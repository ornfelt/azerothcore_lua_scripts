function Sanctus_OnCombat(Unit, Event)
	Unit:SendChatMessage(14, 0, "Oh sad soul. I prity thee for the acts to come!")
		Unit:RegisterEvent("HolyNova", 15000, 0)
		Unit:RegisterEvent("DivineChain", 20000, 0)
		Unit:RegisterEvent("HolyFire", 25000, 0)
		Unit:RegisterEvent("BlastWave", 30000, 0)
		Unit:RegisterEvent("SpawnSentry", 1000, 1)	
end

function HolyNova(Unit, Event)
	Unit:FullCastSpell(67290)
end

function DivineChain(Unit, Event)
	Unit:FullCastSpellOnTarget(64215, Unit:GetRandomPlayer(0))
end

function HolyFire(Unit, Event)
	Unit:CastSpellOnTarget(67676, Unit:GetRandomPlayer(0))
end

function BlastWave(Unit, Event)
	Unit:FullCastSpell(30600)
end

function SpawnSentry(Unit, Event)
	if Unit:GetHealthPct() < 60 then
		Unit:SendChatMessage(14, 0, "Sentrys of Old! Come to my aid!")
			Unit:SpawnCreature(700012, 241.933, -100, 23.78, 6.25, 14, 30000)
			Unit:SpawnCreature(700012, 258.03, -112.59, 18.68, 1.78, 14, 30000)
			Unit:SpawnCreature(700012, 258.99, -87.47, 18.68, 4.43, 14, 30000)
			Unit:SpawnCreature(700012, 268.186, -100.479, 18.68, 3.1, 14, 30000)
end
end

function Sanctus_OnLeaveCombat(Unit, Event)
		Unit:RemoveEvents()
end

function Sanctus_OnKilledTarget(Unit, Event)
	Unit:SendChatMessage(14, 0, "A lost life, but for what cause?!")
end

function Sanctus_OnDied(Unit, Event, Player)
	Unit:SendChatMessage(14, 0, "May the maker shine upon this day.")
		Unit:RemoveEvents()
		for k,v in pairs(GetPlayersInWorld()) do
	    v:SendBroadcastMessage("" ..Player:GetName().."[" ..Player:GetLevel().. "] has slain " ..Unit:GetName().."!")
	end
end

RegisterUnitEvent(700004,1,"Sanctus_OnCombat")
RegisterUnitEvent(700004,2,"Sanctus_OnLeaveCombat")
RegisterUnitEvent(700004,3,"Sanctus_OnKilledTarget")
RegisterUnitEvent(700004,4,"Sanctus_OnDied")