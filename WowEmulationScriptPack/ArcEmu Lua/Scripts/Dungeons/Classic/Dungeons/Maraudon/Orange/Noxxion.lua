-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright© zdroid9770					 --
-------------------------------------------------------------------

function Noxxion_OnCombat(pUnit, event)
	pUnit:FullCastSpellOnTarget(16050, pUnit:GetRandomPlayer(0))
	pUnit:RegisterEvent("Noxxionphase1", 1000, 0)
	pUnit:RegisterEvent("NoxxionSpout", 6000, 0)
end

function Noxxionphase1(pUnit, event)
	if pUnit:GetHealthPct() < 89 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Noxxionphase3", 1000, 0)
		pUnit:RegisterEvent("NoxxionSludgeNova", 5000, 0)
	end
end

function Noxxionphase3(pUnit, event)
	if pUnit:GetHealthPct() < 58 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Noxxionphase4", 1000, 0)
		x = pUnit:GetX()
		y = pUnit:GetY()
		z = pUnit:GetZ()
		o = pUnit:GetO()
		pUnit:SpawnCreature(12218, x + 4, y, z, o, 14, 100000)
		pUnit:SpawnCreature(12218, x - 4, y, z, o, 14, 100000)
	end
end

function Noxxionphase4(pUnit, event)
	if pUnit:GetHealthPct() < 45 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("Noxxionphase5", 1000, 0)
		x = pUnit:GetX()
		y = pUnit:GetY()
		z = pUnit:GetZ()
		o = pUnit:GetO()
		pUnit:SpawnCreature(12218, x + 4, y, z, o, 14, 100000)
		pUnit:SpawnCreature(12218, x - 4, y, z, o, 14, 100000)
	end
end

function Noxxionphase5(pUnit, event)
	if pUnit:GetHealthPct() < 32 then
		pUnit:RemoveEvents()
		pUnit:CastSpell(30035)
		pUnit:RegisterEvent("Noxxionphase6", 1000, 0)
		x = pUnit:GetX()
		y = pUnit:GetY()
		z = pUnit:GetZ()
		o = pUnit:GetO()
		pUnit:SpawnCreature(12218, x + 4, y, z, o, 14, 100000)
		pUnit:SpawnCreature(12218, x - 4, y, z, o, 14, 100000)
	end
end

function Noxxionphase6(pUnit, event)
	if pUnit:GetHealthPct() < 5 then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("NoxxionSludgeNova", 5000, 0)
		pUnit:CastSpell(41953)
		pUnit:CastSpell(41953)
		pUnit:CastSpell(41953)
	end
end

function NoxxionSpout(pUnit, event)
	pUnit:FullCastSpellOnTarget(39207, pUnit:GetRandomPlayer(0))
end

function NoxxionSludgeNova(pUnit, event)
	pUnit:CastSpell(40103)
end

function NoxxionSwarm(pUnit, event)
	pUnit:FullCastSpellOnTarget(24975, pUnit:GetRandomPlayer(0))
end

function Noxxion_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end

function Noxxion_OnLeaveCombat(Unit)
	Unit:RemoveEvents()
end

RegisterUnitEvent(13282, 1, "Noxxion_OnCombat")
RegisterUnitEvent(13282, 2, "Noxxion_OnLeaveCombat")
RegisterUnitEvent(13282, 4, "Noxxion_OnDeath")