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
       Primary = Color3.fromRGB(12, 14, 18),
       Secondary = Color3.fromRGB(18, 20, 24),
       Tertiary = Color3.fromRGB(24, 26, 30),
       Accent = Color3.fromRGB(88, 140, 255),
       Success = Color3.fromRGB(34, 197, 94),
       Warning = Color3.fromRGB(245, 158, 11),
       Error = Color3.fromRGB(239, 68, 68),
       Text = Color3.fromRGB(248, 250, 252),
       SubText = Color3.fromRGB(148, 163, 184),
       Border = Color3.fromRGB(51, 65, 85)
   },
   Light = {
       Primary = Color3.fromRGB(255, 255, 255),
       Secondary = Color3.fromRGB(248, 250, 252),
       Tertiary = Color3.fromRGB(241, 245, 249),
       Accent = Color3.fromRGB(59, 130, 246),
       Success = Color3.fromRGB(34, 197, 94),
       Warning = Color3.fromRGB(234, 179, 8),
       Error = Color3.fromRGB(239, 68, 68),
       Text = Color3.fromRGB(15, 23, 42),
       SubText = Color3.fromRGB(71, 85, 105),
       Border = Color3.fromRGB(203, 213, 225)
   },
   Purple = {
       Primary = Color3.fromRGB(24, 12, 36),
       Secondary = Color3.fromRGB(30, 18, 42),
       Tertiary = Color3.fromRGB(36, 24, 48),
       Accent = Color3.fromRGB(168, 85, 247),
       Success = Color3.fromRGB(34, 197, 94),
       Warning = Color3.fromRGB(245, 158, 11),
       Error = Color3.fromRGB(239, 68, 68),
       Text = Color3.fromRGB(248, 250, 252),
       SubText = Color3.fromRGB(196, 181, 253),
       Border = Color3.fromRGB(88, 28, 135)
   },
   Green = {
       Primary = Color3.fromRGB(12, 24, 18),
       Secondary = Color3.fromRGB(18, 30, 24),
       Tertiary = Color3.fromRGB(24, 36, 30),
       Accent = Color3.fromRGB(52, 211, 153),
       Success = Color3.fromRGB(34, 197, 94),
       Warning = Color3.fromRGB(245, 158, 11),
       Error = Color3.fromRGB(239, 68, 68),
       Text = Color3.fromRGB(248, 250, 252),
       SubText = Color3.fromRGB(167, 243, 208),
       Border = Color3.fromRGB(6, 78, 59)
   },
   Gray = {
       Primary = Color3.fromRGB(30, 32, 36),
       Secondary = Color3.fromRGB(36, 38, 42),
       Tertiary = Color3.fromRGB(42, 44, 48),
       Accent = Color3.fromRGB(156, 163, 175),
       Success = Color3.fromRGB(34, 197, 94),
       Warning = Color3.fromRGB(245, 158, 11),
       Error = Color3.fromRGB(239, 68, 68),
       Text = Color3.fromRGB(248, 250, 252),
       SubText = Color3.fromRGB(156, 163, 175),
       Border = Color3.fromRGB(75, 85, 99)
   },
   Black = {
       Primary = Color3.fromRGB(0, 0, 0),
       Secondary = Color3.fromRGB(8, 8, 8),
       Tertiary = Color3.fromRGB(16, 16, 16),
       Accent = Color3.fromRGB(59, 130, 246),
       Success = Color3.fromRGB(34, 197, 94),
       Warning = Color3.fromRGB(245, 158, 11),
       Error = Color3.fromRGB(239, 68, 68),
       Text = Color3.fromRGB(255, 255, 255),
       SubText = Color3.fromRGB(156, 163, 175),
       Border = Color3.fromRGB(38, 38, 38)
   },
   Sky = {
       Primary = Color3.fromRGB(8, 16, 30),
       Secondary = Color3.fromRGB(14, 22, 36),
       Tertiary = Color3.fromRGB(20, 28, 42),
       Accent = Color3.fromRGB(14, 165, 233),
       Success = Color3.fromRGB(34, 197, 94),
       Warning = Color3.fromRGB(245, 158, 11),
       Error = Color3.fromRGB(239, 68, 68),
       Text = Color3.fromRGB(248, 250, 252),
       SubText = Color3.fromRGB(125, 211, 252),
       Border = Color3.fromRGB(7, 89, 133)
   }
}

local Icons = {
   settings = "rbxassetid://10734950309"
}

local function GetIconId(iconName)
   return Icons[iconName] or ""
end

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

local function FormatTime(seconds)
   local hours = math.floor(seconds / 3600)
   local minutes = math.floor((seconds % 3600) / 60)
   local secs = math.floor(seconds % 60)
   
   if hours > 0 then
       return string.format("%02d:%02d:%02d", hours, minutes, secs)
   else
       return string.format("%02d:%02d", minutes, secs)
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
   local IconImage = config.IconImage or "rbxassetid://0"
   
   local Theme = Themes[ThemeName] or Themes.Dark
   local StartTime = tick()

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
   NotificationLayout.Padding = UDim.new(0, 8)
   NotificationLayout.SortOrder = Enum.SortOrder.LayoutOrder

   local WelcomeFrame = Instance.new("Frame")
   WelcomeFrame.Name = "WelcomeFrame"
   WelcomeFrame.Parent = ScreenGui
   WelcomeFrame.BackgroundColor3 = Theme.Primary
   WelcomeFrame.BackgroundTransparency = 0.1
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
   WelcomeCorner.CornerRadius = UDim.new(0, 24)
   WelcomeCorner.Parent = WelcomeFrame

   local WelcomeStroke = Instance.new("UIStroke")
   WelcomeStroke.Color = Theme.Border
   WelcomeStroke.Thickness = 1
   WelcomeStroke.Transparency = 0.3
   WelcomeStroke.Parent = WelcomeFrame

   local WelcomeGradient = Instance.new("UIGradient")
   WelcomeGradient.Color = ColorSequence.new{
       ColorSequenceKeypoint.new(0, Theme.Primary),
       ColorSequenceKeypoint.new(1, Color3.fromRGB(
           math.min(255, Theme.Primary.R * 255 + 10),
           math.min(255, Theme.Primary.G * 255 + 10),
           math.min(255, Theme.Primary.B * 255 + 10)
       ))
   }
   WelcomeGradient.Rotation = 45
   WelcomeGradient.Parent = WelcomeFrame

   local PlayerAvatar = Instance.new("ImageLabel")
   PlayerAvatar.Parent = WelcomeFrame
   PlayerAvatar.BackgroundTransparency = 1
   PlayerAvatar.Size = UDim2.fromOffset(70, 70)
   PlayerAvatar.Position = UDim2.fromScale(0.5, 0.22)
   PlayerAvatar.AnchorPoint = Vector2.new(0.5, 0.5)
   PlayerAvatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. Player.UserId .. "&width=150&height=150&format=png"

   local AvatarCorner = Instance.new("UICorner")
   AvatarCorner.CornerRadius = UDim.new(1, 0)
   AvatarCorner.Parent = PlayerAvatar

   local AvatarStroke = Instance.new("UIStroke")
   AvatarStroke.Color = Theme.Accent
   AvatarStroke.Thickness = 3
   AvatarStroke.Transparency = 0.2
   AvatarStroke.Parent = PlayerAvatar

   local PlayerNameLabel = Instance.new("TextLabel")
   PlayerNameLabel.Parent = WelcomeFrame
   PlayerNameLabel.BackgroundTransparency = 1
   PlayerNameLabel.Size = UDim2.fromScale(0.85, 0.08)
   PlayerNameLabel.Position = UDim2.fromScale(0.5, 0.38)
   PlayerNameLabel.AnchorPoint = Vector2.new(0.5, 0.5)
   PlayerNameLabel.Text = Player.DisplayName
   PlayerNameLabel.TextColor3 = Theme.Text
   PlayerNameLabel.TextSize = 18
   PlayerNameLabel.Font = Enum.Font.GothamBold

   local PlayerUsernameLabel = Instance.new("TextLabel")
   PlayerUsernameLabel.Parent = WelcomeFrame
   PlayerUsernameLabel.BackgroundTransparency = 1
   PlayerUsernameLabel.Size = UDim2.fromScale(0.85, 0.06)
   PlayerUsernameLabel.Position = UDim2.fromScale(0.5, 0.46)
   PlayerUsernameLabel.AnchorPoint = Vector2.new(0.5, 0.5)
   PlayerUsernameLabel.Text = "@" .. Player.Name
   PlayerUsernameLabel.TextColor3 = Theme.Accent
   PlayerUsernameLabel.TextSize = 13
   PlayerUsernameLabel.Font = Enum.Font.GothamMedium

   local AccountAgeLabel = Instance.new("TextLabel")
   AccountAgeLabel.Parent = WelcomeFrame
   AccountAgeLabel.BackgroundTransparency = 1
   AccountAgeLabel.Size = UDim2.fromScale(0.85, 0.05)
   AccountAgeLabel.Position = UDim2.fromScale(0.5, 0.53)
   AccountAgeLabel.AnchorPoint = Vector2.new(0.5, 0.5)
   AccountAgeLabel.Text = "Account Age: " .. GetAccountAge(Player)
   AccountAgeLabel.TextColor3 = Theme.SubText
   AccountAgeLabel.TextSize = 11
   AccountAgeLabel.Font = Enum.Font.Gotham

   local WelcomeTitle = Instance.new("TextLabel")
   WelcomeTitle.Parent = WelcomeFrame
   WelcomeTitle.BackgroundTransparency = 1
   WelcomeTitle.Size = UDim2.fromScale(0.85, 0.1)
   WelcomeTitle.Position = UDim2.fromScale(0.5, 0.66)
   WelcomeTitle.AnchorPoint = Vector2.new(0.5, 0.5)
   WelcomeTitle.Text = WelcomeText
   WelcomeTitle.TextColor3 = Theme.Text
   WelcomeTitle.TextSize = 19
   WelcomeTitle.Font = Enum.Font.GothamBold

   local WelcomeSubText = Instance.new("TextLabel")
   WelcomeSubText.Parent = WelcomeFrame
   WelcomeSubText.BackgroundTransparency = 1
   WelcomeSubText.Size = UDim2.fromScale(0.85, 0.06)
   WelcomeSubText.Position = UDim2.fromScale(0.5, 0.76)
   WelcomeSubText.AnchorPoint = Vector2.new(0.5, 0.5)
   WelcomeSubText.Text = "Loading Components..."
   WelcomeSubText.TextColor3 = Theme.SubText
   WelcomeSubText.TextSize = 12
   WelcomeSubText.Font = Enum.Font.Gotham

   local LoadingBar = Instance.new("Frame")
   LoadingBar.Parent = WelcomeFrame
   LoadingBar.BackgroundColor3 = Theme.Secondary
   LoadingBar.BackgroundTransparency = 0.2
   LoadingBar.Size = UDim2.fromScale(0.7, 0.03)
   LoadingBar.Position = UDim2.fromScale(0.5, 0.86)
   LoadingBar.AnchorPoint = Vector2.new(0.5, 0.5)

   local LoadingBarCorner = Instance.new("UICorner")
   LoadingBarCorner.CornerRadius = UDim.new(1, 0)
   LoadingBarCorner.Parent = LoadingBar

   local LoadingProgress = Instance.new("Frame")
   LoadingProgress.Parent = LoadingBar
   LoadingProgress.BackgroundColor3 = Theme.Accent
   LoadingProgress.BackgroundTransparency = 0.1
   LoadingProgress.Size = UDim2.fromScale(0, 1)
   LoadingProgress.Position = UDim2.fromScale(0, 0)

   local LoadingProgressCorner = Instance.new("UICorner")
   LoadingProgressCorner.CornerRadius = UDim.new(1, 0)
   LoadingProgressCorner.Parent = LoadingProgress

   local ProgressGlow = Instance.new("UIGradient")
   ProgressGlow.Color = ColorSequence.new{
       ColorSequenceKeypoint.new(0, Theme.Accent),
       ColorSequenceKeypoint.new(1, Color3.fromRGB(
           math.min(255, Theme.Accent.R * 255 * 1.3),
           math.min(255, Theme.Accent.G * 255 * 1.3),
           math.min(255, Theme.Accent.B * 255 * 1.3)
       ))
   }
   ProgressGlow.Parent = LoadingProgress

   local MainFrame = Instance.new("Frame")
   MainFrame.Name = "MainFrame"
   MainFrame.Parent = ScreenGui
   MainFrame.BackgroundColor3 = Theme.Primary
   MainFrame.BackgroundTransparency = 0.05
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
   MainCorner.CornerRadius = UDim.new(0, 24)
   MainCorner.Parent = MainFrame

   local MainStroke = Instance.new("UIStroke")
   MainStroke.Color = Theme.Border
   MainStroke.Thickness = 1
   MainStroke.Transparency = 0.2
   MainStroke.Parent = MainFrame

   local MainGradient = Instance.new("UIGradient")
   MainGradient.Color = ColorSequence.new{
       ColorSequenceKeypoint.new(0, Theme.Primary),
       ColorSequenceKeypoint.new(1, Color3.fromRGB(
           math.min(255, Theme.Primary.R * 255 + 8),
           math.min(255, Theme.Primary.G * 255 + 8),
           math.min(255, Theme.Primary.B * 255 + 8)
       ))
   }
   MainGradient.Rotation = 135
   MainGradient.Parent = MainFrame

   local TitleBar = Instance.new("Frame")
   TitleBar.Name = "TitleBar"
   TitleBar.Parent = MainFrame
   TitleBar.BackgroundColor3 = Theme.Secondary
   TitleBar.BackgroundTransparency = 0.15
   TitleBar.BorderSizePixel = 0
   TitleBar.Size = UDim2.new(1, 0, 0, 55)
   TitleBar.Position = UDim2.fromScale(0, 0)

   local TitleBarCorner = Instance.new("UICorner")
   TitleBarCorner.CornerRadius = UDim.new(0, 24)
   TitleBarCorner.Parent = TitleBar

   local TitleBarBottom = Instance.new("Frame")
   TitleBarBottom.Parent = TitleBar
   TitleBarBottom.BackgroundColor3 = Theme.Secondary
   TitleBarBottom.BackgroundTransparency = 0.15
   TitleBarBottom.BorderSizePixel = 0
   TitleBarBottom.Size = UDim2.new(1, 0, 0, 24)
   TitleBarBottom.Position = UDim2.new(0, 0, 1, -24)

   local TitleBarLine = Instance.new("Frame")
   TitleBarLine.Parent = TitleBar
   TitleBarLine.BackgroundColor3 = Theme.Border
   TitleBarLine.BackgroundTransparency = 0.4
   TitleBarLine.BorderSizePixel = 0
   TitleBarLine.Size = UDim2.new(1, -30, 0, 1)
   TitleBarLine.Position = UDim2.new(0, 15, 1, 0)

   local TitleIcon = Instance.new("ImageLabel")
   TitleIcon.Parent = TitleBar
   TitleIcon.BackgroundColor3 = Theme.Accent
   TitleIcon.BackgroundTransparency = 0.1
   TitleIcon.BorderSizePixel = 0
   TitleIcon.Size = UDim2.fromOffset(35, 35)
   TitleIcon.Position = UDim2.fromOffset(15, 10)
   TitleIcon.Image = IconImage
   TitleIcon.ScaleType = Enum.ScaleType.Crop

   local TitleIconCorner = Instance.new("UICorner")
   TitleIconCorner.CornerRadius = UDim.new(0, 10)
   TitleIconCorner.Parent = TitleIcon

   local TitleIconStroke = Instance.new("UIStroke")
   TitleIconStroke.Color = Theme.Accent
   TitleIconStroke.Thickness = 2
   TitleIconStroke.Transparency = 0.3
   TitleIconStroke.Parent = TitleIcon

   local IconRotation = CreateTween(TitleIcon, TweenInfo.new(10, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {
       Rotation = 360
   })
   IconRotation:Play()

   local IconPulse = CreateTween(TitleIcon, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
       Size = UDim2.fromOffset(38, 38)
   })
   IconPulse:Play()

   local TitleLabel = Instance.new("TextLabel")
   TitleLabel.Parent = TitleBar
   TitleLabel.BackgroundTransparency = 1
   TitleLabel.Size = UDim2.new(0, 180, 0, 22)
   TitleLabel.Position = UDim2.fromOffset(58, 8)
   TitleLabel.Text = Title
   TitleLabel.TextColor3 = Theme.Text
   TitleLabel.TextSize = 16
   TitleLabel.Font = Enum.Font.GothamBold
   TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

   local SubTitleLabel = Instance.new("TextLabel")
   SubTitleLabel.Parent = TitleBar
   SubTitleLabel.BackgroundTransparency = 1
   SubTitleLabel.Size = UDim2.new(0, 150, 0, 16)
   SubTitleLabel.Position = UDim2.fromOffset(58, 30)
   SubTitleLabel.Text = SubTitle
   SubTitleLabel.TextColor3 = Theme.SubText
   SubTitleLabel.TextSize = 12
   SubTitleLabel.Font = Enum.Font.Gotham
   SubTitleLabel.TextXAlignment = Enum.TextXAlignment.Left

   local ButtonsFrame = Instance.new("Frame")
   ButtonsFrame.Parent = TitleBar
   ButtonsFrame.BackgroundTransparency = 1
   ButtonsFrame.Size = UDim2.new(0, 120, 1, -15)
   ButtonsFrame.Position = UDim2.new(1, -125, 0, 8)

   local ButtonsLayout = Instance.new("UIListLayout")
   ButtonsLayout.FillDirection = Enum.FillDirection.Horizontal
   ButtonsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
   ButtonsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
   ButtonsLayout.Padding = UDim.new(0, 8)
   ButtonsLayout.Parent = ButtonsFrame

   local MaximizeButton = Instance.new("TextButton")
   MaximizeButton.Parent = ButtonsFrame
   MaximizeButton.BackgroundColor3 = Theme.Secondary
   MaximizeButton.BackgroundTransparency = 0.2
   MaximizeButton.BorderSizePixel = 0
   MaximizeButton.Size = UDim2.fromOffset(35, 35)
   MaximizeButton.Text = "⬜"
   MaximizeButton.TextColor3 = Theme.Text
   MaximizeButton.TextSize = 16
   MaximizeButton.Font = Enum.Font.GothamBold
   MaximizeButton.TextTransparency = 0.2

   local MaximizeCorner = Instance.new("UICorner")
   MaximizeCorner.CornerRadius = UDim.new(0, 12)
   MaximizeCorner.Parent = MaximizeButton

   local MaximizeStroke = Instance.new("UIStroke")
   MaximizeStroke.Color = Theme.Border
   MaximizeStroke.Thickness = 1
   MaximizeStroke.Transparency = 0.5
   MaximizeStroke.Parent = MaximizeButton

   local MinimizeButton = Instance.new("TextButton")
   MinimizeButton.Parent = ButtonsFrame
   MinimizeButton.BackgroundColor3 = Theme.Secondary
   MinimizeButton.BackgroundTransparency = 0.2
   MinimizeButton.BorderSizePixel = 0
   MinimizeButton.Size = UDim2.fromOffset(35, 35)
   MinimizeButton.Text = "➖"
   MinimizeButton.TextColor3 = Theme.Text
   MinimizeButton.TextSize = 14
   MinimizeButton.Font = Enum.Font.GothamBold
   MinimizeButton.TextTransparency = 0.2

   local MinimizeCorner = Instance.new("UICorner")
   MinimizeCorner.CornerRadius = UDim.new(0, 12)
   MinimizeCorner.Parent = MinimizeButton

   local MinimizeStroke = Instance.new("UIStroke")
   MinimizeStroke.Color = Theme.Border
   MinimizeStroke.Thickness = 1
   MinimizeStroke.Transparency = 0.5
   MinimizeStroke.Parent = MinimizeButton

   local CloseButton = Instance.new("TextButton")
   CloseButton.Parent = ButtonsFrame
   CloseButton.BackgroundColor3 = Theme.Secondary
   CloseButton.BackgroundTransparency = 0.2
   CloseButton.BorderSizePixel = 0
   CloseButton.Size = UDim2.fromOffset(35, 35)
   CloseButton.Text = "❌"
   CloseButton.TextColor3 = Theme.Text
   CloseButton.TextSize = 14
   CloseButton.Font = Enum.Font.GothamBold
   CloseButton.TextTransparency = 0.2

   local CloseCorner = Instance.new("UICorner")
   CloseCorner.CornerRadius = UDim.new(0, 12)
   CloseCorner.Parent = CloseButton

   local CloseStroke = Instance.new("UIStroke")
   CloseStroke.Color = Theme.Border
   CloseStroke.Thickness = 1
   CloseStroke.Transparency = 0.5
   CloseStroke.Parent = CloseButton

   local TabsFrame = Instance.new("Frame")
   TabsFrame.Name = "TabsFrame"
   TabsFrame.Parent = MainFrame
   TabsFrame.BackgroundTransparency = 1
   TabsFrame.Size = UDim2.new(0, 200, 1, -85)
   TabsFrame.Position = UDim2.fromOffset(15, 70)

   local TabsLayout = Instance.new("UIListLayout")
   TabsLayout.Parent = TabsFrame
   TabsLayout.FillDirection = Enum.FillDirection.Vertical
   TabsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
   TabsLayout.VerticalAlignment = Enum.VerticalAlignment.Top
   TabsLayout.Padding = UDim.new(0, 4)
   TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder

   local ContentFrame = Instance.new("Frame")
   ContentFrame.Name = "ContentFrame"
   ContentFrame.Parent = MainFrame
   ContentFrame.BackgroundTransparency = 1
   ContentFrame.Size = UDim2.new(1, -245, 1, -85)
   ContentFrame.Position = UDim2.fromOffset(230, 70)

   local TimeLabel = Instance.new("TextLabel")
   TimeLabel.Parent = MainFrame
   TimeLabel.BackgroundTransparency = 1
   TimeLabel.Size = UDim2.new(0, 120, 0, 18)
   TimeLabel.Position = UDim2.new(0, 15, 1, -25)
   TimeLabel.Text = "00:00"
   TimeLabel.TextColor3 = Theme.SubText
   TimeLabel.TextSize = 11
   TimeLabel.Font = Enum.Font.GothamMedium
   TimeLabel.TextXAlignment = Enum.TextXAlignment.Left

   local FloatingIcon = Instance.new("ImageLabel")
  FloatingIcon.Name = "FloatingIcon"
  FloatingIcon.Parent = ScreenGui
  FloatingIcon.BackgroundColor3 = Theme.Accent
  FloatingIcon.BackgroundTransparency = 0.05
  FloatingIcon.BorderSizePixel = 0
  FloatingIcon.Size = UDim2.fromOffset(65, 65)
  FloatingIcon.Position = UDim2.fromOffset(30, 30)
  FloatingIcon.Image = IconImage
  FloatingIcon.ScaleType = Enum.ScaleType.Crop
  FloatingIcon.Visible = false

  local FloatingCorner = Instance.new("UICorner")
  FloatingCorner.CornerRadius = UDim.new(1, 0)
  FloatingCorner.Parent = FloatingIcon

  local FloatingStroke = Instance.new("UIStroke")
  FloatingStroke.Color = Theme.Accent
  FloatingStroke.Thickness = 3
  FloatingStroke.Transparency = 0.2
  FloatingStroke.Parent = FloatingIcon

  local FloatingButton = Instance.new("TextButton")
  FloatingButton.Parent = FloatingIcon
  FloatingButton.BackgroundTransparency = 1
  FloatingButton.Size = UDim2.new(1, 0, 1, 0)
  FloatingButton.Text = ""

  local FloatingGradient = Instance.new("UIGradient")
  FloatingGradient.Color = ColorSequence.new{
      ColorSequenceKeypoint.new(0, Theme.Accent),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(
          math.min(255, Theme.Accent.R * 255 * 1.4),
          math.min(255, Theme.Accent.G * 255 * 1.4),
          math.min(255, Theme.Accent.B * 255 * 1.4)
      ))
  }
  FloatingGradient.Rotation = 45
  FloatingGradient.Parent = FloatingIcon

  local FloatingPulse = CreateTween(FloatingIcon, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
      Size = UDim2.fromOffset(70, 70)
  })

  local FloatingRotate = CreateTween(FloatingIcon, TweenInfo.new(8, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {
      Rotation = 360
  })

  MakeDraggable(MainFrame, TitleBar)
  MakeDraggable(FloatingIcon, FloatingIcon)

  local isMaximized = false
  local originalSize = Size
  local originalPosition = UDim2.fromScale(0.5, 0.5)
  local currentTab = nil

  local function ShowWindow()
      MainFrame.Visible = true
      FloatingIcon.Visible = false
      FloatingPulse:Cancel()
      FloatingRotate:Cancel()
      CreateTween(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
          Size = isMaximized and UDim2.fromScale(0.9, 0.9) or originalSize
      }):Play()
  end

  local function HideWindow()
      CreateTween(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
          Size = UDim2.fromOffset(0, 0)
      }):Play()
      task.wait(0.4)
      MainFrame.Visible = false
      FloatingIcon.Visible = true
      FloatingPulse:Play()
      FloatingRotate:Play()
  end

  local function MaximizeWindow()
      isMaximized = not isMaximized
      if isMaximized then
          CreateTween(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
              Size = UDim2.fromScale(0.9, 0.9),
              Position = UDim2.fromScale(0.5, 0.5)
          }):Play()
      else
          CreateTween(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
              Size = originalSize,
              Position = originalPosition
          }):Play()
      end
  end

  local function CreateButtonHover(button, hoverColor)
      local originalColor = button.BackgroundColor3
      button.MouseEnter:Connect(function()
          CreateTween(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
              BackgroundColor3 = hoverColor or Theme.Accent,
              BackgroundTransparency = 0.05,
              TextTransparency = 0
          }):Play()
          CreateTween(button:FindFirstChild("UIStroke"), TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
              Transparency = 0.2
          }):Play()
      end)
      
      button.MouseLeave:Connect(function()
          CreateTween(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
              BackgroundColor3 = originalColor,
              BackgroundTransparency = 0.2,
              TextTransparency = 0.2
          }):Play()
          CreateTween(button:FindFirstChild("UIStroke"), TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
              Transparency = 0.5
          }):Play()
      end)
  end

  CreateButtonHover(MaximizeButton, Theme.Success)
  CreateButtonHover(MinimizeButton, Theme.Warning)
  CreateButtonHover(CloseButton, Theme.Error)

  CloseButton.MouseButton1Click:Connect(function()
      CreateTween(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
          Size = UDim2.fromOffset(0, 0)
      }):Play()
      task.wait(0.3)
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

  local function UpdateTimer()
      local elapsed = tick() - StartTime
      TimeLabel.Text = "Uptime: " .. FormatTime(elapsed)
  end

  local timerConnection = RunService.Heartbeat:Connect(UpdateTimer)

  local NotificationCount = 0
  
  function Window:Notify(config)
      local Title = config.Title or "Notification"
      local Content = config.Content or "This is a notification"
      local Duration = config.Duration or 4
      local SoundId = config.SoundId or nil
      
      NotificationCount = NotificationCount + 1
      
      if SoundId then
          local sound = Instance.new("Sound")
          sound.SoundId = SoundId
          sound.Volume = 0.5
          sound.Parent = SoundService
          sound:Play()
          sound.Ended:Connect(function()
              sound:Destroy()
          end)
      end
      
      local NotificationFrame = Instance.new("Frame")
      NotificationFrame.Name = "Notification_" .. NotificationCount
      NotificationFrame.Parent = NotificationContainer
      NotificationFrame.BackgroundColor3 = Theme.Secondary
      NotificationFrame.BackgroundTransparency = 0.1
      NotificationFrame.BorderSizePixel = 0
      NotificationFrame.Size = UDim2.new(1, 0, 0, 70)
      NotificationFrame.Position = UDim2.new(1, 30, 0, 0)
      NotificationFrame.LayoutOrder = NotificationCount
      
      local NotificationCorner = Instance.new("UICorner")
      NotificationCorner.CornerRadius = UDim.new(0, 16)
      NotificationCorner.Parent = NotificationFrame
      
      local NotificationStroke = Instance.new("UIStroke")
      NotificationStroke.Color = Theme.Border
      NotificationStroke.Thickness = 1
      NotificationStroke.Transparency = 0.3
      NotificationStroke.Parent = NotificationFrame
      
      local NotificationGradient = Instance.new("UIGradient")
      NotificationGradient.Color = ColorSequence.new{
          ColorSequenceKeypoint.new(0, Theme.Secondary),
          ColorSequenceKeypoint.new(1, Color3.fromRGB(
              math.min(255, Theme.Secondary.R * 255 + 12),
              math.min(255, Theme.Secondary.G * 255 + 12),
              math.min(255, Theme.Secondary.B * 255 + 12)
          ))
      }
      NotificationGradient.Rotation = 90
      NotificationGradient.Parent = NotificationFrame
      
      local NotificationIcon = Instance.new("ImageLabel")
      NotificationIcon.Parent = NotificationFrame
      NotificationIcon.BackgroundColor3 = Theme.Accent
      NotificationIcon.BackgroundTransparency = 0.1
      NotificationIcon.BorderSizePixel = 0
      NotificationIcon.Size = UDim2.fromOffset(28, 28)
      NotificationIcon.Position = UDim2.fromOffset(15, 15)
      NotificationIcon.Image = IconImage
      NotificationIcon.ScaleType = Enum.ScaleType.Crop
      
      local NotificationIconCorner = Instance.new("UICorner")
      NotificationIconCorner.CornerRadius = UDim.new(0, 8)
      NotificationIconCorner.Parent = NotificationIcon
      
      local NotificationIconStroke = Instance.new("UIStroke")
      NotificationIconStroke.Color = Theme.Accent
      NotificationIconStroke.Thickness = 2
      NotificationIconStroke.Transparency = 0.4
      NotificationIconStroke.Parent = NotificationIcon
      
      local NotificationTitle = Instance.new("TextLabel")
      NotificationTitle.Parent = NotificationFrame
      NotificationTitle.BackgroundTransparency = 1
      NotificationTitle.Size = UDim2.new(1, -90, 0, 20)
      NotificationTitle.Position = UDim2.fromOffset(55, 8)
      NotificationTitle.Text = Title
      NotificationTitle.TextColor3 = Theme.Text
      NotificationTitle.TextSize = 14
      NotificationTitle.Font = Enum.Font.GothamBold
      NotificationTitle.TextXAlignment = Enum.TextXAlignment.Left
      NotificationTitle.TextTruncate = Enum.TextTruncate.AtEnd
      
      local NotificationContent = Instance.new("TextLabel")
      NotificationContent.Parent = NotificationFrame
      NotificationContent.BackgroundTransparency = 1
      NotificationContent.Size = UDim2.new(1, -90, 0, 32)
      NotificationContent.Position = UDim2.fromOffset(55, 25)
      NotificationContent.Text = Content
      NotificationContent.TextColor3 = Theme.SubText
      NotificationContent.TextSize = 12
      NotificationContent.Font = Enum.Font.Gotham
      NotificationContent.TextXAlignment = Enum.TextXAlignment.Left
      NotificationContent.TextWrapped = true
      NotificationContent.TextTruncate = Enum.TextTruncate.AtEnd
      
      local CloseNotificationButton = Instance.new("TextButton")
      CloseNotificationButton.Parent = NotificationFrame
      CloseNotificationButton.BackgroundColor3 = Theme.Error
      CloseNotificationButton.BackgroundTransparency = 0.8
      CloseNotificationButton.BorderSizePixel = 0
      CloseNotificationButton.Size = UDim2.fromOffset(24, 24)
      CloseNotificationButton.Position = UDim2.new(1, -32, 0, 8)
      CloseNotificationButton.Text = "✕"
      CloseNotificationButton.TextColor3 = Theme.Error
      CloseNotificationButton.TextSize = 14
      CloseNotificationButton.Font = Enum.Font.GothamBold
      CloseNotificationButton.TextTransparency = 0.3
      
      local CloseNotificationCorner = Instance.new("UICorner")
      CloseNotificationCorner.CornerRadius = UDim.new(0, 8)
      CloseNotificationCorner.Parent = CloseNotificationButton
      
      CloseNotificationButton.MouseEnter:Connect(function()
          CreateTween(CloseNotificationButton, TweenInfo.new(0.2), {
              BackgroundTransparency = 0.2,
              TextTransparency = 0
          }):Play()
      end)
      
      CloseNotificationButton.MouseLeave:Connect(function()
          CreateTween(CloseNotificationButton, TweenInfo.new(0.2), {
              BackgroundTransparency = 0.8,
              TextTransparency = 0.3
          }):Play()
      end)
      
      NotificationFrame.Position = UDim2.new(1, 30, 0, 0)
      NotificationFrame.BackgroundTransparency = 1
      NotificationStroke.Transparency = 1
      
      CreateTween(NotificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
          BackgroundTransparency = 0.1
      }):Play()
      
      CreateTween(NotificationStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
          Transparency = 0.3
      }):Play()
      
      CreateTween(NotificationFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
          Position = UDim2.new(0, 0, 0, 0)
      }):Play()
      
      local function CloseNotification()
          CreateTween(NotificationFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
              Position = UDim2.new(1, 30, 0, 0),
              BackgroundTransparency = 1
          }):Play()
          
          CreateTween(NotificationStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
              Transparency = 1
          }):Play()
          
          task.wait(0.3)
          NotificationFrame:Destroy()
      end
      
      CloseNotificationButton.MouseButton1Click:Connect(CloseNotification)
      
      if Duration and Duration > 0 then
          task.spawn(function()
              task.wait(Duration + 0.4)
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

  local function SwitchToTab(tab)
      for _, existingTab in pairs(Window.Tabs or {}) do
          if existingTab.ContentFrame then
              existingTab.ContentFrame.Visible = false
          end
          if existingTab.TabButton then
              CreateTween(existingTab.TabButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                  BackgroundTransparency = 1,
                  TextTransparency = 0.3
              }):Play()
              if existingTab.TabIcon then
                  CreateTween(existingTab.TabIcon, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                      ImageTransparency = 0.3
                  }):Play()
              end
          end
      end
      
      if tab.ContentFrame then
          tab.ContentFrame.Visible = true
      end
      if tab.TabButton then
          CreateTween(tab.TabButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
              BackgroundTransparency = 0.85,
              TextTransparency = 0
          }):Play()
          if tab.TabIcon then
              CreateTween(tab.TabIcon, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                  ImageTransparency = 0
              }):Play()
          end
      end
      
      currentTab = tab
  end

  function Window:AddTab(config)
      local TabTitle = config.Title or "Tab"
      local TabIcon = config.Icon or ""
      local IconId = GetIconId(TabIcon)
      
      local Tab = {}
      Tab.Title = TabTitle
      Tab.Icon = TabIcon
      
      local TabButton = Instance.new("TextButton")
      TabButton.Parent = TabsFrame
      TabButton.BackgroundColor3 = Theme.Text
      TabButton.BackgroundTransparency = 1
      TabButton.BorderSizePixel = 0
      TabButton.Size = UDim2.new(1, 0, 0, 40)
      TabButton.Text = ""
      
      local TabButtonCorner = Instance.new("UICorner")
      TabButtonCorner.CornerRadius = UDim.new(0, 12)
      TabButtonCorner.Parent = TabButton
      
      local TabIconLabel = nil
      if IconId and IconId ~= "" then
          TabIconLabel = Instance.new("ImageLabel")
          TabIconLabel.Parent = TabButton
          TabIconLabel.BackgroundTransparency = 1
          TabIconLabel.Size = UDim2.fromOffset(20, 20)
          TabIconLabel.Position = UDim2.fromOffset(12, 10)
          TabIconLabel.Image = IconId
          TabIconLabel.ImageTransparency = 0.3
          TabIconLabel.ScaleType = Enum.ScaleType.Fit
      end
      
      local TabTitleLabel = Instance.new("TextLabel")
      TabTitleLabel.Parent = TabButton
      TabTitleLabel.BackgroundTransparency = 1
      TabTitleLabel.Size = UDim2.new(1, TabIconLabel and -45 or -24, 1, 0)
      TabTitleLabel.Position = UDim2.fromOffset(TabIconLabel and 40 or 12, 0)
      TabTitleLabel.Text = TabTitle
      TabTitleLabel.TextColor3 = Theme.Text
      TabTitleLabel.TextSize = 14
      TabTitleLabel.Font = Enum.Font.GothamMedium
      TabTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
      TabTitleLabel.TextTransparency = 0.3
      
      local TabContentFrame = Instance.new("Frame")
      TabContentFrame.Parent = ContentFrame
      TabContentFrame.BackgroundTransparency = 1
      TabContentFrame.Size = UDim2.new(1, 0, 1, 0)
      TabContentFrame.Position = UDim2.fromScale(0, 0)
      TabContentFrame.Visible = false
      
      Tab.TabButton = TabButton
      Tab.TabIcon = TabIconLabel
      Tab.ContentFrame = TabContentFrame
      
      TabButton.MouseEnter:Connect(function()
          if currentTab ~= Tab then
              CreateTween(TabButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                  BackgroundTransparency = 0.9
              }):Play()
              CreateTween(TabTitleLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                  TextTransparency = 0.1
              }):Play()
              if TabIconLabel then
                  CreateTween(TabIconLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                      ImageTransparency = 0.1
                  }):Play()
              end
          end
      end)
      
      TabButton.MouseLeave:Connect(function()
          if currentTab ~= Tab then
              CreateTween(TabButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                  BackgroundTransparency = 1
              }):Play()
              CreateTween(TabTitleLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                  TextTransparency = 0.3
              }):Play()
              if TabIconLabel then
                  CreateTween(TabIconLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                      ImageTransparency = 0.3
                  }):Play()
              end
          end
      end)
      
      TabButton.MouseButton1Click:Connect(function()
          SwitchToTab(Tab)
      end)
      
      if not Window.Tabs then
          Window.Tabs = {}
      end
      table.insert(Window.Tabs, Tab)
      
      if #Window.Tabs == 1 then
          SwitchToTab(Tab)
      end
      
      return Tab
  end

  CreateTween(LoadingProgress, TweenInfo.new(LoadingTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
      Size = UDim2.fromScale(1, 1)
  }):Play()

  task.wait(LoadingTime)
  
  CreateTween(WelcomeFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
      Size = UDim2.fromOffset(0, 0),
      Position = UDim2.fromScale(0.5, 0.5)
  }):Play()

  task.wait(0.4)
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
  Window.Theme = Theme
  Window.TitleIcon = TitleIcon
  Window.FloatingIcon = FloatingIcon
  Window.TimeLabel = TimeLabel
  Window.TimerConnection = timerConnection
  Window.TabsFrame = TabsFrame
  Window.Tabs = {}
  
  function Window:SetIcon(imageId)
      TitleIcon.Image = imageId
      FloatingIcon.Image = imageId
  end
  
  function Window:Destroy()
      if timerConnection then
          timerConnection:Disconnect()
      end
      ScreenGui:Destroy()
  end
  
  return Window
end

return FRONT_GUI
