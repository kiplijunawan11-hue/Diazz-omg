--==================================================
-- MT YH VIP | AUTO TP GUI
-- CP28 → CP29 → SUMMIT → BC → LOOP
-- Safe Ultra + Minimize + Auto ConfirmTeleport
--==================================================

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Remote
local confirmTeleport = ReplicatedStorage:WaitForChild("ConfirmTeleport")

-- Checkpoints (CP28 & CP29)
local checkpoints = {
    Vector3.new(4839,2269,-389), -- CP28
    Vector3.new(5210,2261,-448)  -- CP29
}

local summit = Vector3.new(6804,4084,-262)
local bc = Vector3.new(-954,124,496)

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MTYHGUI"
ScreenGui.Parent = CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 200, 0, 250)
Frame.Position = UDim2.new(0, 50, 0, 50)
Frame.BackgroundColor3 = Color3.fromRGB(35,35,35)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingTop = UDim.new(0,10)
UIPadding.PaddingLeft = UDim.new(0,10)
UIPadding.Parent = Frame

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "MT YH Auto TP Ultra"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = Frame

-- Delay Input
local DelayLabel = Instance.new("TextLabel")
DelayLabel.Size = UDim2.new(1, -20, 0, 20)
DelayLabel.Position = UDim2.new(0,0,0,40)
DelayLabel.BackgroundTransparency = 1
DelayLabel.Text = "Delay (sec):"
DelayLabel.TextColor3 = Color3.fromRGB(255,255,255)
DelayLabel.Font = Enum.Font.Gotham
DelayLabel.TextSize = 14
DelayLabel.TextXAlignment = Enum.TextXAlignment.Left
DelayLabel.Parent = Frame

local DelayInput = Instance.new("TextBox")
DelayInput.Size = UDim2.new(1, -20, 0, 25)
DelayInput.Position = UDim2.new(0,0,0,60)
DelayInput.BackgroundColor3 = Color3.fromRGB(50,50,50)
DelayInput.TextColor3 = Color3.fromRGB(255,255,255)
DelayInput.Text = "1"
DelayInput.ClearTextOnFocus = false
DelayInput.Font = Enum.Font.Gotham
DelayInput.TextSize = 14
DelayInput.Parent = Frame

-- Toggle Button
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(1, -20, 0, 30)
ToggleButton.Position = UDim2.new(0,0,0,100)
ToggleButton.BackgroundColor3 = Color3.fromRGB(0,150,136)
ToggleButton.TextColor3 = Color3.fromRGB(255,255,255)
ToggleButton.Text = "Start TP"
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 16
ToggleButton.Parent = Frame

-- Minimize Button
local MinButton = Instance.new("TextButton")
MinButton.Size = UDim2.new(0, 30, 0, 30)
MinButton.Position = UDim2.new(1, -35, 0, 5)
MinButton.BackgroundColor3 = Color3.fromRGB(255,0,0)
MinButton.TextColor3 = Color3.fromRGB(255,255,255)
MinButton.Text = "-"
MinButton.Font = Enum.Font.GothamBold
MinButton.TextSize = 18
MinButton.Parent = Frame

-- Logic
local isActive = false
ToggleButton.MouseButton1Click:Connect(function()
    isActive = not isActive
    ToggleButton.Text = isActive and "Stop TP" or "Start TP"
end)

MinButton.MouseButton1Click:Connect(function()
    Frame.Visible = not Frame.Visible
end)

-- Safe Ultra TP Function
local function safeTP(pos)
    local attempt = 0
    local success = false
    while not success and attempt < 3 do -- Retry max 3 kali
        attempt += 1
        local ok, err = pcall(function()
            TweenService:Create(
                HumanoidRootPart,
                TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
                {CFrame = CFrame.new(pos)}
            ):Play()
        end)
        if ok then
            pcall(function() confirmTeleport:FireServer() end)
            success = true
        else
            warn("TP failed, retrying... "..err)
            wait(0.5)
        end
    end
    if not success then
        warn("Failed to TP after 3 attempts")
    end
end

-- Main Loop
spawn(function()
    while true do
        RunService.RenderStepped:Wait()
        if isActive then
            local delayTime = tonumber(DelayInput.Text) or 1

            -- TP Checkpoints (CP28 & CP29)
            for _, cp in ipairs(checkpoints) do
                if not isActive then break end
                safeTP(cp)
                wait(delayTime)
            end

            -- TP Summit
            if isActive then
                safeTP(summit)
                wait(delayTime)
            end

            -- TP BC
            if isActive then
                safeTP(bc)
                wait(delayTime)
            end
        else
            wait(0.1)
        end
    end
end)
