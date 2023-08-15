--[[ Terokkar Forest -- Accursed Apparition.lua

This script was written and is protected
by the GPL v2. This script was released
by Mager of the BLUA Scripting Project. 
Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- Mager, July, 28th, 2008. ]]

function AuchenaiWarrior_WhirlWind(Unit)
	Unit:CastSpellOnTarget(38619)
end

function AuchenaiWarrior_OnCombat(Unit, event)
	local cast = math.random(8900,12000)
	Unit:RegisterEvent("AuchenaiWarrior_WhirlWind", cast, 0)
end

RegisterUnitEvent(21852, 1, "AuchenaiWarrior_OnCombat")

