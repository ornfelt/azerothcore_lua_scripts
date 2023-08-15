local i = 1

s = {}

s[1] =	960001
s[2] =	960002
s[3] =	960003
s[4] =	960004
s[5] =	960005
s[6] =	960006
s[7] =	960007
s[8] =	960008
s[9] =	960009
s[10] =	960010
s[11] =	960011
s[12] =	960012
s[13] =	960013
s[14] =	960014
s[15] =	960015
s[16] =	960016

local quest_id = 960001


function safari_mob_on_death(pUnit, _, killer)
	if not killer then return; end
	if (killer:HasQuest(quest_id)) then
	
		if not (s[plr:GetName()]) then
			s[plr:GetName()] = {killcount = 0}  
		end
	
		while (i <= 16) do
		
			if (CreatureId == s[i]) then
				s[plr:GetName()].killcount = s[plr:GetName()].killcount + 1
				pPlayer:SendBroadcastMessage("You have " .. 16 - s[plr:GetName()].killcount .. " more creatures to go.")
			else
				i = i+1
			end
		end

		if (s[plr:GetName()].killcount == 16) then
			pPlayer:Teleport(209, 2358.637, 1541.420, -17.081)
		end
		
	end	
end

local safari_ids = {
	960001,
	960002,
	960003,
	960004,
	960005,
	960006,
	960007,
	960008,
	960009,
	960010,
	960011,
	960012,
	960013,
	960014,
	960015,
	960016
};

for _, id in pairs(safari_ids) do
	RegisterUnitEvent(id, 4, "safari_mob_on_death") 
end