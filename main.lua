
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

if getgenv().AI_CHAT_LOADED then
    if getgenv().AI_CHAT_GUI then
        getgenv().AI_CHAT_GUI:Destroy()
    end
end
getgenv().AI_CHAT_LOADED = true

local gui = Instance.new("ScreenGui")
gui.Name = "AIChat"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = CoreGui

getgenv().AI_CHAT_GUI = gui

local mainBox = Instance.new("Frame")
mainBox.Size = UDim2.new(0, 0, 0, 0)
mainBox.Position = UDim2.new(0.5, 0, 0.5, 0)
mainBox.AnchorPoint = Vector2.new(0.5, 0.5)
mainBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainBox.BackgroundTransparency = 1
mainBox.BorderSizePixel = 0
mainBox.ClipsDescendants = true
mainBox.Parent = gui

local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0, 15)
boxCorner.Parent = mainBox

local boxStroke = Instance.new("UIStroke")
boxStroke.Thickness = 2
boxStroke.Color = Color3.fromRGB(120, 120, 120)
boxStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
boxStroke.Parent = mainBox

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 45)
header.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
header.BackgroundTransparency = 1
header.BorderSizePixel = 0
header.Parent = mainBox

local headerLabel = Instance.new("TextLabel")
headerLabel.Size = UDim2.new(1, -80, 1, 0)
headerLabel.Position = UDim2.new(0, 20, 0, 0)
headerLabel.BackgroundTransparency = 1
headerLabel.Text = "AI Assistant"
headerLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
headerLabel.TextScaled = true
headerLabel.Font = Enum.Font.GothamBold
headerLabel.TextXAlignment = Enum.TextXAlignment.Left
headerLabel.Parent = header

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -40, 0, 8)
closeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
closeBtn.BorderSizePixel = 0
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
    getgenv().AI_CHAT_LOADED = false
    getgenv().AI_CHAT_GUI = nil
end)

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -30, 1, -115)
scrollFrame.Position = UDim2.new(0, 15, 0, 55)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 4
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollFrame.Parent = mainBox

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 10)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = scrollFrame

local inputFrame = Instance.new("Frame")
inputFrame.Size = UDim2.new(1, -30, 0, 45)
inputFrame.Position = UDim2.new(0, 15, 1, -55)
inputFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
inputFrame.BorderSizePixel = 0
inputFrame.Parent = mainBox

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 10)
inputCorner.Parent = inputFrame

local inputStroke = Instance.new("UIStroke")
inputStroke.Thickness = 1
inputStroke.Color = Color3.fromRGB(80, 80, 80)
inputStroke.Parent = inputFrame

local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(1, -80, 1, 0)
inputBox.Position = UDim2.new(0, 15, 0, 0)
inputBox.BackgroundTransparency = 1
inputBox.Text = ""
inputBox.PlaceholderText = "Type a message..."
inputBox.PlaceholderColor3 = Color3.fromRGB(80, 80, 80)
inputBox.TextColor3 = Color3.fromRGB(220, 220, 220)
inputBox.TextScaled = true
inputBox.Font = Enum.Font.Gotham
inputBox.TextXAlignment = Enum.TextXAlignment.Left
inputBox.ClearTextOnFocus = false
inputBox.Parent = inputFrame

local sendBtn = Instance.new("TextButton")
sendBtn.Size = UDim2.new(0, 50, 1, -10)
sendBtn.Position = UDim2.new(1, -60, 0, 5)
sendBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
sendBtn.BorderSizePixel = 0
sendBtn.Text = "Send"
sendBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
sendBtn.TextScaled = true
sendBtn.Font = Enum.Font.GothamBold
sendBtn.Parent = inputFrame

local sendCorner = Instance.new("UICorner")
sendCorner.CornerRadius = UDim.new(0, 8)
sendCorner.Parent = sendBtn

local function addMessage(text, side)
    local msgFrame = Instance.new("Frame")
    msgFrame.BackgroundTransparency = 1
    msgFrame.Size = UDim2.new(1, 0, 0, 0)
    msgFrame.AutomaticSize = Enum.AutomaticSize.Y
    msgFrame.Parent = scrollFrame

    local msgLabel = Instance.new("TextLabel")
    msgLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    msgLabel.BorderSizePixel = 0
    msgLabel.Text = text
    msgLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    msgLabel.TextSize = 16
    msgLabel.Font = Enum.Font.Gotham
    msgLabel.TextWrapped = true
    msgLabel.TextXAlignment = Enum.TextXAlignment.Left
    msgLabel.TextYAlignment = Enum.TextYAlignment.Center
    msgLabel.AutomaticSize = Enum.AutomaticSize.Y
    msgLabel.Size = UDim2.new(0, 0, 0, 35)
    msgLabel.Position = UDim2.new(0, 0, 0, 0)
    msgLabel.Parent = msgFrame

    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 12)
    padding.PaddingRight = UDim.new(0, 12)
    padding.PaddingTop = UDim.new(0, 8)
    padding.PaddingBottom = UDim.new(0, 8)
    padding.Parent = msgLabel

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = msgLabel

    if side == "left" then
        msgLabel.AnchorPoint = Vector2.new(0, 0)
        msgLabel.Position = UDim2.new(0, 0, 0, 0)
        msgLabel.Size = UDim2.new(0.75, 0, 0, 35)
        msgLabel.TextColor3 = Color3.fromRGB(180, 220, 255)
    else
        msgLabel.AnchorPoint = Vector2.new(1, 0)
        msgLabel.Position = UDim2.new(1, 0, 0, 0)
        msgLabel.Size = UDim2.new(0.75, 0, 0, 35)
        msgLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
        msgLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end

    task.wait(0.05)
    scrollFrame.CanvasPosition = Vector2.new(0, scrollFrame.AbsoluteCanvasSize.Y)
end

local function getAIResponse(message)
    local msg = message:lower():gsub("[%s%p]+", "")
    
    if msg == "hello" or msg == "hi" or msg == "hey" then
        local responses = {
            "Hello! How can I help?",
            "Hi! How can I help?",
            "Yo bro! What's up? How can I help?",
            "Hello, player! How can I help you?",
            "Yes, yes. Hi! How can I help you today?",
            "Hi! How can I help today?",
            "Hey there, player! How can I help?",
            "Yo, player! Hi! How can I help you today?"
        }
        return responses[math.random(1, #responses)]
    end

    if msg == "help" then
        return "I can help with game info, scripts, noclip, and more. Just ask!"
    end

    return nil
end

local greeted = false

local function sendMessage()
    local text = inputBox.Text
    if text == "" then return end

    inputBox.Text = ""

    addMessage(text, "right")

    task.wait(0.4)

    local response = getAIResponse(text)

    if response then
        if greeted then
            response = "Huh? Well, hello. How can I help?"
        end
        greeted = true
        addMessage(response, "left")
    end
end

sendBtn.MouseButton1Click:Connect(sendMessage)

inputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        sendMessage()
    end
end)

local openTween = TweenService:Create(mainBox, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 500, 0, 450),
    BackgroundTransparency = 0
})
openTween:Play()
