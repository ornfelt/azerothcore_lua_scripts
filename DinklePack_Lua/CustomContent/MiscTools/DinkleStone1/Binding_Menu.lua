--[[
Name: Binding Menu
Version: 1.5.0
Made by: MadBuffoon
Notes: This adds a menu that you can bind to an location and easily return too. 

		I use Skuly's code to make this work.

]]
local enabled = true
local MenuMenus = true
local GossipID = 9900002

-- Do not change or remove
local Gold = 10000
local GuidN = 0


-- DP Stuff
local BINDSQL = [[ CREATE TABLE IF NOT EXISTS ac_eluna.binding_menu (`entry` int(10) unsigned NOT NULL AUTO_INCREMENT, `CharID` int(10) unsigned,`BindName` varchar(40), `mappId` int(10) unsigned, `xCoord` varchar(12), `yCoord` varchar(12), `zCoord` varchar(12), `orientation` varchar(12) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL, PRIMARY KEY (`entry`) USING BTREE);]]
CharDBExecute(BINDSQL)

--(Start) Pulles for the guid for the player
local function getPlayerCharacterGUID(player)
    local query = CharDBQuery(string.format("SELECT guid FROM characters WHERE name='%s'", player:GetName()))

    if query then 
      local row = query:GetRow()

      return tonumber(row["guid"])
    end

    return nil
  end
--(End)
--(Start) The Gossip Menu that shows Main Menu
function BindMenuGossip(event, player)
	-- Check if the player is in combat
    if player:IsInCombat() then
        return
    end
	GuidN = getPlayerCharacterGUID(player)
	player:GossipClearMenu()
	player:GossipMenuAddItem(3, "|TInterface\\Icons\\Ability_spy:45:45:-40|t Bind List", 0, 1)
	player:GossipMenuAddItem(0, "|TInterface\\Icons\\achievement_bg_killflagcarriers_grabflag_capit:45:45:-40|t Create Bind", 0, 2, true, "Type the name you want to bind this location to.")
	player:GossipMenuAddItem(3, "|TInterface\\Icons\\achievement_bg_captureflag_wsg:45:45:-40|t Delete Bind List |cff00fc19+|rJust opens a list|cff00fc19+|r", 0, 3)
	player:GossipMenuAddItem(4, "|TInterface\\Icons\\Achievement_bg_returnxflags_def_wsg:45:45:-40|t [Back]", 0, 97)
	
	player:GossipSendMenu(1, player, GossipID)
	
	--player:SendBroadcastMessage("|cff5af304enabled> "..tostring(enabled).." \n|cff5af304commandline1> "..tostring(commandline1).." \n|cff5af304MenuMenus> "..tostring(MenuMenus))


end
--(End)
--(Start) The Gossip Menu that shows the Bind List
local function BindListGossip(event, player)
	-- Check if the player is in combat
    if player:IsInCombat() then
        return
    end
	player:GossipClearMenu()
	player:GossipMenuAddItem(3, "|TInterface\\Icons\\Ability_spy:45:45:-40|t Bind List", 0, 1)
		
	local query1 = CharDBQuery(string.format("SELECT BindName FROM ac_eluna.binding_menu WHERE CharID='%i'", GuidN))
	if query1 then
		repeat
			local BindName = query1:GetString(0)
			local entryNumber = CharDBQuery(string.format("SELECT entry FROM ac_eluna.binding_menu WHERE CharID='%i' and BindName='%s'", GuidN, BindName))
			local entryNumber_Use = tonumber(entryNumber:GetInt32(0)) + 100
			player:GossipMenuAddItem(0, "|TInterface\\Icons\\achievement_bg_defendxtowers_av:30:30:-40|t "..BindName.."", 0, entryNumber_Use, false, "Are you sure you want to Use "..BindName.."?")
		until not query1:NextRow()
	end
	
	player:GossipMenuAddItem(4, "|TInterface\\Icons\\Achievement_bg_returnxflags_def_wsg:45:45:-40|t [Back]", 0, 98)
	player:GossipSendMenu(1, player, GossipID)

end
--(End)
--(Start) The Gossip Menu that shows the Bind List to delete
local function BindListGossip_Delete(event, player)
	-- Check if the player is in combat
    if player:IsInCombat() then
        return
    end
	player:GossipClearMenu()
	player:GossipMenuAddItem(3, "|TInterface\\Icons\\Ability_spy:45:45:-40|t Select one to delete", 0, 3)
	
	local query1 = CharDBQuery(string.format("SELECT BindName FROM ac_eluna.binding_menu WHERE CharID='%i'", GuidN))
	if query1 then
		repeat
			local BindName = query1:GetString(0)
			local entryNumber = CharDBQuery(string.format("SELECT entry FROM ac_eluna.binding_menu WHERE CharID='%i' and BindName='%s'", GuidN, BindName))
			local entryNumber_Delete = tonumber(entryNumber:GetInt32(0)) + 100000000
			player:GossipMenuAddItem(0, "|TInterface\\Icons\\achievement_bg_defendxtowers_av:30:30:-40|t "..BindName.."", 0, entryNumber_Delete, false, "Are you sure you want to delete "..BindName.."?")
		until not query1:NextRow()
	end
	
	player:GossipMenuAddItem(4, "|TInterface\\Icons\\Achievement_bg_returnxflags_def_wsg:45:45:-40|t [Back]", 0, 98)
	player:GossipSendMenu(1, player, GossipID)

end
--(End)
--(Start)
local function OnSelect(event, player, _, sender, intid, code)
local PlayerName = player:GetName()
	
	if(intid == 1) then --List
		BindListGossip(event, player)
	end
	if(intid == 2) then --Create Bind		

	local map = player:GetMap()
	local xstring = string.sub(tostring(player:GetX()),1,10)
	local ystring = string.sub(tostring(player:GetY()),1,10)
	local zstring = string.sub(tostring(player:GetZ()),1,10)
	local ostring = string.sub(tostring(player:GetO()),1,10)
	
	local extractedname = tostring(code:gsub('[%p%c]', ''))

	local query = CharDBQuery(string.format("SELECT * FROM ac_eluna.binding_menu WHERE BindName='%s' AND CharID='%i'", extractedname, getPlayerCharacterGUID(player)))		
	
	--New code to check the number of bindings for a character
	local count_query = CharDBQuery(string.format("SELECT COUNT(*) FROM ac_eluna.binding_menu WHERE CharID='%i'", getPlayerCharacterGUID(player)))
	local count = tonumber(count_query:GetInt32(0))
	
	if count < 15 then
		if not query then
		CharDBExecute(string.format("INSERT INTO ac_eluna.binding_menu (BindName, CharID, mappId, xCoord, yCoord, zCoord, orientation) VALUES ('%s', '%s', '%s', '%s', '%s', '%s', '%s')", extractedname, getPlayerCharacterGUID(player), tostring(map:GetMapId()), xstring, ystring, zstring, ostring))
		
		
		player:SendBroadcastMessage("|cff5af304Location saved as |cff3399FF"..extractedname.."|cff5af304 (Use the menu return to this location at any time)|r")
		else
		local query2 = CharDBQuery(string.format("SELECT BindName FROM ac_eluna.binding_menu WHERE BindName='%s' AND CharID='%i'", extractedname, getPlayerCharacterGUID(player)))
		if query2 then
		local mapID = CharDBQuery(string.format("SELECT mappId FROM ac_eluna.binding_menu WHERE BindName='%s' AND CharID='%i'", extractedname, getPlayerCharacterGUID(player)))
		local x = CharDBQuery(string.format("SELECT xCoord FROM ac_eluna.binding_menu WHERE BindName='%s' AND CharID='%i'", extractedname, getPlayerCharacterGUID(player)))
		local y = CharDBQuery(string.format("SELECT yCoord FROM ac_eluna.binding_menu WHERE BindName='%s' AND CharID='%i'", extractedname, getPlayerCharacterGUID(player)))
		local z = CharDBQuery(string.format("SELECT zCoord FROM ac_eluna.binding_menu WHERE BindName='%s' AND CharID='%i'", extractedname, getPlayerCharacterGUID(player)))
		local O = CharDBQuery(string.format("SELECT orientation FROM ac_eluna.binding_menu WHERE BindName='%s' AND CharID='%i'", extractedname, getPlayerCharacterGUID(player)))
		player:SendBroadcastMessage("|cff5af304 Bind location |cff3399FF"..extractedname.."|cff5af304 already exists (|cff3399FFMap|cff5af304:"..mapID:GetString(0).."|cff3399FF X|cff5af304:"..x:GetString(0).."|cff3399FF Y|cff5af304:"..y:GetString(0).."|cff3399FF Z|cff5af304:"..z:GetString(0).."|cff3399FF O|cff5af304:"..O:GetString(0)..")|r")
		player:SendBroadcastMessage("|cff5af304 You must delete it |cff3399FF"..extractedname.."|cff5af304 if you want to use that name .|r")
		end
		
		end		
		BindMenuGossip(event, player)
		--player:GossipComplete()
		else
		player:SendBroadcastMessage("|cffff0000You have reached the maximum number of bindings (15). Please delete one before creating a new bind.|r")
	end
	end
	if(intid == 3) then --Delete Bind
		BindListGossip_Delete(event, player)
	end
	
	if(intid == 97) then --Back
		MenuMenusGossip(event, player)
	end
	if(intid == 98) then --Back
		BindMenuGossip(event, player)
		return false
	end
	if(intid == 99) then --Close
		player:SendAreaTriggerMessage("Good Bye!")
		player:GossipComplete()
	end
	
	local query1 = CharDBQuery(string.format("SELECT BindName FROM ac_eluna.binding_menu WHERE CharID='%i'", GuidN))
	if query1 then
		repeat
			local BindName = query1:GetString(0)
			local entryNumber = CharDBQuery(string.format("SELECT entry FROM ac_eluna.binding_menu WHERE CharID='%i' and BindName='%s'", GuidN, BindName))
			local entryNumber_Use = tonumber(entryNumber:GetInt32(0)) + 100
			local entryNumber_Delete = tonumber(entryNumber:GetInt32(0)) + 100000000
			if(intid == entryNumber_Use) then
				player:SendBroadcastMessage("|cff00cc00Returning to Bind Location |cff3399FF"..BindName.."")
				local query3 = CharDBQuery(string.format("SELECT BindName FROM ac_eluna.binding_menu WHERE BindName='%s' AND CharID='%i'", BindName, getPlayerCharacterGUID(player)))
				if query3 then
					local mapID = CharDBQuery(string.format("SELECT mappId FROM ac_eluna.binding_menu WHERE BindName='%s' AND CharID='%i'", BindName, getPlayerCharacterGUID(player)))
					local x = CharDBQuery(string.format("SELECT xCoord FROM ac_eluna.binding_menu WHERE BindName='%s' AND CharID='%i'", BindName, getPlayerCharacterGUID(player)))
					local y = CharDBQuery(string.format("SELECT yCoord FROM ac_eluna.binding_menu WHERE BindName='%s' AND CharID='%i'", BindName, getPlayerCharacterGUID(player)))
					local z = CharDBQuery(string.format("SELECT zCoord FROM ac_eluna.binding_menu WHERE BindName='%s' AND CharID='%i'", BindName, getPlayerCharacterGUID(player)))
					local o = CharDBQuery(string.format("SELECT orientation FROM ac_eluna.binding_menu WHERE BindName='%s' AND CharID='%i'", BindName, getPlayerCharacterGUID(player)))
		
					player:Teleport( mapID:GetInt32(0), x:GetFloat(0), y:GetFloat(0), z:GetFloat(0)+0.75, o:GetFloat(0) )
				end
				player:GossipComplete()
			end
			if(intid == entryNumber_Delete) then
				player:SendBroadcastMessage("|cff00cc00Deleted Bind |cff3399FF"..BindName.."")
				CharDBQuery(string.format("DELETE FROM ac_eluna.binding_menu WHERE BindName='%s' AND CharID='%i'", BindName, getPlayerCharacterGUID(player)))
				BindMenuGossip(event, player)
				--player:GossipComplete()
			end
		until not query1:NextRow()
	end
end
--(End)


--(Start) Part of start up.
local function BootMSG(eventid, delay, repeats, player)
local mingmrank = 3
local IsGM = (player:GetGMRank() >= mingmrank)
if not GMonly or IsGM then
		if (MenuMenus ~= true) then
		player:SendBroadcastMessage("|cff3399FFYou can open a bind menu by typing |cff00cc00 ."..commandline1.." |cff3399FF in chat.")
		end
	end
end
local firstlogin = false
local function OnFirstLogin(event, player)
	if event == 30 then
	firstlogin = true
	end
	
	player:RegisterEvent(BootMSG, 60000, 1, player)
end
local function OnLogin(event, player)
	if not firstlogin then
	player:RegisterEvent(BootMSG, 20000, 1, player)
	else
	firstlogin = false
	end
end
--(end)


if enabled then
RegisterPlayerEvent(30, OnFirstLogin)
RegisterPlayerEvent(3, OnLogin)
RegisterPlayerGossipEvent(GossipID, 2, OnSelect)
end
