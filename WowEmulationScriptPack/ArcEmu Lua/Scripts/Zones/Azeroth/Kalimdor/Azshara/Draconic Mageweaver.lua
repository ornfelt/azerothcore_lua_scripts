--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DraconicMageweaver_OnCombat(Unit, Event)
	Unit:RegisterEvent("DraconicMageweaver_ConeofCold", 11000, 0)
	Unit:RegisterEvent("DraconicMageweaver_Frostbolt", 8000, 0)
end

function DraconicMageweaver_ConeofCold(pUnit, Event) 
	pUnit:CastSpell(12557) 
end

function DraconicMageweaver_Frostbolt(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(9672, 	pUnit:GetMainTank()) 
end

function DraconicMageweaver_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function DraconicMageweaver_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6131, 1, "DraconicMageweaver_OnCombat")
RegisterUnitEvent(6131, 2, "DraconicMageweaver_OnLeaveCombat")
RegisterUnitEvent(6131, 4, "DraconicMageweaver_OnDied")