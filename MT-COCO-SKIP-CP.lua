-- MT COCO VIP | SAFE EXEC FIX
-- Compatible | Smooth | No Error | No Lag

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- ===== CONFIG =====
local delayTime = 1.5
local MIN_STEP = 140
local MAX_STEP = 260
local VOID_Y = -60

-- ===== COORD =====
local POINTS = {
    Vector3.new(156, 46, 834),
    Vector3.new(-7668, 959, 9416),
    Vector3.new(-4774, 1439, 14054),
}
local SUMMIT   = Vector3.new(-4135, 2017, 16409)
local BASECAMP = Vector3.new(27, 49, 6)

-- ===== STATE =====
local running = false
local busy = false
local tpLock = false

-- ===== SAFE CHAR =====
local function getChar()
    local char = player.Character or player.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid", 5)
    local hrp = char:WaitForChild("HumanoidRootPart", 5)
    if not hum or not hrp then return end
    return char, hum, hrp
end

-- ===== PHYSICS FREEZE (COMPAT) =====
local function freeze(hrp)
    pcall(function()
        hrp.AssemblyLinearVelocity = Vector3.new(0,0,0)
        hrp.AssemblyAngularVelocity = Vector3.new(0,0,0)
    end)
end

-- ===== STEP =====
local function calcStep(dist)
    return math.clamp(dist / 18, MIN_STEP, MAX_STEP)
end

-- ===== SAFE SMOOTH TP =====
local function safeTP(hum, hrp, target)
    if tpLock or not hrp or not hum then return end
    tpLock = true

    freeze(hrp)

    local start = hrp.Position
    local dist = (target - start).Magnitude
    local step = calcStep(dist)
    local steps = math.max(1, math.floor(dist / step))

    for i = 1, steps do
        if not running then break end
        if hrp.Position.Y < VOID_Y then break end

        local alpha = i / steps
        hrp.CFrame = CFrame.new(start:Lerp(target, alpha))
        freeze(hrp)
        RunService.Heartbeat:Wait()
    end

    hrp.CFrame = CFrame.new(target)
    freeze(hrp)

    task.wait(0.15)
    tpLock = false
end

-- ===== RESET CP (SAFE) =====
local function resetCheckpoint()
    for _,v in ipairs(RS:GetDescendants()) do
        if v:IsA("RemoteEvent") and v.Name:lower():find("reset") then
            pcall(function()
                v:FireServer()
            end)
        end
    end
end

-- ===== MAIN LOOP =====
local function mainLoop()
    if busy then return end
    busy = true

    task.spawn(function()
        while running do
            local char, hum, hrp = getChar()
            if not hum or not hrp then task.wait(1) continue end

            while hum.Health <= 0 do task.wait(0.5) end

            if hrp.Position.Y < VOID_Y then
                hrp.CFrame = CFrame.new(BASECAMP)
                task.wait(1)
            end

            for _,pos in ipairs(POINTS) do
                if not running then break end
                safeTP(hum, hrp, pos)
                task.wait(delayTime)
            end

            if not running then break end
            safeTP(hum, hrp, SUMMIT)
            task.wait(delayTime)

            safeTP(hum, hrp, BASECAMP)
            task.wait(delayTime)

            resetCheckpoint()
            task.wait(delayTime)
        end
        busy = false
    end)
end

-- ===== CONTROL =====
local function start()
    if running then return end
    running = true
    mainLoop()
end

local function stop()
    running = false
end

-- ===== GUI =====
pcall(function()
    local gui = Instance.new("ScreenGui")
    gui.Name = "MT_COCO_SAFE_GUI"
    gui.ResetOnSpawn = false
    gui.Parent = player:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 220, 0, 160)
    frame.Position = UDim2.new(0.5, -110, 0.5, -80)
    frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1,0,0,35)
    title.Text = "MT COCO VIP | SAFE"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 14
    title.TextColor3 = Color3.new(1,1,1)
    title.BackgroundTransparency = 1

    local startBtn = Instance.new("TextButton", frame)
    startBtn.Size = UDim2.new(1,-40,0,35)
    startBtn.Position = UDim2.new(0,20,0,60)
    startBtn.Text = "START"
    startBtn.Font = Enum.Font.GothamBold
    startBtn.TextSize = 14
    startBtn.TextColor3 = Color3.new(1,1,1)
    startBtn.BackgroundColor3 = Color3.fromRGB(0,160,0)
    Instance.new("UICorner", startBtn)

    startBtn.MouseButton1Click:Connect(start)

    local stopBtn = Instance.new("TextButton", frame)
    stopBtn.Size = UDim2.new(1,-40,0,35)
    stopBtn.Position = UDim2.new(0,20,0,105)
    stopBtn.Text = "STOP"
    stopBtn.Font = Enum.Font.GothamBold
    stopBtn.TextSize = 14
    stopBtn.TextColor3 = Color3.new(1,1,1)
    stopBtn.BackgroundColor3 = Color3.fromRGB(170,0,0)
    Instance.new("UICorner", stopBtn)

    stopBtn.MouseButton1Click:Connect(stop)
end)
