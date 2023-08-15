function Crusaderofold_OnCombat(Unit, Event)
	Unit:SendChatMessage(14, 0, "Halt! Who dares tread through the halls of old?")
	Unit:RegisterEvent("AvengerShield", 8000, 3)
	Unit:RegisterEvent("Cleave", 10000, 0)
	Unit:RegisterEvent("ShieldBash", 12000, 0)
end

function AvengerShield(Unit, Event)
	Unit:FullCastSpellOnTarget(69927, Unit:GetRandomPlayer(0))
end

function Cleave(Unit, Event)
	Unit:FullCastSpellOnTarget(52835, Unit:GetClosestPlayer(0))
end

function ShieldBash(Unit, Event)
	Unit:FullCastSpellOnTarget(70964, Unit:GetClosestPlayer(0))
end

function Crusaderofold_OnLeaveCombat(Unit, Event)
		Unit:RemoveEvents()
end

function Crusaderofold_OnKilledTarget(Unit, Event)
	Unit:SendChatMessage(14, 0, "Die, filth!")
end

function Crusaderofold_OnDied(Unit, Event)
		Unit:RemoveEvents()
end

RegisterUnitEvent(700006,1,"Crusaderofold_OnCombat")
RegisterUnitEvent(700006,2,"Crusaderofold_OnLeaveCombat")
RegisterUnitEvent(700006,3,"Crusaderofold_OnKilledTarget")
RegisterUnitEvent(700006,4,"Crusaderofold_OnDied")