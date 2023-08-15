--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function MateofMagmothregar_OnCombat(Unit, Event)
Unit:RegisterEvent("MateofMagmothregar_Enrage", 10000, 0)
end

function MateofMagmothregar_Enrage(Unit, Event) 
Unit:CastSpell(50420) 
end

function MateofMagmothregar_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function MateofMagmothregar_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function MateofMagmothregar_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25432, 1, "MateofMagmothregar_OnCombat")
RegisterUnitEvent(25432, 2, "MateofMagmothregar_OnLeaveCombat")
RegisterUnitEvent(25432, 3, "MateofMagmothregar_OnKilledTarget")
RegisterUnitEvent(25432, 4, "MateofMagmothregar_OnDied")