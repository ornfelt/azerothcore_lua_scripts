--KibbleChat v3 --
--by Kibblebit  --
--www.ac-web.org--

local ChatMsg = "#coldchat"

-- KibbleChat
function ChatSystem (event, player, message, type, language)
	if (message:find(ChatMsg.." ") == 1) then
		local text = message:gsub(ChatMsg.." ", "") 
				for k, v in pairs(GetPlayersInWorld()) do
			if (player:GetTeam() == 0) then -- Alliance
			local GMrank = player:GetGmRank()
			if (GMrank == 'az') then
				v:SendBroadcastMessage("|cFF00FFFF[CNA] |cFFFFA500[Admin] |cffffff00["..player:GetName().."]: |cff00ff00"..text.."") -- Admin Tag
			elseif (GMrank == 'a') then
				v:SendBroadcastMessage("|cFF00FFFF[CNA] |cFFFFA500[GM] |cffffff00["..player:GetName().."]: |cff00ff00"..text.."") -- GM Tag
			elseif (GMrank == 'g') then
				v:SendBroadcastMessage("|cFF00FFFF[CNA] |cFFFFA500[Donor] |cffffff00["..player:GetName().."]: |cff00ff00"..text.."") -- Donor Tag
			else 
				v:SendBroadcastMessage("|cFF00FFFF[CNA] |cff00ff00[Alliance] |cffffff00["..player:GetName().."]: |cffD8FFFF"..text.."") -- Ally Tag
			end
			elseif (player:GetTeam() == 1) then -- Horde
			local GMrank = player:GetGmRank()
			if (GMrank == 'az') then
				v:SendBroadcastMessage("|cFF00FFFF[CNA] |cFFFFA500[Admin] |cffffff00["..player:GetName().."]: |cffff0000"..text.."") -- Admin Tag
			elseif (GMrank == 'a') then
				v:SendBroadcastMessage("|cFF00FFFF[CNA] |cFFF665AB[Developer] |cFFCC00CC["..player:GetName().."]: |cff00FF00"..text.."") -- GM Tag
			elseif (GMrank == 'g') then
				v:SendBroadcastMessage("|cFF00FFFF[CNA] |cFFFFA500[Donor] |cffffff00["..player:GetName().."]: |cffff0000"..text.."") -- Donor Tag
			else 
				v:SendBroadcastMessage("|cFF00FFFF[CNA] |cffff0000[Horde] |cffffff00["..player:GetName().."]: |cffFFE2E2"..text.."") -- Horde Tag
			
				end
					end
						end
                                                     return 0
							end
                                                           
								end
-- Commands Functions
function player_OnChat(event, pPlayer, message, type, language)
	if (message == "#commands") then
		pPlayer:SendAreaTriggerMessage("Commands")
		pPlayer:SendAreaTriggerMessage("--------")
		pPlayer:SendAreaTriggerMessage("#c = Sends message to world")
		pPlayer:SendAreaTriggerMessage("#gold = Gives you 100g - NOT!")


	end
end
-- Gold Functions
function gold_OnChat(event, pPlayer, message, type, language)
	if (message == "#gold") then
		pPlayer:DealGoldMerit(1) -- In Copper. Default = 1000000
		pPlayer:SendAreaTriggerMessage("There you go, "..pPlayer:GetName().."! Enjoy!")
	end
end
RegisterServerHook(16, "gold_OnChat")
RegisterServerHook(16, "player_OnChat")
RegisterServerHook(16, "ChatSystem")