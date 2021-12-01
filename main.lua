repeat task.wait() until game:IsLoaded()
local _ = game:GetService("Players").LocalPlayer.Character or game:GetService("Players").LocalPlayer.CharacterAdded:Wait()

local scripts = {
    ["735030788"] = game:HttpGet("https://raw.githubusercontent.com/3xpl01t3r/RoyaleHighXPAutoFarm/main/PlaceIdScripts/TeleportMenu.lua"),
    ["4728136927"] = game:HttpGet("https://raw.githubusercontent.com/3xpl01t3r/RoyaleHighXPAutoFarm/main/PlaceIdScripts/Beach.lua"),
    ["1765700510"] = game:HttpGet("https://raw.githubusercontent.com/3xpl01t3r/RoyaleHighXPAutoFarm/main/PlaceIdScripts/School.lua")
}; coroutine.create(coroutine.resume(loadstring(scripts[tostring(game.PlaceId)]))
    
if game.PlaceId ~= 735030788 then 
    coroutine.create(coroutine.resume(loadstring(game:HttpGet("https://raw.githubusercontent.com/3xpl01t3r/RoyaleHighXPAutoFarm/main/SolveCaptcha.lua")))
    coroutine.create(coroutine.resume(loadstring(game:HttpGet("https://raw.githubusercontent.com/3xpl01t3r/RoyaleHighXPAutoFarm/main/AntiAfk.lua")))
end
