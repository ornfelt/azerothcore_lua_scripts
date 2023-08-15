function Battleguard(pUnit, Event)
pUnit:RegisterEvent("Lookingforpvpers", 1000, 0)
end

function Lookingforpvpers(pUnit, Event)
local tbl = pUnit:GetInRangeFriends()
	for k,v in pairs(tbl) do
	
		if v:IsInCombat() == true and v:IsPlayerAttacking() == true and v:GetZ() <= 65
		then
		pUnit:Kill(v)
		end
	end

	for k,v in pairs(tbl) do
	
		if  v:GetZ() >= 130
		then
		v:Teleport(619, 544.27, -519.5158, 26.4)
		end
	end

		for k,v in pairs(tbl) do
	
		
	end	


end

RegisterUnitEvent(900031, 18, "Battleguard")


