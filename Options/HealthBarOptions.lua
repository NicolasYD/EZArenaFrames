local EZArenaFrames = _G.EZArenaFrames
local HealthBar = EZArenaFrames:GetModule("HealthBar")

function HealthBar:GetOptions()
    return {
        type = "group",
        name = "HealthBar",
        args = {},
    }
end
