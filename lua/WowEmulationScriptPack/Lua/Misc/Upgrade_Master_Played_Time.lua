local ID = 180001


function tierUpgradeCheck1(player,tiernum1)
--print(player:GetClassAsString(0))
local check10 = false
local check1icon1 = "|TInterface\\icons\\PlayedTimeCache:25:25:-15:0|t"
if tiernum1 == 1 then
	if player:HasItem(559999, 10) then
		check10 = true
	end
end
--print(check10)

if (check10==false) then
	local check1amount1 = player:GetItemCount(559999)
	localsend1 = ""
	local localsend1 = "You do not have the materials required for this upgrade.\n\n"
	if tiernum1 == 1 then
		if check1amount1 < 10 then
			localsend1 = localsend1 .. check1icon1 .. (10 - check1amount1) .. " Played Time Caches\n"
		end
		player:SendBroadcastMessage(localsend1)
    end
    else
    return true
end
return false
end

function onGossip1(event, player, unit)
--Played Time Reward Cache
if (player:HasItem(559999,1)) then
player:GossipMenuAddItem(0,"|cff9700FFSuperior Played Time Cache|r\n\n|TInterface\\icons\\PlayedTimeCache:25:25:-15:0|t10 Played Time Caches\n\n|cff000000This upgrade will |cffff0000DECREASE|cff000000 the overall rewards of your played time reward cache and grant |cffff00001%|cff000000 additional rare drop table loot chances.", 0, 1)

end

if (player:HasItem(559999,1)) then
player:GossipMenuAddItem(0,"|cff9700FFCache of Rarity|r\n\n|TInterface\\icons\\PlayedTimeCache:25:25:-15:0|t10 Played Time Caches\n\n|cff000000This upgrade will |cffff0000REMOVE|cff000000 the overall rewards of your played time reward cache and grant |cffff0000100%|cff000000 additional rare drop table loot chances.", 0, 2)

end

if (player:HasItem(559999,1)) then
player:GossipMenuAddItem(0,"|cff9700FFBurden of Eternity|r\n\n|TInterface\\icons\\PlayedTimeCache:25:25:-15:0|t10 Played Time Caches\n\n|cff000000This will exchange 10 played time reward caches for 1 Burden of Eternity.", 0, 2)

end
--Played Time Reward Cache END

player:GossipSendMenu(101, unit)

end



function onSelect1(event, player, unit, sender, intid, code, id)
--Paladin Helmet Mastery
if(intid == 1) then
if(tierUpgradeCheck1(player,1)) then
player:RemoveItem(559999, 10)
player:AddItem(5599999, 1)
player:GossipComplete()
end
end
if(intid == 2) then
if(tierUpgradeCheck1(player,1)) then
player:RemoveItem(559999, 10)
player:AddItem(5599998, 1)
player:GossipComplete()
end
end
if(intid == 3) then
if(tierUpgradeCheck1(player,1)) then
player:RemoveItem(559999, 10)
player:AddItem(577777, 1)
player:GossipComplete()
end
end
end

RegisterCreatureGossipEvent(ID, 1, onGossip1)
RegisterCreatureGossipEvent(ID, 2, onSelect1)