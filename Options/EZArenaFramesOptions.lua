local ADDON_NAME, NS = ...
local EZArenaFrames = NS.addon

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
                args = {
                    minimap = {
                        type = "toggle",
                        name = "Minimap Button",
                        desc = "Show the minimap button.",
                        width = "full",
                        order = 10,
                        get = function()
                            return not EZArenaFrames.db.profile.general.addon.minimap.hide
                        end,
                        set = function(_, value)
                            EZArenaFrames.db.profile.general.addon.minimap.hide = not value
                            if value then
                                EZArenaFrames.LDBIcon:Show("EZArenaFrames")
                            else
                                EZArenaFrames.LDBIcon:Hide("EZArenaFrames")
                            end
                        end,
                    },
                },
            },
        },
    }
end
