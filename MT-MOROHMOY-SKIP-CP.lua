--==================================================
-- MT MOROHMOY | AUTO TP + AUTO RESET CHECKPOINT
-- CP40 -> Summit -> BC | LOOP
-- CP40→Summit delay 30s | Summit→BC delay 4s
--==================================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local lp = Players.LocalPlayer

-- ===== POSITIONS =====
local CP40   = Vector3.new(-11389, 1781, -10740)
local SUMMIT = Vector3.new(-10823, 2057, -12293)
local BC     = Vector3.new(-922, 97, -815)

-- ===== STATE =====
local running = false
local CP40_TO_SUMMIT_DELAY = 30  -- delay dari CP40→Summit
local SUMMIT_TO_BC_DELAY   = 4   -- delay Summit→BC

-- ===== CHARACTER =====
local char, hum, hrp
local alive = false

local function bindCharacter(c)
    char = c
    hum = c:WaitForChild("Humanoid")
    hrp = c:WaitForChild("HumanoidRootPart")
    alive = true

    hum.Died:Connect(function()
        alive = false
    end)
end

if lp.Character then
    bindCharacter(lp.Character)
end

lp.CharacterAdded:Connect(function(c)
    task.wait(1)
    bindCharacter(c)
end)

-- ===== SAFE TP =====
local function tp(pos)
    if hrp and hrp.Parent and alive then
        hrp.CFrame = CFrame.new(pos + Vector3.new(0,3,0))
    end
end

-- ===== AUTO RESET CHECKPOINT =====
local function resetCheckpoint()
    local event = ReplicatedStorage:FindFirstChild("ResetCheckpointEvent")
    if event then
        pcall(function()
            event:FireServer()
        end)
    end
end

-- ===== MAIN LOOP =====
task.spawn(function()
    while true do
        task.wait(0.2)
        if running then
            if not alive then
                repeat task.wait(0.5) until alive
            end

            -- TP CP40
            tp(CP40)
            task.wait(CP40_TO_SUMMIT_DELAY)  -- 🔥 delay 30 detik

            -- TP Summit
            tp(SUMMIT)
            task.wait(SUMMIT_TO_BC_DELAY)    -- 🔥 delay 4 detik

            -- TP BC
            tp(BC)
            task.wait(4)                     -- delay normal / default

            -- Auto reset checkpoint
            resetCheckpoint()
        end
    end
end)

-- ===== AUTO START =====
running = true
