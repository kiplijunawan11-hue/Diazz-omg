-- MT KENANGAN VIP | AUTO TP GUI
-- CP -> SUMMIT -> BASECAMP (AUTO CLICK) -> LOOP
-- HARD KEY + ANTI EDIT
-- FINAL VERSION

-- ===== ANTI EDIT HARD (PALING ATAS) =====
local EXPECTED_KEY = "diaz-durdur"
local EXPECTED_GUI = "MT_KENANGAN_VIP"
_G.__KENANGAN_KEY = EXPECTED_KEY

task.spawn(function()
	while task.wait(2) do
		pcall(function()
			local plr = game:GetService("Players").LocalPlayer

			if _G.__KENANGAN_KEY ~= EXPECTED_KEY then
				plr:Kick("SCRIPT EDIT DETECTED [KEY]")
			end

			if not game.CoreGui:FindFirstChild(EXPECTED_GUI) then
				plr:Kick("SCRIPT EDIT DETECTED [GUI]")
			end

			if getrenv == nil or getfenv == nil then
				plr:Kick("SCRIPT EDIT DETECTED [ENV]")
			end
		end)
	end
end)

-- ===== SERVICES =====
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

-- ===== SAFE CHAR =====
local function getChar()
	return player.Character or player.CharacterAdded:Wait()
end

local function getHRP()
	return getChar():WaitForChild("HumanoidRootPart")
end

-- ===== CP DATA =====
local Points = {
	Vector3.new(-4137,144,-327),
	Vector3.new(-3811,105,-370),
	Vector3.new(-3621,186,-365),
	Vector3.new(-3267,188,552),
	Vector3.new(-2173,8,848),
	Vector3.new(-1690,181,390),
	Vector3.new(-1672,244,365),
	Vector3.new(-1687,365,274),
	Vector3.new(-1344,24,-1799),
	Vector3.new(652,173,-1571),
	Vector3.new(219,24,-624),
	Vector3.new(285,448,-548),
	Vector3.new(1092,448,-279),
	Vector3.new(1512,446,-240),
	Vector3.new(2386,259,-124)
}

local SUMMIT = Vector3.new(3368,381,49)
local BASECAMP_POS = Vector3.new(-5207,21,-467)

-- ===== REMOTE =====
local DropToStart = RS:WaitForChild("CP_DropToStart")

-- ===== STATE =====
local running = false
local delayTime = 3
local keyPassed = false
local VALID_KEY = "diaz-durdur"

-- ===== GUI ROOT =====
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "MT_KENANGAN_VIP"

-- ===== KEY GUI =====
local keyFrame = Instance.new("Frame", gui)
keyFrame.Size = UDim2.new(0,260,0,160)
keyFrame.Position = UDim2.new(0.4,0,0.35,0)
keyFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
keyFrame.BorderSizePixel = 0
keyFrame.Active = true
keyFrame.Draggable = true

local keyTitle = Instance.new("TextLabel", keyFrame)
keyTitle.Size = UDim2.new(1,0,0,35)
keyTitle.BackgroundColor3 = Color3.fromRGB(35,35,35)
keyTitle.Text = "KEY SYSTEM"
keyTitle.TextColor3 = Color3.new(1,1,1)
keyTitle.Font = Enum.Font.GothamBold
keyTitle.TextSize = 14

local keyBox = Instance.new("TextBox", keyFrame)
keyBox.Position = UDim2.new(0.1,0,0.35,0)
keyBox.Size = UDim2.new(0.8,0,0,35)
keyBox.PlaceholderText = "Enter Key"
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 14
keyBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
keyBox.TextColor3 = Color3.new(1,1,1)

local keyBtn = Instance.new("TextButton", keyFrame)
keyBtn.Position = UDim2.new(0.1,0,0.65,0)
keyBtn.Size = UDim2.new(0.8,0,0,35)
keyBtn.Text = "VERIFY"
keyBtn.Font = Enum.Font.GothamBold
keyBtn.TextSize = 14
keyBtn.BackgroundColor3 = Color3.fromRGB(0,170,170)
keyBtn.TextColor3 = Color3.new(1,1,1)

-- ===== MAIN GUI =====
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,260,0,220)
main.Position = UDim2.new(0.05,0,0.25,0)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.BorderSizePixel = 0
main.Visible = false
main.Active = true
main.Draggable = true

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,35)
title.BackgroundColor3 = Color3.fromRGB(35,35,35)
title.Text = "MT KENANGAN VIP"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 14

local delayBox = Instance.new("TextBox", main)
delayBox.Position = UDim2.new(0.1,0,0.25,0)
delayBox.Size = UDim2.new(0.8,0,0,35)
delayBox.Text = "3"
delayBox.PlaceholderText = "Delay (1 - 10)"
delayBox.Font = Enum.Font.Gotham
delayBox.TextSize = 14
delayBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
delayBox.TextColor3 = Color3.new(1,1,1)

local startBtn = Instance.new("TextButton", main)
startBtn.Position = UDim2.new(0.1,0,0.5,0)
startBtn.Size = UDim2.new(0.8,0,0,35)
startBtn.Text = "START"
startBtn.Font = Enum.Font.GothamBold
startBtn.TextSize = 14
startBtn.BackgroundColor3 = Color3.fromRGB(0,170,0)
startBtn.TextColor3 = Color3.new(1,1,1)

local stopBtn = Instance.new("TextButton", main)
stopBtn.Position = UDim2.new(0.1,0,0.7,0)
stopBtn.Size = UDim2.new(0.8,0,0,35)
stopBtn.Text = "STOP"
stopBtn.Font = Enum.Font.GothamBold
stopBtn.TextSize = 14
stopBtn.BackgroundColor3 = Color3.fromRGB(170,0,0)
stopBtn.TextColor3 = Color3.new(1,1,1)

-- ===== KEY CHECK =====
keyBtn.MouseButton1Click:Connect(function()
	if keyBox.Text == VALID_KEY then
		keyPassed = true
		keyFrame:Destroy()
		main.Visible = true
	else
		player:Kick("INVALID KEY ❌")
	end
end)

-- ===== AUTO TP LOOP =====
local function teleportLoop()
	while running and keyPassed do
		for _,pos in ipairs(Points) do
			if not running then return end
			getHRP().CFrame = CFrame.new(pos)
			task.wait(delayTime)
		end

		getHRP().CFrame = CFrame.new(SUMMIT)
		task.wait(delayTime)

		getHRP().CFrame = CFrame.new(BASECAMP_POS)
		task.wait(0.5)

		pcall(function()
			DropToStart:FireServer()
		end)

		task.wait(delayTime)
	end
end

startBtn.MouseButton1Click:Connect(function()
	if not keyPassed then return end
	local d = tonumber(delayBox.Text)
	if d and d >= 1 and d <= 10 then
		delayTime = d
	end
	if running then return end
	running = true
	task.spawn(teleportLoop)
end)

stopBtn.MouseButton1Click:Connect(function()
	running = false
end)
