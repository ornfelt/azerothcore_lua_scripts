-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright© zdroid9770					 --
-------------------------------------------------------------------

function RazorLash_OnCombat(pUnit, event)
	pUnit:RegisterEvent("RazorLashphase1", 1000, 0)
	pUnit:RegisterEvent("RazorLashFaerieFire", 6000, 0)
end

function RazorLashphase1(pUnit, event)
	if pUnit:GetHealthPct() < 89 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(30035)
		pUnit:CastSpell(41953)
		pUnit:RegisterEvent("RazorLashphase2", 1000, 0)
		pUnit:RegisterEvent("RazorLashFaerieFire", 6000, 0)
		pUnit:RegisterEvent("RazorLashMassRoot", 18000, 0)
	end
end

function RazorLashphase2(pUnit, event)
	if pUnit:GetHealthPct() < 75 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("RazorLashphase3", 1000, 0)
		pUnit:RegisterEvent("RazorLashFaerieFire", 6000, 0)
		x = pUnit:GeyX()
		y = pUnit:GetY()
		z = pUnit:GetZ()
		o = pUnit:GetO()
		pUnit:SpawnCreature(12219, x + 5, y, z, o, 67, 220000)
		pUnit:SpawnCreature(12219, x - 5, y, z, o, 67, 220000)
		pUnit:CastSpell(41953)
	end
end

function RazorLashphase3(pUnit, event)
	if pUnit:GetHealthPct() < 58 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("RazorLashphase4", 1000, 0)
		pUnit:RegisterEvent("RazorLashFaerieFire", 6000, 0)
		pUnit:RegisterEvent("RazorLashMassRoot", 18000, 0)
		x = pUnit:GeyX()
		y = pUnit:GetY()
		z = pUnit:GetZ()
		o = pUnit:GetO()
		pUnit:SpawnCreature(12219, x + 5, y, z, o, 67, 220000)
		pUnit:SpawnCreature(12219, x - 5, y, z, o, 67, 220000)
		pUnit:CastSpell(41953)
	end
end

function RazorLashphase4(pUnit, event)
	if pUnit:GetHealthPct() < 45 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(41953)
		pUnit:RegisterEvent("RazorLashphase5", 1000, 0)
		pUnit:RegisterEvent("RazorLashFaerieFire", 6000, 0)
		pUnit:RegisterEvent("RazorLashSwarm", 8000, 0)
	end
end

function RazorLashphase5(pUnit, event)
	if pUnit:GetHealthPct() < 32 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(41953)
		pUnit:CastSpell(27993)
		pUnit:RegisterEvent("RazorLashphase6", 1000, 0)
		pUnit:RegisterEvent("RazorLashSwarm", 8000, 0)
		pUnit:RegisterEvent("RazorLashMassRoot", 18000, 0)
	end
end

function RazorLashphase6(pUnit, event)
	if pUnit:GetHealthPct() < 15 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(41953)
		pUnit:CastSpell(27993)
		pUnit:RegisterEvent("RazorLashSwarm", 8000, 0)
		pUnit:RegisterEvent("RazorLashMassRoot", 18000, 0)
	end
end

function RazorLashFaerieFire(pUnit, event)
	pUnit:FullCastSpellOnTarget(21670, pUnit:GetRandomPlayer(0))
end

function RazorLashCyclone(pUnit, event)
	pUnit:FullCastSpellOnTarget(33786, pUnit:GetRandomPlayer(0))
end

function RazorLashSwarm(pUnit, event)
	pUnit:FullCastSpellOnTarget(28786, pUnit:GetRandomPlayer(0))
end

function RazorLashMassRoot(pUnit, event)
	pUnit:FullCastSpellOnTarget(20699, pUnit:GetRandomPlayer(0))
	pUnit:FullCastSpellOnTarget(20699, pUnit:GetRandomPlayer(0))
	pUnit:FullCastSpellOnTarget(20699, pUnit:GetRandomPlayer(0))
end

function RazorLash_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end

function RazorLash_OnLeaveCombat(Unit)
	Unit:RemoveEvents()
end

RegisterUnitEvent(12258, 1, "RazorLash_OnCombat")
RegisterUnitEvent(12258, 2, "RazorLash_OnLeaveCombat")
RegisterUnitEvent(12258, 4, "RazorLash_OnDeath")