local UILibrary = {}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local plr = Players.LocalPlayer

function UILibrary:CreateWindow(options)
   local title = options.Title or "UI Window"
   local subtitle = options.SubTitle or ""
   local size = options.Size or UDim2.fromOffset(650, 450)
   local tabWidth = options.TabWidth or 180
   local acrylic = options.Acrylic ~= false
   local theme = options.Theme or "Dark"
   local minimizeKey = options.MinimizeKey or Enum.KeyCode.B
   local icon = options.Icon or "rbxasset://textures/ui/GuiImagePlaceholder.png"
   
   local ScreenGui = Instance.new("ScreenGui")
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
   
   DropShadow.Name = "DropShadow"
   DropShadow.Parent = ScreenGui
   DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
   DropShadow.BackgroundTransparency = 1
   DropShadow.Position = UDim2.new(0.5, 0, 0.5, 3)
   DropShadow.Size = size + UDim2.fromOffset(30, 30)
   DropShadow.Image = "rbxasset://textures/ui/InGameMenu/dropshadow.png"
   DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
   DropShadow.ImageTransparency = 0.3
   DropShadow.ScaleType = Enum.ScaleType.Slice
   DropShadow.SliceCenter = Rect.new(30, 30, 70, 70)
   
   MainFrame.Name = "MainFrame"
   MainFrame.Parent = DropShadow
   MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
   MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
   MainFrame.BorderSizePixel = 0
   MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
   MainFrame.Size = size
   MainFrame.Active = true
   MainFrame.Draggable = true
   MainFrame.Visible = true
   
   if acrylic then
       local Blur = Instance.new("BlurEffect")
       Blur.Size = 15
       Blur.Parent = game.Lighting
       
       MainFrame.BackgroundTransparency = 0.05
   end
   
   UICorner.CornerRadius = UDim.new(0, 18)
   UICorner.Parent = MainFrame
   
   TitleBar.Name = "TitleBar"
   TitleBar.Parent = MainFrame
   TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
   TitleBar.BorderSizePixel = 0
   TitleBar.Size = UDim2.new(1, 0, 0, 55)
   
   local TitleCorner = Instance.new("UICorner")
   TitleCorner.CornerRadius = UDim.new(0, 18)
   TitleCorner.Parent = TitleBar
   
   local TitleBarGradient = Instance.new("UIGradient")
   TitleBarGradient.Color = ColorSequence.new{
       ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 45)),
       ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 32))
   }
   TitleBarGradient.Rotation = 90
   TitleBarGradient.Parent = TitleBar
   
   WindowIcon.Name = "WindowIcon"
   WindowIcon.Parent = TitleBar
   WindowIcon.BackgroundTransparency = 1
   WindowIcon.Position = UDim2.new(0, 18, 0.5, -15)
   WindowIcon.Size = UDim2.new(0, 30, 0, 30)
   WindowIcon.Image = icon
   WindowIcon.ImageColor3 = Color3.fromRGB(120, 160, 255)
   
   local IconCorner = Instance.new("UICorner")
   IconCorner.CornerRadius = UDim.new(0, 8)
   IconCorner.Parent = WindowIcon
   
   TitleLabel.Name = "TitleLabel"
   TitleLabel.Parent = TitleBar
   TitleLabel.BackgroundTransparency = 1
   TitleLabel.Position = UDim2.new(0, 58, 0, 8)
   TitleLabel.Size = UDim2.new(1, -140, 0, 22)
   TitleLabel.Font = Enum.Font.GothamBold
   TitleLabel.Text = title
   TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
   TitleLabel.TextSize = 18
   TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
   
   SubTitleLabel.Name = "SubTitleLabel"
   SubTitleLabel.Parent = TitleBar
   SubTitleLabel.BackgroundTransparency = 1
   SubTitleLabel.Position = UDim2.new(0, 58, 0, 32)
   SubTitleLabel.Size = UDim2.new(1, -140, 0, 15)
   SubTitleLabel.Font = Enum.Font.Gotham
   SubTitleLabel.Text = subtitle
   SubTitleLabel.TextColor3 = Color3.fromRGB(160, 160, 170)
   SubTitleLabel.TextSize = 13
   SubTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
   
   MinimizeButton.Name = "MinimizeButton"
   MinimizeButton.Parent = TitleBar
   MinimizeButton.BackgroundTransparency = 1
   MinimizeButton.Position = UDim2.new(1, -80, 0.5, -15)
   MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
   MinimizeButton.Font = Enum.Font.GothamBold
   MinimizeButton.Text = "−"
   MinimizeButton.TextColor3 = Color3.fromRGB(255, 200, 100)
   MinimizeButton.TextSize = 20
   
   local MinCorner = Instance.new("UICorner")
   MinCorner.CornerRadius = UDim.new(0, 8)
   MinCorner.Parent = MinimizeButton
   
   CloseButton.Name = "CloseButton"
   CloseButton.Parent = TitleBar
   CloseButton.BackgroundTransparency = 1
   CloseButton.Position = UDim2.new(1, -40, 0.5, -15)
   CloseButton.Size = UDim2.new(0, 30, 0, 30)
   CloseButton.Font = Enum.Font.GothamBold
   CloseButton.Text = "×"
   CloseButton.TextColor3 = Color3.fromRGB(255, 100, 100)
   CloseButton.TextSize = 20
   
   local CloseCorner = Instance.new("UICorner")
   CloseCorner.CornerRadius = UDim.new(0, 8)
   CloseCorner.Parent = CloseButton
   
   TabContainer.Name = "TabContainer"
   TabContainer.Parent = MainFrame
   TabContainer.BackgroundTransparency = 1
   TabContainer.Position = UDim2.new(0, 0, 0, 55)
   TabContainer.Size = UDim2.new(1, 0, 1, -55)
   
   TabButtons.Name = "TabButtons"
   TabButtons.Parent = TabContainer
   TabButtons.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
   TabButtons.BorderSizePixel = 0
   TabButtons.Position = UDim2.new(0, 15, 0, 15)
   TabButtons.Size = UDim2.new(0, tabWidth, 1, -30)
   
   local TabGradient = Instance.new("UIGradient")
   TabGradient.Color = ColorSequence.new{
       ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 38)),
       ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 28))
   }
   TabGradient.Rotation = 90
   TabGradient.Parent = TabButtons
   
   local TabButtonsCorner = Instance.new("UICorner")
   TabButtonsCorner.CornerRadius = UDim.new(0, 12)
   TabButtonsCorner.Parent = TabButtons
   
   TabContent.Name = "TabContent"
   TabContent.Parent = TabContainer
   TabContent.BackgroundTransparency = 1
   TabContent.Position = UDim2.new(0, tabWidth + 30, 0, 15)
   TabContent.Size = UDim2.new(1, -tabWidth - 45, 1, -30)
   
   local TabButtonsLayout = Instance.new("UIListLayout")
   TabButtonsLayout.Parent = TabButtons
   TabButtonsLayout.Padding = UDim.new(0, 8)
   TabButtonsLayout.SortOrder = Enum.SortOrder.LayoutOrder
   
   local TabPadding = Instance.new("UIPadding")
   TabPadding.PaddingTop = UDim.new(0, 15)
   TabPadding.PaddingBottom = UDim.new(0, 15)
   TabPadding.PaddingLeft = UDim.new(0, 15)
   TabPadding.PaddingRight = UDim.new(0, 15)
   TabPadding.Parent = TabButtons
   
   MinimizedFrame.Name = "MinimizedFrame"
   MinimizedFrame.Parent = ScreenGui
   MinimizedFrame.BackgroundColor3 = Color3.fromRGB(120, 160, 255)
   MinimizedFrame.BorderSizePixel = 0
   MinimizedFrame.Position = UDim2.new(0, 30, 0, 120)
   MinimizedFrame.Size = UDim2.new(0, 70, 0, 70)
   MinimizedFrame.Visible = false
   MinimizedFrame.Image = icon
   MinimizedFrame.ImageColor3 = Color3.fromRGB(255, 255, 255)
   MinimizedFrame.Draggable = true
   
   local MinimizedGradient = Instance.new("UIGradient")
   MinimizedGradient.Color = ColorSequence.new{
       ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 180, 255)),
       ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 140, 235))
   }
   MinimizedGradient.Rotation = 45
   MinimizedGradient.Parent = MinimizedFrame
   
   local MinimizedCorner = Instance.new("UICorner")
   MinimizedCorner.CornerRadius = UDim.new(0, 35)
   MinimizedCorner.Parent = MinimizedFrame
   
   local MinimizedStroke = Instance.new("UIStroke")
   MinimizedStroke.Color = Color3.fromRGB(255, 255, 255)
   MinimizedStroke.Thickness = 3
   MinimizedStroke.Transparency = 0.7
   MinimizedStroke.Parent = MinimizedFrame
   
   local MinimizedLabel = Instance.new("TextLabel")
   MinimizedLabel.Parent = MinimizedFrame
   MinimizedLabel.BackgroundTransparency = 1
   MinimizedLabel.Size = UDim2.new(1, 0, 0.3, 0)
   MinimizedLabel.Position = UDim2.new(0, 0, 0.7, 0)
   MinimizedLabel.Font = Enum.Font.GothamBold
   MinimizedLabel.Text = string.sub(title, 1, 1)
   MinimizedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
   MinimizedLabel.TextSize = 16
   
   local isMinimized = false
   local isDragging = false
   
   local function animateMinimized()
       local connection
       connection = RunService.Heartbeat:Connect(function()
           MinimizedFrame.Rotation = MinimizedFrame.Rotation + 1
       end)
       
       task.wait(2)
       if connection then
           connection:Disconnect()
       end
   end
   
   local function minimizeWindow()
       isMinimized = not isMinimized
       
       if isMinimized then
           TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
               Position = UDim2.new(0.5, 0, -0.5, 0),
               Size = UDim2.new(0, 0, 0, 0)
           }):Play()
           
           TweenService:Create(DropShadow, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
               ImageTransparency = 1
           }):Play()
           
           task.wait(0.5)
           MainFrame.Visible = false
           DropShadow.Visible = false
           MinimizedFrame.Visible = true
           
           TweenService:Create(MinimizedFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
               Size = UDim2.new(0, 70, 0, 70)
           }):Play()
           
           task.spawn(animateMinimized)
       else
           DropShadow.Visible = true
           MinimizedFrame.Visible = false
           MainFrame.Visible = true
           MainFrame.Size = UDim2.new(0, 0, 0, 0)
           MainFrame.Position = UDim2.new(0.5, 0, -0.5, 0)
           
           TweenService:Create(DropShadow, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
               ImageTransparency = 0.3
           }):Play()
           
           TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
               Position = UDim2.new(0.5, 0, 0.5, 0),
               Size = size
           }):Play()
       end
   end
   
   CloseButton.MouseButton1Click:Connect(function()
       TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
           Position = UDim2.new(0.5, 0, -0.5, 0),
           Size = UDim2.new(0, 0, 0, 0)
       }):Play()
       
       TweenService:Create(DropShadow, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
           ImageTransparency = 1
       }):Play()
       
       task.wait(0.4)
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
           BackgroundTransparency = 0.7,
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
           BackgroundTransparency = 0.7,
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
       local TabGlow = Instance.new("Frame")
       
       TabButton.Name = name
       TabButton.Parent = self.TabButtons
       TabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
       TabButton.BorderSizePixel = 0
       TabButton.Size = UDim2.new(1, 0, 0, 50)
       TabButton.Font = Enum.Font.GothamMedium
       TabButton.Text = ""
       TabButton.TextColor3 = Color3.fromRGB(200, 200, 210)
       TabButton.TextSize = 15
       TabButton.TextXAlignment = Enum.TextXAlignment.Left
       
       local ButtonCorner = Instance.new("UICorner")
       ButtonCorner.CornerRadius = UDim.new(0, 12)
       ButtonCorner.Parent = TabButton
       
       local ButtonGradient = Instance.new("UIGradient")
       ButtonGradient.Color = ColorSequence.new{
           ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 50)),
           ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 40))
       }
       ButtonGradient.Rotation = 90
       ButtonGradient.Parent = TabButton
       
       TabStroke.Color = Color3.fromRGB(60, 60, 70)
       TabStroke.Thickness = 1
       TabStroke.Transparency = 0.5
       TabStroke.Parent = TabButton
       
       TabIcon.Name = "Icon"
       TabIcon.Parent = TabButton
       TabIcon.BackgroundTransparency = 1
       TabIcon.Position = UDim2.new(0, 15, 0.5, -10)
       TabIcon.Size = UDim2.new(0, 20, 0, 20)
       TabIcon.Font = Enum.Font.GothamBold
       TabIcon.Text = icon
       TabIcon.TextColor3 = Color3.fromRGB(120, 160, 255)
       TabIcon.TextSize = 16
       
       local TabLabel = Instance.new("TextLabel")
       TabLabel.Name = "Label"
       TabLabel.Parent = TabButton
       TabLabel.BackgroundTransparency = 1
       TabLabel.Position = UDim2.new(0, 45, 0, 0)
       TabLabel.Size = UDim2.new(1, -50, 1, 0)
       TabLabel.Font = Enum.Font.GothamMedium
       TabLabel.Text = title
       TabLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
       TabLabel.TextSize = 15
       TabLabel.TextXAlignment = Enum.TextXAlignment.Left
       
       TabFrame.Name = name
       TabFrame.Parent = self.TabContent
       TabFrame.Active = true
       TabFrame.BackgroundTransparency = 1
       TabFrame.BorderSizePixel = 0
       TabFrame.Size = UDim2.new(1, 0, 1, 0)
       TabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
       TabFrame.ScrollBarThickness = 8
       TabFrame.ScrollBarImageColor3 = Color3.fromRGB(120, 160, 255)
       TabFrame.ScrollBarImageTransparency = 0.3
       TabFrame.Visible = false
       
       TabLayout.Parent = TabFrame
       TabLayout.Padding = UDim.new(0, 12)
       TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
       
       local TabFramePadding = Instance.new("UIPadding")
       TabFramePadding.PaddingTop = UDim.new(0, 10)
       TabFramePadding.PaddingBottom = UDim.new(0, 10)
       TabFramePadding.Parent = TabFrame
       
       TabLayout.Changed:Connect(function()
           TabFrame.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y + 30)
       end)
       
       TabButton.MouseEnter:Connect(function()
           if self.CurrentTab and self.CurrentTab.Button ~= TabButton then
               TweenService:Create(TabButton, TweenInfo.new(0.3), {
                   BackgroundColor3 = Color3.fromRGB(45, 45, 55)
               }):Play()
               TweenService:Create(TabStroke, TweenInfo.new(0.3), {
                   Color = Color3.fromRGB(120, 160, 255),
                   Transparency = 0.3
               }):Play()
           end
       end)
       
       TabButton.MouseLeave:Connect(function()
           if self.CurrentTab and self.CurrentTab.Button ~= TabButton then
               TweenService:Create(TabButton, TweenInfo.new(0.3), {
                   BackgroundColor3 = Color3.fromRGB(35, 35, 45)
               }):Play()
               TweenService:Create(TabStroke, TweenInfo.new(0.3), {
                   Color = Color3.fromRGB(60, 60, 70),
                   Transparency = 0.5
               }):Play()
           end
       end)
       
       TabButton.MouseButton1Click:Connect(function()
           if self.CurrentTab then
               self.CurrentTab.Frame.Visible = false
               TweenService:Create(self.CurrentTab.Button, TweenInfo.new(0.4), {
                   BackgroundColor3 = Color3.fromRGB(35, 35, 45)
               }):Play()
               TweenService:Create(self.CurrentTab.Label, TweenInfo.new(0.4), {
                   TextColor3 = Color3.fromRGB(200, 200, 210)
               }):Play()
               TweenService:Create(self.CurrentTab.Icon, TweenInfo.new(0.4), {
                   TextColor3 = Color3.fromRGB(120, 160, 255)
               }):Play()
               TweenService:Create(self.CurrentTab.Stroke, TweenInfo.new(0.4), {
                   Color = Color3.fromRGB(60, 60, 70),
                   Transparency = 0.5
               }):Play()
           end
           
           TabFrame.Visible = true
           TweenService:Create(TabButton, TweenInfo.new(0.4), {
               BackgroundColor3 = Color3.fromRGB(120, 160, 255)
           }):Play()
           TweenService:Create(TabLabel, TweenInfo.new(0.4), {
               TextColor3 = Color3.fromRGB(255, 255, 255)
           }):Play()
           TweenService:Create(TabIcon, TweenInfo.new(0.4), {
               TextColor3 = Color3.fromRGB(255, 255, 255)
           }):Play()
           TweenService:Create(TabStroke, TweenInfo.new(0.4), {
               Color = Color3.fromRGB(255, 255, 255),
               Transparency = 0.2
           }):Play()
           
           self.CurrentTab = {Frame = TabFrame, Button = TabButton, Label = TabLabel, Icon = TabIcon, Stroke = TabStroke}
       end)
       
       if not self.CurrentTab then
           TabFrame.Visible = true
           TabButton.BackgroundColor3 = Color3.fromRGB(120, 160, 255)
           TabLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
           TabIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
           TabStroke.Color = Color3.fromRGB(255, 255, 255)
           TabStroke.Transparency = 0.2
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
           ButtonFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
           ButtonFrame.BorderSizePixel = 0
           ButtonFrame.Size = UDim2.new(1, 0, 0, description and 75 or 55)
           
           local FrameCorner = Instance.new("UICorner")
           FrameCorner.CornerRadius = UDim.new(0, 12)
           FrameCorner.Parent = ButtonFrame
           
           local FrameGradient = Instance.new("UIGradient")
           FrameGradient.Color = ColorSequence.new{
               ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 50)),
               ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 40))
           }
           FrameGradient.Rotation = 90
           FrameGradient.Parent = ButtonFrame
           
           ButtonStroke.Color = Color3.fromRGB(60, 60, 70)
           ButtonStroke.Thickness = 1
           ButtonStroke.Transparency = 0.5
           ButtonStroke.Parent = ButtonFrame
           
           Button.Name = "Button"
           Button.Parent = ButtonFrame
           Button.BackgroundTransparency = 1
           Button.Size = UDim2.new(1, 0, 1, 0)
           Button.Text = ""
           
           ButtonIcon.Name = "Icon"
           ButtonIcon.Parent = ButtonFrame
           ButtonIcon.BackgroundTransparency = 1
           ButtonIcon.Position = UDim2.new(0, 18, 0, 15)
           ButtonIcon.Size = UDim2.new(0, 25, 0, 25)
           ButtonIcon.Font = Enum.Font.GothamBold
           ButtonIcon.Text = "▶"
           ButtonIcon.TextColor3 = Color3.fromRGB(120, 160, 255)
           ButtonIcon.TextSize = 16
           
           ButtonLabel.Name = "Title"
           ButtonLabel.Parent = ButtonFrame
           ButtonLabel.BackgroundTransparency = 1
           ButtonLabel.Position = UDim2.new(0, 50, 0, 12)
           ButtonLabel.Size = UDim2.new(1, -65, 0, 25)
           ButtonLabel.Font = Enum.Font.GothamSemiBold
           ButtonLabel.Text = title
           ButtonLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
           ButtonLabel.TextSize = 16
           ButtonLabel.TextXAlignment = Enum.TextXAlignment.Left
           
           if description then
               DescLabel.Name = "Description"
               DescLabel.Parent = ButtonFrame
               DescLabel.BackgroundTransparency = 1
               DescLabel.Position = UDim2.new(0, 50, 0, 40)
               DescLabel.Size = UDim2.new(1, -65, 0, 25)
               DescLabel.Font = Enum.Font.Gotham
               DescLabel.Text = description
               DescLabel.TextColor3 = Color3.fromRGB(180, 180, 190)
               DescLabel.TextSize = 13
               DescLabel.TextXAlignment = Enum.TextXAlignment.Left
           end
           
           Button.MouseEnter:Connect(function()
               TweenService:Create(ButtonFrame, TweenInfo.new(0.3), {
                   BackgroundColor3 = Color3.fromRGB(50, 50, 60)
               }):Play()
               TweenService:Create(ButtonStroke, TweenInfo.new(0.3), {
                   Color = Color3.fromRGB(35, 35, 45), 
                   Transparency = 0.3
               }):Play()
           end)
           
           Button.MouseLeave:Connect(function()
               TweenService:Create(ButtonFrame, TweenInfo.new(0.3), {
                   BackgroundColor3 = Color3.fromRGB(35, 35, 45)
               }):Play()
               TweenService:Create(ButtonStroke, TweenInfo.new(0.3), {
                   Color = Color3.fromRGB(60, 60, 70),
                   Transparency = 0.5
               }):Play()
           end)
           
           Button.MouseButton1Click:Connect(function()
               TweenService:Create(ButtonFrame, TweenInfo.new(0.1), {
                   BackgroundColor3 = Color3.fromRGB(120, 160, 255)
               }):Play()
               TweenService:Create(ButtonIcon, TweenInfo.new(0.1), {
                   TextColor3 = Color3.fromRGB(255, 255, 255)
               }):Play()
               
               task.wait(0.15)
               
               TweenService:Create(ButtonFrame, TweenInfo.new(0.2), {
                   BackgroundColor3 = Color3.fromRGB(35, 35, 45)
               }):Play()
               TweenService:Create(ButtonIcon, TweenInfo.new(0.2), {
                   TextColor3 = Color3.fromRGB(120, 160, 255)
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
           ToggleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
           ToggleFrame.BorderSizePixel = 0
           ToggleFrame.Size = UDim2.new(1, 0, 0, description and 75 or 55)
           
           local FrameCorner = Instance.new("UICorner")
           FrameCorner.CornerRadius = UDim.new(0, 12)
           FrameCorner.Parent = ToggleFrame
           
           local FrameGradient = Instance.new("UIGradient")
           FrameGradient.Color = ColorSequence.new{
               ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 50)),
               ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 40))
           }
           FrameGradient.Rotation = 90
           FrameGradient.Parent = ToggleFrame
           
           ToggleStroke.Color = Color3.fromRGB(60, 60, 70)
           ToggleStroke.Thickness = 1
           ToggleStroke.Transparency = 0.5
           ToggleStroke.Parent = ToggleFrame
           
           ToggleButton.Name = "Button"
           ToggleButton.Parent = ToggleFrame
           ToggleButton.BackgroundTransparency = 1
           ToggleButton.Size = UDim2.new(1, -70, 1, 0)
           ToggleButton.Text = ""
           
           ToggleIcon.Name = "Icon"
           ToggleIcon.Parent = ToggleFrame
           ToggleIcon.BackgroundTransparency = 1
           ToggleIcon.Position = UDim2.new(0, 18, 0, 15)
           ToggleIcon.Size = UDim2.new(0, 25, 0, 25)
           ToggleIcon.Font = Enum.Font.GothamBold
           ToggleIcon.Text = "◐"
           ToggleIcon.TextColor3 = toggled and Color3.fromRGB(100, 255, 150) or Color3.fromRGB(120, 160, 255)
           ToggleIcon.TextSize = 16
           
           TitleLabel.Name = "Title"
           TitleLabel.Parent = ToggleFrame
           TitleLabel.BackgroundTransparency = 1
           TitleLabel.Position = UDim2.new(0, 50, 0, 12)
           TitleLabel.Size = UDim2.new(1, -125, 0, 25)
           TitleLabel.Font = Enum.Font.GothamSemiBold
           TitleLabel.Text = title
           TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
           TitleLabel.TextSize = 16
           TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
           
           if description then
               DescLabel.Name = "Description"
               DescLabel.Parent = ToggleFrame
               DescLabel.BackgroundTransparency = 1
               DescLabel.Position = UDim2.new(0, 50, 0, 40)
               DescLabel.Size = UDim2.new(1, -125, 0, 25)
               DescLabel.Font = Enum.Font.Gotham
               DescLabel.Text = description
               DescLabel.TextColor3 = Color3.fromRGB(180, 180, 190)
               DescLabel.TextSize = 13
               DescLabel.TextXAlignment = Enum.TextXAlignment.Left
           end
           
           Switch.Name = "Switch"
           Switch.Parent = ToggleFrame
           Switch.BackgroundColor3 = toggled and Color3.fromRGB(100, 255, 150) or Color3.fromRGB(60, 60, 70)
           Switch.BorderSizePixel = 0
           Switch.Position = UDim2.new(1, -60, 0.5, -15)
           Switch.Size = UDim2.new(0, 50, 0, 30)
           
           local SwitchCorner = Instance.new("UICorner")
           SwitchCorner.CornerRadius = UDim.new(0, 15)
           SwitchCorner.Parent = Switch
           
           local SwitchGlow = Instance.new("UIStroke")
           SwitchGlow.Color = toggled and Color3.fromRGB(100, 255, 150) or Color3.fromRGB(80, 80, 90)
           SwitchGlow.Thickness = 2
           SwitchGlow.Transparency = 0.6
           SwitchGlow.Parent = Switch
           
           SwitchButton.Name = "Button"
           SwitchButton.Parent = Switch
           SwitchButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
           SwitchButton.BorderSizePixel = 0
           SwitchButton.Position = toggled and UDim2.new(1, -26, 0.5, -13) or UDim2.new(0, 4, 0.5, -13)
           SwitchButton.Size = UDim2.new(0, 26, 0, 26)
           
           local ButtonCorner = Instance.new("UICorner")
           ButtonCorner.CornerRadius = UDim.new(0, 13)
           ButtonCorner.Parent = SwitchButton
           
           local ButtonShadow = Instance.new("UIStroke")
           ButtonShadow.Color = Color3.fromRGB(0, 0, 0)
           ButtonShadow.Thickness = 1
           ButtonShadow.Transparency = 0.8
           ButtonShadow.Parent = SwitchButton
           
           local function updateToggle()
               TweenService:Create(Switch, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
                   BackgroundColor3 = toggled and Color3.fromRGB(100, 255, 150) or Color3.fromRGB(60, 60, 70)
               }):Play()
               
               TweenService:Create(SwitchGlow, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
                   Color = toggled and Color3.fromRGB(100, 255, 150) or Color3.fromRGB(80, 80, 90)
               }):Play()
               
               TweenService:Create(SwitchButton, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
                   Position = toggled and UDim2.new(1, -26, 0.5, -13) or UDim2.new(0, 4, 0.5, -13)
               }):Play()
               
               TweenService:Create(ToggleIcon, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
                   TextColor3 = toggled and Color3.fromRGB(100, 255, 150) or Color3.fromRGB(120, 160, 255)
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
                   BackgroundColor3 = Color3.fromRGB(45, 45, 55)
               }):Play()
               TweenService:Create(ToggleStroke, TweenInfo.new(0.3), {
                   Color = Color3.fromRGB(120, 160, 255),
                   Transparency = 0.3
               }):Play()
           end)
           
           ToggleButton.MouseLeave:Connect(function()
               TweenService:Create(ToggleFrame, TweenInfo.new(0.3), {
                   BackgroundColor3 = Color3.fromRGB(35, 35, 45)
               }):Play()
               TweenService:Create(ToggleStroke, TweenInfo.new(0.3), {
                   Color = Color3.fromRGB(60, 60, 70),
                   Transparency = 0.5
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
           SliderFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
           SliderFrame.BorderSizePixel = 0
           SliderFrame.Size = UDim2.new(1, 0, 0, description and 85 or 65)
           
           local FrameCorner = Instance.new("UICorner")
           FrameCorner.CornerRadius = UDim.new(0, 12)
           FrameCorner.Parent = SliderFrame
           
           local FrameGradient = Instance.new("UIGradient")
           FrameGradient.Color = ColorSequence.new{
               ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 50)),
               ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 40))
           }
           FrameGradient.Rotation = 90
           FrameGradient.Parent = SliderFrame
           
           SliderStroke.Color = Color3.fromRGB(60, 60, 70)
           SliderStroke.Thickness = 1
           SliderStroke.Transparency = 0.5
           SliderStroke.Parent = SliderFrame
           
           SliderIcon.Name = "Icon"
           SliderIcon.Parent = SliderFrame
           SliderIcon.BackgroundTransparency = 1
           SliderIcon.Position = UDim2.new(0, 18, 0, 15)
           SliderIcon.Size = UDim2.new(0, 25, 0, 25)
           SliderIcon.Font = Enum.Font.GothamBold
           SliderIcon.Text = "⚬"
           SliderIcon.TextColor3 = Color3.fromRGB(120, 160, 255)
           SliderIcon.TextSize = 16
           
           TitleLabel.Name = "Title"
           TitleLabel.Parent = SliderFrame
           TitleLabel.BackgroundTransparency = 1
           TitleLabel.Position = UDim2.new(0, 50, 0, 12)
           TitleLabel.Size = UDim2.new(1, -140, 0, 22)
           TitleLabel.Font = Enum.Font.GothamSemiBold
           TitleLabel.Text = title
           TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
           TitleLabel.TextSize = 16
           TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
           
           ValueLabel.Name = "Value"
           ValueLabel.Parent = SliderFrame
           ValueLabel.BackgroundTransparency = 1
           ValueLabel.Position = UDim2.new(1, -85, 0, 12)
           ValueLabel.Size = UDim2.new(0, 70, 0, 22)
           ValueLabel.Font = Enum.Font.GothamBold
           ValueLabel.Text = tostring(value)
           ValueLabel.TextColor3 = Color3.fromRGB(120, 160, 255)
           ValueLabel.TextSize = 16
           ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
           
           if description then
               DescLabel.Name = "Description"
               DescLabel.Parent = SliderFrame
               DescLabel.BackgroundTransparency = 1
               DescLabel.Position = UDim2.new(0, 50, 0, 35)
               DescLabel.Size = UDim2.new(1, -70, 0, 20)
               DescLabel.Font = Enum.Font.Gotham
               DescLabel.Text = description
               DescLabel.TextColor3 = Color3.fromRGB(180, 180, 190)
               DescLabel.TextSize = 13
               DescLabel.TextXAlignment = Enum.TextXAlignment.Left
               
               SliderTrack.Position = UDim2.new(0, 18, 1, -20)
           else
               SliderTrack.Position = UDim2.new(0, 18, 1, -25)
           end
           
           SliderTrack.Name = "Track"
           SliderTrack.Parent = SliderFrame
           SliderTrack.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
           SliderTrack.BorderSizePixel = 0
           SliderTrack.Size = UDim2.new(1, -36, 0, 8)
           
           local TrackCorner = Instance.new("UICorner")
           TrackCorner.CornerRadius = UDim.new(0, 4)
           TrackCorner.Parent = SliderTrack
           
           local TrackStroke = Instance.new("UIStroke")
           TrackStroke.Color = Color3.fromRGB(80, 80, 90)
           TrackStroke.Thickness = 1
           TrackStroke.Transparency = 0.6
           TrackStroke.Parent = SliderTrack
           
           SliderFill.Name = "Fill"
           SliderFill.Parent = SliderTrack
           SliderFill.BackgroundColor3 = Color3.fromRGB(120, 160, 255)
           SliderFill.BorderSizePixel = 0
           SliderFill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
           
           local FillCorner = Instance.new("UICorner")
           FillCorner.CornerRadius = UDim.new(0, 4)
           FillCorner.Parent = SliderFill
           
           local FillGradient = Instance.new("UIGradient")
           FillGradient.Color = ColorSequence.new{
               ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 180, 255)),
               ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 140, 235))
           }
           FillGradient.Parent = SliderFill
           
           SliderHandle.Name = "Handle"
           SliderHandle.Parent = SliderTrack
           SliderHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
           SliderHandle.BorderSizePixel = 0
           SliderHandle.Position = UDim2.new((value - min) / (max - min), -10, 0.5, -10)
           SliderHandle.Size = UDim2.new(0, 20, 0, 20)
           SliderHandle.Text = ""
           
           local HandleCorner = Instance.new("UICorner")
           HandleCorner.CornerRadius = UDim.new(0, 10)
           HandleCorner.Parent = SliderHandle
           
           local HandleStroke = Instance.new("UIStroke")
           HandleStroke.Color = Color3.fromRGB(120, 160, 255)
           HandleStroke.Thickness = 2
           HandleStroke.Transparency = 0.3
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
                   Position = UDim2.new(percent, -10, 0.5, -10)
               }):Play()
               
               callback(value)
           end
           
           SliderHandle.InputBegan:Connect(function(input)
               if input.UserInputType == Enum.UserInputType.MouseButton1 then
                   dragging = true
                   TweenService:Create(SliderHandle, TweenInfo.new(0.2), {
                       Size = UDim2.new(0, 24, 0, 24),
                       BackgroundColor3 = Color3.fromRGB(120, 160, 255)
                   }):Play()
                   TweenService:Create(HandleStroke, TweenInfo.new(0.2), {
                       Color = Color3.fromRGB(255, 255, 255),
                       Transparency = 0.1
                   }):Play()
               end
           end)
           
           SliderHandle.InputEnded:Connect(function(input)
               if input.UserInputType == Enum.UserInputType.MouseButton1 then
                   dragging = false
                   TweenService:Create(SliderHandle, TweenInfo.new(0.2), {
                       Size = UDim2.new(0, 20, 0, 20),
                       BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                   }):Play()
                   TweenService:Create(HandleStroke, TweenInfo.new(0.2), {
                       Color = Color3.fromRGB(120, 160, 255),
                       Transparency = 0.3
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
           InputFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
           InputFrame.BorderSizePixel = 0
           InputFrame.Size = UDim2.new(1, 0, 0, description and 85 or 70)
           
           local FrameCorner = Instance.new("UICorner")
           FrameCorner.CornerRadius = UDim.new(0, 12)
           FrameCorner.Parent = InputFrame
           
           local FrameGradient = Instance.new("UIGradient")
           FrameGradient.Color = ColorSequence.new{
               ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 50)),
               ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 40))
           }
           FrameGradient.Rotation = 90
           FrameGradient.Parent = InputFrame
           
           InputStroke.Color = Color3.fromRGB(60, 60, 70)
           InputStroke.Thickness = 1
           InputStroke.Transparency = 0.5
           InputStroke.Parent = InputFrame
           
           InputIcon.Name = "Icon"
           InputIcon.Parent = InputFrame
           InputIcon.BackgroundTransparency = 1
           InputIcon.Position = UDim2.new(0, 18, 0, 15)
           InputIcon.Size = UDim2.new(0, 25, 0, 25)
           InputIcon.Font = Enum.Font.GothamBold
           InputIcon.Text = "✎"
           InputIcon.TextColor3 = Color3.fromRGB(120, 160, 255)
           InputIcon.TextSize = 16
           
           TitleLabel.Name = "Title"
           TitleLabel.Parent = InputFrame
           TitleLabel.BackgroundTransparency = 1
           TitleLabel.Position = UDim2.new(0, 50, 0, 12)
           TitleLabel.Size = UDim2.new(1, -65, 0, 22)
           TitleLabel.Font = Enum.Font.GothamSemiBold
           TitleLabel.Text = title
           TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
           TitleLabel.TextSize = 16
           TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
           
           if description then
               DescLabel.Name = "Description"
               DescLabel.Parent = InputFrame
               DescLabel.BackgroundTransparency = 1
               DescLabel.Position = UDim2.new(0, 50, 0, 35)
               DescLabel.Size = UDim2.new(1, -65, 0, 20)
               DescLabel.Font = Enum.Font.Gotham
               DescLabel.Text = description
               DescLabel.TextColor3 = Color3.fromRGB(180, 180, 190)
               DescLabel.TextSize = 13
               DescLabel.TextXAlignment = Enum.TextXAlignment.Left
               
               TextBox.Position = UDim2.new(0, 18, 1, -35)
           else
               TextBox.Position = UDim2.new(0, 18, 1, -40)
           end
           
           TextBox.Name = "Input"
           TextBox.Parent = InputFrame
           TextBox.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
           TextBox.BorderSizePixel = 0
           TextBox.Size = UDim2.new(1, -36, 0, 32)
           TextBox.Font = Enum.Font.Gotham
           TextBox.PlaceholderText = placeholder
           TextBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 130)
           TextBox.Text = ""
           TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
           TextBox.TextSize = 14
           TextBox.TextXAlignment = Enum.TextXAlignment.Left
           
           local InputCorner = Instance.new("UICorner")
           InputCorner.CornerRadius = UDim.new(0, 8)
           InputCorner.Parent = TextBox
           
           local TextBoxStroke = Instance.new("UIStroke")
           TextBoxStroke.Color = Color3.fromRGB(80, 80, 90)
           TextBoxStroke.Thickness = 1
           TextBoxStroke.Transparency = 0.6
           TextBoxStroke.Parent = TextBox
           
           local TextBoxPadding = Instance.new("UIPadding")
           TextBoxPadding.PaddingLeft = UDim.new(0, 12)
           TextBoxPadding.PaddingRight = UDim.new(0, 12)
           TextBoxPadding.Parent = TextBox
           
           TextBox.Focused:Connect(function()
               TweenService:Create(TextBox, TweenInfo.new(0.3), {
                   BackgroundColor3 = Color3.fromRGB(120, 160, 255),
                   TextColor3 = Color3.fromRGB(255, 255, 255)
               }):Play()
               TweenService:Create(TextBoxStroke, TweenInfo.new(0.3), {
                   Color = Color3.fromRGB(255, 255, 255),
                   Transparency = 0.2
               }):Play()
           end)
           
           TextBox.FocusLost:Connect(function()
               TweenService:Create(TextBox, TweenInfo.new(0.3), {
                   BackgroundColor3 = Color3.fromRGB(45, 45, 55),
                   TextColor3 = Color3.fromRGB(255, 255, 255)
               }):Play()
               TweenService:Create(TextBoxStroke, TweenInfo.new(0.3), {
                   Color = Color3.fromRGB(80, 80, 90),
                   Transparency = 0.6
               }):Play()
               
               callback(TextBox.Text)
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
           LabelFrame.Size = UDim2.new(1, 0, 0, description and 55 or 35)
           
           LabelIcon.Name = "Icon"
           LabelIcon.Parent = LabelFrame
           LabelIcon.BackgroundTransparency = 1
           LabelIcon.Position = UDim2.new(0, 5, 0, 8)
           LabelIcon.Size = UDim2.new(0, 25, 0, 20)
           LabelIcon.Font = Enum.Font.GothamBold
           LabelIcon.Text = "ℹ"
           LabelIcon.TextColor3 = Color3.fromRGB(120, 160, 255)
           LabelIcon.TextSize = 16
           
           TitleLabel.Name = "Title"
           TitleLabel.Parent = LabelFrame
           TitleLabel.BackgroundTransparency = 1
           TitleLabel.Position = UDim2.new(0, 35, 0, 8)
           TitleLabel.Size = UDim2.new(1, -40, 0, 22)
           TitleLabel.Font = Enum.Font.GothamSemiBold
           TitleLabel.Text = title
           TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
           TitleLabel.TextSize = 16
           TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
           
           if description then
               DescLabel.Name = "Description"
               DescLabel.Parent = LabelFrame
               DescLabel.BackgroundTransparency = 1
               DescLabel.Position = UDim2.new(0, 35, 0, 30)
               DescLabel.Size = UDim2.new(1, -40, 0, 20)
               DescLabel.Font = Enum.Font.Gotham
               DescLabel.Text = description
               DescLabel.TextColor3 = Color3.fromRGB(180, 180, 190)
               DescLabel.TextSize = 13
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
           SectionFrame.Size = UDim2.new(1, 0, 0, 45)
           
           SectionIcon.Name = "Icon"
           SectionIcon.Parent = SectionFrame
           SectionIcon.BackgroundTransparency = 1
           SectionIcon.Position = UDim2.new(0, 0, 0, 10)
           SectionIcon.Size = UDim2.new(0, 25, 0, 25)
           SectionIcon.Font = Enum.Font.GothamBold
           SectionIcon.Text = "◆"
           SectionIcon.TextColor3 = Color3.fromRGB(120, 160, 255)
           SectionIcon.TextSize = 16
           
           SectionLabel.Name = "Title"
           SectionLabel.Parent = SectionFrame
           SectionLabel.BackgroundTransparency = 1
           SectionLabel.Position = UDim2.new(0, 30, 0, 10)
           SectionLabel.Size = UDim2.new(1, -35, 0, 25)
           SectionLabel.Font = Enum.Font.GothamBold
           SectionLabel.Text = title
           SectionLabel.TextColor3 = Color3.fromRGB(120, 160, 255)
           SectionLabel.TextSize = 18
           SectionLabel.TextXAlignment = Enum.TextXAlignment.Left
           
           Separator.Name = "Separator"
           Separator.Parent = SectionFrame
           Separator.BackgroundColor3 = Color3.fromRGB(120, 160, 255)
           Separator.BorderSizePixel = 0
           Separator.Position = UDim2.new(0, 0, 1, -3)
           Separator.Size = UDim2.new(1, 0, 0, 3)
           
           local SepCorner = Instance.new("UICorner")
           SepCorner.CornerRadius = UDim.new(0, 2)
           SepCorner.Parent = Separator
           
           local SepGradient = Instance.new("UIGradient")
           SepGradient.Color = ColorSequence.new{
               ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 160, 255)),
               ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 120, 215))
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
           local OptionsList = Instance.new("Frame")
           local OptionsLayout = Instance.new("UIListLayout")
           local DropdownIcon = Instance.new("TextLabel")
           local DropdownStroke = Instance.new("UIStroke")
           local OptionsScroll = Instance.new("ScrollingFrame")
           
           DropdownFrame.Name = id
           DropdownFrame.Parent = TabFrame
           DropdownFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
           DropdownFrame.BorderSizePixel = 0
           DropdownFrame.Size = UDim2.new(1, 0, 0, description and 85 or 70)
           DropdownFrame.ClipsDescendants = true
           
           local FrameCorner = Instance.new("UICorner")
           FrameCorner.CornerRadius = UDim.new(0, 12)
           FrameCorner.Parent = DropdownFrame
           
           local FrameGradient = Instance.new("UIGradient")
           FrameGradient.Color = ColorSequence.new{
               ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 50)),
               ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 40))
           }
           FrameGradient.Rotation = 90
           FrameGradient.Parent = DropdownFrame
           
           DropdownStroke.Color = Color3.fromRGB(60, 60, 70)
           DropdownStroke.Thickness = 1
           DropdownStroke.Transparency = 0.5
           DropdownStroke.Parent = DropdownFrame
           
           DropdownIcon.Name = "Icon"
           DropdownIcon.Parent = DropdownFrame
           DropdownIcon.BackgroundTransparency = 1
           DropdownIcon.Position = UDim2.new(0, 18, 0, 15)
           DropdownIcon.Size = UDim2.new(0, 25, 0, 25)
           DropdownIcon.Font = Enum.Font.GothamBold
           DropdownIcon.Text = "≡"
           DropdownIcon.TextColor3 = Color3.fromRGB(120, 160, 255)
           DropdownIcon.TextSize = 16
           
           TitleLabel.Name = "Title"
           TitleLabel.Parent = DropdownFrame
           TitleLabel.BackgroundTransparency = 1
           TitleLabel.Position = UDim2.new(0, 50, 0, 12)
           TitleLabel.Size = UDim2.new(1, -65, 0, 22)
           TitleLabel.Font = Enum.Font.GothamSemiBold
           TitleLabel.Text = title
           TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
           TitleLabel.TextSize = 16
           TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
           
           if description then
               DescLabel.Name = "Description"
               DescLabel.Parent = DropdownFrame
               DescLabel.BackgroundTransparency = 1
               DescLabel.Position = UDim2.new(0, 50, 0, 35)
               DescLabel.Size = UDim2.new(1, -65, 0, 20)
               DescLabel.Font = Enum.Font.Gotham
               DescLabel.Text = description
               DescLabel.TextColor3 = Color3.fromRGB(180, 180, 190)
               DescLabel.TextSize = 13
               DescLabel.TextXAlignment = Enum.TextXAlignment.Left
               
               DropButton.Position = UDim2.new(0, 18, 1, -35)
           else
               DropButton.Position = UDim2.new(0, 18, 1, -40)
           end
           
           DropButton.Name = "Button"
           DropButton.Parent = DropdownFrame
           DropButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
           DropButton.BorderSizePixel = 0
           DropButton.Size = UDim2.new(1, -36, 0, 32)
           DropButton.Text = ""
           
           local ButtonCorner = Instance.new("UICorner")
           ButtonCorner.CornerRadius = UDim.new(0, 8)
           ButtonCorner.Parent = DropButton
           
           local ButtonStroke = Instance.new("UIStroke")
           ButtonStroke.Color = Color3.fromRGB(80, 80, 90)
           ButtonStroke.Thickness = 1
           ButtonStroke.Transparency = 0.6
           ButtonStroke.Parent = DropButton
           
           SelectedLabel.Name = "Selected"
           SelectedLabel.Parent = DropButton
           SelectedLabel.BackgroundTransparency = 1
           SelectedLabel.Position = UDim2.new(0, 12, 0, 0)
           SelectedLabel.Size = UDim2.new(1, -40, 1, 0)
           SelectedLabel.Font = Enum.Font.Gotham
           SelectedLabel.Text = selected
           SelectedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
           SelectedLabel.TextSize = 14
           SelectedLabel.TextXAlignment = Enum.TextXAlignment.Left
           
           Arrow.Name = "Arrow"
           Arrow.Parent = DropButton
           Arrow.BackgroundTransparency = 1
           Arrow.Position = UDim2.new(1, -30, 0, 0)
           Arrow.Size = UDim2.new(0, 30, 1, 0)
           Arrow.Font = Enum.Font.GothamSemiBold
           Arrow.Text = "▼"
           Arrow.TextColor3 = Color3.fromRGB(200, 200, 210)
           Arrow.TextSize = 14
           
           OptionsScroll.Name = "OptionsScroll"
           OptionsScroll.Parent = DropdownFrame
           OptionsScroll.Active = true
           OptionsScroll.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
           OptionsScroll.BorderSizePixel = 0
           OptionsScroll.Position = UDim2.new(0, 18, 1, -8)
           OptionsScroll.Size = UDim2.new(1, -36, 0, 0)
           OptionsScroll.Visible = false
           OptionsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
           OptionsScroll.ScrollBarThickness = 6
           OptionsScroll.ScrollBarImageColor3 = Color3.fromRGB(120, 160, 255)
           OptionsScroll.ScrollBarImageTransparency = 0.3
           
           local OptionsCorner = Instance.new("UICorner")
           OptionsCorner.CornerRadius = UDim.new(0, 8)
           OptionsCorner.Parent = OptionsScroll
           
           local OptionsStroke = Instance.new("UIStroke")
           OptionsStroke.Color = Color3.fromRGB(120, 160, 255)
           OptionsStroke.Thickness = 1
           OptionsStroke.Transparency = 0.4
           OptionsStroke.Parent = OptionsScroll
           
           OptionsLayout.Parent = OptionsScroll
           OptionsLayout.SortOrder = Enum.SortOrder.LayoutOrder
           OptionsLayout.Padding = UDim.new(0, 2)
           
           local OptionsPadding = Instance.new("UIPadding")
           OptionsPadding.PaddingTop = UDim.new(0, 5)
           OptionsPadding.PaddingBottom = UDim.new(0, 5)
           OptionsPadding.PaddingLeft = UDim.new(0, 5)
           OptionsPadding.PaddingRight = UDim.new(0, 5)
           OptionsPadding.Parent = OptionsScroll
           
           for i, option in pairs(list) do
               local OptionButton = Instance.new("TextButton")
               
               OptionButton.Name = option
               OptionButton.Parent = OptionsScroll
               OptionButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
               OptionButton.BorderSizePixel = 0
               OptionButton.Size = UDim2.new(1, 0, 0, 35)
               OptionButton.Font = Enum.Font.Gotham
               OptionButton.Text = option
               OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
               OptionButton.TextSize = 13
               
               local OptionCorner = Instance.new("UICorner")
               OptionCorner.CornerRadius = UDim.new(0, 6)
               OptionCorner.Parent = OptionButton
               
               OptionButton.MouseEnter:Connect(function()
                   TweenService:Create(OptionButton, TweenInfo.new(0.2), {
                       BackgroundColor3 = Color3.fromRGB(120, 160, 255)
                   }):Play()
               end)
               
               OptionButton.MouseLeave:Connect(function()
                   TweenService:Create(OptionButton, TweenInfo.new(0.2), {
                       BackgroundColor3 = Color3.fromRGB(45, 45, 55)
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
                       Size = UDim2.new(1, 0, 0, description and 85 or 70)
                   }):Play()
                   
                   TweenService:Create(DropdownStroke, TweenInfo.new(0.3), {
                       Color = Color3.fromRGB(60, 60, 70),
                       Transparency = 0.5
                   }):Play()
                   
                   callback(selected)
               end)
           end
           
           OptionsLayout.Changed:Connect(function()
               OptionsScroll.CanvasSize = UDim2.new(0, 0, 0, OptionsLayout.AbsoluteContentSize.Y + 10)
           end)
           
           DropButton.MouseButton1Click:Connect(function()
               isOpen = not isOpen
               
               if isOpen then
                   OptionsScroll.Visible = true
                   local maxHeight = math.min(#list * 37, 150)
                   OptionsScroll.Size = UDim2.new(1, -36, 0, maxHeight)
                   
                   TweenService:Create(Arrow, TweenInfo.new(0.3), {
                       Rotation = 180
                   }):Play()
                   
                   TweenService:Create(DropdownFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
                       Size = UDim2.new(1, 0, 0, (description and 85 or 70) + maxHeight)
                   }):Play()
                   
                   TweenService:Create(DropdownStroke, TweenInfo.new(0.3), {
                       Color = Color3.fromRGB(120, 160, 255),
                       Transparency = 0.3
                   }):Play()
               else
                   OptionsScroll.Visible = false
                   
                   TweenService:Create(Arrow, TweenInfo.new(0.3), {
                       Rotation = 0
                   }):Play()
                   
                   TweenService:Create(DropdownFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
                       Size = UDim2.new(1, 0, 0, description and 85 or 70)
                   }):Play()
                   
                   TweenService:Create(DropdownStroke, TweenInfo.new(0.3), {
                       Color = Color3.fromRGB(60, 60, 70),
                       Transparency = 0.5
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
           KeybindFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
           KeybindFrame.BorderSizePixel = 0
           KeybindFrame.Size = UDim2.new(1, 0, 0, description and 75 or 55)
           
           local FrameCorner = Instance.new("UICorner")
           FrameCorner.CornerRadius = UDim.new(0, 12)
           FrameCorner.Parent = KeybindFrame
           
           local FrameGradient = Instance.new("UIGradient")
           FrameGradient.Color = ColorSequence.new{
               ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 50)),
               ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 40))
           }
           FrameGradient.Rotation = 90
           FrameGradient.Parent = KeybindFrame
           
           KeybindStroke.Color = Color3.fromRGB(60, 60, 70)
           KeybindStroke.Thickness = 1
           KeybindStroke.Transparency = 0.5
           KeybindStroke.Parent = KeybindFrame
           
           KeybindIcon.Name = "Icon"
           KeybindIcon.Parent = KeybindFrame
           KeybindIcon.BackgroundTransparency = 1
           KeybindIcon.Position = UDim2.new(0, 18, 0, 15)
           KeybindIcon.Size = UDim2.new(0, 25, 0, 25)
           KeybindIcon.Font = Enum.Font.GothamBold
           KeybindIcon.Text = "⌨"
           KeybindIcon.TextColor3 = Color3.fromRGB(120, 160, 255)
           KeybindIcon.TextSize = 16
           
           TitleLabel.Name = "Title"
           TitleLabel.Parent = KeybindFrame
           TitleLabel.BackgroundTransparency = 1
           TitleLabel.Position = UDim2.new(0, 50, 0, 12)
           TitleLabel.Size = UDim2.new(1, -135, 0, 25)
           TitleLabel.Font = Enum.Font.GothamSemiBold
           TitleLabel.Text = title
           TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
           TitleLabel.TextSize = 16
           TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
           
           if description then
               DescLabel.Name = "Description"
               DescLabel.Parent = KeybindFrame
               DescLabel.BackgroundTransparency = 1
               DescLabel.Position = UDim2.new(0, 50, 0, 40)
               DescLabel.Size = UDim2.new(1, -135, 0, 25)
               DescLabel.Font = Enum.Font.Gotham
               DescLabel.Text = description
               DescLabel.TextColor3 = Color3.fromRGB(180, 180, 190)
               DescLabel.TextSize = 13
               DescLabel.TextXAlignment = Enum.TextXAlignment.Left
           end
           
           KeyButton.Name = "Key"
           KeyButton.Parent = KeybindFrame
           KeyButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
           KeyButton.BorderSizePixel = 0
           KeyButton.Position = UDim2.new(1, -75, 0.5, -18)
           KeyButton.Size = UDim2.new(0, 70, 0, 36)
           KeyButton.Font = Enum.Font.GothamSemiBold
           KeyButton.Text = currentKey.Name
           KeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
           KeyButton.TextSize = 12
           
           local KeyCorner = Instance.new("UICorner")
           KeyCorner.CornerRadius = UDim.new(0, 8)
           KeyCorner.Parent = KeyButton
           
           local KeyStroke = Instance.new("UIStroke")
           KeyStroke.Color = Color3.fromRGB(80, 80, 90)
           KeyStroke.Thickness = 1
           KeyStroke.Transparency = 0.6
           KeyStroke.Parent = KeyButton
           
           KeyButton.MouseEnter:Connect(function()
               if not listening then
                   TweenService:Create(KeyButton, TweenInfo.new(0.2), {
                       BackgroundColor3 = Color3.fromRGB(60, 60, 70)
                   }):Play()
                   TweenService:Create(KeyStroke, TweenInfo.new(0.2), {
                       Color = Color3.fromRGB(120, 160, 255),
                       Transparency = 0.4
                   }):Play()
               end
           end)
           
           KeyButton.MouseLeave:Connect(function()
               if not listening then
                   TweenService:Create(KeyButton, TweenInfo.new(0.2), {
                       BackgroundColor3 = Color3.fromRGB(45, 45, 55)
                   }):Play()
                   TweenService:Create(KeyStroke, TweenInfo.new(0.2), {
                       Color = Color3.fromRGB(80, 80, 90),
                       Transparency = 0.6
                   }):Play()
               end
           end)
           
           KeyButton.MouseButton1Click:Connect(function()
               if not listening then
                   listening = true
                   KeyButton.Text = "Press Key..."
                   TweenService:Create(KeyButton, TweenInfo.new(0.2), {
                       BackgroundColor3 = Color3.fromRGB(120, 160, 255)
                   }):Play()
                   TweenService:Create(KeyStroke, TweenInfo.new(0.2), {
                       Color = Color3.fromRGB(255, 255, 255),
                       Transparency = 0.2
                   }):Play()
               end
           end)
           
           UserInputService.InputBegan:Connect(function(input, processed)
               if listening and not processed then
                   if input.UserInputType == Enum.UserInputType.Keyboard then
                       currentKey = input.KeyCode
                       KeyButton.Text = currentKey.Name
                       TweenService:Create(KeyButton, TweenInfo.new(0.2), {
                           BackgroundColor3 = Color3.fromRGB(45, 45, 55)
                       }):Play()
                       TweenService:Create(KeyStroke, TweenInfo.new(0.2), {
                           Color = Color3.fromRGB(80, 80, 90),
                           Transparency = 0.6
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
   
   return Window
end

return UILibrary
