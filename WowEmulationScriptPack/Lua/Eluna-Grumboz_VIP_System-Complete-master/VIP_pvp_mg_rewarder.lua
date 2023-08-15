-- idea from Black Wolf
-- Rochet2 of ac-web.org proofread then reworked it to function
-- Thank you Rochet2 for all your help
-- PVP reward system. player gets awarded 3 mg per kill plus a bonus mg count equal to the vip level (1-VIPMAX) of the victim ROUGH DRAFT

function GrantPvPReward(event, killer, killed)

	if (killer:GetTeam())~=(killed:GetTeam()) then
	
        UpdatePvpReward(killer, killed)
        
			if (killer:GetMapId()==489) then killer:AddItem(20558, math.random(1, 3)) end;
	end
end
 
RegisterPlayerEvent(6, GrantPvPReward)

print("Grumbo'z VIP PvP MG/WSG Rewarder loaded.")
