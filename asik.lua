-- ============================================================
-- 🧪 TEST UI WORKGUI + AUTO JAWAB (FIXED)
-- Standalone, bisa jalan langsung di executor
-- ============================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local playerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ============================================================
-- 🔍 DEBUG: Print semua UI di PlayerGui (FIXED)
-- ============================================================
print("\n" .. string.rep("=", 50))
print("🔍 SCANNING UI DI PlayerGui...")
print(string.rep("=", 50))

for _, gui in ipairs(playerGui:GetChildren()) do
    -- ✅ FIX: Cek apakah objek punya property Visible sebelum akses
    local guiVisible = "N/A"
    pcall(function()
        guiVisible = tostring(gui.Visible)
    end)
    
    print("📁 GUI:", gui.Name, "| Class:", gui.ClassName, "| Visible:", guiVisible)
    
    -- Print semua descendants yang penting
    for _, child in ipairs(gui:GetDescendants()) do
        if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
            local childVisible = "N/A"
            pcall(function()
                childVisible = tostring(child.Visible)
            end)
            
            local text = "N/A"
            pcall(function()
                if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
                    text = tostring(child.Text):sub(1, 30)
                end
            end)
            
            print(string.format("  └─ [%s] %s | Visible: %s | Text: %s", 
                child.ClassName, 
                child.Name, 
                childVisible,
                text
            ))
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
        -- Coba cari dengan nama lain
        for _, gui in ipairs(playerGui:GetChildren()) do
            if gui.Name:lower():find("work") or gui.Name:lower():find("office") then
                print("🔍 Mungkin WorkGui =", gui.Name, "(Class:", gui.ClassName .. ")")
            end
        end
        return false
    end
    
    print("\n" .. string.rep("-", 40))
    print("📋 WorkGui ditemukan:", WorkGui.Name)
    
    -- Cari QuestionLabel (cari di semua level)
    local questionLabel = nil
    for _, obj in ipairs(WorkGui:GetDescendants()) do
        if obj:IsA("TextLabel") then
            local txt = ""
            pcall(function() txt = obj.Text end)
            if txt ~= "" and (txt:find("%d") and txt:find("[%+%-%*/]")) then
                questionLabel = obj
                print("   ✅ QuestionLabel (detected):", obj.Name, "| Text:", txt)
                break
            end
        end
    end
    
    -- Fallback: cari by name
    if not questionLabel then
        questionLabel = WorkGui:FindFirstChild("QuestionLabel", true)
    end
    
    if not questionLabel then
        warn("❌ QuestionLabel tidak ditemukan!")
        return false
    end
    
    local questionText = ""
    pcall(function() questionText = questionLabel.Text end)
    
    print("   QuestionLabel:", questionLabel.Name)
    print("   Text:", questionText)
    
    if questionText == "" then
        warn("⚠️ QuestionLabel kosong!")
        return false
    end
    
    -- Parse soal: "5 + 3" atau "10 - 4" dll
    local a, op, b = string.match(questionText, "(%d+)%s*([%+%-%*/])%s*(%d+)")
    if not a then
        warn("❌ Gagal parse soal! Format:", questionText)
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
    
    -- Cari container tombol (Frame atau apapun yang isinya TextButton)
    local buttonContainer = nil
    for _, obj in ipairs(WorkGui:GetDescendants()) do
        if (obj:IsA("Frame") or obj:IsA("ScrollingFrame")) and #obj:GetChildren() > 0 then
            local hasButtons = false
            for _, child in ipairs(obj:GetChildren()) do
                if child:IsA("TextButton") then
                    hasButtons = true
                    break
                end
            end
            if hasButtons then
                buttonContainer = obj
                print("   ✅ Button container:", obj.Name)
                break
            end
        end
    end
    
    if not buttonContainer then
        warn("❌ Container tombol tidak ditemukan!")
        return false
    end
    
    -- Cari tombol dengan text = jawaban
    local targetBtn = nil
    for _, btn in ipairs(buttonContainer:GetChildren()) do
        if btn:IsA("TextButton") then
            local btnText = ""
            pcall(function() btnText = btn.Text end)
            
            local btnVisible = true
            pcall(function() btnVisible = btn.Visible end)
            
            print("   🔘 Tombol:", btn.Name, "| Text:", btnText, "| Visible:", btnVisible)
            
            if tonumber(btnText) == jawaban and btnVisible then
                targetBtn = btn
                print("   ✅ MATCH! Tombol jawaban:", jawaban)
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
    
    local clicked = false
    
    -- Metode 1: firesignal MouseButton1Click
    pcall(function()
        firesignal(targetBtn.MouseButton1Click)
        clicked = true
        print("   ✅ firesignal(MouseButton1Click) OK!")
    end)
    
    -- Metode 2: firesignal Activated
    if not clicked then
        pcall(function()
            firesignal(targetBtn.Activated)
            clicked = true
            print("   ✅ firesignal(Activated) OK!")
        end)
    end
    
    -- Metode 3: VirtualInputManager (mouse simulation)
    if not clicked then
        pcall(function()
            local VirtualInputManager = game:GetService("VirtualInputManager")
            local absPos = targetBtn.AbsolutePosition
            local absSize = targetBtn.AbsoluteSize
            local centerX = absPos.X + absSize.X / 2
            local centerY = absPos.Y + absSize.Y / 2
            
            VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, true, game, 0)
            task.wait(0.05)
            VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, false, game, 0)
            
            clicked = true
            print("   ✅ VirtualInputManager OK!")
        end)
    end
    
    -- Metode 4: Panggil fungsi langsung (kalau ada)
    if not clicked then
        pcall(function()
            if targetBtn.MouseButton1Click then
                targetBtn.MouseButton1Click:Fire()
                clicked = true
                print("   ✅ :Fire() OK!")
            end
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
-- 🔄 LOOP UTAMA
-- ============================================================
local running = true

getgenv().stopWorkGuiTest = function()
    running = false
    print("\n🛑 Test dihentikan!")
end

print("\n" .. string.rep("=", 50))
print("✅ TEST SIAP!")
print("   - Script scan WorkGui setiap 1 detik")
print("   - Delay 5-10 detik sebelum klik jawaban")
print("   - Ketik `stopWorkGuiTest()` untuk berhenti")
print(string.rep("=", 50) .. "\n")

task.spawn(function()
    while running do
        local success, err = pcall(jawabSoal)
        if not success then
            warn("❌ Error:", err)
        end
        task.wait(1)
    end
end)
