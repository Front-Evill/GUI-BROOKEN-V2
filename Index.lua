local UILibrary = {}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")
local plr = Players.LocalPlayer

function UILibrary:CreateWindow(options)
    local title = options.Title or "UI Window"
    local subtitle = options.SubTitle or ""
    local welcomeText = options.WelcomeText or "FRONT"
    local loadingTime = options.LoadingTime or 3
    local size = options.Size or UDim2.fromOffset(720, 480)
    local tabWidth = options.TabWidth or 200
    local acrylic = options.Acrylic ~= false
    local theme = options.Theme or "Dark"
    local minimizeKey = options.MinimizeKey or Enum.KeyCode.B
    local icon = options.Icon or "rbxasset://textures/ui/GuiImagePlaceholder.png"
    
    local ScreenGui = Instance.new("ScreenGui")
    local WelcomeFrame = Instance.new("Frame")
    local LoadingFrame = Instance.new("Frame")
    local MainFrame = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local DropShadow = Instance.new("ImageLabel")
    local TitleBar = Instance.new("Frame")
    local TitleLabel = Instance.new("TextLabel")
    local SubTitleLabel = Instance.new("TextLabel")
    local CloseButton = Instance.new("TextButton")
    local MinimizeButton = Instance.new("TextButton")
    local TabContainer = Instance.new("Frame")
    local TabButtons = Instance.new("Frame")
    local TabContent = Instance.new("Frame")
    local MinimizedFrame = Instance.new("ImageButton")
    local WindowIcon = Instance.new("ImageLabel")
    
    ScreenGui.Name = title
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    
    local function createWelcomeScreen()
        WelcomeFrame.Name = "WelcomeFrame"
        WelcomeFrame.Parent = ScreenGui
        WelcomeFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        WelcomeFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
        WelcomeFrame.BorderSizePixel = 0
        WelcomeFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        WelcomeFrame.Size = UDim2.new(1, 0, 1, 0)
        WelcomeFrame.Visible = true
        
        local WelcomeCorner = Instance.new("UICorner")
        WelcomeCorner.CornerRadius = UDim.new(0, 0)
        WelcomeCorner.Parent = WelcomeFrame
        
        local WelcomeGradient = Instance.new("UIGradient")
        WelcomeGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 35)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 15, 25)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 15))
        }
        WelcomeGradient.Rotation = 45
        WelcomeGradient.Parent = WelcomeFrame
        
        local WelcomeIcon = Instance.new("ImageLabel")
        WelcomeIcon.Name = "WelcomeIcon"
        WelcomeIcon.Parent = WelcomeFrame
        WelcomeIcon.AnchorPoint = Vector2.new(0.5, 0.5)
        WelcomeIcon.BackgroundTransparency = 1
        WelcomeIcon.Position = UDim2.new(0.5, 0, 0.35, 0)
        WelcomeIcon.Size = UDim2.new(0, 120, 0, 120)
        WelcomeIcon.Image = icon
        WelcomeIcon.ImageColor3 = Color3.fromRGB(130, 170, 255)
        WelcomeIcon.ImageTransparency = 0
        
        local IconCorner = Instance.new("UICorner")
        IconCorner.CornerRadius = UDim.new(0, 25)
        IconCorner.Parent = WelcomeIcon
        
        local IconStroke = Instance.new("UIStroke")
        IconStroke.Color = Color3.fromRGB(130, 170, 255)
        IconStroke.Thickness = 3
        IconStroke.Transparency = 0.6
        IconStroke.Parent = WelcomeIcon
        
        local WelcomeTitle = Instance.new("TextLabel")
        WelcomeTitle.Name = "WelcomeTitle"
        WelcomeTitle.Parent = WelcomeFrame
        WelcomeTitle.AnchorPoint = Vector2.new(0.5, 0.5)
        WelcomeTitle.BackgroundTransparency = 1
        WelcomeTitle.Position = UDim2.new(0.5, 0, 0.55, 0)
        WelcomeTitle.Size = UDim2.new(0, 600, 0, 50)
        WelcomeTitle.Font = Enum.Font.GothamBold
        WelcomeTitle.Text = "Welcome to " .. welcomeText
        WelcomeTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        WelcomeTitle.TextSize = 32
        WelcomeTitle.TextTransparency = 0
        
        local WelcomeSubtitle = Instance.new("TextLabel")
        WelcomeSubtitle.Name = "WelcomeSubtitle"
        WelcomeSubtitle.Parent = WelcomeFrame
        WelcomeSubtitle.AnchorPoint = Vector2.new(0.5, 0.5)
        WelcomeSubtitle.BackgroundTransparency = 1
        WelcomeSubtitle.Position = UDim2.new(0.5, 0, 0.62, 0)
        WelcomeSubtitle.Size = UDim2.new(0, 500, 0, 30)
        WelcomeSubtitle.Font = Enum.Font.Gotham
        WelcomeSubtitle.Text = "Loading interface..."
        WelcomeSubtitle.TextColor3 = Color3.fromRGB(180, 180, 190)
        WelcomeSubtitle.TextSize = 16
        WelcomeSubtitle.TextTransparency = 0
        
        task.spawn(function()
            local rotateConnection
            rotateConnection = RunService.Heartbeat:Connect(function()
                WelcomeIcon.Rotation = WelcomeIcon.Rotation + 2
            end)
            
            TweenService:Create(WelcomeIcon, TweenInfo.new(1, Enum.EasingStyle.Quart), {
                Size = UDim2.new(0, 140, 0, 140)
            }):Play()
            
            task.wait(loadingTime)
            
            if rotateConnection then
                rotateConnection:Disconnect()
            end
            
            TweenService:Create(WelcomeFrame, TweenInfo.new(0.8, Enum.EasingStyle.Quart), {
                Position = UDim2.new(0.5, 0, -0.5, 0),
                BackgroundTransparency = 1
            }):Play()
            
            TweenService:Create(WelcomeTitle, TweenInfo.new(0.8, Enum.EasingStyle.Quart), {
                TextTransparency = 1
            }):Play()
            
            TweenService:Create(WelcomeSubtitle, TweenInfo.new(0.8, Enum.EasingStyle.Quart), {
                TextTransparency = 1
            }):Play()
            
            TweenService:Create(WelcomeIcon, TweenInfo.new(0.8, Enum.EasingStyle.Quart), {
                ImageTransparency = 1
            }):Play()
            
            task.wait(0.8)
            WelcomeFrame:Destroy()
            
            DropShadow.Visible = true
            MainFrame.Visible = true
            
            TweenService:Create(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back), {
                Size = size,
                Position = UDim2.new(0.5, 0, 0.5, 0)
            }):Play()
            
            TweenService:Create(DropShadow, TweenInfo.new(0.6, Enum.EasingStyle.Back), {
                ImageTransparency = 0.2
            }):Play()
        end)
    end
    
    DropShadow.Name = "DropShadow"
    DropShadow.Parent = ScreenGui
    DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
    DropShadow.BackgroundTransparency = 1
    DropShadow.Position = UDim2.new(0.5, 0, 0.5, 4)
    DropShadow.Size = size + UDim2.fromOffset(40, 40)
    DropShadow.Image = "rbxasset://textures/ui/InGameMenu/dropshadow.png"
    DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    DropShadow.ImageTransparency = 1
    DropShadow.ScaleType = Enum.ScaleType.Slice
    DropShadow.SliceCenter = Rect.new(30, 30, 70, 70)
    DropShadow.Visible = false
    
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = DropShadow
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Visible = false
    
    if acrylic then
        local Blur = Instance.new("BlurEffect")
        Blur.Size = 20
        Blur.Parent = game.Lighting
        
        MainFrame.BackgroundTransparency = 0.08
        
        local AcrylicNoise = Instance.new("ImageLabel")
        AcrylicNoise.Name = "AcrylicNoise"
        AcrylicNoise.Parent = MainFrame
        AcrylicNoise.BackgroundTransparency = 1
        AcrylicNoise.Size = UDim2.new(1, 0, 1, 0)
        AcrylicNoise.Image = "rbxasset://textures/ui/Noise.png"
        AcrylicNoise.ImageColor3 = Color3.fromRGB(255, 255, 255)
        AcrylicNoise.ImageTransparency = 0.95
        AcrylicNoise.ScaleType = Enum.ScaleType.Tile
        AcrylicNoise.TileSize = UDim2.new(0, 200, 0, 200)
    end
    
    UICorner.CornerRadius = UDim.new(0, 20)
    UICorner.Parent = MainFrame
    
    local MainFrameStroke = Instance.new("UIStroke")
    MainFrameStroke.Color = Color3.fromRGB(60, 60, 75)
    MainFrameStroke.Thickness = 1
    MainFrameStroke.Transparency = 0.7
    MainFrameStroke.Parent = MainFrame
    
    TitleBar.Name = "TitleBar"
    TitleBar.Parent = MainFrame
    TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    TitleBar.BorderSizePixel = 0
    TitleBar.Size = UDim2.new(1, 0, 0, 60)
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 20)
    TitleCorner.Parent = TitleBar
    
    local TitleBarGradient = Instance.new("UIGradient")
    TitleBarGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 42)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 30))
    }
    TitleBarGradient.Rotation = 90
    TitleBarGradient.Parent = TitleBar
    
    WindowIcon.Name = "WindowIcon"
    WindowIcon.Parent = TitleBar
    WindowIcon.BackgroundTransparency = 1
    WindowIcon.Position = UDim2.new(0, 20, 0.5, -18)
    WindowIcon.Size = UDim2.new(0, 36, 0, 36)
    WindowIcon.Image = icon
    WindowIcon.ImageColor3 = Color3.fromRGB(130, 170, 255)
    
    local IconCorner = Instance.new("UICorner")
    IconCorner.CornerRadius = UDim.new(0, 10)
    IconCorner.Parent = WindowIcon
    
    TitleLabel.Name = "TitleLabel"
    TitleLabel.Parent = TitleBar
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Position = UDim2.new(0, 65, 0, 10)
    TitleLabel.Size = UDim2.new(1, -160, 0, 25)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 20
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    SubTitleLabel.Name = "SubTitleLabel"
    SubTitleLabel.Parent = TitleBar
    SubTitleLabel.BackgroundTransparency = 1
    SubTitleLabel.Position = UDim2.new(0, 65, 0, 35)
    SubTitleLabel.Size = UDim2.new(1, -160, 0, 18)
    SubTitleLabel.Font = Enum.Font.Gotham
    SubTitleLabel.Text = subtitle
    SubTitleLabel.TextColor3 = Color3.fromRGB(170, 170, 180)
    SubTitleLabel.TextSize = 14
    SubTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Parent = TitleBar
    MinimizeButton.BackgroundTransparency = 1
    MinimizeButton.Position = UDim2.new(1, -90, 0.5, -18)
    MinimizeButton.Size = UDim2.new(0, 36, 0, 36)
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.Text = "−"
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 200, 100)
    MinimizeButton.TextSize = 22
    
    local MinCorner = Instance.new("UICorner")
    MinCorner.CornerRadius = UDim.new(0, 10)
    MinCorner.Parent = MinimizeButton
    
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = TitleBar
    CloseButton.BackgroundTransparency = 1
    CloseButton.Position = UDim2.new(1, -45, 0.5, -18)
    CloseButton.Size = UDim2.new(0, 36, 0, 36)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Color3.fromRGB(255, 100, 100)
    CloseButton.TextSize = 22
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 10)
    CloseCorner.Parent = CloseButton
    
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = MainFrame
    TabContainer.BackgroundTransparency = 1
    TabContainer.Position = UDim2.new(0, 0, 0, 60)
    TabContainer.Size = UDim2.new(1, 0, 1, -60)
    
    TabButtons.Name = "TabButtons"
    TabButtons.Parent = TabContainer
    TabButtons.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    TabButtons.BorderSizePixel = 0
    TabButtons.Position = UDim2.new(0, 18, 0, 18)
    TabButtons.Size = UDim2.new(0, tabWidth, 1, -36)
    
    local TabGradient = Instance.new("UIGradient")
    TabGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(28, 28, 38)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 18, 26))
    }
    TabGradient.Rotation = 90
    TabGradient.Parent = TabButtons
    
    local TabButtonsCorner = Instance.new("UICorner")
    TabButtonsCorner.CornerRadius = UDim.new(0, 15)
    TabButtonsCorner.Parent = TabButtons
    
    local TabStroke = Instance.new("UIStroke")
    TabStroke.Color = Color3.fromRGB(45, 45, 55)
    TabStroke.Thickness = 1
    TabStroke.Transparency = 0.6
    TabStroke.Parent = TabButtons
    
    TabContent.Name = "TabContent"
    TabContent.Parent = TabContainer
    TabContent.BackgroundTransparency = 1
    TabContent.Position = UDim2.new(0, tabWidth + 36, 0, 18)
    TabContent.Size = UDim2.new(1, -tabWidth - 54, 1, -36)
    
    local TabButtonsLayout = Instance.new("UIListLayout")
    TabButtonsLayout.Parent = TabButtons
    TabButtonsLayout.Padding = UDim.new(0, 10)
    TabButtonsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    local TabPadding = Instance.new("UIPadding")
    TabPadding.PaddingTop = UDim.new(0, 18)
    TabPadding.PaddingBottom = UDim.new(0, 18)
    TabPadding.PaddingLeft = UDim.new(0, 18)
    TabPadding.PaddingRight = UDim.new(0, 18)
    TabPadding.Parent = TabButtons
    
    MinimizedFrame.Name = "MinimizedFrame"
    MinimizedFrame.Parent = ScreenGui
    MinimizedFrame.BackgroundColor3 = Color3.fromRGB(130, 170, 255)
    MinimizedFrame.BorderSizePixel = 0
    MinimizedFrame.Position = UDim2.new(0, 35, 0, 130)
    MinimizedFrame.Size = UDim2.new(0, 80, 0, 80)
    MinimizedFrame.Visible = false
    MinimizedFrame.Image = icon
    MinimizedFrame.ImageColor3 = Color3.fromRGB(255, 255, 255)
    MinimizedFrame.Draggable = true
    
    local MinimizedGradient = Instance.new("UIGradient")
    MinimizedGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 190, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(110, 150, 245))
    }
    MinimizedGradient.Rotation = 45
    MinimizedGradient.Parent = MinimizedFrame
    
    local MinimizedCorner = Instance.new("UICorner")
    MinimizedCorner.CornerRadius = UDim.new(0, 40)
    MinimizedCorner.Parent = MinimizedFrame
    
    local MinimizedStroke = Instance.new("UIStroke")
    MinimizedStroke.Color = Color3.fromRGB(255, 255, 255)
    MinimizedStroke.Thickness = 4
    MinimizedStroke.Transparency = 0.6
    MinimizedStroke.Parent = MinimizedFrame
    
    local MinimizedLabel = Instance.new("TextLabel")
    MinimizedLabel.Parent = MinimizedFrame
    MinimizedLabel.BackgroundTransparency = 1
    MinimizedLabel.Size = UDim2.new(1, 0, 0.35, 0)
    MinimizedLabel.Position = UDim2.new(0, 0, 0.65, 0)
    MinimizedLabel.Font = Enum.Font.GothamBold
    MinimizedLabel.Text = string.sub(title, 1, 1)
    MinimizedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizedLabel.TextSize = 18
    
    local isMinimized = false
    
    local function animateMinimized()
        local connection
        connection = RunService.Heartbeat:Connect(function()
            MinimizedFrame.Rotation = MinimizedFrame.Rotation + 1.5
        end)
        
        task.wait(3)
        if connection then
            connection:Disconnect()
        end
    end
    
    local function minimizeWindow()
        isMinimized = not isMinimized
        
        if isMinimized then
            TweenService:Create(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quart), {
                Position = UDim2.new(0.5, 0, -0.6, 0),
                Size = UDim2.new(0, 0, 0, 0)
            }):Play()
            
            TweenService:Create(DropShadow, TweenInfo.new(0.6, Enum.EasingStyle.Quart), {
                ImageTransparency = 1
            }):Play()
            
            task.wait(0.6)
            MainFrame.Visible = false
            DropShadow.Visible = false
            MinimizedFrame.Visible = true
            
            TweenService:Create(MinimizedFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
                Size = UDim2.new(0, 80, 0, 80)
            }):Play()
            
            task.spawn(animateMinimized)
        else
            DropShadow.Visible = true
            MinimizedFrame.Visible = false
            MainFrame.Visible = true
            MainFrame.Size = UDim2.new(0, 0, 0, 0)
            MainFrame.Position = UDim2.new(0.5, 0, -0.6, 0)
            
            TweenService:Create(DropShadow, TweenInfo.new(0.6, Enum.EasingStyle.Quart), {
                ImageTransparency = 0.2
            }):Play()
            
            TweenService:Create(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back), {
                Position = UDim2.new(0.5, 0, 0.5, 0),
                Size = size
            }):Play()
        end
    end
    
    CloseButton.MouseButton1Click:Connect(function()
        TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
            Position = UDim2.new(0.5, 0, -0.6, 0),
            Size = UDim2.new(0, 0, 0, 0)
        }):Play()
        
        TweenService:Create(DropShadow, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
            ImageTransparency = 1
        }):Play()
        
        task.wait(0.5)
        ScreenGui:Destroy()
    end)
    
    MinimizeButton.MouseButton1Click:Connect(minimizeWindow)
    MinimizedFrame.MouseButton1Click:Connect(minimizeWindow)
    
    UserInputService.InputBegan:Connect(function(input, processed)
        if not processed and input.KeyCode == minimizeKey then
            minimizeWindow()
        end
    end)
    
    MinimizeButton.MouseEnter:Connect(function()
        TweenService:Create(MinimizeButton, TweenInfo.new(0.3), {
            BackgroundTransparency = 0.6,
            BackgroundColor3 = Color3.fromRGB(255, 200, 100)
        }):Play()
    end)
    
    MinimizeButton.MouseLeave:Connect(function()
        TweenService:Create(MinimizeButton, TweenInfo.new(0.3), {
            BackgroundTransparency = 1
        }):Play()
    end)
    
    CloseButton.MouseEnter:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.3), {
            BackgroundTransparency = 0.6,
            BackgroundColor3 = Color3.fromRGB(255, 100, 100)
        }):Play()
    end)
    
    CloseButton.MouseLeave:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.3), {
            BackgroundTransparency = 1
        }):Play()
    end)
    
    local Window = {}
    Window.ScreenGui = ScreenGui
    Window.MainFrame = MainFrame
    Window.TabContainer = TabContainer
    Window.TabButtons = TabButtons
    Window.TabContent = TabContent
    Window.Tabs = {}
    Window.CurrentTab = nil
    Window.MinimizedFrame = MinimizedFrame
    Window.Icon = WindowIcon
    
    function Window:SetIcon(newIcon)
        WindowIcon.Image = newIcon
        MinimizedFrame.Image = newIcon
    end
    
    function Window:AddTab(options)
        local name = options.Name or "Tab"
        local title = options.Title or name
        local icon = options.Icon or "●"
        
        local TabButton = Instance.new("TextButton")
        local TabFrame = Instance.new("ScrollingFrame")
        local TabLayout = Instance.new("UIListLayout")
        local TabIcon = Instance.new("TextLabel")
        local TabStroke = Instance.new("UIStroke")
        
        TabButton.Name = name
        TabButton.Parent = self.TabButtons
        TabButton.BackgroundColor3 = Color3.fromRGB(32, 32, 42)
        TabButton.BorderSizePixel = 0
        TabButton.Size = UDim2.new(1, 0, 0, 55)
        TabButton.Font = Enum.Font.GothamMedium
        TabButton.Text = ""
        TabButton.TextColor3 = Color3.fromRGB(210, 210, 220)
        TabButton.TextSize = 16
        TabButton.TextXAlignment = Enum.TextXAlignment.Left
        
        local ButtonCorner = Instance.new("UICorner")
        ButtonCorner.CornerRadius = UDim.new(0, 14)
        ButtonCorner.Parent = TabButton
        
        local ButtonGradient = Instance.new("UIGradient")
        ButtonGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(38, 38, 48)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(28, 28, 38))
        }
        ButtonGradient.Rotation = 90
        ButtonGradient.Parent = TabButton
        
        TabStroke.Color = Color3.fromRGB(55, 55, 65)
        TabStroke.Thickness = 1
        TabStroke.Transparency = 0.4
        TabStroke.Parent = TabButton
        
        TabIcon.Name = "Icon"
        TabIcon.Parent = TabButton
        TabIcon.BackgroundTransparency = 1
        TabIcon.Position = UDim2.new(0, 18, 0.5, -12)
        TabIcon.Size = UDim2.new(0, 24, 0, 24)
        TabIcon.Font = Enum.Font.GothamBold
        TabIcon.Text = icon
        TabIcon.TextColor3 = Color3.fromRGB(130, 170, 255)
        TabIcon.TextSize = 18
        
        local TabLabel = Instance.new("TextLabel")
        TabLabel.Name = "Label"
        TabLabel.Parent = TabButton
        TabLabel.BackgroundTransparency = 1
        TabLabel.Position = UDim2.new(0, 50, 0, 0)
        TabLabel.Size = UDim2.new(1, -55, 1, 0)
        TabLabel.Font = Enum.Font.GothamMedium
        TabLabel.Text = title
        TabLabel.TextColor3 = Color3.fromRGB(210, 210, 220)
        TabLabel.TextSize = 16
        TabLabel.TextXAlignment = Enum.TextXAlignment.Left
        
        TabFrame.Name = name
        TabFrame.Parent = self.TabContent
        TabFrame.Active = true
        TabFrame.BackgroundTransparency = 1
        TabFrame.BorderSizePixel = 0
        TabFrame.Size = UDim2.new(1, 0, 1, 0)
        TabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
       TabFrame.ScrollBarThickness = 10
       TabFrame.ScrollBarImageColor3 = Color3.fromRGB(130, 170, 255)
       TabFrame.ScrollBarImageTransparency = 0.2
       TabFrame.Visible = false
       
       TabLayout.Parent = TabFrame
       TabLayout.Padding = UDim.new(0, 15)
       TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
       
       local TabFramePadding = Instance.new("UIPadding")
       TabFramePadding.PaddingTop = UDim.new(0, 12)
       TabFramePadding.PaddingBottom = UDim.new(0, 12)
       TabFramePadding.Parent = TabFrame
       
       TabLayout.Changed:Connect(function()
           TabFrame.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y + 35)
       end)
       
       TabButton.MouseEnter:Connect(function()
           if self.CurrentTab and self.CurrentTab.Button ~= TabButton then
               TweenService:Create(TabButton, TweenInfo.new(0.3), {
                   BackgroundColor3 = Color3.fromRGB(48, 48, 58)
               }):Play()
               TweenService:Create(TabStroke, TweenInfo.new(0.3), {
                   Color = Color3.fromRGB(130, 170, 255),
                   Transparency = 0.2
               }):Play()
           end
       end)
       
       TabButton.MouseLeave:Connect(function()
           if self.CurrentTab and self.CurrentTab.Button ~= TabButton then
               TweenService:Create(TabButton, TweenInfo.new(0.3), {
                   BackgroundColor3 = Color3.fromRGB(32, 32, 42)
               }):Play()
               TweenService:Create(TabStroke, TweenInfo.new(0.3), {
                   Color = Color3.fromRGB(55, 55, 65),
                   Transparency = 0.4
               }):Play()
           end
       end)
       
       TabButton.MouseButton1Click:Connect(function()
           if self.CurrentTab then
               self.CurrentTab.Frame.Visible = false
               TweenService:Create(self.CurrentTab.Button, TweenInfo.new(0.4), {
                   BackgroundColor3 = Color3.fromRGB(32, 32, 42)
               }):Play()
               TweenService:Create(self.CurrentTab.Label, TweenInfo.new(0.4), {
                   TextColor3 = Color3.fromRGB(210, 210, 220)
               }):Play()
               TweenService:Create(self.CurrentTab.Icon, TweenInfo.new(0.4), {
                   TextColor3 = Color3.fromRGB(130, 170, 255)
               }):Play()
               TweenService:Create(self.CurrentTab.Stroke, TweenInfo.new(0.4), {
                   Color = Color3.fromRGB(55, 55, 65),
                   Transparency = 0.4
               }):Play()
           end
           
           TabFrame.Visible = true
           TweenService:Create(TabButton, TweenInfo.new(0.4), {
               BackgroundColor3 = Color3.fromRGB(130, 170, 255)
           }):Play()
           TweenService:Create(TabLabel, TweenInfo.new(0.4), {
               TextColor3 = Color3.fromRGB(255, 255, 255)
           }):Play()
           TweenService:Create(TabIcon, TweenInfo.new(0.4), {
               TextColor3 = Color3.fromRGB(255, 255, 255)
           }):Play()
           TweenService:Create(TabStroke, TweenInfo.new(0.4), {
               Color = Color3.fromRGB(255, 255, 255),
               Transparency = 0.1
           }):Play()
           
           self.CurrentTab = {Frame = TabFrame, Button = TabButton, Label = TabLabel, Icon = TabIcon, Stroke = TabStroke}
       end)
       
       if not self.CurrentTab then
           TabFrame.Visible = true
           TabButton.BackgroundColor3 = Color3.fromRGB(130, 170, 255)
           TabLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
           TabIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
           TabStroke.Color = Color3.fromRGB(255, 255, 255)
           TabStroke.Transparency = 0.1
           self.CurrentTab = {Frame = TabFrame, Button = TabButton, Label = TabLabel, Icon = TabIcon, Stroke = TabStroke}
       end
       
       local Tab = {}
       Tab.Frame = TabFrame
       Tab.Button = TabButton
       
       function Tab:AddButton(id, options)
           local title = options.Title or "Button"
           local description = options.Description
           local callback = options.Callback or function() end
           
           local ButtonFrame = Instance.new("Frame")
           local Button = Instance.new("TextButton")
           local ButtonLabel = Instance.new("TextLabel")
           local DescLabel = Instance.new("TextLabel")
           local ButtonIcon = Instance.new("TextLabel")
           local ButtonStroke = Instance.new("UIStroke")
           
           ButtonFrame.Name = id
           ButtonFrame.Parent = TabFrame
           ButtonFrame.BackgroundColor3 = Color3.fromRGB(32, 32, 42)
           ButtonFrame.BorderSizePixel = 0
           ButtonFrame.Size = UDim2.new(1, 0, 0, description and 80 or 60)
           
           local FrameCorner = Instance.new("UICorner")
           FrameCorner.CornerRadius = UDim.new(0, 14)
           FrameCorner.Parent = ButtonFrame
           
           local FrameGradient = Instance.new("UIGradient")
           FrameGradient.Color = ColorSequence.new{
               ColorSequenceKeypoint.new(0, Color3.fromRGB(38, 38, 48)),
               ColorSequenceKeypoint.new(1, Color3.fromRGB(28, 28, 38))
           }
           FrameGradient.Rotation = 90
           FrameGradient.Parent = ButtonFrame
           
           ButtonStroke.Color = Color3.fromRGB(55, 55, 65)
           ButtonStroke.Thickness = 1
           ButtonStroke.Transparency = 0.4
           ButtonStroke.Parent = ButtonFrame
           
           Button.Name = "Button"
           Button.Parent = ButtonFrame
           Button.BackgroundTransparency = 1
           Button.Size = UDim2.new(1, 0, 1, 0)
           Button.Text = ""
           
           ButtonIcon.Name = "Icon"
           ButtonIcon.Parent = ButtonFrame
           ButtonIcon.BackgroundTransparency = 1
           ButtonIcon.Position = UDim2.new(0, 20, 0, 18)
           ButtonIcon.Size = UDim2.new(0, 28, 0, 28)
           ButtonIcon.Font = Enum.Font.GothamBold
           ButtonIcon.Text = "▶"
           ButtonIcon.TextColor3 = Color3.fromRGB(130, 170, 255)
           ButtonIcon.TextSize = 18
           
           ButtonLabel.Name = "Title"
           ButtonLabel.Parent = ButtonFrame
           ButtonLabel.BackgroundTransparency = 1
           ButtonLabel.Position = UDim2.new(0, 55, 0, 15)
           ButtonLabel.Size = UDim2.new(1, -70, 0, 28)
           ButtonLabel.Font = Enum.Font.GothamSemiBold
           ButtonLabel.Text = title
           ButtonLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
           ButtonLabel.TextSize = 17
           ButtonLabel.TextXAlignment = Enum.TextXAlignment.Left
           
           if description then
               DescLabel.Name = "Description"
               DescLabel.Parent = ButtonFrame
               DescLabel.BackgroundTransparency = 1
               DescLabel.Position = UDim2.new(0, 55, 0, 45)
               DescLabel.Size = UDim2.new(1, -70, 0, 25)
               DescLabel.Font = Enum.Font.Gotham
               DescLabel.Text = description
               DescLabel.TextColor3 = Color3.fromRGB(190, 190, 200)
               DescLabel.TextSize = 14
               DescLabel.TextXAlignment = Enum.TextXAlignment.Left
           end
           
           Button.MouseEnter:Connect(function()
               TweenService:Create(ButtonFrame, TweenInfo.new(0.3), {
                   BackgroundColor3 = Color3.fromRGB(45, 45, 55)
               }):Play()
               TweenService:Create(ButtonStroke, TweenInfo.new(0.3), {
                   Color = Color3.fromRGB(130, 170, 255), 
                   Transparency = 0.2
               }):Play()
               TweenService:Create(ButtonIcon, TweenInfo.new(0.3), {
                   Size = UDim2.new(0, 32, 0, 32)
               }):Play()
           end)
           
           Button.MouseLeave:Connect(function()
               TweenService:Create(ButtonFrame, TweenInfo.new(0.3), {
                   BackgroundColor3 = Color3.fromRGB(32, 32, 42)
               }):Play()
               TweenService:Create(ButtonStroke, TweenInfo.new(0.3), {
                   Color = Color3.fromRGB(55, 55, 65),
                   Transparency = 0.4
               }):Play()
               TweenService:Create(ButtonIcon, TweenInfo.new(0.3), {
                   Size = UDim2.new(0, 28, 0, 28)
               }):Play()
           end)
           
           Button.MouseButton1Click:Connect(function()
               TweenService:Create(ButtonFrame, TweenInfo.new(0.1), {
                   BackgroundColor3 = Color3.fromRGB(130, 170, 255)
               }):Play()
               TweenService:Create(ButtonIcon, TweenInfo.new(0.1), {
                   TextColor3 = Color3.fromRGB(255, 255, 255)
               }):Play()
               
               task.wait(0.15)
               
               TweenService:Create(ButtonFrame, TweenInfo.new(0.25), {
                   BackgroundColor3 = Color3.fromRGB(32, 32, 42)
               }):Play()
               TweenService:Create(ButtonIcon, TweenInfo.new(0.25), {
                   TextColor3 = Color3.fromRGB(130, 170, 255)
               }):Play()
               
               callback()
           end)
           
           return ButtonFrame
       end
       
       function Tab:AddToggle(id, options)
           local title = options.Title or "Toggle"
           local description = options.Description
           local default = options.Default or false
           local callback = options.Callback or function() end
           
           local toggled = default
           
           local ToggleFrame = Instance.new("Frame")
           local ToggleButton = Instance.new("TextButton")
           local TitleLabel = Instance.new("TextLabel")
           local DescLabel = Instance.new("TextLabel")
           local Switch = Instance.new("Frame")
           local SwitchButton = Instance.new("Frame")
           local ToggleIcon = Instance.new("TextLabel")
           local ToggleStroke = Instance.new("UIStroke")
           
           ToggleFrame.Name = id
           ToggleFrame.Parent = TabFrame
           ToggleFrame.BackgroundColor3 = Color3.fromRGB(32, 32, 42)
           ToggleFrame.BorderSizePixel = 0
           ToggleFrame.Size = UDim2.new(1, 0, 0, description and 80 or 60)
           
           local FrameCorner = Instance.new("UICorner")
           FrameCorner.CornerRadius = UDim.new(0, 14)
           FrameCorner.Parent = ToggleFrame
           
           local FrameGradient = Instance.new("UIGradient")
           FrameGradient.Color = ColorSequence.new{
               ColorSequenceKeypoint.new(0, Color3.fromRGB(38, 38, 48)),
               ColorSequenceKeypoint.new(1, Color3.fromRGB(28, 28, 38))
           }
           FrameGradient.Rotation = 90
           FrameGradient.Parent = ToggleFrame
           
           ToggleStroke.Color = Color3.fromRGB(55, 55, 65)
           ToggleStroke.Thickness = 1
           ToggleStroke.Transparency = 0.4
           ToggleStroke.Parent = ToggleFrame
           
           ToggleButton.Name = "Button"
           ToggleButton.Parent = ToggleFrame
           ToggleButton.BackgroundTransparency = 1
           ToggleButton.Size = UDim2.new(1, -75, 1, 0)
           ToggleButton.Text = ""
           
           ToggleIcon.Name = "Icon"
           ToggleIcon.Parent = ToggleFrame
           ToggleIcon.BackgroundTransparency = 1
           ToggleIcon.Position = UDim2.new(0, 20, 0, 18)
           ToggleIcon.Size = UDim2.new(0, 28, 0, 28)
           ToggleIcon.Font = Enum.Font.GothamBold
           ToggleIcon.Text = "◐"
           ToggleIcon.TextColor3 = toggled and Color3.fromRGB(100, 255, 150) or Color3.fromRGB(130, 170, 255)
           ToggleIcon.TextSize = 18
           
           TitleLabel.Name = "Title"
           TitleLabel.Parent = ToggleFrame
           TitleLabel.BackgroundTransparency = 1
           TitleLabel.Position = UDim2.new(0, 55, 0, 15)
           TitleLabel.Size = UDim2.new(1, -140, 0, 28)
           TitleLabel.Font = Enum.Font.GothamSemiBold
           TitleLabel.Text = title
           TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
           TitleLabel.TextSize = 17
           TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
           
           if description then
               DescLabel.Name = "Description"
               DescLabel.Parent = ToggleFrame
               DescLabel.BackgroundTransparency = 1
               DescLabel.Position = UDim2.new(0, 55, 0, 45)
               DescLabel.Size = UDim2.new(1, -140, 0, 25)
               DescLabel.Font = Enum.Font.Gotham
               DescLabel.Text = description
               DescLabel.TextColor3 = Color3.fromRGB(190, 190, 200)
               DescLabel.TextSize = 14
               DescLabel.TextXAlignment = Enum.TextXAlignment.Left
           end
           
           Switch.Name = "Switch"
           Switch.Parent = ToggleFrame
           Switch.BackgroundColor3 = toggled and Color3.fromRGB(100, 255, 150) or Color3.fromRGB(55, 55, 65)
           Switch.BorderSizePixel = 0
           Switch.Position = UDim2.new(1, -65, 0.5, -18)
           Switch.Size = UDim2.new(0, 55, 0, 36)
           
           local SwitchCorner = Instance.new("UICorner")
           SwitchCorner.CornerRadius = UDim.new(0, 18)
           SwitchCorner.Parent = Switch
           
           local SwitchGlow = Instance.new("UIStroke")
           SwitchGlow.Color = toggled and Color3.fromRGB(100, 255, 150) or Color3.fromRGB(75, 75, 85)
           SwitchGlow.Thickness = 2
           SwitchGlow.Transparency = 0.5
           SwitchGlow.Parent = Switch
           
           SwitchButton.Name = "Button"
           SwitchButton.Parent = Switch
           SwitchButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
           SwitchButton.BorderSizePixel = 0
           SwitchButton.Position = toggled and UDim2.new(1, -30, 0.5, -15) or UDim2.new(0, 3, 0.5, -15)
           SwitchButton.Size = UDim2.new(0, 30, 0, 30)
           
           local ButtonCorner = Instance.new("UICorner")
           ButtonCorner.CornerRadius = UDim.new(0, 15)
           ButtonCorner.Parent = SwitchButton
           
           local ButtonShadow = Instance.new("UIStroke")
           ButtonShadow.Color = Color3.fromRGB(0, 0, 0)
           ButtonShadow.Thickness = 1
           ButtonShadow.Transparency = 0.7
           ButtonShadow.Parent = SwitchButton
           
           local function updateToggle()
               TweenService:Create(Switch, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
                   BackgroundColor3 = toggled and Color3.fromRGB(100, 255, 150) or Color3.fromRGB(55, 55, 65)
               }):Play()
               
               TweenService:Create(SwitchGlow, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
                   Color = toggled and Color3.fromRGB(100, 255, 150) or Color3.fromRGB(75, 75, 85)
               }):Play()
               
               TweenService:Create(SwitchButton, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
                   Position = toggled and UDim2.new(1, -30, 0.5, -15) or UDim2.new(0, 3, 0.5, -15)
               }):Play()
               
               TweenService:Create(ToggleIcon, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
                   TextColor3 = toggled and Color3.fromRGB(100, 255, 150) or Color3.fromRGB(130, 170, 255)
               }):Play()
               
               callback(toggled)
           end
           
           ToggleButton.MouseButton1Click:Connect(function()
               toggled = not toggled
               updateToggle()
           end)
           
           Switch.InputBegan:Connect(function(input)
               if input.UserInputType == Enum.UserInputType.MouseButton1 then
                   toggled = not toggled
                   updateToggle()
               end
           end)
           
           ToggleButton.MouseEnter:Connect(function()
               TweenService:Create(ToggleFrame, TweenInfo.new(0.3), {
                   BackgroundColor3 = Color3.fromRGB(42, 42, 52)
               }):Play()
               TweenService:Create(ToggleStroke, TweenInfo.new(0.3), {
                   Color = Color3.fromRGB(130, 170, 255),
                   Transparency = 0.2
               }):Play()
           end)
           
           ToggleButton.MouseLeave:Connect(function()
               TweenService:Create(ToggleFrame, TweenInfo.new(0.3), {
                   BackgroundColor3 = Color3.fromRGB(32, 32, 42)
               }):Play()
               TweenService:Create(ToggleStroke, TweenInfo.new(0.3), {
                   Color = Color3.fromRGB(55, 55, 65),
                   Transparency = 0.4
               }):Play()
           end)
           
           return ToggleFrame
       end
       
       function Tab:AddSlider(id, options)
           local title = options.Title or "Slider"
           local description = options.Description
           local min = options.Min or 0
           local max = options.Max or 100
           local default = options.Default or min
           local callback = options.Callback or function() end
           
           local value = default
           local dragging = false
           
           local SliderFrame = Instance.new("Frame")
           local TitleLabel = Instance.new("TextLabel")
           local DescLabel = Instance.new("TextLabel")
           local ValueLabel = Instance.new("TextLabel")
           local SliderTrack = Instance.new("Frame")
           local SliderFill = Instance.new("Frame")
           local SliderHandle = Instance.new("TextButton")
           local SliderIcon = Instance.new("TextLabel")
           local SliderStroke = Instance.new("UIStroke")
           
           SliderFrame.Name = id
           SliderFrame.Parent = TabFrame
           SliderFrame.BackgroundColor3 = Color3.fromRGB(32, 32, 42)
           SliderFrame.BorderSizePixel = 0
           SliderFrame.Size = UDim2.new(1, 0, 0, description and 90 or 70)
           
           local FrameCorner = Instance.new("UICorner")
           FrameCorner.CornerRadius = UDim.new(0, 14)
           FrameCorner.Parent = SliderFrame
           
           local FrameGradient = Instance.new("UIGradient")
           FrameGradient.Color = ColorSequence.new{
               ColorSequenceKeypoint.new(0, Color3.fromRGB(38, 38, 48)),
               ColorSequenceKeypoint.new(1, Color3.fromRGB(28, 28, 38))
           }
           FrameGradient.Rotation = 90
           FrameGradient.Parent = SliderFrame
           
           SliderStroke.Color = Color3.fromRGB(55, 55, 65)
           SliderStroke.Thickness = 1
           SliderStroke.Transparency = 0.4
           SliderStroke.Parent = SliderFrame
           
           SliderIcon.Name = "Icon"
           SliderIcon.Parent = SliderFrame
           SliderIcon.BackgroundTransparency = 1
           SliderIcon.Position = UDim2.new(0, 20, 0, 18)
           SliderIcon.Size = UDim2.new(0, 28, 0, 28)
           SliderIcon.Font = Enum.Font.GothamBold
           SliderIcon.Text = "⚬"
           SliderIcon.TextColor3 = Color3.fromRGB(130, 170, 255)
           SliderIcon.TextSize = 18
           
           TitleLabel.Name = "Title"
           TitleLabel.Parent = SliderFrame
           TitleLabel.BackgroundTransparency = 1
           TitleLabel.Position = UDim2.new(0, 55, 0, 15)
           TitleLabel.Size = UDim2.new(1, -150, 0, 25)
           TitleLabel.Font = Enum.Font.GothamSemiBold
           TitleLabel.Text = title
           TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
           TitleLabel.TextSize = 17
           TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
           
           ValueLabel.Name = "Value"
           ValueLabel.Parent = SliderFrame
           ValueLabel.BackgroundTransparency = 1
           ValueLabel.Position = UDim2.new(1, -90, 0, 15)
           ValueLabel.Size = UDim2.new(0, 75, 0, 25)
           ValueLabel.Font = Enum.Font.GothamBold
           ValueLabel.Text = tostring(value)
           ValueLabel.TextColor3 = Color3.fromRGB(130, 170, 255)
           ValueLabel.TextSize = 17
           ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
           
           if description then
               DescLabel.Name = "Description"
               DescLabel.Parent = SliderFrame
               DescLabel.BackgroundTransparency = 1
               DescLabel.Position = UDim2.new(0, 55, 0, 40)
               DescLabel.Size = UDim2.new(1, -75, 0, 22)
               DescLabel.Font = Enum.Font.Gotham
               DescLabel.Text = description
               DescLabel.TextColor3 = Color3.fromRGB(190, 190, 200)
               DescLabel.TextSize = 14
               DescLabel.TextXAlignment = Enum.TextXAlignment.Left
               
               SliderTrack.Position = UDim2.new(0, 20, 1, -22)
           else
               SliderTrack.Position = UDim2.new(0, 20, 1, -28)
           end
           
           SliderTrack.Name = "Track"
           SliderTrack.Parent = SliderFrame
           SliderTrack.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
           SliderTrack.BorderSizePixel = 0
           SliderTrack.Size = UDim2.new(1, -40, 0, 10)
           
           local TrackCorner = Instance.new("UICorner")
           TrackCorner.CornerRadius = UDim.new(0, 5)
           TrackCorner.Parent = SliderTrack
           
           local TrackStroke = Instance.new("UIStroke")
           TrackStroke.Color = Color3.fromRGB(75, 75, 85)
           TrackStroke.Thickness = 1
           TrackStroke.Transparency = 0.5
           TrackStroke.Parent = SliderTrack
           
           SliderFill.Name = "Fill"
           SliderFill.Parent = SliderTrack
           SliderFill.BackgroundColor3 = Color3.fromRGB(130, 170, 255)
           SliderFill.BorderSizePixel = 0
           SliderFill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
           
           local FillCorner = Instance.new("UICorner")
           FillCorner.CornerRadius = UDim.new(0, 5)
           FillCorner.Parent = SliderFill
           
           local FillGradient = Instance.new("UIGradient")
           FillGradient.Color = ColorSequence.new{
               ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 190, 255)),
               ColorSequenceKeypoint.new(1, Color3.fromRGB(110, 150, 245))
           }
           FillGradient.Parent = SliderFill
           
           SliderHandle.Name = "Handle"
           SliderHandle.Parent = SliderTrack
           SliderHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
           SliderHandle.BorderSizePixel = 0
           SliderHandle.Position = UDim2.new((value - min) / (max - min), -12, 0.5, -12)
           SliderHandle.Size = UDim2.new(0, 24, 0, 24)
           SliderHandle.Text = ""
           
           local HandleCorner = Instance.new("UICorner")
           HandleCorner.CornerRadius = UDim.new(0, 12)
           HandleCorner.Parent = SliderHandle
           
           local HandleStroke = Instance.new("UIStroke")
           HandleStroke.Color = Color3.fromRGB(130, 170, 255)
           HandleStroke.Thickness = 2
           HandleStroke.Transparency = 0.2
           HandleStroke.Parent = SliderHandle
           
           local function updateSlider(input)
               local sizeX = SliderTrack.AbsoluteSize.X
               local posX = input.Position.X - SliderTrack.AbsolutePosition.X
               local percent = math.clamp(posX / sizeX, 0, 1)
               
               value = math.floor(min + (max - min) * percent)
               ValueLabel.Text = tostring(value)
               
               TweenService:Create(SliderFill, TweenInfo.new(0.1), {
                   Size = UDim2.new(percent, 0, 1, 0)
               }):Play()
               
               TweenService:Create(SliderHandle, TweenInfo.new(0.1), {
                   Position = UDim2.new(percent, -12, 0.5, -12)
               }):Play()
               
               callback(value)
           end
           
           SliderHandle.InputBegan:Connect(function(input)
               if input.UserInputType == Enum.UserInputType.MouseButton1 then
                   dragging = true
                   TweenService:Create(SliderHandle, TweenInfo.new(0.2), {
                       Size = UDim2.new(0, 28, 0, 28),
                       BackgroundColor3 = Color3.fromRGB(130, 170, 255)
                   }):Play()
                   TweenService:Create(HandleStroke, TweenInfo.new(0.2), {
                       Color = Color3.fromRGB(255, 255, 255),
                       Transparency = 0.05
                   }):Play()
               end
           end)
           
           SliderHandle.InputEnded:Connect(function(input)
               if input.UserInputType == Enum.UserInputType.MouseButton1 then
                   dragging = false
                   TweenService:Create(SliderHandle, TweenInfo.new(0.2), {
                       Size = UDim2.new(0, 24, 0, 24),
                       BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                   }):Play()
                   TweenService:Create(HandleStroke, TweenInfo.new(0.2), {
                       Color = Color3.fromRGB(130, 170, 255),
                       Transparency = 0.2
                   }):Play()
               end
           end)
           
           UserInputService.InputChanged:Connect(function(input)
               if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                   updateSlider(input)
               end
           end)
           
           SliderTrack.InputBegan:Connect(function(input)
               if input.UserInputType == Enum.UserInputType.MouseButton1 then
                   updateSlider(input)
               end
           end)
           
           return SliderFrame
       end
       
       function Tab:AddInput(id, options)
           local title = options.Title or "Input"
           local description = options.Description
           local placeholder = options.Placeholder or "Enter text..."
           local callback = options.Callback or function() end
           
           local InputFrame = Instance.new("Frame")
           local TitleLabel = Instance.new("TextLabel")
           local DescLabel = Instance.new("TextLabel")
           local TextBox = Instance.new("TextBox")
           local InputIcon = Instance.new("TextLabel")
           local InputStroke = Instance.new("UIStroke")
           
           InputFrame.Name = id
           InputFrame.Parent = TabFrame
           InputFrame.BackgroundColor3 = Color3.fromRGB(32, 32, 42)
           InputFrame.BorderSizePixel = 0
           InputFrame.Size = UDim2.new(1, 0, 0, description and 90 or 75)
           
           local FrameCorner = Instance.new("UICorner")
           FrameCorner.CornerRadius = UDim.new(0, 14)
           FrameCorner.Parent = InputFrame
           
           local FrameGradient = Instance.new("UIGradient")
           FrameGradient.Color = ColorSequence.new{
               ColorSequenceKeypoint.new(0, Color3.fromRGB(38, 38, 48)),
               ColorSequenceKeypoint.new(1, Color3.fromRGB(28, 28, 38))
           }
           FrameGradient.Rotation = 90
           FrameGradient.Parent = InputFrame
           
           InputStroke.Color = Color3.fromRGB(55, 55, 65)
           InputStroke.Thickness = 1
           InputStroke.Transparency = 0.4
           InputStroke.Parent = InputFrame
           
           InputIcon.Name = "Icon"
           InputIcon.Parent = InputFrame
           InputIcon.BackgroundTransparency = 1
           InputIcon.Position = UDim2.new(0, 20, 0, 18)
           InputIcon.Size = UDim2.new(0, 28, 0, 28)
           InputIcon.Font = Enum.Font.GothamBold
           InputIcon.Text = "✎"
           InputIcon.TextColor3 = Color3.fromRGB(130, 170, 255)
           InputIcon.TextSize = 18
           
           TitleLabel.Name = "Title"
           TitleLabel.Parent = InputFrame
           TitleLabel.BackgroundTransparency = 1
           TitleLabel.Position = UDim2.new(0, 55, 0, 15)
           TitleLabel.Size = UDim2.new(1, -70, 0, 25)
           TitleLabel.Font = Enum.Font.GothamSemiBold
           TitleLabel.Text = title
           TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
           TitleLabel.TextSize = 17
           TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
           
           if description then
               DescLabel.Name = "Description"
               DescLabel.Parent = InputFrame
               DescLabel.BackgroundTransparency = 1
               DescLabel.Position = UDim2.new(0, 55, 0, 40)
               DescLabel.Size = UDim2.new(1, -70, 0, 22)
               DescLabel.Font = Enum.Font.Gotham
               DescLabel.Text = description
               DescLabel.TextColor3 = Color3.fromRGB(190, 190, 200)
               DescLabel.TextSize = 14
               DescLabel.TextXAlignment = Enum.TextXAlignment.Left
               
               TextBox.Position = UDim2.new(0, 20, 1, -38)
           else
               TextBox.Position = UDim2.new(0, 20, 1, -43)
           end
           
           TextBox.Name = "Input"
           TextBox.Parent = InputFrame
           TextBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
           TextBox.BorderSizePixel = 0
           TextBox.Size = UDim2.new(1, -40, 0, 35)
           TextBox.Font = Enum.Font.Gotham
           TextBox.PlaceholderText = placeholder
           TextBox.PlaceholderColor3 = Color3.fromRGB(130, 130, 140)
           TextBox.Text = ""
           TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
           TextBox.TextSize = 15
           TextBox.TextXAlignment = Enum.TextXAlignment.Left
           
           local InputCorner = Instance.new("UICorner")
           InputCorner.CornerRadius = UDim.new(0, 10)
           InputCorner.Parent = TextBox
           
           local TextBoxStroke = Instance.new("UIStroke")
           TextBoxStroke.Color = Color3.fromRGB(75, 75, 85)
           TextBoxStroke.Thickness = 1
           TextBoxStroke.Transparency = 0.5
           TextBoxStroke.Parent = TextBox
           
           local TextBoxPadding = Instance.new("UIPadding")
           TextBoxPadding.PaddingLeft = UDim.new(0, 15)
           TextBoxPadding.PaddingRight = UDim.new(0, 15)
           TextBoxPadding.Parent = TextBox
           
           TextBox.Focused:Connect(function()
               TweenService:Create(TextBox, TweenInfo.new(0.3), {
                   BackgroundColor3 = Color3.fromRGB(130, 170, 255)
               }):Play()
               TweenService:Create(TextBoxStroke, TweenInfo.new(0.3), {
                   Color = Color3.fromRGB(255, 255, 255),
                   Transparency = 0.1
               }):Play()
               TweenService:Create(InputIcon, TweenInfo.new(0.3), {
                   TextColor3 = Color3.fromRGB(100, 255, 150)
               }):Play()
           end)
           
           TextBox.FocusLost:Connect(function(enterPressed)
               TweenService:Create(TextBox, TweenInfo.new(0.3), {
                   BackgroundColor3 = Color3.fromRGB(40, 40, 50)
               }):Play()
               TweenService:Create(TextBoxStroke, TweenInfo.new(0.3), {
                   Color = Color3.fromRGB(75, 75, 85),
                   Transparency = 0.5
               }):Play()
               TweenService:Create(InputIcon, TweenInfo.new(0.3), {
                   TextColor3 = Color3.fromRGB(130, 170, 255)
               }):Play()
               
               if enterPressed then
                   callback(TextBox.Text)
               end
           end)
           
           return InputFrame
       end
       
       function Tab:AddLabel(id, options)
           local title = options.Title or "Label"
           local description = options.Description
           
           local LabelFrame = Instance.new("Frame")
           local TitleLabel = Instance.new("TextLabel")
           local DescLabel = Instance.new("TextLabel")
           local LabelIcon = Instance.new("TextLabel")
           
           LabelFrame.Name = id
           LabelFrame.Parent = TabFrame
           LabelFrame.BackgroundTransparency = 1
           LabelFrame.Size = UDim2.new(1, 0, 0, description and 60 or 40)
           
           LabelIcon.Name = "Icon"
           LabelIcon.Parent = LabelFrame
           LabelIcon.BackgroundTransparency = 1
           LabelIcon.Position = UDim2.new(0, 8, 0, 10)
           LabelIcon.Size = UDim2.new(0, 28, 0, 22)
           LabelIcon.Font = Enum.Font.GothamBold
           LabelIcon.Text = "ℹ"
           LabelIcon.TextColor3 = Color3.fromRGB(130, 170, 255)
           LabelIcon.TextSize = 18
           
           TitleLabel.Name = "Title"
           TitleLabel.Parent = LabelFrame
           TitleLabel.BackgroundTransparency = 1
           TitleLabel.Position = UDim2.new(0, 42, 0, 10)
           TitleLabel.Size = UDim2.new(1, -47, 0, 25)
           TitleLabel.Font = Enum.Font.GothamSemiBold
           TitleLabel.Text = title
           TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
           TitleLabel.TextSize = 17
           TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
           
           if description then
               DescLabel.Name = "Description"
               DescLabel.Parent = LabelFrame
               DescLabel.BackgroundTransparency = 1
               DescLabel.Position = UDim2.new(0, 42, 0, 35)
               DescLabel.Size = UDim2.new(1, -47, 0, 22)
               DescLabel.Font = Enum.Font.Gotham
               DescLabel.Text = description
               DescLabel.TextColor3 = Color3.fromRGB(190, 190, 200)
               DescLabel.TextSize = 14
               DescLabel.TextXAlignment = Enum.TextXAlignment.Left
           end
           
           return LabelFrame
       end
       
       function Tab:AddSection(id, options)
           local title = options.Title or "Section"
           
           local SectionFrame = Instance.new("Frame")
           local SectionLabel = Instance.new("TextLabel")
           local Separator = Instance.new("Frame")
           local SectionIcon = Instance.new("TextLabel")
           
           SectionFrame.Name = id
           SectionFrame.Parent = TabFrame
           SectionFrame.BackgroundTransparency = 1
           SectionFrame.Size = UDim2.new(1, 0, 0, 50)
           
           SectionIcon.Name = "Icon"
           SectionIcon.Parent = SectionFrame
           SectionIcon.BackgroundTransparency = 1
           SectionIcon.Position = UDim2.new(0, 0, 0, 12)
           SectionIcon.Size = UDim2.new(0, 28, 0, 28)
           SectionIcon.Font = Enum.Font.GothamBold
           SectionIcon.Text = "◆"
           SectionIcon.TextColor3 = Color3.fromRGB(130, 170, 255)
           SectionIcon.TextSize = 18
           
           SectionLabel.Name = "Title"
           SectionLabel.Parent = SectionFrame
           SectionLabel.BackgroundTransparency = 1
           SectionLabel.Position = UDim2.new(0, 35, 0, 12)
           SectionLabel.Size = UDim2.new(1, -40, 0, 28)
           SectionLabel.Font = Enum.Font.GothamBold
           SectionLabel.Text = title
           SectionLabel.TextColor3 = Color3.fromRGB(130, 170, 255)
           SectionLabel.TextSize = 19
           SectionLabel.TextXAlignment = Enum.TextXAlignment.Left
           
           Separator.Name = "Separator"
           Separator.Parent = SectionFrame
           Separator.BackgroundColor3 = Color3.fromRGB(130, 170, 255)
           Separator.BorderSizePixel = 0
           Separator.Position = UDim2.new(0, 0, 1, -4)
           Separator.Size = UDim2.new(1, 0, 0, 4)
           
           local SepCorner = Instance.new("UICorner")
           SepCorner.CornerRadius = UDim.new(0, 2)
           SepCorner.Parent = Separator
           
           local SepGradient = Instance.new("UIGradient")
           SepGradient.Color = ColorSequence.new{
               ColorSequenceKeypoint.new(0, Color3.fromRGB(130, 170, 255)),
               ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 130, 225))
           }
           SepGradient.Parent = Separator
           
           return SectionFrame
       end
       
       function Tab:AddDropdown(id, options)
           local title = options.Title or "Dropdown"
           local description = options.Description
           local list = options.List or {}
           local default = options.Default or (list[1] or "None")
           local callback = options.Callback or function() end
           
           local selected = default
           local isOpen = false
           
           local DropdownFrame = Instance.new("Frame")
           local TitleLabel = Instance.new("TextLabel")
           local DescLabel = Instance.new("TextLabel")
           local DropButton = Instance.new("TextButton")
           local SelectedLabel = Instance.new("TextLabel")
           local Arrow = Instance.new("TextLabel")
           local OptionsScroll = Instance.new("ScrollingFrame")
           local OptionsLayout = Instance.new("UIListLayout")
           local DropdownIcon = Instance.new("TextLabel")
           local DropdownStroke = Instance.new("UIStroke")
           
           DropdownFrame.Name = id
           DropdownFrame.Parent = TabFrame
           DropdownFrame.BackgroundColor3 = Color3.fromRGB(32, 32, 42)
           DropdownFrame.BorderSizePixel = 0
           DropdownFrame.Size = UDim2.new(1, 0, 0, description and 90 or 75)
           DropdownFrame.ClipsDescendants = true
           
           local FrameCorner = Instance.new("UICorner")
           FrameCorner.CornerRadius = UDim.new(0, 14)
           FrameCorner.Parent = DropdownFrame
           
           local FrameGradient = Instance.new("UIGradient")
           FrameGradient.Color = ColorSequence.new{
               ColorSequenceKeypoint.new(0, Color3.fromRGB(38, 38, 48)),
               ColorSequenceKeypoint.new(1, Color3.fromRGB(28, 28, 38))
           }
           FrameGradient.Rotation = 90
           FrameGradient.Parent = DropdownFrame
           
           DropdownStroke.Color = Color3.fromRGB(55, 55, 65)
           DropdownStroke.Thickness = 1
           DropdownStroke.Transparency = 0.4
           DropdownStroke.Parent = DropdownFrame
           
           DropdownIcon.Name = "Icon"
           DropdownIcon.Parent = DropdownFrame
           DropdownIcon.BackgroundTransparency = 1
           DropdownIcon.Position = UDim2.new(0, 20, 0, 18)
           DropdownIcon.Size = UDim2.new(0, 28, 0, 28)
           DropdownIcon.Font = Enum.Font.GothamBold
           DropdownIcon.Text = "≡"
           DropdownIcon.TextColor3 = Color3.fromRGB(130, 170, 255)
           DropdownIcon.TextSize = 18
           
           TitleLabel.Name = "Title"
           TitleLabel.Parent = DropdownFrame
           TitleLabel.BackgroundTransparency = 1
           TitleLabel.Position = UDim2.new(0, 55, 0, 15)
           TitleLabel.Size = UDim2.new(1, -70, 0, 25)
           TitleLabel.Font = Enum.Font.GothamSemiBold
           TitleLabel.Text = title
           TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
           TitleLabel.TextSize = 17
           TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
           
           if description then
               DescLabel.Name = "Description"
               DescLabel.Parent = DropdownFrame
               DescLabel.BackgroundTransparency = 1
               DescLabel.Position = UDim2.new(0, 55, 0, 40)
               DescLabel.Size = UDim2.new(1, -70, 0, 22)
               DescLabel.Font = Enum.Font.Gotham
               DescLabel.Text = description
               DescLabel.TextColor3 = Color3.fromRGB(190, 190, 200)
               DescLabel.TextSize = 14
               DescLabel.TextXAlignment = Enum.TextXAlignment.Left
               
               DropButton.Position = UDim2.new(0, 20, 1, -38)
           else
               DropButton.Position = UDim2.new(0, 20, 1, -43)
           end
           
           DropButton.Name = "Button"
           DropButton.Parent = DropdownFrame
           DropButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
           DropButton.BorderSizePixel = 0
           DropButton.Size = UDim2.new(1, -40, 0, 35)
           DropButton.Text = ""
           
           local ButtonCorner = Instance.new("UICorner")
           ButtonCorner.CornerRadius = UDim.new(0, 10)
           ButtonCorner.Parent = DropButton
           
           local ButtonStroke = Instance.new("UIStroke")
           ButtonStroke.Color = Color3.fromRGB(75, 75, 85)
           ButtonStroke.Thickness = 1
           ButtonStroke.Transparency = 0.5
           ButtonStroke.Parent = DropButton
           
           SelectedLabel.Name = "Selected"
           SelectedLabel.Parent = DropButton
           SelectedLabel.BackgroundTransparency = 1
           SelectedLabel.Position = UDim2.new(0, 15, 0, 0)
           SelectedLabel.Size = UDim2.new(1, -45, 1, 0)
           SelectedLabel.Font = Enum.Font.Gotham
           SelectedLabel.Text = selected
           SelectedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
           SelectedLabel.TextSize = 15
           SelectedLabel.TextXAlignment = Enum.TextXAlignment.Left
           
           Arrow.Name = "Arrow"
           Arrow.Parent = DropButton
           Arrow.BackgroundTransparency = 1
           Arrow.Position = UDim2.new(1, -35, 0, 0)
           Arrow.Size = UDim2.new(0, 35, 1, 0)
           Arrow.Font = Enum.Font.GothamSemiBold
           Arrow.Text = "▼"
           Arrow.TextColor3 = Color3.fromRGB(210, 210, 220)
           Arrow.TextSize = 15
           
           OptionsScroll.Name = "OptionsScroll"
           OptionsScroll.Parent = DropdownFrame
           OptionsScroll.Active = true
           OptionsScroll.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
           OptionsScroll.BorderSizePixel = 0
           OptionsScroll.Position = UDim2.new(0, 20, 1, -10)
           OptionsScroll.Size = UDim2.new(1, -40, 0, 0)
           OptionsScroll.Visible = false
           OptionsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
           OptionsScroll.ScrollBarThickness = 8
           OptionsScroll.ScrollBarImageColor3 = Color3.fromRGB(130, 170, 255)
           OptionsScroll.ScrollBarImageTransparency = 0.2
           
           local OptionsCorner = Instance.new("UICorner")
           OptionsCorner.CornerRadius = UDim.new(0, 10)
           OptionsCorner.Parent = OptionsScroll
           
           local OptionsStroke = Instance.new("UIStroke")
           OptionsStroke.Color = Color3.fromRGB(130, 170, 255)
           OptionsStroke.Thickness = 1
           OptionsStroke.Transparency = 0.3
           OptionsStroke.Parent = OptionsScroll
           
           OptionsLayout.Parent = OptionsScroll
           OptionsLayout.SortOrder = Enum.SortOrder.LayoutOrder
           OptionsLayout.Padding = UDim.new(0, 3)
           
           local OptionsPadding = Instance.new("UIPadding")
           OptionsPadding.PaddingTop = UDim.new(0, 8)
           OptionsPadding.PaddingBottom = UDim.new(0, 8)
           OptionsPadding.PaddingLeft = UDim.new(0, 8)
           OptionsPadding.PaddingRight = UDim.new(0, 8)
           OptionsPadding.Parent = OptionsScroll
           
           for i, option in pairs(list) do
               local OptionButton = Instance.new("TextButton")
               
               OptionButton.Name = option
               OptionButton.Parent = OptionsScroll
               OptionButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
               OptionButton.BorderSizePixel = 0
               OptionButton.Size = UDim2.new(1, 0, 0, 38)
               OptionButton.Font = Enum.Font.Gotham
               OptionButton.Text = option
               OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
               OptionButton.TextSize = 14
               
               local OptionCorner = Instance.new("UICorner")
               OptionCorner.CornerRadius = UDim.new(0, 8)
               OptionCorner.Parent = OptionButton
               
               OptionButton.MouseEnter:Connect(function()
                   TweenService:Create(OptionButton, TweenInfo.new(0.2), {
                       BackgroundColor3 = Color3.fromRGB(130, 170, 255)
                   }):Play()
               end)
               
               OptionButton.MouseLeave:Connect(function()
                   TweenService:Create(OptionButton, TweenInfo.new(0.2), {
                       BackgroundColor3 = Color3.fromRGB(40, 40, 50)
                   }):Play()
               end)
               
               OptionButton.MouseButton1Click:Connect(function()
                   selected = option
                   SelectedLabel.Text = selected
                   
                   isOpen = false
                   OptionsScroll.Visible = false
                   
                   TweenService:Create(Arrow, TweenInfo.new(0.3), {
                       Rotation = 0
                   }):Play()
                   
                   TweenService:Create(DropdownFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
                       Size = UDim2.new(1, 0, 0, description and 90 or 75)
                   }):Play()
                   
                   TweenService:Create(DropdownStroke, TweenInfo.new(0.3), {
                       Color = Color3.fromRGB(55, 55, 65),
                       Transparency = 0.4
                   }):Play()
                   
                   callback(selected)
               end)
           end
           
           OptionsLayout.Changed:Connect(function()
               OptionsScroll.CanvasSize = UDim2.new(0, 0, 0, OptionsLayout.AbsoluteContentSize.Y + 16)
           end)
           
           DropButton.MouseButton1Click:Connect(function()
               isOpen = not isOpen
               
               if isOpen then
                   OptionsScroll.Visible = true
                   local maxHeight = math.min(#list * 41, 160)
                   OptionsScroll.Size = UDim2.new(1, -40, 0, maxHeight)
                   
                   TweenService:Create(Arrow, TweenInfo.new(0.3), {
                       Rotation = 180
                   }):Play()
                   
                   TweenService:Create(DropdownFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
                       Size = UDim2.new(1, 0, 0, (description and 90 or 75) + maxHeight)
                   }):Play()
                   
                   TweenService:Create(DropdownStroke, TweenInfo.new(0.3), {
                       Color = Color3.fromRGB(130, 170, 255),
                       Transparency = 0.2
                   }):Play()
               else
                   OptionsScroll.Visible = false
                   
                   TweenService:Create(Arrow, TweenInfo.new(0.3), {
                       Rotation = 0
                   }):Play()
                   
                   TweenService:Create(DropdownFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
                       Size = UDim2.new(1, 0, 0, description and 90 or 75)
                   }):Play()
                   
                   TweenService:Create(DropdownStroke, TweenInfo.new(0.3), {
                       Color = Color3.fromRGB(55, 55, 65),
                       Transparency = 0.4
                   }):Play()
               end
           end)
           
           return DropdownFrame
       end
       
       function Tab:AddKeybind(id, options)
           local title = options.Title or "Keybind"
           local description = options.Description
           local default = options.Default or Enum.KeyCode.E
           local callback = options.Callback or function() end
           
           local currentKey = default
           local listening = false
           
           local KeybindFrame = Instance.new("Frame")
           local TitleLabel = Instance.new("TextLabel")
           local DescLabel = Instance.new("TextLabel")
           local KeyButton = Instance.new("TextButton")
           local KeybindIcon = Instance.new("TextLabel")
           local KeybindStroke = Instance.new("UIStroke")
           
           KeybindFrame.Name = id
           KeybindFrame.Parent = TabFrame
           KeybindFrame.BackgroundColor3 = Color3.fromRGB(32, 32, 42)
           KeybindFrame.BorderSizePixel = 0
           KeybindFrame.Size = UDim2.new(1, 0, 0, description and 80 or 60)
           
           local FrameCorner = Instance.new("UICorner")
           FrameCorner.CornerRadius = UDim.new(0, 14)
           FrameCorner.Parent = KeybindFrame
           
           local FrameGradient = Instance.new("UIGradient")
           FrameGradient.Color = ColorSequence.new{
               ColorSequenceKeypoint.new(0, Color3.fromRGB(38, 38, 48)),
               ColorSequenceKeypoint.new(1, Color3.fromRGB(28, 28, 38))
           }
           FrameGradient.Rotation = 90
           FrameGradient.Parent = KeybindFrame
           
           KeybindStroke.Color = Color3.fromRGB(55, 55, 65)
           KeybindStroke.Thickness = 1
           KeybindStroke.Transparency = 0.4
           KeybindStroke.Parent = KeybindFrame
           
           KeybindIcon.Name = "Icon"
           KeybindIcon.Parent = KeybindFrame
           KeybindIcon.BackgroundTransparency = 1
           KeybindIcon.Position = UDim2.new(0, 20, 0, 18)
           KeybindIcon.Size = UDim2.new(0, 28, 0, 28)
           KeybindIcon.Font = Enum.Font.GothamBold
           KeybindIcon.Text = "⌨"
           KeybindIcon.TextColor3 = Color3.fromRGB(130, 170, 255)
           KeybindIcon.TextSize = 18
           
           TitleLabel.Name = "Title"
           TitleLabel.Parent = KeybindFrame
           TitleLabel.BackgroundTransparency = 1
           TitleLabel.Position = UDim2.new(0, 55, 0, 15)
           TitleLabel.Size = UDim2.new(1, -145, 0, 28)
           TitleLabel.Font = Enum.Font.GothamSemiBold
           TitleLabel.Text = title
           TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
           TitleLabel.TextSize = 17
           TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
           
           if description then
               DescLabel.Name = "Description"
               DescLabel.Parent = KeybindFrame
               DescLabel.BackgroundTransparency = 1
               DescLabel.Position = UDim2.new(0, 55, 0, 45)
               DescLabel.Size = UDim2.new(1, -145, 0, 25)
               DescLabel.Font = Enum.Font.Gotham
               DescLabel.Text = description
               DescLabel.TextColor3 = Color3.fromRGB(190, 190, 200)
               DescLabel.TextSize = 14
               DescLabel.TextXAlignment = Enum.TextXAlignment.Left
           end
           
           KeyButton.Name = "Key"
           KeyButton.Parent = KeybindFrame
           KeyButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
           KeyButton.BorderSizePixel = 0
           KeyButton.Position = UDim2.new(1, -80, 0.5, -20)
           KeyButton.Size = UDim2.new(0, 75, 0, 40)
           KeyButton.Font = Enum.Font.GothamSemiBold
           KeyButton.Text = currentKey.Name
           KeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
           KeyButton.TextSize = 13
           
           local KeyCorner = Instance.new("UICorner")
           KeyCorner.CornerRadius = UDim.new(0, 10)
           KeyCorner.Parent = KeyButton
           
           local KeyStroke = Instance.new("UIStroke")
           KeyStroke.Color = Color3.fromRGB(75, 75, 85)
           KeyStroke.Thickness = 1
           KeyStroke.Transparency = 0.5
           KeyStroke.Parent = KeyButton
           
           KeyButton.MouseEnter:Connect(function()
               if not listening then
                   TweenService:Create(KeyButton, TweenInfo.new(0.2), {
                       BackgroundColor3 = Color3.fromRGB(55, 55, 65)
                   }):Play()
                   TweenService:Create(KeyStroke, TweenInfo.new(0.2), {
                       Color = Color3.fromRGB(130, 170, 255),
                       Transparency = 0.3
                   }):Play()
               end
           end)
           
           KeyButton.MouseLeave:Connect(function()
               if not listening then
                   TweenService:Create(KeyButton, TweenInfo.new(0.2), {
                       BackgroundColor3 = Color3.fromRGB(40, 40, 50)
                   }):Play()
                   TweenService:Create(KeyStroke, TweenInfo.new(0.2), {
                       Color = Color3.fromRGB(75, 75, 85),
                       Transparency = 0.5
                   }):Play()
               end
           end)
           
           KeyButton.MouseButton1Click:Connect(function()
               if not listening then
                   listening = true
                   KeyButton.Text = "Press Key..."
                   TweenService:Create(KeyButton, TweenInfo.new(0.2), {
                       BackgroundColor3 = Color3.fromRGB(130, 170, 255)
                   }):Play()
                   TweenService:Create(KeyStroke, TweenInfo.new(0.2), {
                       Color = Color3.fromRGB(255, 255, 255),
                       Transparency = 0.1
                   }):Play()
               end
           end)
           
           UserInputService.InputBegan:Connect(function(input, processed)
               if listening and not processed then
                   if input.UserInputType == Enum.UserInputType.Keyboard then
                       currentKey = input.KeyCode
                       KeyButton.Text = currentKey.Name
                       TweenService:Create(KeyButton, TweenInfo.new(0.2), {
                           BackgroundColor3 = Color3.fromRGB(40, 40, 50)
                       }):Play()
                       TweenService:Create(KeyStroke, TweenInfo.new(0.2), {
                           Color = Color3.fromRGB(75, 75, 85),
                           Transparency = 0.5
                       }):Play()
                       listening = false
                   end
               end
               
               if input.KeyCode == currentKey and not processed then
                   callback()
               end
           end)
           
           return KeybindFrame
       end
       
       self.Tabs[name] = Tab
       return Tab
   end
   
   createWelcomeScreen()
   return Window
end

return UILibrary
