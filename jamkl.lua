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
    settings = "rbxassetid://10734950309",
    home = "rbxassetid://92309619719802",
    ["map-pin-house"] = "rbxassetid://114294190550941",
    ["house-plus"] = "rbxassetid://97631974975774",
    ["house-wifi"] = "rbxassetid://126763764531115",
    ["phone-call"] = "rbxassetid://90184163844046",
    ["save-off"] = "rbxassetid://94322470847780",
    ["signal-high"] = "rbxassetid://84621858630690",
    ["square-terminal"] = "rbxassetid://106713732085548",
    ["undo-dot"] = "rbxassetid://82459573493832",
    ["wifi-low"] = "rbxassetid://119974531057294",
    ["wind-arrow-down"] = "rbxassetid://90150061617947",
    wrench = "rbxassetid://75760172015867",
    terminal = "rbxassetid://86935080083630",
    ["square-menu"] = "rbxassetid://124363101399299",
    ["shield-ban"] = "rbxassetid://125733003566871",
    ["server-crash"] = "rbxassetid://134344214403302",
    ["scroll-text"] = "rbxassetid://130077059981083",
    ["screen-share"] = "rbxassetid://78407375693434",
    play = "rbxassetid://140688372742211",
    ["mouse-pointer-click"] = "rbxassetid://134698195130356",
    ["mouse-pointer"] = "rbxassetid://113303138946224",
    logs = "rbxassetid://125195928083757",
    ["lock-keyhole"] = "rbxassetid://101626468102285",
    ["locate-fixed"] = "rbxassetid://109203127645538",
    locate = "rbxassetid://117295186471094",
    ["map-plus"] = "rbxassetid://132129417926899",
    ["user-round-check"] = "rbxassetid://89989366513016",
    ["shield-user"] = "rbxassetid://72549166753190",
    ["notepad-text-dashed"] = "rbxassetid://109802149635043",
    ["notepad-text"] = "rbxassetid://78566545135896",
    ["panel-right-open"] = "rbxassetid://111855496283529",
    ["panel-top"] = "rbxassetid://105628045711252",
    ["panel-top-close"] = "rbxassetid://137699602890459",
    phone = "rbxassetid://117916436209255",
    ["plug-zap"] = "rbxassetid://88443033310481",
    plug = "rbxassetid://127640868105866",
    ["radio-receiver"] = "rbxassetid://99030541960024",
    ruler = "rbxassetid://130521784598692",
    save = "rbxassetid://124502845829112",
    ["save-all"] = "rbxassetid://115892453613638",
    scaling = "rbxassetid://138342522500370",
    ["signal-medium"] = "rbxassetid://121589034843436",
    smartphone = "rbxassetid://92613756801622",
    ["smartphone-charging"] = "rbxassetid://91659381468634",
    ["square-plus"] = "rbxassetid://123364205903197",
    star = "rbxassetid://126945835022671",
    ["sticky-note"] = "rbxassetid://97120631432477",
    sticker = "rbxassetid://119340479392140",
    ["ticket-x"] = "rbxassetid://105383579491803",
    ["ticket-slash"] = "rbxassetid://104823509312194",
    transgender = "rbxassetid://75596633760140",
    ["trending-up-down"] = "rbxassetid://73414152507992",
    ["undo-2"] = "rbxassetid://116283716426162",
    ["zoom-out"] = "rbxassetid://82816972511954"
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

    handle.InputBegan:Connect(
        function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragStart = input.Position
                startPos = frame.Position
            end
        end
    )

    handle.InputChanged:Connect(
        function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = input.Position - dragStart
                frame.Position =
                    UDim2.new(
                    startPos.X.Scale,
                    startPos.X.Offset + delta.X,
                    startPos.Y.Scale,
                    startPos.Y.Offset + delta.Y
                )
            end
        end
    )

    handle.InputEnded:Connect(
        function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end
    )
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
    local Size = config.Size or UDim2.fromOffset(580, 482)
    local ThemeName = config.Theme or "Sky"
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
    WelcomeGradient.Color =
        ColorSequence.new {
        ColorSequenceKeypoint.new(0, Theme.Primary),
        ColorSequenceKeypoint.new(
            1,
            Color3.fromRGB(
                math.min(255, Theme.Primary.R * 255 + 10),
                math.min(255, Theme.Primary.G * 255 + 10),
                math.min(255, Theme.Primary.B * 255 + 10)
            )
        )
    }
    WelcomeGradient.Rotation = 45
    WelcomeGradient.Parent = WelcomeFrame

    local PlayerAvatar = Instance.new("ImageLabel")
    PlayerAvatar.Parent = WelcomeFrame
    PlayerAvatar.BackgroundTransparency = 1
    PlayerAvatar.Size = UDim2.fromOffset(70, 70)
    PlayerAvatar.Position = UDim2.fromScale(0.5, 0.22)
    PlayerAvatar.AnchorPoint = Vector2.new(0.5, 0.5)
    PlayerAvatar.Image =
        "https://www.roblox.com/headshot-thumbnail/image?userId=" .. Player.UserId .. "&width=150&height=150&format=png"

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
    ProgressGlow.Color =
        ColorSequence.new {
        ColorSequenceKeypoint.new(0, Theme.Accent),
        ColorSequenceKeypoint.new(
            1,
            Color3.fromRGB(
                math.min(255, Theme.Accent.R * 255 * 1.3),
                math.min(255, Theme.Accent.G * 255 * 1.3),
                math.min(255, Theme.Accent.B * 255 * 1.3)
            )
        )
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
    MainGradient.Color =
        ColorSequence.new {
        ColorSequenceKeypoint.new(0, Theme.Primary),
        ColorSequenceKeypoint.new(
            1,
            Color3.fromRGB(
                math.min(255, Theme.Primary.R * 255 + 8),
                math.min(255, Theme.Primary.G * 255 + 8),
                math.min(255, Theme.Primary.B * 255 + 8)
            )
        )
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

    local IconRotation =
        CreateTween(
        TitleIcon,
        TweenInfo.new(10, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1),
        {
            Rotation = 360
        }
    )
    IconRotation:Play()

    local IconPulse =
        CreateTween(
        TitleIcon,
        TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
        {
            Size = UDim2.fromOffset(38, 38)
        }
    )
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
    MaximizeButton.Text = "⟺"
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
    MinimizeButton.Text = "～"
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
    CloseButton.Text = "〤"
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
    FloatingGradient.Color =
        ColorSequence.new {
        ColorSequenceKeypoint.new(0, Theme.Accent),
        ColorSequenceKeypoint.new(
            1,
            Color3.fromRGB(
                math.min(255, Theme.Accent.R * 255 * 1.4),
                math.min(255, Theme.Accent.G * 255 * 1.4),
                math.min(255, Theme.Accent.B * 255 * 1.4)
            )
        )
    }
    FloatingGradient.Rotation = 45
    FloatingGradient.Parent = FloatingIcon

    local FloatingPulse =
        CreateTween(
        FloatingIcon,
        TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
        {
            Size = UDim2.fromOffset(70, 70)
        }
    )

    local FloatingRotate =
        CreateTween(
        FloatingIcon,
        TweenInfo.new(8, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1),
        {
            Rotation = 360
        }
    )

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
        CreateTween(
            MainFrame,
            TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {
                Size = isMaximized and UDim2.fromScale(0.9, 0.9) or originalSize
            }
        ):Play()
    end

    local function HideWindow()
        CreateTween(
            MainFrame,
            TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
            {
                Size = UDim2.fromOffset(0, 0)
            }
        ):Play()
        task.wait(0.4)
        MainFrame.Visible = false
        FloatingIcon.Visible = true
        FloatingPulse:Play()
        FloatingRotate:Play()
    end

    local function MaximizeWindow()
        isMaximized = not isMaximized
        if isMaximized then
            CreateTween(
                MainFrame,
                TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {
                    Size = UDim2.fromScale(0.9, 0.9),
                    Position = UDim2.fromScale(0.5, 0.5)
                }
            ):Play()
        else
            CreateTween(
                MainFrame,
                TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {
                    Size = originalSize,
                    Position = originalPosition
                }
            ):Play()
        end
    end

    local function CreateButtonHover(button, hoverColor)
        local originalColor = button.BackgroundColor3
        button.MouseEnter:Connect(
            function()
                CreateTween(
                    button,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                    {
                        BackgroundColor3 = hoverColor or Theme.Accent,
                        BackgroundTransparency = 0.05,
                        TextTransparency = 0
                    }
                ):Play()
                CreateTween(
                    button:FindFirstChild("UIStroke"),
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                    {
                        Transparency = 0.2
                    }
                ):Play()
            end
        )

        button.MouseLeave:Connect(
            function()
                CreateTween(
                    button,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                    {
                        BackgroundColor3 = originalColor,
                        BackgroundTransparency = 0.2,
                        TextTransparency = 0.2
                    }
                ):Play()
                CreateTween(
                    button:FindFirstChild("UIStroke"),
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                    {
                        Transparency = 0.5
                    }
                ):Play()
            end
        )
    end

    CreateButtonHover(MaximizeButton, Theme.Success)
    CreateButtonHover(MinimizeButton, Theme.Warning)
    CreateButtonHover(CloseButton, Theme.Error)

    CloseButton.MouseButton1Click:Connect(
        function()
            CreateTween(
                MainFrame,
                TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
                {
                    Size = UDim2.fromOffset(0, 0)
                }
            ):Play()
            task.wait(0.3)
            ScreenGui:Destroy()
        end
    )

    MinimizeButton.MouseButton1Click:Connect(HideWindow)
    MaximizeButton.MouseButton1Click:Connect(MaximizeWindow)
    FloatingButton.MouseButton1Click:Connect(ShowWindow)

    UserInputService.InputBegan:Connect(
        function(input, gameProcessed)
            if not gameProcessed and input.KeyCode == MinimizeKey then
                if MainFrame.Visible then
                    HideWindow()
                else
                    ShowWindow()
                end
            end
        end
    )

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
        local SoundId = config.SoundId or "rbxassetid://9117492353" or nil

        NotificationCount = NotificationCount + 1

        if SoundId then
            local sound = Instance.new("Sound")
            sound.SoundId = SoundId
            sound.Volume = 0.5
            sound.Parent = SoundService
            sound:Play()
            sound.Ended:Connect(
                function()
                    sound:Destroy()
                end
            )
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
        NotificationGradient.Color =
            ColorSequence.new {
            ColorSequenceKeypoint.new(0, Theme.Secondary),
            ColorSequenceKeypoint.new(
                1,
                Color3.fromRGB(
                    math.min(255, Theme.Secondary.R * 255 + 12),
                    math.min(255, Theme.Secondary.G * 255 + 12),
                    math.min(255, Theme.Secondary.B * 255 + 12)
                )
            )
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

        CloseNotificationButton.MouseEnter:Connect(
            function()
                CreateTween(
                    CloseNotificationButton,
                    TweenInfo.new(0.2),
                    {
                        BackgroundTransparency = 0.2,
                        TextTransparency = 0
                    }
                ):Play()
            end
        )

        CloseNotificationButton.MouseLeave:Connect(
            function()
                CreateTween(
                    CloseNotificationButton,
                    TweenInfo.new(0.2),
                    {
                        BackgroundTransparency = 0.8,
                        TextTransparency = 0.3
                    }
                ):Play()
            end
        )

        NotificationFrame.Position = UDim2.new(1, 30, 0, 0)
        NotificationFrame.BackgroundTransparency = 1
        NotificationStroke.Transparency = 1

        CreateTween(
            NotificationFrame,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {
                BackgroundTransparency = 0.1
            }
        ):Play()

        CreateTween(
            NotificationStroke,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {
                Transparency = 0.3
            }
        ):Play()

        CreateTween(
            NotificationFrame,
            TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {
                Position = UDim2.new(0, 0, 0, 0)
            }
        ):Play()

        local function CloseNotification()
            CreateTween(
                NotificationFrame,
                TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
                {
                    Position = UDim2.new(1, 30, 0, 0),
                    BackgroundTransparency = 1
                }
            ):Play()

            CreateTween(
                NotificationStroke,
                TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
                {
                    Transparency = 1
                }
            ):Play()

            task.wait(0.3)
            NotificationFrame:Destroy()
        end

        CloseNotificationButton.MouseButton1Click:Connect(CloseNotification)

        if Duration and Duration > 0 then
            task.spawn(
                function()
                    task.wait(Duration + 0.4)
                    if NotificationFrame.Parent then
                        CloseNotification()
                    end
                end
            )
        end

        NotificationFrame.InputBegan:Connect(
            function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    CloseNotification()
                end
            end
        )
    end

    local function SwitchToTab(tab)
        for _, existingTab in pairs(Window.Tabs or {}) do
            if existingTab.ContentFrame then
                existingTab.ContentFrame.Visible = false
            end
            if existingTab.TabButton then
                CreateTween(
                    existingTab.TabButton,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                    {
                        BackgroundTransparency = 1,
                        TextTransparency = 0.3
                    }
                ):Play()
                if existingTab.TabIcon then
                    CreateTween(
                        existingTab.TabIcon,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                        {
                            ImageTransparency = 0.3
                        }
                    ):Play()
                end
            end
        end

        if tab.ContentFrame then
            tab.ContentFrame.Visible = true
        end
        if tab.TabButton then
            CreateTween(
                tab.TabButton,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                {
                    BackgroundTransparency = 0.85,
                    TextTransparency = 0
                }
            ):Play()
            if tab.TabIcon then
                CreateTween(
                    tab.TabIcon,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                    {
                        ImageTransparency = 0
                    }
                ):Play()
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
        Tab.Theme = Theme
        Tab.Sections = {}

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

        local TabScrollingFrame = Instance.new("ScrollingFrame")
        TabScrollingFrame.Parent = TabContentFrame
        TabScrollingFrame.BackgroundTransparency = 1
        TabScrollingFrame.BorderSizePixel = 0
        TabScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
        TabScrollingFrame.Position = UDim2.new(0, 0, 0, 0)
        TabScrollingFrame.ScrollBarThickness = 6
        TabScrollingFrame.ScrollBarImageColor3 = Theme.Accent
        TabScrollingFrame.ScrollBarImageTransparency = 0.3
        TabScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

        local TabContentLayout = Instance.new("UIListLayout")
        TabContentLayout.Parent = TabScrollingFrame
        TabContentLayout.FillDirection = Enum.FillDirection.Vertical
        TabContentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
        TabContentLayout.VerticalAlignment = Enum.VerticalAlignment.Top
        TabContentLayout.Padding = UDim.new(0, 8)
        TabContentLayout.SortOrder = Enum.SortOrder.LayoutOrder

        local TabContentPadding = Instance.new("UIPadding")
        TabContentPadding.Parent = TabScrollingFrame
        TabContentPadding.PaddingTop = UDim.new(0, 15)
        TabContentPadding.PaddingBottom = UDim.new(0, 15)
        TabContentPadding.PaddingLeft = UDim.new(0, 15)
        TabContentPadding.PaddingRight = UDim.new(0, 15)

        Tab.TabButton = TabButton
        Tab.TabIcon = TabIconLabel
        Tab.ContentFrame = TabContentFrame
        Tab.ScrollingFrame = TabScrollingFrame

        TabButton.MouseEnter:Connect(
            function()
                if currentTab ~= Tab then
                    CreateTween(
                        TabButton,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                        {
                            BackgroundTransparency = 0.9
                        }
                    ):Play()
                    CreateTween(
                        TabTitleLabel,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                        {
                            TextTransparency = 0.1
                        }
                    ):Play()
                    if TabIconLabel then
                        CreateTween(
                            TabIconLabel,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                            {
                                ImageTransparency = 0.1
                            }
                        ):Play()
                    end
                end
            end
        )

        TabButton.MouseLeave:Connect(
            function()
                if currentTab ~= Tab then
                    CreateTween(
                        TabButton,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                        {
                            BackgroundTransparency = 1
                        }
                    ):Play()
                    CreateTween(
                        TabTitleLabel,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                        {
                            TextTransparency = 0.3
                        }
                    ):Play()
                    if TabIconLabel then
                        CreateTween(
                            TabIconLabel,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                            {
                                ImageTransparency = 0.3
                            }
                        ):Play()
                    end
                end
            end
        )

        TabButton.MouseButton1Click:Connect(
            function()
                SwitchToTab(Tab)
            end
        )

        function Tab:AddSection(sectionName)
            local Section = {}
            Section.Title = sectionName or "Section"
            Section.Theme = Theme
            Section.Elements = {}

            local SectionFrame = Instance.new("Frame")
            SectionFrame.Parent = TabScrollingFrame
            SectionFrame.BackgroundColor3 = Theme.Secondary
            SectionFrame.BackgroundTransparency = 0.15
            SectionFrame.BorderSizePixel = 0
            SectionFrame.Size = UDim2.new(1, 0, 0, 0)
            SectionFrame.AutomaticSize = Enum.AutomaticSize.Y

            local SectionCorner = Instance.new("UICorner")
            SectionCorner.CornerRadius = UDim.new(0, 16)
            SectionCorner.Parent = SectionFrame

            local SectionStroke = Instance.new("UIStroke")
            SectionStroke.Color = Theme.Border
            SectionStroke.Thickness = 1
            SectionStroke.Transparency = 0.4
            SectionStroke.Parent = SectionFrame

            local SectionGradient = Instance.new("UIGradient")
            SectionGradient.Color =
                ColorSequence.new {
                ColorSequenceKeypoint.new(0, Theme.Secondary),
                ColorSequenceKeypoint.new(
                    1,
                    Color3.fromRGB(
                        math.min(255, Theme.Secondary.R * 255 + 8),
                        math.min(255, Theme.Secondary.G * 255 + 8),
                        math.min(255, Theme.Secondary.B * 255 + 8)
                    )
                )
            }
            SectionGradient.Rotation = 90
            SectionGradient.Parent = SectionFrame

            local SectionTitle = Instance.new("TextLabel")
            SectionTitle.Parent = SectionFrame
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.Size = UDim2.new(1, -30, 0, 35)
            SectionTitle.Position = UDim2.fromOffset(15, 10)
            SectionTitle.Text = Section.Title
            SectionTitle.TextColor3 = Theme.Text
            SectionTitle.TextSize = 16
            SectionTitle.Font = Enum.Font.GothamBold
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            SectionTitle.TextYAlignment = Enum.TextYAlignment.Top

            local SectionLine = Instance.new("Frame")
            SectionLine.Parent = SectionFrame
            SectionLine.BackgroundColor3 = Theme.Accent
            SectionLine.BackgroundTransparency = 0.2
            SectionLine.BorderSizePixel = 0
            SectionLine.Size = UDim2.new(0, 40, 0, 2)
            SectionLine.Position = UDim2.fromOffset(15, 40)

            local SectionLineCorner = Instance.new("UICorner")
            SectionLineCorner.CornerRadius = UDim.new(1, 0)
            SectionLineCorner.Parent = SectionLine

            local SectionContent = Instance.new("Frame")
            SectionContent.Parent = SectionFrame
            SectionContent.BackgroundTransparency = 1
            SectionContent.Size = UDim2.new(1, -30, 0, 0)
            SectionContent.Position = UDim2.fromOffset(15, 55)
            SectionContent.AutomaticSize = Enum.AutomaticSize.Y

            local SectionLayout = Instance.new("UIListLayout")
            SectionLayout.Parent = SectionContent
            SectionLayout.FillDirection = Enum.FillDirection.Vertical
            SectionLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
            SectionLayout.VerticalAlignment = Enum.VerticalAlignment.Top
            SectionLayout.Padding = UDim.new(0, 6)
            SectionLayout.SortOrder = Enum.SortOrder.LayoutOrder

            local SectionPadding = Instance.new("UIPadding")
            SectionPadding.Parent = SectionFrame
            SectionPadding.PaddingBottom = UDim.new(0, 15)

            Section.Frame = SectionFrame
            Section.ContentFrame = SectionContent

            function Section:AddParagraph(config)
                local ParagraphTitle = config.Title or "Paragraph"
                local ParagraphContent = config.Content or "Paragraph content here"

                local ParagraphFrame = Instance.new("Frame")
                ParagraphFrame.Parent = SectionContent
                ParagraphFrame.BackgroundColor3 = Theme.Tertiary
                ParagraphFrame.BackgroundTransparency = 0.15
                ParagraphFrame.BorderSizePixel = 0
                ParagraphFrame.Size = UDim2.new(1, 0, 0, 0)
                ParagraphFrame.AutomaticSize = Enum.AutomaticSize.Y

                local ParagraphCorner = Instance.new("UICorner")
                ParagraphCorner.CornerRadius = UDim.new(0, 12)
                ParagraphCorner.Parent = ParagraphFrame

                local ParagraphStroke = Instance.new("UIStroke")
                ParagraphStroke.Color = Theme.Border
                ParagraphStroke.Thickness = 1
                ParagraphStroke.Transparency = 0.5
                ParagraphStroke.Parent = ParagraphFrame

                local ParagraphGradient = Instance.new("UIGradient")
                ParagraphGradient.Color =
                    ColorSequence.new {
                    ColorSequenceKeypoint.new(0, Theme.Tertiary),
                    ColorSequenceKeypoint.new(
                        1,
                        Color3.fromRGB(
                            math.min(255, Theme.Tertiary.R * 255 + 6),
                            math.min(255, Theme.Tertiary.G * 255 + 6),
                            math.min(255, Theme.Tertiary.B * 255 + 6)
                        )
                    )
                }
                ParagraphGradient.Rotation = 45
                ParagraphGradient.Parent = ParagraphFrame

                local ParagraphTitleLabel = Instance.new("TextLabel")
                ParagraphTitleLabel.Parent = ParagraphFrame
                ParagraphTitleLabel.BackgroundTransparency = 1
                ParagraphTitleLabel.Size = UDim2.new(1, -30, 0, 20)
                ParagraphTitleLabel.Position = UDim2.fromOffset(15, 12)
                ParagraphTitleLabel.Text = ParagraphTitle
                ParagraphTitleLabel.TextColor3 = Theme.Text
                ParagraphTitleLabel.TextSize = 14
                ParagraphTitleLabel.Font = Enum.Font.GothamSemibold
                ParagraphTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
                ParagraphTitleLabel.TextTruncate = Enum.TextTruncate.AtEnd

                local ParagraphContentLabel = Instance.new("TextLabel")
                ParagraphContentLabel.Parent = ParagraphFrame
                ParagraphContentLabel.BackgroundTransparency = 1
                ParagraphContentLabel.Size = UDim2.new(1, -30, 0, 0)
                ParagraphContentLabel.Position = UDim2.fromOffset(15, 35)
                ParagraphContentLabel.Text = ParagraphContent
                ParagraphContentLabel.TextColor3 = Theme.SubText
                ParagraphContentLabel.TextSize = 12
                ParagraphContentLabel.Font = Enum.Font.Gotham
                ParagraphContentLabel.TextXAlignment = Enum.TextXAlignment.Left
                ParagraphContentLabel.TextYAlignment = Enum.TextYAlignment.Top
                ParagraphContentLabel.TextWrapped = true
                ParagraphContentLabel.AutomaticSize = Enum.AutomaticSize.Y

                local ParagraphPadding = Instance.new("UIPadding")
                ParagraphPadding.Parent = ParagraphFrame
                ParagraphPadding.PaddingBottom = UDim.new(0, 15)

                return {
                    Frame = ParagraphFrame,
                    SetContent = function(newContent)
                        ParagraphContentLabel.Text = newContent or "Paragraph content here"
                    end,
                    SetTitle = function(newTitle)
                        ParagraphTitleLabel.Text = newTitle or "Paragraph"
                    end
                }
            end

            function Section:AddButton(config)
                local ButtonTitle = config.Title or "Button"
                local ButtonDesc = config.Description or ""
                local ButtonCallback = config.Callback or function()
                    end
                local ButtonConfirm = config.Confirm or false

                local ButtonFrame = Instance.new("Frame")
                ButtonFrame.Parent = SectionContent
                ButtonFrame.BackgroundColor3 = Theme.Tertiary
                ButtonFrame.BackgroundTransparency = 0.15
                ButtonFrame.BorderSizePixel = 0
                ButtonFrame.Size = UDim2.new(1, 0, 0, ButtonDesc ~= "" and 65 or 45)

                local ButtonCorner = Instance.new("UICorner")
                ButtonCorner.CornerRadius = UDim.new(0, 12)
                ButtonCorner.Parent = ButtonFrame

                local ButtonStroke = Instance.new("UIStroke")
                ButtonStroke.Color = Theme.Border
                ButtonStroke.Thickness = 1
                ButtonStroke.Transparency = 0.5
                ButtonStroke.Parent = ButtonFrame

                local ButtonGradient = Instance.new("UIGradient")
                ButtonGradient.Color =
                    ColorSequence.new {
                    ColorSequenceKeypoint.new(0, Theme.Tertiary),
                    ColorSequenceKeypoint.new(
                        1,
                        Color3.fromRGB(
                            math.min(255, Theme.Tertiary.R * 255 + 6),
                            math.min(255, Theme.Tertiary.G * 255 + 6),
                            math.min(255, Theme.Tertiary.B * 255 + 6)
                        )
                    )
                }
                ButtonGradient.Rotation = 45
                ButtonGradient.Parent = ButtonFrame

                local ButtonIcon = Instance.new("Frame")
                ButtonIcon.Parent = ButtonFrame
                ButtonIcon.BackgroundColor3 = Theme.Accent
                ButtonIcon.BackgroundTransparency = 0.1
                ButtonIcon.BorderSizePixel = 0
                ButtonIcon.Size = UDim2.fromOffset(8, 8)
                ButtonIcon.Position = UDim2.fromOffset(15, ButtonDesc ~= "" and 18 or 18)

                local ButtonIconCorner = Instance.new("UICorner")
                ButtonIconCorner.CornerRadius = UDim.new(1, 0)
                ButtonIconCorner.Parent = ButtonIcon

                local ButtonIconGlow = Instance.new("UIGradient")
                ButtonIconGlow.Color =
                    ColorSequence.new {
                    ColorSequenceKeypoint.new(0, Theme.Accent),
                    ColorSequenceKeypoint.new(
                        1,
                        Color3.fromRGB(
                            math.min(255, Theme.Accent.R * 255 * 1.3),
                            math.min(255, Theme.Accent.G * 255 * 1.3),
                            math.min(255, Theme.Accent.B * 255 * 1.3)
                        )
                    )
                }
                ButtonIconGlow.Parent = ButtonIcon

                local ButtonTitleLabel = Instance.new("TextLabel")
                ButtonTitleLabel.Parent = ButtonFrame
                ButtonTitleLabel.BackgroundTransparency = 1
                ButtonTitleLabel.Size = UDim2.new(1, -40, 0, 20)
                ButtonTitleLabel.Position = UDim2.fromOffset(32, ButtonDesc ~= "" and 8 or 12)
                ButtonTitleLabel.Text = ButtonTitle
                ButtonTitleLabel.TextColor3 = Theme.Text
                ButtonTitleLabel.TextSize = 14
                ButtonTitleLabel.Font = Enum.Font.GothamSemibold
                ButtonTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
                ButtonTitleLabel.TextTruncate = Enum.TextTruncate.AtEnd

                local ButtonDescLabel = nil
                if ButtonDesc ~= "" then
                    ButtonDescLabel = Instance.new("TextLabel")
                    ButtonDescLabel.Parent = ButtonFrame
                    ButtonDescLabel.BackgroundTransparency = 1
                    ButtonDescLabel.Size = UDim2.new(1, -40, 0, 32)
                    ButtonDescLabel.Position = UDim2.fromOffset(32, 26)
                    ButtonDescLabel.Text = ButtonDesc
                    ButtonDescLabel.TextColor3 = Theme.SubText
                    ButtonDescLabel.TextSize = 12
                    ButtonDescLabel.Font = Enum.Font.Gotham
                    ButtonDescLabel.TextXAlignment = Enum.TextXAlignment.Left
                    ButtonDescLabel.TextYAlignment = Enum.TextYAlignment.Top
                    ButtonDescLabel.TextWrapped = true
                    ButtonDescLabel.TextTruncate = Enum.TextTruncate.AtEnd
                end

                local ButtonClick = Instance.new("TextButton")
                ButtonClick.Parent = ButtonFrame
                ButtonClick.BackgroundTransparency = 1
                ButtonClick.Size = UDim2.new(1, 0, 1, 0)
                ButtonClick.Text = ""

                local function CreateConfirmDialog(callback)
                    local ConfirmFrame = Instance.new("Frame")
                    ConfirmFrame.Name = "ConfirmDialog"
                    ConfirmFrame.Parent = ScreenGui
                    ConfirmFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                    ConfirmFrame.BackgroundTransparency = 0.5
                    ConfirmFrame.BorderSizePixel = 0
                    ConfirmFrame.Size = UDim2.new(1, 0, 1, 0)
                    ConfirmFrame.Position = UDim2.new(0, 0, 0, 0)
                    ConfirmFrame.ZIndex = 1000

                    local ConfirmDialog = Instance.new("Frame")
                    ConfirmDialog.Parent = ConfirmFrame
                    ConfirmDialog.BackgroundColor3 = Theme.Primary
                    ConfirmDialog.BackgroundTransparency = 0.05
                    ConfirmDialog.BorderSizePixel = 0
                    ConfirmDialog.Size = UDim2.fromOffset(300, 150)
                    ConfirmDialog.Position = UDim2.fromScale(0.5, 0.5)
                    ConfirmDialog.AnchorPoint = Vector2.new(0.5, 0.5)

                    local ConfirmCorner = Instance.new("UICorner")
                    ConfirmCorner.CornerRadius = UDim.new(0, 16)
                    ConfirmCorner.Parent = ConfirmDialog

                    local ConfirmStroke = Instance.new("UIStroke")
                    ConfirmStroke.Color = Theme.Border
                    ConfirmStroke.Thickness = 1
                    ConfirmStroke.Transparency = 0.3
                    ConfirmStroke.Parent = ConfirmDialog

                    local ConfirmTitle = Instance.new("TextLabel")
                    ConfirmTitle.Parent = ConfirmDialog
                    ConfirmTitle.BackgroundTransparency = 1
                    ConfirmTitle.Size = UDim2.new(1, -40, 0, 30)
                    ConfirmTitle.Position = UDim2.fromOffset(20, 15)
                    ConfirmTitle.Text = "Confirm Action"
                    ConfirmTitle.TextColor3 = Theme.Text
                    ConfirmTitle.TextSize = 16
                    ConfirmTitle.Font = Enum.Font.GothamBold
                    ConfirmTitle.TextXAlignment = Enum.TextXAlignment.Left

                    local ConfirmText = Instance.new("TextLabel")
                    ConfirmText.Parent = ConfirmDialog
                    ConfirmText.BackgroundTransparency = 1
                    ConfirmText.Size = UDim2.new(1, -40, 0, 40)
                    ConfirmText.Position = UDim2.fromOffset(20, 45)
                    ConfirmText.Text = "Are you sure you want to execute this action?"
                    ConfirmText.TextColor3 = Theme.SubText
                    ConfirmText.TextSize = 13
                    ConfirmText.Font = Enum.Font.Gotham
                    ConfirmText.TextXAlignment = Enum.TextXAlignment.Left
                    ConfirmText.TextYAlignment = Enum.TextYAlignment.Top
                    ConfirmText.TextWrapped = true

                    local ButtonsContainer = Instance.new("Frame")
                    ButtonsContainer.Parent = ConfirmDialog
                    ButtonsContainer.BackgroundTransparency = 1
                    ButtonsContainer.Size = UDim2.new(1, -40, 0, 35)
                    ButtonsContainer.Position = UDim2.fromOffset(20, 95)

                    local ButtonsLayout = Instance.new("UIListLayout")
                    ButtonsLayout.Parent = ButtonsContainer
                    ButtonsLayout.FillDirection = Enum.FillDirection.Horizontal
                    ButtonsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
                    ButtonsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
                    ButtonsLayout.Padding = UDim.new(0, 10)

                    local CancelButton = Instance.new("TextButton")
                    CancelButton.Parent = ButtonsContainer
                    CancelButton.BackgroundColor3 = Theme.Secondary
                    CancelButton.BackgroundTransparency = 0.1
                    CancelButton.BorderSizePixel = 0
                    CancelButton.Size = UDim2.fromOffset(80, 30)
                    CancelButton.Text = "Cancel"
                    CancelButton.TextColor3 = Theme.Text
                    CancelButton.TextSize = 12
                    CancelButton.Font = Enum.Font.GothamMedium

                    local CancelCorner = Instance.new("UICorner")
                    CancelCorner.CornerRadius = UDim.new(0, 8)
                    CancelCorner.Parent = CancelButton

                    local ConfirmButton = Instance.new("TextButton")
                    ConfirmButton.Parent = ButtonsContainer
                    ConfirmButton.BackgroundColor3 = Theme.Accent
                    ConfirmButton.BackgroundTransparency = 0.1
                    ConfirmButton.BorderSizePixel = 0
                    ConfirmButton.Size = UDim2.fromOffset(80, 30)
                    ConfirmButton.Text = "Confirm"
                    ConfirmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    ConfirmButton.TextSize = 12
                    ConfirmButton.Font = Enum.Font.GothamMedium

                    local ConfirmButtonCorner = Instance.new("UICorner")
                    ConfirmButtonCorner.CornerRadius = UDim.new(0, 8)
                    ConfirmButtonCorner.Parent = ConfirmButton

                    ConfirmDialog.Size = UDim2.fromOffset(0, 0)
                    CreateTween(
                        ConfirmDialog,
                        TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                        {
                            Size = UDim2.fromOffset(300, 150)
                        }
                    ):Play()

                    CancelButton.MouseButton1Click:Connect(
                        function()
                            CreateTween(
                                ConfirmDialog,
                                TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
                                {
                                    Size = UDim2.fromOffset(0, 0)
                                }
                            ):Play()
                            task.wait(0.2)
                            ConfirmFrame:Destroy()
                        end
                    )

                    ConfirmButton.MouseButton1Click:Connect(
                        function()
                            CreateTween(
                                ConfirmDialog,
                                TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
                                {
                                    Size = UDim2.fromOffset(0, 0)
                                }
                            ):Play()
                            task.wait(0.2)
                            ConfirmFrame:Destroy()
                            if callback then
                                task.spawn(callback)
                            end
                        end
                    )

                    ConfirmFrame.MouseButton1Click:Connect(
                        function()
                            CreateTween(
                                ConfirmDialog,
                                TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
                                {
                                    Size = UDim2.fromOffset(0, 0)
                                }
                            ):Play()
                            task.wait(0.2)
                            ConfirmFrame:Destroy()
                        end
                    )
                end

                local function AnimateButton(isEnter)
                    if isEnter then
                        CreateTween(
                            ButtonFrame,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                            {
                                BackgroundTransparency = 0.05
                            }
                        ):Play()
                        CreateTween(
                            ButtonStroke,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                            {
                                Transparency = 0.2,
                                Color = Theme.Accent
                            }
                        ):Play()
                        CreateTween(
                            ButtonIcon,
                            TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                            {
                                Size = UDim2.fromOffset(10, 10)
                            }
                        ):Play()
                        CreateTween(
                            ButtonTitleLabel,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                            {
                                TextColor3 = Theme.Accent
                            }
                        ):Play()
                    else
                        CreateTween(
                            ButtonFrame,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                            {
                                BackgroundTransparency = 0.15
                            }
                        ):Play()
                        CreateTween(
                            ButtonStroke,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                            {
                                Transparency = 0.5,
                                Color = Theme.Border
                            }
                        ):Play()
                        CreateTween(
                            ButtonIcon,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                            {
                                Size = UDim2.fromOffset(8, 8)
                            }
                        ):Play()
                        CreateTween(
                            ButtonTitleLabel,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                            {
                                TextColor3 = Theme.Text
                            }
                        ):Play()
                    end
                end

                ButtonClick.MouseEnter:Connect(
                    function()
                        AnimateButton(true)
                    end
                )

                ButtonClick.MouseLeave:Connect(
                    function()
                        AnimateButton(false)
                    end
                )

                ButtonClick.MouseButton1Click:Connect(
                    function()
                        CreateTween(
                            ButtonFrame,
                            TweenInfo.new(0.1, Enum.EasingStyle.Quad),
                            {
                                Size = UDim2.new(1, -4, 0, ButtonDesc ~= "" and 61 or 41)
                            }
                        ):Play()
                        task.wait(0.1)
                        CreateTween(
                            ButtonFrame,
                            TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                            {
                                Size = UDim2.new(1, 0, 0, ButtonDesc ~= "" and 65 or 45)
                            }
                        ):Play()

                        if ButtonConfirm then
                            CreateConfirmDialog(ButtonCallback)
                        else
                            if ButtonCallback then
                                task.spawn(ButtonCallback)
                            end
                        end
                    end
                )

                return ButtonFrame
            end

            function Section:AddToggle(toggleId, config)
                local ToggleTitle = config.Title or "Toggle"
                local ToggleDesc = config.Description or ""
                local ToggleDefault = config.Default or false
                local ToggleCallback = config.Callback or function()
                    end
                local ToggleConfirm = config.Confirm or false

                local isToggled = ToggleDefault

                local ToggleFrame = Instance.new("Frame")
                ToggleFrame.Parent = SectionContent
                ToggleFrame.BackgroundColor3 = Theme.Tertiary
                ToggleFrame.BackgroundTransparency = 0.15
                ToggleFrame.BorderSizePixel = 0
                ToggleFrame.Size = UDim2.new(1, 0, 0, ToggleDesc ~= "" and 65 or 45)

                local ToggleCorner = Instance.new("UICorner")
                ToggleCorner.CornerRadius = UDim.new(0, 12)
                ToggleCorner.Parent = ToggleFrame

                local ToggleStroke = Instance.new("UIStroke")
                ToggleStroke.Color = Theme.Border
                ToggleStroke.Thickness = 1
                ToggleStroke.Transparency = 0.5
                ToggleStroke.Parent = ToggleFrame

                local ToggleGradient = Instance.new("UIGradient")
                ToggleGradient.Color =
                    ColorSequence.new {
                    ColorSequenceKeypoint.new(0, Theme.Tertiary),
                    ColorSequenceKeypoint.new(
                        1,
                        Color3.fromRGB(
                            math.min(255, Theme.Tertiary.R * 255 + 6),
                            math.min(255, Theme.Tertiary.G * 255 + 6),
                            math.min(255, Theme.Tertiary.B * 255 + 6)
                        )
                    )
                }
                ToggleGradient.Rotation = 45
                ToggleGradient.Parent = ToggleFrame

                local ToggleTitleLabel = Instance.new("TextLabel")
                ToggleTitleLabel.Parent = ToggleFrame
                ToggleTitleLabel.BackgroundTransparency = 1
                ToggleTitleLabel.Size = UDim2.new(1, -70, 0, 20)
                ToggleTitleLabel.Position = UDim2.fromOffset(15, ToggleDesc ~= "" and 8 or 12)
                ToggleTitleLabel.Text = ToggleTitle
                ToggleTitleLabel.TextColor3 = Theme.Text
                ToggleTitleLabel.TextSize = 14
                ToggleTitleLabel.Font = Enum.Font.GothamSemibold
                ToggleTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
                ToggleTitleLabel.TextTruncate = Enum.TextTruncate.AtEnd

                local ToggleDescLabel = nil
                if ToggleDesc ~= "" then
                    ToggleDescLabel = Instance.new("TextLabel")
                    ToggleDescLabel.Parent = ToggleFrame
                    ToggleDescLabel.BackgroundTransparency = 1
                    ToggleDescLabel.Size = UDim2.new(1, -70, 0, 32)
                    ToggleDescLabel.Position = UDim2.fromOffset(15, 26)
                    ToggleDescLabel.Text = ToggleDesc
                    ToggleDescLabel.TextColor3 = Theme.SubText
                    ToggleDescLabel.TextSize = 12
                    ToggleDescLabel.Font = Enum.Font.Gotham
                    ToggleDescLabel.TextXAlignment = Enum.TextXAlignment.Left
                    ToggleDescLabel.TextYAlignment = Enum.TextYAlignment.Top
                    ToggleDescLabel.TextWrapped = true
                    ToggleDescLabel.TextTruncate = Enum.TextTruncate.AtEnd
                end

                local ToggleSwitch = Instance.new("Frame")
                ToggleSwitch.Parent = ToggleFrame
                ToggleSwitch.BackgroundColor3 = isToggled and Theme.Accent or Theme.Secondary
                ToggleSwitch.BackgroundTransparency = isToggled and 0.1 or 0.2
                ToggleSwitch.BorderSizePixel = 0
                ToggleSwitch.Size = UDim2.fromOffset(42, 22)
                ToggleSwitch.Position = UDim2.new(1, -52, 0.5, -11)

                local ToggleSwitchCorner = Instance.new("UICorner")
                ToggleSwitchCorner.CornerRadius = UDim.new(1, 0)
                ToggleSwitchCorner.Parent = ToggleSwitch

                local ToggleSwitchStroke = Instance.new("UIStroke")
                ToggleSwitchStroke.Color = isToggled and Theme.Accent or Theme.Border
                ToggleSwitchStroke.Thickness = 1
                ToggleSwitchStroke.Transparency = 0.4
                ToggleSwitchStroke.Parent = ToggleSwitch

                local ToggleKnob = Instance.new("Frame")
                ToggleKnob.Parent = ToggleSwitch
                ToggleKnob.BackgroundColor3 = Theme.Text
                ToggleKnob.BackgroundTransparency = 0
                ToggleKnob.BorderSizePixel = 0
                ToggleKnob.Size = UDim2.fromOffset(16, 16)
                ToggleKnob.Position = UDim2.fromOffset(isToggled and 23 or 3, 3)

                local ToggleKnobCorner = Instance.new("UICorner")
                ToggleKnobCorner.CornerRadius = UDim.new(1, 0)
                ToggleKnobCorner.Parent = ToggleKnob

                local ToggleKnobStroke = Instance.new("UIStroke")
                ToggleKnobStroke.Color = isToggled and Theme.Accent or Theme.Border
                ToggleKnobStroke.Thickness = 2
                ToggleKnobStroke.Transparency = 0.3
                ToggleKnobStroke.Parent = ToggleKnob

                local ToggleKnobGradient = Instance.new("UIGradient")
                ToggleKnobGradient.Color =
                    ColorSequence.new {
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(240, 240, 240))
                }
                ToggleKnobGradient.Rotation = 90
                ToggleKnobGradient.Parent = ToggleKnob

                local ToggleClick = Instance.new("TextButton")
                ToggleClick.Parent = ToggleFrame
                ToggleClick.BackgroundTransparency = 1
                ToggleClick.Size = UDim2.new(1, 0, 1, 0)
                ToggleClick.Text = ""

                local function CreateToggleConfirmDialog(newState, callback)
                    local ConfirmFrame = Instance.new("Frame")
                    ConfirmFrame.Name = "ToggleConfirmDialog"
                    ConfirmFrame.Parent = ScreenGui
                    ConfirmFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                    ConfirmFrame.BackgroundTransparency = 0.5
                    ConfirmFrame.BorderSizePixel = 0
                    ConfirmFrame.Size = UDim2.new(1, 0, 1, 0)
                    ConfirmFrame.Position = UDim2.new(0, 0, 0, 0)
                    ConfirmFrame.ZIndex = 1000

                    local ConfirmDialog = Instance.new("Frame")
                    ConfirmDialog.Parent = ConfirmFrame
                    ConfirmDialog.BackgroundColor3 = Theme.Primary
                    ConfirmDialog.BackgroundTransparency = 0.05
                    ConfirmDialog.BorderSizePixel = 0
                    ConfirmDialog.Size = UDim2.fromOffset(300, 150)
                    ConfirmDialog.Position = UDim2.fromScale(0.5, 0.5)
                    ConfirmDialog.AnchorPoint = Vector2.new(0.5, 0.5)

                    local ConfirmCorner = Instance.new("UICorner")
                    ConfirmCorner.CornerRadius = UDim.new(0, 16)
                    ConfirmCorner.Parent = ConfirmDialog

                    local ConfirmStroke = Instance.new("UIStroke")
                    ConfirmStroke.Color = Theme.Border
                    ConfirmStroke.Thickness = 1
                    ConfirmStroke.Transparency = 0.3
                    ConfirmStroke.Parent = ConfirmDialog

                    local ConfirmTitle = Instance.new("TextLabel")
                    ConfirmTitle.Parent = ConfirmDialog
                    ConfirmTitle.BackgroundTransparency = 1
                    ConfirmTitle.Size = UDim2.new(1, -40, 0, 30)
                    ConfirmTitle.Position = UDim2.fromOffset(20, 15)
                    ConfirmTitle.Text = "Confirm Toggle"
                    ConfirmTitle.TextColor3 = Theme.Text
                    ConfirmTitle.TextSize = 16
                    ConfirmTitle.Font = Enum.Font.GothamBold
                    ConfirmTitle.TextXAlignment = Enum.TextXAlignment.Left

                    local ConfirmText = Instance.new("TextLabel")
                    ConfirmText.Parent = ConfirmDialog
                    ConfirmText.BackgroundTransparency = 1
                    ConfirmText.Size = UDim2.new(1, -40, 0, 40)
                    ConfirmText.Position = UDim2.fromOffset(20, 45)
                    ConfirmText.Text =
                        "Are you sure you want to " .. (newState and "enable" or "disable") .. " this toggle?"
                    ConfirmText.TextColor3 = Theme.SubText
                    ConfirmText.TextSize = 13
                    ConfirmText.Font = Enum.Font.Gotham
                    ConfirmText.TextXAlignment = Enum.TextXAlignment.Left
                    ConfirmText.TextYAlignment = Enum.TextYAlignment.Top
                    ConfirmText.TextWrapped = true

                    local ButtonsContainer = Instance.new("Frame")
                    ButtonsContainer.Parent = ConfirmDialog
                    ButtonsContainer.BackgroundTransparency = 1
                    ButtonsContainer.Size = UDim2.new(1, -40, 0, 35)
                    ButtonsContainer.Position = UDim2.fromOffset(20, 95)

                    local ButtonsLayout = Instance.new("UIListLayout")
                    ButtonsLayout.Parent = ButtonsContainer
                    ButtonsLayout.FillDirection = Enum.FillDirection.Horizontal
                    ButtonsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
                    ButtonsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
                    ButtonsLayout.Padding = UDim.new(0, 10)

                    local CancelButton = Instance.new("TextButton")
                    CancelButton.Parent = ButtonsContainer
                    CancelButton.BackgroundColor3 = Theme.Secondary
                    CancelButton.BackgroundTransparency = 0.1
                    CancelButton.BorderSizePixel = 0
                    CancelButton.Size = UDim2.fromOffset(80, 30)
                    CancelButton.Text = "Cancel"
                    CancelButton.TextColor3 = Theme.Text
                    CancelButton.TextSize = 12
                    CancelButton.Font = Enum.Font.GothamMedium

                    local CancelCorner = Instance.new("UICorner")
                    CancelCorner.CornerRadius = UDim.new(0, 8)
                    CancelCorner.Parent = CancelButton

                    local ConfirmButton = Instance.new("TextButton")
                    ConfirmButton.Parent = ButtonsContainer
                    ConfirmButton.BackgroundColor3 = Theme.Accent
                    ConfirmButton.BackgroundTransparency = 0.1
                    ConfirmButton.BorderSizePixel = 0
                    ConfirmButton.Size = UDim2.fromOffset(80, 30)
                    ConfirmButton.Text = "Confirm"
                    ConfirmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    ConfirmButton.TextSize = 12
                    ConfirmButton.Font = Enum.Font.GothamMedium

                    local ConfirmButtonCorner = Instance.new("UICorner")
                    ConfirmButtonCorner.CornerRadius = UDim.new(0, 8)
                    ConfirmButtonCorner.Parent = ConfirmButton

                    ConfirmDialog.Size = UDim2.fromOffset(0, 0)
                    CreateTween(
                        ConfirmDialog,
                        TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                        {
                            Size = UDim2.fromOffset(300, 150)
                        }
                    ):Play()

                    CancelButton.MouseButton1Click:Connect(
                        function()
                            CreateTween(
                                ConfirmDialog,
                                TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
                                {
                                    Size = UDim2.fromOffset(0, 0)
                                }
                            ):Play()
                            task.wait(0.2)
                            ConfirmFrame:Destroy()
                        end
                    )

                    ConfirmButton.MouseButton1Click:Connect(
                        function()
                            CreateTween(
                                ConfirmDialog,
                                TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
                                {
                                    Size = UDim2.fromOffset(0, 0)
                                }
                            ):Play()
                            task.wait(0.2)
                            ConfirmFrame:Destroy()
                            if callback then
                                callback(newState)
                            end
                        end
                    )

                    ConfirmFrame.MouseButton1Click:Connect(
                        function()
                            CreateTween(
                                ConfirmDialog,
                                TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
                                {
                                    Size = UDim2.fromOffset(0, 0)
                                }
                            ):Play()
                            task.wait(0.2)
                            ConfirmFrame:Destroy()
                        end
                    )
                end

                local function UpdateToggle(newState)
                    isToggled = newState

                    CreateTween(
                        ToggleSwitch,
                        TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                        {
                            BackgroundColor3 = isToggled and Theme.Accent or Theme.Secondary,
                            BackgroundTransparency = isToggled and 0.1 or 0.2
                        }
                    ):Play()

                    CreateTween(
                        ToggleSwitchStroke,
                        TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                        {
                            Color = isToggled and Theme.Accent or Theme.Border
                        }
                    ):Play()

                    CreateTween(
                        ToggleKnob,
                        TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                        {
                            Position = UDim2.fromOffset(isToggled and 23 or 3, 3)
                        }
                    ):Play()

                    CreateTween(
                        ToggleKnobStroke,
                        TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                        {
                            Color = isToggled and Theme.Accent or Theme.Border
                        }
                    ):Play()

                    if isToggled then
                        CreateTween(
                            ToggleKnob,
                            TweenInfo.new(0.1, Enum.EasingStyle.Quad),
                            {
                                Size = UDim2.fromOffset(18, 18)
                            }
                        ):Play()
                        task.wait(0.1)
                        CreateTween(
                            ToggleKnob,
                            TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                            {
                                Size = UDim2.fromOffset(16, 16)
                            }
                        ):Play()
                    end

                    if ToggleCallback then
                        task.spawn(ToggleCallback, isToggled)
                    end
                end

                local function AnimateToggle(isEnter)
                    if isEnter then
                        CreateTween(
                            ToggleFrame,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                            {
                                BackgroundTransparency = 0.05
                            }
                        ):Play()
                        CreateTween(
                            ToggleStroke,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                            {
                                Transparency = 0.2
                            }
                        ):Play()
                    else
                        CreateTween(
                            ToggleFrame,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                            {
                                BackgroundTransparency = 0.15
                            }
                        ):Play()
                        CreateTween(
                            ToggleStroke,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                            {
                                Transparency = 0.5
                            }
                        ):Play()
                    end
                end

                ToggleClick.MouseEnter:Connect(
                    function()
                        AnimateToggle(true)
                    end
                )

                ToggleClick.MouseLeave:Connect(
                    function()
                        AnimateToggle(false)
                    end
                )

                ToggleClick.MouseButton1Click:Connect(
                    function()
                        if ToggleConfirm then
                            CreateToggleConfirmDialog(not isToggled, UpdateToggle)
                        else
                            UpdateToggle(not isToggled)
                        end
                    end
                )

                if isToggled and ToggleCallback then
                    task.spawn(ToggleCallback, isToggled)
                end

                return {
                    Frame = ToggleFrame,
                    SetValue = function(value)
                        UpdateToggle(value)
                    end,
                    GetValue = function()
                        return isToggled
                    end
                }
            end

            function Section:AddSlider(sliderId, config)
                local SliderTitle = config.Title or "Slider"
                local SliderDesc = config.Description or ""
                local SliderMin = config.Min or 0
                local SliderMax = config.Max or 100
                local SliderDefault = config.Default or SliderMin
                local SliderRounding = config.Rounding or 1
                local SliderCallback = config.Callback or function()
                    end

                local currentValue = SliderDefault

                local SliderFrame = Instance.new("Frame")
                SliderFrame.Parent = SectionContent
                SliderFrame.BackgroundColor3 = Theme.Tertiary
                SliderFrame.BackgroundTransparency = 0.15
                SliderFrame.BorderSizePixel = 0
                SliderFrame.Size = UDim2.new(1, 0, 0, SliderDesc ~= "" and 80 or 60)

                local SliderCorner = Instance.new("UICorner")
                SliderCorner.CornerRadius = UDim.new(0, 12)
                SliderCorner.Parent = SliderFrame

                local SliderStroke = Instance.new("UIStroke")
                SliderStroke.Color = Theme.Border
                SliderStroke.Thickness = 1
                SliderStroke.Transparency = 0.5
                SliderStroke.Parent = SliderFrame

                local SliderGradient = Instance.new("UIGradient")
                SliderGradient.Color =
                    ColorSequence.new {
                    ColorSequenceKeypoint.new(0, Theme.Tertiary),
                    ColorSequenceKeypoint.new(
                        1,
                        Color3.fromRGB(
                            math.min(255, Theme.Tertiary.R * 255 + 6),
                            math.min(255, Theme.Tertiary.G * 255 + 6),
                            math.min(255, Theme.Tertiary.B * 255 + 6)
                        )
                    )
                }
                SliderGradient.Rotation = 45
                SliderGradient.Parent = SliderFrame

                local SliderTitleLabel = Instance.new("TextLabel")
                SliderTitleLabel.Parent = SliderFrame
                SliderTitleLabel.BackgroundTransparency = 1
                SliderTitleLabel.Size = UDim2.new(1, -80, 0, 20)
                SliderTitleLabel.Position = UDim2.fromOffset(15, SliderDesc ~= "" and 8 or 12)
                SliderTitleLabel.Text = SliderTitle
                SliderTitleLabel.TextColor3 = Theme.Text
                SliderTitleLabel.TextSize = 14
                SliderTitleLabel.Font = Enum.Font.GothamSemibold
                SliderTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
                SliderTitleLabel.TextTruncate = Enum.TextTruncate.AtEnd

                local SliderValueLabel = Instance.new("TextLabel")
                SliderValueLabel.Parent = SliderFrame
                SliderValueLabel.BackgroundTransparency = 1
                SliderValueLabel.Size = UDim2.new(0, 60, 0, 20)
                SliderValueLabel.Position = UDim2.new(1, -70, 0, SliderDesc ~= "" and 8 or 12)
                SliderValueLabel.Text = tostring(currentValue)
                SliderValueLabel.TextColor3 = Theme.Accent
                SliderValueLabel.TextSize = 13
                SliderValueLabel.Font = Enum.Font.GothamMedium
                SliderValueLabel.TextXAlignment = Enum.TextXAlignment.Right

                local SliderDescLabel = nil
                if SliderDesc ~= "" then
                    SliderDescLabel = Instance.new("TextLabel")
                    SliderDescLabel.Parent = SliderFrame
                    SliderDescLabel.BackgroundTransparency = 1
                    SliderDescLabel.Size = UDim2.new(1, -30, 0, 15)
                    SliderDescLabel.Position = UDim2.fromOffset(15, 28)
                    SliderDescLabel.Text = SliderDesc
                    SliderDescLabel.TextColor3 = Theme.SubText
                    SliderDescLabel.TextSize = 11
                    SliderDescLabel.Font = Enum.Font.Gotham
                    SliderDescLabel.TextXAlignment = Enum.TextXAlignment.Left
                    SliderDescLabel.TextTruncate = Enum.TextTruncate.AtEnd
                end

                local SliderTrack = Instance.new("Frame")
                SliderTrack.Parent = SliderFrame
                SliderTrack.BackgroundColor3 = Theme.Secondary
                SliderTrack.BackgroundTransparency = 0.2
                SliderTrack.BorderSizePixel = 0
                SliderTrack.Size = UDim2.new(1, -30, 0, 6)
                SliderTrack.Position = UDim2.fromOffset(15, SliderDesc ~= "" and 55 or 35)

                local SliderTrackCorner = Instance.new("UICorner")
                SliderTrackCorner.CornerRadius = UDim.new(1, 0)
                SliderTrackCorner.Parent = SliderTrack

                local SliderFill = Instance.new("Frame")
                SliderFill.Parent = SliderTrack
                SliderFill.BackgroundColor3 = Theme.Accent
                SliderFill.BackgroundTransparency = 0.1
                SliderFill.BorderSizePixel = 0
                SliderFill.Size = UDim2.new((currentValue - SliderMin) / (SliderMax - SliderMin), 0, 1, 0)
                SliderFill.Position = UDim2.new(0, 0, 0, 0)

                local SliderFillCorner = Instance.new("UICorner")
                SliderFillCorner.CornerRadius = UDim.new(1, 0)
                SliderFillCorner.Parent = SliderFill

                local SliderKnob = Instance.new("Frame")
                SliderKnob.Parent = SliderTrack
                SliderKnob.BackgroundColor3 = Theme.Text
                SliderKnob.BackgroundTransparency = 0
                SliderKnob.BorderSizePixel = 0
                SliderKnob.Size = UDim2.fromOffset(16, 16)
                SliderKnob.Position = UDim2.new((currentValue - SliderMin) / (SliderMax - SliderMin), -8, 0.5, -8)

                local SliderKnobCorner = Instance.new("UICorner")
                SliderKnobCorner.CornerRadius = UDim.new(1, 0)
                SliderKnobCorner.Parent = SliderKnob

                local SliderKnobStroke = Instance.new("UIStroke")
                SliderKnobStroke.Color = Theme.Accent
                SliderKnobStroke.Thickness = 2
                SliderKnobStroke.Transparency = 0.2
                SliderKnobStroke.Parent = SliderKnob

                local SliderKnobGradient = Instance.new("UIGradient")
                SliderKnobGradient.Color =
                    ColorSequence.new {
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(240, 240, 240))
                }
                SliderKnobGradient.Rotation = 90
                SliderKnobGradient.Parent = SliderKnob

                local isDragging = false

                local function UpdateSlider(value)
                    value = math.clamp(value, SliderMin, SliderMax)
                    if SliderRounding then
                        value = math.round(value / SliderRounding) * SliderRounding
                    end
                    currentValue = value

                    local percentage = (value - SliderMin) / (SliderMax - SliderMin)

                    CreateTween(
                        SliderFill,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                        {
                            Size = UDim2.new(percentage, 0, 1, 0)
                        }
                    ):Play()

                    CreateTween(
                        SliderKnob,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                        {
                            Position = UDim2.new(percentage, -8, 0.5, -8)
                        }
                    ):Play()

                    SliderValueLabel.Text = tostring(value)

                    if SliderCallback then
                        task.spawn(SliderCallback, value)
                    end
                end

                local function StartDrag()
                    isDragging = true
                    CreateTween(
                        SliderKnob,
                        TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                        {
                            Size = UDim2.fromOffset(20, 20)
                        }
                    ):Play()
                    CreateTween(
                        SliderKnobStroke,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                        {
                            Transparency = 0
                        }
                    ):Play()
                end

                local function StopDrag()
                    isDragging = false
                    CreateTween(
                        SliderKnob,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                        {
                            Size = UDim2.fromOffset(16, 16)
                        }
                    ):Play()
                    CreateTween(
                        SliderKnobStroke,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                        {
                            Transparency = 0.2
                        }
                    ):Play()
                end

                SliderKnob.InputBegan:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            StartDrag()
                        end
                    end
                )

                SliderTrack.InputBegan:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            local mouse = Players.LocalPlayer:GetMouse()
                            local trackPosition = SliderTrack.AbsolutePosition.X
                            local trackSize = SliderTrack.AbsoluteSize.X
                            local mouseX = mouse.X
                            local percentage = math.clamp((mouseX - trackPosition) / trackSize, 0, 1)
                            local value = SliderMin + (SliderMax - SliderMin) * percentage
                            UpdateSlider(value)
                            StartDrag()
                        end
                    end
                )

                UserInputService.InputChanged:Connect(
                    function(input)
                        if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                            local mouse = Players.LocalPlayer:GetMouse()
                            local trackPosition = SliderTrack.AbsolutePosition.X
                            local trackSize = SliderTrack.AbsoluteSize.X
                            local mouseX = mouse.X
                            local percentage = math.clamp((mouseX - trackPosition) / trackSize, 0, 1)
                            local value = SliderMin + (SliderMax - SliderMin) * percentage
                            UpdateSlider(value)
                        end
                    end
                )

                UserInputService.InputEnded:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 and isDragging then
                            StopDrag()
                        end
                    end
                )

                UpdateSlider(currentValue)

                return {
                    Frame = SliderFrame,
                    SetValue = function(value)
                        UpdateSlider(value)
                    end,
                    GetValue = function()
                        return currentValue
                    end
                }
            end

            function Section:AddDropdown(dropdownId, config)
                local DropdownTitle = config.Title or "Dropdown"
                local DropdownDesc = config.Description or ""
                local DropdownValues = config.Values or {"Option 1", "Option 2", "Option 3"}
                local DropdownMulti = config.Multi or false
                local DropdownDefault = config.Default or (DropdownMulti and {} or 1)
                local DropdownCallback = config.Callback or function()
                    end

                local selectedValues = {}
                if DropdownMulti then
                    if type(DropdownDefault) == "table" then
                        for _, value in pairs(DropdownDefault) do
                            selectedValues[value] = true
                        end
                    end
                else
                    if type(DropdownDefault) == "number" then
                        selectedValues = DropdownValues[DropdownDefault] or DropdownValues[1]
                    else
                        selectedValues = DropdownDefault or DropdownValues[1]
                    end
                end

                local isOpen = false

                local DropdownFrame = Instance.new("Frame")
                DropdownFrame.Parent = SectionContent
                DropdownFrame.BackgroundColor3 = Theme.Tertiary
                DropdownFrame.BackgroundTransparency = 0.15
                DropdownFrame.BorderSizePixel = 0
                DropdownFrame.Size = UDim2.new(1, 0, 0, DropdownDesc ~= "" and 65 or 45)
                DropdownFrame.ClipsDescendants = true

                local DropdownCorner = Instance.new("UICorner")
                DropdownCorner.CornerRadius = UDim.new(0, 12)
                DropdownCorner.Parent = DropdownFrame

                local DropdownStroke = Instance.new("UIStroke")
                DropdownStroke.Color = Theme.Border
                DropdownStroke.Thickness = 1
                DropdownStroke.Transparency = 0.5
                DropdownStroke.Parent = DropdownFrame

                local DropdownGradient = Instance.new("UIGradient")
                DropdownGradient.Color =
                    ColorSequence.new {
                    ColorSequenceKeypoint.new(0, Theme.Tertiary),
                    ColorSequenceKeypoint.new(
                        1,
                        Color3.fromRGB(
                            math.min(255, Theme.Tertiary.R * 255 + 6),
                            math.min(255, Theme.Tertiary.G * 255 + 6),
                            math.min(255, Theme.Tertiary.B * 255 + 6)
                        )
                    )
                }
                DropdownGradient.Rotation = 45
                DropdownGradient.Parent = DropdownFrame

                local DropdownTitleLabel = Instance.new("TextLabel")
                DropdownTitleLabel.Parent = DropdownFrame
                DropdownTitleLabel.BackgroundTransparency = 1
                DropdownTitleLabel.Size = UDim2.new(1, -50, 0, 20)
                DropdownTitleLabel.Position = UDim2.fromOffset(15, DropdownDesc ~= "" and 8 or 12)
                DropdownTitleLabel.Text = DropdownTitle
                DropdownTitleLabel.TextColor3 = Theme.Text
                DropdownTitleLabel.TextSize = 14
                DropdownTitleLabel.Font = Enum.Font.GothamSemibold
                DropdownTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
                DropdownTitleLabel.TextTruncate = Enum.TextTruncate.AtEnd

                local DropdownDescLabel = nil
                if DropdownDesc ~= "" then
                    DropdownDescLabel = Instance.new("TextLabel")
                    DropdownDescLabel.Parent = DropdownFrame
                    DropdownDescLabel.BackgroundTransparency = 1
                    DropdownDescLabel.Size = UDim2.new(1, -50, 0, 15)
                    DropdownDescLabel.Position = UDim2.fromOffset(15, 26)
                    DropdownDescLabel.Text = DropdownDesc
                    DropdownDescLabel.TextColor3 = Theme.SubText
                    DropdownDescLabel.TextSize = 11
                    DropdownDescLabel.Font = Enum.Font.Gotham
                    DropdownDescLabel.TextXAlignment = Enum.TextXAlignment.Left
                    DropdownDescLabel.TextTruncate = Enum.TextTruncate.AtEnd
                end

                local DropdownArrow = Instance.new("TextLabel")
                DropdownArrow.Parent = DropdownFrame
                DropdownArrow.BackgroundTransparency = 1
                DropdownArrow.Size = UDim2.fromOffset(20, 20)
                DropdownArrow.Position = UDim2.new(1, -30, 0, DropdownDesc ~= "" and 8 or 12)
                DropdownArrow.Text = "⌄"
                DropdownArrow.TextColor3 = Theme.SubText
                DropdownArrow.TextSize = 16
                DropdownArrow.Font = Enum.Font.GothamBold
                DropdownArrow.TextXAlignment = Enum.TextXAlignment.Center

                local DropdownValueLabel = Instance.new("TextLabel")
                DropdownValueLabel.Parent = DropdownFrame
                DropdownValueLabel.BackgroundTransparency = 1
                DropdownValueLabel.Size = UDim2.new(1, -70, 0, 15)
                DropdownValueLabel.Position = UDim2.fromOffset(15, DropdownDesc ~= "" and 43 or 23)
                DropdownValueLabel.TextColor3 = Theme.Accent
                DropdownValueLabel.TextSize = 12
                DropdownValueLabel.Font = Enum.Font.GothamMedium
                DropdownValueLabel.TextXAlignment = Enum.TextXAlignment.Left
                DropdownValueLabel.TextTruncate = Enum.TextTruncate.AtEnd

                local DropdownList = Instance.new("Frame")
                DropdownList.Parent = DropdownFrame
                DropdownList.BackgroundColor3 = Theme.Secondary
                DropdownList.BackgroundTransparency = 0.05
                DropdownList.BorderSizePixel = 0
                DropdownList.Size = UDim2.new(1, -10, 0, 0)
                DropdownList.Position = UDim2.fromOffset(5, DropdownDesc ~= "" and 60 or 40)

                local DropdownListCorner = Instance.new("UICorner")
                DropdownListCorner.CornerRadius = UDim.new(0, 8)
                DropdownListCorner.Parent = DropdownList

                local DropdownListStroke = Instance.new("UIStroke")
                DropdownListStroke.Color = Theme.Border
                DropdownListStroke.Thickness = 1
                DropdownListStroke.Transparency = 0.3
                DropdownListStroke.Parent = DropdownList

                local DropdownScrolling = Instance.new("ScrollingFrame")
                DropdownScrolling.Parent = DropdownList
                DropdownScrolling.BackgroundTransparency = 1
                DropdownScrolling.BorderSizePixel = 0
                DropdownScrolling.Size = UDim2.new(1, 0, 1, 0)
                DropdownScrolling.Position = UDim2.new(0, 0, 0, 0)
                DropdownScrolling.ScrollBarThickness = 4
                DropdownScrolling.ScrollBarImageColor3 = Theme.Accent
                DropdownScrolling.ScrollBarImageTransparency = 0.5
                DropdownScrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
                DropdownScrolling.AutomaticCanvasSize = Enum.AutomaticSize.Y

                local DropdownLayout = Instance.new("UIListLayout")
                DropdownLayout.Parent = DropdownScrolling
                DropdownLayout.FillDirection = Enum.FillDirection.Vertical
                DropdownLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
                DropdownLayout.VerticalAlignment = Enum.VerticalAlignment.Top
                DropdownLayout.Padding = UDim.new(0, 2)
                DropdownLayout.SortOrder = Enum.SortOrder.LayoutOrder

                local DropdownListPadding = Instance.new("UIPadding")
                DropdownListPadding.Parent = DropdownScrolling
                DropdownListPadding.PaddingTop = UDim.new(0, 5)
                DropdownListPadding.PaddingBottom = UDim.new(0, 5)
                DropdownListPadding.PaddingLeft = UDim.new(0, 5)
                DropdownListPadding.PaddingRight = UDim.new(0, 5)

                local DropdownClick = Instance.new("TextButton")
                DropdownClick.Parent = DropdownFrame
                DropdownClick.BackgroundTransparency = 1
                DropdownClick.Size = UDim2.new(1, 0, 0, DropdownDesc ~= "" and 65 or 45)
                DropdownClick.Position = UDim2.new(0, 0, 0, 0)
                DropdownClick.Text = ""

                local function UpdateDropdownText()
                    if DropdownMulti then
                        local selected = {}
                        for value, isSelected in pairs(selectedValues) do
                            if isSelected then
                                table.insert(selected, value)
                            end
                        end
                        if #selected == 0 then
                            DropdownValueLabel.Text = "None selected"
                        elseif #selected == 1 then
                            DropdownValueLabel.Text = selected[1]
                        else
                            DropdownValueLabel.Text = selected[1] .. " + " .. (#selected - 1) .. " more"
                        end
                    else
                        DropdownValueLabel.Text = selectedValues or "None selected"
                    end
                end

                local function CreateDropdownOption(value, index)
                    local OptionFrame = Instance.new("Frame")
                    OptionFrame.Parent = DropdownScrolling
                    OptionFrame.BackgroundColor3 = Theme.Tertiary
                    OptionFrame.BackgroundTransparency = 0.8
                    OptionFrame.BorderSizePixel = 0
                    OptionFrame.Size = UDim2.new(1, 0, 0, 30)
                    OptionFrame.LayoutOrder = index

                    local OptionCorner = Instance.new("UICorner")
                    OptionCorner.CornerRadius = UDim.new(0, 6)
                    OptionCorner.Parent = OptionFrame

                    local OptionButton = Instance.new("TextButton")
                    OptionButton.Parent = OptionFrame
                    OptionButton.BackgroundTransparency = 1
                    OptionButton.Size = UDim2.new(1, 0, 1, 0)
                    OptionButton.Text = ""

                    local OptionLabel = Instance.new("TextLabel")
                    OptionLabel.Parent = OptionFrame
                    OptionLabel.BackgroundTransparency = 1
                    OptionLabel.Size = UDim2.new(1, DropdownMulti and -35 or -15, 1, 0)
                    OptionLabel.Position = UDim2.fromOffset(10, 0)
                    OptionLabel.Text = value
                    OptionLabel.TextColor3 = Theme.Text
                    OptionLabel.TextSize = 12
                    OptionLabel.Font = Enum.Font.GothamMedium
                    OptionLabel.TextXAlignment = Enum.TextXAlignment.Left
                    OptionLabel.TextTruncate = Enum.TextTruncate.AtEnd

                    local OptionCheckmark = nil
                    if DropdownMulti then
                        OptionCheckmark = Instance.new("Frame")
                        OptionCheckmark.Parent = OptionFrame
                        OptionCheckmark.BackgroundColor3 = Theme.Accent
                        OptionCheckmark.BackgroundTransparency = selectedValues[value] and 0.1 or 1
                        OptionCheckmark.BorderSizePixel = 0
                        OptionCheckmark.Size = UDim2.fromOffset(16, 16)
                        OptionCheckmark.Position = UDim2.new(1, -22, 0.5, -8)

                        local CheckmarkCorner = Instance.new("UICorner")
                        CheckmarkCorner.CornerRadius = UDim.new(0, 4)
                        CheckmarkCorner.Parent = OptionCheckmark

                        local CheckmarkStroke = Instance.new("UIStroke")
                        CheckmarkStroke.Color = Theme.Accent
                        CheckmarkStroke.Thickness = 1
                        CheckmarkStroke.Transparency = 0.3
                        CheckmarkStroke.Parent = OptionCheckmark

                        local CheckmarkIcon = Instance.new("TextLabel")
                        CheckmarkIcon.Parent = OptionCheckmark
                        CheckmarkIcon.BackgroundTransparency = 1
                        CheckmarkIcon.Size = UDim2.new(1, 0, 1, 0)
                        CheckmarkIcon.Text = "✓"
                        CheckmarkIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
                        CheckmarkIcon.TextSize = 12
                        CheckmarkIcon.Font = Enum.Font.GothamBold
                        CheckmarkIcon.TextXAlignment = Enum.TextXAlignment.Center
                        CheckmarkIcon.TextTransparency = selectedValues[value] and 0 or 1
                    end

                    local function UpdateOption()
                        if DropdownMulti then
                            local isSelected = selectedValues[value]
                            CreateTween(
                                OptionCheckmark,
                                TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                                {
                                    BackgroundTransparency = isSelected and 0.1 or 1
                                }
                            ):Play()
                            CreateTween(
                                CheckmarkIcon,
                                TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                                {
                                    TextTransparency = isSelected and 0 or 1
                                }
                            ):Play()
                        else
                            local isSelected = selectedValues == value
                            CreateTween(
                                OptionLabel,
                                TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                                {
                                    TextColor3 = isSelected and Theme.Accent or Theme.Text
                                }
                            ):Play()
                        end
                    end

                    OptionButton.MouseEnter:Connect(
                        function()
                            CreateTween(
                                OptionFrame,
                                TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                                {
                                    BackgroundTransparency = 0.6
                                }
                            ):Play()
                        end
                    )

                    OptionButton.MouseLeave:Connect(
                        function()
                            CreateTween(
                                OptionFrame,
                                TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                                {
                                    BackgroundTransparency = 0.8
                                }
                            ):Play()
                        end
                    )

                    OptionButton.MouseButton1Click:Connect(
                        function()
                            if DropdownMulti then
                                selectedValues[value] = not selectedValues[value]
                                UpdateOption()
                                UpdateDropdownText()
                                if DropdownCallback then
                                    local selected = {}
                                    for val, isSelected in pairs(selectedValues) do
                                        if isSelected then
                                            table.insert(selected, val)
                                        end
                                    end
                                    task.spawn(DropdownCallback, selected)
                                end
                            else
                                selectedValues = value
                                for _, option in pairs(DropdownScrolling:GetChildren()) do
                                    if option:IsA("Frame") and option.Name ~= "UIPadding" then
                                        local label = option:FindFirstChild("TextLabel")
                                        if label then
                                            CreateTween(
                                                label,
                                                TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                                                {
                                                    TextColor3 = Theme.Text
                                                }
                                            ):Play()
                                        end
                                    end
                                end
                                UpdateOption()
                                UpdateDropdownText()
                                ToggleDropdown()
                                if DropdownCallback then
                                    task.spawn(DropdownCallback, value)
                                end
                            end
                        end
                    )

                    UpdateOption()
                end

                local function ToggleDropdown()
                    isOpen = not isOpen
                    local targetSize = isOpen and math.min(#DropdownValues * 34 + 10, 150) or 0
                    local totalHeight = (DropdownDesc ~= "" and 65 or 45) + (isOpen and targetSize + 5 or 0)

                    CreateTween(
                        DropdownFrame,
                        TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                        {
                            Size = UDim2.new(1, 0, 0, totalHeight)
                        }
                    ):Play()

                    CreateTween(
                        DropdownList,
                        TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                        {
                            Size = UDim2.new(1, -10, 0, targetSize)
                        }
                    ):Play()

                    CreateTween(
                        DropdownArrow,
                        TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                        {
                            Rotation = isOpen and 180 or 0
                        }
                    ):Play()

                    CreateTween(
                        DropdownStroke,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                        {
                            Color = isOpen and Theme.Accent or Theme.Border,
                            Transparency = isOpen and 0.2 or 0.5
                        }
                    ):Play()
                end

                DropdownClick.MouseButton1Click:Connect(ToggleDropdown)

                for i, value in ipairs(DropdownValues) do
                    CreateDropdownOption(value, i)
                end

                UpdateDropdownText()

                return {
                    Frame = DropdownFrame,
                    SetValues = function(values)
                        for _, child in pairs(DropdownScrolling:GetChildren()) do
                            if child:IsA("Frame") then
                                child:Destroy()
                            end
                        end
                        DropdownValues = values
                        for i, value in ipairs(values) do
                            CreateDropdownOption(value, i)
                        end
                    end,
                    SetValue = function(value)
                        if DropdownMulti then
                            selectedValues = {}
                            if type(value) == "table" then
                                for _, val in pairs(value) do
                                    selectedValues[val] = true
                                end
                            end
                        else
                            selectedValues = value
                        end
                        for _, child in pairs(DropdownScrolling:GetChildren()) do
                            if child:IsA("Frame") then
                                child:Destroy()
                            end
                        end
                        for i, val in ipairs(DropdownValues) do
                            CreateDropdownOption(val, i)
                        end
                        UpdateDropdownText()
                    end,
                    GetValue = function()
                        if DropdownMulti then
                            local selected = {}
                            for value, isSelected in pairs(selectedValues) do
                                if isSelected then
                                    table.insert(selected, value)
                                end
                            end
                            return selected
                        else
                            return selectedValues
                        end
                    end
                }
            end

            function Section:AddInput(inputId, config)
                local InputTitle = config.Title or "Input"
                local InputDesc = config.Description or ""
                local InputDefault = config.Default or ""
                local InputPlaceholder = config.Placeholder or "Enter text..."
                local InputNumeric = config.Numeric or false
                local InputFinished = config.Finished or false
                local InputCallback = config.Callback or function()
                    end

                local currentValue = InputDefault

                local InputFrame = Instance.new("Frame")
                InputFrame.Parent = SectionContent
                InputFrame.BackgroundColor3 = Theme.Tertiary
                InputFrame.BackgroundTransparency = 0.15
                InputFrame.BorderSizePixel = 0
                InputFrame.Size = UDim2.new(1, 0, 0, InputDesc ~= "" and 75 or 55)

                local InputCorner = Instance.new("UICorner")
                InputCorner.CornerRadius = UDim.new(0, 12)
                InputCorner.Parent = InputFrame

                local InputStroke = Instance.new("UIStroke")
                InputStroke.Color = Theme.Border
                InputStroke.Thickness = 1
                InputStroke.Transparency = 0.5
                InputStroke.Parent = InputFrame

                local InputGradient = Instance.new("UIGradient")
                InputGradient.Color =
                    ColorSequence.new {
                    ColorSequenceKeypoint.new(0, Theme.Tertiary),
                    ColorSequenceKeypoint.new(
                        1,
                        Color3.fromRGB(
                            math.min(255, Theme.Tertiary.R * 255 + 6),
                            math.min(255, Theme.Tertiary.G * 255 + 6),
                            math.min(255, Theme.Tertiary.B * 255 + 6)
                        )
                    )
                }
                InputGradient.Rotation = 45
                InputGradient.Parent = InputFrame

                local InputTitleLabel = Instance.new("TextLabel")
                InputTitleLabel.Parent = InputFrame
                InputTitleLabel.BackgroundTransparency = 1
                InputTitleLabel.Size = UDim2.new(1, -30, 0, 20)
                InputTitleLabel.Position = UDim2.fromOffset(15, InputDesc ~= "" and 8 or 12)
                InputTitleLabel.Text = InputTitle
                InputTitleLabel.TextColor3 = Theme.Text
                InputTitleLabel.TextSize = 14
                InputTitleLabel.Font = Enum.Font.GothamSemibold
                InputTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
                InputTitleLabel.TextTruncate = Enum.TextTruncate.AtEnd

                local InputDescLabel = nil
                if InputDesc ~= "" then
                    InputDescLabel = Instance.new("TextLabel")
                    InputDescLabel.Parent = InputFrame
                    InputDescLabel.BackgroundTransparency = 1
                    InputDescLabel.Size = UDim2.new(1, -30, 0, 15)
                    InputDescLabel.Position = UDim2.fromOffset(15, 26)
                    InputDescLabel.Text = InputDesc
                    InputDescLabel.TextColor3 = Theme.SubText
                    InputDescLabel.TextSize = 11
                    InputDescLabel.Font = Enum.Font.Gotham
                    InputDescLabel.TextXAlignment = Enum.TextXAlignment.Left
                    InputDescLabel.TextTruncate = Enum.TextTruncate.AtEnd
                end

                local InputBox = Instance.new("TextBox")
                InputBox.Parent = InputFrame
                InputBox.BackgroundColor3 = Theme.Secondary
                InputBox.BackgroundTransparency = 0.1
                InputBox.BorderSizePixel = 0
                InputBox.Size = UDim2.new(1, -30, 0, 25)
                InputBox.Position = UDim2.fromOffset(15, InputDesc ~= "" and 45 or 25)
                InputBox.Text = InputDefault
                InputBox.PlaceholderText = InputPlaceholder
                InputBox.PlaceholderColor3 = Theme.SubText
                InputBox.TextColor3 = Theme.Text
                InputBox.TextSize = 12
                InputBox.Font = Enum.Font.Gotham
                InputBox.TextXAlignment = Enum.TextXAlignment.Left

                local InputBoxCorner = Instance.new("UICorner")
                InputBoxCorner.CornerRadius = UDim.new(0, 8)
                InputBoxCorner.Parent = InputBox

                local InputBoxStroke = Instance.new("UIStroke")
                InputBoxStroke.Color = Theme.Border
                InputBoxStroke.Thickness = 1
                InputBoxStroke.Transparency = 0.4
                InputBoxStroke.Parent = InputBox

                local InputBoxPadding = Instance.new("UIPadding")
                InputBoxPadding.Parent = InputBox
                InputBoxPadding.PaddingLeft = UDim.new(0, 10)
                InputBoxPadding.PaddingRight = UDim.new(0, 10)

                local function UpdateInput(value)
                    if InputNumeric then
                        local numValue = tonumber(value)
                        if numValue then
                            currentValue = tostring(numValue)
                            InputBox.Text = currentValue
                        else
                            InputBox.Text = currentValue
                        end
                    else
                        currentValue = value
                    end

                    if InputCallback and not InputFinished then
                        task.spawn(InputCallback, currentValue)
                    end
                end

                InputBox.Focused:Connect(
                    function()
                        CreateTween(
                            InputBoxStroke,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                            {
                                Color = Theme.Accent,
                                Transparency = 0.2
                            }
                        ):Play()
                        CreateTween(
                            InputStroke,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                            {
                                Color = Theme.Accent,
                                Transparency = 0.2
                            }
                        ):Play()
                    end
                )

                InputBox.FocusLost:Connect(
                    function(enterPressed)
                        CreateTween(
                            InputBoxStroke,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                            {
                                Color = Theme.Border,
                                Transparency = 0.4
                            }
                        ):Play()
                        CreateTween(
                            InputStroke,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad),
                            {
                                Color = Theme.Border,
                                Transparency = 0.5
                            }
                        ):Play()

                        if InputFinished and enterPressed and InputCallback then
                            task.spawn(InputCallback, currentValue)
                        end
                    end
                )

                if not InputFinished then
                    InputBox:GetPropertyChangedSignal("Text"):Connect(
                        function()
                            UpdateInput(InputBox.Text)
                        end
                    )
                else
                    InputBox.FocusLost:Connect(
                        function(enterPressed)
                            if enterPressed then
                                UpdateInput(InputBox.Text)
                            end
                        end
                    )
                end

                if InputNumeric then
                    InputBox:GetPropertyChangedSignal("Text"):Connect(
                        function()
                            local text = InputBox.Text
                            local newText = text:gsub("[^%d%.%-]", "")
                            if newText ~= text then
                                InputBox.Text = newText
                            end
                        end
                    )
                end

                return {
                    Frame = InputFrame,
                    SetValue = function(value)
                        InputBox.Text = tostring(value)
                        UpdateInput(tostring(value))
                    end,
                    GetValue = function()
                        return currentValue
                    end
                }
            end

            table.insert(Tab.Sections, Section)
            return Section
        end

        if not Window.Tabs then
            Window.Tabs = {}
        end
        table.insert(Window.Tabs, Tab)

        if #Window.Tabs == 1 then
            SwitchToTab(Tab)
        end

        return Tab
    end

    CreateTween(
        LoadingProgress,
        TweenInfo.new(LoadingTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {
            Size = UDim2.fromScale(1, 1)
        }
    ):Play()

    task.wait(LoadingTime)

    CreateTween(
        WelcomeFrame,
        TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
        {
            Size = UDim2.fromOffset(0, 0),
            Position = UDim2.fromScale(0.5, 0.5)
        }
    ):Play()

    task.wait(0.4)
    WelcomeFrame:Destroy()
    MainFrame.Visible = true
    MainFrame.Size = UDim2.fromOffset(0, 0)
    CreateTween(
        MainFrame,
        TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {
            Size = Size
        }
    ):Play()

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
