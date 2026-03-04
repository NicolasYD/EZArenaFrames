local ADDON_NAME, NS = ...
local EZArenaFrames = NS.addon

local HealthBar = EZArenaFrames:GetModule("Outline")

function HealthBar:GetOptions(moduleOrder)
    local settings = self.db.profile

    return {
        type = "group",
        name = "Outline",
        order = moduleOrder,
        args = {

        },
    }
end
