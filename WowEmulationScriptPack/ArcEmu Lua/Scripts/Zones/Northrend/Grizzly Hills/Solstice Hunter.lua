--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SolsticeHunter_OnCombat(Unit, Event)
Unit:RegisterEvent("SolsticeHunter_ImmolationTrap", 2000, 1)
Unit:RegisterEvent("SolsticeHunter_MultiShot", 10000, 0)
Unit:RegisterEvent("SolsticeHunter_ScorpidSting", 9000, 0)
Unit:RegisterEvent("SolsticeHunter_SerpentSting", 11000, 0)
Unit:RegisterEvent("SolsticeHunter_Shoot", 6000, 0)
end

function SolsticeHunter_ImmolationTrap(Unit, Event) 
Unit:CastSpell(52606) 
end

function SolsticeHunter_MultiShot(Unit, Event) 
Unit:FullCastSpellOnTarget(14443, Unit:GetMainTank()) 
end

function SolsticeHunter_ScorpidSting(Unit, Event) 
Unit:FullCastSpellOnTarget(52604, Unit:GetMainTank()) 
end

function SolsticeHunter_SerpentSting(Unit, Event) 
Unit:FullCastSpellOnTarget(31975, Unit:GetMainTank()) 
end

function SolsticeHunter_Shoot(Unit, Event) 
Unit:FullCastSpellOnTarget(6660, Unit:GetMainTank()) 
end

function SolsticeHunter_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SolsticeHunter_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SolsticeHunter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26389, 1, "SolsticeHunter_OnCombat")
RegisterUnitEvent(26389, 2, "SolsticeHunter_OnLeaveCombat")
RegisterUnitEvent(26389, 3, "SolsticeHunter_OnKilledTarget")
RegisterUnitEvent(26389, 4, "SolsticeHunter_OnDied")