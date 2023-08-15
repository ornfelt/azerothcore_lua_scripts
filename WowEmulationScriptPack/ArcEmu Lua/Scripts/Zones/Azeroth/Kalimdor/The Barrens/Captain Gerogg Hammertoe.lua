--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function CaptainGeroggHammertoe_OnCombat(Unit, Event)
	Unit:RegisterEvent("CaptainGeroggHammertoe_ShieldBash", 10000, 0)
end

function CaptainGeroggHammertoe_ShieldBash(Unit, Event) 
	Unit:FullCastSpellOnTarget(1672, 	Unit:GetMainTank()) 
end

function CaptainGeroggHammertoe_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function CaptainGeroggHammertoe_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function CaptainGeroggHammertoe_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5851, 1, "CaptainGeroggHammertoe_OnCombat")
RegisterUnitEvent(5851, 2, "CaptainGeroggHammertoe_OnLeaveCombat")
RegisterUnitEvent(5851, 3, "CaptainGeroggHammertoe_OnKilledTarget")
RegisterUnitEvent(5851, 4, "CaptainGeroggHammertoe_OnDied")