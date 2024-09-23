local vendorEntry = 999999
local forgottenSoulID = 500000

local function onTalk(event, player, object)
	if(playerToSpellEffectCache[player:GetGUIDLow()] ~= nil) then
		player:GossipMenuAddItem(100,"                         |TInterface/ICONS/Spell_Arcane_Portalstormwind:75:75|t", 0, 100)
		for i,v in pairs(playerToSpellEffectCache[player:GetGUIDLow()]) do
			player:GossipMenuAddItem( 1,"I would like to sell \n\n[|cffff0000" .. v[5] .. "|r] [" .. v[6] .. "]\n\nValue : |cffff0000100 Echoes|r.\n", v[2], i)
		end
		player:GossipSendMenu( 1, object )
	else
		player:SendBroadcastMessage("You don't have any augments yet! Continue to adventure!")
		player:SendAreaTriggerMessage("You don't have any augments yet! Continue to adventure!")
	end
end

local function onSelect(event, player, object, sender, intid, code, menu_id)
	if(intid ~= 100)then
		player:SendBroadcastMessage("You've just sold |cffff0000" .. playerToSpellEffectCache[player:GetGUIDLow()][intid][5] .. " |rfor 100 Forgotten Echoes.")
		removeSpellConnection(player,sender)
		player:AddItem(forgottenSoulID,100)
		player:GossipComplete()
	else
		player:SendBroadcastMessage("|cffff0000NOTICE |r: This creature is designed so that you can sell off additional augments that you do not wish to store or use. You will be compensated in Forgotten Echoes when utilizing this vendor.")
	end
end

RegisterCreatureGossipEvent( vendorEntry, 1, onTalk )
RegisterCreatureGossipEvent( vendorEntry, 2, onSelect )