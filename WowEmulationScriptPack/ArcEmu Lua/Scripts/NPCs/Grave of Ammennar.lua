--[[ Grave of Ammennar
	For use on CNA-WoW only
	Do not release
	Copyright (C) Harry Copp, 2010 ]]--
	
-- Trash mobs
local Executioner = 910002  -- Completed
local Acolyte = 910003 -- Completed
local Ghoul = 910004 -- Completed
local Golem = 910005 -- Completed

-- Bosses
local Nessy = 910001 -- Completed
local Ammennar = 910006 -- In progress
local Imezakam = 910007 -- In progress

GraveOfAmmennar = {}
GraveOfAmmennar.Executioner = {}
GraveOfAmmennar.Acolyte = {}
GraveOfAmmennar.Ghoul = {}
GraveOfAmmennar.Golem = {}
GraveOfAmmennar.Nessy = {}
GraveOfAmmennar.Ammennar = {}
GraveOfAmmennar.Imezakam = {}


-- Trash mobs
-- Executioner
function GraveOfAmmennar.Executioner.OnCombat(Unit, event)
	local id = Unit:GetInstanceID()
	local sUnit = tostring(Unit)
	GraveOfAmmennar[id].Executioner[sUnit] = {}
	local ExecutionerChoice = math.random(1, 3)
	if (ExecutionerChoice == 1) then
		Unit:SendChatMessage(14, 0, "Infiltrators! Kill them!")
	elseif (ExecutionerChoice == 2) then
	elseif (ExecutionerChoice == 3) then
	end
	Unit:RegisterEvent("GraveOfAmmennar.Executioner_PhaseOne", 1000, 0)
end

function GraveOfAmmennar.Executioner.OnDeath(Unit, event)
	local id = pUnit:GetInstanceID()
	local sUnit = tostring(Unit)
	GraveOfAmmennar[id].Executioner.IsDead = true
	GraveOfAmmennar[id].Executioner[sUnit] = nil
end

function GraveOfAmmennar.Executioner_PhaseOne(Unit, event)
	if (Unit:GethealthPct() <= 74) then
		 Unit:CastSpell(1680) -- Whirlwind
		 Unit:RegisterEvent("GraveOfAmmennar.Executioner_PhaseTwo", 1000, 0)
	end
end

function GraveOfAmmennar.Executioner_PhaseTwo(Unit, event)
	if (Unit:GetHealthPct() <= 38) then
		Unit:CastSpell(1680) -- Whirlwind
		Unit:RegisterEvent("GraveOfAmmennar.Executioner_PhaseThree", 1000, 0)
	end
end

function GraveOfAmmennar.Executioner_PhaseThree(Unit, event)
	if (Unit:GetHealthPct() <= 7) then
		Unit:CastSpell(46924) -- Bladestorm
	end
end

RegisterUnitEvent(Executioner, 1, GraveOfAmmennar.Executioner.OnCombat)
RegisterUnitEvent(Executioner, 4, GraveOfAmmennar.Executioner.OnDeath)


--Acolyte
function GraveOfAmmennar.Acolyte.OnCombat(Unit, event)
	local id = Unit:GetInstanceID()
	local sUnit = tostring(Unit)
	GraveOfAmmennar[id].Acolyte[sUnit] = {}
	Unit:RegisterEvent("GraveOfAmmennar.Acolyte_PhaseOne", 1000, 0)
end

function GraveOfAmmennar.Acolyte.OnDeath(Unit, event)
	local id = pUnit:GetInstanceID()
	local sUnit = tostring(Unit)
	GraveOfAmmennar[id].Acolyte.IsDead = true
	GraveOfAmmennar[id].Acolyte[sUnit] = nil
end

function GraveOfAmmennar.Acolyte_PhaseOne(Unit, event)
	if (Unit:GethealthPct() <= 64) then
		 Unit:CastSpell(1680) -- Whirlwind
		 Unit:RegisterEvent("GraveOfAmmennar.Acolyte_PhaseTwo", 1000, 0)
	end
end

function GraveOfAmmennar.Acolyte_PhaseTwo(Unit, event)
	if (Unit:GetHealthPct() <= 27) then
		Unit:CastSpell(1680) -- Whirlwind
	end
end

RegisterUnitEvent(Acolyte, 1, GraveOfAmmennar.Acolyte.OnCombat)
RegisterUnitEvent(Acolyte, 4, GraveOfAmmennar.Acolyte.OnDeath)


-- Ghoul
function GraveOfAmmennar.Ghoul.OnCombat(Unit, event)
	local id = Unit:GetInstanceID()
	local sUnit = tostring(Unit)
	GraveOfAmmennar[id].Ghoul[sUnit] = {}
	Unit:RegisterEvent("GraveOfAmmennar.Ghoul_PhaseOne", 1000, 0)
end

function GraveOfAmmennar.Ghoul.OnDeath(Unit, event)
	local id = pUnit:GetInstanceID()
	local sUnit = tostring(Unit)
	GraveOfAmmennar[id].Ghoul.IsDead = true
	GraveOfAmmennar[id].Ghoul[sUnit] = nil
end

function GraveOfAmmennar.Ghoul_PhaseOne(Unit, event)
	if (Unit:GethealthPct() <= 69) then
		 Unit:CastSpell(67793) -- Claw (Rank 11)
		 Unit:RegisterEvent("GraveOfAmmennar.Ghoul_PhaseTwo", 1000, 0)
	end
end

function GraveOfAmmennar.Ghoul_PhaseTwo(Unit, event)
	if (Unit:GetHealthPct() <= 42) then
		Unit:CastSpell(67793) -- Claw (Rank 11)	
		Unit:RegisterEvent("GraveOfAmmennar.Ghoul_PhaseThree", 1000, 0)
	end
end

function GraveOfAmmennar.Ghoul_PhaseThree(Unit, event)
	if (Unit:GetHealthPct() <= 15) then
		Unit:CastSpell(67793) -- Claw (Rank 11)
	end
end

RegisterUnitEvent(Ghoul, 1, GraveOfAmmennar.Ghoul.OnCombat)
RegisterUnitEvent(Ghoul, 4, GraveOfAmmennar.Ghoul.OnDeath)


-- Golem
function GraveOfAmmennar.Golem.OnCombat(Unit, event)
	local id = Unit:GetInstanceID()
	local sUnit = tostring(Unit)
	GraveOfAmmennar[id].Golem[sUnit] = {}
	Unit:RegisterEvent("GraveOfAmmennar.Golem_PhaseOne", 1000, 0)
end

function GraveOfAmmennar.Golem.OnDeath(Unit, event)
	local id = pUnit:GetInstanceID()
	local sUnit = tostring(Unit)
	GraveOfAmmennar[id].Golem.IsDead = true
	GraveOfAmmennar[id].Golem[sUnit] = nil
end

function GraveOfAmmennar.Golem_PhaseOne(Unit, event)
	if (Unit:GethealthPct() <= 82) then
		 Unit:CastSpell(51723) -- Fan of knives
		 Unit:RegisterEvent("GraveOfAmmennar.Golem_PhaseTwo", 1000, 0)
	end
end

function GraveOfAmmennar.Golem_PhaseTwo(Unit, event)
	if (Unit:GetHealthPct() <= 12) then
		Unit:CastSpell(51723) -- Fan of knives
	end
end

RegisterUnitEvent(Golem, 1, GraveOfAmmennar.Golem.OnCombat)
RegisterUnitEvent(Golem, 4, GraveOfAmmennar.Golem.OnDeath)



-- Bosses
-- Nessy
local Nessy_PhaseTwoChoice = 0

function GraveOfAmmennar.Nessy.OnCombat(Unit, event, Attacker)
	local id = Unit:GetInstanceID()
	local sUnit = tostring(Unit)
	GraveOfAmmennar[id].Nessy[sUnit] = {}
	GraveOfAmmennar[id].Nessy[sUnit].InitalAttacker = Attacker
	Unit:RegisterEvent("GraveOfAmmennar.Nessy_PhaseOne", 1000, 0)
	Unit:SendChatMessage(12, 0, "So, you've got past my guards? No problem, I'll take you down myself.")
end

function GraveOfAmmennar.Nessy.OnDeath(Unit, event)
	local id = Unit:GetInstanceID()
	local sUnit = tostring(Unit)
	GraveOfAmmennar[id].Nessy.IsDead = true
	GraveOfAmmennar[id].Nessy[sUnit] = nil
end

function GraveOfAmmennar.Nessy_PhaseOne(Unit, event)
	if (Unit:GetHealthPct() <= 93) then
		Unit:CastSpell(62583) -- Frostbolt
		Unit:CastSpell(62583) -- Frostbolt
		Unit:RegisterEvent("GraveOfAmmennar.Nessy_PhaseTwo", 1000, 0)
	end
end

function GraveOfAmmennar.Nessy_PhaseTwo(Unit, event)
	local NessyChoice = math.random(1, 4)
	if (NessyChoice == 1) then
		if (Unit:GetHealthPct() <= 81) then
			Nessy_PhaseTwoChoice = 1
			Unit:FullCastSpellOnTarget(93501, Unit:GetMainTank()) -- Bubblebeam
			Unit:CastSpell(82676) -- Ring of Frost
			Unit:RegisterEvent("GraveOAmmennar.Nessy_PhaseThree", 1000, 0)
		end
	elseif (NessyChoice == 2) then
		if (Unit:GetHealthPct() <= 79) then
			Nessy_PhaseTwoChoice = 2
			Unit:CastSpell(76793) -- Bubble Shield
			Unit:FullCastSpellOnTarget(29290, Unit:GetRandomPlayer(0)) -- Chilling poison
			Unit:RegisterEvent("GraveOAmmennar.Nessy_PhaseThree", 1000, 0)
		end
	elseif (NessyChoice == 3) then
		if (Unit:GetHealthPct() <= 76) then
			Nessy_PhaseTwoChoice = 3
			Unit:CastSpell(76793) -- Bubble Shield
			Unit:CastSpell(82676) -- Ring of Frost
			Unit:RegisterEvent("GraveOAmmennar.Nessy_PhaseThree", 1000, 0)
		end
	elseif (NessyChoice == 4) then
		if (Unit:GetHealthPct() <= 73) then
			Nessy_PhaseTwoChoice = 4
			Unit:FullCastSpellOnTarget(93501, Unit:GetMainTank()) -- Bubblebeam
			Unit:RegisterEvent("GraveOAmmennar.Nessy_PhaseThree", 1000, 0)	
		end
	end
end

function GraveOfAmmennar.Nessy_PhaseThree(Unit, event)
	if (Nessy_PhaseTwoChoice == 1 or 2) then
		if (Unit:GetHealthPct() <= 78) then
			Unit:RegisterEvent("GraveOfAmmennar.Nessy_PhaseFour", 1000, 0)
		end
	elseif (Nesst_PhaseTwoChoice == 3 or 4) then
		if (Unit:GetHealthPct() <= 68) then
			Unit:RegisterEvent("GraveOfAmmennar.Nessy_PhaseFour", 1000, 0)
		end
	end
end

function GraveOfAmmennar.Nessy_PhaseFour(Unit, event)
	if (Unit:GetHealthPct() <= 50) then
		Unit:SendChatMessage(12, 0, "You're tougher than I thought...")
		Unit:RegisterEvent("GraveOfAmmennar.Nessy_PhaseFive", 1000, 0)
	end
end

function GraveOfAmmennar.Nessy_PhaseFive(Unit, event)
	if (Unit:GetHealthPct() <= 28) then
		Unit:CastSpell(82676) -- Ring of Frost
		Unit:RegisterEvent("GraveOfAmmennar.Nessy_PhaseSix", 1000, 0)
	end
end

function GraveOfAmmennar.Nessy_PhaseSix(Unit, event)
	if (Unit:GetHealthPct() <= 13) then
		Unit:CastSpell(62583) -- Frostbolt
	end
end

RegisterUnitEvent(Nessy, 1, GraveOfAmmennar.Nessy.OnCombat)
RegisterUnitEvent(Nessy, 4, GraveOfAmmennar.Nessy.OnDeath)


-- Ammennar
function GraveOfAmmennar.Ammennar.OnCombat(Unit, event, Attacker)
	local id = Unit:GetInstanceID()
	local sUnit = tostring(Unit)
	GraveOfAmmennar[id].Ammennar[sUnit] = {}
	GraveOfAmmennar[id].Ammennar[sUnit].InitalAttacker = Attacker
	Unit:RegisterEvent("GraveOfAmmennar.Ammennar_PhaseOne", 1000, 0)
	Unit:SendChatMessage(12, 0, "So, "..Attacker..", you think you could take me down?")
end

function GraveOfAmmennar.Ammennar_PhaseOne(Unit, event)
	if (Unit:GetHealthPct() <= 87) then
		Unit:RegisterEvent("GraveOfAmmennar.Ammennar_PhaseTwo", 1000, 0)
	end
end

function GraveOfAmmennar.Ammennar_PhaseTwo(Unit, event)
	if (Unit:GetHealthPct() <= 54) then
		Unit:RegisterEvent("GraveOfAmmennar.Ammennar_PhaseThree", 1000, 0)
	end
end

function GraveOfAmmennar.Ammennar_PhaseThree(Unit, event)
	if (Unit:GetHealthPct() <= 48) then
		Unit:RegisterEvent("GraveOfAmmennar.Ammennar_PhaseFour", 1000, 0)
	end
end

function GraveOfAmmennar.Ammennar_PhaseFour(Unit, event)
	if (Unit:GetHealthPct() <= 29) then
		Unit:RegisterEvent("GraveOfAmmennar.Ammennar_PhaseFive", 1000, 0)
	end
end

function GraveOfAmmennar.Ammennar_PhaseFive(Unit, event)
	if (Unit:GetHealthPct() <=11) then
		Unit:RegisterEvent("GraveOfAmmennar.Ammennar_PhaseSix", 1000, 0)
	end
end

function GraveOfAmmennar.Ammennar_PhaseSix(Unit, event)
	if (Unit:GetHealthPct() <= 3) then
	end
end

function GraveOfAmmennar.Ammennar.OnDeath(Unit, event)
	local id = Unit:GetInstanceID()
	local sUnit = tostring(Unit)
	GraveOfAmmennar[id].Ammennar.IsDead = true
	GraveOfAmmennar[id].Ammennar[sUnit] = nil
end

RegisterUnitEvent(Ammennar, 1, GraveOfAmmennar.Ammennar.OnCombat)
RegisterUnitEvent(Ammennar, 4, GraveOfAmmennar.Ammennar.OnDeath)


-- Imezakam
function GraveOfAmmennar.Imezakam.OnCombat(Unit, event, Attacker)
	local id = Unit:GetInstanceID()
	local sUnit = tostring(Unit)
	GraveOfAmmennar[id].Imezakam[sUnit] = {}
	GraveOfAmmennar[id].Imezakam[sUnit].InitalAttacker = Attacker
end

function GraveOfAmmennar.Imezakam.OnDeath(Unit, event)
	local id = Unit:GetInstanceID()
	local sUnit = tostring(Unit)
	GraveOfAmmennar[id].Imezakam.IsDead = true
	GraveOfAmmennar[id].Imezakam[sUnit] = nil
end

RegisterUnitEvent(Imezakam, 1, GraveOfAmmennar.Imezakam.OnCombat)
RegisterUnitEvent(Imezakam, 4, GraveOfAmmennar.Imezakam.OnDeath)