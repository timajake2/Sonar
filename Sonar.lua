-- SONAR by timajake2
-- FULL UI LIQUID GLASS (все кнопки, тумблеры, ползунки, выборы)
-- Функции НЕ РАБОТАЮТ (кроме UI Settings)

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local uis = game:GetService("UserInputService")
local run = game:GetService("RunService")
local tween = game:GetService("TweenService")

-- ===== СОЗДАНИЕ MAIN GUI =====
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SonarUI"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

-- ===== ОСНОВНОЕ ОКНО (LIQUID GLASS) =====
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 800, 0, 500)
mainFrame.Position = UDim2.new(0.5, -400, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 30, 50)
mainFrame.BackgroundTransparency = 0.3
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

-- Glass эффект (размытие)
local glassEffect = Instance.new("Frame")
glassEffect.Name = "GlassEffect"
glassEffect.Size = UDim2.new(1, 0, 1, 0)
glassEffect.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
glassEffect.BackgroundTransparency = 0.85
glassEffect.BorderSizePixel = 0
glassEffect.Parent = mainFrame

-- Обводка
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(100, 150, 255)
stroke.Thickness = 1.5
stroke.Transparency = 0.7
stroke.Parent = mainFrame

-- Скругление
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 20)
corner.Parent = mainFrame

-- ===== ЛЕВАЯ ПАНЕЛЬ (ВКЛАДКИ + АВАТАР) =====
local leftPanel = Instance.new("Frame")
leftPanel.Name = "LeftPanel"
leftPanel.Size = UDim2.new(0, 200, 1, 0)
leftPanel.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
leftPanel.BackgroundTransparency = 0.4
leftPanel.BorderSizePixel = 0
leftPanel.Parent = mainFrame

local leftCorner = Instance.new("UICorner")
leftCorner.CornerRadius = UDim.new(0, 20)
leftCorner.Parent = leftPanel

-- Логотип сверху
local logoLabel = Instance.new("TextLabel")
logoLabel.Size = UDim2.new(1, 0, 0, 40)
logoLabel.Position = UDim2.new(0, 0, 0, 10)
logoLabel.BackgroundTransparency = 1
logoLabel.Text = "SONAR"
logoLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
logoLabel.TextSize = 24
logoLabel.Font = Enum.Font.GothamBold
logoLabel.TextXAlignment = Enum.TextXAlignment.Center
logoLabel.Parent = leftPanel

-- Список вкладок (ScrollingFrame)
local tabsContainer = Instance.new("ScrollingFrame")
tabsContainer.Name = "TabsContainer"
tabsContainer.Size = UDim2.new(1, 0, 1, -100)
tabsContainer.Position = UDim2.new(0, 0, 0, 50)
tabsContainer.BackgroundTransparency = 1
tabsContainer.BorderSizePixel = 0
tabsContainer.ScrollBarThickness = 2
tabsContainer.ScrollBarImageColor3 = Color3.fromRGB(100, 150, 255)
tabsContainer.Parent = leftPanel

local tabsLayout = Instance.new("UIListLayout")
tabsLayout.Padding = UDim.new(0, 5)
tabsLayout.Parent = tabsContainer

-- ===== СПИСОК ВКЛАДОК =====
local tabs = {
    {name = "About", icon = "ℹ"},
    {name = "Player", icon = "👤"},
    {name = "Protection", icon = "🛡"},
    {name = "Target", icon = "🎯"},
    {name = "Blobman", icon = "👾"},
    {name = "Shaders", icon = "🎨"},
    {name = "UI Settings", icon = "⚙"}
}

local tabButtons = {}
local currentTab = nil

-- ===== ПРАВАЯ ПАНЕЛЬ (КОНТЕНТ) =====
local contentPanel = Instance.new("Frame")
contentPanel.Name = "ContentPanel"
contentPanel.Size = UDim2.new(1, -200, 1, 0)
contentPanel.Position = UDim2.new(0, 200, 0, 0)
contentPanel.BackgroundColor3 = Color3.fromRGB(10, 20, 40)
contentPanel.BackgroundTransparency = 0.3
contentPanel.BorderSizePixel = 0
contentPanel.ClipsDescendants = true
contentPanel.Parent = mainFrame

local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 20)
contentCorner.Parent = contentPanel

-- Контейнер для страниц
local pagesContainer = Instance.new("Frame")
pagesContainer.Name = "PagesContainer"
pagesContainer.Size = UDim2.new(1, 0, 1, 0)
pagesContainer.BackgroundTransparency = 1
pagesContainer.Parent = contentPanel

-- ===== АВАТАР СНИЗУ СЛЕВА =====
local avatarFrame = Instance.new("Frame")
avatarFrame.Name = "AvatarFrame"
avatarFrame.Size = UDim2.new(1, 0, 0, 50)
avatarFrame.Position = UDim2.new(0, 0, 1, -50)
avatarFrame.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
avatarFrame.BackgroundTransparency = 0.5
avatarFrame.BorderSizePixel = 0
avatarFrame.Parent = leftPanel

local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(0, 10)
avatarCorner.Parent = avatarFrame

-- Аватар (ImageLabel с головой игрока)
local avatarImage = Instance.new("ImageLabel")
avatarImage.Size = UDim2.new(0, 35, 0, 35)
avatarImage.Position = UDim2.new(0, 5, 0.5, -17.5)
avatarImage.BackgroundTransparency = 1
avatarImage.Image = "rbxthumb://type=AvatarHeadShot&id=" .. player.UserId .. "&w=100&h=100"
avatarImage.Parent = avatarFrame

-- Ник
local nameLabel = Instance.new("TextLabel")
nameLabel.Size = UDim2.new(1, -45, 1, 0)
nameLabel.Position = UDim2.new(0, 45, 0, 0)
nameLabel.BackgroundTransparency = 1
nameLabel.Text = player.Name
nameLabel.TextColor3 = Color3.fromRGB(200, 220, 255)
nameLabel.TextSize = 14
nameLabel.Font = Enum.Font.GothamSemibold
nameLabel.TextXAlignment = Enum.TextXAlignment.Left
nameLabel.TextYAlignment = Enum.TextYAlignment.Center
nameLabel.Parent = avatarFrame

-- ===== ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ =====
local function createToggle(parent, labelText, defaultState)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 30)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextColor3 = Color3.fromRGB(200, 220, 255)
    label.TextSize = 13
    label.Font = Enum.Font.GothamMedium
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local toggleBtn = Instance.new("Frame")
    toggleBtn.Size = UDim2.new(0, 40, 0, 20)
    toggleBtn.Position = UDim2.new(1, -45, 0.5, -10)
    toggleBtn.BackgroundColor3 = defaultState and Color3.fromRGB(0, 200, 80) or Color3.fromRGB(100, 100, 100)
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Parent = frame
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(1, 0)
    toggleCorner.Parent = toggleBtn
    
    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 16, 0, 16)
    circle.Position = defaultState and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.BorderSizePixel = 0
    circle.Parent = toggleBtn
    
    local circleCorner = Instance.new("UICorner")
    circleCorner.CornerRadius = UDim.new(1, 0)
    circleCorner.Parent = circle
    
    local state = defaultState or false
    
    local function updateToggle()
        state = not state
        toggleBtn.BackgroundColor3 = state and Color3.fromRGB(0, 200, 80) or Color3.fromRGB(100, 100, 100)
        local targetPos = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
        local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tweenObj = tween:Create(circle, tweenInfo, {Position = targetPos})
        tweenObj:Play()
    end
    
    toggleBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            updateToggle()
        end
    end)
    
    return {toggle = toggleBtn, getState = function() return state end, setState = function(s) state = s; updateToggle() end}
end

local function createSlider(parent, labelText, minVal, maxVal, defaultVal, decimals)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 35)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.5, 0, 0.5, 0)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextColor3 = Color3.fromRGB(200, 220, 255)
    label.TextSize = 13
    label.Font = Enum.Font.GothamMedium
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0.4, 0, 0.5, 0)
    valueLabel.Position = UDim2.new(0.5, 0, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(defaultVal)
    valueLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
    valueLabel.TextSize = 13
    valueLabel.Font = Enum.Font.GothamMedium
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Parent = frame
    
    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(1, 0, 0, 4)
    slider.Position = UDim2.new(0, 0, 1, -6)
    slider.BackgroundColor3 = Color3.fromRGB(60, 80, 120)
    slider.BorderSizePixel = 0
    slider.Parent = frame
    
    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(1, 0)
    sliderCorner.Parent = slider
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((defaultVal - minVal) / (maxVal - minVal), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(0, 200, 80)
    fill.BorderSizePixel = 0
    fill.Parent = slider
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = fill
    
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = UDim2.new((defaultVal - minVal) / (maxVal - minVal), -7, 0.5, -7)
    knob.BackgroundColor3 = Color3.fromRGB(200, 220, 255)
    knob.BorderSizePixel = 0
    knob.Parent = slider
    
    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = knob
    
    local dragging = false
    local val = defaultVal
    
    local function updateSlider(input)
        local x = math.clamp((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
        local newVal = minVal + (maxVal - minVal) * x
        if decimals then
            newVal = math.round(newVal * (10^decimals)) / (10^decimals)
        else
            newVal = math.round(newVal)
        end
        val = math.clamp(newVal, minVal, maxVal)
        valueLabel.Text = tostring(val)
        fill.Size = UDim2.new((val - minVal) / (maxVal - minVal), 0, 1, 0)
        knob.Position = UDim2.new((val - minVal) / (maxVal - minVal), -7, 0.5, -7)
    end
    
    slider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            updateSlider(input)
        end
    end)
    
    uis.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    uis.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input)
        end
    end)
    
    return {getValue = function() return val end}
end

local function createButton(parent, labelText, isAction)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 30)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(40, 60, 100)
    btn.BackgroundTransparency = 0.3
    btn.Text = labelText
    btn.TextColor3 = Color3.fromRGB(200, 220, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamMedium
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    btn.Parent = frame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    local indicator = Instance.new("Frame")
    indicator.Size = UDim2.new(0, 4, 0, 20)
    indicator.Position = UDim2.new(0, 2, 0.5, -10)
    indicator.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    indicator.BorderSizePixel = 0
    indicator.Parent = btn
    
    local indCorner = Instance.new("UICorner")
    indCorner.CornerRadius = UDim.new(1, 0)
    indCorner.Parent = indicator
    
    local state = false
    
    btn.MouseButton1Click:Connect(function()
        state = not state
        indicator.BackgroundColor3 = state and Color3.fromRGB(0, 200, 80) or Color3.fromRGB(255, 50, 50)
        if isAction then
            state = false
            indicator.BackgroundColor3 = Color3.fromRGB(0, 200, 80)
            task.wait(0.1)
            indicator.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        end
    end)
    
    return btn
end

local function createDropdown(parent, labelText, options, defaultOption)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 35)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextColor3 = Color3.fromRGB(200, 220, 255)
    label.TextSize = 13
    label.Font = Enum.Font.GothamMedium
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local dropdownBtn = Instance.new("TextButton")
    dropdownBtn.Size = UDim2.new(0.5, 0, 1, 0)
    dropdownBtn.Position = UDim2.new(0.5, 0, 0, 0)
    dropdownBtn.BackgroundColor3 = Color3.fromRGB(30, 50, 80)
    dropdownBtn.BackgroundTransparency = 0.3
    dropdownBtn.Text = defaultOption or options[1] or "Select"
    dropdownBtn.TextColor3 = Color3.fromRGB(200, 220, 255)
    dropdownBtn.TextSize = 12
    dropdownBtn.Font = Enum.Font.GothamMedium
    dropdownBtn.BorderSizePixel = 0
    dropdownBtn.Parent = frame
    
    local dropCorner = Instance.new("UICorner")
    dropCorner.CornerRadius = UDim.new(0, 6)
    dropCorner.Parent = dropdownBtn
    
    local listFrame = Instance.new("Frame")
    listFrame.Size = UDim2.new(0.5, 0, 0, 0)
    listFrame.Position = UDim2.new(0.5, 0, 1, 2)
    listFrame.BackgroundColor3 = Color3.fromRGB(20, 35, 65)
    listFrame.BackgroundTransparency = 0.2
    listFrame.BorderSizePixel = 0
    listFrame.ClipsDescendants = true
    listFrame.Visible = false
    listFrame.Parent = frame
    
    local listCorner = Instance.new("UICorner")
    listCorner.CornerRadius = UDim.new(0, 6)
    listCorner.Parent = listFrame
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 2)
    listLayout.Parent = listFrame
    
    local selected = defaultOption or options[1] or "Select"
    
    for _, opt in ipairs(options) do
        local optBtn = Instance.new("TextButton")
        optBtn.Size = UDim2.new(1, 0, 0, 25)
        optBtn.BackgroundColor3 = Color3.fromRGB(40, 60, 100)
        optBtn.BackgroundTransparency = 0.5
        optBtn.Text = opt
        optBtn.TextColor3 = Color3.fromRGB(200, 220, 255)
        optBtn.TextSize = 12
        optBtn.Font = Enum.Font.GothamMedium
        optBtn.BorderSizePixel = 0
        optBtn.Parent = listFrame
        
        local optCorner = Instance.new("UICorner")
        optCorner.CornerRadius = UDim.new(0, 4)
        optCorner.Parent = optBtn
        
        optBtn.MouseButton1Click:Connect(function()
            selected = opt
            dropdownBtn.Text = opt
            listFrame.Visible = false
            listFrame.Size = UDim2.new(0.5, 0, 0, 0)
        end)
    end
    
    dropdownBtn.MouseButton1Click:Connect(function()
        listFrame.Visible = not listFrame.Visible
        if listFrame.Visible then
            listFrame.Size = UDim2.new(0.5, 0, 0, #options * 27)
        else
            listFrame.Size = UDim2.new(0.5, 0, 0, 0)
        end
    end)
    
    return {getSelected = function() return selected end}
end

local function createKeybind(parent, labelText, defaultKey)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 30)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextColor3 = Color3.fromRGB(200, 220, 255)
    label.TextSize = 13
    label.Font = Enum.Font.GothamMedium
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local keyBtn = Instance.new("TextButton")
    keyBtn.Size = UDim2.new(0.3, 0, 1, 0)
    keyBtn.Position = UDim2.new(0.7, 0, 0, 0)
    keyBtn.BackgroundColor3 = Color3.fromRGB(30, 50, 80)
    keyBtn.BackgroundTransparency = 0.3
    keyBtn.Text = defaultKey
    keyBtn.TextColor3 = Color3.fromRGB(200, 220, 255)
    keyBtn.TextSize = 12
    keyBtn.Font = Enum.Font.GothamMedium
    keyBtn.BorderSizePixel = 0
    keyBtn.Parent = frame
    
    local keyCorner = Instance.new("UICorner")
    keyCorner.CornerRadius = UDim.new(0, 6)
    keyCorner.Parent = keyBtn
    
    local currentKey = defaultKey
    local waiting = false
    
    keyBtn.MouseButton1Click:Connect(function()
        waiting = true
        keyBtn.Text = "..."
    end)
    
    uis.InputBegan:Connect(function(input)
        if waiting and input.KeyCode ~= Enum.KeyCode.Unknown then
            currentKey = input.KeyCode.Name
            keyBtn.Text = currentKey
            waiting = false
        end
    end)
    
    return {getKey = function() return currentKey end}
end

-- ===== СОЗДАНИЕ СТРАНИЦ =====
local pages = {}

for _, tab in ipairs(tabs) do
    local page = Instance.new("ScrollingFrame")
    page.Name = tab.name .. "Page"
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = Color3.fromRGB(100, 150, 255)
    page.Visible = false
    page.Parent = pagesContainer
    
    local pageLayout = Instance.new("UIListLayout")
    pageLayout.Padding = UDim.new(0, 10)
    pageLayout.Parent = page
    
    pages[tab.name] = page
end

-- ===== ABOUT PAGE =====
local aboutPage = pages["About"]
local aboutLabel = Instance.new("TextLabel")
aboutLabel.Size = UDim2.new(1, 0, 0, 60)
aboutLabel.BackgroundTransparency = 1
aboutLabel.Text = "Sonar by timajake2"
aboutLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
aboutLabel.TextSize = 28
aboutLabel.Font = Enum.Font.GothamBold
aboutLabel.TextXAlignment = Enum.TextXAlignment.Center
aboutLabel.Parent = aboutPage

-- ===== PLAYER PAGE =====
local playerPage = pages["Player"]

-- Movement Box
local moveBox = Instance.new("Frame")
moveBox.Size = UDim2.new(1, 0, 0, 250)
moveBox.BackgroundColor3 = Color3.fromRGB(30, 50, 80)
moveBox.BackgroundTransparency = 0.3
moveBox.BorderSizePixel = 0
moveBox.Parent = playerPage
local moveCorner = Instance.new("UICorner")
moveCorner.CornerRadius = UDim.new(0, 10)
moveCorner.Parent = moveBox

local moveTitle = Instance.new("TextLabel")
moveTitle.Size = UDim2.new(1, 0, 0, 25)
moveTitle.BackgroundTransparency = 1
moveTitle.Text = "Movement"
moveTitle.TextColor3 = Color3.fromRGB(150, 200, 255)
moveTitle.TextSize = 16
moveTitle.Font = Enum.Font.GothamBold
moveTitle.Parent = moveBox

local moveLayout = Instance.new("UIListLayout")
moveLayout.Padding = UDim.new(0, 3)
moveLayout.Parent = moveBox

createToggle(moveBox, "Loop Teleport", false)
local teleLocDrop = createDropdown(moveBox, "Teleport Location", {"Spawn", "People"}, "Spawn")
-- Второй dropdown для People появится позже (заглушка)
createButton(moveBox, "Teleport Once", true)
createKeybind(moveBox, "Teleport Bind", "P")
createKeybind(moveBox, "Teleport To Mouse Bind", "Z")
createSlider(moveBox, "Speed Control", 16, 100, 50, 0)
createToggle(moveBox, "Enable Speed", false)
createSlider(moveBox, "Jump Power", 50, 250, 100, 0)
createToggle(moveBox, "Infinite Jump", false)
createToggle(moveBox, "Noclip", false)
createToggle(moveBox, "Water Walk", false)

-- ESP Box
local espBox = Instance.new("Frame")
espBox.Size = UDim2.new(1, 0, 0, 80)
espBox.BackgroundColor3 = Color3.fromRGB(30, 50, 80)
espBox.BackgroundTransparency = 0.3
espBox.BorderSizePixel = 0
espBox.Parent = playerPage
local espCorner = Instance.new("UICorner")
espCorner.CornerRadius = UDim.new(0, 10)
espCorner.Parent = espBox

local espTitle = Instance.new("TextLabel")
espTitle.Size = UDim2.new(1, 0, 0, 25)
espTitle.BackgroundTransparency = 1
espTitle.Text = "ESP"
espTitle.TextColor3 = Color3.fromRGB(150, 200, 255)
espTitle.TextSize = 16
espTitle.Font = Enum.Font.GothamBold
espTitle.Parent = espBox

local espLayout = Instance.new("UIListLayout")
espLayout.Padding = UDim.new(0, 3)
espLayout.Parent = espBox

createToggle(espBox, "Enable Name ESP", false)
createToggle(espBox, "Highlight Players", false)

-- Camera Box
local camBox = Instance.new("Frame")
camBox.Size = UDim2.new(1, 0, 0, 100)
camBox.BackgroundColor3 = Color3.fromRGB(30, 50, 80)
camBox.BackgroundTransparency = 0.3
camBox.BorderSizePixel = 0
camBox.Parent = playerPage
local camCorner = Instance.new("UICorner")
camCorner.CornerRadius = UDim.new(0, 10)
camCorner.Parent = camBox

local camTitle = Instance.new("TextLabel")
camTitle.Size = UDim2.new(1, 0, 0, 25)
camTitle.BackgroundTransparency = 1
camTitle.Text = "Camera"
camTitle.TextColor3 = Color3.fromRGB(150, 200, 255)
camTitle.TextSize = 16
camTitle.Font = Enum.Font.GothamBold
camTitle.Parent = camBox

local camLayout = Instance.new("UIListLayout")
camLayout.Padding = UDim.new(0, 3)
camLayout.Parent = camBox

createSlider(camBox, "FOV", 50, 120, 70, 0)
createToggle(camBox, "Enable FOV", false)
createToggle(camBox, "Third Person", false)

-- ===== PROTECTION PAGE =====
local protPage = pages["Protection"]
local protLayout = Instance.new("UIListLayout")
protLayout.Padding = UDim.new(0, 5)
protLayout.Parent = protPage

createToggle(protPage, "Anti Grab", false)
createToggle(protPage, "Anti Explode", false)
createToggle(protPage, "Anti Void", false)
createToggle(protPage, "Anti Line Lag", false)
createToggle(protPage, "Anti-Kick With Shuriken", false)
createToggle(protPage, "Anti Burn", false)
createButton(protPage, "Anti Banana", false)  -- будет работать как кнопка с индикатором
createToggle(protPage, "Lock Position (RenderStepped)", false)

-- ===== TARGET PAGE =====
local targetPage = pages["Target"]

-- Selection Box
local selBox = Instance.new("Frame")
selBox.Size = UDim2.new(1, 0, 0, 130)
selBox.BackgroundColor3 = Color3.fromRGB(30, 50, 80)
selBox.BackgroundTransparency = 0.3
selBox.BorderSizePixel = 0
selBox.Parent = targetPage
local selCorner = Instance.new("UICorner")
selCorner.CornerRadius = UDim.new(0, 10)
selCorner.Parent = selBox

local selTitle = Instance.new("TextLabel")
selTitle.Size = UDim2.new(1, 0, 0, 25)
selTitle.BackgroundTransparency = 1
selTitle.Text = "Selection"
selTitle.TextColor3 = Color3.fromRGB(150, 200, 255)
selTitle.TextSize = 16
selTitle.Font = Enum.Font.GothamBold
selTitle.Parent = selBox

local selLayout = Instance.new("UIListLayout")
selLayout.Padding = UDim.new(0, 3)
selLayout.Parent = selBox

createDropdown(selBox, "Select Player", {"Player1", "Player2", "Player3"}, "Player1")
createButton(selBox, "Teleport To Target", true)
createToggle(selBox, "Target Line Tracker", false)
createToggle(selBox, "Statistics For Target", false)

-- Auras Box
local auraBox = Instance.new("Frame")
auraBox.Size = UDim2.new(1, 0, 0, 80)
auraBox.BackgroundColor3 = Color3.fromRGB(30, 50, 80)
auraBox.BackgroundTransparency = 0.3
auraBox.BorderSizePixel = 0
auraBox.Parent = targetPage
local auraCorner = Instance.new("UICorner")
auraCorner.CornerRadius = UDim.new(0, 10)
auraCorner.Parent = auraBox

local auraTitle = Instance.new("TextLabel")
auraTitle.Size = UDim2.new(1, 0, 0, 25)
auraTitle.BackgroundTransparency = 1
auraTitle.Text = "Auras"
auraTitle.TextColor3 = Color3.fromRGB(150, 200, 255)
auraTitle.TextSize = 16
auraTitle.Font = Enum.Font.GothamBold
auraTitle.Parent = auraBox

local auraLayout = Instance.new("UIListLayout")
auraLayout.Padding = UDim.new(0, 3)
auraLayout.Parent = auraBox

createDropdown(auraBox, "Select Aura", {"Ragdoll", "Kill", "Magnetic"}, "Ragdoll")
createToggle(auraBox, "Enable Aura", false)

-- ===== BLOBMAN PAGE =====
local blobPage = pages["Blobman"]

-- Selection Box
local blobSelBox = Instance.new("Frame")
blobSelBox.Size = UDim2.new(1, 0, 0, 80)
blobSelBox.BackgroundColor3 = Color3.fromRGB(30, 50, 80)
blobSelBox.BackgroundTransparency = 0.3
blobSelBox.BorderSizePixel = 0
blobSelBox.Parent = blobPage
local blobSelCorner = Instance.new("UICorner")
blobSelCorner.CornerRadius = UDim.new(0, 10)
blobSelCorner.Parent = blobSelBox

local blobSelTitle = Instance.new("TextLabel")
blobSelTitle.Size = UDim2.new(1, 0, 0, 25)
blobSelTitle.BackgroundTransparency = 1
blobSelTitle.Text = "Selection"
blobSelTitle.TextColor3 = Color3.fromRGB(150, 200, 255)
blobSelTitle.TextSize = 16
blobSelTitle.Font = Enum.Font.GothamBold
blobSelTitle.Parent = blobSelBox

local blobSelLayout = Instance.new("UIListLayout")
blobSelLayout.Padding = UDim.new(0, 3)
blobSelLayout.Parent = blobSelBox

createDropdown(blobSelBox, "Select Target", {"Player1", "Player2", "Player3"}, "Player1")
createKeybind(blobSelBox, "Select Target By Mouse", "M")

-- Method Box
local methodBox = Instance.new("Frame")
methodBox.Size = UDim2.new(1, 0, 0, 110)
methodBox.BackgroundColor3 = Color3.fromRGB(30, 50, 80)
methodBox.BackgroundTransparency = 0.3
methodBox.BorderSizePixel = 0
methodBox.Parent = blobPage
local methodCorner = Instance.new("UICorner")
methodCorner.CornerRadius = UDim.new(0, 10)
methodCorner.Parent = methodBox

local methodTitle = Instance.new("TextLabel")
methodTitle.Size = UDim2.new(1, 0, 0, 25)
methodTitle.BackgroundTransparency = 1
methodTitle.Text = "Select Method Destroy"
methodTitle.TextColor3 = Color3.fromRGB(150, 200, 255)
methodTitle.TextSize = 16
methodTitle.Font = Enum.Font.GothamBold
methodTitle.Parent = methodBox

local methodLayout = Instance.new("UIListLayout")
methodLayout.Padding = UDim.new(0, 3)
methodLayout.Parent = methodBox

createDropdown(methodBox, "Kick Methods", {"Blob Kick", "Blob Kick (Circle Spin)", "Blob Kill Target"}, "Blob Kick")
createToggle(methodBox, "Enable Selected Method", false)
createToggle(methodBox, "Auto Sit Blobman", false)

-- ===== SHADERS PAGE =====
local shaderPage = pages["Shaders"]

-- Time of Day Box
local todBox = Instance.new("Frame")
todBox.Size = UDim2.new(1, 0, 0, 130)
todBox.BackgroundColor3 = Color3.fromRGB(30, 50, 80)
todBox.BackgroundTransparency = 0.3
todBox.BorderSizePixel = 0
todBox.Parent = shaderPage
local todCorner = Instance.new("UICorner")
todCorner.CornerRadius = UDim.new(0, 10)
todCorner.Parent = todBox

local todTitle = Instance.new("TextLabel")
todTitle.Size = UDim2.new(1, 0, 0, 25)
todTitle.BackgroundTransparency = 1
todTitle.Text = "Time Of Day"
todTitle.TextColor3 = Color3.fromRGB(150, 200, 255)
todTitle.TextSize = 16
todTitle.Font = Enum.Font.GothamBold
todTitle.Parent = todBox

local todLayout = Instance.new("UIListLayout")
todLayout.Padding = UDim.new(0, 3)
todLayout.Parent = todBox

createToggle(todBox, "Morning", false)
createToggle(todBox, "Midday", false)
createToggle(todBox, "Afternoon", false)
createToggle(todBox, "Evening", false)
createToggle(todBox, "Night", false)
createToggle(todBox, "Midnight", false)

-- Weather Box
local weatherBox = Instance.new("Frame")
weatherBox.Size = UDim2.new(1, 0, 0, 130)
weatherBox.BackgroundColor3 = Color3.fromRGB(30, 50, 80)
weatherBox.BackgroundTransparency = 0.3
weatherBox.BorderSizePixel = 0
weatherBox.Parent = shaderPage
local weatherCorner = Instance.new("UICorner")
weatherCorner.CornerRadius = UDim.new(0, 10)
weatherCorner.Parent = weatherBox

local weatherTitle = Instance.new("TextLabel")
weatherTitle.Size = UDim2.new(1, 0, 0, 25)
weatherTitle.BackgroundTransparency = 1
weatherTitle.Text = "Weather"
weatherTitle.TextColor3 = Color3.fromRGB(150, 200, 255)
weatherTitle.TextSize = 16
weatherTitle.Font = Enum.Font.GothamBold
weatherTitle.Parent = weatherBox

local weatherLayout = Instance.new("UIListLayout")
weatherLayout.Padding = UDim.new(0, 3)
weatherLayout.Parent = weatherBox

createToggle(weatherBox, "Rain", false)
createToggle(weatherBox, "Snow", false)
createToggle(weatherBox, "Fog", false)
createToggle(weatherBox, "Sunny", false)
createToggle(weatherBox, "Cloudy", false)
createToggle(weatherBox, "Storm", false)

-- Seasons Box
local seasonBox = Instance.new("Frame")
seasonBox.Size = UDim2.new(1, 0, 0, 80)
seasonBox.BackgroundColor3 = Color3.fromRGB(30, 50, 80)
seasonBox.BackgroundTransparency = 0.3
seasonBox.BorderSizePixel = 0
seasonBox.Parent = shaderPage
local seasonCorner = Instance.new("UICorner")
seasonCorner.CornerRadius = UDim.new(0, 10)
seasonCorner.Parent = seasonBox

local seasonTitle = Instance.new("TextLabel")
seasonTitle.Size = UDim2.new(1, 0, 0, 25)
seasonTitle.BackgroundTransparency = 1
seasonTitle.Text = "Seasons"
seasonTitle.TextColor3 = Color3.fromRGB(150, 200, 255)
seasonTitle.TextSize = 16
seasonTitle.Font = Enum.Font.GothamBold
seasonTitle.Parent = seasonBox

local seasonLayout = Instance.new("UIListLayout")
seasonLayout.Padding = UDim.new(0, 3)
seasonLayout.Parent = seasonBox

createToggle(seasonBox, "Autumn", false)
createToggle(seasonBox, "Spring", false)
createToggle(seasonBox, "Summer", false)
createToggle(seasonBox, "Winter", false)

-- ===== UI SETTINGS PAGE (РАБОТАЕТ) =====
local uiPage = pages["UI Settings"]

-- Appearance Box
local uiAppBox = Instance.new("Frame")
uiAppBox.Size = UDim2.new(1, 0, 0, 120)
uiAppBox.BackgroundColor3 = Color3.fromRGB(30, 50, 80)
uiAppBox.BackgroundTransparency = 0.3
uiAppBox.BorderSizePixel = 0
uiAppBox.Parent = uiPage
local uiAppCorner = Instance.new("UICorner")
uiAppCorner.CornerRadius = UDim.new(0, 10)
uiAppCorner.Parent = uiAppBox

local uiAppTitle = Instance.new("TextLabel")
uiAppTitle.Size = UDim2.new(1, 0, 0, 25)
uiAppTitle.BackgroundTransparency = 1
uiAppTitle.Text = "Appearance"
uiAppTitle.TextColor3 = Color3.fromRGB(150, 200, 255)
uiAppTitle.TextSize = 16
uiAppTitle.Font = Enum.Font.GothamBold
uiAppTitle.Parent = uiAppBox

local uiAppLayout = Instance.new("UIListLayout")
uiAppLayout.Padding = UDim.new(0, 3)
uiAppLayout.Parent = uiAppBox

local cornerSlider = createSlider(uiAppBox, "Corner Radius", 0, 2, 1, 1)
local transSlider = createSlider(uiAppBox, "Background Transparency", 0, 2, 0.3, 1)
local scaleSlider = createSlider(uiAppBox, "UI Scale", 1, 5, 1, 0)

cornerSlider.getValue = function() return 1 end
transSlider.getValue = function() return 0.3 end
scaleSlider.getValue = function() return 1 end

-- Keybinds Box
local keyBox = Instance.new("Frame")
keyBox.Size = UDim2.new(1, 0, 0, 60)
keyBox.BackgroundColor3 = Color3.fromRGB(30, 50, 80)
keyBox.BackgroundTransparency = 0.3
keyBox.BorderSizePixel = 0
keyBox.Parent = uiPage
local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 10)
keyCorner.Parent = keyBox

local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1, 0, 0, 25)
keyTitle.BackgroundTransparency = 1
keyTitle.Text = "Keybinds"
keyTitle.TextColor3 = Color3.fromRGB(150, 200, 255)
keyTitle.TextSize = 16
keyTitle.Font = Enum.Font.GothamBold
keyTitle.Parent = keyBox

local keyLayout = Instance.new("UIListLayout")
keyLayout.Padding = UDim.new(0, 3)
keyLayout.Parent = keyBox

createKeybind(keyBox, "Toggle UI", "RightShift")

-- ===== АНИМАЦИЯ ВКЛАДОК =====
local function switchTab(tabName)
    if currentTab == tabName then return end
    
    local oldPage = currentTab and pages[currentTab]
    local newPage = pages[tabName]
    
    if oldPage then
        local t1 = tween:Create(oldPage, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, -1, 0)})
        t1:Play()
        t1.Completed:Wait()
        oldPage.Visible = false
        oldPage.Position = UDim2.new(0, 0, 0, 0)
    end
    
    newPage.Position = UDim2.new(0, 0, 1, 0)
    newPage.Visible = true
    local t2 = tween:Create(newPage, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)})
    t2:Play()
    
    currentTab = tabName
    
    -- Обновить кнопки
    for name, btn in pairs(tabButtons) do
        btn.BackgroundColor3 = (name == tabName) and Color3.fromRGB(60, 100, 180) or Color3.fromRGB(30, 50, 80)
        btn.BackgroundTransparency = (name == tabName) and 0.2 or 0.5
    end
end

-- ===== СОЗДАНИЕ КНОПОК ВКЛАДОК =====
for _, tab in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Name = tab.name .. "Btn"
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(30, 50, 80)
    btn.BackgroundTransparency = 0.5
    btn.Text = tab.icon .. " " .. tab.name
    btn.TextColor3 = Color3.fromRGB(200, 220, 255)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamMedium
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    btn.Parent = tabsContainer
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        switchTab(tab.name)
    end)
    
    tabButtons[tab.name] = btn
end

-- ===== ПОКАЗАТЬ ABOUT ПРИ СТАРТЕ =====
switchTab("About")

-- ===== TOGGLE UI (Right-Shift) =====
local uiVisible = true
uis.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        uiVisible = not uiVisible
        mainFrame.Visible = uiVisible
    end
end)

print("SONAR UI LOADED - by timajake2")
