-- Ссылки на сервисы
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Создание главного экрана UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MainMenuGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Создание главного контейнера меню
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0.4, 0, 0.5, 0)
MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Контейнер профиля (левый нижний угол меню)
local ProfileFrame = Instance.new("Frame")
ProfileFrame.Name = "ProfileFrame"
ProfileFrame.Size = UDim2.new(0.4, 0, 0.2, 0)
ProfileFrame.Position = UDim2.new(0.02, 0, 0.78, 0)
ProfileFrame.BackgroundTransparency = 1
ProfileFrame.Parent = MainFrame

-- Аватар игрока (круглый или квадратный)
local AvatarImage = Instance.new("ImageLabel")
AvatarImage.Name = "AvatarImage"
AvatarImage.Size = UDim2.new(0, 50, 0, 50)
AvatarImage.Position = UDim2.new(0, 0, 0.5, -25)
AvatarImage.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
AvatarImage.BorderSizePixel = 0

-- Получение иконки профиля (Bust - голова и плечи)
local userId = LocalPlayer.UserId
local thumbType = Enum.ThumbnailType.AvatarBust
local thumbSize = Enum.ThumbnailSize.Size100x100
local content, isReady = Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)
AvatarImage.Image = content
AvatarImage.Parent = ProfileFrame

-- Скругление для аватара
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0.5, 0) -- Делает аватар круглым
UICorner.Parent = AvatarImage

-- Никнейм игрока
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

-- Кнопка "Misc" (слева, чуть выше профиля)
local MiscButton = Instance.new("TextButton")
MiscButton.Name = "MiscButton"
MiscButton.Size = UDim2.new(0.35, 0, 0.1, 0)
MiscButton.Position = UDim2.new(0.02, 0, 0.65, 0)
MiscButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MiscButton.Text = "Misc"
MiscButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MiscButton.Font = Enum.Font.SourceSans
MiscButton.TextSize = 16
MiscButton.Parent = MainFrame

-- Логика нажатия на кнопку Misc
MiscButton.MouseButton1Click:Connect(function()
	print("Кнопка Misc была нажата игроком: " .. LocalPlayer.Name)
	-- Сюда можно добавить открытие вкладки или выполнение функции
end)
