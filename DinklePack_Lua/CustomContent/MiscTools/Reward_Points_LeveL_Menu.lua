--[[
Name: Reward Points Menu
Version: 1.0.0
Made by: MadBuffoon
Notes: Blank

]]

local enabled = true
local GossipID = 9810000
local maxLevels = 60


local Make_Bank_SQL = [[ CREATE TABLE IF NOT EXISTS ac_eluna.Reward_points_bank  (
  `Account` int NULL DEFAULT NULL,
  `Points` int NULL DEFAULT NULL,
  `Levels` int NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;;]]
CharDBExecute(Make_Bank_SQL)

--(Start) The Gossip Menu that shows Main Menu
function LeveLsMenuGossip(event, player)
	player:GossipClearMenu()
	local playerAccount = player:GetAccountId()
	local playerLeveL = player:GetLevel()
	local leftToMax = maxLevels - playerLeveL
	local query = CharDBQuery(string.format("SELECT * FROM ac_eluna.Reward_points_bank WHERE Account='%i'", playerAccount))	
	if query then
		player:GossipMenuAddItem(4, "|TInterface\\Icons\\inv_misc_token_pvp01:45:45:-40|t Levels in Bank: "..query:GetString(2).."", 0, 9999)	
		player:GossipMenuAddItem(4, "|TInterface\\Icons\\inv_misc_token_pvp01:45:45:-40|t You are level: "..playerLeveL.."", 0, 9999)
		--[[
		if playerLeveL >= 10 then
		player:GossipMenuAddItem(4, "|TInterface\\Icons\\Spell_chargepositive:45:45:-40|t Redeem", 0, 9)
		else 
		player:GossipMenuAddItem(4, "|TInterface\\Icons\\Spell_chargepositive:45:45:-40|t Redeem(Can't Redeem until level 10.)", 0, 9999)
		end
		]]
		--player:GossipMenuAddItem(4, "|TInterface\\Icons\\Spell_chargepositive:45:45:-40|t Deposit all levels.", 0, 1, false, "Are you sure?")
		player:GossipMenuAddItem(4, "|TInterface\\Icons\\Spell_chargenegative:45:45:-40|t Withdraw levels.", 0, 2, true, "How many levels do you want to withdraw?\nYou can only level up "..leftToMax.." more")
		player:GossipMenuAddItem(4, "|TInterface\\Icons\\Achievement_bg_returnxflags_def_wsg:45:45:-40|t [Back]", 0, 9998)
	else
		CharDBExecute(string.format("INSERT INTO ac_eluna.Reward_points_bank (Account, Points) VALUES ('%i', '%i', '%i')", playerAccount, 0, 0))
	end
	player:GossipSendMenu(1, player, GossipID)
end
--(End)

local function levelPoints(level)
	local levelPoints = 0
	if level >= 60 then
		levelPoints = math.floor(level * 3.5) -- level 60 = 210 reward points
	else
		levelPoints = math.floor(level * 1.5)  -- level 59 = 88.5 reward points 
	end
	return levelPoints
end

--(Start) The Gossip Menu that shows Main Menu
function RedeemMenuGossip(event, player)
	player:GossipClearMenu()
	local playerAccount = player:GetAccountId()
	local playerLeveL = player:GetLevel()
	local leftToMax = maxLevels - playerLeveL
	local query = CharDBQuery(string.format("SELECT * FROM ac_eluna.Reward_points_bank WHERE Account='%i'", playerAccount))	
	if query then
		local pointsIfRedeemed = levelPoints(player:GetLevel()) -- Calculate potential points if levels were redeemed now
		player:GossipMenuAddItem(4, "|cff0000ff|TInterface\\Icons\\inv_7xp_inscription_talenttome01:45:45:-40|t |r|cffff0000"..pointsIfRedeemed.."|r|cff0000ff Reward Points if Redeemed.|r ", 0, 9)

		player:GossipMenuAddItem(4, "|TInterface\\Icons\\Spell_chargepositive:45:45:-40|t Redeem Levels for Reward Points.", 0, 10, false, "Reward Points\nThis will make you level 1 again.\nAre you sure?")
		player:GossipMenuAddItem(4, "|TInterface\\Icons\\Spell_chargepositive:45:45:-40|t Redeem Levels for Levels in the bank.", 0, 1, false, "Levels in the bank\nThis will make you level 1 again.\nAre you sure?")
		player:GossipMenuAddItem(4, "|TInterface\\Icons\\Achievement_bg_returnxflags_def_wsg:45:45:-40|t [Back]", 0, 9998)
	else
		CharDBExecute(string.format("INSERT INTO ac_eluna.Reward_points_bank (Account, Points) VALUES ('%i', '%i', '%i')", playerAccount, 0, 0))
	end
	player:GossipSendMenu(1, player, GossipID+100)
end

--(End)


--(Start)
local function OnSelect(event, player, _, sender, intid, code)
	if player:IsInCombat() then
        return
    end
	
	local playerAccount = player:GetAccountId()
	local query = CharDBQuery(string.format("SELECT * FROM ac_eluna.Reward_points_bank WHERE Account='%i'", playerAccount))	
	local levelsInBank = tonumber(query:GetString(2))
	local pointsInBank = tonumber(query:GetString(1))
	local playerLeveL = player:GetLevel()
	local leftToMax = maxLevels - playerLeveL
	
	if(intid == 9) then --Redeem
		RedeemMenuGossip(event, player)
		return false
	end
	
	if(intid == 1) then -- Deposit 
		local newAmount = levelsInBank + (playerLeveL - 1)
		local pointsAdded = playerLeveL - 1
		CharDBExecute(string.format("UPDATE ac_eluna.Reward_points_bank SET Levels=%i WHERE Account=%i", newAmount, playerAccount))
		player:SetLevel(1)
		player:GossipComplete()
		player:SendBroadcastMessage("|cffff3347Notice: |cff3399FFYou have gain |cfffca726"..pointsAdded.."|cff3399FF cff3399FFLevels and have |cfffca726"..newAmount.."|cff3399FF in the Bank.")
		kickPlayer(player,5)
	end
	
	if(intid == 2) then -- Withdraw
		local code = tonumber(code)
		if code > levelsInBank then
			player:SendBroadcastMessage("|cffff3347Notice: |cff3399FFYou don't that amount of Reward Points in the bank. You have |cfffca726"..levelsInBank.."")
		else
			if code <= leftToMax then
				local newAmount = levelsInBank - code
				local newLevel = playerLeveL + code
				CharDBExecute(string.format("UPDATE ac_eluna.Reward_points_bank SET Levels=%i WHERE Account=%i", newAmount, playerAccount))			
				player:SetLevel(newLevel)
				player:GossipComplete()
				player:SendBroadcastMessage("|cffff3347Notice: |cff3399FFYou have withdrawn |cfffca726"..code.." |cff3399FF from the bank you have |cfffca726"..newAmount.." |cff3399FFleft.")
			else
				player:SendBroadcastMessage("|cffff3347Notice: |cff3399FFYou Can't over level yourself.")
				LeveLsMenuGossip(event, player)
			end
		end
	end
	
	if(intid == 10) then -- Redeemed Reward Points 
		local pointsAdded = levelPoints(playerLeveL)
		local newAmount = pointsInBank + pointsAdded
		CharDBExecute(string.format("UPDATE ac_eluna.Reward_points_bank SET Points=%i WHERE Account=%i", newAmount, playerAccount))		
		player:SetLevel(1)
		player:GossipComplete()
		player:SendBroadcastMessage("|cffff3347Notice: |cff3399FFYou have gain |cfffca726"..pointsAdded.."|cff3399FF Reward Points and have |cfffca726"..newAmount.."|cff3399FF in the Bank.")		
		kickPlayer(player,5)
	end
	if(intid == 9998) then --Back
		RewardPointsMenuGossip(event, player)
		return false
	end
	
	if(intid == 9999) then --Back
		LeveLsMenuGossip(event, player)
		return false
	end
end
--(End)
if enabled then
RegisterPlayerGossipEvent(GossipID, 2, OnSelect)
RegisterPlayerGossipEvent(GossipID+100, 2, OnSelect)
end
