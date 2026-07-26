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

-- Настройки Shaders
local currentTimeOfDay = nil
local currentSeason = nil

-- Настройки Menu
local menuScale = 1
local menuTransparency = 0
local cornerRadius = 12
local textSize = 16
local currentColor = Color3.fromRGB(30, 30, 30)
local brightnessMultiplier = 1
local menuName = "Solar"

-- Настройки Misc
local walkWaterEnabled = false

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
local originalWalkSpeed = 16
local originalJumpPower = 50
local originalReach = 8

-- Цвета
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

-- Создание UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SolarMenuGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999999
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Главное окно
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

-- Верхняя панель
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

-- Разделитель
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

-- ================= ФУНКЦИЯ СОЗДАНИЯ КНОПОК =================

local function createToggleButton(parent, text, positionY, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 350, 0, 28)
	btn.Position = UDim2.new(0.5, -175, 0, positionY)
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

-- ================= ФУНКЦИЯ СОЗДАНИЯ БЛОКОВ =================

local function createSectionBlock(parent, title, positionY, height)
	local container = Instance.new("Frame")
	container.Size = UDim2.new(0, 360, 0, height)
	container.Position = UDim2.new(0.5, -180, 0, positionY)
	container.BackgroundTransparency = 1
	container.Parent = parent

	local border = Instance.new("Frame")
	border.Size = UDim2.new(1, 0, 1, 0)
	border.BackgroundTransparency = 1
	border.BorderSizePixel = 2
	border.BorderColor3 = Color3.fromRGB(100, 100, 100)
	border.Parent = container

	local borderCorner = Instance.new("UICorner")
	borderCorner.CornerRadius = UDim.new(0, 8)
	borderCorner.Parent = border

	local titleLabel = Instance.new("TextLabel")
	titleLabel.Size = UDim2.new(0, 0, 0, 20)
	titleLabel.Position = UDim2.new(0, 15, 0, -10)
	titleLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	titleLabel.Text = " " .. title .. " "
	titleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	titleLabel.Font = Enum.Font.SourceSansBold
	titleLabel.TextSize = 13
	titleLabel.AutomaticSize = Enum.AutomaticSize.X
	titleLabel.Parent = container

	local titleCorner = Instance.new("UICorner")
	titleCorner.CornerRadius = UDim.new(0, 4)
	titleCorner.Parent = titleLabel

	return container
end

-- ================= ВКЛАДКА PLAYER =================

local PlayerScrolling = Instance.new("ScrollingFrame")
PlayerScrolling.Size = UDim2.new(1, 0, 1, 0)
PlayerScrolling.BackgroundTransparency = 1
PlayerScrolling.ScrollBarThickness = 4
PlayerScrolling.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
PlayerScrolling.CanvasSize = UDim2.new(0, 0, 0, 400)
PlayerScrolling.Parent = PlayerTab

local PlayerList = Instance.new("UIListLayout")
PlayerList.Padding = UDim.new(0, 3)
PlayerList.Parent = PlayerScrolling

-- WalkSpeed
local WSToggleBtn = Instance.new("TextButton")
WSToggleBtn.Size = UDim2.new(0, 350, 0, 28)
WSToggleBtn.Position = UDim2.new(0.5, -175, 0, 5)
WSToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
WSToggleBtn.Text = "WalkSpeed Changer: OFF"
WSToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
WSToggleBtn.Font = Enum.Font.SourceSansBold
WSToggleBtn.TextSize = 12
WSToggleBtn.Parent = PlayerScrolling

local WSCorner = Instance.new("UICorner")
WSCorner.CornerRadius = UDim.new(0, 5)
WSCorner.Parent = WSToggleBtn

local wsEnabled = false
local wsValue = 16

WSToggleBtn.MouseButton1Click:Connect(function()
	wsEnabled = not wsEnabled
	if wsEnabled then
		WSToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 180, 40)
		WSToggleBtn.Text = "WalkSpeed Changer: ON (" .. wsValue .. ")"
	else
		WSToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
		WSToggleBtn.Text = "WalkSpeed Changer: OFF"
		local char = LocalPlayer.Character
		if char then
			local hum = char:FindFirstChild("Humanoid")
			if hum then hum.WalkSpeed = 16 end
		end
	end
end)

local WSContainer = Instance.new("Frame")
WSContainer.Size = UDim2.new(0, 350, 0, 55)
WSContainer.Position = UDim2.new(0.5, -175, 0, 36)
WSContainer.BackgroundTransparency = 1
WSContainer.Parent = PlayerScrolling

local WSTitle = Instance.new("TextLabel")
WSTitle.Size = UDim2.new(1, 0, 0, 18)
WSTitle.BackgroundTransparency = 1
WSTitle.Text = "WalkSpeed: " .. wsValue
WSTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
WSTitle.Font = Enum.Font.SourceSansSemibold
WSTitle.TextSize = 12
WSTitle.Parent = WSContainer

local WSBg = Instance.new("Frame")
WSBg.Size = UDim2.new(1, 0, 0, 8)
WSBg.Position = UDim2.new(0, 0, 0, 22)
WSBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
WSBg.BorderSizePixel = 0
WSBg.Parent = WSContainer

local WSBgCorner = Instance.new("UICorner")
WSBgCorner.CornerRadius = UDim.new(0, 4)
WSBgCorner.Parent = WSBg

local WSFill = Instance.new("Frame")
WSFill.Size = UDim2.new(0.1, 0, 1, 0)
WSFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
WSFill.BorderSizePixel = 0
WSFill.Parent = WSBg

local WSFillCorner = Instance.new("UICorner")
WSFillCorner.CornerRadius = UDim.new(0, 4)
WSFillCorner.Parent = WSFill

local WSBtn = Instance.new("ImageButton")
WSBtn.Size = UDim2.new(0, 14, 0, 14)
WSBtn.Position = UDim2.new(0.1, -7, 0.5, -7)
WSBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
WSBtn.Image = ""
WSBtn.Parent = WSBg

local WSBtnCorner = Instance.new("UICorner")
WSBtnCorner.CornerRadius = UDim.new(1, 0)
WSBtnCorner.Parent = WSBtn

-- JumpPower
local JPToggleBtn = Instance.new("TextButton")
JPToggleBtn.Size = UDim2.new(0, 350, 0, 28)
JPToggleBtn.Position = UDim2.new(0.5, -175, 0, 94)
JPToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
JPToggleBtn.Text = "JumpPower Changer: OFF"
JPToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
JPToggleBtn.Font = Enum.Font.SourceSansBold
JPToggleBtn.TextSize = 12
JPToggleBtn.Parent = PlayerScrolling

local JPCorner = Instance.new("UICorner")
JPCorner.CornerRadius = UDim.new(0, 5)
JPCorner.Parent = JPToggleBtn

local jpEnabled = false
local jpValue = 50

JPToggleBtn.MouseButton1Click:Connect(function()
	jpEnabled = not jpEnabled
	if jpEnabled then
		JPToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 180, 40)
		JPToggleBtn.Text = "JumpPower Changer: ON (" .. jpValue .. ")"
	else
		JPToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
		JPToggleBtn.Text = "JumpPower Changer: OFF"
		local char = LocalPlayer.Character
		if char then
			local hum = char:FindFirstChild("Humanoid")
			if hum then hum.JumpPower = 50 end
		end
	end
end)

local JPContainer = Instance.new("Frame")
JPContainer.Size = UDim2.new(0, 350, 0, 55)
JPContainer.Position = UDim2.new(0.5, -175, 0, 125)
JPContainer.BackgroundTransparency = 1
JPContainer.Parent = PlayerScrolling

local JPTitle = Instance.new("TextLabel")
JPTitle.Size = UDim2.new(1, 0, 0, 18)
JPTitle.BackgroundTransparency = 1
JPTitle.Text = "JumpPower: " .. jpValue
JPTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
JPTitle.Font = Enum.Font.SourceSansSemibold
JPTitle.TextSize = 12
JPTitle.Parent = JPContainer

local JPBg = Instance.new("Frame")
JPBg.Size = UDim2.new(1, 0, 0, 8)
JPBg.Position = UDim2.new(0, 0, 0, 22)
JPBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
JPBg.BorderSizePixel = 0
JPBg.Parent = JPContainer

local JPBgCorner = Instance.new("UICorner")
JPBgCorner.CornerRadius = UDim.new(0, 4)
JPBgCorner.Parent = JPBg

local JPFill = Instance.new("Frame")
JPFill.Size = UDim2.new(0.2, 0, 1, 0)
JPFill.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
JPFill.BorderSizePixel = 0
JPFill.Parent = JPBg

local JPFillCorner = Instance.new("UICorner")
JPFillCorner.CornerRadius = UDim.new(0, 4)
JPFillCorner.Parent = JPFill

local JPBtn = Instance.new("ImageButton")
JPBtn.Size = UDim2.new(0, 14, 0, 14)
JPBtn.Position = UDim2.new(0.2, -7, 0.5, -7)
JPBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
JPBtn.Image = ""
JPBtn.Parent = JPBg

local JPBtnCorner = Instance.new("UICorner")
JPBtnCorner.CornerRadius = UDim.new(1, 0)
JPBtnCorner.Parent = JPBtn

-- Infinite Jump
createToggleButton(PlayerScrolling, "Infinite Jump", 183, function(e)
	infiniteJumpEnabled = e
	if e then startInfiniteJump() else stopInfiniteJump() end
end)

-- Noclip
createToggleButton(PlayerScrolling, "Noclip", 214, function(e)
	noclipEnabled = e
	if e then startNoclip() else stopNoclip() end
end)

-- Reach Mod
local ReachToggleBtn = Instance.new("TextButton")
ReachToggleBtn.Size = UDim2.new(0, 350, 0, 28)
ReachToggleBtn.Position = UDim2.new(0.5, -175, 0, 245)
ReachToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
ReachToggleBtn.Text = "Reach Mod: OFF"
ReachToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ReachToggleBtn.Font = Enum.Font.SourceSansBold
ReachToggleBtn.TextSize = 12
ReachToggleBtn.Parent = PlayerScrolling

local ReachCorner = Instance.new("UICorner")
ReachCorner.CornerRadius = UDim.new(0, 5)
ReachCorner.Parent = ReachToggleBtn

local reachEnabled = false
local reachValue = 8

ReachToggleBtn.MouseButton1Click:Connect(function()
	reachEnabled = not reachEnabled
	if reachEnabled then
		ReachToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 180, 40)
		ReachToggleBtn.Text = "Reach Mod: ON (" .. reachValue .. ")"
	else
		ReachToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
		ReachToggleBtn.Text = "Reach Mod: OFF"
	end
end)

local ReachContainer = Instance.new("Frame")
ReachContainer.Size = UDim2.new(0, 350, 0, 55)
ReachContainer.Position = UDim2.new(0.5, -175, 0, 276)
ReachContainer.BackgroundTransparency = 1
ReachContainer.Parent = PlayerScrolling

local ReachTitle = Instance.new("TextLabel")
ReachTitle.Size = UDim2.new(1, 0, 0, 18)
ReachTitle.BackgroundTransparency = 1
ReachTitle.Text = "Reach: " .. reachValue
ReachTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
ReachTitle.Font = Enum.Font.SourceSansSemibold
ReachTitle.TextSize = 12
ReachTitle.Parent = ReachContainer

local ReachBg = Instance.new("Frame")
ReachBg.Size = UDim2.new(1, 0, 0, 8)
ReachBg.Position = UDim2.new(0, 0, 0, 22)
ReachBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ReachBg.BorderSizePixel = 0
ReachBg.Parent = ReachContainer

local ReachBgCorner = Instance.new("UICorner")
ReachBgCorner.CornerRadius = UDim.new(0, 4)
ReachBgCorner.Parent = ReachBg

local ReachFill = Instance.new("Frame")
ReachFill.Size = UDim2.new(0.05, 0, 1, 0)
ReachFill.BackgroundColor3 = Color3.fromRGB(255, 0, 255)
ReachFill.BorderSizePixel = 0
ReachFill.Parent = ReachBg

local ReachFillCorner = Instance.new("UICorner")
ReachFillCorner.CornerRadius = UDim.new(0, 4)
ReachFillCorner.Parent = ReachFill

local ReachBtn = Instance.new("ImageButton")
ReachBtn.Size = UDim2.new(0, 14, 0, 14)
ReachBtn.Position = UDim2.new(0.05, -7, 0.5, -7)
ReachBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ReachBtn.Image = ""
ReachBtn.Parent = ReachBg

local ReachBtnCorner = Instance.new("UICorner")
ReachBtnCorner.CornerRadius = UDim.new(1, 0)
ReachBtnCorner.Parent = ReachBtn

-- ================= ВКЛАДКА PROTECT =================

local ProtectScrolling = Instance.new("ScrollingFrame")
ProtectScrolling.Size = UDim2.new(1, 0, 1, 0)
ProtectScrolling.BackgroundTransparency = 1
ProtectScrolling.ScrollBarThickness = 4
ProtectScrolling.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
ProtectScrolling.CanvasSize = UDim2.new(0, 0, 0, 270)
ProtectScrolling.Parent = ProtectTab

local ProtectList = Instance.new("UIListLayout")
ProtectList.Padding = UDim.new(0, 3)
ProtectList.Parent = ProtectScrolling

createToggleButton(ProtectScrolling, "Anti-Grab", 5, function(e) antiGrabEnabled = e end)
createToggleButton(ProtectScrolling, "Anti-Burn", 36, function(e) antiBurnEnabled = e end)
createToggleButton(ProtectScrolling, "Anti-Fling", 67, function(e) antiFlingEnabled = e end)
createToggleButton(ProtectScrolling, "Anti-Kick", 98, function(e)
	antiKickEnabled = e
	if e then spawnAntiKick() else removeAntiKick() end
end)
createToggleButton(ProtectScrolling, "Gucci Anti-Grab", 129, function(e) gucciAntiGrabEnabled = e end)
createToggleButton(ProtectScrolling, "Anti-Stun", 160, function(e) antiStunEnabled = e end)
createToggleButton(ProtectScrolling, "Anti-Kill", 191, function(e)
	antiKillEnabled = e
	if e then startAntiKill() else stopAntiKill() end
end)
createToggleButton(ProtectScrolling, "Anti-Bring", 222, function(e)
	antiBringEnabled = e
	if e then startAntiBring() else stopAntiBring() end
end)

-- ================= ВКЛАДКА ATTACK =================

local AttackScrolling = Instance.new("ScrollingFrame")
AttackScrolling.Size = UDim2.new(1, 0, 1, 0)
AttackScrolling.BackgroundTransparency = 1
AttackScrolling.ScrollBarThickness = 4
AttackScrolling.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
AttackScrolling.CanvasSize = UDim2.new(0, 0, 0, 200)
AttackScrolling.Parent = AttackTab

local AttackList = Instance.new("UIListLayout")
AttackList.Padding = UDim.new(0, 3)
AttackList.Parent = AttackScrolling

createToggleButton(AttackScrolling, "Super Strength", 5, function(e) superStrengthEnabled = e end)
createToggleButton(AttackScrolling, "Kill Grab", 36, function(e) killGrabEnabled = e end)
createToggleButton(AttackScrolling, "Kick Grab", 67, function(e) kickGrabEnabled = e end)

-- Strength слайдер
local StrContainer = Instance.new("Frame")
StrContainer.Size = UDim2.new(0, 350, 0, 55)
StrContainer.Position = UDim2.new(0.5, -175, 0, 100)
StrContainer.BackgroundTransparency = 1
StrContainer.Parent = AttackScrolling

local StrTitle = Instance.new("TextLabel")
StrTitle.Size = UDim2.new(1, 0, 0, 18)
StrTitle.BackgroundTransparency = 1
StrTitle.Text = "Fling Strength: " .. flingStrength
StrTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
StrTitle.Font = Enum.Font.SourceSansSemibold
StrTitle.TextSize = 12
StrTitle.Parent = StrContainer

local StrBg = Instance.new("Frame")
StrBg.Size = UDim2.new(1, 0, 0, 8)
StrBg.Position = UDim2.new(0, 0, 0, 22)
StrBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
StrBg.BorderSizePixel = 0
StrBg.Parent = StrContainer

local StrBgCorner = Instance.new("UICorner")
StrBgCorner.CornerRadius = UDim.new(0, 4)
StrBgCorner.Parent = StrBg

local StrFill = Instance.new("Frame")
StrFill.Size = UDim2.new(0.33, 0, 1, 0)
StrFill.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
StrFill.BorderSizePixel = 0
StrFill.Parent = StrBg

local StrFillCorner = Instance.new("UICorner")
StrFillCorner.CornerRadius = UDim.new(0, 4)
StrFillCorner.Parent = StrFill

local StrBtn = Instance.new("ImageButton")
StrBtn.Size = UDim2.new(0, 14, 0, 14)
StrBtn.Position = UDim2.new(0.33, -7, 0.5, -7)
StrBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
StrBtn.Image = ""
StrBtn.Parent = StrBg

local StrBtnCorner = Instance.new("UICorner")
StrBtnCorner.CornerRadius = UDim.new(1, 0)
StrBtnCorner.Parent = StrBtn

-- Lag Server
local LagBtn = Instance.new("TextButton")
LagBtn.Size = UDim2.new(0, 350, 0, 28)
LagBtn.Position = UDim2.new(0.5, -175, 0, 162)
LagBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
LagBtn.Text = "Lag Server (Coming Soon)"
LagBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LagBtn.Font = Enum.Font.SourceSansBold
LagBtn.TextSize = 12
LagBtn.Parent = AttackScrolling

local LagCorner = Instance.new("UICorner")
LagCorner.CornerRadius = UDim.new(0, 5)
LagCorner.Parent = LagBtn

-- ================= ВКЛАДКА AUTOMATION =================

local AutoScrolling = Instance.new("ScrollingFrame")
AutoScrolling.Size = UDim2.new(1, 0, 1, 0)
AutoScrolling.BackgroundTransparency = 1
AutoScrolling.ScrollBarThickness = 4
AutoScrolling.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
AutoScrolling.CanvasSize = UDim2.new(0, 0, 0, 350)
AutoScrolling.Parent = AutomationTab

local AutoList = Instance.new("UIListLayout")
AutoList.Padding = UDim.new(0, 3)
AutoList.Parent = AutoScrolling

createToggleButton(AutoScrolling, "Auto Fling All", 5, function(e)
	autoFlingAllEnabled = e
	if e then startAutoFlingAll() else stopAutoFlingAll() end
end)

createToggleButton(AutoScrolling, "Auto Grab", 36, function(e)
	autoGrabEnabled = e
	if e then startAutoGrab() else stopAutoGrab() end
end)

createToggleButton(AutoScrolling, "Auto Bring Items", 67, function(e)
	autoBringItemsEnabled = e
	if e then startAutoBringItems() else stopAutoBringItems() end
end)

-- Auto Fling Delay
local FlingDelayContainer = Instance.new("Frame")
FlingDelayContainer.Size = UDim2.new(0, 350, 0, 55)
FlingDelayContainer.Position = UDim2.new(0.5, -175, 0, 100)
FlingDelayContainer.BackgroundTransparency = 1
FlingDelayContainer.Parent = AutoScrolling

local FlingDelayTitle = Instance.new("TextLabel")
FlingDelayTitle.Size = UDim2.new(1, 0, 0, 18)
FlingDelayTitle.BackgroundTransparency = 1
FlingDelayTitle.Text = "Fling Delay: " .. string.format("%.1f", autoFlingDelay) .. "s"
FlingDelayTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
FlingDelayTitle.Font = Enum.Font.SourceSansSemibold
FlingDelayTitle.TextSize = 12
FlingDelayTitle.Parent = FlingDelayContainer

local FlingDelayBg = Instance.new("Frame")
FlingDelayBg.Size = UDim2.new(1, 0, 0, 8)
FlingDelayBg.Position = UDim2.new(0, 0, 0, 22)
FlingDelayBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
FlingDelayBg.BorderSizePixel = 0
FlingDelayBg.Parent = FlingDelayContainer

local FlingDelayBgCorner = Instance.new("UICorner")
FlingDelayBgCorner.CornerRadius = UDim.new(0, 4)
FlingDelayBgCorner.Parent = FlingDelayBg

local FlingDelayFill = Instance.new("Frame")
FlingDelayFill.Size = UDim2.new(0.5, 0, 1, 0)
FlingDelayFill.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
FlingDelayFill.BorderSizePixel = 0
FlingDelayFill.Parent = FlingDelayBg

local FlingDelayFillCorner = Instance.new("UICorner")
FlingDelayFillCorner.CornerRadius = UDim.new(0, 4)
FlingDelayFillCorner.Parent = FlingDelayFill

local FlingDelayBtn = Instance.new("ImageButton")
FlingDelayBtn.Size = UDim2.new(0, 14, 0, 14)
FlingDelayBtn.Position = UDim2.new(0.5, -7, 0.5, -7)
FlingDelayBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
FlingDelayBtn.Image = ""
FlingDelayBtn.Parent = FlingDelayBg

local FlingDelayBtnCorner = Instance.new("UICorner")
FlingDelayBtnCorner.CornerRadius = UDim.new(1, 0)
FlingDelayBtnCorner.Parent = FlingDelayBtn

-- Auto Grab Radius
local GrabRadiusContainer = Instance.new("Frame")
GrabRadiusContainer.Size = UDim2.new(0, 350, 0, 55)
GrabRadiusContainer.Position = UDim2.new(0.5, -175, 0, 162)
GrabRadiusContainer.BackgroundTransparency = 1
GrabRadiusContainer.Parent = AutoScrolling

local GrabRadiusTitle = Instance.new("TextLabel")
GrabRadiusTitle.Size = UDim2.new(1, 0, 0, 18)
GrabRadiusTitle.BackgroundTransparency = 1
GrabRadiusTitle.Text = "Grab Radius: " .. autoGrabRadius
GrabRadiusTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
GrabRadiusTitle.Font = Enum.Font.SourceSansSemibold
GrabRadiusTitle.TextSize = 12
GrabRadiusTitle.Parent = GrabRadiusContainer

local GrabRadiusBg = Instance.new("Frame")
GrabRadiusBg.Size = UDim2.new(1, 0, 0, 8)
GrabRadiusBg.Position = UDim2.new(0, 0, 0, 22)
GrabRadiusBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
GrabRadiusBg.BorderSizePixel = 0
GrabRadiusBg.Parent = GrabRadiusContainer

local GrabRadiusBgCorner = Instance.new("UICorner")
GrabRadiusBgCorner.CornerRadius = UDim.new(0, 4)
GrabRadiusBgCorner.Parent = GrabRadiusBg

local GrabRadiusFill = Instance.new("Frame")
GrabRadiusFill.Size = UDim2.new(0.25, 0, 1, 0)
GrabRadiusFill.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
GrabRadiusFill.BorderSizePixel = 0
GrabRadiusFill.Parent = GrabRadiusBg

local GrabRadiusFillCorner = Instance.new("UICorner")
GrabRadiusFillCorner.CornerRadius = UDim.new(0, 4)
GrabRadiusFillCorner.Parent = GrabRadiusFill

local GrabRadiusBtn = Instance.new("ImageButton")
GrabRadiusBtn.Size = UDim2.new(0, 14, 0, 14)
GrabRadiusBtn.Position = UDim2.new(0.25, -7, 0.5, -7)
GrabRadiusBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
GrabRadiusBtn.Image = ""
GrabRadiusBtn.Parent = GrabRadiusBg

local GrabRadiusBtnCorner = Instance.new("UICorner")
GrabRadiusBtnCorner.CornerRadius = UDim.new(1, 0)
GrabRadiusBtnCorner.Parent = GrabRadiusBtn

-- Bring Items Height
local BringHeightContainer = Instance.new("Frame")
BringHeightContainer.Size = UDim2.new(0, 350, 0, 55)
BringHeightContainer.Position = UDim2.new(0.5, -175, 0, 224)
BringHeightContainer.BackgroundTransparency = 1
BringHeightContainer.Parent = AutoScrolling

local BringHeightTitle = Instance.new("TextLabel")
BringHeightTitle.Size = UDim2.new(1, 0, 0, 18)
BringHeightTitle.BackgroundTransparency = 1
BringHeightTitle.Text = "Bring Height: " .. bringItemsHeight
BringHeightTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
BringHeightTitle.Font = Enum.Font.SourceSansSemibold
BringHeightTitle.TextSize = 12
BringHeightTitle.Parent = BringHeightContainer

local BringHeightBg = Instance.new("Frame")
BringHeightBg.Size = UDim2.new(1, 0, 0, 8)
BringHeightBg.Position = UDim2.new(0, 0, 0, 22)
BringHeightBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
BringHeightBg.BorderSizePixel = 0
BringHeightBg.Parent = BringHeightContainer

local BringHeightBgCorner = Instance.new("UICorner")
BringHeightBgCorner.CornerRadius = UDim.new(0, 4)
BringHeightBgCorner.Parent = BringHeightBg

local BringHeightFill = Instance.new("Frame")
BringHeightFill.Size = UDim2.new(0.2, 0, 1, 0)
BringHeightFill.BackgroundColor3 = Color3.fromRGB(255, 255, 50)
BringHeightFill.BorderSizePixel = 0
BringHeightFill.Parent = BringHeightBg

local BringHeightFillCorner = Instance.new("UICorner")
BringHeightFillCorner.CornerRadius = UDim.new(0, 4)
BringHeightFillCorner.Parent = BringHeightFill

local BringHeightBtn = Instance.new("ImageButton")
BringHeightBtn.Size = UDim2.new(0, 14, 0, 14)
BringHeightBtn.Position = UDim2.new(0.2, -7, 0.5, -7)
BringHeightBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BringHeightBtn.Image = ""
BringHeightBtn.Parent = BringHeightBg

local BringHeightBtnCorner = Instance.new("UICorner")
BringHeightBtnCorner.CornerRadius = UDim.new(1, 0)
BringHeightBtnCorner.Parent = BringHeightBtn

-- ================= ВКЛАДКА SHADERS =================

local ShadersScrolling = Instance.new("ScrollingFrame")
ShadersScrolling.Size = UDim2.new(1, 0, 1, 0)
ShadersScrolling.BackgroundTransparency = 1
ShadersScrolling.ScrollBarThickness = 4
ShadersScrolling.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
ShadersScrolling.CanvasSize = UDim2.new(0, 0, 0, 350)
ShadersScrolling.Parent = ShadersTab

-- Блок Time Of Day
local timeBlock = createSectionBlock(ShadersScrolling, "Time Of Day", 10, 160)

local timeButtons = {"Day", "Sunset", "Night", "Sunrise"}
local timeFunctions = {
	Day = function()
		Lighting.ClockTime = 12
		Lighting.Brightness = 3
		Lighting.OutdoorAmbient = Color3.fromRGB(200, 200, 200)
		Lighting.FogColor = Color3.fromRGB(180, 210, 255)
		Lighting.FogEnd = 10000
	end,
	Sunset = function()
		Lighting.ClockTime = 18
		Lighting.Brightness = 1.5
		Lighting.OutdoorAmbient = Color3.fromRGB(255, 150, 80)
		Lighting.FogColor = Color3.fromRGB(255, 120, 50)
		Lighting.FogEnd = 5000
	end,
	Night = function()
		Lighting.ClockTime = 0
		Lighting.Brightness = 0.5
		Lighting.OutdoorAmbient = Color3.fromRGB(50, 50, 100)
		Lighting.FogColor = Color3.fromRGB(30, 30, 60)
		Lighting.FogEnd = 3000
	end,
	Sunrise = function()
		Lighting.ClockTime = 6
		Lighting.Brightness = 1.5
		Lighting.OutdoorAmbient = Color3.fromRGB(255, 200, 150)
		Lighting.FogColor = Color3.fromRGB(255, 180, 120)
		Lighting.FogEnd = 7000
	end
}

for i, name in ipairs(timeButtons) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 320, 0, 28)
	btn.Position = UDim2.new(0, 20, 0, 25 + (i - 1) * 33)
	btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	btn.Text = name
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 12
	btn.Parent = timeBlock

	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 5)
	btnCorner.Parent = btn

	btn.MouseButton1Click:Connect(function()
		currentTimeOfDay = name
		timeFunctions[name]()
		for _, child in ipairs(timeBlock:GetChildren()) do
			if child:IsA("TextButton") then
				child.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
			end
		end
		btn.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
	end)
end

-- Блок Season
local seasonBlock = createSectionBlock(ShadersScrolling, "Season", 185, 160)

local seasonButtons = {"Winter", "Spring", "Summer", "Autumn"}
local seasonFunctions = {
	Winter = function()
		Lighting.OutdoorAmbient = Color3.fromRGB(200, 210, 230)
		Lighting.FogColor = Color3.fromRGB(230, 235, 245)
		Lighting.FogEnd = 4000
		Lighting.Brightness = 2
	end,
	Spring = function()
		Lighting.OutdoorAmbient = Color3.fromRGB(180, 220, 180)
		Lighting.FogColor = Color3.fromRGB(200, 240, 200)
		Lighting.FogEnd = 8000
		Lighting.Brightness = 2.5
	end,
	Summer = function()
		Lighting.OutdoorAmbient = Color3.fromRGB(255, 240, 200)
		Lighting.FogColor = Color3.fromRGB(255, 255, 200)
		Lighting.FogEnd = 15000
		Lighting.Brightness = 3
	end,
	Autumn = function()
		Lighting.OutdoorAmbient = Color3.fromRGB(220, 180, 140)
		Lighting.FogColor = Color3.fromRGB(200, 150, 100)
		Lighting.FogEnd = 6000
		Lighting.Brightness = 1.8
	end
}

for i, name in ipairs(seasonButtons) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 320, 0, 28)
	btn.Position = UDim2.new(0, 20, 0, 25 + (i - 1) * 33)
	btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	btn.Text = name
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 12
	btn.Parent = seasonBlock

	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 5)
	btnCorner.Parent = btn

	btn.MouseButton1Click:Connect(function()
		currentSeason = name
		seasonFunctions[name]()
		for _, child in ipairs(seasonBlock:GetChildren()) do
			if child:IsA("TextButton") then
				child.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
			end
		end
		btn.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
	end)
end

-- ================= ВКЛАДКА MISC =================

local MiscScrolling = Instance.new("ScrollingFrame")
MiscScrolling.Size = UDim2.new(1, 0, 1, 0)
MiscScrolling.BackgroundTransparency = 1
MiscScrolling.ScrollBarThickness = 4
MiscScrolling.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
MiscScrolling.CanvasSize = UDim2.new(0, 0, 0, 300)
MiscScrolling.Parent = MiscTab

-- FOV
local FOVContainer = Instance.new("Frame")
FOVContainer.Size = UDim2.new(0, 350, 0, 55)
FOVContainer.Position = UDim2.new(0.5, -175, 0, 5)
FOVContainer.BackgroundTransparency = 1
FOVContainer.Parent = MiscScrolling

local FOVTitle = Instance.new("TextLabel")
FOVTitle.Size = UDim2.new(1, 0, 0, 18)
FOVTitle.BackgroundTransparency = 1
FOVTitle.Text = "Field of View (FOV): " .. math.round(Camera.FieldOfView)
FOVTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
FOVTitle.Font = Enum.Font.SourceSansSemibold
FOVTitle.TextSize = 12
FOVTitle.Parent = FOVContainer

local FOVBg = Instance.new("Frame")
FOVBg.Size = UDim2.new(1, 0, 0, 8)
FOVBg.Position = UDim2.new(0, 0, 0, 22)
FOVBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
FOVBg.BorderSizePixel = 0
FOVBg.Parent = FOVContainer

local FOVBgCorner = Instance.new("UICorner")
FOVBgCorner.CornerRadius = UDim.new(0, 4)
FOVBgCorner.Parent = FOVBg

local FOVFill = Instance.new("Frame")
FOVFill.Size = UDim2.new(0.3, 0, 1, 0)
FOVFill.BackgroundColor3 = Color3.fromRGB(0, 160, 255)
FOVFill.BorderSizePixel = 0
FOVFill.Parent = FOVBg

local FOVFillCorner = Instance.new("UICorner")
FOVFillCorner.CornerRadius = UDim.new(0, 4)
FOVFillCorner.Parent = FOVFill

local FOVBtn = Instance.new("ImageButton")
FOVBtn.Size = UDim2.new(0, 14, 0, 14)
FOVBtn.Position = UDim2.new(0.3, -7, 0.5, -7)
FOVBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
FOVBtn.Image = ""
FOVBtn.Parent = FOVBg

local FOVBtnCorner = Instance.new("UICorner")
FOVBtnCorner.CornerRadius = UDim.new(1, 0)
FOVBtnCorner.Parent = FOVBtn

local minFov = 30
local maxFov = 120

-- Walk Water
createToggleButton(MiscScrolling, "Walk Water", 68, function(e)
	walkWaterEnabled = e
	if e then enableWalkWater() else disableWalkWater() end
end)

-- ================= ESP =================

local espEnabled = false
local selectedESPPlayer = nil
local espHighlight = nil
local espConnection = nil

-- Заголовок ESP
local ESPTitle = Instance.new("TextLabel")
ESPTitle.Size = UDim2.new(0, 350, 0, 20)
ESPTitle.Position = UDim2.new(0.5, -175, 0, 100)
ESPTitle.BackgroundTransparency = 1
ESPTitle.Text = "ESP (Player Highlight)"
ESPTitle.TextColor3 = Color3.fromRGB(255, 100, 100)
ESPTitle.Font = Enum.Font.SourceSansBold
ESPTitle.TextSize = 14
ESPTitle.Parent = MiscScrolling

-- Выпадающий список игроков
local ESPDropdown = Instance.new("TextButton")
ESPDropdown.Size = UDim2.new(0, 350, 0, 30)
ESPDropdown.Position = UDim2.new(0.5, -175, 0, 125)
ESPDropdown.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
ESPDropdown.Text = "Выберите игрока..."
ESPDropdown.TextColor3 = Color3.fromRGB(200, 200, 200)
ESPDropdown.Font = Enum.Font.SourceSans
ESPDropdown.TextSize = 12
ESPDropdown.TextXAlignment = Enum.TextXAlignment.Left
ESPDropdown.Parent = MiscScrolling

local ESPDropdownCorner = Instance.new("UICorner")
ESPDropdownCorner.CornerRadius = UDim.new(0, 6)
ESPDropdownCorner.Parent = ESPDropdown

local ESPDropArrow = Instance.new("TextLabel")
ESPDropArrow.Size = UDim2.new(0, 20, 1, 0)
ESPDropArrow.Position = UDim2.new(1, -25, 0, 0)
ESPDropArrow.BackgroundTransparency = 1
ESPDropArrow.Text = "▼"
ESPDropArrow.TextColor3 = Color3.fromRGB(150, 150, 150)
ESPDropArrow.Font = Enum.Font.SourceSansBold
ESPDropArrow.TextSize = 10
ESPDropArrow.Parent = ESPDropdown

-- Список игроков
local ESPDropList = Instance.new("ScrollingFrame")
ESPDropList.Size = UDim2.new(0, 350, 0, 120)
ESPDropList.Position = UDim2.new(0.5, -175, 0, 158)
ESPDropList.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ESPDropList.BorderSizePixel = 1
ESPDropList.BorderColor3 = Color3.fromRGB(60, 60, 60)
ESPDropList.Visible = false
ESPDropList.ScrollBarThickness = 4
ESPDropList.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
ESPDropList.CanvasSize = UDim2.new(0, 0, 0, 0)
ESPDropList.Parent = MiscScrolling

local ESPDropListCorner = Instance.new("UICorner")
ESPDropListCorner.CornerRadius = UDim.new(0, 6)
ESPDropListCorner.Parent = ESPDropList

local ESPDropListLayout = Instance.new("UIListLayout")
ESPDropListLayout.Padding = UDim.new(0, 2)
ESPDropListLayout.Parent = ESPDropList

-- Функция обновления списка игроков
local function updateESPPlayerList()
	for _, child in ipairs(ESPDropList:GetChildren()) do
		if child:IsA("TextButton") then child:Destroy() end
	end

	local totalHeight = 0
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			local btn = Instance.new("TextButton")
			btn.Size = UDim2.new(1, -4, 0, 26)
			btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			btn.Text = player.Name
			btn.TextColor3 = Color3.fromRGB(230, 230, 230)
			btn.Font = Enum.Font.SourceSans
			btn.TextSize = 12
			btn.TextXAlignment = Enum.TextXAlignment.Left
			btn.Parent = ESPDropList

			local btnCorner = Instance.new("UICorner")
			btnCorner.CornerRadius = UDim.new(0, 4)
			btnCorner.Parent = btn

			btn.MouseButton1Click:Connect(function()
				selectedESPPlayer = player
				ESPDropdown.Text = "ESP: " .. player.Name
				ESPDropList.Visible = false
			end)

			totalHeight = totalHeight + 28
		end
	end
	ESPDropList.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
end

updateESPPlayerList()

ESPDropdown.MouseButton1Click:Connect(function()
	updateESPPlayerList()
	ESPDropList.Visible = not ESPDropList.Visible
end)

-- Кнопка ВКЛ/ВЫКЛ ESP
local ESPToggleBtn = Instance.new("TextButton")
ESPToggleBtn.Size = UDim2.new(0, 350, 0, 28)
ESPToggleBtn.Position = UDim2.new(0.5, -175, 0, 160)
ESPToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
ESPToggleBtn.Text = "ESP: OFF"
ESPToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPToggleBtn.Font = Enum.Font.SourceSansBold
ESPToggleBtn.TextSize = 12
ESPToggleBtn.Parent = MiscScrolling

local ESPToggleCorner = Instance.new("UICorner")
ESPToggleCorner.CornerRadius = UDim.new(0, 5)
ESPToggleCorner.Parent = ESPToggleBtn

ESPToggleBtn.MouseButton1Click:Connect(function()
	espEnabled = not espEnabled
	if espEnabled then
		if not selectedESPPlayer then
			ESPToggleBtn.Text = "ESP: ON (No target!)"
			ESPToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
		else
			ESPToggleBtn.Text = "ESP: ON (" .. selectedESPPlayer.Name .. ")"
			ESPToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 180, 40)
		end
		startESP()
	else
		ESPToggleBtn.Text = "ESP: OFF"
		ESPToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
		stopESP()
	end
end)

-- Функции ESP
function startESP()
	stopESP()
	espConnection = RunService.RenderStepped:Connect(function()
		if not espEnabled then return end
		if not selectedESPPlayer then return end
		local char = selectedESPPlayer.Character
		if not char then return end

		-- Применяем подсветку ко всем частям тела
		for _, part in ipairs(char:GetDescendants()) do
			if part:IsA("BasePart") then
				part.BrickColor = BrickColor.new("Bright red")
				part.Transparency = 0.5
				part.Material = Enum.Material.ForceField
			end
		end

		-- Highlight (Box ESP) через SelectionBox или bounding box
		local root = char:FindFirstChild("HumanoidRootPart")
		if root then
			if not char:FindFirstChild("ESPBox") then
				local box = Instance.new("SelectionBox")
				box.Name = "ESPBox"
				box.Adornee = root
				box.Color3 = Color3.fromRGB(255, 50, 50)
				box.Transparency = 0.6
				box.LineThickness = 0.05
				box.Parent = root
			end
		end
	end)
end

function stopESP()
	if espConnection then
		espConnection:Disconnect()
		espConnection = nil
	end
	-- Убираем подсветку со всех игроков
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

-- Закрытие списка при клике вне
UserInputService.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		if ESPDropList.Visible then
			local mousePos = UserInputService:GetMouseLocation()
			local listPos = ESPDropList.AbsolutePosition
			local listSize = ESPDropList.AbsoluteSize
			local dropPos = ESPDropdown.AbsolutePosition
			local dropSize = ESPDropdown.AbsoluteSize

			if not (
				(mousePos.X >= listPos.X and mousePos.X <= listPos.X + listSize.X and
				 mousePos.Y >= listPos.Y and mousePos.Y <= listPos.Y + listSize.Y) or
				(mousePos.X >= dropPos.X and mousePos.X <= dropPos.X + dropSize.X and
				 mousePos.Y >= dropPos.Y and mousePos.Y <= dropPos.Y + dropSize.Y)
			) then
				ESPDropList.Visible = false
			end
		end
	end
end)

-- ================= ВКЛАДКА MENU =================

local MenuScrolling = Instance.new("ScrollingFrame")
MenuScrolling.Size = UDim2.new(1, 0, 1, 0)
MenuScrolling.BackgroundTransparency = 1
MenuScrolling.ScrollBarThickness = 4
MenuScrolling.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
MenuScrolling.CanvasSize = UDim2.new(0, 0, 0, 900)
MenuScrolling.Parent = MenuTab

local MenuList = Instance.new("UIListLayout")
MenuList.Padding = UDim.new(0, 5)
MenuList.Parent = MenuScrolling

-- Scale Menu
local ScaleContainer = Instance.new("Frame")
ScaleContainer.Size = UDim2.new(0, 350, 0, 55)
ScaleContainer.Position = UDim2.new(0.5, -175, 0, 5)
ScaleContainer.BackgroundTransparency = 1
ScaleContainer.Parent = MenuScrolling

local ScaleTitle = Instance.new("TextLabel")
ScaleTitle.Size = UDim2.new(1, 0, 0, 18)
ScaleTitle.BackgroundTransparency = 1
ScaleTitle.Text = "Scale Menu: " .. string.format("%.1f", menuScale)
ScaleTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
ScaleTitle.Font = Enum.Font.SourceSansSemibold
ScaleTitle.TextSize = 12
ScaleTitle.Parent = ScaleContainer

local ScaleBg = Instance.new("Frame")
ScaleBg.Size = UDim2.new(1, 0, 0, 8)
ScaleBg.Position = UDim2.new(0, 0, 0, 22)
ScaleBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ScaleBg.BorderSizePixel = 0
ScaleBg.Parent = ScaleContainer

local ScaleBgCorner = Instance.new("UICorner")
ScaleBgCorner.CornerRadius = UDim.new(0, 4)
ScaleBgCorner.Parent = ScaleBg

local ScaleFill = Instance.new("Frame")
ScaleFill.Size = UDim2.new(0.5, 0, 1, 0)
ScaleFill.BackgroundColor3 = Color3.fromRGB(0, 200, 200)
ScaleFill.BorderSizePixel = 0
ScaleFill.Parent = ScaleBg

local ScaleFillCorner = Instance.new("UICorner")
ScaleFillCorner.CornerRadius = UDim.new(0, 4)
ScaleFillCorner.Parent = ScaleFill

local ScaleBtn = Instance.new("ImageButton")
ScaleBtn.Size = UDim2.new(0, 14, 0, 14)
ScaleBtn.Position = UDim2.new(0.5, -7, 0.5, -7)
ScaleBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ScaleBtn.Image = ""
ScaleBtn.Parent = ScaleBg

local ScaleBtnCorner = Instance.new("UICorner")
ScaleBtnCorner.CornerRadius = UDim.new(1, 0)
ScaleBtnCorner.Parent = ScaleBtn

-- Change Color
local ColorTitle = Instance.new("TextLabel")
ColorTitle.Size = UDim2.new(0, 350, 0, 18)
ColorTitle.BackgroundTransparency = 1
ColorTitle.Text = "Change Color"
ColorTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
ColorTitle.Font = Enum.Font.SourceSansBold
ColorTitle.TextSize = 14
ColorTitle.Parent = MenuScrolling

local colorNames = {"Red", "Blue", "Green", "Pink", "Purple", "White", "Brown", "Rainbow Gradient"}
for _, colorName in ipairs(colorNames) do
	local colorBtn = Instance.new("TextButton")
	colorBtn.Size = UDim2.new(0, 170, 0, 23)
	colorBtn.Text = colorName
	colorBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	colorBtn.Font = Enum.Font.SourceSansBold
	colorBtn.TextSize = 11
	colorBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	colorBtn.Parent = MenuScrolling

	local colCorner = Instance.new("UICorner")
	colCorner.CornerRadius = UDim.new(0, 4)
	colCorner.Parent = colorBtn

	colorBtn.MouseButton1Click:Connect(function()
		selectedColorName = colorName
		updateMenuColor()
	end)
end

-- Brightness
local BrightnessContainer = Instance.new("Frame")
BrightnessContainer.Size = UDim2.new(0, 350, 0, 55)
BrightnessContainer.BackgroundTransparency = 1
BrightnessContainer.Parent = MenuScrolling

local BrightnessTitle = Instance.new("TextLabel")
BrightnessTitle.Size = UDim2.new(1, 0, 0, 18)
BrightnessTitle.BackgroundTransparency = 1
BrightnessTitle.Text = "Brightness: " .. string.format("%.1f", brightnessMultiplier)
BrightnessTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
BrightnessTitle.Font = Enum.Font.SourceSansSemibold
BrightnessTitle.TextSize = 12
BrightnessTitle.Parent = BrightnessContainer

local BrightnessBg = Instance.new("Frame")
BrightnessBg.Size = UDim2.new(1, 0, 0, 8)
BrightnessBg.Position = UDim2.new(0, 0, 0, 22)
BrightnessBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
BrightnessBg.BorderSizePixel = 0
BrightnessBg.Parent = BrightnessContainer

local BrightnessBgCorner = Instance.new("UICorner")
BrightnessBgCorner.CornerRadius = UDim.new(0, 4)
BrightnessBgCorner.Parent = BrightnessBg

local BrightnessFill = Instance.new("Frame")
BrightnessFill.Size = UDim2.new(1, 0, 1, 0)
BrightnessFill.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
BrightnessFill.BorderSizePixel = 0
BrightnessFill.Parent = BrightnessBg

local BrightnessFillCorner = Instance.new("UICorner")
BrightnessFillCorner.CornerRadius = UDim.new(0, 4)
BrightnessFillCorner.Parent = BrightnessFill

local BrightnessBtn = Instance.new("ImageButton")
BrightnessBtn.Size = UDim2.new(0, 14, 0, 14)
BrightnessBtn.Position = UDim2.new(1, -7, 0.5, -7)
BrightnessBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BrightnessBtn.Image = ""
BrightnessBtn.Parent = BrightnessBg

local BrightnessBtnCorner = Instance.new("UICorner")
BrightnessBtnCorner.CornerRadius = UDim.new(1, 0)
BrightnessBtnCorner.Parent = BrightnessBtn

-- Change Name
local NameContainer = Instance.new("Frame")
NameContainer.Size = UDim2.new(0, 350, 0, 45)
NameContainer.BackgroundTransparency = 1
NameContainer.Parent = MenuScrolling

local NameTitle = Instance.new("TextLabel")
NameTitle.Size = UDim2.new(1, 0, 0, 16)
NameTitle.BackgroundTransparency = 1
NameTitle.Text = "Change Name (Solar)"
NameTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
NameTitle.Font = Enum.Font.SourceSansSemibold
NameTitle.TextSize = 12
NameTitle.Parent = NameContainer

local NameInput = Instance.new("TextBox")
NameInput.Size = UDim2.new(0, 190, 0, 26)
NameInput.Position = UDim2.new(0, 0, 0, 19)
NameInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
NameInput.Text = ""
NameInput.PlaceholderText = "Enter new name..."
NameInput.TextColor3 = Color3.fromRGB(255, 255, 255)
NameInput.Font = Enum.Font.SourceSans
NameInput.TextSize = 12
NameInput.Parent = NameContainer

local NameInputCorner = Instance.new("UICorner")
NameInputCorner.CornerRadius = UDim.new(0, 4)
NameInputCorner.Parent = NameInput

local NameApplyBtn = Instance.new("TextButton")
NameApplyBtn.Size = UDim2.new(0, 75, 0, 26)
NameApplyBtn.Position = UDim2.new(0, 200, 0, 19)
NameApplyBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 200)
NameApplyBtn.Text = "Apply"
NameApplyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
NameApplyBtn.Font = Enum.Font.SourceSansBold
NameApplyBtn.TextSize = 12
NameApplyBtn.Parent = NameContainer

local NameApplyCorner = Instance.new("UICorner")
NameApplyCorner.CornerRadius = UDim.new(0, 4)
NameApplyCorner.Parent = NameApplyBtn

NameApplyBtn.MouseButton1Click:Connect(function()
	local newName = NameInput.Text
	if newName ~= "" then
		menuName = newName .. " (Solar)"
		TitleLabel.Text = menuName
		NameInput.Text = ""
	end
end)

-- Transparency
local TransparencyContainer = Instance.new("Frame")
TransparencyContainer.Size = UDim2.new(0, 350, 0, 55)
TransparencyContainer.BackgroundTransparency = 1
TransparencyContainer.Parent = MenuScrolling

local TransparencyTitle = Instance.new("TextLabel")
TransparencyTitle.Size = UDim2.new(1, 0, 0, 18)
TransparencyTitle.BackgroundTransparency = 1
TransparencyTitle.Text = "Transparency: " .. string.format("%.1f", menuTransparency)
TransparencyTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
TransparencyTitle.Font = Enum.Font.SourceSansSemibold
TransparencyTitle.TextSize = 12
TransparencyTitle.Parent = TransparencyContainer

local TransparencyBg = Instance.new("Frame")
TransparencyBg.Size = UDim2.new(1, 0, 0, 8)
TransparencyBg.Position = UDim2.new(0, 0, 0, 22)
TransparencyBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TransparencyBg.BorderSizePixel = 0
TransparencyBg.Parent = TransparencyContainer

local TransparencyBgCorner = Instance.new("UICorner")
TransparencyBgCorner.CornerRadius = UDim.new(0, 4)
TransparencyBgCorner.Parent = TransparencyBg

local TransparencyFill = Instance.new("Frame")
TransparencyFill.Size = UDim2.new(0, 0, 1, 0)
TransparencyFill.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
TransparencyFill.BorderSizePixel = 0
TransparencyFill.Parent = TransparencyBg

local TransparencyFillCorner = Instance.new("UICorner")
TransparencyFillCorner.CornerRadius = UDim.new(0, 4)
TransparencyFillCorner.Parent = TransparencyFill

local TransparencyBtn = Instance.new("ImageButton")
TransparencyBtn.Size = UDim2.new(0, 14, 0, 14)
TransparencyBtn.Position = UDim2.new(0, -7, 0.5, -7)
TransparencyBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TransparencyBtn.Image = ""
TransparencyBtn.Parent = TransparencyBg

local TransparencyBtnCorner = Instance.new("UICorner")
TransparencyBtnCorner.CornerRadius = UDim.new(1, 0)
TransparencyBtnCorner.Parent = TransparencyBtn

-- Corner Radius
local CornerContainer = Instance.new("Frame")
CornerContainer.Size = UDim2.new(0, 350, 0, 55)
CornerContainer.BackgroundTransparency = 1
CornerContainer.Parent = MenuScrolling

local CornerTitle = Instance.new("TextLabel")
CornerTitle.Size = UDim2.new(1, 0, 0, 18)
CornerTitle.BackgroundTransparency = 1
CornerTitle.Text = "Corner Radius: " .. cornerRadius
CornerTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
CornerTitle.Font = Enum.Font.SourceSansSemibold
CornerTitle.TextSize = 12
CornerTitle.Parent = CornerContainer

local CornerBg = Instance.new("Frame")
CornerBg.Size = UDim2.new(1, 0, 0, 8)
CornerBg.Position = UDim2.new(0, 0, 0, 22)
CornerBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
CornerBg.BorderSizePixel = 0
CornerBg.Parent = CornerContainer

local CornerBgCorner = Instance.new("UICorner")
CornerBgCorner.CornerRadius = UDim.new(0, 4)
CornerBgCorner.Parent = CornerBg

local CornerFill = Instance.new("Frame")
CornerFill.Size = UDim2.new(0.4, 0, 1, 0)
CornerFill.BackgroundColor3 = Color3.fromRGB(255, 100, 255)
CornerFill.BorderSizePixel = 0
CornerFill.Parent = CornerBg

local CornerFillCorner = Instance.new("UICorner")
CornerFillCorner.CornerRadius = UDim.new(0, 4)
CornerFillCorner.Parent = CornerFill

local CornerBtn = Instance.new("ImageButton")
CornerBtn.Size = UDim2.new(0, 14, 0, 14)
CornerBtn.Position = UDim2.new(0.4, -7, 0.5, -7)
CornerBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CornerBtn.Image = ""
CornerBtn.Parent = CornerBg

local CornerBtnCorner = Instance.new("UICorner")
CornerBtnCorner.CornerRadius = UDim.new(1, 0)
CornerBtnCorner.Parent = CornerBtn

-- Text Size
local TextSizeContainer = Instance.new("Frame")
TextSizeContainer.Size = UDim2.new(0, 350, 0, 55)
TextSizeContainer.BackgroundTransparency = 1
TextSizeContainer.Parent = MenuScrolling

local TextSizeTitle = Instance.new("TextLabel")
TextSizeTitle.Size = UDim2.new(1, 0, 0, 18)
TextSizeTitle.BackgroundTransparency = 1
TextSizeTitle.Text = "Text Size: " .. textSize
TextSizeTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
TextSizeTitle.Font = Enum.Font.SourceSansSemibold
TextSizeTitle.TextSize = 12
TextSizeTitle.Parent = TextSizeContainer

local TextSizeBg = Instance.new("Frame")
TextSizeBg.Size = UDim2.new(1, 0, 0, 8)
TextSizeBg.Position = UDim2.new(0, 0, 0, 22)
TextSizeBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TextSizeBg.BorderSizePixel = 0
TextSizeBg.Parent = TextSizeContainer

local TextSizeBgCorner = Instance.new("UICorner")
TextSizeBgCorner.CornerRadius = UDim.new(0, 4)
TextSizeBgCorner.Parent = TextSizeBg

local TextSizeFill = Instance.new("Frame")
TextSizeFill.Size = UDim2.new(0.4, 0, 1, 0)
TextSizeFill.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
TextSizeFill.BorderSizePixel = 0
TextSizeFill.Parent = TextSizeBg

local TextSizeFillCorner = Instance.new("UICorner")
TextSizeFillCorner.CornerRadius = UDim.new(0, 4)
TextSizeFillCorner.Parent = TextSizeFill

local TextSizeBtn = Instance.new("ImageButton")
TextSizeBtn.Size = UDim2.new(0, 14, 0, 14)
TextSizeBtn.Position = UDim2.new(0.4, -7, 0.5, -7)
TextSizeBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextSizeBtn.Image = ""
TextSizeBtn.Parent = TextSizeBg

local TextSizeBtnCorner = Instance.new("UICorner")
TextSizeBtnCorner.CornerRadius = UDim.new(1, 0)
TextSizeBtnCorner.Parent = TextSizeBtn

-- ================= ЛЕВЫЕ КНОПКИ =================

local function createNavButton(name, posY, tab, allButtons)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 140, 0, 28)
	btn.Position = UDim2.new(0, 10, 0, posY)
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.Text = name
	btn.TextColor3 = Color3.fromRGB(240, 240, 240)
	btn.Font = Enum.Font.SourceSansSemibold
	btn.TextSize = 13
	btn.Parent = MainFrame

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 5)
	corner.Parent = btn

	btn.MouseButton1Click:Connect(function()
		PlayerTab.Visible = false
		ProtectTab.Visible = false
		AttackTab.Visible = false
		AutomationTab.Visible = false
		ShadersTab.Visible = false
		MiscTab.Visible = false
		MenuTab.Visible = false
		tab.Visible = true
		for _, b in ipairs(allButtons) do b.BackgroundColor3 = Color3.fromRGB(50, 50, 50) end
		btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	end)

	return btn
end

local allNavButtons = {}
allNavButtons[1] = createNavButton("Player", 50, PlayerTab, allNavButtons)
allNavButtons[2] = createNavButton("Protect", 82, ProtectTab, allNavButtons)
allNavButtons[3] = createNavButton("Attack", 114, AttackTab, allNavButtons)
allNavButtons[4] = createNavButton("Automation", 146, AutomationTab, allNavButtons)
allNavButtons[5] = createNavButton("Shaders", 178, ShadersTab, allNavButtons)
allNavButtons[6] = createNavButton("Misc", 210, MiscTab, allNavButtons)
allNavButtons[7] = createNavButton("Menu", 242, MenuTab, allNavButtons)
allNavButtons[1].BackgroundColor3 = Color3.fromRGB(70, 70, 70)

-- Bind
local KeybindsButton = Instance.new("TextButton")
KeybindsButton.Size = UDim2.new(0, 140, 0, 28)
KeybindsButton.Position = UDim2.new(0, 10, 0, 274)
KeybindsButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
KeybindsButton.Text = "Bind: " .. toggleKey.Name
KeybindsButton.TextColor3 = Color3.fromRGB(240, 240, 240)
KeybindsButton.Font = Enum.Font.SourceSansSemibold
KeybindsButton.TextSize = 13
KeybindsButton.Parent = MainFrame

local KeybindsCorner = Instance.new("UICorner")
KeybindsCorner.CornerRadius = UDim.new(0, 5)
KeybindsCorner.Parent = KeybindsButton

KeybindsButton.MouseButton1Click:Connect(function()
	if not isListeningForKey then
		isListeningForKey = true
		KeybindsButton.Text = "Press any key..."
	end
end)

-- Профиль
local ProfileFrame = Instance.new("Frame")
ProfileFrame.Size = UDim2.new(0, 150, 0, 55)
ProfileFrame.Position = UDim2.new(0, 10, 1, -65)
ProfileFrame.BackgroundTransparency = 1
ProfileFrame.Parent = MainFrame

local AvatarImage = Instance.new("ImageLabel")
AvatarImage.Size = UDim2.new(0, 40, 0, 40)
AvatarImage.Position = UDim2.new(0, 0, 0.5, -20)
AvatarImage.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
AvatarImage.BorderSizePixel = 0

local content = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size100x100)
AvatarImage.Image = content
AvatarImage.Parent = ProfileFrame

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(0.5, 0)
AvatarCorner.Parent = AvatarImage

local UsernameLabel = Instance.new("TextLabel")
UsernameLabel.Size = UDim2.new(1, -48, 1, 0)
UsernameLabel.Position = UDim2.new(0, 48, 0, 0)
UsernameLabel.BackgroundTransparency = 1
UsernameLabel.Text = LocalPlayer.Name
UsernameLabel.TextColor3 = Color3.fromRGB(235, 235, 235)
UsernameLabel.TextXAlignment = Enum.TextXAlignment.Left
UsernameLabel.Font = Enum.Font.SourceSansBold
UsernameLabel.TextSize = 14
UsernameLabel.Parent = ProfileFrame

-- ================= СКРЫТИЕ МЕНЮ =================

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end

	if isListeningForKey then
		if input.UserInputType == Enum.UserInputType.Keyboard then
			toggleKey = input.KeyCode
			isListeningForKey = false
			KeybindsButton.Text = "Bind: " .. toggleKey.Name
		end
	else
		if input.KeyCode == toggleKey then
			MainFrame.Visible = not MainFrame.Visible
		end
	end
end)

-- ================= SLIDERS ЛОГИКА =================

local function setupSlider(sliderBtn, sliderBg, sliderFill, titleLabel, minVal, maxVal, currentVal, format, callback)
	local isSliding = false

	sliderBtn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then isSliding = true end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then isSliding = false end
	end)

	local function update(mouseX)
		local barPos = sliderBg.AbsolutePosition.X
		local barSize = sliderBg.AbsoluteSize.X
		local percentage = math.clamp((mouseX - barPos) / barSize, 0, 1)

		sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
		sliderBtn.Position = UDim2.new(percentage, -7, 0.5, -7)

		local val = minVal + (percentage * (maxVal - minVal))
		titleLabel.Text = format:format(val)
		callback(val, percentage)
	end

	UserInputService.InputChanged:Connect(function(input)
		if isSliding and input.UserInputType == Enum.UserInputType.MouseMovement then
			update(input.Position.X)
		end
	end)

	sliderBg.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			isSliding = true
			update(UserInputService:GetMouseLocation().X)
		end
	end)
end

setupSlider(FOVBtn, FOVBg, FOVFill, FOVTitle, 30, 120, Camera.FieldOfView, "Field of View (FOV): %.0f", function(val)
	Camera.FieldOfView = val
end)

setupSlider(StrBtn, StrBg, StrFill, StrTitle, 250, 2500, 1000, "Fling Strength: %.0f", function(val)
	flingStrength = val
end)

setupSlider(FlingDelayBtn, FlingDelayBg, FlingDelayFill, FlingDelayTitle, 0.1, 2, 0.3, "Fling Delay: %.1fs", function(val)
	autoFlingDelay = val
end)

setupSlider(GrabRadiusBtn, GrabRadiusBg, GrabRadiusFill, GrabRadiusTitle, 10, 200, 50, "Grab Radius: %.0f", function(val)
	autoGrabRadius = val
end)

setupSlider(BringHeightBtn, BringHeightBg, BringHeightFill, BringHeightTitle, 1, 20, 5, "Bring Height: %.0f", function(val)
	bringItemsHeight = val
end)

setupSlider(WSBtn, WSBg, WSFill, WSTitle, 16, 500, 16, "WalkSpeed: %.0f", function(val)
	wsValue = val
	if wsEnabled then
		local char = LocalPlayer.Character
		if char then
			local hum = char:FindFirstChild("Humanoid")
			if hum then hum.WalkSpeed = val end
		end
		WSToggleBtn.Text = "WalkSpeed Changer: ON (" .. val .. ")"
	end
end)

setupSlider(JPBtn, JPBg, JPFill, JPTitle, 50, 500, 50, "JumpPower: %.0f", function(val)
	jpValue = val
	if jpEnabled then
		local char = LocalPlayer.Character
		if char then
			local hum = char:FindFirstChild("Humanoid")
			if hum then hum.JumpPower = val end
		end
		JPToggleBtn.Text = "JumpPower Changer: ON (" .. val .. ")"
	end
end)

setupSlider(ReachBtn, ReachBg, ReachFill, ReachTitle, 8, 1000, 8, "Reach: %.0f", function(val)
	reachValue = val
	if reachEnabled then
		ReachToggleBtn.Text = "Reach Mod: ON (" .. val .. ")"
	end
end)

setupSlider(ScaleBtn, ScaleBg, ScaleFill, ScaleTitle, 0.5, 2, 1, "Scale Menu: %.1f", function(val)
	menuScale = val
	updateMenuScale()
end)

setupSlider(BrightnessBtn, BrightnessBg, BrightnessFill, BrightnessTitle, 0, 1, 1, "Brightness: %.1f", function(val)
	brightnessMultiplier = val
	applyBrightness()
end)

setupSlider(TransparencyBtn, TransparencyBg, TransparencyFill, TransparencyTitle, 0, 1, 0, "Transparency: %.1f", function(val)
	menuTransparency = val
	MainFrame.BackgroundTransparency = menuTransparency
	DragPanel.BackgroundTransparency = menuTransparency * 0.5
end)

setupSlider(CornerBtn, CornerBg, CornerFill, CornerTitle, 0, 30, 12, "Corner Radius: %.0f", function(val)
	cornerRadius = val
	MainCorner.CornerRadius = UDim.new(0, cornerRadius)
	DragCorner.CornerRadius = UDim.new(0, cornerRadius)
end)

setupSlider(TextSizeBtn, TextSizeBg, TextSizeFill, TextSizeTitle, 8, 38, 16, "Text Size: %.0f", function(val)
	textSize = val
	TitleLabel.TextSize = textSize
end)

-- ================= ФУНКЦИИ МЕНЮ =================

function updateMenuColor()
	if selectedColorName == "Rainbow Gradient" then
		local gradient = Instance.new("UIGradient")
		gradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
			ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 255, 0)),
			ColorSequenceKeypoint.new(0.4, Color3.fromRGB(0, 255, 0)),
			ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 255)),
			ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 0, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))
		})
		gradient.Parent = MainFrame
		for _, child in ipairs(MainFrame:GetChildren()) do
			if child:IsA("UIGradient") and child ~= gradient then child:Destroy() end
		end
	else
		for _, child in ipairs(MainFrame:GetChildren()) do
			if child:IsA("UIGradient") then child:Destroy() end
		end
		currentColor = colors[selectedColorName]
		applyBrightness()
	end
end

function applyBrightness()
	local r = math.clamp(currentColor.R * brightnessMultiplier, 0, 1)
	local g = math.clamp(currentColor.G * brightnessMultiplier, 0, 1)
	local b = math.clamp(currentColor.B * brightnessMultiplier, 0, 1)
	MainFrame.BackgroundColor3 = Color3.new(r, g, b)
end

function updateMenuScale()
	MainFrame.Size = UDim2.new(0, 550 * menuScale, 0, 420 * menuScale)
	MainFrame.Position = UDim2.new(0.5, -275 * menuScale, 0.5, -210 * menuScale)
end

-- ================= PROTECT ФУНКЦИИ =================

function spawnAntiKick()
	local char = LocalPlayer.Character
	if not char then return end
	local shuriken = Instance.new("Part")
	shuriken.Name = "AntiKickShuriken"
	shuriken.Size = Vector3.new(0.5, 0.5, 0.5)
	shuriken.CanCollide = false
	shuriken.Anchored = false
	shuriken.Parent = Workspace
	local rightLeg = char:FindFirstChild("RightFoot") or char:FindFirstChild("RightLowerLeg")
	if rightLeg then
		local weld = Instance.new("WeldConstraint")
		weld.Part0 = shuriken
		weld.Part1 = rightLeg
		weld.Parent = shuriken
	end
	antiKickShuriken = shuriken
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

local function setupAntiGrab()
	local char = LocalPlayer.Character
	if not char then return end
	local root = char:FindFirstChild("HumanoidRootPart")
	if not root then return end
	for _, child in ipairs(char:GetChildren()) do
		if child:IsA("WeldConstraint") or child:IsA("RopeConstraint") then
			if child.Part1 and child.Part1 ~= root then
				local tp = Players:GetPlayerFromCharacter(child.Part1.Parent)
				if tp and tp ~= LocalPlayer then
					local orig = root.CFrame
					root.CFrame = root.CFrame + Vector3.new(0, 500, 0)
					task.wait()
					root.CFrame = orig
					child:Destroy()
				end
			end
		end
	end
end

local function setupAntiBurn()
	local char = LocalPlayer.Character
	if not char then return end
	for _, part in ipairs(char:GetDescendants()) do
		if part:IsA("BasePart") and part:FindFirstChild("Fire") then
			local ext = Instance.new("Part")
			ext.Size = Vector3.new(2, 2, 2)
			ext.CFrame = char:FindFirstChild("HumanoidRootPart").CFrame
			ext.Anchored = true; ext.CanCollide = false; ext.Transparency = 1
			ext.Parent = Workspace
			for _, f in ipairs(part:GetChildren()) do if f:IsA("Fire") then f:Destroy() end end
			task.wait(0.5)
			ext.CFrame = CFrame.new(0, -500, 0)
			task.wait(0.1)
			ext:Destroy()
		end
	end
end

local function setupAntiFling()
	local char = LocalPlayer.Character
	if not char then return end
	local root = char:FindFirstChild("HumanoidRootPart")
	if not root then return end
	if lastStablePosition and root.Velocity.Magnitude > 50 then
		root.CFrame = lastStablePosition
		root.Velocity = Vector3.new(0, 0, 0)
	end
end

local function setupGucciAntiGrab()
	local char = LocalPlayer.Character
	if not char then return end
	local root = char:FindFirstChild("HumanoidRootPart")
	local hum = char:FindFirstChild("Humanoid")
	if not root or not hum then return end
	for _, child in ipairs(char:GetChildren()) do
		if child:IsA("WeldConstraint") and child.Part1 and child.Part1 ~= root then
			local tp = Players:GetPlayerFromCharacter(child.Part1.Parent)
			if tp and tp ~= LocalPlayer then
				local blob = Instance.new("Part")
				blob.Size = Vector3.new(4, 1, 4)
				blob.CFrame = root.CFrame + Vector3.new(0, 300, 0)
				blob.Anchored = true; blob.CanCollide = true; blob.Transparency = 1
				blob.Parent = Workspace
				local orig = root.CFrame
				root.CFrame = blob.CFrame * CFrame.new(0, 2, 0)
				task.wait(0.1); hum.Sit = true; task.wait(0.1); hum.Sit = false; task.wait(0.1)
				root.CFrame = orig
				blob:Destroy()
			end
		end
	end
end

local function setupAntiStun()
	local char = LocalPlayer.Character
	if not char then return end
	local root = char:FindFirstChild("HumanoidRootPart")
	local hum = char:FindFirstChild("Humanoid")
	if not root or not hum then return end
	if hum:GetState() == Enum.HumanoidStateType.Physics and lastStablePosition then
		root.CFrame = lastStablePosition
		root.Velocity = Vector3.new(0, 0, 0)
	end
end

function startAntiKill()
	antiKillConnection = RunService.Heartbeat:Connect(function()
		local char = LocalPlayer.Character
		if not char then return end
		local head = char:FindFirstChild("Head")
		local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
		if head and torso then
			local distance = (head.Position - torso.Position).Magnitude
			if distance > 5 then
				head.CFrame = torso.CFrame * CFrame.new(0, 2, 0)
			end
			local neck = torso:FindFirstChild("Neck")
			if not neck then
				local newNeck = Instance.new("Motor6D")
				newNeck.Name = "Neck"
				newNeck.Part0 = torso
				newNeck.Part1 = head
				newNeck.C0 = CFrame.new(0, 1, 0)
				newNeck.C1 = CFrame.new(0, -0.5, 0)
				newNeck.Parent = torso
			end
		end
	end)
end

function stopAntiKill()
	if antiKillConnection then antiKillConnection:Disconnect(); antiKillConnection = nil end
end

function startAntiBring()
	antiBringConnection = RunService.Heartbeat:Connect(function()
		local char = LocalPlayer.Character
		if not char then return end
		local root = char:FindFirstChild("HumanoidRootPart")
		if not root then return end
		if lastStablePosition then
			local delta = (root.Position - lastStablePosition.Position).Magnitude
			if delta > 100 then
				root.CFrame = lastStablePosition
				root.Velocity = Vector3.new(0, 0, 0)
			end
		end
	end)
end

function stopAntiBring()
	if antiBringConnection then antiBringConnection:Disconnect(); antiBringConnection = nil end
end

-- ================= ATTACK ФУНКЦИИ =================

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
						local lastInput = UserInputService:GetLastInputType()
						if lastInput == Enum.UserInputType.MouseButton2 then
							bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
							bv.Velocity = Camera.CFrame.LookVector * flingStrength
							Debris:AddItem(bv, 1)
						else
							bv:Destroy()
						end
					end
				end)
			end
		end
	end
end)

local function setupKillGrab()
	if not killGrabEnabled then return end
	local char = LocalPlayer.Character
	if not char then return end
	local root = char:FindFirstChild("HumanoidRootPart")
	if not root then return end
	local targetRoot = nil
	for _, child in ipairs(char:GetChildren()) do
		if child:IsA("WeldConstraint") and child.Part1 and child.Part1 ~= root then
			local tp = Players:GetPlayerFromCharacter(child.Part1.Parent)
			if tp and tp ~= LocalPlayer then
				targetRoot = child.Part1
				local orig = root.CFrame
				local water = CFrame.new(0, -10, 0)
				root.CFrame = water; targetRoot.CFrame = water
				child:Destroy()
				task.wait(0.5)
				root.CFrame = orig
				break
			end
		end
	end
end

local function setupKickGrab()
	if not kickGrabEnabled then return end
	local char = LocalPlayer.Character
	if not char then return end
	local root = char:FindFirstChild("HumanoidRootPart")
	if not root then return end
	for _, child in ipairs(char:GetChildren()) do
		if child:IsA("WeldConstraint") and child.Part1 and child.Part1 ~= root then
			local tp = Players:GetPlayerFromCharacter(child.Part1.Parent)
			if tp and tp ~= LocalPlayer then
				local tr = child.Part1
				local th = tp.Character and tp.Character:FindFirstChild("Humanoid")
				if th then
					th.PlatformStand = true; tr.Velocity = Vector3.zero; tr.Anchored = true
					task.wait(2); tr.Anchored = false; th.PlatformStand = false
				end
			end
		end
	end
end

-- ================= AUTOMATION ФУНКЦИИ =================

function startAutoFlingAll()
	autoFlingConnection = RunService.Heartbeat:Connect(function()
		if not autoFlingAllEnabled then return end
		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= LocalPlayer and player.Character then
				local root = player.Character:FindFirstChild("HumanoidRootPart")
				if root then
					local bv = Instance.new("BodyVelocity")
					bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
					bv.Velocity = Vector3.new(0, 10000, 0)
					bv.P = math.huge
					bv.Parent = root
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
		if not autoGrabEnabled then return end
		local char = LocalPlayer.Character
		if not char then return end
		local root = char:FindFirstChild("HumanoidRootPart")
		if not root then return end

		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= LocalPlayer and player.Character then
				local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
				if targetRoot and (targetRoot.Position - root.Position).Magnitude <= autoGrabRadius then
					local existing = false
					for _, child in ipairs(char:GetChildren()) do
						if child:IsA("WeldConstraint") and child.Part1 == targetRoot then
							existing = true; break
						end
					end
					if not existing then
						local weld = Instance.new("WeldConstraint")
						weld.Part0 = root; weld.Part1 = targetRoot
						weld.Parent = char
					end
				end
			end
		end

		for _, obj in ipairs(Workspace:GetDescendants()) do
			if obj:IsA("BasePart") and obj.CanCollide and not obj.Anchored and not obj.Parent:IsA("Model") then
				if (obj.Position - root.Position).Magnitude <= autoGrabRadius then
					local weld = Instance.new("WeldConstraint")
					weld.Part0 = root; weld.Part1 = obj
					weld.Parent = char
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
		if not autoBringItemsEnabled then return end
		local char = LocalPlayer.Character
		if not char then return end
		local root = char:FindFirstChild("HumanoidRootPart")
		if not root then return end

		local centerPos = root.Position + root.CFrame.LookVector * 10 + Vector3.new(0, bringItemsHeight, 0)

		for _, obj in ipairs(Workspace:GetDescendants()) do
			if obj:IsA("BasePart") and not obj.Anchored and obj.CanCollide then
				local parent = obj.Parent
				if not parent:FindFirstChildOfClass("Humanoid") and parent ~= char then
					obj.CFrame = centerPos + Vector3.new(math.random(-3, 3), math.random(-1, 1), math.random(-3, 3))
				end
			end
		end
	end)
end

function stopAutoBringItems()
	if autoBringConnection then autoBringConnection:Disconnect(); autoBringConnection = nil end
end

-- ================= PLAYER ФУНКЦИИ =================

function startNoclip()
	noclipConnection = RunService.Stepped:Connect(function()
		if LocalPlayer.Character then
			for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
				if part:IsA("BasePart") then part.CanCollide = false end
			end
		end
	end)
end

function stopNoclip()
	if noclipConnection then noclipConnection:Disconnect(); noclipConnection = nil end
	if LocalPlayer.Character then
		for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
			if part:IsA("BasePart") then part.CanCollide = true end
		end
	end
end

function startInfiniteJump()
	infiniteJumpConnection = UserInputService.JumpRequest:Connect(function()
		if not infiniteJumpEnabled then return end
		local char = LocalPlayer.Character
		if char then
			local hum = char:FindFirstChild("Humanoid")
			if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
		end
	end)
end

function stopInfiniteJump()
	if infiniteJumpConnection then infiniteJumpConnection:Disconnect(); infiniteJumpConnection = nil end
end

-- ================= MISC ФУНКЦИИ =================

function enableWalkWater()
	for _, part in ipairs(Workspace:GetDescendants()) do
		if part:IsA("BasePart") and part.Material == Enum.Material.Water then
			part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 100, 0)
		end
	end
end

function disableWalkWater()
	for _, part in ipairs(Workspace:GetDescendants()) do
		if part:IsA("BasePart") and part.Material == Enum.Material.Water then
			part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
		end
	end
end

-- ================= ГЛАВНЫЙ ЦИКЛ =================

RunService.Heartbeat:Connect(function()
	local char = LocalPlayer.Character
	if not char then return end
	local root = char:FindFirstChild("HumanoidRootPart")
	if not root then return end

	if root.Velocity.Magnitude < 10 then lastStablePosition = root.CFrame end

	if wsEnabled then
		local hum = char:FindFirstChild("Humanoid")
		if hum then hum.WalkSpeed = wsValue end
	end
	if jpEnabled then
		local hum = char:FindFirstChild("Humanoid")
		if hum then hum.JumpPower = jpValue end
	end

	if antiGrabEnabled then setupAntiGrab() end
	if antiBurnEnabled then setupAntiBurn() end
	if antiFlingEnabled then setupAntiFling() end
	if gucciAntiGrabEnabled then setupGucciAntiGrab() end
	if antiStunEnabled then setupAntiStun() end
	if killGrabEnabled then setupKillGrab() end
	if kickGrabEnabled then setupKickGrab() end
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

-- ================= ОЧИСТКА ПРИ СМЕРТИ =================

LocalPlayer.CharacterAdded:Connect(function()
	removeAntiKick()
	if antiKickEnabled then task.wait(0.5); spawnAntiKick() end
	if walkWaterEnabled then enableWalkWater() end
	if noclipEnabled then startNoclip() end
end)
