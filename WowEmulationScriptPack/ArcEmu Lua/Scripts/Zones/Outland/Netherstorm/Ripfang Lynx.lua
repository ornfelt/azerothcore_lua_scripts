--[[ Netherstorm -- Ripfang Lynx.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, September, 30th, 2008. ]]

function Lynx_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Lynx_Dash",5000,0)
    Unit:RegisterEvent("Lynx_Rip",6000,0)
    Unit:RegisterEvent("Lynx_Swipe",5000,0)
end

function Lynx_Dash(Unit,Event)
    Unit:CastSpell(36589)
end   
   
function Lynx_Rip(Unit,Event)
    Unit:FullCastSpellOnTarget(36590,Unit:GetMainTank())
end

function Lynx_Swipe(Unit,Event)
    Unit:FullCastSpellOnTarget(31279,Unit:GetMainTank())
end
    
function Lynx_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Lynx_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20671, 1, "Lynx_OnEnterCombat")
RegisterUnitEvent (20671, 2, "Lynx_OnLeaveCombat")
RegisterUnitEvent (20671, 4, "Lynx_OnDied")