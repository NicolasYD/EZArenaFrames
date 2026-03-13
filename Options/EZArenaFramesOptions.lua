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
                order = 10,
                func = function()
                    if type(EZArenaFrames.Test) == "function" then
                        EZArenaFrames:Test()
                    end
                end,
            },
            general = {
                type = "group",
                name = "General",
                order = 20,
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
                                    return not settings.general.addon.minimap.hide
                                end,
                                set = function(_, value)
                                    settings.general.addon.minimap.hide = not value
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
                        name = "Arena Frames",
                        inline = true,
                        order = 20,
                        args = {
                            positionLocked = {
                                type = "toggle",
                                name = "Lock Position",
                                desc = "Lock the position of the arena frames.",
                                order = 10,
                                get = function()
                                    return settings.containerFrame.locked
                                end,
                                set = function(_, value)
                                    settings.containerFrame.locked = value
                                    EZArenaFrames:StyleContainerFrame()
                                end,
                            },
                            sep1 = {
                                type = "description",
                                name = "",
                                width = "full",
                                order = 11
                            },
                            spacing = {
                                type = "range",
                                name = "Spacing",
                                desc = "Adjust the spacing between the arena frames.",
                                min = 0,
                                max = 200,
                                step = 1,
                                order = 20,
                                get = function()
                                    return settings.anchorFrames.spacingY
                                end,
                                set = function(_, value)
                                    settings.anchorFrames.spacingY = value
                                    EZArenaFrames:StyleAnchorFrames()
                                    EZArenaFrames:StyleSecureAnchorFrames()
                                end,
                            },
                            sep2 = {
                                type = "description",
                                name = "",
                                width = "full",
                                order = 21
                            },
                            scale = {
                                type = "range",
                                name = "Scale",
                                desc = "Adjust the scale of the arena frames.",
                                min = 0.1,
                                max = 3,
                                step = 0.1,
                                order = 30,
                                get = function()
                                    return settings.containerFrame.scale
                                end,
                                set = function(_, value)
                                    settings.containerFrame.scale = value
                                    EZArenaFrames:StyleContainerFrame()
                                end,
                            },
                            sep3 = {
                                type = "description",
                                name = "",
                                width = "full",
                                order = 31
                            },
                        },
                    },
                },
            },
        },
    }
end
