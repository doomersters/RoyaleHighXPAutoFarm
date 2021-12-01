local VirtualUser = game:GetService("VirtualUser")
while true do
    local random = math.random(1,500)
    VirtualUser:Button2Down(Vector2.new(0,random), workspace.CurrentCamera.CFrame)
    task.wait(.5)
    VirtualUser:Button2Up(Vector2.new(0,random), workspace.CurrentCamera.CFrame)
    task.wait(480)
end
