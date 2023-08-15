function TitleLogin(event, player)

local PlayerName = player:GetName()
local GetPlayerACCT = CharDBQuery("SELECT acct FROM characters WHERE name = '"..PlayerName.."'"):GetColumn(0):GetString()
local GmRank = CharDBQuery("SELECT gm FROM accounts WHERE acct = '"..GetPlayerACCT.."'"):GetColumn(0):GetString()

if not (GmRank == 'az') or (GmRank == 'p2') or (GmRank == 'p3') then


	local PlayerName = player:GetName()
	local GetPlayerGUID = CharDBQuery("SELECT guid FROM characters WHERE name = '"..PlayerName.."'"):GetColumn(0):GetString()
	local title_donate = CharDBQuery("SELECT current_title FROM characters WHERE guide = '"..GetPlayerGUID.."'"):GetColumn(0):GetString()



			player:SetKnownTitle(title_donate)
			CharDBQuery("UPDATE donate SET current_title= '' WHERE guid='"..GetPlayerGUID.."'")
			
end


RegisterServerHook(4, TitleLogin)