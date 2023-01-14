local Loop = {['Loops']={}}
Loop.__index = Loop;
function Loop:New(name,f)
    for i,v in pairs(self.Loops) do
        if i ~= name then continue end;
        coroutine.close(v._thread)
        self.Loops[i] = nil;
    end
    --// THREAD
    local thread = getgenv().thread
    local i = 0;
    thread = coroutine.create(function()
        while true do
            i+=1
            ({f})[1](i)
            wait()
        end
    end);coroutine.resume(thread);
    local _bindable = Instance.new("BindableEvent")
    self['Loops'] = {
        [name] = {
            _thread = thread,
            OnDisconnectFire = _bindable,
            OnDisconnect = _bindable.Event,
        }
    }
end
function Loop:OnDisconnect(target,f)
    if not self.Loops[target] then
        for i,v in pairs(self.Loops) do
            if not v._thread then continue end;
            if v.OnDisconnectFire then v.OnDisconnectFire:Fire() end
            coroutine.close(v._thread)
        end
        return warn('[FailSave]: Disable all the loops. (Invalid Thread/Loop)')
    end
    self.Loops[target].OnDisconnect:Connect(f)
end
function Loop:Kill(target)
    if not self.Loops[target] then
        for i,v in pairs(self.Loops) do
            if not v._thread then continue end;
            if v.OnDisconnectFire then v.OnDisconnectFire:Fire() end
            coroutine.close(v._thread)
        end
        return warn('[FailSave]: Disable all the loops. (Invalid Thread/Loop)')
    end
    --// Normal
    self.Loops[target].OnDisconnectFire:Fire()
    coroutine.close(self.Loops[target]._thread)
end
return Loop
