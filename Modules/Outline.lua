local ADDON_NAME, NS = ...
local EZArenaFrames = NS.addon

local Outline = EZArenaFrames:NewModule(
    "Outline",
    "AceEvent-3.0"
)

-- Localize WoW API functions


local defaults = {
    profile = {

    },
}

local unitToIndex = {
    arena1 = 1,
    arena2 = 2,
    arena3 = 3,
}

function Outline:OnInitialize()
    self.db = EZArenaFrames.db:RegisterNamespace("Outline", defaults)
end

function Outline:OnEnable()

    --self:CreateTargetOutline()
end

function Outline:OnDisable()
    self:UnregisterAllEvents()
end