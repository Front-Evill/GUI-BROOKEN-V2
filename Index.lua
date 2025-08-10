local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Debris = game:GetService("Debris")
local SoundService = game:GetService("SoundService")

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
   },
   Light = {
       Primary = Color3.fromRGB(248, 249, 252),
       Secondary = Color3.fromRGB(240, 242, 245),
       Tertiary = Color3.fromRGB(232, 235, 238),
       Accent = Color3.fromRGB(59, 130, 246),
       Success = Color3.fromRGB(34, 197, 94),
       Warning = Color3.fromRGB(234, 179, 8),
       Error = Color3.fromRGB(239, 68, 68),
       Text = Color3.fromRGB(30, 41, 59),
       SubText = Color3.fromRGB(100, 116, 139),
       Border = Color3.fromRGB(203, 213, 225)
   },
   Purple = {
       Primary = Color3.fromRGB(30, 20, 45),
       Secondary = Color3.fromRGB(40, 30, 55),
       Tertiary = Color3.fromRGB(50, 40, 65),
       Accent = Color3.fromRGB(147, 51, 234),
       Success = Color3.fromRGB(34, 197, 94),
       Warning = Color3.fromRGB(245, 158, 11),
       Error = Color3.fromRGB(239, 68, 68),
       Text = Color3.fromRGB(255, 255, 255),
       SubText = Color3.fromRGB(196, 181, 253),
       Border = Color3.fromRGB(75, 55, 100)
   },
   Green = {
       Primary = Color3.fromRGB(20, 35, 25),
       Secondary = Color3.fromRGB(25, 45, 30),
       Tertiary = Color3.fromRGB(30, 55, 35),
       Accent = Color3.fromRGB(52, 211, 153),
       Success = Color3.fromRGB(34, 197, 94),
       Warning = Color3.fromRGB(245, 158, 11),
       Error = Color3.fromRGB(239, 68, 68),
       Text = Color3.fromRGB(255, 255, 255),
       SubText = Color3.fromRGB(167, 243, 208),
       Border = Color3.fromRGB(75, 85, 80)
   },
   Gray = {
       Primary = Color3.fromRGB(45, 45, 50),
       Secondary = Color3.fromRGB(55, 55, 60),
       Tertiary = Color3.fromRGB(65, 65, 70),
       Accent = Color3.fromRGB(107, 114, 128),
       Success = Color3.fromRGB(34, 197, 94),
       Warning = Color3.fromRGB(245, 158, 11),
       Error = Color3.fromRGB(239, 68, 68),
       Text = Color3.fromRGB(255, 255, 255),
       SubText = Color3.fromRGB(156, 163, 175),
       Border = Color3.fromRGB(75, 85, 99)
   },
   Black = {
       Primary = Color3.fromRGB(8, 8, 12),
       Secondary = Color3.fromRGB(12, 12, 16),
       Tertiary = Color3.fromRGB(16, 16, 20),
       Accent = Color3.fromRGB(88, 166, 255),
       Success = Color3.fromRGB(34, 197, 94),
       Warning = Color3.fromRGB(245, 158, 11),
       Error = Color3.fromRGB(239, 68, 68),
       Text = Color3.fromRGB(255, 255, 255),
       SubText = Color3.fromRGB(180, 180, 185),
       Border = Color3.fromRGB(40, 40, 45)
   },
   Sky = {
       Primary = Color3.fromRGB(15, 25, 40),
       Secondary = Color3.fromRGB(20, 35, 50),
       Tertiary = Color3.fromRGB(25, 45, 60),
       Accent = Color3.fromRGB(14, 165, 233),
       Success = Color3.fromRGB(34, 197, 94),
       Warning = Color3.fromRGB(245, 158, 11),
       Error = Color3.fromRGB(239, 68, 68),
       Text = Color3.fromRGB(255, 255, 255),
       SubText = Color3.fromRGB(186, 230, 253),
       Border = Color3.fromRGB(70, 80, 95)
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

local function PlaySound(soundId, volume, pitch)
   if soundId and soundId ~= "" then
       local sound = Instance.new("Sound")
       sound.SoundId = "rbxassetid://" .. soundId
       sound.Volume = volume or 0.5
       sound.PlaybackSpeed = pitch or 1
       sound.Parent = SoundService
       sound:Play()
       
       sound.Ended:Connect(function()
           sound:Destroy()
       end)
       
       Debris:AddItem(sound, 10)
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
   local Icon = config.Icon or ""
   local FloatingIcon = config.FloatingIcon or config.Icon or ""
   local SoundId = config.SoundId or ""
   local SoundVolume = config.SoundVolume or 0.5
   local SoundPitch = config.SoundPitch or 1
   
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
   NotificationContainer.Size = UDim2.new(0, 300, 1, -20)
   NotificationContainer.Position = UDim2.new(1, -310, 1, -10)
   NotificationContainer.AnchorPoint = Vector2.new(0, 1)
   NotificationContainer.ZIndex = 1000

   local NotificationLayout = Instance.new("UIListLayout")
   NotificationLayout.Parent = NotificationContainer
   NotificationLayout.FillDirection = Enum.FillDirection.Vertical
   NotificationLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
   NotificationLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
   NotificationLayout.Padding = UDim.new(0, 8)
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

   local TitleIcon = Instance.new("Frame")
   TitleIcon.Parent = TitleBar
   TitleIcon.BackgroundColor3 = Theme.Accent
   TitleIcon.BackgroundTransparency = 0.2
   TitleIcon.BorderSizePixel = 0
   TitleIcon.Size = UDim2.fromOffset(30, 30)
   TitleIcon.Position = UDim2.fromOffset(15, 10)

   local TitleIconCorner = Instance.new("UICorner")
   TitleIconCorner.CornerRadius = UDim.new(0, 10)
   TitleIconCorner.Parent = TitleIcon

   local TitleIconStroke = Instance.new("UIStroke")
   TitleIconStroke.Color = Theme.Accent
   TitleIconStroke.Thickness = 1.5
   TitleIconStroke.Transparency = 0.4
   TitleIconStroke.Parent = TitleIcon

   local TitleIconGrad = Instance.new("UIGradient")
   TitleIconGrad.Color = ColorSequence.new{
       ColorSequenceKeypoint.new(0, Theme.Accent),
       ColorSequenceKeypoint.new(0.5, Color3.fromRGB(
           math.min(255, Theme.Accent.R * 255 * 1.4),
           math.min(255, Theme.Accent.G * 255 * 1.4),
           math.min(255, Theme.Accent.B * 255 * 1.4)
       )),
       ColorSequenceKeypoint.new(1, Theme.Accent)
   }
   TitleIconGrad.Rotation = 45
   TitleIconGrad.Parent = TitleIcon

   local TitleIconImage = Instance.new("ImageLabel")
   TitleIconImage.Parent = TitleIcon
   TitleIconImage.BackgroundTransparency = 1
   TitleIconImage.Size = UDim2.new(0.8, 0, 0.8, 0)
   TitleIconImage.Position = UDim2.new(0.5, 0, 0.5, 0)
   TitleIconImage.AnchorPoint = Vector2.new(0.5, 0.5)
   TitleIconImage.Image = Icon ~= "" and ("rbxassetid://" .. Icon) or ""
   TitleIconImage.ImageColor3 = Color3.fromRGB(255, 255, 255)
   TitleIconImage.ScaleType = Enum.ScaleType.Fit

   local TitleIconShadow = Instance.new("Frame")
   TitleIconShadow.Parent = TitleBar
   TitleIconShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
   TitleIconShadow.BackgroundTransparency = 0.85
   TitleIconShadow.BorderSizePixel = 0
   TitleIconShadow.Size = UDim2.fromOffset(30, 30)
   TitleIconShadow.Position = UDim2.fromOffset(17, 12)
   TitleIconShadow.ZIndex = TitleIcon.ZIndex - 1

   local TitleIconShadowCorner = Instance.new("UICorner")
   TitleIconShadowCorner.CornerRadius = UDim.new(0, 10)
   TitleIconShadowCorner.Parent = TitleIconShadow

   local IconPulse = CreateTween(TitleIcon, TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
       BackgroundTransparency = 0.5
   })
   IconPulse:Play()

   local IconGlow = CreateTween(TitleIconStroke, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
       Transparency = 0.1
   })
   IconGlow:Play()

   local TitleLabel = Instance.new("TextLabel")
   TitleLabel.Parent = TitleBar
   TitleLabel.BackgroundTransparency = 1
   TitleLabel.Size = UDim2.new(0, 170, 0, 20)
   TitleLabel.Position = UDim2.fromOffset(54, 10)
   TitleLabel.Text = Title
   TitleLabel.TextColor3 = Theme.Text
   TitleLabel.TextSize = 15
   TitleLabel.Font = Enum.Font.GothamBold
   TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

   local SubTitleLabel = Instance.new("TextLabel")
   SubTitleLabel.Parent = TitleBar
   SubTitleLabel.BackgroundTransparency = 1
   SubTitleLabel.Size = UDim2.new(0, 140, 0, 15)
   SubTitleLabel.Position = UDim2.fromOffset(54, 28)
   SubTitleLabel.Text = SubTitle
   SubTitleLabel.TextColor3 = Theme.SubText
   SubTitleLabel.TextSize = 11
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

   local MaximizeButton = Instance.new("TextButton")
   MaximizeButton.Parent = ButtonsFrame
   MaximizeButton.BackgroundColor3 = Theme.Secondary
   MaximizeButton.BackgroundTransparency = 0.4
   MaximizeButton.BorderSizePixel = 0
   MaximizeButton.Size = UDim2.fromOffset(32, 32)
   MaximizeButton.Text = "□"
   MaximizeButton.TextColor3 = Theme.Text
   MaximizeButton.TextSize = 16
   MaximizeButton.Font = Enum.Font.GothamBold
   MaximizeButton.TextTransparency = 0.3

   local MaximizeCorner = Instance.new("UICorner")
   MaximizeCorner.CornerRadius = UDim.new(0, 10)
   MaximizeCorner.Parent = MaximizeButton

   local MinimizeButton = Instance.new("TextButton")
   MinimizeButton.Parent = ButtonsFrame
   MinimizeButton.BackgroundColor3 = Theme.Secondary
   MinimizeButton.BackgroundTransparency = 0.4
   MinimizeButton.BorderSizePixel = 0
   MinimizeButton.Size = UDim2.fromOffset(32, 32)
   MinimizeButton.Text = "─"
   MinimizeButton.TextColor3 = Theme.Text
   MinimizeButton.TextSize = 16
   MinimizeButton.Font = Enum.Font.GothamBold
   MinimizeButton.TextTransparency = 0.3

   local MinimizeCorner = Instance.new("UICorner")
   MinimizeCorner.CornerRadius = UDim.new(0, 10)
   MinimizeCorner.Parent = MinimizeButton

   local CloseButton = Instance.new("TextButton")
   CloseButton.Parent = ButtonsFrame
   CloseButton.BackgroundColor3 = Theme.Secondary
   CloseButton.BackgroundTransparency = 0.4
   CloseButton.BorderSizePixel = 0
   CloseButton.Size = UDim2.fromOffset(32, 32)
   CloseButton.Text = "×"
   CloseButton.TextColor3 = Theme.Text
   CloseButton.TextSize = 18
   CloseButton.Font = Enum.Font.GothamBold
   CloseButton.TextTransparency = 0.3

   local CloseCorner = Instance.new("UICorner")
   CloseCorner.CornerRadius = UDim.new(0, 10)
   CloseCorner.Parent = CloseButton

   local ContentFrame = Instance.new("Frame")
   ContentFrame.Name = "ContentFrame"
   ContentFrame.Parent = MainFrame
   ContentFrame.BackgroundTransparency = 1
   ContentFrame.Size = UDim2.new(1, -25, 1, -70)
   ContentFrame.Position = UDim2.fromOffset(12, 58)

   local FloatingIconFrame = Instance.new("Frame")
   FloatingIconFrame.Name = "FloatingIcon"
   FloatingIconFrame.Parent = ScreenGui
   FloatingIconFrame.BackgroundColor3 = Theme.Accent
   FloatingIconFrame.BackgroundTransparency = 0.1
   FloatingIconFrame.BorderSizePixel = 0
   FloatingIconFrame.Size = UDim2.fromOffset(60, 60)
   FloatingIconFrame.Position = UDim2.fromOffset(25, 25)
   FloatingIconFrame.Visible = false

   local FloatingCorner = Instance.new("UICorner")
   FloatingCorner.CornerRadius = UDim.new(1, 0)
   FloatingCorner.Parent = FloatingIconFrame

   local FloatingStroke = Instance.new("UIStroke")
   FloatingStroke.Color = Theme.Accent
   FloatingStroke.Thickness = 2.5
   FloatingStroke.Transparency = 0.3
   FloatingStroke.Parent = FloatingIconFrame

   local FloatingShadow = Instance.new("Frame")
   FloatingShadow.Parent = ScreenGui
   FloatingShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
   FloatingShadow.BackgroundTransparency = 0.8
   FloatingShadow.BorderSizePixel = 0
   FloatingShadow.Size = UDim2.fromOffset(60, 60)
   FloatingShadow.Position = UDim2.fromOffset(27, 27)
   FloatingShadow.Visible = false
   FloatingShadow.ZIndex = FloatingIconFrame.ZIndex - 1

   local FloatingShadowCorner = Instance.new("UICorner")
   FloatingShadowCorner.CornerRadius = UDim.new(1, 0)
   FloatingShadowCorner.Parent = FloatingShadow

   local FloatingButton = Instance.new("TextButton")
   FloatingButton.Parent = FloatingIconFrame
   FloatingButton.BackgroundTransparency = 1
   FloatingButton.Size = UDim2.new(1, 0, 1, 0)
   FloatingButton.Text = ""

   local FloatingIconImage = Instance.new("ImageLabel")
   FloatingIconImage.Parent = FloatingIconFrame
   FloatingIconImage.BackgroundTransparency = 1
   FloatingIconImage.Size = UDim2.new(0.7, 0, 0.7, 0)
   FloatingIconImage.Position = UDim2.new(0.5, 0, 0.5, 0)
   FloatingIconImage.AnchorPoint = Vector2.new(0.5, 0.5)
   FloatingIconImage.Image = FloatingIcon ~= "" and ("rbxassetid://" .. FloatingIcon) or ""
   FloatingIconImage.ImageColor3 = Color3.fromRGB(255, 255, 255)
   FloatingIconImage.ScaleType = Enum.ScaleType.Fit

   local FloatingGrad = Instance.new("UIGradient")
   FloatingGrad.Color = ColorSequence.new{
       ColorSequenceKeypoint.new(0, Theme.Accent),
       ColorSequenceKeypoint.new(0.5, Color3.fromRGB(
           math.min(255, Theme.Accent.R * 255 * 1.3),
           math.min(255, Theme.Accent.G * 255 * 1.3),
           math.min(255, Theme.Accent.B * 255 * 1.3)
       )),
       ColorSequenceKeypoint.new(1, Theme.Accent)
   }
   FloatingGrad.Rotation = 45
   FloatingGrad.Parent = FloatingIconFrame

   local FloatingPulse = CreateTween(FloatingIconFrame, TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
       Size = UDim2.fromOffset(65, 65)
   })

   local FloatingStrokePulse = CreateTween(FloatingStroke, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
       Transparency = 0.1
   })

   local FloatingRotate = CreateTween(FloatingGrad, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {
       Rotation = 405
   })

   MakeDraggable(MainFrame, TitleBar)
   MakeDraggable(FloatingIconFrame, FloatingIconFrame)

   local isMaximized = false
   local originalSize = Size
   local originalPosition = UDim2.fromScale(0.5, 0.5)

   local function ShowWindow()
       PlaySound(SoundId, SoundVolume, SoundPitch)
       MainFrame.Visible = true
       FloatingIconFrame.Visible = false
       FloatingShadow.Visible = false
       FloatingPulse:Cancel()
       FloatingStrokePulse:Cancel()
       FloatingRotate:Cancel()
       CreateTween(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
           Size = isMaximized and UDim2.fromScale(0.88, 0.88) or originalSize
       }):Play()
   end

   local function HideWindow()
       CreateTween(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
           Size = UDim2.fromOffset(0, 0)
       }):Play()
       task.wait(0.3)
       MainFrame.Visible = false
       FloatingIconFrame.Visible = true
       FloatingShadow.Visible = true
       FloatingPulse:Play()
       FloatingStrokePulse:Play()
       FloatingRotate:Play()
   end

   local function MaximizeWindow()
       isMaximized = not isMaximized
       if isMaximized then
           CreateTween(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
               Size = UDim2.fromScale(0.88, 0.88),
               Position = UDim2.fromScale(0.5, 0.5)
           }):Play()
       else
           CreateTween(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
               Size = originalSize,
               Position = originalPosition
           }):Play()
       end
   end

   local function CreateButtonHover(button)
       button.MouseEnter:Connect(function()
           CreateTween(button, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
               BackgroundTransparency = 0.1,
               TextTransparency = 0
           }):Play()
       end)
       
       button.MouseLeave:Connect(function()
           CreateTween(button, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
               BackgroundTransparency = 0.4,
               TextTransparency = 0.3
           }):Play()
       end)
   end

   CreateButtonHover(MaximizeButton)
   CreateButtonHover(MinimizeButton)
   
   CloseButton.MouseEnter:Connect(function()
       CreateTween(CloseButton, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
           BackgroundColor3 = Theme.Error,
           BackgroundTransparency = 0.2,
           TextTransparency = 0
       }):Play()
   end)
   
   CloseButton.MouseLeave:Connect(function()
       CreateTween(CloseButton, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
           BackgroundColor3 = Theme.Secondary,
           BackgroundTransparency = 0.4,
           TextTransparency = 0.3
       }):Play()
   end)

   FloatingButton.MouseEnter:Connect(function()
       CreateTween(FloatingIconFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
           Size = UDim2.fromOffset(68, 68)
       }):Play()
       CreateTween(FloatingShadow, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
           Size = UDim2.fromOffset(68, 68)
       }):Play()
   end)
   
   FloatingButton.MouseLeave:Connect(function()
       CreateTween(FloatingIconFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
           Size = UDim2.fromOffset(60, 60)
       }):Play()
       CreateTween(FloatingShadow, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
           Size = UDim2.fromOffset(60, 60)
       }):Play()
   end)

   CloseButton.MouseButton1Click:Connect(function()
       CreateTween(MainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
           Size = UDim2.fromOffset(0, 0)
       }):Play()
       task.wait(0.2)
       ScreenGui:Destroy()
   end)

   MinimizeButton.MouseButton1Click:Connect(HideWindow)
   MaximizeButton.MouseButton1Click:Connect(MaximizeWindow)
   FloatingButton.MouseButton1Click:Connect(ShowWindow)

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
       local Duration = config.Duration or 3
       local Type = config.Type or "Default"
       local NotificationSoundId = config.SoundId or ""
       local NotificationVolume = config.SoundVolume or 0.3
       local NotificationPitch = config.SoundPitch or 1
       
       PlaySound(NotificationSoundId, NotificationVolume, NotificationPitch)
       
       NotificationCount = NotificationCount + 1
       
       local NotificationFrame = Instance.new("Frame")
       NotificationFrame.Name = "Notification_" .. NotificationCount
       NotificationFrame.Parent = NotificationContainer
       NotificationFrame.BackgroundColor3 = Theme.Secondary
       NotificationFrame.BackgroundTransparency = 0.15
       NotificationFrame.BorderSizePixel = 0
       NotificationFrame.Size = UDim2.new(1, 0, 0, SubContent ~= "" and 65 or 55)
       NotificationFrame.Position = UDim2.new(1, 20, 0, 0)
       NotificationFrame.LayoutOrder = NotificationCount
       
       local NotificationCorner = Instance.new("UICorner")
       NotificationCorner.CornerRadius = UDim.new(0, 12)
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
       NotificationBlurCorner.CornerRadius = UDim.new(0, 12)
       NotificationBlurCorner.Parent = NotificationBlur
       
       local NotificationIcon = Instance.new("Frame")
       NotificationIcon.Parent = NotificationFrame
       NotificationIcon.BackgroundTransparency = 0.3
       NotificationIcon.BorderSizePixel = 0
       NotificationIcon.Size = UDim2.fromOffset(20, 20)
       NotificationIcon.Position = UDim2.fromOffset(15, 12)
       
       local AccentColor = Theme.Accent
       if Type == "Success" then
           AccentColor = Theme.Success
       elseif Type == "Warning" then
           AccentColor = Theme.Warning
       elseif Type == "Error" then
           AccentColor = Theme.Error
       end
       
       NotificationIcon.BackgroundColor3 = AccentColor
       
       local NotificationIconCorner = Instance.new("UICorner")
       NotificationIconCorner.CornerRadius = UDim.new(0, 4)
       NotificationIconCorner.Parent = NotificationIcon
       
       local NotificationTitle = Instance.new("TextLabel")
       NotificationTitle.Parent = NotificationFrame
       NotificationTitle.BackgroundTransparency = 1
       NotificationTitle.Size = UDim2.new(1, -75, 0, 18)
       NotificationTitle.Position = UDim2.fromOffset(45, 10)
       NotificationTitle.Text = Title
       NotificationTitle.TextColor3 = Theme.Text
       NotificationTitle.TextSize = 13
       NotificationTitle.Font = Enum.Font.GothamBold
       NotificationTitle.TextXAlignment = Enum.TextXAlignment.Left
       NotificationTitle.TextTruncate = Enum.TextTruncate.AtEnd
       
       local NotificationContent = Instance.new("TextLabel")
       NotificationContent.Parent = NotificationFrame
       NotificationContent.BackgroundTransparency = 1
       NotificationContent.Size = UDim2.new(1, -75, 0, 15)
       NotificationContent.Position = UDim2.fromOffset(45, 27)
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
           NotificationSubContent.Size = UDim2.new(1, -75, 0, 12)
           NotificationSubContent.Position = UDim2.fromOffset(45, 44)
           NotificationSubContent.Text = SubContent
           NotificationSubContent.TextColor3 = Theme.SubText
           NotificationSubContent.TextSize = 9
           NotificationSubContent.Font = Enum.Font.Gotham
           NotificationSubContent.TextXAlignment = Enum.TextXAlignment.Left
           NotificationSubContent.TextWrapped = true
           NotificationSubContent.TextTruncate = Enum.TextTruncate.AtEnd
           NotificationSubContent.TextTransparency = 0.4
       end
       
       local CloseNotificationButton = Instance.new("TextButton")
       CloseNotificationButton.Parent = NotificationFrame
       CloseNotificationButton.BackgroundTransparency = 1
       CloseNotificationButton.Size = UDim2.fromOffset(20, 20)
       CloseNotificationButton.Position = UDim2.new(1, -28, 0, 8)
       CloseNotificationButton.Text = "×"
       CloseNotificationButton.TextColor3 = Theme.SubText
       CloseNotificationButton.TextSize = 16
       CloseNotificationButton.Font = Enum.Font.GothamBold
       CloseNotificationButton.TextTransparency = 0.6
       
       local CloseNotificationCorner = Instance.new("UICorner")
       CloseNotificationCorner.CornerRadius = UDim.new(0, 5)
       CloseNotificationCorner.Parent = CloseNotificationButton
       
       CloseNotificationButton.MouseEnter:Connect(function()
           CreateTween(CloseNotificationButton, TweenInfo.new(0.15), {
               TextTransparency = 0.2,
               TextColor3 = Theme.Error
           }):Play()
       end)
       
       CloseNotificationButton.MouseLeave:Connect(function()
           CreateTween(CloseNotificationButton, TweenInfo.new(0.15), {
               TextTransparency = 0.6,
               TextColor3 = Theme.SubText
           }):Play()
       end)
       
       NotificationFrame.Position = UDim2.new(1, 25, 0, 0)
       NotificationFrame.BackgroundTransparency = 1
       NotificationStroke.Transparency = 1
       
       CreateTween(NotificationFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
           BackgroundTransparency = 0.15
       }):Play()
       
       CreateTween(NotificationStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
           Transparency = 0.5
       }):Play()
       
       CreateTween(NotificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
           Position = UDim2.new(0, 0, 0, 0)
       }):Play()
       
       local function CloseNotification()
           CreateTween(NotificationFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
               Position = UDim2.new(1, 25, 0, 0),
               BackgroundTransparency = 1
           }):Play()
           
           CreateTween(NotificationStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
               Transparency = 1
           }):Play()
           
           task.wait(0.2)
           NotificationFrame:Destroy()
       end
       
       CloseNotificationButton.MouseButton1Click:Connect(CloseNotification)
       
       if Duration and Duration > 0 then
           task.spawn(function()
               task.wait(Duration + 0.3)
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

   task.wait(LoadingTime)
   
   CreateTween(WelcomeFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
       Size = UDim2.fromOffset(0, 0),
       Position = UDim2.fromScale(0.5, 0.5)
   }):Play()

   task.wait(0.3)
   WelcomeFrame:Destroy()
   MainFrame.Visible = true
   MainFrame.Size = UDim2.fromOffset(0, 0)
   CreateTween(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
       Size = Size
   }):Play()

   Window.MainFrame = MainFrame
   Window.ContentFrame = ContentFrame
   Window.ScreenGui = ScreenGui
   Window.CloseButton = CloseButton
   Window.MinimizeButton = MinimizeButton
   Window.MaximizeButton = MaximizeButton
   Window.NotificationContainer = NotificationContainer
   Window.Theme = Theme
   Window.TitleIcon = TitleIcon
   Window.FloatingIcon = FloatingIconFrame
   
   return Window
end

return FRONT_GUI
