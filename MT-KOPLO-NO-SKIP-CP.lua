--==================================================
-- MT KOPLO | AUTO TP GUI
-- CP1-40 -> SUMMIT -> BC (REMOTE) -> LOOP
-- Simple | Stable | Minimize | Delay Manual
--==================================================

-- SERVICES
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HRP = Character:WaitForChild("HumanoidRootPart")

-- REMOTE
local ResetRemote = ReplicatedStorage:WaitForChild("RequestBasecampReset")

-- CP LIST
local Points = {
    Vector3.new(308,113,130),
    Vector3.new(1096,113,272),
    Vector3.new(1526,113,629),
    Vector3.new(1770,245,658),
    Vector3.new(2559,297,673),
    Vector3.new(3134,199,533),
    Vector3.new(3207,169,-67),
    Vector3.new(3724,193,114),
    Vector3.new(3916,313,82),
    Vector3.new(4634,297,97),
    Vector3.new(5238,297,139),
    Vector3.new(5761,345,144),
    Vector3.new(6078,337,605),
    Vector3.new(6258,337,1426),
    Vector3.new(7220,229,1445),
    Vector3.new(7735,365,1388),
    Vector3.new(8451,385,1506),
    Vector3.new(8421,417,2201),
    Vector3.new(8518,521,2369),
    Vector3.new(8525,521,3178),
    Vector3.new(8586,649,3860),
    Vector3.new(8641,709,4519),
    Vector3.new(8522,821,5224),
    Vector3.new(8579,865,6254),
    Vector3.new(8522,977,7215),
    Vector3.new(8502,945,7865),
    Vector3.new(8427,949,8560),
    Vector3.new(8186,1209,9026),
    Vector3.new(8461,1209,9664),
    Vector3.new(8504,1265,10354),
    Vector3.new(8963,1337,11540),
    Vector3.new(8618,1457,12013),
    Vector3.new(8567,1477,12703),
    Vector3.new(7792,1509,12786),
    Vector3.new(6983,1513,12670),
    Vector3.new(6584,1513,12028),
    Vector3.new(5779,1561,12068),
    Vector3.new(4972,1605,12043),
    Vector3.new(4139,1645,12143),
    Vector3.new(3705,1641,12639)
}

local Summit = Vector3.new(3495,3400,13025)

-- STATE
local Running = false
local DelayTime = 3

-- GUI
local Gui = Instance.new("ScreenGui", game.CoreGui)
Gui.Name = "MT_KOPLO_GUI"

local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.new(0,260,0,200)
Main.Position = UDim2.new(0.05,0,0.3,0)
Main.BackgroundColor3 = Color3.fromRGB(25,25,25)
Main.BorderSizePixel = 0

local UICorner = Instance.new("UICorner", Main)
UICorner.CornerRadius = UDim.new(0,10)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,0,0,40)
Title.Text = "MT KOPLO | AUTO TP"
Title.TextColor3 = Color3.new(1,1,1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14

local DelayBox = Instance.new("TextBox", Main)
DelayBox.Position = UDim2.new(0.1,0,0.3,0)
DelayBox.Size = UDim2.new(0.8,0,0,30)
DelayBox.Text = "3"
DelayBox.PlaceholderText = "Delay (1-10)"
DelayBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
DelayBox.TextColor3 = Color3.new(1,1,1)
DelayBox.Font = Enum.Font.Gotham
DelayBox.TextSize = 12
Instance.new("UICorner", DelayBox)

local StartBtn = Instance.new("TextButton", Main)
StartBtn.Position = UDim2.new(0.1,0,0.55,0)
StartBtn.Size = UDim2.new(0.8,0,0,30)
StartBtn.Text = "START"
StartBtn.BackgroundColor3 = Color3.fromRGB(0,170,0)
StartBtn.TextColor3 = Color3.new(1,1,1)
StartBtn.Font = Enum.Font.GothamBold
StartBtn.TextSize = 13
Instance.new("UICorner", StartBtn)

local MinBtn = Instance.new("TextButton", Main)
MinBtn.Position = UDim2.new(0.85,0,0,0)
MinBtn.Size = UDim2.new(0,40,0,40)
MinBtn.Text = "-"
MinBtn.BackgroundTransparency = 1
MinBtn.TextColor3 = Color3.new(1,1,1)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 20

-- MINIMIZE
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    Main.Size = minimized and UDim2.new(0,260,0,40) or UDim2.new(0,260,0,200)
end)

-- AUTO TP LOOP
task.spawn(function()
    while true do
        task.wait()
        if Running then
            DelayTime = math.clamp(tonumber(DelayBox.Text) or 3,1,10)

            -- CP
            for _,pos in ipairs(Points) do
                if not Running then break end
                HRP.CFrame = CFrame.new(pos)
                task.wait(DelayTime)
            end

            -- SUMMIT
            if Running then
                HRP.CFrame = CFrame.new(Summit)
                task.wait(DelayTime)
            end

            -- BASECAMP RESET
            if Running then
                ResetRemote:FireServer()
                task.wait(DelayTime)
            end
        end
    end
end)

-- BUTTON
StartBtn.MouseButton1Click:Connect(function()
    Running = not Running
    StartBtn.Text = Running and "STOP" or "START"
    StartBtn.BackgroundColor3 = Running and Color3.fromRGB(170,0,0) or Color3.fromRGB(0,170,0)
end)
