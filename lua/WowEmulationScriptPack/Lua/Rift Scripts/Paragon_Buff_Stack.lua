function spelly(event, player, spell, skipCheck)
	if(spell:GetEntry() == 707027) then
		if(player:HasAura(706008)) then
			if(player:GetAura(706008):GetStackAmount() == 250) then
				player:RemoveAura(706008)
				player:AddAura(707450,player)
			end
		end
		if(player:HasAura(707450)) then
			if(player:GetAura(707450):GetStackAmount() == 5) then
				player:RemoveAura(707450)
				player:AddAura(707451,player)
			end
		end
		if(player:HasAura(707451)) then
				player:RemoveAura(707450)
				player:RemoveAura(706008)
		end
	end
end
RegisterPlayerEvent( 5, spelly)