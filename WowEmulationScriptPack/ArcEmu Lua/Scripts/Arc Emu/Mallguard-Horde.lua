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


--Horde Guard--

function MallGuardHorde_OnEnterCombat(pUnit,Event)
    pUnit:SendChatMessage(12, 0, "Another pesky alliance... Pfft")
end

RegisterUnitEvent(90003, 1, "MallGuardHorde_OnEnterCombat")