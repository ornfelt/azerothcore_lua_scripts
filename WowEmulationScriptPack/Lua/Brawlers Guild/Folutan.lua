
local CreatureEntryID = 2325000
local FolutanOffenseSpells = {707472,707471,73058,73046,73037,73029,72998,23967}
local FolutanDefenseSpells = {24185, 24169, 24109}
local Strings = {
    phase0 = "Unyielding efforts on your end... 'hero'.",
    phase1 = "Bold. I like that.",
    phase2 = "Pity you wish to fight rather than do something useful with your life.",
    phase3 = "A wardonic ending for a wardonic hero... heh.",
    phase4 = "Ghost would be so unamused with you.",
    phase5 = "Funny. I appreciate the efforts.",
}

local function FolutanPhaseLoop(eventId, delay, calls, creature) --looping phase
        local number = math.random(8)
		local numberdefense = math.random(3)
    if(creature:GetHealthPct() > 80 and creature:GetHealthPct() < 95) then
        creature:SendUnitYell( Strings.phase1, 0 ) 
        creature:CastSpell( creature:GetVictim(), FolutanOffenseSpells[number], false)
		creature:CastSpell( creature, FolutanDefenseSpells[numberdefense], false)
    elseif (creature:GetHealthPct() > 60) then
		creature:SendUnitYell( Strings.phase2, 0 ) 
        creature:CastSpell( creature:GetVictim(), FolutanOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), FolutanOffenseSpells[number], false)
		creature:CastSpell( creature, FolutanDefenseSpells[numberdefense], false)
    elseif (creature:GetHealthPct() > 40) then
		creature:SendUnitYell( Strings.phase3, 0 ) 
        creature:CastSpell( creature:GetVictim(), FolutanOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), FolutanOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), FolutanOffenseSpells[number], false)
		creature:CastSpell( creature, FolutanDefenseSpells[numberdefense], false)
    elseif (creature:GetHealthPct() > 20) then
		creature:SendUnitYell( Strings.phase4, 0 ) 
        creature:CastSpell( creature:GetVictim(), FolutanOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), FolutanOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), FolutanOffenseSpells[number], false)
		creature:CastSpell( creature:GetVictim(), FolutanOffenseSpells[number], false)
		creature:CastSpell( creature, FolutanDefenseSpells[numberdefense], false)
    else
		creature:SendUnitYell( Strings.phase5, 0 ) 
        creature:CastSpell( creature:GetVictim(), FolutanOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), FolutanOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), FolutanOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), FolutanOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), FolutanOffenseSpells[number], false)
		creature:CastSpell( creature, FolutanDefenseSpells[numberdefense], false)
    end
    creature:RegisterEvent(FolutanPhaseLoop, 5000, 1)
end

function FolutanPhase0(event, creature) -- PHASE 0: on enter combat
	creature:SendUnitYell( Strings.phase5, 0 ) 
	creature:RegisterEvent(FolutanPhaseLoop, 1000, 1)
end



local function OnEnterCombatFolutan(event, creature, target)
    FolutanPhase0(event, creature) -- here we call phase 0 on enter combat
end
RegisterCreatureEvent(CreatureEntryID, 1, OnEnterCombatFolutan)

local function OnLeaveCombatFolutan(event, creature)
    creature:RemoveEvents()
end
RegisterCreatureEvent(CreatureEntryID, 2, OnLeaveCombatFolutan)

local function OnDiedFolutan(event, creature, killer)
    if(killer:GetObjectType() == "Player") then
        killer:SendBroadcastMessage("Congratulations! You managed to kill |cff00ff00" ..creature:GetName().."|r!")
    end
    creature:RemoveEvents()
end
RegisterCreatureEvent(CreatureEntryID, 4, OnDiedFolutan)
