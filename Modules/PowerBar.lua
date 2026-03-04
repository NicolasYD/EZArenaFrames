local ADDON_NAME, NS = ...
local EZArenaFrames = NS.addon

local PowerBar = EZArenaFrames:NewModule(
    "PowerBar",
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

function PowerBar:OnInitialize()
    self.db = EZArenaFrames.db:RegisterNamespace("PowerBar", defaults)
end

function PowerBar:OnEnable()

end

function PowerBar:OnDisable()
    self:UnregisterAllEvents()
end
