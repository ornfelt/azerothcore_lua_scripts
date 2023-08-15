function Altor_OnCombat(Unit, Event)
	Unit:SendChatMessage(14, 0, "You dare tread in the Halls of Old?! I'll send you back to your wretched hovels!")
		Unit:RegisterEvent("ThunderClap", 10000, 0)
		Unit:RegisterEvent("ConstrictingChains", 20000, 0)
		Unit:RegisterEvent("CharredEarth", 15000, 0)
end

function ThunderClap(Unit, Event)
	Unit:FullCastSpellOnTarget(56062, Unit:GetRandomPlayer(0))
end

function ConstrictingChains(Unit, Event)
	Unit:FullCastSpellOnTarget(58823, Unit:GetRandomPlayer(0))
end
		
function CharredEarth(Unit, Event)
	Unit:FullCastSpellOnTarget(30129, Unit:GetRandomPlayer(0))
end

function Altor_OnLeaveCombat(Unit, Event)
		Unit:RemoveEvents()
end

function Altor_OnKilledTarget(Unit, Event)
	Unit:SendChatMessage(14, 0, "The price paid for setting foot in the halls of the old gods!")
end

function Altor_OnDied(Unit, Event, Player)
	Unit:SendChatMessage(14, 0, "I have failed. May the creator smite your wretched souls.")
	Unit:RemoveEvents()
		for k,v in pairs(GetPlayersInWorld()) do
	    v:SendBroadcastMessage("" ..Player:GetName().."[" ..Player:GetLevel().. "] has slain " ..Unit:GetName().."!")
	end
end

RegisterUnitEvent(700002,1,"Altor_OnCombat")
RegisterUnitEvent(700002,2,"Altor_OnLeaveCombat")
RegisterUnitEvent(700002,3,"Altor_OnKilledTarget")
RegisterUnitEvent(700002,4,"Altor_OnDied")