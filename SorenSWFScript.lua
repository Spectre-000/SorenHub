-- Wait for game to load
repeat task.wait() until game:IsLoaded()

-- Clean up existing UI if it exists
local CoreGui = game:GetService("CoreGui")
if CoreGui:FindFirstChild("LocationUI") then
    CoreGui.LocationUI:Destroy()
end

-- Create UI elements
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local LocationLabel = Instance.new("TextLabel")
local SavedLocations = Instance.new("Frame")
local LocationList = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local GetLocationButton = Instance.new("TextButton")
local SaveLocationButton = Instance.new("TextButton")
local TeleportButton = Instance.new("TextButton")
local RenameButton = Instance.new("TextButton")
local DeleteButton = Instance.new("TextButton")
local RenameBox = Instance.new("TextBox")
local AntiAFKButton = Instance.new("TextButton")
local AFKStatusLabel = Instance.new("TextLabel")

-- Configure ScreenGui
ScreenGui.Name = "LocationUI"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Configure main frame with modern design
Frame.Name = "MainFrame"
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.8, 0, 0.5, -175)
Frame.Size = UDim2.new(0, 250, 0, 450)
Frame.Active = true
Frame.Draggable = true

-- Add rounded corners
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = Frame

-- Add title with gradient
Title.Name = "Title"
Title.Parent = Frame
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.BorderSizePixel = 0
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "Location Manager"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16.000

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = Title

-- Add Location Label
LocationLabel.Name = "LocationLabel"
LocationLabel.Parent = Frame
LocationLabel.BackgroundTransparency = 1
LocationLabel.Position = UDim2.new(0, 10, 0, 40)
LocationLabel.Size = UDim2.new(1, -20, 0, 20)
LocationLabel.Font = Enum.Font.GothamSemibold
LocationLabel.Text = "Saved Locations:"
LocationLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
LocationLabel.TextSize = 14.000
LocationLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Configure location list with modern style
SavedLocations.Name = "SavedLocations"
SavedLocations.Parent = Frame
SavedLocations.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
SavedLocations.BorderSizePixel = 0
SavedLocations.Position = UDim2.new(0, 10, 0, 65)
SavedLocations.Size = UDim2.new(1, -20, 0, 180)

local SavedLocationsCorner = Instance.new("UICorner")
SavedLocationsCorner.CornerRadius = UDim.new(0, 6)
SavedLocationsCorner.Parent = SavedLocations

LocationList.Name = "LocationList"
LocationList.Parent = SavedLocations
LocationList.BackgroundTransparency = 1
LocationList.Size = UDim2.new(1, 0, 1, 0)
LocationList.CanvasSize = UDim2.new(0, 0, 0, 0)
LocationList.ScrollBarThickness = 4
LocationList.AutomaticCanvasSize = Enum.AutomaticSize.Y

UIListLayout.Parent = LocationList
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 2)

-- Configure buttons with hover effects
local function createStyledButton(button)
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    button.BorderSizePixel = 0
    button.Font = Enum.Font.Gotham
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 14.000
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = button
    
    -- Hover effect
    local buttonOriginalColor = button.BackgroundColor3
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = buttonOriginalColor
    end)
end

-- Configure buttons
GetLocationButton.Name = "GetLocationButton"
GetLocationButton.Parent = Frame
GetLocationButton.Position = UDim2.new(0, 10, 0, 255)
GetLocationButton.Size = UDim2.new(1, -20, 0, 25)
GetLocationButton.Text = "Get Current Location"
createStyledButton(GetLocationButton)

SaveLocationButton.Name = "SaveLocationButton"
SaveLocationButton.Parent = Frame
SaveLocationButton.Position = UDim2.new(0, 10, 0, 285)
SaveLocationButton.Size = UDim2.new(1, -20, 0, 25)
SaveLocationButton.Text = "Save Location"
createStyledButton(SaveLocationButton)

-- Add rename box
RenameBox.Name = "RenameBox"
RenameBox.Parent = Frame
RenameBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
RenameBox.BorderSizePixel = 0
RenameBox.Position = UDim2.new(0, 10, 0, 315)
RenameBox.Size = UDim2.new(0.7, -15, 0, 25)
RenameBox.Font = Enum.Font.Gotham
RenameBox.PlaceholderText = "Enter new name..."
RenameBox.Text = ""
RenameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
RenameBox.TextSize = 14.000
RenameBox.Visible = false

local RenameBoxCorner = Instance.new("UICorner")
RenameBoxCorner.CornerRadius = UDim.new(0, 6)
RenameBoxCorner.Parent = RenameBox

RenameButton.Name = "RenameButton"
RenameButton.Parent = Frame
RenameButton.Position = UDim2.new(0.7, 5, 0, 315)
RenameButton.Size = UDim2.new(0.3, -15, 0, 25)
RenameButton.Text = "Rename"
createStyledButton(RenameButton)

DeleteButton.Name = "DeleteButton"
DeleteButton.Parent = Frame
DeleteButton.Position = UDim2.new(0, 10, 0, 345)
DeleteButton.Size = UDim2.new(0.5, -15, 0, 25)
DeleteButton.Text = "Delete"
createStyledButton(DeleteButton)

TeleportButton.Name = "TeleportButton"
TeleportButton.Parent = Frame
TeleportButton.Position = UDim2.new(0.5, 5, 0, 345)
TeleportButton.Size = UDim2.new(0.5, -15, 0, 25)
TeleportButton.Text = "Teleport"
createStyledButton(TeleportButton)

-- Add Anti-AFK Toggle
AntiAFKButton.Name = "AntiAFKButton"
AntiAFKButton.Parent = Frame
AntiAFKButton.Position = UDim2.new(0, 10, 0, 385)
AntiAFKButton.Size = UDim2.new(1, -20, 0, 25)
AntiAFKButton.Text = "Anti-AFK: OFF"
createStyledButton(AntiAFKButton)

-- Anti-AFK Status Label
AFKStatusLabel.Name = "AFKStatusLabel"
AFKStatusLabel.Parent = Frame
AFKStatusLabel.BackgroundTransparency = 1
AFKStatusLabel.Position = UDim2.new(0, 10, 0, 415)
AFKStatusLabel.Size = UDim2.new(1, -20, 0, 25)
AFKStatusLabel.Font = Enum.Font.Gotham
AFKStatusLabel.Text = "Status: Inactive"
AFKStatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
AFKStatusLabel.TextSize = 12.000
AFKStatusLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Variables to store data
local savedLocations = {}
local selectedLocation = nil
local currentCoords = nil

-- Function to create a location button
local function createLocationButton(name, position)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -4, 0, 25)
    button.Position = UDim2.new(0, 2, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    button.BorderSizePixel = 0
    button.Text = name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 14.000
    button.Parent = LocationList
    
    -- Add rounded corners to location buttons
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 4)
    buttonCorner.Parent = button
    
    button.MouseButton1Click:Connect(function()
        selectedLocation = {name = name, position = position, button = button}
        print("Selected location:", name, "Position:", tostring(position))
        
        -- Highlight selected button
        for _, child in pairs(LocationList:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
            end
        end
        button.BackgroundColor3 = Color3.fromRGB(85, 170, 255)
        
        -- Update teleport button text
        TeleportButton.Text = "Teleport to " .. name
    end)
    
    return button
end

-- Function to rename location
local function renameLocation()
    if not selectedLocation then
        RenameButton.Text = "Select a location!"
        wait(1)
        RenameButton.Text = "Rename"
        return
    end
    
    -- Toggle rename box visibility
    if RenameBox.Visible then
        -- Apply new name if text box is not empty
        if RenameBox.Text ~= "" then
            local newName = RenameBox.Text
            selectedLocation.name = newName
            selectedLocation.button.Text = newName
            TeleportButton.Text = "Teleport to " .. newName
            
            -- Update in saved locations
            for _, loc in ipairs(savedLocations) do
                if loc.button == selectedLocation.button then
                    loc.name = newName
                    break
                end
            end
        end
        RenameBox.Visible = false
        RenameBox.Text = ""
        RenameButton.Text = "Rename"
    else
        RenameBox.Text = selectedLocation.name
        RenameBox.Visible = true
        RenameButton.Text = "Save"
    end
end

-- Handle rename box enter key
RenameBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        renameLocation()
    end
end)

-- Function to delete location
local function deleteLocation()
    if not selectedLocation then
        DeleteButton.Text = "Select a location!"
        wait(1)
        DeleteButton.Text = "Delete"
        return
    end
    
    -- Remove from saved locations
    for i, loc in ipairs(savedLocations) do
        if loc.name == selectedLocation.name then
            table.remove(savedLocations, i)
            break
        end
    end
    
    -- Remove button
    selectedLocation.button:Destroy()
    selectedLocation = nil
    TeleportButton.Text = "Teleport"
    
    -- Visual feedback
    DeleteButton.Text = "Deleted!"
    wait(1)
    DeleteButton.Text = "Delete"
end

-- Function to get current location
local function getCurrentLocation()
    local player = game:GetService("Players").LocalPlayer
    if player and player.Character then
        local hrp = player.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            currentCoords = hrp.Position
            GetLocationButton.Text = "Location Copied!"
            wait(1)
            GetLocationButton.Text = "Get Current Location"
        end
    end
end

-- Function to save location
local function saveLocation()
    if not currentCoords then
        getCurrentLocation()
    end
    
    if currentCoords then
        local name = game:GetService("Players").LocalPlayer.Name .. "'s Location " .. (#savedLocations + 1)
        print("Saving location:", name, "Position:", tostring(currentCoords))
        local newLoc = {name = name, position = currentCoords}
        table.insert(savedLocations, newLoc)
        newLoc.button = createLocationButton(name, currentCoords)
    end
end

-- Function to teleport
local function teleportToLocation()
    print("Attempting to teleport. Selected location:", selectedLocation and selectedLocation.name or "none")
    
    if not selectedLocation then 
        TeleportButton.Text = "Select a location first!"
        wait(1)
        TeleportButton.Text = "Teleport"
        return 
    end
    
    local player = game:GetService("Players").LocalPlayer
    if not player or not player.Character then return end
    
    local character = player.Character
    local humanoid = character:FindFirstChild("Humanoid")
    local hrp = character:FindFirstChild("HumanoidRootPart")
    
    if not hrp or not humanoid then return end
    
    -- Bypass attempt using character state manipulation
    local function tryTeleport()
        -- Disable character physics
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
                part.Velocity = Vector3.new(0, 0, 0)
                part.RotVelocity = Vector3.new(0, 0, 0)
            end
        end
        
        -- Store old values
        local oldPos = hrp.CFrame
        local oldWalkSpeed = humanoid.WalkSpeed
        local oldJumpPower = humanoid.JumpPower
        local oldGravity = workspace.Gravity
        
        -- Attempt teleport with physics bypass
        workspace.Gravity = 0
        humanoid.WalkSpeed = 0
        humanoid.JumpPower = 0
        humanoid:ChangeState(Enum.HumanoidStateType.Physics)
        
        -- Teleport sequence
        for i = 1, 3 do
            hrp.CFrame = CFrame.new(selectedLocation.position)
            hrp.Velocity = Vector3.new(0, 0, 0)
            hrp.RotVelocity = Vector3.new(0, 0, 0)
            task.wait()
        end
        
        -- Restore values
        workspace.Gravity = oldGravity
        humanoid.WalkSpeed = oldWalkSpeed
        humanoid.JumpPower = oldJumpPower
        humanoid:ChangeState(Enum.HumanoidStateType.Running)
        
        -- Re-enable collisions
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
        
        -- Check if teleport was successful
        return (hrp.Position - selectedLocation.position).Magnitude < 50
    end
    
    -- Try multiple teleport methods
    local success = false
    
    -- Method 1: Direct CFrame teleport with physics bypass
    success = tryTeleport()
    
    -- Method 2: If first method fails, try teleporting through the void
    if not success then
        local oldPos = hrp.CFrame
        hrp.CFrame = CFrame.new(0, -1000000, 0)
        task.wait(0.1)
        hrp.CFrame = CFrame.new(selectedLocation.position)
        success = (hrp.Position - selectedLocation.position).Magnitude < 50
    end
    
    -- Visual feedback
    if success then
        TeleportButton.Text = "Teleported to " .. selectedLocation.name .. "!"
    else
        TeleportButton.Text = "Failed to teleport!"
    end
    wait(1)
    TeleportButton.Text = selectedLocation and ("Teleport to " .. selectedLocation.name) or "Teleport"
end

-- Anti-AFK Variables
local antiAFKEnabled = false
local lastMethodUsed = 0
local virtualInputManager = game:GetService("VirtualInputManager")
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer

-- Anti-AFK Methods
local antiAFKMethods = {
    function() -- Method 1: Virtual key press
        virtualInputManager:SendKeyEvent(true, Enum.KeyCode.Unknown, false, game)
        task.wait(0.1)
        virtualInputManager:SendKeyEvent(false, Enum.KeyCode.Unknown, false, game)
    end,
    
    function() -- Method 2: Mouse movement
        local smallMove = 5
        virtualInputManager:SendMouseMoveEvent(
            smallMove * math.random(-1, 1),
            smallMove * math.random(-1, 1),
            workspace
        )
    end,
    
    function() -- Method 3: Camera movement
        local camera = workspace.CurrentCamera
        if camera then
            local currentCFrame = camera.CFrame
            local randomRotation = CFrame.Angles(
                math.rad(math.random(-1, 1)),
                math.rad(math.random(-1, 1)),
                0
            )
            camera.CFrame = currentCFrame * randomRotation
        end
    end,
    
    function() -- Method 4: Network activity
        local success, _ = pcall(function()
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.MutePlayerRequest:FireServer()
        end)
    end
}

-- Function to update Anti-AFK status
local function updateAFKStatus(status, method)
    AFKStatusLabel.Text = string.format("Status: %s (Method %d)", status, method)
end

-- Anti-AFK Loop
local antiAFKConnection = nil

local function toggleAntiAFK()
    antiAFKEnabled = not antiAFKEnabled
    AntiAFKButton.Text = "Anti-AFK: " .. (antiAFKEnabled and "ON" or "OFF")
    AntiAFKButton.BackgroundColor3 = antiAFKEnabled and Color3.fromRGB(65, 175, 85) or Color3.fromRGB(45, 45, 45)
    
    if antiAFKEnabled then
        -- Start Anti-AFK
        antiAFKConnection = runService.Heartbeat:Connect(function()
            if not antiAFKEnabled then return end
            
            -- Rotate through methods every 30 seconds
            local currentTime = tick()
            if currentTime - lastMethodUsed >= 30 then
                local methodIndex = (math.floor(currentTime / 30) % #antiAFKMethods) + 1
                local success, err = pcall(function()
                    antiAFKMethods[methodIndex]()
                end)
                if success then
                    updateAFKStatus("Active", methodIndex)
                else
                    updateAFKStatus("Error", methodIndex)
                end
                lastMethodUsed = currentTime
            end
        end)
    else
        -- Stop Anti-AFK
        if antiAFKConnection then
            antiAFKConnection:Disconnect()
            antiAFKConnection = nil
        end
        AFKStatusLabel.Text = "Status: Inactive"
    end
end

-- Connect button events
GetLocationButton.MouseButton1Click:Connect(getCurrentLocation)
SaveLocationButton.MouseButton1Click:Connect(saveLocation)
RenameButton.MouseButton1Click:Connect(renameLocation)
DeleteButton.MouseButton1Click:Connect(deleteLocation)
TeleportButton.MouseButton1Click:Connect(teleportToLocation)
AntiAFKButton.MouseButton1Click:Connect(toggleAntiAFK)

-- Add keybind to toggle UI
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        Frame.Visible = not Frame.Visible
    end
end)

-- Initial state
Frame.Visible = false
