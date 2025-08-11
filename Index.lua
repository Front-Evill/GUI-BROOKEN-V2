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
   LoadingProgress.Size = UDim2.fromScale(0, 1)

   local LoadingProgressCorner = Instance.new("UICorner")
   LoadingProgressCorner.CornerRadius = UDim.new(1, 0)
   LoadingProgressCorner.Parent = LoadingProgress

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

   local MainCorner = Instance.new("UICorner")
   MainCorner.CornerRadius = UDim.new(0, 24)
   MainCorner.Parent = MainFrame

   local TitleBar = Instance.new("Frame")
   TitleBar.Name = "TitleBar"
   TitleBar.Parent = MainFrame
   TitleBar.BackgroundColor3 = Theme.Secondary
   TitleBar.BackgroundTransparency = 0.15
   TitleBar.BorderSizePixel = 0
   TitleBar.Size = UDim2.new(1, 0, 0, 55)

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

   local CloseButton = Instance.new("TextButton")
   CloseButton.Parent = ButtonsFrame
   CloseButton.BackgroundColor3 = Theme.Secondary
   CloseButton.BackgroundTransparency = 0.2
   CloseButton.BorderSizePixel = 0
   CloseButton.Size = UDim2.fromOffset(35, 35)
   CloseButton.Text = "×"
   CloseButton.TextColor3 = Theme.Text
   CloseButton.TextSize = 14
   CloseButton.Font = Enum.Font.GothamBold

   local CloseCorner = Instance.new("UICorner")
   CloseCorner.CornerRadius = UDim.new(0, 12)
   CloseCorner.Parent = CloseButton

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

   local currentTab = nil

   MakeDraggable(MainFrame, TitleBar)

   CloseButton.MouseButton1Click:Connect(function()
       CreateTween(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
           Size = UDim2.fromOffset(0, 0)
       }):Play()
       task.wait(0.3)
       ScreenGui:Destroy()
   end)

   function Window:Notify(config)
       local Title = config.Title or "Notification"
       local Content = config.Content or "This is a notification"
       
       print(Title .. ": " .. Content)
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
       end
       
       currentTab = tab
   end

   function Window:AddTab(config)
       local TabTitle = config.Title or "Tab"
       local TabIcon = config.Icon or ""
       
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
       TabButton.Text = TabTitle
       TabButton.TextColor3 = Theme.Text
       TabButton.TextSize = 14
       TabButton.Font = Enum.Font.GothamMedium
       TabButton.TextTransparency = 0.3
       
       local TabButtonCorner = Instance.new("UICorner")
       TabButtonCorner.CornerRadius = UDim.new(0, 12)
       TabButtonCorner.Parent = TabButton
       
       local TabContentFrame = Instance.new("Frame")
       TabContentFrame.Parent = ContentFrame
       TabContentFrame.BackgroundTransparency = 1
       TabContentFrame.Size = UDim2.new(1, 0, 1, 0)
       TabContentFrame.Visible = false
       
       local TabScrollingFrame = Instance.new("ScrollingFrame")
       TabScrollingFrame.Parent = TabContentFrame
       TabScrollingFrame.BackgroundTransparency = 1
       TabScrollingFrame.BorderSizePixel = 0
       TabScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
       TabScrollingFrame.ScrollBarThickness = 6
       TabScrollingFrame.ScrollBarImageColor3 = Theme.Accent
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
       Tab.ContentFrame = TabContentFrame
       Tab.ScrollingFrame = TabScrollingFrame
       
       TabButton.MouseButton1Click:Connect(function()
           SwitchToTab(Tab)
       end)

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
               local ParagraphContent = config.Content or "Paragraph content goes here."
               
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
               
               local ParagraphTitleLabel = Instance.new("TextLabel")
               ParagraphTitleLabel.Parent = ParagraphFrame
               ParagraphTitleLabel.BackgroundTransparency = 1
               ParagraphTitleLabel.Size = UDim2.new(1, -30, 0, 25)
               ParagraphTitleLabel.Position = UDim2.fromOffset(15, 10)
               ParagraphTitleLabel.Text = ParagraphTitle
               ParagraphTitleLabel.TextColor3 = Theme.Text
               ParagraphTitleLabel.TextSize = 14
               ParagraphTitleLabel.Font = Enum.Font.GothamBold
               ParagraphTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
               
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
                   SetTitle = function(title)
                       ParagraphTitleLabel.Text = title
                   end,
                   SetContent = function(content)
                       ParagraphContentLabel.Text = content
                   end
               }
           end

           function Section:AddButton(config)
               local ButtonTitle = config.Title or "Button"
               local ButtonDesc = config.Description or ""
               local ButtonCallback = config.Callback or function() end
               local ConfirmRequired = config.ConfirmRequired or false
               
               local ButtonFrame = Instance.new("Frame")
               ButtonFrame.Parent = SectionContent
               ButtonFrame.BackgroundColor3 = Theme.Tertiary
               ButtonFrame.BackgroundTransparency = 0.15
               ButtonFrame.BorderSizePixel = 0
               ButtonFrame.Size = UDim2.new(1, 0, 0, ButtonDesc ~= "" and 65 or 45)
               
               local ButtonCorner = Instance.new("UICorner")
               ButtonCorner.CornerRadius = UDim.new(0, 12)
               ButtonCorner.Parent = ButtonFrame
               
               local ButtonTitleLabel = Instance.new("TextLabel")
               ButtonTitleLabel.Parent = ButtonFrame
               ButtonTitleLabel.BackgroundTransparency = 1
               ButtonTitleLabel.Size = UDim2.new(1, -40, 0, 20)
               ButtonTitleLabel.Position = UDim2.fromOffset(15, ButtonDesc ~= "" and 8 or 12)
               ButtonTitleLabel.Text = ButtonTitle
               ButtonTitleLabel.TextColor3 = Theme.Text
               ButtonTitleLabel.TextSize = 14
               ButtonTitleLabel.Font = Enum.Font.GothamSemibold
               ButtonTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
               
               if ButtonDesc ~= "" then
                   local ButtonDescLabel = Instance.new("TextLabel")
                   ButtonDescLabel.Parent = ButtonFrame
                   ButtonDescLabel.BackgroundTransparency = 1
                   ButtonDescLabel.Size = UDim2.new(1, -40, 0, 32)
                   ButtonDescLabel.Position = UDim2.fromOffset(15, 26)
                   ButtonDescLabel.Text = ButtonDesc
                   ButtonDescLabel.TextColor3 = Theme.SubText
                   ButtonDescLabel.TextSize = 12
                   ButtonDescLabel.Font = Enum.Font.Gotham
                   ButtonDescLabel.TextXAlignment = Enum.TextXAlignment.Left
                   ButtonDescLabel.TextYAlignment = Enum.TextYAlignment.Top
                   ButtonDescLabel.TextWrapped = true
               end
               
               local ButtonClick = Instance.new("TextButton")
               ButtonClick.Parent = ButtonFrame
               ButtonClick.BackgroundTransparency = 1
               ButtonClick.Size = UDim2.new(1, 0, 1, 0)
               ButtonClick.Text = ""
               
               ButtonClick.MouseButton1Click:Connect(function()
                   if ConfirmRequired then
                       ButtonTitleLabel.Text = "Click again to confirm"
                       ButtonTitleLabel.TextColor3 = Theme.Warning
                       task.wait(2)
                       ButtonTitleLabel.Text = ButtonTitle
                       ButtonTitleLabel.TextColor3 = Theme.Text
                   else
                       if ButtonCallback then
                           task.spawn(ButtonCallback)
                       end
                   end
               end)
               
               return ButtonFrame
           end
           
           function Section:AddToggle(toggleId, config)
               local ToggleTitle = config.Title or "Toggle"
               local ToggleDesc = config.Description or ""
               local ToggleDefault = config.Default or false
              local ToggleCallback = config.Callback or function() end
              local ConfirmRequired = config.ConfirmRequired or false
              
              local isToggled = ToggleDefault
              local pendingConfirm = false
              
              local ToggleFrame = Instance.new("Frame")
              ToggleFrame.Parent = SectionContent
              ToggleFrame.BackgroundColor3 = Theme.Tertiary
              ToggleFrame.BackgroundTransparency = 0.15
              ToggleFrame.BorderSizePixel = 0
              ToggleFrame.Size = UDim2.new(1, 0, 0, ToggleDesc ~= "" and 65 or 45)
              
              local ToggleCorner = Instance.new("UICorner")
              ToggleCorner.CornerRadius = UDim.new(0, 12)
              ToggleCorner.Parent = ToggleFrame
              
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
              
              if ToggleDesc ~= "" then
                  local ToggleDescLabel = Instance.new("TextLabel")
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
              
              local ToggleKnob = Instance.new("Frame")
              ToggleKnob.Parent = ToggleSwitch
              ToggleKnob.BackgroundColor3 = Theme.Text
              ToggleKnob.BorderSizePixel = 0
              ToggleKnob.Size = UDim2.fromOffset(16, 16)
              ToggleKnob.Position = UDim2.fromOffset(isToggled and 23 or 3, 3)
              
              local ToggleKnobCorner = Instance.new("UICorner")
              ToggleKnobCorner.CornerRadius = UDim.new(1, 0)
              ToggleKnobCorner.Parent = ToggleKnob
              
              local ToggleClick = Instance.new("TextButton")
              ToggleClick.Parent = ToggleFrame
              ToggleClick.BackgroundTransparency = 1
              ToggleClick.Size = UDim2.new(1, 0, 1, 0)
              ToggleClick.Text = ""
              
              local function UpdateToggle(newState)
                  isToggled = newState
                  
                  CreateTween(ToggleSwitch, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
                      BackgroundColor3 = isToggled and Theme.Accent or Theme.Secondary,
                      BackgroundTransparency = isToggled and 0.1 or 0.2
                  }):Play()
                  
                  CreateTween(ToggleKnob, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
                      Position = UDim2.fromOffset(isToggled and 23 or 3, 3)
                  }):Play()
                  
                  if ToggleCallback then
                      task.spawn(ToggleCallback, isToggled)
                  end
              end
              
              ToggleClick.MouseButton1Click:Connect(function()
                  if ConfirmRequired and not pendingConfirm then
                      pendingConfirm = true
                      ToggleTitleLabel.Text = "Click again to confirm"
                      ToggleTitleLabel.TextColor3 = Theme.Warning
                      task.wait(2)
                      ToggleTitleLabel.Text = ToggleTitle
                      ToggleTitleLabel.TextColor3 = Theme.Text
                      pendingConfirm = false
                  else
                      UpdateToggle(not isToggled)
                      pendingConfirm = false
                  end
              end)
              
              Toggle = {
                  Frame = ToggleFrame,
                  SetValue = function(value)
                      UpdateToggle(value)
                  end,
                  GetValue = function()
                      return isToggled
                  end
              }
              
              if isToggled and ToggleCallback then
                  task.spawn(ToggleCallback, isToggled)
              end
              
              return Toggle
          end

          function Section:AddSlider(sliderId, config)
              local SliderTitle = config.Title or "Slider"
              local SliderDesc = config.Description or ""
              local SliderMin = config.Min or 0
              local SliderMax = config.Max or 100
              local SliderDefault = config.Default or SliderMin
              local SliderRounding = config.Rounding or 1
              local SliderCallback = config.Callback or function() end
              
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
              
              if SliderDesc ~= "" then
                  local SliderDescLabel = Instance.new("TextLabel")
                  SliderDescLabel.Parent = SliderFrame
                  SliderDescLabel.BackgroundTransparency = 1
                  SliderDescLabel.Size = UDim2.new(1, -15, 0, 16)
                  SliderDescLabel.Position = UDim2.fromOffset(15, 26)
                  SliderDescLabel.Text = SliderDesc
                  SliderDescLabel.TextColor3 = Theme.SubText
                  SliderDescLabel.TextSize = 12
                  SliderDescLabel.Font = Enum.Font.Gotham
                  SliderDescLabel.TextXAlignment = Enum.TextXAlignment.Left
                  SliderDescLabel.TextWrapped = true
              end
              
              local SliderTrack = Instance.new("Frame")
              SliderTrack.Parent = SliderFrame
              SliderTrack.BackgroundColor3 = Theme.Secondary
              SliderTrack.BackgroundTransparency = 0.2
              SliderTrack.BorderSizePixel = 0
              SliderTrack.Size = UDim2.new(1, -30, 0, 6)
              SliderTrack.Position = UDim2.fromOffset(15, SliderDesc ~= "" and 52 or 32)
              
              local SliderTrackCorner = Instance.new("UICorner")
              SliderTrackCorner.CornerRadius = UDim.new(1, 0)
              SliderTrackCorner.Parent = SliderTrack
              
              local SliderFill = Instance.new("Frame")
              SliderFill.Parent = SliderTrack
              SliderFill.BackgroundColor3 = Theme.Accent
              SliderFill.BackgroundTransparency = 0.1
              SliderFill.BorderSizePixel = 0
              SliderFill.Size = UDim2.new((currentValue - SliderMin) / (SliderMax - SliderMin), 0, 1, 0)
              
              local SliderFillCorner = Instance.new("UICorner")
              SliderFillCorner.CornerRadius = UDim.new(1, 0)
              SliderFillCorner.Parent = SliderFill
              
              local SliderKnob = Instance.new("Frame")
              SliderKnob.Parent = SliderTrack
              SliderKnob.BackgroundColor3 = Theme.Text
              SliderKnob.BorderSizePixel = 0
              SliderKnob.Size = UDim2.fromOffset(16, 16)
              SliderKnob.Position = UDim2.new((currentValue - SliderMin) / (SliderMax - SliderMin), -8, 0.5, -8)
              
              local SliderKnobCorner = Instance.new("UICorner")
              SliderKnobCorner.CornerRadius = UDim.new(1, 0)
              SliderKnobCorner.Parent = SliderKnob
              
              local SliderInput = Instance.new("TextButton")
              SliderInput.Parent = SliderFrame
              SliderInput.BackgroundTransparency = 1
              SliderInput.Size = UDim2.new(1, 0, 1, 0)
              SliderInput.Text = ""
              
              local dragging = false
              
              local function UpdateSlider(value)
                  currentValue = math.clamp(value, SliderMin, SliderMax)
                  if SliderRounding > 0 then
                      currentValue = math.round(currentValue / SliderRounding) * SliderRounding
                  end
                  
                  local percentage = (currentValue - SliderMin) / (SliderMax - SliderMin)
                  
                  SliderValueLabel.Text = tostring(currentValue)
                  
                  CreateTween(SliderFill, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                      Size = UDim2.new(percentage, 0, 1, 0)
                  }):Play()
                  
                  CreateTween(SliderKnob, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                      Position = UDim2.new(percentage, -8, 0.5, -8)
                  }):Play()
                  
                  if SliderCallback then
                      task.spawn(SliderCallback, currentValue)
                  end
              end
              
              SliderInput.InputBegan:Connect(function(input)
                  if input.UserInputType == Enum.UserInputType.MouseButton1 then
                      dragging = true
                  end
              end)
              
              SliderInput.InputEnded:Connect(function(input)
                  if input.UserInputType == Enum.UserInputType.MouseButton1 then
                      dragging = false
                  end
              end)
              
              UserInputService.InputChanged:Connect(function(input)
                  if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                      local percentage = math.clamp((input.Position.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X, 0, 1)
                      local value = SliderMin + (SliderMax - SliderMin) * percentage
                      UpdateSlider(value)
                  end
              end)
              
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
              local DropdownValues = config.Values or {"Option 1", "Option 2"}
              local DropdownMulti = config.Multi or false
              local DropdownDefault = config.Default or (DropdownMulti and {} or 1)
              local DropdownCallback = config.Callback or function() end
              
              local isOpen = false
              local selectedValues = DropdownMulti and 
                  (type(DropdownDefault) == "table" and DropdownDefault or {}) or 
                  {DropdownValues[DropdownDefault] or DropdownValues[1]}
              
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
              
              local DropdownTitleLabel = Instance.new("TextLabel")
              DropdownTitleLabel.Parent = DropdownFrame
              DropdownTitleLabel.BackgroundTransparency = 1
              DropdownTitleLabel.Size = UDim2.new(1, -40, 0, 20)
              DropdownTitleLabel.Position = UDim2.fromOffset(15, DropdownDesc ~= "" and 8 or 12)
              DropdownTitleLabel.Text = DropdownTitle
              DropdownTitleLabel.TextColor3 = Theme.Text
              DropdownTitleLabel.TextSize = 14
              DropdownTitleLabel.Font = Enum.Font.GothamSemibold
              DropdownTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
              
              if DropdownDesc ~= "" then
                  local DropdownDescLabel = Instance.new("TextLabel")
                  DropdownDescLabel.Parent = DropdownFrame
                  DropdownDescLabel.BackgroundTransparency = 1
                  DropdownDescLabel.Size = UDim2.new(1, -40, 0, 32)
                  DropdownDescLabel.Position = UDim2.fromOffset(15, 26)
                  DropdownDescLabel.Text = DropdownDesc
                  DropdownDescLabel.TextColor3 = Theme.SubText
                  DropdownDescLabel.TextSize = 12
                  DropdownDescLabel.Font = Enum.Font.Gotham
                  DropdownDescLabel.TextXAlignment = Enum.TextXAlignment.Left
                  DropdownDescLabel.TextYAlignment = Enum.TextYAlignment.Top
                  DropdownDescLabel.TextWrapped = true
              end
              
              local DropdownArrow = Instance.new("TextLabel")
              DropdownArrow.Parent = DropdownFrame
              DropdownArrow.BackgroundTransparency = 1
              DropdownArrow.Size = UDim2.fromOffset(20, 20)
              DropdownArrow.Position = UDim2.new(1, -30, 0, DropdownDesc ~= "" and 12 or 12)
              DropdownArrow.Text = "▼"
              DropdownArrow.TextColor3 = Theme.Accent
              DropdownArrow.TextSize = 12
              DropdownArrow.Font = Enum.Font.GothamMedium
              
              local DropdownList = Instance.new("Frame")
              DropdownList.Parent = DropdownFrame
              DropdownList.BackgroundColor3 = Theme.Secondary
              DropdownList.BackgroundTransparency = 0.05
              DropdownList.BorderSizePixel = 0
              DropdownList.Size = UDim2.new(1, -20, 0, 0)
              DropdownList.Position = UDim2.fromOffset(10, DropdownDesc ~= "" and 70 or 50)
              
              local DropdownListCorner = Instance.new("UICorner")
              DropdownListCorner.CornerRadius = UDim.new(0, 8)
              DropdownListCorner.Parent = DropdownList
              
              local DropdownListLayout = Instance.new("UIListLayout")
              DropdownListLayout.Parent = DropdownList
              DropdownListLayout.FillDirection = Enum.FillDirection.Vertical
              DropdownListLayout.Padding = UDim.new(0, 2)
              DropdownListLayout.SortOrder = Enum.SortOrder.LayoutOrder
              
              local DropdownListPadding = Instance.new("UIPadding")
              DropdownListPadding.Parent = DropdownList
              DropdownListPadding.PaddingTop = UDim.new(0, 5)
              DropdownListPadding.PaddingBottom = UDim.new(0, 5)
              DropdownListPadding.PaddingLeft = UDim.new(0, 5)
              DropdownListPadding.PaddingRight = UDim.new(0, 5)
              
              local function UpdateDropdownText()
                  if DropdownMulti then
                      if #selectedValues == 0 then
                          DropdownTitleLabel.Text = DropdownTitle .. " (None)"
                      elseif #selectedValues == 1 then
                          DropdownTitleLabel.Text = DropdownTitle .. " (" .. selectedValues[1] .. ")"
                      else
                          DropdownTitleLabel.Text = DropdownTitle .. " (" .. #selectedValues .. " selected)"
                      end
                  else
                      DropdownTitleLabel.Text = DropdownTitle .. " (" .. (selectedValues[1] or "None") .. ")"
                  end
              end
              
              local function CreateDropdownOption(value)
                  local OptionButton = Instance.new("TextButton")
                  OptionButton.Parent = DropdownList
                  OptionButton.BackgroundColor3 = Theme.Tertiary
                  OptionButton.BackgroundTransparency = 0.3
                  OptionButton.BorderSizePixel = 0
                  OptionButton.Size = UDim2.new(1, 0, 0, 30)
                  OptionButton.Text = value
                  OptionButton.TextColor3 = Theme.Text
                  OptionButton.TextSize = 12
                  OptionButton.Font = Enum.Font.Gotham
                  
                  local OptionCorner = Instance.new("UICorner")
                  OptionCorner.CornerRadius = UDim.new(0, 6)
                  OptionCorner.Parent = OptionButton
                  
                  OptionButton.MouseButton1Click:Connect(function()
                      if DropdownMulti then
                          local index = table.find(selectedValues, value)
                          if index then
                              table.remove(selectedValues, index)
                              OptionButton.BackgroundTransparency = 0.3
                          else
                              table.insert(selectedValues, value)
                              OptionButton.BackgroundTransparency = 0.1
                          end
                      else
                          selectedValues = {value}
                          for _, child in pairs(DropdownList:GetChildren()) do
                              if child:IsA("TextButton") then
                                  child.BackgroundTransparency = 0.3
                              end
                          end
                          OptionButton.BackgroundTransparency = 0.1
                      end
                      
                      UpdateDropdownText()
                      
                      if DropdownCallback then
                          task.spawn(DropdownCallback, DropdownMulti and selectedValues or selectedValues[1])
                      end
                  end)
                  
                  if DropdownMulti then
                      if table.find(selectedValues, value) then
                          OptionButton.BackgroundTransparency = 0.1
                      end
                  else
                      if selectedValues[1] == value then
                          OptionButton.BackgroundTransparency = 0.1
                      end
                  end
              end
              
              for _, value in pairs(DropdownValues) do
                  CreateDropdownOption(value)
              end
              
              local DropdownClick = Instance.new("TextButton")
              DropdownClick.Parent = DropdownFrame
              DropdownClick.BackgroundTransparency = 1
              DropdownClick.Size = UDim2.new(1, 0, 0, DropdownDesc ~= "" and 65 or 45)
              DropdownClick.Text = ""
              
              local function ToggleDropdown()
                  isOpen = not isOpen
                  local targetSize = isOpen and 
                      UDim2.new(1, 0, 0, (DropdownDesc ~= "" and 80 or 60) + (#DropdownValues * 32) + 10) or
                      UDim2.new(1, 0, 0, DropdownDesc ~= "" and 65 or 45)
                  
                  CreateTween(DropdownFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
                      Size = targetSize
                  }):Play()
                  
                  CreateTween(DropdownList, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
                      Size = UDim2.new(1, -20, 0, isOpen and (#DropdownValues * 32) + 10 or 0)
                  }):Play()
                  
                  CreateTween(DropdownArrow, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                      Rotation = isOpen and 180 or 0
                  }):Play()
              end
              
              DropdownClick.MouseButton1Click:Connect(ToggleDropdown)
              
              UpdateDropdownText()
              
              return {
                  Frame = DropdownFrame,
                  SetValue = function(value)
                      if DropdownMulti then
                          selectedValues = type(value) == "table" and value or {value}
                      else
                          selectedValues = {value}
                      end
                      UpdateDropdownText()
                      
                      for _, child in pairs(DropdownList:GetChildren()) do
                          if child:IsA("TextButton") then
                              child.BackgroundTransparency = 0.3
                              if DropdownMulti then
                                  if table.find(selectedValues, child.Text) then
                                      child.BackgroundTransparency = 0.1
                                  end
                              else
                                  if selectedValues[1] == child.Text then
                                      child.BackgroundTransparency = 0.1
                                  end
                              end
                          end
                      end
                  end,
                  GetValue = function()
                      return DropdownMulti and selectedValues or selectedValues[1]
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
              local InputCallback = config.Callback or function() end
              
              local currentValue = InputDefault
              
              local InputFrame = Instance.new("Frame")
              InputFrame.Parent = SectionContent
              InputFrame.BackgroundColor3 = Theme.Tertiary
              InputFrame.BackgroundTransparency = 0.15
              InputFrame.BorderSizePixel = 0
              InputFrame.Size = UDim2.new(1, 0, 0, InputDesc ~= "" and 85 or 65)
              
              local InputCorner = Instance.new("UICorner")
              InputCorner.CornerRadius = UDim.new(0, 12)
              InputCorner.Parent = InputFrame
              
              local InputTitleLabel = Instance.new("TextLabel")
              InputTitleLabel.Parent = InputFrame
              InputTitleLabel.BackgroundTransparency = 1
              InputTitleLabel.Size = UDim2.new(1, -15, 0, 20)
              InputTitleLabel.Position = UDim2.fromOffset(15, 8)
              InputTitleLabel.Text = InputTitle
              InputTitleLabel.TextColor3 = Theme.Text
              InputTitleLabel.TextSize = 14
              InputTitleLabel.Font = Enum.Font.GothamSemibold
              InputTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
              
              if InputDesc ~= "" then
                  local InputDescLabel = Instance.new("TextLabel")
                  InputDescLabel.Parent = InputFrame
                  InputDescLabel.BackgroundTransparency = 1
                  InputDescLabel.Size = UDim2.new(1, -30, 0, 16)
                  InputDescLabel.Position = UDim2.fromOffset(15, 26)
                  InputDescLabel.Text = InputDesc
                  InputDescLabel.TextColor3 = Theme.SubText
                  InputDescLabel.TextSize = 12
                  InputDescLabel.Font = Enum.Font.Gotham
                  InputDescLabel.TextXAlignment = Enum.TextXAlignment.Left
                  InputDescLabel.TextWrapped = true
              end
              
              local InputBox = Instance.new("TextBox")
              InputBox.Parent = InputFrame
              InputBox.BackgroundColor3 = Theme.Secondary
              InputBox.BackgroundTransparency = 0.2
              InputBox.BorderSizePixel = 0
              InputBox.Size = UDim2.new(1, -30, 0, 28)
              InputBox.Position = UDim2.fromOffset(15, InputDesc ~= "" and 50 or 30)
              InputBox.Text = currentValue
              InputBox.PlaceholderText = InputPlaceholder
              InputBox.TextColor3 = Theme.Text
              InputBox.PlaceholderColor3 = Theme.SubText
              InputBox.TextSize = 12
              InputBox.Font = Enum.Font.Gotham
              InputBox.TextXAlignment = Enum.TextXAlignment.Left
              InputBox.ClearButtonMode = Enum.ClearButtonMode.WhileEditing
              
              local InputBoxCorner = Instance.new("UICorner")
              InputBoxCorner.CornerRadius = UDim.new(0, 8)
              InputBoxCorner.Parent = InputBox
              
              local InputBoxPadding = Instance.new("UIPadding")
              InputBoxPadding.Parent = InputBox
              InputBoxPadding.PaddingLeft = UDim.new(0, 10)
              InputBoxPadding.PaddingRight = UDim.new(0, 10)
              
              local function UpdateInput(value)
                  if InputNumeric then
                      value = string.gsub(value, "[^%d%.]", "")
                      local num = tonumber(value)
                      if num then
                          value = tostring(num)
                      else
                          value = ""
                      end
                  end
                  
                  currentValue = value
                  InputBox.Text = value
                  
                  if not InputFinished then
                      if InputCallback then
                          task.spawn(InputCallback, currentValue)
                      end
                  end
              end
              
              InputBox.Changed:Connect(function(property)
                  if property == "Text" then
                      UpdateInput(InputBox.Text)
                  end
              end)
              
              if InputFinished then
                  InputBox.FocusLost:Connect(function(enterPressed)
                      if enterPressed and InputCallback then
                          task.spawn(InputCallback, currentValue)
                      end
                  end)
              end
              
              return {
                  Frame = InputFrame,
                  SetValue = function(value)
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
  Window.Theme = Theme
  Window.TitleIcon = TitleIcon
  Window.TabsFrame = TabsFrame
  Window.Tabs = {}
  
  function Window:SetIcon(imageId)
      TitleIcon.Image = imageId
  end
  
  function Window:Destroy()
      ScreenGui:Destroy()
  end
  
  return Window
end

return FRONT_GUI
