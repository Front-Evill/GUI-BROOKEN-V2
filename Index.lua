local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local FRONT_GUI = {}
FRONT_GUI.__index = FRONT_GUI

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
  local Size = config.Size or UDim2.fromOffset(800, 500)
  local Theme = config.Theme or "Dark"
  local MinimizeKey = config.MinimizeKey or Enum.KeyCode.B
  local IconId = config.Icon or "rbxassetid://73031703958632"

  local ScreenGui = Instance.new("ScreenGui")
  ScreenGui.Name = "FRONT_GUI"
  ScreenGui.Parent = PlayerGui
  ScreenGui.ResetOnSpawn = false
  ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

  local WelcomeFrame = Instance.new("Frame")
  WelcomeFrame.Name = "WelcomeFrame"
  WelcomeFrame.Parent = ScreenGui
  WelcomeFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
  WelcomeFrame.BorderSizePixel = 0
  WelcomeFrame.Size = UDim2.fromScale(0.45, 0.55)
  WelcomeFrame.Position = UDim2.fromScale(0.5, 0.5)
  WelcomeFrame.AnchorPoint = Vector2.new(0.5, 0.5)

  local WelcomeConstraint = Instance.new("UISizeConstraint")
  WelcomeConstraint.MinSize = Vector2.new(400, 350)
  WelcomeConstraint.MaxSize = Vector2.new(600, 450)
  WelcomeConstraint.Parent = WelcomeFrame

  local WelcomeGradient = Instance.new("UIGradient")
  WelcomeGradient.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 45)),
      ColorSequenceKeypoint.new(0.5, Color3.fromRGB(20, 20, 35)),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 25))
  })
  WelcomeGradient.Rotation = 45
  WelcomeGradient.Parent = WelcomeFrame

  local WelcomeCorner = Instance.new("UICorner")
  WelcomeCorner.CornerRadius = UDim.new(0, 20)
  WelcomeCorner.Parent = WelcomeFrame

  local WelcomeStroke = Instance.new("UIStroke")
  WelcomeStroke.Color = Color3.fromRGB(85, 170, 255)
  WelcomeStroke.Thickness = 3
  WelcomeStroke.Transparency = 0.2
  WelcomeStroke.Parent = WelcomeFrame

  local PlayerAvatar = Instance.new("ImageLabel")
  PlayerAvatar.Parent = WelcomeFrame
  PlayerAvatar.BackgroundTransparency = 1
  PlayerAvatar.Size = UDim2.fromOffset(80, 80)
  PlayerAvatar.Position = UDim2.fromScale(0.5, 0.15)
  PlayerAvatar.AnchorPoint = Vector2.new(0.5, 0.5)
  PlayerAvatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. Player.UserId .. "&width=150&height=150&format=png"
  PlayerAvatar.ImageColor3 = Color3.fromRGB(255, 255, 255)

  local AvatarCorner = Instance.new("UICorner")
  AvatarCorner.CornerRadius = UDim.new(1, 0)
  AvatarCorner.Parent = PlayerAvatar

  local AvatarStroke = Instance.new("UIStroke")
  AvatarStroke.Color = Color3.fromRGB(85, 170, 255)
  AvatarStroke.Thickness = 3
  AvatarStroke.Transparency = 0.3
  AvatarStroke.Parent = PlayerAvatar

  local PlayerNameLabel = Instance.new("TextLabel")
  PlayerNameLabel.Parent = WelcomeFrame
  PlayerNameLabel.BackgroundTransparency = 1
  PlayerNameLabel.Size = UDim2.fromScale(0.9, 0.08)
  PlayerNameLabel.Position = UDim2.fromScale(0.5, 0.28)
  PlayerNameLabel.AnchorPoint = Vector2.new(0.5, 0.5)
  PlayerNameLabel.Text = Player.DisplayName
  PlayerNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
  PlayerNameLabel.TextScaled = true
  PlayerNameLabel.Font = Enum.Font.GothamBold

  local PlayerUsernameLabel = Instance.new("TextLabel")
  PlayerUsernameLabel.Parent = WelcomeFrame
  PlayerUsernameLabel.BackgroundTransparency = 1
  PlayerUsernameLabel.Size = UDim2.fromScale(0.9, 0.06)
  PlayerUsernameLabel.Position = UDim2.fromScale(0.5, 0.35)
  PlayerUsernameLabel.AnchorPoint = Vector2.new(0.5, 0.5)
  PlayerUsernameLabel.Text = "@" .. Player.Name
  PlayerUsernameLabel.TextColor3 = Color3.fromRGB(85, 170, 255)
  PlayerUsernameLabel.TextScaled = true
  PlayerUsernameLabel.Font = Enum.Font.Gotham

  local AccountAgeLabel = Instance.new("TextLabel")
  AccountAgeLabel.Parent = WelcomeFrame
  AccountAgeLabel.BackgroundTransparency = 1
  AccountAgeLabel.Size = UDim2.fromScale(0.9, 0.05)
  AccountAgeLabel.Position = UDim2.fromScale(0.5, 0.42)
  AccountAgeLabel.AnchorPoint = Vector2.new(0.5, 0.5)
  AccountAgeLabel.Text = "Account Age: " .. GetAccountAge(Player)
  AccountAgeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
  AccountAgeLabel.TextScaled = true
  AccountAgeLabel.Font = Enum.Font.Gotham

  local WelcomeTitle = Instance.new("TextLabel")
  WelcomeTitle.Parent = WelcomeFrame
  WelcomeTitle.BackgroundTransparency = 1
  WelcomeTitle.Size = UDim2.fromScale(0.9, 0.12)
  WelcomeTitle.Position = UDim2.fromScale(0.5, 0.58)
  WelcomeTitle.AnchorPoint = Vector2.new(0.5, 0.5)
  WelcomeTitle.Text = WelcomeText
  WelcomeTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
  WelcomeTitle.TextScaled = true
  WelcomeTitle.Font = Enum.Font.GothamBold
  WelcomeTitle.TextStrokeTransparency = 0.8
  WelcomeTitle.TextStrokeColor3 = Color3.fromRGB(85, 170, 255)

  local WelcomeSubText = Instance.new("TextLabel")
  WelcomeSubText.Parent = WelcomeFrame
  WelcomeSubText.BackgroundTransparency = 1
  WelcomeSubText.Size = UDim2.fromScale(0.9, 0.08)
  WelcomeSubText.Position = UDim2.fromScale(0.5, 0.72)
  WelcomeSubText.AnchorPoint = Vector2.new(0.5, 0.5)
  WelcomeSubText.Text = "Loading GUI Components..."
  WelcomeSubText.TextColor3 = Color3.fromRGB(200, 200, 200)
  WelcomeSubText.TextScaled = true
  WelcomeSubText.Font = Enum.Font.Gotham

  local LoadingBar = Instance.new("Frame")
  LoadingBar.Parent = WelcomeFrame
  LoadingBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
  LoadingBar.Size = UDim2.fromScale(0.7, 0.04)
  LoadingBar.Position = UDim2.fromScale(0.5, 0.85)
  LoadingBar.AnchorPoint = Vector2.new(0.5, 0.5)

  local LoadingBarCorner = Instance.new("UICorner")
  LoadingBarCorner.CornerRadius = UDim.new(1, 0)
  LoadingBarCorner.Parent = LoadingBar

  local LoadingProgress = Instance.new("Frame")
  LoadingProgress.Parent = LoadingBar
  LoadingProgress.BackgroundColor3 = Color3.fromRGB(85, 170, 255)
  LoadingProgress.Size = UDim2.fromScale(0, 1)
  LoadingProgress.Position = UDim2.fromScale(0, 0)

  local LoadingGradient = Instance.new("UIGradient")
  LoadingGradient.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 170, 255)),
      ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120, 200, 255)),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 180, 255))
  })
  LoadingGradient.Parent = LoadingProgress

  local LoadingProgressCorner = Instance.new("UICorner")
  LoadingProgressCorner.CornerRadius = UDim.new(1, 0)
  LoadingProgressCorner.Parent = LoadingProgress

  local MainFrame = Instance.new("Frame")
  MainFrame.Name = "MainFrame"
  MainFrame.Parent = ScreenGui
  MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
  MainFrame.BackgroundTransparency = 0.25
  MainFrame.BorderSizePixel = 0
  MainFrame.Size = Size
  MainFrame.Position = UDim2.fromScale(0.5, 0.5)
  MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
  MainFrame.Visible = false

  local MainConstraint = Instance.new("UISizeConstraint")
  MainConstraint.MinSize = Vector2.new(400, 300)
  MainConstraint.MaxSize = Vector2.new(2000, 1200)
  MainConstraint.Parent = MainFrame

  local MainGradient = Instance.new("UIGradient")
  MainGradient.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 50)),
      ColorSequenceKeypoint.new(0.5, Color3.fromRGB(25, 25, 40)),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 30))
  })
  MainGradient.Rotation = 45
  MainGradient.Parent = MainFrame

  local MainCorner = Instance.new("UICorner")
  MainCorner.CornerRadius = UDim.new(0, 20)
  MainCorner.Parent = MainFrame

  local MainStroke = Instance.new("UIStroke")
  MainStroke.Color = Color3.fromRGB(85, 170, 255)
  MainStroke.Thickness = 2
  MainStroke.Transparency = 0.3
  MainStroke.Parent = MainFrame

  local TitleBar = Instance.new("Frame")
  TitleBar.Name = "TitleBar"
  TitleBar.Parent = MainFrame
  TitleBar.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
  TitleBar.BackgroundTransparency = 0.15
  TitleBar.BorderSizePixel = 0
  TitleBar.Size = UDim2.new(1, 0, 0, 55)
  TitleBar.Position = UDim2.fromScale(0, 0)

  local TitleBarGradient = Instance.new("UIGradient")
  TitleBarGradient.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 55)),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 38))
  })
  TitleBarGradient.Rotation = 90
  TitleBarGradient.Parent = TitleBar

  local TitleBarCorner = Instance.new("UICorner")
  TitleBarCorner.CornerRadius = UDim.new(0, 20)
  TitleBarCorner.Parent = TitleBar

  local TitleBarBottom = Instance.new("Frame")
  TitleBarBottom.Parent = TitleBar
  TitleBarBottom.BackgroundColor3 = Color3.fromRGB(25, 25, 38)
  TitleBarBottom.BackgroundTransparency = 0.15
  TitleBarBottom.BorderSizePixel = 0
  TitleBarBottom.Size = UDim2.new(1, 0, 0, 20)
  TitleBarBottom.Position = UDim2.new(0, 0, 1, -20)

  local TitleBarLine = Instance.new("Frame")
  TitleBarLine.Parent = TitleBar
  TitleBarLine.BackgroundColor3 = Color3.fromRGB(85, 170, 255)
  TitleBarLine.BorderSizePixel = 0
  TitleBarLine.Size = UDim2.new(1, 0, 0, 3)
  TitleBarLine.Position = UDim2.new(0, 0, 1, 0)
  TitleBarLine.BackgroundTransparency = 0.2

  local TitleIcon = Instance.new("ImageLabel")
  TitleIcon.Parent = TitleBar
  TitleIcon.BackgroundTransparency = 1
  TitleIcon.Size = UDim2.fromOffset(35, 35)
  TitleIcon.Position = UDim2.fromOffset(15, 10)
  TitleIcon.Image = IconId
  TitleIcon.ImageColor3 = Color3.fromRGB(85, 170, 255)

  local TitleLabel = Instance.new("TextLabel")
  TitleLabel.Parent = TitleBar
  TitleLabel.BackgroundTransparency = 1
  TitleLabel.Size = UDim2.fromScale(0.3, 1)
  TitleLabel.Position = UDim2.fromOffset(60, 0)
  TitleLabel.Text = Title
  TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
  TitleLabel.TextScaled = true
  TitleLabel.Font = Enum.Font.GothamBold
  TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

  local SubTitleLabel = Instance.new("TextLabel")
  SubTitleLabel.Parent = TitleBar
  SubTitleLabel.BackgroundTransparency = 1
  SubTitleLabel.Size = UDim2.fromScale(0.25, 1)
  SubTitleLabel.Position = UDim2.fromScale(0.35, 0)
  SubTitleLabel.Text = SubTitle
  SubTitleLabel.TextColor3 = Color3.fromRGB(85, 170, 255)
  SubTitleLabel.TextScaled = true
  SubTitleLabel.Font = Enum.Font.Gotham
  SubTitleLabel.TextXAlignment = Enum.TextXAlignment.Left

  local ButtonsFrame = Instance.new("Frame")
  ButtonsFrame.Parent = TitleBar
  ButtonsFrame.BackgroundTransparency = 1
  ButtonsFrame.Size = UDim2.fromScale(0.25, 0.75)
  ButtonsFrame.Position = UDim2.fromScale(0.75, 0.125)

  local ButtonsLayout = Instance.new("UIListLayout")
  ButtonsLayout.FillDirection = Enum.FillDirection.Horizontal
  ButtonsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
  ButtonsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
  ButtonsLayout.Padding = UDim.new(0, 10)
  ButtonsLayout.Parent = ButtonsFrame

  local MaximizeButton = Instance.new("ImageButton")
  MaximizeButton.Parent = ButtonsFrame
  MaximizeButton.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
  MaximizeButton.BackgroundTransparency = 0.2
  MaximizeButton.BorderSizePixel = 0
  MaximizeButton.Size = UDim2.fromOffset(38, 38)
  MaximizeButton.Image = "rbxassetid://118135004396306"
  MaximizeButton.ImageColor3 = Color3.fromRGB(255, 255, 255)

  local MaximizeCorner = Instance.new("UICorner")
  MaximizeCorner.CornerRadius = UDim.new(0, 10)
  MaximizeCorner.Parent = MaximizeButton

  local MinimizeButton = Instance.new("ImageButton")
  MinimizeButton.Parent = ButtonsFrame
  MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 170, 85)
  MinimizeButton.BackgroundTransparency = 0.2
  MinimizeButton.BorderSizePixel = 0
  MinimizeButton.Size = UDim2.fromOffset(38, 38)
  MinimizeButton.Image = "rbxassetid://109112049975998"
  MinimizeButton.ImageColor3 = Color3.fromRGB(255, 255, 255)

  local MinimizeCorner = Instance.new("UICorner")
  MinimizeCorner.CornerRadius = UDim.new(0, 10)
  MinimizeCorner.Parent = MinimizeButton

  local CloseButton = Instance.new("ImageButton")
  CloseButton.Parent = ButtonsFrame
  CloseButton.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
  CloseButton.BackgroundTransparency = 0.2
  CloseButton.BorderSizePixel = 0
  CloseButton.Size = UDim2.fromOffset(38, 38)
  CloseButton.Image = "rbxassetid://74818383222024"
  CloseButton.ImageColor3 = Color3.fromRGB(255, 255, 255)

  local CloseCorner = Instance.new("UICorner")
  CloseCorner.CornerRadius = UDim.new(0, 10)
  CloseCorner.Parent = CloseButton

  local ContentFrame = Instance.new("Frame")
  ContentFrame.Name = "ContentFrame"
  ContentFrame.Parent = MainFrame
  ContentFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
  ContentFrame.BackgroundTransparency = 0.3
  ContentFrame.Size = UDim2.new(1, -30, 1, -85)
  ContentFrame.Position = UDim2.fromOffset(15, 70)

  local ContentCorner = Instance.new("UICorner")
  ContentCorner.CornerRadius = UDim.new(0, 15)
  ContentCorner.Parent = ContentFrame

  local ContentStroke = Instance.new("UIStroke")
  ContentStroke.Color = Color3.fromRGB(60, 60, 80)
  ContentStroke.Thickness = 1
  ContentStroke.Transparency = 0.6
  ContentStroke.Parent = ContentFrame

  local FloatingIcon = Instance.new("ImageButton")
  FloatingIcon.Name = "FloatingIcon"
  FloatingIcon.Parent = ScreenGui
  FloatingIcon.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
  FloatingIcon.BackgroundTransparency = 0.2
  FloatingIcon.BorderSizePixel = 0
  FloatingIcon.Size = UDim2.fromOffset(65, 65)
  FloatingIcon.Position = UDim2.fromOffset(20, 20)
  FloatingIcon.Image = IconId
  FloatingIcon.ImageColor3 = Color3.fromRGB(85, 170, 255)
  FloatingIcon.Visible = false

  local FloatingGradient = Instance.new("UIGradient")
  FloatingGradient.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 65)),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 45))
  })
  FloatingGradient.Rotation = 45
  FloatingGradient.Parent = FloatingIcon

  local FloatingCorner = Instance.new("UICorner")
  FloatingCorner.CornerRadius = UDim.new(0, 32)
  FloatingCorner.Parent = FloatingIcon

  local FloatingStroke = Instance.new("UIStroke")
  FloatingStroke.Color = Color3.fromRGB(85, 170, 255)
  FloatingStroke.Thickness = 3
  FloatingStroke.Transparency = 0.2
  FloatingStroke.Parent = FloatingIcon

  MakeDraggable(MainFrame, TitleBar)
  MakeDraggable(FloatingIcon, FloatingIcon)

  local isMaximized = false
  local originalSize = Size
  local originalPosition = UDim2.fromScale(0.5, 0.5)

  local function ShowWindow()
      MainFrame.Visible = true
      FloatingIcon.Visible = false
      CreateTween(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
          Size = isMaximized and UDim2.fromScale(0.95, 0.95) or originalSize
      }):Play()
  end

  local function HideWindow()
      CreateTween(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
          Size = UDim2.fromOffset(0, 0)
      }):Play()
      wait(0.5)
      MainFrame.Visible = false
      FloatingIcon.Visible = true
  end

  local function MaximizeWindow()
      isMaximized = not isMaximized
      if isMaximized then
          CreateTween(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
              Size = UDim2.fromScale(0.95, 0.95),
              Position = UDim2.fromScale(0.5, 0.5)
          }):Play()
      else
          CreateTween(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
              Size = originalSize,
              Position = originalPosition
          }):Play()
      end
  end

  CloseButton.MouseButton1Click:Connect(function()
      CreateTween(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
          Size = UDim2.fromOffset(0, 0)
      }):Play()
      wait(0.4)
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
  
  CreateTween(WelcomeFrame, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
      Size = UDim2.fromOffset(0, 0),
      Position = UDim2.fromScale(0.5, 0.5)
  }):Play()

  wait(0.7)
  WelcomeFrame:Destroy()
  MainFrame.Visible = true
  MainFrame.Size = UDim2.fromOffset(0, 0)
  CreateTween(MainFrame, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
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
