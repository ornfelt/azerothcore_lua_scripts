m = WorldDBQuery("SELECT `value` FROM `fortune` LIMIT 1")
Total = m:GetUInt32(0)
MaxTotal = 15000000
local creature = 318830
local items = {
{6460050,1000},
{577777,250000},
{649285,50000},
{544481,25000},
{5509000,75000},
{600016,8000},
}
local spells = {707487}
function onHelloFortune (event, player, object)
	player:GossipMenuAddItem( 2000000,"|TInterface/icons/votingtoken:35|t|cffff0000Total|r : "..Total.." / "..MaxTotal,0,20)
	player:GossipMenuAddItem( 2000000, "|TInterface/icons/INV_Misc_Apexis_Shard:35|t Shazzian Shard", 0, 1, true, "Enter The Amount Of Shazzian You Wish To Donate.\n\nWhen completed, please CLICK accept.\n\n|cffff00001 Shazzian Shard is worth 1,000 points to the pot." )
	player:GossipMenuAddItem( 2000000, "|TInterface/icons/Frostfire Orb:35|t Burden of Eternity", 0, 2, true, "Enter The Amount Of Burdens You Wish To Donate.\n\nWhen completed, please CLICK accept.\n\n|cffff00001 Burden of Eternity is worth 250,000 points to the pot." )
	player:GossipMenuAddItem( 2000000, "|TInterface/icons/Titanforge_Stone:35|t Titanforge Stone", 0, 3, true, "Enter The Amount Of Stones You Wish To Donate.\n\nWhen completed, please CLICK accept.\n\n|cffff00001 Titanforge Stone is worth 50,000 points to the pot." )
	player:GossipMenuAddItem( 2000000, "|TInterface/icons/PlayedTimeToken:35|t Played Time Token", 0, 4, true, "Enter The Amount Of Played Time Tokens You Wish To Donate.\n\nWhen completed, please CLICK accept.\n\n|cffff00001 Played Time Token is worth 25,000 points to the pot." )
	player:GossipMenuAddItem( 2000000, "|TInterface/icons/INV_Elemental_Mote_Shadow01:35|t Paragon Essence", 0, 5, true, "Enter The Amount Of Essences You Wish To Donate.\n\nWhen completed, please CLICK accept.\n\n|cffff00001 Paragon Essence is worth 75,000 points to the pot." )
	player:GossipMenuAddItem( 2000000, "|TInterface/icons/Brawler_Token:35|t Brawl Point", 0, 6, true, "Enter The Amount Of Brawl Points You Wish To Donate.\n\nWhen completed, please CLICK accept.\n\n|cffff00001 Brawl Point is worth 8,000 points to the pot." )
	player:GossipSendMenu(318830,object)	
end

function onSelectFortune(event, player, unit, sender, intid, code, id)
	if(intid == 20) then
		player:SendAreaTriggerMessage("Current Total : "..Total.." / "..MaxTotal)
	else
	local m = WorldDBQuery("SELECT `value` FROM `fortune` LIMIT 1")
	 Total = m:GetUInt32(0)
		tonumber(code)
		if(player:HasItem(items[intid][1],code)) then
			player:RemoveItem(items[intid][1],code)
			Total = Total + (code*items[intid][2])
		else
		player:SendAreaTriggerMessage("You don't have that much to give!")
		end
		if(Total >= MaxTotal) then
			local plrs = GetPlayersInWorld()
			for k, v in pairs(plrs) do
				v:AddAura(spells[math.random(#spells)],v)
				v:SendAreaTriggerMessage("The Well Spills Forth!")
			end
			Total = 0
		end
	end
	WorldDBQuery( "UPDATE `fortune` SET `value` = "..Total..";")
player:GossipComplete()
end

RegisterCreatureGossipEvent( creature, 1, onHelloFortune )
RegisterCreatureGossipEvent( creature, 2, onSelectFortune )