--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function KolkarDrudge_OnCombat(Unit, Event)
	Unit:RegisterEvent("KolkarDrudge_DustCloud", 12000, 0)
end

function KolkarDrudge_DustCloud(Unit, Event) 
	Unit:FullCastSpellOnTarget(7272, 	Unit:GetMainTank()) 
end

function KolkarDrudge_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function KolkarDrudge_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function KolkarDrudge_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3119, 1, "KolkarDrudge_OnCombat")
RegisterUnitEvent(3119, 2, "KolkarDrudge_OnLeaveCombat")
RegisterUnitEvent(3119, 3, "KolkarDrudge_OnKilledTarget")
RegisterUnitEvent(3119, 4, "KolkarDrudge_OnDied")