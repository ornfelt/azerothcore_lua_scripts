--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function HighborneLichling_OnCombat(Unit, Event)
	Unit:RegisterEvent("HighborneLichling_FrostArmor", 1000, 2)
	Unit:RegisterEvent("HighborneLichling_Frostbolt", 8000, 0)
end

function HighborneLichling_FrostArmor(pUnit, Event) 
	pUnit:CastSpell(12544) 
end

function HighborneLichling_Frostbolt(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(20822, 	pUnit:GetMainTank()) 
end

function HighborneLichling_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function HighborneLichling_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6117, 1, "HighborneLichling_OnCombat")
RegisterUnitEvent(6117, 2, "HighborneLichling_OnLeaveCombat")
RegisterUnitEvent(6117, 4, "HighborneLichling_OnDied")