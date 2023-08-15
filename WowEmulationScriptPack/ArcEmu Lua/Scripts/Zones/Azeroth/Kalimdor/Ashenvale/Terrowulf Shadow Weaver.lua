--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TerrowulfShadowWeaver_OnCombat(Unit, Event)
	Unit:RegisterEvent("TerrowulfShadowWeaver_VeilofShadow", 8000, 0)
end

function TerrowulfShadowWeaver_VeilofShadow(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(7068, 	pUnit:GetMainTank()) 
end

function TerrowulfShadowWeaver_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TerrowulfShadowWeaver_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3791, 1, "TerrowulfShadowWeaver_OnCombat")
RegisterUnitEvent(3791, 2, "TerrowulfShadowWeaver_OnLeaveCombat")
RegisterUnitEvent(3791, 4, "TerrowulfShadowWeaver_OnDied")