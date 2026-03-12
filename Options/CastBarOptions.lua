local ADDON_NAME, NS = ...
local EZArenaFrames = NS.addon

local CastBar = EZArenaFrames:GetModule("CastBar")

function CastBar:GetOptions(moduleOrder)
    local settings = self.db.profile

    return {
        type = "group",
        name = "Cast Bar",
        order = moduleOrder,
        args = {

        },
    }
end
