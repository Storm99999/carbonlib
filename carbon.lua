local module = {}

-- Create Library Functions

-- Main func, must be executed before using functions like safe_highlight
module.load = function()
    local fs = Instance.new("Folder")
    fs.Name = "CarbonLibrary"
    fs.Parent = game:WaitForChild("CoreGui")
    local hs = Instance.new("Folder")
    hs.Name = "Highlights"
    hs.Parent = fs
end

module.get_nearest = function(x)
    local dist = math.huge -- inf
    local target = nil --- Nil, no target yet.
    local localplayer = game.Players.LocalPlayer
	for i,v in pairs(game:GetService("Players"):GetPlayers()) do
		if v ~= localplayer then
			if v.Character and v.Character:FindFirstChild("Head") and v.Character.Humanoid.Health > 0 then --- Alive checks
                if x then
                    if v.Character.TeamColor ~= localplayer.TeamColor then
                        local magnitude = (v.Character.Head.Position - localplayer.Character.Head.Position).magnitude
                        if magnitude < dist then
                            dist = magnitude
                            target = v
                        end
                    end
                else
                    local magnitude = (v.Character.Head.Position - localplayer.Character.Head.Position).magnitude
                    if magnitude < dist then
                        dist = magnitude
                        target = v
                    end
                end
			end
		end
    end

    return target
end

module.set_callback = function(x)
    spawn(x)
end

module.Player = function()
    return game.Players.LocalPlayer
end

module.get_cframe = function(part, path, isplr)
    local cframe = nil

    if isplr then
        if game.Players.LocalPlayer.Character:FindFirstChild(part) then
            cframe = game.Players.LocalPlayer.Character[part].CFrame
           
        end
    else
        if path:FindFirstChild(part) then
            cframe = path[part].CFrame
        end
    end

    return cframe
end

module.set_camera = function(x, y)
    workspace.CurrentCamera.CFrame = CFrame.new(x,y)
end

module.set_gravity = function(x) 
    if isnumber(x) then
        workspace.Gravity = x
    else
        print("[CarbonLib] set_gravity("..x..") failed: Not a number [CarbonLib: NaN]" )
    end
end

module.bind_function = function(x, callback)
    local plrm = game.Players.LocalPlayer:GetMouse()

    plrm.KeyDown:Connect(function(key)
        if key == x then
            spawn(callback)
        end
    end)
end

module.get_mouse = function()
    return game.Players.LocalPlayer:GetMouse()
end

module.safe_highlight = function(part, name, r, g, b)
    local h = Instance.new("Highlight")
    h.Name = name
    h.Parent = game:WaitForChild("CoreGui")["CarbonLibrary"]["Highlights"]
    h.AlwaysOnTop = true
    h.Adornee = part
    h.FillColor = Color3.fromRGB(r,g,b)
end

module.unhighlight = function(x)
    game:WaitForChild("CoreGui")["CarbonLibrary"]["Highlights"][x].Parent = nil
end

module.protect_gui = function(x) 
    if game.Players.LocalPlayer.PlayerGui[x]:IsA("ScreenGui") then
        game.Players.LocalPlayer.PlayerGui[x].Parent = game.CoreGui["CarbonLibrary"]
    else
        print("[CarbonLib] protect_gui("..x..") failed: Not a gui [CarbonLib: NaG]" )
    end
end
