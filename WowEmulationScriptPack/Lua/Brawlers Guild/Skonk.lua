
local CreatureEntryID = 2324600
local SkonkOffenseSpells = {67875,52469,7938,71729,11016}
local SkonkDefenseSpells = {707019}
local Strings = {
    phase0 = "Rawr Bitch!",
    phase1 = "Chomp Chomp!!!",
    phase2 = "Skonk... belly hurt... MORE FOOD!!!",
    phase3 = "Why...won't... you...DIE!",
    phase4 = "Skonk don't feel so well...",
    phase5 = "Grumble... mumble... skonk is in trouble...",
}

local function SkonkPhaseLoop(eventId, delay, calls, creature) --looping phase
        local number = math.random(5)
		local numberdefense = math.random(1)
    if(creature:GetHealthPct() > 80 and creature:GetHealthPct() < 95) then
        creature:SendUnitYell( Strings.phase1, 0 ) 
        creature:CastSpell( creature:GetVictim(), SkonkOffenseSpells[number], false)
    elseif (creature:GetHealthPct() > 60) then
		creature:SendUnitYell( Strings.phase2, 0 ) 
        creature:CastSpell( creature:GetVictim(), SkonkOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), SkonkOffenseSpells[number], false)
    elseif (creature:GetHealthPct() > 40) then
		creature:SendUnitYell( Strings.phase3, 0 ) 
        creature:CastSpell( creature:GetVictim(), SkonkOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), SkonkOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), SkonkOffenseSpells[number], false)
    elseif (creature:GetHealthPct() > 20) then
		creature:SendUnitYell( Strings.phase4, 0 ) 
        creature:CastSpell( creature:GetVictim(), SkonkOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), SkonkOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), SkonkOffenseSpells[number], false)
		creature:CastSpell( creature:GetVictim(), SkonkOffenseSpells[number], false)
    else
		creature:SendUnitYell( Strings.phase5, 0 ) 
        creature:CastSpell( creature:GetVictim(), SkonkOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), SkonkOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), SkonkOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), SkonkOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), SkonkOffenseSpells[number], false)
		creature:CastSpell( creature, SkonkDefenseSpells[numberdefense], false)
    end
    creature:RegisterEvent(SkonkPhaseLoop, 5000, 1)
end

function SkonkPhase0(event, creature) -- PHASE 0: on enter combat
	creature:SendUnitYell( Strings.phase5, 0 ) 
	creature:RegisterEvent(SkonkPhaseLoop, 1000, 1)
end



local function OnEnterCombatSkonk(event, creature, target)
    SkonkPhase0(event, creature) -- here we call phase 0 on enter combat
end
RegisterCreatureEvent(CreatureEntryID, 1, OnEnterCombatSkonk)

local function OnLeaveCombatSkonk(event, creature)
    creature:RemoveEvents()
end
RegisterCreatureEvent(CreatureEntryID, 2, OnLeaveCombatSkonk)

local function OnDiedSkonk(event, creature, killer)
    if(killer:GetObjectType() == "Player") then
        killer:SendBroadcastMessage("Congratulations! You managed to kill |cff00ff00" ..creature:GetName().."|r!")
    end
    creature:RemoveEvents()
end
RegisterCreatureEvent(CreatureEntryID, 4, OnDiedSkonk)
