
local CreatureEntryID = 2324900
local RegnarSpells = {34889,34824,34820,34802,34800,34899,34798,34752}
local Strings = {
    phase0 = "I have no quarrels with you, yet you still wish to fight?",
    phase1 = "So be it.",
    phase2 = "So it is said, so it shall be.",
    phase3 = "All too easy..",
    phase4 = "This is impossible. Die!",
    phase5 = "So... Ruthless...",
}

local function RegnarPhaseLoop(eventId, delay, calls, creature) --looping phase
        local number = math.random(8)
    if(creature:GetHealthPct() > 80 and creature:GetHealthPct() < 95) then
        creature:SendUnitYell( Strings.phase1, 0 ) 
        creature:CastSpell( creature:GetVictim(), RegnarSpells[number], false)
    elseif (creature:GetHealthPct() > 60) then
		creature:SendUnitYell( Strings.phase2, 0 ) 
        creature:CastSpell( creature:GetVictim(), RegnarSpells[number], false)
        creature:CastSpell( creature:GetVictim(), RegnarSpells[number], false)
    elseif (creature:GetHealthPct() > 40) then
		creature:SendUnitYell( Strings.phase3, 0 ) 
        creature:CastSpell( creature:GetVictim(), RegnarSpells[number], false)
        creature:CastSpell( creature:GetVictim(), RegnarSpells[number], false)
        creature:CastSpell( creature:GetVictim(), RegnarSpells[number], false)
    elseif (creature:GetHealthPct() > 20) then
		creature:SendUnitYell( Strings.phase4, 0 ) 
        creature:CastSpell( creature:GetVictim(), RegnarSpells[number], false)
        creature:CastSpell( creature:GetVictim(), RegnarSpells[number], false)
        creature:CastSpell( creature:GetVictim(), RegnarSpells[number], false)
		creature:CastSpell( creature:GetVictim(), RegnarSpells[number], false)
    else
		creature:SendUnitYell( Strings.phase5, 0 ) 
        creature:CastSpell( creature:GetVictim(), RegnarSpells[number], false)
        creature:CastSpell( creature:GetVictim(), RegnarSpells[number], false)
        creature:CastSpell( creature:GetVictim(), RegnarSpells[number], false)
        creature:CastSpell( creature:GetVictim(), RegnarSpells[number], false)
        creature:CastSpell( creature:GetVictim(), RegnarSpells[number], false)
    end
    creature:RegisterEvent(RegnarPhaseLoop, 5000, 1)
end

function RegnarPhase0(event, creature) -- PHASE 0: on enter combat
	creature:SendUnitYell( Strings.phase5, 0 ) 
	creature:RegisterEvent(RegnarPhaseLoop, 1000, 1)
end



local function OnEnterCombatRegnar(event, creature, target)
    RegnarPhase0(event, creature) -- here we call phase 0 on enter combat
end
RegisterCreatureEvent(CreatureEntryID, 1, OnEnterCombatRegnar)

local function OnLeaveCombatRegnar(event, creature)
    creature:RemoveEvents()
end
RegisterCreatureEvent(CreatureEntryID, 2, OnLeaveCombatRegnar)

local function OnDiedRegnar(event, creature, killer)
    if(killer:GetObjectType() == "Player") then
        killer:SendBroadcastMessage("Congratulations! You managed to kill |cff00ff00" ..creature:GetName().."|r!")
    end
    creature:RemoveEvents()
end
RegisterCreatureEvent(CreatureEntryID, 4, OnDiedRegnar)
