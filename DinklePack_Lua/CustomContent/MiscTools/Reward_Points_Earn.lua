--[[
Name: Reward Points Menu
Version: 1.0.0
Made by: MadBuffoon
Notes: Blank

]]

local enabled = false

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

local function Gain_Points(pointsAdded,newAmount,playerAccount,player)

		CharDBExecute(string.format("UPDATE ac_eluna.Reward_points_bank SET Points=%i WHERE Account=%i", newAmount, playerAccount))
		player:SendBroadcastMessage("|cffff3347Notice: |cff3399FFYou have gain |cfffca726"..pointsAdded.."|cff3399FF Reward Points and have |cfffca726"..newAmount.."|cff3399FF in the Bank.")
end

local function LeveL_Up(event, player, oldLevel)
	--local playerGUID = getPlayerCharacterGUID(player)
	local playerAccount = player:GetAccountId()
	local query = CharDBQuery(string.format("SELECT * FROM ac_eluna.Reward_points_bank WHERE Account='%i'", playerAccount))	
	--local query2 = CharDBQuery(string.format("SELECT level FROM Characters WHERE guid='%i'", playerGUID))
	--local player_LeveL = tonumber(query2:GetString(0))
	local player_LeveL = oldLevel + 1
	local pointsInBank = tonumber(query:GetString(1))
	
	if player_LeveL == 10 then
		local pointsAdded = 10
		local newAmount = pointsInBank + pointsAdded
		Gain_Points(pointsAdded,newAmount,playerAccount,player)
	end
	if player_LeveL == 20 then
		local pointsAdded = 20
		local newAmount = pointsInBank + pointsAdded
		Gain_Points(pointsAdded,newAmount,playerAccount,player)
	end
	if player_LeveL == 30 then
		local pointsAdded = 30
		local newAmount = pointsInBank + pointsAdded
		Gain_Points(pointsAdded,newAmount,playerAccount,player)
	end
	if player_LeveL == 40 then
		local pointsAdded = 40
		local newAmount = pointsInBank + pointsAdded
		Gain_Points(pointsAdded,newAmount,playerAccount,player)
	end
	if player_LeveL == 50 then
		local pointsAdded = 50
		local newAmount = pointsInBank + pointsAdded
		Gain_Points(pointsAdded,newAmount,playerAccount,player)
	end
	if player_LeveL == 60 then
		local pointsAdded = 60
		local newAmount = pointsInBank + pointsAdded
		Gain_Points(pointsAdded,newAmount,playerAccount,player)
	end
end


if enabled then
RegisterPlayerEvent(13, LeveL_Up)
end
