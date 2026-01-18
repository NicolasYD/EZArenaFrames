local EZArenaFrames = EZArenaFrames

local HealthBar = EZArenaFrames:NewModule(
    "HealthBar",
    "AceEvent-3.0"
)

-- Localize WoW API functions
local CreateFrame = CreateFrame
local GetArenaOpponentSpec = GetArenaOpponentSpec
local GetClassColor = C_ClassColor.GetClassColor
local GetClassInfo = C_CreatureInfo.GetClassInfo
local GetSpecializationInfoByID = GetSpecializationInfoByID
local InCombatLockdown = InCombatLockdown
local UnitHealth = UnitHealth
local UnitHealthMax = UnitHealthMax

local defaults = {
    profile = {
        width = 100,
        height = 20,
        offsetX = 0,
        offsetY = 0,
    },
}

local unitToIndex = {
    arena1 = 1,
    arena2 = 2,
    arena3 = 3,
}

function HealthBar:OnInitialize()
    self.db = EZArenaFrames.db:RegisterNamespace("HealthBar", defaults)
end

function HealthBar:OnEnable()
    self:RegisterEvent("ARENA_PREP_OPPONENT_SPECIALIZATIONS")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("UNIT_HEALTH")

    self:CreateHealthBar()
    self:CreateSecureButton()
end

function HealthBar:OnDisable()
    self:UnregisterAllEvents()
end

function HealthBar:ARENA_PREP_OPPONENT_SPECIALIZATIONS()
    self:ColorHealthBar()
end

function HealthBar:PLAYER_ENTERING_WORLD(event, isInitialLogin, isReloadingUi)
    self:ColorHealthBar()
end

function HealthBar:UNIT_HEALTH(event, unitTarget)
    self:UpdateHealthBar(unitTarget)
end

function HealthBar:CreateHealthBar()
    for i = 1, 3 do
        local parent = _G["EZAF_Arena" .. i .. "Anchor"]
        if parent and not parent.HealthBar then

            local bar = CreateFrame("StatusBar", nil, parent)

            local bg = bar:CreateTexture(nil, "BACKGROUND")
            bar.bg = bg

            local text = bar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
            bar.text = text

            parent.HealthBar = bar
        end
    end

    self:StyleHealthBar()
end

function HealthBar:CreateSecureButton()
    if InCombatLockdown() then return end

    for i = 1, 3 do
        local parent = _G["EZAF_Arena" .. i .. "SecureAnchor"]
        if parent and not parent.HealthBar then

            local secureButton = CreateFrame("Button", nil, parent, "SecureUnitButtonTemplate")

            -- secureButton:SetAttribute("unit", "player") -- for testing
            secureButton:SetAttribute("unit", "arena" .. i)
            secureButton:SetAttribute("type1", "target")
            secureButton:RegisterForClicks("AnyDown")

            parent.HealthBar = secureButton
        end
    end

    self:StyleSecureButton()
end

function HealthBar:StyleHealthBar()
    local settings = self.db.profile

    for i = 1, 3 do
        local parent = _G["EZAF_Arena" .. i .. "Anchor"]
        if parent and parent.HealthBar then
            local bar = parent.HealthBar

            bar:ClearAllPoints()
            bar:SetPoint("TOPLEFT", parent, "TOPRIGHT", settings.offsetX, settings.offsetY)
            bar:SetSize(settings.width, settings.height)
            bar:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")

            bar.bg:ClearAllPoints()
            bar.bg:SetAllPoints()
            bar.bg:SetColorTexture(0, 0, 0, 1)

            bar.text:ClearAllPoints()
            bar.text:SetPoint("CENTER")
            bar.text:SetText("100%") -- for testing
        end
    end
end

function HealthBar:StyleSecureButton()
    if InCombatLockdown() then return end

    local settings = self.db.profile

    for i = 1, 3 do
        local parent = _G["EZAF_Arena" .. i .. "SecureAnchor"]
        if parent and parent.HealthBar then
            local secureButton = parent.HealthBar

            secureButton:ClearAllPoints()
            secureButton:SetPoint("TOPLEFT", parent, "TOPRIGHT", settings.offsetX, settings.offsetY)
            secureButton:SetSize(settings.width, settings.height)
        end
    end
end

-- Set healthbar colors to class colors
function HealthBar:ColorHealthBar()
    for i = 1, 3 do
        local specID = GetArenaOpponentSpec(i)

        if specID and specID > 0 then
            local id, name, description, icon, role, classFile, className = GetSpecializationInfoByID(specID)

            if classFile then
                local color = GetClassColor(classFile)

                if color then
                    local r, g, b = color.r, color.g, color.b
                    local parent = _G["EZAF_Arena" .. i .. "Anchor"]

                    if parent and parent.HealthBar then
                        local bar = parent.HealthBar

                        bar:SetStatusBarColor(r, g, b, 1)
                    end
                end
            end
        end
    end
end

function HealthBar:UpdateHealthBar(unitToken)
    local index = unitToIndex[unitToken]
    if not index then return end

    local parent = _G["EZAF_Arena" .. index .. "Anchor"]
    if not parent or not parent.HealthBar then return end

    local bar = parent.HealthBar
    if not bar then return end

    local health = UnitHealth(unitToken)
    local maxHealth = UnitHealthMax(unitToken)

    if maxHealth == 0 then
        bar:SetValue(0)
        return
    end

    bar:SetMinMaxValues(0, maxHealth)
    bar:SetValue(health)

    if bar.text then
        local percent = math.floor((health / maxHealth) * 100)
        bar.text:SetText(percent .. "%")
    end
end

function HealthBar:Test()
    if EZArenaFrames.test then
        for i = 1, 3 do
            local parent = _G["EZAF_Arena" .. i .. "Anchor"]
            local bar = parent.HealthBar
            local text = parent.HealthBar.text

            local classID = math.random(1, 13)
            local classInfo = GetClassInfo(classID)
            local color = GetClassColor(classInfo and classInfo.classFile)

            bar:SetStatusBarColor(color.r, color.g, color.b, color.a)

            local maxHealth = 10000000
            local health = ceil(math.random((0.3 * maxHealth), maxHealth))

            bar:SetMinMaxValues(0, maxHealth)
            bar:SetValue(health)

            local percent = math.floor((health / maxHealth) * 100)
            text:SetText(percent .. "%")
        end
    end
end
