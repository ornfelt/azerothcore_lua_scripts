-- Constants
--Boss ID
local ENTRY_CORRUPTED_NOSTOS = 90024--boss

--adds
local ENTRY_CORRUPTED_WARRIOR = 90025--add
local ENTRY_CORRUPTED_PALADIN = 90026--add
local ENTRY_CORRUPTED_HUNTER = 90027--add
local ENTRY_CORRUPTED_ROGUE = 90028--add
local ENTRY_CORRUPTED_PRIEST = 90029--add
local ENTRY_CORRUPTED_SHAMAN = 90030--add
local ENTRY_CORRUPTED_MAGE	= 90031--add
local ENTRY_CORRUPTED_WARLOCK = 90032--add
local ENTRY_CORRUPTED_DRUID = 90033--add

--all spells cast(sorted by class)
local SPELL_SHADOW_VOLLEY =	9081 -- Shadow Bolt Volley
local SPELL_CORRUPTION = 7648 -- dmg over 18s
local SPELL_SUMMONED_ENRAGE	 = 24318 -- 50% attack, 60% speed

--GIFTS
local SPELL_QUICKENING = 23723 -- Gift of Nostos Caster positive effect spell
local SPELL_FRENZY	= 28371 -- Gift of Nostos Melee positive spell effect

--start of adds spells
local SPELL_SHADOW_VISUAL = 15473 -- Visual, cast on class-based adds.
local SPELL_WARR_MORTAL = 27580 -- Warrior mortal strike 50% reduced heal
local SPELL_WARR_THUNDER = 8732 -- Warrior thunderclap
local SPELL_PALA_RETRI = 10301 -- Paladin retribution aura 
local SPELL_PALA_CONSECRATION = 20924 --  damage per sec AoE
local SPELL_HUNT_NET = 6533 -- 10 sec immobilised
local SPELL_HUNT_VOLLEY = 14295
local SPELL_ROGUE_CRIPPLING	 = 11201 -- 70% slow
local SPELL_ROGUE_DEADLY = 11469 --damage per stack, 5 stacks, 12 sec
local SPELL_PRIEST_PAIN	= 2767 -- damage per sec
local SPELL_PRIEST_SHIELD = 10899 -- damage absorption
local SPELL_SHAMAN_FLAME = 10447 -- Flame shock (over 12sec)
local SPELL_SHAMAN_CHAIN = 15305--AoE damage
local SPELL_MAGE_ARCANE_BLAST =	8439 -- Arcane exposion AoE
local SPELL_MAGE_FROST_NOVA = 6131 --AoE root
local SPELL_WARLOCK_IMPOTENCE = 22371 -- -magic damage dealt
local SPELL_WARLOCK_BOLT = 1088 -- shadow bolt
local SPELL_DRUID_MOONFIRE = 8927 -- damage over time
local SPELL_DRUID_BEAR_FORM	 =	9634 -- forms
local SPELL_DRUID_BASH = 8983 -- 3 sec
local SPELL_DRUID_REJUVENATE = 3627 -- heal

--if a class sucks remove it
local PossibleSpawns = {
ENTRY_CORRUPTED_WARRIOR,
 ENTRY_CORRUPTED_PALADIN,
 ENTRY_CORRUPTED_HUNTER,
 ENTRY_CORRUPTED_ROGUE,
 ENTRY_CORRUPTED_PRIEST,
 ENTRY_CORRUPTED_SHAMAN,
 ENTRY_CORRUPTED_MAGE,
 ENTRY_CORRUPTED_WARLOCK,
 ENTRY_CORRUPTED_DRUID
 }
 
local Nostos = {
	Strings = {
	-- Boss emotes
	"Nostos sends a minion to %s.",
	"Nostos bestows a gift unto %s.",
	-- Announce class summon
	"This is your worst nightmare, %s.",
	"I see your inner fear, %s.",
	"This is your worst nightmare, %s? Pitiful.",
	"These visions don't lie, %s. Your will falters. You will join us.",
	"Stare into the abyss, %s.",
	"Your will falters, %s.",
	"You hesitate at the sight of a mere figment of your imagination, %s?",
	"Your inner hell before your eyes, %s.",
	-- Announce gift of Nostos
	"Look at the power I could grant you, %s. Can you resist the temptation?",
	"Join me, %s. Together, we shall rule the minds of the feeble.",
	"Watch as I grant you immense power, %s. Imagine how much more I could give you.",
	"This is only the beginning, %s. Power like this could be yours, if only you joined me.",
	"Feel the power, %s. All this, and more, could be yours.",
	"Dominion over the weak. Join me, %s. I shall grant you unimaginable power.",
	-- 30% Health
	"This cannot be! Help me, minions!",
	},
	Classes = {
	-- Class value is index. 
	[1]	= ENTRY_CORRUPTED_WARRIOR,
	[2]	= ENTRY_CORRUPTED_PALADIN,
	[3]	= ENTRY_CORRUPTED_HUNTER,
	[4]	= ENTRY_CORRUPTED_ROGUE,
	[5]	= ENTRY_CORRUPTED_PRIEST,
	-- [6]	= "CLASS_DEATH_KNIGHT", -- eh
	[7]	= ENTRY_CORRUPTED_SHAMAN,
	[8]	= ENTRY_CORRUPTED_MAGE,
	[9]	= ENTRY_CORRUPTED_WARLOCK,
	[11] = ENTRY_CORRUPTED_DRUID,
	},
}

local function ResetEncounter(creature)
	for _, v in pairs(Nostos.Classes) do
		local summonedCreatures = creature:GetCreaturesInRange(533, v, 0, 0)
		for _, val in pairs(summonedCreatures) do
			val:DespawnOrUnsummon()
		end
	end
end

function Nostos.CheckHealth(event, delay, repeats, creature)
	local HealthPct = creature:GetHealthPct()
	if HealthPct <= 30 then
		local x1, y1, z1 = creature:GetRelativePoint(math.random(3, 6), (math.random(math.pi / 12, math.pi * 2)))
		local o = creature:GetO()
		local Victim = creature:GetVictim()
		local summonedCreature1 = creature:SpawnCreature(PossibleSpawns[math.random(#PossibleSpawns)], x1, y1, z1, o, 2)
		summonedCreature1:CastSpell(summonedCreature1, SPELL_SHADOW_VISUAL, true)
		summonedCreature1:AttackStart(Victim)
		summonedCreature1:CastSpell(summonedCreature1, SPELL_SUMMONED_ENRAGE, true)
		creature:SendUnitSay(Nostos.Strings[17], 0)
	end
	if HealthPct <= 10 then
		local x2, y2, z2 = creature:GetRelativePoint(math.random(3, 6), (math.random(math.pi / 12, math.pi * 2)))
		local summonedCreature2 = creature:SpawnCreature(PossibleSpawns[math.random(#PossibleSpawns)],x2, y2, z2, o, 2)
		summonedCreature2:CastSpell(summonedCreature1, SPELL_SHADOW_VISUAL, true)
		summonedCreature2:AttackStart(Victim)
		summonedCreature2:CastSpell(summonedCreature1, SPELL_SUMMONED_ENRAGE, true)
	end
	if HealthPct <= 5 then
		local x3, y3, z3 = creature:GetRelativePoint(math.random(3, 6), (math.random(math.pi / 12, math.pi * 2)))
		local summonedCreature3 = creature:SpawnCreature(PossibleSpawns[math.random(#PossibleSpawns)],x3, y3, z3, o, 2)
		summonedCreature3:CastSpell(summonedCreature1, SPELL_SHADOW_VISUAL, true)
		summonedCreature3:AttackStart(Victim)
		summonedCreature3:CastSpell(summonedCreature1, SPELL_SUMMONED_ENRAGE, true)
	end
end

function Nostos.ShadowBoltVolley(event, delay, repeats, creature)
	creature:CastSpell(creature, SPELL_SHADOW_VOLLEY, true)
end

function Nostos.Corruption(event, delay, repeats, creature)
	local Target = creature:GetAITarget(0, true, 0, 50)
	creature:CastSpell(Target, SPELL_CORRUPTION, true)
end

function Nostos.Gift(event, delay, repeats, creature)
	local Target = creature:GetAITarget(0, true, 0, 50) -- Random, playeronly, random, 50yd
	local TargetName = Target:GetName()
	local TargetClass = Target:GetClass()
	local RandomMessage = math.random(11, 16)
	if TargetClass == 1 or TargetClass == 2 or TargetClass == 3 or TargetClass == 4 or TargetClass == 11 then
		Target:CastSpell(Target, SPELL_FRENZY, true)
		local FrenzyAura = Target:GetAura(SPELL_FRENZY)
		FrenzyAura:SetDuration(6000)
	elseif TargetClass == 5 or  TargetClass == 6 or TargetClass == 7 or TargetClass == 8 or TargetClass == 9 then
		Target:CastSpell(Target, SPELL_QUICKENING, true)
		local QuickeningAura = Target:GetAura(SPELL_QUICKENING)
		QuickeningAura:SetDuration(6000)
	end
	creature:SendUnitSay(string.format(Nostos.Strings[RandomMessage], TargetName), 0)
	creature:SendUnitEmote(string.format(Nostos.Strings[2], TargetName), nil, true)
end

function Nostos.SummonAdd(event, delay, repeats, creature)
	local id = creature:GetInstanceId()
	local RandomText = math.random(3, 10)
	local Target = creature:GetAITarget(0, true, 0, 50)
	local TargetName = Target:GetName()
	local TargetClass = Target:GetClass()
	local TargetO = Target:GetO()
	local TargetClassStr = Target:GetClassAsString()
	local summonX, summonY, summonZ = Target:GetRelativePoint(math.random(2, 5), math.random(math.pi / 12, math.pi * 2))
	local summonedCreature = creature:SpawnCreature(Nostos.Classes[TargetClass], summonX, summonY, summonZ, TargetO, 2)
	summonedCreature:CastSpell(summonedCreature, SPELL_SHADOW_VISUAL, true)
	summonedCreature:AttackStart(Target)
	-- Boss emote
	creature:SendUnitEmote(string.format(Nostos.Strings[1], TargetName), nil, true)
	creature:SendUnitSay(string.format(Nostos.Strings[RandomText], TargetClassStr), 0)
end

function Nostos.EnrageTimer(event, delay, repeats, creature)
	creature:CastSpell(creature, SPELL_SUMMONED_ENRAGE, true)
end
-- Main
function Nostos.OnEnterCombat(event, creature, target)
	local InstanceId = creature:GetInstanceId()
	creature:RegisterEvent(Nostos.Gift, {12000, 15000}, 0)
	creature:RegisterEvent(Nostos.SummonAdd, {20000, 30000}, 0)
	creature:RegisterEvent(Nostos.Corruption, 12000, 0)
	creature:RegisterEvent(Nostos.ShadowBoltVolley, {5000, 7000}, 0)
	creature:RegisterEvent(Nostos.CheckHealth, {10000, 15000}, 0)
	creature:RegisterEvent(Nostos.EnrageTimer,600000)
end

function Nostos.OnLeaveCombat(event, creature)
	local InstanceId = creature:GetInstanceId()
	ResetEncounter(creature)
	creature:RemoveEvents()
end

function Nostos.OnDied(event, creature, killer)
	local InstanceId = creature:GetInstanceId()
	creature:RemoveEvents()
end


RegisterCreatureEvent(ENTRY_CORRUPTED_NOSTOS, 1, Nostos.OnEnterCombat) -- CREATURE_EVENT_ON_ENTER_COMBAT
RegisterCreatureEvent(ENTRY_CORRUPTED_NOSTOS, 2, Nostos.OnLeaveCombat) -- CREATURE_EVENT_ON_LEAVE_COMBAT
RegisterCreatureEvent(ENTRY_CORRUPTED_NOSTOS, 4, Nostos.OnDied)		-- CREATURE_EVENT_ON_DIED

-- Corrupted Warrior
local Corrupted_Warrior = {
	Strings = {
	"I'll tear them apart!",
	"Weak fools!",
	"Do you fear me yet, fools?",
	"I'll shred the meat off your bones.",
	"We shall drink from your skull, heathen.",
	"Don't resist the master's will!",
	}
}

-- Abilities
function Corrupted_Warrior.Mortal(event, delay, repeats, creature)
	local Victim = creature:GetVictim()
	creature:CastSpell(Victim, SPELL_WARR_MORTAL, true)
end

function Corrupted_Warrior.Thunderclap(event, delay, repeats, creature)
	creature:CastSpell(creature, SPELL_WARR_THUNDER, true)
end

-- Main
function Corrupted_Warrior.OnEnterCombat(event, creature, target)
	local RandomMessage	= math.random(#Corrupted_Warrior.Strings)
	creature:SendUnitSay(Corrupted_Warrior.Strings[RandomMessage], 0)
	creature:RegisterEvent(Corrupted_Warrior.Mortal, {6000,12000}, 0)
	creature:RegisterEvent(Corrupted_Warrior.Thunderclap, {4000,6000}, 2)
end

function Corrupted_Warrior.OnLeaveCombat(event, creature)
	creature:RemoveEvents()
end

function Corrupted_Warrior.OnDied(event, creature, killer)
	creature:DespawnOrUnsummon(1000)
	creature:RemoveEvents()
end

RegisterCreatureEvent(ENTRY_CORRUPTED_WARRIOR, 1, Corrupted_Warrior.OnEnterCombat) -- CREATURE_EVENT_ON_ENTER_COMBAT
RegisterCreatureEvent(ENTRY_CORRUPTED_WARRIOR, 2, Corrupted_Warrior.OnLeaveCombat) -- CREATURE_EVENT_ON_LEAVE_COMBAT
RegisterCreatureEvent(ENTRY_CORRUPTED_WARRIOR, 4, Corrupted_Warrior.OnDied)		-- CREATURE_EVENT_ON_DIED

-- Corrupted Paladin
local Corrupted_Paladin = {
	Strings = {
	"The light won't save you now!",
	"I see only darkness before me.",
	"My will won't falter. I've already succumbed to the master.",
	"The light abandoned us.",
	"The light failed us all. The abyss stares back.",
	"Doubt yourself, young Paladin. Free yourself from these bounds.",
	}
}

-- Abilities
function Corrupted_Paladin.Consecration(event, delay, repeats, creature)
	if (repeats % 5) == 2 then
		creature:CastSpell(creature, SPELL_PALA_CONSECRATION, true)
	end
end

-- Main
function Corrupted_Paladin.OnEnterCombat(event, creature, target)
	local RandomMessage = math.random(#Corrupted_Paladin.Strings)
	creature:SendUnitSay(Corrupted_Paladin.Strings[RandomMessage], 0)
	creature:CastSpell(creature, SPELL_PALA_RETRI, true)
	creature:RegisterEvent(Corrupted_Paladin.Consecration, 2000, 7)
end

function Corrupted_Paladin.OnLeaveCombat(event, creature)
	creature:RemoveEvents()
end

function Corrupted_Paladin.OnDied(event, creature, killer)
	creature:DespawnOrUnsummon(1000)
	creature:RemoveEvents()
end

RegisterCreatureEvent(ENTRY_CORRUPTED_PALADIN, 1, Corrupted_Paladin.OnEnterCombat) -- CREATURE_EVENT_ON_ENTER_COMBAT
RegisterCreatureEvent(ENTRY_CORRUPTED_PALADIN, 2, Corrupted_Paladin.OnLeaveCombat) -- CREATURE_EVENT_ON_LEAVE_COMBAT
RegisterCreatureEvent(ENTRY_CORRUPTED_PALADIN, 4, Corrupted_Paladin.OnDied)		-- CREATURE_EVENT_ON_DIED

-- Corrupted Hunter
local Corrupted_Hunter = {
	Strings = {
	"Nobody can save you, Hunter.",
	"We all have a price.",
	"We all wither away eventually.",
	"The power is intoxicating.",
	"Your heads will adorn my walls.",
	"I'll make trophies out of you all.",
	}
}

-- Abilities
function Corrupted_Hunter.Net(event, delay, repeats, creature)
	local Target = creature:GetAITarget(0, true, 0, 20)
	creature:CastSpell(Target, SPELL_HUNT_NET, true)
end

function Corrupted_Hunter.Volley(event, delay, repeats, creature)
	local Target = creature:GetAITarget(0, true, 0, 30)
	local Tx, Ty, Tz = Target:GetLocation()
	creature:CastSpellAoF(Tx, Ty, Tz, SPELL_HUNT_VOLLEY, true)
end

-- Main
function Corrupted_Hunter.OnEnterCombat(event, creature, target)
	local RandomMessage = math.random(#Corrupted_Hunter.Strings)
	creature:SendUnitSay(Corrupted_Hunter.Strings[RandomMessage], 0)
	creature:RegisterEvent(Corrupted_Hunter.Net, {6000,8000}, 3)
	creature:RegisterEvent(Corrupted_Hunter.Volley, {10000,13000}, 0)
	creature:CastSpell(target, SPELL_HUNT_VOLLEY, true)
end

function Corrupted_Hunter.OnLeaveCombat(event, creature)
	creature:RemoveEvents()
end

function Corrupted_Hunter.OnDied(event, creature, killer)
	creature:DespawnOrUnsummon(1000)
	creature:RemoveEvents()
end

RegisterCreatureEvent(ENTRY_CORRUPTED_HUNTER, 1, Corrupted_Hunter.OnEnterCombat) -- CREATURE_EVENT_ON_ENTER_COMBAT
RegisterCreatureEvent(ENTRY_CORRUPTED_HUNTER, 2, Corrupted_Hunter.OnLeaveCombat) -- CREATURE_EVENT_ON_LEAVE_COMBAT
RegisterCreatureEvent(ENTRY_CORRUPTED_HUNTER, 4, Corrupted_Hunter.OnDied)		-- CREATURE_EVENT_ON_DIED


-- Corrupted Rogue
local Corrupted_Rogue = {
	Strings = {
	"Let's play a little game.",
	"One wrong move, and there's a slit in your throat.",
	"What comes around, goes around, Rogue.",
	"Silly little rats.",
	"Stare into the abyss. Let it envelop you.",
	}
}

-- Abilities
function Corrupted_Rogue.Crippling(event, delay, repeats, creature)
	local Victim = creature:GetVictim()
	creature:CastSpell(Victim, SPELL_ROGUE_CRIPPLING, false)
end

function Corrupted_Rogue.Deadly(event, delay, repeats, creature)
	local Victim = creature:GetVictim()
	creature:CastSpell(Victim, SPELL_ROGUE_DEADLY, false)
end

-- Main
function Corrupted_Rogue.OnEnterCombat(event, creature, target)
	local RandomMessage	= math.random(#Corrupted_Rogue.Strings)
	creature:SendUnitSay(Corrupted_Rogue.Strings[RandomMessage], 0)
	creature:RegisterEvent(Corrupted_Rogue.Deadly, 3000, 0)
	creature:RegisterEvent(Corrupted_Rogue.Crippling, {7500,1100}, 2)
end

function Corrupted_Rogue.OnLeaveCombat(event, creature)
	creature:RemoveEvents()
end

function Corrupted_Rogue.OnDied(event, creature, killer)
	creature:DespawnOrUnsummon(1000)
	creature:RemoveEvents()
end

RegisterCreatureEvent(ENTRY_CORRUPTED_ROGUE, 1, Corrupted_Rogue.OnEnterCombat) -- CREATURE_EVENT_ON_ENTER_COMBAT
RegisterCreatureEvent(ENTRY_CORRUPTED_ROGUE, 2, Corrupted_Rogue.OnLeaveCombat) -- CREATURE_EVENT_ON_LEAVE_COMBAT
RegisterCreatureEvent(ENTRY_CORRUPTED_ROGUE, 4, Corrupted_Rogue.OnDied)		-- CREATURE_EVENT_ON_DIED

-- Corrupted Priest
local Corrupted_Priest = {
	Strings = {
	"The light faded a long time ago.",
	"There's nobody to save you here.",
	"The light can't mend your broken will.",
	"What are you waiting for? Join us.",
	"Stare into the abyss, Priest.",
	"Darkness encompasses the light, Priest.",
	}
}

-- Abilities
function Corrupted_Priest.Shield(event, delay, repeats, creature)
	local creaturesInRange = creature:GetCreaturesInRange(25, 0, 0, 1)
	local EligibleTargets = {}
	for _, v in pairs(creaturesInRange) do
		if v:GetEntry() == ENTRY_CORRUPTED_WARRIOR or v:GetEntry() == ENTRY_CORRUPTED_PALADIN or v:GetEntry() == ENTRY_CORRUPTED_WARLOCK or v:GetEntry() == ENTRY_CORRUPTED_HUNTER or v:GetEntry() == ENTRY_CORRUPTED_SHAMAN or v:GetEntry() == ENTRY_CORRUPTED_ROGUE or v:GetEntry() == ENTRY_CORRUPTED_MAGE or v:GetEntry() == ENTRY_CORRUPTED_DRUID then
			table.insert(EligibleTargets, v)
		end
	end
	for _, v in pairs(EligibleTargets) do
		if v:IsAlive() and creature:IsWithinLoS(v) then
			creature:CastSpell(v, SPELL_PRIEST_SHIELD, true)
			return
		end
	end
	creature:CastSpell(creature, SPELL_PRIEST_SHIELD) -- Only happens if no eligble targets are found.
end

function Corrupted_Priest.Pain(event, delay, repeats, creature)
	local Victim = creature:GetVictim()
	creature:CastSpell(Victim, SPELL_PRIEST_PAIN)
end

-- Main
function Corrupted_Priest.OnEnterCombat(event, creature, target)
	local RandomMessage	= math.random(#Corrupted_Priest.Strings)
	creature:SendUnitSay(Corrupted_Priest.Strings[RandomMessage], 0)
	creature:RegisterEvent(Corrupted_Priest.Pain, {8000,10000}, 5)
	creature:RegisterEvent(Corrupted_Priest.Shield, {9500,11000}, 0)
	creature:CastSpell(creature, SPELL_PRIEST_SHIELD)
end

function Corrupted_Priest.OnLeaveCombat(event, creature)
	creature:RemoveEvents()
end

function Corrupted_Priest.OnDied(event, creature, killer)
	creature:DespawnOrUnsummon(1000)
	creature:RemoveEvents()
end

RegisterCreatureEvent(ENTRY_CORRUPTED_PRIEST, 1, Corrupted_Priest.OnEnterCombat) -- CREATURE_EVENT_ON_ENTER_COMBAT
RegisterCreatureEvent(ENTRY_CORRUPTED_PRIEST, 2, Corrupted_Priest.OnLeaveCombat) -- CREATURE_EVENT_ON_LEAVE_COMBAT
RegisterCreatureEvent(ENTRY_CORRUPTED_PRIEST, 4, Corrupted_Priest.OnDied)		-- CREATURE_EVENT_ON_DIED

-- Corrupted Shaman
local Corrupted_Shaman = {
	Strings = {
	"The ancestors have stopped talking, Shaman. Nostos takes over us now.",
	"The Ancestors' Call has long been gone, Shaman. It's a figment of your weak imagination.",
	"Stop playing with those wooden toys, Shaman. We can give you incredible power.",
	"What a fool you've been. The elements are nothing in comparison to Nostos's power.",
	"The elements? Darkness is ubiquitous. Stop worshipping those fake idols.",
	"Pitiful. Join us and unlock your true potential.",
	}
}

-- Abilities
function Corrupted_Shaman.Chain(event, delay, repeats, creature)
	local Victim = creature:GetVictim()
	creature:CastSpell(Victim, SPELL_SHAMAN_CHAIN)
end

function Corrupted_Shaman.Flameshock(event, delay, repeats, creature)
	local Victim = creature:GetAITarget(0, true, 0, 25)
	if Victim then
		creature:CastSpell(Victim, SPELL_SHAMAN_FLAME, true)
	end
end

-- Main
function Corrupted_Shaman.OnEnterCombat(event, creature, target)
	local RandomMessage = math.random(#Corrupted_Shaman.Strings)
	creature:SendUnitSay(Corrupted_Shaman.Strings[RandomMessage], 0)
	creature:RegisterEvent(Corrupted_Shaman.Chain, {3000,5000}, 0)
	creature:RegisterEvent(Corrupted_Shaman.Flameshock, 7000, 0)
end

function Corrupted_Shaman.OnLeaveCombat(event, creature)
	creature:RemoveEvents()
end

function Corrupted_Shaman.OnDied(event, creature, killer)
	creature:DespawnOrUnsummon(1000)
	creature:RemoveEvents()
end

RegisterCreatureEvent(ENTRY_CORRUPTED_SHAMAN, 1, Corrupted_Shaman.OnEnterCombat) -- CREATURE_EVENT_ON_ENTER_COMBAT
RegisterCreatureEvent(ENTRY_CORRUPTED_SHAMAN, 2, Corrupted_Shaman.OnLeaveCombat) -- CREATURE_EVENT_ON_LEAVE_COMBAT
RegisterCreatureEvent(ENTRY_CORRUPTED_SHAMAN, 4, Corrupted_Shaman.OnDied)		-- CREATURE_EVENT_ON_DIED

-- Corrupted Mage
local Corrupted_Mage = {
	Strings = {
	"Dabbling in the arcane arts, Mage? Let me show you what REAL magic looks like.",
	"Still playing with fireballs, Mage? Cute.",
	"And now, for a display of REAL magic.",
	"Stare into the abyss. Join us, and you'll be granted more power than you could possibly wish for.",
	"Submissive heathens. Surrender your minds to Nostos!",
	"How silly. Think your magic can stand up to mine?",
	}
}

function Corrupted_Mage.SwitchTarget(event, delay, repetas, creature)
	local playersInRange = creature:GetPlayersInRange(10, 1, 1)
	if #playersInRange > 1 then
		local RandomNewTarget = math.random(#playersInRange)
		creature:Attack(playersInRange[RandomNewTarget])
	end
end

-- Abilities
function Corrupted_Mage.ArcaneExplosion(event, delay, repeats, creature)
	creature:CastSpell(creature, SPELL_MAGE_ARCANE_BLAST, false)
end

function Corrupted_Mage.FrostNova(event, delay, repeats, creature)
	creature:CastSpell(creature, SPELL_MAGE_FROST_NOVA, false)
end

-- Main
function Corrupted_Mage.OnEnterCombat(event, creature, target)
	local RandomMessage = math.random(#Corrupted_Mage.Strings)
	creature:SendUnitSay(Corrupted_Mage.Strings[RandomMessage], 0)
	creature:RegisterEvent(Corrupted_Mage.ArcaneExplosion, {2000,4000}, 0)
	creature:RegisterEvent(Corrupted_Mage.FrostNova, {5000,7000}, 2)
	creature:RegisterEvent(Corrupted_Mage.SwitchTarget, 5000, 0)
end

function Corrupted_Mage.OnLeaveCombat(event, creature)
	creature:RemoveEvents()
end

function Corrupted_Mage.OnDied(event, creature, killer)
	creature:DespawnOrUnsummon(1000)
	creature:RemoveEvents()
end

RegisterCreatureEvent(ENTRY_CORRUPTED_MAGE, 1, Corrupted_Mage.OnEnterCombat) -- CREATURE_EVENT_ON_ENTER_COMBAT
RegisterCreatureEvent(ENTRY_CORRUPTED_MAGE, 2, Corrupted_Mage.OnLeaveCombat) -- CREATURE_EVENT_ON_LEAVE_COMBAT
RegisterCreatureEvent(ENTRY_CORRUPTED_MAGE, 4, Corrupted_Mage.OnDied)		-- CREATURE_EVENT_ON_DIED

-- Corrupted Warlock
local Corrupted_Warlock = {
	Strings = {
	"Surrender your mind to Nostos.",
	"Stare into the mouth of the abyss. This world will end.",
	"This world will end. There's no escape.",
	"Surrender now, and reap the rewards.",
	"We all have our price, Warlock. Surrender control, and we'll find yours.",
	"Still summoning measly creatures, Warlock? We could give you control over the most powerful demons in Azeroth.",
	}
}

-- Abilities
function Corrupted_Warlock.Curse(event, delay, repeats, creature)
	local Target = creature:GetAITarget(0, true, 0, 25)
	if Target then
		creature:CastSpell(Target, SPELL_WARLOCK_IMPOTENCE, true)
	end
end

function Corrupted_Warlock.ShadowBolt(event, delay, repeats, creature)
	local Victim = creature:GetVictim()
	creature:CastSpell(Victim, SPELL_WARLOCK_BOLT)
end

-- Main
function Corrupted_Warlock.OnEnterCombat(event, creature, target)
	local RandomMessage = math.random(#Corrupted_Warlock.Strings)
	creature:SendUnitSay(Corrupted_Warlock.Strings[RandomMessage], 0)
	creature:RegisterEvent(Corrupted_Warlock.Curse, 2500, 2)
	creature:RegisterEvent(Corrupted_Warlock.ShadowBolt, {3500,5000}, 0)
end

function Corrupted_Warlock.OnLeaveCombat(event, creature)
	creature:RemoveEvents()
end

function Corrupted_Warlock.OnDied(event, creature, killer)
	creature:DespawnOrUnsummon(1000)
	creature:RemoveEvents()
end

RegisterCreatureEvent(ENTRY_CORRUPTED_WARLOCK, 1, Corrupted_Warlock.OnEnterCombat) -- CREATURE_EVENT_ON_ENTER_COMBAT
RegisterCreatureEvent(ENTRY_CORRUPTED_WARLOCK, 2, Corrupted_Warlock.OnLeaveCombat) -- CREATURE_EVENT_ON_LEAVE_COMBAT
RegisterCreatureEvent(ENTRY_CORRUPTED_WARLOCK, 4, Corrupted_Warlock.OnDied)		-- CREATURE_EVENT_ON_DIED

-- Corrupted Druid
local Corrupted_Druid = {
	Strings = {
	"We're all at fault for this, Druid.",
	"We brought destruction to the peaceful world of Azeroth, Druid.",
	"If peace is your objective, Druid, then surrender all hope.",
	"Abandon hope. Certain things can't be changed.",
	"The World Tree will fall, and then so will Azeroth.",
	"The blame for the corruption of our world will fall on you.",
	"It's too late to save the world. Join us and be a survivor.",
	"Nature can adapt, and so must you -- join us, Druid.",
	}
}

-- Abilities
function Corrupted_Druid.Rejuvenation(event, delay, repeats, creature)
	local creaturesInRange = creature:GetCreaturesInRange(30, 0, 0, 1)
	local EligibleTargets = {}
	for _, v in pairs(creaturesInRange) do
		if v:GetEntry() == ENTRY_CORRUPTED_WARRIOR or v:GetEntry() == ENTRY_CORRUPTED_PALADIN or v:GetEntry() == ENTRY_CORRUPTED_WARLOCK or v:GetEntry() == ENTRY_CORRUPTED_HUNTER or v:GetEntry() == ENTRY_CORRUPTED_SHAMAN or v:GetEntry() == ENTRY_CORRUPTED_PRIEST or v:GetEntry() == ENTRY_CORRUPTED_ROGUE or v:GetEntry() == ENTRY_CORRUPTED_MAGE then
			table.insert(EligibleTargets, v)
		end
	end
	for _, v in pairs(EligibleTargets) do
		if v:IsAlive() and creature:IsWithinLoS(v) then
			creature:CastSpell(v, SPELL_DRUID_REJUVENATE, true)
			return
		end
	end
	creature:CastSpell(creature, SPELL_DRUID_REJUVENATE) -- Only happens if no eligble targets are found.
end

function Corrupted_Druid.Bash(event, delay, repeats, creature)
	local Victim = creature:GetVictim()
	creature:CastSpell(Victim, SPELL_DRUID_BASH, true)
end

function Corrupted_Druid.Moonfire(event, delay, repeats, creature)
	local Target = creature:GetAITarget(0, true, 0, 30)
	if Target then
		creature:CastSpell(Target, SPELL_DRUID_MOONFIRE, true)
	end
end

function Corrupted_Druid.Shapeshift(event, delay, repeats, creature)
	local Victim = creature:GetVictim()
	creature:CastSpell(creature, SPELL_DRUID_BEAR_FORM, true)
	creature:CastSpell(creature, SPELL_DRUID_REJUVENATE, true)
	creature:RegisterEvent(Corrupted_Druid.Bash, {5000,8000}, 5)
	creature:CastSpell(Victim, SPELL_DRUID_BASH, true)
end

-- Main
function Corrupted_Druid.OnEnterCombat(event, creature, target)
	local RandomMessage = math.random(#Corrupted_Druid.Strings)
	creature:SendUnitSay(Corrupted_Druid.Strings[RandomMessage], 0)
	creature:RegisterEvent(Corrupted_Druid.Moonfire, {3000,5000}, 0)
	creature:RegisterEvent(Corrupted_Druid.Shapeshift, {3500,7000}, 1)
	creature:RegisterEvent(Corrupted_Druid.Rejuvenation, {6000,10000}, 0)
end

function Corrupted_Druid.OnLeaveCombat(event, creature)
	creature:RemoveEvents()
end

function Corrupted_Druid.OnDied(event, creature, killer)
	creature:DespawnOrUnsummon(1000)
	creature:RemoveEvents()
end

RegisterCreatureEvent(ENTRY_CORRUPTED_DRUID, 1, Corrupted_Druid.OnEnterCombat) -- CREATURE_EVENT_ON_ENTER_COMBAT
RegisterCreatureEvent(ENTRY_CORRUPTED_DRUID, 2, Corrupted_Druid.OnLeaveCombat) -- CREATURE_EVENT_ON_LEAVE_COMBAT
RegisterCreatureEvent(ENTRY_CORRUPTED_DRUID, 4, Corrupted_Druid.OnDied)		-- CREATURE_EVENT_ON_DIEDe