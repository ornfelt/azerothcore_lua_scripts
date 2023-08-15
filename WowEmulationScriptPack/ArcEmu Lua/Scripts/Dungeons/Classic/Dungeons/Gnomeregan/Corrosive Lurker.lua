-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright (c) zdroid9770                  --
-------------------------------------------------------------------
--[[
----Quotes
----Spells-ID
Corrosive Ooze-9459
]]--

function corrosive_lurker_OnCombat(pUnit, event, miscpUnit, misc)
	pUnit:RegisterEvent("Dazed", 25000, 0)
	pUnit:RegisterEvent("Corrosive_Ooze", 50000, 0)
end

function Dazed(pUnit, event, miscpUnit, misc)
	pUnit:FullCastSpellOnTarget(1604, pUnit:GetClosestPlayer()) -- Dazed
end

function Corrosive_Ooze(pUnit, event, miscpUnit, misc)
	pUnit:FullCastSpellOnTarget(9459, pUnit:GetClosestPlayer()) -- Corrosive Ooze
end

function corrosive_lurker_OnLeaveCombat(pUnit)
	pUnit:RemoveEvents()
end

function corrosive_lurker_OnDied(pUnit)
	pUnit:CastSpell(10341)-- Radiation cloud
	pUnit:CastSpell(11638)-- Radiation Poisoning
	pUnit:RemoveEvents()
end

RegisterUnitEvent(6219, 1, "corrosive_lurker_OnCombat")
RegisterUnitEvent(6219, 2, "corrosive_lurker_OnLeaveCombat")
RegisterUnitEvent(6219, 4, "corrosive_lurker_OnDied")