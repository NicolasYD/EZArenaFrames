local ADDON_NAME, NS = ...
local EZArenaFrames = NS.addon

local PowerBar = EZArenaFrames:GetModule("PowerBar")

function PowerBar:GetOptions(moduleOrder)
    local settings = self.db.profile

    return {
        type = "group",
        name = "Power Bar",
        order = moduleOrder,
        args = {

        },
    }
end
