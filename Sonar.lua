local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Debris = game:GetService("Debris")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local toggleKey = Enum.KeyCode.RightShift
local isListeningForKey = false
local strength = 10000

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
MainFrame.Size = UDim2.new(0, 500, 0, 380)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Верхняя панель "Solar"
local DragPanel = Instance.new("Frame")
DragPanel.Size = UDim2.new(1, 0, 0, 35)
DragPanel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
DragPanel.BorderSizePixel = 0
DragPanel.Parent = MainFrame

local DragCorner = Instance.new("UICorner")
DragCorner.CornerRadius = UDim.new(0, 12)
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
TitleLabel.Text = "Solar"
TitleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 16
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
local KeybindsTab = Instance.new("Frame")
KeybindsTab.Size = UDim2.new(1, -161, 1, -35)
KeybindsTab.Position = UDim2.new(0, 161, 0, 35)
KeybindsTab.BackgroundTransparency = 1
KeybindsTab.Visible = true
KeybindsTab.Parent = MainFrame

local MiscTab = Instance.new("Frame")
MiscTab.Size = UDim2.new(1, -161, 1, -35)
MiscTab.Position = UDim2.new(0, 161, 0, 35)
MiscTab.BackgroundTransparency = 1
MiscTab.Visible = false
MiscTab.Parent = MainFrame

local TargetTab = Instance.new("Frame")
TargetTab.Size = UDim2.new(1, -161, 1, -35)
TargetTab.Position = UDim2.new(0, 161, 0, 35)
TargetTab.BackgroundTransparency = 1
TargetTab.Visible = false
TargetTab.Parent = MainFrame

local KeybindsInfo = Instance.new("TextLabel")
KeybindsInfo.Size = UDim2.new(1, 0, 1, 0)
KeybindsInfo.BackgroundTransparency = 1
KeybindsInfo.Text = "Нажмите 'Bind' слева для смены кнопки скрытия"
KeybindsInfo.TextColor3 = Color3.fromRGB(150, 150, 150)
KeybindsInfo.Font = Enum.Font.SourceSans
KeybindsInfo.TextSize = 15
KeybindsInfo.Parent = KeybindsTab

-- ================= ВКЛАДКА MISC (FOV СЛАЙДЕР) =================

local SliderContainer = Instance.new("Frame")
SliderContainer.Size = UDim2.new(0, 300, 0, 60)
SliderContainer.Position = UDim2.new(0.5, -150, 0, 20)
SliderContainer.BackgroundTransparency = 1
SliderContainer.Parent = MiscTab

local SliderTitle = Instance.new("TextLabel")
SliderTitle.Size = UDim2.new(1, 0, 0, 20)
SliderTitle.BackgroundTransparency = 1
SliderTitle.Text = "Field of View (FOV): " .. math.round(Camera.FieldOfView)
SliderTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
SliderTitle.Font = Enum.Font.SourceSansSemibold
SliderTitle.TextSize = 14
SliderTitle.Parent = SliderContainer

local SliderBackground = Instance.new("Frame")
SliderBackground.Size = UDim2.new(1, 0, 0, 8)
SliderBackground.Position = UDim2.new(0, 0, 0, 30)
SliderBackground.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SliderBackground.BorderSizePixel = 0
SliderBackground.Parent = SliderContainer

local SliderBgCorner = Instance.new("UICorner")
SliderBgCorner.CornerRadius = UDim.new(0, 4)
SliderBgCorner.Parent = SliderBackground

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new(0.3, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(0, 160, 255)
SliderFill.BorderSizePixel = 0
SliderFill.Parent = SliderBackground

local SliderFillCorner = Instance.new("UICorner")
SliderFillCorner.CornerRadius = UDim.new(0, 4)
SliderFillCorner.Parent = SliderFill

local SliderButton = Instance.new("ImageButton")
SliderButton.Size = UDim2.new(0, 16, 0, 16)
SliderButton.Position = UDim2.new(0.3, -8, 0.5, -8)
SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SliderButton.Image = ""
SliderButton.Parent = SliderBackground

local SliderBtnCorner = Instance.new("UICorner")
SliderBtnCorner.CornerRadius = UDim.new(1, 0)
SliderBtnCorner.Parent = SliderButton

local minFov = 30
local maxFov = 120
local defaultFov = Camera.FieldOfView
local currentPercentage = (defaultFov - minFov) / (maxFov - minFov)

SliderFill.Size = UDim2.new(currentPercentage, 0, 1, 0)
SliderButton.Position = UDim2.new(currentPercentage, -8, 0.5, -8)

-- ================= ВКЛАДКА TARGET =================

local PlayerDropdown = Instance.new("TextButton")
PlayerDropdown.Size = UDim2.new(0, 280, 0, 32)
PlayerDropdown.Position = UDim2.new(0, 20, 0, 20)
PlayerDropdown.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
PlayerDropdown.Text = "Выберите игрока..."
PlayerDropdown.TextColor3 = Color3.fromRGB(200, 200, 200)
PlayerDropdown.Font = Enum.Font.SourceSans
PlayerDropdown.TextSize = 14
PlayerDropdown.TextXAlignment = Enum.TextXAlignment.Left
PlayerDropdown.Parent = TargetTab

local DropdownCorner = Instance.new("UICorner")
DropdownCorner.CornerRadius = UDim.new(0, 6)
DropdownCorner.Parent = PlayerDropdown

local DropArrow = Instance.new("TextLabel")
DropArrow.Size = UDim2.new(0, 20, 1, 0)
DropArrow.Position = UDim2.new(1, -25, 0, 0)
DropArrow.BackgroundTransparency = 1
DropArrow.Text = "▼"
DropArrow.TextColor3 = Color3.fromRGB(150, 150, 150)
DropArrow.Font = Enum.Font.SourceSansBold
DropArrow.TextSize = 12
DropArrow.Parent = PlayerDropdown

local DropList = Instance.new("ScrollingFrame")
DropList.Size = UDim2.new(0, 280, 0, 160)
DropList.Position = UDim2.new(0, 20, 0, 55)
DropList.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
DropList.BorderSizePixel = 1
DropList.BorderColor3 = Color3.fromRGB(60, 60, 60)
DropList.Visible = false
DropList.ScrollBarThickness = 4
DropList.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
DropList.CanvasSize = UDim2.new(0, 0, 0, 0)
DropList.Parent = TargetTab

local DropListCorner = Instance.new("UICorner")
DropListCorner.CornerRadius = UDim.new(0, 6)
DropListCorner.Parent = DropList

local DropListLayout = Instance.new("UIListLayout")
DropListLayout.Padding = UDim.new(0, 2)
DropListLayout.Parent = DropList

-- Кнопка TARGET
local TargetActionBtn = Instance.new("TextButton")
TargetActionBtn.Size = UDim2.new(0, 280, 0, 40)
TargetActionBtn.Position = UDim2.new(0, 20, 0, 225)
TargetActionBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
TargetActionBtn.Text = "TARGET (AIM + FLING UP)"
TargetActionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TargetActionBtn.Font = Enum.Font.SourceSansBold
TargetActionBtn.TextSize = 14
TargetActionBtn.Parent = TargetTab

local TargetBtnCorner2 = Instance.new("UICorner")
TargetBtnCorner2.CornerRadius = UDim.new(0, 8)
TargetBtnCorner2.Parent = TargetActionBtn

local TargetStatus = Instance.new("TextLabel")
TargetStatus.Size = UDim2.new(0, 280, 0, 20)
TargetStatus.Position = UDim2.new(0, 20, 0, 275)
TargetStatus.BackgroundTransparency = 1
TargetStatus.Text = "Выберите игрока и нажмите TARGET"
TargetStatus.TextColor3 = Color3.fromRGB(180, 180, 180)
TargetStatus.Font = Enum.Font.SourceSansItalic
TargetStatus.TextSize = 12
TargetStatus.TextXAlignment = Enum.TextXAlignment.Left
TargetStatus.Parent = TargetTab

-- ================= ЛЕВЫЕ КНОПКИ НАВИГАЦИИ =================

local MiscButton = Instance.new("TextButton")
MiscButton.Size = UDim2.new(0, 140, 0, 32)
MiscButton.Position = UDim2.new(0, 10, 0, 50)
MiscButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MiscButton.Text = "Misc"
MiscButton.TextColor3 = Color3.fromRGB(240, 240, 240)
MiscButton.Font = Enum.Font.SourceSansSemibold
MiscButton.TextSize = 15
MiscButton.Parent = MainFrame

local MiscCorner = Instance.new("UICorner")
MiscCorner.CornerRadius = UDim.new(0, 6)
MiscCorner.Parent = MiscButton

local TargetButton = Instance.new("TextButton")
TargetButton.Size = UDim2.new(0, 140, 0, 32)
TargetButton.Position = UDim2.new(0, 10, 0, 95)
TargetButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TargetButton.Text = "Target"
TargetButton.TextColor3 = Color3.fromRGB(240, 240, 240)
TargetButton.Font = Enum.Font.SourceSansSemibold
TargetButton.TextSize = 15
TargetButton.Parent = MainFrame

local TargetBtnCorner = Instance.new("UICorner")
TargetBtnCorner.CornerRadius = UDim.new(0, 6)
TargetBtnCorner.Parent = TargetButton

local KeybindsButton = Instance.new("TextButton")
KeybindsButton.Size = UDim2.new(0, 140, 0, 32)
KeybindsButton.Position = UDim2.new(0, 10, 0, 140)
KeybindsButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
KeybindsButton.Text = "Bind: " .. toggleKey.Name
KeybindsButton.TextColor3 = Color3.fromRGB(240, 240, 240)
KeybindsButton.Font = Enum.Font.SourceSansSemibold
KeybindsButton.TextSize = 15
KeybindsButton.Parent = MainFrame

local KeybindsCorner = Instance.new("UICorner")
KeybindsCorner.CornerRadius = UDim.new(0, 6)
KeybindsCorner.Parent = KeybindsButton

-- ================= ПРОФИЛЬ ИГРОКА =================

local ProfileFrame = Instance.new("Frame")
ProfileFrame.Size = UDim2.new(0, 150, 0, 60)
ProfileFrame.Position = UDim2.new(0, 10, 1, -70)
ProfileFrame.BackgroundTransparency = 1
ProfileFrame.Parent = MainFrame

local AvatarImage = Instance.new("ImageLabel")
AvatarImage.Size = UDim2.new(0, 44, 0, 44)
AvatarImage.Position = UDim2.new(0, 0, 0.5, -22)
AvatarImage.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
AvatarImage.BorderSizePixel = 0

local content = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size100x100)
AvatarImage.Image = content
AvatarImage.Parent = ProfileFrame

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(0.5, 0)
AvatarCorner.Parent = AvatarImage

local UsernameLabel = Instance.new("TextLabel")
UsernameLabel.Size = UDim2.new(1, -54, 1, 0)
UsernameLabel.Position = UDim2.new(0, 54, 0, 0)
UsernameLabel.BackgroundTransparency = 1
UsernameLabel.Text = LocalPlayer.Name
UsernameLabel.TextColor3 = Color3.fromRGB(235, 235, 235)
UsernameLabel.TextXAlignment = Enum.TextXAlignment.Left
UsernameLabel.Font = Enum.Font.SourceSansBold
UsernameLabel.TextSize = 16
UsernameLabel.Parent = ProfileFrame

-- ================= ЛОГИКА ПЕРЕКЛЮЧЕНИЯ ВКЛАДОК =================

MiscButton.MouseButton1Click:Connect(function()
	MiscTab.Visible = true
	KeybindsTab.Visible = false
	TargetTab.Visible = false
	MiscButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	TargetButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	KeybindsButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)

TargetButton.MouseButton1Click:Connect(function()
	MiscTab.Visible = false
	KeybindsTab.Visible = false
	TargetTab.Visible = true
	TargetButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	MiscButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	KeybindsButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)

KeybindsButton.MouseButton1Click:Connect(function()
	MiscTab.Visible = false
	KeybindsTab.Visible = true
	TargetTab.Visible = false
	KeybindsButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	MiscButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	TargetButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	
	if not isListeningForKey then
		isListeningForKey = true
		KeybindsButton.Text = "Press any key..."
	end
end)

-- Скрытие / Показ меню
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

-- ================= FOV СЛАЙДЕР ЛОГИКА =================

local isSliding = false

SliderButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		isSliding = true
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		isSliding = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if isSliding and input.UserInputType == Enum.UserInputType.MouseMovement then
		local mousePos = input.Position.X
		local barPos = SliderBackground.AbsolutePosition.X
		local barSize = SliderBackground.AbsoluteSize.X
		local percentage = math.clamp((mousePos - barPos) / barSize, 0, 1)
		
		SliderFill.Size = UDim2.new(percentage, 0, 1, 0)
		SliderButton.Position = UDim2.new(percentage, -8, 0.5, -8)
		
		local currentFov = minFov + (percentage * (maxFov - minFov))
		Camera.FieldOfView = currentFov
		SliderTitle.Text = "Field of View (FOV): " .. math.round(currentFov)
	end
end)

SliderBackground.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		isSliding = true
		local mousePos = UserInputService:GetMouseLocation().X
		local barPos = SliderBackground.AbsolutePosition.X
		local barSize = SliderBackground.AbsoluteSize.X
		local percentage = math.clamp((mousePos - barPos) / barSize, 0, 1)
		
		SliderFill.Size = UDim2.new(percentage, 0, 1, 0)
		SliderButton.Position = UDim2.new(percentage, -8, 0.5, -8)
		
		local currentFov = minFov + (percentage * (maxFov - minFov))
		Camera.FieldOfView = currentFov
		SliderTitle.Text = "Field of View (FOV): " .. math.round(currentFov)
	end
end)

-- ================= TARGET: ВЫПАДАЮЩИЙ СПИСОК =================

local selectedTarget = nil

local function updatePlayerList()
	for _, child in ipairs(DropList:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end
	
	local totalHeight = 0
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			local btn = Instance.new("TextButton")
			btn.Size = UDim2.new(1, -4, 0, 28)
			btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			btn.Text = player.Name
			btn.TextColor3 = Color3.fromRGB(230, 230, 230)
			btn.Font = Enum.Font.SourceSans
			btn.TextSize = 13
			btn.TextXAlignment = Enum.TextXAlignment.Left
			btn.Parent = DropList
			
			local btnCorner = Instance.new("UICorner")
			btnCorner.CornerRadius = UDim.new(0, 4)
			btnCorner.Parent = btn
			
			btn.MouseButton1Click:Connect(function()
				selectedTarget = player
				PlayerDropdown.Text = "Цель: " .. player.Name
				DropList.Visible = false
			end)
			
			totalHeight = totalHeight + 30
		end
	end
	DropList.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
end

updatePlayerList()

PlayerDropdown.MouseButton1Click:Connect(function()
	updatePlayerList()
	DropList.Visible = not DropList.Visible
end)

UserInputService.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		if DropList.Visible then
			local mousePos = UserInputService:GetMouseLocation()
			local listPos = DropList.AbsolutePosition
			local listSize = DropList.AbsoluteSize
			local dropPos = PlayerDropdown.AbsolutePosition
			local dropSize = PlayerDropdown.AbsoluteSize
			
			if not (
				(mousePos.X >= listPos.X and mousePos.X <= listPos.X + listSize.X and
				 mousePos.Y >= listPos.Y and mousePos.Y <= listPos.Y + listSize.Y) or
				(mousePos.X >= dropPos.X and mousePos.X <= dropPos.X + dropSize.X and
				 mousePos.Y >= dropPos.Y and mousePos.Y <= dropPos.Y + dropSize.Y)
			) then
				DropList.Visible = false
			end
		end
	end
end)

-- ================= TARGET: AIM + AUTO FLING UP (БЕЗ НОУКЛИПА) =================

local function aimAndFling(targetPlayer)
	if not targetPlayer or not targetPlayer.Character then return end
	
	local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
	local targetHumanoid = targetPlayer.Character:FindFirstChild("Humanoid")
	
	if not targetRoot then return end
	
	-- Наводим камеру на цель (AIM)
	local targetPos = targetRoot.Position
	local camCFrame = CFrame.new(Camera.CFrame.Position, targetPos)
	Camera.CFrame = camCFrame
	
	TaskStatus.Text = "Камера наведена на " .. targetPlayer.Name .. "..."
	task.wait(0.1)
	
	-- Применяем силу ВВЕРХ через BodyVelocity
	local bv = Instance.new("BodyVelocity")
	bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	bv.Velocity = Vector3.new(0, strength, 0) -- СТРОГО ВВЕРХ
	bv.P = math.huge
	bv.Parent = targetRoot
	
	-- Удаляем BodyVelocity через 0.5 секунды
	Debris:AddItem(bv, 0.5)
	
	-- Отключаем Humanoid чтобы ragdoll сработал
	if targetHumanoid then
		targetHumanoid.PlatformStand = true
		task.delay(0.3, function()
			if targetHumanoid and targetHumanoid.Parent then
				targetHumanoid.PlatformStand = false
			end
		end)
	end
	
	TargetStatus.Text = "Игрок " .. targetPlayer.Name .. " запущен ВВЕРХ с силой " .. strength .. "!"
end

-- Кнопка TARGET
TargetActionBtn.MouseButton1Click:Connect(function()
	if not selectedTarget then
		TargetStatus.Text = "Сначала выберите игрока из списка!"
		return
	end
	if not selectedTarget.Character or not selectedTarget.Character:FindFirstChild("HumanoidRootPart") then
		TargetStatus.Text = "Игрок " .. selectedTarget.Name .. " не на карте!"
		return
	end
	
	aimAndFling(selectedTarget)
end)

-- ================= ПЕРЕТАСКИВАНИЕ ОКНА =================

local dragToggle, dragStart, startPos = nil, nil, nil

DragPanel.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragToggle = true
		dragStart = input.Position
		startPos = MainFrame.Position
	end
end)

DragPanel.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragToggle = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragToggle and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Очистка при смерти
LocalPlayer.CharacterAdded:Connect(function()
	selectedTarget = nil
	PlayerDropdown.Text = "Выберите игрока..."
	TargetStatus.Text = "Выберите игрока и нажмите TARGET"
end)
