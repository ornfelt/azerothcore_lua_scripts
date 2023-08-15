local randomItemEntry = 100000

local classToSubClass = {
	4,--classID 1
	4,--classID 2
	3,--classID 3
	2,--classID 4
	1,--classID 5
	4,--classID 6
	3,--classID 7
	1,--classID 8
	1,--classID 9
	1,--classID 10(unused)
	2--classID 11
}

local function chooseItemType(player)
	local typeChoice = math.random(8)
	if(typeChoice == 8 ) then--weapon
		local chance = math.random(20)
		local subclass = 0
		if chance == 10 then
			subclass = 10
		elseif(chance > 10) then
			subclass = math.random(5)+14
		else
			subclass = math.random(9)-1
		end
		local Q = WorldDBQuery("SELECT `entry` FROM `item_template` WHERE `RequiredLevel` > " .. (player:GetLevel()-3) .. " AND `RequiredLevel` < " .. (player:GetLevel()+3) .. " AND `Quality` > 1  AND `Quality` < 6 AND `class` = 2 AND `subclass` = " .. subclass .. " ORDER BY RAND() LIMIT 1")
		if Q then
			repeat
				return Q:GetUInt32(0)
			until not Q:NextRow()
		end
	else
		local chancer = math.random(15)
		local subclassID = 0
		if(chancer > 2) then
			subclassID = classToSubClass[player:GetClass()]	
		end
		local Q = WorldDBQuery("SELECT `entry` FROM `item_template` WHERE `RequiredLevel` > " .. (player:GetLevel()-3) .. " AND `RequiredLevel` < " .. (player:GetLevel()+3) .. " AND `Quality` > 1  AND `Quality` < 6 AND `class` = 4 AND `subclass` = " .. subclassID .. " ORDER BY RAND() LIMIT 1")
		if Q then
			repeat
				return Q:GetUInt32(0)
			until not Q:NextRow()
		end
	end
end

function giveRandomItem(event, player)--opt = item option ID starting at 0
    if player:GetLevel() <= 100 then
        if(player:HasItem(randomItemEntry)) then
            local currentItemEntry = chooseItemType(player)
            if(currentItemEntry == nil) then
                giveRandomItem(event, player)
            end
            player:RemoveItem(randomItemEntry,1)--removes the blank item entry
            local addedItem = player:AddItem(currentItemEntry,1)
            OnLoot(1, player, addedItem, 1)
        end
    else
        player:SendBroadcastMessage( "you're too high of a level. fucking trash no lifing a alpha server1")
    end
end

local Q = WorldDBQuery("SELECT `id` FROM `creature_questender`")
local questlist = {}
if Q then
    repeat
    local entryval = Q:GetUInt32(0)
        questlist[entryval] = entryval
    until not Q:NextRow()
    for i,v in pairs(questlist) do
        RegisterCreatureEvent( v, 34, giveRandomItem )
    end
end