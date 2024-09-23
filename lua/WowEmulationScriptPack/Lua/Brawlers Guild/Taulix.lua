
local CreatureEntryID = 2324800
local TaulixSpells = {33230,33238,44525,44534,44542,44806,44857,44862}
local Strings = {
    phase0 = "REEEEEEEEEEEEEEEEEE!!!!!!!",
    phase1 = "REEEEEEEEEEEEEEEEEE!!!!!!!REEEEEEEEEEEEEEEEEE!!!!!!!",
    phase2 = "REEEEEEEEEEEEEEEEEE!!!!!!!REEEEEEEEEEEEEEEEEE!!!!!!!REEEEEEEEEEEEEEEEEE!!!!!!!",
    phase3 = "REEEEEEEEEEEEEEEEEE!!!!!!!REEEEEEEEEEEEEEEEEE!!!!!!!REEEEEEEEEEEEEEEEEE!!!!!!!",
    phase4 = "REEEEEEEEEEEEEEEEEE....?",
    phase5 = "Why...",
}

local function TaulixPhaseLoop(eventId, delay, calls, creature) --looping phase
        local number = math.random(8)
    if(creature:GetHealthPct() > 80 and creature:GetHealthPct() < 95) then
        creature:SendUnitYell( Strings.phase1, 0 ) 
        creature:CastSpell( creature:GetVictim(), TaulixSpells[number], false)
    elseif (creature:GetHealthPct() > 60) then
		creature:SendUnitYell( Strings.phase2, 0 ) 
        creature:CastSpell( creature:GetVictim(), TaulixSpells[number], false)
        creature:CastSpell( creature:GetVictim(), TaulixSpells[number], false)
    elseif (creature:GetHealthPct() > 40) then
		creature:SendUnitYell( Strings.phase3, 0 ) 
        creature:CastSpell( creature:GetVictim(), TaulixSpells[number], false)
        creature:CastSpell( creature:GetVictim(), TaulixSpells[number], false)
        creature:CastSpell( creature:GetVictim(), TaulixSpells[number], false)
    elseif (creature:GetHealthPct() > 20) then
		creature:SendUnitYell( Strings.phase4, 0 ) 
        creature:CastSpell( creature:GetVictim(), TaulixSpells[number], false)
        creature:CastSpell( creature:GetVictim(), TaulixSpells[number], false)
        creature:CastSpell( creature:GetVictim(), TaulixSpells[number], false)
		creature:CastSpell( creature:GetVictim(), TaulixSpells[number], false)
    else
		creature:SendUnitYell( Strings.phase5, 0 ) 
        creature:CastSpell( creature:GetVictim(), TaulixSpells[number], false)
        creature:CastSpell( creature:GetVictim(), TaulixSpells[number], false)
        creature:CastSpell( creature:GetVictim(), TaulixSpells[number], false)
        creature:CastSpell( creature:GetVictim(), TaulixSpells[number], false)
        creature:CastSpell( creature:GetVictim(), TaulixSpells[number], false)
    end
    creature:RegisterEvent(TaulixPhaseLoop, 5000, 1)
end

function TaulixPhase0(event, creature) -- PHASE 0: on enter combat
	creature:SendUnitYell( Strings.phase5, 0 ) 
	creature:RegisterEvent(TaulixPhaseLoop, 1000, 1)
end



local function OnEnterCombatTaulix(event, creature, target)
    TaulixPhase0(event, creature) -- here we call phase 0 on enter combat
end
RegisterCreatureEvent(CreatureEntryID, 1, OnEnterCombatTaulix)

local function OnLeaveCombatTaulix(event, creature)
    creature:RemoveEvents()
end
RegisterCreatureEvent(CreatureEntryID, 2, OnLeaveCombatTaulix)

local function OnDiedTaulix(event, creature, killer)
    if(killer:GetObjectType() == "Player") then
        killer:SendBroadcastMessage("Congratulations! You managed to kill |cff00ff00" ..creature:GetName().."|r!")
    end
    creature:RemoveEvents()
end
RegisterCreatureEvent(CreatureEntryID, 4, OnDiedTaulix)
