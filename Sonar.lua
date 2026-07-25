local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Настройки клавиши скрытия
local toggleKey = Enum.KeyCode.RightShift
local isListeningForKey = false

-- Создание UI (Поверх всех окон)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PremiumMenuGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999999 
ScreenGui.IgnoreGuiInset = true 
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Главное окно
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true -- Делает окно кликабельным
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- ВЕРХНЯЯ ПАНЕЛЬ ДЛЯ ПЕРЕТАСКИВАНИЯ
local DragPanel = Instance.new("Frame")
DragPanel.Name = "DragPanel"
DragPanel.Size = UDim2.new(1, 0, 0, 35)
DragPanel.Position = UDim2.new(0, 0, 0, 0)
DragPanel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
DragPanel.BorderSizePixel = 0
DragPanel.Parent = MainFrame

local DragCorner = Instance.new("UICorner")
DragCorner.CornerRadius = UDim.new(0, 12)
DragCorner.Parent = DragPanel

local HideCornerFix = Instance.new("Frame")
HideCornerFix.Name = "HideCornerFix"
HideCornerFix.Size = UDim2.new(1, 0, 0, 10)
HideCornerFix.Position = UDim2.new(0, 0, 1, -10)
HideCornerFix.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
HideCornerFix.BorderSizePixel = 0
HideCornerFix.Parent = DragPanel

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, -20, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Main Menu"
TitleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 16
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = DragPanel

-- ВЕРТИКАЛЬНАЯ РАЗДЕЛИТЕЛЬНАЯ ЛИНИЯ
local SeparatorLine = Instance.new("Frame")
SeparatorLine.Name = "SeparatorLine"
SeparatorLine.Size = UDim2.new(0, 1, 1, -35)
SeparatorLine.Position = UDim2.new(0, 160, 0, 35)
SeparatorLine.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SeparatorLine.BorderSizePixel = 0
SeparatorLine.Parent = MainFrame

-- КОНТЕНТНЫЕ ЗОНЫ (ВКЛАДКИ)
local KeybindsTab = Instance.new("Frame")
KeybindsTab.Name = "KeybindsTab"
KeybindsTab.Size = UDim2.new(1, -161, 1, -35)
KeybindsTab.Position = UDim2.new(0, 161, 0, 35)
KeybindsTab.BackgroundTransparency = 1
KeybindsTab.Visible = true -- По умолчанию открыты кейбинды
KeybindsTab.Parent = MainFrame

local MiscTab = Instance.new("Frame")
MiscTab.Name = "MiscTab"
MiscTab.Size = UDim2.new(1, -161, 1, -35)
MiscTab.Position = UDim2.new(0, 161, 0, 35)
MiscTab.BackgroundTransparency = 1
MiscTab.Visible = false -- Изначально скрыта
MiscTab.Parent = MainFrame

-- Содержимое вкладки Keybinds
local KeybindsInfo = Instance.new("TextLabel")
KeybindsInfo.Size = UDim2.new(1, 0, 1, 0)
KeybindsInfo.BackgroundTransparency = 1
KeybindsInfo.Text = "Используйте кнопку слева для смены бинда"
KeybindsInfo.TextColor3 = Color3.fromRGB(150, 150, 150)
KeybindsInfo.Font = Enum.Font.SourceSans
KeybindsInfo.TextSize = 16
KeybindsInfo.Parent = KeybindsTab

-- СОДЕРЖИМОЕ ВКЛАДКИ MISC (ПОЛЗУНОК FOV)
local SliderContainer = Instance.new("Frame")
SliderContainer.Name = "SliderContainer"
SliderContainer.Size = UDim2.new(0, 300, 0, 50)
SliderContainer.Position = UDim2.new(0.5, -150, 0, 30)
SliderContainer.BackgroundTransparency = 1
SliderContainer.Parent = MiscTab

local SliderTitle = Instance.new("TextLabel")
SliderTitle.Name = "SliderTitle"
SliderTitle.Size = UDim2.new(1, 0, 0, 20)
SliderTitle.BackgroundTransparency = 1
SliderTitle.Text = "Field of View (FOV): " .. math.round(Camera.FieldOfView)
SliderTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
SliderTitle.Font = Enum.Font.SourceSansSemibold
SliderTitle.TextSize = 15
SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
SliderTitle.Parent = SliderContainer

local SliderBackground = Instance.new("Frame")
SliderBackground.Name = "SliderBackground"
SliderBackground.Size = UDim2.new(1, 0, 0, 6)
SliderBackground.Position = UDim2.new(0, 0, 0, 28)
SliderBackground.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SliderBackground.BorderSizePixel = 0
SliderBackground.Parent = SliderContainer

local SliderFill = Instance.new("Frame")
SliderFill.Name = "SliderFill"
SliderFill.Size = UDim2.new(0.3, 0, 1, 0) -- Изначальное заполнение
SliderFill.BackgroundColor3 = Color3.fromRGB(0, 160, 255)
SliderFill.BorderSizePixel = 0
SliderFill.Parent = SliderBackground

local SliderButton = Instance.new("ImageButton")
SliderButton.Name = "SliderButton"
SliderButton.Size = UDim2.new(0, 14, 0, 14)
SliderButton.Position = UDim2.new(0.3, -7, 0.5, -7)
SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SliderButton.BorderSizePixel = 0
SliderButton.Parent = SliderBackground

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0.5, 0)
ButtonCorner.Parent = SliderButton

-- ПРОФИЛЬ ИГРОКА (Слева снизу)
local ProfileFrame = Instance.new("Frame")
ProfileFrame.Name = "ProfileFrame"
ProfileFrame.Size = UDim2.new(0, 150, 0, 60)
ProfileFrame.Position = UDim2.new(0, 10, 1, -70)
ProfileFrame.BackgroundTransparency = 1
ProfileFrame.Parent = MainFrame

local AvatarImage = Instance.new("ImageLabel")
AvatarImage.Name = "AvatarImage"
AvatarImage.Size = UDim2.new(0, 44, 0, 44)
AvatarImage.Position = UDim2.new(0, 0, 0.5, -22)
AvatarImage.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
AvatarImage.BorderSizePixel = 0

local userId = LocalPlayer.UserId
local thumbType = Enum.ThumbnailType.AvatarBust
local thumbSize = Enum.ThumbnailSize.Size100x100
local content, isReady = Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)
AvatarImage.Image = content
AvatarImage.Parent = ProfileFrame

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(0.5, 0)
AvatarCorner.Parent = AvatarImage

local UsernameLabel = Instance.new("TextLabel")
UsernameLabel.Name = "UsernameLabel"
UsernameLabel.Size = UDim2.new(1, -54, 1, 0)
UsernameLabel.Position = UDim2.new(0, 54, 0, 0)
UsernameLabel.BackgroundTransparency = 1
UsernameLabel.Text = LocalPlayer.Name
UsernameLabel.TextColor3 = Color3.fromRGB(235, 235, 235)
UsernameLabel.TextXAlignment = Enum.TextXAlignment.Left
UsernameLabel.Font = Enum.Font.SourceSansBold
UsernameLabel.TextSize = 16
UsernameLabel.Parent = ProfileFrame

-- ЛЕВАЯ КНОПКА: MISC
local MiscButton = Instance.new("TextButton")
MiscButton.Name = "MiscButton"
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

-- ЛЕВАЯ КНОПКА: KEYBINDS
local KeybindsButton = Instance.new("TextButton")
KeybindsButton.Name = "KeybindsButton"
KeybindsButton.Size = UDim2.new(0, 140, 0, 32)
KeybindsButton.Position = UDim2.new(0, 10, 0, 95)
KeybindsButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70) -- Подсвечена, т.к. активна изначально
KeybindsButton.Text = "Bind: " .. toggleKey.Name
KeybindsButton.TextColor3 = Color3.fromRGB(240, 240, 240)
KeybindsButton.Font = Enum.Font.SourceSansSemibold
KeybindsButton.TextSize = 15
KeybindsButton.Parent = MainFrame

local KeybindsCorner = Instance.new("UICorner")
KeybindsCorner.CornerRadius = UDim.new(0, 6)
KeybindsCorner.Parent = KeybindsButton


-- ================= ЛОГИКА И ИНТЕРАКТИВНОСТЬ =================

-- 1. Переключение вкладок
MiscButton.MouseButton1Click:Connect(function()
	MiscTab.Visible = true
	KeybindsTab.Visible = false
	MiscButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	KeybindsButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)

KeybindsButton.MouseButton1Click:Connect(function()
	if not isListeningForKey then
		isListeningForKey = true
		KeybindsButton.Text = "Press any key..."
	end
end)

-- Сброс состояния кнопки бинда при клике мимо, если нужно переключить вкладку
KeybindsButton.MouseButton2Click:Connect(function()
	MiscTab.Visible = false
	KeybindsTab.Visible = true
	KeybindsButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	MiscButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)

-- 2. Скрытие/Показ и Смена Бинда
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	
	if isListeningForKey then
		if input.UserInputType == Enum.UserInputType.Keyboard then
			toggleKey = input.KeyCode
			isListeningForKey = false
			KeybindsButton.Text = "Bind: " .. toggleKey.Name
			MiscTab.Visible = false
			KeybindsTab.Visible = true
			KeybindsButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
			MiscButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		end
	else
		if input.KeyCode == toggleKey then
			MainFrame.Visible = not MainFrame.Visible
		end
	end
end)

-- 3. РАБОТА ПОЛЗУНКА (FOV: 50 - 120)
local minFov = 50
local maxFov = 120
local isSliding = false

local function updateSlider(input)
	local mousePos = input.Position.X
	local barPos = SliderBackground.AbsolutePosition.X
	local barSize = SliderBackground.AbsoluteSize.X
	
	-- Вычисление процента заполнения (от 0 до 1)
	local percentage = math.clamp((mousePos - barPos) / barSize, 0, 1)
	
	SliderFill.Size = UDim2.new(percentage, 0, 1, 0)
	SliderButton.Position = UDim2.new(percentage, -7, 0.5, -7)
	
	-- Рассчет и применение FOV
-- Обязательно объявите службы и переменные, если они не объявлены выше
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

-- Настройки FOV (измените под свои нужды)
local minFov = 70
local maxFov = 120

local isSliding = false
local dragToggle = false
local dragStart = Vector2.new()
local startPos = UDim2.new()

-- 1. ФУНКЦИЯ ОБНОВЛЕНИЯ ПОЛЗУНКА (SLIDER)
local function updateSlider(input)
    -- Получаем позицию клика/касания относительно контейнера ползунка (SliderFrame)
    -- Для этого из позиции ввода вычитаем абсолютную позицию самого трека ползунка
    local sliderAbsolutePosition = SliderFrame.AbsolutePosition
    local sliderAbsoluteSize = SliderFrame.AbsoluteSize
    
    local inputPositionX = input.Position.X
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
        inputPositionX = UserInputService:GetMouseLocation().X
    end
    
    -- Вычисляем процент заполнения (от 0 до 1)
    local percentage = math.clamp((inputPositionX - sliderAbsolutePosition.X) / sliderAbsoluteSize.X, 0, 1)
    
    -- Визуальное обновление ползунка
    SliderFill.Size = UDim2.new(percentage, 0, 1, 0)
    SliderButton.Position = UDim2.new(percentage, -7, 0.5, -7)
    
    -- Логика изменения FOV
    local currentFov = minFov + (percentage * (maxFov - minFov))
    Camera.FieldOfView = currentFov
    SliderTitle.Text = "Field of View (FOV): " .. math.round(currentFov)
end

-- События для управления ползунком
SliderButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isSliding = true
        updateSlider(input) -- Обновляем сразу при клике
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isSliding = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if isSliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        updateSlider(input)
    end
end)

-- Установка начального положения ползунка под текущий FOV камеры
local initialPercentage = math.clamp((Camera.FieldOfView - minFov) / (maxFov - minFov), 0, 1)
SliderFill.Size = UDim2.new(initialPercentage, 0, 1, 0)
SliderButton.Position = UDim2.new(initialPercentage, -7, 0.5, -7)
SliderTitle.Text = "Field of View (FOV): " .. math.round(Camera.FieldOfView)


-- 2. СТАБИЛЬНАЯ СИСТЕМА ПЕРЕТАСКИВАНИЯ ОКНА (DRAG)
DragPanel.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragToggle = true
        dragStart = UserInputService:GetMouseLocation()
        startPos = MainFrame.Position
        
        -- Безопасный сброс, если игрок отпустил мышь за пределами экрана/панели
        local connection
        connection = input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragToggle = false
                connection:Disconnect()
            end
        end)
    end
end)

RunService.RenderStepped:Connect(function()
    if dragToggle then
        local mousePos = UserInputService:GetMouseLocation()
        -- Использование GetMouseLocation для обеих точек избавляет от бага со смещением Topbar (36px)
        local delta = mousePos - dragStart
        
        MainFrame.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X, 
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    end
end)
