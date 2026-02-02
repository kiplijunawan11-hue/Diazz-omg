--==================================================
-- MT SAKURAVALE X1000 | AUTO TP GUI
-- CP -> SUMMIT -> BC -> LOOP
-- Simple | Stable | Minimize | Delay Manual
-- CP_DropToStart AUTO CLICK (1x ONLY)
--==================================================

--================ SERVICES =================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HRP = Character:WaitForChild("HumanoidRootPart")

LocalPlayer.CharacterAdded:Connect(function(char)
	Character = char
	HRP = char:WaitForChild("HumanoidRootPart")
end)

--================ CONFIG =================
local SUMMIT = Vector3.new(-14470, 9125, 755)
local BC = Vector3.new(-468, 138, 220)
local delayTP = 3
local running = false
local dropFired = false -- 🔒 REMOTE 1x ONLY
--=========================================

--================ GUI =====================
local gui = Instance.new("ScreenGui")
gui.Name = "MT_SAKURAVALE_X1000"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.25,0.32)
main.Position = UDim2.fromScale(0.05,0.3)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.fromScale(1,0.18)
title.Text = "MT SAKURAVALE X1000"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14

local delayBox = Instance.new("TextBox", main)
delayBox.PlaceholderText = "Delay (1 - 10)"
delayBox.Size = UDim2.fromScale(0.8,0.18)
delayBox.Position = UDim2.fromScale(0.1,0.25)
delayBox.Text = tostring(delayTP)
delayBox.BackgroundColor3 = Color3.fromRGB(35,35,35)
delayBox.TextColor3 = Color3.new(1,1,1)
delayBox.Font = Enum.Font.Gotham
delayBox.TextSize = 12
Instance.new("UICorner", delayBox).CornerRadius = UDim.new(0,8)

local startBtn = Instance.new("TextButton", main)
startBtn.Size = UDim2.fromScale(0.8,0.18)
startBtn.Position = UDim2.fromScale(0.1,0.47)
startBtn.Text = "START"
startBtn.BackgroundColor3 = Color3.fromRGB(60,180,90)
startBtn.TextColor3 = Color3.new(1,1,1)
startBtn.Font = Enum.Font.GothamBold
startBtn.TextSize = 13
Instance.new("UICorner", startBtn).CornerRadius = UDim.new(0,8)

local stopBtn = Instance.new("TextButton", main)
stopBtn.Size = UDim2.fromScale(0.8,0.18)
stopBtn.Position = UDim2.fromScale(0.1,0.68)
stopBtn.Text = "STOP"
stopBtn.BackgroundColor3 = Color3.fromRGB(180,60,60)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBold
stopBtn.TextSize = 13
Instance.new("UICorner", stopBtn).CornerRadius = UDim.new(0,8)

local mini = Instance.new("TextButton", gui)
mini.Size = UDim2.fromScale(0.06,0.08)
mini.Position = UDim2.fromScale(0.01,0.4)
mini.Text = "MT"
mini.Visible = false
mini.BackgroundColor3 = Color3.fromRGB(20,20,20)
mini.TextColor3 = Color3.new(1,1,1)
mini.Font = Enum.Font.GothamBold
mini.TextSize = 12
Instance.new("UICorner", mini).CornerRadius = UDim.new(1,0)

--================ FUNCTIONS =================
local function smoothTP(pos)
	if not HRP then return end
	local tween = TweenService:Create(
		HRP,
		TweenInfo.new(0.35, Enum.EasingStyle.Linear),
		{CFrame = CFrame.new(pos)}
	)
	tween:Play()
	tween.Completed:Wait()
end

local function getAllCP()
	local cps = {}
	for _,v in pairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") and string.find(string.lower(v.Name),"checkpoint") then
			table.insert(cps, v)
		end
	end
	table.sort(cps,function(a,b)
		return a.Position.Y < b.Position.Y
	end)
	return cps
end

-- 🔥 AUTO CLICK CP_DropToStart (1x ONLY)
local function autoClickDropCP()
	if dropFired then return end
	dropFired = true

	task.spawn(function()
		pcall(function()
			local remote = ReplicatedStorage:WaitForChild("CP_DropToStart")
			remote:FireServer()
		end)
	end)
end

--================ LOGIC =====================
startBtn.MouseButton1Click:Connect(function()
	delayTP = math.clamp(tonumber(delayBox.Text) or 3, 1, 10)
	running = true

	-- 🔥 AUTO KLIK DROP CP
	autoClickDropCP()

	task.spawn(function()
		while running do
			for _,cp in pairs(getAllCP()) do
				if not running then return end
				smoothTP(cp.Position + Vector3.new(0,3,0))
				task.wait(delayTP)
			end

			smoothTP(SUMMIT + Vector3.new(0,3,0))
			task.wait(delayTP)

			smoothTP(BC + Vector3.new(0,3,0))
			task.wait(delayTP)
		end
	end)
end)

stopBtn.MouseButton1Click:Connect(function()
	running = false
end)

title.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 then
		main.Visible = false
		mini.Visible = true
	end
end)

mini.MouseButton1Click:Connect(function()
	main.Visible = true
	mini.Visible = false
end)
