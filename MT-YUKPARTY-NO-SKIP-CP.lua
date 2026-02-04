--==================================================
-- MT YUKPARTY | AUTO TP GUI (ANTI JATUH)
-- CP1 -> CP10 -> SUMMIT -> BC -> LOOP
-- INSTANT | NO MELAYANG | NO NEMBUS
--==================================================

-- SERVICES
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HRP = Character:WaitForChild("HumanoidRootPart")

Player.CharacterAdded:Connect(function(char)
    Character = char
    HRP = char:WaitForChild("HumanoidRootPart")
end)

-- POSITIONS
local CP = {
    Vector3.new(2277,297,-1524),
    Vector3.new(1451,513,-1474),
    Vector3.new(1140,665,-2373),
    Vector3.new(332,761,-2770),
    Vector3.new(450,1013,-1870),
    Vector3.new(222,885,-1090),
    Vector3.new(-357,1238,-1017),
    Vector3.new(-320,1341,-783),
    Vector3.new(-1101,1481,-1211),
    Vector3.new(-1841,1485,-1616)
}

local SUMMIT = Vector3.new(-2279,1905,-2207)
local REMOTE_BC = Vector3.new(2411,246,-584)

-- SETTINGS
local running = false
local delayTime = 2

-- TP ANTI JATUH (DIEM)
local function TP(pos)
    if not HRP then return end
    HRP.Anchored = true
    HRP.Velocity = Vector3.zero
    HRP.RotVelocity = Vector3.zero
    HRP.CFrame = CFrame.new(pos.X, pos.Y + 5, pos.Z)
    task.wait(0.15)
    HRP.Anchored = false
end

-- AUTO REMOTE CLICK
local function ClickRemote()
    for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("ClickDetector") and v.Parent then
            if (v.Parent.Position - REMOTE_BC).Magnitude <= 10 then
                fireclickdetector(v)
            end
        end
    end
end

-- MAIN LOOP
task.spawn(function()
    while true do
        if running then
            for _,cp in ipairs(CP) do
                if not running then break end
                TP(cp)
                task.wait(delayTime)
            end

            if running then
                TP(SUMMIT)
                task.wait(delayTime)
            end

            if running then
                TP(REMOTE_BC)
                task.wait(1)
                ClickRemote()
                task.wait(delayTime)
            end
        end
        task.wait(0.1)
    end
end)

--================ GUI =================--
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "MT_YUKPARTY_GUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,220,0,190)
frame.Position = UDim2.new(0.05,0,0.3,0)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,30)
title.BackgroundTransparency = 1
title.Text = "MT YUKPARTY"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 16

local startBtn = Instance.new("TextButton", frame)
startBtn.Size = UDim2.new(0.9,0,0,35)
startBtn.Position = UDim2.new(0.05,0,0,40)
startBtn.Text = "START"
startBtn.BackgroundColor3 = Color3.fromRGB(0,170,0)
startBtn.TextColor3 = Color3.new(1,1,1)
startBtn.Font = Enum.Font.SourceSansBold

startBtn.MouseButton1Click:Connect(function()
    running = not running
    startBtn.Text = running and "STOP" or "START"
    startBtn.BackgroundColor3 = running and Color3.fromRGB(170,0,0) or Color3.fromRGB(0,170,0)
end)

local delayBox = Instance.new("TextBox", frame)
delayBox.Size = UDim2.new(0.9,0,0,30)
delayBox.Position = UDim2.new(0.05,0,0,85)
delayBox.PlaceholderText = "Delay (1 - 10)"
delayBox.Text = "2"
delayBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
delayBox.TextColor3 = Color3.new(1,1,1)

delayBox.FocusLost:Connect(function()
    local v = tonumber(delayBox.Text)
    if v and v >= 1 and v <= 10 then
        delayTime = v
    else
        delayBox.Text = tostring(delayTime)
    end
end)

local miniBtn = Instance.new("TextButton", frame)
miniBtn.Size = UDim2.new(0.9,0,0,30)
miniBtn.Position = UDim2.new(0.05,0,0,125)
miniBtn.Text = "MINIMIZE"
miniBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
miniBtn.TextColor3 = Color3.new(1,1,1)

local mini = false
miniBtn.MouseButton1Click:Connect(function()
    mini = not mini
    frame.Size = mini and UDim2.new(0,220,0,40) or UDim2.new(0,220,0,190)
    miniBtn.Text = mini and "OPEN" or "MINIMIZE"
end)
