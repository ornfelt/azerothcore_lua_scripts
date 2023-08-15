-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright (c) zdroid9770                  --
-------------------------------------------------------------------
--[[
----Quotes
----Spells-ID
Enrage-15061
Flurry-17687
Sunder Armor-15572
]]--

function GAF_OnCombat(pUnit, Event)
		pUnit:RegisterEvent("GAF_Enrage", 25000, 0)
		pUnit:RegisterEvent("GAF_Flurry", 5000, 0)
		pUnit:RegisterEvent("GAF_SunderArmor", 20000, 0)
end

function GAF_Enrage(pUnit, Event)
	if (pUnit:GetHealthPct() >= 30) then
		pUnit:SpawnCreature(8894, pUnit:GetX(), pUnit:GetY(),pUnit:GetZ(), pUnit:GetO(), 14, 300000)
		pUnit:SpawnCreature(8894, pUnit:GetX(), pUnit:GetY(),pUnit:GetZ(), pUnit:GetO(), 14, 300000)
		pUnit:FullCastSpell(15061)
	end
end

function GAF_Flurry(pUnit, Event)
	pUnit:FullCastSpell(17687)
end

function GAF_SunderArmor(pUnit, Event)
	pUnit:FullCastSpellOnTarget(15572)
end

function GAF_OnLeaveCombat(pUnit, Event)
        pUnit:RemoveEvents()
end

function GAF_OnDeath(pUnit, Event)
        pUnit:RemoveEvents()
end

RegisterUnitEvent(9033, 1, "GAF_OnCombat")
RegisterUnitEvent(9033, 2, "GAF_OnLeaveCombat")
RegisterUnitEvent(9033, 4, "GAF_OnDeath")