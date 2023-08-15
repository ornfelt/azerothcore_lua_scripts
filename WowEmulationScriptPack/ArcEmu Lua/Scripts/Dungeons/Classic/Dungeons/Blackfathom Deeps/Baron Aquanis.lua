-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright (c) zdroid9770                  --
-------------------------------------------------------------------
--[[
----Quotes
----Spells-ID
Frost Nova-15531
Frostbolt-15043
]]--

function BaronAquanis_OnCombat(pUnit, event)
	pUnit:RegisterEvent("BaronAquanis_FrostNova", 15000, 0)
	pUnit:RegisterEvent("BaronAquanis_Frostbolt", 10000, 0)
end
 
function BaronAquanis_FrostNova(pUnit, Event)
	pUnit:CastSpell(15531)
end
 
function BaronAquanis_Frostbolt(pUnit, Event)
	pUnit:FullCastSpellOnTarget(15043, pUnit:GetRandomPlayer(0))
end
 
function BaronAquanis_OnLeaveCombat(pUnit, event)
	pUnit:RemoveEvents()
end
 
function BaronAquanis_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end
 
RegisterUnitEvent(12876, 1, "BaronAquanis_OnCombat")
RegisterUnitEvent(12876, 2, "BaronAquanis_OnLeaveCombat")
RegisterUnitEvent(12876, 3, "BaronAquanis_OnDeath")