--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function InfiniteChronoMagus_OnCombat(Unit, Event)
Unit:RegisterEvent("InfiniteChronoMagus_ShadowBlast", 9000, 0)
Unit:RegisterEvent("InfiniteChronoMagus_ShadowBolt", 6000, 0)
end

function InfiniteChronoMagus_ShadowBlast(Unit, Event) 
Unit:FullCastSpellOnTarget(38085, Unit:GetMainTank()) 
end

function InfiniteChronoMagus_ShadowBolt(Unit, Event) 
Unit:FullCastSpellOnTarget(9613, Unit:GetMainTank()) 
end

function InfiniteChronoMagus_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function InfiniteChronoMagus_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function InfiniteChronoMagus_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27898, 1, "InfiniteChronoMagus_OnCombat")
RegisterUnitEvent(27898, 2, "InfiniteChronoMagus_OnLeaveCombat")
RegisterUnitEvent(27898, 3, "InfiniteChronoMagus_OnKilledTarget")
RegisterUnitEvent(27898, 4, "InfiniteChronoMagus_OnDied")