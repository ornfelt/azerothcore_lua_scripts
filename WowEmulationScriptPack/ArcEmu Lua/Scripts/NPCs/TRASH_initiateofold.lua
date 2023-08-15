function initiateofold_OnCombat(Unit, Event)
	Unit:SendChatMessage(14, 0, "Hey! You are not allowed here!")
		Unit:RegisterEvent("IceNova", 16000, 0)
		Unit:RegisterEvent("IceSpike", 10000, 0)
		Unit:RegisterEvent("ArcaneExplosion", 12000, 0)	
end

function IceNova(Unit, Event)
	Unit:FullCastSpellOnTarget(70209, Unit:GetRandomPlayer(0))	
end

function IceSpike(Unit, Event)
	Unit:FullCastSpellOnTarget(61269, Unit:GetRandomPlayer(0))	
end

function ArcaneExplosion(Unit, Event)
	Unit:FullCastSpell(68001)	
end

function initiateofold_OnLeaveCombat(Unit, Event)
		Unit:RemoveEvents()
end

function initiateofold_OnKilledTarget(Unit, Event)
	Unit:SendChatMessage(14, 0, "Hey! I got one! Overhere!")
end

function initiateofold_OnDied(Unit, Event)
	Unit:SendChatMessage(12, 0, "It wasn't supposed to end like this.")
		Unit:RemoveEvents()
end

RegisterUnitEvent(700010,1,"initiateofold_OnCombat")
RegisterUnitEvent(700010,2,"initiateofold_OnLeaveCombat")
RegisterUnitEvent(700010,3,"initiateofold_OnKilledTarget")
RegisterUnitEvent(700010,4,"initiateofold_OnDied")