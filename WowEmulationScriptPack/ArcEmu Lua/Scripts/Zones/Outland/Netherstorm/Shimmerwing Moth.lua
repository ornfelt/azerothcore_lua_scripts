--[[ Netherstorm -- Shimmerwing Moth.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, September, 30th, 2008. ]]

function Moth_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Moth_Dust",10000,0)
    Unit:RegisterEvent("Moth_Buffet",2000,0)
end

function Moth_Dust(Unit,Event)
    Unit:FullCastSpellOnTarget(36592,Unit:GetMainTank())
end   

function Moth_Buffet(Unit,Event)
    Unit:FullCastSpellOnTarget(32914,Unit:GetMainTank())
end

function Moth_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Moth_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20611, 1, "Moth_OnEnterCombat")
RegisterUnitEvent (20611, 2, "Moth_OnLeaveCombat")
RegisterUnitEvent (20611, 4, "Moth_OnDied")