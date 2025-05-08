local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))() -- Libary

-- Functions
local espEnabled = false
local espObjects = {}

local function CreateESP(player)
    if not player.Character or not player.Character:FindFirstChild("Head") then return end

    local head = player.Character:FindFirstChild("Head")
    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.FillColor = Color3.fromRGB(255, 0, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Adornee = player.Character
    highlight.Parent = game.CoreGui
    table.insert(espObjects, highlight)

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Billboard"
    billboard.Adornee = head
    billboard.Size = UDim2.new(0, 100, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = game.CoreGui
    table.insert(espObjects, billboard)

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Color3.new(1, 1, 1)
    nameLabel.TextStrokeTransparency = 0.5
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.TextScaled = true
    nameLabel.Text = player.Name
    nameLabel.Parent = billboard

    local hpFrame = Instance.new("Frame")
    hpFrame.Size = UDim2.new(1, 0, 0.2, 0)
    hpFrame.Position = UDim2.new(0, 0, 0.8, 0)
    hpFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    hpFrame.BorderSizePixel = 0
    hpFrame.Parent = billboard

    local hpFill = Instance.new("Frame")
    hpFill.Size = UDim2.new(1, 0, 1, 0)
    hpFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    hpFill.BorderSizePixel = 0
    hpFill.Name = "HP_Fill"
    hpFill.Parent = hpFrame

    humanoid.HealthChanged:Connect(function()
        local percent = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
        hpFill.Size = UDim2.new(percent, 0, 1, 0)
        hpFill.BackgroundColor3 = Color3.fromRGB(255 * (1 - percent), 255 * percent, 0)
    end)
end

local function ToggleESP(enabled)
    espEnabled = enabled

    for _, obj in ipairs(espObjects) do
        if obj and obj.Parent then
            obj:Destroy()
        end
    end
    espObjects = {}

    if not espEnabled then return end

    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            CreateESP(player)
        end
    end

    game.Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function()
            task.wait(1)
            if espEnabled then
                CreateESP(player)
            end
        end)
    end)
end
----------------------------- ESP FUNCTION ----------------------------------
-- Functions

local Window = Rayfield:CreateWindow({
    Name = "Hyper Universal Exploit",
    Icon = "ghost",
    LoadingTitle = "Hyper Universal Exploit",
    LoadingSubtitle = "by Hyper",
    Theme = "DarkBlue",

    DisableRayfieldPrompts = true,
    DisableBuildWarnings = false,

    ConfigurationSaving = {
        Enabled = true,
        FolderName = "HyperUniversal",
        FileName = "hyperLua"
    },

    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
        RememberJoins = true
    },

    KeySystem = false,
    KeySettings = {
        Title = "Untitled",
        Subtitle = "Key System",
        Note = "No method of obtaining the key is provided",
        FileName = "Key",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"Hello"}
    }
})

-- Main Section
local MainTab = Window:CreateTab("Home", "home") 
local MainSection = MainTab:CreateSection("Main Section")

Rayfield:Notify({
    Title = "You executed the script!",
    Content = "My top G",
    Duration = 5,
    Image = "rewind",
})
-- Main Section

-- Visual Section
local VisualTab = Window:CreateTab("Visual", "eye") 
local VisualSection = VisualTab:CreateSection("Visual Section")

local Toggle = VisualTab:CreateToggle({
    Name = "ESP",
    CurrentValue = false,
    Flag = "Highlight",
    Callback = function(Value)
        ToggleESP(Value)
    end,
})
----------------------------- ESP ----------------------------------

-- Visual Section

-- Player Section
local PlayerTab = Window:CreateTab("Player", "person-standing") 
local PlayerSection = PlayerTab:CreateSection("Player Section")

local ServerHopButton = PlayerTab:CreateButton({
    Name = "Server hop",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId)
    end,
})
----------------------------- SERVER HOP ----------------------------------

local FPSButton = PlayerTab:CreateButton({
    Name = "FPS Boost",
    Callback = function()
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
            end
        end
    end,
})
----------------------------- FPS BOOST ----------------------------------

PlayerTab:CreateSlider({
    Name = "Walkspeed",
    Range = {16, 300},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})
----------------------------- WALK SPEED ----------------------------------

local noclipConnection
local noclipEnabled = false

PlayerTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Callback = function(state)
        noclipEnabled = state
        if state then
            noclipConnection = game:GetService("RunService").Stepped:Connect(function()
                for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end)
        else
            if noclipConnection then
                noclipConnection:Disconnect()
            end
        end
    end
})
----------------------------- NOCLIP ----------------------------------

local flyEnabled = false
local flyConnection
local flySpeed = 50
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

PlayerTab:CreateToggle({
    Name = "Fly (WASD)",
    CurrentValue = false,
    Callback = function(state)
        flyEnabled = state

        local char = game.Players.LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        if state then
            local bv = Instance.new("BodyVelocity")
            bv.Name = "FlyVelocity"
            bv.Velocity = Vector3.new(0, 0.5, 0) -- leicht schweben
            bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            bv.P = 1e4
            bv.Parent = hrp

            flyConnection = RunService.RenderStepped:Connect(function()
                if not flyEnabled or not hrp:FindFirstChild("FlyVelocity") then return end

                local camCF = workspace.CurrentCamera.CFrame
                local moveVec = Vector3.zero

                if UIS:IsKeyDown(Enum.KeyCode.W) then moveVec += camCF.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.S) then moveVec -= camCF.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.A) then moveVec -= camCF.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.D) then moveVec += camCF.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.Space) then moveVec += Vector3.new(0, 1, 0) end
                if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then moveVec -= Vector3.new(0, 1, 0) end

                -- Wenn keine Taste gedrückt wird, langsam schweben
                if moveVec.Magnitude == 0 then
                    moveVec = Vector3.new(0, 0.5, 0)
                end

                hrp.FlyVelocity.Velocity = moveVec.Unit * flySpeed
            end)
        else
            if hrp:FindFirstChild("FlyVelocity") then
                hrp.FlyVelocity:Destroy()
            end
            if flyConnection then
                flyConnection:Disconnect()
                flyConnection = nil
            end
        end
    end,
})
----------------------------- FLY ----------------------------------

PlayerTab:CreateSlider({
    Name = "Fly Speed",
    Range = {10, 150},
    Increment = 5,
    Suffix = "Speed",
    CurrentValue = flySpeed,
    Callback = function(Value)
        flySpeed = Value
    end
})
----------------------------- FLY SPEED ----------------------------------

PlayerTab:CreateSlider({
    Name = "Jump Power",
    Range = {50, 200},
    Increment = 5,
    Suffix = "Power",
    CurrentValue = 50,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end
})
----------------------------- JUMP POWER ----------------------------------

PlayerTab:CreateButton({
    Name = "Reset Movement",
    Callback = function()
        local player = game.Players.LocalPlayer
        local char = player.Character or player.CharacterAdded:Wait()
        local hum = char:FindFirstChildOfClass("Humanoid")

        if hum then
            hum.WalkSpeed = 16
            hum.JumpPower = 50
        end

        -- Deaktivieren Fly
        flyEnabled = false
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp and hrp:FindFirstChild("FlyVelocity") then
            hrp.FlyVelocity:Destroy()
        end
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end

        -- Deaktivieren Noclip
        noclipEnabled = false
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
    end,
})
----------------------------- RESET MOVEMENT ----------------------------------
-- Player Section

-- Misc Section
local MiscTab = Window:CreateTab("Misc", "settings") 
local MiscSection = MiscTab:CreateSection("Misc Section")

local DiscordButton = MiscTab:CreateButton({
    Name = "Join my discord!",
    Callback = function()
        setclipboard("https://discord.gg/qtnEeGqV4c")

        Rayfield:Notify({
            Title = "Discord",
            Content = "Copied!",
            Duration = 5,
            Image = "rewind",
        })
    end,
})
-- Misc Section