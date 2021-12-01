local services = setmetatable({},{__index = function(_,serv) return game:GetService(serv) end})
local localPlayer = services.Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")

local function sleep()
    local needsScreen = playerGui:WaitForChild("NeedsBar")
    local energyEventHandler = services.ReplicatedStorage.Needs.UpdateEnergy.OnClientEvent
    
    services.ReplicatedStorage.ToolGiverRemotes.GiveTool:FireServer("Sleeping Bag"); task.wait(2)
    localPlayer.Backpack:WaitForChild("Sleeping Bag").Parent = localPlayer.Character; task.wait(2)
    services.ReplicatedStorage.Tools.PlaceTool:FireServer(
        localPlayer.Character:FindFirstChild("Sleeping Bag"),
        localPlayer.Character.HumanoidRootPart.CFrame - Vector3.new(0,2,3.5),
        {}
    ); task.wait(2)
    services.ReplicatedStorage.Bed.Anim:FireServer("sleep")

    repeat task.wait(2) 
    until getupvalues(getconnections(energyEventHandler)[2].Function)[1] == 1
    services.ReplicatedStorage.SceptorTeleport:FireServer("New Royale")
end; sleep()
