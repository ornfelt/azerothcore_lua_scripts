-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright (c) zdroid9770                  --
-------------------------------------------------------------------

function OldSerra_OnLeaveCombat(pUnit, event)
	pUnit:RemoveEvents()
end

function OldSerra_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(4830, 2, "OldSerra_OnLeaveCombat")
RegisterUnitEvent(4830, 3, "OldSerra_OnDeath")