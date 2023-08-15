local enabled = false

local function AnnounceBossKilled (event, killer, killed)
	if (killed:IsWorldBoss() == true) then 
		if (killer:GetGender() == 0) then 
			local message = "|CFF7BBEF7[Boss Announcer]|r:|cffff0000 "..killer:GetName().."|r and his group killed world boss |CFF18BE00["..killed:GetName().."]|r !!!"
			SendWorldMessage(message)
		else
			local message = "|CFF7BBEF7[Boss Announcer]|r:|cffff0000 "..killer:GetName().."|r and her group killed world boss |CFF18BE00["..killed:GetName().."]|r !!!"
			SendWorldMessage(message)
		end
	end
end
if enabled then
RegisterPlayerEvent(7, AnnounceBossKilled)
end