
local CreatureEntryID = 2325400
local WendigoOffenseSpells = {30832,12540,37685,7992,15583,15667,8876,6942}
local WendigoDefenseSpells = {6434, 8599}
local Strings = {
    phase0 = "Just another 'hero'... eh?",
    phase1 = "Very well.. be gone.",
    phase2 = "Pest.",
    phase3 = "Are you expecting epic loot from this?",
    phase4 = "What a funny adventure you pride yourself on.",
    phase5 = "Foolish, as all else are.",
}

local function WendigoPhaseLoop(eventId, delay, calls, creature) --looping phase
        local number = math.random(8)
		local numberdefense = math.random(2)
    if(creature:GetHealthPct() > 80 and creature:GetHealthPct() < 95) then
        creature:SendUnitYell( Strings.phase1, 0 ) 
        creature:CastSpell( creature:GetVictim(), WendigoOffenseSpells[number], false)
		creature:CastSpell( creature, WendigoDefenseSpells[numberdefense], false)
    elseif (creature:GetHealthPct() > 60) then
		creature:SendUnitYell( Strings.phase2, 0 ) 
        creature:CastSpell( creature:GetVictim(), WendigoOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), WendigoOffenseSpells[number], false)
		creature:CastSpell( creature, WendigoDefenseSpells[numberdefense], false)
    elseif (creature:GetHealthPct() > 40) then
		creature:SendUnitYell( Strings.phase3, 0 ) 
        creature:CastSpell( creature:GetVictim(), WendigoOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), WendigoOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), WendigoOffenseSpells[number], false)
		creature:CastSpell( creature, WendigoDefenseSpells[numberdefense], false)
    elseif (creature:GetHealthPct() > 20) then
		creature:SendUnitYell( Strings.phase4, 0 ) 
        creature:CastSpell( creature:GetVictim(), WendigoOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), WendigoOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), WendigoOffenseSpells[number], false)
		creature:CastSpell( creature:GetVictim(), WendigoOffenseSpells[number], false)
		creature:CastSpell( creature, WendigoDefenseSpells[numberdefense], false)
    else
		creature:SendUnitYell( Strings.phase5, 0 ) 
        creature:CastSpell( creature:GetVictim(), WendigoOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), WendigoOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), WendigoOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), WendigoOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), WendigoOffenseSpells[number], false)
		creature:CastSpell( creature, WendigoDefenseSpells[numberdefense], false)
    end
    creature:RegisterEvent(WendigoPhaseLoop, 5000, 1)
end

function WendigoPhase0(event, creature) -- PHASE 0: on enter combat
	creature:SendUnitYell( Strings.phase5, 0 ) 
	creature:RegisterEvent(WendigoPhaseLoop, 1000, 1)
end



local function OnEnterCombatWendigo(event, creature, target)
    WendigoPhase0(event, creature) -- here we call phase 0 on enter combat
end
RegisterCreatureEvent(CreatureEntryID, 1, OnEnterCombatWendigo)

local function OnLeaveCombatWendigo(event, creature)
    creature:RemoveEvents()
end
RegisterCreatureEvent(CreatureEntryID, 2, OnLeaveCombatWendigo)

local function OnDiedWendigo(event, creature, killer)
    if(killer:GetObjectType() == "Player") then
        killer:SendBroadcastMessage("Congratulations! You managed to kill |cff00ff00" ..creature:GetName().."|r!")
    end
    creature:RemoveEvents()
end
RegisterCreatureEvent(CreatureEntryID, 4, OnDiedWendigo)
