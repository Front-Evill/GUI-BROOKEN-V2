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
        Primary = Color3.fromRGB(25, 25, 30),
        Secondary = Color3.fromRGB(35, 35, 40),
        Tertiary = Color3.fromRGB(45, 45, 50),
        Accent = Color3.fromRGB(88, 166, 255),
        Success = Color3.fromRGB(46, 204, 113),
        Warning = Color3.fromRGB(241, 196, 15),
        Error = Color3.fromRGB(231, 76, 60),
        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(170, 170, 175),
        Border = Color3.fromRGB(55, 55, 60)
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
    Pink = {
        Primary = Color3.fromRGB(45, 20, 35),
        Secondary = Color3.fromRGB(55, 30, 45),
        Tertiary = Color3.fromRGB(65, 40, 55),
        Accent = Color3.fromRGB(236, 72, 153),
        Success = Color3.fromRGB(34, 197, 94),
        Warning = Color3.fromRGB(245, 158, 11),
        Error = Color3.fromRGB(239, 68, 68),
        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(251, 207, 232),
        Border = Color3.fromRGB(95, 55, 80)
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
    local Size = config.Size or UDim2.fromOffset(700, 450)
    local ThemeName = config.Theme or "Dark"
    local MinimizeKey = config.MinimizeKey or Enum.KeyCode.B
    local IconId = config.Icon or "rbxassetid://73031703958632"
    
    local Theme = Themes[ThemeName] or Themes.Dark

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "FRONT_GUI"
    ScreenGui.Parent = PlayerGui
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- Notification Container
    local NotificationContainer = Instance.new("Frame")
    NotificationContainer.Name = "NotificationContainer"
    NotificationContainer.Parent = ScreenGui
    NotificationContainer.BackgroundTransparency = 1
    NotificationContainer.Size = UDim2.new(0, 350, 1, -20)
    NotificationContainer.Position = UDim2.new(1, -360, 0, 10)
    NotificationContainer.ZIndex = 1000

    local NotificationLayout = Instance.new("UIListLayout")
    NotificationLayout.Parent = NotificationContainer
    NotificationLayout.FillDirection = Enum.FillDirection.Vertical
    NotificationLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    NotificationLayout.VerticalAlignment = Enum.VerticalAlignment.Top
    NotificationLayout.Padding = UDim.new(0, 8)
    NotificationLayout.SortOrder = Enum.SortOrder.LayoutOrder

    -- Welcome Frame
    local WelcomeFrame = Instance.new("Frame")
    WelcomeFrame.Name = "WelcomeFrame"
    WelcomeFrame.Parent = ScreenGui
    WelcomeFrame.BackgroundColor3 = Theme.Primary
    WelcomeFrame.BorderSizePixel = 0
    WelcomeFrame.Size = UDim2.fromScale(0.35, 0.48)
    WelcomeFrame.Position = UDim2.fromScale(0.5, 0.5)
    WelcomeFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    WelcomeFrame.ZIndex = 100

    local WelcomeConstraint = Instance.new("UISizeConstraint")
    WelcomeConstraint.MinSize = Vector2.new(340, 300)
    WelcomeConstraint.MaxSize = Vector2.new(480, 400)
    WelcomeConstraint.Parent = WelcomeFrame

    local WelcomeCorner = Instance.new("UICorner")
    WelcomeCorner.CornerRadius = UDim.new(0, 16)
    WelcomeCorner.Parent = WelcomeFrame

    local WelcomeStroke = Instance.new("UIStroke")
    WelcomeStroke.Color = Theme.Border
    WelcomeStroke.Thickness = 1
    WelcomeStroke.Parent = WelcomeFrame

    -- Drop Shadow Effect
    local WelcomeShadow = Instance.new("Frame")
    WelcomeShadow.Name = "Shadow"
    WelcomeShadow.Parent = WelcomeFrame
    WelcomeShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    WelcomeShadow.BackgroundTransparency = 0.7
    WelcomeShadow.Size = UDim2.new(1, 8, 1, 8)
    WelcomeShadow.Position = UDim2.new(0, 4, 0, 4)
    WelcomeShadow.ZIndex = -1

    local ShadowCorner = Instance.new("UICorner")
    ShadowCorner.CornerRadius = UDim.new(0, 16)
    ShadowCorner.Parent = WelcomeShadow

    local PlayerAvatar = Instance.new("ImageLabel")
    PlayerAvatar.Parent = WelcomeFrame
    PlayerAvatar.BackgroundTransparency = 1
    PlayerAvatar.Size = UDim2.fromOffset(70, 70)
    PlayerAvatar.Position = UDim2.fromScale(0.5, 0.2)
    PlayerAvatar.AnchorPoint = Vector2.new(0.5, 0.5)
    PlayerAvatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. Player.UserId .. "&width=150&height=150&format=png"

    local AvatarCorner = Instance.new("UICorner")
    AvatarCorner.CornerRadius = UDim.new(1, 0)
    AvatarCorner.Parent = PlayerAvatar

    local AvatarStroke = Instance.new("UIStroke")
    AvatarStroke.Color = Theme.Accent
    AvatarStroke.Thickness = 3
    AvatarStroke.Parent = PlayerAvatar

    local PlayerNameLabel = Instance.new("TextLabel")
    PlayerNameLabel.Parent = WelcomeFrame
    PlayerNameLabel.BackgroundTransparency = 1
    PlayerNameLabel.Size = UDim2.fromScale(0.85, 0.08)
    PlayerNameLabel.Position = UDim2.fromScale(0.5, 0.35)
    PlayerNameLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    PlayerNameLabel.Text = Player.DisplayName
    PlayerNameLabel.TextColor3 = Theme.Text
    PlayerNameLabel.TextSize = 18
    PlayerNameLabel.Font = Enum.Font.GothamBold

    local PlayerUsernameLabel = Instance.new("TextLabel")
    PlayerUsernameLabel.Parent = WelcomeFrame
    PlayerUsernameLabel.BackgroundTransparency = 1
    PlayerUsernameLabel.Size = UDim2.fromScale(0.85, 0.06)
    PlayerUsernameLabel.Position = UDim2.fromScale(0.5, 0.43)
    PlayerUsernameLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    PlayerUsernameLabel.Text = "@" .. Player.Name
    PlayerUsernameLabel.TextColor3 = Theme.Accent
    PlayerUsernameLabel.TextSize = 13
    PlayerUsernameLabel.Font = Enum.Font.GothamMedium

    local AccountAgeLabel = Instance.new("TextLabel")
    AccountAgeLabel.Parent = WelcomeFrame
    AccountAgeLabel.BackgroundTransparency = 1
    AccountAgeLabel.Size = UDim2.fromScale(0.85, 0.05)
    AccountAgeLabel.Position = UDim2.fromScale(0.5, 0.5)
    AccountAgeLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    AccountAgeLabel.Text = "Account Age: " .. GetAccountAge(Player)
    AccountAgeLabel.TextColor3 = Theme.SubText
    AccountAgeLabel.TextSize = 11
    AccountAgeLabel.Font = Enum.Font.Gotham

    local WelcomeTitle = Instance.new("TextLabel")
    WelcomeTitle.Parent = WelcomeFrame
    WelcomeTitle.BackgroundTransparency = 1
    WelcomeTitle.Size = UDim2.fromScale(0.85, 0.1)
    WelcomeTitle.Position = UDim2.fromScale(0.5, 0.63)
    WelcomeTitle.AnchorPoint = Vector2.new(0.5, 0.5)
    WelcomeTitle.Text = WelcomeText
    WelcomeTitle.TextColor3 = Theme.Text
    WelcomeTitle.TextSize = 20
    WelcomeTitle.Font = Enum.Font.GothamBold

    local WelcomeSubText = Instance.new("TextLabel")
    WelcomeSubText.Parent = WelcomeFrame
    WelcomeSubText.BackgroundTransparency = 1
    WelcomeSubText.Size = UDim2.fromScale(0.85, 0.06)
    WelcomeSubText.Position = UDim2.fromScale(0.5, 0.74)
    WelcomeSubText.AnchorPoint = Vector2.new(0.5, 0.5)
    WelcomeSubText.Text = "Loading GUI Components..."
    WelcomeSubText.TextColor3 = Theme.SubText
    WelcomeSubText.TextSize = 12
    WelcomeSubText.Font = Enum.Font.Gotham

    local LoadingBar = Instance.new("Frame")
    LoadingBar.Parent = WelcomeFrame
    LoadingBar.BackgroundColor3 = Theme.Secondary
    LoadingBar.Size = UDim2.fromScale(0.65, 0.03)
    LoadingBar.Position = UDim2.fromScale(0.5, 0.85)
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

    -- Main Frame
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
    MainConstraint.MinSize = Vector2.new(400, 300)
    MainConstraint.MaxSize = Vector2.new(1400, 900)
    MainConstraint.Parent = MainFrame

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 16)
    MainCorner.Parent = MainFrame

    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Theme.Border
    MainStroke.Thickness = 1
    MainStroke.Parent = MainFrame

    -- Main Frame Shadow
    local MainShadow = Instance.new("Frame")
    MainShadow.Name = "Shadow"
    MainShadow.Parent = MainFrame
    MainShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MainShadow.BackgroundTransparency = 0.8
    MainShadow.Size = UDim2.new(1, 12, 1, 12)
    MainShadow.Position = UDim2.new(0, 6, 0, 6)
    MainShadow.ZIndex = -1

    local MainShadowCorner = Instance.new("UICorner")
    MainShadowCorner.CornerRadius = UDim.new(0, 16)
    MainShadowCorner.Parent = MainShadow

    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Parent = MainFrame
    TitleBar.BackgroundColor3 = Theme.Secondary
    TitleBar.BorderSizePixel = 0
    TitleBar.Size = UDim2.new(1, 0, 0, 45)
    TitleBar.Position = UDim2.fromScale(0, 0)

    local TitleBarCorner = Instance.new("UICorner")
    TitleBarCorner.CornerRadius = UDim.new(0, 16)
    TitleBarCorner.Parent = TitleBar

    local TitleBarBottom = Instance.new("Frame")
    TitleBarBottom.Parent = TitleBar
    TitleBarBottom.BackgroundColor3 = Theme.Secondary
    TitleBarBottom.BorderSizePixel = 0
    TitleBarBottom.Size = UDim2.new(1, 0, 0, 16)
    TitleBarBottom.Position = UDim2.new(0, 0, 1, -16)

    local TitleBarLine = Instance.new("Frame")
    TitleBarLine.Parent = TitleBar
    TitleBarLine.BackgroundColor3 = Theme.Border
    TitleBarLine.BorderSizePixel = 0
    TitleBarLine.Size = UDim2.new(1, -20, 0, 1)
    TitleBarLine.Position = UDim2.new(0, 10, 1, 0)

    local TitleIcon = Instance.new("ImageLabel")
    TitleIcon.Parent = TitleBar
    TitleIcon.BackgroundTransparency = 1
    TitleIcon.Size = UDim2.fromOffset(24, 24)
    TitleIcon.Position = UDim2.fromOffset(15, 10)
    TitleIcon.Image = IconId
    TitleIcon.ImageColor3 = Theme.Accent

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Parent = TitleBar
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Size = UDim2.new(0, 160, 1, 0)
    TitleLabel.Position = UDim2.fromOffset(45, 0)
    TitleLabel.Text = Title
    TitleLabel.TextColor3 = Theme.Text
    TitleLabel.TextSize = 15
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local SubTitleLabel = Instance.new("TextLabel")
    SubTitleLabel.Parent = TitleBar
    SubTitleLabel.BackgroundTransparency = 1
    SubTitleLabel.Size = UDim2.new(0, 130, 1, 0)
    SubTitleLabel.Position = UDim2.fromOffset(210, 0)
    SubTitleLabel.Text = SubTitle
    SubTitleLabel.TextColor3 = Theme.SubText
    SubTitleLabel.TextSize = 12
    SubTitleLabel.Font = Enum.Font.Gotham
    SubTitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local ButtonsFrame = Instance.new("Frame")
    ButtonsFrame.Parent = TitleBar
    ButtonsFrame.BackgroundTransparency = 1
    ButtonsFrame.Size = UDim2.new(0, 95, 1, -10)
    ButtonsFrame.Position = UDim2.new(1, -100, 0, 5)

    local ButtonsLayout = Instance.new("UIListLayout")
    ButtonsLayout.FillDirection = Enum.FillDirection.Horizontal
    ButtonsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    ButtonsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    ButtonsLayout.Padding = UDim.new(0, 5)
    ButtonsLayout.Parent = ButtonsFrame

    local MaximizeButton = Instance.new("ImageButton")
    MaximizeButton.Parent = ButtonsFrame
    MaximizeButton.BackgroundColor3 = Theme.Secondary
    MaximizeButton.BorderSizePixel = 0
    MaximizeButton.Size = UDim2.fromOffset(30, 30)
    MaximizeButton.Image = "rbxassetid://118135004396306"
    MaximizeButton.ImageColor3 = Theme.SubText

    local MaximizeCorner = Instance.new("UICorner")
    MaximizeCorner.CornerRadius = UDim.new(0, 8)
    MaximizeCorner.Parent = MaximizeButton

    local MinimizeButton = Instance.new("ImageButton")
    MinimizeButton.Parent = ButtonsFrame
    MinimizeButton.BackgroundColor3 = Theme.Secondary
    MinimizeButton.BorderSizePixel = 0
    MinimizeButton.Size = UDim2.fromOffset(30, 30)
    MinimizeButton.Image = "rbxassetid://109112049975998"
    MinimizeButton.ImageColor3 = Theme.SubText

    local MinimizeCorner = Instance.new("UICorner")
    MinimizeCorner.CornerRadius = UDim.new(0, 8)
    MinimizeCorner.Parent = MinimizeButton

    local CloseButton = Instance.new("ImageButton")
    CloseButton.Parent = ButtonsFrame
    CloseButton.BackgroundColor3 = Theme.Secondary
    CloseButton.BorderSizePixel = 0
    CloseButton.Size = UDim2.fromOffset(30, 30)
    CloseButton.Image = "rbxassetid://74818383222024"
    CloseButton.ImageColor3 = Theme.SubText

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 8)
    CloseCorner.Parent = CloseButton

    local ContentFrame = Instance.new("Frame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Parent = MainFrame
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Size = UDim2.new(1, -20, 1, -65)
    ContentFrame.Position = UDim2.fromOffset(10, 55)

    local FloatingIcon = Instance.new("ImageButton")
    FloatingIcon.Name = "FloatingIcon"
    FloatingIcon.Parent = ScreenGui
    FloatingIcon.BackgroundColor3 = Theme.Primary
    FloatingIcon.BorderSizePixel = 0
    FloatingIcon.Size = UDim2.fromOffset(55, 55)
    FloatingIcon.Position = UDim2.fromOffset(20, 20)
    FloatingIcon.Image = IconId
    FloatingIcon.ImageColor3 = Theme.Accent
    FloatingIcon.Visible = false

    local FloatingCorner = Instance.new("UICorner")
    FloatingCorner.CornerRadius = UDim.new(1, 0)
    FloatingCorner.Parent = FloatingIcon

    local FloatingStroke = Instance.new("UIStroke")
    FloatingStroke.Color = Theme.Border
    FloatingStroke.Thickness = 2
    FloatingStroke.Parent = FloatingIcon

    -- Floating Icon Shadow
    local FloatingShadow = Instance.new("Frame")
    FloatingShadow.Name = "Shadow"
    FloatingShadow.Parent = FloatingIcon
    FloatingShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    FloatingShadow.BackgroundTransparency = 0.7
    FloatingShadow.Size = UDim2.new(1, 8, 1, 8)
    FloatingShadow.Position = UDim2.new(0, 4, 0, 4)
    FloatingShadow.ZIndex = -1

    local FloatingShadowCorner = Instance.new("UICorner")
    FloatingShadowCorner.CornerRadius = UDim.new(1, 0)
    FloatingShadowCorner.Parent = FloatingShadow

    MakeDraggable(MainFrame, TitleBar)
    MakeDraggable(FloatingIcon, FloatingIcon)

    local isMaximized = false
    local originalSize = Size
    local originalPosition = UDim2.fromScale(0.5, 0.5)

    local function ShowWindow()
        MainFrame.Visible = true
        FloatingIcon.Visible = false
        CreateTween(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = isMaximized and UDim2.fromScale(0.9, 0.9) or originalSize
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
            CreateTween(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(0.9, 0.9),
                Position = UDim2.fromScale(0.5, 0.5)
            }):Play()
        else
            CreateTween(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = originalSize,
                Position = originalPosition
            }):Play()
        end
    end

    -- Button Hover Effects
    local function CreateButtonHover(button, hoverColor, normalColor)
        button.MouseEnter:Connect(function()
            CreateTween(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                BackgroundColor3 = Theme.Tertiary,
                ImageColor3 = hoverColor
            }):Play()
        end)
        
        button.MouseLeave:Connect(function()
            CreateTween(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                BackgroundColor3 = Theme.Secondary,
                ImageColor3 = normalColor
            }):Play()
        end)
    end

    CreateButtonHover(MaximizeButton, Theme.Accent, Theme.SubText)
    CreateButtonHover(MinimizeButton, Theme.Accent, Theme.SubText)
    CreateButtonHover(CloseButton, Theme.Error, Theme.SubText)

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

    -- Notification System
    local NotificationCount = 0
    
    function Window:Notify(config)
        local Title = config.Title or "Notification"
        local Content = config.Content or "This is a notification"
        local SubContent = config.SubContent or ""
        local Duration = config.Duration or 5
        local Type = config.Type or "Default" -- Default, Success, Warning, Error
        
        NotificationCount = NotificationCount + 1
        
        local NotificationFrame = Instance.new("Frame")
        NotificationFrame.Name = "Notification_" .. NotificationCount
        NotificationFrame.Parent = NotificationContainer
        NotificationFrame.BackgroundColor3 = Theme.Secondary
        NotificationFrame.BorderSizePixel = 0
        NotificationFrame.Size = UDim2.new(1, 0, 0, SubContent ~= "" and 100 or 80)
        NotificationFrame.Position = UDim2.new(1, 20, 0, 0)
        NotificationFrame.LayoutOrder = NotificationCount
        NotificationFrame.BackgroundTransparency = 1
        
        local NotificationCorner = Instance.new("UICorner")
        NotificationCorner.CornerRadius = UDim.new(0, 12)
        NotificationCorner.Parent = NotificationFrame
        
        local NotificationStroke = Instance.new("UIStroke")
        NotificationStroke.Color = Theme.Border
        NotificationStroke.Thickness = 1
        NotificationStroke.Parent = NotificationFrame
        
        -- Shadow
        local NotificationShadow = Instance.new("Frame")
        NotificationShadow.Name = "Shadow"
        NotificationShadow.Parent = NotificationFrame
        NotificationShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
       NotificationShadow.BackgroundTransparency = 0.8
       NotificationShadow.Size = UDim2.new(1, 6, 1, 6)
       NotificationShadow.Position = UDim2.new(0, 3, 0, 3)
       NotificationShadow.ZIndex = -1
       
       local NotificationShadowCorner = Instance.new("UICorner")
       NotificationShadowCorner.CornerRadius = UDim.new(0, 12)
       NotificationShadowCorner.Parent = NotificationShadow
       
       -- Accent Bar
       local AccentBar = Instance.new("Frame")
       AccentBar.Name = "AccentBar"
       AccentBar.Parent = NotificationFrame
       AccentBar.BorderSizePixel = 0
       AccentBar.Size = UDim2.new(0, 4, 1, 0)
       AccentBar.Position = UDim2.new(0, 0, 0, 0)
       
       -- Set accent color based on type
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
       AccentBarCorner.CornerRadius = UDim.new(0, 12)
       AccentBarCorner.Parent = AccentBar
       
       -- Fix the corner by adding a cover frame
       local AccentBarCover = Instance.new("Frame")
       AccentBarCover.Parent = AccentBar
       AccentBarCover.BackgroundColor3 = AccentColor
       AccentBarCover.BorderSizePixel = 0
       AccentBarCover.Size = UDim2.new(1, 0, 1, 0)
       AccentBarCover.Position = UDim2.new(0, 2, 0, 0)
       
       -- Icon
       local NotificationIcon = Instance.new("ImageLabel")
       NotificationIcon.Parent = NotificationFrame
       NotificationIcon.BackgroundTransparency = 1
       NotificationIcon.Size = UDim2.fromOffset(20, 20)
       NotificationIcon.Position = UDim2.fromOffset(20, 15)
       NotificationIcon.ImageColor3 = AccentColor
       
       -- Set icon based on type
       local IconId = "rbxassetid://3944680095" -- Default bell icon
       if Type == "Success" then
           IconId = "rbxassetid://3944680095" -- Checkmark
       elseif Type == "Warning" then
           IconId = "rbxassetid://3944680095" -- Warning triangle
       elseif Type == "Error" then
           IconId = "rbxassetid://3944680095" -- Error X
       end
       
       NotificationIcon.Image = IconId
       
       -- Title
       local NotificationTitle = Instance.new("TextLabel")
       NotificationTitle.Parent = NotificationFrame
       NotificationTitle.BackgroundTransparency = 1
       NotificationTitle.Size = UDim2.new(1, -80, 0, 20)
       NotificationTitle.Position = UDim2.fromOffset(50, 15)
       NotificationTitle.Text = Title
       NotificationTitle.TextColor3 = Theme.Text
       NotificationTitle.TextSize = 14
       NotificationTitle.Font = Enum.Font.GothamBold
       NotificationTitle.TextXAlignment = Enum.TextXAlignment.Left
       NotificationTitle.TextTruncate = Enum.TextTruncate.AtEnd
       
       -- Content
       local NotificationContent = Instance.new("TextLabel")
       NotificationContent.Parent = NotificationFrame
       NotificationContent.BackgroundTransparency = 1
       NotificationContent.Size = UDim2.new(1, -80, 0, 16)
       NotificationContent.Position = UDim2.fromOffset(50, 35)
       NotificationContent.Text = Content
       NotificationContent.TextColor3 = Theme.SubText
       NotificationContent.TextSize = 12
       NotificationContent.Font = Enum.Font.Gotham
       NotificationContent.TextXAlignment = Enum.TextXAlignment.Left
       NotificationContent.TextWrapped = true
       NotificationContent.TextTruncate = Enum.TextTruncate.AtEnd
       
       -- SubContent (if provided)
       if SubContent ~= "" then
           local NotificationSubContent = Instance.new("TextLabel")
           NotificationSubContent.Parent = NotificationFrame
           NotificationSubContent.BackgroundTransparency = 1
           NotificationSubContent.Size = UDim2.new(1, -80, 0, 14)
           NotificationSubContent.Position = UDim2.fromOffset(50, 55)
           NotificationSubContent.Text = SubContent
           NotificationSubContent.TextColor3 = Theme.SubText
           NotificationSubContent.TextSize = 10
           NotificationSubContent.Font = Enum.Font.Gotham
           NotificationSubContent.TextXAlignment = Enum.TextXAlignment.Left
           NotificationSubContent.TextWrapped = true
           NotificationSubContent.TextTruncate = Enum.TextTruncate.AtEnd
           NotificationSubContent.TextTransparency = 0.3
       end
       
       -- Close Button
       local CloseNotificationButton = Instance.new("ImageButton")
       CloseNotificationButton.Parent = NotificationFrame
       CloseNotificationButton.BackgroundTransparency = 1
       CloseNotificationButton.Size = UDim2.fromOffset(20, 20)
       CloseNotificationButton.Position = UDim2.new(1, -30, 0, 10)
       CloseNotificationButton.Image = "rbxassetid://74818383222024"
       CloseNotificationButton.ImageColor3 = Theme.SubText
       CloseNotificationButton.ImageTransparency = 0.5
       
       local CloseNotificationCorner = Instance.new("UICorner")
       CloseNotificationCorner.CornerRadius = UDim.new(0, 4)
       CloseNotificationCorner.Parent = CloseNotificationButton
       
       -- Close button hover effect
       CloseNotificationButton.MouseEnter:Connect(function()
           CreateTween(CloseNotificationButton, TweenInfo.new(0.2), {
               ImageTransparency = 0,
               ImageColor3 = Theme.Error
           }):Play()
       end)
       
       CloseNotificationButton.MouseLeave:Connect(function()
           CreateTween(CloseNotificationButton, TweenInfo.new(0.2), {
               ImageTransparency = 0.5,
               ImageColor3 = Theme.SubText
           }):Play()
       end)
       
       -- Progress Bar (if duration is set)
       local ProgressBar = nil
       if Duration and Duration > 0 then
           ProgressBar = Instance.new("Frame")
           ProgressBar.Parent = NotificationFrame
           ProgressBar.BackgroundColor3 = AccentColor
           ProgressBar.BorderSizePixel = 0
           ProgressBar.Size = UDim2.new(1, 0, 0, 2)
           ProgressBar.Position = UDim2.new(0, 0, 1, -2)
           
           local ProgressBarCorner = Instance.new("UICorner")
           ProgressBarCorner.CornerRadius = UDim.new(0, 0)
           ProgressBarCorner.Parent = ProgressBar
       end
       
       -- Animation: Slide in from right
       NotificationFrame.Position = UDim2.new(1, 20, 0, 0)
       NotificationFrame.BackgroundTransparency = 1
       NotificationStroke.Transparency = 1
       
       -- Fade in background and stroke
       CreateTween(NotificationFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
           BackgroundTransparency = 0
       }):Play()
       
       CreateTween(NotificationStroke, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
           Transparency = 0
       }):Play()
       
       -- Slide in animation
       CreateTween(NotificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
           Position = UDim2.new(0, 0, 0, 0)
       }):Play()
       
       -- Progress bar animation
       if ProgressBar and Duration and Duration > 0 then
           wait(0.5) -- Wait for slide in animation
           CreateTween(ProgressBar, TweenInfo.new(Duration, Enum.EasingStyle.Linear), {
               Size = UDim2.new(0, 0, 0, 2)
           }):Play()
       end
       
       -- Auto close function
       local function CloseNotification()
           -- Slide out animation
           CreateTween(NotificationFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
               Position = UDim2.new(1, 20, 0, 0),
               BackgroundTransparency = 1
           }):Play()
           
           CreateTween(NotificationStroke, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
               Transparency = 1
           }):Play()
           
           wait(0.4)
           NotificationFrame:Destroy()
       end
       
       -- Close button click
       CloseNotificationButton.MouseButton1Click:Connect(CloseNotification)
       
       -- Auto close after duration
       if Duration and Duration > 0 then
           spawn(function()
               wait(Duration + 0.5) -- Add slide in time
               if NotificationFrame.Parent then
                   CloseNotification()
               end
           end)
       end
       
       -- Click to close
       NotificationFrame.InputBegan:Connect(function(input)
           if input.UserInputType == Enum.UserInputType.MouseButton1 then
               CloseNotification()
           end
       end)
   end

   -- Loading Animation
   CreateTween(LoadingProgress, TweenInfo.new(LoadingTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
       Size = UDim2.fromScale(1, 1)
   }):Play()

   wait(LoadingTime)
   
   CreateTween(WelcomeFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
       Size = UDim2.fromOffset(0, 0),
       Position = UDim2.fromScale(0.5, 0.5)
   }):Play()

   wait(0.5)
   WelcomeFrame:Destroy()
   MainFrame.Visible = true
   MainFrame.Size = UDim2.fromOffset(0, 0)
   CreateTween(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
       Size = Size
   }):Play()

   -- Show welcome notification after GUI loads
   spawn(function()
       wait(1)
       Window:Notify({
           Title = "Welcome!",
           Content = "GUI loaded successfully",
           SubContent = "Ready to use • " .. os.date("%H:%M"),
           Duration = 4,
           Type = "Success"
       })
   end)

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
