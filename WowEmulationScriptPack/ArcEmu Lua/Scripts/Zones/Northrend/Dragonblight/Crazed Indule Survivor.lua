--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function CrazedInduleSurvivor_OnCombat(Unit, Event)
Unit:RegisterEvent("CrazedInduleSurvivor_Crazed", 4000, 1)
Unit:RegisterEvent("CrazedInduleSurvivor_MortalStrike", 7000, 0)
end

function CrazedInduleSurvivor_Crazed(Unit, Event) 
Unit:CastSpell(48139) 
end

function CrazedInduleSurvivor_MortalStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(39171, Unit:GetMainTank()) 
end

function CrazedInduleSurvivor_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CrazedInduleSurvivor_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CrazedInduleSurvivor_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(32409, 1, "CrazedInduleSurvivor_OnCombat")
RegisterUnitEvent(32409, 2, "CrazedInduleSurvivor_OnLeaveCombat")
RegisterUnitEvent(32409, 3, "CrazedInduleSurvivor_OnKilledTarget")
RegisterUnitEvent(32409, 4, "CrazedInduleSurvivor_OnDied")