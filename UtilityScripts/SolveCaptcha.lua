local services = setmetatable({},{__index = function(_,serv) return game:GetService(serv) end})
local localPlayer = services.Players.LocalPlayer

local playerGui = localPlayer:WaitForChild("PlayerGui")
local captchaGui = playerGui:WaitForChild("CaptchaGui")

local floatArea = playerGui.CaptchaGui.Captcha.FloatArea
local awardGui = playerGui.CaptchaGui.Award

local function solveCaptcha()
    if captchaGui.Enabled == false then return end
    task.wait(2)
    repeat
        for _,box in next, floatArea:GetChildren() do
            local connections = getconnections(box.MouseButton1Click)
            for _,connection in next, connections do
                connection:Fire()
            end
            task.wait(2)
        end
        task.wait(2)
    until awardGui.Visible
    captchaGui.Enabled = false
end

captchaGui:GetPropertyChangedSignal("Enabled"):Connect(solveCaptcha); solveCaptcha()
