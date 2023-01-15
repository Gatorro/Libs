function say(...)
    game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(tostring(...), "All")
end
function oldsay(msg)
    game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(tostring(msg), "All")
end
function getPlayer(player)
    if not player then return game.Players.LocalPlayer end
    if not game:GetService('Players'):FindFirstChild(player) then return nil end
    return game:GetService('Players'):FindFirstChild(player)
end
function getPlayers() return game:GetService('Players'):GetChildren() end
function getCharacter(player)
    if not player then return getPlayer().Character end
    if not getPlayer(player).Character then return nil end
    return getPlayer(player).Character
end
function getRoot(player)
    if not player then return getCharacter():FindFirstChild("HumanoidRootPart")end
    if not getCharacter(player):FindFirstChild("HumanoidRootPart") then return nil;end
    return getCharacter(player):FindFirstChild("HumanoidRootPart")
end
function getTorso(player)
    if not player then
        if not getCharacter(LocalPlayer):FindFirstChild("Torso") then return nil;end
        return getCharacter(LocalPlayer):FindFirstChild("Torso")
    elseif getCharacter(player):FindFirstChild("Torso") then
        return getCharacter(player):FindFirstChild("Torso")
    elseif getCharacter(player):FindFirstChild("UpperTorso") then
        return getCharacter(player):FindFirstChild("UpperTorso")
    else return nil;end
end
function getHumanoid(player)
    if not player then return getCharacter():FindFirstChild("Humanoid") end
    return getCharacter(player):FindFirstChild("Humanoid")
end
function getHum(player)
    if not player then return getCharacter():FindFirstChild("Humanoid") end
    return getCharacter(player):FindFirstChild("Humanoid")
end
function int(num, radix) return tonumber(num, radix) end
function str(string) return tostring(string) end
function remove(_table, pos)
    table.remove(_table, pos)
    return _table
end
function clone(_table) return {table.unpack(_table)} end
function addtable(_table, _table2)
    local tClone, tClone2 = clone(_table), clone(_table2)
    return table.move(tClone2, 1, #tClone2, #tClone + 1, tClone)
end
function find(_table, string, init) return table.find(_table, string, init) end
function insert(_table, _string) table.insert(_table, _string) end
function concat(_table, separator, i, j)
    return table.concat(_table, separator, i, j)
end
function p(_name_)
    local players, T = game.Players:GetChildren(), {}
    local stringPlayers = table.concat(T, ",")
    local predictor = string.match(stringPlayers:lower(),'(' .. _name_:lower() .. ".-),")
    for i, v in pairs(players) do
        if string.find(string.lower(v.DisplayName), string.lower(_name_)) then
            return v.Name
        elseif string.find(string.lower(v.Name), string.lower(_name_)) then
            return v.Name
        end
    end
    for i, v in pairs(players) do table.insert(T, v.Name) end
    if not predictor then return p(predictor) end
    return false
end
function dictFind(dict, string)
    for i, v in pairs(dict) do
        if string ~= i then continue end
        return i
    end
end
function _removepart(name)
    for i, v in pairs(getCharacter():GetChildren()) do
        if not v.Name:match(name) then continue end
        v:Destroy()
    end
end
