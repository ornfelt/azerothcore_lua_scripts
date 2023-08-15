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



function gil_Died(Unit, event, player)

Unit:RemoveEvents()

end



function gil(Unit, event, player)

Unit:RegisterEvent("gil_Say",18000, 0)

end



function gil_Say(Unit, event, player)

local chance = math.random(1,6)

if(chance == 1) then

Unit:SendChatMessage(12, 0, "I wanna see the Mage Tower." )

end

if(chance == 2) then

Unit:SendChatMessage(12, 0, "s it true? Are there crocolisks in the canal?")

end

if(chance == 3) then

Unit:SendChatMessage(12, 0, "Why do we always go the same way?")

end

if(chance == 4) then

Unit:SendChatMessage(12, 0, "Are we there yet?")

end

if(chance == 5) then

Unit:SendChatMessage(12, 0, "I have to pee.")

end

if(chance == 6) then

Unit:SendChatMessage(12, 0, "My feet hurt.")

end

end

RegisterUnitEvent(3504, 18, "gil")

RegisterUnitEvent(3504, 4, "gil_Died")

