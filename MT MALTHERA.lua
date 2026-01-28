-- MT MALTHERA VIP | AUTO TP GUI (FULL + KEY SYSTEM)
-- CP -> SUMMIT -> BC -> ULANG
-- KEY: diaz-kenapa-ya
-- by ChatGPT

-- ======================================================
-- =================== KEY SYSTEM =======================
-- ======================================================

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

local VALID_KEY = "diaz-kenapa-ya"

local keyGui = Instance.new("ScreenGui", player.PlayerGui)
keyGui.Name = "MT_KEY_GUI"

local kf = Instance.new("Frame", keyGui)
kf.Size = UDim2.fromOffset(260,160)
kf.Position = UDim2.fromScale(0.5,0.5)
kf.AnchorPoint = Vector2.new(0.5,0.5)
kf.BackgroundColor3 = Color3.fromRGB(20,20,20)
kf.BorderSizePixel = 0
Instance.new("UICorner", kf).CornerRadius = UDim.new(0,12)

local kt = Instance.new("TextLabel", kf)
kt.Size = UDim2.new(1,0,0,40)
kt.Text = "MT MALTHERA VIP"
kt.Font = Enum.Font.GothamBold
kt.TextSize = 14
kt.TextColor3 = Color3.new(1,1,1)
kt.BackgroundTransparency = 1

local kb = Instance.new("TextBox", kf)
kb.PlaceholderText = "Masukkan Key"
kb.Size = UDim2.fromOffset(200,32)
kb.Position = UDim2.fromOffset(30,55)
kb.BackgroundColor3 = Color3.fromRGB(35,35,35)
kb.TextColor3 = Color3.new(1,1,1)
kb.Font = Enum.Font.Gotham
kb.TextSize = 12
Instance.new("UICorner", kb).CornerRadius = UDim.new(0,8)

local kv = Instance.new("TextButton", kf)
kv.Text = "VERIFY"
kv.Size = UDim2.fromOffset(200,32)
kv.Position = UDim2.fromOffset(30,100)
kv.BackgroundColor3 = Color3.fromRGB(45,45,45)
kv.TextColor3 = Color3.new(1,1,1)
kv.Font = Enum.Font.GothamBold
kv.TextSize = 12
Instance.new("UICorner", kv).CornerRadius = UDim.new(0,8)

local unlocked = false

kv.MouseButton1Click:Connect(function()
	if kb.Text == VALID_KEY then
		unlocked = true
		keyGui:Destroy()
	else
		kv.Text = "KEY SALAH"
		task.wait(1)
		kv.Text = "VERIFY"
	end
end)

repeat task.wait() until unlocked

-- ======================================================
-- =================== MAIN SCRIPT ======================
-- ======================================================

-- ===== SAFE HRP =====
local function getChar()
	return player.Character or player.CharacterAdded:Wait()
end

local function getHRP()
	return getChar():WaitForChild("HumanoidRootPart")
end

-- ===== DATA =====
local CP = {
	Vector3.new(-90,2180,601),
	Vector3.new(-76,2332,1151),
	Vector3.new(-76,2492,1649),
	Vector3.new(-59,2632,2096),
	Vector3.new(-122,2796,2512),
	Vector3.new(-78,3030,3031),
	Vector3.new(14,3192,3681),
	Vector3.new(45,3416,4231),
}

local SUMMIT = Vector3.new(72,4633,5004)
local BC = Vector3.new(-57,2032,77)

-- ===== STATE =====
local running = false
local delayTime = 2

-- ===== GUI =====
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "MT_MALTHERA_VIP"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromOffset(230,260)
frame.Position = UDim2.fromScale(0.05,0.3)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,40)
title.Text = "MT MALTHERA VIP"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.BackgroundTransparency = 1

local delayBox = Instance.new("TextBox", frame)
delayBox.Text = "2"
delayBox.PlaceholderText = "Delay (1 - 10)"
delayBox.Size = UDim2.fromOffset(180,30)
delayBox.Position = UDim2.fromOffset(25,50)
delayBox.BackgroundColor3 = Color3.fromRGB(35,35,35)
delayBox.TextColor3 = Color3.new(1,1,1)
delayBox.Font = Enum.Font.Gotham
delayBox.TextSize = 12
Instance.new("UICorner", delayBox).CornerRadius = UDim.new(0,8)

local function makeBtn(text,y)
	local b = Instance.new("TextButton", frame)
	b.Text = text
	b.Size = UDim2.fromOffset(180,32)
	b.Position = UDim2.fromOffset(25,y)
	b.BackgroundColor3 = Color3.fromRGB(45,45,45)
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 12
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
	return b
end

local startBtn = makeBtn("START AUTO",95)
local stopBtn  = makeBtn("STOP",135)
local miniBtn  = makeBtn("MINIMIZE",175)

-- ===== ICON =====
local icon = Instance.new("TextButton", gui)
icon.Size = UDim2.fromOffset(50,50)
icon.Position = UDim2.fromScale(0.05,0.3)
icon.Text = "MT"
icon.Visible = false
icon.BackgroundColor3 = Color3.fromRGB(20,20,20)
icon.TextColor3 = Color3.new(1,1,1)
icon.Font = Enum.Font.GothamBold
icon.TextSize = 14
Instance.new("UICorner", icon).CornerRadius = UDim.new(1,0)

-- ===== LOOP =====
startBtn.MouseButton1Click:Connect(function()
	local v = tonumber(delayBox.Text)
	if v and v >= 1 and v <= 10 then
		delayTime = v
	end
	if running then return end
	running = true

	task.spawn(function()
		while running do
			for _,pos in ipairs(CP) do
				if not running then return end
				getHRP().CFrame = CFrame.new(pos)
				task.wait(delayTime)
			end

			getHRP().CFrame = CFrame.new(SUMMIT)
			task.wait(delayTime)

			getHRP().CFrame = CFrame.new(BC)
			task.wait(delayTime)

			pcall(function()
				RS:WaitForChild("CheckpointSync"):FireServer("ResetCheckpoint")
			end)

			task.wait(delayTime)
		end
	end)
end)

stopBtn.MouseButton1Click:Connect(function()
	running = false
end)

miniBtn.MouseButton1Click:Connect(function()
	frame.Visible = false
	icon.Visible = true
end)

icon.MouseButton1Click:Connect(function()
	frame.Visible = true
	icon.Visible = false
end)
