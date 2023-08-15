--------------------------------
-- Script By: RakkorZ - ZxOxZ --
--------------------------------

ITEMS = {}

ITEMS.Command = "#additem"

function ITEMS.OnChat(event, player, message, type, language)
	local ItemMessage = message:lower()
		if (ItemMessage:find(ITEMS.Command.." ") == 1) then
			if (player:GetGmRank() == 'a') or (player:GetGmRank() == 'az') then
				ItemsTable = GetWords(ItemMessage:gsub(ITEMS.Command.." ", ""))
					local PlayersInWorld = GetPlayersInWorld()
						for k, v in pairs(PlayersInWorld) do
							local CheckID = WorldDBQuery("SELECT * FROM items WHERE entry = "..ItemsTable[1])
								if (CheckID == nil) then
							player:SendBroadcastMessage("The EntryID is not correct!")
							return 0
								else
							v:AddItem(ItemsTable[1], ItemsTable[2])
							player:SendBroadcastMessage("|CFFFC000FYou have added EntryID: |r"..ItemsTable[1].."|CFFFC000F, Quantity: |r"..ItemsTable[2].."|CFFFC000F to all players inventory!|r")
							return 0
								end
						end
			end
		end
end

--Credits for that function: Grandelf from Ac-Web.

function GetWords(str)
        local ret = {};
        local pos = 0;
        while (true) do
                local word;
                _,pos,word = string.find(str, "^ *([^%s]+) *", pos + 1);
                if (not word) then
                        return ret;
                end
                table.insert(ret, word);
        end
end

RegisterServerHook(16, "ITEMS.OnChat")