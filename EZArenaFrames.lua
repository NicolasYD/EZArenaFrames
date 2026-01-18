-- Create addon object and make it globally accessible
local ADDON_NAME, NS = ...

-- Library references
local LibStub = LibStub

local EZArenaFrames = LibStub("AceAddon-3.0"):NewAddon(
    ADDON_NAME,
    "AceEvent-3.0",
    "AceConsole-3.0"
)

_G.EZArenaFrames = EZArenaFrames

-- Localize WoW API functions
local InCombatLockdown = InCombatLockdown
local CreateFrame = CreateFrame
local GetArenaOpponentSpec = GetArenaOpponentSpec

-- Shared state flags
EZArenaFrames.test = false

-- Core lifecycle hooks
function EZArenaFrames:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("EZArenaFramesDB", {
        profile = {
            modules = {},
            anchorFrames = {
                width = 40,
                height = 40,
                spacingY = 80,
            },
        },
    }, true)

    self:RegisterOptions()
end

function EZArenaFrames:OnEnable()
    self:RegisterEvent("ARENA_PREP_OPPONENT_SPECIALIZATIONS")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")

    self:CreateAnchorFrames()
    self:CreateSecureAnchorFrames()
end

function EZArenaFrames:OnDisable()
    self:UnregisterAllEvents()
end

function EZArenaFrames:RegisterOptions()
    local AceConfig = LibStub("AceConfig-3.0")
    local AceConfigDialog = LibStub("AceConfigDialog-3.0")

    local options = self:GetOptions()

    AceConfig:RegisterOptionsTable("EZArenaFrames", options)
    AceConfigDialog:AddToBlizOptions("EZArenaFrames", "EZArenaFrames")

    for _, module in self:IterateModules() do
        if type(module.GetOptions) == "function" then
            local name = module.moduleName or module.name
            options.args[name] = module:GetOptions()
        end
    end
end

function EZArenaFrames:ARENA_PREP_OPPONENT_SPECIALIZATIONS()
    for i = 1, 3 do
        local specID = GetArenaOpponentSpec(i)
        if specID and specID > 0 then
            self:ShowAnchorFrames(i, true)
        end
    end
end

function EZArenaFrames:PLAYER_ENTERING_WORLD(event, isInitialLogin, isReloadingUi)
    for i = 1, 3 do
        local specID = GetArenaOpponentSpec(i)
        if specID and specID > 0 then
            self:ShowAnchorFrames(i, true)
        else
            -- self:ShowAnchorFrames(i, true) -- for testing
            self:ShowAnchorFrames(i, false)
        end
    end
end

-- Create anchor frames
function EZArenaFrames:CreateAnchorFrames()
    self.anchorFrames = self.anchorFrames or {}

    for i = 1, 3 do
        if not self.anchorFrames[i] then
            local name = "EZAF_Arena" .. i .. "Anchor"

            local frame = CreateFrame("Frame", name, UIParent)

            if not frame.icon then -- for testing
                local icon = frame:CreateTexture(nil, "OVERLAY")
                frame.icon = icon
            end

            frame:Hide()

            self.anchorFrames[i] = frame
        end
    end

    self:StyleAnchorFrames()
end

-- Create secure anchor frames
function EZArenaFrames:CreateSecureAnchorFrames()
    if InCombatLockdown() then return end

    self.secureAnchorFrames = self.secureAnchorFrames or {}

    for i = 1, 3 do
        if not self.secureAnchorFrames[i] then
            local name = "EZAF_Arena" .. i .. "SecureAnchor"

            local frame = CreateFrame("Frame", name, UIParent, "SecureHandlerStateTemplate")

            RegisterStateDriver(frame, "visibility", "[@arena"..i..",exists] show; hide")

            self.secureAnchorFrames[i] = frame
        end
    end

    self:StyleSecureAnchorFrames()
end

-- Style anchor frames
function EZArenaFrames:StyleAnchorFrames()
    local settings = self.db.profile.anchorFrames

    for index, frame in ipairs(self.anchorFrames) do
        frame:ClearAllPoints()
        frame:SetPoint("CENTER", UIParent, "CENTER", 0, -(index - 1) * settings.spacingY)
        frame:SetSize(settings.width, settings.height) -- Invisible frames still need a size or the child frames are not shown

        -- for testing
        frame.icon:ClearAllPoints()
        frame.icon:SetAllPoints()
        frame.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
    end
end

function EZArenaFrames:StyleSecureAnchorFrames()
    if InCombatLockdown() then return end

    local settings = self.db.profile.anchorFrames

    for index, frame in ipairs(self.secureAnchorFrames) do
        frame:ClearAllPoints()
        frame:SetPoint("CENTER", UIParent, "CENTER", 0, -(index - 1) * settings.spacingY)
        frame:SetSize(settings.width, settings.height) -- Invisible frames still need a size or the child frames are not shown
    end
end

function EZArenaFrames:ShowAnchorFrames(index, show)
    local name = "EZAF_Arena" .. index .. "Anchor"
    local frame = _G[name]

    if frame then
        if show then
            frame:Show()
        else
            frame:Hide()
        end
    end
end

function EZArenaFrames:Test()
    if not self.test then
        self.test = true

        for i = 1, 3 do
            self:ShowAnchorFrames(i, true)
        end
    elseif self.test then
        self.test = false

        for i = 1, 3 do
            self:ShowAnchorFrames(i, false)
        end
    end

    for _, module in self:IterateModules() do
        if type(module.Test) == "function" then
            module:Test()
        end
    end
end
