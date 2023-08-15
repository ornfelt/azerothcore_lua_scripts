-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright© zdroid9770					 --
-------------------------------------------------------------------

function Commander_1(Unit, Event)
	if Unit:GetHealthPct() < 70 then
		Unit:RemoveEvents();
		Unit:FullCastSpell(38840)
		Unit:SendChatMessage (11, 0, "DIE!!!")
		Unit:RegisterEvent("Commander_2",1000, 0)
	end
end
 
function Commander_2(Unit, Event)
	if Unit:GetHealthPct() < 50 then
		Unit:RemoveEvents();
		Unit:FullCastSpell(36127)
		Unit:SendChatMessage (11, 0, "Die !")
		Unit:RegisterEvent("Commander_3",1000, 0)
	end
end
 
function Commander_3(Unit, Event)
	if Unit:GetHealthPct() < 30 then
		Unit:RemoveEvents();
		Unit:FullCastSpell(39666)
		Unit:SendChatMessage (11, 0, "Nothing may harm me!")  
		Unit:RegisterEvent("Commander_4",1000, 0)
	end
end

function Commander_4(Unit, Event)
	if Unit:GetHealthPct() < 10 then
		Unit:RemoveEvents();
		Unit:SendChatMessage (11, 0, "I will not die!")  
		Unit:FullCastSpell(17683)
		Unit:RegisterEvent("Commander_5",1000, 0)
	end
end

function Commander_5(Unit, Event)
	if Unit:GetHealthPct() < 75 then
		Unit:RemoveEvents();
		Unit:SendChatMessage (11, 0, "This will be your grave!")  
		Unit:FullCastSpell(36127)
		Unit:RegisterEvent("Commander_6",1000, 0)
	end
end

function Commander_6(Unit, Event)
	if Unit:GetHealthPct() < 50 then
		Unit:RemoveEvents();
		Unit:SendChatMessage(11, 0, "Die! All of you!")  
		Unit:FullCastSpell(38840)
		Unit:RegisterEvent("Commander_7",1000, 0)
	end
end

function Commander_7(Unit, Event)
	if Unit:GetHealthPct() < 10 then
		Unit:RemoveEvents();
		Unit:SendChatMessage(11, 0, "No!!")  
		Unit:FullCastSpell(17928)
	end
end
 
function Commander_start(Unit, Event)
	Unit:RegisterEvent("Commander_1",1000, 0)
	Unit:SendChatMessage (11, 0, ", you will die here!")
end

RegisterUnitEvent(4278, 1, "Commander_start")