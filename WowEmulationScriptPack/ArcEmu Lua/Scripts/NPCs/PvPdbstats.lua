--[[  PvP Script by Marijnz  Scripts belongs to CNA WoW  wowcna@hotmail.com
]]







function PvPstats(pGameObject, event, pPlayer)



local PlayerName = pPlayer:GetName()
local GetpPlayerGUID = CharDBQuery("SELECT guid FROM characters WHERE name = '"..PlayerName.."'"):GetColumn(0):GetString()


local i = 0




pGameObject:GossipCreateMenu(370233, pPlayer, 0)
        pGameObject:GossipMenuAddItem(0, "PvP Stats: Kills/Deaths/Ratio", 1, 0)


-- i = CharDBQuery("SELECT MAX(guid) AS i FROM killstats"):GetColumn(0)
			

	
	while (i <= 2500) do

		PvPkills = CharDBQuery("SELECT kills FROM killstats WHERE guid = '"..i.."'")
		PvPdeaths = CharDBQuery("SELECT deaths FROM killstats WHERE guid = '"..i.."'")
 		PvPname = CharDBQuery("SELECT name FROM killstats WHERE guid = '"..i.."'")
		
		

		if (PvPkills ~= nil) then
			PvPkills = PvPkills:GetColumn(0):GetString()
			PvPdeaths = PvPdeaths:GetColumn(0):GetString()
			PvPname = PvPname:GetColumn(0):GetString()


			pGameObject:GossipMenuAddItem(4,PvPname, i, 0)

		elseif (PvPkills ~= nil) then
			pPlayer:SendAreaTriggerMessage("There aren't any statistics yet.")

		end


	i = i+1


	end

pGameObject:GossipSendMenu(pPlayer)

end

function PvPstats_select(pGameObject, event, pPlayer, id, intid, code)


if intid == 1 then
pPlayer:SendAreaTriggerMessage("Please click at a name.")
			
else

		PvPkills = CharDBQuery("SELECT kills FROM killstats WHERE guid = '"..intid.."'"):GetColumn(0):GetString()
		PvPdeaths = CharDBQuery("SELECT deaths FROM killstats WHERE guid = '"..intid.."'"):GetColumn(0):GetString()
 		PvPname = CharDBQuery("SELECT name FROM killstats WHERE guid = '"..intid.."'"):GetColumn(0):GetString()


PvPratio = PvPkills/PvPdeaths




if PvPratio == 0 then
	PvPratio_s = "|cFFFFFFFFlower then |cFFFF3333" ..PvPratio
elseif PvPratio <= 0.5 then
	PvPratio_s = "|cFFFFFFFFof |cFFFF9900" ..PvPratio
elseif PvPratio <= 1 then
	PvPratio_s = "|cFFFFFFFFof |cFFFFFF66" ..PvPratio
elseif PvPratio >= 1.5 then
	PvPratio_s = "|cFFFFFFFFof |cFF66FF33" ..PvPratio
elseif PvPratio >= 1 then
	PvPratio_s = "|cFFFFFFFFof |cFF33FF00" ..PvPratio

end




pPlayer:SendBroadcastMessage(PvPname.. "|cFFFFFFFF has |cFF90EE90" ..PvPkills.. " kills|cFFFFFFFF and |cFFFF0000" ..PvPdeaths.. " deaths|cFFFFFFFF, with a |cFF90EE90K/|cFFFF0000D |cFFFFFFFFRatio "..PvPratio_s) 


end




pGameObject:GossipCreateMenu(370233, pPlayer, 0)
        pGameObject:GossipMenuAddItem(0, "PvP Stats: Kills/Deaths/Ratio", 1, 0)



local i = 0
	
	while (i <= 2500) do

		PvPkills = CharDBQuery("SELECT kills FROM killstats WHERE guid = '"..i.."'")
		PvPdeaths = CharDBQuery("SELECT deaths FROM killstats WHERE guid = '"..i.."'")
 		PvPname = CharDBQuery("SELECT name FROM killstats WHERE guid = '"..i.."'")
		
		

		if (PvPkills ~= nil) then
			PvPkills = PvPkills:GetColumn(0):GetString()
			PvPdeaths = PvPdeaths:GetColumn(0):GetString()
			PvPname = PvPname:GetColumn(0):GetString()


			pGameObject:GossipMenuAddItem(4,PvPname, i, 0)
		end


	i = i+1


	end

pGameObject:GossipSendMenu(pPlayer)








end

RegisterGameObjectEvent(90008, 4, PvPstats)
RegisterGOGossipEvent(90008, 2, PvPstats_select) 