local ADDON_NAME, NS = ...
local EZArenaFrames = NS.addon

local Outline = EZArenaFrames:NewModule(
    "Outline",
    "AceEvent-3.0"
)

-- Localize WoW API functions
local IsInInstance = IsInInstance
local CreateFrame = CreateFrame
local UnitIsUnit = UnitIsUnit

local defaults = {
    profile = {
        drawTargetOnTop = true,

        target = {
            topleftFrame = "HealthBar",
            toprightFrame = "HealthBar",
            bottomleftFrame = "PowerBar",
            bottomrightFrame = "PowerBar",
            offset = 0,
            thickness = 1,
            color = {r = 1, g = 1, b = 0, a = 1},
            sublevel = 1,
        },

        focus = {
            topleftFrame = "HealthBar",
            toprightFrame = "HealthBar",
            bottomleftFrame = "PowerBar",
            bottomrightFrame = "PowerBar",
            offset = -1,
            thickness = 1,
            color = {r = 1, g = 0, b = 0, a = 1},
            sublevel = 0,
        },

    },
}

-- Variables that store the tickers for the testmode function
local targetTestTicker
local focusTestTicker

function Outline:OnInitialize()
    self.db = EZArenaFrames.db:RegisterNamespace("Outline", defaults)
end

function Outline:OnEnable()
    self:RegisterEvent("PLAYER_TARGET_CHANGED")
    self:RegisterEvent("PLAYER_FOCUS_CHANGED")

    self:CreateOutlines()
end

function Outline:OnDisable()
    self:UnregisterAllEvents()
end

function Outline:PLAYER_TARGET_CHANGED()
    local _, instanceType = IsInInstance()

    if instanceType ~= "arena" then return end

    for i = 1, 3 do
        local parent = EZArenaFrames.anchorFrames[i]

        if parent and parent.targetOutline then

            if UnitIsUnit("target", "arena" .. i) then
                parent.targetOutline:Show()
            else
                parent.targetOutline:Hide()
            end
        end
    end
end

function Outline:PLAYER_FOCUS_CHANGED()
    local _, instanceType = IsInInstance()

    if instanceType ~= "arena" then return end

    for i = 1, 3 do
        local parent = EZArenaFrames.anchorFrames[i]

        if parent and parent.focusOutline then

            if UnitIsUnit("focus", "arena" .. i) then
                parent.focusOutline:Show()
            else
                parent.focusOutline:Hide()
            end
        end
    end
end

function Outline:CreateOutlines()

    local function CreateBorder(parent)
        local border = CreateFrame("Frame", nil, parent)

        border.top = border:CreateTexture(nil, "OVERLAY")
        border.bottom = border:CreateTexture(nil, "OVERLAY")
        border.left = border:CreateTexture(nil, "OVERLAY")
        border.right = border:CreateTexture(nil, "OVERLAY")

        return border
    end

    for i = 1, 3 do
        local parent = EZArenaFrames.anchorFrames[i]

        if parent then
            if not parent.targetOutline then
                parent.targetOutline = CreateBorder(parent)
                parent.targetOutline:Hide()
            end

            if not parent.focusOutline then
                parent.focusOutline = CreateBorder(parent)
                parent.focusOutline:Hide()
            end
        end
    end

    self:StyleOutlines()
end

function Outline:StyleOutlines()

    local function SetAttributes(border, parent, unitToken)
        local settings = self.db.profile[unitToken]
        local topleftFrame = settings.topleftFrame
        local toprightFrame = settings.toprightFrame
        local bottomleftFrame = settings.bottomleftFrame
        local bottomrightFrame = settings.bottomrightFrame
        local offset = settings.offset
        local thickness = settings.thickness
        local color = settings.color
        local sublevel = settings.sublevel

        border:ClearAllPoints()

        border.top:SetPoint("TOPLEFT", parent[topleftFrame] or parent, "TOPLEFT", -(offset + thickness), (offset + thickness))
        border.top:SetPoint("TOPRIGHT", parent[toprightFrame] or parent, "TOPRIGHT", (offset + thickness), (offset + thickness))
        border.top:SetHeight(thickness)
        border.top:SetColorTexture(color.r, color.g, color.b, color.a)
        border.top:SetDrawLayer("OVERLAY", sublevel)

        border.bottom:SetPoint("BOTTOMLEFT", parent[bottomleftFrame] or parent, "BOTTOMLEFT", -(offset + thickness), -(offset + thickness))
        border.bottom:SetPoint("BOTTOMRIGHT", parent[bottomrightFrame] or parent, "BOTTOMRIGHT", (offset + thickness), -(offset + thickness))
        border.bottom:SetHeight(thickness)
        border.bottom:SetColorTexture(color.r, color.g, color.b, color.a)
        border.bottom:SetDrawLayer("OVERLAY", sublevel)

        border.left:SetPoint("TOPLEFT", parent[topleftFrame] or parent, "TOPLEFT", -(offset + thickness), (offset + thickness))
        border.left:SetPoint("BOTTOMLEFT", parent[bottomleftFrame] or parent, "BOTTOMLEFT", -(offset + thickness), -(offset + thickness))
        border.left:SetWidth(thickness)
        border.left:SetColorTexture(color.r, color.g, color.b, color.a)
        border.left:SetDrawLayer("OVERLAY", sublevel)

        border.right:SetPoint("TOPRIGHT", parent[toprightFrame] or parent, "TOPRIGHT", (offset + thickness), (offset + thickness))
        border.right:SetPoint("BOTTOMRIGHT", parent[bottomrightFrame] or parent, "BOTTOMRIGHT", (offset + thickness), -(offset + thickness))
        border.right:SetWidth(thickness)
        border.right:SetColorTexture(color.r, color.g, color.b, color.a)
        border.right:SetDrawLayer("OVERLAY", sublevel)
    end

    for i = 1, 3 do
        local parent = EZArenaFrames.anchorFrames[i]

        if parent and parent.targetOutline then
            local border = parent.targetOutline

            SetAttributes(border, parent, "target")
        end

        if parent and parent.focusOutline then
            local border = parent.focusOutline

            SetAttributes(border, parent, "focus")
        end
    end
end

function Outline:Test()
    if EZArenaFrames.test then

        -- Target Outline
        local targetIndex = 2
        local previousTargetIndex = 1

        EZArenaFrames.anchorFrames[1].targetOutline:Show()

        targetTestTicker = C_Timer.NewTicker(4, function()
            if previousTargetIndex then
                EZArenaFrames.anchorFrames[previousTargetIndex].targetOutline:Hide()
            end

            EZArenaFrames.anchorFrames[targetIndex].targetOutline:Show()

            previousTargetIndex = targetIndex

            if targetIndex == 3 then
                targetIndex = 1
            else
                targetIndex = targetIndex + 1
            end
        end)

        -- Focus Outline
        local focusIndex = 1
        local previousFocusIndex = 3

        EZArenaFrames.anchorFrames[3].focusOutline:Show()

        focusTestTicker = C_Timer.NewTicker(16, function()
            if previousFocusIndex then
                EZArenaFrames.anchorFrames[previousFocusIndex].focusOutline:Hide()
            end

            EZArenaFrames.anchorFrames[focusIndex].focusOutline:Show()

            previousFocusIndex = focusIndex

            if focusIndex == 3 then
                focusIndex = 1
            else
                focusIndex = focusIndex + 1
            end
        end)

    else
        if targetTestTicker then
            targetTestTicker:Cancel()
            targetTestTicker = nil
        end

        if focusTestTicker then
            focusTestTicker:Cancel()
            focusTestTicker = nil
        end

        for i = 1, 3 do
            local parent = EZArenaFrames.anchorFrames[i]
            parent.targetOutline:Hide()
            parent.focusOutline:Hide()
        end
    end
end
