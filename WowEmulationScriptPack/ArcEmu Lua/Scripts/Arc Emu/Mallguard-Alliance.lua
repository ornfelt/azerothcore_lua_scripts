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


--Alliance Guard--

function MallGuardAlliance_OnEnterCombat(pUnit,Event)
    pUnit:SendChatMessage(12, 0, "Another pesky horde... Pfft")
end

RegisterUnitEvent(90002, 1, "MallGuardAlliance_OnEnterCombat")

