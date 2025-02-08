local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Create the GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

-- Background Frame (Make it sleek and modern)
local BackgroundFrame = Instance.new("Frame")
BackgroundFrame.Parent = ScreenGui
BackgroundFrame.Size = UDim2.new(0, 400, 0, 500)
BackgroundFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
BackgroundFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
BackgroundFrame.BackgroundTransparency = 0.85
BackgroundFrame.BorderSizePixel = 2
BackgroundFrame.BorderColor3 = Color3.fromRGB(50, 50, 255)  -- Soft blue border

-- Draggable GUI functionality
local dragToggle = nil
local dragInput = nil
local dragStart = nil
local startPos = nil

BackgroundFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragToggle = true
        dragStart = input.Position
        startPos = BackgroundFrame.Position
    end
end)

BackgroundFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragToggle then
        local delta = input.Position - dragStart
        BackgroundFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

BackgroundFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragToggle = false
    end
end)

-- Modern Text Label (Centered, simple, and sleek)
local TextLabel = Instance.new("TextLabel")
TextLabel.Parent = BackgroundFrame
TextLabel.Size = UDim2.new(0, 380, 0, 60)
TextLabel.Position = UDim2.new(0.5, -190, 0, 10)
TextLabel.Text = "Tuahei Hub | Blue Lock Rival"
TextLabel.TextSize = 32
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1
TextLabel.TextStrokeTransparency = 0.6
TextLabel.TextXAlignment = Enum.TextXAlignment.Center
TextLabel.Font = Enum.Font.GothamBold

-- NoClip Button
local NoClipButton = Instance.new("TextButton")
NoClipButton.Parent = BackgroundFrame
NoClipButton.Size = UDim2.new(0, 350, 0, 50)
NoClipButton.Position = UDim2.new(0.5, -175, 0, 80)
NoClipButton.Text = "NoClip: OFF"
NoClipButton.TextSize = 26
NoClipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
NoClipButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
NoClipButton.TextStrokeTransparency = 0.7
NoClipButton.BackgroundTransparency = 0.6
NoClipButton.Font = Enum.Font.Gotham

local noClipEnabled = false
NoClipButton.MouseButton1Click:Connect(function()
    noClipEnabled = not noClipEnabled
    if noClipEnabled then
        NoClipButton.Text = "NoClip: ON"
        NoClipButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        -- Enable NoClip here
        local character = Player.Character or Player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.PlatformStand = true
        character:WaitForChild("HumanoidRootPart").AncestryChanged:Connect(function()
            if not noClipEnabled then
                humanoid.PlatformStand = false
            end
        end)
    else
        NoClipButton.Text = "NoClip: OFF"
        NoClipButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        -- Disable NoClip here
        local character = Player.Character or Player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.PlatformStand = false
    end
end)

-- Teleport Button
local WarpButton = Instance.new("TextButton")
WarpButton.Parent = BackgroundFrame
WarpButton.Size = UDim2.new(0, 350, 0, 50)
WarpButton.Position = UDim2.new(0.5, -175, 0, 160)
WarpButton.Text = "Teleport to Players"
WarpButton.TextSize = 26
WarpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
WarpButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
WarpButton.TextStrokeTransparency = 0.7
WarpButton.BackgroundTransparency = 0.6
WarpButton.Font = Enum.Font.Gotham

WarpButton.MouseButton1Click:Connect(function()
    local players = game.Players:GetPlayers()
    for _, otherPlayer in pairs(players) do
        if otherPlayer ~= Player then
            -- Teleport to the first available player
            local character = otherPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                Player.Character:SetPrimaryPartCFrame(character.HumanoidRootPart.CFrame)
                break
            end
        end
    end
end)

-- Auto Dribble Button (Press Q to start automatic dribbling)
local AutoDribbleButton = Instance.new("TextButton")
AutoDribbleButton.Parent = BackgroundFrame
AutoDribbleButton.Size = UDim2.new(0, 350, 0, 50)
AutoDribbleButton.Position = UDim2.new(0.5, -175, 0, 240)
AutoDribbleButton.Text = "Auto Dribble: OFF"
AutoDribbleButton.TextSize = 26
AutoDribbleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoDribbleButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
AutoDribbleButton.TextStrokeTransparency = 0.7
AutoDribbleButton.BackgroundTransparency = 0.6
AutoDribbleButton.Font = Enum.Font.Gotham

local autoDribbleActive = false
AutoDribbleButton.MouseButton1Click:Connect(function()
    autoDribbleActive = not autoDribbleActive
    if autoDribbleActive then
        AutoDribbleButton.Text = "Auto Dribble: ON"
        AutoDribbleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
        -- Start automatic dribbling here (press Q to simulate dribbling)
        while autoDribbleActive do
            local character = Player.Character
            if character then
                local humanoid = character:FindFirstChild("Humanoid")
                if humanoid and humanoid.Health > 0 then
                    game:GetService("ReplicatedStorage"):WaitForChild("DribbleEvent"):FireServer()
                    wait(0.1) -- Press Q every 0.1 seconds
                end
            end
            wait(0.1)
        end
    else
        AutoDribbleButton.Text = "Auto Dribble: OFF"
        AutoDribbleButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    end
end)

-- Auto Slide Button (Press E to start automatic sliding)
local AutoSlideButton = Instance.new("TextButton")
AutoSlideButton.Parent = BackgroundFrame
AutoSlideButton.Size = UDim2.new(0, 350, 0, 50)
AutoSlideButton.Position = UDim2.new(0.5, -175, 0, 320)
AutoSlideButton.Text = "Auto Slide: OFF"
AutoSlideButton.TextSize = 26
AutoSlideButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoSlideButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
AutoSlideButton.TextStrokeTransparency = 0.7
AutoSlideButton.BackgroundTransparency = 0.6
AutoSlideButton.Font = Enum.Font.Gotham

local autoSlideActive = false
AutoSlideButton.MouseButton1Click:Connect(function()
    autoSlideActive = not autoSlideActive
    if autoSlideActive then
        AutoSlideButton.Text = "Auto Slide: ON"
        AutoSlideButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        -- Start automatic sliding here (press E to simulate sliding)
        while autoSlideActive do
            local character = Player.Character
            if character then
                local humanoid = character:FindFirstChild("Humanoid")
                if humanoid and humanoid.Health > 0 then
                    game:GetService("ReplicatedStorage"):WaitForChild("SlideEvent"):FireServer()
                    wait(0.1) -- Press E every 0.1 seconds
                end
            end
            wait(0.1)
        end
    else
        AutoSlideButton.Text = "Auto Slide: OFF"
        AutoSlideButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    end
end)

-- Add "X" Button for exiting the GUI
local ExitButton = Instance.new("TextButton")
ExitButton.Parent = BackgroundFrame
ExitButton.Size = UDim2.new(0, 50, 0, 50)
ExitButton.Position = UDim2.new(0.5, 170, 0, 10)
ExitButton.Text = "X"
ExitButton.TextSize = 26
ExitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ExitButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ExitButton.TextStrokeTransparency = 0.7
ExitButton.BackgroundTransparency = 0.6
ExitButton.Font = Enum.Font.Gotham

ExitButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy() -- Close the GUI when clicked
end)
