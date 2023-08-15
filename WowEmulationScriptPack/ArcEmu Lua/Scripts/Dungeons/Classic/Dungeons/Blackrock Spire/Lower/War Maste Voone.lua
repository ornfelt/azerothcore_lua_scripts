-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright (c) zdroid9770                  --
-------------------------------------------------------------------
--[[
----Quotes
----Spells-ID
Cleave-15284
Mortal Strike-16856
Pummel-15615
Snap Kick-15618
Thrash-3391
Throw Axe-16075
Uppercut-10966
]]--

function WMV_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("WMV_Spells", 100, 0)
end

function WMV_Spells(pUnit, Event)
	pUnit:RegisterEvent("WMV_Cleave", 1100, 0)
	pUnit:RegisterEvent("WMV_MortalStrike", 2100, 0)
	pUnit:RegisterEvent("WMV_Pummel", 4100, 0)
	pUnit:RegisterEvent("WMV_SnapKick", 5100, 0)
	pUnit:RegisterEvent("WMV_Thrash", 6100, 0)
	pUnit:RegisterEvent("WMV_ThrowAxe", 7100, 0)
	pUnit:RegisterEvent("WMV_Uppercut", 8100, 0)
end

function WMV_Uppercut(pUnit, Event)
	pUnit:CastSpellOnTarget(10966)
end

function WMV_ThrowAxe(pUnit, Event)
	pUnit:FullCastSpellOnTarget(16075)
end

function WMV_Trash(pUnit, Event)
	pUnit:CastSpell(3391)
end
function WMV_SnapKick(pUnit, Event)
	pUnit:CastSpellOnTarget(15618)
end

function WMV_Pummel(pUnit, Event)
	pUnit:CastSpellOnTarget(15615)
end

function WMV_MortalStrike(pUnit, Event)
	pUnit:CastSpellOnTarget(16856)
end

function WMV_Cleave(pUnit, Event)
	pUnit:CastSpellOnTarget(15284)
end

function WMV_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function WMV_OnDeath(pUnit, Event)
	pUnit:removeEvents()
end

RegisterUnitEvent(9237, 1, "WMV_OnCombat")
RegisterUnitEvent(9237, 2, "WMV_OnLeaveCombat")
RegisterUnitEvent(9237, 4, "WMV_OnDeath")