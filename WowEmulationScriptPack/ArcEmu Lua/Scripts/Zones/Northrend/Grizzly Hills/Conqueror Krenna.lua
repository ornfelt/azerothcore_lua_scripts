--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ConquerorKrenna_OnCombat(Unit, Event)
Unit:RegisterEvent("ConquerorKrenna_Cleave", 8000, 0)
Unit:RegisterEvent("ConquerorKrenna_Fixate", 10000, 0)
Unit:RegisterEvent("ConquerorKrenna_Pummel", 17000, 0)
Unit:RegisterEvent("ConquerorKrenna_Slam", 12000, 0)
end

function ConquerorKrenna_Cleave(Unit, Event) 
Unit:CastSpell(15284) 
end

function ConquerorKrenna_Fixate(Unit, Event) 
Unit:FullCastSpellOnTarget(34719, Unit:GetMainTank()) 
end

function ConquerorKrenna_Pummel(Unit, Event) 
Unit:FullCastSpellOnTarget(12555, Unit:GetMainTank()) 
end

function ConquerorKrenna_Slam(Unit, Event) 
Unit:FullCastSpellOnTarget(11430, Unit:GetMainTank()) 
end

function ConquerorKrenna_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ConquerorKrenna_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ConquerorKrenna_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27727, 1, "ConquerorKrenna_OnCombat")
RegisterUnitEvent(27727, 2, "ConquerorKrenna_OnLeaveCombat")
RegisterUnitEvent(27727, 3, "ConquerorKrenna_OnKilledTarget")
RegisterUnitEvent(27727, 4, "ConquerorKrenna_OnDied")