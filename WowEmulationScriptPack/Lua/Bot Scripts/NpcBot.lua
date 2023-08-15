--[[
Fighting/Buffing/Healing (via spells, melee, ranged combat)  -- yes(script)
Resurrecting -- maybe(on leave combat, get owner, check if dead, cast ress(certain classes(place in their respecitve class script)))
Acting as a guard (when bot has no owner) -- yes
Grouping --no
Dungeons/Raid -- not sure(follow when map change?)
PvP (they can fight members of your opposing faction) -- yes to other faction, not so sure about cross faction stuff
Providing you with consumables (mage, warlock) -- yes - on recruit cast their table/lock rock spell, have gossip option to also recast it(out of combat)(add to their respective script)
Equipping gear -- uhhhhhhhhhhh UI that lets you place items, it takes IDs, stores in database, gets stats from item ,applies hidden aura of stat values to creature(removed on abandon)?
Abilities management -- ??
]]

local botIDs = {1,1,1,1,1,1}   

local function onPlayerLogout(event, player)
	CharDBQuery("DELETE FROM player_bots WHERE Pguid='".. player:GetGUIDLow() .. "';")
end

local function EmptyTableOnShutdown(event)
	CharDBQuery("DELETE FROM player_bots WHERE Pguid > 0;")
end

local function onPlayerCombatEnter(event, player, enemy)
	local Q = WorldDBQuery("SELECT Cid FROM player_bots WHERE Pguid = '" .. player:GetGUIDLow() .. "';")
	local bots = player:GetCreaturesInRange( 20, Q:GetUInt32(0), 2)
	for i,v in pairs(bots)do
		if(v:CanStartAttack( enemy) and v:GetOwnerGUID() == player:GetGUIDLow()) then
			v:AttackStart( enemy)
		end
	end
end

local function onPlayerCombatLeave(event, player) --maybe not needed?
	local Q = WorldDBQuery("SELECT Cid FROM player_bots WHERE Pguid = '" .. player:GetGUIDLow() .. "';")
	local bots = player:GetCreaturesInRange( 60, Q:GetUInt32(0), 2)
	for i,v in pairs(bots)do
		if(v:GetOwnerGUID() == player:GetGUIDLow()) then
			v:MoveFollow( player, 5 )
		end
	end
end

RegisterPlayerEvent( 4, onPlayerLogout)
RegisterServerEvent( 15, EmptyTableOnShutdown)
RegisterPlayerEvent( 33, onPlayerCombatEnter)
RegisterPlayerEvent( 34, onPlayerCombatLeave)

--NOT IN USE ATM
local function CleanTableOnUpdate(event)--code to clean DB while server running(idk how to setup the timed event yet) put on some kind of update function
	local Q = WorldDBQuery("SELECT Cguid,Pguid FROM player_bots")
	local plrs = GetPlayersInWorld()
	local found = false
	if Q then
		repeat
			found = false
			local Cguid, Pguid = Q:GetUInt32(0), Q:GetUInt32(1)
			for i,v in pairs(plrs) do
				if(GetPlayerByGUID(Pguid) == v:GetGUIDLow()) then
					found = true
				end
			end
			if(found)then
				CharDBQuery("DELETE FROM player_bots WHERE Pguid='".. v:GetGUIDLow() .. "';")
			end
		until not Q:NextRow()
	end
end


--eventually get moved to each of the NPCs scripts to be customized(such as spawn lock cookies)
local function onHello(event, player, object)
	player:GossipMenuAddItem( 9, "Follow Me", 0, 1)	
	player:GossipMenuAddItem( 9, "Go Home", 0, 2)
	player:GossipMenuAddItem( 1, "Never Mind", 0, 100)
	player:GossipSendMenu( 1, object)
end

local function onSelect(event, player, object, sender, intid, code, menu_id)
	if(intid == 1) then
		if(object:GetOwnerGUID == 0) then 
		--possibly change its faction?(also on return(intid 2 func))  object:SetFaction( something)
		-- also test setting a pet GUID(might fuck hunters)(would allow the on combat exit/enter for player bot array for loops to instead be player:GetPetGUID())(possible db query for the ID to search for) player:SetPetGUID( object:GetGUIDLow())
			object:MoveFollow( player, 5)
			object:SetOwnerGUID( player:GetGUIDLow())
			CharDBQuery("INSERT INTO player_bots (Pguid, Cguid, Cid)VALUES ('" .. player:GetGUIDLow() .. "','" .. object:GetGUIDLow() .. "','" .. object:GetEntry() .. "');")
		end
	elseif(intid == 2) then
		object:MoveHome()
		--object:SetFaction(35)--change to be a guard?
		CharDBQuery("DELETE FROM player_bots WHERE Pguid='".. object:GetOwnerGUID() .. "';")
		object:SetOwnerGUID(0)
		
	end
	player:GossipComplete()
end

function onBotLeaveCombat(event, creature)
	--[[
	if(GetPlayerByGUID( creature:GetOwnerGUID()):IsDead()) then
		creature:CastSpell( GetPlayerByGUID( creature:GetOwnerGUID()), spell) --possible rez mechanic
	end
	if(!GetPlayerByGUID( creature:GetOwnerGUID()):IsDead()) then
		creature:CastSpell( GetPlayerByGUID( creature:GetOwnerGUID()), spell) --possible buff mechanic(after a fight)
	end
	]]
end

for i,v in pairs(botIDs) do
	RegisterCreatureGossipEvent( v, 1, onHello)
	RegisterCreatureGossipEvent( v, 2, onSelect)
	RegisterCreatureEvent( v, 2, onBotLeaveCombat)
end