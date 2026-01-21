local ADDON_NAME, NS = ...
local EZArenaFrames = NS.addon

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
local UnitGetTotalAbsorbs = UnitGetTotalAbsorbs
local UnitHealth = UnitHealth
local UnitHealthMax = UnitHealthMax

local defaults = {
    profile = {
        width = 160,
        height = 30,
        offsetX = 0,
        offsetY = 0,
        maxWidth = 300,
        maxHeight =100,
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
    self:RegisterEvent("UNIT_MAXHEALTH")

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

function HealthBar:UNIT_HEALTH(event, unitToken)
    self:UpdateHealthBar(unitToken)
end

function HealthBar:UNIT_MAXHEALTH(event, unitToken)
    self:UpdateHealthBar(unitToken)
end

function HealthBar:CreateHealthBar()
    for i = 1, 3 do
        local parent = EZArenaFrames.anchorFrames[i]

        if parent and not parent.HealthBar then

            local bar = CreateFrame("StatusBar", nil, parent)

            local bg = bar:CreateTexture(nil, "BACKGROUND")
            bg:SetAllPoints()
            bg:SetColorTexture(0, 0, 0, 1)
            bar.bg = bg

            parent.HealthBar = bar
        end
    end

    self:StyleHealthBar()
end

function HealthBar:CreateSecureButton()
    if InCombatLockdown() then return end

    for i = 1, 3 do
        local parent = EZArenaFrames.secureAnchorFrames[i]

        if parent and not parent.HealthBar then

            local secureButton = CreateFrame("Button", nil, parent, "SecureUnitButtonTemplate")
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
        local parent = EZArenaFrames.anchorFrames[i]

        if parent and parent.HealthBar then
            local bar = parent.HealthBar

            bar:ClearAllPoints()
            bar:SetPoint("TOPLEFT", parent, "TOPRIGHT", settings.offsetX, settings.offsetY)
            bar:SetSize(settings.width, settings.height)
            bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
        end
    end
end

function HealthBar:StyleSecureButton()
    if InCombatLockdown() then return end

    local settings = self.db.profile

    for i = 1, 3 do
        local parent = EZArenaFrames.secureAnchorFrames[i]

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
                    local parent = EZArenaFrames.anchorFrames[i]

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

    local parent = EZArenaFrames.anchorFrames[index]

    if not parent or not parent.HealthBar then return end

    local bar = parent.HealthBar

    local health = UnitHealth(unitToken)
    local maxHealth = UnitHealthMax(unitToken)

    bar:SetMinMaxValues(0, maxHealth)
    bar:SetValue(health)
end

function HealthBar:Test()
    if EZArenaFrames.test then
        for i = 1, 3 do
            local parent = EZArenaFrames.anchorFrames[i]
            local bar = parent.HealthBar

            local classID = math.random(1, 13)
            local classInfo = GetClassInfo(classID)
            local color = GetClassColor(classInfo and classInfo.classFile)

            bar:SetStatusBarColor(color.r, color.g, color.b, color.a)

            local maxHealth = 10000000
            local health = ceil(math.random((0.3 * maxHealth), maxHealth))

            bar:SetMinMaxValues(0, maxHealth)
            bar:SetValue(health)
        end
    else
        for i = 1, 3 do
            local parent = EZArenaFrames.anchorFrames[i]
            local bar = parent.HealthBar

            bar:SetStatusBarColor(1, 1, 1, 1)
            bar:SetMinMaxValues(0, 1)
            bar:SetValue(1)
        end
    end
end
