local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local toggleKey = Enum.KeyCode.RightShift
local isListeningForKey = false

-- Silent Aim настройки
local silentAimEnabled = false
local aimRadius = 50

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

local AimbotTab = Instance.new("Frame")
AimbotTab.Size = UDim2.new(1, -161, 1, -35)
AimbotTab.Position = UDim2.new(0, 161, 0, 35)
AimbotTab.BackgroundTransparency = 1
AimbotTab.Visible = false
AimbotTab.Parent = MainFrame

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

-- ================= ВКЛАДКА AIMBOT (SILENT AIM + РАДИУС) =================

-- Заголовок
local AimbotTitle = Instance.new("TextLabel")
AimbotTitle.Size = UDim2.new(0, 300, 0, 30)
AimbotTitle.Position = UDim2.new(0.5, -150, 0, 10)
AimbotTitle.BackgroundTransparency = 1
AimbotTitle.Text = "SILENT AIM"
AimbotTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
AimbotTitle.Font = Enum.Font.SourceSansBold
AimbotTitle.TextSize = 18
AimbotTitle.Parent = AimbotTab

-- Переключатель ВКЛ/ВЫКЛ
local ToggleAimbot = Instance.new("TextButton")
ToggleAimbot.Size = UDim2.new(0, 300, 0, 40)
ToggleAimbot.Position = UDim2.new(0.5, -150, 0, 50)
ToggleAimbot.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
ToggleAimbot.Text = "SILENT AIM: OFF"
ToggleAimbot.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleAimbot.Font = Enum.Font.SourceSansBold
ToggleAimbot.TextSize = 16
ToggleAimbot.Parent = AimbotTab

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 8)
ToggleCorner.Parent = ToggleAimbot

-- Радиус
local RadiusContainer = Instance.new("Frame")
RadiusContainer.Size = UDim2.new(0, 300, 0, 60)
RadiusContainer.Position = UDim2.new(0.5, -150, 0, 110)
RadiusContainer.BackgroundTransparency = 1
RadiusContainer.Parent = AimbotTab

local RadiusTitle = Instance.new("TextLabel")
RadiusTitle.Size = UDim2.new(1, 0, 0, 20)
RadiusTitle.BackgroundTransparency = 1
RadiusTitle.Text = "Radius: " .. aimRadius
RadiusTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
RadiusTitle.Font = Enum.Font.SourceSansSemibold
RadiusTitle.TextSize = 14
RadiusTitle.Parent = RadiusContainer

local RadiusSliderBg = Instance.new("Frame")
RadiusSliderBg.Size = UDim2.new(1, 0, 0, 8)
RadiusSliderBg.Position = UDim2.new(0, 0, 0, 30)
RadiusSliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
RadiusSliderBg.BorderSizePixel = 0
RadiusSliderBg.Parent = RadiusContainer

local RadiusBgCorner = Instance.new("UICorner")
RadiusBgCorner.CornerRadius = UDim.new(0, 4)
RadiusBgCorner.Parent = RadiusSliderBg

local RadiusFill = Instance.new("Frame")
RadiusFill.Size = UDim2.new(0.5, 0, 1, 0)
RadiusFill.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
RadiusFill.BorderSizePixel = 0
RadiusFill.Parent = RadiusSliderBg

local RadiusFillCorner = Instance.new("UICorner")
RadiusFillCorner.CornerRadius = UDim.new(0, 4)
RadiusFillCorner.Parent = RadiusFill

local RadiusSliderBtn = Instance.new("ImageButton")
RadiusSliderBtn.Size = UDim2.new(0, 16, 0, 16)
RadiusSliderBtn.Position = UDim2.new(0.5, -8, 0.5, -8)
RadiusSliderBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
RadiusSliderBtn.Image = ""
RadiusSliderBtn.Parent = RadiusSliderBg

local RadiusBtnCorner = Instance.new("UICorner")
RadiusBtnCorner.CornerRadius = UDim.new(1, 0)
RadiusBtnCorner.Parent = RadiusSliderBtn

-- Статус
local AimbotStatus = Instance.new("TextLabel")
AimbotStatus.Size = UDim2.new(0, 300, 0, 40)
AimbotStatus.Position = UDim2.new(0.5, -150, 0, 190)
AimbotStatus.BackgroundTransparency = 1
AimbotStatus.Text = "Выберите радиус и включите Silent Aim"
AimbotStatus.TextColor3 = Color3.fromRGB(180, 180, 180)
AimbotStatus.Font = Enum.Font.SourceSansItalic
AimbotStatus.TextSize = 13
AimbotStatus.TextWrapped = true
AimbotStatus.Parent = AimbotTab

-- ================= ЛЕВЫЕ КНОПКИ НАВИГАЦИИ =================

local AimbotButton = Instance.new("TextButton")
AimbotButton.Size = UDim2.new(0, 140, 0, 32)
AimbotButton.Position = UDim2.new(0, 10, 0, 50)
AimbotButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
AimbotButton.Text = "Aimbot"
AimbotButton.TextColor3 = Color3.fromRGB(240, 240, 240)
AimbotButton.Font = Enum.Font.SourceSansSemibold
AimbotButton.TextSize = 15
AimbotButton.Parent = MainFrame

local AimbotCorner = Instance.new("UICorner")
AimbotCorner.CornerRadius = UDim.new(0, 6)
AimbotCorner.Parent = AimbotButton

local MiscButton = Instance.new("TextButton")
MiscButton.Size = UDim2.new(0, 140, 0, 32)
MiscButton.Position = UDim2.new(0, 10, 0, 95)
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

AimbotButton.MouseButton1Click:Connect(function()
	AimbotTab.Visible = true
	MiscTab.Visible = false
	KeybindsTab.Visible = false
	AimbotButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	MiscButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	KeybindsButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)

MiscButton.MouseButton1Click:Connect(function()
	AimbotTab.Visible = false
	MiscTab.Visible = true
	KeybindsTab.Visible = false
	AimbotButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	MiscButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	KeybindsButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)

KeybindsButton.MouseButton1Click:Connect(function()
	AimbotTab.Visible = false
	MiscTab.Visible = false
	KeybindsTab.Visible = true
	AimbotButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	MiscButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	KeybindsButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	
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

-- ================= RADIUS СЛАЙДЕР ЛОГИКА =================

local isRadiusSliding = false

RadiusSliderBtn.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		isRadiusSliding = true
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		isRadiusSliding = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if isRadiusSliding and input.UserInputType == Enum.UserInputType.MouseMovement then
		local mousePos = input.Position.X
		local barPos = RadiusSliderBg.AbsolutePosition.X
		local barSize = RadiusSliderBg.AbsoluteSize.X
		local percentage = math.clamp((mousePos - barPos) / barSize, 0, 1)
		
		RadiusFill.Size = UDim2.new(percentage, 0, 1, 0)
		RadiusSliderBtn.Position = UDim2.new(percentage, -8, 0.5, -8)
		
		aimRadius = math.floor(10 + (percentage * 190)) -- Радиус от 10 до 200
		RadiusTitle.Text = "Radius: " .. aimRadius
	end
end)

RadiusSliderBg.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		isRadiusSliding = true
		local mousePos = UserInputService:GetMouseLocation().X
		local barPos = RadiusSliderBg.AbsolutePosition.X
		local barSize = RadiusSliderBg.AbsoluteSize.X
		local percentage = math.clamp((mousePos - barPos) / barSize, 0, 1)
		
		RadiusFill.Size = UDim2.new(percentage, 0, 1, 0)
		RadiusSliderBtn.Position = UDim2.new(percentage, -8, 0.5, -8)
		
		aimRadius = math.floor(10 + (percentage * 190))
		RadiusTitle.Text = "Radius: " .. aimRadius
	end
end)

-- ================= SILENT AIM ЛОГИКА =================

-- Функция поиска ближайшего игрока в радиусе
local function getClosestPlayer()
	local closestPlayer = nil
	local closestDistance = aimRadius
	
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character then
			local head = player.Character:FindFirstChild("Head")
			local humanoid = player.Character:FindFirstChild("Humanoid")
			
			if head and humanoid and humanoid.Health > 0 then
				local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
				
				if onScreen then
					local mousePos = UserInputService:GetMouseLocation()
					local distance = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
					
					if distance < closestDistance then
						closestDistance = distance
						closestPlayer = player
					end
				end
			end
		end
	end
	
	return closestPlayer
end

-- Перехват выстрела через удалённое событие (Silent Aim)
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
	local args = {...}
	local method = getnamecallmethod()
	
	if method == "FireServer" and silentAimEnabled then
		if self.Name == "RemoteEvent" or self.Name == "GunEvent" or self.Name == "Shoot" or self.Name == "Fire" then
			local target = getClosestPlayer()
			if target and target.Character and target.Character:FindFirstChild("Head") then
				-- Меняем направление на голову цели
				local head = target.Character.Head
				local direction = (head.Position - Camera.CFrame.Position).Unit
				
				-- Пытаемся найти аргументы с направлением и заменить их
				for i, arg in ipairs(args) do
					if typeof(arg) == "Vector3" and arg.Magnitude <= 1.1 then
						args[i] = direction
					elseif typeof(arg) == "CFrame" then
						args[i] = CFrame.new(arg.Position, arg.Position + direction)
					end
				end
			end
		end
	end
	
	return oldNamecall(self, unpack(args))
end)

-- Переключатель Silent Aim
ToggleAimbot.MouseButton1Click:Connect(function()
	silentAimEnabled = not silentAimEnabled
	
	if silentAimEnabled then
		ToggleAimbot.BackgroundColor3 = Color3.fromRGB(40, 180, 40)
		ToggleAimbot.Text = "SILENT AIM: ON"
		AimbotStatus.Text = "Silent Aim активен! Радиус: " .. aimRadius .. ". Просто стреляйте."
	else
		ToggleAimbot.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
		ToggleAimbot.Text = "SILENT AIM: OFF"
		AimbotStatus.Text = "Выберите радиус и включите Silent Aim"
	end
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
