--[[ Netherstorm -- Skeletal Stallion.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 01th, 2008. ]]

function Stallion_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Stallion_Kick",5000,0)
end

function Stallion_Kick(Unit,Event)
    Unit:FullCastSpellOnTarget(11978,Unit:GetMainTank())
end   

function Stallion_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Stallion_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20495, 1, "Stallion_OnEnterCombat")
RegisterUnitEvent (20495, 2, "Stallion_OnLeaveCombat")
RegisterUnitEvent (20495, 4, "Stallion_OnDied")