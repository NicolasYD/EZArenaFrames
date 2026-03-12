local ADDON_NAME, NS = ...
local EZArenaFrames = NS.addon

local PowerBar = EZArenaFrames:NewModule(
    "PowerBar",
    "AceEvent-3.0"
)

-- Localize WoW API functions
local IsInInstance = IsInInstance
local CreateFrame = CreateFrame
local InCombatLockdown = InCombatLockdown
local UnitPower = UnitPower
local UnitPowerMax = UnitPowerMax
local UnitPowerType = UnitPowerType

local defaults = {
    profile = {
        width = 160,
        height = 10,
        offsetX = 0,
        offsetY = 0,
        maxWidth = 300,
        maxHeight =100,
    },
}

local instanceType = nil

local unitToIndex = {
    arena1 = 1,
    arena2 = 2,
    arena3 = 3,
}

function PowerBar:OnInitialize()
    self.db = EZArenaFrames.db:RegisterNamespace("PowerBar", defaults)
end

function PowerBar:OnEnable()
    self:RegisterEvent("ARENA_PREP_OPPONENT_SPECIALIZATIONS")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("UNIT_POWER_FREQUENT")
    self:RegisterEvent("UNIT_MAXPOWER")
    self:RegisterEvent("UNIT_DISPLAYPOWER")

    self:CreatePowerBar()
    self:CreateSecureButton()
end

function PowerBar:OnDisable()
    self:UnregisterAllEvents()
end

function PowerBar:ARENA_PREP_OPPONENT_SPECIALIZATIONS()
    if instanceType ~= "arena" then return end
end

function PowerBar:PLAYER_ENTERING_WORLD(event, isInitialLogin, isReloadingUi)
    _, instanceType = IsInInstance()

    if instanceType ~= "arena" then return end

end

function PowerBar:UNIT_POWER_FREQUENT(event, unitToken)
    if not EZArenaFrames.test then

        if instanceType ~= "arena" then return end

        self:UpdatePowerBar(unitToken)
    else
        self:UpdatePowerBar("arena1")
    end
end

function PowerBar:UNIT_MAXPOWER(event, unitToken)
    if not EZArenaFrames.test then

        if instanceType ~= "arena" then return end

        self:UpdatePowerBar(unitToken)
    else
        self:UpdatePowerBar("arena1")
    end
end

function PowerBar:UNIT_DISPLAYPOWER(event, unitToken)
    if not EZArenaFrames.test then

        if instanceType ~= "arena" then return end

        self:UpdatePowerBar(unitToken)
        self:ColorPowerBar(unitToken)
    else
        local powerType = UnitPowerType("player")

        self:UpdatePowerBar("arena1")
        self:ColorPowerBar("arena1", powerType)
    end

end

function PowerBar:CreatePowerBar()
    for i = 1, 3 do
        local parent = EZArenaFrames.anchorFrames[i]

        if parent and not parent.PowerBar then

            local bar = CreateFrame("StatusBar", nil, parent)

            local bg = bar:CreateTexture(nil, "BACKGROUND")
            bg:SetAllPoints()
            bg:SetColorTexture(0, 0, 0, 1)
            bar.bg = bg

            parent.PowerBar = bar
        end
    end

    self:StylePowerBar()
end

function PowerBar:CreateSecureButton()
    if InCombatLockdown() then return end

    for i = 1, 3 do
        local parent = EZArenaFrames.secureAnchorFrames[i]

        if parent and not parent.PowerBar then

            local secureButton = CreateFrame("Button", nil, parent, "SecureUnitButtonTemplate")
            secureButton:SetAttribute("unit", "arena" .. i)
            secureButton:SetAttribute("type1", "target")
            secureButton:RegisterForClicks("AnyDown")

            parent.PowerBar = secureButton
        end
    end

    self:StyleSecureButton()
end

function PowerBar:StylePowerBar()
    local settings = self.db.profile

    for i = 1, 3 do
        local parent = EZArenaFrames.anchorFrames[i]

        if parent and parent.PowerBar then
            local bar = parent.PowerBar

            bar:ClearAllPoints()
            bar:SetPoint("BOTTOMLEFT", parent, "BOTTOMRIGHT", settings.offsetX, settings.offsetY)
            bar:SetSize(settings.width, settings.height)
            bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
        end
    end
end

function PowerBar:StyleSecureButton()
    if InCombatLockdown() then return end

    local settings = self.db.profile

    for i = 1, 3 do
        local parent = EZArenaFrames.secureAnchorFrames[i]

        if parent and parent.PowerBar then
            local secureButton = parent.PowerBar

            secureButton:ClearAllPoints()
            secureButton:SetPoint("BOTTOMLEFT", parent, "BOTTOMRIGHT", settings.offsetX, settings.offsetY)
            secureButton:SetSize(settings.width, settings.height)
        end
    end
end

function PowerBar:ColorPowerBar(unitToken, testPowerType)
    local index = unitToIndex[unitToken]
    if not index then return end

    local powerType = testPowerType or UnitPowerType(unitToken)
    local color = PowerBarColor[powerType]

    if color then

        local parent = EZArenaFrames.anchorFrames[index]

        if parent and parent.PowerBar then
            local bar = parent.PowerBar

            bar:SetStatusBarColor(color.r, color.g, color.b, 1)
        end
    end
end

function PowerBar:UpdatePowerBar(unitToken)
    local index = unitToIndex[unitToken]
    if not index then return end

    local parent = EZArenaFrames.anchorFrames[index]

    if not parent or not parent.PowerBar then return end

    local bar = parent.PowerBar

    local power
    local maxPower

    if not EZArenaFrames.test then
        power = UnitPower(unitToken)
        maxPower = UnitPowerMax(unitToken)
    else
        power = UnitPower("player")
        maxPower = UnitPowerMax("player")
    end

    bar:SetMinMaxValues(0, maxPower)
    bar:SetValue(power)
end

function PowerBar:Test()
    if EZArenaFrames.test then
        for i = 1, 3 do
            local parent = EZArenaFrames.anchorFrames[i]
            local bar = parent.PowerBar

            local maxPower
            local power

            if i == 1 then
                maxPower = UnitPowerMax("player")
                power = UnitPower("player")

                local powerType = UnitPowerType("player")

                self:ColorPowerBar("arena1", powerType)
            else
                maxPower = 10000000
                power = ceil(math.random((0.3 * maxPower), maxPower))

                local classID = EZArenaFrames.testTable["arena" .. i].classID
                local specID = EZArenaFrames.testTable["arena" .. i].specID
                local powerType = EZArenaFrames.classIDs[classID].specIDs[specID].powerType

                self:ColorPowerBar("arena" .. i, powerType)
            end

            bar:SetMinMaxValues(0, maxPower)
            bar:SetValue(power)
        end
    else
        for i = 1, 3 do
            local parent = EZArenaFrames.anchorFrames[i]
            local bar = parent.PowerBar

            bar:SetStatusBarColor(1, 1, 1, 1)
            bar:SetMinMaxValues(0, 1)
            bar:SetValue(1)
        end
    end
end
