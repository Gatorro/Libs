--[[

          >CUSTOM ESP<

  Original script made by Blissful#4992 (Chams ESP): https://v3rmillion.net/showthread.php?tid=1104445
  Modified by me for using it with any part
  
    Syntax:
  ESP:Render(part: Instance): ..stop: Function

    Example:
  local render = ESP:Render(game.Workspace.SomePart)
  render:Stop()


    ENJOY!
]]

local Camera = game:GetService("Workspace").CurrentCamera
local RS = game:GetService("RunService").RenderStepped

local Settings = {
    Color = Color3.fromRGB(255, 0, 0),
}

local function NewQuad(color)
    local quad = Drawing.new("Quad")
    quad.Visible = false
    quad.PointA = Vector2.new(0,0)
    quad.PointB = Vector2.new(0,0)
    quad.PointC = Vector2.new(0,0)
    quad.PointD = Vector2.new(0,0)
    quad.Color = color
    quad.Filled = true
    quad.Thickness = 15
    quad.Transparency = 0.2
    return quad
end
local ESP = {};ESP.__index = ESP
function ESP:Render(object)
    local part = object
    local quads = {
        quad1 = NewQuad(Settings.Color),
        quad2 = NewQuad(Settings.Color),
        quad3 = NewQuad(Settings.Color),
        quad4 = NewQuad(Settings.Color),
        quad5 = NewQuad(Settings.Color),
        quad6 = NewQuad(Settings.Color)
    }
    local connection
    connection = RS:Connect(function()
        local size_X = part.Size.X/2
        local size_Y = part.Size.Y/2
        local size_Z = part.Size.Z/2
        local Top1 = Camera:WorldToViewportPoint((part.CFrame * CFrame.new(-size_X, size_Y, -size_Z)).p)
        local Top2 = Camera:WorldToViewportPoint((part.CFrame * CFrame.new(-size_X, size_Y, size_Z)).p)
        local Top3 = Camera:WorldToViewportPoint((part.CFrame * CFrame.new(size_X, size_Y, size_Z)).p)
        local Top4 = Camera:WorldToViewportPoint((part.CFrame * CFrame.new(size_X, size_Y, -size_Z)).p)
        local Bottom1 = Camera:WorldToViewportPoint((part.CFrame * CFrame.new(-size_X, -size_Y, -size_Z)).p)
        local Bottom2 = Camera:WorldToViewportPoint((part.CFrame * CFrame.new(-size_X, -size_Y, size_Z)).p)
        local Bottom3 = Camera:WorldToViewportPoint((part.CFrame * CFrame.new(size_X, -size_Y, size_Z)).p)
        local Bottom4 = Camera:WorldToViewportPoint((part.CFrame * CFrame.new(size_X, -size_Y, -size_Z)).p)
        quads.quad1.PointA = Vector2.new(Top1.X, Top1.Y)
        quads.quad1.PointB = Vector2.new(Top2.X, Top2.Y)
        quads.quad1.PointC = Vector2.new(Top3.X, Top3.Y)
        quads.quad1.PointD = Vector2.new(Top4.X, Top4.Y)
        quads.quad2.PointA = Vector2.new(Bottom1.X, Bottom1.Y)
        quads.quad2.PointB = Vector2.new(Bottom2.X, Bottom2.Y)
        quads.quad2.PointC = Vector2.new(Bottom3.X, Bottom3.Y)
        quads.quad2.PointD = Vector2.new(Bottom4.X, Bottom4.Y)
        quads.quad3.PointA = Vector2.new(Top1.X, Top1.Y)
        quads.quad3.PointB = Vector2.new(Top2.X, Top2.Y)
        quads.quad3.PointC = Vector2.new(Bottom2.X, Bottom2.Y)
        quads.quad3.PointD = Vector2.new(Bottom1.X, Bottom1.Y)
        quads.quad4.PointA = Vector2.new(Top2.X, Top2.Y)
        quads.quad4.PointB = Vector2.new(Top3.X, Top3.Y)
        quads.quad4.PointC = Vector2.new(Bottom3.X, Bottom3.Y)
        quads.quad4.PointD = Vector2.new(Bottom2.X, Bottom2.Y)
        quads.quad5.PointA = Vector2.new(Top3.X, Top3.Y)
        quads.quad5.PointB = Vector2.new(Top4.X, Top4.Y)
        quads.quad5.PointC = Vector2.new(Bottom4.X, Bottom4.Y)
        quads.quad5.PointD = Vector2.new(Bottom3.X, Bottom3.Y)
        quads.quad6.PointA = Vector2.new(Top4.X, Top4.Y)
        quads.quad6.PointB = Vector2.new(Top1.X, Top1.Y)
        quads.quad6.PointC = Vector2.new(Bottom1.X, Bottom1.Y)
        quads.quad6.PointD = Vector2.new(Bottom4.X, Bottom4.Y)
    end)
    for u, x in pairs(quads) do
        x.Visible = true
    end
    return setmetatable({
        render = connection,
        removeQuads = function()
            for i,v in pairs(quads) do
                v:Remove()
            end
        end,
    },ESP)
end
function ESP:Stop()
    self.render:Disconnect()
    self.removeQuads()
end
return ESP
