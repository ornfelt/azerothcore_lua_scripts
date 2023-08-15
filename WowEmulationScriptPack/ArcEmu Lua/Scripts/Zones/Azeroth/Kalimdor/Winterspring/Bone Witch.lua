--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Witch_OnCombat(Unit, Event)
	Unit:RegisterEvent("Witch_ArcaneBolt",6000,0)
	Unit:RegisterEvent("Witch_Shield",10000,0)
	Unit:RegisterEvent("Witch_Movement",8000,0)
end

function Witch_ArcaneBolt(Unit, Event) 
	Unit:FullCastSpellOnTarget(20829, 	Unit:GetMainTank()) 
end

function Witch_Shield(Unit, Event) 
	Unit:CastSpell(17014) 
end

function Witch_Movement(Unit, Event) 
	Unit:FullCastSpellOnTarget(56138, 	Unit:GetMainTank()) 
end

function Witch_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Witch_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(16380, 1, "Witch_OnCombat")
RegisterUnitEvent(16380, 2, "Witch_OnLeaveCombat")
RegisterUnitEvent(16380, 4, "Witch_OnDied")