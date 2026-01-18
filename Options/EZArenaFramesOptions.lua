local EZArenaFrames = _G.EZArenaFrames

function EZArenaFrames:GetOptions()
    return {
        type = "group",
        name = "EZ Arena Frames",
        args = {
            testmode = {
                type = "execute",
                name = "Test Mode",
                desc = "Toggle Test Mode",
                func = function()
                    if type(EZArenaFrames.Test) == "function" then
                        EZArenaFrames:Test()
                    end
                end,
            },
            general = {
                type = "group",
                name = "General",
                args = {},
            },
        },
    }
end
