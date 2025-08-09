local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local FRONT_GUI = {}
FRONT_GUI.__index = FRONT_GUI

local Themes = {
   Dark = {
       Primary = Color3.fromRGB(30, 30, 35),
       Secondary = Color3.fromRGB(40, 40, 45),
       Accent = Color3.fromRGB(70, 130, 180),
       Text = Color3.fromRGB(255, 255, 255),
       SubText = Color3.fromRGB(160, 160, 160),
       Border = Color3.fromRGB(60, 60, 65)
   },
   Light = {
       Primary = Color3.fromRGB(245, 245, 250),
       Secondary = Color3.fromRGB(235, 235, 240),
       Accent = Color3.fromRGB(70, 130, 180),
       Text = Color3.fromRGB(45, 45, 50),
       SubText = Color3.fromRGB(120, 120, 125),
       Border = Color3.fromRGB(200, 200, 205)
   },
   Purple = {
       Primary = Color3.fromRGB(35, 25, 50),
       Secondary = Color3.fromRGB(45, 35, 60),
       Accent = Color3.fromRGB(138, 43, 226),
       Text = Color3.fromRGB(255, 255, 255),
       SubText = Color3.fromRGB(180, 160, 200),
       Border = Color3.fromRGB(80, 60, 100)
   },
   Pink = {
       Primary = Color3.fromRGB(50, 25, 40),
       Secondary = Color3.fromRGB(60, 35, 50),
       Accent = Color3.fromRGB(255, 105, 180),
       Text = Color3.fromRGB(255, 255, 255),
       SubText = Color3.fromRGB(200, 160, 180),
       Border = Color3.fromRGB(100, 60, 80)
   },
   Gray = {
       Primary = Color3.fromRGB(50, 50, 55),
       Secondary = Color3.fromRGB(60, 60, 65),
       Accent = Color3.fromRGB(100, 150, 200),
       Text = Color3.fromRGB(255, 255, 255),
       SubText = Color3.fromRGB(180, 180, 185),
       Border = Color3.fromRGB(80, 80, 85)
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
  local LoadingTime = config.LoadingTime or 3
  local Size = config.Size or UDim2.fromOffset(650, 420)
  local ThemeName = config.Theme or "Dark"
  local MinimizeKey = config.MinimizeKey or Enum.KeyCode.B
  local IconId = config.Icon or "rbxassetid://73031703958632"
  
  local Theme = Themes[ThemeName] or Themes.Dark

  local ScreenGui = Instance.new("ScreenGui")
  ScreenGui.Name = "FRONT_GUI"
  ScreenGui.Parent = PlayerGui
  ScreenGui.ResetOnSpawn = false
  ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

  local WelcomeFrame = Instance.new("Frame")
  WelcomeFrame.Name = "WelcomeFrame"
  WelcomeFrame.Parent = ScreenGui
  WelcomeFrame.BackgroundColor3 = Theme.Primary
  WelcomeFrame.BorderSizePixel = 0
  WelcomeFrame.Size = UDim2.fromScale(0.35, 0.45)
  WelcomeFrame.Position = UDim2.fromScale(0.5, 0.5)
  WelcomeFrame.AnchorPoint = Vector2.new(0.5, 0.5)

  local WelcomeConstraint = Instance.new("UISizeConstraint")
  WelcomeConstraint.MinSize = Vector2.new(320, 280)
  WelcomeConstraint.MaxSize = Vector2.new(450, 380)
  WelcomeConstraint.Parent = WelcomeFrame

  local WelcomeCorner = Instance.new("UICorner")
  WelcomeCorner.CornerRadius = UDim.new(0, 12)
  WelcomeCorner.Parent = WelcomeFrame

  local WelcomeStroke = Instance.new("UIStroke")
  WelcomeStroke.Color = Theme.Border
  WelcomeStroke.Thickness = 1
  WelcomeStroke.Parent = WelcomeFrame

  local PlayerAvatar = Instance.new("ImageLabel")
  PlayerAvatar.Parent = WelcomeFrame
  PlayerAvatar.BackgroundTransparency = 1
  PlayerAvatar.Size = UDim2.fromOffset(60, 60)
  PlayerAvatar.Position = UDim2.fromScale(0.5, 0.18)
  PlayerAvatar.AnchorPoint = Vector2.new(0.5, 0.5)
  PlayerAvatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. Player.UserId .. "&width=150&height=150&format=png"

  local AvatarCorner = Instance.new("UICorner")
  AvatarCorner.CornerRadius = UDim.new(1, 0)
  AvatarCorner.Parent = PlayerAvatar

  local AvatarStroke = Instance.new("UIStroke")
  AvatarStroke.Color = Theme.Accent
  AvatarStroke.Thickness = 2
  AvatarStroke.Parent = PlayerAvatar

  local PlayerNameLabel = Instance.new("TextLabel")
  PlayerNameLabel.Parent = WelcomeFrame
  PlayerNameLabel.BackgroundTransparency = 1
  PlayerNameLabel.Size = UDim2.fromScale(0.85, 0.08)
  PlayerNameLabel.Position = UDim2.fromScale(0.5, 0.32)
  PlayerNameLabel.AnchorPoint = Vector2.new(0.5, 0.5)
  PlayerNameLabel.Text = Player.DisplayName
  PlayerNameLabel.TextColor3 = Theme.Text
  PlayerNameLabel.TextSize = 16
  PlayerNameLabel.Font = Enum.Font.GothamMedium

  local PlayerUsernameLabel = Instance.new("TextLabel")
  PlayerUsernameLabel.Parent = WelcomeFrame
  PlayerUsernameLabel.BackgroundTransparency = 1
  PlayerUsernameLabel.Size = UDim2.fromScale(0.85, 0.06)
  PlayerUsernameLabel.Position = UDim2.fromScale(0.5, 0.4)
  PlayerUsernameLabel.AnchorPoint = Vector2.new(0.5, 0.5)
  PlayerUsernameLabel.Text = "@" .. Player.Name
  PlayerUsernameLabel.TextColor3 = Theme.Accent
  PlayerUsernameLabel.TextSize = 12
  PlayerUsernameLabel.Font = Enum.Font.Gotham

  local AccountAgeLabel = Instance.new("TextLabel")
  AccountAgeLabel.Parent = WelcomeFrame
  AccountAgeLabel.BackgroundTransparency = 1
  AccountAgeLabel.Size = UDim2.fromScale(0.85, 0.05)
  AccountAgeLabel.Position = UDim2.fromScale(0.5, 0.47)
  AccountAgeLabel.AnchorPoint = Vector2.new(0.5, 0.5)
  AccountAgeLabel.Text = "Account Age: " .. GetAccountAge(Player)
  AccountAgeLabel.TextColor3 = Theme.SubText
  AccountAgeLabel.TextSize = 10
  AccountAgeLabel.Font = Enum.Font.Gotham

  local WelcomeTitle = Instance.new("TextLabel")
  WelcomeTitle.Parent = WelcomeFrame
  WelcomeTitle.BackgroundTransparency = 1
  WelcomeTitle.Size = UDim2.fromScale(0.85, 0.1)
  WelcomeTitle.Position = UDim2.fromScale(0.5, 0.6)
  WelcomeTitle.AnchorPoint = Vector2.new(0.5, 0.5)
  WelcomeTitle.Text = WelcomeText
  WelcomeTitle.TextColor3 = Theme.Text
  WelcomeTitle.TextSize = 18
  WelcomeTitle.Font = Enum.Font.GothamBold

  local WelcomeSubText = Instance.new("TextLabel")
  WelcomeSubText.Parent = WelcomeFrame
  WelcomeSubText.BackgroundTransparency = 1
  WelcomeSubText.Size = UDim2.fromScale(0.85, 0.06)
  WelcomeSubText.Position = UDim2.fromScale(0.5, 0.72)
  WelcomeSubText.AnchorPoint = Vector2.new(0.5, 0.5)
  WelcomeSubText.Text = "Loading GUI Components..."
  WelcomeSubText.TextColor3 = Theme.SubText
  WelcomeSubText.TextSize = 12
  WelcomeSubText.Font = Enum.Font.Gotham

  local LoadingBar = Instance.new("Frame")
  LoadingBar.Parent = WelcomeFrame
  LoadingBar.BackgroundColor3 = Theme.Secondary
  LoadingBar.Size = UDim2.fromScale(0.6, 0.025)
  LoadingBar.Position = UDim2.fromScale(0.5, 0.83)
  LoadingBar.AnchorPoint = Vector2.new(0.5, 0.5)

  local LoadingBarCorner = Instance.new("UICorner")
  LoadingBarCorner.CornerRadius = UDim.new(1, 0)
  LoadingBarCorner.Parent = LoadingBar

  local LoadingProgress = Instance.new("Frame")
  LoadingProgress.Parent = LoadingBar
  LoadingProgress.BackgroundColor3 = Theme.Accent
  LoadingProgress.Size = UDim2.fromScale(0, 1)
  LoadingProgress.Position = UDim2.fromScale(0, 0)

  local LoadingProgressCorner = Instance.new("UICorner")
  LoadingProgressCorner.CornerRadius = UDim.new(1, 0)
  LoadingProgressCorner.Parent = LoadingProgress

  local MainFrame = Instance.new("Frame")
  MainFrame.Name = "MainFrame"
  MainFrame.Parent = ScreenGui
  MainFrame.BackgroundColor3 = Theme.Primary
  MainFrame.BorderSizePixel = 0
  MainFrame.Size = Size
  MainFrame.Position = UDim2.fromScale(0.5, 0.5)
  MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
  MainFrame.Visible = false

  local MainConstraint = Instance.new("UISizeConstraint")
  MainConstraint.MinSize = Vector2.new(350, 250)
  MainConstraint.MaxSize = Vector2.new(1400, 900)
  MainConstraint.Parent = MainFrame

  local MainCorner = Instance.new("UICorner")
  MainCorner.CornerRadius = UDim.new(0, 12)
  MainCorner.Parent = MainFrame

  local MainStroke = Instance.new("UIStroke")
  MainStroke.Color = Theme.Border
  MainStroke.Thickness = 1
  MainStroke.Parent = MainFrame

  local TitleBar = Instance.new("Frame")
  TitleBar.Name = "TitleBar"
  TitleBar.Parent = MainFrame
  TitleBar.BackgroundColor3 = Theme.Secondary
  TitleBar.BorderSizePixel = 0
  TitleBar.Size = UDim2.new(1, 0, 0, 40)
  TitleBar.Position = UDim2.fromScale(0, 0)

  local TitleBarCorner = Instance.new("UICorner")
  TitleBarCorner.CornerRadius = UDim.new(0, 12)
  TitleBarCorner.Parent = TitleBar

  local TitleBarBottom = Instance.new("Frame")
  TitleBarBottom.Parent = TitleBar
  TitleBarBottom.BackgroundColor3 = Theme.Secondary
  TitleBarBottom.BorderSizePixel = 0
  TitleBarBottom.Size = UDim2.new(1, 0, 0, 12)
  TitleBarBottom.Position = UDim2.new(0, 0, 1, -12)

  local TitleBarLine = Instance.new("Frame")
  TitleBarLine.Parent = TitleBar
  TitleBarLine.BackgroundColor3 = Theme.Border
  TitleBarLine.BorderSizePixel = 0
  TitleBarLine.Size = UDim2.new(1, 0, 0, 1)
  TitleBarLine.Position = UDim2.new(0, 0, 1, 0)

  local TitleIcon = Instance.new("ImageLabel")
  TitleIcon.Parent = TitleBar
  TitleIcon.BackgroundTransparency = 1
  TitleIcon.Size = UDim2.fromOffset(22, 22)
  TitleIcon.Position = UDim2.fromOffset(12, 9)
  TitleIcon.Image = IconId
  TitleIcon.ImageColor3 = Theme.Accent

  local TitleLabel = Instance.new("TextLabel")
  TitleLabel.Parent = TitleBar
  TitleLabel.BackgroundTransparency = 1
  TitleLabel.Size = UDim2.new(0, 150, 1, 0)
  TitleLabel.Position = UDim2.fromOffset(40, 0)
  TitleLabel.Text = Title
  TitleLabel.TextColor3 = Theme.Text
  TitleLabel.TextSize = 14
  TitleLabel.Font = Enum.Font.GothamMedium
  TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

  local SubTitleLabel = Instance.new("TextLabel")
  SubTitleLabel.Parent = TitleBar
  SubTitleLabel.BackgroundTransparency = 1
  SubTitleLabel.Size = UDim2.new(0, 120, 1, 0)
  SubTitleLabel.Position = UDim2.fromOffset(200, 0)
  SubTitleLabel.Text = SubTitle
  SubTitleLabel.TextColor3 = Theme.SubText
  SubTitleLabel.TextSize = 11
  SubTitleLabel.Font = Enum.Font.Gotham
  SubTitleLabel.TextXAlignment = Enum.TextXAlignment.Left

  local ButtonsFrame = Instance.new("Frame")
  ButtonsFrame.Parent = TitleBar
  ButtonsFrame.BackgroundTransparency = 1
  ButtonsFrame.Size = UDim2.new(0, 90, 1, -10)
  ButtonsFrame.Position = UDim2.new(1, -95, 0, 5)

  local ButtonsLayout = Instance.new("UIListLayout")
  ButtonsLayout.FillDirection = Enum.FillDirection.Horizontal
  ButtonsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
  ButtonsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
  ButtonsLayout.Padding = UDim.new(0, 4)
  ButtonsLayout.Parent = ButtonsFrame

  local MaximizeButton = Instance.new("ImageButton")
  MaximizeButton.Parent = ButtonsFrame
  MaximizeButton.BackgroundTransparency = 1
  MaximizeButton.BorderSizePixel = 0
  MaximizeButton.Size = UDim2.fromOffset(28, 28)
  MaximizeButton.Image = "rbxassetid://118135004396306"
  MaximizeButton.ImageColor3 = Theme.SubText

  local MaximizeCorner = Instance.new("UICorner")
  MaximizeCorner.CornerRadius = UDim.new(0, 6)
  MaximizeCorner.Parent = MaximizeButton

  local MinimizeButton = Instance.new("ImageButton")
  MinimizeButton.Parent = ButtonsFrame
  MinimizeButton.BackgroundTransparency = 1
  MinimizeButton.BorderSizePixel = 0
  MinimizeButton.Size = UDim2.fromOffset(28, 28)
  MinimizeButton.Image = "rbxassetid://109112049975998"
  MinimizeButton.ImageColor3 = Theme.SubText

  local MinimizeCorner = Instance.new("UICorner")
  MinimizeCorner.CornerRadius = UDim.new(0, 6)
  MinimizeCorner.Parent = MinimizeButton

  local CloseButton = Instance.new("ImageButton")
  CloseButton.Parent = ButtonsFrame
  CloseButton.BackgroundTransparency = 1
  CloseButton.BorderSizePixel = 0
  CloseButton.Size = UDim2.fromOffset(28, 28)
  CloseButton.Image = "rbxassetid://74818383222024"
  CloseButton.ImageColor3 = Theme.SubText

  local CloseCorner = Instance.new("UICorner")
  CloseCorner.CornerRadius = UDim.new(0, 6)
  CloseCorner.Parent = CloseButton

  local ContentFrame = Instance.new("Frame")
  ContentFrame.Name = "ContentFrame"
  ContentFrame.Parent = MainFrame
  ContentFrame.BackgroundTransparency = 1
  ContentFrame.Size = UDim2.new(1, -16, 1, -56)
  ContentFrame.Position = UDim2.fromOffset(8, 48)

  local FloatingIcon = Instance.new("ImageButton")
  FloatingIcon.Name = "FloatingIcon"
  FloatingIcon.Parent = ScreenGui
  FloatingIcon.BackgroundColor3 = Theme.Primary
  FloatingIcon.BorderSizePixel = 0
  FloatingIcon.Size = UDim2.fromOffset(50, 50)
  FloatingIcon.Position = UDim2.fromOffset(20, 20)
  FloatingIcon.Image = IconId
  FloatingIcon.ImageColor3 = Theme.Accent
  FloatingIcon.Visible = false

  local FloatingCorner = Instance.new("UICorner")
  FloatingCorner.CornerRadius = UDim.new(0, 25)
  FloatingCorner.Parent = FloatingIcon

  local FloatingStroke = Instance.new("UIStroke")
  FloatingStroke.Color = Theme.Border
  FloatingStroke.Thickness = 1
  FloatingStroke.Parent = FloatingIcon

  MakeDraggable(MainFrame, TitleBar)
  MakeDraggable(FloatingIcon, FloatingIcon)

  local isMaximized = false
  local originalSize = Size
  local originalPosition = UDim2.fromScale(0.5, 0.5)

  local function ShowWindow()
      MainFrame.Visible = true
      FloatingIcon.Visible = false
      CreateTween(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
          Size = isMaximized and UDim2.fromScale(0.9, 0.9) or originalSize
      }):Play()
  end

  local function HideWindow()
      CreateTween(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
          Size = UDim2.fromOffset(0, 0)
      }):Play()
      wait(0.3)
      MainFrame.Visible = false
      FloatingIcon.Visible = true
  end

  local function MaximizeWindow()
      isMaximized = not isMaximized
      if isMaximized then
          CreateTween(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
              Size = UDim2.fromScale(0.9, 0.9),
              Position = UDim2.fromScale(0.5, 0.5)
          }):Play()
      else
          CreateTween(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
              Size = originalSize,
              Position = originalPosition
          }):Play()
      end
  end

  MaximizeButton.MouseEnter:Connect(function()
      CreateTween(MaximizeButton, TweenInfo.new(0.1), {ImageColor3 = Theme.Accent}):Play()
  end)
  
  MaximizeButton.MouseLeave:Connect(function()
      CreateTween(MaximizeButton, TweenInfo.new(0.1), {ImageColor3 = Theme.SubText}):Play()
  end)

  MinimizeButton.MouseEnter:Connect(function()
      CreateTween(MinimizeButton, TweenInfo.new(0.1), {ImageColor3 = Theme.Accent}):Play()
  end)
  
  MinimizeButton.MouseLeave:Connect(function()
      CreateTween(MinimizeButton, TweenInfo.new(0.1), {ImageColor3 = Theme.SubText}):Play()
  end)

  CloseButton.MouseEnter:Connect(function()
      CreateTween(CloseButton, TweenInfo.new(0.1), {ImageColor3 = Color3.fromRGB(255, 85, 85)}):Play()
  end)
  
  CloseButton.MouseLeave:Connect(function()
      CreateTween(CloseButton, TweenInfo.new(0.1), {ImageColor3 = Theme.SubText}):Play()
  end)

  CloseButton.MouseButton1Click:Connect(function()
      CreateTween(MainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
          Size = UDim2.fromOffset(0, 0)
      }):Play()
      wait(0.2)
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
  CreateTween(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
      Size = Size
  }):Play()

  Window.MainFrame = MainFrame
  Window.ContentFrame = ContentFrame
  Window.ScreenGui = ScreenGui
  Window.CloseButton = CloseButton
  Window.MinimizeButton = MinimizeButton
  Window.MaximizeButton = MaximizeButton
  
  return Window
end

return FRONT_GUI
