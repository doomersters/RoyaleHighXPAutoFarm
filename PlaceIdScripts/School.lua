local services = setmetatable({},{__index = function(_,serv) return game:GetService(serv) end})
local classRemotes = services.ReplicatedStorage.Classes
local prevConnections = {}

local localPlayer = services.Players.LocalPlayer

local path = {
    Vector3.new(246.582840, 3.116798, -263.670898),
    Vector3.new(241.167694, 3.116798, -250.917007),
    Vector3.new(217.770721, 9.711408, -246.333435),
    Vector3.new(175.770721, 9.711408, -246.333435),
    Vector3.new(150.770721, 9.711408, -246.333435),
    Vector3.new(100.770721, 9.711408, -246.333435),
    Vector3.new(75.770721, 9.711408, -246.333435),
    Vector3.new(40.770721, 9.711408, -246.333435),
    Vector3.new(6.873971, 4.000004, -242.510757),
    Vector3.new(34.572433, 28.657318, -182.121841)
}

function fireBack(remote, times, ...)
    local args = {...}
    return remote.OnClientEvent:Connect(function()
        for i = 0, times do
            remote:FireServer(unpack(args))
        end
    end)
end

local classFuncs = {
    computer = function()
        return {fireBack(classRemotes.Computer, 1, 1)}
    end,

    chemistry = function()
        return {fireBack(classRemotes.Chemistry, 1, "SequenceDone")}
    end,

    pe = function()
        return {
            classRemotes.Timer.OnClientEvent:Connect(function()
                fireclickdetector(workspace["PE Class"].Bell.ClickDetector, 4)
            end)   
        }
    end,
    
    english = function()
        local label = localPlayer.PlayerGui.EnglishClass.Frame.question
        return {
            label:GetPropertyChangedSignal("Text"):Connect(function()
                classRemotes.English:FireServer(label.Parent.D.Answer.Value)
            end)
        }   
    end,

    baking = function()
        local flavorFrame = localPlayer.PlayerGui.Baking.FlavorSelect
        local linerFrame = localPlayer.PlayerGui.Baking.LinerSelect
        local icingFrame = localPlayer.PlayerGui.Baking.IcingSelect
        local addedIndex = 0

        fireBackData = {
            {services.ReplicatedStorage.Cooking.Butter, 1},
            {services.ReplicatedStorage.Cooking.Sugar, 15},
            {services.ReplicatedStorage.Cooking.Mixer, 1, 300},
            {services.ReplicatedStorage.Cooking.Flour, 15},
            {services.ReplicatedStorage.Cooking.Milk, 1}
        }

        function getFireBackConns()
            local connections = {}
            for _,data in next, fireBackData do
                table.insert(connections, fireBack(data[1], data[2], data[3]))
            end
            return connections
        end

        function getFrameConns()
            local connections = {}
            for i,frame in next, {flavorFrame, linerFrame, icingFrame} do
                table.insert(connections, frame:GetPropertyChangedSignal("Visible"):Connect(function()
                    if frame.Visible then
                        task.wait(.6)
                        getconnections(frame:FindFirstChildOfClass("TextButton").MouseButton1Click)[1]:Fire()

                        if i == 3 then
                            task.wait(.6)
                            services.ReplicatedStorage.Cooking.Toppings:FireServer("Done", "")
                            localPlayer.PlayerGui.Baking.Enabled = false
                        end
                    end
                end))
            end
            return connections
        end

        function getAllConns()
            local t1 = getFireBackConns()
            local t2 = getFrameConns()
            for _,connection in next, t2 do
                table.insert(t1, connection)
            end
            return t1
        end

        return {
            classRemotes.BookCheck.OnClientEvent:Connect(function()
                fireclickdetector(workspace.BakingCounters.CounterStuff.ClaimButton.ClickDetector, 5)
            end),

            services.ReplicatedStorage.Cooking.Egg.OnClientEvent:Connect(function(p1)
                if not p1 then return end
                fireclickdetector(workspace.BakingCounters.CounterStuff.BakingCupcakesIngredients.egg.ClickDetector, 3)
                task.wait(3.5)
                fireclickdetector(workspace.BakingCounters.CounterStuff.BakingCupcakesIngredients.egg.ClickDetector, 3)
            end),

            localPlayer.Character.ChildAdded:Connect(function(child)
                if child.Name == "Cupcake Pan" then
                    if addedIndex == 0 then
                        localPlayer.Character.Humanoid:MoveTo(workspace.BakingCounters.CounterStuff.Oven.Door.Position)
                    else
                        localPlayer.Character.Humanoid:MoveTo(workspace.BakingCounters.CounterStuff.Place.Position)
                    end
                    addedIndex += 1
                end
            end),

            unpack(getAllConns())
        }
    end
}

classRemotes.Starting.OnClientEvent:Connect(function(class)
    game:GetService("ReplicatedStorage").Classes.Starting:FireServer()
    local class = string.lower(string.gsub(class, " class", ""))
    if not classFuncs[class] then return end

    local newConnections = classFuncs[class]()

    for _,connection in next, prevConnections do
        connection:Disconnect()
    end; prevConnections = {}

    for _,connection in next, newConnections do
        table.insert(prevConnections, connection)
    end
end)

localPlayer.ChildAdded:Connect(function(child)
    if child.Name == "Homework" then
        repeat task.wait() until child:FindFirstChildOfClass("BoolValue")
        for i,homework in next, child:GetChildren() do
            homework.Complete:FireServer()
            task.wait(.5)
            fireclickdetector(workspace["Homeworkbox_" .. homework.Name].Click.ClickDetector, 3)
            if i == 3 then
                task.wait(4)
                services.ReplicatedStorage.SceptorTeleport:FireServer("BeachHouse")
            end
        end
    end
end)

local function getLocker()
    local closestMag = math.huge; local closetLocker;
    for _,door in next, workspace:GetDescendants() do
        if door:IsA("MeshPart") and door.Name == "LockerDoor" then
            local mag = (door.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude
            if mag < closestMag then closestMag = mag; closestLocker = door end
        end
    end
    return closestLocker
end

local function walkPath()
    local humanoid = localPlayer.Character:WaitForChild("Humanoid")
    for _,point in next, path do
        humanoid:MoveTo(point)
        humanoid.MoveToFinished:Wait()
    end
end

local function getBooks()
    local locker = getLocker()
    fireclickdetector(locker.ClickDetector, 5); task.wait(1)
    fireclickdetector(locker.ClickDetector, 5); task.wait(1)
    services.ReplicatedStorage.Lockers.Code:FireServer(locker, "0000", "Create"); task.wait(1)

    for _,book in next, localPlayer.Locker:GetChildren() do
        services.ReplicatedStorage.Lockers.Contents:InvokeServer("Take", book)
        task.wait(.1)
    end

    localPlayer.PlayerGui.Locker.Enabled = false
end;

walkPath()
getBooks()
