local ADDON_NAME, NS = ...
local EZArenaFrames = NS.addon

function EZArenaFrames:GetOptions()
    local settings = self.db.profile

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
                    addon = {
                        type = "group",
                        name = "Addon",
                        inline = true,
                        order = 10,
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
                    size = {
                        type = "group",
                        name = "Size",
                        inline = true,
                        order = 20,
                        args = {
                            spacing = {
                                type = "range",
                                name = "Anchor Frames Spacing",
                                desc = "Adjust the spacing between the anchor frames.",
                                min = 0,
                                max = 200,
                                step = 1,
                                get = function()
                                    return settings.anchorFrames.spacingY
                                end,
                                set = function(_, value)
                                    settings.anchorFrames.spacingY = value
                                    EZArenaFrames:StyleAnchorFrames()
                                    EZArenaFrames:StyleSecureAnchorFrames()
                                end,
                            },
                        },
                    },
                },
            },
        },
    }
end
