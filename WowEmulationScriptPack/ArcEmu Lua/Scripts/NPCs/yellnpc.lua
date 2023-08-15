--[[

-- ]]


function WelcomeNPC_Died(Unit, event, player)
Unit:RemoveEvents()
end

function WelcomeNPC(Unit, event, player)
Unit:RegisterEvent("WelcomeNPC_Say",45000, 0)
end

function WelcomeNPC_Say(Unit, event, player)
local chance = math.random(1,3)
if(chance == 1) then
Unit:SendChatMessage(14, 0, "Hello and Welcome To CNA WoW!")
end
if(chance == 2) then
Unit:SendChatMessage(14, 0, "Talk to me for more information!")
end
if(chance == 3) then
Unit:SendChatMessage(14, 0, "We hope you have a wonderful stay!")
end
end

RegisterUnitEvent(900027, 2, "WelcomeNPC")
RegisterUnitEvent(900027, 1, "WelcomeNPC_Died")