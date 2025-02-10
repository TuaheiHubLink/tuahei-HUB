--// Main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
game:GetService("GuiService"):AddSelectionParent("PersistentGUI", ScreenGui)

--// Main Frame (Draggable)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

--// UICorner for rounded corners on MainFrame
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 16)
UICorner.Parent = MainFrame

--// Text Label (Title)
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "tuahei Hub | Free"
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Parent = MainFrame

--// Toggle Button
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0.8, 0, 0.08, 0)
ToggleButton.Position = UDim2.new(0.1, 0, 0.2, 0)
ToggleButton.Text = "Enable Teleport"
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Parent = MainFrame

--// State Variable to Track Button Color and Activation
local isEnabled = false

--// Function to Toggle Button Color and State
ToggleButton.MouseButton1Click:Connect(function()
    isEnabled = not isEnabled
    if isEnabled then
        ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Red when enabled
        ToggleButton.Text = "Disable Teleport"
    else
        ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255) -- Default color when disabled
        ToggleButton.Text = "Enable Teleport"
    end
end)

--// Function to Handle Teleportation on Click (No Ctrl)
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        if isEnabled then
            local mousePos = game:GetService("Players").LocalPlayer:GetMouse().Hit.p
            local character = game.Players.LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                character.HumanoidRootPart.CFrame = CFrame.new(mousePos)
            end
        end
    end
end)

--// Close Button (with Confirmation)
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -50, 0, 5)
CloseButton.Text = "X"
CloseButton.TextSize = 20
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.AutoButtonColor = false
CloseButton.Parent = MainFrame

--// UICorner for Close Button
local UICornerCloseButton = Instance.new("UICorner")
UICornerCloseButton.CornerRadius = UDim.new(0, 12)
UICornerCloseButton.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

--// Version Label
local VersionLabel = Instance.new("TextLabel")
VersionLabel.Size = UDim2.new(1, 0, 0, 20)
VersionLabel.Position = UDim2.new(0, 0, 1, 5) -- Position at the bottom of MainFrame
VersionLabel.BackgroundTransparency = 1
VersionLabel.Text = "version 0.00.2"
VersionLabel.TextSize = 14
VersionLabel.Font = Enum.Font.GothamBold
VersionLabel.TextColor3 = Color3.fromRGB(255, 50, 50) -- Red color
VersionLabel.Parent = MainFrame

--// Speed Input
local SpeedInput = Instance.new("TextBox")
SpeedInput.Size = UDim2.new(0.8, 0, 0.08, 0)
SpeedInput.Position = UDim2.new(0.1, 0, 0.15, 0)
SpeedInput.PlaceholderText = "Enter Speed"
SpeedInput.TextColor3 = Color3.fromRGB(255, 50, 50)
SpeedInput.Parent = MainFrame

--// Speed Button
local SpeedButton = Instance.new("TextButton")
SpeedButton.Size = UDim2.new(0.8, 0, 0.08, 0)
SpeedButton.Position = UDim2.new(0.1, 0, 0.25, 0)
SpeedButton.Text = "Set Speed"
SpeedButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
SpeedButton.Parent = MainFrame

SpeedButton.MouseButton1Click:Connect(function()
    local speed = tonumber(SpeedInput.Text)
    if speed and speed > 0 then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed
    end
end)

--// NoClip Button
local NoClipButton = Instance.new("TextButton")
NoClipButton.Size = UDim2.new(0.8, 0, 0.08, 0)
NoClipButton.Position = UDim2.new(0.1, 0, 0.35, 0)
NoClipButton.Text = "NoClip"
NoClipButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
NoClipButton.Parent = MainFrame

local noclip = false
game:GetService("RunService").Stepped:Connect(function()
    if noclip then
        for _, part in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    else
        for _, part in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end)

NoClipButton.MouseButton1Click:Connect(function()
    noclip = not noclip
    if noclip then
        NoClipButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        NoClipButton.Text = "NoClip ON"
    else
        NoClipButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
        NoClipButton.Text = "NoClip"
    end
end)

--// TP to Nearest Player
local TPButton = Instance.new("TextButton")
TPButton.Size = UDim2.new(0.8, 0, 0.08, 0)
TPButton.Position = UDim2.new(0.1, 0, 0.45, 0)
TPButton.Text = "TP to Nearest Player"
TPButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
TPButton.Parent = MainFrame

TPButton.MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local nearestPlayer, minDistance = nil, math.huge
        for _, otherPlayer in pairs(game.Players:GetPlayers()) do
            if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local distance = (char.HumanoidRootPart.Position - otherPlayer.Character.HumanoidRootPart.Position).Magnitude
                if distance < minDistance then
                    nearestPlayer = otherPlayer
                    minDistance = distance
                end
            end
        end
        if nearestPlayer then
            char.HumanoidRootPart.CFrame = nearestPlayer.Character.HumanoidRootPart.CFrame
        end
    end
end)
