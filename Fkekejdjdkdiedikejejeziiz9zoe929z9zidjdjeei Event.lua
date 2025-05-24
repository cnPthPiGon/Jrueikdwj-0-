local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- GUI
local gui = Instance.new("ScreenGui", playerGui)
gui.Name = "StylishTargetGui"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.Active = true
frame.Draggable = true

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 12)

-- Target TextBox
local targetBox = Instance.new("TextBox", frame)
targetBox.PlaceholderText = "Player name (partial)"
targetBox.Size = UDim2.new(1, -20, 0, 35)
targetBox.Position = UDim2.new(0, 10, 0, 10)
targetBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
targetBox.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", targetBox).CornerRadius = UDim.new(0, 8)

-- RemoteEvent TextBox
local remoteBox = Instance.new("TextBox", frame)
remoteBox.PlaceholderText = "RemoteEvent name"
remoteBox.Size = UDim2.new(1, -20, 0, 35)
remoteBox.Position = UDim2.new(0, 10, 0, 55)
remoteBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
remoteBox.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", remoteBox).CornerRadius = UDim.new(0, 8)

-- Button
local button = Instance.new("TextButton", frame)
button.Text = "Execute"
button.Size = UDim2.new(1, -20, 0, 40)
button.Position = UDim2.new(0, 10, 0, 105)
button.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
button.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)

-- Mobile drag support
local UIS = game:GetService("UserInputService")
local dragging, dragStart, startPos

frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
	end
end)

frame.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

-- Button action
button.MouseButton1Click:Connect(function()
	local partialName = targetBox.Text:lower()
	local remoteName = remoteBox.Text
	local target

	for _, plr in pairs(game.Players:GetPlayers()) do
		if plr.Name:lower():sub(1, #partialName) == partialName then
			target = plr.Name
			break
		end
	end

	if target and remoteName ~= "" then
		local args = {
			[1] = target
		}
		game:GetService("ReplicatedStorage"):WaitForChild(remoteName):FireServer(unpack(args))
	else
		warn("Invalid player name or RemoteEvent name.")
	end
end)
