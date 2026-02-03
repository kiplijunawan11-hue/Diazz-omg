--==================================================
-- MT YAYAKIN MERAH MUDAH | AUTO TP GUI
-- NORMAL MODE | SMOOTH | PERFECT CP
-- CP1 -> CP5 -> SUMMIT -> BC -> LOOP
--==================================================

-- SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- CHARACTER
local function getHRP()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    return char:WaitForChild("HumanoidRootPart")
end

-- POINTS
local Points = {
    {name="CP1", pos=Vector3.new(-456,253,753)},
    {name="CP2", pos=Vector3.new(-338,391,538)},
    {name="CP3", pos=Vector3.new(287,435,499)},
    {name="CP4", pos=Vector3.new(333,493,346)},
    {name="CP5", pos=Vector3.new(236,317,-144)},
    {name="SUMMIT", pos=Vector3.new(-613,908,-551)},
    {name="BC", pos=Vector3.new(-946,172,861)}
}

-- STATE
local running = false
local delayTime = 2

-- 🔥 NORMAL PERFECT INJECT
local function NormalInject(pos)
    local hrp = getHRP()

    -- datang dari atas
    hrp.CFrame = CFrame.new(pos + Vector3.new(0,4,0))
    task.wait(0.15)

    -- turun pelan (sekali, halus)
    local tween = TweenService:Create(
        hrp,
        TweenInfo.new(0.45, Enum.EasingStyle.Linear),
        {CFrame = CFrame.new(pos + Vector3.new(0,0.8,0))}
    )
    tween:Play()
    tween.Completed:Wait()

    -- diam biar CP kebaca
    task.wait(0.45)
end

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "MT_YAYAKIN_NORMAL"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,260,0,230)
main.Position = UDim2.new(0.35,0,0.25,0)
main.BackgroundColor3 = Color3.fromRGB(255,170,200)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,35)
title.Text = "MT YAYAKIN | NORMAL MODE"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 14

local delayBox = Instance.new("TextBox", main)
delayBox.Size = UDim2.new(0.8,0,0,30)
delayBox.Position = UDim2.new(0.1,0,0,50)
delayBox.Text = "2"
delayBox.PlaceholderText = "Delay Loop (1-10)"
delayBox.Font = Enum.Font.Gotham
delayBox.TextSize = 14

delayBox.FocusLost:Connect(function()
    local v = tonumber(delayBox.Text)
    if v and v >= 1 and v <= 10 then
        delayTime = v
    else
        delayBox.Text = tostring(delayTime)
    end
end)

local start = Instance.new("TextButton", main)
start.Size = UDim2.new(0.8,0,0,35)
start.Position = UDim2.new(0.1,0,0,95)
start.Text = "START"
start.BackgroundColor3 = Color3.fromRGB(255,90,140)
start.TextColor3 = Color3.new(1,1,1)
start.Font = Enum.Font.GothamBold
start.TextSize = 14

local stop = Instance.new("TextButton", main)
stop.Size = UDim2.new(0.8,0,0,35)
stop.Position = UDim2.new(0.1,0,0,140)
stop.Text = "STOP"
stop.BackgroundColor3 = Color3.fromRGB(180,60,100)
stop.TextColor3 = Color3.new(1,1,1)
stop.Font = Enum.Font.GothamBold
stop.TextSize = 14

local mini = Instance.new("TextButton", main)
mini.Size = UDim2.new(0,30,0,30)
mini.Position = UDim2.new(1,-35,0,5)
mini.Text = "-"
mini.Font = Enum.Font.GothamBold

local hidden = false
mini.MouseButton1Click:Connect(function()
    hidden = not hidden
    for _,v in pairs(main:GetChildren()) do
        if v ~= title and v ~= mini then
            v.Visible = not hidden
        end
    end
    main.Size = hidden and UDim2.new(0,260,0,40) or UDim2.new(0,260,0,230)
end)

-- LOOP
task.spawn(function()
    while true do
        task.wait()
        if running then
            for _,p in ipairs(Points) do
                if not running then break end
                NormalInject(p.pos)
                task.wait(delayTime)
            end
        end
    end
end)

start.MouseButton1Click:Connect(function()
    running = true
end)

stop.MouseButton1Click:Connect(function()
    running = false
end)
