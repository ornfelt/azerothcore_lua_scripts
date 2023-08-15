function Gnome_OnSpawn(pUnit, event, player)
		local x = pUnit:GetX()
		local map = pUnit:GetMapId()
		local y = pUnit:GetY()
		local z = pUnit:GetZ()
		local o = pUnit:GetO()
		pUnit:SetFaction(35)
		pUnit:SetModel(28714)
		pUnit:Emote(431, 0)
end

function Gnome_OnLeaveCombat(pUnit, event, player)
		pUnit:Despawn(1000, 1)
end

function Gnome_OnDeath(pUnit, event, player)
		pUnit:Despawn(4000, 1)
		pUnit:SpawnCreature(33558,x, y, z, o, 35, 0)
end

function Gnome_OnGossip(pUnit, event, player)
		pUnit:GossipCreateMenu(1, player, 0)
		pUnit:GossipMenuAddItem(1, "Whats up with you?", 1, 0)
		pUnit:GossipMenuAddItem(1, "Nevermind.", 2, 0)
		pUnit:GossipSendMenu(player)
end

function Gnome_OnGossipSelect(pUnit, event, player, id, intid, pmisc)
		if(intid == 1) then
		pUnit:GossipCreateMenu(1, player, 0)
		pUnit:GossipMenuAddItem(1, "Tinkle told me to find you.", 3, 0)
		pUnit:GossipMenuAddItem(1, "Oh ok.", 2, 0)
		pUnit:GossipSendMenu(player)
end

		if(intid == 2) then
		player:GossipComplete()
end
	
		if(intid == 3) then
		pUnit:SendChatMessage(12, 0, "No one can help me... I'm cursed...")
		pUnit:GossipCreateMenu(1, player, 0)
		pUnit:GossipMenuAddItem(1, "Why is that?", 4, 0)
		pUnit:GossipMenuAddItem(1, "Oh I see.", 2, 0)
		pUnit:GossipSendMenu(player)
end

		if(intid == 4) then
		pUnit:SendChatMessage(12, 0, "The rage... it's coming..")
		pUnit:SetModel(24999)
		pUnit:SetFaction(14)
		end
end

RegisterUnitEvent(930022, 2, "Gnome_OnLeaveCombat")
RegisterUnitEvent(930022, 4, "Gnome_OnDeath")
RegisterUnitEvent(930022, 18, "Gnome_OnSpawn")
RegisterUnitGossipEvent(930022, 1, "Gnome_OnGossip")
RegisterUnitGossipEvent(930022, 2, "Gnome_OnGossipSelect")