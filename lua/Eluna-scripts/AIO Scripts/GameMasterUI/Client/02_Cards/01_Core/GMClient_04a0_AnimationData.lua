local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

if not GM_RequireNamespace() then return end

-- ============================================================
-- Animation Data — predefined WoW 3.3.5 animation sequence IDs
-- Used by card animation dropdown and magnifier viewer
-- ============================================================

local GMCards = _G.GMCards
local GMData = _G.GMData

-- Animation definitions: { id, label, category }
-- Not all creatures support all animations — unsupported ones
-- silently fallback to stand.
local ANIMATION_LIST = {
    -- Basic Movement
    { id = 0,   label = "Stand",             category = "Basic" },
    { id = 4,   label = "Walk",              category = "Basic" },
    { id = 5,   label = "Run",               category = "Basic" },
    { id = 13,  label = "Walk Backwards",    category = "Basic" },
    { id = 37,  label = "Jump Start",        category = "Basic" },
    { id = 38,  label = "Jump",              category = "Basic" },
    { id = 39,  label = "Jump End",          category = "Basic" },
    { id = 40,  label = "Fall",              category = "Basic" },
    { id = 135, label = "Fly",               category = "Basic" },

    -- Combat
    { id = 16,  label = "Attack Unarmed",    category = "Combat" },
    { id = 17,  label = "Attack 1H",         category = "Combat" },
    { id = 18,  label = "Attack 2H",         category = "Combat" },
    { id = 19,  label = "Attack 2HL",        category = "Combat" },
    { id = 46,  label = "Attack Bow",        category = "Combat" },
    { id = 49,  label = "Attack Rifle",      category = "Combat" },
    { id = 107, label = "Attack Thrown",      category = "Combat" },
    { id = 20,  label = "Parry Unarmed",     category = "Combat" },
    { id = 21,  label = "Parry 1H",          category = "Combat" },
    { id = 22,  label = "Parry 2H",          category = "Combat" },
    { id = 24,  label = "Shield Block",      category = "Combat" },
    { id = 30,  label = "Dodge",             category = "Combat" },
    { id = 25,  label = "Ready Unarmed",     category = "Combat" },
    { id = 26,  label = "Ready 1H",          category = "Combat" },
    { id = 27,  label = "Ready 2H",          category = "Combat" },
    { id = 29,  label = "Ready Bow",         category = "Combat" },
    { id = 55,  label = "Battle Roar",       category = "Combat" },

    -- Spells
    { id = 2,   label = "Spell",             category = "Spells" },
    { id = 31,  label = "Spell Precast",     category = "Spells" },
    { id = 32,  label = "Spell Cast",        category = "Spells" },
    { id = 33,  label = "Spell Cast Area",   category = "Spells" },
    { id = 51,  label = "Ready Spell Dir.",  category = "Spells" },
    { id = 52,  label = "Ready Spell Omni",  category = "Spells" },
    { id = 53,  label = "Spell Cast Dir.",   category = "Spells" },
    { id = 54,  label = "Spell Cast Omni",   category = "Spells" },
    { id = 124, label = "Channel Dir.",      category = "Spells" },
    { id = 125, label = "Channel Omni",      category = "Spells" },

    -- Emotes / Social
    { id = 60,  label = "Talk",              category = "Social" },
    { id = 64,  label = "Exclamation",       category = "Social" },
    { id = 65,  label = "Question",          category = "Social" },
    { id = 66,  label = "Bow",              category = "Social" },
    { id = 67,  label = "Wave",              category = "Social" },
    { id = 68,  label = "Cheer",             category = "Social" },
    { id = 69,  label = "Dance",             category = "Social" },
    { id = 70,  label = "Laugh",             category = "Social" },
    { id = 71,  label = "Sleep",             category = "Social" },
    { id = 73,  label = "Rude",              category = "Social" },
    { id = 74,  label = "Roar",              category = "Social" },
    { id = 75,  label = "Kneel",             category = "Social" },
    { id = 76,  label = "Kiss",              category = "Social" },
    { id = 77,  label = "Cry",               category = "Social" },
    { id = 78,  label = "Chicken",           category = "Social" },
    { id = 79,  label = "Beg",               category = "Social" },
    { id = 80,  label = "Applaud",           category = "Social" },
    { id = 81,  label = "Shout",             category = "Social" },
    { id = 82,  label = "Flex",              category = "Social" },
    { id = 83,  label = "Shy",               category = "Social" },
    { id = 84,  label = "Point",             category = "Social" },
    { id = 113, label = "Salute",            category = "Social" },
    { id = 185, label = "Yes",               category = "Social" },
    { id = 186, label = "No",                category = "Social" },

    -- Actions
    { id = 1,   label = "Death",             category = "Actions" },
    { id = 6,   label = "Dead",              category = "Actions" },
    { id = 14,  label = "Stun",              category = "Actions" },
    { id = 50,  label = "Loot",              category = "Actions" },
    { id = 61,  label = "Eat",               category = "Actions" },
    { id = 62,  label = "Work",              category = "Actions" },
    { id = 63,  label = "Use Standing",      category = "Actions" },
    { id = 91,  label = "Mount",             category = "Actions" },
    { id = 95,  label = "Kick",              category = "Actions" },
    { id = 121, label = "Knockdown",         category = "Actions" },
    { id = 126, label = "Whirlwind",         category = "Actions" },
    { id = 127, label = "Birth",             category = "Actions" },
    { id = 130, label = "Creature Special",  category = "Actions" },
    { id = 196, label = "Emote Dead",        category = "Actions" },
    { id = 197, label = "Dance Once",        category = "Actions" },

    -- Swimming / Misc
    { id = 41,  label = "Swim Idle",         category = "Misc" },
    { id = 42,  label = "Swim",              category = "Misc" },
    { id = 119, label = "Stealth Walk",      category = "Misc" },
    { id = 120, label = "Stealth Stand",     category = "Misc" },
    { id = 131, label = "Drown",             category = "Misc" },
    { id = 133, label = "Fishing Cast",      category = "Misc" },
    { id = 134, label = "Fishing Loop",      category = "Misc" },
    { id = 143, label = "Sprint",            category = "Misc" },
}

-- Build dropdown items grouped by category
local function buildDropdownItems()
    local items = {}
    items[#items + 1] = "Default"
    items[#items + 1] = { isSeparator = true }

    local lastCategory = nil
    for _, anim in ipairs(ANIMATION_LIST) do
        if anim.category ~= lastCategory then
            if lastCategory then
                items[#items + 1] = { isSeparator = true }
            end
            items[#items + 1] = { isTitle = true, text = anim.category }
            lastCategory = anim.category
        end
        items[#items + 1] = {
            text = anim.label .. "  [" .. anim.id .. "]",
            value = anim.id,
        }
    end
    return items
end

-- Shared state: currently selected animation
local selectedCardAnimId = nil

-- Start looping animation on a model via a driver frame
-- Uses SetSequenceTime to manually advance the animation each tick
local function applyAnimationToModel(model, animId)
    if not model then return end

    -- Stop existing driver
    if model._animDriver then
        model._animDriver:SetScript("OnUpdate", nil)
    end

    model._activeAnimId = animId

    if not animId then
        pcall(function() model:SetSequence(0) end)
        return
    end

    -- Create driver frame once
    if not model._animDriver then
        model._animDriver = CreateFrame("Frame", nil, model)
        model._animDriver:SetSize(1, 1)
        model._animDriver:SetPoint("CENTER")
    end

    model._animElapsed = 0
    pcall(function() model:SetSequence(animId) end)

    model._animDriver:SetScript("OnUpdate", function(_, dt)
        -- Pause animation loop during hover spin
        if model._spinActive then return end

        model._animElapsed = model._animElapsed + dt
        pcall(function()
            model:SetSequenceTime(animId, model._animElapsed * 1000)
        end)
    end)
end

-- Apply selected animation to all visible card models
local function applyAnimationToAllCards()
    if not GMCards or not GMCards.getActiveCards then return end
    for card in pairs(GMCards.getActiveCards()) do
        if card.modelFrame then
            applyAnimationToModel(card.modelFrame, selectedCardAnimId)
        end
    end
end

-- ============================================================
-- Card area animation dropdown
-- ============================================================

local function createCardAnimDropdown(parent)
    local tabBar = GMData and GMData.frames.tabBar
    if not tabBar then return nil end

    local label = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    label:SetPoint("LEFT", tabBar, "LEFT", 160, 0)
    label:SetText("Anim:")
    label:SetTextColor(0.8, 0.8, 0.8)

    local dropdown = CreateFullyStyledDropdown(
        parent, 150, buildDropdownItems(), "Default",
        function(value)
            if value == "Default" then
                selectedCardAnimId = nil
            else
                selectedCardAnimId = value
            end
            applyAnimationToAllCards()
        end,
        true, "Search..."
    )
    dropdown:SetPoint("LEFT", label, "RIGHT", 5, 0)

    if GMData then
        GMData.frames.animDropdown = dropdown
        GMData.frames.animLabel = label
    end

    return dropdown
end

-- ============================================================
-- Magnifier animation dropdown (for the side panel)
-- ============================================================

local function createMagnifierAnimDropdown(sidePanel, index)
    local dropdown = CreateFullyStyledDropdown(
        sidePanel, 36, buildDropdownItems(), "Default",
        function(value)
            local model = _G["FullModel" .. index]
            if not model then return end
            local animId = (value == "Default") and nil or value
            applyAnimationToModel(model, animId)
        end,
        false
    )
    return dropdown
end

-- Export to namespace
GMCards.AnimationData = {
    LIST = ANIMATION_LIST,
    buildDropdownItems = buildDropdownItems,
    getSelectedAnimation = function() return selectedCardAnimId end,
    setSelectedAnimation = function(id) selectedCardAnimId = id end,
    applyAnimationToModel = applyAnimationToModel,
    applyAnimationToAllCards = applyAnimationToAllCards,
    createCardAnimDropdown = createCardAnimDropdown,
    createMagnifierAnimDropdown = createMagnifierAnimDropdown,
}

-- Animation Data module loaded
