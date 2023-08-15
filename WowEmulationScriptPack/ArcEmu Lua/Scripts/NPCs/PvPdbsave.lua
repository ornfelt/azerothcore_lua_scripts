--[[  PvP Script by Marijnz  Scripts belongs to CNA WoW  wowcna@hotmail.com
]]



function killstats(event, pPlayer, pKiller)

if pPlayer:GetMapId() == 619 and pPlayer:GetZ() >= 65 then

	local PlayerName = pPlayer:GetName()
	local PlayerNameKilled = pKiller:GetName()


	local GetPlayerGUID = CharDBQuery("SELECT guid FROM characters WHERE name = '"..PlayerName.."'"):GetColumn(0):GetString()
	local GetKillerGUID = CharDBQuery("SELECT guid FROM characters WHERE name = '"..PlayerNameKilled.."'"):GetColumn(0):GetString()






	local IsPlayerNil = CharDBQuery("SELECT guid FROM killstats WHERE guid = '"..GetPlayerGUID.."'")
	
		if (IsPlayerNil == nil) then
			CharDBQuery("INSERT INTO killstats VALUES ('"..GetPlayerGUID.."','"..PlayerName.."','0','0')")		
	
		end

	
	local IsKillerNil = CharDBQuery("SELECT guid FROM killstats WHERE guid = '"..GetKillerGUID.."'")
	
		if (IsKillerNil == nil) then
			CharDBQuery("INSERT INTO killstats VALUES ('"..GetKillerGUID.."','"..PlayerNameKilled.."','0','0')")		
	
		end








	PvPkills = CharDBQuery("SELECT kills FROM killstats WHERE guid = '"..GetPlayerGUID.."'"):GetColumn(0):GetString()
	PvPdeaths = CharDBQuery("SELECT deaths FROM killstats WHERE guid = '"..GetKillerGUID.."'"):GetColumn(0):GetString()
 
	PvPkills = PvPkills + 1
	PvPdeaths = PvPdeaths + 1


	CharDBQuery("UPDATE killstats SET kills= '"..PvPkills.."' WHERE guid="..GetPlayerGUID.."")

	CharDBQuery("UPDATE killstats SET deaths= '"..PvPdeaths.."' WHERE guid="..GetKillerGUID.."")


end


end
RegisterServerHook(2, "killstats")