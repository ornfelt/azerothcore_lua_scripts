local function onKillInRandDung(event, killer, killed)
	if(isCorrectMap(killer)) then
		local roll = math.random(10)
		if(roll == 1)then
			givePlayerDungeonpopup(killer)
		end
	end
end

RegisterPlayerEvent(7,onKillInRandDung)