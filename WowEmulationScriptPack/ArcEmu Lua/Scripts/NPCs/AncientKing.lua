function Gate_OnUse(object, event, player)
	if(player:IsInCombat() == true) then
	player:SendAreaTriggerMessage("Cant use this in combat.")
	else
	player:Teleport(0, -11217.048828, -1719.351929, 3.822803)
	end
end

function Gates_OnUse(object, event, player)
	if(player:HasItem(93000) == false) then
		player:SendBroadcastMessage("|cFFFFFFCCGate Keeper says: You shall not pass "..player:GetName().."!")
	else
		if(player:IsInFront(object) == true) then
			player:Teleport(0, -11226.475586, -1759.845947, 6.292635)
		else
			player:Teleport(0, -11226.475586, -1759.845947, 6.292635)
			end
		end
end

function Yuriv_OnUse(object, event, player)
	if(player:HasItem(93000) == false) then
		player:SendAreaTriggerMessage("You need Relic of the Fallen!")
	else
		player:RemoveItem(93000, 1)
		player:FullCastSpell(25167)
		player:SpawnCreature(700020, -11215.708008, -1787.158569, 4.250812, 0, 35, 0)
		end
end

function Yuriv_OnSpawn(pUnit, event)
	pUnit:EquipWeapons(50672, 50729, 0)
	pUnit:CastSpell(25160)
	pUnit:SendChatMessage(14, 0, "You come to die!")
	pUnit:PlaySoundToSet(13537)
	pUnit:RegisterEvent("Yuriv_GoAttack", 7000, 1)
end

function Yuriv_GoAttack(pUnit, event)
	pUnit:RemoveAura(25160)
	pUnit:SendChatMessage(12, 0, "I spit on you!")
	pUnit:PlaySoundToSet(13538)
	pUnit:RegisterEvent("Yuriv_Attack", 3000, 1)
end

function Yuriv_Attack(pUnit, event)
	pUnit:SetFaction(14)
end

function Yuriv_OnDeath(pUnit, event)
	yurivdeath = 1
	pUnit:RemoveEvents()
end

RegisterGameObjectEvent(177047, 4, "Gate_OnUse")
RegisterGameObjectEvent(177048, 4, "Gates_OnUse")
RegisterGameObjectEvent(700000, 4, "Yuriv_OnUse")
RegisterUnitEvent(700020, 18, "Yuriv_OnSpawn")
RegisterUnitEvent(700020, 4, "Yuriv_OnDeath")