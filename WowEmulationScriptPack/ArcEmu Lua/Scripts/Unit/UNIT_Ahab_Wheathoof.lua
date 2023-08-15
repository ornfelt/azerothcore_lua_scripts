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




function Ahab_Died(Unit, event, player)
Unit:RemoveEvents()

end



function Ahab(Unit, event, player)

Unit:RegisterEvent("Ahab_Say",15000, 0)

end



function Ahab_Say(Unit, event, player)

local chance = math.random(1,2)

if(chance == 1) then

Unit:SendChatMessage(12, 0, "Where is that dog ?")

end

if(chance == 2) then

Unit:SendChatMessage(12, 0, "I miss my dog so much !")

end

end

RegisterUnitEvent(23618, 18, "Ahab")

RegisterUnitEvent(23618, 4, "Ahab_Died")

