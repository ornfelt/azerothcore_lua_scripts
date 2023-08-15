--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SkymasterBaeric_OnCombat(Unit, Event)
Unit:RegisterEvent("SkymasterBaeric_FieryIntellect", 2000, 1)
end

function SkymasterBaeric_FieryIntellect(Unit, Event) 
Unit:CastSpell(35917) 
end

function SkymasterBaeric_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SkymasterBaeric_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SkymasterBaeric_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(30269, 1, "SkymasterBaeric_OnCombat")
RegisterUnitEvent(30269, 2, "SkymasterBaeric_OnLeaveCombat")
RegisterUnitEvent(30269, 3, "SkymasterBaeric_OnKilledTarget")
RegisterUnitEvent(30269, 4, "SkymasterBaeric_OnDied")