repeat task.wait() until game:IsLoaded()
local _ = game:GetService("services.Players").LocalPlayer.Character or game:GetService("services.Players").LocalPlayer.CharacterAdded:Wait()
game:GetService("ReplicatedStorage").SceptorTeleport:FireServer("BeachHouse")
