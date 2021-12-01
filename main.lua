repeat task.wait() until game:IsLoaded()
local _ = game:GetService("Players").LocalPlayer.Character or game:GetService("Players").LocalPlayer.CharacterAdded:Wait()

local scripts = {
    ["735030788"] = game:HttpGet("https://raw.githubusercontent.com/3xpl01t3r/RoyaleHighXPAutoFarm/main/PlaceIdScripts/TeleportMenu.lua"),
    ["4728136927"] = game:HttpGet("https://raw.githubusercontent.com/3xpl01t3r/RoyaleHighXPAutoFarm/main/PlaceIdScripts/Beach.lua"),
    ["1765700510"] = game:HttpGet("https://raw.githubusercontent.com/3xpl01t3r/RoyaleHighXPAutoFarm/main/PlaceIdScripts/School.lua")
}; loadstring(scripts[tostring(game.PlaceId)])()        
