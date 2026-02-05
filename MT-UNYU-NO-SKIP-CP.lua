--==================================================
-- MT UNYU | AUTO TP GUI (BOLAK BALIK FIX)
-- CP 1 -> CP 28 -> RESET -> RESPAWN -> LOOP
--==================================================

-- SERVICES
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

-- REMOTE
local ResetRemote = ReplicatedStorage
    :WaitForChild("GameRemotes")
    :WaitForChild("ResetRemote")

-- CHECKPOINTS
local CPs = {
    Vector3.new(-99.56,12.83,-444.35),
    Vector3.new(-471.03,8.83,-430.68),
    Vector3.new(-475.08,8.83,-775.13),
    Vector3.new(-195.02,8.83,-779.16),
    Vector3.new(-240.56,100.83,-878.42),
    Vector3.new(-241.74,100.83,-1350.30),
    Vector3.new(-16.90,36.83,-1373.76),
    Vector3.new(-25.32,56.83,-1667.41),
    Vector3.new(-504.57,52.83,-1663.91),
    Vector3.new(-779.42,56.83,-1364.20),
    Vector3.new(-1060.10,148.83,-1167.90),
    Vector3.new(-1161.44,184.83,-1502.33),
    Vector3.new(-1157.33,184.83,-1825.46),
    Vector3.new(-1161.13,140.83,-2147.67),
    Vector3.new(-969.74,148.83,-2381.63),
    Vector3.new(-423.32,148.83,-2376.93),
    Vector3.new(-32.77,224.83,-2287.95),
    Vector3.new(340.63,104.83,-2571.07),
    Vector3.new(50.43,228.83,-2871.08),
    Vector3.new(59.34,240.83,-3313.49),
    Vector3.new(59.31,488.83,-3826.18),
    Vector3.new(66.94,644.83,-4465.82),
    Vector3.new(181.18,808.83,-5017.64),
    Vector3.new(-150.32,1000.83,-5380.80),
    Vector3.new(-182.02,908.83,-5800.13),
    Vector3.new(-356.87,912.83,-6011.23),
    Vector3.new(-352.13,1144.83,-6886.29),
    Vector3.new(-317.04,1710.84,-7781.39)
}

-- SETTINGS
local running = false
local autoReset = true
local delayTime = 1

-- CHARACTER
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "MT_UNYU_GUI"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,260,0,230)
main.Position = UDim2.new(0.5,-130,0.5,-115)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.Active = true
main.Draggable = true

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,35)
title.Text = "MT UNYU AUTO TP"
title.BackgroundColor3 = Color3.fromRGB(35,35,35)
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 14

local startBtn = Instance.new("TextButton", main)
startBtn.Size = UDim2.new(1,-20,0,35)
startBtn.Position = UDim2.new(0,10,0,50)
startBtn.Text = "START"
startBtn.BackgroundColor3 = Color3.fromRGB(60,180,75)
startBtn.TextColor3 = Color3.new(1,1,1)
startBtn.Font = Enum.Font.GothamBold
startBtn.TextSize = 14

local delayBox = Instance.new("TextBox", main)
delayBox.Size = UDim2.new(1,-20,0,30)
delayBox.Position = UDim2.new(0,10,0,95)
delayBox.Text = "Delay (detik)"
delayBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
delayBox.TextColor3 = Color3.new(1,1,1)
delayBox.Font = Enum.Font.Gotham
delayBox.TextSize = 13

local resetBtn = Instance.new("TextButton", main)
resetBtn.Size = UDim2.new(1,-20,0,30)
resetBtn.Position = UDim2.new(0,10,0,135)
resetBtn.Text = "Auto Reset: ON"
resetBtn.BackgroundColor3 = Color3.fromRGB(70,70,200)
resetBtn.TextColor3 = Color3.new(1,1,1)
resetBtn.Font = Enum.Font.GothamBold
resetBtn.TextSize = 13

local miniBtn = Instance.new("TextButton", main)
miniBtn.Size = UDim2.new(1,-20,0,30)
miniBtn.Position = UDim2.new(0,10,0,175)
miniBtn.Text = "MINIMIZE"
miniBtn.BackgroundColor3 = Color3.fromRGB(120,120,120)
miniBtn.TextColor3 = Color3.new(1,1,1)
miniBtn.Font = Enum.Font.GothamBold
miniBtn.TextSize = 13

local icon = Instance.new("TextButton", gui)
icon.Size = UDim2.new(0,50,0,50)
icon.Position = UDim2.new(0,20,0.5,-25)
icon.Text = "UNYU"
icon.Visible = false
icon.BackgroundColor3 = Color3.fromRGB(25,25,25)
icon.TextColor3 = Color3.new(1,1,1)
icon.Font = Enum.Font.GothamBold
icon.TextSize = 12

-- TP FUNCTION
local function tp(pos)
    if hrp then
        hrp.CFrame = CFrame.new(pos + Vector3.new(0,2,0))
    end
end

-- MAIN LOOP (BOLAK BALIK)
task.spawn(function()
    while true do
        if running then
            -- CP -> SUMMIT
            for _, pos in ipairs(CPs) do
                if not running then break end
                tp(pos)
                task.wait(delayTime)
            end

            -- RESET / BC
            if running and autoReset then
                ResetRemote:FireServer()

                -- WAIT RESPAWN
                char = player.CharacterAdded:Wait()
                hrp = char:WaitForChild("HumanoidRootPart")

                task.wait(delayTime + 1)
            end
        end
        task.wait()
    end
end)

-- BUTTONS
startBtn.MouseButton1Click:Connect(function()
    running = not running
    startBtn.Text = running and "STOP" or "START"
    startBtn.BackgroundColor3 = running and Color3.fromRGB(200,60,60) or Color3.fromRGB(60,180,75)
end)

resetBtn.MouseButton1Click:Connect(function()
    autoReset = not autoReset
    resetBtn.Text = autoReset and "Auto Reset: ON" or "Auto Reset: OFF"
end)

delayBox.FocusLost:Connect(function()
    local v = tonumber(delayBox.Text)
    if v and v > 0 then
        delayTime = v
    end
end)

miniBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    icon.Visible = true
end)

icon.MouseButton1Click:Connect(function()
    main.Visible = true
    icon.Visible = false
end)
