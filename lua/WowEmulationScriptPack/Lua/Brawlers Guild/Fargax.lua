
local CreatureEntryID = 2325700
local VengeworthyOffenseSpells = {14517,13953,32774,58127,36093,17327,36345,37998,74509,35491}
local VengeworthyDefenseSpells = {51758, 51763, 51764, 51766, 60158, 20223,64112}
local Strings = {
    phase0 = "Just another 'hero'... eh?",
    phase1 = "Very well.. be gone.",
    phase2 = "Pest.",
    phase3 = "Are you expecting epic loot from this?",
    phase4 = "What a funny adventure you pride yourself on.",
    phase5 = "Foolish, as all else are.",
}

local function VengeworthyPhaseLoop(eventId, delay, calls, creature) --looping phase
        local number = math.random(8)
		local numberdefense = math.random(6)
    if(creature:GetHealthPct() > 80 and creature:GetHealthPct() < 95) then
        creature:SendUnitYell( Strings.phase1, 0 ) 
        creature:CastSpell( creature:GetVictim(), VengeworthyOffenseSpells[number], false)
		creature:CastSpell( creature, VengeworthyDefenseSpells[numberdefense], false)
    elseif (creature:GetHealthPct() > 60) then
		creature:SendUnitYell( Strings.phase2, 0 ) 
        creature:CastSpell( creature:GetVictim(), VengeworthyOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), VengeworthyOffenseSpells[number], false)
		creature:CastSpell( creature, VengeworthyDefenseSpells[numberdefense], false)
    elseif (creature:GetHealthPct() > 40) then
		creature:SendUnitYell( Strings.phase3, 0 ) 
        creature:CastSpell( creature:GetVictim(), VengeworthyOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), VengeworthyOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), VengeworthyOffenseSpells[number], false)
		creature:CastSpell( creature, VengeworthyDefenseSpells[numberdefense], false)
    elseif (creature:GetHealthPct() > 20) then
		creature:SendUnitYell( Strings.phase4, 0 ) 
        creature:CastSpell( creature:GetVictim(), VengeworthyOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), VengeworthyOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), VengeworthyOffenseSpells[number], false)
		creature:CastSpell( creature:GetVictim(), VengeworthyOffenseSpells[number], false)
		creature:CastSpell( creature, VengeworthyDefenseSpells[numberdefense], false)
    else
		creature:SendUnitYell( Strings.phase5, 0 ) 
        creature:CastSpell( creature:GetVictim(), VengeworthyOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), VengeworthyOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), VengeworthyOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), VengeworthyOffenseSpells[number], false)
        creature:CastSpell( creature:GetVictim(), VengeworthyOffenseSpells[number], false)
		creature:CastSpell( creature, VengeworthyDefenseSpells[numberdefense], false)
    end
    creature:RegisterEvent(VengeworthyPhaseLoop, 5000, 1)
end

function VengeworthyPhase0(event, creature) -- PHASE 0: on enter combat
	creature:SendUnitYell( Strings.phase5, 0 ) 
	creature:RegisterEvent(VengeworthyPhaseLoop, 1000, 1)
end



local function OnEnterCombatVengeworthy(event, creature, target)
    VengeworthyPhase0(event, creature) -- here we call phase 0 on enter combat
end
RegisterCreatureEvent(CreatureEntryID, 1, OnEnterCombatVengeworthy)

local function OnLeaveCombatVengeworthy(event, creature)
    creature:RemoveEvents()
end
RegisterCreatureEvent(CreatureEntryID, 2, OnLeaveCombatVengeworthy)

local function OnDiedVengeworthy(event, creature, killer)
    if(killer:GetObjectType() == "Player") then
        killer:SendBroadcastMessage("Congratulations! You managed to kill |cff00ff00" ..creature:GetName().."|r!")
    end
    creature:RemoveEvents()
end
RegisterCreatureEvent(CreatureEntryID, 4, OnDiedVengeworthy)
