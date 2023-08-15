local armorSpellConnection = {--requiredtalent, aura to apply when equiping said piece
	{requiredTalentCloth,clothSpellAura},
	{requiredTalentLeather,leatherSpellAura},
	{requiredTalentMail,mailSpellAura},
	{requiredTalentPlate,plateSpellAura},
}

local function onEquip(event, player, item, bag, slot)--not entirely sure how this would work with whole set swaps
	for i,v in pairs(armorSpellConnection) do--could implement a find in table feature, but eh.
		if(player:HasSpell(v[1])) then
			if(item:GetSubClass() == i) then--i = 1 through 4, which correspond to the subclasses of cloth to plate
				if(player:HasAura(v[2]))then
					local currentAura = player:GetAura(v[2])
					currentAura:SetStackAmount(currentAura:GetStackAmount() + 1)
				else
					player:AddAura(v[2])
				end
			end
		end
	end
end

RegisterPlayerEvent( 29, onEquip )