--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function PrinceRaze_OnCombat(Unit, Event)
	Unit:RegisterEvent("PrinceRaze_GiftoftheXavian", 15000, 1)
	Unit:RegisterEvent("PrinceRaze_Fireball", 8000, 0)
	Unit:RegisterEvent("PrinceRaze_FireNova", 6000, 0)
	Unit:RegisterEvent("PrinceRaze_ChargedArcaneBolt", 1000, 1)
end

function PrinceRaze_GiftoftheXavian(pUnit, Event) 
	pUnit:CastSpell(6925) 
end

function PrinceRaze_Fireball(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(9053, 	pUnit:GetMainTank()) 
end

function PrinceRaze_FireNova(pUnit, Event) 
	pUnit:CastSpell(11969) 
end

function PrinceRaze_ChargedArcaneBolt(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(16570, 	pUnit:GetMainTank()) 
end

function PrinceRaze_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function PrinceRaze_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(10647, 1, "PrinceRaze_OnCombat")
RegisterUnitEvent(10647, 2, "PrinceRaze_OnLeaveCombat")
RegisterUnitEvent(10647, 4, "PrinceRaze_OnDied")