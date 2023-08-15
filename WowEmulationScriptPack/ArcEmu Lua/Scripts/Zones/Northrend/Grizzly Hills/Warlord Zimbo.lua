--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WarlordZimbo_OnCombat(Unit, Event)
Unit:RegisterEvent("WarlordZimbo_SkullCrack", 8000, 0)
Unit:RegisterEvent("WarlordZimbo_WarlordRoar", 2000, 1)
end

function WarlordZimbo_SkullCrack(Unit, Event) 
Unit:FullCastSpellOnTarget(3551, Unit:GetMainTank()) 
end

function WarlordZimbo_WarlordRoar(Unit, Event) 
Unit:CastSpell(52283) 
end

function WarlordZimbo_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WarlordZimbo_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WarlordZimbo_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26544, 1, "WarlordZimbo_OnCombat")
RegisterUnitEvent(26544, 2, "WarlordZimbo_OnLeaveCombat")
RegisterUnitEvent(26544, 3, "WarlordZimbo_OnKilledTarget")
RegisterUnitEvent(26544, 4, "WarlordZimbo_OnDied")