-- 🎨 Ultimate Pro-Level Blox Fruits-Style Executor UI (Fixed Load) 🎨
-- LocalScript under StarterGui

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local player = Players.LocalPlayer

-- Create ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "TournamentExecutorUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

-- Load Assets
local LOGO_ASSET = "rbxassetid://1234567890"   -- replace with your logo ID
local CLOSE_ICON = "rbxassetid://3926307971"

-- Utility: Tween
local function tween(obj, props, time, style, dir)
    TweenService:Create(obj, TweenInfo.new(time or 0.4, style or Enum.EasingStyle.Quint, dir or Enum.EasingDirection.Out), props):Play()
end

-- Utility: Click Sound
local clickSound = Instance.new("Sound")
clickSound.SoundId = "rbxassetid://142376088" -- click fx
clickSound.Volume = 0.5
clickSound.Parent = SoundService

-- Overlay
overlay = Instance.new("Frame")
overlay.Name = "Overlay"
overlay.Size = UDim2.new(1,0,1,0)
overlay.Position = UDim2.new(0,0,0,0)
overlay.BackgroundColor3 = Color3.new(0,0,0)
overlay.BackgroundTransparency = 0.75
overlay.ZIndex = 1
overlay.Active = true
overlay.Parent = gui

-- Main Window
local main = Instance.new("Frame")
main.Name = "MainWindow"
main.AnchorPoint = Vector2.new(0.5,0.5)
main.Position = UDim2.new(0.5,0,0.5,0)
main.Size = UDim2.new(0,0,0,0)
main.BackgroundColor3 = Color3.fromRGB(22,22,22)
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.ZIndex = 2
main.Parent = gui

-- Shadow
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Image = "rbxassetid://6023426915"
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(20,20,280,280)
shadow.Size = UDim2.new(1,40,1,40)
shadow.Position = UDim2.new(0,-20,0,-20)
shadow.BackgroundTransparency = 1
shadow.ImageTransparency = 0.6
shadow.ZIndex = 1
shadow.Parent = main

-- Round corners
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0,14)
mainCorner.Parent = main

-- Animate open
tween(main, {Size = UDim2.new(0,700,0,500)}, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

-- Top bar
topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1,0,0,60)
topBar.Position = UDim2.new(0,0,0,0)
topBar.BackgroundColor3 = Color3.fromRGB(28,28,28)
topBar.BorderSizePixel = 0
topBar.ZIndex = 3
topBar.Parent = main

local topGrad = Instance.new("UIGradient")
topGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(75,0,130)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(138,43,226)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(75,0,130)),
})
topGrad.Rotation = 45
topGrad.Parent = topBar

-- Logo
local logo = Instance.new("ImageLabel")
logo.Name = "Logo"
logo.Image = LOGO_ASSET
logo.Size = UDim2.new(0,48,0,48)
logo.Position = UDim2.new(0,12,0,6)
logo.BackgroundTransparency = 1
logo.ZIndex = 4
logo.Parent = topBar

-- Title
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Text = "🏆 Tournament Executor"
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.TextColor3 = Color3.fromRGB(255,255,255)
title.BackgroundTransparency = 1
title.Position = UDim2.new(0,72,0,0)
title.Size = UDim2.new(0.6,0,1,0)
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 4
title.Parent = topBar

-- Close Button
local closeBtn = Instance.new("ImageButton")
closeBtn.Name = "CloseBtn"
closeBtn.Image = CLOSE_ICON
closeBtn.ImageColor3 = Color3.fromRGB(255,100,100)
closeBtn.BackgroundTransparency = 1
closeBtn.Size = UDim2.new(0,32,0,32)
closeBtn.Position = UDim2.new(1,-44,0,14)
closeBtn.ZIndex = 4
closeBtn.Parent = topBar

closeBtn.MouseEnter:Connect(function()
    tween(closeBtn, {ImageColor3 = Color3.fromRGB(255,150,150)}, 0.2)
end)
closeBtn.MouseLeave:Connect(function()
    tween(closeBtn, {ImageColor3 = Color3.fromRGB(255,100,100)}, 0.2)
end)
closeBtn.MouseButton1Click:Connect(function()
    tween(main, {Size = UDim2.new(0,0,0,0)}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
    tween(overlay, {BackgroundTransparency = 1}, 0.3)
    delay(0.35, function() gui:Destroy() end)
end)

-- Side tabs
local sideBar = Instance.new("Frame")
sideBar.Name = "SideBar"
sideBar.Size = UDim2.new(0,180,1,-60)
sideBar.Position = UDim2.new(0,0,0,60)
sideBar.BackgroundColor3 = Color3.fromRGB(30,30,30)
sideBar.BorderSizePixel = 0
sideBar.ZIndex = 3
sideBar.Parent = main

local list = Instance.new("UIListLayout")
list.Parent = sideBar
list.Padding = UDim.new(0,16)
list.SortOrder = Enum.SortOrder.LayoutOrder
list.HorizontalAlignment = Enum.HorizontalAlignment.Left

local tabs = {"Overview","AutoFarm","Teleport","Utilities","Settings","Scripts"}
local pages = {}

-- Indicator
local indicator = Instance.new("Frame")
indicator.Name = "Indicator"
indicator.Size = UDim2.new(0,6,0,36)
indicator.Position = UDim2.new(0,0,0,16)
indicator.BackgroundColor3 = Color3.fromRGB(138,43,226)
indicator.ZIndex = 4
indicator.Parent = sideBar

for i,name in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Name = name.."Tab"
    btn.Text = name
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 18
    btn.TextColor3 = Color3.fromRGB(220,220,220)
    btn.BackgroundTransparency = 1
    btn.Size = UDim2.new(1,-16,0,36)
    btn.LayoutOrder = i
    btn.ZIndex = 4
    btn.Parent = sideBar

    btn.MouseButton1Click:Connect(function()
        clickSound:Play()
        tween(indicator, {Position = UDim2.new(0,0,0,(i-1)*52+16)}, 0.25, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)
        for _,pg in pairs(pages) do tween(pg, {BackgroundTransparency=1}, 0.2) end
        tween(pages[name], {BackgroundTransparency=0}, 0.2)
    end)
end

-- Create pages
for idx,name in ipairs(tabs) do
    local page = Instance.new("Frame")
    page.Name = name.."Page"
    page.Size = UDim2.new(1,-180,1,-60)
    page.Position = UDim2.new(0,180,0,60)
    page.BackgroundColor3 = Color3.new(1,1,1)
    page.BackgroundTransparency = (name ~= "Overview") and 1 or 0
    page.BorderSizePixel = 0
    page.ZIndex = 2
    page.Parent = main

    local grid = Instance.new("UIGridLayout")
    grid.Parent = page
    grid.CellSize = UDim2.new(0,200,0,48)
    grid.CellPadding = UDim2.new(0,24,0,24)
    grid.SortOrder = Enum.SortOrder.LayoutOrder

    pages[name] = page
end

-- Populate buttons
for name,page in pairs(pages) do
    for i=1,6 do
        local btn = Instance.new("TextButton")
        btn.Name = name.."Btn"..i
        btn.Text = name.." Action "..i
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 16
        btn.TextColor3 = Color3.new(1,1,1)
        btn.Size = UDim2.new(0,200,0,48)
        btn.BackgroundColor3 = Color3.fromRGB(75,0,130)
        btn.BorderSizePixel = 0
        btn.AutoButtonColor = false
        btn.ZIndex = page.ZIndex + 1
        btn.Parent = page

        local uc = Instance.new("UICorner") uc.CornerRadius = UDim.new(0,8) uc.Parent = btn
        local stroke = Instance.new("UIStroke") stroke.Color = Color3.fromRGB(180,100,255) stroke.Transparency = 0.3 stroke.Parent = btn

        btn.MouseEnter:Connect(function()
            tween(btn, {Size = UDim2.new(0,215,0,52), BackgroundColor3 = Color3.fromRGB(95,0,160)}, 0.2, Enum.EasingStyle.Exponential)
        end)
        btn.MouseLeave:Connect(function()
            tween(btn, {Size = UDim2.new(0,200,0,48), BackgroundColor3 = Color3.fromRGB(75,0,130)}, 0.2)
        end)
        btn.MouseButton1Click:Connect(function()
            clickSound:Play()
            tween(btn, {Size = UDim2.new(0,180,0,44)}, 0.1, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)
            delay(0.1, function() tween(btn, {Size = UDim2.new(0,200,0,48)}, 0.1) end)
            print("Executed: "..btn.Name)
        end)
    end
end
