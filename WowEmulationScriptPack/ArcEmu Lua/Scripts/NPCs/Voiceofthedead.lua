function Voiceofthedead_OnSpawn(pUnit, Event)
		if(pUnit:GetMapId() == 33) then
			pUnit:RegisterEvent("Broadcast_Silverpine", 120000, 0)
		else
		pUnit:EventChat(14, 0, "This has been made by the death, and only the dead shall enter.", 50000)
			end
end
	
function Broadcast_Silverpine(pUnit, Event)
		local plrs = GetPlayersInWorld()
			for _,v in pairs(plrs) do
				if(v:GetMapId() == 33) then
					v:SendBroadcastMessage("|cFF00FF00[Silverpine Forest]:|cFF43BFC7 While in Silverpine you can use two player commands: #GetPhase and #Mall.")
					end
		   end
end

RegisterUnitEvent(930003, 18, "Voiceofthedead_OnSpawn")

