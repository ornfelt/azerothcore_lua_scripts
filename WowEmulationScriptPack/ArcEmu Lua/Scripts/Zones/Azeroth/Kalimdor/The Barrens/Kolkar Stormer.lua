--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function KolkarStormer_OnCombat(Unit, Event)
	Unit:RegisterEvent("KolkarStormer_LightningBolt", 8000, 0)
	Unit:RegisterEvent("KolkarStormer_LightningCloud", 4000, 1)
end

function KolkarStormer_LightningBolt(Unit, Event) 
	Unit:FullCastSpellOnTarget(9532, 	Unit:GetMainTank()) 
end

function KolkarStormer_LightningCloud(Unit, Event) 
	Unit:CastSpell(6535) 
end

function KolkarStormer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function KolkarStormer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function KolkarStormer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3273, 1, "KolkarStormer_OnCombat")
RegisterUnitEvent(3273, 2, "KolkarStormer_OnLeaveCombat")
RegisterUnitEvent(3273, 3, "KolkarStormer_OnKilledTarget")
RegisterUnitEvent(3273, 4, "KolkarStormer_OnDied")