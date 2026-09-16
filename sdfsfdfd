local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Connections = {}
local AllLabels = {}
local AllFramesForSize = {}

if CoreGui:FindFirstChild("LiquidGlassMenu") then
    CoreGui.LiquidGlassMenu:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LiquidGlassMenu"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999999

local Theme = {
    Current = "Light",
    Light = {
        MainBg = Color3.fromRGB(240, 242, 245),
        MainTrans = 0.15,
        MainStroke = Color3.fromRGB(255, 255, 255),
        MainStrokeTrans = 0.35,
        SidebarBg = Color3.fromRGB(220, 224, 232),
        TextDark = Color3.fromRGB(60, 65, 75),
        TextLight = Color3.fromRGB(110, 115, 125),
        TextActive = Color3.fromRGB(40, 45, 55),
        Grad1 = Color3.fromRGB(255, 255, 255),
        Grad2 = Color3.fromRGB(225, 228, 235),
        CloseBg = Color3.fromRGB(0, 0, 0),
        CloseBgTrans = 0.95,
        CloseText = Color3.fromRGB(120, 125, 135)
    },
    Dark = {
        MainBg = Color3.fromRGB(18, 18, 24),
        MainTrans = 0.22,
        MainStroke = Color3.fromRGB(255, 255, 255),
        MainStrokeTrans = 0.65,
        SidebarBg = Color3.fromRGB(12, 12, 18),
        TextDark = Color3.fromRGB(240, 240, 245),
        TextLight = Color3.fromRGB(160, 160, 170),
        TextActive = Color3.fromRGB(255, 255, 255),
        Grad1 = Color3.fromRGB(255, 255, 255),
        Grad2 = Color3.fromRGB(120, 120, 130),
        CloseBg = Color3.fromRGB(255, 255, 255),
        CloseBgTrans = 0.95,
        CloseText = Color3.fromRGB(180, 185, 195)
    }
}

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 550, 0, 350)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -175)
MainFrame.BackgroundColor3 = Theme.Light.MainBg
MainFrame.BackgroundTransparency = Theme.Light.MainTrans
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui
table.insert(AllFramesForSize, MainFrame)

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 2
MainStroke.Color = Theme.Light.MainStroke
MainStroke.Transparency = Theme.Light.MainStrokeTrans
MainStroke.Parent = MainFrame

local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Theme.Light.Grad1),
    ColorSequenceKeypoint.new(1, Theme.Light.Grad2)
})
MainGradient.Rotation = 45
MainGradient.Parent = MainFrame

local dragging = false
local dragStart, startPos
local targetPosition = MainFrame.Position

table.insert(Connections, MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end))

table.insert(Connections, RunService.Heartbeat:Connect(function()
    if dragging and dragStart and startPos then
        local delta = UserInputService:GetMouseLocation() - Vector2.new(dragStart.X, dragStart.Y)
        delta = delta - Vector2.new(0, 36) 
        targetPosition = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    if MainFrame.Visible then
        MainFrame.Position = MainFrame.Position:Lerp(targetPosition, 0.15)
    end
end))

local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 140, 1, 0)
Sidebar.BackgroundColor3 = Theme.Light.SidebarBg
Sidebar.BackgroundTransparency = 0.3
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 16)
SidebarCorner.Parent = Sidebar

local TabButtonsContainer = Instance.new("Frame")
TabButtonsContainer.Name = "TabButtons"
TabButtonsContainer.Size = UDim2.new(1, -20, 1, -60)
TabButtonsContainer.Position = UDim2.new(0, 10, 0, 50)
TabButtonsContainer.BackgroundTransparency = 1
TabButtonsContainer.Parent = Sidebar

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.Padding = UDim.new(0, 4)
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Parent = TabButtonsContainer

local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Size = UDim2.new(1, -160, 1, -50)
ContentContainer.Position = UDim2.new(0, 150, 0, 40)
ContentContainer.BackgroundTransparency = 1
ContentContainer.ClipsDescendants = true
ContentContainer.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 0, 40)
Title.Position = UDim2.new(0, 15, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "LIQUID UI"
Title.TextColor3 = Theme.Light.TextDark
Title.Font = Enum.Font.GothamBold
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Sidebar
table.insert(AllLabels, Title)

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 26, 0, 26)
CloseButton.Position = UDim2.new(1, -36, 0, 12)
CloseButton.BackgroundColor3 = Theme.Light.CloseBg
CloseButton.BackgroundTransparency = Theme.Light.CloseBgTrans
CloseButton.Text = "×"
CloseButton.TextColor3 = Theme.Light.CloseText
CloseButton.Font = Enum.Font.GothamMedium
CloseButton.TextSize = 18
CloseButton.Parent = MainFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseButton

local CloseStroke = Instance.new("UIStroke")
CloseStroke.Thickness = 1
CloseStroke.Color = Color3.fromRGB(255, 255, 255)
CloseStroke.Transparency = 0.6
CloseStroke.Parent = CloseButton

CloseButton.MouseEnter:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 90, 90), BackgroundTransparency = 0.2, TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
    TweenService:Create(CloseStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(255, 90, 90), Transparency = 0.4}):Play()
end)

CloseButton.MouseLeave:Connect(function()
    local currentColors = Theme[Theme.Current]
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = currentColors.CloseBg, BackgroundTransparency = currentColors.CloseBgTrans, TextColor3 = currentColors.CloseText}):Play()
    TweenService:Create(CloseStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(255, 255, 255), Transparency = 0.6}):Play()
end)

local function UnloadScript()
    dragging = false
    local targetPos = UDim2.new(MainFrame.Position.X.Scale, MainFrame.Position.X.Offset + (MainFrame.Size.X.Offset / 2), MainFrame.Position.Y.Scale, MainFrame.Position.Y.Offset + (MainFrame.Size.Y.Offset / 2))
    local closeTween = TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), Position = targetPos, BackgroundTransparency = 1})
    TweenService:Create(MainStroke, TweenInfo.new(0.15), {Transparency = 1}):Play()
    closeTween:Play()
    closeTween.Completed:Wait()
    for _, connection in pairs(Connections) do if connection then connection:Disconnect() end end
    ScreenGui:Destroy()
end
CloseButton.MouseButton1Click:Connect(UnloadScript)

local activeTab = nil
local isSwitchingTab = false

local function CreateTab(tabName, isDefault)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 28)
    Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Button.BackgroundTransparency = 1
    Button.Text = "  " .. tabName
    Button.TextColor3 = Theme.Light.TextLight
    Button.Font = Enum.Font.GothamMedium
    Button.TextSize = 11
    Button.TextXAlignment = Enum.TextXAlignment.Left
    Button.Parent = TabButtonsContainer
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 6)
    ButtonCorner.Parent = Button
    
    local Page = Instance.new("ScrollingFrame")
    Page.Name = tabName .. "Page"
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 2
    Page.Visible = false
    Page.Parent = ContentContainer
    
    local PageListLayout = Instance.new("UIListLayout")
    PageListLayout.Padding = UDim.new(0, 10)
    PageListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    PageListLayout.Parent = Page
    
    local function select()
        if isSwitchingTab or (activeTab and activeTab.Button == Button) then return end
        isSwitchingTab = true
        local oldTab = activeTab
        activeTab = {Button = Button, Page = Page}
        TweenService:Create(Button, TweenInfo.new(0.25), {BackgroundTransparency = 0.5, TextColor3 = Theme[Theme.Current].TextActive}):Play()
        if oldTab then
            TweenService:Create(oldTab.Button, TweenInfo.new(0.25), {BackgroundTransparency = 1, TextColor3 = Theme[Theme.Current].TextLight}):Play()
            local oldOut = TweenService:Create(oldTab.Page, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, -1, 0)})
            oldOut:Play()
            oldOut.Completed:Connect(function() oldTab.Page.Visible = false end)
        end
        Page.Position = UDim2.new(0, 0, 1, 0)
        Page.Visible = true
        local newIn = TweenService:Create(Page, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)})
        newIn:Play()
        newIn.Completed:Wait()
        isSwitchingTab = false
    end
    
    Button.MouseButton1Click:Connect(select)
    Button.MouseEnter:Connect(function() if not activeTab or activeTab.Button ~= Button then TweenService:Create(Button, TweenInfo.new(0.2), {TextColor3 = Theme[Theme.Current].TextDark}):Play() end end)
    Button.MouseLeave:Connect(function() if not activeTab or activeTab.Button ~= Button then TweenService:Create(Button, TweenInfo.new(0.2), {TextColor3 = Theme[Theme.Current].TextLight}):Play() end end)
    
    if isDefault then
        activeTab = {Button = Button, Page = Page}
        Button.BackgroundTransparency = 0.5
        Button.TextColor3 = Theme.Light.TextActive
        Page.Position = UDim2.new(0, 0, 0, 0)
        Page.Visible = true
    end
    return Page, Button
end

local HomePage, HomeBtn = CreateTab("Home", true)
local PlayerPage, PlayerBtn = CreateTab("Player", false)
local GrabPage, GrabBtn = CreateTab("Grab", false)
local TargetPage, TargetBtn = CreateTab("Target", false)
local ServerPage, ServerBtn = CreateTab("Server", false)
local MiscPage, MiscBtn = CreateTab("Misc", false)
local UISettingsPage, UISettingsBtn = CreateTab("UI Settings", false)

-- Индикатор пользователя
local UserIndicator = Instance.new("Frame")
UserIndicator.Name = "UserIndicator"
UserIndicator.Size = UDim2.new(0.1, 0, 0.1, 0)
UserIndicator.Position = UDim2.new(0.05, 0, 0.9, 0)
UserIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
UserIndicator.BackgroundTransparency = 0.3
UserIndicator.BorderSizePixel = 0
UserIndicator.Parent = MainFrame

local UserAvatar = Instance.new("ImageLabel")
UserAvatar.Size = UDim2.new(1, 0, 1, 0)
UserAvatar.Position = UDim2.new(0, 0, 0, 0)
UserAvatar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
UserAvatar.BackgroundTransparency = 1
UserAvatar.Image = Players.LocalPlayer.Character.Head.Image
UserAvatar.Parent = UserIndicator

local UserName = Instance.new("TextLabel")
UserName.Size = UDim2.new(1, 0, 0.3, 0)
UserName.Position = UDim2.new(0, 0, 0.7, 0)
UserName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
UserName.BackgroundTransparency = 1
UserName.Text = Players.LocalPlayer.Name
UserName.TextColor3 = Theme.Light.TextDark
UserName.TextSize = 18
UserName.Font = Enum.Font.SourceSans
UserName.Parent = UserIndicator

-- Вкладка: HOME
local WelcomeText = Instance.new("TextLabel")
WelcomeText.Size = UDim2.new(1, 0, 0, 40)
WelcomeText.BackgroundTransparency = 1
WelcomeText.Text = "Liquid UI Хаб успешно инициализирован.\nИспользуйте меню слева для навигации."
WelcomeText.TextColor3 = Theme.Light.TextLight
WelcomeText.Font = Enum.Font.GothamMedium
WelcomeText.TextSize = 12
WelcomeText.TextXAlignment = Enum.TextXAlignment.Left
WelcomeText.Parent = HomePage
table.insert(AllLabels, WelcomeText)

local AuthorText = Instance.new("TextLabel")
AuthorText.Size = UDim2.new(0, 150, 0, 20)
AuthorText.Position = UDim2.new(1, -160, 1, -25)
AuthorText.BackgroundTransparency = 1
AuthorText.Text = "Made By timajake2"
AuthorText.TextColor3 = Theme.Light.TextLight
AuthorText.Font = Enum.Font.GothamBold
AuthorText.TextSize = 11
AuthorText.TextXAlignment = Enum.TextXAlignment.Right
AuthorText.Parent = MainFrame
table.insert(AllLabels, AuthorText)

-- Вкладка: PLAYER
local tpToggle = false
CreateToggle(PlayerPage, "Режим 3-го лица", false, function(state)
    tpToggle = state
    local lp = Players.LocalPlayer
    if lp then lp.CameraMode = state and Enum.CameraMode.Classic or Enum.CameraMode.LockFirstPerson end
end)

local wsEnabled = false
local wsVal = 16
local wsTgl = CreateToggle(PlayerPage, "Включить скорость бега", false, function(state)
    wsEnabled = state
    local char = Players.LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then char:FindFirstChildOfClass("Humanoid").WalkSpeed = state and wsVal or 16 end
end)
CreateSlider(PlayerPage, "Скорость бега", 16, 50, 16, function(val)
    wsVal = val
    local char = Players.LocalPlayer.Character
    if wsEnabled and char and char:FindFirstChildOfClass("Humanoid") then char:FindFirstChildOfClass("Humanoid").WalkSpeed = val end
end)

local jpEnabled = false
local jpVal = 50
local jpTgl = CreateToggle(PlayerPage, "Включить силу прыжка", false, function(state)
    jpEnabled = state
    local char = Players.LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        local hum = char:FindFirstChildOfClass("Humanoid")
        hum.UseJumpPower = true
        hum.JumpPower = state and jpVal or 50
    end
end)
CreateSlider(PlayerPage, "Сила прыжка", 50, 200, 50, function(val)
    jpVal = val
    local char = Players.LocalPlayer.Character
    if jpEnabled and char and char:FindFirstChildOfClass("Humanoid") then char:FindFirstChildOfClass("Humanoid").JumpPower = val end
end)

-- Вкладка: GRAB (Интерфейс заглушек)
CreateToggle(GrabPage, "Super Strange", false, function() end)
CreateSlider(GrabPage, "Мощность Grab", 100, 1000, 100, function() end)
CreateToggle(GrabPage, "Kill grab", false, function() end)
CreateToggle(GrabPage, "Kick grab", false, function() end)
CreateToggle(GrabPage, "Anchor grab", false, function() end)

-- Вкладка: TARGET (Интерфейс целей)
local selectedPlr = nil
local plrsList = {}
for _, p in pairs(Players:GetPlayers()) do if p ~= Players.LocalPlayer then table.insert(plrsList, p.Name) end end
local targetDropdown = CreateDropdown(TargetPage, "Выбрать игрока", plrsList, function(name) selectedPlr = Players:FindFirstChild(name) end)

task.spawn(function()
    while task.wait(3) do
        if targetDropdown then
            local current = {}
            for _, p in pairs(Players:GetPlayers()) do if p ~= Players.LocalPlayer then table.insert(current, p.Name) end end
            -- Динамическое обновление списка игроков можно расширить здесь
        end
    end
end)

CreateButton(TargetPage, "Телепорт к игроку", function()
    if selectedPlr and selectedPlr.Character and selectedPlr.Character:FindFirstChild("HumanoidRootPart") and Players.LocalPlayer.Character then
        Players.LocalPlayer.Character:MoveTo(selectedPlr.Character.HumanoidRootPart.Position)
    end
end)

local spectating = false
CreateButton(TargetPage, "Наблюдать (Spectate)", function()
    if selectedPlr and selectedPlr.Character and selectedPlr.Character:FindFirstChildOfClass("Humanoid") then
        spectating = not spectating
        workspace.CurrentCamera.CameraSubject = spectating and selectedPlr.Character:FindFirstChildOfClass("Humanoid") or Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    end
end)

-- Вкладка: SERVER (Заглушки)
CreateToggle(ServerPage, "Line Lag", false, function() end)
CreateToggle(ServerPage, "Kick All", false, function() end)
CreateToggle(ServerPage, "Френдлист (Игнорировать друзей)", false, function() end)
CreateToggle(ServerPage, "Kill All", false, function() end)

-- Вкладка: MISC (Кейбинды и точки телепорта)
local KeybindsFrame = Instance.new("Frame")
KeybindsFrame.Name = "KeybindsFrame"
KeybindsFrame.Size = UDim2.new(0, 160, 0, 100)
KeybindsFrame.Position = UDim2.new(0, 20, 0, 50)
KeybindsFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
KeybindsFrame.BackgroundTransparency = 0.3
KeybindsFrame.Visible = false
KeybindsFrame.Parent = ScreenGui
Instance.new("UICorner", KeybindsFrame).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", KeybindsFrame).Color = Color3.fromRGB(255, 255, 255)

local KbTitle = Instance.new("TextLabel", KeybindsFrame)
KbTitle.Size = UDim2.new(1, 0, 0, 25)
KbTitle.Text = "  Кейбинды"
KbTitle.Font = Enum.Font.GothamBold
KbTitle.TextSize = 11
KbTitle.TextXAlignment = Enum.TextXAlignment.Left

local KbText = Instance.new("TextLabel", KeybindsFrame)
KbText.Size = UDim2.new(1, 0, 1, -25)
KbText.Position = UDim2.new(0, 0, 0, 25)
KbText.Text = "  [RShift] - Меню\n  [X] - Срочный Unload"
KbText.Font = Enum.Font.Gotham
KbText.TextSize = 11
KbText.TextXAlignment = Enum.TextXAlignment.Left

CreateToggle(MiscPage, "Окно Кейбиндов", false, function(state)
    if state then
        KeybindsFrame.Visible = true
        KeybindsFrame.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(KeybindsFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Size = UDim2.new(0, 160, 0, 100)}):Play()
    else
        local tw = TweenService:Create(KeybindsFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 0, 0, 0)})
        tw:Play() tw.Completed:Wait() KeybindsFrame.Visible = false
    end
end)

CreateDropdown(MiscPage, "Телепорт по точкам", {"Spawn", "Pink House", "Green House", "Purple House", "Red House", "Blue House"}, function(place)
    print("Телепорт на локацию: " .. place)
end)

-- Вкладка: UI SETTINGS
local ThemeToggle = CreateToggle(UISettingsPage, "Темный режим UI", false, function(state)
    SetTheme(state and "Dark" or "Light")
end)

CreateSlider(UISettingsPage, "Размер текста шрифта", 10, 18, 12, function(val)
    for _, lbl in pairs(AllLabels) do if lbl then lbl.TextSize = val end end
end)

CreateSlider(UISettingsPage, "Масштаб меню", 80, 130, 100, function(val)
    local scale = val / 100
    for _, f in pairs(AllFramesForSize) do if f then f.Size = UDim2.new(0, 550 * scale, 0, 350 * scale) end end
end)

CreateButton(UISettingsPage, "Change Keybind Menu", function()
    local function SetKeybind(name, keycode)
        themeToggle.Keycode = keycode
    end

    local function PromptKeybind()
        local prompt = Instance.new("ScreenGui")
        prompt.Parent = game.Players.LocalPlayer.PlayerGui
        prompt.Name = "KeybindPrompt"

        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 200, 0, 100)
        frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        frame.Position = UDim2.new(0.5, -100, 0.5, -50)
        frame.ClipsDescendants = true

        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, 0, 0, 20)
        title.Text = "Set Keybind"
        title.TextColor3 = Color3.fromRGB(0, 0, 0)
        title.Font = Enum.Font.GothamBold
        title.TextSize = 14
        title.Position = UDim2.new(0, 0, 0, 0)
        title.Parent = frame

        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 0, 40)
        textLabel.Text = "Press the key you want to bind"
        textLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
        textLabel.Font = Enum.Font.Gotham
        textLabel.TextSize = 12
        textLabel.Position = UDim2.new(0, 0, 0, 20)
        textLabel.Parent = frame

        local function OnKeyReleased(input)
            if input.UserInputType == Enum.UserInputType.Keyboard then
                SetKeybind("KeybindMenu", input.KeyCode)
                prompt:Destroy()
            end
        end

        UserInputService.InputEnded:Connect(OnKeyReleased)
    end

    PromptKeybind()
end)

local isOpened = true
local isTweening = false
local originalSize = UDim2.new(0, 550, 0, 350)

local function ToggleMenu()
    if isTweening then return end
    isTweening = true
    if isOpened then
        dragging = false
        local currentPos = MainFrame.Position
        local targetPos = UDim2.new(currentPos.X.Scale, currentPos.X.Offset + (MainFrame.Size.X.Offset / 2), currentPos.Y.Scale, currentPos.Y.Offset + (MainFrame.Size.Y.Offset / 2))
        targetPosition = targetPos
        local sizeTween = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), Position = targetPos, BackgroundTransparency = 1})
        TweenService:Create(MainStroke, TweenInfo.new(0.15), {Transparency = 1}):Play()
        sizeTween:Play() sizeTween.Completed:Wait()
        MainFrame.Visible = false isOpened = false
    else
        MainFrame.Visible = true
        local centerPos = UDim2.new(0.5, -MainFrame.Size.X.Offset/2, 0.5, -MainFrame.Size.Y.Offset/2)
        targetPosition = centerPos
        local sizeTween = TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = originalSize, Position = centerPos, BackgroundTransparency = Theme[Theme.Current].MainTrans})
        TweenService:Create(MainStroke, TweenInfo.new(0.25), {Transparency = Theme[Theme.Current].MainStrokeTrans}):Play()
        sizeTween:Play() sizeTween.Completed:Wait()
        isOpened = true
    end
    isTweening = false
end

local keybind = Enum.KeyCode.X
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == keybind then
        local char = Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Camera") then
            char.HumanoidRootPart.CFrame = workspace.CurrentCamera.CFrame
        end
    end
end)

table.insert(Connections, UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightShift then ToggleMenu() end
end))

table.insert(Connections, UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.X then UnloadScript() end
end))
