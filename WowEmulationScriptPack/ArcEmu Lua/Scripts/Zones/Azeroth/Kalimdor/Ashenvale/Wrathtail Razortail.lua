--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WrathtailRazortail_OnCombat(Unit, Event)
	Unit:RegisterEvent("WrathtailRazortail_PierceArmor", 10000, 0)
	Unit:RegisterEvent("WrathtailRazortail_Thorns", 2000, 2)
end

function WrathtailRazortail_PierceArmor(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6016, 	pUnit:GetMainTank()) 
end

function WrathtailRazortail_Thorns(pUnit, Event) 
	pUnit:CastSpell(782) 
end

function WrathtailRazortail_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WrathtailRazortail_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3712, 1, "WrathtailRazortail_OnCombat")
RegisterUnitEvent(3712, 2, "WrathtailRazortail_OnLeaveCombat")
RegisterUnitEvent(3712, 4, "WrathtailRazortail_OnDied")