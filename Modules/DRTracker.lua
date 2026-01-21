local ADDON_NAME, NS = ...
local EZArenaFrames = NS.addon

local DRTracker = EZArenaFrames:NewModule(
    "DRTracker",
    "AceEvent-3.0"
)

-- Localize WoW API functions
local CreateFrame = CreateFrame

local defaults = {
    profile = {

    },
}

local unitToIndex = {
    arena1 = 1,
    arena2 = 2,
    arena3 = 3,
}

function DRTracker:OnInitialize()
    self.db = EZArenaFrames.db:RegisterNamespace("DRTracker", defaults)
end

function DRTracker:OnEnable()
    self:RegisterEvent("UNIT_SPELL_DIMINISH_CATEGORY_STATE_UPDATED")
end

function DRTracker:OnDisable()
    self:UnregisterAllEvents()
end

function DRTracker:UNIT_SPELL_DIMINISH_CATEGORY_STATE_UPDATED(event, unitTarget, trackerInfo)
    print("event: ", event)
    print("unitTarget: ", unitTarget)
    print("trackerInfo:")
    DevTools_Dump(trackerInfo)
end
