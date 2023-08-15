function Malum_OnCombat(Unit, Event)
	Unit:SendChatMessage(14, 0, "I WILL DEVOUR YOUR SOULS!")
	Unit:RegisterEvent("Corruption", 22000, 0)
	Unit:RegisterEvent("LeechingRot", 12000, 0)
	Unit:RegisterEvent("MassFear", 18000, 0)
	Unit:RegisterEvent("SiphonLife", 26000, 0)	
end

function Corruption(Unit, Event)
	Unit:FullCastSpellOnTarget(65810, Unit:GetRandomPlayer(0))
end

function LeechingRot(Unit, Event)
	Unit:FullCastSpellOnTarget(70710, Unit:GetRandomPlayer(0))
end

function MassFear(Unit, Event)
	Unit:FullCastSpellOnTarget(36922, Unit:GetRandomPlayer(0))
end

function SiphonLife(Unit, Event)
	Unit:FullCastSpellOnTarget(41597, Unit:GetRandomPlayer(0))
end

function Malum_OnLeaveCombat(Unit, Event)
		Unit:RemoveEvents()
end

function Malum_OnKilledTarget(Unit, Event)
	Unit:SendChatMessage(14, 0, "Hahaha! Who's next?!")
		Unit:CastSpell(40318)
end

function Malum_OnDied(Unit, Event, Player)
	Unit:SendChatMessage(14, 0, "But... this is impossible! He said we would live forever!")
		Unit:RemoveEvents()
		for k,v in pairs(GetPlayersInWorld()) do
	    v:SendBroadcastMessage("" ..Player:GetName().."[" ..Player:GetLevel().. "] has slain " ..Unit:GetName().."!")
	end
end

RegisterUnitEvent(700003,1,"Malum_OnCombat")
RegisterUnitEvent(700003,2,"Malum_OnLeaveCombat")
RegisterUnitEvent(700003,3,"Malum_OnKilledTarget")
RegisterUnitEvent(700003,4,"Malum_OnDied")