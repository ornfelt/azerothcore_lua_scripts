local TrapPlacer = {}

TrapPlacer.NPC_ID = 400034 -- The ID of the NPC you want players to get kill credit for

-- List of allowed zones (use zone ID)
TrapPlacer.ALLOWED_ZONES = {
    1519, -- SW City
    12,	
    14,
    1637
}

-- List of allowed spell IDs
TrapPlacer.ALLOWED_SPELLS = {
    100144, -- Spell 1
    100142, 
    100143,
    100145, 
    -- Add more spells here as needed
}

-- Define the indexOf function for tables
function TrapPlacer.indexOf(t, value)
    for k, v in ipairs(t) do
        if v == value then
            return k
        end
    end
    return -1
end

function TrapPlacer.OnPlayerCastSpell(event, player, spell)
    local spellId = spell:GetEntry()
    local zoneId = player:GetZoneId()

    if TrapPlacer.indexOf(TrapPlacer.ALLOWED_SPELLS, spellId) ~= -1 then
        if TrapPlacer.indexOf(TrapPlacer.ALLOWED_ZONES, zoneId) == -1 then
            spell:Cancel()
            player:SendBroadcastMessage("You cannot use that here.")
        else
            player:KilledMonsterCredit(TrapPlacer.NPC_ID)
            player:SendBroadcastMessage("You have successfully placed a trap!")
        end
    end
end

RegisterPlayerEvent(5, TrapPlacer.OnPlayerCastSpell)
