--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Occulus_OnCombat(Unit, Event)
	Unit:RegisterEvent("Occulus_ArcaneBlast", 6000, 0)
	Unit:RegisterEvent("Occulus_SandBreath", 8000, 0)
	Unit:RegisterEvent("Occulus_Swoop", 7000, 0)
end

function Occulus_ArcaneBlast(Unit, Event) 
	Unit:FullCastSpellOnTarget(10833, 	Unit:GetMainTank()) 
end

function Occulus_SandBreath(Unit, Event) 
	Unit:FullCastSpellOnTarget(20717, 	Unit:GetMainTank()) 
end

function Occulus_Swoop(Unit, Event) 
	Unit:CastSpell(18144) 
end

function Occulus_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Occulus_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function Occulus_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(8196, 1, "Occulus_OnCombat")
RegisterUnitEvent(8196, 2, "Occulus_OnLeaveCombat")
RegisterUnitEvent(8196, 3, "Occulus_OnKilledTarget")
RegisterUnitEvent(8196, 4, "Occulus_OnDied")