--[[ Netherstorm -- Dimensius the All-Devouring.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 24th, 2008. ]]

function Dimensius_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Dimensius_Trick",1000,(1))
    Unit:RegisterEvent("Dimensius_Spiral",3000,0)
    Unit:RegisterEvent("Dimensius_Vault",1000,0)
end

function Dimensius_Trick(Unit,Event)
    Unit:CastSpell(37425)
end

function Dimensius_Spiral(Unit,Event)
    Unit:FullCastSpellOnTarget(37500,Unit:GetClosestPlayer())
end

function Dimensius_Vault(Unit,Event)
    Unit:FullCastSpellOnTarget(37412,Unit:GetClosestPlayer())
end

function Dimensius_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Dimensius_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (19554, 1, "Dimensius_OnEnterCombat")
RegisterUnitEvent (19554, 2, "Dimensius_OnLeaveCombat")
RegisterUnitEvent (19554, 4, "Dimensius_OnDied")