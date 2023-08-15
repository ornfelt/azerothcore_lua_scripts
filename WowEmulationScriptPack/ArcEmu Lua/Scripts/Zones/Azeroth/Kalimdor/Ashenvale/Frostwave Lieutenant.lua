--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function FrostwaveLieutenant_OnCombat(Unit, Event)
	Unit:RegisterEvent("FrostwaveLieutenant_FrostNova", 10000, 0)
	Unit:RegisterEvent("FrostwaveLieutenant_FrostShock", 8000, 0)
end

function FrostwaveLieutenant_FrostNova(pUnit, Event) 
	pUnit:CastSpell(122) 
end

function FrostwaveLieutenant_FrostShock(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(8056, 	pUnit:GetMainTank()) 
end

function FrostwaveLieutenant_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function FrostwaveLieutenant_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(26116, 1, "FrostwaveLieutenant_OnCombat")
RegisterUnitEvent(26116, 2, "FrostwaveLieutenant_OnLeaveCombat")
RegisterUnitEvent(26116, 4, "FrostwaveLieutenant_OnDied")