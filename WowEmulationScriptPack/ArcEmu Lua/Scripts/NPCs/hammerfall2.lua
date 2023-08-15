local timebetweenannounce = 60000 --Time between messages the NPC sends. In Milliseconds
local restarttime = 200000 --How long you want until it restarts all over again. In Milliseconds
local npcid = 303031 --The NPC's ID
local yellortalk = 14 --   14 = Yell,   12 = Talk

--Change the folowing text to whatever you want
local message1 = "YES SIR!! WE ARE READY TO SLAY THEM!!!"  
local message2 = "YES SIR!! WE WILL HONOR YOU!!!"  
local message3 = "FOR THE HORDE!!! FOR THE HORDE!!! FOR THE HORDE!!!"


function Army_Yell(pUnit, Event)
   pUnit:SendChatMessage(yellortalk , 0, message1)
   pUnit:RemoveEvents();
   pUnit:RegisterEvent("Army2_Yell", timebetweenannounce, 0) 
end

function Army2_Yell(pUnit, Event)
   pUnit:SendChatMessage(yellortalk,0, message2)
   pUnit:RemoveEvents();
   pUnit:RegisterEvent("Army3_Yell", timebetweenannounce, 0)
end

function Army3_Yell(pUnit, Event)
   pUnit:SendChatMessage(yellortalk, 0, message3)
   pUnit:RemoveEvents();
   pUnit:RegisterEvent("Army2_Yell", restarttime, 0)
end

function Army_Start(pUnit, Event)
   pUnit:RegisterEvent("Army_Yell", 6000, 0)
end
RegisterUnitEvent(npcid, 6, "Army_Start")