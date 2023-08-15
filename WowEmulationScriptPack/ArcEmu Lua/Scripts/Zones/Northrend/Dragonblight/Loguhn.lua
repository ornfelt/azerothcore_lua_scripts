--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Loguhn_OnCombat(Unit, Event)
Unit:RegisterEvent("Loguhn_Enrage", 10000, 1)
Unit:RegisterEvent("Loguhn_SunderArmor", 5000, 0)
end

function Loguhn_Enrage(Unit, Event) 
Unit:CastSpell(8599)
end

function Loguhn_SunderArmor(Unit, Event) 
Unit:FullCastSpellOnTarget(50370, Unit:GetMainTank()) 
end

function Loguhn_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Loguhn_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Loguhn_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26196, 1, "Loguhn_OnCombat")
RegisterUnitEvent(26196, 2, "Loguhn_OnLeaveCombat")
RegisterUnitEvent(26196, 3, "Loguhn_OnKilledTarget")
RegisterUnitEvent(26196, 4, "Loguhn_OnDied")