--[[ Netherstorm -- Severed Defender.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, September, 30th, 2008. ]]

function Defender_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Defender_Block",1000,(1))
    Unit:RegisterEvent("Defender_Strike",5000,0)
end

function Defender_Block(Unit,Event)
    Unit:CastSpell(12169)
end   

function Defender_Strike(Unit,Event)
    Unit:FullCastSpellOnTarget(36093,Unit:GetMainTank())
end

function Defender_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Defender_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20934, 1, "Defender_OnEnterCombat")
RegisterUnitEvent (20934, 2, "Defender_OnLeaveCombat")
RegisterUnitEvent (20934, 4, "Defender_OnDied")