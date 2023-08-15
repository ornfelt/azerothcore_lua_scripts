--[[

	This is created by zdroid9770  :D

	© Copyright 2011 - 2012

:) If you use this script change the name in the " ' ' " to your wow private server is called xD

]]--

function WelcomeNPC(Unit, event, player)
        pUnit:RegisterEvent("WelcomeNPC_Say",45000, 0)
end

function WelcomeNPC_Say(Unit, event, player)
  local chance = math.random(1,3)
    if(chance == 1) then
        pUnit:SendChatMessage(14, 0, "Hello and Welcome To 'World of the Dam'!")
end
    if(chance == 2) then
        pUnit:SendChatMessage(14, 0, "Talk to me for more information!")
end
    if(chance == 3) then
        pUnit:SendChatMessage(14, 0, "We hope you have a wonderful stay!")
    end
end

RegisterUnitEvent(7000006, 1, "WelcomeNPC")