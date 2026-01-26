-- MT YAHAYOK VIP @DIAZ | Simple Auto TP GUI
-- by ChatGPT

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local TweenService = game:GetService("TweenService")

-- ===== COORDINATE =====
local CP = {
    Vector3.new(-477,248,775),
    Vector3.new(-338,387,586),
    Vector3.new(295,429,493),
    Vector3.new(348,487,351),
    Vector3.new(49,248,133),
    Vector3.new(226,313,-144)
}

local SUMMIT = Vector3.new(-617,905,-552)
local BC = Vector3.new(-964,169,921)

-- ===== FUNCTION TP =====
local function tp(pos)
    local tween = TweenService:Create(
        hrp,
        TweenInfo.new(0.5, Enum.EasingStyle.Linear),
        {CFrame = CFrame.new(pos)}
    )
    tween:Play()
    tween.Completed:Wait()
end

-- ===== GUI =====
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "MT_YAHAYOK_GUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,230,0,220)
frame.Position = UDim2.new(0.35,0,0.25,0)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,30)
title.Text = "MT YAHAYOK VIP"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundColor3 = Color3.fromRGB(45,45,45)
title.BorderSizePixel = 0
title.Font = Enum.Font.GothamBold
title.TextSize = 14

local delayBox = Instance.new("TextBox", frame)
delayBox.Position = UDim2.new(0.1,0,0.25,0)
delayBox.Size = UDim2.new(0.8,0,0,30)
delayBox.Text = "2"
delayBox.PlaceholderText = "Delay (1-10)"
delayBox.BackgroundColor3 = Color3.fromRGB(50,50,50)
delayBox.TextColor3 = Color3.new(1,1,1)
delayBox.Font = Enum.Font.Gotham
delayBox.TextSize = 13
delayBox.BorderSizePixel = 0

local startBtn = Instance.new("TextButton", frame)
startBtn.Position = UDim2.new(0.1,0,0.45,0)
startBtn.Size = UDim2.new(0.8,0,0,35)
startBtn.Text = "START AUTO TP"
startBtn.BackgroundColor3 = Color3.fromRGB(0,170,0)
startBtn.TextColor3 = Color3.new(1,1,1)
startBtn.Font = Enum.Font.GothamBold
startBtn.TextSize = 14
startBtn.BorderSizePixel = 0

local stopBtn = Instance.new("TextButton", frame)
stopBtn.Position = UDim2.new(0.1,0,0.65,0)
stopBtn.Size = UDim2.new(0.8,0,0,30)
stopBtn.Text = "STOP"
stopBtn.BackgroundColor3 = Color3.fromRGB(170,0,0)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.Gotham
stopBtn.TextSize = 13
stopBtn.BorderSizePixel = 0

local miniBtn = Instance.new("TextButton", frame)
miniBtn.Position = UDim2.new(0.85,0,0,0)
miniBtn.Size = UDim2.new(0,30,0,30)
miniBtn.Text = "-"
miniBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
miniBtn.TextColor3 = Color3.new(1,1,1)
miniBtn.BorderSizePixel = 0

-- ===== LOGIC =====
local running = false
local minimized = false

startBtn.MouseButton1Click:Connect(function()
    if running then return end
    running = true

    task.spawn(function()
        while running do
            local delayTime = tonumber(delayBox.Text) or 2
            delayTime = math.clamp(delayTime,1,10)

            for _,pos in ipairs(CP) do
                if not running then return end
                tp(pos)
                task.wait(delayTime)
            end

            tp(SUMMIT)
            task.wait(delayTime)

            tp(BC)
            task.wait(delayTime)
        end
    end)
end)

stopBtn.MouseButton1Click:Connect(function()
    running = false
end)

miniBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    frame.Size = minimized and UDim2.new(0,230,0,30) or UDim2.new(0,230,0,220)
    miniBtn.Text = minimized and "+" or "-"
end)
