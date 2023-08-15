# local npcid = 129129
 local laberzeit = 1
 local neustart = 1200000
 local Art = 14
  
 local NachrichtX = "Welcome! To Chat With Players Online Do /Join world. If You Need Anyhelp, Open a Ticket from the Red Question Mark Below."
 local NachrichtY = "Have a Suggestion For Server?, Need a Guild?, or Just Chill And Talk? Join our Forum Now At http://vigilancewow.forum-motion.com/"
 local NachrichtZ = "Log onto http://Vigilancewow.servgame.org vote for us now, You Will Get Prices By Voting :)"
 local NachrichtO = "if You Need Emblem of Frost (S8) Go to Quest Zone S8 or For (Tier10) Go To Quest Zone T10. If You Need to Pvp, Go to Gurubashi Arena ;)"
  
 function Rufen1(Unit, Event)
     Unit:RemoveEvents()
     Unit:SendChatMessage(Art, 0, NachrichtX)
     Unit:RegisterEvent("Rufen2", laberzeit, 0)
 end
  
 function Rufen2(Unit, Event)
     Unit:RemoveEvents()
     Unit:SendChatMessage(Art, 0, NachrichtY)
     Unit:RegisterEvent("Rufen3", laberzeit, 0)
 end
  
 function Rufen3(Unit, Event)
     Unit:RemoveEvents()
     Unit:SendChatMessage(Art, 0, NachrichtZ)
     Unit:RegisterEvent("Rufen4", laberzeit, 0)
 end
  
 function Rufen4(Unit, Event)
     Unit:RemoveEvents()
     Unit:SendChatMessage(Art, 0, NachrichtO)
     Unit:RegisterEvent("Rufen1", neustart, 0)
 end
  
 
 RegisterUnitEvent(129129, 18, "Rufen1")