local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
-- Nonaktifkan print & warn untuk modul ini agar console tidak spam
-- local print = function(...) end
-- local warn = function(...) end


local Window = WindUI:CreateWindow({
    Title = "King Vypers",
    Icon = "rbxassetid://139467646163013",
    Folder = "KingVypers",
    Background = "rbxassetid://97514324988224",
    BackgroundImageTransparency = 0.35,
    Size = UDim2.new(0, 530, 0, 300),
    MinSize = Vector2.new(530, 300),
    MaxSize = Vector2.new(530, 300),
    NewElements = true,
    OpenButton = {
        Enabled = false,
    },
})

-- */  Colors  /* --
local Kings = Color3.fromHex("#120324")
local Mains = Color3.fromHex("#110029")
local Purple = Color3.fromHex("#7775F2")
local Yellow = Color3.fromHex("#ECA201")
local Green = Color3.fromHex("#10C550")
local Grey = Color3.fromHex("#292828")
local Blue = Color3.fromHex("#257AF7")
local Red = Color3.fromHex("#EF4F1D")


-- TARUH DISINI ↓
WindUI:AddTheme({
    Name = "MachTheme",
    Background = Kings,
})
WindUI:SetTheme("MachTheme")
-- SAMPAI SINI ↑

-- Tambahkan setelah CreateWindow
Window:Tag({
    Title = "PREMIUM",
    Color = Mains,
})

Window:Tag({
    Title = "V 0.3",
    Color = Purple,
})

-- =================================================================
-- 🔴 TOMBOL MERAH (PC + MOBILE SUPPORT)
-- =================================================================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

-- Protection
local protectGui
local success, result = pcall(function()
    if gethui then
        return gethui()
    elseif syn and syn.protect_gui then
        local sg = Instance.new("ScreenGui")
        syn.protect_gui(sg)
        sg.Parent = CoreGui
        return sg.Parent
    else
        return CoreGui
    end
end)

if success then
    protectGui = result
else
    protectGui = Players.LocalPlayer:WaitForChild("PlayerGui")
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MachFishingButton"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = protectGui

local buttonFrame = Instance.new("Frame")
buttonFrame.Size = UDim2.new(0, 42, 0, 42)
buttonFrame.Position = UDim2.new(0, 20, 0, 20)
buttonFrame.BackgroundTransparency = 1
buttonFrame.Parent = screenGui

local imageButton = Instance.new("ImageButton")
imageButton.Size = UDim2.new(1, 0, 1, 0)
imageButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)       -- merah -> hitam pekat
imageButton.BackgroundTransparency = 0.2
imageButton.Image = "rbxassetid://107726435417936"
imageButton.ScaleType = Enum.ScaleType.Fit
imageButton.Parent = buttonFrame

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = imageButton

local uiStroke = Instance.new("UIStroke")
uiStroke.Thickness = 2
uiStroke.Color = Color3.fromRGB(60, 60, 60)                     -- merah muda -> abu gelap
uiStroke.Parent = imageButton

local uiGradient = Instance.new("UIGradient")
uiGradient.Color = ColorSequence.new(
    Color3.fromRGB(20, 20, 20),                                  -- merah -> hitam pekat
    Color3.fromRGB(60, 60, 60)                                   -- merah muda -> abu gelap
)
uiGradient.Parent = uiStroke

-- ========================================
-- 🖱️📱 DRAG + CLICK (PC + MOBILE)
-- ========================================
local dragging = false
local dragInput
local dragStart
local startPos

imageButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = buttonFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

imageButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

-- DRAG MOVEMENT (PC + MOBILE)
UserInputService.InputChanged:Connect(function(input)
    if dragging and dragInput and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        buttonFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- CLICK DETECTION (PC + MOBILE)
local clickStart = nil
imageButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        clickStart = input.Position
    end
end)

imageButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if clickStart then
            local moved = (input.Position - clickStart).Magnitude
            
            -- CLICK (ga di-drag)
            if moved < 10 then
                if Window and Window.Toggle then
                    Window:Toggle()
                    print("🔄 Window toggled")
                end
            end
            
            clickStart = nil
        end
    end
end)

-- HOVER EFFECT (PC only)
imageButton.MouseEnter:Connect(function()
    TweenService:Create(imageButton, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play()
end)

imageButton.MouseLeave:Connect(function()
    TweenService:Create(imageButton, TweenInfo.new(0.15), {BackgroundTransparency = 0.2}):Play()
end)

-- INFO TAB

	local InfoTab = Window:Tab({
		Title = "Info",
		Icon = "solar:info-square-bold",
		IconColor = Mains,
		IconShape = "Square",
		Border = true,
	})






local HttpService = game:GetService("HttpService")

-- =============================================
-- CONFIG AUTO-SAVE
-- =============================================
local uiConfigPath = "KingVypers_MonsterConfig.json"
local isUILoading = true

local function loadUIConfig()
    if readfile then
        local ok, data = pcall(readfile, uiConfigPath)
        if ok and data then
            local ok2, decoded = pcall(function() return HttpService:JSONDecode(data) end)
            if ok2 and decoded then return decoded end
        end
    end
    return {}
end

local function saveUIConfig(cfg)
    if writefile then
        pcall(writefile, uiConfigPath, HttpService:JSONEncode(cfg))
    end
end

local uiConfig = loadUIConfig()

-- Fungsi fetch member count
local memberCount = "N/A"
local onlineCount = "N/A"

local function fetchDiscordInfo()
    local req = request or http_request or syn and syn.request
    if not req then return end
    
    local success, result = pcall(function()
        return req({
            Url = "https://discord.com/api/v9/invites/XmWf3YQPpZ?with_counts=true",
            Method = "GET",
            Headers = {
                ["User-Agent"] = "Mozilla/5.0"
            }
        })
    end)
    
    if success and result and result.StatusCode == 200 then
        local ok, data = pcall(function()
            return game:GetService("HttpService"):JSONDecode(result.Body)
        end)
        
        if ok and data then
            memberCount = tostring(data.approximate_member_count or "N/A")
            onlineCount = tostring(data.approximate_presence_count or "N/A")
        end
    end
end

-- Fetch dulu sebelum bikin UI
fetchDiscordInfo()

-- Info + buttons + banner semua dalam satu frame
local ServerInfo = InfoTab:Paragraph({
    Title = "King Vypers | Official",
    Desc = "• Member Count: " .. memberCount .. "\n• Online Count: " .. onlineCount,
    Image = "rbxassetid://107726435417936",
    Thumbnail = "rbxassetid://83197533072664",
    ThumbnailSize = 80,
    Buttons = {
        {
            Title = "Copy Discord Invite",
            Color= Color3.fromHex("#5707AB"),
            Icon = "link",
            Callback = function()
                if setclipboard then
                    setclipboard("https://discord.gg/XmWf3YQPpZ")
                end
            end
        },
        {
            Title = "Update Info",
            Icon = "refresh-cw",
            Callback = function()
                fetchDiscordInfo()
                ServerInfo:SetDesc("• Member Count: " .. memberCount .. "\n• Online Count: " .. onlineCount)
            end
        }
    }
})

-- FISHING TAB
local Fishing = Window:Tab({
    Title = "Fishing",
    Icon = "fish",
	IconColor = Mains,
	IconShape = "Square",
	Border = true,
})

-- =============================================
-- ⚡ INSTANT FISHING TOGGLE
-- =============================================
local InstantFishSection = Fishing:Section({ Title = "Instant Fish", Box = true, TextXAlignment = "Center", TextSize = 15, Opened = false })


local instantFishEnabled = uiConfig.InstantFishEnabled or false
local instantFishTask = nil
local instantFishDelay = uiConfig.InstantFishDelay or 3

InstantFishSection:Input({
    Title = "Fish Delay",
    Value = tostring(instantFishDelay),
    InputIcon = "clock",
    Type = "Input",
    Placeholder = "Angka (Contoh: 3)",
    Callback = function(input) 
        local val = tonumber(input)
        if val then
            instantFishDelay = val
            print("[Instant Fish] Delay diatur ke: " .. val .. " detik")
            if not isUILoading then
                uiConfig.InstantFishDelay = val
                saveUIConfig(uiConfig)
            end
        else
            print("[Instant Fish] Input delay tidak valid!")
        end
    end
})

InstantFishSection:Toggle({
    Title = "Instant Fishing",
    Icon = "zap",
    Default = instantFishEnabled,
    Callback = function(state)
        instantFishEnabled = state
        if not isUILoading then
            uiConfig.InstantFishEnabled = state
            saveUIConfig(uiConfig)
        end

        if state then
            print("[Instant Fish] ON")

            instantFishTask = task.spawn(function()
                local RS = game:GetService("ReplicatedStorage")
                local LP = game:GetService("Players").LocalPlayer
                local Knit = RS.Packages._Index["sleitnick_knit@1.7.0"].knit.Services
                local FishingRF = Knit.FishingReplicationService.RF
                local RewardRF  = Knit.FishingRewardService.RF
                local RewardRE  = Knit.FishingRewardService.RE

                local START_FISHING      = FishingRF.StartFishing
                local THROW_FLOATER      = FishingRF.ThrowFloater
                local CONFIRM_CAST       = FishingRF.ConfirmFloatingCast
                local REQUEST_FISH_BITE  = RewardRF.RequestFishBite
                local START_PULLING      = FishingRF.StartPulling
                local FISHING_PULL_INPUT = RewardRF.FishingPullInput
                local STOP_FISHING       = FishingRF.StopFishing
                local PULL_STATE_EVENT   = RewardRE:WaitForChild("FishingPullState")

                local FLOATER = "Floater_Doll"
                local FLOATER_PROPS = {
                    LightInfluence = 0,
                    Transparency   = 0.12,
                    LightEmission  = 0.6,
                    Color          = Color3.new(0, 1, 1),
                    FaceCamera     = true,
                    Width          = 0.16
                }

                local function getCastPos()
                    local char = LP.Character or LP.CharacterAdded:Wait()
                    local hrp = char:WaitForChild("HumanoidRootPart")
                    local playerPos = hrp.Position
                    local lookDir = hrp.CFrame.LookVector
                    local targetXZ = playerPos + (lookDir * 15)

                    local rayParams = RaycastParams.new()
                    rayParams.FilterDescendantsInstances = {char}
                    rayParams.FilterType = Enum.RaycastFilterType.Exclude
                    rayParams.IgnoreWater = false

                    local origin = targetXZ + Vector3.new(0, 15, 0)
                    local result = workspace:Raycast(origin, Vector3.new(0, -100, 0), rayParams)

                    local castPos = result and result.Position or (targetXZ + Vector3.new(0, -8, 0))
                    local tool = char:FindFirstChildOfClass("Tool")
                    local rodName = tool and tool.Name or "BananaRod"

                    return playerPos, castPos, rodName
                end

                -- Listener resolved
                local isResolved = false
                local activeSessionId = nil
                local resolvedConn
                resolvedConn = PULL_STATE_EVENT.OnClientEvent:Connect(function(data)
                    if type(data) == "table" and data.sessionId and data.type == "resolved" then
                        if data.sessionId == activeSessionId then
                            isResolved = true
                        end
                    end
                end)

                while instantFishEnabled do
                    if shared.isDoingEvent then task.wait(1) continue end
                    isResolved = false
                    activeSessionId = nil
                    local playerPos, castPos, rodName = getCastPos()

                    -- 1. StartFishing
                    pcall(function() START_FISHING:InvokeServer(rodName, FLOATER) end)

                    -- 2. ThrowFloater
                    pcall(function() THROW_FLOATER:InvokeServer(playerPos, castPos, rodName, FLOATER, FLOATER_PROPS, 10) end)

                    -- 3. ConfirmFloatingCast
                    pcall(function() CONFIRM_CAST:InvokeServer(castPos) end)

                    -- 4. RequestFishBite -> ambil SessionId dari response!
                    local sessionId = nil
                    local ok, result = pcall(function() return REQUEST_FISH_BITE:InvokeServer(castPos) end)
                    if ok and type(result) == "table" and result.SessionId then
                        sessionId = result.SessionId
                        activeSessionId = sessionId
                        print("[Instant Fish] Session:", sessionId)
                    else
                        print("[Instant Fish] RequestFishBite gagal / tidak ada session.")
                    end
                    
                    -- Kasih jeda sesuai input biar server ready dan ga too_early
                    task.wait(instantFishDelay)

                    -- 5. StartPulling
                    pcall(function() START_PULLING:InvokeServer() end)

                    -- 6. Spam tap sampai resolved!
                    if sessionId then
                        -- begin SEKALI
                        pcall(function() FISHING_PULL_INPUT:InvokeServer(sessionId, "begin") end)

                        -- spam tap per frame sampai resolved
                        local waitStart = tick()
                        while not isResolved and instantFishEnabled and tick() - waitStart < 15 do
                            task.spawn(function()
                                pcall(function() FISHING_PULL_INPUT:InvokeServer(sessionId, "tap") end)
                            end)
                            task.wait()
                        end

                        print("[Instant Fish] Selesai! resolved:", isResolved)
                    else
                        print("[Instant Fish] Gagal dapet SessionId, skip...")
                    end

                    -- Stop & jeda antar mancing
                    pcall(function() STOP_FISHING:InvokeServer() end)
                end

                resolvedConn:Disconnect()
            end)

        else
            print("[Instant Fish] OFF")
            instantFishEnabled = false
            if instantFishTask then
                task.cancel(instantFishTask)
                instantFishTask = nil
            end
        end
    end,
})




-- =============================================
-- 🐟 Legit FISH SECTION
-- =============================================

local LegitFishSection = Fishing:Section({ Title = "Legit Fish", Box = true, TextXAlignment = "Center", TextSize = 15, Opened = false })

local legitFishingEnabled = false
local legitFishingConnection = nil

LegitFishSection:Toggle({
    Title = "Legit Fishing",
    Icon = "fish",
    Default = false,
    Callback = function(state)
        legitFishingEnabled = state

        if state then
            print("[Auto Fish] ON")

            legitFishingConnection = task.spawn(function()
                local player = game:GetService("Players").LocalPlayer
                local char = player.Character or player.CharacterAdded:Wait()
                local VIM = game:GetService("VirtualInputManager")
                local Knit = game:GetService("ReplicatedStorage").Packages
                    ._Index["sleitnick_knit@1.7.0"].knit.Services
                local ReplicationRF = Knit.FishingReplicationService.RF
                local RewardRF = Knit.FishingRewardService.RF
                local RewardRE = Knit.FishingRewardService.RE

                -- Auto detect
                local reelButton = player.PlayerGui.FishingMobile:FindFirstChild("ReelButton")
                local IS_MOBILE = reelButton ~= nil
                print(IS_MOBILE and "Mobile detected!" or "PC detected!")

                local currentUUID = nil
                local isPulling = false
                local castSuccess = false
                local castFailed = false

                -- Listen FishCaught
                local caughtConn = RewardRE.FishCaught.OnClientEvent:Connect(function(data)
                    if data then
                        print("[CAUGHT]", data.FishID, "|", data.Weight, "Kg")
                    end
                    isPulling = false
                end)

                -- Hook ConfirmFloatingCast + StopFishing via __namecall
                local ConfirmRF = Knit.FishingReplicationService.RF.ConfirmFloatingCast
                local StopRF = Knit.FishingReplicationService.RF.StopFishing
                local mt = getrawmetatable(game)
                local oldNamecall = mt.__namecall
                setreadonly(mt, false)
                mt.__namecall = function(self, ...)
                    local method = getnamecallmethod()
                    if self == ConfirmRF and method == "InvokeServer" then
                        castSuccess = true
                        print("[Cast Sukses! ConfirmFloatingCast datang]")
                    elseif self == StopRF and method == "InvokeServer" then
                        castFailed = true
                        print("[Cast Gagal! StopFishing datang]")
                    end
                    return oldNamecall(self, ...)
                end
                setreadonly(mt, true)

                while legitFishingEnabled do
                    castSuccess = false
                    castFailed = false
                    currentUUID = nil
                    isPulling = false

                    -- [1] Cek dan equip rod
                    local equippedTool = char:FindFirstChildOfClass("Tool")
                    if equippedTool then
                        print("[1] Sudah pegang rod:", equippedTool.Name)
                    else
                        print("[1] Belum pegang rod, equip slot 1...")
                        VIM:SendKeyEvent(true, Enum.KeyCode.One, false, game)
                        task.wait(0.1)
                        VIM:SendKeyEvent(false, Enum.KeyCode.One, false, game)
                        task.wait(0.5)
                        print("[1] Slot 1 equipped!")
                    end

                    -- [2] Cast loop sampai sukses
                    local fillbar = player.PlayerGui.FishingPanel.ThrowFrame.FillContainer.Fillbar
                    repeat
                        if not legitFishingEnabled then break end
                        castSuccess = false
                        castFailed = false
                        currentUUID = nil
                        print("[2] Casting...")
                        if IS_MOBILE then
                            firesignal(reelButton.MouseButton1Down)
                        else
                            VIM:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                        end

                        local maxFillWait = 0
                        repeat 
                            task.wait(0.05) 
                            maxFillWait += 0.05
                        until fillbar.Size.Y.Scale >= 0.99 or castFailed or not legitFishingEnabled or maxFillWait > 3

                        if IS_MOBILE then
                            firesignal(reelButton.MouseButton1Up)
                        else
                            VIM:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                        end

                        -- Tunggu ConfirmFloatingCast atau StopFishing max 10 detik
                        local timeout = 0
                        while not castSuccess and not castFailed and timeout < 10 and legitFishingEnabled do
                            task.wait(0.1)
                            timeout += 0.1
                        end

                        if castFailed then
                            print("[Cast Gagal! StopFishing detected, retry...")
                            task.wait(1)
                        elseif not castSuccess then
                            print("[Cast Gagal] Timeout 10 detik, retry...")
                        end
                    until castSuccess or not legitFishingEnabled

                    if not legitFishingEnabled then break end

                    print("[3] Cast done! Waiting fish...")

                    -- [3] Tunggu UUID pake event
                    local uuidEvent = Instance.new("BindableEvent")
                    local uuidConn
                    uuidConn = RewardRE.FishingPullState.OnClientEvent:Connect(function(data)
                        if data and data.sessionId and currentUUID == nil then
                            currentUUID = data.sessionId
                            print("[UUID]", currentUUID)
                            uuidConn:Disconnect()
                            uuidEvent:Fire()
                        end
                    end)

                    local uuidTimeout = task.delay(15, function()
                        uuidEvent:Fire()
                    end)

                    uuidEvent.Event:Wait()
                    uuidEvent:Destroy()
                    pcall(function() task.cancel(uuidTimeout) end)

                    if currentUUID == nil then
                        print("[ERROR] UUID timeout!")
                        if not legitFishingEnabled then break end
                        task.wait(1)
                        continue
                    end

                    -- [4] Pull instant - spam tap sampai server resolved!
                    print("[4] Pulling UUID:", currentUUID)
                    isPulling = true

                    -- Listen resolved event dulu sebelum mulai
                    local isResolved = false
                    local resolvedConn2
                    resolvedConn2 = RewardRE.FishingPullState.OnClientEvent:Connect(function(data)
                        if type(data) == "table" and data.sessionId == currentUUID and data.type == "resolved" then
                            isResolved = true
                            isPulling = false
                        end
                    end)

                    RewardRF.FishingPullInput:InvokeServer(currentUUID, "begin")
                    task.wait(0.05)

                    -- Spam tap tiap frame (super cepat) sampai resolved (max 15 detik)
                    local pullStart = tick()
                    while isPulling and legitFishingEnabled and tick() - pullStart < 15 do
                        task.spawn(function()
                            for i = 1, 5 do
                                pcall(function() RewardRF.FishingPullInput:InvokeServer(currentUUID, "tap") end)
                            end
                        end)
                        task.wait()
                    end

                    resolvedConn2:Disconnect()
                    print("[5] Done! Looping...")
                    task.wait(3)
                end

                -- Cleanup
                caughtConn:Disconnect()
                setreadonly(mt, false)
                mt.__namecall = oldNamecall
                setreadonly(mt, true)
                print("[Legit Fish] OFF")
            end)
        else
            print("[Legit Fish] Stopping...")
            legitFishingEnabled = false
        end
    end,
})

local autoMinigameEnabled = false
local autoMinigameConnUUID = nil
local autoMinigameConnCaught = nil

LegitFishSection:Toggle({
    Title = "Auto Minigame Only",
    Icon = "gamepad-2",
    Default = false,
    Callback = function(state)
        autoMinigameEnabled = state
        
        local Knit = game:GetService("ReplicatedStorage").Packages._Index["sleitnick_knit@1.7.0"].knit.Services
        local RewardRF = Knit.FishingRewardService.RF
        local RewardRE = Knit.FishingRewardService.RE

        if state then
            print("[Auto Minigame] ON")
            
            local isPulling = false
            local pullTask = nil

            autoMinigameConnCaught = RewardRE.FishCaught.OnClientEvent:Connect(function(data)
                isPulling = false
                if pullTask then
                    task.cancel(pullTask)
                    pullTask = nil
                end
                print("[Auto Minigame] Ikan ketangkep!")
            end)

            autoMinigameConnUUID = RewardRE.FishingPullState.OnClientEvent:Connect(function(data)
                if data and data.sessionId and autoMinigameEnabled then
                    local currentUUID = data.sessionId
                    print("[Auto Minigame] Minigame mulai! UUID:", currentUUID)
                    
                    isPulling = true
                    RewardRF.FishingPullInput:InvokeServer(currentUUID, "begin")
                    
                    pullTask = task.spawn(function()
                        while isPulling and autoMinigameEnabled do
                            RewardRF.FishingPullInput:InvokeServer(currentUUID, "tap")
                            task.wait()
                        end
                    end)
                end
            end)

        else
            print("[Auto Minigame] OFF")
            if autoMinigameConnUUID then autoMinigameConnUUID:Disconnect() end
            if autoMinigameConnCaught then autoMinigameConnCaught:Disconnect() end
        end
    end,
})


-- =============================================
-- Support Functions FISH SECTION
-- =============================================

local SupportFishSection = Fishing:Section({ Title = "Support Fishing", Box = true, TextXAlignment = "Center", TextSize = 15, Opened = false })

local WalkOnWater = (function()
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local Workspace = game:GetService("Workspace")
    local RunService = game:GetService("RunService")
    local M = { Enabled = false, Platform = nil, AlignPos = nil, Connection = nil }
    local PLATFORM_SIZE = 14
    local OFFSET = 2.5
    local WATER_Y = nil
    local TICK = 0
    local SCAN_INTERVAL = 10 -- scanWaterY tiap 10 frame sekali aja

    local function getChar()
        local char = LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hum or not hrp then return end
        return char, hum, hrp
    end

    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist
    rayParams.IgnoreWater = false

    local function isAboveWater(hrp)
        rayParams.FilterDescendantsInstances = { LocalPlayer.Character }
        local result = Workspace:Raycast(hrp.Position, Vector3.new(0, -50, 0), rayParams)
        if result and result.Instance:IsA("Terrain") then
            return result.Material == Enum.Material.Water
        end
        return false
    end

    local function scanWaterY(hrp)
        rayParams.FilterDescendantsInstances = { LocalPlayer.Character }
        local result = Workspace:Raycast(
            hrp.Position + Vector3.new(0, 100, 0),
            Vector3.new(0, -500, 0),
            rayParams
        )
        if result and result.Instance:IsA("Terrain") and result.Material == Enum.Material.Water then
            return result.Position.Y
        end
        return nil
    end

    local function createPlatform()
        if M.Platform then M.Platform:Destroy() end
        local p = Instance.new("Part")
        p.Name = "WaterLockPlatform"
        p.Size = Vector3.new(PLATFORM_SIZE, 1, PLATFORM_SIZE)
        p.Anchored = true
        p.CanCollide = true
        p.CanQuery = false
        p.CanTouch = false
        p.Transparency = 1
        p.Parent = Workspace
        M.Platform = p
    end

    local function setupAlign(hrp)
        if M.AlignPos then M.AlignPos:Destroy() end
        local att = hrp:FindFirstChild("WOW_Att") or Instance.new("Attachment")
        att.Name = "WOW_Att"
        att.Parent = hrp
        local ap = Instance.new("AlignPosition")
        ap.Attachment0 = att
        ap.MaxForce = math.huge
        ap.MaxVelocity = math.huge
        ap.Responsiveness = 200
        ap.RigidityEnabled = true
        ap.Parent = hrp
        M.AlignPos = ap
    end

    local function cleanup()
        if M.Connection then M.Connection:Disconnect() M.Connection = nil end
        if M.AlignPos then M.AlignPos:Destroy() M.AlignPos = nil end
        if M.Platform then M.Platform:Destroy() M.Platform = nil end
        WATER_Y = nil
        TICK = 0
    end

    function M.Start()
        if M.Enabled then return end
        local _, hum, hrp = getChar()
        if not hum or not hrp then
            warn("[WOW] Karakter tidak ditemukan!") return
        end

        M.Enabled = true
        createPlatform()
        setupAlign(hrp)
        print("[WOW] ON")

        M.Connection = RunService.Heartbeat:Connect(function()
            if not M.Enabled then return end
            local _, curHum, curHRP = getChar()
            if not curHum or not curHRP then return end

            local pos = curHRP.Position
            TICK += 1

            -- Swimming handler
            if curHum:GetState() == Enum.HumanoidStateType.Swimming then
                curHRP.Velocity = Vector3.new(curHRP.Velocity.X, 60, curHRP.Velocity.Z)
            end

            -- ScanWaterY tiap 10 frame bukan tiap frame
            if TICK % SCAN_INTERVAL == 0 then
                local y = scanWaterY(curHRP)
                if y then WATER_Y = y end
            end

            -- isAboveWater tiap frame (ringan, raycast pendek)
            local aboveWater = isAboveWater(curHRP)

            if aboveWater and WATER_Y then
                M.Platform.CFrame = CFrame.new(pos.X, WATER_Y - 0.5, pos.Z)
                M.AlignPos.Position = Vector3.new(pos.X, WATER_Y + OFFSET, pos.Z)
            else
                M.Platform.CFrame = CFrame.new(pos.X, -9999, pos.Z)
                M.AlignPos.Position = pos
            end
        end)
    end

    function M.Stop()
        M.Enabled = false
        cleanup()
        print("[WOW] OFF")
    end

    LocalPlayer.CharacterAdded:Connect(function()
        if M.Enabled then
            task.wait(0.5)
            cleanup()
            M.Enabled = false
            M.Start()
        end
    end)

    return M
end)()

SupportFishSection:Toggle({
    Title = "Walk on Water",
    Icon = "waves",
    Default = false,
    Callback = function(state)
        if state then
            WalkOnWater.Start()
        else
            WalkOnWater.Stop()
        end
    end,
})

-- =============================================
-- AUTO EQUIP ROD MODULE
-- =============================================
local AutoEquipRod = (function()
    local M = {
        Enabled = false,
        Thread = nil,
    }

    function M.Start()
        if M.Enabled then return end
        M.Enabled = true
        print("[AutoEquipRod] ON")

        M.Thread = task.spawn(function()
            local LP = game:GetService("Players").LocalPlayer
            while M.Enabled do
                local char = LP.Character
                if char then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    local equippedTool = char:FindFirstChildOfClass("Tool")

                    -- Kalau ga pegang rod sama sekali
                    if hum and not equippedTool then
                        local backpack = LP:FindFirstChild("Backpack")
                        if backpack then
                            -- Cari rod apapun di backpack (prioritas: yang namanya ada "Rod")
                            local rod = nil
                            for _, item in ipairs(backpack:GetChildren()) do
                                if item:IsA("Tool") and item.Name:lower():find("rod") then
                                    rod = item
                                    break
                                end
                            end
                            -- Kalau ga ada "rod", equip tool pertama yang ada
                            if not rod then
                                rod = backpack:FindFirstChildOfClass("Tool")
                            end

                            if rod then
                                hum:EquipTool(rod)
                                print("[AutoEquipRod] Equip:", rod.Name)
                            end
                        end
                    end
                end
                task.wait(1) -- Cek setiap 1 detik
            end
        end)
    end

    function M.Stop()
        if not M.Enabled then return end
        M.Enabled = false
        if M.Thread then
            task.cancel(M.Thread)
            M.Thread = nil
        end
        print("[AutoEquipRod] OFF")
    end

    return M
end)()

SupportFishSection:Toggle({
    Title = "Auto Equip Rod",
    Icon = "zap",
    Default = false,
    Callback = function(state)
        if state then
            AutoEquipRod.Start()
        else
            AutoEquipRod.Stop()
        end
    end,
})


-- =============================================
-- Sell Tab
-- =============================================
local favoritedFishTracker = {}

local SellTab = Window:Tab({
    Title = "Shell",
    Icon = "dollar-sign",
    IconColor = Mains,
    IconShape = "Square",
    Border = true,
})

local SellSection = SellTab:Section({ Title = "Auto Sell", Box = true, TextXAlignment = "Center", TextSize = 15, Opened = true })

local selectedRarities = {}

SellSection:Dropdown({
    Title = "Pilih Rarity",
    Multi = true,
    Values = {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Secret", "Monster"},
    Value = {},
    AllowNone = true,
    Callback = function(selected)
        selectedRarities = {}
        for _, rarity in ipairs(selected) do
            selectedRarities[rarity] = true
        end
    end
})

local autoSellInterval = 5 -- Default in minutes

SellSection:Input({
    Type = "Input",
    Title = "Auto Sell(Minutes)",
    Placeholder = "5",
    Callback = function(text)
        local val = tonumber(text)
        if val and val > 0 then
            autoSellInterval = val
            print("[Auto Sell] Interval set to", val, "minutes")
        end
    end
})

local function ExecuteSell()
    print("[AutoSell] Memulai Auto Sell (GUI Method)...")
    local Players = game:GetService("Players")
    local LP = Players.LocalPlayer
    local PlayerGui = LP:FindFirstChild("PlayerGui")
    local RS = game:GetService("ReplicatedStorage")
    local Knit = RS.Packages._Index["sleitnick_knit@1.7.0"].knit.Services
    local FISH_SOLD = Knit.FishermanShopService.RE.FishSold

    local function waitForUI()
        print("⏳ Nunggu FishermanShopGUI kebuka...")
        local gui = PlayerGui:WaitForChild("FishermanShopGUI", 10)
        if not gui then
            print("❌ FishermanShopGUI ga muncul!")
            return false
        end
        print("✅ UI kebuka!")
        return true
    end

    local function clickButton(btn, name)
        local ok, err = pcall(function()
            firesignal(btn.MouseButton1Click)
        end)
        if ok then
            print("✅ Klik " .. name)
        else
            print("❌ Gagal klik " .. name .. ":", err)
        end
        task.wait(0.5)
    end

    local character = LP.Character or LP.CharacterAdded:Wait()
    local hrp = character:FindFirstChild("HumanoidRootPart")
    local originalCFrame = nil

    if hrp then
        originalCFrame = hrp.CFrame
        print("[AutoSell] Teleport ke lokasi sell...")
        
        if game.PlaceId == 90457367396205 then
            -- Map 2 logic
            local hud = LP.PlayerGui:FindFirstChild("HUD")
            local statsPanel = hud and hud:FindFirstChild("PlayerStatsPanel", true)
            local levelLabel = statsPanel and statsPanel:FindFirstChild("LevelLabel", true)

            local level = 0
            if levelLabel then
                level = tonumber(levelLabel.Text:match("%d+")) or 0
            end

            local unlockIslands = {
                { name = "Bamboo",          pos = Vector3.new(-1119.28, 227.39, 256.52),    unlockLevel = 1  },
                { name = "Iceberg",         pos = Vector3.new(-521.57, 309.43, -818.11),    unlockLevel = 1  },
                { name = "Lost Whale Island", pos = Vector3.new(-2470.06, 65.96, -89.39),   unlockLevel = 10 },
                { name = "Bora Reef",       pos = Vector3.new(-3774.61, 200.02, 2078.67),   unlockLevel = 20 },
                { name = "Volcano Vent",    pos = Vector3.new(-1855.89, 316.16, 6046.96),   unlockLevel = 30 },
                { name = "Cape Town",       pos = Vector3.new(1259.36, 214.58, 2513.89),    unlockLevel = 35 },
            }

            local sellLocations = {
                Vector3.new(-605.20, 172.88, 25.43),
                Vector3.new(-2660.34, 172.12, 203.34),
                Vector3.new(-1409.31, 173.55, 400.75),
                Vector3.new(804.61, 187.62, 2952.89),
                Vector3.new(-3996.39, 171.44, 2028.85),
                Vector3.new(-1686.41, 173.81, 5931.25),
            }

            local validSellLocs = {}
            for _, sell in ipairs(sellLocations) do
                local nearest, nearestDist = nil, math.huge
                for _, island in ipairs(unlockIslands) do
                    local dist = (sell - island.pos).Magnitude
                    if dist < nearestDist then
                        nearestDist = dist
                        nearest = island
                    end
                end
                
                if nearest and level >= nearest.unlockLevel then
                    table.insert(validSellLocs, sell)
                end
            end

            local bestSellLoc = nil
            local bestDist = math.huge
            for _, loc in ipairs(validSellLocs) do
                local dist = (hrp.Position - loc).Magnitude
                if dist < bestDist then
                    bestDist = dist
                    bestSellLoc = loc
                end
            end

            if bestSellLoc then
                hrp.CFrame = CFrame.new(bestSellLoc)
            else
                hrp.CFrame = CFrame.new(sellLocations[1])
            end
        else
            -- Default / Map 1 logic (111385005478215)
            hrp.CFrame = CFrame.new(280.2694396972656, 201.01766967773438, 1551.6795654296875)
        end
        
        task.wait(1.5) -- Tunggu sampai server acknowledge posisi
    end

    local prompt = nil
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("ProximityPrompt") and v.ActionText == "Sell Fish" then
            prompt = v
            break
        end
    end

    if not prompt then
        print("❌ Prompt Sell Fish ga ketemu!")
        if hrp and originalCFrame then hrp.CFrame = originalCFrame end
        return
    end

    print("🐟 Trigger Sell Fish...")
    fireproximityprompt(prompt)

    if not waitForUI() then 
        if hrp and originalCFrame then hrp.CFrame = originalCFrame end
        return 
    end
    task.wait(0.5)

    local ShopPanel = PlayerGui.FishermanShopGUI.ShopPanel
    local CartPanel = PlayerGui.FishermanShopGUI.CartPanel

    -- Listen FishSold sebelum klik confirm
    local sellDone = false
    local totalEarned = 0
    local soldConn
    soldConn = FISH_SOLD.OnClientEvent:Connect(function(data)
        sellDone = true
        totalEarned = data.Earned or 0
        print("💰 FishSold! Earned:", data.Earned, "| NewMoney:", data.NewMoney, "| Quantity:", data.Quantity)
        if data.SoldFish then
            for _, fish in ipairs(data.SoldFish) do
                print("   🐟", fish.Name, "x" .. fish.Count, "| Value:", fish.Value)
            end
        end
        soldConn:Disconnect()
    end)

    -- Step 1: SellAll
    clickButton(ShopPanel.ActionBar.BtnFrame.SellAll, "SellAll")

    -- Step 2: ViewCart
    clickButton(ShopPanel.ActionBar.BtnFrame.ViewCart, "ViewCart")

    -- Step 3: ConfirmSell
    clickButton(CartPanel.CartActionFrame.ConfirmSellBtn, "ConfirmSellBtn")

    -- Tunggu FishSold event max 5 detik
    local timeout = tick()
    while not sellDone and tick() - timeout < 5 do
        task.wait(0.1)
    end

    if sellDone then
        print("🏁 Auto Sell selesai! Total earned:", totalEarned)
    else
        print("⚠️ FishSold event ga kedetect, mungkin inventory kosong?")
        soldConn:Disconnect()
    end

    if hrp and originalCFrame then
        print("[AutoSell] Mengembalikan posisi player...")
        task.wait(0.5)
        hrp.CFrame = originalCFrame
    end
end

local autoSellEnabled = false
local autoSellTask = nil

SellSection:Toggle({
    Title = "Enable Auto Sell",
    Icon = "refresh-cw",
    Default = false,
    Callback = function(state)
        autoSellEnabled = state
        if state then
            print("[Auto Sell] ON")
            autoSellTask = task.spawn(function()
                while autoSellEnabled do
                    -- Tunggu interval dulu sebelum sell pertama kali di loop
                    local waited = 0
                    while autoSellEnabled and waited < (autoSellInterval * 60) do
                        task.wait(1)
                        waited += 1
                    end

                    -- Pause kalau lagi event biar ga tabrakan
                    if shared.isDoingEvent then
                        print("[Auto Sell] Lagi event, tunda sell dulu...")
                        while shared.isDoingEvent and autoSellEnabled do
                            task.wait(1)
                        end
                        print("[Auto Sell] Event selesai, lanjut sell!")
                    end

                    -- Setelah tunggu, baru sell
                    if autoSellEnabled then
                        ExecuteSell()
                    end
                end
            end)
        else
            print("[Auto Sell] OFF")
            if autoSellTask then
                task.cancel(autoSellTask)
                autoSellTask = nil
            end
        end
    end
})

SellSection:Button({
    Title = "Sell Now",
    Icon = "shopping-cart",
    Callback = function()
        task.spawn(ExecuteSell)
    end
})

InfoTab:Select()




-- =============================================
-- Favorit Tab
-- =============================================

local FavoritTab = Window:Tab({
    Title = "Favorit",
    Icon = "star",
    IconColor = Mains,
    IconShape = "Square",
    Border = true,
})

local FavoritSection = FavoritTab:Section({ Title = "Auto Favorit", Box = true, TextXAlignment = "Center", TextSize = 15, Opened = true })

local favSelectedRarities = {}

FavoritSection:Dropdown({
    Title = "Pilih Rarity",
    Multi = true,
    Values = {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Secret", "Monster"},
    Value = {},
    AllowNone = true,
    Callback = function(selected)
        favSelectedRarities = {}
        for _, rarity in ipairs(selected) do
            favSelectedRarities[rarity] = true
        end
    end
})

local favSelectedMutations = {}

FavoritSection:Dropdown({
    Title = "Pilih Mutation",
    Multi = true,
    Values = {"Electric", "GlassFin", "Shiny", "Zombie", "Metal"},
    Value = {},
    AllowNone = true,
    Callback = function(selected)
        favSelectedMutations = {}
        for _, mutation in ipairs(selected) do
            favSelectedMutations[mutation] = true
        end
    end
})

local autoFavEnabled = false
local autoFavConnection = nil

FavoritSection:Toggle({
    Title = "Enable Auto Favorit",
    Icon = "star",
    Default = false,
    Callback = function(state)
        autoFavEnabled = state
        
        local Knit = game:GetService("ReplicatedStorage").Packages._Index["sleitnick_knit@1.7.0"].knit.Services
        local RewardRE = Knit.FishingRewardService.RE
        local ShopRF = Knit.FishermanShopService.RF
        
        if state then
            print("[Auto Favorit] ON")
            if autoFavConnection == nil then
                autoFavConnection = RewardRE.FishCaught.OnClientEvent:Connect(function(data)
                    if not autoFavEnabled then return end
                    
                    if type(data) == "table" and data.InstanceId and data.FishData then
                        local rarity = data.FishData.Rarity
                        local fishName = data.FishData.Name or ""
                        local mutation = data.Mutation or data.FishData.Mutation
                        
                        local shouldFavorite = false
                        
                        -- Cek Rarity
                        if rarity and favSelectedRarities[rarity] then
                            shouldFavorite = true
                        end
                        
                        -- Cek Mutation
                        if not shouldFavorite then
                            local fishNameLower = string.lower(fishName)
                            for mut, _ in pairs(favSelectedMutations) do
                                local mutLower = string.lower(mut)
                                
                                -- 1. Cek dari nama ikan (case insensitive)
                                if string.find(fishNameLower, mutLower) then
                                    shouldFavorite = true
                                    break
                                end
                                
                                -- 2. Cek dari properti Mutation/Mutations
                                local mutData = data.Mutation or data.Mutations or (data.FishData and (data.FishData.Mutation or data.FishData.Mutations))
                                if type(mutData) == "string" and string.find(string.lower(mutData), mutLower) then
                                    shouldFavorite = true
                                    break
                                elseif type(mutData) == "table" then
                                    for _, m in pairs(mutData) do
                                        if type(m) == "string" and string.find(string.lower(m), mutLower) then
                                            shouldFavorite = true
                                            break
                                        end
                                    end
                                    if shouldFavorite then break end
                                end
                            end
                        end
                        
                        if shouldFavorite then
                            print("[Auto Favorit] Favoriting " .. tostring(fishName))
                            pcall(function()
                                ShopRF.ToggleFavoriteFish:InvokeServer(data.InstanceId)
                                favoritedFishTracker[data.InstanceId] = true
                            end)
                        end
                    end
                end)
            end
        else
            print("[Auto Favorit] OFF")
            if autoFavConnection then
                autoFavConnection:Disconnect()
                autoFavConnection = nil
            end
        end
    end
})


-- =============================================
-- Teleport Tab
-- =============================================

local TeleportTab = Window:Tab({
    Title = "Teleport",
    Icon = "lucide:arrow-left-right",
    IconColor = Mains,
    IconShape = "Square",
    Border = true,
})

local TeleportSection = TeleportTab:Section({ Title = "Teleport Player", Box = true, TextXAlignment = "Center", TextSize = 15, Opened = true })


local Players = game:GetService("Players")

-- build list nama player (exclude self kalau mau)
local function getPlayerNames()
    local names = {}
    for _, p in ipairs(Players:GetPlayers()) do
        table.insert(names, p.Name)
    end
    return names
end

local selectedPlayer = nil

local PlayerDropdown = TeleportSection:Dropdown({
    Title = "Select Player",
    Values = getPlayerNames(),
    Value = getPlayerNames()[1],
    Callback = function(option)
        selectedPlayer = option
    end
})

-- refresh list player (opsional)
TeleportSection:Button({
    Title = "Refresh Players",
    Callback = function()
        local names = getPlayerNames()
        PlayerDropdown:SetValues(names)
        PlayerDropdown:SetValue(names[1])
    end
})

TeleportSection:Button({
    Title = "Teleport Now",
    Callback = function()
        if not selectedPlayer then
            return
        end
        local target = Players:FindFirstChild(selectedPlayer)
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local localChar = Players.LocalPlayer.Character
            if localChar and localChar:FindFirstChild("HumanoidRootPart") then
                localChar.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
            end
        end
    end
})

-- =============================================
-- AUTO EVENT MODULE
-- =============================================
local AutoEventSection = TeleportTab:Section({ Title = "Auto Event", Box = true, TextXAlignment = "Center", TextSize = 15, Opened = true })

local selectedEvents = {
    ["Losi"] = false,
    ["Windah"] = false
}

AutoEventSection:Dropdown({
    Title = "Select Event Boss",
    Multi = true,
    Values = {"Losi", "Windah"},
    Value = {},
    Callback = function(selected)
        selectedEvents.Losi = false
        selectedEvents.Windah = false
        for _, v in ipairs(selected) do
            selectedEvents[v] = true
        end
    end
})

local autoEventEnabled = false
local eventAnnounceConn = nil

local function handleEvent(position, bossName)
    if shared.isDoingEvent then return end
    shared.isDoingEvent = true

    local LP = game:GetService("Players").LocalPlayer
    local char = LP.Character or LP.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local PlayerGui = LP:WaitForChild("PlayerGui")

    -- 1. Save original position
    local originalCFrame = hrp.CFrame
    print("✅ Menyimpan posisi awal:", originalCFrame)

    -- 2. Teleport ke event
    hrp.CFrame = CFrame.new(position + Vector3.new(0, 5, 0))
    print("✅ Teleport ke event:", bossName, "| Pos:", position)

    task.wait(5) -- Jeda 5 detik biar map/UI server bener-bener keload
    print("🚨 LANGSUNG PARTICIPATE!")

    -- 3. Participate
    local ok, btn = pcall(function()
        return PlayerGui.BossFishEventGUI.FishMonsterContainer.FishMonsterBtn
    end)
    if ok and btn then
        firesignal(btn.Activated)
        print("✅ PARTICIPATE!")
    else
        print("❌ Tombol participate ga ketemu!")
    end

    task.wait(1)

    -- 5. Setup EventEnd listener DULU sebelum spam tap
    local RS = game:GetService("ReplicatedStorage")
    local Knit = RS.Packages._Index["sleitnick_knit@1.7.0"].knit.Services

    local isEventEnded = false
    local endConn
    endConn = Knit.BossFishEventService.RE.EventEnd.OnClientEvent:Connect(function(data)
        print("🏁 EventEnd diterima dari server! State:", data and data.State or "nil")
        isEventEnded = true
    end)

    -- 5. Listen to StartPulling via namecall hook
    print("⏳ Menunggu instruksi StartPulling dari game/server...")
    local isPullingStarted = false
    local mt = getrawmetatable(game)
    local oldNamecall = mt.__namecall
    
    pcall(function()
        setreadonly(mt, false)
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            if method == "InvokeServer" and tostring(self) == "StartPulling" then
                isPullingStarted = true
            end
            return oldNamecall(self, ...)
        end)
        setreadonly(mt, true)
    end)

    -- Scan text untuk nentuin timeout (kalau-kalau eventnya masih lama)
    local timeout = 600 -- fallback 10 menit
    pcall(function()
        local readyPanel = PlayerGui:WaitForChild("BossFishEventGUI", 2):WaitForChild("ReadyPanel", 2)
        local label = readyPanel:WaitForChild("TextLabel", 2)
        local text = label.Text
        print("📊 Status Event pas nunggu StartPulling:", text)
        
        local secs = string.match(text, "in: (%d+)s") or string.match(text, "(%d+)s")
        if secs then
            timeout = tonumber(secs) + 60 -- Kasih buffer 60 detik dari sisa waktu countdown
            print("⏱️ Sisa waktu event:", secs, "detik. Set timeout nunggu StartPulling jadi:", timeout, "detik")
        end
    end)

    -- Tunggu StartPulling sesuai timeout, atau sampai EventEnd keluar
    local waitPull = tick()
    while not isPullingStarted and not isEventEnded and tick() - waitPull < timeout do
        task.wait(0.1)
    end
    
    -- balikin namecall
    pcall(function()
        setreadonly(mt, false)
        mt.__namecall = oldNamecall
        setreadonly(mt, true)
    end)
    
    if isEventEnded then
        print("⚠️ EventEnd sudah keluar sebelum StartPulling, skip tap...")
        endConn:Disconnect()
        task.wait(1)
        pcall(function()
            local cBtn1 = PlayerGui.BossEndgameGUI.EndgameUI.CloseButton
            firesignal(cBtn1.Activated)
            print("🏆 Close EndgameUI")
        end)
        task.wait(0.3)
        pcall(function()
            local cBtn2 = PlayerGui.RewardGui.RewardPanel.Header.CloseBtn
            firesignal(cBtn2.MouseButton1Click)
            print("🎁 Close RewardGui")
        end)
        task.wait(1)
        hrp.CFrame = originalCFrame
        print("🔙 Kembali ke posisi awal!")
        shared.isDoingEvent = false
        print("▶️ Instant Fishing dilanjutkan!")
        return
    end
    
    if isPullingStarted then
        print("🎣 StartPulling terdeteksi! Lanjut ke tap...")
    else
        print("⚠️ Timeout nunggu StartPulling, lanjut aja...")
    end
    
    -- 6. Spam tap event
    local tapBossName = "Windah_SM_Clown"
    if bossName:lower():find("losi") then
        tapBossName = "Losi_Coral"
    end
    print("👾 Spam tap", tapBossName, "mulai!")
    
    local PlayerTap = Knit.BossFishEventService.RF.PlayerTap
    
    -- Cek juga dari UI kalau-kalau onClientEvent kelewat
    task.spawn(function()
        task.wait(5) -- Kasih jeda dulu sebelum mulai ngecek UI biar gak false positive awal
        while not isEventEnded and shared.isDoingEvent do
            local hasVictory = false
            local hasReward = false
            pcall(function()
                hasVictory = PlayerGui.BossEndgameGUI.Enabled and PlayerGui.BossEndgameGUI.EndgameUI.Visible
            end)
            pcall(function()
                hasReward = PlayerGui.RewardGui.Enabled and PlayerGui.RewardGui.RewardPanel.Visible
            end)
            
            if hasVictory or hasReward then
                print("🏆 UI Kemenangan kedetect! Event berarti kelar.")
                isEventEnded = true
            end
            task.wait(1)
        end
    end)

    -- Spam tap sampai EventEnd dari server atau UI selesai
    while not isEventEnded and shared.isDoingEvent do
        pcall(function() PlayerTap:InvokeServer(tapBossName) end)
        task.wait(0.1)
    end
    
    endConn:Disconnect()
    print("🏁 Event selesai!")
    
    -- 7. Close GUI
    task.wait(1)
    pcall(function()
        local cBtn1 = PlayerGui.BossEndgameGUI.EndgameUI.CloseButton
        firesignal(cBtn1.Activated)
        print("🏆 Close EndgameUI")
    end)
    task.wait(0.3)
    pcall(function()
        local cBtn2 = PlayerGui.RewardGui.RewardPanel.Header.CloseBtn
        firesignal(cBtn2.MouseButton1Click)
        print("🎁 Close RewardGui")
    end)
    
    task.wait(1)

    -- 8. Teleport Back
    hrp.CFrame = originalCFrame
    print("🔙 Kembali ke posisi awal!")

    shared.isDoingEvent = false
    print("▶️ Instant Fishing dilanjutkan!")
end

local function scanActiveEvent()
    -- print("🔍 Scan event points...")
    if selectedEvents["Windah"] then
        local eventPoints = workspace:FindFirstChild("Event") and workspace.Event:FindFirstChild("WindahEvent")
        if eventPoints then
            for i, point in ipairs(eventPoints:GetChildren()) do
                for _, child in ipairs(point:GetChildren()) do
                    if child.Name:find("SeaMonsterTitleAnchor_") then
                        local bossName = child.Name:gsub("SeaMonsterTitleAnchor_", "")
                        print("🎯 Event aktif ditemukan di point #" .. i .. " | Boss:", bossName)
                        task.spawn(handleEvent, child.Position, bossName)
                        return true
                    end
                end
            end
        end
    end

    if selectedEvents["Losi"] then
        local ok, losiPillar = pcall(function()
            return workspace.BossEventMarker_Losi_Clown.BossEventPillar
        end)
        if ok and losiPillar then
            print("🎯 Losi event aktif!")
            task.spawn(handleEvent, losiPillar.Position, "Losi_Clown")
            return true
        end
    end

    -- print("❌ Ga ada event aktif yang dipilih saat ini")
    return false
end

AutoEventSection:Toggle({
    Title = "Enable Auto Event",
    Icon = "zap",
    Default = false,
    Callback = function(state)
        autoEventEnabled = state
        if state then
            local RS = game:GetService("ReplicatedStorage")
            local Knit = RS.Packages._Index["sleitnick_knit@1.7.0"].knit.Services
            local EVENT_ANNOUNCE = Knit.BossFishEventService.RE.EventAnnounce
            
            print("👂 Listen EventAnnounce...")
            eventAnnounceConn = EVENT_ANNOUNCE.OnClientEvent:Connect(function(data)
                if not autoEventEnabled then return end
                print("📢 EVENT ANNOUNCE!")
                print("   Boss:", data.BossDisplayName, "(" .. data.BossName .. ")")
                print("   State:", data.CurrentState)
                
                local bName = (data.BossName or ""):lower()
                local isWindah = bName:find("windah") and selectedEvents["Windah"]
                local isLosi = bName:find("losi") and selectedEvents["Losi"]
                
                if (isWindah or isLosi) and (data.CurrentState == "Announcing" or data.CurrentState == "Gathering") then
                    local eventPos = Vector3.new(
                        data.EventPosition[1],
                        data.EventPosition[2],
                        data.EventPosition[3]
                    )
                    print("📍 Event Position:", eventPos)
                    task.spawn(handleEvent, eventPos, data.BossName)
                end
            end)
            
            print("✅ Auto Event aktif, nunggu event...")
            task.spawn(function()
                while autoEventEnabled do
                    if not shared.isDoingEvent then
                        scanActiveEvent()
                    end
                    task.wait(3)
                end
            end)
        else
            if eventAnnounceConn then
                eventAnnounceConn:Disconnect()
                eventAnnounceConn = nil
            end
            -- Reset flag biar bisa deteksi event lagi kalau toggle dihidupin balik
            shared.isDoingEvent = false
            print("❌ Auto Event mati")
        end
    end
})

AutoEventSection:Button({
    Title = "Teleport Now",
    Callback = function()
        scanActiveEvent()
    end
})

---teleportIsland
local TeleportIslandSection = TeleportTab:Section({ Title = "Teleport Island", Box = true, TextXAlignment = "Center", TextSize = 15, Opened = true })

-- =============================================
-- Settings Tab
-- =============================================

local SettingsTab = Window:Tab({
    Title = "Settings",
    Icon = "lucide:settings",
    IconColor = Mains,
    IconShape = "Square",
    Border = true,
})

local SettingsSection = SettingsTab:Section({ Title = "Protection", Box = true, TextXAlignment = "Center", TextSize = 15, Opened = false })

-- =============================================
-- ANTI-AFK MODULE
-- =============================================
local AntiAFK = (function()
    local AA = {
        Enabled = false,
        Thread = nil,
        Conn = nil,
    }

    function AA.Start()
        if AA.Enabled then return end
        AA.Enabled = true

        local VirtualUser = game:GetService("VirtualUser")
        
        -- Bypass Anti-AFK Roblox native yang paling ampuh (jalan di background saat idled)
        AA.Conn = game:GetService("Players").LocalPlayer.Idled:Connect(function()
            if AA.Enabled then
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
                print("[Anti-AFK] Roblox Idle bypassed!")
            end
        end)

        AA.Thread = task.spawn(function()
            while AA.Enabled do
                task.wait(600)
                if not AA.Enabled then break end
                pcall(function()
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton2(Vector2.new())
                end)
            end
        end)
    end

    function AA.Stop()
        if not AA.Enabled then return end
        AA.Enabled = false
        if AA.Thread then
            task.cancel(AA.Thread)
            AA.Thread = nil
        end
        if AA.Conn then
            AA.Conn:Disconnect()
            AA.Conn = nil
        end
    end

    return AA
end)()

SettingsSection:Toggle({
    Title = "Anti-AFK",
    Icon = "shield-check",
    Default = false,
    Callback = function(state)
        if state then
            AntiAFK.Start()
            print("[Anti-AFK] Activated!")
        else
            AntiAFK.Stop()
            print("[Anti-AFK] Deactivated!")
        end
    end
})

-- =============================================
-- ANTI-ADMIN MODULE
-- =============================================
local AntiAdmin = (function()
    local AA = {
        Enabled = false,
        Conns = {},
        Kicked = false
    }

    local function isAdmin(player)
        return player:GetAttribute("IsAdmin") == true
            or player:GetAttribute("IsPrimaryAdmin") == true
            or (player:GetAttribute("AdminAccess") ~= nil and player:GetAttribute("AdminAccess") ~= "")
    end

    local function safeKick(reason)
        warn("🚨 " .. reason)
        warn("🚪 Auto-kick untuk keamanan!")
        local LP = game:GetService("Players").LocalPlayer
        LP:Kick("🚨 SAFETY KICK\n" .. reason .. "\nScript otomatis keluar untuk keamanan.")
    end

    local function checkAdmin(player, context)
        if AA.Kicked then return end
        local LP = game:GetService("Players").LocalPlayer
        if player == LP then return end
        if isAdmin(player) then
            AA.Kicked = true
            safeKick("ADMIN/STAFF TERDETEKSI!\nNama: " .. player.Name .. "\nKonteks: " .. context)
        end
    end

    function AA.Start()
        if AA.Enabled then return end
        AA.Enabled = true
        AA.Kicked = false

        local Players = game:GetService("Players")
        local LP = Players.LocalPlayer

        -- Scan sekarang
        for _, player in ipairs(Players:GetPlayers()) do
            if player == LP then
                print("✅ " .. player.Name .. " = kamu sendiri")
            elseif isAdmin(player) then
                checkAdmin(player, "Already in server")
            else
                print("✅ " .. player.Name .. " = player biasa")
            end
        end

        -- Listen player baru join
        table.insert(AA.Conns, Players.PlayerAdded:Connect(function(player)
            if not AA.Enabled then return end
            task.wait(1)
            checkAdmin(player, "Baru join server")

            table.insert(AA.Conns, player:GetAttributeChangedSignal("IsAdmin"):Connect(function()
                if AA.Enabled then checkAdmin(player, "IsAdmin berubah jadi true") end
            end))
            table.insert(AA.Conns, player:GetAttributeChangedSignal("IsPrimaryAdmin"):Connect(function()
                if AA.Enabled then checkAdmin(player, "IsPrimaryAdmin berubah jadi true") end
            end))
            table.insert(AA.Conns, player:GetAttributeChangedSignal("AdminAccess"):Connect(function()
                if AA.Enabled then checkAdmin(player, "AdminAccess berubah") end
            end))
        end))

        -- Listen attribute player yang udah ada
        for _, player in ipairs(Players:GetPlayers()) do
            if player == LP then continue end
            table.insert(AA.Conns, player:GetAttributeChangedSignal("IsAdmin"):Connect(function()
                if AA.Enabled then checkAdmin(player, "IsAdmin berubah jadi true") end
            end))
            table.insert(AA.Conns, player:GetAttributeChangedSignal("IsPrimaryAdmin"):Connect(function()
                if AA.Enabled then checkAdmin(player, "IsPrimaryAdmin berubah jadi true") end
            end))
            table.insert(AA.Conns, player:GetAttributeChangedSignal("AdminAccess"):Connect(function()
                if AA.Enabled then checkAdmin(player, "AdminAccess berubah") end
            end))
        end
        print("🛡️ Anti-Admin aktif! Auto-kick kalau ada admin masuk.")
    end

    function AA.Stop()
        if not AA.Enabled then return end
        AA.Enabled = false
        for _, conn in ipairs(AA.Conns) do
            if conn then conn:Disconnect() end
        end
        AA.Conns = {}
        print("🛡️ Anti-Admin mati!")
    end


    return AA
end)()

SettingsSection:Toggle({
    Title = "Anti Staff/Admin",
    Icon = "shield",
    Default = false,
    Callback = function(state)
        if state then
            AntiAdmin.Start()
        else
            AntiAdmin.Stop()
        end
    end
})

local ConfigSection = SettingsTab:Section({ Title = "Config", Box = true, TextXAlignment = "Center", TextSize = 15, Opened = false })

ConfigSection:Button({
    Title = "Copy Your Config",
    Icon = "copy",
    Callback = function()
        if setclipboard and HttpService then
            local success, jsonStr = pcall(function() return HttpService:JSONEncode(uiConfig) end)
            if success and jsonStr then
                setclipboard(jsonStr)
                WindUI:Notify({
                    Title = "Config",
                    Content = "Config berhasil dicopy ke clipboard!",
                    Duration = 3,
                    Icon = "copy",
                })
            else
                WindUI:Notify({
                    Title = "Config",
                    Content = "Gagal meng-copy config!",
                    Duration = 3,
                    Icon = "x",
                })
            end
        else
            WindUI:Notify({
                Title = "Config",
                Content = "Executor tidak support setclipboard!",
                Duration = 3,
                Icon = "x",
            })
        end
    end
})

local sharedConfigInput = ""

ConfigSection:Input({
    Title = "Load Config (Paste Here)",
    Type = "Input",
    Placeholder = "Paste config JSON disini...",
    Callback = function(v)
        sharedConfigInput = v:gsub("^%s*(.-)%s*$", "%1")
    end
})

ConfigSection:Button({
    Title = "Load Config",
    Icon = "download",
    Callback = function()
        if sharedConfigInput and sharedConfigInput ~= "" then
            local success, decoded = pcall(function() return HttpService:JSONDecode(sharedConfigInput) end)
            if success and type(decoded) == "table" then
                uiConfig = decoded
                saveUIConfig(uiConfig)
                WindUI:Notify({
                    Title = "Config",
                    Content = "Config berhasil di-load! Silakan re-execute script untuk melihat perubahannya.",
                    Duration = 5,
                    Icon = "check",
                })
            else
                WindUI:Notify({
                    Title = "Config",
                    Content = "Gagal meload config! Pastikan format JSON valid.",
                    Duration = 3,
                    Icon = "x",
                })
            end
        else
            WindUI:Notify({
                Title = "Config",
                Content = "Input config kosong!",
                Duration = 3,
                Icon = "x",
            })
        end
    end
})

ConfigSection:Button({
    Title = "Restore Config Default",
    Icon = "refresh-cw",
    Callback = function()
        uiConfig = {}
        saveUIConfig(uiConfig)
        WindUI:Notify({
            Title = "Config",
            Content = "Config dikembalikan ke default! Silakan re-execute script.",
            Duration = 5,
            Icon = "refresh-cw",
        })
    end
})

local CostumSection = SettingsTab:Section({ Title = "Costum Settings", Box = true, TextXAlignment = "Center", TextSize = 15, Opened = false })

-- =============================================
-- HIDE STATS MODULE (w/ Verified Badge)
-- =============================================
-- =============================================
-- HIDE STATS MODULE (w/ Verified Badge + Fake Level)
-- =============================================
local HideStats = (function()
    local M = {
        Enabled = false,
        FakeName = "King Vypers",
        FakeLevel = "Lvl. 99",
        UseAltBadge = false,
        Conns = {},
        TextConns = {}
    }

    local lp = game:GetService("Players").LocalPlayer
    local Workspace = game:GetService("Workspace")

    local BADGE = utf8.char(0xE000)
    local BADGE_ALT = "✓"

    local function getBadge()
        return M.UseAltBadge and BADGE_ALT or BADGE
    end

    local function getTargetDisplay()
        return M.FakeName .. " " .. getBadge()
    end

    -- Spoof NameLabel
    local function spoofText(obj)
        if not obj or not obj.Parent then return end
        local ok, text = pcall(function() return obj.Text end)
        if not ok or not text or text == "" then return end

        local target = getTargetDisplay()
        local realName = lp.Name
        local realDisplay = lp.DisplayName

        if text:find(target, 1, true) then return end

        local newText = text
        if newText:find(realDisplay, 1, true) then
            newText = newText:gsub(realDisplay, target)
        end
        if newText:find(realName, 1, true) then
            newText = newText:gsub(realName, M.FakeName)
        end

        if newText ~= text then
            pcall(function() obj.Text = newText end)
        end
    end

    -- Spoof LevelLabel
    local function spoofLevel(obj)
        if not obj or not obj.Parent then return end
        local ok, text = pcall(function() return obj.Text end)
        if not ok or not text or text == "" then return end
        if text == M.FakeLevel then return end
        -- Cek format "Lvl. X" atau "Lv X"
        if text:match("Lvl%.") or text:match("Lv%s") then
            pcall(function() obj.Text = M.FakeLevel end)
        end
    end

    local function monitorObj(obj)
        if not (obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox")) then return end

        if obj.Name == "LevelLabel" then
            spoofLevel(obj)
            local c = obj:GetPropertyChangedSignal("Text"):Connect(function()
                if M.Enabled then spoofLevel(obj) end
            end)
            table.insert(M.TextConns, c)
        else
            spoofText(obj)
            local c = obj:GetPropertyChangedSignal("Text"):Connect(function()
                if M.Enabled then spoofText(obj) end
            end)
            table.insert(M.TextConns, c)
        end
    end

    local function monitorBillboard(billboard)
        for _, textObj in ipairs(billboard:GetDescendants()) do
            if textObj:IsA("TextLabel") then
                if textObj.Name == "LevelLabel" then
                    spoofLevel(textObj)
                    local c = textObj:GetPropertyChangedSignal("Text"):Connect(function()
                        if M.Enabled then spoofLevel(textObj) end
                    end)
                    table.insert(M.TextConns, c)
                else
                    pcall(function() textObj.Text = getTargetDisplay() end)
                    local c = textObj:GetPropertyChangedSignal("Text"):Connect(function()
                        if M.Enabled then pcall(function() textObj.Text = getTargetDisplay() end) end
                    end)
                    table.insert(M.TextConns, c)
                end
            end
        end
        local c = billboard.DescendantAdded:Connect(function(obj)
            if obj:IsA("TextLabel") and M.Enabled then
                task.wait(0.1)
                if obj.Name == "LevelLabel" then
                    pcall(function() obj.Text = M.FakeLevel end)
                else
                    pcall(function() obj.Text = getTargetDisplay() end)
                end
            end
        end)
        table.insert(M.TextConns, c)
    end

    local function monitorCharacter(char)
        local hum = char:WaitForChild("Humanoid", 10)
        if hum then
            pcall(function() hum.DisplayName = getTargetDisplay() end)
            local c = hum:GetPropertyChangedSignal("DisplayName"):Connect(function()
                if M.Enabled then
                    pcall(function()
                        if hum.DisplayName ~= getTargetDisplay() then
                            hum.DisplayName = getTargetDisplay()
                        end
                    end)
                end
            end)
            table.insert(M.TextConns, c)
        end

        task.wait(0.5)
        for _, obj in ipairs(char:GetDescendants()) do
            if obj:IsA("BillboardGui") then
                monitorBillboard(obj)
            end
        end
    end

    local function scanWorkspace()
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("BillboardGui") then
                for _, textObj in ipairs(obj:GetDescendants()) do
                    if textObj:IsA("TextLabel") then
                        local txt = textObj.Text
                        if txt:find(lp.Name, 1, true) or txt:find(lp.DisplayName, 1, true)
                        or txt:match("Lvl%.") or txt:match("Lv%s") then
                            monitorBillboard(obj)
                            break
                        end
                    end
                end
            end
        end
    end

    local function spoofChat()
        pcall(function()
            local TCS = game:GetService("TextChatService")
            if TCS.ChatVersion == Enum.ChatVersion.TextChatService then
                TCS.OnIncomingMessage = function(message)
                    local props = Instance.new("TextChatMessageProperties")
                    if message.TextSource and message.TextSource.UserId == lp.UserId then
                        props.PrefixText = getTargetDisplay()
                    end
                    return props
                end
            end
        end)
    end

    function M.Enable()
        M.Enabled = true

        for _, v in ipairs(lp.PlayerGui:GetDescendants()) do monitorObj(v) end
        local c1 = lp.PlayerGui.DescendantAdded:Connect(monitorObj)
        table.insert(M.TextConns, c1)

        pcall(function()
            local CoreGui = game:GetService("CoreGui")
            for _, v in ipairs(CoreGui:GetDescendants()) do monitorObj(v) end
            local c = CoreGui.DescendantAdded:Connect(monitorObj)
            table.insert(M.TextConns, c)
        end)

        if lp.Character then monitorCharacter(lp.Character) end
        local c2 = lp.CharacterAdded:Connect(function(char)
            if M.Enabled then monitorCharacter(char) end
        end)
        table.insert(M.TextConns, c2)

        scanWorkspace()
        local c3 = Workspace.DescendantAdded:Connect(function(obj)
            if not M.Enabled then return end
            if obj:IsA("BillboardGui") then
                task.wait(0.5)
                monitorBillboard(obj)
            end
        end)
        table.insert(M.TextConns, c3)

        spoofChat()
    end

    function M.Disable()
        M.Enabled = false

        for _, c in ipairs(M.TextConns) do
            pcall(function() c:Disconnect() end)
        end
        M.TextConns = {}

        if lp.Character then
            local hum = lp.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                pcall(function() hum.DisplayName = lp.DisplayName end)
            end
            for _, obj in ipairs(lp.Character:GetDescendants()) do
                if obj:IsA("TextLabel") then
                    if obj.Name == "NameLabel" then
                        pcall(function() obj.Text = lp.DisplayName end)
                    elseif obj.Name == "LevelLabel" then
                        -- Biarkan game yang restore, atau force refresh
                        pcall(function() obj.Text = "Lvl. ?" end)
                    end
                end
            end
        end

        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("TextLabel") then
                if obj.Name == "NameLabel" and obj.Text:find(M.FakeName, 1, true) then
                    pcall(function() obj.Text = lp.DisplayName end)
                elseif obj.Name == "LevelLabel" and obj.Text == M.FakeLevel then
                    pcall(function() obj.Text = "Lvl. ?" end)
                end
            end
        end

        pcall(function()
            local TCS = game:GetService("TextChatService")
            if TCS.ChatVersion == Enum.ChatVersion.TextChatService then
                TCS.OnIncomingMessage = nil
            end
        end)
    end

    function M.SetFakeName(val)
        M.FakeName = val
    end

    function M.SetFakeLevel(val)
        M.FakeLevel = val
    end

    return M
end)()

-- =============================================
-- UI
-- =============================================
local hideStatsToggle = CostumSection:Toggle({
    Title = "Enable Hide Stats",
    Default = uiConfig.HideStats or false,
    Callback = function(on)
        if not isUILoading then
            uiConfig.HideStats = on
            saveUIConfig(uiConfig)
        end
        if on then HideStats.Enable() else HideStats.Disable() end
    end
})

if uiConfig.HideStats then HideStats.Enable() end

local fakeNameInput = CostumSection:Input({
    Type = "Input",
    Title = "Fake Name",
    Value = uiConfig.FakeName or "King Vypers",
    Placeholder = "Nama palsu",
    Callback = function(value)
        HideStats.SetFakeName(value)
        if not isUILoading then
            uiConfig.FakeName = value
            saveUIConfig(uiConfig)
        end
    end
})
HideStats.SetFakeName(uiConfig.FakeName or "King Vypers")

local fakeLevelInput = CostumSection:Input({
    Type = "Input",
    Title = "Fake Level",
    Value = uiConfig.FakeLevel or "Lvl. 99",
    Placeholder = "Contoh: Lvl. 99",
    Callback = function(value)
        HideStats.SetFakeLevel(value)
        if not isUILoading then
            uiConfig.FakeLevel = value
            saveUIConfig(uiConfig)
        end
    end
})
HideStats.SetFakeLevel(uiConfig.FakeLevel or "Lvl. 99")
-- =============================================
-- Webhook Tab
-- =============================================

local WebhookTab = Window:Tab({
    Title = "webhook",
    Icon = "lucide:webhook",
    IconColor = Mains,
    IconShape = "Square",
    Border = true,
})
-- =============================================
-- WEBHOOK MODULE
-- =============================================
local WebhookModule = (function()
    local M = {}

    -- Cari HTTP request function yang tersedia
    local function getHTTPRequest()
        local funcs = { request, http_request,
            (syn and syn.request),
            (fluxus and fluxus.request),
            (http and http.request),
            (solara and solara.request),
        }
        for _, f in ipairs(funcs) do
            if f and type(f) == "function" then return f end
        end
        return nil
    end
    local httpRequest = getHTTPRequest()
    local HttpService = game:GetService("HttpService")

    -- Config
    M.FishConfig = {
        WebhookURL = "",
        DiscordUserID = "",
        HideIdentity = "",
        EnabledRarities = {},
    }
    M.DisconnectConfig = {
        WebhookURL = "",
        DiscordUserID = "",
        HideIdentity = "",
        Enabled = false
    }

    local RARITY_COLORS = {
        Common    = 9807270,
        Uncommon  = 3066993,
        Rare      = 3447003,
        Epic      = 10181046,
        Legendary = 15844367,
        Mythic    = 16711680,
        Secret    = 65535,
        Monster   = 16711935,
    }

    local isFishRunning = false
    local fishEventConn = nil
    local isDisconnectEnabled = false
    local disconnectSetup = false

    local function getDisplayName(config)
        if config.HideIdentity and config.HideIdentity ~= "" then
            return config.HideIdentity
        end
        local lp = game:GetService("Players").LocalPlayer
        return lp.DisplayName or lp.Name
    end

    -- Ambil URL gambar dari ImageID rbxassetid via Roblox API
    local function getImageUrl(imageID)
        if not imageID then return "https://i.imgur.com/UMWNYK7.png" end
        local id = tostring(imageID):match("%d+")
        if not id then return "https://i.imgur.com/UMWNYK7.png" end
        
        local thumbnailUrl = string.format(
            "https://thumbnails.roblox.com/v1/assets?assetIds=%s&returnPolicy=PlaceHolder&size=420x420&format=Png&isCircular=false",
            id
        )
        
        if httpRequest then
            local success, result = pcall(function()
                local response = httpRequest({ Url = thumbnailUrl, Method = "GET" })
                if response and response.Body then
                    local data = HttpService:JSONDecode(response.Body)
                    if data and data.data and data.data[1] and data.data[1].imageUrl then
                        return data.data[1].imageUrl
                    end
                end
            end)
            if success and result then return result end
        end
        
        return "https://tr.rbxcdn.com/180DAY-" .. id .. "/420/420/Image/Png"
    end

    local function formatPrice(price)
        local formatted = tostring(math.floor(tonumber(price) or 0))
        return formatted:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
    end

    local function sendFishWebhook(data)
        if not M.FishConfig.WebhookURL or M.FishConfig.WebhookURL == "" then return end
        if not httpRequest then return end

        local fishData = data.FishData or {}
        local rarity = fishData.Rarity or "Common"
        local color = RARITY_COLORS[rarity] or RARITY_COLORS.Common

        -- Filter rarity
        local enabledRarities = M.FishConfig.EnabledRarities
        if enabledRarities and next(enabledRarities) then
            local hasFilter = false
            local passed = false
            for k, v in pairs(enabledRarities) do
                hasFilter = true
                local r = (type(k) == "string" and v == true) and k or v
                if r == rarity then passed = true break end
            end
            if hasFilter and not passed then return end
        end

        local playerName = getDisplayName(M.FishConfig)
        local mention = M.FishConfig.DiscordUserID ~= "" and "<@" .. M.FishConfig.DiscordUserID .. ">" or ""
        local imageUrl = getImageUrl(fishData.ImageID)

        local fishName = fishData.Name or data.FishID or "Unknown"
        local weightStr = data.WeightFormatted or (string.format("%.2f Kg", data.Weight or 0))
        local weightTier = data.WeightTier or "-"
        local price = formatPrice(data.Price or fishData.Price or 0)
        local basePrice = formatPrice(fishData.Price or 0)

        local payload = {
            username = "King Vypers",
            avatar_url = "https://raw.githubusercontent.com/semuao621-wq/Kamunanya/main/Kingvyperslogo.jpg",
            content = mention ~= "" and (mention .. " **" .. playerName .. "** caught a **" .. rarity .. "** fish!") or nil,
            embeds = {{
                author = { name = "King Vypers | Fish Caught" },
                color = color,
                fields = {
                    { name = "🐟 Fish Name",   value = "```" .. fishName .. "```",  inline = false },
                    { name = "⭐ Rarity",       value = "```" .. rarity .. "```",    inline = true  },
                    { name = "⚖️ Weight",       value = "```" .. weightStr .. "```", inline = true  },
                    { name = "🏆 Weight Tier",  value = "```" .. weightTier .. "```",inline = true  },
                    { name = "💰 Base Price",   value = "```$" .. basePrice .. "```",inline = true  },
                    { name = "💸 Sold For",     value = "```$" .. price .. "```",    inline = true  },
                    { name = "👤 Player",       value = "```" .. playerName .. "```",inline = true  },
                },
                image = { url = imageUrl },
                footer = {
                    text = "King Vypers • " .. os.date("%m/%d/%Y at %I:%M %p"),
                    icon_url = "https://raw.githubusercontent.com/semuao621-wq/Kamunanya/main/Kingvyperslogo.jpg"
                },
                timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
            }}
        }

        pcall(function()
            httpRequest({
                Url = M.FishConfig.WebhookURL,
                Method = "POST",
                Headers = { ["Content-Type"] = "application/json" },
                Body = HttpService:JSONEncode(payload)
            })
        end)
    end

    local function sendDisconnectWebhook(reason)
        if not isDisconnectEnabled then return end
        local url = M.DisconnectConfig.WebhookURL
        if not url or url == "" then return end
        if not httpRequest then return end

        local playerName = getDisplayName(M.DisconnectConfig)
        local mention = M.DisconnectConfig.DiscordUserID ~= ""
            and "<@" .. M.DisconnectConfig.DiscordUserID:gsub("%D", "") .. ">"
            or ""

        local payload = {
            content = mention ~= "" and (mention .. " Account disconnected!") or nil,
            username = "King Vypers",
            avatar_url = "https://raw.githubusercontent.com/semuao621-wq/Kamunanya/main/Kingvyperslogo.jpg",
            embeds = {{
                author = { name = "King Vypers | Disconnect Alert" },
                title = "⚠️ Connection Lost",
                description = "Roblox session disconnected. Attempting rejoin...",
                color = 16711680,
                fields = {
                    { name = "👤 Account", value = "```" .. playerName .. "```", inline = true },
                    { name = "🕐 Time",    value = "```" .. os.date("%m/%d/%Y at %I:%M %p") .. "```", inline = true },
                    { name = "📋 Reason",  value = "```" .. (reason or "Disconnected") .. "```", inline = false },
                },
                footer = {
                    text = "King Vypers • Auto-rejoin enabled",
                    icon_url = "https://raw.githubusercontent.com/semuao621-wq/Kamunanya/main/Kingvyperslogo.jpg"
                },
                timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
            }}
        }

        task.spawn(function()
            pcall(function()
                httpRequest({
                    Url = url, Method = "POST",
                    Headers = { ["Content-Type"] = "application/json" },
                    Body = HttpService:JSONEncode(payload)
                })
            end)
        end)
    end

    local function setupDisconnectDetection()
        if disconnectSetup then return end
        disconnectSetup = true
        local done = false

        local function handleDisconnect(reason)
            if not done and isDisconnectEnabled then
                done = true
                sendDisconnectWebhook(reason or "Disconnected from server")
                task.wait(2)
                game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
            end
        end

        game:GetService("GuiService").ErrorMessageChanged:Connect(function(msg)
            if msg and msg ~= "" then handleDisconnect(msg) end
        end)
    end

    -- Public API
    function M:StartFishWebhook()
        if isFishRunning then return end
        if not httpRequest then print("[Webhook] HTTP ga tersedia!") return end
        if not self.FishConfig.WebhookURL or self.FishConfig.WebhookURL == "" then
            print("[Webhook] URL belum diisi!") return
        end

        local RS = game:GetService("ReplicatedStorage")
        local ok, FishCaught = pcall(function()
            return RS.Packages._Index["sleitnick_knit@1.7.0"].knit.Services.FishingRewardService.RE.FishCaught
        end)
        if not ok or not FishCaught then print("[Webhook] FishCaught event ga ketemu!") return end

        fishEventConn = FishCaught.OnClientEvent:Connect(function(data)
            task.spawn(sendFishWebhook, data)
        end)
        isFishRunning = true
        print("[Webhook] Fish Webhook ON!")
    end

    function M:StopFishWebhook()
        if not isFishRunning then return end
        if fishEventConn then fishEventConn:Disconnect() fishEventConn = nil end
        isFishRunning = false
        print("[Webhook] Fish Webhook OFF!")
    end

    function M:EnableDisconnectWebhook(enabled)
        self.DisconnectConfig.Enabled = enabled
        isDisconnectEnabled = enabled
        if enabled then setupDisconnectDetection() end
    end

    function M:TestFishWebhook()
        if not httpRequest then return end
        if not self.FishConfig.WebhookURL or self.FishConfig.WebhookURL == "" then return end
        pcall(function()
            httpRequest({
                Url = self.FishConfig.WebhookURL,
                Method = "POST",
                Headers = { ["Content-Type"] = "application/json" },
                Body = HttpService:JSONEncode({
                    username = "King Vypers",
                    avatar_url = "https://raw.githubusercontent.com/semuao621-wq/Kamunanya/main/Kingvyperslogo.jpg",
                    embeds = {{
                        title = "✅ Webhook Test Berhasil!",
                        description = "Fish Webhook sudah terhubung dan siap menerima notifikasi!",
                        color = 3066993,
                        footer = {
                            text = "King Vypers • Test",
                            icon_url = "https://raw.githubusercontent.com/semuao621-wq/Kamunanya/main/Kingvyperslogo.jpg"
                        },
                        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
                    }}
                })
            })
        end)
    end

    function M:TestDisconnectWebhook()
        sendDisconnectWebhook("Test - Simulasi Disconnect")
    end

    return M
end)()

-- =============================================
-- FISH CAUGHT WEBHOOK SECTION
-- =============================================
local FishWebhookSection = WebhookTab:Section({
    Title = "Fish Caught Webhook",
    Box = true, TextXAlignment = "Center", TextSize = 15, Opened = true,
})

local fishToggleRef = nil

FishWebhookSection:Input({
    Title = "Webhook URL",
    Type = "Input",
    Placeholder = "https://discord.com/api/webhooks/...",
    Callback = function(v)
        WebhookModule.FishConfig.WebhookURL = v:gsub("^%s*(.-)%s*$", "%1")
    end,
})

FishWebhookSection:Input({
    Title = "Discord User ID",
    Type = "Input",
    Placeholder = "123456789012345678",
    Callback = function(v)
        WebhookModule.FishConfig.DiscordUserID = v:gsub("^%s*(.-)%s*$", "%1")
    end,
})

FishWebhookSection:Input({
    Title = "Custom Name",
    Type = "Input",
    Placeholder = "Masukkan nama custom...",
    Callback = function(v)
        WebhookModule.FishConfig.HideIdentity = v:gsub("^%s*(.-)%s*$", "%1")
    end,
})

FishWebhookSection:Dropdown({
    Title = "Filter Rarity (kosong = semua)",
    Values = { "Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Secret", "Monster" },
    Value = {},
    AllowNone = true,
    Multi = true,
    Callback = function(selected)
        local rarityMap = {}
        if type(selected) == "table" then
            for _, v in ipairs(selected) do
                rarityMap[v] = true
            end
        end
        WebhookModule.FishConfig.EnabledRarities = rarityMap
    end,
})

fishToggleRef = FishWebhookSection:Toggle({
    Title = "Enable Fish Webhook",
    Icon = "zap",
    Default = false,
    Callback = function(state)
        if state then
            if WebhookModule.FishConfig.WebhookURL == "" then
                print("[Webhook] URL belum diisi!")
                fishToggleRef:Set(false)
                return
            end
            WebhookModule:StartFishWebhook()
        else
            WebhookModule:StopFishWebhook()
        end
    end,
})

FishWebhookSection:Button({
    Title = "Test Fish Webhook",
    Callback = function()
        WebhookModule:TestFishWebhook()
    end,
})

-- =============================================
-- DISCONNECT WEBHOOK SECTION
-- =============================================
local DisconnectSection = WebhookTab:Section({
    Title = "Disconnect Webhook",
    Box = true, TextXAlignment = "Center", TextSize = 15, Opened = false,
})

DisconnectSection:Input({
    Title = "Webhook URL",
    Type = "Input",
    Placeholder = "https://discord.com/api/webhooks/...",
    Callback = function(v)
        WebhookModule.DisconnectConfig.WebhookURL = v:gsub("^%s*(.-)%s*$", "%1")
    end,
})

DisconnectSection:Input({
    Title = "Discord User ID",
    Type = "Input",
    Placeholder = "123456789012345678",
    Callback = function(v)
        WebhookModule.DisconnectConfig.DiscordUserID = v:gsub("^%s*(.-)%s*$", "%1")
    end,
})

DisconnectSection:Input({
    Title = "Custom Name",
    Type = "Input",
    Placeholder = "Masukkan nama custom...",
    Callback = function(v)
        WebhookModule.DisconnectConfig.HideIdentity = v:gsub("^%s*(.-)%s*$", "%1")
    end,
})

DisconnectSection:Toggle({
    Title = "Enable Disconnect Webhook",
    Icon = "wifi-off",
    Default = false,
    Callback = function(state)
        WebhookModule:EnableDisconnectWebhook(state)
    end,
})

DisconnectSection:Button({
    Title = "Test Disconnect Webhook",
    Callback = function()
        WebhookModule:TestDisconnectWebhook()
    end,
})

task.spawn(function()
    task.wait(1)
    isUILoading = false
end)
