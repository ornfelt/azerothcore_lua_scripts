local function TransmogTimer(eventId, delay, repeats, player)
	local transmogfind = player:GetCreaturesInRange(10, 190010, 2, 1)
	for p=1,#transmogfind,1 do
		if (transmogfind[p]:GetOwner() == player) then
			transmogfind[p]:AddAura(2000004, transmogfind[p])
			transmogfind[p]:AddAura(2000005, transmogfind[p])
			transmogfind[p]:AddAura(2000006, transmogfind[p])
		end
	end
end


local function TransmogDebuffs(event, player, spell, skipCheck)
	if (spell:GetEntry() ~= 2000007) then
		return false
	end
	
	AwardAchievement(player, 65494)
	local transmogfind = player:GetCreaturesInRange(3, 190010, 2, 1)
	if (transmogfind == nil) then
		return false
	elseif (transmogfind == 0) then
		return false
	else
		player:RegisterEvent(TransmogTimer, 1000, 1)
		return false
	end
end


RegisterPlayerEvent(5, TransmogDebuffs)