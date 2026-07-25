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

-- Главное окно
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Верхняя панель "Solar"
local DragPanel = Instance.new("Frame")
DragPanel.Name = "DragPanel"
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

-- Вкладки
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

local KeybindsInfo = Instance.new("TextLabel")
KeybindsInfo.Size = UDim2.new(1, 0, 1, 0)
KeybindsInfo.BackgroundTransparency = 1
KeybindsInfo.Text = "Нажмите 'Bind' слева для смены кнопки скрытия"
KeybindsInfo.TextColor3 = Color3.fromRGB(150, 150, 150)
KeybindsInfo.Font = Enum.Font.SourceSans
KeybindsInfo.TextSize = 15
KeybindsInfo.Parent = KeybindsTab

-- [ПОЛЗУНОК 1: FOV КАМЕРЫ]
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
SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
SliderTitle.Parent = SliderContainer

local SliderBackground = Instance.new("Frame")
SliderBackground.Size = UDim2.new(1, 0, 0, 6)
SliderBackground.Position = UDim2.new(0, 0, 0, 25)
SliderBackground.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SliderBackground.BorderSizePixel = 0
SliderBackground.Parent = SliderContainer

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new(0.3, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(0, 160, 255)
SliderFill.BorderSizePixel = 0
SliderFill.Parent = SliderBackground

local SliderButton = Instance.new("ImageButton")
SliderButton.Size = UDim2.new(0, 14, 0, 14)
SliderButton.Position = UDim2.new(0.3, -7, 0.5, -7)
SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SliderButton.BorderSizePixel = 0
SliderButton.Parent = SliderBackground

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0.5, 0)
ButtonCorner.Parent = SliderButton

-- [ПОЛЗУНОК 2: СКРЫТЫЙ SILENT AIM RAD]
local AimContainer = Instance.new("Frame")
AimContainer.Size = UDim2.new(0, 300, 0, 50)
AimContainer.Position = UDim2.new(0.5, -150, 0, 85)
AimContainer.BackgroundTransparency = 1
AimContainer.Parent = MiscTab

local AimTitle = Instance.new("TextLabel")
AimTitle.Size = UDim2.new(1, 0, 0, 20)
AimTitle.BackgroundTransparency = 1
AimTitle.Text = "Silent Aim Radius: 100"
AimTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
AimTitle.Font = Enum.Font.SourceSansSemibold
AimTitle.TextSize = 14
AimTitle.TextXAlignment = Enum.TextXAlignment.Left
AimTitle.Parent = AimContainer

local AimBackground = Instance.new("Frame")
AimBackground.Size = UDim2.new(1, 0, 0, 6)
AimBackground.Position = UDim2.new(0, 0, 0, 25)
AimBackground.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
AimBackground.BorderSizePixel = 0
AimBackground.Parent = AimContainer

local AimFill = Instance.new("Frame")
AimFill.Size = UDim2.new(0.3, 0, 1, 0)
AimFill.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
AimFill.BorderSizePixel = 0
AimFill.Parent = AimBackground

local AimButton = Instance.new("ImageButton")
AimButton.Size = UDim2.new(0, 14, 0, 14)
AimButton.Position = UDim2.new(0.3, -7, 0.5, -7)
AimButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
AimButton.BorderSizePixel = 0
AimButton.Parent = AimBackground

local AButtonCorner = Instance.new("UICorner")
AButtonCorner.CornerRadius = UDim.new(0.5, 0)
AButtonCorner.Parent = AimButton

-- Профиль
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

-- Навигация
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

local KeybindsButton = Instance.new("TextButton")
KeybindsButton.Size = UDim2.new(0, 140, 0, 32)
KeybindsButton.Position = UDim2.new(0, 10, 0, 95)
KeybindsButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
KeybindsButton.Text = "Bind: " .. toggleKey.Name
KeybindsButton.TextColor3 = Color3.fromRGB(240, 240, 240)
KeybindsButton.Font = Enum.Font.SourceSansSemibold
KeybindsButton.TextSize = 15
KeybindsButton.Parent = MainFrame

local KeybindsCorner = Instance.new("UICorner")
KeybindsCorner.CornerRadius = UDim.new(0, 6)
KeybindsCorner.Parent = KeybindsButton
-- ================= ЛОГИКА И ИНТЕРАКТИВНОСТЬ =================

local silentAimFOV = 100 -- Скрытый радиус захвата вокруг курсора (в пикселях)

-- Вкладки
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

-- Слайдеры
local activeSlider = nil

local function handleSliderUpdate(input)
	if not activeSlider then return end
	local mousePos = input.Position.X
	local barPos = activeSlider.Bg.AbsolutePosition.X
	local barSize = activeSlider.Bg.AbsoluteSize.X
	local percentage = math.clamp((mousePos - barPos) / barSize, 0, 1)
	
	activeSlider.Fill.Size = UDim2.new(percentage, 0, 1, 0)
	activeSlider.Btn.Position = UDim2.new(percentage, -7, 0.5, -7)
	local value = activeSlider.Min + (percentage * (activeSlider.Max - activeSlider.Min))
	activeSlider.Callback(value)
end

SliderButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		activeSlider = {
			Bg = SliderBackground, Fill = SliderFill, Btn = SliderButton,
			Min = 50, Max = 120, Callback = function(v)
				Camera.FieldOfView = v
				SliderTitle.Text = "Field of View (FOV): " .. math.round(v)
			end
		}
	end
end)

AimButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		activeSlider = {
			Bg = AimBackground, Fill = AimFill, Btn = AimButton,
			Min = 20, Max = 300, Callback = function(v)
				silentAimFOV = v
				AimTitle.Text = "Silent Aim Radius: " .. math.round(v)
			end
		}
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		activeSlider = nil
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if activeSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		handleSliderUpdate(input)
	end
end)

-- Инициализация слайдеров
local initPercentage = math.clamp((Camera.FieldOfView - 50) / 70, 0, 1)
SliderFill.Size = UDim2.new(initPercentage, 0, 1, 0)
SliderButton.Position = UDim2.new(initPercentage, -7, 0.5, -7)


-- [АЛГОРИТМ ПОДМЕНЫ ДАННЫХ МЫШИ (LEGIT SILENT AIM)]
-- Находит ближайшую к курсору кость противника в заданном радиусе пикселей
local function getClosestBodyPartToCursor()
	local mousePos = UserInputService:GetMouseLocation()
	local closestPart = nil
	local shortestDistance = silentAimFOV

	for _, player in ipairs(Players:GetPlayers()) do
		-- Проверяем, что это не локальный игрок, у него загружен персонаж и он жив
		if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
			for _, part in ipairs(player.Character:GetChildren()) do
				if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
					local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
					if onScreen then
						local distance = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
						if distance < shortestDistance then
							shortestDistance = distance
							closestPart = part
						end
					end
				end
			end
		end
	end
	return closestPart
end

-- Перехват свойств мыши через hookmetamethod
-- Этот метод подменяет ответы на запросы игры о положении мыши на системном уровне
local oldIndex
oldIndex = hookmetamethod(game, "__index", function(self, key)
	-- Если вызов идет из скрипта игры, объект является мышкой и игра проверяет куда направлен клик
	if not checkcaller() and self:IsA("Mouse") and (key == "Hit" or key == "Target") then
		local targetPart = getClosestBodyPartToCursor()
		if targetPart then
			if key == "Hit" then
				return targetPart.CFrame -- Игра думает, что трехмерные координаты мыши находятся на игроке
			elseif key == "Target" then
				return targetPart -- Игра уверена, что курсор физически наведен на деталь противника
			end
		end
	end
	return oldIndex(self, key)
end)


-- Перетаскивание меню
local dragToggle, dragStart, startPos = nil, nil, nil
DragPanel.InputBegan:Connect(function(input)
	if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
		dragToggle = true
		dragStart = input.Position
		startPos = MainFrame.Position
	end
end)
DragPanel.InputEnded:Connect(function(input)
	if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
		dragToggle = false
	end
end)
RunService.RenderStepped:Connect(function()
	if dragToggle then
		local mousePos = UserInputService:GetMouseLocation()
		local delta = mousePos - Vector2.new(dragStart.X, dragStart.Y - 36)
		MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)
