repeat task.wait() until game:IsLoaded()
local _ = game:GetService("Players").LocalPlayer.Character or game:GetService("Players").LocalPlayer.CharacterAdded:Wait()
game:GetService("ReplicatedStorage").SceptorTeleport:FireServer("BeachHouse")
