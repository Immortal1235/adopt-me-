-- 🎨 Ultimate Pro-Level Blox Fruits-Style Executor UI 🎨
-- LocalScript under StarterGui

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local player = Players.LocalPlayer

-- Create ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "TournamentExecutorUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

-- Load Assets
local LOGO_ASSET = "rbxassetid://1234567890"   -- replace with custom logo asset id
local CLOSE_ICON = "rbxassetid://3926307971"

-- Utility: Tween
local function tween(obj, props, time, style, dir)
    TweenService:Create(obj, TweenInfo.new(time or 0.4, style or Enum.EasingStyle.Quint, dir or Enum.EasingDirection.Out), props):Play()
end

-- Utility: Play click sound
local clickSound = Instance.new("Sound", SoundService)
clickSound.SoundId = "rbxassetid://142376088" -- click fx
clickSound.Volume = 0.5

-- Overlay to dim world
local overlay = Instance.new("Frame", gui)
overlay.Name = "Overlay"
overlay.Size = UDim2.new(1,0,1,0)
overlay.BackgroundColor3 = Color3.new(0,0,0)
overlay.BackgroundTransparency = 0.75
overlay.ZIndex = 1
overlay.Active = true

-- Main GUI frame
local main = Instance.new("Frame", gui)
main.Name = "MainWindow"
main.AnchorPoint = Vector2.new(0.5,0.5)
main.Position = UDim2.new(0.5,0,0.5,0)
main.Size = UDim2.new(0,0,0,0)
main.BackgroundColor3 = Color3.fromRGB(22,22,22)
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.ZIndex = 2

-- Shadow
local shadow = Instance.new("ImageLabel", main)
shadow.Name = "Shadow"
shadow.Image = "rbxassetid://6023426915"
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(20,20,280,280)
shadow.Size = UDim2.new(1,40,1,40)
shadow.Position = UDim2.new(0,-20,0,-20)
shadow.BackgroundTransparency = 1
shadow.ImageTransparency = 0.6
shadow.ZIndex = 1

-- Round corners
local mainCorner = Instance.new("UICorner", main)
mainCorner.CornerRadius = UDim.new(0,14)

-- Animate open
tween(main, {Size = UDim2.new(0,700,0,500)}, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

-- Top section: gradient, logo, title, close
local topBar = Instance.new("Frame", main)
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1,0,0,60)
topBar.BackgroundColor3 = Color3.fromRGB(28,28,28)
topBar.BorderSizePixel = 0

local topGrad = Instance.new("UIGradient", topBar)
topGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(75,0,130)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(138,43,226)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(75,0,130)),
})
topGrad.Rotation = 45

topGrad.Enabled = true

-- Logo
local logo = Instance.new("ImageLabel", topBar)
logo.Name = "Logo"
logo.Image = LOGO_ASSET
logo.Size = UDim2.new(0,48,0,48)
logo.Position = UDim2.new(0,12,0,6)
logo.BackgroundTransparency = 1

-- Title
local title = Instance.new("TextLabel", topBar)
title.Name = "Title"
title.Text = "🏆 Tournament Executor"
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.TextColor3 = Color3.fromRGB(255,255,255)
title.BackgroundTransparency = 1
title.Position = UDim2.new(0,72,0,0)
title.Size = UDim2.new(0.6,0,1,0)
title.TextXAlignment = Enum.TextXAlignment.Left

-- Close Button
local closeBtn = Instance.new("ImageButton", topBar)
closeBtn.Name = "CloseBtn"
closeBtn.Image = CLOSE_ICON
closeBtn.ImageColor3 = Color3.fromRGB(255,100,100)
closeBtn.BackgroundTransparency = 1
closeBtn.Size = UDim2.new(0,32,0,32)
closeBtn.Position = UDim2.new(1,-44,0,14)
closeBtn.ZIndex = 3

closeBtn.MouseEnter:Connect(function() tween(closeBtn, {ImageColor3 = Color3.fromRGB(255,150,150)},0.2) end)
closeBtn.MouseLeave:Connect(function() tween(closeBtn, {ImageColor3 = Color3.fromRGB(255,100,100)},0.2) end)
closeBtn.MouseButton1Click:Connect(function()
    tween(main, {Size = UDim2.new(0,0,0,0)}, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
    tween(overlay, {BackgroundTransparency = 1}, 0.3)
    delay(0.35, function() gui:Destroy() end)
end)

-- Side tabs
local sideBar = Instance.new("Frame", main)
sideBar.Name = "SideBar"
sideBar.Size = UDim2.new(0,180,1,-60)
sideBar.Position = UDim2.new(0,0,0,60)
sideBar.BackgroundColor3 = Color3.fromRGB(30,30,30)
sideBar.BorderSizePixel = 0

local list = Instance.new("UIListLayout", sideBar)
list.Padding = UDim.new(0,16)
list.SortOrder = Enum.SortOrder.LayoutOrder

-- Indicator
local indicator = Instance.new("Frame", sideBar)
indicator.Name = "Indicator"
indicator.Size = UDim2.new(0,6,0,36)
indicator.Position = UDim2.new(0,0,0,16)
indicator.BackgroundColor3 = Color3.fromRGB(138,43,226)
indicator.ZIndex = 3

-- Tabs definition
