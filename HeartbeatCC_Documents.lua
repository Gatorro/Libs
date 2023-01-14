-- \\\ << EXAMPLE 1, using OOP. >> /// --
local HBLoop = Heartbeat:New(function(i)
    print(i)
end)
HBLoop:Disconnect()
-- \\\ << EXAMPLE 1, using OOP. >> /// --
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ --
-- \\\ << EXAMPLE 2, normal functions. >> /// --
Heartbeat:New(function(i)
    print(i)
end,'test')
Heartbeat:Disconnect('test')
-- \\\ << EXAMPLE 2, normal functions. >> /// --
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ --
-- \\\ << EXAMPLE 3, Automatic token. >> /// --
Heartbeat:New(function(i)
    print(i)
end)
Heartbeat:Disconnect(1) -- Will stop we just created if there aren't more loops running, if there is 1 already running and u didn't set a custom name to it, the number should be 2.
-- \\\ << EXAMPLE 3, Automatic token. >> /// --
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ --
-- \\\ << SYNTAX >> /// --
Heartbeat:New(f: function, token: any)
--            ↑ Required    ↑ Optional
Heartbeat:Disconnect(token: any)
--                    ↑ Not required when using OOP.
-- \\\ << SYNTAX >> /// --
-- ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬ --
--[[
\\\ << INFORMATION >> /// --
   If the parameter token is not set it will be set to a INDEX depending on the already existing loops. (1 if there aren't loops.)
   The callback, in this case "i": Will return a number that increases by 1 every time the loop repeats.
\\\ << INFORMATION >> /// --
]]
