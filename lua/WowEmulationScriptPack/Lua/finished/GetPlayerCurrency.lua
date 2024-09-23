-- GM command to show player currency in bags
local function GetPlayerCurrency(event, player, command)
	if (command:find("pcurrency") ~= 1) then
		return
	elseif (player:GetGMRank() < ADMIN_RANK) then
		return false
	end

	local target = player:GetSelection()
	if (target == nil) then
		player:SendBroadcastMessage("You must have a target.")
		return false
	elseif (target:ToPlayer() == nil) then
		player:SendBroadcastMessage("You must target a player.")
		return false
	end
	
	auto_string = TranslateCurrency(GetCurrency(target))
	player:SendBroadcastMessage(target:GetName() .. " has " .. auto_string .. ".")
	return false
end

RegisterPlayerEvent(42, GetPlayerCurrency)