--[[ Terokkar Forest -- Accursed Apparition.lua

This script was written and is protected
by the GPL v2. This script was released
by Mager of the BLUA Scripting Project. 
Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- Mager, July, 27th, 2008. ]]

--playing with the else here if it fails ill simply edit it
-- like most my scripts checks if casting if not then cast the spell
function Ashkaz_ArakkoaBlast(Unit)
	local casting = Unit:IsCasting()
	local plr = Unit:GetClosestPlayer()
	if (casting == false) then
		Unit:FullCastSpellOnTarget(32907, plr)
	end
	if (casting == true) then
		Unit:CancelSpell(26098)
	end
end

-- checking for casting not needed cause other spell is instant
function Ashkaz_LightningBolt(Unit)
	Unit:FullCastSpellOnTarget(26098)
end

-- gonna make the buff he gives OnCombat til i find further info on it
function Ashkaz_OnEnterCombat(Unit, event)
	local light = math.random(4300,7300)
	local blast = math.random(8000,15000)
	Unit:RegisterEvent("Ashkaz_LightningBolt", light, 0)
	Unit:RegisterEvent("Ashkaz_ArakkoaBlast", blast, 0) --I think it needs limit ill half to think about it
	Unit:CastSpell(32924)
end

--woot script done
-- Registration
RegisterUnitEvent(18539, 1, "Ashkaz_OnEnterCombat")
