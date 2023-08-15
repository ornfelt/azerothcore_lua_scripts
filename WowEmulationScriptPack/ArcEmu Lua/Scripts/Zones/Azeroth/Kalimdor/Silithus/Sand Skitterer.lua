--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SandSkitterer_OnCombat(Unit, Event)
	Unit:RegisterEvent("SandSkitterer_Poison", 10000, 0)
end

function SandSkitterer_Poison(Unit, Event) 
	Unit:FullCastSpellOnTarget(744, 	Unit:GetRandomPlayer(0)) 
end

function SandSkitterer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SandSkitterer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function SandSkitterer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(11738, 1, "SandSkitterer_OnCombat")
RegisterUnitEvent(11738, 2, "SandSkitterer_OnLeaveCombat")
RegisterUnitEvent(11738, 3, "SandSkitterer_OnKilledTarget")
RegisterUnitEvent(11738, 4, "SandSkitterer_OnDied")