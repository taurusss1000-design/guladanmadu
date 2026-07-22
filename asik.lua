-- ============================================================
-- 🧪 TEST UI WORKGUI + AUTO JAWAB
-- Standalone, bisa jalan langsung di executor
-- ============================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local playerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ============================================================
-- 🔍 DEBUG: Print semua UI di PlayerGui
-- ============================================================
print("\n" .. string.rep("=", 50))
print("🔍 SCANNING UI DI PlayerGui...")
print(string.rep("=", 50))

for _, gui in ipairs(playerGui:GetChildren()) do
    print("📁 ScreenGui:", gui.Name, "| Enabled:", gui.Enabled, "| Visible:", gui.Visible)
    
    -- Print semua children level 1
    for _, child in ipairs(gui:GetDescendants()) do
        if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("Frame") then
            local info = string.format("  └─ %s | %s | Visible: %s | Text: %s", 
                child.ClassName, 
                child.Name, 
                tostring(child.Visible),
                child:IsA("TextLabel") or child:IsA("TextButton") and tostring(child.Text):sub(1, 30) or "N/A"
            )
            print(info)
        end
    end
end
print(string.rep("=", 50) .. "\n")

-- ============================================================
-- 🧮 FUNGSI JAWAB SOAL
-- ============================================================
local function jawabSoal()
    -- Cari WorkGui
    local WorkGui = playerGui:FindFirstChild("WorkGui")
    if not WorkGui then
        warn("❌ WorkGui tidak ditemukan!")
        return false
    end
    
    print("\n" .. string.rep("-", 40))
    print("📋 WorkGui ditemukan!")
    print("   Enabled:", WorkGui.Enabled)
    
    -- Cari QuestionLabel
    local questionLabel = WorkGui:FindFirstChild("QuestionLabel", true)
    if not questionLabel then
        warn("❌ QuestionLabel tidak ditemukan!")
        -- Print semua TextLabel di WorkGui buat debug
        print("   TextLabel yang ada:")
        for _, obj in ipairs(WorkGui:GetDescendants()) do
            if obj:IsA("TextLabel") then
                print("     -", obj.Name, "| Text:", obj.Text, "| Visible:", obj.Visible)
            end
        end
        return false
    end
    
    print("   QuestionLabel ditemukan!")
    print("   Visible:", questionLabel.Visible)
    print("   Text:", questionLabel.Text)
    
    if not questionLabel.Visible or questionLabel.Text == "" then
        warn("⚠️ QuestionLabel kosong atau hidden!")
        return false
    end
    
    -- Parse soal: "5 + 3" atau "10 - 4" dll
    local a, op, b = string.match(questionLabel.Text, "(%d+)%s*([%+%-%*/])%s*(%d+)")
    if not a then
        warn("❌ Gagal parse soal! Format tidak dikenal:", questionLabel.Text)
        return false
    end
    
    local n1, n2 = tonumber(a), tonumber(b)
    local jawaban
    
    if op == "+" then jawaban = n1 + n2
    elseif op == "-" then jawaban = n1 - n2
    elseif op == "*" then jawaban = n1 * n2
    elseif op == "/" and n2 ~= 0 then jawaban = n1 / n2
    else
        warn("❌ Operator tidak valid:", op)
        return false
    end
    
    print("   🧮 Soal:", n1, op, n2, "=", jawaban)
    
    -- Cari tombol jawaban
    local frame = WorkGui:FindFirstChild("Frame", true)
    if not frame then
        warn("❌ Frame tidak ditemukan!")
        -- Print semua Frame di WorkGui
        print("   Frame yang ada:")
        for _, obj in ipairs(WorkGui:GetDescendants()) do
            if obj:IsA("Frame") then
                print("     -", obj.Name, "| Visible:", obj.Visible, "| Children:", #obj:GetChildren())
            end
        end
        return false
    end
    
    print("   Frame ditemukan:", frame.Name)
    
    -- Cari tombol dengan text = jawaban
    local targetBtn = nil
    for _, btn in ipairs(frame:GetChildren()) do
        if btn:IsA("TextButton") and btn.Visible then
            print("   🔘 Tombol:", btn.Name, "| Text:", btn.Text, "| Visible:", btn.Visible)
            if tonumber(btn.Text) == jawaban then
                targetBtn = btn
                print("   ✅ MATCH! Tombol jawaban ditemukan:", jawaban)
            end
        end
    end
    
    if not targetBtn then
        warn("❌ Tombol dengan jawaban", jawaban, "tidak ditemukan!")
        return false
    end
    
    -- ============================================================
    -- ⏱️ DELAY 5-10 DETIK SEBELUM KLIK
    -- ============================================================
    local delayTime = math.random(5, 10)
    print("   ⏳ Delay", delayTime, "detik sebelum klik...")
    
    for i = delayTime, 1, -1 do
        print("   ⏱️  Klik dalam", i, "detik...")
        task.wait(1)
    end
    
    -- Klik tombol
    print("   🖱️  MENG-KLIK JAWABAN:", jawaban)
    
    -- Coba beberapa metode klik
    local clicked = false
    
    -- Metode 1: firesignal
    pcall(function()
        firesignal(targetBtn.MouseButton1Click)
        clicked = true
        print("   ✅ firesignal(MouseButton1Click) berhasil!")
    end)
    
    -- Metode 2: firesignal Activated
    if not clicked then
        pcall(function()
            firesignal(targetBtn.Activated)
            clicked = true
            print("   ✅ firesignal(Activated) berhasil!")
        end)
    end
    
    -- Metode 3: Simulate click
    if not clicked then
        pcall(function()
            -- Buat fake input
            local VirtualInputManager = game:GetService("VirtualInputManager")
            local absPos = targetBtn.AbsolutePosition
            local absSize = targetBtn.AbsoluteSize
            local centerX = absPos.X + absSize.X / 2
            local centerY = absPos.Y + absSize.Y / 2
            
            VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, true, game, 0)
            task.wait(0.05)
            VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, false, game, 0)
            
            clicked = true
            print("   ✅ VirtualInputManager berhasil!")
        end)
    end
    
    if not clicked then
        warn("   ❌ Semua metode klik gagal!")
        return false
    end
    
    print(string.rep("-", 40))
    return true
end

-- ============================================================
-- 🔄 LOOP UTAMA (bisa di-toggle)
-- ============================================================
local running = true

-- Toggle OFF: ketik di console atau pencet tombol
local function stopTest()
    running = false
    print("\n🛑 Test dihentikan!")
end

-- Simpan fungsi stop ke global biar bisa dipanggil
getgenv().stopWorkGuiTest = stopTest

print("\n" .. string.rep("=", 50))
print("✅ TEST SIAP!")
print("   - Script akan scan WorkGui setiap 1 detik")
print("   - Kalau ada soal, bakal jawab dengan delay 5-10 detik")
print("   - Ketik `stopWorkGuiTest()` di console untuk berhenti")
print(string.rep("=", 50) .. "\n")

-- Loop utama
task.spawn(function()
    while running do
        local success, err = pcall(jawabSoal)
        if not success then
            warn("❌ Error:", err)
        end
        task.wait(1)
    end
end)

-- ============================================================
-- 🎯 TEST SEKALI (langsung jalan)
-- ============================================================
-- Uncomment baris di bawah kalo mau test sekali aja tanpa loop:
-- jawabSoal()
