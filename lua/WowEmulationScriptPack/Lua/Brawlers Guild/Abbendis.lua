
local CreatureEntryID = 2325200
local AbbendisOffenseSpells = {58127,6713,3148,11977,12555,39070,51875,23262}
local AbbendisDefenseSpells = {5242, 38664}
local Strings = {
    phase0 = "There is no truth to this...",
    phase1 = "No light...",
    phase2 = "No death",
    phase3 = "There is only POWER!",
    phase4 = "Too... much... power...",
    phase5 = "Truly a shame...",
}

local function AbbendisPhaseLoop(eventId, delay, calls, creature) --looping phase
        local number = math.random(8)
		local numberdefense = math.random(2)
    if(creature:GetHealthPct() > 80 and creature:GetHealthPct() < 95) then
        creature:SendUnitYell( Strings.phase1, 0 ) 
        creature:CastSpell( creature:GetVictim(), AbbendisOffenseSpells[number], false)
		creature:CastSpell( creature, AbbendisDefenseSpells[numberdefense], false)
    elseif (creature:GetHealthPct() > 60) then
		creature:SendUnitYell( Strings.phase2, 0 ) 
        creature:CastSpell( creature:GetVictim(), AbbendisOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), AbbendisOffenseSpells[number], false)
		creature:CastSpell( creature, AbbendisDefenseSpells[numberdefense], false)
    elseif (creature:GetHealthPct() > 40) then
		creature:SendUnitYell( Strings.phase3, 0 ) 
        creature:CastSpell( creature:GetVictim(), AbbendisOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), AbbendisOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), AbbendisOffenseSpells[number], false)
		creature:CastSpell( creature, AbbendisDefenseSpells[numberdefense], false)
    elseif (creature:GetHealthPct() > 20) then
		creature:SendUnitYell( Strings.phase4, 0 ) 
        creature:CastSpell( creature:GetVictim(), AbbendisOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), AbbendisOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), AbbendisOffenseSpells[number], false)
		creature:CastSpell( creature:GetVictim(), AbbendisOffenseSpells[number], false)
		creature:CastSpell( creature, AbbendisDefenseSpells[numberdefense], false)
    else
		creature:SendUnitYell( Strings.phase5, 0 ) 
        creature:CastSpell( creature:GetVictim(), AbbendisOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), AbbendisOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), AbbendisOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), AbbendisOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), AbbendisOffenseSpells[number], false)
		creature:CastSpell( creature, AbbendisDefenseSpells[numberdefense], false)
    end
    creature:RegisterEvent(AbbendisPhaseLoop, 5000, 1)
end

function AbbendisPhase0(event, creature) -- PHASE 0: on enter combat
	creature:SendUnitYell( Strings.phase5, 0 ) 
	creature:RegisterEvent(AbbendisPhaseLoop, 1000, 1)
end



local function OnEnterCombatAbbendis(event, creature, target)
    AbbendisPhase0(event, creature) -- here we call phase 0 on enter combat
end
RegisterCreatureEvent(CreatureEntryID, 1, OnEnterCombatAbbendis)

local function OnLeaveCombatAbbendis(event, creature)
    creature:RemoveEvents()
end
RegisterCreatureEvent(CreatureEntryID, 2, OnLeaveCombatAbbendis)

local function OnDiedAbbendis(event, creature, killer)
    if(killer:GetObjectType() == "Player") then
        killer:SendBroadcastMessage("Congratulations! You managed to kill |cff00ff00" ..creature:GetName().."|r!")
    end
    creature:RemoveEvents()
end
RegisterCreatureEvent(CreatureEntryID, 4, OnDiedAbbendis)
