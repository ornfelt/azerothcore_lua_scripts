--[[ Hand of The Deceiver(Visual).lua

This script was written and is protected
by the GPL v2. This script was released
by BrantX of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BrantX, February 24th, 2008. ]]

function HandOfDeceiverVisual_OnSpawn(Unit,Event)
	Unit:FullCastSpell(51795)
	Unit:RegisterEvent("HandOfDeceiverVisual_Channel", 10000, 0)
end

function HandOfDeceiverVisual_Channel(Unit,Event)
	Unit:FullCastSpell(51795)
end

RegisterUnitEvent(25955, 18, "HandOfDeceiverVisual_OnSpawn")