ANN = ANN or {}

function Duel(event, pWinner, pLoser)
	if not ANN[pWinner:GetName()].wins then
		ANN[pWinner:GetName()].wins = 0
		ANN[pWinner:GetName()].wins = ANN[pWinner:GetName()].wins + 1
	end
	local world = GetPlayersInWorld()
	for _, v in pairs(world) do
		if ANN[pWinner:GetName()].wins == < 5 then
		v:SendBroadcastMessage(pWinner:GetName().." has won a dual against "..pLoser:GetName().."")
		elseif ANN[pWinner:GetName()].wins > 5 then
			v:SendBroadcastMessage(pWinner:GetName().." has won a duel against "..pLoser:GetName().." and is on a win streak of ANN[pWinner:GetName()].wins")
		elseif ANN[pWinner:GetName()].wins > 10 then
			v:SendBroadcastMessage(pWinner:GetName().." has won a duel against "..pLoser:GetName().." and is on a win streak of ANN[pWinner:GetName()].wins")
			pWinner:AddItem(TOKEN, TENKILLS)
		elseif ANN[pWinner:GetName()].wins > 15 then
			pWinner:AddItem(TOKEN, FIFTEENKILLS)
			v:SendBroadcastMessage(pWinner:GetName().." has won a duel against "..pLoser:GetName().." and is on a godlike streak!")
			end
	end
	if ANN[pLoser:GetName()].wins > 5 then
		for _,v in pairs(GetPlayersInWorld()) do
			v:SendBroadcastMessage(pWinner:GetName().." has ended "..pLoser:GetName().."' killstreak of ANN[pLoser:GetName()].wins")
			pWinner:AddItem(TOKEN, ENDSTREAK)
			break;
		end
	end
end

RegisterServerHook(30, "Duel")