local enabled = true
local GMonly = false  --.xp works opens for GM



local xp01 = "xp 0.1"
local xp02 = "xp 0.2"
local xp03 = "xp 0.3"
local xp04 = "xp 0.4"
local xp05 = "xp 0.5"
local xp06 = "xp 0.6"
local xp07 = "xp 0.7"
local xp08 = "xp 0.8"
local xp09 = "xp 0.9"

local xp1 = "xp 1"
local xp2 = "xp 2"
local xp3 = "xp 3"
local xp4 = "xp 4"
local xp5 = "xp 5"
local xp6 = "xp 6"
local xp7 = "xp 7"
local xp8 = "xp 8"
local xp9 = "xp 9"
local xp10 = "xp 10"
local xpq = "xp ?"
local xpd = "xp reset" -- only gm can use, it will wipe all custom xp rates.



local XPSQL = [[ CREATE TABLE IF NOT EXISTS Custom_XP ( CharID int(10) unsigned NOT NULL, Rate float unsigned NOT NULL DEFAULT 1) ENGINE=InnoDB DEFAULT CHARSET=utf8;]]
WorldDBExecute(XPSQL)

local function getPlayerCharacterGUID(player)
	if player ~= nil then
    query = CharDBQuery(string.format("SELECT guid FROM characters WHERE name='%s'", player:GetName()))
	end

    if query then 
      local row = query:GetRow()

      return tonumber(row["guid"])
    end

    return nil
  end
  
 local function SKULY(eventid, delay, repeats, player)
    player:SendBroadcastMessage("|cff3399FF You can change your XP by typing |cff00cc00 .xp 0.1-0.9 |cff3399FF or |cff00cc00 .xp 1-10 |cff3399FF in chat.")
	player:SendBroadcastMessage("|cff3399FF You can check your current XP rate by typing |cff00cc00 .xp ? |cff3399FF in chat.")
end

local function OnLogin(event, player)
local mingmrank = 3
local PUID = getPlayerCharacterGUID(player)
	if (not GMonly and player:GetGMRank() < mingmrank) then
	player:RegisterEvent(SKULY, 10000, 1, player)
	end	
	
	if (GMonly and player:GetGMRank() >= mingmrank) then
	player:RegisterEvent(SKULY, 10000, 1, player)
	end	
	
	if (GMonly and player:GetGMRank() < mingmrank) then
	WorldDBExecute(string.format("DELETE FROM custom_xp WHERE CharID = %i", PUID))
	end	
	
end 
  
local function GMONLY(player)
 player:SendBroadcastMessage("|cff5af304Only a GM can use this command.|r")
end


local function SetRate(event, player, msg)
--local function SetRate(event, player, message, Type, lang)
local PUID = getPlayerCharacterGUID(player)
if PUID ~= nil then
local Q = WorldDBQuery(string.format("SELECT * FROM custom_xp WHERE CharID=%i", PUID))
end
local mingmrank = 3

		
if msg == xp01 then
if (GMonly and player:GetGMRank() < mingmrank) then
		GMONLY(player)
		return false
		else
WorldDBExecute(string.format("DELETE FROM custom_xp WHERE CharID = %i", PUID))
WorldDBExecute(string.format("INSERT INTO custom_xp VALUES (%i, 0.1)", PUID))
player:SendBroadcastMessage("|cff5af304You changed your XP rate to 0.1x|r")
return false
end
end



if msg == xp02 then
if (GMonly and player:GetGMRank() < mingmrank) then
		GMONLY(player)
		return false
		else
WorldDBExecute(string.format("DELETE FROM custom_xp WHERE CharID = %i", PUID))
WorldDBExecute(string.format("INSERT INTO custom_xp VALUES (%i, 0.2)", PUID))
player:SendBroadcastMessage("|cff5af304You changed your XP rate to 0.2x|r")
return false
end
end


if msg == xp03 then
if (GMonly and player:GetGMRank() < mingmrank) then
		GMONLY(player)
		return false
		else
WorldDBExecute(string.format("DELETE FROM custom_xp WHERE CharID = %i", PUID))
WorldDBExecute(string.format("INSERT INTO custom_xp VALUES (%i, 0.3)", PUID))
player:SendBroadcastMessage("|cff5af304You changed your XP rate to 0.3x|r")
return false
end
end

if msg == xp04 then
if (GMonly and player:GetGMRank() < mingmrank) then
		GMONLY(player)
		return false
		else
WorldDBExecute(string.format("DELETE FROM custom_xp WHERE CharID = %i", PUID))
WorldDBExecute(string.format("INSERT INTO custom_xp VALUES (%i, 0.4)", PUID))
player:SendBroadcastMessage("|cff5af304You changed your XP rate to 0.4x|r")
return false
end
end		
		
		
if msg == xp05 then
if (GMonly and player:GetGMRank() < mingmrank) then
		GMONLY(player)
		return false
		else
WorldDBExecute(string.format("DELETE FROM custom_xp WHERE CharID = %i", PUID))
WorldDBExecute(string.format("INSERT INTO custom_xp VALUES (%i, 0.5)", PUID))
player:SendBroadcastMessage("|cff5af304You changed your XP rate to 0.5x|r")
return false
end
end


if msg == xp06 then
if (GMonly and player:GetGMRank() < mingmrank) then
		GMONLY(player)
		return false
		else
WorldDBExecute(string.format("DELETE FROM custom_xp WHERE CharID = %i", PUID))
WorldDBExecute(string.format("INSERT INTO custom_xp VALUES (%i, 0.6)", PUID))
player:SendBroadcastMessage("|cff5af304You changed your XP rate to 0.6x|r")
return false
end
end

if msg == xp07 then
if (GMonly and player:GetGMRank() < mingmrank) then
		GMONLY(player)
		return false
		else
WorldDBExecute(string.format("DELETE FROM custom_xp WHERE CharID = %i", PUID))
WorldDBExecute(string.format("INSERT INTO custom_xp VALUES (%i, 0.7)", PUID))
player:SendBroadcastMessage("|cff5af304You changed your XP rate to 0.7x|r")
return false
end
end
		
	
if msg == xp08 then
if (GMonly and player:GetGMRank() < mingmrank) then
		GMONLY(player)
		return false
		else
WorldDBExecute(string.format("DELETE FROM custom_xp WHERE CharID = %i", PUID))
WorldDBExecute(string.format("INSERT INTO custom_xp VALUES (%i, 0.8)", PUID))
player:SendBroadcastMessage("|cff5af304You changed your XP rate to 0.8x|r")
return false
end
end

if msg == xp09 then
if (GMonly and player:GetGMRank() < mingmrank) then
		GMONLY(player)
		return false
		else
WorldDBExecute(string.format("DELETE FROM custom_xp WHERE CharID = %i", PUID))
WorldDBExecute(string.format("INSERT INTO custom_xp VALUES (%i, 0.9)", PUID))
player:SendBroadcastMessage("|cff5af304You changed your XP rate to 0.9x|r")
return false
end
end

	
if msg == xp1 then
if (GMonly and player:GetGMRank() < mingmrank) then
		GMONLY(player)
		return false
		else
WorldDBExecute(string.format("DELETE FROM custom_xp WHERE CharID = %i", PUID))
WorldDBExecute(string.format("INSERT INTO custom_xp VALUES (%i, 1)", PUID))
player:SendBroadcastMessage("|cff5af304You changed your XP rate to 1x|r")
return false
end
end

if msg == xp2 then
if (GMonly and player:GetGMRank() < mingmrank) then
		GMONLY(player)
		return false
		else
WorldDBExecute(string.format("DELETE FROM custom_xp WHERE CharID = %i", PUID))
WorldDBExecute(string.format("INSERT INTO custom_xp VALUES (%i, 2)", PUID))
player:SendBroadcastMessage("|cff5af304You changed your XP rate to 2x|r")
return false
end
end

if msg == xp3 then
if (GMonly and player:GetGMRank() < mingmrank) then
		GMONLY(player)
		return false
		else
WorldDBExecute(string.format("DELETE FROM custom_xp WHERE CharID = %i", PUID))
WorldDBExecute(string.format("INSERT INTO custom_xp VALUES (%i, 3)", PUID))
player:SendBroadcastMessage("|cff5af304You changed your XP rate to 3x|r")
return false
end
end

if msg == xp4 then
if (GMonly and player:GetGMRank() < mingmrank) then
		GMONLY(player)
		return false
		else
WorldDBExecute(string.format("DELETE FROM custom_xp WHERE CharID = %i", PUID))
WorldDBExecute(string.format("INSERT INTO custom_xp VALUES (%i, 4)", PUID))
player:SendBroadcastMessage("|cff5af304You changed your XP rate to 4x|r")
return false
end
end

if msg == xp5 then
if (GMonly and player:GetGMRank() < mingmrank) then
		GMONLY(player)
		return false
		else
WorldDBExecute(string.format("DELETE FROM custom_xp WHERE CharID = %i", PUID))
WorldDBExecute(string.format("INSERT INTO custom_xp VALUES (%i, 5)", PUID))
player:SendBroadcastMessage("|cff5af304You changed your XP rate to 5x|r")
return false
end
end

if msg == xp6 then
if (GMonly and player:GetGMRank() < mingmrank) then
		GMONLY(player)
		return false
		else
WorldDBExecute(string.format("DELETE FROM custom_xp WHERE CharID = %i", PUID))
WorldDBExecute(string.format("INSERT INTO custom_xp VALUES (%i, 6)", PUID))
player:SendBroadcastMessage("|cff5af304You changed your XP rate to 6x|r")
return false
end
end

if msg == xp7 then
if (GMonly and player:GetGMRank() < mingmrank) then
		GMONLY(player)
		return false
		else
WorldDBExecute(string.format("DELETE FROM custom_xp WHERE CharID = %i", PUID))
WorldDBExecute(string.format("INSERT INTO custom_xp VALUES (%i, 7)", PUID))
player:SendBroadcastMessage("|cff5af304You changed your XP rate to 7x|r")
return false
end
end

if msg == xp8 then
if (GMonly and player:GetGMRank() < mingmrank) then
		GMONLY(player)
		return false
		else
WorldDBExecute(string.format("DELETE FROM custom_xp WHERE CharID = %i", PUID))
WorldDBExecute(string.format("INSERT INTO custom_xp VALUES (%i, 8)", PUID))
player:SendBroadcastMessage("|cff5af304You changed your XP rate to 8x|r")
return false
end
end

if msg == xp9 then
if (GMonly and player:GetGMRank() < mingmrank) then
		GMONLY(player)
		return false
		else
WorldDBExecute(string.format("DELETE FROM custom_xp WHERE CharID = %i", PUID))
WorldDBExecute(string.format("INSERT INTO custom_xp VALUES (%i, 9)", PUID))
player:SendBroadcastMessage("|cff5af304You changed your XP rate to 9x|r")
return false
end
end

if msg == xp10 then
if (GMonly and player:GetGMRank() < mingmrank) then
		GMONLY(player)
		return false
		else
WorldDBExecute(string.format("DELETE FROM custom_xp WHERE CharID = %i", PUID))
WorldDBExecute(string.format("INSERT INTO custom_xp VALUES (%i, 10)", PUID))
player:SendBroadcastMessage("|cff5af304You changed your XP rate to 10x|r")
return false
end
end

if msg == xpq then
if (GMonly and player:GetGMRank() < mingmrank) then
		GMONLY(player)
		return false
		else

if Q then
local CharID, Rate = Q:GetUInt32(0), Q:GetFloat(1)
 player:SendBroadcastMessage(string.format("|cff5af304Your XP rate is curently set to %.1f|r", Rate))
 return false
 else 
 player:SendBroadcastMessage(string.format("|cff5af304You haven't set a custom rate yet.|r"))
 return false

end

end
end


	
	
if msg == xpd then
if (player:GetGMRank() < mingmrank) then
		GMONLY(player)
		return false
		else
local XPSQLDEL = [[ DROP TABLE IF EXISTS Custom_XP]]
WorldDBExecute(XPSQLDEL)
local XPSQL2 = [[ CREATE TABLE IF NOT EXISTS Custom_XP ( CharID int(10) unsigned NOT NULL, Rate float unsigned NOT NULL DEFAULT 1) ENGINE=InnoDB DEFAULT CHARSET=utf8;]]
WorldDBExecute(XPSQL2)
player:SendBroadcastMessage("|cff5af304You reset XP table|r")
return false
end
end


end
	

local function OnXP(event, player, amount, victim)
local PUID = getPlayerCharacterGUID(player)
local Q = WorldDBQuery(string.format("SELECT * FROM custom_xp WHERE CharID=%i", PUID))
local mingmrank = 3


	if Q then
		local CharID, Rate = Q:GetUInt32(0), Q:GetFloat(1)
		Rate = tonumber(string.format("%.1f", Rate))
		
	

		if (GMonly and player:GetGMRank() < mingmrank) then
					return amount
			end	
			
		if (GMonly and player:GetGMRank() >= mingmrank) then
			return amount * Rate
			end
		
		if (not GMonly) then	
			return amount * Rate
		end
		
	else
	
	return amount
		
		
	end

	
	
	
	
end

if enabled then
RegisterPlayerEvent(3, OnLogin)
RegisterPlayerEvent(12, OnXP)
RegisterPlayerEvent(42, SetRate)
end