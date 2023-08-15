--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DragonflayerFlamebinder_OnCombat(Unit, Event)
Unit:RegisterEvent("DragonflayerFlamebinder_FlamePatch", 10000, 0)
Unit:RegisterEvent("DragonflayerFlamebinder_InciteFlames", 7000, 0)
end

function DragonflayerFlamebinder_FlamePatch(Unit, Event) 
Unit:CastSpell(52208) 
end

function DragonflayerFlamebinder_InciteFlames(Unit, Event) 
Unit:FullCastSpellOnTarget(52209, Unit:GetMainTank()) 
end

function DragonflayerFlamebinder_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function DragonflayerFlamebinder_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function DragonflayerFlamebinder_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27259, 1, "DragonflayerFlamebinder_OnCombat")
RegisterUnitEvent(27259, 2, "DragonflayerFlamebinder_OnLeaveCombat")
RegisterUnitEvent(27259, 3, "DragonflayerFlamebinder_OnKilledTarget")
RegisterUnitEvent(27259, 4, "DragonflayerFlamebinder_OnDied")