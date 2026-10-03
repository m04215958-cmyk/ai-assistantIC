local Players = game:GetService("Players")
local player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

local STORAGE_FILE = "ai_assistant_activated.txt"
local CORRECT_KEY = "111"

local alreadyActivated = false

if isfile and isfile(STORAGE_FILE) then
    local saved = readfile(STORAGE_FILE)
    if saved == player.Name then
        alreadyActivated = true
    end
end

if alreadyActivated then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/m04215958-cmyk/ai-assistantIC/main/main.lua"))()
    return
end

local gui = Instance.new("ScreenGui")
gui.Name = "AIKeyPrompt"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = CoreGui

local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
bg.BackgroundTransparency = 1
bg.BorderSizePixel = 0
bg.Parent = gui

local box = Instance.new("Frame")
box.Size = UDim2.new(0, 0, 0, 0)
box.Position = UDim2.new(0.5, 0, 0.5, 0)
box.AnchorPoint = Vector2.new(0.5, 0.5)
box.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
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

local dustFrame = Instance.new("Frame")
dustFrame.Size = UDim2.new(1, 0, 1, 0)
dustFrame.BackgroundTransparency = 1
dustFrame.ClipsDescendants = true
dustFrame.Parent = box

local dustCanvas = Instance.new("Frame")
dustCanvas.Size = UDim2.new(1, 0, 1, 0)
dustCanvas.BackgroundTransparency = 1
dustCanvas.Parent = dustFrame

local dustParticles = {}
for i = 1, 40 do
    local p = Instance.new("Frame")
    p.Size = UDim2.new(0, math.random(1, 3), 0, math.random(1, 3))
    p.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    p.BackgroundTransparency = math.random(70, 90) / 100
    p.BorderSizePixel = 0
    p.Position = UDim2.new(math.random(), 0, math.random(), 0)
    p.Parent = dustCanvas

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = p

    table.insert(dustParticles, {
        frame = p,
        vx = (math.random() - 0.5) * 0.0005,
        vy = (math.random() - 0.5) * 0.0005
    })
end

task.spawn(function()
    while dustCanvas.Parent do
        for _, d in ipairs(dustParticles) do
            local pos = d.frame.Position
            local newX = pos.X.Scale + d.vx
            local newY = pos.Y.Scale + d.vy
            if newX < 0 or newX > 1 then d.vx = -d.vx end
            if newY < 0 or newY > 1 then d.vy = -d.vy end
            d.frame.Position = UDim2.new(newX, 0, newY, 0)
        end
        task.wait(0.03)
    end
end)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 40)
title.Position = UDim2.new(0, 20, 0, 30)
title.BackgroundTransparency = 1
title.Text = "Enter the key"
title.TextColor3 = Color3.fromRGB(150, 150, 150)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Center
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
textBox.TextXAlignment = Enum.TextXAlignment.Center
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

box.Size = UDim2.new(0, 0, 0, 0)
box.BackgroundTransparency = 1

local TweenService = game:GetService("TweenService")

local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

local openTween = TweenService:Create(box, tweenInfo, {
    Size = UDim2.new(0, 400, 0, 240)
})

openTween:Play()

task.wait(0.5)

local fadeTween = TweenService:Create(box, TweenInfo.new(0.3), {
    BackgroundTransparency = 0
})

fadeTween:Play()

local activated = false

activateBtn.MouseButton1Click:Connect(function()
    if activated then return end

    if textBox.Text == CORRECT_KEY then
        activated = true

        activateBtn.Text = "Loading..."
        activateBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        textBox.TextEditable = false

        if writefile then
            writefile(STORAGE_FILE, player.Name)
        end

        task.wait(1.5)

        local closeTween = TweenService:Create(box, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1
        })

        closeTween:Play()
        task.wait(0.4)

        gui:Destroy()

        loadstring(game:HttpGet("https://raw.githubusercontent.com/m04215958-cmyk/ai-scripts/main/main.lua"))()
    end
end)
