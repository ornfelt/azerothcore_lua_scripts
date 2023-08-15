--[[ Terokkar Forest -- Accursed Apparition.lua

This script was written and is protected
by the GPL v2. This script was released
by Mager of the BLUA Scripting Project. 
Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- Mager, July, 27th, 2008. ]]



function AuchenaiDoomsayer_Heal(Unit)
	local hp = Unit:GetHealthPct()
	if (hp < 43) then
		Unit:CastSpell(11642)
	end
end

-- Having some fun here making it choose at random on of 
-- the two spells possible if not liked ill change
function AuchenaiDoomsayer_Mind(Unit)
	local Spell = math.random(1,2)
	if (Spell == 1) then
		Unit:FullCastSpellOnTarget(3516)
	end
	if (Spell == 2) then
		Unit:FullCastSpellOnTarget(16568)
	end
end


--Heal set to 12 seconda cause it seems about 10-12 seconds on retail

function AuchenaiDoomsayer_OnEnterCombat(Unit, event)
	local spellcast = math.random(2300,5600)
	Unit:RegisterEvent("AuchenaiDoomsayer_MindBlast", spellcast, 0)
	Unit:RegisterEvent("AuchenaiDoomsayer_Heal", 12000, 2)
end

RegisterUnitEvent(21285, 1, "AuchenaiDoomsayer_OnEnterCombat")
	
	
	
