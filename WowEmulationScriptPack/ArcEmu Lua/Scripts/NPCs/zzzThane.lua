--************************************************************
--*                                                          *
--*               ******************************             *                   
--*               *                            *             *
--*               *   The FrostTeam Project    *             *     
--*               *        stoneharry          *             *
--*               ******************************             *            
--*                                                          *
--*                                                          *
--*      --FrostTeam SVN consists of the latest WotLK        *   
--*      scripts, both Lua and C++. Some will be our own,    *
--*      some will be others with credits attatched. Our     *
--*      Svn includes all scripts that you may need          *
--*      to help make your server a more fun environment.--  *
--*                                                          *
--************************************************************


 function abigbad_Phase1(Unit, event)
    if Unit:GetHealthPct() < 95 then
        Unit:PlaySoundToSet(8899)
        Unit:SendChatMessage(12, 0, "Come on and fight you wee ne ne!")
        Unit:RemoveEvents()
        Unit:CastSpell(30035)
        Unit:RegisterEvent("abigbad_Phase2",1000, 0)
    end
end
 
function abigbad_Phase2(Unit, event)
    if Unit:GetHealthPct() < 85 then
        Unit:PlaySoundToSet(8905)
        Unit:SendChatMessage(12, 0, "I'm going to enjoy killing these slapjaw daffidiles!")
        Unit:RemoveEvents()
        Unit:CastSpell(29963)
        Unit:RegisterEvent("abigbad_Phase3",1000, 0)
    end
end
 
function abigbad_Phase3(Unit, event)
    if Unit:GetHealthPct() < 65 then
        Unit:PlaySoundToSet(8902)
        Unit:SendChatMessage(12, 0, "I like my meat extra crispy!")
        Unit:RemoveEvents()
        Unit:CastSpell(19129)
        Unit:CastSpell(45345)
        Unit:RegisterEvent("abigbad_Phase4",1000, 0)        
    end
end
 
function abigbad_Phase4(Unit, event)
    if Unit:GetHealthPct() < 45 then
        Unit:PlaySoundToSet(8904)
        Unit:SendChatMessage(12, 0, "I heard about enough of yer sniviling, shut your fly trap before i shut it for you!")
        Unit:RemoveEvents()
        Unit:CastSpell(19366)
        Unit:CastSpell(22436)
        Unit:CastSpell(15636)
        Unit:RegisterEvent("abigbad_Phase5",1000, 0)        
    end
end
 
function abigbad_Phase5(Unit, event)
    if Unit:GetHealthPct() < 35 then
        Unit:RemoveEvents()
        Unit:RegisterEvent("abigbad_Phase6",1000, 0)        
    end
end
function abigbad_Phase6(Unit, event)
    if Unit:GetHealthPct() < 5 then
        Unit:RemoveEvents()
        Unit:PlaySoundToSet(8901)
        Unit:CastSpell(28323)
        Unit:CastSpell(20620)
        Unit:SendChatMessage(12, 0, "Next time, bring more friends!")  
    end
end
function abigbad_OnLeaveCombat(Unit, event)
    Unit:RemoveEvents()
end
 
function abigbad_OnKilledTarget(Unit)
    Unit:CastSpell(41106)
end
 
function abigbad_Death(Unit)
    Unit:RemoveEvents()
    Unit:PlaySoundToSet(8870)
    Unit:SendChatMessage(12, 0, "Thank... You...")
end
RegisterUnitEvent(88888889, 1, "abigbad_OnCombat")
RegisterUnitEvent(88888889, 2, "abigbad_OnLeaveCombat")
RegisterUnitEvent(88888889, 3, "abigbad_OnKilledTarget")
RegisterUnitEvent(88888889, 4, "abigbad_Death")
function abigbadie_OnCombat(Unit, event)
    Unit:PlaySoundToSet(8903)
    Unit:SendChatMessage(12, 0, "To arms ye resta'bouts, we've got company!")
    x = Unit:GetX();
    y = Unit:GetY();
    z = Unit:GetZ();
    o = Unit:GetO();
    x = x - 2
    y = y - 2
    Unit:SpawnCreature(8888881, x, y, z, o, 17, 45000);
    x = x + 4
    y = y + 4
    Unit:SpawnCreature(8888881, x, y, z, o, 17, 45000);       
    Unit:FullCastSpell(46907)
    Unit:RegisterEvent("abigbad_Phase1",1000, 0)
end
function abigbadie_Death(Unit)
    RemoveEvents()
end
RegisterUnitEvent(5552221, 1, "abigbadie_OnCombat")
RegisterUnitEvent(5552221, 4, "abigbadie_Death")
 
 
