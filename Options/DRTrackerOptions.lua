local ADDON_NAME, NS = ...
local EZArenaFrames = NS.addon

local DRTracker = EZArenaFrames:GetModule("DRTracker")

function DRTracker:GetOptions(moduleOrder)
    local settings = self.db.profile

    return {
        type = "group",
        name = "DR Tracker",
        order = moduleOrder,
        args = {
            widget = {
                type = "group",
                name = "Widget",
                inline = true,
                order = 1,
                args = {
                    grow = {
                        type = "select",
                        name = "Grow",
                        desc = "Choose in which directions the DR icons should grow.",
                        values = {
                            ["LEFT"] = "Left",
                            ["RIGHT"] = "Right",
                        },
                        get = function(info)
                            return settings.grow
                        end,
                        set = function(info, value)
                            settings.grow = value
                            DRTracker:StyleDRFrames()
                        end,
                    },
                }
            }
        },
    }
end
