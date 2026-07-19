local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
--Nonaktifkan print & warn untuk modul ini agar console tidak spam
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
    Title = "BETA",
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


local instantFishEnabled = false
local instantFishTask = nil

InstantFishSection:Toggle({
    Title = "Instant Fishing",
    Icon = "zap",
    Default = false,
    Callback = function(state)
        instantFishEnabled = state

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
                local DISCONNECT_RESTORE = RewardRF.StageFishingDisconnectRestore
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
                local resolvedConn
                resolvedConn = PULL_STATE_EVENT.OnClientEvent:Connect(function(data)
                    if type(data) == "table" and data.sessionId and data.type == "resolved" then
                        isResolved = true
                    end
                end)

                while instantFishEnabled do
                    isResolved = false
                    local playerPos, castPos, rodName = getCastPos()

                    -- 1. StartFishing
                    pcall(function() START_FISHING:InvokeServer(rodName, FLOATER) end)
                    task.wait(0.3)

                    -- 2. ThrowFloater
                    pcall(function() THROW_FLOATER:InvokeServer(playerPos, castPos, rodName, FLOATER, FLOATER_PROPS, 10) end)
                    task.wait(0.3)

                    -- 2.5 Restore Disconnect (New Fisch Update)
                    pcall(function() DISCONNECT_RESTORE:InvokeServer(castPos) end)
                    task.wait(0.1)

                    -- 3. ConfirmFloatingCast
                    pcall(function() CONFIRM_CAST:InvokeServer(castPos) end)
                    task.wait(0.3)

                    -- 4. RequestFishBite -> ambil SessionId dari response!
                    local sessionId = nil
                    local ok, result = pcall(function() return REQUEST_FISH_BITE:InvokeServer(castPos) end)
                    if ok and type(result) == "table" and result.SessionId then
                        sessionId = result.SessionId
                        print("[Instant Fish] Session:", sessionId)
                    end
                    task.wait(0.1)

                    -- 5. StartPulling
                    pcall(function() START_PULLING:InvokeServer() end)
                    task.wait(0.1)

                    -- 6. Spam tap sampai resolved!
                    if sessionId then
                        pcall(function() FISHING_PULL_INPUT:InvokeServer(sessionId, "begin") end)
                        task.wait(0.05)

                        local waitStart = tick()
                        while not isResolved and instantFishEnabled and tick() - waitStart < 15 do
                            task.spawn(function()
                                for i = 1, 5 do
                                    pcall(function() FISHING_PULL_INPUT:InvokeServer(sessionId, "tap") end)
                                end
                            end)
                            task.wait()
                        end

                        print("[Instant Fish] Selesai! resolved:", isResolved)
                    else
                        print("[Instant Fish] Gagal dapet SessionId, skip...")
                    end

                    -- Stop & jeda
                    pcall(function() STOP_FISHING:InvokeServer() end)
                    task.wait(2)
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

    local function getChar()
        local char = LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hum or not hrp then return end
        return char, hum, hrp
    end

    -- Cek apakah tepat di bawah player itu air (bukan tanah/part lain)
    local function isAboveWater(hrp)
        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Blacklist
        params.FilterDescendantsInstances = { LocalPlayer.Character }
        params.IgnoreWater = false

        -- Cast pendek dari kaki ke bawah
        local result = Workspace:Raycast(
            hrp.Position,
            Vector3.new(0, -50, 0),
            params
        )

        if result then
            -- Kalau kena terrain, cek apakah materialnya air
            if result.Instance:IsA("Terrain") then
                return result.Material == Enum.Material.Water, result.Position.Y
            end
            -- Kena part biasa = tanah/darat
            return false, nil
        end

        -- Ga kena apa-apa = void, anggap bukan air
        return false, nil
    end

    local function getWaterY(hrp)
        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Blacklist
        params.FilterDescendantsInstances = { LocalPlayer.Character }
        params.IgnoreWater = false

        local result = Workspace:Raycast(
            hrp.Position + Vector3.new(0, 5, 0),
            Vector3.new(0, -500, 0),
            params
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
    end

    function M.Start()
        if M.Enabled then return end
        local _, hum, hrp = getChar()
        if not hum or not hrp then
            warn("[WOW] Karakter tidak ditemukan!") return
        end

        -- Paksa keluar swimming dulu
        if hum:GetState() == Enum.HumanoidStateType.Swimming then
            for _ = 1, 40 do
                hrp.Velocity = Vector3.new(hrp.Velocity.X, 60, hrp.Velocity.Z)
                task.wait(0.05)
                if hum:GetState() ~= Enum.HumanoidStateType.Swimming then break end
            end
            task.wait(0.1)
        end

        -- Simpan water Y saat Q ditekan
        WATER_Y = getWaterY(hrp)
        if not WATER_Y then
            warn("[WOW] Tidak ada air di bawah! Pindah ke area air dulu.")
            return
        end

        M.Enabled = true
        createPlatform()
        setupAlign(hrp)

        print("[WOW] ON - Water Y locked at:", WATER_Y)

        M.Connection = RunService.Heartbeat:Connect(function()
            if not M.Enabled then return end
            local _, _, curHRP = getChar()
            if not curHRP then return end

            local pos = curHRP.Position

            -- Cek apakah tepat di bawah player itu air atau bukan
            local aboveWater, _ = isAboveWater(curHRP)

            if aboveWater then
                -- Di atas air = lock ke water Y
                if M.Platform then
                    M.Platform.CFrame = CFrame.new(pos.X, WATER_Y - 0.5, pos.Z)
                end
                if M.AlignPos then
                    M.AlignPos.Position = Vector3.new(pos.X, WATER_Y + OFFSET, pos.Z)
                end
            else
                -- Di darat / gunung = bebasin player, sembunyiin platform
                if M.Platform then
                    M.Platform.CFrame = CFrame.new(pos.X, -9999, pos.Z)
                end
                if M.AlignPos then
                    -- Set ke posisi player saat ini biar ga narik kemana-mana
                    M.AlignPos.Position = pos
                end
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
    print("[AutoSell] Sedang mencari ikan di backpack...")
    local player = game:GetService("Players").LocalPlayer
    local backpack = player:FindFirstChild("Backpack")
    if not backpack then return end

    local SELL_RF = game:GetService("ReplicatedStorage").Packages._Index["sleitnick_knit@1.7.0"].knit.Services.FishermanShopService.RF.SellSelectedFish
    local toSell = {}

    -- 1. Scan dan simpan ID ikan yang terfavorit di dalam tas terlebih dahulu
    local currentFavorited = {}
    
    -- Cek dari memori tracker Auto Favorit
    for id, _ in pairs(favoritedFishTracker) do
        currentFavorited[id] = true
    end
    
    -- Cek dari attribute tas saat ini (jaga-jaga kalau gamenya update)
    for _, v in ipairs(backpack:GetChildren()) do
        local instId = v:GetAttribute("FishInstanceId")
        if instId then
            if v:GetAttribute("Favorited") or v:GetAttribute("Favorite") or v:GetAttribute("Locked") then
                currentFavorited[instId] = true
            elseif v:FindFirstChild("Favorited") or v:FindFirstChild("Favorite") or v:FindFirstChild("Locked") then
                currentFavorited[instId] = true
            else
                local cs = game:GetService("CollectionService")
                if cs:HasTag(v, "Favorite") or cs:HasTag(v, "Favorited") then
                    currentFavorited[instId] = true
                end
            end
        end
    end

    -- Cek dari UI FishCollectionGUI (User Logic)
    local pGui = player:FindFirstChild("PlayerGui")
    if pGui then
        local gui = pGui:FindFirstChild("FishCollectionGUI")
        if gui and gui:FindFirstChild("MainPanel") and gui.MainPanel:FindFirstChild("ContentFrame") then
            local contentFrame = gui.MainPanel.ContentFrame
            
            -- build list dari backpack untuk dicocokkan dengan UI
            local backpackList = {}
            for _, item in ipairs(backpack:GetChildren()) do
                local fId = item:GetAttribute("FishId")
                local instId = item:GetAttribute("FishInstanceId")
                if fId and instId then
                    table.insert(backpackList, {
                        fishId = fId,
                        instanceId = instId,
                        used = false
                    })
                end
            end

            -- kumpulkan card dan urutkan berdasarkan LayoutOrder (agar urutannya sama persis dengan visual UI)
            local uiCards = {}
            for _, card in ipairs(contentFrame:GetChildren()) do
                if string.sub(card.Name, 1, 8) == "FishCard" then
                    table.insert(uiCards, card)
                end
            end
            
            table.sort(uiCards, function(a, b)
                local orderA = a:IsA("GuiObject") and a.LayoutOrder or 0
                local orderB = b:IsA("GuiObject") and b.LayoutOrder or 0
                return orderA < orderB
            end)

            -- scan card di GUI secara berurutan
            for _, card in ipairs(uiCards) do
                local favImg = card:FindFirstChild("Favorite")
                local isFav = favImg and favImg.Visible or false
                local cardName = string.gsub(card.Name, "FishCard_", "")

                -- cari match pertama yang belum dipakai
                -- [MASALAH Ikan Kembar]: Kita sort UI berdasarkan LayoutOrder supaya sinkron dengan urutan Backpack
                local cardInstId = card:GetAttribute("FishInstanceId") or card:GetAttribute("InstanceId") or card:GetAttribute("UUID")
                
                if cardInstId then
                    if isFav then
                        currentFavorited[cardInstId] = true
                    end
                else
                    for _, data in ipairs(backpackList) do
                        if not data.used and data.fishId == cardName then
                            data.used = true
                            if isFav then
                                currentFavorited[data.instanceId] = true
                            end
                            break
                        end
                    end
                end
            end
        end
    end

    -- 2. Lakukan Sell untuk ikan yang tidak ada di daftar favorit
    for _, v in ipairs(backpack:GetChildren()) do
        local rarity = v:GetAttribute("Rarity")
        local fishId = v:GetAttribute("FishId")
        local instanceId = v:GetAttribute("FishInstanceId")
        
        if rarity and fishId and instanceId and selectedRarities[rarity] and not currentFavorited[instanceId] then
            table.insert(toSell, {
                FishId = fishId,
                Count = 1,
                InstanceId = instanceId
            })
        end
    end

    if #toSell == 0 then
        print("[AutoSell] Ga ada ikan yang sesuai rarity terpilih!")
        return
    end

    print("[AutoSell] Selling " .. #toSell .. " ikan...")

    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:FindFirstChild("HumanoidRootPart")
    local originalCFrame = nil

    if hrp then
        originalCFrame = hrp.CFrame
        print("[AutoSell] Teleport ke lokasi sell...")
        hrp.CFrame = CFrame.new(280.2694396972656, 201.01766967773438, 1551.6795654296875)
        task.wait(1.5) -- Tunggu sampai server acknowledge posisi
    end

    -- Sell batch per 50
    local sold = 0
    for i = 1, #toSell, 50 do
        local batch = {}
        for j = i, math.min(i + 49, #toSell) do
            table.insert(batch, toSell[j])
        end
        local success, result = pcall(function()
            return SELL_RF:InvokeServer(batch)
        end)
        
        if success and result then
            sold += #batch
        end
        task.wait(0.2)
    end

    print("[AutoSell] Berhasil jual", sold, "ikan!")

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
    Icon = "crosshair",
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


local TeleportToEvent = TeleportTab:Section({ Title = "Teleport Event", Box = true, TextXAlignment = "Center", TextSize = 15, Opened = true })

local Players = game:GetService("Players")
local selectedEvent = nil
local autoTeleportEnabled = false
local autoTeleportConnection = nil

local eventList = Players.LocalPlayer.PlayerGui.EventHudGui.Root.EventPanel.EventList

-- ambil event dari GUI (hanya boss_fish, skip weather dll)
local function getEventNames()
    local names = {}
    for _, v in ipairs(eventList:GetChildren()) do
        if v:IsA("Frame") and v.Name:sub(1, 5) == "Card_" then
            -- ambil nama dari TextHolder.Name label
            local inner = v:FindFirstChild("Inner")
            if inner then
                local textHolder = inner:FindFirstChild("TextHolder")
                if textHolder then
                    local nameLabel = textHolder:FindFirstChild("Name")
                    if nameLabel then
                        table.insert(names, nameLabel.Text)
                    end
                end
            end
        end
    end
    if #names == 0 then
        table.insert(names, "No Event")
    end
    return names
end

-- cari folder di workspace.Event yang namanya mengandung eventName
local function getEventPosition(eventName)
    for _, folder in ipairs(workspace.Event:GetChildren()) do
        if folder.Name:lower():find(eventName:lower()) then
            local point = folder:FindFirstChild("Event Point")
            if point then
                return point.Position
            end
        end
    end
    return nil
end

local function teleportToEvent(eventName)
    local pos = getEventPosition(eventName)
    if not pos then
        warn("Event point tidak ditemukan untuk: " .. eventName)
        return
    end
    local char = Players.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
    end
end

-- Dropdown
local EventDropdown = TeleportToEvent:Dropdown({
    Title = "Select Event",
    Desc = "Pilih event dari HUD",
    Values = getEventNames(),
    Value = getEventNames()[1],
    Callback = function(option)
        selectedEvent = option
    end
})
selectedEvent = getEventNames()[1]

-- Refresh
TeleportToEvent:Button({
    Title = "Refresh Events",
    Desc = "Update list event dari HUD",
    Callback = function()
        local names = getEventNames()
        EventDropdown:SetValues(names)
        EventDropdown:SetValue(names[1])
        selectedEvent = names[1]
    end
})

-- Auto Teleport
TeleportToEvent:Toggle({
    Title = "Auto Teleport",
    Desc = "Auto teleport saat event baru muncul di HUD",
    Value = false,
    Callback = function(state)
        autoTeleportEnabled = state
        if state then
            autoTeleportConnection = eventList.ChildAdded:Connect(function(child)
                if not autoTeleportEnabled then return end
                task.wait(0.5)
                local inner = child:FindFirstChild("Inner")
                if inner then
                    local textHolder = inner:FindFirstChild("TextHolder")
                    if textHolder then
                        local nameLabel = textHolder:FindFirstChild("Name")
                        if nameLabel then
                            teleportToEvent(nameLabel.Text)
                        end
                    end
                end
            end)
        else
            if autoTeleportConnection then
                autoTeleportConnection:Disconnect()
                autoTeleportConnection = nil
            end
        end
    end
})

-- Teleport Now
TeleportToEvent:Button({
    Title = "Teleport Now",
    Desc = "Teleport ke event yang dipilih",
    Callback = function()
        if selectedEvent and selectedEvent ~= "No Event" then
            teleportToEvent(selectedEvent)
        end
    end
})
