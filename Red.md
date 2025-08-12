# ًں“¦ FRONT EVILL GUI Library

**FRONT EVILL GUI** is an advanced graphical user interface library for Roblox.  
It is easy to use and includes all essential UI components for creating professional, interactive interfaces such as buttons, toggles, dropdowns, sliders, inputs, and notifications.

---

## ًںڑ€ **Usage**
```lua
local FRONT_GUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Front-Evill/GUI-BROOKEN-V2/refs/heads/main/Index.lua"))()

local Window = FRONT_GUI:CreateWindow({
    Title = "FRONT GUI Example",
    SubTitle = "by: FRONT EVILL",
    WelcomeText = "Welcome to Example GUI",
    LoadingTime = 3,
    Size = UDim2.fromOffset(750, 500),
    Theme = "Sky",
    MinimizeKey = Enum.KeyCode.B,
    IconImage = "rbxassetid://84366260598765"
})
```

---

## ًں–¥ **Components Documentation**

### **Button**
```lua
Section:AddButton({
    Title = "Normal Button",
    Description = "This is a normal button",
    Callback = function()
        print("Normal button clicked!")
    end
})
```

---

### **Confirm Button**
```lua
Section:AddButton({
    Title = "Confirm Button",
    Description = "This button requires confirmation",
    Confirm = true,
    Callback = function()
        print("Confirmed button clicked!")
    end
})
```

---

### **Toggle**
```lua
Section:AddToggle("Toggle1", {
    Title = "Normal Toggle",
    Description = "This is a normal toggle",
    Default = false,
    Callback = function(Value)
        print("Toggle changed:", Value)
    end
})
```

---

### **Confirm Toggle**
```lua
Section:AddToggle("Toggle2", {
    Title = "Confirm Toggle",
    Description = "This toggle requires confirmation",
    Default = false,
    Confirm = true,
    Callback = function(Value)
        print("Confirm Toggle changed:", Value)
    end
})
```

---

### **Slider**
```lua
Section:AddSlider("Slider", {
    Title = "Slider",
    Description = "This is a slider",
    Default = 2,
    Min = 0,
    Max = 5,
    Rounding = 1,
    Callback = function(Value)
        print("Slider was changed:", Value)
    end
})
```

---

### **Dropdown**
```lua
Section:AddDropdown("Dropdown", {
    Title = "Dropdown",
    Description = "Dropdown description",
    Values = {"one", "two", "three", "four", "five"},
    Multi = false,
    Default = 1,
    Callback = function(Value)
        print("Dropdown changed:", Value)
    end
})
```

---

### **Multi Dropdown**
```lua
Section:AddDropdown("MultiDropdown", {
    Title = "Multi Dropdown",
    Description = "You can select multiple values.",
    Values = {"one", "two", "three", "four", "five"},
    Multi = true,
    Default = {"three", "five"},
    Callback = function(Values)
        for _, value in pairs(Values) do
            print(" -", value)
        end
    end
})
```

---

### **Input**
```lua
Section:AddInput("Input", {
    Title = "Input",
    Description = "Input Description",
    Default = "Default",
    Placeholder = "Placeholder",
    Numeric = false,
    Finished = false,
    Callback = function(Value)
        print("Input changed:", Value)
    end
})
```

---

### **Notify**
```lua
Window:Notify({
    Title = "GUI Loaded!",
    Content = "All elements have been loaded successfully.",
    Duration = 5
})
```

---

## ًں“Œ Notes
- All components are easy to customize.
- The library supports themes, icons, and full design control.
- Perfect for creating control panels, tools, and Roblox scripts.
