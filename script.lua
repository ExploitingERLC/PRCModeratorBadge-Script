local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local isVisible = false
local billboardGui = nil
print("=" .. string.rep("=", 50))
print("[DEBUG] Script Starting...")
print("[DEBUG] Player:", player.Name)
print("[DEBUG] Player UserId:", player.UserId)
print("[DEBUG] Initial Visibility:", isVisible)
local function createGui(head)
    print("\n[DEBUG] ========== Creating GUI ==========")
    print("[DEBUG] Head found:", head)
    print("[DEBUG] Head Parent:", head.Parent)
    print("[DEBUG] Head Position:", head.Position)
    if billboardGui and billboardGui.Parent then
        print("[DEBUG] Destroying old BillboardGui")
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
    print("[DEBUG] BillboardGui Created:")
    print("  - Name:", billboardGui.Name)
    print("  - Size:", billboardGui.Size)
    print("  - StudsOffset:", billboardGui.StudsOffset)
    print("  - AlwaysOnTop:", billboardGui.AlwaysOnTop)
    print("  - Enabled:", billboardGui.Enabled)
    print("  - Adornee:", billboardGui.Adornee)
    print("  - Parent:", billboardGui.Parent)
    print("  - LightInfluence:", billboardGui.LightInfluence)
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Size = UDim2.new(1, 0, 1, 0)
    imageLabel.BackgroundTransparency = 1
    imageLabel.BorderSizePixel = 0
    imageLabel.Image = "rbxassetid://110486556863987"
    imageLabel.ScaleType = Enum.ScaleType.Fit
    imageLabel.Parent = billboardGui
    print("[DEBUG] ImageLabel Created:")
    print("  - Size:", imageLabel.Size)
    print("  - BackgroundTransparency:", imageLabel.BackgroundTransparency)
    print("  - Image:", imageLabel.Image)
    print("  - ScaleType:", imageLabel.ScaleType)
    print("  - Parent:", imageLabel.Parent)
    wait(0.1)
    print("\n[DEBUG] Verification Check:")
    print("  - BillboardGui exists:", billboardGui ~= nil)
    print("  - BillboardGui Parent:", billboardGui and billboardGui.Parent or "NIL")
    print("  - BillboardGui Enabled:", billboardGui and billboardGui.Enabled or "NIL")
    print("  - ImageLabel exists:", billboardGui and billboardGui:FindFirstChildOfClass("ImageLabel") ~= nil or "NIL")
    local foundImageLabel = billboardGui and billboardGui:FindFirstChildOfClass("ImageLabel")
    if foundImageLabel then
        print("  - ImageLabel Image property:", foundImageLabel.Image)
        print("  - ImageLabel Visible:", foundImageLabel.Visible)
        print("  - ImageLabel Size:", foundImageLabel.Size)
    end
    print("[DEBUG] ========== GUI Creation Complete ==========\n")
end
local function toggleGui()
    print("\n[DEBUG] ========== Toggle Called ==========")
    isVisible = not isVisible
    print("[DEBUG] New Visibility State:", isVisible)
    if billboardGui and billboardGui.Parent then
        billboardGui.Enabled = isVisible
        print("[DEBUG] BillboardGui toggled successfully")
        print("  - BillboardGui Enabled:", billboardGui.Enabled)
        print("  - BillboardGui Parent:", billboardGui.Parent)
        print("  - BillboardGui Adornee:", billboardGui.Adornee)
        local imageLabel = billboardGui:FindFirstChildOfClass("ImageLabel")
        if imageLabel then
            print("  - ImageLabel found")
            print("    - Image:", imageLabel.Image)
            print("    - Visible:", imageLabel.Visible)
            print("    - Size:", imageLabel.Size)
            print("    - BackgroundTransparency:", imageLabel.BackgroundTransparency)
        else
            warn("[DEBUG] ERROR: ImageLabel NOT FOUND!")
            warn("[DEBUG] BillboardGui Children:")
            for i, child in pairs(billboardGui:GetChildren()) do
                warn("  - " .. tostring(child) .. " (" .. child.ClassName .. ")")
            end
        end
    else
        warn("[DEBUG] ERROR: BillboardGui not found or has no parent!")
        warn("  - billboardGui exists:", billboardGui ~= nil)
        warn("  - billboardGui.Parent:", billboardGui and billboardGui.Parent or "NIL")
        print("[DEBUG] Attempting to recreate...")
        local character = player.Character
        if character then
            print("  - Character found:", character)
            local head = character:FindFirstChild("Head")
            if head then
                print("  - Head found:", head)
                createGui(head)
                billboardGui.Enabled = isVisible
            else
                warn("  - ERROR: Head not found!")
                warn("  - Character children:")
                for i, child in pairs(character:GetChildren()) do
                    warn("    - " .. tostring(child) .. " (" .. child.ClassName .. ")")
                end
            end
        else
            warn("  - ERROR: Character not found!")
        end
    end
    print("[DEBUG] ========== Toggle Complete ==========\n")
end
local function init()
    print("\n[DEBUG] ========== Initialization ==========")
    local character = player.Character
    print("[DEBUG] Current Character:", character)
    if not character then
        print("[DEBUG] Waiting for character...")
        character = player.CharacterAdded:Wait()
        print("[DEBUG] Character loaded:", character)
    end
    wait(0.1)
    print("[DEBUG] Character children:")
    for i, child in pairs(character:GetChildren()) do
        print("  - " .. tostring(child) .. " (" .. child.ClassName .. ")")
    end
    local head = character:WaitForChild("Head", 10)
    if head then
        print("[DEBUG] Head found, creating GUI...")
        createGui(head)
    else
        warn("[DEBUG] ERROR: Could not find Head!")
        warn("[DEBUG] Character:", character)
        warn("[DEBUG] Character Parent:", character and character.Parent or "NIL")
    end
    print("[DEBUG] ========== Initialization Complete ==========\n")
end
init()

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.Zero or input.KeyCode == Enum.KeyCode.KeypadZero then
        print("\n[DEBUG] ========== 0 Key Pressed ==========")
        toggleGui()
    end
end)

print("[DEBUG] Keybind registered: Press 0 to toggle image")

player.CharacterAdded:Connect(function(newCharacter)
    print("\n[DEBUG] Character respawned, recreating GUI...")
    wait(0.5)
    local head = newCharacter:WaitForChild("Head", 10)
    if head then
        createGui(head)
    else
        warn("[DEBUG] ERROR: Could not find Head after respawn!")
    end
end)

print("=" .. string.rep("=", 50))
print("[DEBUG] Script fully loaded!")
print("[DEBUG] Press 0 to toggle image visibility")
print("[DEBUG] Current visibility:", isVisible)
print("=" .. string.rep("=", 50))
