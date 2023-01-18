local Loop = {['Loops']={}}
Loop.__index = Loop;
function Loop:New(f: func,token: string)
    if not token then
        token = #self.Loops+1
    else
        for i,v in pairs(self.Loops) do
            if v._token ~= token then continue end;
            coroutine.close(v._thread)
            table.remove(self.Loops,i)
			v._CC:Fire()
            warn('[Fail-Safe]: Stopping & Removing all Loops (Token Overlay) [ ?:New('..tostring(token)..') ]')
        end
    end
    local i=0;
	local thread = coroutine.create(function()
		while task.wait() do 
			i+=1;({f})[1](i)
		end
	end)
	coroutine.resume(thread)
    --// Tables
	local CC = Instance.new('BindableEvent')
	local METATABLE = {
        _thread = thread,
        _token = token;
		_CC = CC,
    }
    table.insert(self.Loops,METATABLE)
    return setmetatable(METATABLE,Loop)
end
function Loop:Stop(token)
    local _token = token or self._token
    local success = false;
	--// Disabling / Stopping thread
    if self._thread then
        coroutine.close(self._thread)
		self._CC:Fire()
    else
        for i,v in pairs(self.Loops) do
            if v._token ~= _token then continue end;
            coroutine.close(v._thread)
			v._CC:Fire()
            success = true;
        end
    end
	--// Removing from Loops & Fail-Safe
    for i,v in pairs(self.Loops) do
        if v._token ~= _token then continue end;
        self.Loops[i]=nil
        success = true;
    end
    if not success then
        warn('[Fail-Safe]: Stopping & Removing all Loops. (Invalid token) [ ?:Stop('..tostring(token)..') ]')
        for i,v in pairs(self.Loops) do
            if not v then continue end;
            coroutine.close(v._thread)
			v._CC:Fire()
            self.Loops[i]=nil
        end
    end
	---------------------------------------
end
function Loop:StopAll()
    local c = 0;
    for i,v in pairs(self.Loops) do
        coroutine.close(v._thread)
		v._CC:Fire()
        self.Loops[i]=nil
        c+=1
    end
	return c
end
function Loop:OnStop(f,token: any)
	if self._CC then
		self._CC.Event:Connect(function() ({f})[1]() end) return
	end
	-- If isn't OOP and there's a token
	local success = false;
	for i,v in pairs(self.Loops) do
		if v._token ~= token then continue end;
		v._CC.Event:Connect(function()
			({f})[1]()
		end)
		success = true;
	end
	if not success then
        for i,v in pairs(self.Loops) do
            coroutine.close(v._thread)
			v._CC:Fire()
            self.Loops[i]=nil
        end
		warn('[Fail-Safe]: Stopping & Removing all Loops. (Invalid token) [ ?:OnStop('..tostring(token)..') ]')
	end
end
function Loop:Toggle(f,token)
	if not token then
        token = #self.Loops+1
	else
		for i,v in pairs(self.Loops) do
			if v._token ~= token then continue end;
			coroutine.close(v._thread)
			table.remove(self.Loops,i)
			v._CC:Fire()
			warn('[Fail-Safe]: Stopping & Removing all Loops (Token Overlay) [ ?:New('..tostring(token)..') ]')
		end
    end
	local CC = Instance.new('BindableEvent')
	local F = CC.Event:Connect(function()
		({f})[1]()
	end)
    --// Tables
	local METATABLE = {
		_thread = coroutine.create(function()end),
        _token = token;
		_CC = CC,
    }
    table.insert(self.Loops,METATABLE)
    return setmetatable(METATABLE,Loop)
end
return Loop
