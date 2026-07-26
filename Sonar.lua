local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Debris = game:GetService("Debris")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local toggleKey = Enum.KeyCode.RightShift
local isListeningForKey = false

-- Настройки Protect
local antiGrabEnabled = false
local antiBurnEnabled = false
local antiFlingEnabled = false
local antiKickEnabled = false
local gucciAntiGrabEnabled = false
local antiStunEnabled = false
local antiKillEnabled = false
local antiBringEnabled = false

-- Настройки Attack
local flingStrength = 1000
local superStrengthEnabled = false
local killGrabEnabled = false
local kickGrabEnabled = false

-- Настройки Automation
local autoFlingAllEnabled = false
local autoGrabEnabled = false
local autoBringItemsEnabled = false
local autoGrabRadius = 50
local autoFlingDelay = 0.3
local bringItemsHeight = 5

-- Настройки Player
local noclipEnabled = false
local infiniteJumpEnabled = false
local wsEnabled = false
local wsValue = 16
local jpEnabled = false
local jpValue = 50
local reachEnabled = false
local reachValue = 8

-- Настройки Shaders
local currentTimeOfDay = nil
local currentSeason = nil

-- Настройки Misc
local walkWaterEnabled = false
local espEnabled = false
local selectedESPPlayer = nil

-- Настройки Menu
local menuScale = 1
local menuTransparency = 0
local cornerRadius = 12
local textSize = 16
local currentColor = Color3.fromRGB(30, 30, 30)
local brightnessMultiplier = 1
local menuName = "Solar"

-- Переменные
local antiKickShuriken = nil
local antiKickConnection = nil
local lastStablePosition = nil
local autoFlingConnection = nil
local autoGrabConnection = nil
local autoBringConnection = nil
local noclipConnection = nil
local infiniteJumpConnection = nil
local antiKillConnection = nil
local antiBringConnection = nil
local espConnection = nil

local colors = {
	["Red"] = Color3.fromRGB(180, 40, 40),
	["Blue"] = Color3.fromRGB(40, 40, 180),
	["Green"] = Color3.fromRGB(40, 180, 40),
	["Pink"] = Color3.fromRGB(255, 105, 180),
	["Purple"] = Color3.fromRGB(128, 0, 128),
	["White"] = Color3.fromRGB(200, 200, 200),
	["Brown"] = Color3.fromRGB(139, 69, 19),
	["Rainbow Gradient"] = Color3.fromRGB(255, 0, 0)
}
local selectedColorName = "Default"

-- ================= СОЗДАНИЕ UI =================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SolarMenuGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999999
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 550, 0, 420)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -210)
MainFrame.BackgroundColor3 = currentColor
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, cornerRadius)
MainCorner.Parent = MainFrame

local DragPanel = Instance.new("Frame")
DragPanel.Size = UDim2.new(1, 0, 0, 35)
DragPanel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
DragPanel.BorderSizePixel = 0
DragPanel.Parent = MainFrame

local DragCorner = Instance.new("UICorner")
DragCorner.CornerRadius = UDim.new(0, cornerRadius)
DragCorner.Parent = DragPanel

local HideCornerFix = Instance.new("Frame")
HideCornerFix.Size = UDim2.new(1, 0, 0, 10)
HideCornerFix.Position = UDim2.new(0, 0, 1, -10)
HideCornerFix.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
HideCornerFix.BorderSizePixel = 0
HideCornerFix.Parent = DragPanel

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -20, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = menuName
TitleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = textSize
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = DragPanel

local SeparatorLine = Instance.new("Frame")
SeparatorLine.Size = UDim2.new(0, 1, 1, -35)
SeparatorLine.Position = UDim2.new(0, 160, 0, 35)
SeparatorLine.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SeparatorLine.BorderSizePixel = 0
SeparatorLine.Parent = MainFrame

-- ВКЛАДКИ
local PlayerTab = Instance.new("Frame")
PlayerTab.Size = UDim2.new(1, -161, 1, -35)
PlayerTab.Position = UDim2.new(0, 161, 0, 35)
PlayerTab.BackgroundTransparency = 1
PlayerTab.Visible = true
PlayerTab.Parent = MainFrame

local ProtectTab = Instance.new("Frame")
ProtectTab.Size = UDim2.new(1, -161, 1, -35)
ProtectTab.Position = UDim2.new(0, 161, 0, 35)
ProtectTab.BackgroundTransparency = 1
ProtectTab.Visible = false
ProtectTab.Parent = MainFrame

local AttackTab = Instance.new("Frame")
AttackTab.Size = UDim2.new(1, -161, 1, -35)
AttackTab.Position = UDim2.new(0, 161, 0, 35)
AttackTab.BackgroundTransparency = 1
AttackTab.Visible = false
AttackTab.Parent = MainFrame

local AutomationTab = Instance.new("Frame")
AutomationTab.Size = UDim2.new(1, -161, 1, -35)
AutomationTab.Position = UDim2.new(0, 161, 0, 35)
AutomationTab.BackgroundTransparency = 1
AutomationTab.Visible = false
AutomationTab.Parent = MainFrame

local ShadersTab = Instance.new("Frame")
ShadersTab.Size = UDim2.new(1, -161, 1, -35)
ShadersTab.Position = UDim2.new(0, 161, 0, 35)
ShadersTab.BackgroundTransparency = 1
ShadersTab.Visible = false
ShadersTab.Parent = MainFrame

local MiscTab = Instance.new("Frame")
MiscTab.Size = UDim2.new(1, -161, 1, -35)
MiscTab.Position = UDim2.new(0, 161, 0, 35)
MiscTab.BackgroundTransparency = 1
MiscTab.Visible = false
MiscTab.Parent = MainFrame

local MenuTab = Instance.new("Frame")
MenuTab.Size = UDim2.new(1, -161, 1, -35)
MenuTab.Position = UDim2.new(0, 161, 0, 35)
MenuTab.BackgroundTransparency = 1
MenuTab.Visible = false
MenuTab.Parent = MainFrame

-- ================= ФУНКЦИИ ДЛЯ UI =================
local function createToggle(parent, text, y, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 350, 0, 26)
	btn.Position = UDim2.new(0.5, -175, 0, y)
	btn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
	btn.Text = text .. ": OFF"
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 12
	btn.Parent = parent
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 5)
	corner.Parent = btn
	local enabled = false
	btn.MouseButton1Click:Connect(function()
		enabled = not enabled
		if enabled then
			btn.BackgroundColor3 = Color3.fromRGB(40, 180, 40)
			btn.Text = text .. ": ON"
		else
			btn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
			btn.Text = text .. ": OFF"
		end
		callback(enabled)
	end)
	return btn
end

local function createSlider(parent, title, y, minVal, maxVal, defaultVal, callback)
	local container = Instance.new("Frame")
	container.Size = UDim2.new(0, 350, 0, 50)
	container.Position = UDim2.new(0.5, -175, 0, y)
	container.BackgroundTransparency = 1
	container.Parent = parent

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 0, 16)
	label.BackgroundTransparency = 1
	label.Text = title .. ": " .. math.floor(defaultVal)
	label.TextColor3 = Color3.fromRGB(240, 240, 240)
	label.Font = Enum.Font.SourceSansSemibold
	label.TextSize = 12
	label.Parent = container

	local bg = Instance.new("Frame")
	bg.Size = UDim2.new(1, 0, 0, 8)
	bg.Position = UDim2.new(0, 0, 0, 20)
	bg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	bg.BorderSizePixel = 0
	bg.Parent = container
	local bgCorner = Instance.new("UICorner")
	bgCorner.CornerRadius = UDim.new(0, 4)
	bgCorner.Parent = bg

	local fill = Instance.new("Frame")
	local pct = (defaultVal - minVal) / (maxVal - minVal)
	fill.Size = UDim2.new(pct, 0, 1, 0)
	fill.BackgroundColor3 = Color3.fromRGB(0, 160, 255)
	fill.BorderSizePixel = 0
	fill.Parent = bg
	local fillCorner = Instance.new("UICorner")
	fillCorner.CornerRadius = UDim.new(0, 4)
	fillCorner.Parent = fill

	local btn = Instance.new("ImageButton")
	btn.Size = UDim2.new(0, 14, 0, 14)
	btn.Position = UDim2.new(pct, -7, 0.5, -7)
	btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	btn.Image = ""
	btn.Parent = bg
	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(1, 0)
	btnCorner.Parent = btn

	local isSliding = false
	btn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then isSliding = true end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then isSliding = false end
	end)
	local function update(mx)
		local bp = bg.AbsolutePosition.X
		local bs = bg.AbsoluteSize.X
		local p = math.clamp((mx - bp) / bs, 0, 1)
		fill.Size = UDim2.new(p, 0, 1, 0)
		btn.Position = UDim2.new(p, -7, 0.5, -7)
		local val = minVal + p * (maxVal - minVal)
		if maxVal <= 10 then val = math.floor(val * 10) / 10
		else val = math.floor(val) end
		label.Text = title .. ": " .. val
		callback(val)
	end
	UserInputService.InputChanged:Connect(function(input)
		if isSliding and input.UserInputType == Enum.UserInputType.MouseMovement then
			update(input.Position.X)
		end
	end)
	bg.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			isSliding = true
			update(UserInputService:GetMouseLocation().X)
		end
	end)
	return container
end

local function createSection(parent, title, y, h)
	local container = Instance.new("Frame")
	container.Size = UDim2.new(0, 360, 0, h)
	container.Position = UDim2.new(0.5, -180, 0, y)
	container.BackgroundTransparency = 1
	container.Parent = parent

	local border = Instance.new("Frame")
	border.Size = UDim2.new(1, 0, 1, 0)
	border.BackgroundTransparency = 1
	border.BorderSizePixel = 2
	border.BorderColor3 = Color3.fromRGB(100, 100, 100)
	border.Parent = container
	local bCorner = Instance.new("UICorner")
	bCorner.CornerRadius = UDim.new(0, 8)
	bCorner.Parent = border

	local lbl = Instance.new("TextLabel")
	lbl.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	lbl.Text = " " .. title .. " "
	lbl.TextColor3 = Color3.fromRGB(200, 200, 200)
	lbl.Font = Enum.Font.SourceSansBold
	lbl.TextSize = 13
	lbl.Position = UDim2.new(0, 15, 0, -10)
	lbl.AutomaticSize = Enum.AutomaticSize.X
	lbl.Size = UDim2.new(0, 0, 0, 20)
	lbl.Parent = container
	local lCorner = Instance.new("UICorner")
	lCorner.CornerRadius = UDim.new(0, 4)
	lCorner.Parent = lbl
	return container
end

-- ================= PLAYER TAB =================
local pScroll = Instance.new("ScrollingFrame")
pScroll.Size = UDim2.new(1, 0, 1, 0)
pScroll.BackgroundTransparency = 1
pScroll.ScrollBarThickness = 4
pScroll.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
pScroll.CanvasSize = UDim2.new(0, 0, 0, 340)
pScroll.Parent = PlayerTab

-- WalkSpeed
createToggle(pScroll, "WalkSpeed Changer", 5, function(e)
	wsEnabled = e
	if not e and LocalPlayer.Character then
		local h = LocalPlayer.Character:FindFirstChild("Humanoid")
		if h then h.WalkSpeed = 16 end
	end
end)
createSlider(pScroll, "WalkSpeed", 34, 16, 500, 16, function(v) wsValue = v end)

-- JumpPower
createToggle(pScroll, "JumpPower Changer", 87, function(e)
	jpEnabled = e
	if not e and LocalPlayer.Character then
		local h = LocalPlayer.Character:FindFirstChild("Humanoid")
		if h then h.JumpPower = 50 end
	end
end)
createSlider(pScroll, "JumpPower", 116, 50, 500, 50, function(v) jpValue = v end)

createToggle(pScroll, "Infinite Jump", 169, function(e)
	infiniteJumpEnabled = e
	if e then
		infiniteJumpConnection = UserInputService.JumpRequest:Connect(function()
			local c = LocalPlayer.Character
			if c then
				local h = c:FindFirstChild("Humanoid")
				if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
			end
		end)
	else
		if infiniteJumpConnection then infiniteJumpConnection:Disconnect(); infiniteJumpConnection = nil end
	end
end)

createToggle(pScroll, "Noclip", 198, function(e)
	noclipEnabled = e
	if e then
		noclipConnection = RunService.Stepped:Connect(function()
			if LocalPlayer.Character then
				for _, p in ipairs(LocalPlayer.Character:GetDescendants()) do
					if p:IsA("BasePart") then p.CanCollide = false end
				end
			end
		end)
	else
		if noclipConnection then noclipConnection:Disconnect(); noclipConnection = nil end
		if LocalPlayer.Character then
			for _, p in ipairs(LocalPlayer.Character:GetDescendants()) do
				if p:IsA("BasePart") then p.CanCollide = true end
			end
		end
	end
end)

createToggle(pScroll, "Reach Mod", 227, function(e) reachEnabled = e end)
createSlider(pScroll, "Reach", 256, 8, 1000, 8, function(v) reachValue = v end)

-- ================= PROTECT TAB =================
local prScroll = Instance.new("ScrollingFrame")
prScroll.Size = UDim2.new(1, 0, 1, 0)
prScroll.BackgroundTransparency = 1
prScroll.ScrollBarThickness = 4
prScroll.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
prScroll.CanvasSize = UDim2.new(0, 0, 0, 240)
prScroll.Parent = ProtectTab

createToggle(prScroll, "Anti-Grab", 5, function(e) antiGrabEnabled = e end)
createToggle(prScroll, "Anti-Burn", 34, function(e) antiBurnEnabled = e end)
createToggle(prScroll, "Anti-Fling", 63, function(e) antiFlingEnabled = e end)
createToggle(prScroll, "Anti-Kick", 92, function(e)
	antiKickEnabled = e
	if e then spawnAntiKick() else removeAntiKick() end
end)
createToggle(prScroll, "Gucci Anti-Grab", 121, function(e) gucciAntiGrabEnabled = e end)
createToggle(prScroll, "Anti-Stun", 150, function(e) antiStunEnabled = e end)
createToggle(prScroll, "Anti-Kill", 179, function(e)
	antiKillEnabled = e
	if e then startAntiKill() else stopAntiKill() end
end)
createToggle(prScroll, "Anti-Bring", 208, function(e)
	antiBringEnabled = e
	if e then startAntiBring() else stopAntiBring() end
end)

-- ================= ATTACK TAB =================
local aScroll = Instance.new("ScrollingFrame")
aScroll.Size = UDim2.new(1, 0, 1, 0)
aScroll.BackgroundTransparency = 1
aScroll.ScrollBarThickness = 4
aScroll.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
aScroll.CanvasSize = UDim2.new(0, 0, 0, 180)
aScroll.Parent = AttackTab

createToggle(aScroll, "Super Strength", 5, function(e) superStrengthEnabled = e end)
createToggle(aScroll, "Kill Grab", 34, function(e) killGrabEnabled = e end)
createToggle(aScroll, "Kick Grab", 63, function(e) kickGrabEnabled = e end)
createSlider(aScroll, "Fling Strength", 92, 250, 2500, 1000, function(v) flingStrength = v end)

local lagBtn = Instance.new("TextButton")
lagBtn.Size = UDim2.new(0, 350, 0, 26)
lagBtn.Position = UDim2.new(0.5, -175, 0, 145)
lagBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
lagBtn.Text = "Lag Server (Coming Soon)"
lagBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
lagBtn.Font = Enum.Font.SourceSansBold
lagBtn.TextSize = 12
lagBtn.Parent = aScroll
local lagCorner = Instance.new("UICorner")
lagCorner.CornerRadius = UDim.new(0, 5)
lagCorner.Parent = lagBtn

-- ================= AUTOMATION TAB =================
local auScroll = Instance.new("ScrollingFrame")
auScroll.Size = UDim2.new(1, 0, 1, 0)
auScroll.BackgroundTransparency = 1
auScroll.ScrollBarThickness = 4
auScroll.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
auScroll.CanvasSize = UDim2.new(0, 0, 0, 290)
auScroll.Parent = AutomationTab

createToggle(auScroll, "Auto Fling All", 5, function(e)
	autoFlingAllEnabled = e
	if e then startAutoFlingAll() else stopAutoFlingAll() end
end)
createToggle(auScroll, "Auto Grab", 34, function(e)
	autoGrabEnabled = e
	if e then startAutoGrab() else stopAutoGrab() end
end)
createToggle(auScroll, "Auto Bring Items", 63, function(e)
	autoBringItemsEnabled = e
	if e then startAutoBringItems() else stopAutoBringItems() end
end)
createSlider(auScroll, "Fling Delay", 92, 0.1, 2, 0.3, function(v) autoFlingDelay = v end)
createSlider(auScroll, "Grab Radius", 145, 10, 200, 50, function(v) autoGrabRadius = v end)
createSlider(auScroll, "Bring Height", 198, 1, 20, 5, function(v) bringItemsHeight = v end)

-- ================= SHADERS TAB =================
local sScroll = Instance.new("ScrollingFrame")
sScroll.Size = UDim2.new(1, 0, 1, 0)
sScroll.BackgroundTransparency = 1
sScroll.ScrollBarThickness = 4
sScroll.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
sScroll.CanvasSize = UDim2.new(0, 0, 0, 370)
sScroll.Parent = ShadersTab

local timeBlock = createSection(sScroll, "Time Of Day", 10, 160)
local timeData = {
	{"Day", 12, 3, Color3.fromRGB(200, 200, 200), Color3.fromRGB(180, 210, 255), 10000},
	{"Sunset", 18, 1.5, Color3.fromRGB(255, 150, 80), Color3.fromRGB(255, 120, 50), 5000},
	{"Night", 0, 0.5, Color3.fromRGB(50, 50, 100), Color3.fromRGB(30, 30, 60), 3000},
	{"Sunrise", 6, 1.5, Color3.fromRGB(255, 200, 150), Color3.fromRGB(255, 180, 120), 7000}
}
for i, d in ipairs(timeData) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 320, 0, 26)
	btn.Position = UDim2.new(0, 20, 0, 25 + (i-1)*32)
	btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	btn.Text = d[1]
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 12
	btn.Parent = timeBlock
	local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 5); c.Parent = btn
	btn.MouseButton1Click:Connect(function()
		currentTimeOfDay = d[1]
		Lighting.ClockTime = d[2]
		Lighting.Brightness = d[3]
		Lighting.OutdoorAmbient = d[4]
		Lighting.FogColor = d[5]
		Lighting.FogEnd = d[6]
		for _, ch in ipairs(timeBlock:GetChildren()) do
			if ch:IsA("TextButton") then ch.BackgroundColor3 = Color3.fromRGB(60, 60, 60) end
		end
		btn.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
	end)
end

local seasonBlock = createSection(sScroll, "Season", 185, 160)
local seasonData = {
	{"Winter", Color3.fromRGB(200, 210, 230), Color3.fromRGB(230, 235, 245), 4000, 2},
	{"Spring", Color3.fromRGB(180, 220, 180), Color3.fromRGB(200, 240, 200), 8000, 2.5},
	{"Summer", Color3.fromRGB(255, 240, 200), Color3.fromRGB(255, 255, 200), 15000, 3},
	{"Autumn", Color3.fromRGB(220, 180, 140), Color3.fromRGB(200, 150, 100), 6000, 1.8}
}
for i, d in ipairs(seasonData) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 320, 0, 26)
	btn.Position = UDim2.new(0, 20, 0, 25 + (i-1)*32)
	btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	btn.Text = d[1]
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 12
	btn.Parent = seasonBlock
	local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 5); c.Parent = btn
	btn.MouseButton1Click:Connect(function()
		currentSeason = d[1]
		Lighting.OutdoorAmbient = d[2]
		Lighting.FogColor = d[3]
		Lighting.FogEnd = d[4]
		Lighting.Brightness = d[5]
		for _, ch in ipairs(seasonBlock:GetChildren()) do
			if ch:IsA("TextButton") then ch.BackgroundColor3 = Color3.fromRGB(60, 60, 60) end
		end
		btn.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
	end)
end

-- ================= MISC TAB =================
local mScroll = Instance.new("ScrollingFrame")
mScroll.Size = UDim2.new(1, 0, 1, 0)
mScroll.BackgroundTransparency = 1
mScroll.ScrollBarThickness = 4
mScroll.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
mScroll.CanvasSize = UDim2.new(0, 0, 0, 280)
mScroll.Parent = MiscTab

createSlider(mScroll, "FOV", 5, 30, 120, Camera.FieldOfView, function(v) Camera.FieldOfView = v end)
createToggle(mScroll, "Walk Water", 58, function(e)
	walkWaterEnabled = e
	if e then
		for _, p in ipairs(Workspace:GetDescendants()) do
			if p:IsA("BasePart") and p.Material == Enum.Material.Water then
				p.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 100, 0)
			end
		end
	else
		for _, p in ipairs(Workspace:GetDescendants()) do
			if p:IsA("BasePart") and p.Material == Enum.Material.Water then
				p.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
			end
		end
	end
end)

-- ESP
local espTitle = Instance.new("TextLabel")
espTitle.Size = UDim2.new(0, 350, 0, 18)
espTitle.Position = UDim2.new(0.5, -175, 0, 88)
espTitle.BackgroundTransparency = 1
espTitle.Text = "ESP Player Highlight"
espTitle.TextColor3 = Color3.fromRGB(255, 100, 100)
espTitle.Font = Enum.Font.SourceSansBold
espTitle.TextSize = 13
espTitle.Parent = mScroll

local espDrop = Instance.new("TextButton")
espDrop.Size = UDim2.new(0, 350, 0, 28)
espDrop.Position = UDim2.new(0.5, -175, 0, 110)
espDrop.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
espDrop.Text = "Выберите игрока..."
espDrop.TextColor3 = Color3.fromRGB(200, 200, 200)
espDrop.Font = Enum.Font.SourceSans
espDrop.TextSize = 12
espDrop.TextXAlignment = Enum.TextXAlignment.Left
espDrop.Parent = mScroll
local dCorner = Instance.new("UICorner"); dCorner.CornerRadius = UDim.new(0, 5); dCorner.Parent = espDrop

local espList = Instance.new("ScrollingFrame")
espList.Size = UDim2.new(0, 350, 0, 100)
espList.Position = UDim2.new(0.5, -175, 0, 140)
espList.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
espList.BorderSizePixel = 1
espList.BorderColor3 = Color3.fromRGB(60, 60, 60)
espList.Visible = false
espList.ScrollBarThickness = 4
espList.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
espList.CanvasSize = UDim2.new(0, 0, 0, 0)
espList.Parent = mScroll
local lCorner = Instance.new("UICorner"); lCorner.CornerRadius = UDim.new(0, 5); lCorner.Parent = espList
local lLayout = Instance.new("UIListLayout"); lLayout.Padding = UDim.new(0, 2); lLayout.Parent = espList

local function updateESPList()
	for _, c in ipairs(espList:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
	local th = 0
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LocalPlayer then
			local btn = Instance.new("TextButton")
			btn.Size = UDim2.new(1, -4, 0, 24)
			btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			btn.Text = p.Name
			btn.TextColor3 = Color3.fromRGB(230, 230, 230)
			btn.Font = Enum.Font.SourceSans; btn.TextSize = 12; btn.TextXAlignment = Enum.TextXAlignment.Left
			btn.Parent = espList
			local bc = Instance.new("UICorner"); bc.CornerRadius = UDim.new(0, 4); bc.Parent = btn
			btn.MouseButton1Click:Connect(function()
				selectedESPPlayer = p
				espDrop.Text = "ESP: " .. p.Name
				espList.Visible = false
			end)
			th = th + 26
		end
	end
	espList.CanvasSize = UDim2.new(0, 0, 0, th)
end
updateESPList()

espDrop.MouseButton1Click:Connect(function() updateESPList(); espList.Visible = not espList.Visible end)

local espToggle = Instance.new("TextButton")
espToggle.Size = UDim2.new(0, 350, 0, 26)
espToggle.Position = UDim2.new(0.5, -175, 0, 140)
espToggle.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
espToggle.Text = "ESP: OFF"
espToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
espToggle.Font = Enum.Font.SourceSansBold; espToggle.TextSize = 12
espToggle.Parent = mScroll
local etCorner = Instance.new("UICorner"); etCorner.CornerRadius = UDim.new(0, 5); etCorner.Parent = espToggle

espToggle.MouseButton1Click:Connect(function()
	espEnabled = not espEnabled
	if espEnabled then
		if not selectedESPPlayer then
			espToggle.Text = "ESP: ON (No target!)"
			espToggle.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
		else
			espToggle.Text = "ESP: ON (" .. selectedESPPlayer.Name .. ")"
			espToggle.BackgroundColor3 = Color3.fromRGB(40, 180, 40)
		end
		startESP()
	else
		espToggle.Text = "ESP: OFF"
		espToggle.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
		stopESP()
	end
end)

UserInputService.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 and espList.Visible then
		local mp = UserInputService:GetMouseLocation()
		if not (mp.X >= espList.AbsolutePosition.X and mp.X <= espList.AbsolutePosition.X + espList.AbsoluteSize.X and
			mp.Y >= espList.AbsolutePosition.Y and mp.Y <= espList.AbsolutePosition.Y + espList.AbsoluteSize.Y) and
		   not (mp.X >= espDrop.AbsolutePosition.X and mp.X <= espDrop.AbsolutePosition.X + espDrop.AbsoluteSize.X and
			mp.Y >= espDrop.AbsolutePosition.Y and mp.Y <= espDrop.AbsolutePosition.Y + espDrop.AbsoluteSize.Y) then
			espList.Visible = false
		end
	end
end)

function startESP()
	stopESP()
	espConnection = RunService.RenderStepped:Connect(function()
		if not espEnabled or not selectedESPPlayer or not selectedESPPlayer.Character then return end
		local char = selectedESPPlayer.Character
		for _, part in ipairs(char:GetDescendants()) do
			if part:IsA("BasePart") then
				part.BrickColor = BrickColor.new("Bright red")
				part.Transparency = 0.5
				part.Material = Enum.Material.ForceField
			end
		end
		local root = char:FindFirstChild("HumanoidRootPart")
		if root and not root:FindFirstChild("ESPBox") then
			local box = Instance.new("SelectionBox")
			box.Name = "ESPBox"
			box.Adornee = root
			box.Color3 = Color3.fromRGB(255, 50, 50)
			box.Transparency = 0.6
			box.LineThickness = 0.05
			box.Parent = root
		end
	end)
end

function stopESP()
	if espConnection then espConnection:Disconnect(); espConnection = nil end
	for _, player in ipairs(Players:GetPlayers()) do
		if player.Character then
			for _, part in ipairs(player.Character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.Transparency = 0
					part.Material = Enum.Material.Plastic
				end
			end
			local root = player.Character:FindFirstChild("HumanoidRootPart")
			if root then
				local box = root:FindFirstChild("ESPBox")
				if box then box:Destroy() end
			end
		end
	end
end

-- ================= MENU TAB =================
local muScroll = Instance.new("ScrollingFrame")
muScroll.Size = UDim2.new(1, 0, 1, 0)
muScroll.BackgroundTransparency = 1
muScroll.ScrollBarThickness = 4
muScroll.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
muScroll.CanvasSize = UDim2.new(0, 0, 0, 750)
muScroll.Parent = MenuTab

createSlider(muScroll, "Scale Menu", 5, 0.5, 2, 1, function(v)
	menuScale = v
	MainFrame.Size = UDim2.new(0, 550*menuScale, 0, 420*menuScale)
	MainFrame.Position = UDim2.new(0.5, -275*menuScale, 0.5, -210*menuScale)
end)

local colTitle = Instance.new("TextLabel")
colTitle.Size = UDim2.new(0, 350, 0, 18)
colTitle.Position = UDim2.new(0.5, -175, 0, 58)
colTitle.BackgroundTransparency = 1
colTitle.Text = "Change Color"
colTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
colTitle.Font = Enum.Font.SourceSansBold; colTitle.TextSize = 13
colTitle.Parent = muScroll

local colNames = {"Red", "Blue", "Green", "Pink", "Purple", "White", "Brown", "Rainbow Gradient"}
for i, name in ipairs(colNames) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 170, 0, 22)
	btn.Position = UDim2.new(0.5, -175 + ((i-1)%2)*175, 0, 80 + math.floor((i-1)/2)*26)
	btn.Text = name
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.SourceSansBold; btn.TextSize = 10
	btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	btn.Parent = muScroll
	local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 4); c.Parent = btn
	btn.MouseButton1Click:Connect(function()
		selectedColorName = name
		if name == "Rainbow Gradient" then
			local g = Instance.new("UIGradient")
			g.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255,0,0)),
				ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255,255,0)),
				ColorSequenceKeypoint.new(0.4, Color3.fromRGB(0,255,0)),
				ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0,255,255)),
				ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0,0,255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(255,0,255))
			})
			g.Parent = MainFrame
			for _, ch in ipairs(MainFrame:GetChildren()) do if ch:IsA("UIGradient") and ch ~= g then ch:Destroy() end end
		else
			for _, ch in ipairs(MainFrame:GetChildren()) do if ch:IsA("UIGradient") then ch:Destroy() end end
			currentColor = colors[name]
			local r = math.clamp(currentColor.R * brightnessMultiplier, 0, 1)
			local g = math.clamp(currentColor.G * brightnessMultiplier, 0, 1)
			local b = math.clamp(currentColor.B * brightnessMultiplier, 0, 1)
			MainFrame.BackgroundColor3 = Color3.new(r, g, b)
		end
	end)
end

createSlider(muScroll, "Brightness", 190, 0, 1, 1, function(v)
	brightnessMultiplier = v
	if selectedColorName ~= "Rainbow Gradient" then
		local r = math.clamp(currentColor.R * brightnessMultiplier, 0, 1)
		local g = math.clamp(currentColor.G * brightnessMultiplier, 0, 1)
		local b = math.clamp(currentColor.B * brightnessMultiplier, 0, 1)
		MainFrame.BackgroundColor3 = Color3.new(r, g, b)
	end
end)

local nameCont = Instance.new("Frame")
nameCont.Size = UDim2.new(0, 350, 0, 45)
nameCont.Position = UDim2.new(0.5, -175, 0, 245)
nameCont.BackgroundTransparency = 1
nameCont.Parent = muScroll
local nameT = Instance.new("TextLabel")
nameT.Size = UDim2.new(1, 0, 0, 16)
nameT.BackgroundTransparency = 1
nameT.Text = "Change Name (Solar)"
nameT.TextColor3 = Color3.fromRGB(240, 240, 240)
nameT.Font = Enum.Font.SourceSansSemibold; nameT.TextSize = 12
nameT.Parent = nameCont
local nameInp = Instance.new("TextBox")
nameInp.Size = UDim2.new(0, 190, 0, 26)
nameInp.Position = UDim2.new(0, 0, 0, 19)
nameInp.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
nameInp.PlaceholderText = "Enter new name..."
nameInp.TextColor3 = Color3.fromRGB(255, 255, 255)
nameInp.Font = Enum.Font.SourceSans; nameInp.TextSize = 12
nameInp.Parent = nameCont
local niCorner = Instance.new("UICorner"); niCorner.CornerRadius = UDim.new(0, 4); niCorner.Parent = nameInp
local nameApply = Instance.new("TextButton")
nameApply.Size = UDim2.new(0, 75, 0, 26)
nameApply.Position = UDim2.new(0, 200, 0, 19)
nameApply.BackgroundColor3 = Color3.fromRGB(0, 140, 200)
nameApply.Text = "Apply"
nameApply.TextColor3 = Color3.fromRGB(255, 255, 255)
nameApply.Font = Enum.Font.SourceSansBold; nameApply.TextSize = 12
nameApply.Parent = nameCont
local naCorner = Instance.new("UICorner"); naCorner.CornerRadius = UDim.new(0, 4); naCorner.Parent = nameApply
nameApply.MouseButton1Click:Connect(function()
	if nameInp.Text ~= "" then
		menuName = nameInp.Text .. " (Solar)"
		TitleLabel.Text = menuName
		nameInp.Text = ""
	end
end)

createSlider(muScroll, "Transparency", 295, 0, 1, 0, function(v)
	menuTransparency = v
	MainFrame.BackgroundTransparency = menuTransparency
	DragPanel.BackgroundTransparency = menuTransparency * 0.5
end)
createSlider(muScroll, "Corner Radius", 348, 0, 30, 12, function(v)
	cornerRadius = v
	MainCorner.CornerRadius = UDim.new(0, cornerRadius)
	DragCorner.CornerRadius = UDim.new(0, cornerRadius)
end)
createSlider(muScroll, "Text Size", 401, 8, 38, 16, function(v)
	textSize = v
	TitleLabel.TextSize = textSize
end)

-- ================= НАВИГАЦИЯ =================
local function createNav(name, y, tab, all)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 140, 0, 28)
	btn.Position = UDim2.new(0, 10, 0, y)
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.Text = name
	btn.TextColor3 = Color3.fromRGB(240, 240, 240)
	btn.Font = Enum.Font.SourceSansSemibold; btn.TextSize = 13
	btn.Parent = MainFrame
	local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 5); c.Parent = btn
	btn.MouseButton1Click:Connect(function()
		PlayerTab.Visible = false; ProtectTab.Visible = false; AttackTab.Visible = false
		AutomationTab.Visible = false; ShadersTab.Visible = false; MiscTab.Visible = false; MenuTab.Visible = false
		tab.Visible = true
		for _, b in ipairs(all) do b.BackgroundColor3 = Color3.fromRGB(50, 50, 50) end
		btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	end)
	return btn
end

local navs = {}
navs[1] = createNav("Player", 50, PlayerTab, navs)
navs[2] = createNav("Protect", 82, ProtectTab, navs)
navs[3] = createNav("Attack", 114, AttackTab, navs)
navs[4] = createNav("Automation", 146, AutomationTab, navs)
navs[5] = createNav("Shaders", 178, ShadersTab, navs)
navs[6] = createNav("Misc", 210, MiscTab, navs)
navs[7] = createNav("Menu", 242, MenuTab, navs)
navs[1].BackgroundColor3 = Color3.fromRGB(70, 70, 70)

-- Bind
local bindBtn = Instance.new("TextButton")
bindBtn.Size = UDim2.new(0, 140, 0, 28)
bindBtn.Position = UDim2.new(0, 10, 0, 274)
bindBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
bindBtn.Text = "Bind: " .. toggleKey.Name
bindBtn.TextColor3 = Color3.fromRGB(240, 240, 240)
bindBtn.Font = Enum.Font.SourceSansSemibold; bindBtn.TextSize = 13
bindBtn.Parent = MainFrame
local biCorner = Instance.new("UICorner"); biCorner.CornerRadius = UDim.new(0, 5); biCorner.Parent = bindBtn
bindBtn.MouseButton1Click:Connect(function()
	if not isListeningForKey then isListeningForKey = true; bindBtn.Text = "Press any key..." end
end)

-- Профиль
local pf = Instance.new("Frame")
pf.Size = UDim2.new(0, 150, 0, 55)
pf.Position = UDim2.new(0, 10, 1, -65)
pf.BackgroundTransparency = 1
pf.Parent = MainFrame
local av = Instance.new("ImageLabel")
av.Size = UDim2.new(0, 40, 0, 40)
av.Position = UDim2.new(0, 0, 0.5, -20)
av.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
av.BorderSizePixel = 0
av.Image = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size100x100)
av.Parent = pf
local avCorner = Instance.new("UICorner"); avCorner.CornerRadius = UDim.new(0.5, 0); avCorner.Parent = av
local un = Instance.new("TextLabel")
un.Size = UDim2.new(1, -48, 1, 0)
un.Position = UDim2.new(0, 48, 0, 0)
un.BackgroundTransparency = 1
un.Text = LocalPlayer.Name
un.TextColor3 = Color3.fromRGB(235, 235, 235)
un.TextXAlignment = Enum.TextXAlignment.Left
un.Font = Enum.Font.SourceSansBold; un.TextSize = 14
un.Parent = pf

-- Скрытие меню
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if isListeningForKey then
		if input.UserInputType == Enum.UserInputType.Keyboard then
			toggleKey = input.KeyCode; isListeningForKey = false; bindBtn.Text = "Bind: " .. toggleKey.Name
		end
	elseif input.KeyCode == toggleKey then
		MainFrame.Visible = not MainFrame.Visible
	end
end)

-- ================= ЗАЩИТА =================
function spawnAntiKick()
	local char = LocalPlayer.Character; if not char then return end
	local s = Instance.new("Part")
	s.Name = "AntiKickShuriken"; s.Size = Vector3.new(0.5, 0.5, 0.5)
	s.CanCollide = false; s.Anchored = false; s.Parent = Workspace
	local leg = char:FindFirstChild("RightFoot") or char:FindFirstChild("RightLowerLeg")
	if leg then
		local w = Instance.new("WeldConstraint"); w.Part0 = s; w.Part1 = leg; w.Parent = s
	end
	antiKickShuriken = s
	antiKickConnection = RunService.Heartbeat:Connect(function()
		if not antiKickShuriken or not antiKickShuriken.Parent then
			removeAntiKick()
			if antiKickEnabled then spawnAntiKick() end
		end
	end)
end
function removeAntiKick()
	if antiKickConnection then antiKickConnection:Disconnect(); antiKickConnection = nil end
	if antiKickShuriken then antiKickShuriken:Destroy(); antiKickShuriken = nil end
end
function startAntiKill()
	antiKillConnection = RunService.Heartbeat:Connect(function()
		local char = LocalPlayer.Character; if not char then return end
		local head = char:FindFirstChild("Head")
		local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
		if head and torso then
			if (head.Position - torso.Position).Magnitude > 5 then head.CFrame = torso.CFrame * CFrame.new(0, 2, 0) end
			if not torso:FindFirstChild("Neck") then
				local n = Instance.new("Motor6D"); n.Name = "Neck"; n.Part0 = torso; n.Part1 = head
				n.C0 = CFrame.new(0, 1, 0); n.C1 = CFrame.new(0, -0.5, 0); n.Parent = torso
			end
		end
	end)
end
function stopAntiKill()
	if antiKillConnection then antiKillConnection:Disconnect(); antiKillConnection = nil end
end
function startAntiBring()
	antiBringConnection = RunService.Heartbeat:Connect(function()
		local char = LocalPlayer.Character; if not char then return end
		local root = char:FindFirstChild("HumanoidRootPart"); if not root then return end
		if lastStablePosition and (root.Position - lastStablePosition.Position).Magnitude > 100 then
			root.CFrame = lastStablePosition; root.Velocity = Vector3.zero
		end
	end)
end
function stopAntiBring()
	if antiBringConnection then antiBringConnection:Disconnect(); antiBringConnection = nil end
end

-- ================= АВТОМАТИЗАЦИЯ =================
function startAutoFlingAll()
	autoFlingConnection = RunService.Heartbeat:Connect(function()
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= LocalPlayer and p.Character then
				local r = p.Character:FindFirstChild("HumanoidRootPart")
				if r then
					local bv = Instance.new("BodyVelocity"); bv.MaxForce = Vector3.new(1,1,1)*math.huge
					bv.Velocity = Vector3.new(0, 10000, 0); bv.P = math.huge; bv.Parent = r
					Debris:AddItem(bv, 0.5)
				end
			end
		end
		task.wait(autoFlingDelay)
	end)
end
function stopAutoFlingAll()
	if autoFlingConnection then autoFlingConnection:Disconnect(); autoFlingConnection = nil end
end
function startAutoGrab()
	autoGrabConnection = RunService.Heartbeat:Connect(function()
		local char = LocalPlayer.Character; if not char then return end
		local root = char:FindFirstChild("HumanoidRootPart"); if not root then return end
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= LocalPlayer and p.Character then
				local tr = p.Character:FindFirstChild("HumanoidRootPart")
				if tr and (tr.Position - root.Position).Magnitude <= autoGrabRadius then
					local ex = false
					for _, c in ipairs(char:GetChildren()) do
						if c:IsA("WeldConstraint") and c.Part1 == tr then ex = true; break end
					end
					if not ex then
						local w = Instance.new("WeldConstraint"); w.Part0 = root; w.Part1 = tr; w.Parent = char
					end
				end
			end
		end
		for _, obj in ipairs(Workspace:GetDescendants()) do
			if obj:IsA("BasePart") and obj.CanCollide and not obj.Anchored then
				if (obj.Position - root.Position).Magnitude <= autoGrabRadius then
					local w = Instance.new("WeldConstraint"); w.Part0 = root; w.Part1 = obj; w.Parent = char
				end
			end
		end
	end)
end
function stopAutoGrab()
	if autoGrabConnection then autoGrabConnection:Disconnect(); autoGrabConnection = nil end
end
function startAutoBringItems()
	autoBringConnection = RunService.Heartbeat:Connect(function()
		local char = LocalPlayer.Character; if not char then return end
		local root = char:FindFirstChild("HumanoidRootPart"); if not root then return end
		local cp = root.Position + root.CFrame.LookVector * 10 + Vector3.new(0, bringItemsHeight, 0)
		for _, obj in ipairs(Workspace:GetDescendants()) do
			if obj:IsA("BasePart") and not obj.Anchored and obj.CanCollide then
				if not obj.Parent:FindFirstChildOfClass("Humanoid") and obj.Parent ~= char then
					obj.CFrame = cp + Vector3.new(math.random(-3,3), math.random(-1,1), math.random(-3,3))
				end
			end
		end
	end)
end
function stopAutoBringItems()
	if autoBringConnection then autoBringConnection:Disconnect(); autoBringConnection = nil end
end

-- ================= СУПЕР СИЛА =================
Workspace.ChildAdded:Connect(function(model)
	if model.Name == "GrabParts" and superStrengthEnabled then
		local part = model:FindFirstChild("GrabPart")
		if part then
			local weld = part:FindFirstChild("WeldConstraint")
			if weld and weld.Part1 then
				local target = weld.Part1
				local bv = Instance.new("BodyVelocity", target)
				model:GetPropertyChangedSignal("Parent"):Connect(function()
					if not model.Parent then
						if UserInputService:GetLastInputType() == Enum.UserInputType.MouseButton2 then
							bv.MaxForce = Vector3.new(1,1,1)*math.huge
							bv.Velocity = Camera.CFrame.LookVector * flingStrength
							Debris:AddItem(bv, 1)
						else bv:Destroy() end
					end
				end)
			end
		end
	end
end)

-- ================= ГЛАВНЫЙ ЦИКЛ =================
RunService.Heartbeat:Connect(function()
	local char = LocalPlayer.Character; if not char then return end
	local root = char:FindFirstChild("HumanoidRootPart"); if not root then return end
	if root.Velocity.Magnitude < 10 then lastStablePosition = root.CFrame end

	if wsEnabled then
		local h = char:FindFirstChild("Humanoid"); if h then h.WalkSpeed = wsValue end
	end
	if jpEnabled then
		local h = char:FindFirstChild("Humanoid"); if h then h.JumpPower = jpValue end
	end

	-- Protect
	if antiGrabEnabled then
		for _, c in ipairs(char:GetChildren()) do
			if (c:IsA("WeldConstraint") or c:IsA("RopeConstraint")) and c.Part1 and c.Part1 ~= root then
				local tp = Players:GetPlayerFromCharacter(c.Part1.Parent)
				if tp and tp ~= LocalPlayer then
					local orig = root.CFrame; root.CFrame = root.CFrame + Vector3.new(0, 500, 0)
					task.wait(); root.CFrame = orig; c:Destroy()
				end
			end
		end
	end
	if antiBurnEnabled then
		for _, p in ipairs(char:GetDescendants()) do
			if p:IsA("BasePart") and p:FindFirstChild("Fire") then
				local ext = Instance.new("Part"); ext.Size = Vector3.new(2,2,2)
				ext.CFrame = char:FindFirstChild("HumanoidRootPart").CFrame
				ext.Anchored = true; ext.CanCollide = false; ext.Transparency = 1; ext.Parent = Workspace
				for _, f in ipairs(p:GetChildren()) do if f:IsA("Fire") then f:Destroy() end end
				task.wait(0.5); ext.CFrame = CFrame.new(0,-500,0); task.wait(0.1); ext:Destroy()
			end
		end
	end
	if antiFlingEnabled and lastStablePosition and root.Velocity.Magnitude > 50 then
		root.CFrame = lastStablePosition; root.Velocity = Vector3.zero
	end
	if gucciAntiGrabEnabled then
		local hum = char:FindFirstChild("Humanoid")
		for _, c in ipairs(char:GetChildren()) do
			if c:IsA("WeldConstraint") and c.Part1 and c.Part1 ~= root then
				local tp = Players:GetPlayerFromCharacter(c.Part1.Parent)
				if tp and tp ~= LocalPlayer then
					local blob = Instance.new("Part"); blob.Size = Vector3.new(4,1,4)
					blob.CFrame = root.CFrame + Vector3.new(0,300,0)
					blob.Anchored = true; blob.CanCollide = true; blob.Transparency = 1; blob.Parent = Workspace
					local orig = root.CFrame; root.CFrame = blob.CFrame * CFrame.new(0,2,0)
					if hum then task.wait(0.1); hum.Sit = true; task.wait(0.1); hum.Sit = false; task.wait(0.1) end
					root.CFrame = orig; blob:Destroy()
				end
			end
		end
	end
	if antiStunEnabled then
		local hum = char:FindFirstChild("Humanoid")
		if hum and hum:GetState() == Enum.HumanoidStateType.Physics and lastStablePosition then
			root.CFrame = lastStablePosition; root.Velocity = Vector3.zero
		end
	end

	-- Attack
	if killGrabEnabled then
		for _, c in ipairs(char:GetChildren()) do
			if c:IsA("WeldConstraint") and c.Part1 and c.Part1 ~= root then
				local tp = Players:GetPlayerFromCharacter(c.Part1.Parent)
				if tp and tp ~= LocalPlayer then
					local orig = root.CFrame; local water = CFrame.new(0,-10,0)
					root.CFrame = water; c.Part1.CFrame = water; c:Destroy()
					task.wait(0.5); root.CFrame = orig
				end
			end
		end
	end
	if kickGrabEnabled then
		for _, c in ipairs(char:GetChildren()) do
			if c:IsA("WeldConstraint") and c.Part1 and c.Part1 ~= root then
				local tp = Players:GetPlayerFromCharacter(c.Part1.Parent)
				if tp and tp ~= LocalPlayer then
					local tr = c.Part1; local th = tp.Character and tp.Character:FindFirstChild("Humanoid")
					if th then
						th.PlatformStand = true; tr.Velocity = Vector3.zero; tr.Anchored = true
						task.wait(2); tr.Anchored = false; th.PlatformStand = false
					end
				end
			end
		end
	end
end)

-- ================= ПЕРЕТАСКИВАНИЕ =================
local dragToggle, dragStart, startPos = nil, nil, nil
DragPanel.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragToggle = true; dragStart = input.Position; startPos = MainFrame.Position
	end
end)
DragPanel.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then dragToggle = false end
end)
UserInputService.InputChanged:Connect(function(input)
	if dragToggle and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- ================= РЕСПАВН =================
LocalPlayer.CharacterAdded:Connect(function()
	removeAntiKick()
	if antiKickEnabled then task.wait(0.5); spawnAntiKick() end
	if walkWaterEnabled then
		for _, p in ipairs(Workspace:GetDescendants()) do
			if p:IsA("BasePart") and p.Material == Enum.Material.Water then
				p.CustomPhysicalProperties = PhysicalProperties.new(0,0,0,100,0)
			end
		end
	end
	if noclipEnabled then
		noclipConnection = RunService.Stepped:Connect(function()
			if LocalPlayer.Character then
				for _, p in ipairs(LocalPlayer.Character:GetDescendants()) do
					if p:IsA("BasePart") then p.CanCollide = false end
				end
			end
		end)
	end
end)
