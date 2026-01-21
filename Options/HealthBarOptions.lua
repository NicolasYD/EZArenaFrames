local ADDON_NAME, NS = ...
local EZArenaFrames = NS.addon

local HealthBar = EZArenaFrames:GetModule("HealthBar")

function HealthBar:GetOptions()
    local settings = self.db.profile

    return {
        type = "group",
        name = "Health Bar",
        args = {
            size = {
                type = "group",
                name = "Size",
                inline = true,
                order = 1,
                args = {
                    width = {
                        type = "range",
                        name = "Width",
                        desc = "Adjust the health bar width",
                        min = settings.minWidth,
                        max = settings.maxWidth,
                        step = 1,
                        get = function()
                            return settings.width
                        end,
                        set = function(_, value)
                            settings.width = value
                            HealthBar:StyleHealthBar()
                            HealthBar:StyleSecureButton()
                        end,
                    },
                    height = {
                        type = "range",
                        name = "Height",
                        desc = "Adjust the health bar height",
                        min = settings.minHeight,
                        max = settings.maxHeight,
                        step = 1,
                        get = function()
                            return settings.height
                        end,
                        set = function(_, value)
                            settings.height = value
                            HealthBar:StyleHealthBar()
                            HealthBar:StyleSecureButton()
                        end,
                    },
                },
            },
        },
    }
end
