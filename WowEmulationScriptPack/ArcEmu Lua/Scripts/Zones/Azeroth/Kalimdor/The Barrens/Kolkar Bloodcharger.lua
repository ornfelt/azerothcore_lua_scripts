--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function KolkarBloodcharger_OnCombat(Unit, Event)
	Unit:RegisterEvent("KolkarBloodcharger_Bloodlust", 4000, 1)
	Unit:RegisterEvent("KolkarBloodcharger_Corruption", 10000, 0)
end

function KolkarBloodcharger_Bloodlust(Unit, Event) 
	Unit:CastSpell(6742) 
end

function KolkarBloodcharger_Corruption(Unit, Event) 
	Unit:FullCastSpellOnTarget(172, 	Unit:GetMainTank()) 
end

function KolkarBloodcharger_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function KolkarBloodcharger_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function KolkarBloodcharger_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3397, 1, "KolkarBloodcharger_OnCombat")
RegisterUnitEvent(3397, 2, "KolkarBloodcharger_OnLeaveCombat")
RegisterUnitEvent(3397, 3, "KolkarBloodcharger_OnKilledTarget")
RegisterUnitEvent(3397, 4, "KolkarBloodcharger_OnDied")