--==================================================
-- MT DINTIL | AUTO TP GUI (NO TERBANG)
-- CP -> SUMMIT -> BC -> LOOP
-- Solid TP | Stable | Delay Manual | Minimize | Auto Remote BC
--==================================================

-- SERVICES
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function getChar()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

local Character = getChar()
local HRP = Character:WaitForChild("HumanoidRootPart")

LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    HRP = char:WaitForChild("HumanoidRootPart")
end)

-- COORDINATES
local Points = {
    Vector3.new(540, -10, -1286), -- CP1
    Vector3.new(523, 27, -908),   -- CP2
    Vector3.new(547, 41, -561),   -- CP3
    Vector3.new(571, 119, -174),  -- CP4
    Vector3.new(454, 377, 224),   -- CP5
    Vector3.new(273, 377, 381),   -- SUMMIT
    Vector3.new(508, -5, -1781)   -- BC
}

-- SETTINGS
local running = false
local delayTime = 2

-- SOLID TP (DIEM, NO TERBANG)
local function SolidTP(pos)
    if not HRP then return end
    HRP.Anchored = true
    HRP.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
    task.wait(0.15)
    HRP.Anchored = false
end

-- AUTO REMOTE BASE CAMP
local function ClickBaseCamp()
    for _,v in pairs(game:GetDescendants()) do
        if v:IsA("RemoteEvent") and v.Name:lower():find("base") then
            pcall(function()
                v:FireServer()
            end)
        end
    end
end

-- MAIN LOOP
task.spawn(function()
    while task.wait() do
        if running then
            for _,pos in ipairs(Points) do
                if not running then break end
                SolidTP(pos)
                task.wait(delayTime)
                ClickBaseCamp()
            end
        end
    end
end)

--================ GUI =================

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "MT_DINTIL_GUI"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,220,0,185)
main.Position = UDim2.new(0.05,0,0.3,0)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,30)
title.Text = "MT DINTIL AUTO TP"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundColor3 = Color3.fromRGB(40,40,40)
title.BorderSizePixel = 0

local start = Instance.new("TextButton", main)
start.Size = UDim2.new(0.8,0,0,35)
start.Position = UDim2.new(0.1,0,0.28,0)
start.Text = "START"
start.BackgroundColor3 = Color3.fromRGB(0,170,0)
start.TextColor3 = Color3.new(1,1,1)

local stop = Instance.new("TextButton", main)
stop.Size = UDim2.new(0.8,0,0,35)
stop.Position = UDim2.new(0.1,0,0.52,0)
stop.Text = "STOP"
stop.BackgroundColor3 = Color3.fromRGB(170,0,0)
stop.TextColor3 = Color3.new(1,1,1)

local delayBox = Instance.new("TextBox", main)
delayBox.Size = UDim2.new(0.8,0,0,30)
delayBox.Position = UDim2.new(0.1,0,0.75,0)
delayBox.PlaceholderText = "Delay (1 - 10)"
delayBox.Text = tostring(delayTime)
delayBox.BackgroundColor3 = Color3.fromRGB(50,50,50)
delayBox.TextColor3 = Color3.new(1,1,1)

-- MINIMIZE
local mini = Instance.new("TextButton", gui)
mini.Size = UDim2.new(0,45,0,45)
mini.Position = UDim2.new(0.01,0,0.4,0)
mini.Text = "MT"
mini.Visible = false
mini.BackgroundColor3 = Color3.fromRGB(30,30,30)
mini.TextColor3 = Color3.new(1,1,1)
mini.Active = true
mini.Draggable = true

-- BUTTONS
start.MouseButton1Click:Connect(function()
    local val = tonumber(delayBox.Text)
    if val and val >= 1 and val <= 10 then
        delayTime = val
    end
    running = true
end)

stop.MouseButton1Click:Connect(function()
    running = false
end)

title.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton2 then
        main.Visible = false
        mini.Visible = true
    end
end)

mini.MouseButton1Click:Connect(function()
    main.Visible = true
    mini.Visible = false
end)
