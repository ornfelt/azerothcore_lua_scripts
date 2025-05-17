local enabled = false
local giveammount = 1
local checktp = "checktp"
local claimtp = "claimtp"


local ACHSQLOLD = [[ DROP TABLE IF EXISTS custom_ach_tp;]]
WorldDBExecute(ACHSQLOLD)

local ACHSQL = [[ CREATE TABLE IF NOT EXISTS custom_ach_talentpoints ( CharID int(10) unsigned NOT NULL, `CharName` varchar(12) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL, AchievementID int(10) unsigned NOT NULL, Claimed int(10) unsigned NOT NULL) ENGINE=InnoDB DEFAULT CHARSET=utf8;]]
WorldDBExecute(ACHSQL)

local achievementlist = {6, 7, 8, 9, 10, 11, 12, 13, 504}



local function getPlayerCharacterGUID(player)
    query = CharDBQuery(string.format("SELECT guid FROM characters WHERE name='%s'", player:GetName()))

    if query then 
      local row = query:GetRow()

      return tonumber(row["guid"])
    end

    return nil
  end
  

local function initcheck(event, player)
local PUID = getPlayerCharacterGUID(player)
local level = player:GetLevel()
local test = 0
local checkID = WorldDBQuery(string.format("SELECT * FROM custom_ach_talentpoints WHERE CharID='%i' AND CharName='%s'", PUID, player:GetName()))

if not checkID then
WorldDBQuery(string.format("DELETE FROM custom_ach_talentpoints WHERE CharID='%i'", PUID))
WorldDBQuery(string.format("DELETE FROM custom_ach_talentpoints WHERE CharName='%s'", player:GetName()))
end

for k,v in pairs(achievementlist) do

local query = WorldDBQuery(string.format("SELECT * FROM custom_ach_talentpoints WHERE CharID='%i' AND CharName='%s' AND AchievementID='%i'", PUID, player:GetName(), v))
local query2 = WorldDBQuery(string.format("SELECT * FROM custom_ach_talentpoints WHERE CharID='%i' AND CharName='%s' AND AchievementID='%i' AND Claimed=0", PUID, player:GetName(), v))
local hasAchieved = player:HasAchieved(v)


if hasAchieved and not query then
WorldDBExecute(string.format("INSERT INTO custom_ach_talentpoints (CharID, CharName, AchievementID, Claimed) VALUES ('%i', '%s', '%i', 0)", PUID, player:GetName(), v))
end

if query2 then
local rowCount = query2:GetRowCount()

if rowCount >= 1 then
test = test + 1

end

end


end



if test >= 1 then
local ammount = test * giveammount
player:SendBroadcastMessage(string.format("|cff5af304 "..ammount.." Talents Point(s)avaibable to be claimed.|r"))
player:SendBroadcastMessage(string.format("|cff5af304 Type .claimtp to claim them now|r"))
player:SendBroadcastMessage(string.format("|cff5af304 If/when you claim them you will need to use all free Talent Points before logging out.|r"))
else
player:SendBroadcastMessage(string.format("|cff5af304 You don't have any Talent Points from Achievements to claim.|r"))
end


end

local function chkforachievements2(event, player)
local PUID = getPlayerCharacterGUID(player)
local level = player:GetLevel()
local test = 0
local checkID = WorldDBQuery(string.format("SELECT * FROM custom_ach_talentpoints WHERE CharID='%i' AND CharName='%s'", PUID, player:GetName()))

if not checkID then
WorldDBQuery(string.format("DELETE FROM custom_ach_talentpoints WHERE CharID='%i'", PUID))
WorldDBQuery(string.format("DELETE FROM custom_ach_talentpoints WHERE CharName='%s'", player:GetName()))
end

for k,v in pairs(achievementlist) do

local query = WorldDBQuery(string.format("SELECT * FROM custom_ach_talentpoints WHERE CharID='%i' AND CharName='%s' AND AchievementID='%i'", PUID, player:GetName(), v))
local query2 = WorldDBQuery(string.format("SELECT * FROM custom_ach_talentpoints WHERE CharID='%i' AND CharName='%s' AND AchievementID='%i' AND Claimed=0", PUID, player:GetName(), v))
local hasAchieved = player:HasAchieved(v)


if hasAchieved and not query then
WorldDBExecute(string.format("INSERT INTO custom_ach_talentpoints (CharID, CharName, AchievementID, Claimed) VALUES ('%i', '%s', '%i', 0)", PUID, player:GetName(), v))
end

if query2 then
local rowCount = query2:GetRowCount()

if rowCount >= 1 then
test = test + 1

end

end


end



if test >= 1 then
local ammount = test * giveammount
player:SendBroadcastMessage(string.format("|cff5af304 "..ammount.." Talents Point(s)avaibable to be claimed.|r"))
player:SendBroadcastMessage(string.format("|cff5af304 Type .claimtp to claim them now|r"))
player:SendBroadcastMessage(string.format("|cff5af304 If/when you claim them you will need to use all free Talent Points before logging out.|r"))
else
initcheck(event, player)

end

end


local function claimchievements(event, player)
local PUID = getPlayerCharacterGUID(player)
local level = player:GetLevel()
local test = 0
local checkID = WorldDBQuery(string.format("SELECT * FROM custom_ach_talentpoints WHERE CharID='%i' AND CharName='%s'", PUID, player:GetName()))

if not checkID then
WorldDBQuery(string.format("DELETE FROM custom_ach_talentpoints WHERE CharID='%i'", PUID))
WorldDBQuery(string.format("DELETE FROM custom_ach_talentpoints WHERE CharName='%s'", player:GetName()))
end

for k,v in pairs(achievementlist) do

local query = WorldDBQuery(string.format("SELECT * FROM custom_ach_talentpoints WHERE CharID='%i' AND CharName='%s' AND AchievementID='%i'", PUID, player:GetName(), v))
local query2 = WorldDBQuery(string.format("SELECT * FROM custom_ach_talentpoints WHERE CharID='%i' AND CharName='%s' AND AchievementID='%i' AND Claimed=0", PUID, player:GetName(), v))
local hasAchieved = player:HasAchieved(v)


if hasAchieved and not query then
WorldDBExecute(string.format("INSERT INTO custom_ach_talentpoints (CharID, CharName, AchievementID, Claimed) VALUES ('%i', '%s', '%i', 0)", PUID, player:GetName(), v))
end

if query2 then
local freeTalentPointAmt = player:GetFreeTalentPoints()
local rowCount = query2:GetRowCount()

if rowCount >= 1 then

local talentPointAmt2 = freeTalentPointAmt + giveammount
player:SetFreeTalentPoints(talentPointAmt2)
WorldDBExecute(string.format("UPDATE custom_ach_talentpoints SET Claimed=1 WHERE CharID=%i AND CharName='%s' AND AchievementID=%i", PUID, player:GetName(), v))
test = test + 1

end

end


end



if test >= 1 then
local ammount = test * giveammount
player:SendBroadcastMessage(string.format("|cff3399FF "..ammount.." Talents Point(s) Claimed.|r"))
player:SendBroadcastMessage(string.format("|cff3399FF Please make sure to use them before logging out.|r"))
else
player:SendBroadcastMessage(string.format("|cff5af304 You don't have any Talent Points from Achievements to claim.|r"))
end
end

local function PlrMenu(event, player, message, Type, lang)
	
	if (message:lower() == checktp) then		
		chkforachievements2(event, player)
		return false
	end
	
	if (message:lower() == claimtp) then		
		claimchievements(event, player)
		return false
	end
end

if enabled then
RegisterPlayerEvent(3, chkforachievements2) --login
RegisterPlayerEvent(13, chkforachievements2) --level change
RegisterPlayerEvent(28, chkforachievements2) --map change
RegisterPlayerEvent(42, PlrMenu)
end