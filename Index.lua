local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Debris = game:GetService("Debris")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local FRONT_GUI = {}
FRONT_GUI.__index = FRONT_GUI

local Themes = {
   Dark = {
       Primary = Color3.fromRGB(15, 15, 20),
       Secondary = Color3.fromRGB(20, 20, 25),
       Tertiary = Color3.fromRGB(25, 25, 30),
       Accent = Color3.fromRGB(100, 150, 255),
       Success = Color3.fromRGB(46, 204, 113),
       Warning = Color3.fromRGB(255, 193, 7),
       Error = Color3.fromRGB(220, 53, 69),
       Text = Color3.fromRGB(255, 255, 255),
       SubText = Color3.fromRGB(200, 200, 200),
       Border = Color3.fromRGB(60, 60, 65)
   }
}

local function CreateTween(object, info, properties)
   return TweenService:Create(object, info, properties)
end

local function MakeDraggable(frame, handle)
   local dragging = false
   local dragStart = nil
   local startPos = nil

   handle.InputBegan:Connect(function(input)
       if input.UserInputType == Enum.UserInputType.MouseButton1 then
           dragging = true
           dragStart = input.Position
           startPos = frame.Position
       end
   end)

   handle.InputChanged:Connect(function(input)
       if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
           local delta = input.Position - dragStart
           frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
       end
   end)

   handle.InputEnded:Connect(function(input)
       if input.UserInputType == Enum.UserInputType.MouseButton1 then
           dragging = false
       end
   end)
end

local function GetAccountAge(player)
   local ageInDays = player.AccountAge
   if ageInDays < 30 then
       return tostring(ageInDays) .. " Days"
   elseif ageInDays < 365 then
       return tostring(math.floor(ageInDays / 30)) .. " Months"
   else
       return tostring(math.floor(ageInDays / 365)) .. " Years"
   end
end

function FRONT_GUI:CreateWindow(config)
   local Window = {}
   
   local Title = config.Title or "FRONT GUI"
   local SubTitle = config.SubTitle or "by: FRONT EVILL"
   local WelcomeText = config.WelcomeText or "Welcome to GUI"
   local LoadingTime = config.LoadingTime or 2
   local Size = config.Size or UDim2.fromOffset(750, 500)
   local ThemeName = config.Theme or "Dark"
   local MinimizeKey = config.MinimizeKey or Enum.KeyCode.B
   local IconId = config.Icon or "rbxassetid://73031703958632"
   
   local Theme = Themes[ThemeName] or Themes.Dark

   local ScreenGui = Instance.new("ScreenGui")
   ScreenGui.Name = "FRONT_GUI"
   ScreenGui.Parent = PlayerGui
   ScreenGui.ResetOnSpawn = false
   ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

   local NotificationContainer = Instance.new("Frame")
   NotificationContainer.Name = "NotificationContainer"
   NotificationContainer.Parent = ScreenGui
   NotificationContainer.BackgroundTransparency = 1
   NotificationContainer.Size = UDim2.new(0, 320, 1, -20)
   NotificationContainer.Position = UDim2.new(1, -330, 1, -10)
   NotificationContainer.AnchorPoint = Vector2.new(0, 1)
   NotificationContainer.ZIndex = 1000

   local NotificationLayout = Instance.new("UIListLayout")
   NotificationLayout.Parent = NotificationContainer
   NotificationLayout.FillDirection = Enum.FillDirection.Vertical
   NotificationLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
   NotificationLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
   NotificationLayout.Padding = UDim.new(0, 6)
   NotificationLayout.SortOrder = Enum.SortOrder.LayoutOrder

   local WelcomeFrame = Instance.new("Frame")
   WelcomeFrame.Name = "WelcomeFrame"
   WelcomeFrame.Parent = ScreenGui
   WelcomeFrame.BackgroundColor3 = Theme.Primary
   WelcomeFrame.BackgroundTransparency = 0.2
   WelcomeFrame.BorderSizePixel = 0
   WelcomeFrame.Size = UDim2.fromScale(0.32, 0.42)
   WelcomeFrame.Position = UDim2.fromScale(0.5, 0.5)
   WelcomeFrame.AnchorPoint = Vector2.new(0.5, 0.5)
   WelcomeFrame.ZIndex = 100

   local WelcomeConstraint = Instance.new("UISizeConstraint")
   WelcomeConstraint.MinSize = Vector2.new(320, 260)
   WelcomeConstraint.MaxSize = Vector2.new(400, 340)
   WelcomeConstraint.Parent = WelcomeFrame

   local WelcomeCorner = Instance.new("UICorner")
   WelcomeCorner.CornerRadius = UDim.new(0, 20)
   WelcomeCorner.Parent = WelcomeFrame

   local WelcomeStroke = Instance.new("UIStroke")
   WelcomeStroke.Color = Theme.Border
   WelcomeStroke.Thickness = 1
   WelcomeStroke.Transparency = 0.5
   WelcomeStroke.Parent = WelcomeFrame

   local WelcomeBlur = Instance.new("Frame")
   WelcomeBlur.Name = "Blur"
   WelcomeBlur.Parent = WelcomeFrame
   WelcomeBlur.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   WelcomeBlur.BackgroundTransparency = 0.95
   WelcomeBlur.Size = UDim2.new(1, 0, 1, 0)
   WelcomeBlur.Position = UDim2.new(0, 0, 0, 0)

   local WelcomeBlurCorner = Instance.new("UICorner")
   WelcomeBlurCorner.CornerRadius = UDim.new(0, 20)
   WelcomeBlurCorner.Parent = WelcomeBlur

   local PlayerAvatar = Instance.new("ImageLabel")
   PlayerAvatar.Parent = WelcomeFrame
   PlayerAvatar.BackgroundTransparency = 1
   PlayerAvatar.Size = UDim2.fromOffset(65, 65)
   PlayerAvatar.Position = UDim2.fromScale(0.5, 0.22)
   PlayerAvatar.AnchorPoint = Vector2.new(0.5, 0.5)
   PlayerAvatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. Player.UserId .. "&width=150&height=150&format=png"

   local AvatarCorner = Instance.new("UICorner")
   AvatarCorner.CornerRadius = UDim.new(1, 0)
   AvatarCorner.Parent = PlayerAvatar

   local AvatarStroke = Instance.new("UIStroke")
   AvatarStroke.Color = Theme.Accent
   AvatarStroke.Thickness = 2
   AvatarStroke.Transparency = 0.3
   AvatarStroke.Parent = PlayerAvatar

   local PlayerNameLabel = Instance.new("TextLabel")
   PlayerNameLabel.Parent = WelcomeFrame
   PlayerNameLabel.BackgroundTransparency = 1
   PlayerNameLabel.Size = UDim2.fromScale(0.85, 0.08)
   PlayerNameLabel.Position = UDim2.fromScale(0.5, 0.38)
   PlayerNameLabel.AnchorPoint = Vector2.new(0.5, 0.5)
   PlayerNameLabel.Text = Player.DisplayName
   PlayerNameLabel.TextColor3 = Theme.Text
   PlayerNameLabel.TextSize = 17
   PlayerNameLabel.Font = Enum.Font.GothamBold

   local PlayerUsernameLabel = Instance.new("TextLabel")
   PlayerUsernameLabel.Parent = WelcomeFrame
   PlayerUsernameLabel.BackgroundTransparency = 1
   PlayerUsernameLabel.Size = UDim2.fromScale(0.85, 0.06)
   PlayerUsernameLabel.Position = UDim2.fromScale(0.5, 0.46)
   PlayerUsernameLabel.AnchorPoint = Vector2.new(0.5, 0.5)
   PlayerUsernameLabel.Text = "@" .. Player.Name
   PlayerUsernameLabel.TextColor3 = Theme.Accent
   PlayerUsernameLabel.TextSize = 12
   PlayerUsernameLabel.Font = Enum.Font.GothamMedium

   local AccountAgeLabel = Instance.new("TextLabel")
   AccountAgeLabel.Parent = WelcomeFrame
   AccountAgeLabel.BackgroundTransparency = 1
   AccountAgeLabel.Size = UDim2.fromScale(0.85, 0.05)
   AccountAgeLabel.Position = UDim2.fromScale(0.5, 0.53)
   AccountAgeLabel.AnchorPoint = Vector2.new(0.5, 0.5)
   AccountAgeLabel.Text = "Account Age: " .. GetAccountAge(Player)
   AccountAgeLabel.TextColor3 = Theme.SubText
   AccountAgeLabel.TextSize = 10
   AccountAgeLabel.Font = Enum.Font.Gotham

   local WelcomeTitle = Instance.new("TextLabel")
   WelcomeTitle.Parent = WelcomeFrame
   WelcomeTitle.BackgroundTransparency = 1
   WelcomeTitle.Size = UDim2.fromScale(0.85, 0.1)
   WelcomeTitle.Position = UDim2.fromScale(0.5, 0.66)
   WelcomeTitle.AnchorPoint = Vector2.new(0.5, 0.5)
   WelcomeTitle.Text = WelcomeText
   WelcomeTitle.TextColor3 = Theme.Text
   WelcomeTitle.TextSize = 18
   WelcomeTitle.Font = Enum.Font.GothamBold

   local WelcomeSubText = Instance.new("TextLabel")
   WelcomeSubText.Parent = WelcomeFrame
   WelcomeSubText.BackgroundTransparency = 1
   WelcomeSubText.Size = UDim2.fromScale(0.85, 0.06)
   WelcomeSubText.Position = UDim2.fromScale(0.5, 0.76)
   WelcomeSubText.AnchorPoint = Vector2.new(0.5, 0.5)
   WelcomeSubText.Text = "Loading Components..."
   WelcomeSubText.TextColor3 = Theme.SubText
   WelcomeSubText.TextSize = 11
   WelcomeSubText.Font = Enum.Font.Gotham

   local LoadingBar = Instance.new("Frame")
   LoadingBar.Parent = WelcomeFrame
   LoadingBar.BackgroundColor3 = Theme.Secondary
   LoadingBar.BackgroundTransparency = 0.3
   LoadingBar.Size = UDim2.fromScale(0.7, 0.025)
   LoadingBar.Position = UDim2.fromScale(0.5, 0.86)
   LoadingBar.AnchorPoint = Vector2.new(0.5, 0.5)

   local LoadingBarCorner = Instance.new("UICorner")
   LoadingBarCorner.CornerRadius = UDim.new(1, 0)
   LoadingBarCorner.Parent = LoadingBar

   local LoadingProgress = Instance.new("Frame")
   LoadingProgress.Parent = LoadingBar
   LoadingProgress.BackgroundColor3 = Theme.Accent
   LoadingProgress.BackgroundTransparency = 0.2
   LoadingProgress.Size = UDim2.fromScale(0, 1)
   LoadingProgress.Position = UDim2.fromScale(0, 0)

   local LoadingProgressCorner = Instance.new("UICorner")
   LoadingProgressCorner.CornerRadius = UDim.new(1, 0)
   LoadingProgressCorner.Parent = LoadingProgress

   local MainFrame = Instance.new("Frame")
   MainFrame.Name = "MainFrame"
   MainFrame.Parent = ScreenGui
   MainFrame.BackgroundColor3 = Theme.Primary
   MainFrame.BackgroundTransparency = 0.15
   MainFrame.BorderSizePixel = 0
   MainFrame.Size = Size
   MainFrame.Position = UDim2.fromScale(0.5, 0.5)
   MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
   MainFrame.Visible = false

   local MainConstraint = Instance.new("UISizeConstraint")
   MainConstraint.MinSize = Vector2.new(450, 350)
   MainConstraint.MaxSize = Vector2.new(1200, 800)
   MainConstraint.Parent = MainFrame

   local MainCorner = Instance.new("UICorner")
   MainCorner.CornerRadius = UDim.new(0, 20)
   MainCorner.Parent = MainFrame

   local MainStroke = Instance.new("UIStroke")
   MainStroke.Color = Theme.Border
   MainStroke.Thickness = 1
   MainStroke.Transparency = 0.4
   MainStroke.Parent = MainFrame

   local MainBlur = Instance.new("Frame")
   MainBlur.Name = "Blur"
   MainBlur.Parent = MainFrame
   MainBlur.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   MainBlur.BackgroundTransparency = 0.96
   MainBlur.Size = UDim2.new(1, 0, 1, 0)
   MainBlur.Position = UDim2.new(0, 0, 0, 0)

   local MainBlurCorner = Instance.new("UICorner")
   MainBlurCorner.CornerRadius = UDim.new(0, 20)
   MainBlurCorner.Parent = MainBlur

   local TitleBar = Instance.new("Frame")
   TitleBar.Name = "TitleBar"
   TitleBar.Parent = MainFrame
   TitleBar.BackgroundColor3 = Theme.Secondary
   TitleBar.BackgroundTransparency = 0.3
   TitleBar.BorderSizePixel = 0
   TitleBar.Size = UDim2.new(1, 0, 0, 50)
   TitleBar.Position = UDim2.fromScale(0, 0)

   local TitleBarCorner = Instance.new("UICorner")
   TitleBarCorner.CornerRadius = UDim.new(0, 20)
   TitleBarCorner.Parent = TitleBar

   local TitleBarBottom = Instance.new("Frame")
   TitleBarBottom.Parent = TitleBar
   TitleBarBottom.BackgroundColor3 = Theme.Secondary
   TitleBarBottom.BackgroundTransparency = 0.3
   TitleBarBottom.BorderSizePixel = 0
   TitleBarBottom.Size = UDim2.new(1, 0, 0, 20)
   TitleBarBottom.Position = UDim2.new(0, 0, 1, -20)

   local TitleBarLine = Instance.new("Frame")
   TitleBarLine.Parent = TitleBar
   TitleBarLine.BackgroundColor3 = Theme.Border
   TitleBarLine.BackgroundTransparency = 0.6
   TitleBarLine.BorderSizePixel = 0
   TitleBarLine.Size = UDim2.new(1, -25, 0, 1)
   TitleBarLine.Position = UDim2.new(0, 12, 1, 0)

   local TitleIcon = Instance.new("ImageLabel")
   TitleIcon.Parent = TitleBar
   TitleIcon.BackgroundTransparency = 1
   TitleIcon.Size = UDim2.fromOffset(26, 26)
   TitleIcon.Position = UDim2.fromOffset(18, 12)
   TitleIcon.Image = IconId
   TitleIcon.ImageColor3 = Theme.Accent
   TitleIcon.ImageTransparency = 0.2

   local TitleLabel = Instance.new("TextLabel")
   TitleLabel.Parent = TitleBar
   TitleLabel.BackgroundTransparency = 1
   TitleLabel.Size = UDim2.new(0, 170, 1, 0)
   TitleLabel.Position = UDim2.fromOffset(50, 0)
   TitleLabel.Text = Title
   TitleLabel.TextColor3 = Theme.Text
   TitleLabel.TextSize = 15
   TitleLabel.Font = Enum.Font.GothamBold
   TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

   local SubTitleLabel = Instance.new("TextLabel")
   SubTitleLabel.Parent = TitleBar
   SubTitleLabel.BackgroundTransparency = 1
   SubTitleLabel.Size = UDim2.new(0, 140, 1, 0)
   SubTitleLabel.Position = UDim2.fromOffset(230, 0)
   SubTitleLabel.Text = SubTitle
   SubTitleLabel.TextColor3 = Theme.SubText
   SubTitleLabel.TextSize = 12
   SubTitleLabel.Font = Enum.Font.Gotham
   SubTitleLabel.TextXAlignment = Enum.TextXAlignment.Left

   local ButtonsFrame = Instance.new("Frame")
   ButtonsFrame.Parent = TitleBar
   ButtonsFrame.BackgroundTransparency = 1
   ButtonsFrame.Size = UDim2.new(0, 105, 1, -12)
   ButtonsFrame.Position = UDim2.new(1, -110, 0, 6)

   local ButtonsLayout = Instance.new("UIListLayout")
   ButtonsLayout.FillDirection = Enum.FillDirection.Horizontal
   ButtonsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
   ButtonsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
   ButtonsLayout.Padding = UDim.new(0, 6)
   ButtonsLayout.Parent = ButtonsFrame

   local MaximizeButton = Instance.new("ImageButton")
   MaximizeButton.Parent = ButtonsFrame
   MaximizeButton.BackgroundColor3 = Theme.Secondary
   MaximizeButton.BackgroundTransparency = 0.4
   MaximizeButton.BorderSizePixel = 0
   MaximizeButton.Size = UDim2.fromOffset(32, 32)
   MaximizeButton.Image = "rbxassetid://118135004396306"
   MaximizeButton.ImageColor3 = Theme.Text
   MaximizeButton.ImageTransparency = 0.3

   local MaximizeCorner = Instance.new("UICorner")
   MaximizeCorner.CornerRadius = UDim.new(0, 10)
   MaximizeCorner.Parent = MaximizeButton

   local MinimizeButton = Instance.new("ImageButton")
   MinimizeButton.Parent = ButtonsFrame
   MinimizeButton.BackgroundColor3 = Theme.Secondary
   MinimizeButton.BackgroundTransparency = 0.4
   MinimizeButton.BorderSizePixel = 0
   MinimizeButton.Size = UDim2.fromOffset(32, 32)
   MinimizeButton.Image = "rbxassetid://109112049975998"
   MinimizeButton.ImageColor3 = Theme.Text
   MinimizeButton.ImageTransparency = 0.3

   local MinimizeCorner = Instance.new("UICorner")
   MinimizeCorner.CornerRadius = UDim.new(0, 10)
   MinimizeCorner.Parent = MinimizeButton

   local CloseButton = Instance.new("ImageButton")
   CloseButton.Parent = ButtonsFrame
   CloseButton.BackgroundColor3 = Theme.Secondary
   CloseButton.BackgroundTransparency = 0.4
   CloseButton.BorderSizePixel = 0
   CloseButton.Size = UDim2.fromOffset(32, 32)
   CloseButton.Image = "rbxassetid://74818383222024"
   CloseButton.ImageColor3 = Theme.Text
   CloseButton.ImageTransparency = 0.3

   local CloseCorner = Instance.new("UICorner")
   CloseCorner.CornerRadius = UDim.new(0, 10)
   CloseCorner.Parent = CloseButton

   local ContentFrame = Instance.new("Frame")
   ContentFrame.Name = "ContentFrame"
   ContentFrame.Parent = MainFrame
   ContentFrame.BackgroundTransparency = 1
   ContentFrame.Size = UDim2.new(1, -25, 1, -70)
   ContentFrame.Position = UDim2.fromOffset(12, 58)

   local FloatingIcon = Instance.new("ImageButton")
   FloatingIcon.Name = "FloatingIcon"
   FloatingIcon.Parent = ScreenGui
   FloatingIcon.BackgroundColor3 = Theme.Primary
   FloatingIcon.BackgroundTransparency = 0.2
   FloatingIcon.BorderSizePixel = 0
   FloatingIcon.Size = UDim2.fromOffset(58, 58)
   FloatingIcon.Position = UDim2.fromOffset(25, 25)
   FloatingIcon.Image = IconId
   FloatingIcon.ImageColor3 = Theme.Accent
   FloatingIcon.ImageTransparency = 0.2
   FloatingIcon.Visible = false

   local FloatingCorner = Instance.new("UICorner")
   FloatingCorner.CornerRadius = UDim.new(1, 0)
   FloatingCorner.Parent = FloatingIcon

   local FloatingStroke = Instance.new("UIStroke")
   FloatingStroke.Color = Theme.Border
   FloatingStroke.Thickness = 1
   FloatingStroke.Transparency = 0.4
   FloatingStroke.Parent = FloatingIcon

   local FloatingBlur = Instance.new("Frame")
   FloatingBlur.Name = "Blur"
   FloatingBlur.Parent = FloatingIcon
   FloatingBlur.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   FloatingBlur.BackgroundTransparency = 0.95
   FloatingBlur.Size = UDim2.new(1, 0, 1, 0)
   FloatingBlur.Position = UDim2.new(0, 0, 0, 0)

   local FloatingBlurCorner = Instance.new("UICorner")
   FloatingBlurCorner.CornerRadius = UDim.new(1, 0)
   FloatingBlurCorner.Parent = FloatingBlur

   MakeDraggable(MainFrame, TitleBar)
   MakeDraggable(FloatingIcon, FloatingIcon)

   local isMaximized = false
   local originalSize = Size
   local originalPosition = UDim2.fromScale(0.5, 0.5)

   local function ShowWindow()
       MainFrame.Visible = true
       FloatingIcon.Visible = false
       CreateTween(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
           Size = isMaximized and UDim2.fromScale(0.88, 0.88) or originalSize
       }):Play()
   end

   local function HideWindow()
       CreateTween(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
           Size = UDim2.fromOffset(0, 0)
       }):Play()
       wait(0.4)
       MainFrame.Visible = false
       FloatingIcon.Visible = true
   end

   local function MaximizeWindow()
       isMaximized = not isMaximized
       if isMaximized then
           CreateTween(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
               Size = UDim2.fromScale(0.88, 0.88),
               Position = UDim2.fromScale(0.5, 0.5)
           }):Play()
       else
           CreateTween(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
               Size = originalSize,
               Position = originalPosition
           }):Play()
       end
   end

   local function CreateButtonHover(button)
       button.MouseEnter:Connect(function()
           CreateTween(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
               BackgroundTransparency = 0.1,
               ImageTransparency = 0
           }):Play()
       end)
       
       button.MouseLeave:Connect(function()
           CreateTween(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
               BackgroundTransparency = 0.4,
               ImageTransparency = 0.3
           }):Play()
       end)
   end

   CreateButtonHover(MaximizeButton)
   CreateButtonHover(MinimizeButton)
   
   CloseButton.MouseEnter:Connect(function()
       CreateTween(CloseButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
           BackgroundColor3 = Theme.Error,
           BackgroundTransparency = 0.2,
           ImageTransparency = 0
       }):Play()
   end)
   
   CloseButton.MouseLeave:Connect(function()
       CreateTween(CloseButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
           BackgroundColor3 = Theme.Secondary,
           BackgroundTransparency = 0.4,
           ImageTransparency = 0.3
       }):Play()
   end)

   CloseButton.MouseButton1Click:Connect(function()
       CreateTween(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
           Size = UDim2.fromOffset(0, 0)
       }):Play()
       wait(0.3)
       ScreenGui:Destroy()
   end)

   MinimizeButton.MouseButton1Click:Connect(HideWindow)
   MaximizeButton.MouseButton1Click:Connect(MaximizeWindow)
   FloatingIcon.MouseButton1Click:Connect(ShowWindow)

   UserInputService.InputBegan:Connect(function(input, gameProcessed)
       if not gameProcessed and input.KeyCode == MinimizeKey then
           if MainFrame.Visible then
               HideWindow()
           else
               ShowWindow()
           end
       end
   end)

   local NotificationCount = 0
   
   function Window:Notify(config)
       local Title = config.Title or "Notification"
       local Content = config.Content or "This is a notification"
       local SubContent = config.SubContent or ""
       local Duration = config.Duration or 4
       local Type = config.Type or "Default"
       
       NotificationCount = NotificationCount + 1
       
       local NotificationFrame = Instance.new("Frame")
       NotificationFrame.Name = "Notification_" .. NotificationCount
       NotificationFrame.Parent = NotificationContainer
       NotificationFrame.BackgroundColor3 = Theme.Secondary
       NotificationFrame.BackgroundTransparency = 0.2
       NotificationFrame.BorderSizePixel = 0
       NotificationFrame.Size = UDim2.new(1, 0, 0, SubContent ~= "" and 70 or 60)
       NotificationFrame.Position = UDim2.new(1, 20, 0, 0)
       NotificationFrame.LayoutOrder = NotificationCount
       
       local NotificationCorner = Instance.new("UICorner")
       NotificationCorner.CornerRadius = UDim.new(0, 15)
       NotificationCorner.Parent = NotificationFrame
       
       local NotificationStroke = Instance.new("UIStroke")
       NotificationStroke.Color = Theme.Border
       NotificationStroke.Thickness = 1
       NotificationStroke.Transparency = 0.5
       NotificationStroke.Parent = NotificationFrame
       
       local NotificationBlur = Instance.new("Frame")
       NotificationBlur.Name = "Blur"
       NotificationBlur.Parent = NotificationFrame
       NotificationBlur.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
       NotificationBlur.BackgroundTransparency = 0.94
       NotificationBlur.Size = UDim2.new(1, 0, 1, 0)
       NotificationBlur.Position = UDim2.new(0, 0, 0, 0)
       
       local NotificationBlurCorner = Instance.new("UICorner")
       NotificationBlurCorner.CornerRadius = UDim.new(0, 15)
       NotificationBlurCorner.Parent = NotificationBlur
       
       local AccentBar = Instance.new("Frame")
       AccentBar.Name = "AccentBar"
       AccentBar.Parent = NotificationFrame
       AccentBar.BorderSizePixel = 0
       AccentBar.Size = UDim2.new(0, 3, 1, 0)
       AccentBar.Position = UDim2.new(0, 0, 0, 0)
       AccentBar.BackgroundTransparency = 0.3
       
       local AccentColor = Theme.Accent
       if Type == "Success" then
           AccentColor = Theme.Success
       elseif Type == "Warning" then
           AccentColor = Theme.Warning
       elseif Type == "Error" then
           AccentColor = Theme.Error
       end
       
       AccentBar.BackgroundColor3 = AccentColor
       
       local AccentBarCorner = Instance.new("UICorner")
       AccentBarCorner.CornerRadius = UDim.new(0, 15)
       AccentBarCorner.Parent = AccentBar
       
       local AccentBarCover = Instance.new("Frame")
       AccentBarCover.Parent = AccentBar
       AccentBarCover.BackgroundColor3 = AccentColor
       AccentBarCover.BackgroundTransparency = 0.3
       AccentBarCover.BorderSizePixel = 0
       AccentBarCover.Size = UDim2.new(1, 0, 1, 0)
       AccentBarCover.Position = UDim2.new(0, 1, 0, 0)
       
       local NotificationIcon = Instance.new("ImageLabel")
       NotificationIcon.Parent = NotificationFrame
       NotificationIcon.BackgroundTransparency = 1
       NotificationIcon.Size = UDim2.fromOffset(16, 16)
       NotificationIcon.Position = UDim2.fromOffset(15, 12)
       NotificationIcon.ImageColor3 = AccentColor
       NotificationIcon.ImageTransparency = 0.2
       
       local IconId = "rbxassetid://3944680095"
       if Type == "Suc" then
           IconId = "rbxassetid://3944680095"
       elseif Type == "War" then
           IconId = "rbxassetid://3944680095"
       elseif Type == "Er" then
           IconId = "rbxassetid://3944680095"
       end
       
       NotificationIcon.Image = IconId
       
       local NotificationTitle = Instance.new("TextLabel")
       NotificationTitle.Parent = NotificationFrame
       NotificationTitle.BackgroundTransparency = 1
       NotificationTitle.Size = UDim2.new(1, -70, 0, 16)
       NotificationTitle.Position = UDim2.fromOffset(38, 12)
       NotificationTitle.Text = Title
       NotificationTitle.TextColor3 = Theme.Text
       NotificationTitle.TextSize = 13
       NotificationTitle.Font = Enum.Font.GothamBold
       NotificationTitle.TextXAlignment = Enum.TextXAlignment.Left
       NotificationTitle.TextTruncate = Enum.TextTruncate.AtEnd
       
       local NotificationContent = Instance.new("TextLabel")
       NotificationContent.Parent = NotificationFrame
       NotificationContent.BackgroundTransparency = 1
       NotificationContent.Size = UDim2.new(1, -70, 0, 14)
       NotificationContent.Position = UDim2.fromOffset(38, 28)
       NotificationContent.Text = Content
       NotificationContent.TextColor3 = Theme.SubText
       NotificationContent.TextSize = 11
       NotificationContent.Font = Enum.Font.Gotham
       NotificationContent.TextXAlignment = Enum.TextXAlignment.Left
       NotificationContent.TextWrapped = true
       NotificationContent.TextTruncate = Enum.TextTruncate.AtEnd
       
       if SubContent ~= "" then
           local NotificationSubContent = Instance.new("TextLabel")
           NotificationSubContent.Parent = NotificationFrame
           NotificationSubContent.BackgroundTransparency = 1
           NotificationSubContent.Size = UDim2.new(1, -70, 0, 12)
           NotificationSubContent.Position = UDim2.fromOffset(38, 46)
           NotificationSubContent.Text = SubContent
           NotificationSubContent.TextColor3 = Theme.SubText
           NotificationSubContent.TextSize = 9
           NotificationSubContent.Font = Enum.Font.Gotham
           NotificationSubContent.TextXAlignment = Enum.TextXAlignment.Left
           NotificationSubContent.TextWrapped = true
           NotificationSubContent.TextTruncate = Enum.TextTruncate.AtEnd
           NotificationSubContent.TextTransparency = 0.4
       end
       
       local CloseNotificationButton = Instance.new("ImageButton")
       CloseNotificationButton.Parent = NotificationFrame
       CloseNotificationButton.BackgroundTransparency = 1
       CloseNotificationButton.Size = UDim2.fromOffset(18, 18)
       CloseNotificationButton.Position = UDim2.new(1, -25, 0, 8)
       CloseNotificationButton.Image = "rbxassetid://74818383222024"
       CloseNotificationButton.ImageColor3 = Theme.SubText
       CloseNotificationButton.ImageTransparency = 0.6
       
       local CloseNotificationCorner = Instance.new("UICorner")
       CloseNotificationCorner.CornerRadius = UDim.new(0, 5)
       CloseNotificationCorner.Parent = CloseNotificationButton
       
       CloseNotificationButton.MouseEnter:Connect(function()
           CreateTween(CloseNotificationButton, TweenInfo.new(0.2), {
               ImageTransparency = 0.2,
               ImageColor3 = Theme.Error
           }):Play()
       end)
       
       CloseNotificationButton.MouseLeave:Connect(function()
           CreateTween(CloseNotificationButton, TweenInfo.new(0.2), {
               ImageTransparency = 0.6,
               ImageColor3 = Theme.SubText
           }):Play()
       end)
       
       local ProgressBar = nil
       if Duration and Duration > 0 then
           ProgressBar = Instance.new("Frame")
           ProgressBar.Parent = NotificationFrame
           ProgressBar.BackgroundColor3 = AccentColor
           ProgressBar.BackgroundTransparency = 0.4
           ProgressBar.BorderSizePixel = 0
           ProgressBar.Size = UDim2.new(1, 0, 0, 2)
           ProgressBar.Position = UDim2.new(0, 0, 1, -2)
           
           local ProgressBarCorner = Instance.new("UICorner")
           ProgressBarCorner.CornerRadius = UDim.new(0, 0)
           ProgressBarCorner.Parent = ProgressBar
       end
       
       NotificationFrame.Position = UDim2.new(1, 30, 0, 0)
       NotificationFrame.BackgroundTransparency = 1
       NotificationStroke.Transparency = 1
       
       CreateTween(NotificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
           BackgroundTransparency = 0.2
       }):Play()
       
       CreateTween(NotificationStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
           Transparency = 0.5
       }):Play()
       
       CreateTween(NotificationFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
           Position = UDim2.new(0, 0, 0, 0)
       }):Play()
       
       if ProgressBar and Duration and Duration > 0 then
           wait(0.4)
           CreateTween(ProgressBar, TweenInfo.new(Duration, Enum.EasingStyle.Linear), {
               Size = UDim2.new(0, 0, 0, 2)
           }):Play()
       end
       
       local function CloseNotification()
           CreateTween(NotificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
               Position = UDim2.new(1, 30, 0, 0),
               BackgroundTransparency = 1
           }):Play()
           
           CreateTween(NotificationStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
               Transparency = 1
           }):Play()
           
           wait(0.3)
           NotificationFrame:Destroy()
       end
       
       CloseNotificationButton.MouseButton1Click:Connect(CloseNotification)
       
       if Duration and Duration > 0 then
           spawn(function()
               wait(Duration + 0.4)
               if NotificationFrame.Parent then
                   CloseNotification()
               end
           end)
       end
       
       NotificationFrame.InputBegan:Connect(function(input)
           if input.UserInputType == Enum.UserInputType.MouseButton1 then
               CloseNotification()
           end
       end)
   end

   CreateTween(LoadingProgress, TweenInfo.new(LoadingTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
       Size = UDim2.fromScale(1, 1)
   }):Play()

   wait(LoadingTime)
   
   CreateTween(WelcomeFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
       Size = UDim2.fromOffset(0, 0),
       Position = UDim2.fromScale(0.5, 0.5)
   }):Play()

   wait(0.4)
   WelcomeFrame:Destroy()
   MainFrame.Visible = true
   MainFrame.Size = UDim2.fromOffset(0, 0)
   CreateTween(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
       Size = Size
   }):Play()

   Window.MainFrame = MainFrame
   Window.ContentFrame = ContentFrame
   Window.ScreenGui = ScreenGui
   Window.CloseButton = CloseButton
   Window.MinimizeButton = MinimizeButton
   Window.MaximizeButton = MaximizeButton
   Window.NotificationContainer = NotificationContainer
   
   return Window
end

return FRONT_GUI
