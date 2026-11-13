-- GameServer module. Load after Platform.Platform; native API is in LuaFunction.
local CHANNEL = "auctions"
local Config = require("Modules\\Auctions\\Config")
-- Optional rollout restriction, supplied by ScriptMain before loading this module.
local TEST_ACCOUNTS = rawget(_G,"AuctionTestAccounts")
local states = {}
local ZERO = {0,0,0,0,0,0,0,0,0,0}
local function identity(index)
    if GetObjectConnected(index) ~= 3 then return end
    return GetObjectAccount(index), GetObjectName(index)
end
local function state(index)
    local account,name=identity(index)
    if not account then return end
    local s=states[index]
    if not s or s.account~=account or s.name~=name then
        s={account=account,name=name,last=0}; states[index]=s
    end
    return s
end
local function alive(index,s)
    local account,name=identity(index)
    return states[index]==s and account==s.account and name==s.name
end
local function send(index,s,msg)
    if alive(index,s) then Net.Send(index,CHANNEL,msg) end
end
local function request(index,s,msg,callback)
    msg.account=s.account;msg.name=s.name
    Net.Request(CHANNEL,msg,index,function(reply,err)
        if alive(index,s) then callback(reply,err) end
    end,15)
end
local function report(index,s,err)
    send(index,s,{op="result",ok=false,error=err or "connection"})
end
local function announce(s,result,item)
    if not result.ok or not result.id or not item or not item.name or s.announced==result.id then return end
    s.announced=result.id
    local name=tostring(item.name):gsub("[%c|]", " "):sub(1,64)
    local level=tonumber(item.level) or 0
    if level>0 then name=name.." +"..level end
    NoticeGlobalSend(0,3400,s.name,name)
end
local function finish(index,s,result)
    local pending=s.pending
    if not pending then return end
    if not AuctionTransferFinish(index,pending.operation,result.ok==true) then
        report(index,s,"session");return
    end
    s.pending=nil
    if pending.op=="publish" and result.ok then announce(s,result,pending.item) end
    if pending.cancelled then
        result.cancelled=true;result.returned=result.ok==true;result.delivery=pending.id
        result.ok=true
    end
    result.op="result";send(index,s,result)
end
local function submit(index,s,msg)
    s.pending=msg
    request(index,s,msg,function(reply,err)
        if reply and not reply.uncertain then finish(index,s,reply)
        else s.checkAt=os.time()+2 end
    end)
end
local function price(value)
    if type(value)~="table" or #value~=10 then return end
    local out={};local any=false
    for i=1,10 do
        local n=value[i]
        if type(n)~="number" or n%1~=0 or n<0 or n>2000000000 then return end
        out[i]=n;any=any or n>0
    end
    return any and out or nil
end 
local function transfer(index,s,mode,slot,value,raw,extra)
    -- SQL/network arithmetic may produce integral floats. The native custody
    -- API requires Lua integers; reject fractions instead of rounding money.
    local normalized={}
    for i=1,10 do
        normalized[i]=type(value)=="table" and math.tointeger(value[i]) or nil
        if not normalized[i] or normalized[i]<0 or normalized[i]>2000000000 then
            report(index,s,mode==3 and "delivery_values" or "price");return
        end
    end
    value=normalized
    local snapshot,err=AuctionTransferBegin(index,mode,slot,value,raw or "",extra and extra.serials or {})
    if not snapshot then
        if extra and extra.cancelled then
            send(index,s,{op="result",ok=true,cancelled=true,returned=false,delivery=extra.id,error=err})
        else report(index,s,mode==3 and err=="price" and "delivery_values" or err) end
        return
    end
    for k,v in pairs(extra or {}) do snapshot[k]=v end
    submit(index,s,snapshot)
end
local function claim(index,s,id,cancelled)
    local function failed(err)
        s.waiting=false
        if cancelled then send(index,s,{op="result",ok=true,cancelled=true,returned=false,delivery=id,error=err})
        else report(index,s,err) end
    end
    local limits,err=AuctionCapacity(index)
    if not limits then failed(err);return end
    s.waiting=true
    request(index,s,{op="quote_claim",id=id,limits=limits},function(reply,err)
        s.waiting=false
        if not reply or not reply.ok then failed(reply and reply.error or err);return end
        transfer(index,s,3,-1,reply.price,reply.item,{op="claim",id=reply.id,version=reply.version,
            price=reply.price,raw=reply.item,serials=reply.serials,cancelled=cancelled})
    end)
end
Net.On(CHANNEL,function(index,msg)
    local s=state(index)
    if not s or type(msg)~="table" then return end
    if TEST_ACCOUNTS and not TEST_ACCOUNTS[s.account:lower()] then report(index,s,"disabled");return end
    if s.pending or s.waiting then
        if msg.op~="watch" then report(index,s,"busy") end
        return
    end
    if s.last~=os.time() then s.last=os.time();s.requests=0 end
    s.requests=(s.requests or 0)+1
    if s.requests>5 then report(index,s,"rate_limit");return end
    local op=msg.op
    if op=="inventory" then
        local items,err=AuctionInventory(index)
        send(index,s,{op="inventory",ok=items~=nil,items=items,currencies=AuctionCurrencies(),durations=Config.Hours,max_hours=Config.MaxHours,error=err})
    elseif op=="watch" then
        if type(msg.ids)~="table" or #msg.ids<1 or #msg.ids>16 then return end
        for _,id in ipairs(msg.ids) do
            if type(id)~="number" or id%1~=0 or id<1 or id>2147483647 then return end
        end
        request(index,s,{op="watch",ids=msg.ids},function(reply,err)
            reply=reply or {ok=false,error=err or "connection"}
            reply.op="watch";send(index,s,reply)
        end)
    elseif op=="sync" then
        local view=msg.view
        if view~="browse" and view~="mine" and view~="bids" and view~="deliveries" then return end
        request(index,s,{op="sync",view=view,page=msg.page,filter=msg.filter,section=msg.section},function(reply,err)
            if not reply then report(index,s,err);return end
            reply.op="sync";reply.currencies=AuctionCurrencies();reply.durations=Config.Hours;reply.max_hours=Config.MaxHours;send(index,s,reply)
        end)
    elseif op=="publish" then
        local value=price(msg.price)
        if not value then report(index,s,"price");return end
        if not Config.Allows(msg.hours) then report(index,s,"duration");return end
        transfer(index,s,1,msg.slot,value,"",{op="publish",price=value,hours=msg.hours})
    elseif op=="republish" then
        local value=price(msg.price)
        if not value then report(index,s,"price");return end
        if not Config.Allows(msg.hours) then report(index,s,"duration");return end
        if type(msg.id)~="number" or msg.id%1~=0 or msg.id<1 or type(msg.version)~="number" or msg.version%1~=0 or msg.version<0 then report(index,s,"delivery");return end
        local currencies=AuctionCurrencies()
        for i=1,10 do if value[i]>0 and not currencies[i] then report(index,s,"currency_disabled");return end end
        s.waiting=true
        request(index,s,{op="quote_republish",id=msg.id,version=msg.version},function(quote,err)
            if not quote or not quote.ok then s.waiting=false;report(index,s,quote and quote.error or err);return end
            local allowed,reason=AuctionCanPublish(index,quote.raw)
            if not allowed then s.waiting=false;report(index,s,reason or "item_blocked");return end
            request(index,s,{op="republish",id=msg.id,version=msg.version,price=value,hours=msg.hours,operation=AuctionOperationID()},function(reply,err)
                s.waiting=false
                if not reply then report(index,s,err);return end
                if reply.ok then announce(s,reply,reply.item) end
                reply.op="result";send(index,s,reply)
            end)
        end)
    elseif op=="claim" then
        if type(msg.id)~="number" or msg.id%1~=0 or msg.id<1 then return end
        claim(index,s,msg.id,false)
    elseif op=="bid" then
        if type(msg.id)~="number" or msg.id%1~=0 or msg.id<1 then return end
        local quote={op="quote_bid",id=msg.id,price=price(msg.price)}
        if not quote.price then report(index,s,"price");return end
        s.waiting=true
        request(index,s,quote,function(reply,err)
            s.waiting=false
            if not reply or not reply.ok then report(index,s,reply and reply.error or err);return end
            transfer(index,s,2,-1,reply.debit,"",{op="bid",id=reply.id,version=reply.version,price=reply.price,debit=reply.debit})
        end)
    elseif op=="cancel" then
        s.waiting=true
        request(index,s,{op="cancel",id=msg.id,operation=AuctionOperationID()},function(reply,err)
            s.waiting=false
            if not reply then report(index,s,err);return end
            if reply.ok and reply.delivery then claim(index,s,reply.delivery,true);return end
            reply.op="result";send(index,s,reply)
        end)
    end
end) 
Events.On("CharacterClose",function(index) states[index]=nil end,"Auctions.Close")
Events.On("CharacterEntry",function(index) states[index]=nil end,"Auctions.Entry")
local nextSettle=0
Events.On("Timer",function()
    local now=os.time()
    if now>=nextSettle then
        nextSettle=now+5;Net.ToData(CHANNEL,{op="settle"})
    end
    for index,s in pairs(states) do
        if s.pending and s.checkAt and now>=s.checkAt then
            s.checkAt=nil
            request(index,s,{op="status",operation=s.pending.operation},function(reply)
                if reply and reply.ok then
                    -- A status request follows the operation on the same ordered queue.
                    -- No receipt means it did not commit; never roll back on a timeout.
                    finish(index,s,reply.result or {ok=false,error="rolled_back"})
                else s.checkAt=os.time()+3 end
            end)
        end
    end
end,"Auctions.Timer")
