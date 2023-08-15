--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function EnkilahCryptFiend_OnCombat(Unit, Event)
Unit:RegisterEvent("EnkilahCryptFiend_CryptScarabs", 6000, 1)
end

function EnkilahCryptFiend_CryptScarabs(Unit, Event) 
Unit:CastSpell(31600) 
end

function EnkilahCryptFiend_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function EnkilahCryptFiend_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function EnkilahCryptFiend_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25386, 1, "EnkilahCryptFiend_OnCombat")
RegisterUnitEvent(25386, 2, "EnkilahCryptFiend_OnLeaveCombat")
RegisterUnitEvent(25386, 3, "EnkilahCryptFiend_OnKilledTarget")
RegisterUnitEvent(25386, 4, "EnkilahCryptFiend_OnDied")