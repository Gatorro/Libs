local CCHeartbeat = {}
CCHeartbeat.__index = CCHeartbeat
function CCHeartbeat:Connect(f)
	local i = 0;
	local CC = game:GetService('RunService').Heartbeat:Connect(function()
		i+=1;({f})[1]()
	end)
	return setmetatable({
		CC = CC,
		status = true
	},CCHeartbeat)
end
function CCHeartbeat:Disconnect()
	self.CC:Disconnect()
	self.status = false
end
return true
