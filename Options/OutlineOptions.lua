local ADDON_NAME, NS = ...
local EZArenaFrames = NS.addon

local Outline = EZArenaFrames:GetModule("Outline")

function Outline:GetOptions(moduleOrder)
    local settings = self.db.profile

    return {
        type = "group",
        name = "Outline",
        order = moduleOrder,
        args = {

        },
    }
end
