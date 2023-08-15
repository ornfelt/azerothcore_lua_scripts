--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function LieutenantTazinni_OnCombat(Unit, Event)
Unit:RegisterEvent("LieutenantTazinni_DragonsBreath", 7000, 0)
Unit:RegisterEvent("LieutenantTazinni_FrostfireBolt", 8000, 0)
end

function LieutenantTazinni_DragonsBreath(Unit, Event) 
Unit:CastSpell(35250) 
end

function LieutenantTazinni_FrostfireBolt(Unit, Event) 
Unit:FullCastSpellOnTarget(51779, Unit:GetMainTank()) 
end

function LieutenantTazinni_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function LieutenantTazinni_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function LieutenantTazinni_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26815, 1, "LieutenantTazinni_OnCombat")
RegisterUnitEvent(26815, 2, "LieutenantTazinni_OnLeaveCombat")
RegisterUnitEvent(26815, 3, "LieutenantTazinni_OnKilledTarget")
RegisterUnitEvent(26815, 4, "LieutenantTazinni_OnDied")