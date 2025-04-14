local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- Création de l'interface
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = lp:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 150, 0, 60)
frame.Position = UDim2.new(0, 10, 0.5, -30)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local button = Instance.new("TextButton")
button.Size = UDim2.new(1, 0, 1, 0)
button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
button.Text = "Spam"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextScaled = true
button.Font = Enum.Font.GothamBold
button.Parent = frame

-- Fonction quand on clique
button.MouseButton1Click:Connect(function()
    for _, tool in pairs(lp.Backpack:GetChildren()) do
        if tool:IsA("Tool") then
            tool.Parent = lp.Character
            tool:Activate()
            task.wait()
            tool.Parent = lp.Backpack
        end
    end
end)
