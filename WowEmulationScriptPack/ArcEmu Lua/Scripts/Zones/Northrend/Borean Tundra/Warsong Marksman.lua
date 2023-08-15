--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WarsongMarksman_OnCombat(Unit, Event)
Unit:RegisterEvent("WarsongMarksman_Enrage", 8000, 0)
Unit:RegisterEvent("WarsongMarksman_Shoot", 6000, 0)
end

function WarsongMarksman_Enrage(Unit, Event) 
Unit:CastSpell(8599) 
end

function WarsongMarksman_Shoot(Unit, Event) 
Unit:FullCastSpellOnTarget(45578, Unit:GetMainTank()) 
end

function WarsongMarksman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WarsongMarksman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WarsongMarksman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25244, 1, "WarsongMarksman_OnCombat")
RegisterUnitEvent(25244, 2, "WarsongMarksman_OnLeaveCombat")
RegisterUnitEvent(25244, 3, "WarsongMarksman_OnKilledTarget")
RegisterUnitEvent(25244, 4, "WarsongMarksman_OnDied")