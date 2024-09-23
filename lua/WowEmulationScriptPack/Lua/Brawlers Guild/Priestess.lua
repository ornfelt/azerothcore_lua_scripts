
local CreatureEntryID = 2325300
local PriestessOffenseSpells = {16568,14887,13704,24022,34944,14032,46561,13860}
local PriestessDefenseSpells = {11642, 1245, 11640}
local Strings = {
    phase0 = "Enjoy the pain, won't you?",
    phase1 = "Stay a while, and listen.",
    phase2 = "Justice comes to those who fight with honor.",
    phase3 = "Are there none left to face me?",
    phase4 = "Try as you may, you will fall just as all else have.",
    phase5 = "Perish honorably.",
}

local function PriestessPhaseLoop(eventId, delay, calls, creature) --looping phase
        local number = math.random(8)
		local numberdefense = math.random(3)
    if(creature:GetHealthPct() > 80 and creature:GetHealthPct() < 95) then
        creature:SendUnitYell( Strings.phase1, 0 ) 
        creature:CastSpell( creature:GetVictim(), PriestessOffenseSpells[number], false)
		creature:CastSpell( creature, PriestessDefenseSpells[numberdefense], false)
    elseif (creature:GetHealthPct() > 60) then
		creature:SendUnitYell( Strings.phase2, 0 ) 
        creature:CastSpell( creature:GetVictim(), PriestessOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), PriestessOffenseSpells[number], false)
		creature:CastSpell( creature, PriestessDefenseSpells[numberdefense], false)
    elseif (creature:GetHealthPct() > 40) then
		creature:SendUnitYell( Strings.phase3, 0 ) 
        creature:CastSpell( creature:GetVictim(), PriestessOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), PriestessOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), PriestessOffenseSpells[number], false)
		creature:CastSpell( creature, PriestessDefenseSpells[numberdefense], false)
    elseif (creature:GetHealthPct() > 20) then
		creature:SendUnitYell( Strings.phase4, 0 ) 
        creature:CastSpell( creature:GetVictim(), PriestessOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), PriestessOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), PriestessOffenseSpells[number], false)
		creature:CastSpell( creature:GetVictim(), PriestessOffenseSpells[number], false)
		creature:CastSpell( creature, PriestessDefenseSpells[numberdefense], false)
    else
		creature:SendUnitYell( Strings.phase5, 0 ) 
        creature:CastSpell( creature:GetVictim(), PriestessOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), PriestessOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), PriestessOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), PriestessOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), PriestessOffenseSpells[number], false)
		creature:CastSpell( creature, PriestessDefenseSpells[numberdefense], false)
    end
    creature:RegisterEvent(PriestessPhaseLoop, 5000, 1)
end

function PriestessPhase0(event, creature) -- PHASE 0: on enter combat
	creature:SendUnitYell( Strings.phase5, 0 ) 
	creature:RegisterEvent(PriestessPhaseLoop, 1000, 1)
end



local function OnEnterCombatPriestess(event, creature, target)
    PriestessPhase0(event, creature) -- here we call phase 0 on enter combat
end
RegisterCreatureEvent(CreatureEntryID, 1, OnEnterCombatPriestess)

local function OnLeaveCombatPriestess(event, creature)
    creature:RemoveEvents()
end
RegisterCreatureEvent(CreatureEntryID, 2, OnLeaveCombatPriestess)

local function OnDiedPriestess(event, creature, killer)
    if(killer:GetObjectType() == "Player") then
        killer:SendBroadcastMessage("Congratulations! You managed to kill |cff00ff00" ..creature:GetName().."|r!")
    end
    creature:RemoveEvents()
end
RegisterCreatureEvent(CreatureEntryID, 4, OnDiedPriestess)
