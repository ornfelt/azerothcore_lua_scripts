--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function IthrixtheHarvester_OnCombat(Unit, Event)
Unit:RegisterEvent("IthrixtheHarvester_PoisonStinger", 7000, 0)
Unit:RegisterEvent("IthrixtheHarvester_StingerRage", 9000, 0)
Unit:RegisterEvent("IthrixtheHarvester_VenomSpit", 10000, 0)
end

function IthrixtheHarvester_PoisonStinger(Unit, Event) 
Unit:FullCastSpellOnTarget(25748, Unit:GetMainTank()) 
end

function IthrixtheHarvester_StingerRage(Unit, Event) 
Unit:CastSpell(34392) 
end

function IthrixtheHarvester_VenomSpit(Unit, Event) 
Unit:FullCastSpellOnTarget(45592, Unit:GetMainTank()) 
end

function IthrixtheHarvester_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function IthrixtheHarvester_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function IthrixtheHarvester_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25453, 1, "IthrixtheHarvester_OnCombat")
RegisterUnitEvent(25453, 2, "IthrixtheHarvester_OnLeaveCombat")
RegisterUnitEvent(25453, 3, "IthrixtheHarvester_OnKilledTarget")
RegisterUnitEvent(25453, 4, "IthrixtheHarvester_OnDied")