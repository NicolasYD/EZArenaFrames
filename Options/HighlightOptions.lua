local ADDON_NAME, NS = ...
local EZArenaFrames = NS.addon

local HealthBar = EZArenaFrames:GetModule("Highlight")

function HealthBar:GetOptions(moduleOrder)
    local settings = self.db.profile

    return {
        type = "group",
        name = "Highlight",
        order = moduleOrder,
        args = {

        },
    }
end
