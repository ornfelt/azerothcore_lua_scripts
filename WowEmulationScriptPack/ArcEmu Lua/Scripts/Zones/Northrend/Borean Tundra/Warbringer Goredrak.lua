--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WarbringerGoredrak_OnCombat(Unit, Event)
Unit:RegisterEvent("WarbringerGoredrak_ArcaneBlast", 8000, 0)
Unit:RegisterEvent("WarbringerGoredrak_PowerSap", 10000, 0)
end

function WarbringerGoredrak_ArcaneBlast(Unit, Event) 
Unit:FullCastSpellOnTarget(50545, Unit:GetMainTank()) 
end

function WarbringerGoredrak_PowerSap(Unit, Event) 
Unit:FullCastSpellOnTarget(50534, Unit:GetMainTank()) 
end

function WarbringerGoredrak_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WarbringerGoredrak_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WarbringerGoredrak_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25712, 1, "WarbringerGoredrak_OnCombat")
RegisterUnitEvent(25712, 2, "WarbringerGoredrak_OnLeaveCombat")
RegisterUnitEvent(25712, 3, "WarbringerGoredrak_OnKilledTarget")
RegisterUnitEvent(25712, 4, "WarbringerGoredrak_OnDied")