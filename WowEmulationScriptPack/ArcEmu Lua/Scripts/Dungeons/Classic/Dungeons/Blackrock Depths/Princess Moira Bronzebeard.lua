-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright (c) zdroid9770                  --
--------------------------------------------------------------------
--[[
----Quotes
----Spells-ID
Heal-15586
Mind Blast-15587
Renew-8362
Shadow Bolt-15537
Shadow Word: Pain-15654
]]--

function PMBB_OnCombat(pUnit, event)
	pUnit:RegisterEvent("PMBB_Heal", 5000, 0)
	pUnit:RegisterEvent("PMBB_MindBlast", 25000, 0)
	pUnit:RegisterEvent("PMBB_SWPain", 30000, 0)
	pUnit:RegisterEvent("PMBB_Renew", 35000, 0)
	pUnit:RegisterEvent("PMBB_ShadowBolt", 40000, 0)
end
 
function PMBB_Heal(pUnit, Event)
	pUnit:FullCastSpell(15586)
end
 
function PMBB_MindBlast(pUnit, Event)
	pUnit:FullCastSpellOnTarget(15587)
end

function PMBB_SWPain(pUnit, Event)
	pUnit:CastSpellOnTarget(15654)
end

function PMBB_ShadowBolt(Unit, Event)
	pUnit:FullCastSpellOnTarget(15537)
end

function PMBB_Renew(Unit, Event)
	pUnit:FullCastSpell(8362)
end
 
function PMBB_OnLeaveCombat(pUnit, event)
	pUnit:RemoveEvents()
end
 
function PMBB_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end
 
RegisterUnitEvent(8929, 1, "PMBB_OnCombat")
RegisterUnitEvent(8929, 2, "PMBB_OnLeaveCombat")
RegisterUnitEvent(8929, 4, "PMBB_OnDeath")