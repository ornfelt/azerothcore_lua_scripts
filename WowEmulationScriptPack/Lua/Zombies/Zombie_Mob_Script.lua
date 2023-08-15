local UpgradeCurrency = 6460050 --item/currency ID
local enrageSpellId = 27680
local DiseasedSpitSpellId = 8050
local BiteSpellId = 8042
local UpgradeCurrencyAmountOnKill = 1
local ZombieTypes = { -- use same 1 multiple times for better odds
27059
}

-- Abilities
local function ZombieBite(event, delay, repeats, creature)
	local Victim = creature:GetVictim()
	creature:CastSpell(Victim, BiteSpellId, true)
end

local function ZombieSpit(event, delay, repeats, creature)
local Victim = creature:GetVictim()
	creature:CastSpell(Victim, DiseasedSpitSpellId, true)
end


local function ZombieEnterCombat(event, creature, target)
	creature:RegisterEvent(ZombieSpit, {6000,12000}, 0)
	creature:RegisterEvent(ZombieBite, {4000,6000}, 2)
end

local function ZombieLeaveCombat(event, creature)
	creature:RemoveEvents()
end

local function ZombieOnDied(event, creature, killer)
	creature:DespawnOrUnsummon(1000)
	if (killTracker[killer:GetName()] == nil) then
		killTracker[killer:GetName()] = 0
	end
	killTracker[killer:GetName()] = killTracker[killer:GetName()] + 1
	killer:AddItem(UpgradeCurrency,UpgradeCurrencyAmountOnKill)
	creature:RemoveEvents()
end

RegisterCreatureEvent( 27059, 1, ZombieEnterCombat )
RegisterCreatureEvent( 27059, 2, ZombieLeaveCombat )
RegisterCreatureEvent( 27059, 4, ZombieOnDied )

