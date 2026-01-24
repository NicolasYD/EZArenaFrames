local ADDON_NAME, NS = ...
local EZArenaFrames = NS.addon

local DRTracker = EZArenaFrames:NewModule(
    "DRTracker",
    "AceEvent-3.0"
)

-- Localize WoW API functions
local CreateFrame = CreateFrame
local GetSpellTexture = C_Spell.GetSpellTexture
local GetAllSpellDiminishCategories = C_SpellDiminish.GetAllSpellDiminishCategories

local defaults = {
    profile = {
        size = 30,
        spacing = 5,
        offsetX = -5,
        offsetY = 0,
        grow = "LEFT",
        drawBling = false,

        drCategories = {
            -- Root
            [0] = {
                fallbackIcon = 339, -- Entangling Roots
                priority = 6,
            },

            -- Taunt
            [1] = {
                fallbackIcon = 355, -- Taunt
                priority = 8,
            },

            -- Stun
            [2] = {
                fallbackIcon = 408, -- Kidney Shot
                priority = 1,
            },

            -- AoEKnockback
            [3] = {
                fallbackIcon = 51490, -- Thunderstorm
                priority = 7,
            },

            -- Incapacitate
            [4] = {
                fallbackIcon = 118, -- Polymorph
                priority = 2,
            },

            -- Disorient
            [5] = {
                fallbackIcon = 5782, -- Fear
                priority = 3,
            },

            -- Silence
            [6] = {
                fallbackIcon = 15487, -- Silence
                priority = 4,
            },

            -- Disarm
            [7] = {
                fallbackIcon = 455098, -- Disarm
                priority = 5,
            }
        },
    },
}

-- Create list of relevant DR categories
local spellDiminishCategories = GetAllSpellDiminishCategories()
for index, categoryInfo in ipairs(spellDiminishCategories) do
    if categoryInfo.category == 1 then -- Remove "Taunt" category from list
      spellDiminishCategories[index] = nil
    end
end

local unitToIndex = {
    arena1 = 1,
    arena2 = 2,
    arena3 = 3,
}

function DRTracker:OnInitialize()
    self.db = EZArenaFrames.db:RegisterNamespace("DRTracker", defaults)
end

function DRTracker:OnEnable()
    self:RegisterEvent("UNIT_SPELL_DIMINISH_CATEGORY_STATE_UPDATED")

    self:CreateDRFrames()
end

function DRTracker:OnDisable()
    self:UnregisterAllEvents()
end

function DRTracker:UNIT_SPELL_DIMINISH_CATEGORY_STATE_UPDATED(event, unitTarget, trackerInfo)
    DevTools_Dump(trackerInfo)
end

function DRTracker:CreateDRFrames()
    for i = 1, 3 do
        local parent = EZArenaFrames.anchorFrames[i]

        if parent and not parent.DRTracker then

            local drContainerFrame = CreateFrame("Frame", nil, parent)

            parent.DRTracker = {
                container = drContainerFrame,
                frames ={},
            }

            local drFrames = {}
            for _, drInfo in pairs(spellDiminishCategories) do

                local drFrame = CreateFrame("Cooldown", nil, drContainerFrame, "CooldownFrameTemplate")
                drFrame.categoryName = drInfo.name

                local icon = drFrame:CreateTexture(nil, "ARTWORK")
                icon:SetAllPoints()
                drFrame.icon = icon

                drFrames[drInfo.category] = drFrame
            end

            parent.DRTracker.frames = drFrames
        end
    end

    self:StyleDRFrames()
end

function DRTracker:StyleDRFrames()
    local settings = self.db.profile

    for i = 1, 3 do
        local parent = EZArenaFrames.anchorFrames[i]

        if parent and parent.DRTracker then

            local drContainerFrame = parent.DRTracker.container

            drContainerFrame:ClearAllPoints()
            if settings.grow == "LEFT" then
                drContainerFrame:SetPoint("TOPRIGHT", parent, "TOPLEFT", settings.offsetX, settings.offsetY)
            elseif settings.grow == "RIGHT" then
                drContainerFrame:SetPoint("TOPLEFT", parent, "TOPRIGHT", settings.offsetX, settings.offsetY)
            end
            drContainerFrame:SetSize(settings.size, settings.size)

            local drFrames = parent.DRTracker.frames
            local previousFrame
            for drCategory, drFrame in pairs(drFrames) do

                if not previousFrame then
                    drFrame:ClearAllPoints()
                    if settings.grow == "LEFT" then
                        drFrame:SetPoint("RIGHT", drContainerFrame, "RIGHT", 0, 0)
                    elseif settings.grow == "RIGHT" then
                        drFrame:SetPoint("LEFT", drContainerFrame, "LEFT", 0, 0)
                    end
                else
                    drFrame:ClearAllPoints()
                    if settings.grow == "LEFT" then
                        drFrame:SetPoint("RIGHT", previousFrame, "LEFT", -settings.spacing, 0)
                    elseif settings.grow == "RIGHT" then
                        drFrame:SetPoint("LEFT", previousFrame, "RIGHT", settings.spacing, 0)
                    end
                end
                drFrame:SetSize(settings.size, settings.size)
                drFrame:SetDrawBling(settings.drawBling)

                drFrame.icon:SetTexture(GetSpellTexture(settings.drCategories[drCategory].fallbackIcon))

                previousFrame = drFrame
            end
        end
    end
end

function DRTracker:Test()
    if EZArenaFrames.test then
        for i = 1, 3 do
            local parent = EZArenaFrames.anchorFrames[i]

            for _, drInfo in pairs(spellDiminishCategories) do
                local drCategory = drInfo.category

                local drFrame = parent.DRTracker.frames[drCategory]

                local start = GetTime()
                local duration = 16

                drFrame:SetCooldown(start, duration)
            end
        end
    end
end
