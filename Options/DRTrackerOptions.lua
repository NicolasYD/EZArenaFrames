local ADDON_NAME, NS = ...
local EZArenaFrames = NS.addon

local DRTracker = EZArenaFrames:GetModule("DRTracker")

function DRTracker:GetOptions(moduleOrder)
    local settings = self.db.profile

    return {
        type = "group",
        name = "DR Tracker",
        order = moduleOrder,
        args = {

        },
    }
end
