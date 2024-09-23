
local CreatureEntryID = 2324700
local AxisSpells = {70823,600031,71553,42917,44644,31589,55360,42950}
local Strings = {
    phase0 = "The world heaves with my torment!",
    phase1 = "You have entered MY domain now!",
    phase2 = "Feast upon the your own demise!",
    phase3 = "Disorienting... isn't it?",
    phase4 = "Worthless little rat!",
    phase5 = "Oh my... how the turns.. have... tabeled..",
}

local function AxisPhaseLoop(eventId, delay, calls, creature) --looping phase
        local number = math.random(8)
    if(creature:GetHealthPct() > 80 and creature:GetHealthPct() < 95) then
        creature:SendUnitYell( Strings.phase1, 0 ) 
        creature:CastSpell( creature:GetVictim(), AxisSpells[number], false)
    elseif (creature:GetHealthPct() > 60) then
		creature:SendUnitYell( Strings.phase2, 0 ) 
        creature:CastSpell( creature:GetVictim(), AxisSpells[number], false)
        creature:CastSpell( creature:GetVictim(), AxisSpells[number], false)
    elseif (creature:GetHealthPct() > 40) then
		creature:SendUnitYell( Strings.phase3, 0 ) 
        creature:CastSpell( creature:GetVictim(), AxisSpells[number], false)
        creature:CastSpell( creature:GetVictim(), AxisSpells[number], false)
        creature:CastSpell( creature:GetVictim(), AxisSpells[number], false)
    elseif (creature:GetHealthPct() > 20) then
		creature:SendUnitYell( Strings.phase4, 0 ) 
        creature:CastSpell( creature:GetVictim(), AxisSpells[number], false)
        creature:CastSpell( creature:GetVictim(), AxisSpells[number], false)
        creature:CastSpell( creature:GetVictim(), AxisSpells[number], false)
		creature:CastSpell( creature:GetVictim(), AxisSpells[number], false)
    else
		creature:SendUnitYell( Strings.phase5, 0 ) 
        creature:CastSpell( creature:GetVictim(), AxisSpells[number], false)
        creature:CastSpell( creature:GetVictim(), AxisSpells[number], false)
        creature:CastSpell( creature:GetVictim(), AxisSpells[number], false)
        creature:CastSpell( creature:GetVictim(), AxisSpells[number], false)
        creature:CastSpell( creature:GetVictim(), AxisSpells[number], false)
    end
    creature:RegisterEvent(AxisPhaseLoop, 5000, 1)
end

function AxisPhase0(event, creature) -- PHASE 0: on enter combat
	creature:SendUnitYell( Strings.phase5, 0 ) 
	creature:RegisterEvent(AxisPhaseLoop, 1000, 1)
end



local function OnEnterCombatAxis(event, creature, target)
    AxisPhase0(event, creature) -- here we call phase 0 on enter combat
end
RegisterCreatureEvent(CreatureEntryID, 1, OnEnterCombatAxis)

local function OnLeaveCombatAxis(event, creature)
    creature:RemoveEvents()
end
RegisterCreatureEvent(CreatureEntryID, 2, OnLeaveCombatAxis)

local function OnDiedAxis(event, creature, killer)
    if(killer:GetObjectType() == "Player") then
        killer:SendBroadcastMessage("Congratulations! You managed to kill |cff00ff00" ..creature:GetName().."|r!")
    end
    creature:RemoveEvents()
end
RegisterCreatureEvent(CreatureEntryID, 4, OnDiedAxis)
