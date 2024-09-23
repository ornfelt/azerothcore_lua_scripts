local timer = 5000 --1000 = 1 second
local giveammount = 1

local ACHSQL = [[ CREATE TABLE IF NOT EXISTS Custom_ACH_TP ( CharID int(10) unsigned NOT NULL, AchievementID int(10) unsigned NOT NULL, Claimed int(10) unsigned NOT NULL) ENGINE=InnoDB DEFAULT CHARSET=utf8;]]
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
  
local function chkforachievements(eventid, delay, repeats, player)
local PUID = getPlayerCharacterGUID(player)
local level = player:GetLevel()
local test = 0

for k,v in pairs(achievementlist) do

local query = WorldDBQuery(string.format("SELECT * FROM Custom_ACH_TP WHERE CharID=%i and AchievementID=%i", PUID, v))
local query2 = WorldDBQuery(string.format("SELECT * FROM Custom_ACH_TP WHERE CharID=%i and AchievementID=%i and Claimed=0", PUID, v))
local hasAchieved = player:HasAchieved(v)


if level >=80 and hasAchieved and not query then
WorldDBExecute(string.format("INSERT INTO Custom_ACH_TP (CharID, AchievementID, Claimed) VALUES (%i, %i, 0)", PUID, v))
end

if level >=80 and query2 then
local freeTalentPointAmt = player:GetFreeTalentPoints()
if query2 then
local rowCount = query2:GetRowCount()
if rowCount >= 1 then

local talentPointAmt2 = freeTalentPointAmt + giveammount
player:SetFreeTalentPoints(talentPointAmt2)
WorldDBExecute(string.format("UPDATE Custom_ACH_TP SET Claimed=1 WHERE CharID=%i and AchievementID=%i", PUID, v))
test = test + 1

end

end
	end

end



if test >= 1 then
local ammount = test * giveammount
player:SendBroadcastMessage(string.format("|cff5af304 "..ammount.." Talents Point(s) given from Achievement.|r"))
player:SendBroadcastMessage(string.format("|cff5af304 Talents Point(s) given from Achievements must be used before next login/quest reward.|r"))
end

end


local function OnLogin(event, player)
	if player ~= nil then
	player:RegisterEvent(chkforachievements, timer, 0, player)
	end
end

RegisterPlayerEvent(3, OnLogin)