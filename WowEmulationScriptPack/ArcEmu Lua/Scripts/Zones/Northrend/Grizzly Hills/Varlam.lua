--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Varlam_OnCombat(Unit, Event)
Unit:RegisterEvent("Varlam_Cleave", 9000, 0)
Unit:RegisterEvent("Varlam_MortalStrike", 7000, 0)
end

function Varlam_Cleave(Unit, Event) 
Unit:CastSpell(15496) 
end

function Varlam_MortalStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(32736, Unit:GetMainTank()) 
end

function Varlam_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Varlam_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Varlam_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27579, 1, "Varlam_OnCombat")
RegisterUnitEvent(27579, 2, "Varlam_OnLeaveCombat")
RegisterUnitEvent(27579, 3, "Varlam_OnKilledTarget")
RegisterUnitEvent(27579, 4, "Varlam_OnDied")