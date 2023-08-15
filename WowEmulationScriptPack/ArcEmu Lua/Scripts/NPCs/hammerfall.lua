local timebetweenannounce = 60000 --Time between messages the NPC sends. In Milliseconds
local restarttime = 200000 --How long you want until it restarts all over again. In Milliseconds
local npcid = 303030 --The NPC's ID
local yellortalk = 14 --   14 = Yell,   12 = Talk

--Change the folowing text to whatever you want
local message1 = "IN SICK AND TIRED OF THOSE FUCKING ALLY'S!! LETS SLAY THEM ALL!!! "  
local message2 = "ARE YOU GUYS READY TO FOR KILLING SOM ALLY'S???"  
local message3 = "FOR THE HORDE!!! LET US KILL THOSE ALLYFUCKERS!!!"


function ArmyChief_Yell(pUnit, Event)
   pUnit:SendChatMessage(yellortalk , 0, message1)
   pUnit:RemoveEvents();
   pUnit:RegisterEvent("ArmyChief2_Yell", timebetweenannounce, 0) 
end

function ArmyChief2_Yell(pUnit, Event)
   pUnit:SendChatMessage(yellortalk,0, message2)
   pUnit:RemoveEvents();
   pUnit:RegisterEvent("ArmyChief3_Yell", timebetweenannounce, 0)
end

function ArmyChief3_Yell(pUnit, Event)
   pUnit:SendChatMessage(yellortalk, 0, message3)
   pUnit:RemoveEvents();
   pUnit:RegisterEvent("ArmyChief2_Yell", restarttime, 0)
end

function ArmyChief_Start(pUnit, Event)
   pUnit:RegisterEvent("ArmyChief_Yell", 3000, 0)
end
RegisterUnitEvent(npcid, 6, "ArmyChief_Start")