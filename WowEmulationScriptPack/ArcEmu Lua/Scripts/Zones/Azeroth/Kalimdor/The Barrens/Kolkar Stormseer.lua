--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function KolkarStormseer_OnCombat(Unit, Event)
	Unit:RegisterEvent("KolkarStormseer_FlingTorch", 2000, 1)
	Unit:RegisterEvent("KolkarStormseer_LightningBolt", 8000, 0)
	Unit:RegisterEvent("KolkarStormseer_LightningCloud", 4000, 1)
end

function KolkarStormseer_FlingTorch(Unit, Event) 
	Unit:CastSpell(14292) 
end

function KolkarStormseer_LightningBolt(Unit, Event) 
	Unit:FullCastSpellOnTarget(9532, 	Unit:GetMainTank()) 
end

function KolkarStormseer_LightningCloud(Unit, Event) 
	Unit:CastSpell(6535) 
end

function KolkarStormseer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function KolkarStormseer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function KolkarStormseer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(9523, 1, "KolkarStormseer_OnCombat")
RegisterUnitEvent(9523, 2, "KolkarStormseer_OnLeaveCombat")
RegisterUnitEvent(9523, 3, "KolkarStormseer_OnKilledTarget")
RegisterUnitEvent(9523, 4, "KolkarStormseer_OnDied")