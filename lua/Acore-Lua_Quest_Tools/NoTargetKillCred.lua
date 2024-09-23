--Credits to Dinkledork
--Allows you to cast specified spells to get kill credit for an npc. Handy when you are just needing to cast spells but don't have a specific npc to target
--Made this for a quest to have players set traps in Stormwind. 
--Zone must be specified. Will likely update this script in the future just to tweak it a bit but is fine as is currently.

local NPC_ID = 400034 -- The ID of the NPC you want players to get kill credit for. This is a dummy npc (just need db entry but not to actually exist in game)

-- List of allowed zones to use the spell in (use zone ID)
local ALLOWED_ZONES = {
   1519, -- SW City
   12,
   14,
   1637	--Elwyn Forest
}

-- List of allowed spell IDs to count toward quest credit
local ALLOWED_SPELLS = {
    100144, -- Spell 1
    100142, -- Spell 2
    100143, -- Spell 3
	100145, --Spell 4
    -- Add more spells here as needed
}

-- Define the indexOf function for tables
function table.indexOf(t, value)
    for k, v in ipairs(t) do
        if v == value then
            return k
        end
    end
    return -1
end

function OnPlayerCastSpell(event, player, spell)
    local spellId = spell:GetEntry()
    local zoneId = player:GetZoneId()

    if table.indexOf(ALLOWED_SPELLS, spellId) ~= -1 then
        if table.indexOf(ALLOWED_ZONES, zoneId) == -1 then
            spell:Cancel()
            player:SendBroadcastMessage("You cannot use that here.") -- change me
        else
            player:KilledMonsterCredit(NPC_ID)
            player:SendBroadcastMessage("You have successfuly placed a trap!") -- change me
        end
    end
end

RegisterPlayerEvent(5, OnPlayerCastSpell)
