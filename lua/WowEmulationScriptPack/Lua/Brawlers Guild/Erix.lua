
local CreatureEntryID = 2325100
local ErixOffenseSpells = {36887,36876,36862,36841,36837,36814,36787,32905}
local ErixDefenseSpells = {24185, 43928, 36782}
local Strings = {
    phase0 = "Try as you may, you are still useless.",
    phase1 = "Is this all the fury you can muster?",
    phase2 = "A waste of space.",
    phase3 = "Oh look. You must have lagged.",
    phase4 = "They have yet to nerf your class, hero.",
    phase5 = "Oops... did I do that?",
}

local function ErixPhaseLoop(eventId, delay, calls, creature) --looping phase
        local number = math.random(8)
		local numberdefense = math.random(3)
    if(creature:GetHealthPct() > 80 and creature:GetHealthPct() < 95) then
        creature:SendUnitYell( Strings.phase1, 0 ) 
        creature:CastSpell( creature:GetVictim(), ErixOffenseSpells[number], false)
		creature:CastSpell( creature, ErixDefenseSpells[numberdefense], false)
    elseif (creature:GetHealthPct() > 60) then
		creature:SendUnitYell( Strings.phase2, 0 ) 
        creature:CastSpell( creature:GetVictim(), ErixOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), ErixOffenseSpells[number], false)
		creature:CastSpell( creature, ErixDefenseSpells[numberdefense], false)
    elseif (creature:GetHealthPct() > 40) then
		creature:SendUnitYell( Strings.phase3, 0 ) 
        creature:CastSpell( creature:GetVictim(), ErixOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), ErixOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), ErixOffenseSpells[number], false)
		creature:CastSpell( creature, ErixDefenseSpells[numberdefense], false)
    elseif (creature:GetHealthPct() > 20) then
		creature:SendUnitYell( Strings.phase4, 0 ) 
        creature:CastSpell( creature:GetVictim(), ErixOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), ErixOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), ErixOffenseSpells[number], false)
		creature:CastSpell( creature:GetVictim(), ErixOffenseSpells[number], false)
		creature:CastSpell( creature, ErixDefenseSpells[numberdefense], false)
    else
		creature:SendUnitYell( Strings.phase5, 0 ) 
        creature:CastSpell( creature:GetVictim(), ErixOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), ErixOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), ErixOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), ErixOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), ErixOffenseSpells[number], false)
		creature:CastSpell( creature, ErixDefenseSpells[numberdefense], false)
    end
    creature:RegisterEvent(ErixPhaseLoop, 5000, 1)
end

function ErixPhase0(event, creature) -- PHASE 0: on enter combat
	creature:SendUnitYell( Strings.phase5, 0 ) 
	creature:RegisterEvent(ErixPhaseLoop, 1000, 1)
end



local function OnEnterCombatErix(event, creature, target)
    ErixPhase0(event, creature) -- here we call phase 0 on enter combat
end
RegisterCreatureEvent(CreatureEntryID, 1, OnEnterCombatErix)

local function OnLeaveCombatErix(event, creature)
    creature:RemoveEvents()
end
RegisterCreatureEvent(CreatureEntryID, 2, OnLeaveCombatErix)

local function OnDiedErix(event, creature, killer)
    if(killer:GetObjectType() == "Player") then
        killer:SendBroadcastMessage("Congratulations! You managed to kill |cff00ff00" ..creature:GetName().."|r!")
    end
    creature:RemoveEvents()
end
RegisterCreatureEvent(CreatureEntryID, 4, OnDiedErix)
