--[[
***************************
*      .-.                *
*      `-.. ..-. + +      *
*      `-''-'' '          *
*  OpenSource Scripting   *
*          Team           *
* http://sunplusplus.info *
*                         *
***************************
Created:Recon
-- ]]



function donna_Died(Unit, event, player)
	Unit:RemoveEvents()
end



function donna(Unit, event, player)
	Unit:RegisterEvent("donna_Say",45000, 0)
end


function donna_Say(Unit, event, player)
local chance = math.random(1,3)
	if(chance == 1) then
		Unit:SendChatMessage(12, 0, "Hey you, did you see my puppy ?")
	end
	if(chance == 2) then
		Unit:SendChatMessage(12, 0, "Guard ? Can you find my puppy for me ?")
	end
	if(chance == 3) then
		Unit:SendChatMessage(12, 0, "Hmmm ... Where is my puppey ?")
	end
end

RegisterUnitEvent(2532, 18, "donna")
RegisterUnitEvent(2532, 4, "donna_Died")