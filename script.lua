-- FartyHUB v5.7 (Ultra Animations + Old Classic Fly + Hard Multi-Fling + Custom Sliders & Toggles Everywhere)

-- ==================== ЗАЩИТА ОТ КИКА ====================
pcall(function()
    local OldNameCall
    OldNameCall = hookmetamethod(game, "__namecall", function(self, ...)
        local Method = getnamecallmethod()
        if Method:lower() == "kick" or Method:lower() == "(-kick-)" then
            if self == game:GetService("Players").LocalPlayer then
                return
            end
        end
        return OldNameCall(self, ...)
    end)
end)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- ==================== СИСТЕМА ДИНАМИЧЕСКИХ АНИМАЦИЙ ====================
local function applyAdvancedAnimations(btn, isToggle)
    local originalColor = btn.BackgroundColor3
    local hoverColor = Color3.fromRGB(
        math.clamp(originalColor.R * 255 + 35, 0, 255),
        math.clamp(originalColor.G * 255 + 35, 0, 255),
        math.clamp(originalColor.B * 255 + 35, 0, 255)
    )
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            BackgroundColor3 = hoverColor,
            Size = UDim2.new(btn.Size.X.Scale, btn.Size.X.Offset, btn.Size.Y.Scale, btn.Size.Y.Offset + 2)
        }):Play()
    end)
    
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            BackgroundColor3 = originalColor,
            Size = UDim2.new(btn.Size.X.Scale, btn.Size.X.Offset, btn.Size.Y.Scale, btn.Size.Y.Offset - 2)
        }):Play()
    end)
    
    btn.MouseButton1Down:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(btn.Size.X.Scale, btn.Size.X.Offset, btn.Size.Y.Scale, btn.Size.Y.Offset - 4)
        }):Play()
    end)
    
    btn.MouseButton1Up:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(btn.Size.X.Scale, btn.Size.X.Offset, btn.Size.Y.Scale, btn.Size.Y.Offset + 4)
        }):Play()
    end)
end

-- ==================== ИНТЕРФЕЙС ====================
local main = Instance.new("ScreenGui")
main.Name = "FartyHUB_v5.7"
main.ResetOnSpawn = false
main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

if syn and syn.protect_gui then
    syn.protect_gui(main)
    main.Parent = game:GetService("CoreGui")
elseif gethui then
    main.Parent = gethui()
else
    main.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

local MainFrame = Instance.new("Frame")
MainFrame.Parent = main
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
MainFrame.BorderColor3 = Color3.fromRGB(60, 60, 60)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -155)
MainFrame.Size = UDim2.new(0, 420, 0, 310)
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 14)
UICorner.Parent = MainFrame

-- Шапка
local TopBar = Instance.new("Frame")
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
TopBar.Size = UDim2.new(1, 0, 0, 38)
TopBar.BorderSizePixel = 0

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 14)
TopCorner.Parent = TopBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = TopBar
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 16, 0, 0)
TitleLabel.Size = UDim2.new(0, 260, 1, 0)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "FartyHUB v5.7 | Ultra FX"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 14
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = TopBar
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 45, 45)
CloseBtn.Position = UDim2.new(1, -34, 0, 7)
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 16
CloseBtn.BorderSizePixel = 0
applyAdvancedAnimations(CloseBtn)

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

local MiniBtn = Instance.new("TextButton")
MiniBtn.Parent = TopBar
MiniBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MiniBtn.Position = UDim2.new(1, -66, 0, 7)
MiniBtn.Size = UDim2.new(0, 24, 0, 24)
MiniBtn.Font = Enum.Font.GothamBold
MiniBtn.Text = "−"
MiniBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MiniBtn.TextSize = 16
MiniBtn.BorderSizePixel = 0
applyAdvancedAnimations(MiniBtn)

local MiniCorner = Instance.new("UICorner")
MiniCorner.CornerRadius = UDim.new(0, 6)
MiniCorner.Parent = MiniBtn

-- Основной контейнер
local Content = Instance.new("Frame")
Content.Parent = MainFrame
Content.BackgroundTransparency = 1
Content.Position = UDim2.new(0, 0, 0, 42)
Content.Size = UDim2.new(1, 0, 1, -42)

local TabBar = Instance.new("ScrollingFrame")
TabBar.Parent = Content
TabBar.BackgroundTransparency = 1
TabBar.Position = UDim2.new(0, 10, 0, 0)
TabBar.Size = UDim2.new(0, 115, 1, -10)
TabBar.CanvasSize = UDim2.new(0, 0, 0, 280)
TabBar.ScrollBarThickness = 2

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.Parent = TabBar
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 6)

local PagesContainer = Instance.new("Frame")
PagesContainer.Parent = Content
PagesContainer.BackgroundTransparency = 1
PagesContainer.Position = UDim2.new(0, 132, 0, 0)
PagesContainer.Size = UDim2.new(1, -142, 1, -10)

local Categories = {"Fly GUI", "Speed", "High Jump", "Combat", "ESP", "Fling"}
local Pages = {}

for _, cat in ipairs(Categories) do
    local TabBtn = Instance.new("TextButton")
    TabBtn.Parent = TabBar
    TabBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    TabBtn.Size = UDim2.new(1, 0, 0, 38)
    TabBtn.Font = Enum.Font.GothamMedium
    TabBtn.Text = cat
    TabBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
    TabBtn.TextSize = 12
    applyAdvancedAnimations(TabBtn)
    
    local TCorner = Instance.new("UICorner")
    TCorner.CornerRadius = UDim.new(0, 8)
    TCorner.Parent = TabBtn
    
    local Page = Instance.new("ScrollingFrame")
    Page.Parent = PagesContainer
    Page.BackgroundTransparency = 1
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.CanvasSize = UDim2.new(0, 0, 0, 420)
    Page.ScrollBarThickness = 2
    Page.Visible = (cat == "Fly GUI")
    
    local PageLayout = Instance.new("UIListLayout")
    PageLayout.Parent = Page
    PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    PageLayout.Padding = UDim.new(0, 6)
    
    Pages[cat] = Page
    
    TabBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        for _, b in pairs(TabBar:GetChildren()) do
            if b:IsA("TextButton") then
                TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(20, 20, 20), TextColor3 = Color3.fromRGB(150, 150, 150)}):Play()
            end
        end
        Page.Visible = true
        TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45), TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
    end)
    
    if cat == "Fly GUI" then
        TabBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end

-- Функция создания красивого интерактивного слайдера
local function CreateAdvancedSlider(parent, name, min, max, default, callback)
    local Container = Instance.new("Frame")
    Container.Parent = parent
    Container.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    Container.Size = UDim2.new(1, -4, 0, 48)
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Container
    
    local Label = Instance.new("TextLabel")
    Label.Parent = Container
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 10, 0, 4)
    Label.Size = UDim2.new(1, -20, 0, 18)
    Label.Font = Enum.Font.GothamMedium
    Label.Text = name .. ": " .. tostring(default)
    Label.TextColor3 = Color3.fromRGB(210, 210, 210)
    Label.TextSize = 11
    Label.TextXAlignment = Enum.TextXAlignment.Left
    
    local SliderBar = Instance.new("Frame")
    SliderBar.Parent = Container
    SliderBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    SliderBar.Position = UDim2.new(0, 10, 0, 28)
    SliderBar.Size = UDim2.new(1, -20, 0, 8)
    
    local BarCorner = Instance.new("UICorner")
    BarCorner.CornerRadius = UDim.new(0, 4)
    BarCorner.Parent = SliderBar
    
    local Fill = Instance.new("Frame")
    Fill.Parent = SliderBar
    Fill.BackgroundColor3 = Color3.fromRGB(80, 160, 255)
    Fill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
    
    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(0, 4)
    FillCorner.Parent = Fill
    
    local Knob = Instance.new("Frame")
    Knob.Parent = SliderBar
    Knob.AnchorPoint = Vector2.new(0.5, 0.5)
    Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Knob.Position = UDim2.new((default - min)/(max - min), 0, 0.5, 0)
    Knob.Size = UDim2.new(0, 14, 0, 14)
    
    local KnobCorner = Instance.new("UICorner")
    KnobCorner.CornerRadius = UDim.new(1, 0)
    KnobCorner.Parent = Knob
    
    local dragging = false
    local function updateInput(input)
        local pos = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
        local val = math.floor(min + (max - min) * pos)
        Fill.Size = UDim2.new(pos, 0, 1, 0)
        Knob.Position = UDim2.new(pos, 0, 0.5, 0)
        Label.Text = name .. ": " .. tostring(val)
        pcall(function() callback(val) end)
    end
    
    SliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateInput(input)
            TweenService:Create(Knob, TweenInfo.new(0.1), {Size = UDim2.new(0, 18, 0, 18)}):Play()
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if dragging then
                dragging = false
                TweenService:Create(Knob, TweenInfo.new(0.1), {Size = UDim2.new(0, 14, 0, 14)}):Play()
            end
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateInput(input)
        end
    end)
end

-- ==================== 1. FLY GUI (СТАРЫЙ КЛАССИЧЕСКИЙ ПЛАВНЫЙ ФЛАЙ) ====================
local FlyPage = Pages["Fly GUI"]
local FlyToggle = Instance.new("TextButton")
FlyToggle.Parent = FlyPage
FlyToggle.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
FlyToggle.Size = UDim2.new(1, -4, 0, 40)
FlyToggle.Font = Enum.Font.GothamMedium
FlyToggle.Text = "Classic Fly: [OFF]"
FlyToggle.TextColor3 = Color3.fromRGB(200, 200, 200)
FlyToggle.TextSize = 12
applyAdvancedAnimations(FlyToggle)

local FTCorner = Instance.new("UICorner")
FTCorner.CornerRadius = UDim.new(0, 8)
FTCorner.Parent = FlyToggle

local flySpeed = 50
CreateAdvancedSlider(FlyPage, "Fly Speed", 16, 200, 50, function(val) flySpeed = val end)

local flying = false
local deb = false
local ctrl = {f = 0, b = 0, l = 0, r = 0}
local lastctrl = {f = 0, b = 0, l = 0, r = 0}
local maxspeed = 50
local speed = 0

local function Fly()
    local p = LocalPlayer
    local char = p.Character
    if not char then return end
    local torso = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
    if not torso then return end
    
    local bg = Instance.new("BodyGyro", torso)
    bg.P = 9e4
    bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    bg.cframe = torso.CFrame
    
    local bv = Instance.new("BodyVelocity", torso)
    bv.velocity = Vector3.new(0,0,0)
    bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
    
    task.spawn(function()
        repeat task.wait()
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.PlatformStand = true end
            if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
                speed = speed+.5+(flySpeed/maxspeed)
                if speed > (flySpeed) then speed = (flySpeed) end
            elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
                speed = speed-1
                if speed < 0 then speed = 0 end
            end
            if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
                bv.velocity = ((Camera.CoordinateFrame.lookVector * (ctrl.f + ctrl.b)) + ((Camera.CoordinateFrame * CFrame.new(ctrl.l + ctrl.r, (ctrl.f + ctrl.b) * .2, 0).p) - Camera.CoordinateFrame.p)) * speed
                lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
            elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
                bv.velocity = ((Camera.CoordinateFrame.lookVector * (lastctrl.f + lastctrl.b)) + ((Camera.CoordinateFrame * CFrame.new(lastctrl.l + lastctrl.r, (lastctrl.f + lastctrl.b) * .2, 0).p) - Camera.CoordinateFrame.p)) * speed
            else
                bv.velocity = Vector3.new(0,0,0)
            end
            bg.cframe = Camera.CoordinateFrame
        until not flying
        ctrl = {f = 0, b = 0, l = 0, r = 0}
        lastctrl = {f = 0, b = 0, l = 0, r = 0}
        speed = 0
        bg:Destroy()
        bv:Destroy()
        if hum then hum.PlatformStand = false end
    end)
end

FlyToggle.MouseButton1Click:Connect(function()
    flying = not flying
    if flying then
        FlyToggle.Text = "Classic Fly: [ON]"
        TweenService:Create(FlyToggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 90, 35)}):Play()
        FlyToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
        Fly()
    else
        FlyToggle.Text = "Classic Fly: [OFF]"
        TweenService:Create(FlyToggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(18, 18, 18)}):Play()
        FlyToggle.TextColor3 = Color3.fromRGB(200, 200, 200)
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not flying then return end
    if input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.Up then ctrl.f = 1 end
    if input.KeyCode == Enum.KeyCode.S or input.KeyCode == Enum.KeyCode.Down then ctrl.b = -1 end
    if input.KeyCode == Enum.KeyCode.A or input.KeyCode == Enum.KeyCode.Left then ctrl.l = -1 end
    if input.KeyCode == Enum.KeyCode.D or input.KeyCode == Enum.KeyCode.Right then ctrl.r = 1 end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if not flying then return end
    if input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.Up then ctrl.f = 0 end
    if input.KeyCode == Enum.KeyCode.S or input.KeyCode == Enum.KeyCode.Down then ctrl.b = 0 end
    if input.KeyCode == Enum.KeyCode.A or input.KeyCode == Enum.KeyCode.Left then ctrl.l = 0 end
    if input.KeyCode == Enum.KeyCode.D or input.KeyCode == Enum.KeyCode.Right then ctrl.r = 0 end
end)

-- ==================== 2. SPEED ====================
local SpeedPage = Pages["Speed"]
local walkSpeedVal = 16
local speedactive = false

local SpeedToggle = Instance.new("TextButton")
SpeedToggle.Parent = SpeedPage
SpeedToggle.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
SpeedToggle.Size = UDim2.new(1, -4, 0, 40)
SpeedToggle.Font = Enum.Font.GothamMedium
SpeedToggle.Text = "Speedhack: [OFF]"
SpeedToggle.TextColor3 = Color3.fromRGB(200, 200, 200)
SpeedToggle.TextSize = 12
applyAdvancedAnimations(SpeedToggle)

local STCorner = Instance.new("UICorner")
STCorner.CornerRadius = UDim.new(0, 8)
STCorner.Parent = SpeedToggle

CreateAdvancedSlider(SpeedPage, "WalkSpeed", 16, 200, 16, function(val) walkSpeedVal = val end)

SpeedToggle.MouseButton1Click:Connect(function()
    speedactive = not speedactive
    if speedactive then
        SpeedToggle.Text = "Speedhack: [ON]"
        TweenService:Create(SpeedToggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 90, 35)}):Play()
        SpeedToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    else
        SpeedToggle.Text = "Speedhack: [OFF]"
        TweenService:Create(SpeedToggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(18, 18, 18)}):Play()
        SpeedToggle.TextColor3 = Color3.fromRGB(200, 200, 200)
    end
end)

RunService.Stepped:Connect(function()
    if speedactive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = walkSpeedVal
    end
end)

-- ==================== 3. HIGH JUMP ====================
local JumpPage = Pages["High Jump"]
local jumpPowerVal = 50
local jumpActive = false

local JumpToggle = Instance.new("TextButton")
JumpToggle.Parent = JumpPage
JumpToggle.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
JumpToggle.Size = UDim2.new(1, -4, 0, 40)
JumpToggle.Font = Enum.Font.GothamMedium
JumpToggle.Text = "High Jump: [OFF]"
JumpToggle.TextColor3 = Color3.fromRGB(200, 200, 200)
JumpToggle.TextSize = 12
applyAdvancedAnimations(JumpToggle)

local JTCorner = Instance.new("UICorner")
JTCorner.CornerRadius = UDim.new(0, 8)
JTCorner.Parent = JumpToggle

CreateAdvancedSlider(JumpPage, "Jump Power", 50, 400, 50, function(val) jumpPowerVal = val end)

JumpToggle.MouseButton1Click:Connect(function()
    jumpActive = not jumpActive
    if jumpActive then
        JumpToggle.Text = "High Jump: [ON]"
        TweenService:Create(JumpToggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 90, 35)}):Play()
        JumpToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    else
        JumpToggle.Text = "High Jump: [OFF]"
        TweenService:Create(JumpToggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(18, 18, 18)}):Play()
        JumpToggle.TextColor3 = Color3.fromRGB(200, 200, 200)
    end
end)

RunService.Stepped:Connect(function()
    if jumpActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local hum = LocalPlayer.Character.Humanoid
        hum.UseJumpPower = true
        hum.JumpPower = jumpPowerVal
    end
end)

-- ==================== 4. COMBAT (АИМБОТ С НАСТРОЙКОЙ ПЛАВНОСТИ) ====================
local CombatPage = Pages["Combat"]
local aimbotActive = false
local smoothnessVal = 20 -- от 5 до 50

local AimbotToggle = Instance.new("TextButton")
AimbotToggle.Parent = CombatPage
AimbotToggle.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
AimbotToggle.Size = UDim2.new(1, -4, 0, 40)
AimbotToggle.Font = Enum.Font.GothamMedium
AimbotToggle.Text = "Smooth Aimbot: [OFF]"
AimbotToggle.TextColor3 = Color3.fromRGB(200, 200, 200)
AimbotToggle.TextSize = 12
applyAdvancedAnimations(AimbotToggle)

local ATCorner = Instance.new("UICorner")
ATCorner.CornerRadius = UDim.new(0, 8)
ATCorner.Parent = AimbotToggle

CreateAdvancedSlider(CombatPage, "Aimbot Smoothness", 5, 50, 20, function(val) smoothnessVal = val end)

AimbotToggle.MouseButton1Click:Connect(function()
    aimbotActive = not aimbotActive
    if aimbotActive then
        AimbotToggle.Text = "Smooth Aimbot: [ON]"
        TweenService:Create(AimbotToggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 90, 35)}):Play()
        AimbotToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    else
        AimbotToggle.Text = "Smooth Aimbot: [OFF]"
        TweenService:Create(AimbotToggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(18, 18, 18)}):Play()
        AimbotToggle.TextColor3 = Color3.fromRGB(200, 200, 200)
    end
end)

RunService.RenderStepped:Connect(function()
    if aimbotActive then
        local minDist = math.huge
        local targetHead = nil
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                local head = p.Character.Head
                local _, onScreen = Camera:WorldToViewportPoint(head.Position)
                if onScreen then
                    local dist = (head.Position - Camera.CFrame.Position).Magnitude
                    if dist < minDist then
                        minDist = dist
                        targetHead = head
                    end
                end
            end
        end
        if targetHead then
            local targetCF = CFrame.new(Camera.CFrame.Position, targetHead.Position)
            Camera.CFrame = Camera.CFrame:Lerp(targetCF, smoothnessVal / 100)
        end
    end
end)

-- ==================== 5. ESP ====================
local ESPPage = Pages["ESP"]
local espActive = false

local ESPToggle = Instance.new("TextButton")
ESPToggle.Parent = ESPPage
ESPToggle.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
ESPToggle.Size = UDim2.new(1, -4, 0, 40)
ESPToggle.Font = Enum.Font.GothamMedium
ESPToggle.Text = "Player ESP: [OFF]"
ESPToggle.TextColor3 = Color3.fromRGB(200, 200, 200)
ESPToggle.TextSize = 12
applyAdvancedAnimations(ESPToggle)

local ESP_Corner = Instance.new("UICorner")
ESP_Corner.CornerRadius = UDim.new(0, 8)
ESP_Corner.Parent = ESPToggle

ESPToggle.MouseButton1Click:Connect(function()
    espActive = not espActive
    if espActive then
        ESPToggle.Text = "Player ESP: [ON]"
        TweenService:Create(ESPToggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 90, 35)}):Play()
        ESPToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    else
        ESPToggle.Text = "Player ESP: [OFF]"
        TweenService:Create(ESPToggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(18, 18, 18)}):Play()
        ESPToggle.TextColor3 = Color3.fromRGB(200, 200, 200)
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("FartyHighlight") then
                p.Character.FartyHighlight:Destroy()
            end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if espActive then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local char = p.Character
                if not char:FindFirstChild("FartyHighlight") then
                    local hl = Instance.new("Highlight")
                    hl.Name = "FartyHighlight"
                    hl.Adornee = char
                    hl.Parent = char
                    hl.FillTransparency = 0.4
                    hl.FillColor = Color3.fromRGB(70, 150, 255)
                    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                    hl.OutlineTransparency = 0
                end
            end
        end
    end
end)

-- ==================== 6. FLING (УЛЬТРА-ЖЕСТКИЙ СТАРЫЙ МУЛЬТИ-ФЛИНГ) ====================
local FlingPage = Pages["Fling"]

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = FlingPage
StatusLabel.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
StatusLabel.Size = UDim2.new(1, -4, 0, 34)
StatusLabel.Font = Enum.Font.GothamMedium
StatusLabel.Text = "Targets: 0 selected"
StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
StatusLabel.TextSize = 11

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 8)
StatusCorner.Parent = StatusLabel

local PlayerScrollFrame = Instance.new("ScrollingFrame")
PlayerScrollFrame.Parent = FlingPage
PlayerScrollFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
PlayerScrollFrame.Size = UDim2.new(1, -4, 0, 130)
PlayerScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerScrollFrame.ScrollBarThickness = 4
PlayerScrollFrame.BorderSizePixel = 0

local FlingScrollCorner = Instance.new("UICorner")
FlingScrollCorner.CornerRadius = UDim.new(0, 8)
FlingScrollCorner.Parent = PlayerScrollFrame

local FlingScrollLayout = Instance.new("UIListLayout")
FlingScrollLayout.Parent = PlayerScrollFrame
FlingScrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
FlingScrollLayout.Padding = UDim.new(0, 4)

local StartButton = Instance.new("TextButton")
StartButton.Parent = FlingPage
StartButton.BackgroundColor3 = Color3.fromRGB(35, 90, 35)
StartButton.Size = UDim2.new(1, -4, 0, 34)
StartButton.Font = Enum.Font.GothamMedium
StartButton.Text = "START ULTRA FLING"
StartButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StartButton.TextSize = 12
applyAdvancedAnimations(StartButton)
local SB_Corner = Instance.new("UICorner"); SB_Corner.CornerRadius = UDim.new(0, 8); SB_Corner.Parent = StartButton

local StopButton = Instance.new("TextButton")
StopButton.Parent = FlingPage
StopButton.BackgroundColor3 = Color3.fromRGB(140, 35, 35)
StopButton.Size = UDim2.new(1, -4, 0, 34)
StopButton.Font = Enum.Font.GothamMedium
StopButton.Text = "STOP FLING"
StopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StopButton.TextSize = 12
applyAdvancedAnimations(StopButton)
local StopB_Corner = Instance.new("UICorner"); StopB_Corner.CornerRadius = UDim.new(0, 8); StopB_Corner.Parent = StopButton

local SelectAllButton = Instance.new("TextButton")
SelectAllButton.Parent = FlingPage
SelectAllButton.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
SelectAllButton.Size = UDim2.new(1, -4, 0, 30)
SelectAllButton.Font = Enum.Font.GothamMedium
SelectAllButton.Text = "SELECT ALL"
SelectAllButton.TextColor3 = Color3.fromRGB(200, 200, 200)
SelectAllButton.TextSize = 11
applyAdvancedAnimations(SelectAllButton)
local SA_Corner = Instance.new("UICorner"); SA_Corner.CornerRadius = UDim.new(0, 8); SA_Corner.Parent = SelectAllButton

local DeselectAllButton = Instance.new("TextButton")
DeselectAllButton.Parent = FlingPage
DeselectAllButton.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
DeselectAllButton.Size = UDim2.new(1, -4, 0, 30)
DeselectAllButton.Font = Enum.Font.GothamMedium
DeselectAllButton.Text = "DESELECT ALL"
DeselectAllButton.TextColor3 = Color3.fromRGB(200, 200, 200)
DeselectAllButton.TextSize = 11
applyAdvancedAnimations(DeselectAllButton)
local DA_Corner = Instance.new("UICorner"); DA_Corner.CornerRadius = UDim.new(0, 8); DA_Corner.Parent = DeselectAllButton

local SelectedTargets = {}
local PlayerCheckboxes = {}
local FlingActive = false
getgenv().OldPos = nil
getgenv().FPDH = workspace.FallenPartsDestroyHeight

local function CountSelectedTargets()
    local count = 0
    for _ in pairs(SelectedTargets) do count = count + 1 end
    return count
end

local function UpdateStatus()
    local count = CountSelectedTargets()
    if FlingActive then
        StatusLabel.Text = "Flinging " .. count .. " target(s) with max force!"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
    else
        StatusLabel.Text = count .. " target(s) selected" 
        StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    end
end

local function RefreshPlayerList()
    for _, child in pairs(PlayerScrollFrame:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end
    PlayerCheckboxes = {}
    
    local PlayerList = Players:GetPlayers()
    table.sort(PlayerList, function(a, b) return a.Name:lower() < b.Name:lower() end)
    
    local yPosition = 2
    for _, player in ipairs(PlayerList) do
        if player ~= LocalPlayer then
            local PlayerEntry = Instance.new("Frame")
            PlayerEntry.Size = UDim2.new(1, -4, 0, 28)
            PlayerEntry.Position = UDim2.new(0, 2, 0, yPosition)
            PlayerEntry.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
            PlayerEntry.BorderSizePixel = 0
            PlayerEntry.Parent = PlayerScrollFrame
            
            local PE_Corner = Instance.new("UICorner"); PE_Corner.CornerRadius = UDim.new(0, 6); PE_Corner.Parent = PlayerEntry
            
            local Checkbox = Instance.new("TextButton")
            Checkbox.Size = UDim2.new(0, 18, 0, 18)
            Checkbox.Position = UDim2.new(0, 6, 0.5, -9)
            Checkbox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Checkbox.BorderSizePixel = 0
            Checkbox.Text = ""
            Checkbox.Parent = PlayerEntry
            
            local CB_Corner = Instance.new("UICorner"); CB_Corner.CornerRadius = UDim.new(0, 4); CB_Corner.Parent = Checkbox
            
            local Checkmark = Instance.new("TextLabel")
            Checkmark.Size = UDim2.new(1, 0, 1, 0)
            Checkmark.BackgroundTransparency = 1
            Checkmark.Text = "✓"
            Checkmark.TextColor3 = Color3.fromRGB(80, 255, 80)
            Checkmark.TextSize = 14
            Checkmark.Font = Enum.Font.GothamBold
            Checkmark.Visible = SelectedTargets[player.Name] ~= nil
            Checkmark.Parent = Checkbox
            
            local NameLabel = Instance.new("TextLabel")
            NameLabel.Size = UDim2.new(1, -32, 1, 0)
            NameLabel.Position = UDim2.new(0, 32, 0, 0)
            NameLabel.BackgroundTransparency = 1
            NameLabel.Text = player.Name
            NameLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
            NameLabel.TextSize = 11
            NameLabel.Font = Enum.Font.GothamMedium
            NameLabel.TextXAlignment = Enum.TextXAlignment.Left
            NameLabel.Parent = PlayerEntry
            
            local ClickArea = Instance.new("TextButton")
            ClickArea.Size = UDim2.new(1, 0, 1, 0)
            ClickArea.BackgroundTransparency = 1
            ClickArea.Text = ""
            ClickArea.Parent = PlayerEntry
            
            ClickArea.MouseButton1Click:Connect(function()
                if SelectedTargets[player.Name] then
                    SelectedTargets[player.Name] = nil
                    Checkmark.Visible = false
                else
                    SelectedTargets[player.Name] = player
                    Checkmark.Visible = true
                end
                UpdateStatus()
            end)
            
            PlayerCheckboxes[player.Name] = { Checkmark = Checkmark }
            yPosition = yPosition + 32
        end
    end
    PlayerScrollFrame.CanvasSize = UDim2.new(0, 0, 0, yPosition + 2)
end

local function ToggleAllPlayers(select)
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local checkboxData = PlayerCheckboxes[player.Name]
            if checkboxData then
                if select then
                    SelectedTargets[player.Name] = player
                    checkboxData.Checkmark.Visible = true
                else
                    SelectedTargets[player.Name] = nil
                    checkboxData.Checkmark.Visible = false
                end
            end
        end
    end
    UpdateStatus()
end

local function HardOldFling(TargetPlayer)
    local Character = LocalPlayer.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local RootPart = Humanoid and Humanoid.RootPart
    local TCharacter = TargetPlayer.Character
    if not TCharacter then return end
    
    local THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
    local TRootPart = THumanoid and THumanoid.RootPart
    local THead = TCharacter:FindFirstChild("Head")
    
    if Character and Humanoid and RootPart then
        if RootPart.Velocity.Magnitude < 50 then
            getgenv().OldPos = RootPart.CFrame
        end
        
        if THumanoid and THumanoid.Sit then return end
        if THead then workspace.CurrentCamera.CameraSubject = THead end
        
        local FPos = function(BasePart, Pos, Ang)
            RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
            Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
            RootPart.Velocity = Vector3.new(9e9, 9e9, 9e9)
            RootPart.RotVelocity = Vector3.new(9e9, 9e9, 9e9)
        end
        
        local SFBasePart = function(BasePart)
            local Time = tick()
            local Angle = 0
            repeat
                if RootPart and THumanoid then
                    Angle = Angle + 200
                    FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * 3, CFrame.Angles(math.rad(Angle), 0, 0))
                    task.wait()
                    FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * 3, CFrame.Angles(math.rad(Angle), 0, 0))
                    task.wait()
                end
            until tick() - Time > 1.8 or not FlingActive
        end
        
        workspace.FallenPartsDestroyHeight = 0/0
        
        local BV = Instance.new("BodyVelocity")
        BV.Parent = RootPart
        BV.Velocity = Vector3.new(9e9, 9e9, 9e9)
        BV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
        
        if TRootPart then
            SFBasePart(TRootPart)
        elseif THead then
            SFBasePart(THead)
        end
        
        BV:Destroy()
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        workspace.CurrentCamera.CameraSubject = Humanoid
        
        if getgenv().OldPos then
            repeat
                RootPart.CFrame = getgenv().OldPos
                Character:SetPrimaryPartCFrame(getgenv().OldPos)
                Humanoid:ChangeState("GettingUp")
                for _, part in pairs(Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.Velocity, part.RotVelocity = Vector3.new(), Vector3.new()
                    end
                end
                task.wait()
            until (RootPart.Position - getgenv().OldPos.p).Magnitude < 20
            workspace.FallenPartsDestroyHeight = getgenv().FPDH
        end
    end
end

StartButton.MouseButton1Click:Connect(function()
    if FlingActive then return end
    if CountSelectedTargets() == 0 then return end
    
    FlingActive = true
    UpdateStatus()
    
    task.spawn(function()
        while FlingActive do
            for name, player in pairs(SelectedTargets) do
                if player and player.Parent and FlingActive then
                    HardOldFling(player)
                    task.wait(0.1)
                else
                    SelectedTargets[name] = nil
                end
            end
            task.wait(0.3)
        end
    end)
end)

StopButton.MouseButton1Click:Connect(function()
    FlingActive = false
    UpdateStatus()
end)

SelectAllButton.MouseButton1Click:Connect(function() ToggleAllPlayers(true) end)
DeselectAllButton.MouseButton1Click:Connect(function() ToggleAllPlayers(false) end)

Players.PlayerAdded:Connect(RefreshPlayerList)
Players.PlayerRemoving:Connect(function(player)
    if SelectedTargets[player.Name] then SelectedTargets[player.Name] = nil end
    RefreshPlayerList()
    UpdateStatus()
end)

RefreshPlayerList()
UpdateStatus()

-- ==================== УПРАВЛЕНИЕ ОКНОМ ====================
local isMinimized = false
MiniBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    Content.Visible = not isMinimized
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = isMinimized and UDim2.new(0, 420, 0, 38) or UDim2.new(0, 420, 0, 310)
    }):Play()
    MiniBtn.Text = isMinimized and "+" or "−"
end)

CloseBtn.MouseButton1Click:Connect(function()
    FlingActive = false
    main:Destroy()
end)

