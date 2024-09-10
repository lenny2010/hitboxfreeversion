-- Hitbox Expander Script (for others, excluding the local player)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Function to expand the hitbox for other players and make it red
local function expandHitbox(character)
    -- Ensure the character has a HumanoidRootPart
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        -- Expand the hitbox size
        humanoidRootPart.Size = Vector3.new(10, 10, 10)
        humanoidRootPart.CanCollide = false  -- Disable collision if needed

        -- Create a BoxHandleAdornment to visualize the hitbox in red
        local hitboxAdornment = Instance.new("BoxHandleAdornment")
        hitboxAdornment.Adornee = humanoidRootPart
        hitboxAdornment.Size = humanoidRootPart.Size  -- Match the size of the hitbox
        hitboxAdornment.Color3 = Color3.new(1, 0, 0)  -- Red color
        hitboxAdornment.Transparency = 0.5  -- Semi-transparent
        hitboxAdornment.AlwaysOnTop = true  -- Make sure the box is always on top of other objects
        hitboxAdornment.ZIndex = 0
        hitboxAdornment.Parent = humanoidRootPart
        print(character.Name .. "'s hitbox expanded and colored red!")
    end
end

-- Apply the hitbox expansion for new players, excluding yourself
Players.PlayerAdded:Connect(function(player)
    -- Ensure the script only applies to other players
    if player ~= LocalPlayer then
        player.CharacterAdded:Connect(function(character)
            expandHitbox(character)
        end)
    end
end)

-- Apply hitbox expansion for existing players in the game (excluding the local player)
for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer and player.Character then
        expandHitbox(player.Character)
    end
end
