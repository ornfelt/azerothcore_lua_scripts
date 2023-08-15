--[[ Netherstorm -- Phase Hunter.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, September, 30th, 2008. ]]

function Hunter_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Hunter_DeMaterialize",8000,0)
    Unit:RegisterEvent("Hunter_ManaBurn",3000,0)
end

function Hunter_DeMaterialize(Unit,Event)
    Unit:CastSpell(34814)
    Unit:RegisterEvent("Hunter_Materialize",3000,0)
end   
   
function Hunter_ManaBurn(Unit,Event)
    Unit:FullCastSpellOnTarget(13321,Unit:GetClosestPlayer())
end

function Hunter_Materialize(Unit,Event)
    Unit:CastSpell(34804)
end
    
function Hunter_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Hunter_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (18879, 1, "Hunter_OnEnterCombat")
RegisterUnitEvent (18879, 2, "Hunter_OnLeaveCombat")
RegisterUnitEvent (18879, 4, "Hunter_OnDied")