-- MT GINI VIP | Auto TP GUI (KEY SYSTEM + ANTI CRACK)
-- CP -> SUMMIT -> BC LOOP (RESPAWN SAFE)
-- by ChatGPT

-- ===== ANTI TAMPER BASIC =====
local __CHECK = 0
for i = 1,5 do
	__CHECK += i
end
if __CHECK ~= 15 then
	while true do end
end

-- ===== SERVICES =====
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local dropRemote = RS:WaitForChild("CP_DropToStart")

-- ===== SIMPLE HASH =====
local function hash(str)
	local h = 0
	for i = 1, #str do
		h = (h * 31 + string.byte(str, i)) % 1000000007
	end
	return h
end

-- ===== KEY (SUDAH DIGANTI) =====
local KEY_HASH = hash("DIAZ-JULE-IDAMAN")

-- ===== SAFE CHARACTER =====
local function getChar()
	return player.Character or player.CharacterAdded:Wait()
end

local function getHRP()
	return getChar():WaitForChild("HumanoidRootPart")
end

-- ===== DATA =====
local CP = {
	Vector3.new(-534,112,-80),
	Vector3.new(-691,114,33),
	Vector3.new(-149,142,583),
	Vector3.new(-513,507,634),
	Vector3.new(-604,477,949),
	Vector3.new(-602,756,574),
	Vector3.new(-998,671,737),
	Vector3.new(-1104,786,184),
	Vector3.new(-919,855,-596),
	Vector3.new(-893,806,-909),
	Vector3.new(-879,808,-1337),
	Vector3.new(-827,1149,-2521),
	Vector3.new(255,1144,-2542),
	Vector3.new(863,1000,-2565),
	Vector3.new(1748,1030,-2447),
	Vector3.new(1753,1034,-1881),
	Vector3.new(674,997,-1196),
	Vector3.new(371,1132,-906),
	Vector3.new(-49,983,-577),
	Vector3.new(-337,936,-938),
	Vector3.new(-720,908,-1149),
	Vector3.new(-678,852,-912),
	Vector3.new(-708,936,-683),
	Vector3.new(-884,785,-20),
}

local SUMMIT = Vector3.new(-874,894,279)
local BC = Vector3.new(33,113,-254)

-- ===== GUI KEY =====
local keyGui = Instance.new("ScreenGui", game.CoreGui)
keyGui.Name = "MT_GINI_KEY"

local keyFrame = Instance.new("Frame", keyGui)
keyFrame.Size = UDim2.new(0,250,0,140)
keyFrame.Position = UDim2.new(0.4,0,0.35,0)
keyFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
keyFrame.Active = true
keyFrame.Draggable = true

local keyTitle = Instance.new("TextLabel", keyFrame)
keyTitle.Size = UDim2.new(1,0,0,30)
keyTitle.BackgroundTransparency = 1
keyTitle.Text = "MT GINI VIP - KEY"
keyTitle.TextColor3 = Color3.new(1,1,1)
keyTitle.Font = Enum.Font.SourceSansBold
keyTitle.TextSize = 18

local keyBox = Instance.new("TextBox", keyFrame)
keyBox.Position = UDim2.new(0.1,0,0.35,0)
keyBox.Size = UDim2.new(0.8,0,0,30)
keyBox.PlaceholderText = "Masukkan Key"
keyBox.Text = ""
keyBox.BackgroundColor3 = Color3.fromRGB(45,45,45)
keyBox.TextColor3 = Color3.new(1,1,1)
keyBox.ClearTextOnFocus = false

local keyBtn = Instance.new("TextButton", keyFrame)
keyBtn.Position = UDim2.new(0.1,0,0.65,0)
keyBtn.Size = UDim2.new(0.8,0,0,30)
keyBtn.Text = "VERIFY"
keyBtn.BackgroundColor3 = Color3.fromRGB(0,170,0)
keyBtn.TextColor3 = Color3.new(1,1,1)

-- ===== MAIN GUI FUNCTION =====
local function loadMain()
	local gui = Instance.new("ScreenGui", game.CoreGui)
	gui.Name = "MT_GINI_GUI"

	local main = Instance.new("Frame", gui)
	main.Size = UDim2.new(0,220,0,180)
	main.Position = UDim2.new(0.05,0,0.3,0)
	main.BackgroundColor3 = Color3.fromRGB(30,30,30)
	main.Active = true
	main.Draggable = true

	local title = Instance.new("TextLabel", main)
	title.Size = UDim2.new(1,0,0,30)
	title.BackgroundTransparency = 1
	title.Text = "MT GINI VIP"
	title.TextColor3 = Color3.new(1,1,1)
	title.Font = Enum.Font.SourceSansBold
	title.TextSize = 18

	local delayBox = Instance.new("TextBox", main)
	delayBox.Position = UDim2.new(0.1,0,0.25,0)
	delayBox.Size = UDim2.new(0.8,0,0,30)
	delayBox.Text = "2"
	delayBox.BackgroundColor3 = Color3.fromRGB(45,45,45)
	delayBox.TextColor3 = Color3.new(1,1,1)
	delayBox.ClearTextOnFocus = false

	local startBtn = Instance.new("TextButton", main)
	startBtn.Position = UDim2.new(0.1,0,0.5,0)
	startBtn.Size = UDim2.new(0.8,0,0,30)
	startBtn.Text = "START"
	startBtn.BackgroundColor3 = Color3.fromRGB(0,170,0)
	startBtn.TextColor3 = Color3.new(1,1,1)

	local miniBtn = Instance.new("TextButton", main)
	miniBtn.Position = UDim2.new(0.1,0,0.75,0)
	miniBtn.Size = UDim2.new(0.8,0,0,25)
	miniBtn.Text = "MINIMIZE"
	miniBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
	miniBtn.TextColor3 = Color3.new(1,1,1)

	local running = false
	local minimized = false

	local function tp(pos)
		getHRP().CFrame = CFrame.new(pos)
	end

	startBtn.MouseButton1Click:Connect(function()
		running = not running
		startBtn.Text = running and "STOP" or "START"
		startBtn.BackgroundColor3 = running and Color3.fromRGB(170,0,0) or Color3.fromRGB(0,170,0)

		while running do
			local d = tonumber(delayBox.Text) or 2

			for _,cp in ipairs(CP) do
				if not running then break end
				tp(cp)
				task.wait(d)
			end

			if not running then break end
			tp(SUMMIT)
			task.wait(d)

			if not running then break end
			dropRemote:FireServer()
			task.wait(1.2)
			tp(BC)
			task.wait(d)
		end
	end)

	miniBtn.MouseButton1Click:Connect(function()
		minimized = not minimized
		main.Size = minimized and UDim2.new(0,220,0,30) or UDim2.new(0,220,0,180)
		delayBox.Visible = not minimized
		startBtn.Visible = not minimized
		miniBtn.Text = minimized and "OPEN" or "MINIMIZE"
	end)
end

-- ===== KEY CHECK =====
keyBtn.MouseButton1Click:Connect(function()
	if hash(keyBox.Text) == KEY_HASH then
		keyGui:Destroy()
		loadMain()
	else
		keyBtn.Text = "KEY SALAH"
		keyBtn.BackgroundColor3 = Color3.fromRGB(170,0,0)
		task.wait(1)
		keyBtn.Text = "VERIFY"
		keyBtn.BackgroundColor3 = Color3.fromRGB(0,170,0)
	end
end)
