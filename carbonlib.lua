local module = {}

-- Create Library Functions

-- Main func, must be executed before using functions like safe_highlight

function module.loadLib()
    local fs = Instance.new("Folder")
    fs.Name = "CarbonLibrary"
    fs.Parent = game:WaitForChild("CoreGui")
    local hs = Instance.new("Folder")
    hs.Name = "Highlights"
    hs.Parent = fs
end

function module.get_nearest(x)
    local dist = math.huge -- inf
    local target = nil --- Nil, no target yet.
    local localplayer = game.Players.LocalPlayer
	for i,v in pairs(game:GetService("Players"):GetPlayers()) do
		if v ~= localplayer then
			if v.Character and v.Character:FindFirstChild("Head") and v.Character.Humanoid.Health > 0 then --- Alive checks
                if x then
                    if v.TeamColor ~= localplayer.TeamColor then
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

function module.set_callback(x)
    spawn(x)
end


function module.getPlr()
    return game.Players.LocalPlayer

end

function module.get_cframe(part, path, isplr)
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

function module.set_camera(x, y)
    workspace.CurrentCamera.CFrame = CFrame.new(x,y)
end


function module.set_gravity(x)
    workspace.Gravity = x
end

function module.bind_function(x, callback)
    local plrm = game.Players.LocalPlayer:GetMouse()

    plrm.KeyDown:Connect(function(key)
        if key == x then
            spawn(callback)
        end
    end)
end

function module.get_mouse()
    return game.Players.LocalPlayer:GetMouse()
end

function module.safe_highlight(part, name, r, g, b)
    local h = Instance.new("Highlight")
    h.Name = name
    h.DepthMode = "AlwaysOnTop"
    h.FillColor = Color3.fromRGB(r,g,b)
    h.Adornee = part
    h.Parent = game:WaitForChild("CoreGui")["CarbonLibrary"]["Highlights"]
end

function module.unhighlight(x)
    game:WaitForChild("CoreGui")["CarbonLibrary"]["Highlights"][x].Parent = nil

end


function module.protect_gui(x)
    if game.Players.LocalPlayer.PlayerGui[x]:IsA("ScreenGui") then
        game.Players.LocalPlayer.PlayerGui[x].Parent = game.CoreGui["CarbonLibrary"]
    else
        print("[CarbonLib] protect_gui("..x..") failed: Not a gui [CarbonLib: NaG]" )
    end
end

return module
