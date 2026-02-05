--==================================================
-- MT FREESTYLE | FAST AUTO TP GUI
-- CP1 -> CP17 -> SUMMIT -> BC -> LOOP
-- Fast | Stable | No Skip | Delay 0.5 - 10 | Minimize
--==================================================

-- SERVICES
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local function GetChar()
    local c = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    return c, c:WaitForChild("HumanoidRootPart")
end

local Character, HRP = GetChar()
LocalPlayer.CharacterAdded:Connect(function()
    Character, HRP = GetChar()
end)

-- REMOTE
local BackToBC = ReplicatedStorage:WaitForChild("BackToBCEvent")

-- STATE
local running = false
local delayTime = 0.5

-- CHECKPOINTS
local CP = {
    Vector3.new(-903,15,-833),
    Vector3.new(-553,14,-886),
    Vector3.new(-9,138,-690),
    Vector3.new(89,35,-736),
    Vector3.new(370,150,-920),
    Vector3.new(749,78,-755),
    Vector3.new(628,142,-584),
    Vector3.new(550,206,-465),
    Vector3.new(655,170,-193),
    Vector3.new(996,278,-131),
    Vector3.new(1381,251,-104),
    Vector3.new(1791,118,-69),
    Vector3.new(2260,119,-77),
    Vector3.new(2681,155,-81),
    Vector3.new(3105,143,117),
    Vector3.new(3434,110,-167),
    Vector3.new(3806,217,-163)
}

local SUMMIT = Vector3.new(4142,238,-179)

-- FAST SAFE TP (ANTI JATUH)
local function SafeTP(pos)
    if not HRP then return end
    HRP.Anchored = true
    HRP.CFrame = CFrame.new(pos)
    task.wait(0.15)
    HRP.Anchored = false
end

-- MAIN LOOP
task.spawn(function()
    while true do
        if running then
            for _,v in ipairs(CP) do
                if not running then break end
                SafeTP(v)
                task.wait(delayTime)
            end

            if running then
                SafeTP(SUMMIT)
                task.wait(delayTime)

                -- AUTO BACK TO BC
                BackToBC:FireServer()
                task.wait(delayTime)
            end
        end
        task.wait(0.1)
    end
end)

--================ GUI =================--
local gui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
gui.Name = "MT_FREESTYLE_FAST"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,220,0,160)
main.Position = UDim2.new(0.03,0,0.35,0)
main.BackgroundColor3 = Color3.fromRGB(30,30,30)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,10)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,30)
title.Text = "MT FREESTYLE FAST"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 13

local delayBox = Instance.new("TextBox", main)
delayBox.PlaceholderText = "Delay 0.5 - 10"
delayBox.Text = "0.5"
delayBox.Size = UDim2.new(0.8,0,0,30)
delayBox.Position = UDim2.new(0.1,0,0.3,0)
delayBox.BackgroundColor3 = Color3.fromRGB(45,45,45)
delayBox.TextColor3 = Color3.new(1,1,1)
delayBox.Font = Enum.Font.Gotham
delayBox.TextSize = 12
Instance.new("UICorner", delayBox)

delayBox.FocusLost:Connect(function()
    local v = tonumber(delayBox.Text)
    if v and v >= 0.5 and v <= 10 then
        delayTime = v
    else
        delayBox.Text = tostring(delayTime)
    end
end)

local startBtn = Instance.new("TextButton", main)
startBtn.Text = "START"
startBtn.Size = UDim2.new(0.8,0,0,30)
startBtn.Position = UDim2.new(0.1,0,0.55,0)
startBtn.BackgroundColor3 = Color3.fromRGB(0,170,0)
startBtn.TextColor3 = Color3.new(1,1,1)
startBtn.Font = Enum.Font.GothamBold
startBtn.TextSize = 12
Instance.new("UICorner", startBtn)

local stopBtn = Instance.new("TextButton", main)
stopBtn.Text = "STOP"
stopBtn.Size = UDim2.new(0.8,0,0,30)
stopBtn.Position = UDim2.new(0.1,0,0.78,0)
stopBtn.BackgroundColor3 = Color3.fromRGB(170,0,0)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBold
stopBtn.TextSize = 12
Instance.new("UICorner", stopBtn)

startBtn.MouseButton1Click:Connect(function()
    running = true
end)

stopBtn.MouseButton1Click:Connect(function()
    running = false
end)

-- MINIMIZE ICON
local mini = Instance.new("TextButton", gui)
mini.Size = UDim2.new(0,50,0,50)
mini.Position = UDim2.new(0.01,0,0.45,0)
mini.Text = "MT"
mini.BackgroundColor3 = Color3.fromRGB(30,30,30)
mini.TextColor3 = Color3.new(1,1,1)
mini.Font = Enum.Font.GothamBold
mini.TextSize = 14
Instance.new("UICorner", mini)

mini.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
end)
