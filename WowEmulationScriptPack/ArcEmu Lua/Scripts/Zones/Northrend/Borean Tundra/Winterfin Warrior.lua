--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WinterfinWarrior_OnCombat(Unit, Event)
Unit:RegisterEvent("WinterfinWarrior_DemoralizingMmmrrrggglll", 8000, 0)
end

function WinterfinWarrior_DemoralizingMmmrrrggglll(Unit, Event) 
Unit:CastSpell(50267) 
end

function WinterfinWarrior_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WinterfinWarrior_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WinterfinWarrior_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25217, 1, "WinterfinWarrior_OnCombat")
RegisterUnitEvent(25217, 2, "WinterfinWarrior_OnLeaveCombat")
RegisterUnitEvent(25217, 3, "WinterfinWarrior_OnKilledTarget")
RegisterUnitEvent(25217, 4, "WinterfinWarrior_OnDied")