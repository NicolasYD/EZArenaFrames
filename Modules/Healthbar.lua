local EZArenaFrames = EZArenaFrames

local Healthbar = EZArenaFrames:NewModule(
    "Healthbar",
    "AceEvent-3.0"
)

local defaults = {
    profile = {
        width = 100,
        height = 20,
        offsetX = 0,
        offsetY = 0,
    },
}

function Healthbar:OnInitialize()
    self.db = EZArenaFrames.db:RegisterNamespace("Healthbar", defaults)
end

function Healthbar:OnEnable()
    self:AttachHealthbars()
end

function Healthbar:AttachHealthbars()
    for i = 1, 3 do
        local parent = _G["EZAF_Arena" .. i .. "Anchor"]
        if parent and not parent.healthbar then
            self:CreateHealthbar(parent, i)
        end
    end
end

function Healthbar:CreateHealthbar(parent, index)
    local bar = CreateFrame("StatusBar", nil, parent)

    local bg = bar:CreateTexture(nil, "BACKGROUND")
    bar.bg = bg

    local text = bar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    bar.text = text

    parent.healthbar = bar
    self:StyleHealthbar()
end

function Healthbar:StyleHealthbar()
    local settings = self.db.profile

    for i = 1, 3 do
        local parent = _G["EZAF_Arena" .. i .. "Anchor"]
        if parent and parent.healthbar then
            local bar = parent.healthbar
            bar:SetPoint("TOPLEFT", parent, "TOPLEFT", settings.offsetX, settings.offsetY)
            bar:SetSize(settings.width, settings.height)
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
