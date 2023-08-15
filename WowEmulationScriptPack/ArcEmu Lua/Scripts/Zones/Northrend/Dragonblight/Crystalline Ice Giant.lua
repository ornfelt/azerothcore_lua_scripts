--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function CrystallineIceGiant_OnCombat(Unit, Event)
Unit:RegisterEvent("CrystallineIceGiant_IceStalagmite", 8000, 0)
Unit:RegisterEvent("CrystallineIceGiant_IceBoulder", 5500, 0)
end

function CrystallineIceGiant_IceStalagmite(Unit, Event) 
Unit:FullCastSpellOnTarget(50597, Unit:GetMainTank()) 
end

function CrystallineIceGiant_IceBoulder(Unit, Event) 
Unit:FullCastSpellOnTarget(50588, Unit:GetMainTank()) 
end

function CrystallineIceGiant_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CrystallineIceGiant_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CrystallineIceGiant_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26291, 1, "CrystallineIceGiant_OnCombat")
RegisterUnitEvent(26291, 2, "CrystallineIceGiant_OnLeaveCombat")
RegisterUnitEvent(26291, 3, "CrystallineIceGiant_OnKilledTarget")
RegisterUnitEvent(26291, 4, "CrystallineIceGiant_OnDied")