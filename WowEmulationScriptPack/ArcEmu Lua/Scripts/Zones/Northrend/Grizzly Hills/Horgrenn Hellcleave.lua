--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function HorgrennHellcleave_OnCombat(Unit, Event)
Unit:RegisterEvent("HorgrennHellcleave_IntimidatingRoar", 12000, 1)
Unit:RegisterEvent("HorgrennHellcleave_MortalStrike", 7000, 0)
Unit:RegisterEvent("HorgrennHellcleave_SunderArmor", 6000, 0)
Unit:RegisterEvent("HorgrennHellcleave_Whirlwind", 8000, 0)
end

function HorgrennHellcleave_IntimidatingRoar(Unit, Event) 
Unit:FullCastSpellOnTarget(16508, Unit:GetMainTank()) 
end

function HorgrennHellcleave_MortalStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(39171, Unit:GetMainTank()) 
end

function HorgrennHellcleave_SunderArmor(Unit, Event) 
Unit:FullCastSpellOnTarget(15572, Unit:GetMainTank()) 
end

function HorgrennHellcleave_Whirlwind(Unit, Event) 
Unit:CastSpell(38619) 
end

function HorgrennHellcleave_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function HorgrennHellcleave_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function HorgrennHellcleave_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27718, 1, "HorgrennHellcleave_OnCombat")
RegisterUnitEvent(27718, 2, "HorgrennHellcleave_OnLeaveCombat")
RegisterUnitEvent(27718, 3, "HorgrennHellcleave_OnKilledTarget")
RegisterUnitEvent(27718, 4, "HorgrennHellcleave_OnDied")