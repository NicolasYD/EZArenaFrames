local ADDON_NAME, NS = ...
local EZArenaFrames = NS.addon

local CastBar = EZArenaFrames:NewModule(
    "CastBar",
    "AceEvent-3.0"
)

-- Localize WoW API functions
local InCombatLockdown = InCombatLockdown

local defaults = {
    profile = {
        width = 160,
        height = 10,
        offsetX = 0,
        offsetY = 0,
    },
}

local unitToIndex = {
    arena1 = 1,
    arena2 = 2,
    arena3 = 3,
}

function CastBar:OnInitialize()
    self.db = EZArenaFrames.db:RegisterNamespace("CastBar", defaults)
end

function CastBar:OnEnable()
    self:RegisterEvent("PLAYER_ENTERING_WORLD")

    self:CreateCastBar()
    self:CreateSecureButton()
end

function CastBar:OnDisable()
    self:UnregisterAllEvents()
end

function CastBar:PLAYER_ENTERING_WORLD(event, isInitialLogin, isReloadingUi)

end

function CastBar:CreateCastBar()
    for i = 1, 3 do
        local parent = EZArenaFrames.anchorFrames[i]

        if parent and not parent.CastBar then

            local bar = CreateFrame("StatusBar", nil, parent)

            local bg = bar:CreateTexture(nil, "BACKGROUND")
            bg:SetAllPoints()
            bg:SetColorTexture(0, 0, 0, 1)
            bar.bg = bg

            parent.CastBar = bar
        end
    end

    self:StyleCastBar()
end

function CastBar:CreateSecureButton()
    if InCombatLockdown() then return end

    for i = 1, 3 do
        local parent = EZArenaFrames.secureAnchorFrames[i]

        if parent and not parent.CastBar then

            local secureButton = CreateFrame("Button", nil, parent, "SecureUnitButtonTemplate")
            --[[ secureButton:SetAttribute("unit", "arena" .. i)
            secureButton:SetAttribute("type1", "target")
            secureButton:RegisterForClicks("AnyDown") ]]

            parent.CastBar = secureButton
        end
    end

    self:StyleSecureButton()
end

function CastBar:StyleCastBar()
    local settings = self.db.profile

    for i = 1, 3 do
        local parent = EZArenaFrames.anchorFrames[i]

        if parent and parent.CastBar then
            local bar = parent.CastBar

            bar:ClearAllPoints()
            bar:SetPoint("BOTTOMRIGHT", parent, "BOTTOMLEFT", settings.offsetX, settings.offsetY)
            bar:SetSize(settings.width, settings.height)
            bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
        end
    end
end

function CastBar:StyleSecureButton()
    if InCombatLockdown() then return end

    local settings = self.db.profile

    for i = 1, 3 do
        local parent = EZArenaFrames.secureAnchorFrames[i]

        if parent and parent.CastBar then
            local secureButton = parent.CastBar

            secureButton:ClearAllPoints()
            secureButton:SetPoint("BOTTOMRIGHT", parent, "BOTTOMLEFT", settings.offsetX, settings.offsetY)
            secureButton:SetSize(settings.width, settings.height)
        end
    end
end

function CastBar:UpdateCastBar(unitToken)
    local index = unitToIndex[unitToken]
    if not index then return end

    local parent = EZArenaFrames.anchorFrames[index]

    if not parent or not parent.CastBar then return end

    local bar = parent.CastBar

    --[[ local power
    local maxPower

    if not EZArenaFrames.test then
        power = UnitPower(unitToken)
        maxPower = UnitPowerMax(unitToken)
    else
        power = UnitPower("player")
        maxPower = UnitPowerMax("player")
    end

    bar:SetMinMaxValues(0, maxPower)
    bar:SetValue(power) ]]
end

function CastBar:Test()
    if EZArenaFrames.test then
        for i = 1, 3 do
            local parent = EZArenaFrames.anchorFrames[i]
            local bar = parent.CastBar

            --[[ local maxPower
            local power

            if i == 1 then
                maxPower = UnitPowerMax("player")
                power = UnitPower("player")

                local powerType = UnitPowerType("player")

                self:ColorCastBar("arena1", powerType)
            else
                maxPower = 10000000
                power = ceil(math.random((0.3 * maxPower), maxPower))

                local classID = EZArenaFrames.testTable["arena" .. i].classID
                local specID = EZArenaFrames.testTable["arena" .. i].specID
                local powerType = EZArenaFrames.classIDs[classID].specIDs[specID].powerType

                self:ColorCastBar("arena" .. i, powerType)
            end

            bar:SetMinMaxValues(0, maxPower)
            bar:SetValue(power) ]]
        end
    else
        for i = 1, 3 do
            local parent = EZArenaFrames.anchorFrames[i]
            local bar = parent.CastBar

            --[[ bar:SetStatusBarColor(1, 1, 1, 1)
            bar:SetMinMaxValues(0, 1)
            bar:SetValue(1) ]]
        end
    end
end
