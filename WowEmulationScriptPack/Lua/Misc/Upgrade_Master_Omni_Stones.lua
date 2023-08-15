local ID = 180002


function tierUpgradeCheck2(player,tiernum10)

local check100 = false
local check1icon10 = "|TInterface\\icons\\Omni_trinket:25:25:-15:0|t"
if tiernum10 == 1 then
	if player:HasItem(8461591, 2) then
		check100 = true
	end
	elseif tiernum10 == 2 then
	if player:HasItem(8461591, 5) then
		check100 = true
	end
end


if (check100==false) then
	local check1amount10 = player:GetItemCount(8461591)
	localsend10 = ""
	local localsend10 = "You do not have the materials required for this upgrade.\n\n"
	if tiernum10 == 1 then
		if check1amount10 < 2 then
			localsend10 = localsend10 .. check1icon10 .. (2 - check1amount10) .. " Omni Runes\n"
		end
		player:SendBroadcastMessage(localsend10)
		elseif tiernum10 == 2 then
		if check1amount10 < 5 then
			localsend10 = localsend10 .. check1icon10 .. (5 - check1amount10) .. " Omni Runes\n"
		end
		player:SendBroadcastMessage(localsend10)
    end
    else
    return true
end
return false
end

function onGossip10(event, player, unit)

if (player:HasItem(8461591,1)) then
player:GossipMenuAddItem(0,"|cff9700FFCache of Omnipotence|r\n\n|TInterface\\icons\\Omni_trinket:25:25:-15:0|t2 Omni Runes\n\n|cff000000This will |cffff0000Consume|cff000000 the Omni Runes that are provided and provide a cache with |cffff000010%|cff000000 additional chances to obtain ANY Omni Trinket.", 0, 1)
end

if (player:HasItem(8461591,1)) then
player:GossipMenuAddItem(0,"|cff9700FFCache of Rarity|r\n\n|TInterface\\icons\\Omni_trinket:25:25:-15:0|t5 Omni Runes\n\n|cff000000This will |cffff0000Consume|cff000000 the Omni Runes that are provided and provide a cache with |cffff000010%|cff000000 additional rare drop table loot chances.", 0, 2)

end

player:GossipSendMenu(102, unit)

end



function onSelect10(event, player, unit, sender, intid, code, id)

if(intid == 1) then
if(tierUpgradeCheck2(player,1)) then
player:RemoveItem(8461591, 2)
player:AddItem(5599997, 1)
player:GossipComplete()
end
end
if(intid == 2) then
if(tierUpgradeCheck2(player,2)) then
player:RemoveItem(8461591, 5)
player:AddItem(5599998, 1)
player:GossipComplete()
end
end
end

RegisterCreatureGossipEvent(ID, 1, onGossip10)
RegisterCreatureGossipEvent(ID, 2, onSelect10)