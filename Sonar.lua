local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

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
MainFrame.Size = UDim2.new(0, 500, 0, 350) -- Фиксированный удобный размер
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175) -- Центрирование по экрану
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Закругление углов главного окна
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12) -- Небольшое аккуратное закругление
MainCorner.Parent = MainFrame

-- ВЕРХНЯЯ ПАНЕЛЬ ДЛЯ ПЕРЕТАСКИВАНИЯ (ДРАГ-СИСТЕМА)
local DragPanel = Instance.new("Frame")
DragPanel.Name = "DragPanel"
DragPanel.Size = UDim2.new(1, 0, 0, 35)
DragPanel.Position = UDim2.new(0, 0, 0, 0)
DragPanel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
DragPanel.BorderSizePixel = 0
DragPanel.Parent = MainFrame

-- Закругление для верхней панели (чтобы не вылезала за края)
local DragCorner = Instance.new("UICorner")
DragCorner.CornerRadius = UDim.new(0, 12)
DragCorner.Parent = DragPanel

-- Скрытие нижних углов верхней панели, чтобы дизайн был монолитным
local HideCornerFix = Instance.new("Frame")
HideCornerFix.Name = "HideCornerFix"
HideCornerFix.Size = UDim2.new(1, 0, 0, 10)
HideCornerFix.Position = UDim2.new(0, 0, 1, -10)
HideCornerFix.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
HideCornerFix.BorderSizePixel = 0
HideCornerFix.Parent = DragPanel

-- Название меню на верхней панели
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
SeparatorLine.Size = UDim2.new(0, 1, 1, -35) -- На всю высоту под верхней панелью
SeparatorLine.Position = UDim2.new(0, 160, 0, 35) -- Отделяет левые 160 пикселей
SeparatorLine.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SeparatorLine.BorderSizePixel = 0
SeparatorLine.Parent = MainFrame

-- ОКНО ФУНКЦИЙ (Правая основная часть)
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -161, 1, -35)
ContentFrame.Position = UDim2.new(0, 161, 0, 35)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Текст-заглушка внутри окна функций
local InfoLabel = Instance.new("TextLabel")
InfoLabel.Name = "InfoLabel"
InfoLabel.Size = UDim2.new(1, 0, 1, 0)
InfoLabel.BackgroundTransparency = 1
InfoLabel.Text = "Select a tab from the left side"
InfoLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
InfoLabel.Font = Enum.Font.SourceSansItalic
InfoLabel.TextSize = 18
InfoLabel.Parent = ContentFrame

-- КОНТЕЙНЕР ДЛЯ ПРОФИЛЯ (Слева снизу)
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

-- ЛЕВАЯ КНОПКА: KEYBINDS
local KeybindsButton = Instance.new("TextButton")
KeybindsButton.Name = "KeybindsButton"
KeybindsButton.Size = UDim2.new(0, 140, 0, 32)
KeybindsButton.Position = UDim2.new(0, 10, 0, 95)
KeybindsButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
KeybindsButton.Text = "Bind: " .. toggleKey.Name
KeybindsButton.TextColor3 = Color3.fromRGB(240, 240, 240)
KeybindsButton.Font = Enum.Font.SourceSansSemibold
KeybindsButton.TextSize = 15
KeybindsButton.Parent = MainFrame

local KeybindsCorner = Instance.new("UICorner")
KeybindsCorner.CornerRadius = UDim.new(0, 6)
KeybindsCorner.Parent = KeybindsButton

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


-- ================= ЛОГИКА И ИНТЕРАКТИВНОСТЬ =================

-- 1. Скрытие/Показ и смена бинда
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

KeybindsButton.MouseButton1Click:Connect(function()
	isListeningForKey = true
	KeybindsButton.Text = "Press any key..."
end)

MiscButton.MouseButton1Click:Connect(function()
	InfoLabel.Text = "Misc Tab Opened"
	print("Вкладка Misc активирована!")
end)

-- 2. Скрипт перетаскивания (Drag System) для верхней полоски
local dragging, dragInput, dragStart, startPos

local function update(input)
	local delta = input.Position - dragStart
	MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

DragPanel.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

DragPanel.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)
