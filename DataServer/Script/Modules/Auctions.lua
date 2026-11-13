-- DataServer module: durable auctions, compound bids and pending deliveries.
-- Load after Platform.Platform. Client data must arrive through the GS bridge.
local CHANNEL = "auctions"
local Config = require("Modules.AuctionsConfig")
local ZERO = {0,0,0,0,0,0,0,0,0,0}
local MAX_PRICE = 2000000000
local function must(value, err)
    if value == nil then error(err or "sql", 0) end
    return value
end
local function exec(sql, ...) return must(SQL.Exec(sql, ...)) end
local function query(sql, ...) return must(SQL.Query(sql, ...)) end
local function integer(n, lo, hi) return type(n)=="number" and n%1==0 and n>=lo and n<=hi end
local function prices(values, allowZero, maximum, validationError)
    maximum=maximum or MAX_PRICE
    validationError=validationError or "price"
    if type(values)~="table" or #values~=10 then error(validationError,0) end
    local out, any = {}, false
    for i=1,10 do
        if not integer(values[i],0,maximum) then error(validationError,0) end
        out[i]=values[i]; any=any or out[i]>0
    end
    if not allowZero and not any then error("price",0) end
    return out
end
local function same(a,b)
    for i=1,10 do if a[i]~=b[i] then return false end end
    return true
end
local function empty(a)
    for i=1,10 do if a[i]>0 then return false end end
    return true
end
local function packed(value) return SQL.Binary(Pack(value)) end
local function actor(msg)
    return type(msg.account)=="string" and #msg.account>=1 and #msg.account<=10 and
        type(msg.name)=="string" and #msg.name>=1 and #msg.name<=10
end
local function loadPrice(raw) return prices(Unpack(raw),true) end
local function required(current)
    local out={}
    for i=1,10 do out[i]=current[i]>0 and current[i]+math.max(1,math.ceil(current[i]*0.05)) or 0 end
    return out
end
local function transaction(fn)
    if not SQL.Begin() then return false,"sql_begin" end
    local ok,err=pcall(fn)
    if not ok then SQL.Rollback();return false,err end
    if not SQL.Commit() then SQL.Rollback();return false,"sql_commit" end
    return true
end

Platform.Install("auctions",function()
    exec([[IF OBJECT_ID('MSPro_Auctions') IS NULL CREATE TABLE MSPro_Auctions (
        ID bigint IDENTITY(1,1) PRIMARY KEY, OwnerAccount varchar(10) NOT NULL, OwnerName varchar(10) NOT NULL,
        Item varbinary(16) NOT NULL, Serial bigint NOT NULL, Info varbinary(max) NOT NULL,
        ItemName varchar(64) NOT NULL, ItemIndex int NOT NULL, ItemLevel int NOT NULL,
        BasePrice varbinary(max) NOT NULL, Price varbinary(max) NOT NULL,
        BidderAccount varchar(10) NULL, BidderName varchar(10) NULL,
        Version int NOT NULL DEFAULT 0, Ends bigint NOT NULL, State varchar(12) NOT NULL DEFAULT 'active',
        Released bit NOT NULL DEFAULT 0, Created bigint NOT NULL)]])
    exec([[IF OBJECT_ID('MSPro_AuctionBids') IS NULL CREATE TABLE MSPro_AuctionBids (
        AuctionID bigint NOT NULL, Version int NOT NULL, Account varchar(10) NOT NULL,
        Name varchar(10) NOT NULL, Price varbinary(max) NOT NULL, Created bigint NOT NULL,
        CONSTRAINT PK_MSPro_AuctionBids PRIMARY KEY (AuctionID,Version))]])
    exec([[IF OBJECT_ID('MSPro_AuctionDeliveries') IS NULL CREATE TABLE MSPro_AuctionDeliveries (
        ID bigint IDENTITY(1,1) PRIMARY KEY, AuctionID bigint NOT NULL, Account varchar(10) NOT NULL,
        Name varchar(10) NOT NULL, Kind varchar(12) NOT NULL, SourceVersion int NOT NULL,
        Item varbinary(16) NULL, Info varbinary(max) NULL, Price varbinary(max) NOT NULL,
        Version int NOT NULL DEFAULT 0, Claimed bit NOT NULL DEFAULT 0, Created bigint NOT NULL,
        CONSTRAINT UQ_MSPro_AuctionDeliveries UNIQUE (AuctionID,Kind,SourceVersion))]])
    exec([[IF OBJECT_ID('MSPro_AuctionOperations') IS NULL CREATE TABLE MSPro_AuctionOperations (
        ID varchar(36) PRIMARY KEY, Account varchar(10) NOT NULL, Name varchar(10) NOT NULL,
        Result varbinary(max) NOT NULL, Created bigint NOT NULL)]])
    exec([[IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name='IX_MSPro_AuctionEscrow')
        CREATE UNIQUE INDEX IX_MSPro_AuctionEscrow ON MSPro_Auctions(Serial) WHERE Released=0]])
    exec([[IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name='IX_MSPro_Auctions_Ends')
        CREATE INDEX IX_MSPro_Auctions_Ends ON MSPro_Auctions(State,Ends,ID)]])
    exec([[IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name='IX_MSPro_AuctionDelivery_Owner')
        CREATE INDEX IX_MSPro_AuctionDelivery_Owner ON MSPro_AuctionDeliveries(Account,Name,Claimed,ID)]])
end)

local function operationResult(msg)
    local rows=query("SELECT Result FROM MSPro_AuctionOperations WHERE ID=? AND Account=? AND Name=?",msg.operation,msg.account,msg.name)
    return rows[1] and Unpack(rows[1].Result)
end
local function operation(msg, fn)
    if type(msg.operation)~="string" or not msg.operation:match("^[%x%-]+$") or #msg.operation~=36 then error("operation",0) end
    local previous=operationResult(msg)
    if previous then return previous end
    local result
    local ok,err=transaction(function()
        -- All asset changes and the durable receipt share this transaction.
        result=fn()
        result.ok=true; result.operation=msg.operation
        exec("INSERT INTO MSPro_AuctionOperations(ID,Account,Name,Result,Created) VALUES(?,?,?,?,?)",
            msg.operation,msg.account,msg.name,packed(result),os.time())
    end)
    if not ok then return {ok=false,error=tostring(err),uncertain=true,operation=msg.operation} end
    return result
end
local function snapshot(msg, delta)
    if type(msg.inventory)~="string" or #msg.inventory~=236*16 or not integer(msg.money,0,2000000000) then error("snapshot",0) end
    local coins=msg.before_coins
    if type(coins)~="table" or #coins~=4 then error("coins",0) end
    for i=1,4 do if not integer(coins[i],0,MAX_PRICE) then error("coins",0) end end
    -- Prevent using a stale GS currency cache. Ruuds belong to Character in this build.
    local cash=query("SELECT WCoinC,WCoinP,GoblinPoint FROM CashShopData WITH(UPDLOCK,HOLDLOCK) WHERE AccountID=?",msg.account)[1]
    local character=query("SELECT RuudToken FROM Character WITH(UPDLOCK,HOLDLOCK) WHERE Name=? AND AccountID=?",msg.name,msg.account)[1]
    if not character then error("character",0) end
    if not cash then error("coins",0) end
    if cash.WCoinC~=coins[1] or cash.WCoinP~=coins[2] or cash.GoblinPoint~=coins[3] or character.RuudToken~=coins[4] then error("coins_stale",0) end
    local balances={}
    for i=1,4 do
        balances[i]=coins[i]+delta[i+1]
        if not integer(balances[i],0,MAX_PRICE) then error("funds",0) end
    end
    if exec("UPDATE Character SET Inventory=?,Money=?,RuudToken=? WHERE Name=? AND AccountID=?",
        SQL.Binary(msg.inventory),msg.money,balances[4],msg.name,msg.account)~=1 then error("character",0) end
    if exec("UPDATE CashShopData SET WCoinC=?,WCoinP=?,GoblinPoint=? WHERE AccountID=?",
        balances[1],balances[2],balances[3],msg.account)~=1 then error("coins",0) end
end
local function deliver(a,account,name,kind,version,item,info,value)
    exec("INSERT INTO MSPro_AuctionDeliveries(AuctionID,Account,Name,Kind,SourceVersion,Item,Info,Price,Created) VALUES(?,?,?,?,?,CONVERT(varbinary(16),?),CONVERT(varbinary(max),?),?,?)",
        a.ID,account,name,kind,version,item and SQL.Binary(item) or nil,info and SQL.Binary(info) or nil,packed(value),os.time())
end
local function closeOne(id)
    local ok,err=transaction(function()
        local a=query("SELECT * FROM MSPro_Auctions WITH(UPDLOCK,HOLDLOCK) WHERE ID=? AND State='active' AND Ends<=?",id,os.time())[1]
        if not a then return end
        if a.BidderName then
            deliver(a,a.BidderAccount,a.BidderName,"win",a.Version,a.Item,a.Info,ZERO)
            deliver(a,a.OwnerAccount,a.OwnerName,"sale",a.Version,nil,nil,loadPrice(a.Price))
        else
            deliver(a,a.OwnerAccount,a.OwnerName,"return",a.Version,a.Item,a.Info,ZERO)
        end
        exec("UPDATE MSPro_Auctions SET State='closed' WHERE ID=? AND State='active'",id)
    end)
    if not ok then error(err,0) end
end
local function settle()
    for _,row in ipairs(query("SELECT TOP 50 ID FROM MSPro_Auctions WHERE State='active' AND Ends<=? ORDER BY Ends,ID",os.time())) do closeOne(row.ID) end
end
local handlers={}
function handlers.publish(msg)
    local base=prices(msg.price,false)
    if not Config.Allows(msg.hours) then error("duration",0) end
    local item=msg.item
    if type(item)~="table" or type(item.raw)~="string" or #item.raw~=16 or not integer(item.serial,1,4294967294) then error("item",0) end
    return operation(msg,function()
        local count=must(SQL.Scalar("SELECT COUNT(*) FROM MSPro_Auctions WITH(UPDLOCK,HOLDLOCK) WHERE OwnerAccount=? AND State='active'",msg.account))
        if count>=Config.MaxActivePerAccount then error("limit",0) end
        snapshot(msg,ZERO)
        local id=must(SQL.Scalar([[INSERT INTO MSPro_Auctions(OwnerAccount,OwnerName,Item,Serial,Info,ItemName,ItemIndex,ItemLevel,BasePrice,Price,Ends,Created)
            OUTPUT INSERTED.ID VALUES(?,?,?,?,?,?,?,?,?,?,?,?)]],msg.account,msg.name,SQL.Binary(item.raw),item.serial,packed(item),item.name,item.index,item.level,packed(base),packed(base),os.time()+Config.Seconds(msg.hours),os.time()))
        return {id=id}
    end)
end
local function bidQuote(msg)
    local a=query("SELECT * FROM MSPro_Auctions WHERE ID=? AND State='active' AND Ends>?",msg.id,os.time())[1]
    if not a then error("expired",0) end
    if a.OwnerAccount:lower()==msg.account:lower() then error("own_auction",0) end
    local current=loadPrice(a.Price)
    return a,current,a.Version==0 and current or required(current)
end
function handlers.quote_republish(msg)
    if not integer(msg.id,1,2147483647) or not integer(msg.version,0,2147483647) then error("delivery",0) end
    local d=query("SELECT * FROM MSPro_AuctionDeliveries WHERE ID=? AND Account=? AND Name=? AND Claimed=0",msg.id,msg.account,msg.name)[1]
    if not d or d.Version~=msg.version then error("changed",0) end
    if d.Kind~="return" or not d.Item or not d.Info then error("delivery_item",0) end
    return {ok=true,id=d.ID,version=d.Version,raw=d.Item}
end
function handlers.republish(msg)
    local base=prices(msg.price,false)
    if not Config.Allows(msg.hours) then error("duration",0) end
    return operation(msg,function()
        local d=query("SELECT * FROM MSPro_AuctionDeliveries WITH(UPDLOCK,HOLDLOCK) WHERE ID=? AND Account=? AND Name=? AND Claimed=0",msg.id,msg.account,msg.name)[1]
        if not d or d.Version~=msg.version then error("changed",0) end
        if d.Kind~="return" or not d.Item or not d.Info then error("delivery_item",0) end
        local item=Unpack(d.Info)
        if type(item)~="table" or not integer(item.serial,1,4294967294) then error("item",0) end
        local count=must(SQL.Scalar("SELECT COUNT(*) FROM MSPro_Auctions WITH(UPDLOCK,HOLDLOCK) WHERE OwnerAccount=? AND State='active'",msg.account))
        if count>=Config.MaxActivePerAccount then error("limit",0) end
        -- The same serial moves from delivery custody to a new auction. Preserve
        -- any currency delivery; never write character inventory or balances.
        local value=loadPrice(d.Price)
        if exec("UPDATE MSPro_Auctions SET Released=1 WHERE ID=? AND Released=0",d.AuctionID)~=1 then error("changed",0) end
        local id=must(SQL.Scalar([[INSERT INTO MSPro_Auctions(OwnerAccount,OwnerName,Item,Serial,Info,ItemName,ItemIndex,ItemLevel,BasePrice,Price,Ends,Created)
            OUTPUT INSERTED.ID VALUES(?,?,?,?,?,?,?,?,?,?,?,?)]],msg.account,msg.name,SQL.Binary(d.Item),item.serial,SQL.Binary(d.Info),item.name,item.index,item.level,packed(base),packed(base),os.time()+Config.Seconds(msg.hours),os.time()))
        if exec("UPDATE MSPro_AuctionDeliveries SET Item=NULL,Info=NULL,Price=?,Version=Version+1,Claimed=? WHERE ID=? AND Version=?",packed(value),empty(value),d.ID,d.Version)~=1 then error("changed",0) end
        return {id=id,republished=true,item={name=item.name,level=item.level}}
    end)
end
function handlers.quote_bid(msg)
    local a,current,minimum=bidQuote(msg)
    local offer=prices(msg.price,false)
    local debit={}
    for i=1,10 do
        if (minimum[i]==0 and offer[i]~=0) or offer[i]<minimum[i] then error("minimum",0) end
        debit[i]=offer[i]-((a.BidderAccount==msg.account and a.BidderName==msg.name) and current[i] or 0)
    end
    return {ok=true,id=a.ID,version=a.Version,price=offer,debit=debit,minimum=minimum}
end
function handlers.bid(msg)
    return operation(msg,function()
        local a=query("SELECT * FROM MSPro_Auctions WITH(UPDLOCK,HOLDLOCK) WHERE ID=? AND State='active' AND Ends>?",msg.id,os.time())[1]
        if not a or a.Version~=msg.version then error("changed",0) end
        local quote=handlers.quote_bid(msg)
        if not same(quote.debit,prices(msg.debit,true)) then error("changed",0) end
        local debit={};for i=1,10 do debit[i]=-quote.debit[i] end
        snapshot(msg,debit)
        if a.BidderName and not (a.BidderAccount==msg.account and a.BidderName==msg.name) then
            deliver(a,a.BidderAccount,a.BidderName,"refund",a.Version,nil,nil,loadPrice(a.Price))
        end
        exec("UPDATE MSPro_Auctions SET Price=?,BidderAccount=?,BidderName=?,Version=Version+1 WHERE ID=? AND Version=?",
            packed(quote.price),msg.account,msg.name,msg.id,msg.version)
        exec("INSERT INTO MSPro_AuctionBids(AuctionID,Version,Account,Name,Price,Created) VALUES(?,?,?,?,?,?)",
            msg.id,msg.version+1,msg.account,msg.name,packed(quote.price),os.time())
        return {id=msg.id,version=msg.version+1}
    end)
end
function handlers.quote_claim(msg)
    local d=query("SELECT * FROM MSPro_AuctionDeliveries WHERE ID=? AND Account=? AND Name=? AND Claimed=0",msg.id,msg.account,msg.name)[1]
    if not d then error("delivery",0) end
    -- Native Capacity reports headroom up to INT_MAX, not an asking price.
    local value,limits=loadPrice(d.Price),prices(msg.limits,true,2147483647,"capacity")
    local grant={};for i=1,10 do grant[i]=math.min(value[i],limits[i]) end
    if empty(grant) and not d.Item then error("balance_limit",0) end
    local serials={}
    for i=6,10 do
        local left=grant[i]
        while left>0 do
            local size=left>=30 and 30 or left>=20 and 20 or left>=10 and 10 or 1
            local serial=must(SQL.Scalar("EXEC WZ_GetItemSerial"))
            if serial<0 then serial=serial+4294967296 end
            if not integer(serial,1,4294967294) then error("serial",0) end
            serials[#serials+1]=serial;left=left-size
        end
    end
    return {ok=true,id=d.ID,version=d.Version,price=grant,item=d.Item or "",serials=serials}
end
function handlers.claim(msg)
    return operation(msg,function()
        local d=query("SELECT * FROM MSPro_AuctionDeliveries WITH(UPDLOCK,HOLDLOCK) WHERE ID=? AND Account=? AND Name=? AND Claimed=0",msg.id,msg.account,msg.name)[1]
        if not d or d.Version~=msg.version then error("changed",0) end
        local value,grant=loadPrice(d.Price),prices(msg.price,true)
        if msg.raw~=(d.Item or "") then error("changed",0) end
        for i=1,10 do if grant[i]>value[i] then error("price",0) end value[i]=value[i]-grant[i] end
        if empty(grant) and not d.Item then error("price",0) end
        snapshot(msg,grant)
        exec("UPDATE MSPro_AuctionDeliveries SET Item=NULL,Info=NULL,Price=?,Version=Version+1,Claimed=? WHERE ID=? AND Version=?",
            packed(value),empty(value),d.ID,d.Version)
        if d.Item then exec("UPDATE MSPro_Auctions SET Released=1 WHERE ID=?",d.AuctionID) end
        return {id=d.ID,remaining=value}
    end)
end
function handlers.cancel(msg)
    return operation(msg,function()
        local a=query("SELECT * FROM MSPro_Auctions WITH(UPDLOCK,HOLDLOCK) WHERE ID=? AND OwnerAccount=? AND OwnerName=? AND State='active' AND Version=0",msg.id,msg.account,msg.name)[1]
        if not a then error("cannot_cancel",0) end
        deliver(a,a.OwnerAccount,a.OwnerName,"return",0,a.Item,a.Info,ZERO)
        exec("UPDATE MSPro_Auctions SET State='cancelled' WHERE ID=?",a.ID)
        local delivery=must(SQL.Scalar("SELECT ID FROM MSPro_AuctionDeliveries WHERE AuctionID=? AND Kind='return' AND SourceVersion=0",a.ID))
        return {id=a.ID,delivery=delivery,cancelled=true}
    end)
end
function handlers.status(msg)
    return {ok=true,result=operationResult(msg),operation=msg.operation}
end
local function tooltipItem(item)
    if item and type(item.raw)=="string" and #item.raw==16 then
        item.tooltip_bytes=item.raw:sub(1,3)..item.raw:sub(8,16)
    end
    if item then item.raw=nil end
    return item
end
local function pendingDeliveries(msg,ids)
    local result,marks,values={},{},{msg.account,msg.name}
    for _,id in ipairs(ids) do marks[#marks+1]="?";values[#values+1]=id end
    if #ids==0 then return result end
    for _,d in ipairs(query("SELECT AuctionID FROM MSPro_AuctionDeliveries WHERE Account=? AND Name=? AND Claimed=0 AND AuctionID IN ("..table.concat(marks,",")..")",table.unpack(values))) do
        result[d.AuctionID]=true
    end
    return result
end
function handlers.watch(msg)
    if type(msg.ids)~="table" or #msg.ids<1 or #msg.ids>16 then error("request",0) end
    local marks,ids={},{}
    for _,id in ipairs(msg.ids) do
        if not integer(id,1,2147483647) then error("request",0) end
        marks[#marks+1]="?";ids[#ids+1]=id
    end
    local rows=query("SELECT ID,Price,Version,Ends,State,BidderName,Released FROM MSPro_Auctions WHERE ID IN ("..table.concat(marks,",")..")",table.unpack(ids))
    local pending=pendingDeliveries(msg,ids)
    local result={ok=true,rows={},now=os.time()}
    for _,a in ipairs(rows) do
        local value=loadPrice(a.Price)
        result.rows[#result.rows+1]={id=a.ID,price=value,minimum=a.Version==0 and value or required(value),
            version=a.Version,ends=a.Ends,state=a.State,bidder=a.BidderName,released=a.Released==true or a.Released==1,pending_delivery=pending[a.ID]==true}
    end
    return result
end
function handlers.sync(msg)
    settle()
    local page=integer(msg.page,0,100000) and msg.page or 0
    local view=msg.view or "browse"
    if view~="browse" and view~="mine" and view~="bids" and view~="deliveries" then error("view",0) end
    local result={ok=true,view=view,page=page,rows={},now=os.time()}
    if view=="deliveries" then
        local rows=query("SELECT d.ID,d.AuctionID,d.Kind,d.Info,d.Price,d.Version,a.Info AS SourceInfo,COUNT(*) OVER() AS TotalRows FROM MSPro_AuctionDeliveries d LEFT JOIN MSPro_Auctions a ON a.ID=d.AuctionID WHERE d.Account=? AND d.Name=? AND d.Claimed=0 ORDER BY d.ID OFFSET ? ROWS FETCH NEXT 7 ROWS ONLY",msg.account,msg.name,page*6)
        if rows[1] and rows[1].TotalRows then result.pages=math.max(1,math.ceil(rows[1].TotalRows/6))
        elseif page==0 and #rows==0 then result.pages=1 end
        result.more=#rows>6
        for i=1,math.min(6,#rows) do
            local d=rows[i]; result.rows[i]={id=d.ID,auction=d.AuctionID,kind=d.Kind,price=loadPrice(d.Price),item=d.Info and Unpack(d.Info) or nil,version=d.Version}
            result.rows[i].source_item=d.SourceInfo and Unpack(d.SourceInfo) or nil
            tooltipItem(result.rows[i].item);tooltipItem(result.rows[i].source_item)
        end
        return result
    end
    local name=type(msg.filter)=="string" and msg.filter:sub(1,32) or ""
    local section=msg.section==nil and -1 or msg.section
    if not integer(section,-1,15) then error("section",0) end
    local rows
    -- Apply the name predicate before pagination; wildcard characters are literal.
    name=name:gsub("%[","[[]"):gsub("%%","[%%]"):gsub("_","[_]")
    local pattern="%"..name.."%"
    if view=="mine" then
        rows=query("SELECT a.*,COUNT(*) OVER() AS TotalRows FROM MSPro_Auctions a WHERE a.OwnerAccount=? AND a.OwnerName=? AND a.Released=0 AND (?=-1 OR a.ItemIndex/512=?) AND a.ItemName LIKE ? AND NOT EXISTS(SELECT 1 FROM MSPro_Auctions newer WHERE newer.Serial=a.Serial AND newer.ID>a.ID AND newer.OwnerAccount=a.OwnerAccount AND newer.OwnerName=a.OwnerName) ORDER BY a.ID DESC OFFSET ? ROWS FETCH NEXT 7 ROWS ONLY",msg.account,msg.name,section,section,pattern,page*6)
    elseif view=="bids" then
        rows=query("SELECT a.*,COUNT(*) OVER() AS TotalRows FROM MSPro_Auctions a WHERE EXISTS(SELECT 1 FROM MSPro_AuctionBids b WHERE b.AuctionID=a.ID AND b.Account=? AND b.Name=?) AND (?=-1 OR a.ItemIndex/512=?) AND a.ItemName LIKE ? ORDER BY a.ID DESC OFFSET ? ROWS FETCH NEXT 7 ROWS ONLY",msg.account,msg.name,section,section,pattern,page*6)
    else
        rows=query("SELECT *,COUNT(*) OVER() AS TotalRows FROM MSPro_Auctions WHERE State='active' AND Ends>? AND (?=-1 OR ItemIndex/512=?) AND ItemName LIKE ? ORDER BY ID DESC OFFSET ? ROWS FETCH NEXT 7 ROWS ONLY",os.time(),section,section,pattern,page*6)
    end
    local matches={}
    local ids={};for _,a in ipairs(rows) do ids[#ids+1]=a.ID end
    local pending=view=="bids" and pendingDeliveries(msg,ids) or {}
    if rows[1] and rows[1].TotalRows then result.pages=math.max(1,math.ceil(rows[1].TotalRows/6))
    elseif page==0 and #rows==0 then result.pages=1 end
    for _,a in ipairs(rows) do
        local item=Unpack(a.Info)
            tooltipItem(item)
            matches[#matches+1]={id=a.ID,owner=a.OwnerName,mine=a.OwnerAccount:lower()==msg.account:lower(),item=item,price=loadPrice(a.Price),minimum=a.Version==0 and loadPrice(a.Price) or required(loadPrice(a.Price)),
                version=a.Version,ends=a.Ends,state=a.State,bidder=a.BidderName,pending_delivery=pending[a.ID]==true}
    end
    result.more=#matches>6
    for i=1,math.min(#matches,6) do result.rows[i]=matches[i] end
    return result
end
function handlers.settle() settle(); return {ok=true} end
Net.On(CHANNEL,function(msg,ctx)
    if type(msg)~="table" or not handlers[msg.op] or (msg.op~="settle" and not actor(msg)) then
        Net.Reply(ctx,{ok=false,error="request"});return
    end
    local ok,result=pcall(handlers[msg.op],msg)
    Net.Reply(ctx,ok and result or {ok=false,error=tostring(result),operation=msg.operation})
end)
