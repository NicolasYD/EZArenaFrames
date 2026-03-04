local ADDON_NAME, NS = ...
local EZArenaFrames = NS.addon

local Highlight = EZArenaFrames:NewModule(
    "Highlight",
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

function Highlight:OnInitialize()
    self.db = EZArenaFrames.db:RegisterNamespace("Highlight", defaults)
end

function Highlight:OnEnable()

end

function Highlight:OnDisable()
    self:UnregisterAllEvents()
end