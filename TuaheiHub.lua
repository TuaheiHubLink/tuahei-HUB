local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Create the GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

-- Background Frame
local BackgroundFrame = Instance.new("Frame")
BackgroundFrame.Parent = ScreenGui
BackgroundFrame.Size = UDim2.new(0, 300, 0, 400)
BackgroundFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
BackgroundFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
BackgroundFrame.BackgroundTransparency = 0.8
BackgroundFrame.BorderSizePixel = 2
BackgroundFrame.BorderColor3 = Color3.fromRGB(0, 170, 255)

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

-- Rainbow Gradient Label (Tuahei Hub)
local TextLabel = Instance.new("TextLabel")
TextLabel.Parent = BackgroundFrame
TextLabel.Size = UDim2.new(0, 280, 0, 50)
TextLabel.Position = UDim2.new(0.5, -140, 0, 10)
TextLabel.Text = "Tuahei Hub | Blue Lock Rival"
TextLabel.TextSize = 30
TextLabel.TextStrokeTransparency = 0.8
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1
TextLabel.TextStrokeTransparency = 0.5
TextLabel.TextXAlignment = Enum.TextXAlignment.Center

-- Rainbow effect for label
local function setRainbow()
    local rainbowColors = {Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 165, 0), Color3.fromRGB(255, 255, 0), 
                           Color3.fromRGB(0, 255, 0), Color3.fromRGB(0, 0, 255), Color3.fromRGB(75, 0, 130), 
                           Color3.fromRGB(238, 130, 238)}

    local i = 1
    while true do
        TextLabel.TextColor3 = rainbowColors[i]
        i = i + 1
        if i > #rainbowColors then
            i = 1
        end
        wait(0.1)
    end
end

-- Run the rainbow effect in a separate thread
coroutine.wrap(setRainbow)()

-- Create NoClip Toggle Button
local NoClipButton = Instance.new("TextButton")
NoClipButton.Parent = BackgroundFrame
NoClipButton.Size = UDim2.new(0, 250, 0, 40)
NoClipButton.Position = UDim2.new(0.5, -125, 0, 70)
NoClipButton.Text = "NoClip: OFF"
NoClipButton.TextSize = 24
NoClipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
NoClipButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
NoClipButton.TextStrokeTransparency = 0.5
NoClipButton.BackgroundTransparency = 0.5

local noClipEnabled = false
NoClipButton.MouseButton1Click:Connect(function()
    noClipEnabled = not noClipEnabled
    if noClipEnabled then
        NoClipButton.Text = "NoClip: ON"
        NoClipButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        -- Enable NoClip here
        -- For example: Player.Character.HumanoidRootPart.CanCollide = false
    else
        NoClipButton.Text = "NoClip: OFF"
        NoClipButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        -- Disable NoClip here
        -- For example: Player.Character.HumanoidRootPart.CanCollide = true
    end
end)

-- Create Player Warp Button
local WarpButton = Instance.new("TextButton")
WarpButton.Parent = BackgroundFrame
WarpButton.Size = UDim2.new(0, 250, 0, 40)
WarpButton.Position = UDim2.new(0.5, -125, 0, 120)
WarpButton.Text = "Warp to Players"
WarpButton.TextSize = 24
WarpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
WarpButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
WarpButton.TextStrokeTransparency = 0.5
WarpButton.BackgroundTransparency = 0.5

local warpActive = false
local warpConnection
WarpButton.MouseButton1Click:Connect(function()
    warpActive = not warpActive
    if warpActive then
        WarpButton.Text = "Warping Active"
        WarpButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

        warpConnection = game:GetService("RunService").Heartbeat:Connect(function()
            local closestPlayer = nil
            local shortestDistance = math.huge

            -- Find the closest player
            for _, otherPlayer in pairs(game.Players:GetPlayers()) do
                if otherPlayer ~= Player then
                    local character = otherPlayer.Character
                    if character then
                        local torso = character:FindFirstChild("HumanoidRootPart")
                        if torso then
                            local distance = (Player.Character.HumanoidRootPart.Position - torso.Position).Magnitude
                            if distance < shortestDistance then
                                closestPlayer = torso
                                shortestDistance = distance
                            end
                        end
                    end
                end
            end

            -- Warp to the closest player’s HumanoidRootPart (Torso)
            if closestPlayer then
                Player.Character:SetPrimaryPartCFrame(closestPlayer.CFrame + Vector3.new(0, 3, 5)) -- Warp 5 studs ahead
            end
        end)
    else
        WarpButton.Text = "Warp to Players"
        WarpButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        if warpConnection then
            warpConnection:Disconnect()
        end
    end
end)

-- Create Close Button (X) at the top right
local CloseButton = Instance.new("TextButton")
CloseButton.Parent = BackgroundFrame
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -50, 0, 10)
CloseButton.Text = "X"
CloseButton.TextSize = 24
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.TextStrokeTransparency = 0.5
CloseButton.BackgroundTransparency = 0.5

CloseButton.MouseButton1Click:Connect(function()
    -- Show confirmation prompt to exit
    local confirmationPrompt = Instance.new("TextLabel")
    confirmationPrompt.Parent = ScreenGui
    confirmationPrompt.Size = UDim2.new(0, 200, 0, 50)
    confirmationPrompt.Position = UDim2.new(0.5, -100, 0.5, -50)
    confirmationPrompt.Text = "Are you sure you want to exit Tuahei Script?"
    confirmationPrompt.TextSize = 18
    confirmationPrompt.TextColor3 = Color3.fromRGB(255, 255, 255)
    confirmationPrompt.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    confirmationPrompt.TextStrokeTransparency = 0.5
    confirmationPrompt.TextXAlignment = Enum.TextXAlignment.Center

    local confirmButton = Instance.new("TextButton")
    confirmButton.Parent = ScreenGui
    confirmButton.Size = UDim2.new(0, 80, 0, 40)
    confirmButton.Position = UDim2.new(0.5, -100, 0.5, 10)
    confirmButton.Text = "Confirm"
    confirmButton.TextSize = 20
    confirmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    confirmButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

    local cancelButton = Instance.new("TextButton")
    cancelButton.Parent = ScreenGui
    cancelButton.Size = UDim2.new(0, 80, 0, 40)
    cancelButton.Position = UDim2.new(0.5, 20, 0.5, 10)
    cancelButton.Text = "Cancel"
    cancelButton.TextSize = 20
    cancelButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    cancelButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

    confirmButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    cancelButton.MouseButton1Click:Connect(function()
        confirmationPrompt:Destroy()
        confirmButton:Destroy()
        cancelButton:Destroy()
    end)
end)
