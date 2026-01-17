-- Create addon object and make it globally accessible
local ADDON_NAME, NS = ...

local EZArenaFrames = LibStub("AceAddon-3.0"):NewAddon(
    ADDON_NAME,
    "AceEvent-3.0",
    "AceConsole-3.0"
)

_G.EZArenaFrames = EZArenaFrames

-- Library references
local LibStub = LibStub
local AceDB = LibStub("AceDB-3.0")

-- Localize WoW API functions
local CreateFrame = CreateFrame
local InCombatLockdown = InCombatLockdown

-- Core lifecycle hooks
function EZArenaFrames:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("EZArenaFramesDB", {
        profile = {
            modules = {},
            anchorFrames = {
                width = 50,
                height = 50,
                spacingY = 100,
            },
        },
    }, true)
    self.db.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
    self.db.RegisterCallback(self, "OnProfileCopied", "RefreshConfig")
    self.db.RegisterCallback(self, "OnProfileReset", "RefreshConfig")
end

function EZArenaFrames:OnEnable()
    self:CreateAnchorFrames()
end

function EZArenaFrames:OnDisable()

end

-- Shared state flags
EZArenaFrames.test = false

function EZArenaFrames:RefreshConfig()
  -- would do some stuff here
end

-- Create anchor frames
function EZArenaFrames:CreateAnchorFrames()
    if InCombatLockdown() then return end

    self.frames = self.frames or {}

    for i = 1, 3 do
        if not self.frames[i] then
            local name = "EZAF_Arena" .. i .. "Anchor"

            local frame = _G[name] or CreateFrame("Frame", name, UIParent)

            if not frame.bg then -- for testing
                local bg = frame:CreateTexture(nil, "BACKGROUND")
                bg:SetAllPoints()
                bg:SetColorTexture(0, 0, 0, 1)
                frame.bg = bg
            end

            self.frames[i] = frame
        end
    end

    self:StyleAnchorFrames()
end

-- Update anchor frames
function EZArenaFrames:StyleAnchorFrames()
    if InCombatLockdown() then return end

    local settings = self.db.profile.anchorFrames

    for index, frame in ipairs(self.frames) do
        frame:ClearAllPoints()
        frame:SetSize(settings.width, settings.height)
        frame:SetPoint("CENTER", UIParent, "CENTER", 0, -(index - 1) * settings.spacingY)
    end
end