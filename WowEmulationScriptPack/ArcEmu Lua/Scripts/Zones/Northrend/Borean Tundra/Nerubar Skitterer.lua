--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function NerubarSkitterer_OnCombat(Unit, Event)
Unit:RegisterEvent("NerubarSkitterer_PiercingBlow", 8000, 0)
end

function NerubarSkitterer_PiercingBlow(Unit, Event) 
Unit:FullCastSpellOnTarget(49749, Unit:GetMainTank()) 
end

function NerubarSkitterer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NerubarSkitterer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NerubarSkitterer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24566, 1, "NerubarSkitterer_OnCombat")
RegisterUnitEvent(24566, 2, "NerubarSkitterer_OnLeaveCombat")
RegisterUnitEvent(24566, 3, "NerubarSkitterer_OnKilledTarget")
RegisterUnitEvent(24566, 4, "NerubarSkitterer_OnDied")