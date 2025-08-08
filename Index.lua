local UILibrary = {}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local plr = Players.LocalPlayer

function UILibrary:CreateWindow(options)
    local title = options.Title or "UI Window"
    local subtitle = options.SubTitle or ""
    local size = options.Size or UDim2.fromOffset(580, 400)
    local tabWidth = options.TabWidth or 160
    local acrylic = options.Acrylic ~= false
    local theme = options.Theme or "Dark"
    local minimizeKey = options.MinimizeKey or Enum.KeyCode.B
    
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local TitleBar = Instance.new("Frame")
    local TitleLabel = Instance.new("TextLabel")
    local SubTitleLabel = Instance.new("TextLabel")
    local CloseButton = Instance.new("TextButton")
    local MinimizeButton = Instance.new("TextButton")
    local TabContainer = Instance.new("Frame")
    local TabButtons = Instance.new("Frame")
    local TabContent = Instance.new("Frame")
    local MinimizedFrame = Instance.new("ImageButton")
    
    ScreenGui.Name = title
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.Size = size
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Visible = true
    
    if acrylic then
        local Blur = Instance.new("BlurEffect")
        Blur.Size = 10
        Blur.Parent = game.Lighting
        
        MainFrame.BackgroundTransparency = 0.1
    end
    
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = MainFrame
    
    TitleBar.Name = "TitleBar"
    TitleBar.Parent = MainFrame
    TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TitleBar.BorderSizePixel = 0
    TitleBar.Size = UDim2.new(1, 0, 0, 45)
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 12)
    TitleCorner.Parent = TitleBar
    
    TitleLabel.Name = "TitleLabel"
    TitleLabel.Parent = TitleBar
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Position = UDim2.new(0, 15, 0, 5)
    TitleLabel.Size = UDim2.new(1, -80, 0, 20)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 16
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    SubTitleLabel.Name = "SubTitleLabel"
    SubTitleLabel.Parent = TitleBar
    SubTitleLabel.BackgroundTransparency = 1
    SubTitleLabel.Position = UDim2.new(0, 15, 0, 25)
    SubTitleLabel.Size = UDim2.new(1, -80, 0, 15)
    SubTitleLabel.Font = Enum.Font.Gotham
    SubTitleLabel.Text = subtitle
    SubTitleLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    SubTitleLabel.TextSize = 12
    SubTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Parent = TitleBar
    MinimizeButton.BackgroundTransparency = 1
    MinimizeButton.Position = UDim2.new(1, -60, 0, 0)
    MinimizeButton.Size = UDim2.new(0, 30, 1, 0)
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.Text = "−"
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 200, 100)
    MinimizeButton.TextSize = 18
    
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = TitleBar
    CloseButton.BackgroundTransparency = 1
    CloseButton.Position = UDim2.new(1, -30, 0, 0)
    CloseButton.Size = UDim2.new(0, 30, 1, 0)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Color3.fromRGB(255, 100, 100)
    CloseButton.TextSize = 18
    
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = MainFrame
    TabContainer.BackgroundTransparency = 1
    TabContainer.Position = UDim2.new(0, 0, 0, 45)
    TabContainer.Size = UDim2.new(1, 0, 1, -45)
    
    TabButtons.Name = "TabButtons"
    TabButtons.Parent = TabContainer
    TabButtons.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TabButtons.BorderSizePixel = 0
    TabButtons.Position = UDim2.new(0, 0, 0, 0)
    TabButtons.Size = UDim2.new(0, tabWidth, 1, 0)
    
    local TabButtonsCorner = Instance.new("UICorner")
    TabButtonsCorner.CornerRadius = UDim.new(0, 8)
    TabButtonsCorner.Parent = TabButtons
    
    TabContent.Name = "TabContent"
    TabContent.Parent = TabContainer
    TabContent.BackgroundTransparency = 1
    TabContent.Position = UDim2.new(0, tabWidth + 10, 0, 10)
    TabContent.Size = UDim2.new(1, -tabWidth - 20, 1, -20)
    
    local TabButtonsLayout = Instance.new("UIListLayout")
    TabButtonsLayout.Parent = TabButtons
    TabButtonsLayout.Padding = UDim.new(0, 3)
    TabButtonsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    MinimizedFrame.Name = "MinimizedFrame"
    MinimizedFrame.Parent = ScreenGui
    MinimizedFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    MinimizedFrame.BorderSizePixel = 0
    MinimizedFrame.Position = UDim2.new(0, 20, 0, 100)
    MinimizedFrame.Size = UDim2.new(0, 60, 0, 60)
    MinimizedFrame.Visible = false
    MinimizedFrame.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    MinimizedFrame.ImageColor3 = Color3.fromRGB(100, 150, 255)
    MinimizedFrame.Draggable = true
    
    local MinimizedCorner = Instance.new("UICorner")
    MinimizedCorner.CornerRadius = UDim.new(0, 30)
    MinimizedCorner.Parent = MinimizedFrame
    
    local MinimizedLabel = Instance.new("TextLabel")
    MinimizedLabel.Parent = MinimizedFrame
    MinimizedLabel.BackgroundTransparency = 1
    MinimizedLabel.Size = UDim2.new(1, 0, 1, 0)
    MinimizedLabel.Font = Enum.Font.GothamBold
    MinimizedLabel.Text = string.sub(title, 1, 1)
    MinimizedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizedLabel.TextSize = 20
    
    local isMinimized = false
    local isDragging = false
    
    local function minimizeWindow()
        isMinimized = not isMinimized
        
        if isMinimized then
            TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
                Position = UDim2.new(0.5, 0, -0.5, 0),
                Size = UDim2.new(0, 0, 0, 0)
            }):Play()
            
            wait(0.4)
            MainFrame.Visible = false
            MinimizedFrame.Visible = true
            
            TweenService:Create(MinimizedFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
                Size = UDim2.new(0, 60, 0, 60)
            }):Play()
        else
            MinimizedFrame.Visible = false
            MainFrame.Visible = true
            MainFrame.Size = UDim2.new(0, 0, 0, 0)
            MainFrame.Position = UDim2.new(0.5, 0, -0.5, 0)
            
            TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
                Position = UDim2.new(0.5, 0, 0.5, 0),
                Size = size
            }):Play()
        end
    end
    
    CloseButton.MouseButton1Click:Connect(function()
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
            Position = UDim2.new(0.5, 0, -0.5, 0),
            Size = UDim2.new(0, 0, 0, 0)
        }):Play()
        
        wait(0.3)
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
        TweenService:Create(MinimizeButton, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.8,
            BackgroundColor3 = Color3.fromRGB(255, 200, 100)
        }):Play()
    end)
    
    MinimizeButton.MouseLeave:Connect(function()
        TweenService:Create(MinimizeButton, TweenInfo.new(0.2), {
            BackgroundTransparency = 1
        }):Play()
    end)
    
    CloseButton.MouseEnter:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.8,
            BackgroundColor3 = Color3.fromRGB(255, 100, 100)
        }):Play()
    end)
    
    CloseButton.MouseLeave:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.2), {
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
    
    function Window:AddTab(options)
        local name = options.Name or "Tab"
        local title = options.Title or name
        
        local TabButton = Instance.new("TextButton")
        local TabFrame = Instance.new("ScrollingFrame")
        local TabLayout = Instance.new("UIListLayout")
        local TabIcon = Instance.new("TextLabel")
        
        TabButton.Name = name
        TabButton.Parent = self.TabButtons
        TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        TabButton.BorderSizePixel = 0
        TabButton.Size = UDim2.new(1, -10, 0, 45)
        TabButton.Font = Enum.Font.GothamMedium
        TabButton.Text = "  " .. title
        TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        TabButton.TextSize = 14
        TabButton.TextXAlignment = Enum.TextXAlignment.Left
        
        local ButtonCorner = Instance.new("UICorner")
        ButtonCorner.CornerRadius = UDim.new(0, 8)
        ButtonCorner.Parent = TabButton
        
        TabFrame.Name = name
        TabFrame.Parent = self.TabContent
        TabFrame.Active = true
        TabFrame.BackgroundTransparency = 1
        TabFrame.BorderSizePixel = 0
        TabFrame.Size = UDim2.new(1, 0, 1, 0)
        TabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabFrame.ScrollBarThickness = 6
        TabFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 150, 255)
        TabFrame.Visible = false
        
        TabLayout.Parent = TabFrame
        TabLayout.Padding = UDim.new(0, 10)
        TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
        
        TabLayout.Changed:Connect(function()
            TabFrame.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y + 20)
        end)
        
        TabButton.MouseEnter:Connect(function()
            if self.CurrentTab and self.CurrentTab.Button ~= TabButton then
                TweenService:Create(TabButton, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                }):Play()
            end
        end)
        
        TabButton.MouseLeave:Connect(function()
            if self.CurrentTab and self.CurrentTab.Button ~= TabButton then
                TweenService:Create(TabButton, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                }):Play()
            end
        end)
        
        TabButton.MouseButton1Click:Connect(function()
            if self.CurrentTab then
                self.CurrentTab.Frame.Visible = false
                TweenService:Create(self.CurrentTab.Button, TweenInfo.new(0.3), {
                    BackgroundColor3 = Color3.fromRGB(40, 40, 40),
                    TextColor3 = Color3.fromRGB(200, 200, 200)
                }):Play()
            end
            
            TabFrame.Visible = true
            TweenService:Create(TabButton, TweenInfo.new(0.3), {
                BackgroundColor3 = Color3.fromRGB(100, 150, 255),
                TextColor3 = Color3.fromRGB(255, 255, 255)
            }):Play()
            
            self.CurrentTab = {Frame = TabFrame, Button = TabButton}
        end)
        
        if not self.CurrentTab then
            TabFrame.Visible = true
            TabButton.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            self.CurrentTab = {Frame = TabFrame, Button = TabButton}
        end
        
        local Tab = {}
        Tab.Frame = TabFrame
        Tab.Button = TabButton
        
        function Tab:AddButton(id, options)
            local title = options.Title or "Button"
            local description = options.Description
            local callback = options.Callback
            
            local ButtonFrame = Instance.new("Frame")
            local Button = Instance.new("TextButton")
            local ButtonLabel = Instance.new("TextLabel")
            local DescLabel = Instance.new("TextLabel")
            local ButtonIcon = Instance.new("TextLabel")
            
            ButtonFrame.Name = id
            ButtonFrame.Parent = TabFrame
            ButtonFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            ButtonFrame.BorderSizePixel = 0
            ButtonFrame.Size = UDim2.new(1, 0, 0, description and 65 or 45)
            
            local FrameCorner = Instance.new("UICorner")
            FrameCorner.CornerRadius = UDim.new(0, 10)
            FrameCorner.Parent = ButtonFrame
            
            Button.Name = "Button"
            Button.Parent = ButtonFrame
            Button.BackgroundTransparency = 1
            Button.Size = UDim2.new(1, 0, 1, 0)
            Button.Text = ""
            
            ButtonIcon.Name = "Icon"
            ButtonIcon.Parent = ButtonFrame
            ButtonIcon.BackgroundTransparency = 1
            ButtonIcon.Position = UDim2.new(0, 15, 0, 10)
            ButtonIcon.Size = UDim2.new(0, 25, 0, 25)
            ButtonIcon.Font = Enum.Font.GothamBold
            ButtonIcon.Text = "●"
            ButtonIcon.TextColor3 = Color3.fromRGB(100, 150, 255)
            ButtonIcon.TextSize = 16
            
            ButtonLabel.Name = "Title"
            ButtonLabel.Parent = ButtonFrame
            ButtonLabel.BackgroundTransparency = 1
            ButtonLabel.Position = UDim2.new(0, 45, 0, 10)
            ButtonLabel.Size = UDim2.new(1, -60, 0, 25)
            ButtonLabel.Font = Enum.Font.GothamSemiBold
            ButtonLabel.Text = title
            ButtonLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            ButtonLabel.TextSize = 14
            ButtonLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            if description then
                DescLabel.Name = "Description"
                DescLabel.Parent = ButtonFrame
                DescLabel.BackgroundTransparency = 1
                DescLabel.Position = UDim2.new(0, 45, 0, 35)
                DescLabel.Size = UDim2.new(1, -60, 0, 20)
                DescLabel.Font = Enum.Font.Gotham
                DescLabel.Text = description
                DescLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
                DescLabel.TextSize = 12
                DescLabel.TextXAlignment = Enum.TextXAlignment.Left
            end
            
            Button.MouseEnter:Connect(function()
                TweenService:Create(ButtonFrame, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(55, 55, 55)
                }):Play()
            end)
            
            Button.MouseLeave:Connect(function()
                TweenService:Create(ButtonFrame, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                }):Play()
            end)
            
            Button.MouseButton1Click:Connect(function()
                TweenService:Create(ButtonFrame, TweenInfo.new(0.1), {
                    BackgroundColor3 = Color3.fromRGB(100, 150, 255)
                }):Play()
                
                wait(0.1)
                
                TweenService:Create(ButtonFrame, TweenInfo.new(0.1), {
                    BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                }):Play()
                
                if callback then
                    callback()
                end
            end)
            
            return ButtonFrame
        end
        
        function Tab:AddToggle(id, options)
            local title = options.Title or "Toggle"
            local description = options.Description
            local default = options.Default or false
            local callback = options.Callback
            
            local toggled = default
            
            local ToggleFrame = Instance.new("Frame")
            local ToggleButton = Instance.new("TextButton")
            local TitleLabel = Instance.new("TextLabel")
            local DescLabel = Instance.new("TextLabel")
            local Switch = Instance.new("Frame")
            local SwitchButton = Instance.new("Frame")
            local ToggleIcon = Instance.new("TextLabel")
            
            ToggleFrame.Name = id
            ToggleFrame.Parent = TabFrame
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.Size = UDim2.new(1, 0, 0, description and 65 or 45)
            
            local FrameCorner = Instance.new("UICorner")
            FrameCorner.CornerRadius = UDim.new(0, 10)
            FrameCorner.Parent = ToggleFrame
            
            ToggleButton.Name = "Button"
            ToggleButton.Parent = ToggleFrame
            ToggleButton.BackgroundTransparency = 1
            ToggleButton.Size = UDim2.new(1, -60, 1, 0)
            ToggleButton.Text = ""
            
            ToggleIcon.Name = "Icon"
            ToggleIcon.Parent = ToggleFrame
            ToggleIcon.BackgroundTransparency = 1
            ToggleIcon.Position = UDim2.new(0, 15, 0, 10)
            ToggleIcon.Size = UDim2.new(0, 25, 0, 25)
            ToggleIcon.Font = Enum.Font.GothamBold
            ToggleIcon.Text = "◐"
            ToggleIcon.TextColor3 = Color3.fromRGB(100, 150, 255)
            ToggleIcon.TextSize = 16
            
            TitleLabel.Name = "Title"
            TitleLabel.Parent = ToggleFrame
            TitleLabel.BackgroundTransparency = 1
            TitleLabel.Position = UDim2.new(0, 45, 0, 10)
            TitleLabel.Size = UDim2.new(1, -105, 0, 25)
            TitleLabel.Font = Enum.Font.GothamSemiBold
            TitleLabel.Text = title
            TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            TitleLabel.TextSize = 14
            TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            if description then
                DescLabel.Name = "Description"
                DescLabel.Parent = ToggleFrame
                DescLabel.BackgroundTransparency = 1
                DescLabel.Position = UDim2.new(0, 45, 0, 35)
                DescLabel.Size = UDim2.new(1, -105, 0, 20)
                DescLabel.Font = Enum.Font.Gotham
                DescLabel.Text = description
                DescLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
                DescLabel.TextSize = 12
                DescLabel.TextXAlignment = Enum.TextXAlignment.Left
            end
            
            Switch.Name = "Switch"
            Switch.Parent = ToggleFrame
            Switch.BackgroundColor3 = toggled and Color3.fromRGB(100, 150, 255) or Color3.fromRGB(60, 60, 60)
            Switch.BorderSizePixel = 0
            Switch.Position = UDim2.new(1, -50, 0.5, -12)
            Switch.Size = UDim2.new(0, 45, 0, 24)
            
            local SwitchCorner = Instance.new("UICorner")
            SwitchCorner.CornerRadius = UDim.new(0, 12)
            SwitchCorner.Parent = Switch
            
            SwitchButton.Name = "Button"
            SwitchButton.Parent = Switch
            SwitchButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SwitchButton.BorderSizePixel = 0
            SwitchButton.Position = toggled and UDim2.new(1, -20, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
            SwitchButton.Size = UDim2.new(0, 20, 0, 20)
            
            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 10)
            ButtonCorner.Parent = SwitchButton
            
            ToggleButton.MouseButton1Click:Connect(function()
                toggled = not toggled
                
                TweenService:Create(Switch, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
                    BackgroundColor3 = toggled and Color3.fromRGB(100, 150, 255) or Color3.fromRGB(60, 60, 60)
                }):Play()
                
                TweenService:Create(SwitchButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
                    Position = toggled and UDim2.new(1, -20, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
                }):Play()
                
                if callback then
                    callback(toggled)
                end
            end)
            
            Switch.MouseButton1Click:Connect(function()
                ToggleButton.MouseButton1Click:Fire()
            end)
            
            ToggleButton.MouseEnter:Connect(function()
                TweenService:Create(ToggleFrame, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                }):Play()
            end)
            
            ToggleButton.MouseLeave:Connect(function()
                TweenService:Create(ToggleFrame, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(40, 40, 40)
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
            local callback = options.Callback
            
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
            
            SliderFrame.Name = id
            SliderFrame.Parent = TabFrame
            SliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            SliderFrame.BorderSizePixel = 0
            SliderFrame.Size = UDim2.new(1, 0, 0, description and 75 or 55)
            
            local FrameCorner = Instance.new("UICorner")
            FrameCorner.CornerRadius = UDim.new(0, 10)
            FrameCorner.Parent = SliderFrame
            
            SliderIcon.Name = "Icon"
            SliderIcon.Parent = SliderFrame
            SliderIcon.BackgroundTransparency = 1
            SliderIcon.Position = UDim2.new(0, 15, 0, 10)
            SliderIcon.Size = UDim2.new(0, 25, 0, 25)
            SliderIcon.Font = Enum.Font.GothamBold
            SliderIcon.Text = "⚬"
            SliderIcon.TextColor3 = Color3.fromRGB(100, 150, 255)
            SliderIcon.TextSize = 16
            
            TitleLabel.Name = "Title"
            TitleLabel.Parent = SliderFrame
            TitleLabel.BackgroundTransparency = 1
            TitleLabel.Position = UDim2.new(0, 45, 0, 10)
            TitleLabel.Size = UDim2.new(1, -120, 0, 20)
            TitleLabel.Font = Enum.Font.GothamSemiBold
            TitleLabel.Text = title
            TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            TitleLabel.TextSize = 14
            TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            ValueLabel.Name = "Value"
            ValueLabel.Parent = SliderFrame
            ValueLabel.BackgroundTransparency = 1
            ValueLabel.Position = UDim2.new(1, -75, 0, 10)
            ValueLabel.Size = UDim2.new(0, 60, 0, 20)
            ValueLabel.Font = Enum.Font.GothamSemiBold
            ValueLabel.Text = tostring(value)
			ValueLabel.TextColor3 = Color3.fromRGB(100, 150, 255)
           ValueLabel.TextSize = 14
           ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
           
           if description then
               DescLabel.Name = "Description"
               DescLabel.Parent = SliderFrame
               DescLabel.BackgroundTransparency = 1
               DescLabel.Position = UDim2.new(0, 45, 0, 30)
               DescLabel.Size = UDim2.new(1, -60, 0, 18)
               DescLabel.Font = Enum.Font.Gotham
               DescLabel.Text = description
               DescLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
               DescLabel.TextSize = 12
               DescLabel.TextXAlignment = Enum.TextXAlignment.Left
               
               SliderTrack.Position = UDim2.new(0, 15, 1, -16)
           else
               SliderTrack.Position = UDim2.new(0, 15, 1, -20)
           end
           
           SliderTrack.Name = "Track"
           SliderTrack.Parent = SliderFrame
           SliderTrack.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
           SliderTrack.BorderSizePixel = 0
           SliderTrack.Size = UDim2.new(1, -30, 0, 6)
           
           local TrackCorner = Instance.new("UICorner")
           TrackCorner.CornerRadius = UDim.new(0, 3)
           TrackCorner.Parent = SliderTrack
           
           SliderFill.Name = "Fill"
           SliderFill.Parent = SliderTrack
           SliderFill.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
           SliderFill.BorderSizePixel = 0
           SliderFill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
           
           local FillCorner = Instance.new("UICorner")
           FillCorner.CornerRadius = UDim.new(0, 3)
           FillCorner.Parent = SliderFill
           
           SliderHandle.Name = "Handle"
           SliderHandle.Parent = SliderTrack
           SliderHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
           SliderHandle.BorderSizePixel = 0
           SliderHandle.Position = UDim2.new((value - min) / (max - min), -8, 0.5, -8)
           SliderHandle.Size = UDim2.new(0, 16, 0, 16)
           SliderHandle.Text = ""
           
           local HandleCorner = Instance.new("UICorner")
           HandleCorner.CornerRadius = UDim.new(0, 8)
           HandleCorner.Parent = SliderHandle
           
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
                   Position = UDim2.new(percent, -8, 0.5, -8)
               }):Play()
               
               if callback then
                   callback(value)
               end
           end
           
           SliderHandle.InputBegan:Connect(function(input)
               if input.UserInputType == Enum.UserInputType.MouseButton1 then
                   dragging = true
                   TweenService:Create(SliderHandle, TweenInfo.new(0.2), {
                       Size = UDim2.new(0, 20, 0, 20),
                       BackgroundColor3 = Color3.fromRGB(100, 150, 255)
                   }):Play()
               end
           end)
           
           SliderHandle.InputEnded:Connect(function(input)
               if input.UserInputType == Enum.UserInputType.MouseButton1 then
                   dragging = false
                   TweenService:Create(SliderHandle, TweenInfo.new(0.2), {
                       Size = UDim2.new(0, 16, 0, 16),
                       BackgroundColor3 = Color3.fromRGB(255, 255, 255)
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
           local callback = options.Callback
           
           local InputFrame = Instance.new("Frame")
           local TitleLabel = Instance.new("TextLabel")
           local DescLabel = Instance.new("TextLabel")
           local TextBox = Instance.new("TextBox")
           local InputIcon = Instance.new("TextLabel")
           
           InputFrame.Name = id
           InputFrame.Parent = TabFrame
           InputFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
           InputFrame.BorderSizePixel = 0
           InputFrame.Size = UDim2.new(1, 0, 0, description and 75 or 60)
           
           local FrameCorner = Instance.new("UICorner")
           FrameCorner.CornerRadius = UDim.new(0, 10)
           FrameCorner.Parent = InputFrame
           
           InputIcon.Name = "Icon"
           InputIcon.Parent = InputFrame
           InputIcon.BackgroundTransparency = 1
           InputIcon.Position = UDim2.new(0, 15, 0, 10)
           InputIcon.Size = UDim2.new(0, 25, 0, 25)
           InputIcon.Font = Enum.Font.GothamBold
           InputIcon.Text = "✎"
           InputIcon.TextColor3 = Color3.fromRGB(100, 150, 255)
           InputIcon.TextSize = 16
           
           TitleLabel.Name = "Title"
           TitleLabel.Parent = InputFrame
           TitleLabel.BackgroundTransparency = 1
           TitleLabel.Position = UDim2.new(0, 45, 0, 10)
           TitleLabel.Size = UDim2.new(1, -60, 0, 20)
           TitleLabel.Font = Enum.Font.GothamSemiBold
           TitleLabel.Text = title
           TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
           TitleLabel.TextSize = 14
           TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
           
           if description then
               DescLabel.Name = "Description"
               DescLabel.Parent = InputFrame
               DescLabel.BackgroundTransparency = 1
               DescLabel.Position = UDim2.new(0, 45, 0, 30)
               DescLabel.Size = UDim2.new(1, -60, 0, 18)
               DescLabel.Font = Enum.Font.Gotham
               DescLabel.Text = description
               DescLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
               DescLabel.TextSize = 12
               DescLabel.TextXAlignment = Enum.TextXAlignment.Left
               
               TextBox.Position = UDim2.new(0, 15, 1, -28)
           else
               TextBox.Position = UDim2.new(0, 15, 1, -32)
           end
           
           TextBox.Name = "Input"
           TextBox.Parent = InputFrame
           TextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
           TextBox.BorderSizePixel = 0
           TextBox.Size = UDim2.new(1, -30, 0, 26)
           TextBox.Font = Enum.Font.Gotham
           TextBox.PlaceholderText = placeholder
           TextBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
           TextBox.Text = ""
           TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
           TextBox.TextSize = 13
           TextBox.TextXAlignment = Enum.TextXAlignment.Left
           
           local InputCorner = Instance.new("UICorner")
           InputCorner.CornerRadius = UDim.new(0, 6)
           InputCorner.Parent = TextBox
           
           TextBox.Focused:Connect(function()
               TweenService:Create(TextBox, TweenInfo.new(0.2), {
                   BackgroundColor3 = Color3.fromRGB(100, 150, 255),
                   TextColor3 = Color3.fromRGB(255, 255, 255)
               }):Play()
           end)
           
           TextBox.FocusLost:Connect(function()
               TweenService:Create(TextBox, TweenInfo.new(0.2), {
                   BackgroundColor3 = Color3.fromRGB(50, 50, 50),
                   TextColor3 = Color3.fromRGB(255, 255, 255)
               }):Play()
               
               if callback then
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
           LabelFrame.Size = UDim2.new(1, 0, 0, description and 45 or 30)
           
           LabelIcon.Name = "Icon"
           LabelIcon.Parent = LabelFrame
           LabelIcon.BackgroundTransparency = 1
           LabelIcon.Position = UDim2.new(0, 0, 0, 5)
           LabelIcon.Size = UDim2.new(0, 25, 0, 20)
           LabelIcon.Font = Enum.Font.GothamBold
           LabelIcon.Text = "ℹ"
           LabelIcon.TextColor3 = Color3.fromRGB(100, 150, 255)
           LabelIcon.TextSize = 14
           
           TitleLabel.Name = "Title"
           TitleLabel.Parent = LabelFrame
           TitleLabel.BackgroundTransparency = 1
           TitleLabel.Position = UDim2.new(0, 30, 0, 5)
           TitleLabel.Size = UDim2.new(1, -30, 0, 20)
           TitleLabel.Font = Enum.Font.GothamSemiBold
           TitleLabel.Text = title
           TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
           TitleLabel.TextSize = 14
           TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
           
           if description then
               DescLabel.Name = "Description"
               DescLabel.Parent = LabelFrame
               DescLabel.BackgroundTransparency = 1
               DescLabel.Position = UDim2.new(0, 30, 0, 25)
               DescLabel.Size = UDim2.new(1, -30, 0, 18)
               DescLabel.Font = Enum.Font.Gotham
               DescLabel.Text = description
               DescLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
               DescLabel.TextSize = 12
               DescLabel.TextXAlignment = Enum.TextXAlignment.Left
           end
           
           return LabelFrame
       end
       
       function Tab:AddSection(id, options)
           local title = options.Title or "Section"
           
           local SectionFrame = Instance.new("Frame")
           local SectionLabel = Instance.new("TextLabel")
           local Separator = Instance.new("Frame")
           
           SectionFrame.Name = id
           SectionFrame.Parent = TabFrame
           SectionFrame.BackgroundTransparency = 1
           SectionFrame.Size = UDim2.new(1, 0, 0, 35)
           
           SectionLabel.Name = "Title"
           SectionLabel.Parent = SectionFrame
           SectionLabel.BackgroundTransparency = 1
           SectionLabel.Position = UDim2.new(0, 0, 0, 8)
           SectionLabel.Size = UDim2.new(1, 0, 0, 22)
           SectionLabel.Font = Enum.Font.GothamBold
           SectionLabel.Text = title
           SectionLabel.TextColor3 = Color3.fromRGB(100, 150, 255)
           SectionLabel.TextSize = 16
           SectionLabel.TextXAlignment = Enum.TextXAlignment.Left
           
           Separator.Name = "Separator"
           Separator.Parent = SectionFrame
           Separator.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
           Separator.BorderSizePixel = 0
           Separator.Position = UDim2.new(0, 0, 1, -2)
           Separator.Size = UDim2.new(1, 0, 0, 2)
           
           local SepCorner = Instance.new("UICorner")
           SepCorner.CornerRadius = UDim.new(0, 1)
           SepCorner.Parent = Separator
           
           return SectionFrame
       end
       
       function Tab:AddDropdown(id, options)
           local title = options.Title or "Dropdown"
           local description = options.Description
           local list = options.List or {}
           local default = options.Default or (list[1] or "None")
           local callback = options.Callback
           
           local selected = default
           local isOpen = false
           
           local DropdownFrame = Instance.new("Frame")
           local TitleLabel = Instance.new("TextLabel")
           local DescLabel = Instance.new("TextLabel")
           local DropButton = Instance.new("TextButton")
           local SelectedLabel = Instance.new("TextLabel")
           local Arrow = Instance.new("TextLabel")
           local OptionsList = Instance.new("Frame")
           local OptionsLayout = Instance.new("UIListLayout")
           local DropdownIcon = Instance.new("TextLabel")
           
           DropdownFrame.Name = id
           DropdownFrame.Parent = TabFrame
           DropdownFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
           DropdownFrame.BorderSizePixel = 0
           DropdownFrame.Size = UDim2.new(1, 0, 0, description and 75 or 60)
           DropdownFrame.ClipsDescendants = true
           
           local FrameCorner = Instance.new("UICorner")
           FrameCorner.CornerRadius = UDim.new(0, 10)
           FrameCorner.Parent = DropdownFrame
           
           DropdownIcon.Name = "Icon"
           DropdownIcon.Parent = DropdownFrame
           DropdownIcon.BackgroundTransparency = 1
           DropdownIcon.Position = UDim2.new(0, 15, 0, 10)
           DropdownIcon.Size = UDim2.new(0, 25, 0, 25)
           DropdownIcon.Font = Enum.Font.GothamBold
           DropdownIcon.Text = "≡"
           DropdownIcon.TextColor3 = Color3.fromRGB(100, 150, 255)
           DropdownIcon.TextSize = 16
           
           TitleLabel.Name = "Title"
           TitleLabel.Parent = DropdownFrame
           TitleLabel.BackgroundTransparency = 1
           TitleLabel.Position = UDim2.new(0, 45, 0, 10)
           TitleLabel.Size = UDim2.new(1, -60, 0, 20)
           TitleLabel.Font = Enum.Font.GothamSemiBold
           TitleLabel.Text = title
           TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
           TitleLabel.TextSize = 14
           TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
           
           if description then
               DescLabel.Name = "Description"
               DescLabel.Parent = DropdownFrame
               DescLabel.BackgroundTransparency = 1
               DescLabel.Position = UDim2.new(0, 45, 0, 30)
               DescLabel.Size = UDim2.new(1, -60, 0, 18)
               DescLabel.Font = Enum.Font.Gotham
               DescLabel.Text = description
               DescLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
               DescLabel.TextSize = 12
               DescLabel.TextXAlignment = Enum.TextXAlignment.Left
               
               DropButton.Position = UDim2.new(0, 15, 1, -28)
           else
               DropButton.Position = UDim2.new(0, 15, 1, -32)
           end
           
           DropButton.Name = "Button"
           DropButton.Parent = DropdownFrame
           DropButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
           DropButton.BorderSizePixel = 0
           DropButton.Size = UDim2.new(1, -30, 0, 26)
           DropButton.Text = ""
           
           local ButtonCorner = Instance.new("UICorner")
           ButtonCorner.CornerRadius = UDim.new(0, 6)
           ButtonCorner.Parent = DropButton
           
           SelectedLabel.Name = "Selected"
           SelectedLabel.Parent = DropButton
           SelectedLabel.BackgroundTransparency = 1
           SelectedLabel.Position = UDim2.new(0, 10, 0, 0)
           SelectedLabel.Size = UDim2.new(1, -35, 1, 0)
           SelectedLabel.Font = Enum.Font.Gotham
           SelectedLabel.Text = selected
           SelectedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
           SelectedLabel.TextSize = 13
           SelectedLabel.TextXAlignment = Enum.TextXAlignment.Left
           
           Arrow.Name = "Arrow"
           Arrow.Parent = DropButton
           Arrow.BackgroundTransparency = 1
           Arrow.Position = UDim2.new(1, -25, 0, 0)
           Arrow.Size = UDim2.new(0, 25, 1, 0)
           Arrow.Font = Enum.Font.GothamSemiBold
           Arrow.Text = "▼"
           Arrow.TextColor3 = Color3.fromRGB(200, 200, 200)
           Arrow.TextSize = 12
           
           OptionsList.Name = "Options"
           OptionsList.Parent = DropdownFrame
           OptionsList.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
           OptionsList.BorderSizePixel = 0
           OptionsList.Position = UDim2.new(0, 15, 1, -6)
           OptionsList.Size = UDim2.new(1, -30, 0, 0)
           OptionsList.Visible = false
           
           local OptionsCorner = Instance.new("UICorner")
           OptionsCorner.CornerRadius = UDim.new(0, 6)
           OptionsCorner.Parent = OptionsList
           
           OptionsLayout.Parent = OptionsList
           OptionsLayout.SortOrder = Enum.SortOrder.LayoutOrder
           
           for i, option in pairs(list) do
               local OptionButton = Instance.new("TextButton")
               
               OptionButton.Name = option
               OptionButton.Parent = OptionsList
               OptionButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
               OptionButton.BorderSizePixel = 0
               OptionButton.Size = UDim2.new(1, 0, 0, 28)
               OptionButton.Font = Enum.Font.Gotham
               OptionButton.Text = option
               OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
               OptionButton.TextSize = 12
               
               OptionButton.MouseEnter:Connect(function()
                   TweenService:Create(OptionButton, TweenInfo.new(0.2), {
                       BackgroundColor3 = Color3.fromRGB(100, 150, 255)
                   }):Play()
               end)
               
               OptionButton.MouseLeave:Connect(function()
                   TweenService:Create(OptionButton, TweenInfo.new(0.2), {
                       BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                   }):Play()
               end)
               
               OptionButton.MouseButton1Click:Connect(function()
                   selected = option
                   SelectedLabel.Text = selected
                   
                   isOpen = false
                   OptionsList.Visible = false
                   
                   TweenService:Create(Arrow, TweenInfo.new(0.2), {
                       Rotation = 0
                   }):Play()
                   
                   TweenService:Create(DropdownFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
                       Size = UDim2.new(1, 0, 0, description and 75 or 60)
                   }):Play()
                   
                   if callback then
                       callback(selected)
                   end
               end)
           end
           
           DropButton.MouseButton1Click:Connect(function()
               isOpen = not isOpen
               
               if isOpen then
                   OptionsList.Visible = true
                   OptionsList.Size = UDim2.new(1, -30, 0, #list * 28)
                   
                   TweenService:Create(Arrow, TweenInfo.new(0.2), {
                       Rotation = 180
                   }):Play()
                   
                   TweenService:Create(DropdownFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
                       Size = UDim2.new(1, 0, 0, (description and 75 or 60) + (#list * 28))
                   }):Play()
               else
                   OptionsList.Visible = false
                   
                   TweenService:Create(Arrow, TweenInfo.new(0.2), {
                       Rotation = 0
                   }):Play()
                   
                   TweenService:Create(DropdownFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
                       Size = UDim2.new(1, 0, 0, description and 75 or 60)
                   }):Play()
               end
           end)
           
           return DropdownFrame
       end
       
       function Tab:AddKeybind(id, options)
           local title = options.Title or "Keybind"
           local description = options.Description
           local default = options.Default or Enum.KeyCode.E
           local callback = options.Callback
           
           local currentKey = default
           local listening = false
           
           local KeybindFrame = Instance.new("Frame")
           local TitleLabel = Instance.new("TextLabel")
           local DescLabel = Instance.new("TextLabel")
           local KeyButton = Instance.new("TextButton")
           local KeybindIcon = Instance.new("TextLabel")
           
           KeybindFrame.Name = id
           KeybindFrame.Parent = TabFrame
           KeybindFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
           KeybindFrame.BorderSizePixel = 0
           KeybindFrame.Size = UDim2.new(1, 0, 0, description and 65 or 45)
           
           local FrameCorner = Instance.new("UICorner")
           FrameCorner.CornerRadius = UDim.new(0, 10)
           FrameCorner.Parent = KeybindFrame
           
           KeybindIcon.Name = "Icon"
           KeybindIcon.Parent = KeybindFrame
           KeybindIcon.BackgroundTransparency = 1
           KeybindIcon.Position = UDim2.new(0, 15, 0, 10)
           KeybindIcon.Size = UDim2.new(0, 25, 0, 25)
           KeybindIcon.Font = Enum.Font.GothamBold
           KeybindIcon.Text = "⌨"
           KeybindIcon.TextColor3 = Color3.fromRGB(100, 150, 255)
           KeybindIcon.TextSize = 16
           
           TitleLabel.Name = "Title"
           TitleLabel.Parent = KeybindFrame
           TitleLabel.BackgroundTransparency = 1
           TitleLabel.Position = UDim2.new(0, 45, 0, 10)
           TitleLabel.Size = UDim2.new(1, -115, 0, 25)
           TitleLabel.Font = Enum.Font.GothamSemiBold
           TitleLabel.Text = title
           TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
           TitleLabel.TextSize = 14
           TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
           
           if description then
               DescLabel.Name = "Description"
               DescLabel.Parent = KeybindFrame
               DescLabel.BackgroundTransparency = 1
               DescLabel.Position = UDim2.new(0, 45, 0, 35)
               DescLabel.Size = UDim2.new(1, -115, 0, 20)
               DescLabel.Font = Enum.Font.Gotham
               DescLabel.Text = description
               DescLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
               DescLabel.TextSize = 12
               DescLabel.TextXAlignment = Enum.TextXAlignment.Left
           end
           
           KeyButton.Name = "Key"
           KeyButton.Parent = KeybindFrame
           KeyButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
           KeyButton.BorderSizePixel = 0
           KeyButton.Position = UDim2.new(1, -65, 0.5, -15)
           KeyButton.Size = UDim2.new(0, 60, 0, 30)
           KeyButton.Font = Enum.Font.GothamSemiBold
           KeyButton.Text = currentKey.Name
           KeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
           KeyButton.TextSize = 11
           
           local KeyCorner = Instance.new("UICorner")
           KeyCorner.CornerRadius = UDim.new(0, 6)
           KeyCorner.Parent = KeyButton
           
           KeyButton.MouseEnter:Connect(function()
               if not listening then
                   TweenService:Create(KeyButton, TweenInfo.new(0.2), {
                       BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                   }):Play()
               end
           end)
           
           KeyButton.MouseLeave:Connect(function()
               if not listening then
                   TweenService:Create(KeyButton, TweenInfo.new(0.2), {
                       BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                   }):Play()
               end
           end)
           
           KeyButton.MouseButton1Click:Connect(function()
               if not listening then
                   listening = true
                   KeyButton.Text = "..."
                   TweenService:Create(KeyButton, TweenInfo.new(0.2), {
                       BackgroundColor3 = Color3.fromRGB(100, 150, 255)
                   }):Play()
               end
           end)
           
           UserInputService.InputBegan:Connect(function(input, processed)
               if listening and not processed then
                   if input.UserInputType == Enum.UserInputType.Keyboard then
                       currentKey = input.KeyCode
                       KeyButton.Text = currentKey.Name
                       TweenService:Create(KeyButton, TweenInfo.new(0.2), {
                           BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                       }):Play()
                       listening = false
                   end
               end
               
               if input.KeyCode == currentKey and not processed then
                   if callback then
                       callback()
                   end
               end
           end)
           
           return KeybindFrame
       end
       
       self.Tabs[name] = Tab
       return Tab
   end
   
   return Window
end

return UILibrary
