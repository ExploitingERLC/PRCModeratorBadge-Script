local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local isVisible = false
local billboardGui = nil

local function createGui(head)
    if billboardGui and billboardGui.Parent then
        billboardGui:Destroy()
    end
    billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = "FloatingImage"
    billboardGui.Size = UDim2.new(0, 250, 0, 250)
    billboardGui.StudsOffset = Vector3.new(0, 4, 0)
    billboardGui.AlwaysOnTop = true
    billboardGui.Adornee = head
    billboardGui.Enabled = isVisible
    billboardGui.LightInfluence = 0
    billboardGui.SizeOffset = Vector2.new(0, 0)
    billboardGui.MaxDistance = 0
    billboardGui.Parent = head

    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Size = UDim2.new(1, 0, 1, 0)
    imageLabel.BackgroundTransparency = 1
    imageLabel.BorderSizePixel = 0
    imageLabel.Image = "rbxassetid://110486556863987"
    imageLabel.ScaleType = Enum.ScaleType.Fit
    imageLabel.Parent = billboardGui
end

local function toggleGui()
    isVisible = not isVisible
    if billboardGui and billboardGui.Parent then
        billboardGui.Enabled = isVisible
    else
        local character = player.Character
        if character then
            local head = character:FindFirstChild("Head")
            if head then
                createGui(head)
                billboardGui.Enabled = isVisible
            end
        end
    end
end

local function init()
    local character = player.Character or player.CharacterAdded:Wait()
    local head = character:WaitForChild("Head", 10)
    if head then
        createGui(head)
    end
end

init()

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Zero or input.KeyCode == Enum.KeyCode.KeypadZero then
        toggleGui()
    end
end)

player.CharacterAdded:Connect(function(newCharacter)
    wait(0.5)
    local head = newCharacter:WaitForChild("Head", 10)
    if head then
        createGui(head)
    end
end)
