--[[ Terokkar Forest -- Accursed Apparition.lua

This script was written and is protected
by the GPL v2. This script was released
by Mager of the BLUA Scripting Project. 
Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- Mager, July, 27th, 2008. ]]


-- This is a simple script just use shield bash every once and a while

function Ayit_ShieldBash(Unit)
	Unit:CastSpellOnTarget(11972)
end

function Ayit_OnCombat(Unit, event)
	local cast = math.random(7500,10000)
	Unit:RegisterEvent("Ayit_ShieldBash", cast, 0)
end

RegisterUnitEvent(18540, 1, "Ayit_OnCombat")
