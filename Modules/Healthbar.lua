local EZArenaFrames = EZArenaFrames

local HealthBar = EZArenaFrames:NewModule(
    "HealthBar",
    "AceEvent-3.0"
)

-- Localize WoW API functions
local InCombatLockdown = InCombatLockdown
local CreateFrame = CreateFrame

local defaults = {
    profile = {
        width = 100,
        height = 20,
        offsetX = 0,
        offsetY = 0,
    },
}

function HealthBar:OnInitialize()
    self.db = EZArenaFrames.db:RegisterNamespace("HealthBar", defaults)
end

function HealthBar:OnEnable()
    self:CreateHealthBar()
end

function HealthBar:CreateHealthBar()
    if InCombatLockdown() then return end

    for i = 1, 3 do
        local parent = _G["EZAF_Arena" .. i .. "Anchor"]
        if parent and not parent.healthbar then

            local button = CreateFrame("Button", nil, parent, "SecureUnitButtonTemplate")

            button:SetAttribute("unit", "player") -- for testing
            -- button:SetAttribute("unit", "arena" .. i)
            button:SetAttribute("type1", "target")
            button:RegisterForClicks("AnyDown")

            local bar = CreateFrame("StatusBar", nil, button)
            bar:SetAllPoints()

            local bg = bar:CreateTexture(nil, "BACKGROUND")
            bg:SetAllPoints()
            bar.bg = bg

            local text = bar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
            bar.text = text

            button.bar = bar


            parent.healthbar = button
        end
    end

    self:StyleHealthBar()
end

function HealthBar:StyleHealthBar()
    local settings = self.db.profile

    for i = 1, 3 do
        local parent = _G["EZAF_Arena" .. i .. "Anchor"]
        if parent and parent.healthbar then
            local button = parent.healthbar

            button:ClearAllPoints()
            button:SetSize(settings.width, settings.height)
            button:SetPoint("TOPLEFT", parent, "TOPLEFT", settings.offsetX, settings.offsetY)

            local bar = parent.healthbar.bar
            -- bar:SetPoint("TOPLEFT", parent, "TOPLEFT", settings.offsetX, settings.offsetY)
            -- bar:SetSize(settings.width, settings.height)
            bar:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")

            bar:SetMinMaxValues(0, 100) -- for testing
            bar:SetValue(50) -- for testing

            bar.bg:SetAllPoints()
            bar.bg:SetColorTexture(0, 0, 0, 0.6)

            bar.text:SetPoint("CENTER")
            bar.text:SetText("100%") -- for testing
        end
    end
end
