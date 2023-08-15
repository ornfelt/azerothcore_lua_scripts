--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Nak_OnCombat(Unit, Event)
	Unit:RegisterEvent("Nak_LesserHealingWave", 15000, 0)
	Unit:RegisterEvent("Nak_LightningBolt", 8000, 0)
end

function Nak_LesserHealingWave(Unit, Event) 
	Unit:CastSpell(8004) 
end

function Nak_LightningBolt(Unit, Event) 
	Unit:FullCastSpellOnTarget(9532, 	Unit:GetMainTank()) 
end

function Nak_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Nak_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function Nak_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3434, 1, "Nak_OnCombat")
RegisterUnitEvent(3434, 2, "Nak_OnLeaveCombat")
RegisterUnitEvent(3434, 3, "Nak_OnKilledTarget")
RegisterUnitEvent(3434, 4, "Nak_OnDied")