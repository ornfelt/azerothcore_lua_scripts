--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function KolkarWrangler_OnCombat(Unit, Event)
	Unit:RegisterEvent("KolkarWrangler_Net", 10000, 0)
	Unit:RegisterEvent("KolkarWrangler_Shoot", 6000, 0)
end

function KolkarWrangler_Net(Unit, Event) 
	Unit:FullCastSpellOnTarget(12024, 	Unit:GetMainTank()) 
end

function KolkarWrangler_Shoot(Unit, Event) 
	Unit:FullCastSpellOnTarget(6660, 	Unit:GetMainTank()) 
end

function KolkarStormseer_LightningCloud(Unit, Event) 
	Unit:CastSpell(6535) 
end

function KolkarWrangler_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function KolkarWrangler_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function KolkarWrangler_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3272, 1, "KolkarWrangler_OnCombat")
RegisterUnitEvent(3272, 2, "KolkarWrangler_OnLeaveCombat")
RegisterUnitEvent(3272, 3, "KolkarWrangler_OnKilledTarget")
RegisterUnitEvent(3272, 4, "KolkarWrangler_OnDied")