--// Main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

--// Main Frame (Draggable)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

--// Text Label (Title)
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "tuahei Hub | Free"
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Parent = MainFrame

--// Close Button (with Confirmation)
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -50, 0, 5)
CloseButton.Text = "X"
CloseButton.TextSize = 20
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.Parent = MainFrame

CloseButton.MouseButton1Click:Connect(function()
    local ConfirmFrame = Instance.new("Frame", ScreenGui)
    ConfirmFrame.Size = UDim2.new(0.3, 0, 0.2, 0)
    ConfirmFrame.Position = UDim2.new(0.35, 0, 0.4, 0)
    ConfirmFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    
    local ConfirmText = Instance.new("TextLabel", ConfirmFrame)
    ConfirmText.Size = UDim2.new(1, 0, 0.5, 0)
    ConfirmText.Text = "Are you sure?"
    ConfirmText.TextColor3 = Color3.fromRGB(255, 50, 50)
    ConfirmText.BackgroundTransparency = 1
    
    local ConfirmButton = Instance.new("TextButton", ConfirmFrame)
    ConfirmButton.Size = UDim2.new(0.5, 0, 0.5, 0)
    ConfirmButton.Position = UDim2.new(0.25, 0, 0.5, 0)
    ConfirmButton.Text = "Confirm"
    ConfirmButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    
    ConfirmButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    wait(2)
    ConfirmFrame:Destroy()
end)

--// Speed Input
local SpeedInput = Instance.new("TextBox")
SpeedInput.Size = UDim2.new(0.8, 0, 0.08, 0)
SpeedInput.Position = UDim2.new(0.1, 0, 0.15, 0)
SpeedInput.PlaceholderText = "Enter Speed"
SpeedInput.TextColor3 = Color3.fromRGB(255, 50, 50)
SpeedInput.Parent = MainFrame

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
    end
end)

NoClipButton.MouseButton1Click:Connect(function()
    noclip = not noclip
    NoClipButton.BackgroundColor3 = noclip and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 120, 255)
    NoClipButton.Text = noclip and "NoClip ON" or "NoClip"
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
                local distance = (char.HumanoidRootPart.Position - otherPlayer.Character.HumanoidRootPart.Position).magnitude
                if distance < minDistance then
                    nearestPlayer, minDistance = otherPlayer, distance
                end
            end
        end
        if nearestPlayer then
            char.HumanoidRootPart.CFrame = nearestPlayer.Character.HumanoidRootPart.CFrame
        end
    end
end)
