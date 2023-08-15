--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ColdarraSpellweaver_OnCombat(Unit, Event)
Unit:RegisterEvent("ColdarraSpellweaver_ArcaneMissiles", 8000, 0)
end

function ColdarraSpellweaver_ArcaneMissiles(Unit, Event) 
Unit:FullCastSpellOnTarget(34447, Unit:GetMainTank()) 
end

function ColdarraSpellweaver_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ColdarraSpellweaver_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ColdarraSpellweaver_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25722, 1, "ColdarraSpellweaver_OnCombat")
RegisterUnitEvent(25722, 2, "ColdarraSpellweaver_OnLeaveCombat")
RegisterUnitEvent(25722, 3, "ColdarraSpellweaver_OnKilledTarget")
RegisterUnitEvent(25722, 4, "ColdarraSpellweaver_OnDied")