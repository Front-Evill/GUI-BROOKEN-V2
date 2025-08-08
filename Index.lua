local UILibrary = {}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local plr = Players.LocalPlayer

function UILibrary:CreateWindow(options)
    local title = options.Title or "UI Window"
    local size = options.Size or UDim2.new(0, 400, 0, 300)
    
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local TitleBar = Instance.new("Frame")
    local TitleLabel = Instance.new("TextLabel")
    local CloseButton = Instance.new("TextButton")
    local TabContainer = Instance.new("Frame")
    local TabButtons = Instance.new("Frame")
    local TabContent = Instance.new("Frame")
    
    ScreenGui.Name = title
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.Size = size
    MainFrame.Active = true
    MainFrame.Draggable = true
    
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = MainFrame
    
    TitleBar.Name = "TitleBar"
    TitleBar.Parent = MainFrame
    TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TitleBar.BorderSizePixel = 0
    TitleBar.Size = UDim2.new(1, 0, 0, 30)
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 8)
    TitleCorner.Parent = TitleBar
    
    TitleLabel.Name = "TitleLabel"
    TitleLabel.Parent = TitleBar
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Position = UDim2.new(0, 10, 0, 0)
    TitleLabel.Size = UDim2.new(1, -40, 1, 0)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 14
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = TitleBar
    CloseButton.BackgroundTransparency = 1
    CloseButton.Position = UDim2.new(1, -30, 0, 0)
    CloseButton.Size = UDim2.new(0, 30, 1, 0)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Color3.fromRGB(255, 100, 100)
    CloseButton.TextSize = 16
    
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = MainFrame
    TabContainer.BackgroundTransparency = 1
    TabContainer.Position = UDim2.new(0, 0, 0, 30)
    TabContainer.Size = UDim2.new(1, 0, 1, -30)
    
    TabButtons.Name = "TabButtons"
    TabButtons.Parent = TabContainer
    TabButtons.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TabButtons.BorderSizePixel = 0
    TabButtons.Position = UDim2.new(0, 0, 0, 0)
    TabButtons.Size = UDim2.new(0, 120, 1, 0)
    
    TabContent.Name = "TabContent"
    TabContent.Parent = TabContainer
    TabContent.BackgroundTransparency = 1
    TabContent.Position = UDim2.new(0, 120, 0, 0)
    TabContent.Size = UDim2.new(1, -120, 1, 0)
    
    local TabButtonsLayout = Instance.new("UIListLayout")
    TabButtonsLayout.Parent = TabButtons
    TabButtonsLayout.Padding = UDim.new(0, 2)
    TabButtonsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    local Window = {}
    Window.ScreenGui = ScreenGui
    Window.MainFrame = MainFrame
    Window.TabContainer = TabContainer
    Window.TabButtons = TabButtons
    Window.TabContent = TabContent
    Window.Tabs = {}
    Window.CurrentTab = nil
    
    function Window:AddTab(options)
        local name = options.Name or "Tab"
        local title = options.Title or name
        
        local TabButton = Instance.new("TextButton")
        local TabFrame = Instance.new("ScrollingFrame")
        local TabLayout = Instance.new("UIListLayout")
        
        TabButton.Name = name
        TabButton.Parent = self.TabButtons
        TabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        TabButton.BorderSizePixel = 0
        TabButton.Size = UDim2.new(1, 0, 0, 35)
        TabButton.Font = Enum.Font.Gotham
        TabButton.Text = title
        TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        TabButton.TextSize = 12
        
        local ButtonCorner = Instance.new("UICorner")
        ButtonCorner.CornerRadius = UDim.new(0, 6)
        ButtonCorner.Parent = TabButton
        
        TabFrame.Name = name
        TabFrame.Parent = self.TabContent
        TabFrame.Active = true
        TabFrame.BackgroundTransparency = 1
        TabFrame.BorderSizePixel = 0
        TabFrame.Position = UDim2.new(0, 10, 0, 10)
        TabFrame.Size = UDim2.new(1, -20, 1, -20)
        TabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabFrame.ScrollBarThickness = 4
        TabFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
        TabFrame.Visible = false
        
        TabLayout.Parent = TabFrame
        TabLayout.Padding = UDim.new(0, 8)
        TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
        
        TabLayout.Changed:Connect(function()
            TabFrame.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y + 10)
        end)
        
        TabButton.MouseButton1Click:Connect(function()
            if self.CurrentTab then
                self.CurrentTab.Frame.Visible = false
                self.CurrentTab.Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                self.CurrentTab.Button.TextColor3 = Color3.fromRGB(200, 200, 200)
            end
            
            TabFrame.Visible = true
            TabButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            self.CurrentTab = {Frame = TabFrame, Button = TabButton}
        end)
        
        if not self.CurrentTab then
            TabFrame.Visible = true
            TabButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
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
            
            ButtonFrame.Name = id
            ButtonFrame.Parent = TabFrame
            ButtonFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            ButtonFrame.BorderSizePixel = 0
            ButtonFrame.Size = UDim2.new(1, 0, 0, description and 60 or 40)
            
            local FrameCorner = Instance.new("UICorner")
            FrameCorner.CornerRadius = UDim.new(0, 6)
            FrameCorner.Parent = ButtonFrame
            
            Button.Name = "Button"
            Button.Parent = ButtonFrame
            Button.BackgroundTransparency = 1
            Button.Size = UDim2.new(1, 0, 1, 0)
            Button.Text = ""
            
            ButtonLabel.Name = "Title"
            ButtonLabel.Parent = ButtonFrame
            ButtonLabel.BackgroundTransparency = 1
            ButtonLabel.Position = UDim2.new(0, 12, 0, 8)
            ButtonLabel.Size = UDim2.new(1, -24, 0, 20)
            ButtonLabel.Font = Enum.Font.GothamMedium
            ButtonLabel.Text = title
            ButtonLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            ButtonLabel.TextSize = 13
            ButtonLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            if description then
                DescLabel.Name = "Description"
                DescLabel.Parent = ButtonFrame
                DescLabel.BackgroundTransparency = 1
                DescLabel.Position = UDim2.new(0, 12, 0, 28)
                DescLabel.Size = UDim2.new(1, -24, 0, 16)
                DescLabel.Font = Enum.Font.Gotham
                DescLabel.Text = description
                DescLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
                DescLabel.TextSize = 11
                DescLabel.TextXAlignment = Enum.TextXAlignment.Left
            end
            
            Button.MouseEnter:Connect(function()
                TweenService:Create(ButtonFrame, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                }):Play()
            end)
            
            Button.MouseLeave:Connect(function()
                TweenService:Create(ButtonFrame, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                }):Play()
            end)
            
            if callback then
                Button.MouseButton1Click:Connect(callback)
            end
            
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
            
            ToggleFrame.Name = id
            ToggleFrame.Parent = TabFrame
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.Size = UDim2.new(1, 0, 0, description and 60 or 40)
            
            local FrameCorner = Instance.new("UICorner")
            FrameCorner.CornerRadius = UDim.new(0, 6)
            FrameCorner.Parent = ToggleFrame
            
            ToggleButton.Name = "Button"
            ToggleButton.Parent = ToggleFrame
            ToggleButton.BackgroundTransparency = 1
            ToggleButton.Size = UDim2.new(1, -50, 1, 0)
            ToggleButton.Text = ""
            
            TitleLabel.Name = "Title"
            TitleLabel.Parent = ToggleFrame
            TitleLabel.BackgroundTransparency = 1
            TitleLabel.Position = UDim2.new(0, 12, 0, 8)
            TitleLabel.Size = UDim2.new(1, -70, 0, 20)
            TitleLabel.Font = Enum.Font.GothamMedium
            TitleLabel.Text = title
            TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            TitleLabel.TextSize = 13
            TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            if description then
                DescLabel.Name = "Description"
                DescLabel.Parent = ToggleFrame
                DescLabel.BackgroundTransparency = 1
                DescLabel.Position = UDim2.new(0, 12, 0, 28)
                DescLabel.Size = UDim2.new(1, -70, 0, 16)
                DescLabel.Font = Enum.Font.Gotham
                DescLabel.Text = description
                DescLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
                DescLabel.TextSize = 11
                DescLabel.TextXAlignment = Enum.TextXAlignment.Left
            end
            
            Switch.Name = "Switch"
            Switch.Parent = ToggleFrame
            Switch.BackgroundColor3 = toggled and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(60, 60, 60)
            Switch.BorderSizePixel = 0
            Switch.Position = UDim2.new(1, -45, 0.5, -10)
            Switch.Size = UDim2.new(0, 40, 0, 20)
            
            local SwitchCorner = Instance.new("UICorner")
            SwitchCorner.CornerRadius = UDim.new(0, 10)
            SwitchCorner.Parent = Switch
            
            SwitchButton.Name = "Button"
            SwitchButton.Parent = Switch
            SwitchButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SwitchButton.BorderSizePixel = 0
            SwitchButton.Position = toggled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
            SwitchButton.Size = UDim2.new(0, 16, 0, 16)
            
            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 8)
            ButtonCorner.Parent = SwitchButton
            
            ToggleButton.MouseButton1Click:Connect(function()
                toggled = not toggled
                
                TweenService:Create(Switch, TweenInfo.new(0.2), {
                    BackgroundColor3 = toggled and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(60, 60, 60)
                }):Play()
                
                TweenService:Create(SwitchButton, TweenInfo.new(0.2), {
                    Position = toggled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
                }):Play()
                
                if callback then
                    callback(toggled)
                end
            end)
            
            Switch.MouseButton1Click:Connect(function()
                ToggleButton.MouseButton1Click:Fire()
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
            
            SliderFrame.Name = id
            SliderFrame.Parent = TabFrame
            SliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            SliderFrame.BorderSizePixel = 0
            SliderFrame.Size = UDim2.new(1, 0, 0, description and 70 or 50)
            
            local FrameCorner = Instance.new("UICorner")
            FrameCorner.CornerRadius = UDim.new(0, 6)
            FrameCorner.Parent = SliderFrame
            
            TitleLabel.Name = "Title"
            TitleLabel.Parent = SliderFrame
            TitleLabel.BackgroundTransparency = 1
            TitleLabel.Position = UDim2.new(0, 12, 0, 8)
            TitleLabel.Size = UDim2.new(1, -80, 0, 16)
            TitleLabel.Font = Enum.Font.GothamMedium
            TitleLabel.Text = title
            TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            TitleLabel.TextSize = 13
            TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            ValueLabel.Name = "Value"
            ValueLabel.Parent = SliderFrame
            ValueLabel.BackgroundTransparency = 1
            ValueLabel.Position = UDim2.new(1, -70, 0, 8)
            ValueLabel.Size = UDim2.new(0, 60, 0, 16)
            ValueLabel.Font = Enum.Font.GothamMedium
            ValueLabel.Text = tostring(value)
            ValueLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
            ValueLabel.TextSize = 13
            ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
            
            if description then
                DescLabel.Name = "Description"
                DescLabel.Parent = SliderFrame
                DescLabel.BackgroundTransparency = 1
                DescLabel.Position = UDim2.new(0, 12, 0, 24)
                DescLabel.Size = UDim2.new(1, -24, 0, 14)
                DescLabel.Font = Enum.Font.Gotham
                DescLabel.Text = description
                DescLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
                DescLabel.TextSize = 11
                DescLabel.TextXAlignment = Enum.TextXAlignment.Left
                
                SliderTrack.Position = UDim2.new(0, 12, 1, -14)
            else
                SliderTrack.Position = UDim2.new(0, 12, 1, -18)
            end
            
            SliderTrack.Name = "Track"
            SliderTrack.Parent = SliderFrame
            SliderTrack.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            SliderTrack.BorderSizePixel = 0
            SliderTrack.Size = UDim2.new(1, -24, 0, 4)
            
            local TrackCorner = Instance.new("UICorner")
            TrackCorner.CornerRadius = UDim.new(0, 2)
            TrackCorner.Parent = SliderTrack
            
            SliderFill.Name = "Fill"
            SliderFill.Parent = SliderTrack
            SliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
            SliderFill.BorderSizePixel = 0
            SliderFill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
            
            local FillCorner = Instance.new("UICorner")
            FillCorner.CornerRadius = UDim.new(0, 2)
            FillCorner.Parent = SliderFill
            
            SliderHandle.Name = "Handle"
            SliderHandle.Parent = SliderTrack
            SliderHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderHandle.BorderSizePixel = 0
            SliderHandle.Position = UDim2.new((value - min) / (max - min), -6, 0.5, -6)
            SliderHandle.Size = UDim2.new(0, 12, 0, 12)
            SliderHandle.Text = ""
            
            local HandleCorner = Instance.new("UICorner")
            HandleCorner.CornerRadius = UDim.new(0, 6)
            HandleCorner.Parent = SliderHandle
            
            local function updateSlider(input)
                local sizeX = SliderTrack.AbsoluteSize.X
                local posX = input.Position.X - SliderTrack.AbsolutePosition.X
                local percent = math.clamp(posX / sizeX, 0, 1)
                
                value = math.floor(min + (max - min) * percent)
                ValueLabel.Text = tostring(value)
                
                SliderFill.Size = UDim2.new(percent, 0, 1, 0)
                SliderHandle.Position = UDim2.new(percent, -6, 0.5, -6)
                
                if callback then
                    callback(value)
                end
            end
            
            SliderHandle.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                end
            end)
            
            SliderHandle.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
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
            
            InputFrame.Name = id
            InputFrame.Parent = TabFrame
            InputFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            InputFrame.BorderSizePixel = 0
            InputFrame.Size = UDim2.new(1, 0, 0, description and 70 or 55)
            
            local FrameCorner = Instance.new("UICorner")
            FrameCorner.CornerRadius = UDim.new(0, 6)
            FrameCorner.Parent = InputFrame
            
            TitleLabel.Name = "Title"
            TitleLabel.Parent = InputFrame
            TitleLabel.BackgroundTransparency = 1
            TitleLabel.Position = UDim2.new(0, 12, 0, 8)
            TitleLabel.Size = UDim2.new(1, -24, 0, 16)
            TitleLabel.Font = Enum.Font.GothamMedium
            TitleLabel.Text = title
            TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            TitleLabel.TextSize = 13
            TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            if description then
                DescLabel.Name = "Description"
                DescLabel.Parent = InputFrame
                DescLabel.BackgroundTransparency = 1
                DescLabel.Position = UDim2.new(0, 12, 0, 24)
                DescLabel.Size = UDim2.new(1, -24, 0, 14)
                DescLabel.Font = Enum.Font.Gotham
                DescLabel.Text = description
                DescLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
                DescLabel.TextSize = 11
                DescLabel.TextXAlignment = Enum.TextXAlignment.Left
                
                TextBox.Position = UDim2.new(0, 12, 1, -26)
            else
                TextBox.Position = UDim2.new(0, 12, 1, -30)
            end
            
            TextBox.Name = "Input"
            TextBox.Parent = InputFrame
            TextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            TextBox.BorderSizePixel = 0
            TextBox.Size = UDim2.new(1, -24, 0, 22)
            TextBox.Font = Enum.Font.Gotham
            TextBox.PlaceholderText = placeholder
            TextBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
            TextBox.Text = ""
            TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.TextSize = 12
            TextBox.TextXAlignment = Enum.TextXAlignment.Left
            
            local InputCorner = Instance.new("UICorner")
            InputCorner.CornerRadius = UDim.new(0, 4)
            InputCorner.Parent = TextBox
            
            if callback then
                TextBox.FocusLost:Connect(function()
                    callback(TextBox.Text)
                end)
            end
            
            return InputFrame
        end
        
        function Tab:AddLabel(id, options)
            local title = options.Title or "Label"
            local description = options.Description
            
            local LabelFrame = Instance.new("Frame")
            local TitleLabel = Instance.new("TextLabel")
            local DescLabel = Instance.new("TextLabel")
            
            LabelFrame.Name = id
            LabelFrame.Parent = TabFrame
            LabelFrame.BackgroundTransparency = 1
            LabelFrame.Size = UDim2.new(1, 0, 0, description and 40 or 25)
            
            TitleLabel.Name = "Title"
            TitleLabel.Parent = LabelFrame
            TitleLabel.BackgroundTransparency = 1
            TitleLabel.Position = UDim2.new(0, 0, 0, 0)
            TitleLabel.Size = UDim2.new(1, 0, 0, 20)
            TitleLabel.Font = Enum.Font.GothamMedium
            TitleLabel.Text = title
            TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            TitleLabel.TextSize = 13
            TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            if description then
                DescLabel.Name = "Description"
                DescLabel.Parent = LabelFrame
                DescLabel.BackgroundTransparency = 1
                DescLabel.Position = UDim2.new(0, 0, 0, 20)
                DescLabel.Size = UDim2.new(1, 0, 0, 16)
                DescLabel.Font = Enum.Font.Gotham
                DescLabel.Text = description
                DescLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
                DescLabel.TextSize = 11
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
            SectionFrame.Size = UDim2.new(1, 0, 0, 30)
            
            SectionLabel.Name = "Title"
            SectionLabel.Parent = SectionFrame
            SectionLabel.BackgroundTransparency = 1
            SectionLabel.Position = UDim2.new(0, 0, 0, 5)
            SectionLabel.Size = UDim2.new(1, 0, 0, 20)
            SectionLabel.Font = Enum.Font.GothamBold
            SectionLabel.Text = title
            SectionLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
            SectionLabel.TextSize = 14
            SectionLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            Separator.Name = "Separator"
            Separator.Parent = SectionFrame
            Separator.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            Separator.BorderSizePixel = 0
            Separator.Position = UDim2.new(0, 0, 1, -1)
            Separator.Size = UDim2.new(1, 0, 0, 1)
            
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
            
            DropdownFrame.Name = id
            DropdownFrame.Parent = TabFrame
            DropdownFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            DropdownFrame.BorderSizePixel = 0
            DropdownFrame.Size = UDim2.new(1, 0, 0, description and 70 or 55)
            DropdownFrame.ClipsDescendants = true
            
            local FrameCorner = Instance.new("UICorner")
            FrameCorner.CornerRadius = UDim.new(0, 6)
            FrameCorner.Parent = DropdownFrame
            
            TitleLabel.Name = "Title"
            TitleLabel.Parent = DropdownFrame
            TitleLabel.BackgroundTransparency = 1
            TitleLabel.Position = UDim2.new(0, 12, 0, 8)
            TitleLabel.Size = UDim2.new(1, -24, 0, 16)
            TitleLabel.Font = Enum.Font.GothamMedium
            TitleLabel.Text = title
            TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            TitleLabel.TextSize = 13
            TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            if description then
                DescLabel.Name = "Description"
                DescLabel.Parent = DropdownFrame
                DescLabel.BackgroundTransparency = 1
                DescLabel.Position = UDim2.new(0, 12, 0, 24)
                DescLabel.Size = UDim2.new(1, -24, 0, 14)
                DescLabel.Font = Enum.Font.Gotham
                DescLabel.Text = description
                DescLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
                DescLabel.TextSize = 11
                DescLabel.TextXAlignment = Enum.TextXAlignment.Left
                
                DropButton.Position = UDim2.new(0, 12, 1, -26)
            else
                DropButton.Position = UDim2.new(0, 12, 1, -30)
            end
            
            DropButton.Name = "Button"
            DropButton.Parent = DropdownFrame
            DropButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            DropButton.BorderSizePixel = 0
            DropButton.Size = UDim2.new(1, -24, 0, 22)
            DropButton.Text = ""
            
            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 4)
            ButtonCorner.Parent = DropButton
            
            SelectedLabel.Name = "Selected"
            SelectedLabel.Parent = DropButton
            SelectedLabel.BackgroundTransparency = 1
            SelectedLabel.Position = UDim2.new(0, 8, 0, 0)
            SelectedLabel.Size = UDim2.new(1, -30, 1, 0)
            SelectedLabel.Font = Enum.Font.Gotham
            SelectedLabel.Text = selected
            SelectedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            SelectedLabel.TextSize = 12
            SelectedLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            Arrow.Name = "Arrow"
            Arrow.Parent = DropButton
            Arrow.BackgroundTransparency = 1
            Arrow.Position = UDim2.new(1, -22, 0, 0)
            Arrow.Size = UDim2.new(0, 22, 1, 0)
            Arrow.Font = Enum.Font.GothamMedium
            Arrow.Text = "▼"
            Arrow.TextColor3 = Color3.fromRGB(200, 200, 200)
            Arrow.TextSize = 10
            
            OptionsList.Name = "Options"
            OptionsList.Parent = DropdownFrame
            OptionsList.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            OptionsList.BorderSizePixel = 0
            OptionsList.Position = UDim2.new(0, 12, 1, -4)
            OptionsList.Size = UDim2.new(1, -24, 0, 0)
            OptionsList.Visible = false
            
            local OptionsCorner = Instance.new("UICorner")
            OptionsCorner.CornerRadius = UDim.new(0, 4)
            OptionsCorner.Parent = OptionsList
            
            OptionsLayout.Parent = OptionsList
            OptionsLayout.SortOrder = Enum.SortOrder.LayoutOrder
            
            for i, option in pairs(list) do
                local OptionButton = Instance.new("TextButton")
                
                OptionButton.Name = option
                OptionButton.Parent = OptionsList
                OptionButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                OptionButton.BorderSizePixel = 0
                OptionButton.Size = UDim2.new(1, 0, 0, 25)
                OptionButton.Font = Enum.Font.Gotham
                OptionButton.Text = option
                OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                OptionButton.TextSize = 11
                
                OptionButton.MouseEnter:Connect(function()
                    OptionButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
                end)
                
                OptionButton.MouseLeave:Connect(function()
                    OptionButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                end)
                
                OptionButton.MouseButton1Click:Connect(function()
                    selected = option
                    SelectedLabel.Text = selected
                    
                    isOpen = false
                    OptionsList.Visible = false
                    Arrow.Text = "▼"
                    
                    TweenService:Create(DropdownFrame, TweenInfo.new(0.3), {
                        Size = UDim2.new(1, 0, 0, description and 70 or 55)
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
                    Arrow.Text = "▲"
                    OptionsList.Size = UDim2.new(1, -24, 0, #list * 25)
                    
                    TweenService:Create(DropdownFrame, TweenInfo.new(0.3), {
                        Size = UDim2.new(1, 0, 0, (description and 70 or 55) + (#list * 25))
                    }):Play()
                else
                    OptionsList.Visible = false
                    Arrow.Text = "▼"
                    
                    TweenService:Create(DropdownFrame, TweenInfo.new(0.3), {
                        Size = UDim2.new(1, 0, 0, description and 70 or 55)
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
            
            KeybindFrame.Name = id
            KeybindFrame.Parent = TabFrame
            KeybindFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            KeybindFrame.BorderSizePixel = 0
            KeybindFrame.Size = UDim2.new(1, 0, 0, description and 60 or 40)
            
            local FrameCorner = Instance.new("UICorner")
            FrameCorner.CornerRadius = UDim.new(0, 6)
            FrameCorner.Parent = KeybindFrame
            
            TitleLabel.Name = "Title"
            TitleLabel.Parent = KeybindFrame
            TitleLabel.BackgroundTransparency = 1
            TitleLabel.Position = UDim2.new(0, 12, 0, 8)
            TitleLabel.Size = UDim2.new(1, -80, 0, 20)
            TitleLabel.Font = Enum.Font.GothamMedium
            TitleLabel.Text = title
            TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            TitleLabel.TextSize = 13
            TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            if description then
                DescLabel.Name = "Description"
                DescLabel.Parent = KeybindFrame
                DescLabel.BackgroundTransparency = 1
                DescLabel.Position = UDim2.new(0, 12, 0, 28)
                DescLabel.Size = UDim2.new(1, -80, 0, 16)
                DescLabel.Font = Enum.Font.Gotham
                DescLabel.Text = description
                DescLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
                DescLabel.TextSize = 11
                DescLabel.TextXAlignment = Enum.TextXAlignment.Left
            end
            
            KeyButton.Name = "Key"
            KeyButton.Parent = KeybindFrame
            KeyButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            KeyButton.BorderSizePixel = 0
            KeyButton.Position = UDim2.new(1, -65, 0.5, -12)
            KeyButton.Size = UDim2.new(0, 55, 0, 24)
            KeyButton.Font = Enum.Font.GothamMedium
            KeyButton.Text = currentKey.Name
            KeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            KeyButton.TextSize = 10
            
            local KeyCorner = Instance.new("UICorner")
            KeyCorner.CornerRadius = UDim.new(0, 4)
            KeyCorner.Parent = KeyButton
            
            KeyButton.MouseButton1Click:Connect(function()
                if not listening then
                    listening = true
                    KeyButton.Text = "..."
                    KeyButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
                end
            end)
            
            UserInputService.InputBegan:Connect(function(input, processed)
                if listening and not processed then
                    if input.UserInputType == Enum.UserInputType.Keyboard then
                        currentKey = input.KeyCode
                        KeyButton.Text = currentKey.Name
                        KeyButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
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
