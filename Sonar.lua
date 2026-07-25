local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local toggleKey = Enum.KeyCode.RightShift
local isListeningForKey = false

-- Создание UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SolarMenuGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999999 
ScreenGui.IgnoreGuiInset = true 
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Главное окно (увеличили высоту до 380, чтобы влезла третья кнопка)
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

-- НОВАЯ ВКЛАДКА: TARGET TAB
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

-- Элементы внутри вкладки Target
local TargetInput = Instance.new("TextBox")
TargetInput.Size = UDim2.new(0, 200, 0, 30)
TargetInput.Position = UDim2.new(0, 20, 0, 20)
TargetInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TargetInput.PlaceholderText = "Введите ник игрока..."
TargetInput.Text = ""
TargetInput.TextColor3 = Color3.fromRGB(255, 255, 255)
TargetInput.Font = Enum.Font.SourceSans
TargetInput.TextSize = 14
TargetInput.Parent = TargetTab

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 6)
InputCorner.Parent = TargetInput

local AddTargetBtn = Instance.new("TextButton")
AddTargetBtn.Size = UDim2.new(0, 90, 0, 30)
AddTargetBtn.Position = UDim2.new(0, 230, 0, 20)
AddTargetBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 200)
AddTargetBtn.Text = "Add Target"
AddTargetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AddTargetBtn.Font = Enum.Font.SourceSansBold
AddTargetBtn.TextSize = 14
AddTargetBtn.Parent = TargetTab

local AddCorner = Instance.new("UICorner")
AddCorner.CornerRadius = UDim.new(0, 6)
AddCorner.Parent = AddTargetBtn

local TargetListLabel = Instance.new("TextLabel")
TargetListLabel.Size = UDim2.new(0, 300, 0, 20)
TargetListLabel.Position = UDim2.new(0, 20, 0, 65)
TargetListLabel.BackgroundTransparency = 1
TargetListLabel.Text = "Текущие цели: Нет"
TargetListLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
TargetListLabel.Font = Enum.Font.SourceSansItalic
TargetListLabel.TextSize = 14
TargetListLabel.TextXAlignment = Enum.TextXAlignment.Left
TargetListLabel.Parent = TargetTab

local KillTargetBtn = Instance.new("TextButton")
KillTargetBtn.Size = UDim2.new(0, 300, 0, 40)
KillTargetBtn.Position = UDim2.new(0, 20, 0, 100)
KillTargetBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
KillTargetBtn.Text = "KILL TARGET"
KillTargetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
KillTargetBtn.Font = Enum.Font.SourceSansBold
KillTargetBtn.TextSize = 16
KillTargetBtn.Parent = TargetTab

local KillCorner = Instance.new("UICorner")
KillCorner.CornerRadius = UDim.new(0, 8)
KillCorner.Parent = KillTargetBtn

-- Ползунки во вкладке Misc (Оставили старые для FOV)
local SliderContainer = Instance.new("Frame")
SliderContainer.Size = UDim2.new(0, 300, 0, 50)
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
SliderBackground.Size = UDim2.new(1, 0, 0, 6)
SliderBackground.Position = UDim2.new(0, 0, 0, 25)
SliderBackground.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SliderBackground.Parent = SliderContainer

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new(0.3, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(0, 160, 255)
SliderFill.Parent = SliderBackground

local SliderButton = Instance.new("ImageButton")
SliderButton.Size = UDim2.new(0, 14, 0, 14)
SliderButton.Position = UDim2.new(0.3, -7, 0.5, -7)
SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SliderButton.Parent = SliderBackground

-- Левые кнопки навигации
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

-- КНОПКА НАВИГАЦИИ TARGET
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
KeybindsButton.Position = UDim2.new(0, 10, 0, 140) -- Сместилась вниз
KeybindsButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
KeybindsButton.Text = "Bind: " .. toggleKey.Name
KeybindsButton.TextColor3 = Color3.fromRGB(240, 240, 240)
KeybindsButton.Font = Enum.Font.SourceSansSemibold
KeybindsButton.TextSize = 15
KeybindsButton.Parent = MainFrame

local KeybindsCorner = Instance.new("UICorner")
KeybindsCorner.CornerRadius = UDim.new(0, 6)
KeybindsCorner.Parent = KeybindsButton

-- Профиль игрока (сместился в самый низ)
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
-- ================= ЛОГИКА И ИНТЕРАКТИВНОСТЬ =================

local targetsList = {}

-- Переключение вкладок
MiscButton.MouseButton1Click:Connect(function()
	MiscTab.Visible = true; KeybindsTab.Visible = false; TargetTab.Visible = false
	MiscButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	TargetButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	KeybindsButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)

TargetButton.MouseButton1Click:Connect(function()
	MiscTab.Visible = false; KeybindsTab.Visible = false; TargetTab.Visible = true
	TargetButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	MiscButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	KeybindsButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)

KeybindsButton.MouseButton1Click:Connect(function()
	if not isListeningForKey then
		isListeningForKey = true
		KeybindsButton.Text = "Press any key..."
	end
end)

-- Скрытие / Показ меню и смена бинда
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if isListeningForKey then
		if input.UserInputType == Enum.UserInputType.Keyboard then
			toggleKey = input.KeyCode
			isListeningForKey = false
			KeybindsButton.Text = "Bind: " .. toggleKey.Name
			MiscTab.Visible = false; TargetTab.Visible = false; KeybindsTab.Visible = true
			KeybindsButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
			MiscButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			TargetButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		end
	else
		if input.KeyCode == toggleKey then
			MainFrame.Visible = not MainFrame.Visible
		end
	end
end)

-- Логика добавления игроков в список целей
AddTargetBtn.MouseButton1Click:Connect(function()
	local inputText = string.lower(TargetInput.Text)
	if inputText == "" then return end
	
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and string.find(string.lower(player.Name), inputText) or string.find(string.lower(player.DisplayName), inputText) then
			if not table.find(targetsList, player) then
				table.insert(targetsList, player)
				TargetListLabel.Text = "Цель добавлена: " .. player.Name
				TargetInput.Text = ""
				return
			end
		end
	end
	TargetListLabel.Text = "Игрок не найден!"
end)

-- ФУНКЦИЯ KILL TARGET (Мгновенное физическое устранение/выбрасывание через флинг)
local function flingPlayer(targetPlayer)
	if not targetPlayer or not targetPlayer.Character or not LocalPlayer.Character then return end
	
	local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
	local localRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	local localHumanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
	
	if targetRoot and localRoot and localHumanoid then
		-- Сохраняем исходную позицию локального игрока, чтобы вернуться после килла
		local originalCFrame = localRoot.CFrame
		
		-- Отключаем падение в рэгдолл на долю секунды для точности
		localHumanoid.PlatformStand = true
		
		-- Включаем безумную угловую скорость для создания невидимого физического торнадо
		local Velocity = Instance.new("BodyAngularVelocity")
		Velocity.MaxTorque = Vector3.new(1, 1, 1) * math.huge
		Velocity.P = math.huge
		Velocity.AngularVelocity = Vector3.new(10000, 10000, 10000) -- Огромная скорость вращения
		Velocity.Parent = localRoot
		
		-- Серия микро-телепортаций в цель для симуляции сокрушительного физического удара (fling)
		for i = 1, 25 do
			if targetRoot and localRoot then
				localRoot.CFrame = targetRoot.CFrame + Vector3.new(math.random(-1,1)/10, 0, math.random(-1,1)/10)
				task.wait()
			end
		end
		
		-- Наводим порядок: убираем физическую силу и возвращаем на место
		Velocity:Destroy()
		localHumanoid.PlatformStand = false
		localRoot.CFrame = originalCFrame
	end
end

-- Обработка нажатия на главную кнопку KILL TARGET
KillTargetBtn.MouseButton1Click:Connect(function()
	if #targetsList == 0 then
		TargetListLabel.Text = "Сначала добавьте цель!"
		return
	end
	
	TargetListLabel.Text = "Атака целей..."
	for _, targetPlayer in ipairs(targetsList) do
		flingPlayer(targetPlayer)
	end
	
	-- Очищаем список после выполнения атаки
	targetsList = {}
	TargetListLabel.Text = "Цели успешно уничтожены/удалены."
end)

-- Слайдер FOV (из прошлых версий)
local isSliding = false
SliderButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then isSliding = true end
end)
UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then isSliding = false end
end)
UserInputService.InputChanged:Connect(function(input)
	if isSliding and input.UserInputType == Enum.UserInputType.MouseMovement then
		local mousePos = input.Position.X
		local barPos = SliderBackground.AbsolutePosition.X
		local barSize = SliderBackground.AbsoluteSize.X
		local percentage = math.clamp((mousePos - barPos) / barSize, 0, 1)
		SliderFill.Size = UDim2.new(percentage, 0, 1, 0)
		SliderButton.Position = UDim2.new(percentage, -7, 0.5, -7)
		local currentFov = 50 + (percentage * 70)
		Camera.FieldOfView = currentFov
		SliderTitle.Text = "Field of View (FOV): " .. math.round(currentFov)
	end
end)

-- Стабильное перетаскивание
local dragToggle, dragStart, startPos = nil, nil, nil
DragPanel.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragToggle = true; dragStart = input.Position; startPos = MainFrame.Position
	end
end)
DragPanel.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then dragToggle = false end
end)
RunService.RenderStepped:Connect(function()
	if dragToggle then
		local mousePos = UserInputService:GetMouseLocation()
		local delta = mousePos - Vector2.new(dragStart.X, dragStart.Y - 36)
		MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)
