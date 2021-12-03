while true do
    for _,v in next, getconnections(game:GetService("Players").LocalPlayer.Idled)) do v:Disconnect() end
    task.wait()
end
