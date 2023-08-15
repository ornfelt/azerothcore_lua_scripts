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



function Maiev_Died(Unit, event, player)

Unit:RemoveEvents()

end



function Maiev(Unit, event, player)

Unit:RegisterEvent("Maiev_Say", 62000, 0)

end




function Maiev_Say(Unit, event, player)

Unit:SendChatMessage(12, 0, "I've waited for this moment for years. Illidan and his lapdogs will be destroyed!!")

Unit:SendChatMessage(12, 0, "You've sealed your fate, Akama. The Master will learn of your betrayal!")

end

RegisterUnitEvent(21699, 18, "Maiev")

RegisterUnitEvent(21699, 4, "Maiev_Died")

