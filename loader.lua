local Players = game:GetService("Players")
local player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local CORRECT_KEY = "111"
local MAIN_URL = "https://raw.githubusercontent.com/m04215958-cmyk/ai-assistantIC/main/main.lua"

getgenv().AI_ACTIVATED = getgenv().AI_ACTIVATED or false

if getgenv().AI_ACTIVATED then
    loadstring(game:HttpGet(MAIN_URL .. "?t=" .. tick()))()
    return
end

local gui = Instance.new("ScreenGui")
gui.Name = "AIKeyPrompt"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = CoreGui

local box = Instance.new("Frame")
box.Size = UDim2.new(0, 0, 0, 0)
box.Position = UDim2.new(0.5, 0, 0.5, 0)
box.AnchorPoint = Vector2.new(0.5, 0.5)
box.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
box.BackgroundTransparency = 1
box.BorderSizePixel = 0
box.ClipsDescendants = true
box.Parent = gui

local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0, 18)
boxCorner.Parent = box

local rainbowStroke = Instance.new("UIStroke")
rainbowStroke.Thickness = 3
rainbowStroke.Color = Color3.fromRGB(255, 0, 0)
rainbowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
rainbowStroke.Parent = box

task.spawn(function()
    local hue = 0
    while rainbowStroke.Parent do
        hue = (hue + 0.008) % 1
        rainbowStroke.Color = Color3.fromHSV(hue, 1, 1)
        task.wait(0.03)
    end
end)

for i = 1, 40 do
    local p = Instance.new("Frame")
    p.Size = UDim2.new(0, math.random(1, 3), 0, math.random(1, 3))
    p.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    p.BackgroundTransparency = math.random(70, 90) / 100
    p.BorderSizePixel = 0
    p.Position = UDim2.new(math.random(), 0, math.random(), 0)
    p.Parent = box

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = p

    task.spawn(function()
        local vx = (math.random() - 0.5) * 0.0008
        local vy = (math.random() - 0.5) * 0.0008
        while p.Parent do
            local pos = p.Position
            local newX = pos.X.Scale + vx
            local newY = pos.Y.Scale + vy
            if newX < 0 or newX > 1 then vx = -vx end
            if newY < 0 or newY > 1 then vy = -vy end
            p.Position = UDim2.new(newX, 0, newY, 0)
            task.wait(0.03)
        end
    end)
end

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 40)
title.Position = UDim2.new(0, 20, 0, 30)
title.BackgroundTransparency = 1
title.Text = "Enter the key"
title.TextColor3 = Color3.fromRGB(150, 150, 150)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = box

local keyBox = Instance.new("Frame")
keyBox.Size = UDim2.new(1, -60, 0, 50)
keyBox.Position = UDim2.new(0, 30, 0, 90)
keyBox.BackgroundColor3 = Color3.fromRGB(15, 25, 60)
keyBox.BorderSizePixel = 0
keyBox.Parent = box

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 10)
keyCorner.Parent = keyBox

local keyStroke = Instance.new("UIStroke")
keyStroke.Thickness = 2
keyStroke.Color = Color3.fromRGB(50, 80, 160)
keyStroke.Parent = keyBox

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(1, -20, 1, 0)
textBox.Position = UDim2.new(0, 10, 0, 0)
textBox.BackgroundTransparency = 1
textBox.Text = ""
textBox.PlaceholderText = "here"
textBox.PlaceholderColor3 = Color3.fromRGB(60, 80, 140)
textBox.TextColor3 = Color3.fromRGB(200, 220, 255)
textBox.TextScaled = true
textBox.Font = Enum.Font.GothamBold
textBox.ClearTextOnFocus = false
textBox.Parent = keyBox

local activateBtn = Instance.new("TextButton")
activateBtn.Size = UDim2.new(1, -60, 0, 45)
activateBtn.Position = UDim2.new(0, 30, 0, 160)
activateBtn.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
activateBtn.BorderSizePixel = 0
activateBtn.Text = "Activate"
activateBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
activateBtn.TextScaled = true
activateBtn.Font = Enum.Font.GothamBold
activateBtn.Parent = box

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 10)
btnCorner.Parent = activateBtn

local openTween = TweenService:Create(box, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 400, 0, 240),
    BackgroundTransparency = 0
})
openTween:Play()

local activated = false

activateBtn.MouseButton1Click:Connect(function()
    if activated then return end

    if textBox.Text == CORRECT_KEY then
        activated = true
        activateBtn.Text = "Loading..."
        activateBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        textBox.TextEditable = false

        getgenv().AI_ACTIVATED = true

        task.wait(1.5)

        local closeTween = TweenService:Create(box, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1
        })
        closeTween:Play()
        task.wait(0.4)

        gui:Destroy()

        loadstring(game:HttpGet(MAIN_URL .. "?t=" .. tick()))()
    end
end)
