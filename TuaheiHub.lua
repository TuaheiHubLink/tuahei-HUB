--// Main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

--// Main Frame (Draggable & Resizable)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 250)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

--// Text Label (Animated Gradient)
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "tuahei Hub | Blue Lock"
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Parent = MainFrame

-- Gradient Effect
local UIGradient = Instance.new("UIGradient")
UIGradient.Parent = Title
UIGradient.Rotation = 0
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 170, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(170, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 170, 255))
}

-- Animate Gradient
spawn(function()
    while wait(0.1) do
        UIGradient.Rotation = UIGradient.Rotation + 5
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

--// Toggle Button for Hitbox Visibility
local HitboxToggle = Instance.new("TextButton")
HitboxToggle.Size = UDim2.new(0.8, 0, 0.15, 0)
HitboxToggle.Position = UDim2.new(0.1, 0, 0.2, 0)
HitboxToggle.Text = "Show Hitboxes"
HitboxToggle.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
HitboxToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
HitboxToggle.Parent = MainFrame

local hitboxEnabled = false
HitboxToggle.MouseButton1Click:Connect(function()
    hitboxEnabled = not hitboxEnabled
    HitboxToggle.BackgroundColor3 = hitboxEnabled and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 120, 255)
    HitboxToggle.Text = hitboxEnabled and "Hide Hitboxes" or "Show Hitboxes"
    for _, player in pairs(game.Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("Hitbox") then
            player.Character.Hitbox.Transparency = hitboxEnabled and 0 or 1
        end
    end
end)

--// Input for Hitbox Size
local HitboxSizeInput = Instance.new("TextBox")
HitboxSizeInput.Size = UDim2.new(0.6, 0, 0.15, 0)
HitboxSizeInput.Position = UDim2.new(0.1, 0, 0.4, 0)
HitboxSizeInput.PlaceholderText = "Hitbox Size (0.1-500)"
HitboxSizeInput.TextColor3 = Color3.fromRGB(255, 50, 50)
HitboxSizeInput.Parent = MainFrame

local HitboxSizeButton = Instance.new("TextButton")
HitboxSizeButton.Size = UDim2.new(0.2, 0, 0.15, 0)
HitboxSizeButton.Position = UDim2.new(0.75, 0, 0.4, 0)
HitboxSizeButton.Text = "Set"
HitboxSizeButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
HitboxSizeButton.Parent = MainFrame

HitboxSizeButton.MouseButton1Click:Connect(function()
    local size = tonumber(HitboxSizeInput.Text)
    if size and size >= 0.1 and size <= 500 then
        game.Players.LocalPlayer.Character.Hitbox.Size = Vector3.new(size, size, size)
    end
end)
