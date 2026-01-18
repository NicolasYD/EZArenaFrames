local ADDON_NAME, NS = ...
local EZArenaFrames = NS.addon

local HealthBar = EZArenaFrames:GetModule("HealthBar")

function HealthBar:GetOptions()
    return {
        type = "group",
        name = "HealthBar",
        args = {},
    }
end
