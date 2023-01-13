local Heartbeat = {['CCs']={}}
Heartbeat.__index = Heartbeat;
function Heartbeat:New(f: func,name: string)
    if not name then
        name = #self.CCs+1
    else
        for i,v in pairs(self.CCs) do
            if v._name ~= name then continue end;
            v._CC:Disconnect()
            table.remove(self.CCs,i)
            warn('[Fail-Save]: Disconnecting all connections (Name Overlay)')
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
        _name = name;
    })
    return setmetatable({
        _CC = CC,
        _name = name;
    },Heartbeat)
end
function Heartbeat:Disconnect(token)
    local _token = token or self._name
    local success = false;
    if self._CC then
        self._CC:Disconnect()
    else
        for i,v in pairs(self.CCs) do
            if v._name ~= _token then continue end;
            v._CC:Disconnect()
            success = true;
        end
    end
    for i,v in pairs(self.CCs) do
        if v._name ~= _token then continue end;
        table.remove(self.CCs,i)
        success = true;
    end
    if not success then
        warn('[Fail-Safe]: Disconnecting all connections. (Invalid token)')
        for i,v in pairs(self.CCs) do
            if not v then continue end;
            v._CC:Disconnect()
            table.remove(self.CCs,i)
        end
    end
end
