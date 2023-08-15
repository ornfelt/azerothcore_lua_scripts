local GH = 930020
local Ghoul = 930021

function Ghoul_OnSpawn(pUnit, Event)
	pUnit:Root()
	pUnit:SetFaction(35)
	local MapId = pUnit:GetMapId()
	local x = pUnit:GetX()
	local y = pUnit:GetY()
	local z = pUnit:GetZ()
	pUnit:RegisterEvent("Ghoul_Test", 1000, 1)
	pUnit:RegisterEvent("Ghoul_Unroot", 8000, 1)
end

function Ghoul_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("Spell1", 10000, 0)
	pUnit:RegisterEvent("Spell2", 15000, 0)
	pUnit:RegisterEvent("Spell3", 25000, 0)
end

function Ghoul_Test(pUnit, Event)
	pUnit:Emote(449, 4000)
end

function Spell1(pUnit, Event)
	pUnit:FullCastSpellOnTarget(40400, pUnit:GetPrimaryCombatTarget())
end

function Spell2(pUnit, Event)
	pUnit:FullCastSpellOnTarget(29044, pUnit:GetPrimaryCombatTarget())
end

function Spell3(pUnit, Event)
	pUnit:FullCastSpellOnTarget(11641, pUnit:GetPrimaryCombatTarget())
end

function Ghoul_Unroot(pUnit, Event)
	pUnit:SetFaction(14)
	pUnit:Unroot()
end

function GhoulOne_OnDeath(pUnit, Event)
	pUnit:Despawn(1000, 0)
	local choice = math.random(1, 2)
	if(choice == 1) then
		pUnit:SpawnCreature(930020, x, y, z, 0, 35, 0)
	else
	if(choice == 2) then
		pUnit:SpawnCreature(930021, x, y, z, 0, 35, 0)
		end
	end
end

function GhoulTwo_OnDeath(pUnit, Event)
	pUnit:Despawn(1000, 0)
	local choice = math.random(1, 2)
	if(choice == 1) then
		pUnit:SpawnCreature(930020, x, y, z, 0, 35, 0)
	else
	if(choice == 2) then
		pUnit:SpawnCreature(930021, x, y, z, 0, 35, 0)
		end
	end
end

RegisterUnitEvent(GH, 4, "GhoulOne_OnDeath")
RegisterUnitEvent(Ghoul, 4, "GhoulTwo_OnDeath")
RegisterUnitEvent(GH, 18, "Ghoul_OnSpawn")
RegisterUnitEvent(Ghoul, 18, "Ghoul_OnSpawn")
RegisterUnitEvent(GH, 1, "Ghoul_OnCombat")
RegisterUnitEvent(Ghoul, 1, "Ghoul_OnCombat")
