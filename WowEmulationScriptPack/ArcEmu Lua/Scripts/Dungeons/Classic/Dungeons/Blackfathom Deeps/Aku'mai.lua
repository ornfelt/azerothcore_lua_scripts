-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright (c) zdroid9770                  --
-------------------------------------------------------------------
--[[
----Quotes
----Spells-ID
Frenzied Rage-3490
Poison Cloud-3815
]]--

function Akumai_OnCombat(pUnit, event)
	pUnit:RegisterEvent("Akumai_FrenziedRage", 5000, 0)
	pUnit:RegisterEvent("Akumai_PoisonCloud", 20000, 0)
end
 
function Akumai_FrenziedRage(pUnit, Event)
	pUnit:CastSpell(3490)
end
 
function Akumai_PoisonCloud(pUnit, Event)
	pUnit:CastSpell(3815)
end
 
function Akumai_OnLeaveCombat(pUnit, event)
	pUnit:RemoveEvents()
end
 
function Akumai_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end
 
RegisterUnitEvent(4829, 1, "Akumai_OnCombat")
RegisterUnitEvent(4829, 2, "Akumai_OnLeaveCombat")
RegisterUnitEvent(4829, 3, "Akumai_OnDeath")