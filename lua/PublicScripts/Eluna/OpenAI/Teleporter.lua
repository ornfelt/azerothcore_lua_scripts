--[[
    This teleporter was generated using OpenAI (with a good amount of coaching). 
    The teleporter supports a variable amount of teleport locations per page using OPTIONS_PER_PAGE, as well as faction and level specific teleport options.

    It's not the most advanced script, but this is probably as far as I can take OpenAI in its current form without the need for more hand holding. 
    Trying to add more features caused the AI to break.

    I have not tested the code other than looking over the logic. It looks alright, so use it as you please.
]]

-- This script allows a creature to teleport a player to a specified location
-- when the player selects the appropriate gossip option.

-- The number of gossip options per page.
local OPTIONS_PER_PAGE = 16

-- The entry ID of the teleporter creature
local CREATURE_ID = 12345

-- First, we'll define the creature's gossip options and their corresponding
-- destinations.
local GOSSIP_OPTIONS = {
    {
        text = "Teleport to Ironforge",
        destination = { map = 0, x = -4918.15, y = -976.792, z = 501.535, o = 0 },
        faction = 0,  -- Alliance only
        level = 10,   -- Required level: 10
    },
    {
        text = "Teleport to Stormwind",
        destination = { map = 0, x = -8913.23, y = 554.633, z = 93.7944, o = 0 },
        faction = 0,  -- Alliance only
        level = 10,   -- Required level: 10
    },
    {
        text = "Teleport to Orgrimmar",
        destination = { map = 1, x = 1479.5, y = -4178.5, z = 25.5, o = 0 },
        faction = 1,  -- Horde only
        level = 10,   -- Required level: 10
    },
    {
        text = "Teleport to Thunder Bluff",
        destination = { map = 1, x = -1280.5, y = 127.5, z = 131.5, o = 0 },
        faction = 1,  -- Horde only
        level = 10,   -- Required level: 10
    },
    {
        text = "Teleport to Dalaran",
        destination = { map = 571, x = 5804.15, y = 624.792, z = 647.535, o = 0 },
        faction = -1,  -- Both Horde and Alliance
        level = 70,   -- Required level: 70
    },
}

-- Next, we'll define the creature's OnGossip function, which is called
-- when the player talks to the creature and selects one of the gossip options.
local function OnGossip(event, player, creature, page)
    -- Set the page number to 1 if it's not set.
    if not page then
        page = 1
    end

    -- Calculate the indices of the first and last options on the current page.
    local startIndex = (page - 1) * OPTIONS_PER_PAGE + 1
    local endIndex = startIndex + OPTIONS_PER_PAGE - 1

    -- Add the gossip options that are available to the player's faction and on the current page.
    for i, option in ipairs(GOSSIP_OPTIONS) do
        if i >= startIndex and i <= endIndex and (option.faction == -1 or option.faction == player:GetTeam()) and player:GetLevel() >= option.level then
            player:GossipMenuAddItem(0, option.text, 0, i)
        end
    end

    -- Add the "Next" and "Back" buttons if there are more options.
    if endIndex < #GOSSIP_OPTIONS then
        player:GossipMenuAddItem(0, "Next", page, #GOSSIP_OPTIONS + 1)
    end
    if page > 1 then
        player:GossipMenuAddItem(0, "Back", page, #GOSSIP_OPTIONS + 2)
    end

    -- Send the gossip menu to the player.
    player:GossipSendMenu(0, creature)
end

local function OnGossipSelect(event, player, creature, sender, intid, code, menu_id)
    -- Find the selected gossip option and teleport the player to the specified location,
    -- or navigate to the next or previous page.
    local option = GOSSIP_OPTIONS[intid]
    if option then
        player:Teleport(option.destination.map, option.destination.x, option.destination.y, option.destination.z, option.destination.o)
    elseif intid == #GOSSIP_OPTIONS + 1 then  -- "Next" button
        OnGossip(event, player, creature, sender + 1)
    elseif intid == #GOSSIP_OPTIONS + 2 then  -- "Back" button
        OnGossip(event, player, creature, sender - 1)
    end
end

-- Finally, we'll register the OnGossip and OnGossipSelect functions to be
-- called when the player talks to the creature.
RegisterCreatureGossipEvent(CREATURE_ID, 1, OnGossip)
RegisterCreatureGossipEvent(CREATURE_ID, 2, OnGossipSelect)
