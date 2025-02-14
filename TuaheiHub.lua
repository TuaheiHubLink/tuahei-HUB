--[[ 
    Open Src AutoFisch Script By : NOOBHUB
]]
local Player = game:GetService("Players")
local LocalPlayer = Player.LocalPlayer
local Char = LocalPlayer.Character
local Humanoid = Char.Humanoid
local VirtualInputManager = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")

equipitem = function(v)
    if LocalPlayer.Backpack:FindFirstChild(v) then
        local a = LocalPlayer.Backpack:FindFirstChild(v)
        Humanoid:EquipTool(a)
    end
end

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Tuahei Hub", "BloodTheme")
local Tab = Window:NewTab("Menu")
local Section = Tab:NewSection("MAIN")

-- Player Customization Tab
local PlayerTab = Window:NewTab("Player") -- เพิ่มหน้าต่างใหม่
local PlayerSection = PlayerTab:NewSection("สคริปการปรับแต่งของผู้เล่น") -- คำอธิบาย

-- Speed Control
local speedValue = 16
local speedEnabled = false
PlayerSection:NewSlider("Speed", "Adjust running speed", 16, 200, function(value)
    speedValue = value
    if speedEnabled then
        Humanoid.WalkSpeed = speedValue
    end
end)

PlayerSection:NewButton("Enable Fast Speed", "Set speed to max", function()
    speedValue = 200
    Humanoid.WalkSpeed = speedValue
end)

PlayerSection:NewToggle("Enable Speed", "Enable/Disable speed modification", function(state)
    speedEnabled = state
    if not state then
        Humanoid.WalkSpeed = 16
    else
        Humanoid.WalkSpeed = speedValue
    end
end)

-- FOV Control
local fovValue = 70
local fovEnabled = false
PlayerSection:NewSlider("FOV", "Adjust Field of View", 70, 120, function(value)
    fovValue = value
    if fovEnabled then
        game.Workspace.CurrentCamera.FieldOfView = fovValue
    end
end)

PlayerSection:NewToggle("Enable FOV Adjustment", "Enable/Disable FOV adjustment", function(state)
    fovEnabled = state
    if fovEnabled then
        game.Workspace.CurrentCamera.FieldOfView = fovValue
    end
end)

-- Fly (keeping this feature as it was)
PlayerSection:NewButton("Fly", "เปิดใช้งานโหมดบิน", function()
    loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\40\39\104\116\116\112\115\58\47\47\103\105\115\116\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\109\101\111\122\111\110\101\89\84\47\98\102\48\51\57\100\102\102\57\102\48\97\55\48\48\49\57\53\56\51\51\99\102\51\57\57\56\57\53\50\48\55\49\102\52\54\52\56\57\53\48\56\55\53\56\100\53\53\54\52\49\55\47\114\97\119\47\101\49\52\101\55\52\102\52\50\53\98\48\54\48\100\102\53\50\51\51\54\53\99\102\51\48\56\48\55\56\55\56\99\51\48\49\102\52\47\97\114\99\101\117\115\37\50\53\50\48\120\37\50\53\50\48\102\108\121\37\50\53\50\48\50\37\50\53\50\48\111\98\102\108\117\99\97\116\111\114\39\41\44\116\114\117\101\41\41\40\41\10\10")()
end)

-- AutoCast
Section:NewToggle("AutoCast", "", function(v)
    _G.AutoCast = v
    pcall(function()
        while _G.AutoCast do wait()
            local Rod = Char:FindFirstChildOfClass("Tool")
            task.wait(0.1)
            if Rod then
                Rod.events.cast:FireServer(100, 1)
            end
        end
    end)
end)

-- AutoShake
Section:NewToggle("AutoShake", "", function(v)
    _G.AutoShake = v
    pcall(function()
        while _G.AutoShake do wait(0.01)
            local PlayerGUI = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
            local shakeUI = PlayerGUI:FindFirstChild("shakeui")
            if shakeUI and shakeUI.Enabled then
                local safezone = shakeUI:FindFirstChild("safezone")
                if safezone then
                    local button = safezone:FindFirstChild("button")
                    if button and button:IsA("ImageButton") and button.Visible then
                        GuiService.SelectedObject = button
                        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
                    end
                end
            end
        end
    end)
end)

-- AutoReel
Section:NewToggle("AutoReel", "", function(v)
    _G.AutoReel = v
    pcall(function()
        while _G.AutoReel do wait()
            for i, v in pairs(LocalPlayer.PlayerGui:GetChildren()) do
                if v:IsA("ScreenGui") and v.Name == "reel" then
                    if v:FindFirstChild("bar") then
                        wait(0.15)
                        ReplicatedStorage.events.reelfinished:FireServer(100, true)
                    end
                end
            end
        end
    end)
end)

-- Freeze Character
Section:NewToggle("Freeze Character", "", function(v)
    Char.HumanoidRootPart.Anchored = v
end)

-- equipitem
spawn(function()
    while wait() do
        if _G.AutoCast then
            pcall(function()
                for i, v in pairs(LocalPlayer.Backpack:GetChildren()) do
                    if v:IsA("Tool") and v.Name:lower():find("rod") then
                        equipitem(v.Name)
                    end
                end
            end)
        end
    end
end)
