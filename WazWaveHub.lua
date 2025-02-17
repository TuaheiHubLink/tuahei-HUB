local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Attrixx/FreeScripts/main/YTUILib1.lua"))():init("MazWave Premium")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local GuiService = game:GetService("GuiService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local MainUI = Library.Base
local isVisible = true
local Char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

local Tab = Library:Tab("Main")

local Section = Tab:Section("AutoEquip")
Section:Toggle("Click Here", false, function(value)
    _G.AutoEquip = value
    if _G.AutoEquip then
        spawn(function()
            pcall(function()
                while _G.AutoEquip do
                    wait()
                    local Rod = Char:FindFirstChildOfClass("Tool")
                    if Rod and Rod:FindFirstChild("events") and Rod.events:FindFirstChild("cast") then
                        task.wait(0.1)
                        Rod.events.cast:FireServer(100, 1)
                    end
                end
            end)
        end)
    end
end)

local Section = Tab:Section("AutoShake")
Section:Toggle("Click Here", false, function(value)
    _G.AutoShake = value
    if _G.AutoShake then
        spawn(function()
            pcall(function()
                while _G.AutoShake do
                    task.wait(0.00000000000000000000000000000000000000000001)
                    local PlayerGUI = LocalPlayer:FindFirstChild("PlayerGui")
                    local shakeUI = PlayerGUI and PlayerGUI:FindFirstChild("shakeui")
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
    end
end)

local Section = Tab:Section("AutoReel")
Section:Toggle("Click Here", false, function(value)
    _G.AutoReel = value
    if _G.AutoReel then
        spawn(function()
            pcall(function()
                while _G.AutoReel do
                    wait()
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
    end
end)

local Section = Tab:Section("Toggle UI")
Section:Button("❌ Hide/Show", function()
    isVisible = not isVisible
    MainUI.Visible = isVisible
end)
