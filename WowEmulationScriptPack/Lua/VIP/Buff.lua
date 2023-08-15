local command = "#buff"

local BUFFIDS = {
	[1] = {36880, 48074, 700140,48162}, 
	[2] = {48469, 48170, 700139},
	[3] = {43223, 99695, 257051, 99615, 89906, 700138}     
     }
function VIPbuff(event, player, message, type, language)
	local PaccName = player:GetAccountName()
	if(message:lower() == command) then
		for _, v in ipairs(BUFFIDS[1]) do
				player:AddAura(v, player)
		end
		if(player:HasItem(ACCT["SERVER"].Inventory_Stone)==true) then
			for _, v in ipairs(BUFFIDS[1]) do
				player:AddAura(v, player)
			end
			if((ACCT[PaccName].Vip) > 1)then
				for _, v in ipairs(BUFFIDS[2]) do
					player:AddAura(v, player)
				end
			end	
			if((ACCT[PaccName].Vip) > 2)then
				for _, v in ipairs(BUFFIDS[3]) do
					player:AddAura(v, player)
				end
			end
		return false;
		end
	end
end
RegisterPlayerEvent(18, VIPbuff)
