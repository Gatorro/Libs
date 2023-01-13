local Heartbeat = {['CCs']={}}
Heartbeat.__index = Heartbeat;
function Heartbeat:New(f: func,token: string)
    if not token then
        token = #self.CCs+1
    else
        for i,v in pairs(self.CCs) do
            if v._token ~= token then continue end;
            v._CC:Disconnect()
            table.remove(self.CCs,i)
            warn('[Fail-Save]: Disconnecting all connections (Token Overlay)')
            return
        end
    end
    local i=0;
    local CC = game:GetService('RunService').Heartbeat:Connect(function()
        i+=1;({f})[1](i)
    end)
    --// Tables
    table.insert(self.CCs,{
        _CC = CC,
        _token = token;
    })
    return setmetatable({
        _CC = CC,
        _token = token;
    },Heartbeat)
end
function Heartbeat:Disconnect(token)
    local _token = token or self._token
    local success = false;
    if self._CC then
        self._CC:Disconnect()
    else
        for i,v in pairs(self.CCs) do
            if v._token ~= _token then continue end;
            v._CC:Disconnect()
            success = true;
        end
    end
    for i,v in pairs(self.CCs) do
        if v._token ~= _token then continue end;
        self.CCs[i]=nil
        success = true;
    end
    if not success then
        warn('[Fail-Safe]: Disconnecting all connections. (Invalid token)')
        for i,v in pairs(self.CCs) do
            if not v then continue end;
            v._CC:Disconnect()
            self.CCs[i]=nil
        end
    end
end
function Heartbeat:DisconnectAll()
    local c = 0;
    for i,v in pairs(self.CCs) do
        v._CC:Disconnect()
        self.CCs[i]=nil
        c+=1
    end
    return c
end
