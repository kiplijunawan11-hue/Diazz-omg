-- =========================================================
-- MT PARUNG VIP | FINAL PERFECT VERSION
-- Anti-Crack + Key System + Auto TP GUI
-- by ChatGPT
-- =========================================================

-- ================== ANTI CRACK CORE ==================
if getgenv().__MT_PARUNG_CORE then
	game:GetService("Players").LocalPlayer:Kick("Duplicate Inject")
	return
end
getgenv().__MT_PARUNG_CORE = true

if not getgenv or not getrenv then
	while true do end
end

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local PLACE_LOCK = game.PlaceId
if game.PlaceId ~= PLACE_LOCK then
	player:Kick("Invalid Place")
	return
end

local integrity = {
	pcall = pcall,
	type = type,
	task = task,
	math = math,
	string = string
}

task.delay(3, function()
	for k,_ in pairs(integrity) do
		if _G[k] ~= nil then
			player:Kick("Environment Tampered")
		end
	end
end)

local function __bait()
	return math.random(1,9999999) == -1
end
task.spawn(function()
	while task.wait(6) do
		if __bait() then while true do end end
	end
end)

-- ================== KEY SYSTEM ==================
local VALID_KEY = "DIAZ-LAGI-MALES"

local function KeyUI()
	local gui = Instance.new("ScreenGui", game.CoreGui)
	gui.Name = "MT_PARUNG_KEY"

	local frame = Instance.new("Frame", gui)
	frame.Size = UDim2.fromOffset(260,150)
	frame.Position = UDim2.fromScale(0.5,0.5)
	frame.AnchorPoint = Vector2.new(0.5,0.5)
	frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
	frame.BorderSizePixel = 0
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

	local title = Instance.new("TextLabel", frame)
	title.Size = UDim2.new(1,0,0,35)
	title.Text = "MT PARUNG VIP KEY"
	title.TextColor3 = Color3.new(1,1,1)
	title.BackgroundTransparency = 1
	title.Font = Enum.Font.GothamBold
	title.TextSize = 14

	local box = Instance.new("TextBox", frame)
	box.PlaceholderText = "Masukkan Key"
	box.Size = UDim2.new(1,-30,0,35)
	box.Position = UDim2.fromOffset(15,45)
	box.BackgroundColor3 = Color3.fromRGB(40,40,40)
	box.TextColor3 = Color3.new(1,1,1)
	box.Font = Enum.Font.Gotham
	box.TextSize = 13
	Instance.new("UICorner", box).CornerRadius = UDim.new(0,8)

	local btn = Instance.new("TextButton", frame)
	btn.Text = "VERIFY"
	btn.Size = UDim2.new(1,-30,0,35)
	btn.Position = UDim2.fromOffset(15,90)
	btn.BackgroundColor3 = Color3.fromRGB(60,180,90)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)

	btn.MouseButton1Click:Connect(function()
		if box.Text == VALID_KEY then
			gui:Destroy()
			getgenv().MT_PARUNG_KEY_OK = true
		else
			player:Kick("❌ Key Salah")
		end
	end)
end

KeyUI()
repeat task.wait() until getgenv().MT_PARUNG_KEY_OK

-- ================== CORE LOCK ==================
if getgenv().MT_PARUNG then return end
getgenv().MT_PARUNG = true

-- ================== SERVICES ==================
local RS = game:GetService("ReplicatedStorage")

-- ================== SAFE CHARACTER ==================
local function getChar()
	return player.Character or player.CharacterAdded:Wait()
end
local function getHRP()
	return getChar():WaitForChild("HumanoidRootPart")
end
local function getHum()
	return getChar():WaitForChild("Humanoid")
end

-- ================== DATA ==================
local CP = {
	Vector3.new(-370,149,2502),
	Vector3.new(-529,149,2033),
	Vector3.new(-669,149,1599),
	Vector3.new(-1122,213,1187),
	Vector3.new(-1567,217,1002),
	Vector3.new(-1931,221,997),
	Vector3.new(-2224,229,1322),
	Vector3.new(-2545,221,940),
	Vector3.new(-2421,269,512),
	Vector3.new(-2573,417,128),
	Vector3.new(-2880,577,-398),
	Vector3.new(-3620,766,-1012),
	Vector3.new(-4454,749,-1741),
	Vector3.new(-5174,917,-2390),
	Vector3.new(-5799,918,-3292),
	Vector3.new(-6415,910,-4294),
	Vector3.new(-7033,905,-4979),
	Vector3.new(-8002,909,-5334),
	Vector3.new(-8496,1005,-5543),
}

local SUMMIT = Vector3.new(-9049,2507,-5821)
local BC = Vector3.new(-103,44,3393)

-- ================== REMOTE ==================
local RecallEvent = RS:WaitForChild("ValuableRecallSystem"):WaitForChild("RequestRecall")

-- ================== STATE ==================
local running = false
local delayTP = 1
local recallCooldown = false

-- ================== GUI ==================
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "MT_PARUNG_VIP"

local main = Instance.new("Frame", gui)
main.Size = UDim2.fromOffset(230,200)
main.Position = UDim2.fromScale(0.02,0.3)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,35)
title.Text = "MT PARUNG VIP"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14

local delayBox = Instance.new("TextBox", main)
delayBox.PlaceholderText = "Delay (1-10)"
delayBox.Text = "1"
delayBox.Size = UDim2.new(1,-30,0,35)
delayBox.Position = UDim2.fromOffset(15,45)
delayBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
delayBox.TextColor3 = Color3.new(1,1,1)
delayBox.Font = Enum.Font.Gotham
delayBox.TextSize = 13
Instance.new("UICorner", delayBox).CornerRadius = UDim.new(0,8)

local toggle = Instance.new("TextButton", main)
toggle.Text = "START"
toggle.Size = UDim2.new(1,-30,0,40)
toggle.Position = UDim2.fromOffset(15,90)
toggle.BackgroundColor3 = Color3.fromRGB(60,180,90)
toggle.TextColor3 = Color3.new(1,1,1)
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 14
Instance.new("UICorner", toggle).CornerRadius = UDim.new(0,10)

local minimize = Instance.new("TextButton", main)
minimize.Text = "-"
minimize.Size = UDim2.fromOffset(30,30)
minimize.Position = UDim2.new(1,-35,0,5)
minimize.BackgroundColor3 = Color3.fromRGB(60,60,60)
minimize.TextColor3 = Color3.new(1,1,1)
minimize.Font = Enum.Font.GothamBold
minimize.TextSize = 18
Instance.new("UICorner", minimize).CornerRadius = UDim.new(0,8)

local mini = Instance.new("TextButton", gui)
mini.Text = "MT"
mini.Size = UDim2.fromOffset(45,45)
mini.Position = UDim2.fromScale(0.02,0.3)
mini.Visible = false
mini.BackgroundColor3 = Color3.fromRGB(30,30,30)
mini.TextColor3 = Color3.new(1,1,1)
mini.Font = Enum.Font.GothamBold
mini.TextSize = 14
Instance.new("UICorner", mini).CornerRadius = UDim.new(1,0)

minimize.MouseButton1Click:Connect(function()
	main.Visible = false
	mini.Visible = true
end)
mini.MouseButton1Click:Connect(function()
	main.Visible = true
	mini.Visible = false
end)

-- ================== SAFE TP ==================
local function safeTP(pos)
	local hrp = getHRP()
	local hum = getHum()
	hum:ChangeState(Enum.HumanoidStateType.GettingUp)
	hum.PlatformStand = false
	hrp.AssemblyLinearVelocity = Vector3.zero
	hrp.AssemblyAngularVelocity = Vector3.zero
	hrp.CFrame = CFrame.new(pos + Vector3.new(0,8,0))
	task.wait(0.15)
	hrp.CFrame = CFrame.new(pos + Vector3.new(0,3,0))
end

local function nearBC()
	return (getHRP().Position - BC).Magnitude < 25
end

-- ================== LOOP ==================
task.spawn(function()
	while true do
		if running then
			for _,v in ipairs(CP) do
				if not running then break end
				safeTP(v)
				task.wait(delayTP)
			end

			if running then
				safeTP(SUMMIT)
				task.wait(delayTP + 0.3)

				safeTP(BC + Vector3.new(0,25,0))
				task.wait(0.25)
				safeTP(BC)
				task.wait(0.4)

				if nearBC() and not recallCooldown then
					recallCooldown = true
					pcall(function()
						RecallEvent:FireServer()
					end)
					task.delay(2,function()
						recallCooldown = false
					end)
				end
				task.wait(delayTP)
			end
		end
		task.wait(0.2)
	end
end)

toggle.MouseButton1Click:Connect(function()
	local d = tonumber(delayBox.Text)
	if d then delayTP = math.clamp(d,1,10) end
	running = not running
	toggle.Text = running and "STOP" or "START"
	toggle.BackgroundColor3 = running
		and Color3.fromRGB(200,80,80)
		or Color3.fromRGB(60,180,90)
end)
