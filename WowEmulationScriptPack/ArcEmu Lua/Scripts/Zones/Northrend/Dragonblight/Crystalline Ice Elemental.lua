--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function CrystallineIceElemental_OnCombat(Unit, Event)
Unit:RegisterEvent("CrystallineIceElemental_IceSlash", 6000, 0)
end

function CrystallineIceElemental_IceSlash(Unit, Event) 
Unit:FullCastSpellOnTarget(51878, Unit:GetMainTank()) 
end

function CrystallineIceElemental_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CrystallineIceElemental_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CrystallineIceElemental_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26316, 1, "CrystallineIceElemental_OnCombat")
RegisterUnitEvent(26316, 2, "CrystallineIceElemental_OnLeaveCombat")
RegisterUnitEvent(26316, 3, "CrystallineIceElemental_OnKilledTarget")
RegisterUnitEvent(26316, 4, "CrystallineIceElemental_OnDied")