--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function FumblubGearwind_OnCombat(Unit, Event)
Unit:RegisterEvent("FumblubGearwind_MachineGun", 8000, 0)
end

function FumblubGearwind_MachineGun(Unit, Event) 
Unit:FullCastSpellOnTarget(60906, Unit:GetMainTank()) 
end

function FumblubGearwind_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FumblubGearwind_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FumblubGearwind_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(32358, 1, "FumblubGearwind_OnCombat")
RegisterUnitEvent(32358, 2, "FumblubGearwind_OnLeaveCombat")
RegisterUnitEvent(32358, 3, "FumblubGearwind_OnKilledTarget")
RegisterUnitEvent(32358, 4, "FumblubGearwind_OnDied")