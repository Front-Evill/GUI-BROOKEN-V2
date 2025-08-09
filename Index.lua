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
       Primary = Color3.fromRGB(18, 18, 23),
       Secondary = Color3.fromRGB(25, 25, 30),
       Tertiary = Color3.fromRGB(35, 35, 40),
       Accent = Color3.fromRGB(88, 166, 255),
       Success = Color3.fromRGB(34, 197, 94),
       Warning = Color3.fromRGB(245, 158, 11),
       Error = Color3.fromRGB(239, 68, 68),
       Text = Color3.fromRGB(255, 255, 255),
       SubText = Color3.fromRGB(156, 163, 175),
       Border = Color3.fromRGB(75, 85, 99),
       Shadow = Color3.fromRGB(0, 0, 0)
   },
   Light = {
       Primary = Color3.fromRGB(255, 255, 255),
       Secondary = Color3.fromRGB(248, 250, 252),
       Tertiary = Color3.fromRGB(241, 245, 249),
       Accent = Color3.fromRGB(59, 130, 246),
       Success = Color3.fromRGB(34, 197, 94),
       Warning = Color3.fromRGB(245, 158, 11),
       Error = Color3.fromRGB(239, 68, 68),
       Text = Color3.fromRGB(15, 23, 42),
       SubText = Color3.fromRGB(100, 116, 139),
       Border = Color3.fromRGB(226, 232, 240),
       Shadow = Color3.fromRGB(148, 163, 184)
   },
   Purple = {
       Primary = Color3.fromRGB(24, 24, 37),
       Secondary = Color3.fromRGB(35, 35, 50),
       Tertiary = Color3.fromRGB(45, 45, 65),
       Accent = Color3.fromRGB(139, 92, 246),
       Success = Color3.fromRGB(34, 197, 94),
       Warning = Color3.fromRGB(245, 158, 11),
       Error = Color3.fromRGB(239, 68, 68),
       Text = Color3.fromRGB(255, 255, 255),
       SubText = Color3.fromRGB(196, 181, 253),
       Border = Color3.fromRGB(88, 80, 141),
       Shadow = Color3.fromRGB(17, 24, 39)
   },
   Green = {
       Primary = Color3.fromRGB(22, 40, 28),
       Secondary = Color3.fromRGB(30, 50, 36),
       Tertiary = Color3.fromRGB(38, 60, 44),
       Accent = Color3.fromRGB(34, 197, 94),
       Success = Color3.fromRGB(34, 197, 94),
       Warning = Color3.fromRGB(245, 158, 11),
       Error = Color3.fromRGB(239, 68, 68),
       Text = Color3.fromRGB(255, 255, 255),
       SubText = Color3.fromRGB(167, 243, 208),
       Border = Color3.fromRGB(75, 95, 85),
       Shadow = Color3.fromRGB(5, 46, 22)
   },
   Black = {
       Primary = Color3.fromRGB(9, 9, 11),
       Secondary = Color3.fromRGB(15, 15, 18),
       Tertiary = Color3.fromRGB(21, 21, 24),
       Accent = Color3.fromRGB(88, 166, 255),
       Success = Color3.fromRGB(34, 197, 94),
       Warning = Color3.fromRGB(245, 158, 11),
       Error = Color3.fromRGB(239, 68, 68),
       Text = Color3.fromRGB(255, 255, 255),
       SubText = Color3.fromRGB(161, 161, 170),
       Border = Color3.fromRGB(63, 63, 70),
       Shadow = Color3.fromRGB(0, 0, 0)
   },
   Ocean = {
       Primary = Color3.fromRGB(12, 30, 45),
       Secondary = Color3.fromRGB(20, 40, 55),
       Tertiary = Color3.fromRGB(28, 50, 65),
       Accent = Color3.fromRGB(14, 165, 233),
       Success = Color3.fromRGB(34, 197, 94),
       Warning = Color3.fromRGB(245, 158, 11),
       Error = Color3.fromRGB(239, 68, 68),
       Text = Color3.fromRGB(255, 255, 255),
       SubText = Color3.fromRGB(186, 230, 253),
       Border = Color3.fromRGB(71, 85, 105),
       Shadow = Color3.fromRGB(2, 6, 23)
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
       return tostring(ageInDays) .. " D"
   elseif ageInDays < 365 then
       return tostring(math.floor(ageInDays / 30)) .. " W"
   else
       return tostring(math.floor(ageInDays / 365)) .. " Y"
   end
end

local function CreateShadow(parent, size, position, zIndex)
   local shadow = Instance.new("ImageLabel")
   shadow.Name = "Shadow"
   shadow.Parent = parent
   shadow.BackgroundTransparency = 1
   shadow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
   shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
   shadow.ImageTransparency = 0.8
   shadow.Size = size
   shadow.Position = position
   shadow.ZIndex = zIndex or 1
   
   local shadowCorner = Instance.new("UICorner")
   shadowCorner.CornerRadius = UDim.new(0, 20)
   shadowCorner.Parent = shadow
   
   return shadow
end

function FRONT_GUI:CreateWindow(config)
   local Window = {}
   Window.Tabs = {}
   
   local Title = config.Title or "FRONT GUI"
   local SubTitle = config.SubTitle or "By : FRONT TEAM"
   local WelcomeText = config.WelcomeText or "Welcome To Front-Evill Gui"
   local LoadingTime = config.LoadingTime or 2.5
   local Size = config.Size or UDim2.fromOffset(820, 550)
   local ThemeName = config.Theme or "Dark"
   local MinimizeKey = config.MinimizeKey or Enum.KeyCode.B
   
   local Theme = Themes[ThemeName] or Themes.Dark

   local ScreenGui = Instance.new("ScreenGui")
   ScreenGui.Name = "FRONT_GUI_" .. tick()
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
   NotificationLayout.Padding = UDim.new(0, 10)
   NotificationLayout.SortOrder = Enum.SortOrder.LayoutOrder

   local WelcomeFrame = Instance.new("Frame")
   WelcomeFrame.Name = "WelcomeFrame"
   WelcomeFrame.Parent = ScreenGui
   WelcomeFrame.BackgroundColor3 = Theme.Primary
   WelcomeFrame.BackgroundTransparency = 0.1
   WelcomeFrame.BorderSizePixel = 0
   WelcomeFrame.Size = UDim2.fromScale(0.35, 0.45)
   WelcomeFrame.Position = UDim2.fromScale(0.5, 0.5)
   WelcomeFrame.AnchorPoint = Vector2.new(0.5, 0.5)
   WelcomeFrame.ZIndex = 100

   local WelcomeShadow = CreateShadow(ScreenGui, UDim2.fromScale(0.35, 0.45), UDim2.fromScale(0.5, 0.51), 99)
   WelcomeShadow.AnchorPoint = Vector2.new(0.5, 0.5)

   local WelcomeConstraint = Instance.new("UISizeConstraint")
   WelcomeConstraint.MinSize = Vector2.new(350, 280)
   WelcomeConstraint.MaxSize = Vector2.new(450, 380)
   WelcomeConstraint.Parent = WelcomeFrame

   local WelcomeCorner = Instance.new("UICorner")
   WelcomeCorner.CornerRadius = UDim.new(0, 25)
   WelcomeCorner.Parent = WelcomeFrame

   local WelcomeStroke = Instance.new("UIStroke")
   WelcomeStroke.Color = Theme.Border
   WelcomeStroke.Thickness = 1.5
   WelcomeStroke.Transparency = 0.4
   WelcomeStroke.Parent = WelcomeFrame

   local WelcomeGradient = Instance.new("UIGradient")
   WelcomeGradient.Color = ColorSequence.new{
       ColorSequenceKeypoint.new(0, Theme.Primary),
       ColorSequenceKeypoint.new(1, Color3.fromRGB(
           math.min(255, Theme.Primary.R * 255 + 15),
           math.min(255, Theme.Primary.G * 255 + 15),
           math.min(255, Theme.Primary.B * 255 + 15)
       ))
   }
   WelcomeGradient.Rotation = 45
   WelcomeGradient.Parent = WelcomeFrame

   local PlayerAvatar = Instance.new("ImageLabel")
   PlayerAvatar.Parent = WelcomeFrame
   PlayerAvatar.BackgroundTransparency = 1
   PlayerAvatar.Size = UDim2.fromOffset(75, 75)
   PlayerAvatar.Position = UDim2.fromScale(0.5, 0.2)
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

   local AvatarGlow = CreateTween(AvatarStroke, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
       Transparency = 0.6
   })
   AvatarGlow:Play()

   local PlayerNameLabel = Instance.new("TextLabel")
   PlayerNameLabel.Parent = WelcomeFrame
   PlayerNameLabel.BackgroundTransparency = 1
   PlayerNameLabel.Size = UDim2.fromScale(0.85, 0.08)
   PlayerNameLabel.Position = UDim2.fromScale(0.5, 0.36)
   PlayerNameLabel.AnchorPoint = Vector2.new(0.5, 0.5)
   PlayerNameLabel.Text = Player.DisplayName
   PlayerNameLabel.TextColor3 = Theme.Text
   PlayerNameLabel.TextSize = 18
   PlayerNameLabel.Font = Enum.Font.GothamBold
   PlayerNameLabel.TextScaled = true

   local PlayerUsernameLabel = Instance.new("TextLabel")
   PlayerUsernameLabel.Parent = WelcomeFrame
   PlayerUsernameLabel.BackgroundTransparency = 1
   PlayerUsernameLabel.Size = UDim2.fromScale(0.85, 0.06)
   PlayerUsernameLabel.Position = UDim2.fromScale(0.5, 0.44)
   PlayerUsernameLabel.AnchorPoint = Vector2.new(0.5, 0.5)
   PlayerUsernameLabel.Text = "@" .. Player.Name
   PlayerUsernameLabel.TextColor3 = Theme.Accent
   PlayerUsernameLabel.TextSize = 13
   PlayerUsernameLabel.Font = Enum.Font.GothamMedium
   PlayerUsernameLabel.TextScaled = true

   local AccountAgeLabel = Instance.new("TextLabel")
   AccountAgeLabel.Parent = WelcomeFrame
   AccountAgeLabel.BackgroundTransparency = 1
   AccountAgeLabel.Size = UDim2.fromScale(0.85, 0.05)
   AccountAgeLabel.Position = UDim2.fromScale(0.5, 0.52)
   AccountAgeLabel.AnchorPoint = Vector2.new(0.5, 0.5)
   AccountAgeLabel.Text = "عمر الحساب: " .. GetAccountAge(Player)
   AccountAgeLabel.TextColor3 = Theme.SubText
   AccountAgeLabel.TextSize = 11
   AccountAgeLabel.Font = Enum.Font.Gotham
   AccountAgeLabel.TextScaled = true

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
   WelcomeTitle.TextScaled = true

   local WelcomeSubText = Instance.new("TextLabel")
   WelcomeSubText.Parent = WelcomeFrame
   WelcomeSubText.BackgroundTransparency = 1
   WelcomeSubText.Size = UDim2.fromScale(0.85, 0.06)
   WelcomeSubText.Position = UDim2.fromScale(0.5, 0.76)
   WelcomeSubText.AnchorPoint = Vector2.new(0.5, 0.5)
   WelcomeSubText.Text = "جاري تحميل المكونات..."
   WelcomeSubText.TextColor3 = Theme.SubText
   WelcomeSubText.TextSize = 12
   WelcomeSubText.Font = Enum.Font.Gotham
   WelcomeSubText.TextScaled = true

   local LoadingBar = Instance.new("Frame")
   LoadingBar.Parent = WelcomeFrame
   LoadingBar.BackgroundColor3 = Theme.Secondary
   LoadingBar.BackgroundTransparency = 0.2
   LoadingBar.Size = UDim2.fromScale(0.75, 0.03)
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

   local LoadingGradient = Instance.new("UIGradient")
   LoadingGradient.Color = ColorSequence.new{
       ColorSequenceKeypoint.new(0, Theme.Accent),
       ColorSequenceKeypoint.new(1, Color3.fromRGB(
           math.min(255, Theme.Accent.R * 255 + 50),
           math.min(255, Theme.Accent.G * 255 + 50),
           math.min(255, Theme.Accent.B * 255 + 50)
       ))
   }
   LoadingGradient.Rotation = 0
   LoadingGradient.Parent = LoadingProgress

   local MainFrame = Instance.new("Frame")
   MainFrame.Name = "MainFrame"
   MainFrame.Parent = ScreenGui
   MainFrame.BackgroundColor3 = Theme.Primary
   MainFrame.BackgroundTransparency = 0.08
   MainFrame.BorderSizePixel = 0
   MainFrame.Size = Size
   MainFrame.Position = UDim2.fromScale(0.5, 0.5)
   MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
   MainFrame.Visible = false

   local MainShadow = CreateShadow(ScreenGui, Size, UDim2.fromScale(0.5, 0.52), 1)
   MainShadow.AnchorPoint = Vector2.new(0.5, 0.5)
   MainShadow.Visible = false

   local MainConstraint = Instance.new("UISizeConstraint")
   MainConstraint.MinSize = Vector2.new(500, 400)
   MainConstraint.MaxSize = Vector2.new(1400, 900)
   MainConstraint.Parent = MainFrame

   local MainCorner = Instance.new("UICorner")
   MainCorner.CornerRadius = UDim.new(0, 25)
   MainCorner.Parent = MainFrame

   local MainStroke = Instance.new("UIStroke")
   MainStroke.Color = Theme.Border
   MainStroke.Thickness = 1.5
   MainStroke.Transparency = 0.3
   MainStroke.Parent = MainFrame

   local MainGradient = Instance.new("UIGradient")
   MainGradient.Color = ColorSequence.new{
       ColorSequenceKeypoint.new(0, Theme.Primary),
       ColorSequenceKeypoint.new(1, Color3.fromRGB(
           math.min(255, Theme.Primary.R * 255 + 10),
           math.min(255, Theme.Primary.G * 255 + 10),
           math.min(255, Theme.Primary.B * 255 + 10)
       ))
   }
   MainGradient.Rotation = 135
   MainGradient.Parent = MainFrame

   local TitleFrame = Instance.new("Frame")
   TitleFrame.Name = "TitleFrame"
   TitleFrame.Parent = MainFrame
   TitleFrame.BackgroundColor3 = Theme.Secondary
   TitleFrame.BackgroundTransparency = 0.2
   TitleFrame.BorderSizePixel = 0
   TitleFrame.Size = UDim2.new(1, 0, 0, 60)
   TitleFrame.Position = UDim2.fromScale(0, 0)

   local TitleCorner = Instance.new("UICorner")
   TitleCorner.CornerRadius = UDim.new(0, 25)
   TitleCorner.Parent = TitleFrame

   local TitleBottom = Instance.new("Frame")
   TitleBottom.Parent = TitleFrame
   TitleBottom.BackgroundColor3 = Theme.Secondary
   TitleBottom.BackgroundTransparency = 0.2
   TitleBottom.BorderSizePixel = 0
   TitleBottom.Size = UDim2.new(1, 0, 0, 25)
   TitleBottom.Position = UDim2.new(0, 0, 1, -25)

   local TitleGradient = Instance.new("UIGradient")
   TitleGradient.Color = ColorSequence.new{
       ColorSequenceKeypoint.new(0, Theme.Secondary),
       ColorSequenceKeypoint.new(1, Color3.fromRGB(
           math.min(255, Theme.Secondary.R * 255 + 20),
           math.min(255, Theme.Secondary.G * 255 + 20),
           math.min(255, Theme.Secondary.B * 255 + 20)
       ))
   }
   TitleGradient.Rotation = 90
   TitleGradient.Parent = TitleFrame

   local TitleLine = Instance.new("Frame")
   TitleLine.Parent = TitleFrame
   TitleLine.BackgroundColor3 = Theme.Accent
   TitleLine.BackgroundTransparency = 0.3
   TitleLine.BorderSizePixel = 0
   TitleLine.Size = UDim2.new(1, -30, 0, 2)
   TitleLine.Position = UDim2.new(0, 15, 1, 0)

   local LineGradient = Instance.new("UIGradient")
   LineGradient.Color = ColorSequence.new{
       ColorSequenceKeypoint.new(0, Theme.Accent),
       ColorSequenceKeypoint.new(0.5, Color3.fromRGB(
           math.min(255, Theme.Accent.R * 255 + 50),
           math.min(255, Theme.Accent.G * 255 + 50),
           math.min(255, Theme.Accent.B * 255 + 50)
       )),
       ColorSequenceKeypoint.new(1, Theme.Accent)
   }
   LineGradient.Rotation = 0
   LineGradient.Parent = TitleLine

   local TitleIcon = Instance.new("Frame")
   TitleIcon.Parent = TitleFrame
   TitleIcon.BackgroundColor3 = Theme.Accent
   TitleIcon.BackgroundTransparency = 0.1
   TitleIcon.BorderSizePixel = 0
   TitleIcon.Size = UDim2.fromOffset(35, 35)
   TitleIcon.Position = UDim2.fromOffset(18, 12)

   local IconCorner = Instance.new("UICorner")
   IconCorner.CornerRadius = UDim.new(0, 10)
   IconCorner.Parent = TitleIcon

   local IconStroke = Instance.new("UIStroke")
   IconStroke.Color = Theme.Accent
   IconStroke.Thickness = 1.5
   IconStroke.Transparency = 0.4
   IconStroke.Parent = TitleIcon

   local IconGradient = Instance.new("UIGradient")
   IconGradient.Color = ColorSequence.new{
       ColorSequenceKeypoint.new(0, Theme.Accent),
       ColorSequenceKeypoint.new(1, Color3.fromRGB(
           math.min(255, Theme.Accent.R * 255 + 70),
           math.min(255, Theme.Accent.G * 255 + 70),
           math.min(255, Theme.Accent.B * 255 + 70)
       ))
   }
   IconGradient.Rotation = 45
   IconGradient.Parent = TitleIcon

   local IconPulse = CreateTween(TitleIcon, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
       BackgroundTransparency = 0.4
   })
   IconPulse:Play()

   local TitleLabel = Instance.new("TextLabel")
   TitleLabel.Parent = TitleFrame
   TitleLabel.BackgroundTransparency = 1
   TitleLabel.Size = UDim2.new(0, 200, 0, 22)
   TitleLabel.Position = UDim2.fromOffset(62, 12)
   TitleLabel.Text = Title
   TitleLabel.TextColor3 = Theme.Text
   TitleLabel.TextSize = 16
   TitleLabel.Font = Enum.Font.GothamBold
   TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
   TitleLabel.TextScaled = true

   local SubTitleLabel = Instance.new("TextLabel")
   SubTitleLabel.Parent = TitleFrame
   SubTitleLabel.BackgroundTransparency = 1
   SubTitleLabel.Size = UDim2.new(0, 180, 0, 16)
   SubTitleLabel.Position = UDim2.fromOffset(62, 32)
   SubTitleLabel.Text = SubTitle
   SubTitleLabel.TextColor3 = Theme.SubText
   SubTitleLabel.TextSize = 12
   SubTitleLabel.Font = Enum.Font.Gotham
   SubTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
   SubTitleLabel.TextScaled = true

   local ButtonsFrame = Instance.new("Frame")
   ButtonsFrame.Parent = TitleFrame
   ButtonsFrame.BackgroundTransparency = 1
   ButtonsFrame.Size = UDim2.new(0, 120, 1, -16)
   ButtonsFrame.Position = UDim2.new(1, -130, 0, 8)

   local ButtonsLayout = Instance.new("UIListLayout")
   ButtonsLayout.FillDirection = Enum.FillDirection.Horizontal
   ButtonsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
   ButtonsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
   ButtonsLayout.Padding = UDim.new(0, 8)
   ButtonsLayout.Parent = ButtonsFrame

   local function CreateControlButton(text, color)
       local button = Instance.new("TextButton")
       button.BackgroundColor3 = Theme.Secondary
       button.BackgroundTransparency = 0.3
       button.BorderSizePixel = 0
       button.Size = UDim2.fromOffset(35, 35)
       button.Text = text
       button.TextColor3 = Theme.Text
       button.TextSize = 16
       button.Font = Enum.Font.GothamBold
       button.TextTransparency = 0.2

       local corner = Instance.new("UICorner")
       corner.CornerRadius = UDim.new(0, 12)
       corner.Parent = button

       local stroke = Instance.new("UIStroke")
       stroke.Color = Theme.Border
       stroke.Thickness = 1
       stroke.Transparency = 0.6
       stroke.Parent = button

       return button
   end

   local MaximizeButton = CreateControlButton("⤢", Theme.Accent)
   MaximizeButton.Parent = ButtonsFrame

   local MinimizeButton = CreateControlButton("—", Theme.Warning)
   MinimizeButton.Parent = ButtonsFrame

   local CloseButton = CreateControlButton("✕", Theme.Error)
   CloseButton.Parent = ButtonsFrame

   local ContentFrame = Instance.new("Frame")
   ContentFrame.Name = "ContentFrame"
   ContentFrame.Parent = MainFrame
   ContentFrame.BackgroundTransparency = 1
   ContentFrame.Size = UDim2.new(1, -30, 1, -80)
   ContentFrame.Position = UDim2.fromOffset(15, 68)

   local FloatingIcon = Instance.new("Frame")
   FloatingIcon.Name = "FloatingIcon"
   FloatingIcon.Parent = ScreenGui
   FloatingIcon.BackgroundColor3 = Theme.Accent
   FloatingIcon.BackgroundTransparency = 0.05
   FloatingIcon.BorderSizePixel = 0
   FloatingIcon.Size = UDim2.fromOffset(65, 65)
   FloatingIcon.Position = UDim2.fromOffset(30, 30)
   FloatingIcon.Visible = false

   local FloatingCorner = Instance.new("UICorner")
   FloatingCorner.CornerRadius = UDim.new(1, 0)
   FloatingCorner.Parent = FloatingIcon

   local FloatingStroke = Instance.new("UIStroke")
   FloatingStroke.Color = Theme.Accent
   FloatingStroke.Thickness = 2.5
   FloatingStroke.Transparency = 0.2
   FloatingStroke.Parent = FloatingIcon

   local FloatingGradient = Instance.new("UIGradient")
  FloatingGradient.Color = ColorSequence.new{
      ColorSequenceKeypoint.new(0, Theme.Accent),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(
          math.min(255, Theme.Accent.R * 255 + 80),
          math.min(255, Theme.Accent.G * 255 + 80),
          math.min(255, Theme.Accent.B * 255 + 80)
      ))
  }
  FloatingGradient.Rotation = 45
  FloatingGradient.Parent = FloatingIcon

  local FloatingButton = Instance.new("TextButton")
  FloatingButton.Parent = FloatingIcon
  FloatingButton.BackgroundTransparency = 1
  FloatingButton.Size = UDim2.new(1, 0, 1, 0)
  FloatingButton.Text = ""

  local FloatingPulse = CreateTween(FloatingIcon, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
      Size = UDim2.fromOffset(70, 70)
  })

  local FloatingRotate = CreateTween(FloatingGradient, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {
      Rotation = 405
  })

  MakeDraggable(MainFrame, TitleFrame)
  MakeDraggable(FloatingIcon, FloatingIcon)

  local isMaximized = false
  local originalSize = Size
  local originalPosition = UDim2.fromScale(0.5, 0.5)

  local function ShowWindow()
      MainFrame.Visible = true
      MainShadow.Visible = true
      FloatingIcon.Visible = false
      FloatingPulse:Cancel()
      FloatingRotate:Cancel()
      
      MainFrame.Size = UDim2.fromOffset(0, 0)
      MainShadow.Size = UDim2.fromOffset(0, 0)
      
      CreateTween(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
          Size = isMaximized and UDim2.fromScale(0.9, 0.9) or originalSize
      }):Play()
      
      CreateTween(MainShadow, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
          Size = isMaximized and UDim2.fromScale(0.9, 0.9) or originalSize
      }):Play()
  end

  local function HideWindow()
      CreateTween(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
          Size = UDim2.fromOffset(0, 0)
      }):Play()
      
      CreateTween(MainShadow, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
          Size = UDim2.fromOffset(0, 0)
      }):Play()
      
      wait(0.35)
      MainFrame.Visible = false
      MainShadow.Visible = false
      FloatingIcon.Visible = true
      FloatingPulse:Play()
      FloatingRotate:Play()
  end

  local function MaximizeWindow()
      isMaximized = not isMaximized
      if isMaximized then
          CreateTween(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
              Size = UDim2.fromScale(0.9, 0.9),
              Position = UDim2.fromScale(0.5, 0.5)
          }):Play()
          
          CreateTween(MainShadow, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
              Size = UDim2.fromScale(0.9, 0.9),
              Position = UDim2.fromScale(0.5, 0.52)
          }):Play()
      else
          CreateTween(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
              Size = originalSize,
              Position = originalPosition
          }):Play()
          
          CreateTween(MainShadow, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
              Size = originalSize,
              Position = UDim2.fromScale(0.5, 0.52)
          }):Play()
      end
  end

  local function CreateButtonHover(button, hoverColor)
      button.MouseEnter:Connect(function()
          CreateTween(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
              BackgroundTransparency = 0.05,
              TextTransparency = 0,
              BackgroundColor3 = hoverColor or button.BackgroundColor3
          }):Play()
          
          CreateTween(button:FindFirstChild("UIStroke"), TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
              Transparency = 0.3
          }):Play()
      end)
      
      button.MouseLeave:Connect(function()
          CreateTween(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
              BackgroundTransparency = 0.3,
              TextTransparency = 0.2,
              BackgroundColor3 = Theme.Secondary
          }):Play()
          
          CreateTween(button:FindFirstChild("UIStroke"), TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
              Transparency = 0.6
          }):Play()
      end)
  end

  CreateButtonHover(MaximizeButton, Theme.Accent)
  CreateButtonHover(MinimizeButton, Theme.Warning)
  CreateButtonHover(CloseButton, Theme.Error)

  CloseButton.MouseButton1Click:Connect(function()
      CreateTween(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
          Size = UDim2.fromOffset(0, 0)
      }):Play()
      
      CreateTween(MainShadow, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
          Size = UDim2.fromOffset(0, 0)
      }):Play()
      
      wait(0.25)
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
      local Title = config.Title or "Notify"
      local Content = config.Content or "Hello"
      local SubContent = config.SubContent or ""
      local Duration = config.Duration or 5
      local Type = config.Type or "Default"
      
      NotificationCount = NotificationCount + 1
      
      local NotificationFrame = Instance.new("Frame")
      NotificationFrame.Name = "Notification_" .. NotificationCount
      NotificationFrame.Parent = NotificationContainer
      NotificationFrame.BackgroundColor3 = Theme.Secondary
      NotificationFrame.BackgroundTransparency = 0.1
      NotificationFrame.BorderSizePixel = 0
      NotificationFrame.Size = UDim2.new(1, 0, 0, SubContent ~= "" and 75 or 60)
      NotificationFrame.Position = UDim2.new(1, 30, 0, 0)
      NotificationFrame.LayoutOrder = NotificationCount
      
      local NotificationCorner = Instance.new("UICorner")
      NotificationCorner.CornerRadius = UDim.new(0, 15)
      NotificationCorner.Parent = NotificationFrame
      
      local NotificationStroke = Instance.new("UIStroke")
      NotificationStroke.Color = Theme.Border
      NotificationStroke.Thickness = 1.2
      NotificationStroke.Transparency = 0.4
      NotificationStroke.Parent = NotificationFrame
      
      local NotificationGradient = Instance.new("UIGradient")
      NotificationGradient.Color = ColorSequence.new{
          ColorSequenceKeypoint.new(0, Theme.Secondary),
          ColorSequenceKeypoint.new(1, Color3.fromRGB(
              math.min(255, Theme.Secondary.R * 255 + 15),
              math.min(255, Theme.Secondary.G * 255 + 15),
              math.min(255, Theme.Secondary.B * 255 + 15)
          ))
      }
      NotificationGradient.Rotation = 90
      NotificationGradient.Parent = NotificationFrame
      
      local NotificationIcon = Instance.new("Frame")
      NotificationIcon.Parent = NotificationFrame
      NotificationIcon.BackgroundTransparency = 0.2
      NotificationIcon.BorderSizePixel = 0
      NotificationIcon.Size = UDim2.fromOffset(25, 25)
      NotificationIcon.Position = UDim2.fromOffset(18, 15)
      
      local AccentColor = Theme.Accent
      local IconText = "ℹ"
      
      if Type == "Success" then
          AccentColor = Theme.Success
          IconText = "✓"
      elseif Type == "Warning" then
          AccentColor = Theme.Warning
          IconText = "⚠"
      elseif Type == "Error" then
          AccentColor = Theme.Error
          IconText = "✕"
      end
      
      NotificationIcon.BackgroundColor3 = AccentColor
      
      local NotificationIconCorner = Instance.new("UICorner")
      NotificationIconCorner.CornerRadius = UDim.new(0, 6)
      NotificationIconCorner.Parent = NotificationIcon
      
      local IconLabel = Instance.new("TextLabel")
      IconLabel.Parent = NotificationIcon
      IconLabel.BackgroundTransparency = 1
      IconLabel.Size = UDim2.new(1, 0, 1, 0)
      IconLabel.Text = IconText
      IconLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
      IconLabel.TextSize = 14
      IconLabel.Font = Enum.Font.GothamBold
      IconLabel.TextScaled = true
      
      local NotificationTitle = Instance.new("TextLabel")
      NotificationTitle.Parent = NotificationFrame
      NotificationTitle.BackgroundTransparency = 1
      NotificationTitle.Size = UDim2.new(1, -85, 0, 20)
      NotificationTitle.Position = UDim2.fromOffset(52, 12)
      NotificationTitle.Text = Title
      NotificationTitle.TextColor3 = Theme.Text
      NotificationTitle.TextSize = 14
      NotificationTitle.Font = Enum.Font.GothamBold
      NotificationTitle.TextXAlignment = Enum.TextXAlignment.Left
      NotificationTitle.TextTruncate = Enum.TextTruncate.AtEnd
      NotificationTitle.TextScaled = true
      
      local NotificationContent = Instance.new("TextLabel")
      NotificationContent.Parent = NotificationFrame
      NotificationContent.BackgroundTransparency = 1
      NotificationContent.Size = UDim2.new(1, -85, 0, 16)
      NotificationContent.Position = UDim2.fromOffset(52, 30)
      NotificationContent.Text = Content
      NotificationContent.TextColor3 = Theme.SubText
      NotificationContent.TextSize = 12
      NotificationContent.Font = Enum.Font.Gotham
      NotificationContent.TextXAlignment = Enum.TextXAlignment.Left
      NotificationContent.TextWrapped = true
      NotificationContent.TextTruncate = Enum.TextTruncate.AtEnd
      NotificationContent.TextScaled = true
      
      if SubContent ~= "" then
          local NotificationSubContent = Instance.new("TextLabel")
          NotificationSubContent.Parent = NotificationFrame
          NotificationSubContent.BackgroundTransparency = 1
          NotificationSubContent.Size = UDim2.new(1, -85, 0, 13)
          NotificationSubContent.Position = UDim2.fromOffset(52, 48)
          NotificationSubContent.Text = SubContent
          NotificationSubContent.TextColor3 = Theme.SubText
          NotificationSubContent.TextSize = 10
          NotificationSubContent.Font = Enum.Font.Gotham
          NotificationSubContent.TextXAlignment = Enum.TextXAlignment.Left
          NotificationSubContent.TextWrapped = true
          NotificationSubContent.TextTruncate = Enum.TextTruncate.AtEnd
          NotificationSubContent.TextTransparency = 0.3
          NotificationSubContent.TextScaled = true
      end
      
      local CloseNotificationButton = Instance.new("TextButton")
      CloseNotificationButton.Parent = NotificationFrame
      CloseNotificationButton.BackgroundColor3 = Theme.Secondary
      CloseNotificationButton.BackgroundTransparency = 0.4
      CloseNotificationButton.Size = UDim2.fromOffset(25, 25)
      CloseNotificationButton.Position = UDim2.new(1, -35, 0, 10)
      CloseNotificationButton.Text = "✕"
      CloseNotificationButton.TextColor3 = Theme.SubText
      CloseNotificationButton.TextSize = 12
      CloseNotificationButton.Font = Enum.Font.GothamBold
      CloseNotificationButton.TextTransparency = 0.4
      
      local CloseNotificationCorner = Instance.new("UICorner")
      CloseNotificationCorner.CornerRadius = UDim.new(0, 8)
      CloseNotificationCorner.Parent = CloseNotificationButton
      
      CloseNotificationButton.MouseEnter:Connect(function()
          CreateTween(CloseNotificationButton, TweenInfo.new(0.15), {
              TextTransparency = 0.1,
              BackgroundTransparency = 0.1,
              TextColor3 = Theme.Error
          }):Play()
      end)
      
      CloseNotificationButton.MouseLeave:Connect(function()
          CreateTween(CloseNotificationButton, TweenInfo.new(0.15), {
              TextTransparency = 0.4,
              BackgroundTransparency = 0.4,
              TextColor3 = Theme.SubText
          }):Play()
      end)
      
      NotificationFrame.Position = UDim2.new(1, 35, 0, 0)
      NotificationFrame.BackgroundTransparency = 1
      NotificationStroke.Transparency = 1
      
      CreateTween(NotificationFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
          BackgroundTransparency = 0.1
      }):Play()
      
      CreateTween(NotificationStroke, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
          Transparency = 0.4
      }):Play()
      
      CreateTween(NotificationFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
          Position = UDim2.new(0, 0, 0, 0)
      }):Play()
      
      local function CloseNotification()
          CreateTween(NotificationFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
              Position = UDim2.new(1, 35, 0, 0),
              BackgroundTransparency = 1
          }):Play()
          
          CreateTween(NotificationStroke, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
              Transparency = 1
          }):Play()
          
          wait(0.25)
          if NotificationFrame.Parent then
              NotificationFrame:Destroy()
          end
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

  local loadingTexts = {
      "Loading Data...",
      "Loading Gui...",
      "Loading Setting...",
      "wait..."
  }
  
  spawn(function()
      for i = 1, #loadingTexts do
          wait(LoadingTime / #loadingTexts)
          WelcomeSubText.Text = loadingTexts[i]
      end
  end)

  wait(LoadingTime)
  
  CreateTween(WelcomeFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
      Size = UDim2.fromOffset(0, 0),
      Position = UDim2.fromScale(0.5, 0.5)
  }):Play()
  
  CreateTween(WelcomeShadow, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
      Size = UDim2.fromOffset(0, 0)
  }):Play()

  wait(0.35)
  WelcomeFrame:Destroy()
  WelcomeShadow:Destroy()
  
  MainFrame.Visible = true
  MainShadow.Visible = true
  MainFrame.Size = UDim2.fromOffset(0, 0)
  MainShadow.Size = UDim2.fromOffset(0, 0)
  
  CreateTween(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
      Size = Size
  }):Play()
  
  CreateTween(MainShadow, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
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
  Window.ShowWindow = ShowWindow
  Window.HideWindow = HideWindow
  
  return Window
end

return FRONT_GUI
