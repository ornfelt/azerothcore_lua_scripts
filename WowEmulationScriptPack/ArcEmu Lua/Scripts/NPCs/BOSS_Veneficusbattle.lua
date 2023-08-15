function Veneficus_OnCombat(Unit, Event)
	Unit:SendChatMessage(14, 0, "Trespasser! Rejoin the earth from once you came!")
		Unit:RegisterEvent("Moonfire", 8000, 0)
		Unit:RegisterEvent("Starfire", 13000, 0)
		Unit:RegisterEvent("Hurricane", 22000, 0)
		Unit:RegisterEvent("RootSnare", 18000, 0)
		Unit:RegisterEvent("SpawnEnts", 45000, 0)
end

function Moonfire(Unit, Event)
	Unit:CastSpellOnTarget(67946, Unit:GetClosestPlayer(0))
end

function Starfire(Unit, Event)
	Unit:FullCastSpellOnTarget(67949, Unit:GetRandomPlayer(0))
end

function Hurricane(Unit, Event)
	Unit:CastSpellOnTarget(63272, Unit:GetRandomPlayer(0))
end

function RootSnare(Unit, Event)
	Unit:FullCastSpellOnTarget(65857, Unit:GetRandomPlayer(0))
end

function SpawnEnts(Unit, Event)
	if Unit:GetHealthPct() <= 60 then
	Unit:SendChatMessage(12, 0, "Creatures of the wood! Protect the sanctuary!")
		Unit:SpawnCreature(700011, 204.316, 18.57, 30.9, 2.37, 14, 30000)
		Unit:SpawnCreature(700011, 204.293, 33.194, 31.3, 3.92, 14, 30000)
		Unit:SpawnCreature(700011, 190.270, 32.852, 31.09, 5.47, 14, 30000)
		Unit:SpawnCreature(700011, 189.858, 18.540, 31.33, 0.80, 14, 30000)
end
end

function Veneficus_OnLeaveCombat(Unit, Event)
		Unit:RemoveEvents()
end

function Veneficus_OnKilledTarget(Unit, Event)
	Unit:SendChatMessage(14, 0, "Back to the earth you go!")
end

function Veneficus_OnDied(Unit, Event, Player)
	Unit:SendChatMessage(14, 0, "Mother! I will be with you soon!")
		Unit:RemoveEvents()
		for k,v in pairs(GetPlayersInWorld()) do
	    v:SendBroadcastMessage("" ..Player:GetName().."[" ..Player:GetLevel().. "] has slain " ..Unit:GetName().."!")
	end
end

RegisterUnitEvent(700005,1,"Veneficus_OnCombat")
RegisterUnitEvent(700005,2,"Veneficus_OnLeaveCombat")
RegisterUnitEvent(700005,3,"Veneficus_OnKilledTarget")
RegisterUnitEvent(700005,4,"Veneficus_OnDied")