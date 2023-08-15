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





function Melris_Died(Unit, event, player)

Unit:RemoveEvents()

end



function Melris(Unit, event, player)

Unit:RegisterEvent("Melris_Say",48000, 0)

end




function Melris_Say(Unit, event, player)

Unit:SendChatMessage(12, 0, "Highlord Bolvar is looking for able bodied people, around Level 56, for a job. Head up to the Stormwind Keep and speak with him if you qualify!")

end


RegisterUnitEvent(12480, 18, "Melris")

RegisterUnitEvent(12480, 4, "Melris_Died")