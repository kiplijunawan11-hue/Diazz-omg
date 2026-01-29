-- =====================================================
-- MT YAHAYUK V1 | AUTO TP GUI
-- CP1 -> CP5 -> SUMMIT -> BC (LOOP)
-- SIMPLE UI + MINIMIZE + DELAY INPUT
-- ANTI CRACK VERSION (VALID)
-- by ChatGPT
-- =====================================================

-- ================== ANTI CRACK CORE ==================
if getgenv().__MT_YAHAYUK_CORE then
	game:GetService("Players").LocalPlayer:Kick("Duplicate Inject Detected")
	return
end
getgenv().__MT_YAHAYUK_CORE = true

if not getgenv or not getrenv then
	while true do end
end
-- =====================================================

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- ===== SAFE CHARACTER =====
local function getChar()
	return player.Character or player.CharacterAdded:Wait()
end

local function getHRP()
	return getChar():WaitForChild("HumanoidRootPart")
end

-- ===== POSITIONS =====
local CP = {
	Vector3.new(-429,249,789),   -- CP1
	Vector3.new(-347,388,522),   -- CP2
	Vector3.new(288,429,505),    -- CP3
	Vector3.new(334,490,348),    -- CP4
	Vector3.new(223,314,-146)    -- CP5
}

local SUMMIT = Vector3.new(-616,905,-543)
local BC = Vector3.new(-958,170,875)

-- ===== STATE =====
local running = false
local delayTime = 2

-- ===== GUI =====
local gui = Instance.new("ScreenGui")
gui.Name = "MT_YAHAYUK_GUI"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,260,0,220)
main.Position = UDim2.new(0.5,-130,0.35,0)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,10)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,35)
title.BackgroundTransparency = 1
title.Text = "MT YAHAYUK V1"
title.TextColor3 = Color3.fromRGB(0,255,170)
title.Font = Enum.Font.GothamBold
title.TextSize = 16

local minimizeBtn = Instance.new("TextButton", main)
minimizeBtn.Size = UDim2.new(0,30,0,30)
minimizeBtn.Position = UDim2.new(1,-35,0,3)
minimizeBtn.Text = "-"
minimizeBtn.BackgroundTransparency = 1
minimizeBtn.TextColor3 = Color3.new(1,1,1)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 18

local startBtn = Instance.new("TextButton", main)
startBtn.Size = UDim2.new(0.9,0,0,35)
startBtn.Position = UDim2.new(0.05,0,0.3,0)
startBtn.Text = "START"
startBtn.Font = Enum.Font.GothamBold
startBtn.TextSize = 14
startBtn.TextColor3 = Color3.new(1,1,1)
startBtn.BackgroundColor3 = Color3.fromRGB(0,170,120)
Instance.new("UICorner", startBtn)

local delayBox = Instance.new("TextBox", main)
delayBox.Size = UDim2.new(0.9,0,0,30)
delayBox.Position = UDim2.new(0.05,0,0.55,0)
delayBox.PlaceholderText = "Delay (1 - 10)"
delayBox.Text = "2"
delayBox.Font = Enum.Font.Gotham
delayBox.TextSize = 13
delayBox.TextColor3 = Color3.new(1,1,1)
delayBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
Instance.new("UICorner", delayBox)

-- ===== MINIMIZE ICON =====
local mini = Instance.new("TextButton", gui)
mini.Size = UDim2.new(0,45,0,45)
mini.Position = UDim2.new(0,15,0.5,0)
mini.Text = "MT"
mini.Font = Enum.Font.GothamBold
mini.TextSize = 14
mini.TextColor3 = Color3.new(1,1,1)
mini.BackgroundColor3 = Color3.fromRGB(0,170,120)
mini.Visible = false
Instance.new("UICorner", mini)

minimizeBtn.MouseButton1Click:Connect(function()
	main.Visible = false
	mini.Visible = true
end)

mini.MouseButton1Click:Connect(function()
	main.Visible = true
	mini.Visible = false
end)

-- ===== FUNCTIONS =====
local function tp(pos)
	getHRP().CFrame = CFrame.new(pos)
end

local function resetChar()
	local hum = getChar():FindFirstChildOfClass("Humanoid")
	if hum then hum.Health = 0 end
	player.CharacterAdded:Wait()
	task.wait(1)
end

-- ===== MAIN LOOP =====
task.spawn(function()
	while true do
		if running then
			for i, pos in ipairs(CP) do
				tp(pos)
				task.wait(delayTime)
				if i == 5 then
					resetChar()
				end
			end
			tp(SUMMIT)
			task.wait(delayTime)
			tp(BC)
			task.wait(delayTime)
		end
		task.wait(0.2)
	end
end)

-- ===== BUTTON =====
startBtn.MouseButton1Click:Connect(function()
	running = not running
	delayTime = math.clamp(tonumber(delayBox.Text) or 2,1,10)
	startBtn.Text = running and "STOP" or "START"
	startBtn.BackgroundColor3 = running and Color3.fromRGB(200,60,60) or Color3.fromRGB(0,170,120)
end)
