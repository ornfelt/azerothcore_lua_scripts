--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WarsongBattleguard_OnCombat(Unit, Event)
Unit:RegisterEvent("WarsongBattleguard_Enrage", 10000, 0)
end

function WarsongBattleguard_Enrage(Unit, Event) 
Unit:CastSpell(8599) 
end

function WarsongBattleguard_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WarsongBattleguard_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WarsongBattleguard_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25242, 1, "WarsongBattleguard_OnCombat")
RegisterUnitEvent(25242, 2, "WarsongBattleguard_OnLeaveCombat")
RegisterUnitEvent(25242, 3, "WarsongBattleguard_OnKilledTarget")
RegisterUnitEvent(25242, 4, "WarsongBattleguard_OnDied")