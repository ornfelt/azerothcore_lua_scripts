-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright (c) zdroid9770                  --
-------------------------------------------------------------------
--[[
----Quotes
----Spells-ID
Blessing of Blackfathom (the altar behind him)
Net-6533
]]--


function Gelihast_OnCombat(pUnit, event)
	pUnit:RegisterEvent("Gelihast_Net", 4000, 0)
end
 
function Gelihast_Net(pUnit, Event)
	pUnit:FullCastSpellOnTarget(6533, pUnit:GetRandomPlayer(0))
end
 
function Gelihast_OnLeaveCombat(pUnit, event)
	pUnit:RemoveEvents()
end
 
function Gelihast_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end
 
RegisterUnitEvent(6243, 1, "Gelihast_OnCombat")
RegisterUnitEvent(6243, 2, "Gelihast_OnLeaveCombat")
RegisterUnitEvent(6243, 3, "Gelihast_OnDeath")
RegisterUnitEvent(6243, 3, "Gelihast_OnDeath")