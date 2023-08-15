-----------------------------------------------------------------------------------
--   Original Code: Kenuvis                                                      --
--                                  			                           --
--   This Script is known to have some little                                    --
--   Bugs but thex can be resolved by Killing the NPC                            --
--   Dont delete our Credits!!!                                                  --
--   Modified by darkalex									   --
-----------------------------------------------------------------------------------
--   LUAppArc Scripting Project. 								   --
--   SVN: http://svn.assembla.com/svn/LUAppArc 						   --
--   LOG: http://burning-azzinoth.de/arcemu/new/frontend/?t=2			   --
-----------------------------------------------------------------------------------


print "XXXXXXXXX  LUA QUIZ LOADED  XXXXXXXX"

--			Question				Answers		Right AW
Fragebogen = {{"What is a real planet? A: Mars B: Snickers C: Twix", 1},{"What is an Instance on Live Servers? A: The Black Temple  B: The white house C: both", 1}}

Start_NPC = 9870123 --This is an NPC which should only exist ONCE on your world.

Time_between_events = 3600000 --Time in Milliseconds (Seconds*1000) which should pass between two Events. Standard is 1 hour

number_of_questions = 8 --How many questions should I ask in each round






























































-------------Don't do anything below this line!!!----------------

Teilnehmer = {{}}

function startevent(Unit, Event)
   print "Quiz-Event start..."
   Unit:RegisterEvent("RegPly_start", 10, 1)
end

RegisterUnitEvent(Start_NPC, 6, "startevent")

function RegPly_start(Unit)
   print "RegPly_start init..."
	Teilnehmer = {{}}
    Unit:SpawnGameObject(183320, Unit:GetX()+6, Unit:GetY()+3, Unit:GetZ()+0.5, Unit:GetO(), 29500)
   Unit:SendChatMessage(12, 0, "Wer beim Quiz-Event mitmachen will, bitte jetzt in den Rosa Kreis stellen! - 30 Sekunden Zeit ab jetzt!")
   Unit:RemoveEvents()
   Unit:RegisterEvent("RegPly_finish", 30000, 1)
end

function RegPly_finish(Unit)
   print "RegPly_finish init..."
   local TIndex = 1
   local allreg = 0
   repeat 
      local Ply = Unit:GetRandomPlayer(0)
      if (Ply ~= nil) then
         if (Ply:GetX() > Unit:GetX()+2) and (Ply:GetX() < Unit:GetX()+10) and (Ply:GetY() > Unit:GetY()-4) and (Ply:GetY() < Unit:GetY()+4) then
                        
            local a = 1
            local check = 1
            repeat 
               if (Teilnehmer[a][1] == Ply) then
                  check = 0
               end 
               a = a + 1
            until (Teilnehmer[a] == nil)             
            
            if (check == 1) then
               print "Player registriert:"
               print (Ply:GetName())
               Teilnehmer[TIndex] = {}
               Teilnehmer[TIndex][1] = Ply
               Teilnehmer[TIndex][2] = 0
               TIndex = TIndex + 1
            else
               allreg = allreg +1
            end
         else
            Ply = nil
         end
      end
   until (Ply == nil) or (allreg == 10)
   Unit:RemoveEvents()
   
   if (Teilnehmer[1] == nil) or (Teilnehmer[2] == nil) then
      Unit:SendChatMessage(12, 0, "I don't have 2 players - Cancelling Event!") 
      print "zu wenig Teilnehmer"
      --Unit:SendChatMessage(12, 0, "Next Quiz-Event: Here, in 5 Minutes!") 
      Unit:Despawn(1000, 300000);
   else
      Unit:RegisterEvent("RegPly_list", 1000, 1)
   end
end

function RegPly_list(pUnit)
   print "RegPly_list init..."
   local PlyList = "User fuer Quiz registriert: "
   local a = 1
   repeat
      PlyList = string.format("%s %s", PlyList, Teilnehmer[a][1]:GetName())
      a = a + 1
   until (Teilnehmer[a] == nil)
   
   pUnit:SendChatMessage(12, 0, PlyList)
   pUnit:RemoveEvents()
   pUnit:RegisterEvent("Quiz_start", 1, 1)
   FrageAZ = 1 
end 

function Spawn_Circle_a(pUnit)
   --print "Circle A spawn..."
   pUnit:SendChatMessage(12, 0, "This Circle is A, the next B and the last one is C")
   pUnit:SpawnGameObject(183320, pUnit:GetX()+6, pUnit:GetY()+3, pUnit:GetZ()+0.5, pUnit:GetO(), 20000)
end

function Spawn_Circle_b(pUnit)
   --print "Circle B spawn..."
   --pUnit:SendChatMessage(12, 0, "Fuer B in den hier")
   pUnit:SpawnGameObject(183320, pUnit:GetX(), pUnit:GetY()+3, pUnit:GetZ()+0.5, pUnit:GetO(), 20000)
end

function Spawn_Circle_c(pUnit)
   --print "Circle C spawn..."
   --pUnit:SendChatMessage(12, 0, "Und fuer Antwort C stellt ihr euch in diesen Kreis.")
   pUnit:SpawnGameObject(183320, pUnit:GetX()-6, pUnit:GetY()+3, pUnit:GetZ()+0.5, pUnit:GetO(), 20000)
end

function Quiz_start(Unit)
   print "Quiz_start init..."
   Unit:RemoveEvents()
   local a = 0
   repeat
      a = a + 1
   until (Fragebogen[a+1] == nil)
   
   repeat
      b = math.random(1, a)
   until (b ~= Frage)
   
   Frage = b
      
   Unit:RegisterEvent("Spawn_Circle_a", 5000, 1)
   Unit:RegisterEvent("Spawn_Circle_b", 6000, 1)
   Unit:RegisterEvent("Spawn_Circle_c", 7000, 1)
   Unit:RegisterEvent("Quiz_Frage_Start", 8000, 1)
end

function Quiz_Frage_Start(Unit)
   print "Quiz_Frage_start init..."
   Unit:SendChatMessage(12,0, Fragebogen[Frage][1])
   Unit:RemoveEvents()
   Unit:RegisterEvent("Quiz_Frage_end", 10000, 1)
end   
   
function Quiz_Frage_end(Unit)
   print "Quiz_Frage init..."
   local a = 1
   local Gewinner = ""
   repeat
      local Ply = Teilnehmer[a][1]
       if (Fragebogen[Frage][2] == 1) then
         if (Ply:GetX() > Unit:GetX()+3) and (Ply:GetX() < Unit:GetX()+9) and (Ply:GetY() > Unit:GetY()) and (Ply:GetY() < Unit:GetY()+6) then
            print (string.format("Teilnehmer %s ist im Kreis A", Ply:GetName()))
            Gewinner = string.format("%s %s", Gewinner, Ply:GetName())
            Teilnehmer[a][2] = Teilnehmer[a][2] +1
         else
            print (string.format("Teilnehmer %s ist nicht im Kreis A", Ply:GetName()))
           -- Ply:SetHealthPct(10)
         end
      elseif (Fragebogen[Frage][2] == 2) then
         if (Ply:GetX() > Unit:GetX()-3) and (Ply:GetX() < Unit:GetX()+3) and (Ply:GetY() > Unit:GetY()) and (Ply:GetY() < Unit:GetY()+6) then
             print (string.format("Teilnehmer %s ist im Kreis B", Ply:GetName()))
            Gewinner = string.format("%s %s", Gewinner, Ply:GetName())
            Teilnehmer[a][2] = Teilnehmer[a][2] +1
         else
            print (string.format("Teilnehmer %s ist nicht im Kreis B", Ply:GetName()))
           -- Ply:SetHealthPct(10)
         end
      elseif (Fragebogen[Frage][2] == 3) then
         if (Ply:GetX() > Unit:GetX()-9) and (Ply:GetX() < Unit:GetX()-3) and (Ply:GetY() > Unit:GetY()) and (Ply:GetY() < Unit:GetY()+6) then
             print (string.format("Teilnehmer %s ist im Kreis C", Ply:GetName()))
            Gewinner = string.format("%s %s", Gewinner, Ply:GetName())
            Teilnehmer[a][2] = Teilnehmer[a][2] +1
         else
            print (string.format("Teilnehmer %s ist nicht im Kreis C", Ply:GetName()))
           -- Ply:SetHealthPct(10)
         end
      end
      a = a + 1
   until (Teilnehmer[a] == nil)
   
   if (Fragebogen[Frage][2] == 1) then
      Gewinner = string.format("Richt answaer was A: %s", Gewinner)
   elseif (Fragebogen[Frage][2] == 2) then
      Gewinner = string.format("Richt answaer was B: %s", Gewinner)
   elseif (Fragebogen[Frage][2] == 3) then
      Gewinner = string.format("Richt answaer was C: %s", Gewinner)
   end 
   
   --Unit:SendChatMessage(12, 0, Gewinner)
   Unit:SendChatMessage(12, 0, "I have your Answers! Thanks!.")   

   Unit:RemoveEvents()
   Unit:RegisterEvent("Quiz_Frage_neu", 10000, 1)
end

function Quiz_Frage_neu(Unit)
   print "Quiz_Frage_neu init..."
   Unit:RemoveEvents()
   
   if (FrageAZ == number_of_questions) then   
      Unit:RegisterEvent("Quiz_Auswertung", 1000, 1)
   else
      FrageAZ = FrageAZ + 1
      Unit:RegisterEvent("Quiz_start", 1000, 1)
   end
end


function Quiz_Auswertung(Unit)
   print "Quiz_Auswertung init..."
   local a = 1
   local top = {{0,0},{0,0},{0,0}}
   
   repeat
      if (top[1][2] < Teilnehmer[a][2]) then
         top[3] = top[2]
         top[2] = top[1]
         top[1] = Teilnehmer[a]
      elseif (top[2][2] < Teilnehmer[a][2]) then   
         top[3] = top[2]
         top[2] = Teilnehmer[a]
      elseif (top[3][2] < Teilnehmer[a][2]) then   
         top[3] = Teilnehmer[a]
      end
      
      a = a + 1
   until (Teilnehmer[a] == nil)
   
   msg = "Sieger:"
   msg = string.format("%s %s (%d); ", msg, top[1][1]:GetName(), top[1][2])
   --if (top[1][2] ~= top[2][2]) then
   --   msg = string.format("%s Zweiter: ", msg)
   --end       
   top[1][1]:AddItem(31205, 5)
   --msg = string.format("%s %s (%d), ", msg, top[2][1]:GetName(), top[2][2])
   --if (top[2][2] ~= top[3][2]) and (top[1][2] ~= top[2][2]) then
   --   msg = string.format("%s Dritter: ", msg)
   --elseif (top[1][2] ~= top[2][2]) then
   --   msg = string.format("%s Zweiter: ", msg)
   --end   
   top[2][1]:AddItem(31205, 3)
   --msg = string.format("%s %s (%d) ", msg, top[3][1]:GetName(), top[3][2])
   Unit:SendChatMessage(11, 0, msg) 
   
   Unit:SendChatMessage(12, 0, "Thanks for playing. Bye until I come again with new brutal questions!") 
   Unit:Despawn(1000, Time_between_events)
   Unit:RemoveEvents()
end

