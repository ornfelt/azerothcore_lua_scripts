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

function guldan_Died(Unit, event, player)
Unit:RemoveEvents()
end

function guldan(Unit, event, player)
Unit:RegisterEvent("guldan_Say",69000, 0)
end

function guldan_Say(Unit, event, player)
Unit:SendChatMessage(12, 0, "Behold those who have power, and who are not afraid to wield it. Behold... the warlocks!")
end



RegisterUnitEvent(17008, 18, "guldan")
RegisterUnitEvent(17008, 4, "guldan_Died")