--[[ Terokkar Forest -- Accursed Apparition.lua

This script was written and is protected
by the GPL v2. This script was released
by Mager of the BLUA Scripting Project. 
Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- Mager, July, 28th, 2008. ]]

function BlackwindSabercat_Rip(Unit)
	Unit:CastSpellOnTarget(33912)
end

function BlackwindSabercat_OnCombat(Unit, event)
	local cast = math.random(6700,1190)
	Unit:RegisterEvent("BlackWindSabercat_rip", cast, 0)
end

RegisterUnitEvent(21723, 1, "BlackwindSabercat_OnCombat")




