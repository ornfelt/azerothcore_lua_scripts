--[[ Terokkar Forest -- Accursed Apparition.lua

This script was written and is protected
by the GPL v2. This script was released
by Mager of the BLUA Scripting Project. 
Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- Mager, July, 27th, 2008. ]]

function AuchenaiDeathSpeaker_ShadowBolt(Unit)
	Unit:FullCastSpellOnTarget(9613)
end

function AuchenaiDeathSpeaker_OnEnterCombat(Unit, event)
	local casttime = math.random(3500,5600)
	Unit:RegisterEvent("AuchenaiDeathSpeaker_ShadowBolt", casttime, 0)
	Unit:CastSpell(13787)
end

RegisterUnitEvent(21242, 1, "AuchenaiDeathSpeaker_OnEnterCombat")
