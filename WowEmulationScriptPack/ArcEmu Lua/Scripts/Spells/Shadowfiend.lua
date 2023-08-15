SHADOW = {}

function SHADOW.fiend(event, pPlayer, SpellId, pSpellObject)
	if(SpellId == 34433) then
		local unit = pPlayer:GetClosestFriend()
			local faction = pPlayer:GetFaction()
			unit:SetFaction(faction)
		        end
end

RegisterServerHook(10, "SHADOW.fiend")
	

	
	
	

