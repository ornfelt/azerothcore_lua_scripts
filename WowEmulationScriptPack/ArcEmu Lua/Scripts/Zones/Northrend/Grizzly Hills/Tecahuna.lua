--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Tecahuna_OnCombat(Unit, Event)
Unit:RegisterEvent("Tecahuna_TecahunaVenomSpit", 9000, 0)
end

function Tecahuna_TecahunaVenomSpit(Unit, Event) 
Unit:FullCastSpellOnTarget(47629, Unit:GetMainTank()) 
end

function Tecahuna_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Tecahuna_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Tecahuna_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26865, 1, "Tecahuna_OnCombat")
RegisterUnitEvent(26865, 2, "Tecahuna_OnLeaveCombat")
RegisterUnitEvent(26865, 3, "Tecahuna_OnKilledTarget")
RegisterUnitEvent(26865, 4, "Tecahuna_OnDied")