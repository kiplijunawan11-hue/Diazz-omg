--==================================================
-- MT NGEBUT | AUTO TP GUI (FAST + SUMMIT ULTRA-SAFE)
-- CP49 SKIP -> SUMMIT -> BC -> LOOP
-- Fast | Stable | Summit Ultra-Safe | Minimize
--==================================================

-- SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- AUTO REBIND RESPAWN
player.CharacterAdded:Connect(function(c)
    char = c
    hrp = char:WaitForChild("HumanoidRootPart")
end)

--================ POSISI =================
-- CP49 dihapus, jadi teleport ke CP tidak ada
local SUMMIT = Vector3.new(-3111, 2322, 13245)
local BC = Vector3.new(2528, 118, -5884)

--================ REMOTE =================
local CP_REMOTE = ReplicatedStorage:WaitForChild("CP_DropToStart")

--================ VAR =================
local running = false
local delayTime = 0.5

--================ TP FAST (BC) =================
local function TP_Injek(pos)
    if not hrp then return end

    hrp.CFrame = CFrame.new(pos + Vector3.new(0, 6, 0))
    task.wait(0.05)

    local tween = TweenService:Create(
        hrp,
        TweenInfo.new(0.18, Enum.EasingStyle.Linear),
        {CFrame = CFrame.new(pos + Vector3.new(0, 1.8, 0))}
    )
    tween:Play()
    tween.Completed:Wait()

    task.wait(0.12)
end

--================ TP KHUSUS SUMMIT (ULTRA-SAFE ANTI SKIP) =================
local function TP_SummitSafe(pos)
    if not hrp then return end

    -- Sentuh pertama (tinggi 6)
    hrp.CFrame = CFrame.new(pos + Vector3.new(0, 6, 0))
    task.wait(0.08)

    -- Tween turun pelan ke posisi 2
    local tween1 = TweenService:Create(
        hrp,
        TweenInfo.new(0.25, Enum.EasingStyle.Linear),
        {CFrame = CFrame.new(pos + Vector3.new(0, 2, 0))}
    )
    tween1:Play()
    tween1.Completed:Wait()

    -- HOLD (kunci register)
    task.wait(0.35)

    -- Sentuh ulang paksa register server beberapa kali
    for i = 1, 2 do
        hrp.CFrame = CFrame.new(pos + Vector3.new(0, 3 + i*0.5, 0))
        task.wait(0.1)
        hrp.CFrame = CFrame.new(pos + Vector3.new(0, 2, 0))
        task.wait(0.1)
    end

    -- Drop ke posisi normal
    hrp.CFrame = CFrame.new(pos + Vector3.new(0, 1.8, 0))
    task.wait(0.2)
end

--================ GUI =================
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "MT_NGEBUT_GUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 220, 0, 200)
frame.Position = UDim2.new(0, 20, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,35)
title.BackgroundTransparency = 1
title.Text = "MT NGEBUT AUTO TP"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 14

-- Delay Box
local delayBox = Instance.new("TextBox", frame)
delayBox.PlaceholderText = "Delay (0.3 - 10)"
delayBox.Text = "0.5"
delayBox.Size = UDim2.new(0.8,0,0,30)
delayBox.Position = UDim2.new(0.1,0,0,50)
delayBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
delayBox.TextColor3 = Color3.new(1,1,1)
delayBox.Font = Enum.Font.Gotham
delayBox.TextSize = 13
Instance.new("UICorner", delayBox)

-- START
local startBtn = Instance.new("TextButton", frame)
startBtn.Text = "START"
startBtn.Size = UDim2.new(0.8,0,0,30)
startBtn.Position = UDim2.new(0.1,0,0,90)
startBtn.BackgroundColor3 = Color3.fromRGB(0,170,0)
startBtn.TextColor3 = Color3.new(1,1,1)
startBtn.Font = Enum.Font.GothamBold
startBtn.TextSize = 14
Instance.new("UICorner", startBtn)

-- STOP
local stopBtn = Instance.new("TextButton", frame)
stopBtn.Text = "STOP"
stopBtn.Size = UDim2.new(0.8,0,0,30)
stopBtn.Position = UDim2.new(0.1,0,0,130)
stopBtn.BackgroundColor3 = Color3.fromRGB(170,0,0)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBold
stopBtn.TextSize = 14
Instance.new("UICorner", stopBtn)

-- MINIMIZE
local miniBtn = Instance.new("TextButton", frame)
miniBtn.Text = "-"
miniBtn.Size = UDim2.new(0,30,0,30)
miniBtn.Position = UDim2.new(1,-35,0,5)
miniBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
miniBtn.TextColor3 = Color3.new(1,1,1)
miniBtn.Font = Enum.Font.GothamBold
miniBtn.TextSize = 18
Instance.new("UICorner", miniBtn)

-- OPEN BUTTON
local openBtn = Instance.new("TextButton", gui)
openBtn.Text = "OPEN"
openBtn.Size = UDim2.new(0,70,0,30)
openBtn.Position = UDim2.new(0,20,0.3,0)
openBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
openBtn.TextColor3 = Color3.new(1,1,1)
openBtn.Font = Enum.Font.GothamBold
openBtn.TextSize = 13
openBtn.Visible = false
Instance.new("UICorner", openBtn)

--================ BUTTON LOGIC =================
startBtn.MouseButton1Click:Connect(function()
    local val = tonumber(delayBox.Text)
    if val and val >= 0.3 and val <= 10 then
        delayTime = val
    end

    running = true

    task.spawn(function()
        while running do
            -- AUTO FIRE CP tetap jalan walau CP49 di-APUS
            pcall(function()
                CP_REMOTE:FireServer()
            end)

            task.wait(0.2)

            -- TP ke CP dihapus karena CP49 di-APUS
            -- TP_Injek(CP) -- di-skip

            task.wait(delayTime)

            TP_SummitSafe(SUMMIT) -- SUMMIT ultra-safe
            task.wait(delayTime)

            TP_Injek(BC) -- BC tetap jalan
            task.wait(delayTime)
        end
    end)
end)

stopBtn.MouseButton1Click:Connect(function()
    running = false
end)

miniBtn.MouseButton1Click:Connect(function()
    frame.Visible = false
    openBtn.Visible = true
end)

openBtn.MouseButton1Click:Connect(function()
    frame.Visible = true
    openBtn.Visible = false
end)
