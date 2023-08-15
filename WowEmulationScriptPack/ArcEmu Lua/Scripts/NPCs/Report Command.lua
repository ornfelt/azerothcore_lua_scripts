local ChatMsg = "#report"
 
function ReportMessage(event, player, message, type, language)
         if (message:find(ChatMsg.." ") == 1) then
             local Reporter = player:GetName()
                       local Text = message:gsub(ChatMsg.." ", "")
                       local World = GetPlayersInWorld()
                            for _,v in pairs(World) do
                              if(GetPlayer("..Text..") == true) then
				if (v:IsGm() == true) then
					v:SendBroadcastMessage("|cff00ff00Report Channel: ["..Reporter.."] has reported player ["..Text.."].")
				else
					player:SendBroadcastMessage("There is no GM online.")
				end
			else
				player:SendBroadcastMessage("The player you want to report is not online or does not exist.")
                                break
			end
                 end
       end
end
 
RegisterServerHook(16, "ReportMessage")