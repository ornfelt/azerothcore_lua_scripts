local AIO = AIO or require("AIO")

local Quest = AIO.AddHandlers("Quest", {})

function indexOf(value, list)
	for i,v in ipairs(list) do
		if(value == v)then
			return i
		end
	end
	return 0
end

function len(arr)
	count = 0
	for k,v in pairs(arr) do
	     count = count + 1
	end
	return count
end

function Quest.CompleteQuest(player)
	local qry = WorldDBQuery("SELECT * FROM custom_quest WHERE GUID = "..(player:GetGUIDLow()))
	if(qry ~= nil)then
		local cur = qry:GetUInt32(3)
		local req = qry:GetUInt32(2)
		if(cur >= req)then
			finish_quest(player)
		end
	end
end

function updateQuestProgress(player, amt)
	local qry = WorldDBQuery("SELECT * FROM custom_quest WHERE GUID = "..(player:GetGUIDLow()))
	local cur = qry:GetUInt32(3)
	WorldDBQuery("UPDATE custom_quest SET CurrentCount = "..(cur+amt).." WHERE GUID = "..(player:GetGUIDLow()))
	local item = false
	local req = qry:GetUInt32(2)
	if(qry:GetUInt32(4) == 1)then
		item = true;
	end
	local tar_name = ""
	if(item)then
		tar_name = WorldDBQuery("SELECT name FROM item_template WHERE entry = "..(qry:GetUInt32(1))):GetString(0)
	else
		tar_name = WorldDBQuery("SELECT name FROM creature_template WHERE entry = "..(qry:GetUInt32(1))):GetString(0)
	end
	player:SendAreaTriggerMessage((cur+amt).."/"..(req).." "..tar_name)
	if(cur+amt >= req)then
		player:SendAreaTriggerMessage("Sidequest Complete!")
	end
	open_custom_quest(player)
end

function open_custom_quest(player)
	local qry = WorldDBQuery("SELECT * FROM custom_quest WHERE GUID = "..(player:GetGUIDLow()))
	if(qry ~= nil)then
		local cur = qry:GetUInt32(3)
		local item = false
		local req = qry:GetUInt32(2)
		if(qry:GetUInt32(4) == 1)then
			item = true;
		end
		local tar_name = ""
		if(item)then
			tar_name = WorldDBQuery("SELECT name FROM item_template WHERE entry = "..(qry:GetUInt32(1))):GetString(0)
		else
			tar_name = WorldDBQuery("SELECT name FROM creature_template WHERE entry = "..(qry:GetUInt32(1))):GetString(0)
		end
		local rew_id = qry:GetUInt32(5)
		local rew_amt = qry:GetUInt32(6)
		AIO.Handle(player, "Quest", "ShowFrameQuest", tar_name, cur, req, rew_id, rew_amt)
	end
end

function generate_sidequest(player)
	local near = player:GetUnfriendlyUnitsInRange(500)
	mob = -1;
	iter = 0;
	local isitem = 0;
	local level = 0;
	while(mob == -1)do
		if(iter > 5)then
			break;
		end
		for i,v in ipairs(near) do
			if(math.random(10) == 1 and v:IsTrigger() == false)then
				mob = v:GetEntry();
				level = v:GetLevel()
			end
		end
		iter = iter + 1;
	end
	if(mob > -1)then
		local req = 11 + math.random(18);
		local rew_id = 0;
		local q = WorldDBQuery("SELECT entry,amount FROM custom_quest_drops WHERE creatureId = "..mob.." ORDER BY rand() limit 1")
		if(q ~= nil)then
			rew_id = q:GetUInt32(0)
			local rew_amt = q:GetUInt32(1);
			WorldDBQuery("INSERT INTO custom_quest VALUES ("..(player:GetGUIDLow())..", "..(mob)..", "..(req)..", 0, "..(isitem)..", "..(rew_id)..", "..(rew_amt)..")")
		else
			generate_sidequest(player)
		end
	else
		player:SendBroadcastMessage("Could not find any enemies in your area!")
	end
end

function finish_quest(player)
	local qry = WorldDBQuery("SELECT * FROM custom_quest WHERE GUID = "..(player:GetGUIDLow()))
	local rew = qry:GetUInt32(5);
	local a = qry:GetUInt32(6);
	player:AddItem(rew, a)
	print("ye")
	--player:CastSpell(47292,player)
	WorldDBQuery("DELETE FROM custom_quest WHERE GUID = "..(player:GetGUIDLow()))
	AIO.Handle(player, "Quest", "Close")
	generate_sidequest(player)
	open_custom_quest(player)
end

local function OnCommand(event, player, command)
    if(command == "sidequest") then
		if(WorldDBQuery("SELECT * FROM custom_quest WHERE GUID = "..(player:GetGUIDLow())) == nil) then
			if( player:GetMapId() == 571) then
				generate_sidequest(player)
				open_custom_quest(player)
			end
		else
			open_custom_quest(player)
		end
    end
	if(command == "GMsidequestReset") then
		WorldDBQuery("DELETE FROM custom_quest WHERE GUID = "..(player:GetGUIDLow()))
		generate_sidequest(player)
		open_custom_quest(player)
	end
end

local function onLogout(event, player)
--abandon_sidequest(player)
end

RegisterPlayerEvent(42, OnCommand)
RegisterPlayerEvent(4, onLogout)
