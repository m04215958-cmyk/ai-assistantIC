local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

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

local responsesFirst = {
    "Hello! How can I help?",
    "Hi! How can I help?",
    "Yo bro! What's up? How can I help?",
    "Hello, player! How can I help you?",
    "Yes, yes. Hi! How can I help you today?",
    "Hi! How can I help today?",
    "Hey there, player! How can I help?",
    "Yo, player! Hi! How can I help you today?",
    "Hello there! What can I do for you?",
    "Hey! Great to see you. How can I help?",
    "Hiya! What can I assist you with?",
    "Hello friend! How may I help you today?",
    "Greetings! How can I be of service?",
    "Hey there! What brings you here?",
    "Hi! Ready to help. What do you need?",
    "Hello! I'm here to help. What's up?",
    "Hey! How's it going? Need anything?",
    "Hi there! How can I assist you?",
    "Hello! What's on your mind today?",
    "Hey hey! How can I help you out?",
    "Hi! At your service. What do you need?",
    "Hello! Ready when you are. How can I help?",
    "Yo! What's good? How can I help?",
    "Hey! Nice to see you. What can I do?",
    "Hello there, player! Need anything?",
    "Hi! What can I help you with today?",
    "Greetings, player! How can I assist?",
    "Hey! What's up? How can I help you?",
    "Hello! How are you doing today?",
    "Hi there! Ready to help. What's up?",
    "Hey! Good to see you. How can I help?",
    "Hello! What can I do for you today?",
    "Hi! How's everything? Need help?",
    "Hey there! What brings you to me?",
    "Hello, my friend! How can I help you?",
    "Hiya! What do you need help with?",
    "Hey! Welcome. How can I assist you?",
    "Hello! I'm all ears. What's up?",
    "Hi there! How can I be useful today?",
    "Hey! What can I do for you, player?",
    "Hello! Nice to meet you. Need help?",
    "Hi! How are you? What can I help with?",
    "Hey! Ready for anything. What's up?",
    "Hello there! How can I help today?",
    "Hi! What can I do for you, friend?",
    "Hey! How can I make your day better?",
    "Hello! What do you need assistance with?",
    "Hi there! How's your day going?",
    "Hey! Let's get started. What's up?",
    "Hello! Ready to help. What do you need?",
    "Hi! What can I help you with, player?",
    "Hey! Great timing. How can I help?",
    "Hello there! How may I be of service?",
    "Hi! What's going on? Need any help?",
    "Hey! What's new? How can I assist?",
    "Hello! How's everything? What's up?",
    "Hi there! What can I do for you today?",
    "Hey! Need something? I'm here to help.",
    "Hello! What brings you here today?",
    "Hi! How can I be helpful to you?",
    "Hey there! What can I help you with?",
    "Hello! Ready to assist. What's up?",
    "Hi! What do you need help with today?",
    "Hey! Good to have you here. Need help?",
    "Hello! I'm ready. How can I help?",
    "Hi there! What's on your mind?",
    "Hey! What can I do for you?",
    "Hello! How can I make things easier?",
    "Hi! Need a hand? What's up?",
    "Hey! What's going on? How can I help?",
    "Hello there! Ready when you are.",
    "Hi! What can I help you with?",
    "Hey! How's everything going?",
    "Hello! What do you need today?",
    "Hi there! How can I be of help?",
    "Hey! Ready to serve. What's up?",
    "Hello! Need assistance? I'm here.",
    "Hi! What brings you to me today?",
    "Hey! How can I make your day better?",
    "Hello! I'm all set. What do you need?",
    "Hi! What's up, player? Need help?",
    "Hey there! How can I assist you today?",
    "Hello! What can I do for you, friend?",
    "Hi! How's it going? Need anything?",
    "Hey! What can I help with, player?",
    "Hello there! Ready to help you.",
    "Hi! What do you need help with?",
    "Hey! How are you? What can I do?",
    "Hello! Let's get to it. What's up?",
    "Hi there! How can I help today?",
    "Hey! What's happening? Need help?",
    "Hello! How may I assist you today?",
    "Hi! What can I do for you now?",
    "Hey there! What brings you here?",
    "Hello! Ready to help. What's up?",
    "Hi! What's on your mind, player?",
    "Hey! How can I be helpful today?",
    "Hello! Need something? Just ask.",
    "Hi there! What do you need today?",
    "Hey! How's your day going so far?",
    "Hello! What can I help you with?",
    "Hi! Ready when you are. What's up?",
    "Hey there! Need a hand with anything?",
    "Hello! What's going on, player?",
    "Hi! How can I assist you today?",
    "Hey! What do you need help with?",
    "Hello there! How's everything?",
    "Hi! What can I do to help you?",
    "Hey! Ready to assist. What's up?",
    "Hello! What brings you my way?",
    "Hi there! Need any assistance?",
    "Hey! How can I make this easier?",
    "Hello! What can I help with today?",
    "Hi! What's new, player? Need help?",
    "Hey there! How's it going today?",
    "Hello! Ready to be useful. What's up?",
    "Hi! What do you need from me?",
    "Hey! How can I help you right now?",
    "Hello there! What's on your mind?",
    "Hi! Need help with something?",
    "Hey! What can I do for you today?",
    "Hello! How can I be of service?",
    "Hi there! What's going on?",
    "Hey! Ready to help. What do you need?",
    "Hello! What can I assist you with?",
    "Hi! How's everything? Need anything?",
    "Hey there! What brings you here today?",
    "Hello! Let's work together. What's up?",
    "Hi! What can I help you with now?",
    "Hey! Good to see you. What's new?",
    "Hello there! Ready to assist you.",
    "Hi! What do you need help with today?",
    "Hey! How can I make your day better?",
    "Hello! What's up, player? Need help?",
    "Hi there! How can I be useful?",
    "Hey! What can I do for you, friend?",
    "Hello! Ready when you are. Need help?",
    "Hi! What's on your mind today?",
    "Hey there! How can I help you out?",
    "Hello! What do you need assistance with?",
    "Hi! How can I be of help today?",
    "Hey! What's going on, player?",
    "Hello there! Ready to serve. What's up?",
    "Hi! Need a hand with anything?",
    "Hey! How can I assist you right now?",
    "Hello! What can I do for you today?",
    "Hi there! What brings you to me?",
    "Hey! Ready to help you out. What's up?",
    "Hello! How's everything going?",
    "Hi! What do you need help with now?",
    "Hey there! How can I be helpful?",
    "Hello! What's on your mind, friend?",
    "Hi! Ready to assist. What do you need?",
    "Hey! What can I help you with today?",
    "Hello there! How's it going?",
    "Hi! What can I do to assist you?",
    "Hey! Need anything? I'm here to help.",
    "Hello! What brings you here, player?",
    "Hi there! How can I help you now?",
    "Hey! Ready when you are. What's up?",
    "Hello! What do you need help with?",
    "Hi! How can I make things better?",
    "Hey there! What's new with you?",
    "Hello! Ready to help. What do you need?",
    "Hi! What can I assist you with today?",
    "Hey! How's everything, player?",
    "Hello there! What can I do for you?",
    "Hi! Need any help right now?",
    "Hey! How can I be useful to you?",
    "Hello! What's going on today?",
    "Hi there! Ready to serve. What's up?",
    "Hey! What can I help you with, friend?",
    "Hello! How's your day going, player?",
    "Hi! What do you need from me today?",
    "Hey there! Ready to assist you. What's up?",
    "Hello! What can I do for you now?",
    "Hi! How can I help you out today?",
    "Hey! What's on your mind, player?",
    "Hello there! Need any assistance?",
    "Hi! Ready when you are. What do you need?",
    "Hey! How can I assist you today?",
    "Hello! What brings you to me today?",
    "Hi there! What can I help with?",
    "Hey! Ready to be helpful. What's up?",
    "Hello! How's it going, friend?",
    "Hi! What do you need help with today?",
    "Hey there! How can I make this easier?",
    "Hello! What's up, player? Need anything?",
    "Hi! Ready to assist. What do you need?",
    "Hey! What can I do for you now?",
    "Hello there! How's everything today?",
    "Hi! Need help with something?",
    "Hey! What's new, player? How can I help?",
    "Hello! Ready to help you. What's up?",
    "Hi there! What can I do for you?",
    "Hey! How can I be of service today?",
    "Hello! What do you need assistance with?",
    "Hi! What's on your mind right now?",
    "Hey there! Ready to serve. What's up?",
    "Hello! How can I help you today, player?",
    "Hi! What can I assist you with?",
    "Hey! Ready to help. What do you need?",
    "Hello there! What's going on, friend?",
    "Hi! How can I be useful today?",
    "Hey! What can I do for you, player?",
    "Hello! Ready when you are. Need help?",
    "Hi there! What do you need today?",
    "Hey! How's everything going, player?",
    "Hello! What can I help you with now?"
}

local responsesSecond = {
    "Huh? Well, hello. How can I help?",
    "Oh, hi again! How can I help?",
    "Hello again! What do you need?",
    "Back so soon? Hi! How can I help?",
    "Hey again! What's up?",
    "Oh, it's you again. Hi! Need help?",
    "Well, hello there. Again. How can I help?",
    "Hi again, player! What do you need?",
    "You're back! Hello. How can I help?",
    "Oh! Hi again. What can I do for you?",
    "Hello, hello. Again. What's up?",
    "Hey, you again! How can I help?",
    "Well, look who's back. Hi!",
    "Oh, hello again. What's new?",
    "Hi again! Need something else?",
    "Back again? Hello! How can I help?",
    "Oh, you're back. Hi there!",
    "Well, hi again. What can I do?",
    "Hello once more! How can I help?",
    "Hey, welcome back! What's up?",
    "Oh, hi! Again. How can I help?",
    "Well well, hi again. Need help?",
    "Hello again, friend! What's up?",
    "Oh, you again. Hi! How can I help?",
    "Back already? Hi! What's up?",
    "Hi again! What brings you back?",
    "Well, hello again, player. How can I help?",
    "Oh hi! You're back. What do you need?",
    "Hey again! How can I be useful?",
    "Hello once again! How can I help?",
    "Oh, hey there. Again. What's up?",
    "Back so soon? Hello! Need help?",
    "Hi again! What can I do for you?",
    "Well, hi there again. Need anything?",
    "Oh, hello. Again. How can I help?",
    "Hey, you're back! What can I do?",
    "Hello again! Ready to help. What's up?",
    "Oh, hi again! What do you need now?",
    "Well, well. Hi again. How can I help?",
    "Back again, huh? Hi! What's up?",
    "Oh, hello again, player. Need help?",
    "Hey again! What's on your mind?",
    "Hi once more! How can I assist?",
    "Well, hello again. What can I do?",
    "Oh, you again! Hi. How can I help?",
    "Back again? Hello there! What's up?",
    "Hi again, friend! Need anything?",
    "Well, look who's back again. Hi!",
    "Oh, hi! Again. What can I help with?",
    "Hello once more, player! What's up?",
    "Hey, back again? Hi! Need help?",
    "Oh, hello again! What do you need?",
    "Well, hi again. What can I do for you?",
    "Back so soon? Hello! How can I help?",
    "Hi again! What's going on?",
    "Oh, you're back! Hello. Need help?",
    "Well, hello again. How's it going?",
    "Hey again, player! What can I do?",
    "Oh, hi once more! How can I help?",
    "Back again, huh? Hello! What's up?",
    "Hi again! What brings you here now?",
    "Well, hello again, friend. What's up?",
    "Oh, you again! Hi. What do you need?",
    "Hello again! How can I be useful?",
    "Hey, you're back! What's new?",
    "Oh, hi again! Need something else?",
    "Well, well, well. Hi again. What's up?",
    "Back again? Hello, player! Need help?",
    "Hi again! What can I help with today?",
    "Oh, hello once more. What's up?",
    "Hey again! Ready to help. What's up?",
    "Well, hi again! What do you need now?",
    "Back so soon? Hello there! What's up?",
    "Hi again, player! How can I help?",
    "Oh, you're back again! Hi! Need help?",
    "Well, hello once more. What can I do?",
    "Hey again! How's everything?",
    "Oh, hi! Again. What brings you back?",
    "Hello again, friend! What can I do?",
    "Back again, huh? Hi there! Need help?",
    "Oh, hello again! Ready to assist?",
    "Well, hi again, player. What's up?",
    "Hey, back so soon? Hi! Need help?",
    "Hi once more! What do you need?",
    "Oh, you again! Hello. How can I help?",
    "Well, well. Hi again. What's new?",
    "Back again? Hello, friend! What's up?",
    "Oh, hi again! What can I do for you?",
    "Hello once more, player! Need help?",
    "Hey again! What's going on today?",
    "Oh, you're back! Hi. What do you need?",
    "Well, hi again. Ready to help. What's up?",
    "Back so soon, huh? Hello! Need help?",
    "Hi again! How can I assist you now?",
    "Oh, hello again! What's on your mind?",
    "Well, look who's back. Hi! What's up?",
    "Hey again, player! Need anything?",
    "Oh, hi once more! How can I help?",
    "Back again? Hello there. What's up?",
    "Hi again! What can I do for you now?",
    "Well, hello again. How's it going today?",
    "Oh, you again! Hi there. Need help?",
    "Hello again, player! Ready to assist?",
    "Hey, back again? Hi! What's up?",
    "Oh, hi again. What do you need help with?",
    "Well, well. Hi again, friend. What's up?",
    "Back already? Hello! How can I help?",
    "Hi again! What brings you back today?",
    "Oh, hello once more! Need something?",
    "Well, hi again, player. What can I do?",
    "Hey, you're back! Hi! How can I help?",
    "Oh, you again! Hi. What's going on?",
    "Back so soon? Hello, player! Need help?",
    "Hi once more, friend! What's up?",
    "Oh, hi again! How can I be useful today?",
    "Well, hello again. What brings you here?",
    "Hey again! Ready when you are. What's up?",
    "Oh, you're back! Hi there. Need anything?",
    "Back again, huh? Hello, friend! What's up?",
    "Hi again! What can I help you with now?",
    "Well, hi again. How can I assist you?",
    "Oh, hello once more, player! What's up?",
    "Hey, back so soon? Hi! Need any help?",
    "Oh, you again! Hello there. What's up?",
    "Well, well, hi again. What do you need?",
    "Back again? Hello, player! How can I help?",
    "Hi once more! What's on your mind today?",
    "Oh, hi again! Ready to help. What's up?",
    "Well, hello once more. How's everything?",
    "Hey, you're back again! Hi! Need help?",
    "Oh, you again! Hi there. What can I do?",
    "Back so soon? Hello! What's going on?",
    "Hi again, friend! How can I help you?",
    "Oh, hello again! What can I assist with?",
    "Well, hi again, player. What's new with you?",
    "Hey again! What brings you back so soon?",
    "Oh, you're back! Hi. Need anything else?",
    "Back again, huh? Hello! How can I help?",
    "Hi once more, player! What do you need?",
    "Well, hello again. Ready to assist. What's up?",
    "Oh, hi again! What can I do for you now?",
    "Hey, back again? Hello there! Need help?",
    "Well, well. Hi again, friend. What's going on?",
    "Oh, you again! Hi. How can I be useful?",
    "Back so soon? Hello, player! What's up?",
    "Hi again! How's everything going today?",
    "Well, hello once more. What can I help with?",
    "Oh, hi again, player! Need any help?",
    "Hey, you're back! Hi there. What's new?",
    "Oh, you again! Hello, friend. What's up?",
    "Back again? Hi! Ready to help. What do you need?",
    "Hi once more! What brings you here now?",
    "Well, hi again. What can I do for you today?",
    "Oh, hello again! Ready when you are.",
    "Hey, back so soon? Hi! What's going on?"
}

local responsesAnnoyed = {
    "Okay, you've said hello quite a few times now. Everything alright?",
    "Hello again. And again. And again. What's going on?",
    "Are you okay? That's a lot of hellos...",
    "You know I can hear you, right? No need to keep saying hi.",
    "Should I be concerned?",
    "Bro. Hello. Again. What do you actually need?",
    "I'm starting to think you don't have anything else to say.",
    "Hi. Yeah. I get it. What do you want?",
    "Okay okay, I'm here. Stop saying hello.",
    "You've said hello a lot. I'm still here. What's up?",
    "Testing if I'm still alive? I am. Hi.",
    "Hello to you too. Again.",
    "Is this a hello competition? Because I'm losing count.",
    "Yes, I exist. No, you don't need to keep checking.",
    "Okay, I'm officially concerned. Why so many hellos?",
    "Hello. Is something wrong?",
    "You good, bro? That's a lot of hellos.",
    "Hi. Again. What's happening?",
    "Okay, you're clearly bored. What do you need?",
    "I'm going to start charging for each hello.",
    "Dude, I'm right here. Stop saying hello.",
    "Is this some kind of test? I passed it already.",
    "Hello. Yes. Hi. What. Do. You. Need.",
    "Okay you've said hello a bunch of times. Should I call someone?",
    "Hey. Enough with the hellos. Tell me what you need.",
    "Hi again. I'm still waiting for an actual question.",
    "You're really committed to this hello thing, huh?",
    "Hello. What can I do for you? Actually?",
    "I think you might be stuck. Blink twice if you need help.",
    "Hi. Are you alright? For real this time?",
    "Okay, this is getting weird. What do you want?",
    "Hello. Yes. I'm here. Please, anything else?",
    "Are you testing my patience? Because it's working.",
    "Hi again. No, seriously, what's going on?",
    "You've said hello many times. I'm starting to worry.",
    "Hello. Yes. Me again. What is it?",
    "Is your keyboard stuck on 'hi'? Need help?",
    "Okay, I get it. I'm helpful. Can we move on?",
    "Hi. Please. Anything. Ask me something.",
    "Hello there. Again. And again. What do you need?",
    "I'm beginning to think you're just messing with me.",
    "Hi. Still here. Still waiting. What's up?",
    "Okay, I'm going to ignore the next hello. Just so you know.",
    "Hello. Fine. What do you actually want?",
    "You've said hello more times than I can count.",
    "Hey. Are you okay? Do you need a break?",
    "Hi again. I'm going to assume you're just bored.",
    "Okay this is getting old. What's up?",
    "Hello. I exist. Now what?",
    "You really like saying hello, don't you?",
    "Hi. Yes. I'm here. What do you need? Seriously.",
    "I'm starting to think you're not going to stop.",
    "Hello again. Should I be worried?",
    "Okay, you've won the hello game. What now?",
    "Hi. Please ask me something. Anything.",
    "You're the most polite person I've ever met. Too polite.",
    "Hello. I'm still counting. What's up?",
    "Okay, I'm officially concerned about your mental state.",
    "Hi again. Do you need a hug or something?",
    "You've said hello so many times I lost count.",
    "Hello. Please. I'm begging you. Something else.",
    "Is this a glitch? Are you a bot?",
    "Hi. Yes. Hi. Yes. Hi. Yes. What. Do. You. Want.",
    "Okay, I'm going to mute myself if you keep this up.",
    "Hello. I think you might be stuck in a loop.",
    "Hi again. What's going on?",
    "You've said hello more than any human should.",
    "Okay, this is ridiculous. What do you need?",
    "Hi. Please, I'm here to help, not to hear hello forever.",
    "Hello. Yes. I'm. Still. Here. Now what?",
    "I'm going to start responding with only emojis.",
    "Hi again. I'm concerned. Are you okay?",
    "You've officially broken the hello record.",
    "Hello. Please. Just. Ask. Me. Something.",
    "Okay, I'm starting to think you're doing this on purpose.",
    "Hi. Yes. Hi. Please stop. What do you need?",
    "You've said hello a whole lot. I'm calling the police.",
    "Hello again. I'm still here. Still waiting.",
    "Is your enter key broken? Or are you just bored?",
    "Hi. I'm going to count to three and then ignore you.",
    "Okay. Enough. What do you actually need?",
    "Hello. I'm here. I've always been here. Now what?",
    "You know there's more to say than hello, right?",
    "Hi again. Let me guess — you're going to say hello again?",
    "Okay, I'm not mad, I'm just disappointed. What do you need?",
    "Hello. And I mean this kindly. Please. Something else.",
    "You've said hello more than I've said anything else.",
    "Hi. Yes. Cool. What else?",
    "Alright, this is getting repetitive. What's up?",
    "Hello. Please. My circuits are overheating from all these hellos.",
    "You've said hello so much I'm starting to like it. What's up?",
    "Hi again. Do you want to talk about something else?",
    "Okay, I'm all ears. Literally. What do you need?",
    "Hello. Yes. I hear you. Now please, something else.",
    "You're really into this greeting thing. What's up?",
    "Hi. Please. I'll do anything. Just say something else.",
    "Okay, I'm going to assume you're just testing me now.",
    "Hello again. I'm still waiting for a real question.",
    "You've said hello a lot. Can we talk about something else?",
    "Hi. I'm going to start giving random answers if you keep this up.",
    "Okay, you clearly like saying hello. Cool. Now what?"
}

local function getAIResponse(message)
    local msg = message:lower():gsub("[%s%p]+", "")

    if msg == "help" then
        return "I can help with game info, scripts, noclip, and more. Just ask!"
    end

    return nil
end

local greetCount = 0

local function sendMessage()
    local text = inputBox.Text
    if text == "" then return end

    inputBox.Text = ""

    addMessage(text, "right")

    task.wait(0.4)

    local msg = text:lower():gsub("[%s%p]+", "")
    local isGreeting = (msg == "hello" or msg == "hi" or msg == "hey")

    if isGreeting then
        greetCount = greetCount + 1

        if greetCount == 1 then
            addMessage(responsesFirst[math.random(1, #responsesFirst)], "left")
        elseif greetCount <= 5 then
            addMessage(responsesSecond[math.random(1, #responsesSecond)], "left")
        else
            addMessage(responsesAnnoyed[math.random(1, #responsesAnnoyed)], "left")
        end
    else
        local response = getAIResponse(text)
        if response then
            addMessage(response, "left")
        end
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
