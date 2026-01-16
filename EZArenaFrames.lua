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

end

function EZArenaFrames:OnEnable()
    self:CreateArenaFrames()
end

function EZArenaFrames:OnDisable()

end

-- Shared state flags
EZArenaFrames.test = false

-- Create frames
function EZArenaFrames:CreateArenaFrames()
    if InCombatLockdown() then return end

    self.frames = self.frames or {}

    for i = 1, 3 do
        if not self.frames[i] then
            local name = "EZAF_Arena" .. i
            local frame = _G[name] or CreateFrame(
                "Button",
                name,
                UIParent,
                "SecureUnitButtonTemplate"
            )

            -- frame:SetAttribute("unit", "arena" .. i)
            frame:SetAttribute("unit", "player") -- for testing
            frame:SetAttribute("type", "target")

            -- frame:Hide()
            self.frames[i] = frame
        end
    end
end
