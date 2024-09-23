-- Settings
local config = require ('!config')-- Need Don't Remove

local luaName = "Reward Point Menu"
local luaNameShort = "RPM_"

local debugON = config.get(luaNameShort.."debugOn")
local enabled = config.get(luaNameShort.."enabled", debugON)
local GossipID = config.get(luaNameShort.."GossipID", debugON)
local ItemEntry = config.get(luaNameShort.."ItemEntry", debugON)
local Item_RewardPoint = config.get("Item_RewardPoint", debugON) -- Global Setting
local Item_HardcoreKey = config.get("Item_HardcoreKey", debugON) -- Global Setting
local msgDelay = config.get(luaNameShort.."msgDelay", debugON)
local NPC_Venders = config.get(luaNameShort.."NPC_Venders", debugON)
local NPC_CheckNear = config.get("NPC_CheckNear", debugON) -- Global Setting

local Make_Bank_SQL = [[ CREATE TABLE IF NOT EXISTS ac_eluna.Reward_points_bank  (
  `Account` int NULL DEFAULT NULL,
  `Points` int NULL DEFAULT NULL,
  `Levels` int NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;;]]
CharDBExecute(Make_Bank_SQL)

--(Start) The Gossip Menu that shows Main Menu
function RewardPointsMenuGossip(event, player)
	player:GossipClearMenu()
	local playerAccount = player:GetAccountId()
	local playerINV = player:GetItemCount(Item_RewardPoint)	
	local playerLeveL = player:GetLevel()
	local query = CharDBQuery(string.format("SELECT * FROM ac_eluna.Reward_points_bank WHERE Account='%i'", playerAccount))	
	if query then
	if tonumber(query:GetString(1)) >= 0 then
		player:GossipMenuAddItem(3, "|cFF008000|TInterface\\Icons\\inv_misc_token_pvp01:45:45:-40|t Reward Points Menu|r", 0, 8) -- Green
	end
	if (player:HasItem(Item_HardcoreKey) == false and tonumber(query:GetString(2)) >= 1) then
		player:GossipMenuAddItem(3, "|cFFA52A2A|TInterface\\Icons\\inv_misc_treasurechest02b:45:45:-40|t Level Bank Menu|r", 0, 4) -- Red
	end
	if playerLeveL >= 10 and player:GetClass() ~= 6 then
		player:GossipMenuAddItem(4, "|cFF0000FF|TInterface\\Icons\\Achievement_Level_60:45:45:-40|t Level Exchange|r", 0, 9) -- Blue
	elseif player:GetClass() ~= 6 then
		player:GossipMenuAddItem(4, "|cFF000080|TInterface\\Icons\\Spell_chargepositive:45:45:-40|t (Cannot Exchange until level 10.)|r", 0, 9999) -- Purple
	else		
		player:GossipMenuAddItem(4, "|cFF000080|TInterface\\Icons\\Spell_chargepositive:45:45:-40|t (Cannot Exchange cause Death Knight.)|r", 0, 9999) -- Purple
	end
	player:GossipMenuAddItem(4, "|TInterface\\Icons\\achievement_bg_hld4bases_eos:45:45:-40|t [Exit Menu]", 0, 9998) -- Yellow

		
	else
		CharDBExecute(string.format("INSERT INTO ac_eluna.Reward_points_bank (Account, Points, Levels) VALUES ('%i', '%i', '%i')", playerAccount, 0, 0))
	end
	player:GossipSendMenu(1, player, GossipID)
	--player:GossipMenuAddItem(4, "|TInterface\\Icons\\Achievement_bg_returnxflags_def_wsg:34|t [Back]", 0, 9999)	
end
--(End)
--(Start) The Gossip Menu that shows Main Menu
local function RewardPointsBankMenuGossip(event, player)
	player:GossipClearMenu()
	local playerAccount = player:GetAccountId()
	local playerINV = player:GetItemCount(Item_RewardPoint)	
	local playerLeveL = player:GetLevel()
	local query = CharDBQuery(string.format("SELECT * FROM ac_eluna.Reward_points_bank WHERE Account='%i'", playerAccount))	
		player:GossipMenuAddItem(4, "|TInterface\\Icons\\inv_misc_token_pvp01:45:45:-40|t Points in Bank: "..query:GetString(1).."", 0, 9999)	
		player:GossipMenuAddItem(4, "|TInterface\\Icons\\inv_misc_token_pvp01:45:45:-40|t Points on You: "..playerINV.."", 0, 9999)
		player:GossipMenuAddItem(4, "|TInterface\\Icons\\Spell_chargepositive:45:45:-40|t Deposit all points to Bank.", 0, 1, false, "Are you sure?")
		player:GossipMenuAddItem(4, "|TInterface\\Icons\\Spell_chargenegative:45:45:-40|t Withdraw points from Bank.", 0, 2, true, "How many points do you want to withdraw?")
		player:GossipMenuAddItem(3, "|TInterface\\Icons\\ability_warrior_rallyingcry:45:45:-40|t Summon Reward Vendors Menu", 0, 10)
	player:GossipMenuAddItem(4, "|TInterface\\Icons\\Achievement_bg_returnxflags_def_wsg:45:45:-40|t [Back]", 0, 9999)	
	player:GossipSendMenu(1, player, GossipID+100)
end
--(End)
--(Start) The Gossip Menu that shows NPC Venders
local function RewardPointsNPCMenuGossip(event, player)
	player:GossipClearMenu()
	for k, v in pairs(NPC_Venders) do
		player:GossipMenuAddItem(3, v[3].." "..v[4], 0, v[1]+100)
	end
	player:GossipMenuAddItem(4, "|TInterface\\Icons\\Achievement_bg_returnxflags_def_wsg:45:45:-40|t [Back]", 0, 8)	
	player:GossipSendMenu(1, player, GossipID+100)
end
--(End)
--(Start)
local function OnSelect(event, player, _, sender, intid, code)
	if player:IsInCombat() then
        return
    end
	
	local x = player:GetX()
	local y = player:GetY()
	local z = player:GetZ()
	local o = player:GetO()
	local map = player:GetMap()
	local mapID = map:GetMapId()
	local areaId = map:GetAreaId( x, y, z )
	
	local playerAccount = player:GetAccountId()
	local playerINV = player:GetItemCount(Item_RewardPoint)
	local query = CharDBQuery(string.format("SELECT * FROM ac_eluna.Reward_points_bank WHERE Account='%i'", playerAccount))	
	local pointsInBank = tonumber(query:GetString(1))
	
	if(intid == 1) then -- Deposit 
		local newAmount = pointsInBank + playerINV
		CharDBExecute(string.format("UPDATE ac_eluna.Reward_points_bank SET Points=%i WHERE Account=%i", newAmount, playerAccount))
		player:RemoveItem(Item_RewardPoint, playerINV)
		player:GossipComplete()
		player:SendBroadcastMessage("|cffff3347Notice: |cff3399FFYou have |cfffca726"..newAmount.." |cff3399FFReward Points in the Bank.")
	end
	
	if(intid == 2) then -- Withdraw
		local code = tonumber(code)
		if code > pointsInBank then
			player:SendBroadcastMessage("|cffff3347Notice: |cff3399FFYou don't that amount of Reward Points in the bank. You have |cfffca726"..pointsInBank.."")
		else
			local newAmount = pointsInBank - code
			CharDBExecute(string.format("UPDATE ac_eluna.Reward_points_bank SET Points=%i WHERE Account=%i", newAmount, playerAccount))
			player:AddItem(Item_RewardPoint, code)
			player:GossipComplete()
			player:SendBroadcastMessage("|cffff3347Notice: |cff3399FFYou have withdrawn |cfffca726"..code.." |cff3399FF from the bank you have |cfffca726"..newAmount.." |cff3399FFleft.")
		end
	end
	
	
	for k, v in pairs(NPC_Venders) do
		if(intid== v[1]+100) then -- Reward Vender
			local Reward_NPC_Vender = player:GetNearestCreature( 80, v[1] )
			local NPC_Vender
			if Reward_NPC_Vender == nil or NPC_CheckNear == false then
				NPC_Vender = player:SpawnCreature( v[1], x+1, y+1, z+0.5, o-3.5, 1, 60000 )
					NPC_Vender:SetFaction(35) -- Set the creature's faction to 35
					NPC_Vender:MoveFollow(player, 2, v[2])
					NPC_Vender:SetLevel(80)
					NPC_Vender:SetMaxHealth(5000000)
					NPC_Vender:SetHealth(5000000)
				else
				player:SendAreaTriggerMessage("|cffff3347Note: |cffffd000"..v[4].." is already nearby!")
			end
			player:GossipComplete()
		end
	end
	
	
	if(intid == 4) then --Back
		LeveLsMenuGossip(event, player)
		return false
	end
	if(intid == 8) then --Redeem
		RewardPointsBankMenuGossip(event, player)
		return false
	end
	if(intid == 9) then --Redeem
		RedeemMenuGossip(event, player)
		return false
	end
	if(intid == 10) then --Redeem
		RewardPointsNPCMenuGossip(event, player)
		return false
	end
	if(intid == 9998) then --Close
		player:SendAreaTriggerMessage("Good Bye!")
		player:GossipComplete()
	end
	if(intid == 9999) then --Back
		RewardPointsMenuGossip(event, player)
		return false
	end
end
--(End)
local function OnUse(event, player, item, target)
	if player:IsInCombat() then
		player:SendBroadcastMessage("You cannot use this item while in combat.")
		return false
	end
	return true
end
local function Check_Bank(eventId, delay, repeats, player)
	local playerAccount = player:GetAccountId()
	local query = CharDBQuery(string.format("SELECT * FROM ac_eluna.Reward_points_bank WHERE Account='%i'", playerAccount))	
	if query then
		player:SendBroadcastMessage("|cffff3347Notice: |cff3399FFYou have |cfffca726"..query:GetString(1).."|cff3399FF Reward Points in the Bank.")
		player:SendBroadcastMessage("|cffff3347Notice: |cff3399FFYou have |cfffca726"..query:GetString(2).."|cff3399FF Levels in the Bank.")
	else
		CharDBExecute(string.format("INSERT INTO ac_eluna.Reward_points_bank (Account, Points, Levels) VALUES ('%i', '%i', '%i')", playerAccount, 0, 0))
	end
end
local function playerLogin_CheckBank(event, player)
	local delayMS = msgDelay * 1000
    player:RegisterEvent(Check_Bank, delayMS, 1, player)
end
if enabled then
RegisterPlayerEvent(3, playerLogin_CheckBank)
RegisterPlayerGossipEvent(GossipID, 2, OnSelect)
RegisterPlayerGossipEvent(GossipID+100, 2, OnSelect)
RegisterItemEvent(ItemEntry, 2, RewardPointsMenuGossip )
RegisterItemEvent(ItemEntry, 2, OnUse )
end
