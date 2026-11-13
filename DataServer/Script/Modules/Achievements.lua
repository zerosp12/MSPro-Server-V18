---------------------------------------------------------------------------
-- Achievements - DataServer module (tables and queries)
-- GameServer side: Scripts\GameServer\Modules\Achievements
--
-- Channel "achievements":
--   load      { name }                         -> { rows = {{id, tier, claimed, progress}}, milestones = {{kind, category, value}} }
--   save      { name, rows, points, completed } -> { ok } (batch of changed rows, rolled back on error)
--   milestone { name, kind, category, value }   (claimed milestone, no answer)
--   ranking   { limit }                         -> { rows = {{name, points, completed}} }
---------------------------------------------------------------------------

Platform.Install("achievements", function()
	local statements = {
		[[IF OBJECT_ID('MSPro_Achievements') IS NULL
		CREATE TABLE MSPro_Achievements (
			Name        varchar(10) NOT NULL,
			Achievement int         NOT NULL,
			Tier        tinyint     NOT NULL DEFAULT 0,
			Claimed     tinyint     NOT NULL DEFAULT 0,
			Progress    bigint      NOT NULL DEFAULT 0,
			Updated     datetime    NOT NULL DEFAULT GETDATE(),
			CONSTRAINT PK_MSPro_Achievements PRIMARY KEY (Name, Achievement)
		)]],
		[[IF OBJECT_ID('MSPro_AchievementMilestones') IS NULL
		CREATE TABLE MSPro_AchievementMilestones (
			Name      varchar(10) NOT NULL,
			Kind      tinyint     NOT NULL,
			Category  int         NOT NULL,
			Milestone int         NOT NULL,
			Claimed   datetime    NOT NULL DEFAULT GETDATE(),
			CONSTRAINT PK_MSPro_AchievementMilestones PRIMARY KEY (Name, Kind, Category, Milestone)
		)]],
		[[IF OBJECT_ID('MSPro_AchievementSummary') IS NULL
		CREATE TABLE MSPro_AchievementSummary (
			Name      varchar(10) NOT NULL PRIMARY KEY,
			Points    int         NOT NULL DEFAULT 0,
			Completed int         NOT NULL DEFAULT 0,
			Updated   datetime    NOT NULL DEFAULT GETDATE()
		)]],
		[[IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_MSPro_AchievementSummary_Points')
		CREATE INDEX IX_MSPro_AchievementSummary_Points ON MSPro_AchievementSummary (Points DESC)]],
	}

	for _, sql in ipairs(statements) do
		local ok, err = SQL.Exec(sql)

		if ok == nil then
			error(err)
		end
	end
end)

local function ValidName(name)
	return type(name) == "string" and #name >= 1 and #name <= 10
end

-- SQL errors inside SQL.Transaction must raise to roll back
local function Must(result, err)
	if result == nil then
		error(err or "sql error", 2)
	end

	return result
end

local Handlers = {}

function Handlers.load(msg, ctx)
	local rows = SQL.Query("SELECT Achievement, Tier, Claimed, Progress FROM MSPro_Achievements WHERE Name = ?", msg.name)
	local milestones = SQL.Query("SELECT Kind, Category, Milestone FROM MSPro_AchievementMilestones WHERE Name = ?", msg.name)

	if rows == nil or milestones == nil then
		Net.Reply(ctx, { error = "sql" })
		return
	end

	local result = { rows = {}, milestones = {} }

	for i, row in ipairs(rows) do
		result.rows[i] = { row.Achievement, row.Tier, row.Claimed, row.Progress }
	end

	for i, row in ipairs(milestones) do
		result.milestones[i] = { row.Kind, row.Category, row.Milestone }
	end

	Net.Reply(ctx, result)
end

function Handlers.save(msg, ctx)
	if type(msg.rows) ~= "table" then
		return
	end

	local ok = SQL.Transaction(function()
		for _, row in ipairs(msg.rows) do
			local id, tier, claimed, progress = row[1], row[2], row[3], row[4]

			if type(id) == "number" and type(tier) == "number" and type(claimed) == "number" and type(progress) == "number" then
				local updated = Must(SQL.Exec("UPDATE MSPro_Achievements SET Tier = ?, Claimed = ?, Progress = ?, Updated = GETDATE() WHERE Name = ? AND Achievement = ?",
					tier, claimed, progress, msg.name, id))

				if updated == 0 then
					Must(SQL.Exec("INSERT INTO MSPro_Achievements (Name, Achievement, Tier, Claimed, Progress) VALUES (?, ?, ?, ?, ?)",
						msg.name, id, tier, claimed, progress))
				end
			end
		end

		if type(msg.points) == "number" then
			local updated = Must(SQL.Exec("UPDATE MSPro_AchievementSummary SET Points = ?, Completed = ?, Updated = GETDATE() WHERE Name = ?",
				msg.points, msg.completed or 0, msg.name))

			if updated == 0 then
				Must(SQL.Exec("INSERT INTO MSPro_AchievementSummary (Name, Points, Completed) VALUES (?, ?, ?)", msg.name, msg.points, msg.completed or 0))
			end
		end
	end)

	if ctx.req then
		Net.Reply(ctx, { ok = ok })
	end
end

function Handlers.milestone(msg, ctx)
	if type(msg.kind) ~= "number" or type(msg.category) ~= "number" or type(msg.value) ~= "number" then
		return
	end

	SQL.Exec("IF NOT EXISTS (SELECT 1 FROM MSPro_AchievementMilestones WHERE Name = ? AND Kind = ? AND Category = ? AND Milestone = ?) "
		.. "INSERT INTO MSPro_AchievementMilestones (Name, Kind, Category, Milestone) VALUES (?, ?, ?, ?)",
		msg.name, msg.kind, msg.category, msg.value, msg.name, msg.kind, msg.category, msg.value)
end

function Handlers.ranking(msg, ctx)
	-- TOP does not accept parameters in every SQL Server version: the value is forced to an integer 1..100
	local limit = math.floor(math.max(1, math.min(tonumber(msg.limit) or 20, 100)))
	local rows = SQL.Query("SELECT TOP (" .. limit .. ") Name, Points, Completed FROM MSPro_AchievementSummary ORDER BY Points DESC, Updated ASC")
	local result = {}

	for i, row in ipairs(rows or {}) do
		result[i] = { row.Name, row.Points, row.Completed }
	end

	Net.Reply(ctx, { rows = result })
end

Net.On("achievements", function(msg, ctx)
	if type(msg) ~= "table" or Handlers[msg.op] == nil then
		return
	end

	if msg.op ~= "ranking" and not ValidName(msg.name) then
		if ctx.req then Net.Reply(ctx, { error = "invalid" }) end
		return
	end

	Handlers[msg.op](msg, ctx)
end)
