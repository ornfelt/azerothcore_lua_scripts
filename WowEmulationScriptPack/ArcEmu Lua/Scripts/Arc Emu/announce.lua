                ******************************                              
                *                            *
                *   The FrostTeam Project    *                 
                *                            *
                ******************************                        
                

        --FrostTeam SVN consists of the latest WotLK
        scripts, both Lua and C++. Some will be our own,
        some will be others with credits attatched. Our
        Svn includes all scripts that you may need
        to help make your server a more fun environment.--

---------------------------//----------------------------------------------


 local timebetweenannounce = 30000 --Milliseconds between messages the NPC sends
    local restarttime = 125000 --Milliseconds between replay
    local npcid = 55555

    local message1 = "Welcome to the server!"
    local message2 = "Please report any bugs onto the site."
    local message3 = "Please keep voting for use every 12 hours."
    local message4 = "Please do not try to go agenst any of the server rules."


    function Announcer_Yell(pUnit, Event)
       pUnit:SendChatMessage(12, 0, message1)
       pUnit:RemoveEvents();
       pUnit:RegisterEvent("Announcer2_Yell", timebetweenannounce, 0)
    end

    function Announcer2_Yell(pUnit, Event)
       pUnit:SendChatMessage(12 ,0, message2)
       pUnit:RemoveEvents();
       pUnit:RegisterEvent("Announcer3_Yell", timebetweenannounce, 0)
    end

    function Announcer3_Yell(pUnit, Event)
       pUnit:SendChatMessage(12, 0, message3)
       pUnit:RemoveEvents();
       pUnit:RegisterEvent("Announcer4_Yell", timebetweenannounce, 0)
    end

    function Announcer4_Yell(pUnit, Event)
       pUnit:SendChatMessage(12, 0, message4)
       pUnit:RemoveEvents();
       pUnit:RegisterEvent("Announcer5_Yell", timebetweenannounce, 0)
    end

    function Announcer_Start(pUnit, Event)
       pUnit:RegisterEvent("Announcer_Yell", 1000, 0)
    end
    RegisterUnitEvent(npcid, 6, "Announcer_Start")