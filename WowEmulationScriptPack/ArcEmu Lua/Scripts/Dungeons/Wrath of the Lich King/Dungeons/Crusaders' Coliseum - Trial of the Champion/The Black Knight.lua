--[[	
		
		Here goes nothing, Ik hoop dat hij het doet =P NIet slecht voor een middagtje verveling tijdens ICT :P
]]

local undead_ID = 35451 -- Eerste Phase
local skeleton_ID = 35547 -- Tweede Phase
local ghost_ID = 35557 -- Derde Phase
local champion_ID = 35590 -- Risen Champion Add
local heraldSummoned = 0 -- Controle of Herald gesummond is als Ghoul
local ghoulsSummoned = 0 -- Controle of Alle ghouls dood zijn na wipe
local difficulty
local herald
local blackKnight
local risenChampion

-- Heroic Damage
local heraldHCMinDmg = 3000
local heraldHCMaxDmg = 4000
local blackKnightHCMinDmg = 7000
local blackKnightHCMaxDmg = 8000

----------------------------------------------------------------------------------------------------------------
-- Muziek Functies
----------------------------------------------------------------------------------------------------------------

function Black_Knight_OnKilledTarget(pUnit, Event)
	if (math.random(1, 2) == 1) then
		blackKnight:SendChatMessage(14, 0, "Pathetic.")
		blackKnight:PlaySoundToSet(16260) -- AC_BlackKnight_Slay01
	else
		blackKnight:SendChatMessage(14, 0, "A waste of flesh!")
		blackKnight:PlaySoundToSet(16261) -- AC_BlackKnight_Slay02
	end
end



----------------------------------------------------------------------------------------------------------------
-- Abilities
----------------------------------------------------------------------------------------------------------------

function Black_Knight_Plague_Strike(pUnit, Event)
	if (difficulty == 1) then -- Heroic Mode
		blackKnight:FullCastSpellOnTarget(67885, blackKnight:GetMainTank())
	else -- Normal Mode
		blackKnight:FullCastSpellOnTarget(67724, blackKnight:GetMainTank())
	end
end

function Black_Knight_Icy_Touch(pUnit, Event)
	if (difficulty == 1) then -- Heroic Mode
		blackKnight:FullCastSpellOnTarget(67881, blackKnight:GetMainTank())
	else -- Normal Mode
		blackKnight:FullCastSpellOnTarget(67718, blackKnight:GetMainTank())
	end
end

function Black_Knight_Deaths_Respite(pUnit, Event)
	if (difficulty == 1) then -- Heroic Mode
		blackKnight:FullCastSpellOnTarget(68306, blackKnight:GetRandomPlayer(0))
	else -- Normal Mode
		blackKnight:FullCastSpellOnTarget(67745, blackKnight:GetRandomPlayer(0))
	end
end

function Black_Knight_Obliterate(pUnit, Event)
	if (difficulty == 1) then -- Heroic Mode
		blackKnight:FullCastSpellOnTarget(67883, blackKnight:GetMainTank())
	else -- Normal Mode
		blackKnight:FullCastSpellOnTarget(67725, blackKnight:GetMainTank())
	end
end

function Black_Knight_Ghost_Deaths_Bite(pUnit, Event)
	if (difficulty == 1) then -- Heroic Mode
		blackKnight:FullCastSpell(67875)
	else -- Normal Mode
		blackKnight:FullCastSpell(67808)
	end
end

function Black_Knight_Ghost_Marked(pUnit, Event)
	blackKnight:FullCastSpellOnTarget(67823, blackKnight:GetRandomPlayer(0))
end

function Black_Knight_Raise_Herald(pUnit, Event)
	local target = blackKnight:GetMainTank()
	local faction = target:GetTeam()
		
	if (faction == 1) then -- Horde (Risen Jaeren Sunsworn)
		-- blackKnight:FullCastSpell(67715) -- Beetje bugged
		local X = blackKnight:GetX()
		local Y = blackKnight:GetY()
		local Z = blackKnight:GetZ()
		local O = blackKnight:GetO()
		local heraldSummoned = heraldSummoned + 1
		blackKnight:SpawnCreature(35545, X, Y, Z, O, 14, 0)
	elseif (faction == 0) then -- Alliance (Risen Arelas Brightstar)
		-- blackKnight:FullCastSpell(67705) -- Beetje BUgged
		local X = blackKnight:GetX()
		local Y = blackKnight:GetY()
		local Z = blackKnight:GetZ()
		local O = blackKnight:GetO()
		local heraldSummoned = heraldSummoned + 1
		blackKnight:SpawnCreature(35564, X, Y, Z, O, 14, 0)
	end
end

function Black_Knight_Skeleton_AotD(pUnit, Event) -- Doet het niet. Ghouls worden niet gespawnd
	if (ghoulsSummoned == 0) then
		blackKnight:FullCastSpell(67761)
	end
end

function Black_Knight_Skeleton_Desecration(pUnit, Event)
	if (difficulty == 1) then -- Heroic Mode
		blackKnight:FullCastSpellOnTarget(67876, pUnit:GetRandomPlayer(0))
	else -- Normal Mode
		blackKnight:FullCastSpellOnTarget(67781,pUnit:GetRandomPlayer(0))
	end
end

function Black_Knight_Skeleton_Ghoul_Explode(pUnit, Event)
	blackKnight:FullCastSpellOnTarget(67751, pUnit:GetRandomFriend())
end


----------------------------------------------------------------------------------------------------------------
-- Adds And Their Abilities
----------------------------------------------------------------------------------------------------------------

function Herald_OnSpawn(pUnit, Event)
	herald = pUnit
	if (difficulty == 1) then -- Heroic Mode
		herald:SetHealth(50400)
		herald:SetMaxHealth(50400)
		herald:SetUInt32Value(UNIT_FIELD_MINDAMAGE, heraldHCMinDmg)
		herald:SetUInt32Value(UNIT_FIELD_MAXDAMAGE, heraldHCMaxDmg)
	else -- Normal Mode
		herald:SetHealth(31500)
		herald:SetMaxHealth(31500)
	end
end

function Herald_OnCombat(pUnit, Event)
	--herald:RegisterEvent("Herald_Explode", math.random(500, 2500), 1) -- Doet het soms en soms niet
	--herald:RegisterEvent("Herald_Leap", math.random(5000, 12000), 0) -- Server crasht op localhost. Door spell effect
	herald:RegisterEvent("Herald_Claw", math.random(6000, 10000), 0)
end

function Herald_OnDeath(pUnit, Event)
	herald:RemoveEvents()
	herald:Despawn(1, 0)
end

function Herald_OnLeaveCombat(pUnit, Event)
	herald:RemoveEvents()
	herald:Despawn(1, 0)
end

function Herald_Explode(pUnit, Event)
	if (difficulty == 1) then -- Heroic Mode
		herald:FullCastSpell(67886)
	else -- Normal Mode
		herald:FullCastSpell(67729)
	end
end

function Herald_Leap(pUnit, Event)
	herald:FullCastSpellOnTarget(67749, herald:GetRandomPlayer(0))
end

function Herald_Claw(pUnit, Event)
	herald:FullCastSpellOnTarget(67774, herald:GetMainTank())
end

function Champion_OnSpawn(pUnit, Event)
	risenChampion = pUnit
	if (difficulty == 1) then -- Heroic Mode
		risenChampion:SetHealth(37800)
		risenChampion:SetMaxHealth(37800)
		risenChampion:SetUInt32Value(UNIT_FIELD_MINDAMAGE, heraldHCMinDmg)
		risenChampion:SetUInt32Value(UNIT_FIELD_MAXDAMAGE, heraldHCMaxDmg)
	else -- Normal Mode
		risenChampion:SetHealth(18900)
		risenChampion:SetMaxHealth(18900)
	end
	ghoulsSummoned = ghoulsSummoned + 1
end

function Champion_OnCombat(pUnit, Event)
	risenChampion:RegisterEvent("Champion_Claw", math.random(6000, 10000), 0)
end

function Champion_OnDeath(pUnit, Event)
	risenChampion:RemoveEvents()
	risenChampion:Despawn(1, 0)
	ghoulsSummoned = ghoulsSummoned - 1
	if (ghoulsSummoned < 0) then
		ghoulsSummoned = 0
	end
end

function Champion_OnLeaveCombat(pUnit, Event)
	risenChampion:RemoveEvents()
	risenChampion:Despawn(1, 0)
	ghoulsSummoned = ghoulsSummoned - 1
	if (ghoulsSummoned < 0) then
		ghoulsSummoned = 0
	end
end

function Champion_Claw(pUnit, Event)
	local clawTarget = risenChampion:GetMainTank()
	if (clawTarget ~= nil) then
		risenChampion:FullCastSpellOnTarget(67774, clawTarget)
	end
end

RegisterUnitEvent(35545, 1, "Herald_OnCombat")
RegisterUnitEvent(35545, 2, "Herald_OnLeaveCombat")
RegisterUnitEvent(35545, 4, "Herald_OnDeath")
RegisterUnitEvent(35545, 18, "Herald_OnSpawn")
RegisterUnitEvent(35564, 1, "Herald_OnCombat")
RegisterUnitEvent(35564, 2, "Herald_OnLeaveCombat")
RegisterUnitEvent(35564, 4, "Herald_OnDeath")
RegisterUnitEvent(35564, 18, "Herald_OnSpawn")

RegisterUnitEvent(champion_ID, 1, "Champion_OnCombat")
RegisterUnitEvent(champion_ID, 2, "Champion_OnLeaveCombat")
RegisterUnitEvent(champion_ID, 4, "Champion_OnDeath")
RegisterUnitEvent(champion_ID, 18, "Champion_OnSpawn")

----------------------------------------------------------------------------------------------------------------
-- Phase 1 : Undead
----------------------------------------------------------------------------------------------------------------

function Black_Knight_Undead_OnCombat(pUnit, Event)
	blackKnight:SendChatMessage(14, 0, "This farce ends here!")
	blackKnight:PlaySoundToSet(16259) -- AC_BlackKnight_Aggro01
	blackKnight:RegisterEvent("Black_Knight_Plague_Strike", math.random(15000, 19000), 0)
	blackKnight:RegisterEvent("Black_Knight_Icy_Touch", math.random(18000, 25000), 0)
	blackKnight:RegisterEvent("Black_Knight_Deaths_Respite", math.random(15000, 25000), 0)
	blackKnight:RegisterEvent("Black_Knight_Obliterate", math.random(13000, 19000), 0)
	if (heraldSummoned == 0) then
		blackKnight:RegisterEvent("Black_Knight_Raise_Herald", 5000, 1)
	end
end

function Black_Knight_Undead_OnLeaveCombat(pUnit, Event)
	blackKnight:RemoveEvents()
end

function Black_Knight_Undead_OnDeath(pUnit, Event)
	blackKnight:RemoveEvents()
	local X = blackKnight:GetX()
	local Y = blackKnight:GetY()
	local Z = blackKnight:GetZ()
	local O = blackKnight:GetO()
	blackKnight:Despawn(1, 0)
	herald:RegisterEvent("Herald_Explode", 500, 1)
	herald:Despawn(10, 0)
	blackKnight:SpawnCreature(skeleton_ID, X, Y, Z, O, 14, 0)
end

function Black_Knight_Undead_OnSpawn(pUnit, Event)
	blackKnight = pUnit
	difficulty = blackKnight:GetDungeonDifficulty()
	if (difficulty ==1) then -- Heroic Mode
		blackKnight:SetHealth(277000)
		blackKnight:SetMaxHealth(277000)
		blackKnight:SetUInt32Value(UNIT_FIELD_MINDAMAGE, blackKnightHCMinDmg)
		blackKnight:SetUInt32Value(UNIT_FIELD_MAXDAMAGE, blackKnightHCMaxDmg)
	else
		blackKnight:SetHealth(201000)
		blackKnight:SetMaxHealth(201000)
	end
end

RegisterUnitEvent(undead_ID, 1, "Black_Knight_Undead_OnCombat")
RegisterUnitEvent(undead_ID, 2, "Black_Knight_Undead_OnLeaveCombat")
RegisterUnitEvent(undead_ID, 3, "Black_Knight_OnKilledTarget")
RegisterUnitEvent(undead_ID, 4, "Black_Knight_Undead_OnDeath")
RegisterUnitEvent(undead_ID, 18, "Black_Knight_Undead_OnSpawn")


----------------------------------------------------------------------------------------------------------------
-- Phase 2 : Skeleton
----------------------------------------------------------------------------------------------------------------

function Black_Knight_Skeleton_OnSpawn(pUnit, Event)
	blackKnight = pUnit
	if (difficulty ==1) then -- Heroic Mode
		blackKnight:SetHealth(277000)
		blackKnight:SetMaxHealth(277000)
		blackKnight:SetUInt32Value(UNIT_FIELD_MINDAMAGE, blackKnightHCMinDmg)
		blackKnight:SetUInt32Value(UNIT_FIELD_MAXDAMAGE, blackKnightHCMaxDmg)
	else
		blackKnight:SetHealth(201000)
		blackKnight:SetMaxHealth(201000)
	end
end

function Black_Knight_Skeleton_OnCombat(pUnit, Event)
	blackKnight:SendChatMessage(14, 0, "My rotting flesh was just getting in the way!")
	blackKnight:PlaySoundToSet(16262) -- AC_BlackKnight_SkeletonRes01
	blackKnight:RegisterEvent("Black_Knight_Plague_Strike", math.random(15000, 19000), 0)
	blackKnight:RegisterEvent("Black_Knight_Icy_Touch", math.random(18000, 25000), 0)
	blackKnight:RegisterEvent("Black_Knight_Obliterate", math.random(13000, 19000), 0)
	--blackKnight:RegisterEvent("Black_Knight_Skeleton_AotD", 500, 1)
	blackKnight:RegisterEvent("Black_Knight_Skeleton_Desecration", math.random(10000, 17000), 0)
end

function Black_Knight_Skeleton_OnLeaveCombat(pUnit, Event)
	blackKnight:RemoveEvents()
	blackKnight:Despawn(2000, 0)
end

function Black_Knight_Skeleton_OnDeath(pUnit, Event)
	blackKnight:RemoveEvents()
	local X = blackKnight:GetX()
	local Y = blackKnight:GetY()
	local Z = blackKnight:GetZ()
	local O = blackKnight:GetO()
	--risenChampion:Despawn(1, 0)
	blackKnight:Despawn(1, 0)
	blackKnight:SpawnCreature(ghost_ID, X, Y, Z, O, 14, 0)
end

RegisterUnitEvent(skeleton_ID, 1, "Black_Knight_Skeleton_OnCombat")
RegisterUnitEvent(skeleton_ID, 2, "Black_Knight_Skeleton_OnLeaveCombat")
RegisterUnitEvent(skeleton_ID, 3, "Black_Knight_OnKilledTarget")
RegisterUnitEvent(skeleton_ID, 4, "Black_Knight_Skeleton_OnDeath")
RegisterUnitEvent(skeleton_ID, 18, "Black_Knight_Skeleton_OnSpawn")



----------------------------------------------------------------------------------------------------------------
-- Phase 3 : Ghost
----------------------------------------------------------------------------------------------------------------

function Black_Knight_Ghost_OnSpawn(pUnit, Event)
	blackKnight = pUnit
	if (difficulty ==1) then -- Heroic Mode
		blackKnight:SetHealth(277000)
		blackKnight:SetMaxHealth(277000)
		blackKnight:SetUInt32Value(UNIT_FIELD_MINDAMAGE, blackKnightHCMinDmg)
		blackKnight:SetUInt32Value(UNIT_FIELD_MAXDAMAGE, blackKnightHCMaxDmg)
	else
		blackKnight:SetHealth(201000)
		blackKnight:SetMaxHealth(201000)
	end
end

function Black_Knight_Ghost_OnCombat(pUnit, Event)
	blackKnight:SendChatMessage(14, 0, "I have no need for bones to best you!")
	blackKnight:PlaySoundToSet(16263) -- AC_BlackKnight_GhostRes01
	blackKnight:RegisterEvent("Black_Knight_Ghost_Deaths_Bite", 3000, 0)
	blackKnight:RegisterEvent("Black_Knight_Ghost_Marked", 10000, 0) -- Marked For Death skill
end

function Black_Knight_Ghost_OnLeaveCombat(pUnit, Event)
	blackKnight:RemoveEvents()
	blackKnight:Despawn(2000, 0)
end

function Black_Knight_Ghost_OnDeath(pUnit, Event)
	blackKnight:RemoveEvents()
	blackKnight:PlaySoundToSet(16264) -- AC_BlackKnight_Death01
	blackKnight:SendChatMessage(14, 0, "No... I must not fail... again...")
end

RegisterUnitEvent(ghost_ID, 1, "Black_Knight_Ghost_OnCombat")
RegisterUnitEvent(ghost_ID, 2, "Black_Knight_Ghost_OnLeaveCombat")
RegisterUnitEvent(ghost_ID, 3, "Black_Knight_OnKilledTarget")
RegisterUnitEvent(ghost_ID, 4, "Black_Knight_Ghost_OnDeath")
RegisterUnitEvent(ghost_ID, 18, "Black_Knight_Ghost_OnSpawn")