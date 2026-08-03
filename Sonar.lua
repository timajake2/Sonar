local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local toggleKey = Enum.KeyCode.RightShift
local isListeningForKey = false

-- UI Settings значения
local uiScale = 1
local bgTransparency = 0.3
local cornerRadius = 0.8

-- Переменные для анимации вкладок
local currentTab = nil
local tabAnimating = false

-- ================= СОЗДАНИЕ UI =================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SonarMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999999
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Главный контейнер
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 620, 0, 400)
MainFrame.Position = UDim2.new(0.5, -310, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 20, 30)
MainFrame.BackgroundTransparency = bgTransparency
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Градиент для Liquid Glass эффекта
local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 30, 50)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(10, 15, 25)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 30, 50))
})
MainGradient.Rotation = 135
MainGradient.Parent = MainFrame

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, cornerRadius * 20)
MainCorner.Parent = MainFrame

-- Обводка
local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(60, 80, 120)
MainStroke.Thickness = 1.5
MainStroke.Transparency = 0.7
MainStroke.Parent = MainFrame

-- Фоновое свечение
local GlowFrame = Instance.new("Frame")
GlowFrame.Size = UDim2.new(1, 40, 1, 40)
GlowFrame.Position = UDim2.new(0, -20, 0, -20)
GlowFrame.BackgroundTransparency = 1
GlowFrame.BorderSizePixel = 0
GlowFrame.Parent = MainFrame

local GlowGradient = Instance.new("UIGradient")
GlowGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 50, 80)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(50, 70, 100)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 50, 80))
})
GlowGradient.Transparency = NumberSequence.new({
	NumberSequenceKeypoint.new(0, 0.9),
	NumberSequenceKeypoint.new(0.5, 0.7),
	NumberSequenceKeypoint.new(1, 0.9)
})
GlowGradient.Parent = GlowFrame

local GlowCorner = Instance.new("UICorner")
GlowCorner.CornerRadius = UDim.new(0, cornerRadius * 20 + 10)
GlowCorner.Parent = GlowFrame

-- Верхняя панель для перетаскивания
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(20, 25, 35)
TopBar.BackgroundTransparency = 0.5
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopBarGradient = Instance.new("UIGradient")
TopBarGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 40, 60)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 25, 40))
})
TopBarGradient.Parent = TopBar

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, cornerRadius * 20)
TopBarCorner.Parent = TopBar

local TopBarFix = Instance.new("Frame")
TopBarFix.Size = UDim2.new(1, 0, 0, 15)
TopBarFix.Position = UDim2.new(0, 0, 1, -15)
TopBarFix.BackgroundColor3 = Color3.fromRGB(20, 25, 35)
TopBarFix.BackgroundTransparency = 0.5
TopBarFix.BorderSizePixel = 0
TopBarFix.Parent = TopBar

-- Заголовок
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -100, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Sonar"
TitleLabel.TextColor3 = Color3.fromRGB(180, 200, 230)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 18
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TopBar

-- Кнопка закрытия
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -40, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
CloseButton.BackgroundTransparency = 0.8
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(200, 200, 220)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 14
CloseButton.Parent = TopBar
Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0, 8)

CloseButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = false
end)

-- Разделитель
local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(0, 1, 1, -40)
Divider.Position = UDim2.new(0, 170, 0, 40)
Divider.BackgroundColor3 = Color3.fromRGB(50, 60, 80)
Divider.BackgroundTransparency = 0.5
Divider.BorderSizePixel = 0
Divider.Parent = MainFrame

-- Левая панель с вкладками
local LeftPanel = Instance.new("Frame")
LeftPanel.Size = UDim2.new(0, 170, 1, -40)
LeftPanel.Position = UDim2.new(0, 0, 0, 40)
LeftPanel.BackgroundTransparency = 1
LeftPanel.BorderSizePixel = 0
LeftPanel.Parent = MainFrame

local LeftGradient = Instance.new("UIGradient")
LeftGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 20, 30)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 30, 40))
})
LeftGradient.Transparency = NumberSequence.new({
	NumberSequenceKeypoint.new(0, 0.7),
	NumberSequenceKeypoint.new(1, 0.5)
})
LeftGradient.Parent = LeftPanel

-- Список вкладок
local tabList = Instance.new("UIListLayout")
tabList.Padding = UDim.new(0, 8)
tabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
tabList.SortOrder = Enum.SortOrder.LayoutOrder
tabList.Parent = LeftPanel

-- Правая панель для контента вкладок
local RightPanel = Instance.new("Frame")
RightPanel.Size = UDim2.new(1, -171, 1, -40)
RightPanel.Position = UDim2.new(0, 171, 0, 40)
RightPanel.BackgroundTransparency = 1
RightPanel.BorderSizePixel = 0
RightPanel.ClipsDescendants = true
RightPanel.Parent = MainFrame

-- ================= ФУНКЦИИ СОЗДАНИЯ ЭЛЕМЕНТОВ =================

-- Создание тумблера
local function createToggle(parent, text, y)
	local container = Instance.new("Frame")
	container.Size = UDim2.new(1, -30, 0, 28)
	container.Position = UDim2.new(0, 15, 0, y)
	container.BackgroundTransparency = 1
	container.Parent = parent

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -50, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.fromRGB(180, 190, 210)
	label.Font = Enum.Font.Gotham
	label.TextSize = 12
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = container

	local toggleBg = Instance.new("Frame")
	toggleBg.Size = UDim2.new(0, 40, 0, 20)
	toggleBg.Position = UDim2.new(1, -40, 0.5, -10)
	toggleBg.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
	toggleBg.BorderSizePixel = 0
	toggleBg.Parent = container
	local toggleBgCorner = Instance.new("UICorner")
	toggleBgCorner.CornerRadius = UDim.new(1, 0)
	toggleBgCorner.Parent = toggleBg

	local toggleDot = Instance.new("Frame")
	toggleDot.Size = UDim2.new(0, 16, 0, 16)
	toggleDot.Position = UDim2.new(0, 2, 0.5, -8)
	toggleDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	toggleDot.BorderSizePixel = 0
	toggleDot.Parent = toggleBg
	Instance.new("UICorner", toggleDot).CornerRadius = UDim.new(1, 0)

	local enabled = false

	local function setState(state)
		enabled = state
		if state then
			toggleBg.BackgroundColor3 = Color3.fromRGB(40, 180, 60)
			toggleDot:TweenPosition(UDim2.new(1, -18, 0.5, -8), "Out", "Quad", 0.15)
		else
			toggleBg.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
			toggleDot:TweenPosition(UDim2.new(0, 2, 0.5, -8), "Out", "Quad", 0.15)
		end
	end

	container.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			setState(not enabled)
		end
	end)

	return {
		Container = container,
		SetState = setState,
		GetState = function() return enabled end
	}
end

-- Создание кнопки действия (плоская)
local function createActionButton(parent, text, y)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -30, 0, 34)
	btn.Position = UDim2.new(0, 15, 0, y)
	btn.BackgroundColor3 = Color3.fromRGB(25, 30, 45)
	btn.BorderSizePixel = 0
	btn.Text = ""
	btn.Parent = parent
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

	local btnGradient = Instance.new("UIGradient")
	btnGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 40, 55)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 25, 40))
	})
	btnGradient.Parent = btn

	-- Индикатор слева
	local indicator = Instance.new("Frame")
	indicator.Size = UDim2.new(0, 4, 1, -12)
	indicator.Position = UDim2.new(0, 8, 0, 6)
	indicator.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
	indicator.BorderSizePixel = 0
	indicator.Parent = btn
	Instance.new("UICorner", indicator).CornerRadius = UDim.new(1, 0)

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -24, 1, 0)
	label.Position = UDim2.new(0, 18, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.fromRGB(180, 190, 210)
	label.Font = Enum.Font.Gotham
	label.TextSize = 12
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = btn

	local active = false

	btn.MouseButton1Click:Connect(function()
		active = not active
		if active then
			indicator.BackgroundColor3 = Color3.fromRGB(40, 255, 60)
		else
			indicator.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
		end
	end)

	return {
		Button = btn,
		Indicator = indicator,
		SetActive = function(state)
			active = state
			indicator.BackgroundColor3 = state and Color3.fromRGB(40, 255, 60) or Color3.fromRGB(255, 60, 60)
		end
	}
end

-- Создание выпадающего списка
local function createDropdown(parent, text, options, y)
	local container = Instance.new("Frame")
	container.Size = UDim2.new(1, -30, 0, 30)
	container.Position = UDim2.new(0, 15, 0, y)
	container.BackgroundTransparency = 1
	container.Parent = parent

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -120, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.fromRGB(160, 170, 190)
	label.Font = Enum.Font.Gotham
	label.TextSize = 11
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = container

	local dropBtn = Instance.new("TextButton")
	dropBtn.Size = UDim2.new(0, 100, 1, 0)
	dropBtn.Position = UDim2.new(1, -100, 0, 0)
	dropBtn.BackgroundColor3 = Color3.fromRGB(30, 35, 50)
	dropBtn.BorderSizePixel = 0
	dropBtn.Text = options[1] or "Select..."
	dropBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
	dropBtn.Font = Enum.Font.Gotham
	dropBtn.TextSize = 10
	dropBtn.Parent = container
	Instance.new("UICorner", dropBtn).CornerRadius = UDim.new(0, 5)

	local dropList = Instance.new("ScrollingFrame")
	dropList.Size = UDim2.new(0, 100, 0, 0)
	dropList.Position = UDim2.new(1, -100, 1, 2)
	dropList.BackgroundColor3 = Color3.fromRGB(20, 25, 38)
	dropList.BorderSizePixel = 1
	dropList.BorderColor3 = Color3.fromRGB(50, 60, 80)
	dropList.Visible = false
	dropList.ScrollBarThickness = 3
	dropList.ScrollBarImageColor3 = Color3.fromRGB(60, 70, 90)
	dropList.CanvasSize = UDim2.new(0, 0, 0, #options * 24)
	dropList.ZIndex = 10
	dropList.Parent = container
	Instance.new("UICorner", dropList).CornerRadius = UDim.new(0, 5)

	local listLayout = Instance.new("UIListLayout")
	listLayout.Padding = UDim.new(0, 1)
	listLayout.Parent = dropList

	local selected = options[1]

	for _, opt in ipairs(options) do
		local optBtn = Instance.new("TextButton")
		optBtn.Size = UDim2.new(1, -2, 0, 22)
		optBtn.BackgroundColor3 = Color3.fromRGB(30, 35, 50)
		optBtn.Text = opt
		optBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
		optBtn.Font = Enum.Font.Gotham
		optBtn.TextSize = 10
		optBtn.ZIndex = 10
		optBtn.Parent = dropList

		optBtn.MouseButton1Click:Connect(function()
			selected = opt
			dropBtn.Text = opt
			dropList.Visible = false
		end)
	end

	dropBtn.MouseButton1Click:Connect(function()
		dropList.Visible = not dropList.Visible
		dropList.Size = dropList.Visible and UDim2.new(0, 100, 0, math.min(#options * 24, 100)) or UDim2.new(0, 100, 0, 0)
	end)

	return {
		Container = container,
		GetSelected = function() return selected end,
		SetOptions = function(newOptions)
			for _, c in ipairs(dropList:GetChildren()) do
				if c:IsA("TextButton") then c:Destroy() end
			end
			for _, opt in ipairs(newOptions) do
				local optBtn = Instance.new("TextButton")
				optBtn.Size = UDim2.new(1, -2, 0, 22)
				optBtn.BackgroundColor3 = Color3.fromRGB(30, 35, 50)
				optBtn.Text = opt
				optBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
				optBtn.Font = Enum.Font.Gotham
				optBtn.TextSize = 10
				optBtn.ZIndex = 10
				optBtn.Parent = dropList
				optBtn.MouseButton1Click:Connect(function()
					selected = opt
					dropBtn.Text = opt
					dropList.Visible = false
				end)
			end
			dropList.CanvasSize = UDim2.new(0, 0, 0, #newOptions * 24)
		end
	}
end

-- Создание ползунка
local function createSlider(parent, text, y, minVal, maxVal, defaultVal, step)
	local container = Instance.new("Frame")
	container.Size = UDim2.new(1, -30, 0, 45)
	container.Position = UDim2.new(0, 15, 0, y)
	container.BackgroundTransparency = 1
	container.Parent = parent

	local topRow = Instance.new("Frame")
	topRow.Size = UDim2.new(1, 0, 0, 18)
	topRow.BackgroundTransparency = 1
	topRow.Parent = container

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -60, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.fromRGB(160, 170, 190)
	label.Font = Enum.Font.Gotham
	label.TextSize = 11
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = topRow

	local valueLabel = Instance.new("TextLabel")
	valueLabel.Size = UDim2.new(0, 55, 1, 0)
	valueLabel.Position = UDim2.new(1, -55, 0, 0)
	valueLabel.BackgroundTransparency = 1
	valueLabel.Text = tostring(defaultVal)
	valueLabel.TextColor3 = Color3.fromRGB(140, 180, 220)
	valueLabel.Font = Enum.Font.GothamBold
	valueLabel.TextSize = 11
	valueLabel.TextXAlignment = Enum.TextXAlignment.Right
	valueLabel.Parent = topRow

	local sliderBg = Instance.new("Frame")
	sliderBg.Size = UDim2.new(1, 0, 0, 6)
	sliderBg.Position = UDim2.new(0, 0, 0, 22)
	sliderBg.BackgroundColor3 = Color3.fromRGB(40, 45, 55)
	sliderBg.BorderSizePixel = 0
	sliderBg.Parent = container
	Instance.new("UICorner", sliderBg).CornerRadius = UDim.new(0, 3)

	local sliderFill = Instance.new("Frame")
	local pct = (defaultVal - minVal) / (maxVal - minVal)
	sliderFill.Size = UDim2.new(pct, 0, 1, 0)
	sliderFill.BackgroundColor3 = Color3.fromRGB(60, 120, 220)
	sliderFill.BorderSizePixel = 0
	sliderFill.Parent = sliderBg
	Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(0, 3)

	local sliderDot = Instance.new("ImageButton")
	sliderDot.Size = UDim2.new(0, 14, 0, 14)
	sliderDot.Position = UDim2.new(pct, -7, 0.5, -7)
	sliderDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	sliderDot.Image = ""
	sliderDot.Parent = sliderBg
	Instance.new("UICorner", sliderDot).CornerRadius = UDim.new(1, 0)

	local isSliding = false
	local currentVal = defaultVal

	local function setVal(newVal)
		currentVal = newVal
		valueLabel.Text = step and step < 1 and string.format("%.1f", newVal) or tostring(math.floor(newVal))
		local p = (newVal - minVal) / (maxVal - minVal)
		sliderFill.Size = UDim2.new(p, 0, 1, 0)
		sliderDot.Position = UDim2.new(p, -7, 0.5, -7)
	end

	sliderDot.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then isSliding = true end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then isSliding = false end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if isSliding and input.UserInputType == Enum.UserInputType.MouseMovement then
			local bp = sliderBg.AbsolutePosition.X
			local bs = sliderBg.AbsoluteSize.X
			local p = math.clamp((input.Position.X - bp) / bs, 0, 1)
			local val = minVal + p * (maxVal - minVal)
			if step then val = math.floor(val / step) * step end
			setVal(val)
		end
	end)
	sliderBg.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			isSliding = true
			local bp = sliderBg.AbsolutePosition.X
			local bs = sliderBg.AbsoluteSize.X
			local p = math.clamp((UserInputService:GetMouseLocation().X - bp) / bs, 0, 1)
			local val = minVal + p * (maxVal - minVal)
			if step then val = math.floor(val / step) * step end
			setVal(val)
		end
	end)

	return {
		Container = container,
		SetValue = setVal,
		GetValue = function() return currentVal end
	}
end

-- Создание бокса (секции)
local function createSection(parent, title, y, height)
	local section = Instance.new("Frame")
	section.Size = UDim2.new(1, -20, 0, height)
	section.Position = UDim2.new(0, 10, 0, y)
	section.BackgroundColor3 = Color3.fromRGB(20, 25, 38)
	section.BackgroundTransparency = 0.4
	section.BorderSizePixel = 0
	section.Parent = parent
	Instance.new("UICorner", section).CornerRadius = UDim.new(0, 10)

	local sectionStroke = Instance.new("UIStroke")
	sectionStroke.Color = Color3.fromRGB(50, 60, 80)
	sectionStroke.Thickness = 1
	sectionStroke.Transparency = 0.6
	sectionStroke.Parent = section

	local titleLabel = Instance.new("TextLabel")
	titleLabel.Size = UDim2.new(1, -20, 0, 22)
	titleLabel.Position = UDim2.new(0, 10, 0, 5)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = title
	titleLabel.TextColor3 = Color3.fromRGB(140, 160, 200)
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextSize = 13
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Parent = section

	return section
end

-- Создание вкладки
local function createTab(name, icon)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -20, 0, 34)
	btn.BackgroundColor3 = Color3.fromRGB(25, 30, 45)
	btn.BackgroundTransparency = 0.5
	btn.BorderSizePixel = 0
	btn.Text = "  " .. icon .. "  " .. name
	btn.TextColor3 = Color3.fromRGB(160, 180, 210)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 12
	btn.TextXAlignment = Enum.TextXAlignment.Left
	btn.Parent = LeftPanel
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

	local btnStroke = Instance.new("UIStroke")
	btnStroke.Color = Color3.fromRGB(50, 60, 80)
	btnStroke.Thickness = 0.5
	btnStroke.Transparency = 0.8
	btnStroke.Parent = btn

	return btn
end

-- ================= ВКЛАДКИ =================
local AboutTabBtn = createTab("About", "✦")
local PlayerTabBtn = createTab("Player", "👤")
local ProtectionTabBtn = createTab("Protection", "🛡️")
local TargetTabBtn = createTab("Target", "◎")
local BlobmanTabBtn = createTab("Blobman", "🌀")
local ShadersTabBtn = createTab("Shaders", "🎨")
local UISettingsTabBtn = createTab("UI Settings", "⚙")

-- ================= КОНТЕНТ ВКЛАДОК =================

-- About
local AboutContent = Instance.new("ScrollingFrame")
AboutContent.Size = UDim2.new(1, 0, 1, 0)
AboutContent.BackgroundTransparency = 1
AboutContent.ScrollBarThickness = 3
AboutContent.ScrollBarImageColor3 = Color3.fromRGB(60, 70, 90)
AboutContent.CanvasSize = UDim2.new(0, 0, 0, 300)
AboutContent.Parent = RightPanel

local AboutTitle = Instance.new("TextLabel")
AboutTitle.Size = UDim2.new(1, -40, 0, 30)
AboutTitle.Position = UDim2.new(0, 20, 0, 30)
AboutTitle.BackgroundTransparency = 1
AboutTitle.Text = "Sonar"
AboutTitle.TextColor3 = Color3.fromRGB(180, 200, 240)
AboutTitle.Font = Enum.Font.GothamBold
AboutTitle.TextSize = 28
AboutTitle.TextXAlignment = Enum.TextXAlignment.Center
AboutTitle.Parent = AboutContent

local AboutSubtitle = Instance.new("TextLabel")
AboutSubtitle.Size = UDim2.new(1, -40, 0, 20)
AboutSubtitle.Position = UDim2.new(0, 20, 0, 65)
AboutSubtitle.BackgroundTransparency = 1
AboutSubtitle.Text = "by timajake2"
AboutSubtitle.TextColor3 = Color3.fromRGB(120, 150, 200)
AboutSubtitle.Font = Enum.Font.Gotham
AboutSubtitle.TextSize = 14
AboutSubtitle.TextXAlignment = Enum.TextXAlignment.Center
AboutSubtitle.Parent = AboutContent

local AboutVersion = Instance.new("TextLabel")
AboutVersion.Size = UDim2.new(1, -40, 0, 20)
AboutVersion.Position = UDim2.new(0, 20, 0, 90)
AboutVersion.BackgroundTransparency = 1
AboutVersion.Text = "v1.0.0"
AboutVersion.TextColor3 = Color3.fromRGB(100, 130, 170)
AboutVersion.Font = Enum.Font.Gotham
AboutVersion.TextSize = 11
AboutVersion.TextXAlignment = Enum.TextXAlignment.Center
AboutVersion.Parent = AboutContent

-- Player Content
local PlayerContent = Instance.new("ScrollingFrame")
PlayerContent.Size = UDim2.new(1, 0, 1, 0)
PlayerContent.BackgroundTransparency = 1
PlayerContent.ScrollBarThickness = 3
PlayerContent.ScrollBarImageColor3 = Color3.fromRGB(60, 70, 90)
PlayerContent.CanvasSize = UDim2.new(0, 0, 0, 750)
PlayerContent.Visible = false
PlayerContent.Parent = RightPanel

local pMovementSection = createSection(PlayerContent, "Movement", 5, 240)
createToggle(pMovementSection, "Loop Teleport", 30)
createDropdown(pMovementSection, "Teleport Location", 62, {"Spawn", "People"})
createToggle(pMovementSection, "Teleport Once", 96)
createToggle(pMovementSection, "Teleport Once", 96)
local tpBindBtn = Instance.new("TextButton")
tpBindBtn.Size = UDim2.new(1, -30, 0, 26)
tpBindBtn.Position = UDim2.new(0, 15, 0, 128)
tpBindBtn.BackgroundColor3 = Color3.fromRGB(25, 30, 45)
tpBindBtn.Text = "Bind: P"
tpBindBtn.TextColor3 = Color3.fromRGB(160, 180, 210)
tpBindBtn.Font = Enum.Font.Gotham
tpBindBtn.TextSize = 11
tpBindBtn.Parent = pMovementSection
Instance.new("UICorner", tpBindBtn).CornerRadius = UDim.new(0, 5)

local tmBindBtn = Instance.new("TextButton")
tmBindBtn.Size = UDim2.new(1, -30, 0, 26)
tmBindBtn.Position = UDim2.new(0, 15, 0, 158)
tmBindBtn.BackgroundColor3 = Color3.fromRGB(25, 30, 45)
tmBindBtn.Text = "Teleport To Mouse - Bind: Z"
tmBindBtn.TextColor3 = Color3.fromRGB(160, 180, 210)
tmBindBtn.Font = Enum.Font.Gotham
tmBindBtn.TextSize = 11
tmBindBtn.Parent = pMovementSection
Instance.new("UICorner", tmBindBtn).CornerRadius = UDim.new(0, 5)

createSlider(pMovementSection, "Speed Control", 190, 16, 100, 16, 1)
createToggle(pMovementSection, "Enable Speed", 210)
createSlider(PlayerContent, "Jump Power", 248, 50, 250, 50, 1)
createToggle(PlayerContent, "Infinite Jump", 270)
createToggle(PlayerContent, "Noclip", 300)
createToggle(PlayerContent, "Water Walk", 330)

local pESPSection = createSection(PlayerContent, "ESP", 365, 80)
createToggle(pESPSection, "Enable Name ESP", 30)
createToggle(pESPSection, "Highlight Players", 62)

local pCameraSection = createSection(PlayerContent, "Camera", 460, 110)
createSlider(pCameraSection, "FOV", 30, 50, 120, 70, 1)
createToggle(pCameraSection, "Enable FOV", 68)
createToggle(pCameraSection, "Third Person", 90)

-- Protection Content
local ProtectionContent = Instance.new("ScrollingFrame")
ProtectionContent.Size = UDim2.new(1, 0, 1, 0)
ProtectionContent.BackgroundTransparency = 1
ProtectionContent.ScrollBarThickness = 3
ProtectionContent.ScrollBarImageColor3 = Color3.fromRGB(60, 70, 90)
ProtectionContent.CanvasSize = UDim2.new(0, 0, 0, 300)
ProtectionContent.Visible = false
ProtectionContent.Parent = RightPanel

createToggle(ProtectionContent, "Anti Grab", 5)
createToggle(ProtectionContent, "Anti Explode", 35)
createToggle(ProtectionContent, "Anti Void", 65)
createToggle(ProtectionContent, "Anti Line Lag", 95)
createToggle(ProtectionContent, "Anti-Kick With Shuriken", 125)
createToggle(ProtectionContent, "Anti Burn", 155)
createActionButton(ProtectionContent, "Anti Banana", 185)
createToggle(ProtectionContent, "Lock Position (RenderStepped)", 225)

-- Target Content
local TargetContent = Instance.new("ScrollingFrame")
TargetContent.Size = UDim2.new(1, 0, 1, 0)
TargetContent.BackgroundTransparency = 1
TargetContent.ScrollBarThickness = 3
TargetContent.ScrollBarImageColor3 = Color3.fromRGB(60, 70, 90)
TargetContent.CanvasSize = UDim2.new(0, 0, 0, 350)
TargetContent.Visible = false
TargetContent.Parent = RightPanel

local tSelectionSection = createSection(TargetContent, "Selection", 5, 140)
createDropdown(tSelectionSection, "Select Player", 30, {"None"})
createActionButton(tSelectionSection, "Teleport To Target", 66)
createToggle(tSelectionSection, "Target Line Tracker", 102)
createToggle(tSelectionSection, "Statistics For Target", 120)

local tAurasSection = createSection(TargetContent, "Auras", 155, 110)
createDropdown(tAurasSection, "Select Aura", 30, {"Ragdoll", "Kill", "Magnetic"})
createToggle(tAurasSection, "Enable Aura", 66)

-- Blobman Content
local BlobmanContent = Instance.new("ScrollingFrame")
BlobmanContent.Size = UDim2.new(1, 0, 1, 0)
BlobmanContent.BackgroundTransparency = 1
BlobmanContent.ScrollBarThickness = 3
BlobmanContent.ScrollBarImageColor3 = Color3.fromRGB(60, 70, 90)
BlobmanContent.CanvasSize = UDim2.new(0, 0, 0, 300)
BlobmanContent.Visible = false
BlobmanContent.Parent = RightPanel

local bSelectionSection = createSection(BlobmanContent, "Selection", 5, 120)
createDropdown(bSelectionSection, "Select Target", 30, {"None"})

local mouseBindBtn = Instance.new("TextButton")
mouseBindBtn.Size = UDim2.new(1, -30, 0, 26)
mouseBindBtn.Position = UDim2.new(0, 15, 0, 66)
mouseBindBtn.BackgroundColor3 = Color3.fromRGB(25, 30, 45)
mouseBindBtn.Text = "Select Target By Mouse - Bind: M"
mouseBindBtn.TextColor3 = Color3.fromRGB(160, 180, 210)
mouseBindBtn.Font = Enum.Font.Gotham
mouseBindBtn.TextSize = 11
mouseBindBtn.Parent = bSelectionSection
Instance.new("UICorner", mouseBindBtn).CornerRadius = UDim.new(0, 5)

local bMethodSection = createSection(BlobmanContent, "Select Method Destroy", 135, 130)
createDropdown(bMethodSection, "Kick Methods", 30, {"Blob Kick", "Blob Kick (Circle Spin)", "Blob Kill Target"})
createToggle(bMethodSection, "Enable Selected Method", 66)
createToggle(bMethodSection, "Auto Sit Blobman", 96)

-- Shaders Content
local ShadersContent = Instance.new("ScrollingFrame")
ShadersContent.Size = UDim2.new(1, 0, 1, 0)
ShadersContent.BackgroundTransparency = 1
ShadersContent.ScrollBarThickness = 3
ShadersContent.ScrollBarImageColor3 = Color3.fromRGB(60, 70, 90)
ShadersContent.CanvasSize = UDim2.new(0, 0, 0, 500)
ShadersContent.Visible = false
ShadersContent.Parent = RightPanel

local sTODSection = createSection(ShadersContent, "Time Of Day", 5, 210)
createToggle(sTODSection, "Morning", 30)
createToggle(sTODSection, "Midday", 60)
createToggle(sTODSection, "Afternoon", 90)
createToggle(sTODSection, "Evening", 120)
createToggle(sTODSection, "Night", 150)
createToggle(sTODSection, "Midnight", 180)

local sWeatherSection = createSection(ShadersContent, "Weather", 225, 210)
createToggle(sWeatherSection, "Rain", 30)
createToggle(sWeatherSection, "Snow", 60)
createToggle(sWeatherSection, "Fog", 90)
createToggle(sWeatherSection, "Sunny", 120)
createToggle(sWeatherSection, "Cloudy", 150)
createToggle(sWeatherSection, "Storm", 180)

local sSeasonSection = createSection(ShadersContent, "Seasons", 445, 140)
createToggle(sSeasonSection, "Autumn", 30)
createToggle(sSeasonSection, "Spring", 60)
createToggle(sSeasonSection, "Summer", 90)
createToggle(sSeasonSection, "Winter", 120)

-- UI Settings Content
local UISettingsContent = Instance.new("ScrollingFrame")
UISettingsContent.Size = UDim2.new(1, 0, 1, 0)
UISettingsContent.BackgroundTransparency = 1
UISettingsContent.ScrollBarThickness = 3
UISettingsContent.ScrollBarImageColor3 = Color3.fromRGB(60, 70, 90)
UISettingsContent.CanvasSize = UDim2.new(0, 0, 0, 260)
UISettingsContent.Visible = false
UISettingsContent.Parent = RightPanel

local uiAppearanceSection = createSection(UISettingsContent, "Appearance", 5, 150)
createSlider(uiAppearanceSection, "Corner Radius", 30, 0, 2, 0.8, 0.1)
createSlider(uiAppearanceSection, "Background Transparency", 75, 0, 2, 0.3, 0.1)
createSlider(uiAppearanceSection, "UI Scale", 120, 1, 5, 1, 0.1)

local uiKeybindsSection = createSection(UISettingsContent, "Keybinds", 165, 70)
local toggleUIBindBtn = Instance.new("TextButton")
toggleUIBindBtn.Size = UDim2.new(1, -30, 0, 30)
toggleUIBindBtn.Position = UDim2.new(0, 15, 0, 35)
toggleUIBindBtn.BackgroundColor3 = Color3.fromRGB(25, 30, 45)
toggleUIBindBtn.Text = "Toggle UI - Bind: Right-Shift"
toggleUIBindBtn.TextColor3 = Color3.fromRGB(160, 180, 210)
toggleUIBindBtn.Font = Enum.Font.Gotham
toggleUIBindBtn.TextSize = 11
toggleUIBindBtn.Parent = uiKeybindsSection
Instance.new("UICorner", toggleUIBindBtn).CornerRadius = UDim.new(0, 5)

-- ================= ПРОФИЛЬ =================
local ProfileFrame = Instance.new("Frame")
ProfileFrame.Size = UDim2.new(0, 150, 0, 50)
ProfileFrame.Position = UDim2.new(0, 10, 1, -60)
ProfileFrame.BackgroundTransparency = 1
ProfileFrame.Parent = LeftPanel

local AvatarImage = Instance.new("ImageLabel")
AvatarImage.Size = UDim2.new(0, 36, 0, 36)
AvatarImage.Position = UDim2.new(0, 0, 0.5, -18)
AvatarImage.BackgroundColor3 = Color3.fromRGB(30, 35, 50)
AvatarImage.BorderSizePixel = 0
AvatarImage.Image = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size100x100)
AvatarImage.Parent = ProfileFrame
Instance.new("UICorner", AvatarImage).CornerRadius = UDim.new(0.5, 0)

local AvatarStroke = Instance.new("UIStroke")
AvatarStroke.Color = Color3.fromRGB(80, 100, 140)
AvatarStroke.Thickness = 1.5
AvatarStroke.Transparency = 0.5
AvatarStroke.Parent = AvatarImage

local UsernameLabel = Instance.new("TextLabel")
UsernameLabel.Size = UDim2.new(1, -44, 1, 0)
UsernameLabel.Position = UDim2.new(0, 44, 0, 0)
UsernameLabel.BackgroundTransparency = 1
UsernameLabel.Text = LocalPlayer.Name
UsernameLabel.TextColor3 = Color3.fromRGB(200, 210, 230)
UsernameLabel.TextXAlignment = Enum.TextXAlignment.Left
UsernameLabel.Font = Enum.Font.GothamBold
UsernameLabel.TextSize = 13
UsernameLabel.Parent = ProfileFrame

-- ================= ЛОГИКА ВКЛАДОК =================
local allContents = {
	AboutContent,
	PlayerContent,
	ProtectionContent,
	TargetContent,
	BlobmanContent,
	ShadersContent,
	UISettingsContent
}
local allTabBtns = {
	AboutTabBtn,
	PlayerTabBtn,
	ProtectionTabBtn,
	TargetTabBtn,
	BlobmanTabBtn,
	ShadersTabBtn,
	UISettingsTabBtn
}

local function switchTab(newContent, tabBtn)
	if tabAnimating then return end
	if currentTab == newContent then return end
	tabAnimating = true

	if currentTab then
		-- Анимация уезда вверх
		local oldContent = currentTab
		local outTween = TweenService:Create(oldContent, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Position = UDim2.new(0, 0, -1, 0)
		})
		outTween:Play()
		outTween.Completed:Connect(function()
			oldContent.Visible = false
			oldContent.Position = UDim2.new(0, 0, 0, 0)
		end)
	end

	-- Анимация приезда снизу
	newContent.Position = UDim2.new(0, 0, 1, 0)
	newContent.Visible = true
	local inTween = TweenService:Create(newContent, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Position = UDim2.new(0, 0, 0, 0)
	})
	inTween:Play()
	inTween.Completed:Connect(function()
		tabAnimating = false
	end)

	currentTab = newContent

	-- Подсветка кнопок
	for _, btn in ipairs(allTabBtns) do
		btn.BackgroundTransparency = 0.5
		btn.TextColor3 = Color3.fromRGB(160, 180, 210)
	end
	tabBtn.BackgroundTransparency = 0.2
	tabBtn.TextColor3 = Color3.fromRGB(220, 230, 255)
end

AboutTabBtn.MouseButton1Click:Connect(function() switchTab(AboutContent, AboutTabBtn) end)
PlayerTabBtn.MouseButton1Click:Connect(function() switchTab(PlayerContent, PlayerTabBtn) end)
ProtectionTabBtn.MouseButton1Click:Connect(function() switchTab(ProtectionContent, ProtectionTabBtn) end)
TargetTabBtn.MouseButton1Click:Connect(function() switchTab(TargetContent, TargetTabBtn) end)
BlobmanTabBtn.MouseButton1Click:Connect(function() switchTab(BlobmanContent, BlobmanTabBtn) end)
ShadersTabBtn.MouseButton1Click:Connect(function() switchTab(ShadersContent, ShadersTabBtn) end)
UISettingsTabBtn.MouseButton1Click:Connect(function() switchTab(UISettingsContent, UISettingsTabBtn) end)

-- Изначально открыт About
currentTab = AboutContent
AboutTabBtn.BackgroundTransparency = 0.2
AboutTabBtn.TextColor3 = Color3.fromRGB(220, 230, 255)

-- ================= СКРЫТИЕ МЕНЮ =================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if isListeningForKey then
		if input.UserInputType == Enum.UserInputType.Keyboard then
			toggleKey = input.KeyCode
			isListeningForKey = false
			toggleUIBindBtn.Text = "Toggle UI - Bind: " .. toggleKey.Name
		end
	elseif input.KeyCode == toggleKey then
		MainFrame.Visible = not MainFrame.Visible
	end
end)

toggleUIBindBtn.MouseButton1Click:Connect(function()
	if not isListeningForKey then
		isListeningForKey = true
		toggleUIBindBtn.Text = "Press any key..."
	end
end)

-- ================= ПЕРЕТАСКИВАНИЕ =================
local dragToggle, dragStart, startPos = nil, nil, nil
TopBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragToggle = true
		dragStart = input.Position
		startPos = MainFrame.Position
	end
end)
TopBar.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then dragToggle = false end
end)
UserInputService.InputChanged:Connect(function(input)
	if dragToggle and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- ================= UI SETTINGS ФУНКЦИИ =================
-- (Будут подключены позже, когда слайдеры заработают)
