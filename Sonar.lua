local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Текущая клавиша скрытия меню (по умолчанию Right Shift)
local toggleKey = Enum.KeyCode.RightShift
local isListeningForKey = false

-- Создание UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MainMenuGui"
ScreenGui.ResetOnSpawn = false

-- ПРИОРИТЕТ ОТОБРАЖЕНИЯ: ставим максимальный слой, чтобы быть выше всех
ScreenGui.DisplayOrder = 999999999 
ScreenGui.IgnoreGuiInset = true -- Игнорировать верхнюю черную полосу Roblox (топбар)

ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0.4, 0, 0.5, 0)
MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- ФУНКЦИЯ СКРЫТИЯ/ПОКАЗА МЕНЮ
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end -- Игнорируем, если игрок пишет в чат
	
	if isListeningForKey then
		if input.UserInputType == Enum.UserInputType.Keyboard then
			toggleKey = input.KeyCode
			isListeningForKey = false
			local keybindButton = MainFrame:FindFirstChild("KeybindsButton")
			if keybindButton then
				keybindButton.Text = "Bind: " .. toggleKey.Name
			end
		end
	else
		if input.KeyCode == toggleKey then
			MainFrame.Visible = not MainFrame.Visible
		end
	end
end)

-- Профиль игрока (слева снизу)
local ProfileFrame = Instance.new("Frame")
ProfileFrame.Name = "ProfileFrame"
ProfileFrame.Size = UDim2.new(0.4, 0, 0.2, 0)
ProfileFrame.Position = UDim2.new(0.02, 0, 0.78, 0)
ProfileFrame.BackgroundTransparency = 1
ProfileFrame.Parent = MainFrame

local AvatarImage = Instance.new("ImageLabel")
AvatarImage.Name = "AvatarImage"
AvatarImage.Size = UDim2.new(0, 50, 0, 50)
AvatarImage.Position = UDim2.new(0, 0, 0.5, -25)
AvatarImage.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
AvatarImage.BorderSizePixel = 0

local userId = LocalPlayer.UserId
local thumbType = Enum.ThumbnailType.AvatarBust
local thumbSize = Enum.ThumbnailSize.Size100x100
local content, isReady = Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)
AvatarImage.Image = content
AvatarImage.Parent = ProfileFrame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0.5, 0)
UICorner.Parent = AvatarImage

local UsernameLabel = Instance.new("TextLabel")
UsernameLabel.Name = "UsernameLabel"
UsernameLabel.Size = UDim2.new(1, -60, 1, 0)
UsernameLabel.Position = UDim2.new(0, 60, 0, 0)
UsernameLabel.BackgroundTransparency = 1
UsernameLabel.Text = LocalPlayer.Name
UsernameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
UsernameLabel.TextXAlignment = Enum.TextXAlignment.Left
UsernameLabel.Font = Enum.Font.SourceSansBold
UsernameLabel.TextSize = 18
UsernameLabel.Parent = ProfileFrame

-- КНОПКА КЕЙБИНДОВ (над профилем)
local KeybindsButton = Instance.new("TextButton")
KeybindsButton.Name = "KeybindsButton"
KeybindsButton.Size = UDim2.new(0.35, 0, 0.1, 0)
KeybindsButton.Position = UDim2.new(0.02, 0, 0.65, 0)
KeybindsButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
KeybindsButton.Text = "Bind: " .. toggleKey.Name
KeybindsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
KeybindsButton.Font = Enum.Font.SourceSans
KeybindsButton.TextSize = 16
KeybindsButton.Parent = MainFrame

KeybindsButton.MouseButton1Click:Connect(function()
	isListeningForKey = true
	KeybindsButton.Text = "Press any key..."
end)

-- КНОПКА MISC (выше кейбиндов)
local MiscButton = Instance.new("TextButton")
MiscButton.Name = "MiscButton"
MiscButton.Size = UDim2.new(0.35, 0, 0.1, 0)
MiscButton.Position = UDim2.new(0.02, 0, 0.52, 0)
MiscButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MiscButton.Text = "Misc"
MiscButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MiscButton.Font = Enum.Font.SourceSans
MiscButton.TextSize = 16
MiscButton.Parent = MainFrame

MiscButton.MouseButton1Click:Connect(function()
	print("Кнопка Misc была нажата!")
end)
