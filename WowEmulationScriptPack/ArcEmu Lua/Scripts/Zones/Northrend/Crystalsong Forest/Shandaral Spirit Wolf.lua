--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ShandaralSpiritWolf_OnCombat(Unit, Event)
Unit:RegisterEvent("ShandaralSpiritWolf_TendonRip", 8000, 0)
end

function ShandaralSpiritWolf_TendonRip(Unit, Event) 
Unit:FullCastSpellOnTarget(3604, Unit:GetMainTank()) 
end

function ShandaralSpiritWolf_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ShandaralSpiritWolf_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ShandaralSpiritWolf_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(31123, 1, "ShandaralSpiritWolf_OnCombat")
RegisterUnitEvent(31123, 2, "ShandaralSpiritWolf_OnLeaveCombat")
RegisterUnitEvent(31123, 3, "ShandaralSpiritWolf_OnKilledTarget")
RegisterUnitEvent(31123, 4, "ShandaralSpiritWolf_OnDied")