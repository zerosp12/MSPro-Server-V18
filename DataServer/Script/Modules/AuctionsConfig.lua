-- Shared GS/DS policy. Options accept minutes, hours or days; the DS enforces the limit.
local config = {
    MaxActivePerAccount = 30,
    MaxDuration = { days = 7 },
    Durations = { {hours=1}, {hours=3}, {hours=6}, {hours=12}, {days=1}, {days=3}, {days=7} },
}
local function hours(value)
    assert(type(value)=="table","auction duration: expected table")
    local units,n,scale=0
    for key,multiplier in pairs({minutes=60,hours=3600,days=86400}) do
        if value[key]~=nil then units=units+1;n=value[key];scale=multiplier end
    end
    assert(units==1 and type(n)=="number" and n%1==0,"auction duration: use integer minutes OR hours OR days")
    local seconds=n*scale
    assert(seconds>=3600 and seconds<=31536000,"auction duration: 1 hour to 365 days")
    return seconds/3600
end
config.MaxHours=hours(config.MaxDuration)
assert(type(config.MaxActivePerAccount)=="number" and config.MaxActivePerAccount%1==0 and config.MaxActivePerAccount>=1,"auction limit: positive integer required")
config.Hours={}
local allowed={}
for _,option in ipairs(config.Durations) do
    local n=hours(option)
    assert(n<=config.MaxHours and not allowed[n],"auction duration exceeds maximum or is duplicated")
    allowed[n]=true;config.Hours[#config.Hours+1]=n
end
assert(#config.Hours>0,"auction duration options are empty")
function config.Allows(n) return type(n)=="number" and allowed[n]==true end
function config.Seconds(n) assert(config.Allows(n),"duration");return math.floor(n*3600+0.5) end
return config
