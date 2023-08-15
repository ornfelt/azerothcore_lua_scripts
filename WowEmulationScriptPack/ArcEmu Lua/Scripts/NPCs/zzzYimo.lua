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

function bigbad_Phase1(Unit, event)
    if Unit:GetHealthPct() < 90 then
        Unit:RemoveEvents()
        Unit:PlaySoundToSet(8871)
        Unit:FullCastSpell(43440)
        Unit:SendChatMessage(12, 0, "No, you feel pain!")
        Unit:RegisterEvent("bigbad_Phase2",1000, 0)
    end
end
 
function bigbad_Phase2(Unit, event)
    if Unit:GetHealthPct() < 80 then
        Unit:RemoveEvents()
        Unit:PlaySoundToSet(8852)
        Unit:FullCastSpell(43440)
        Unit:SendChatMessage(12, 0, "I'm just getting warmed up!")
        Unit:RegisterEvent("bigbad_Phase3",1000, 0)
    end
end
 
function bigbad_Phase3(Unit, event)
    if Unit:GetHealthPct() < 60 then
        Unit:RemoveEvents()
        Unit:PlaySoundToSet(8811)
        Unit:SendChatMessage(12, 0, "The end is upon you!")
        x = Unit:GetX();
        y = Unit:GetY();
        z = Unit:GetZ();
        o = Unit:GetO();
        x = x - 2
        y = y - 2
        Unit:SpawnCreature(88888888, x, y, z, o, 17, 45000);
        x = x + 4
        y = y + 4
        Unit:SpawnCreature(88888888, x, y, z, o, 17, 45000);
        Unit:RegisterEvent("bigbad_Phase4",1000, 0)        
    end
end
 
function bigbad_Phase4(Unit, event)
    if Unit:GetHealthPct() < 40 then
        Unit:RemoveEvents()
        Unit:PlaySoundToSet(10485)
        Unit:FullCastSpell(34109)
        Unit:SendChatMessage(12, 0, "Help us, hurry!")
        Unit:RegisterEvent("bigbad_Phase5",1000, 0)        
    end
end
 
function bigbad_Phase5(Unit, event)
    if Unit:GetHealthPct() < 30 then
        Unit:RemoveEvents()
        Unit:RemoveEvents()
        Unit:CastSpell(28410)
        Unit:CastSpell(19952)
        x = Unit:GetX();
        y = Unit:GetY();
        z = Unit:GetZ();
        o = Unit:GetO();
        x = x - 2
        y = y - 2
        Unit:SpawnCreature(88888888, x, y, z, o, 17, 45000);
        x = x + 4
        y = y + 4
        Unit:SpawnCreature(88888888, x, y, z, o, 17, 45000);       
        Unit:RegisterEvent("bigbad_Phase6",1000, 0)        
    end
end
function bigbad_Phase6(Unit, event)
    if Unit:GetHealthPct() < 2 then
        Unit:RemoveEvents()
        Unit:PlaySoundToSet(11214)
        Unit:SendChatMessage(12, 0, "Systems, Shutting... down...")  
    end
end
 
function bigbad_OnCombat(Unit, event)
    Unit:RemoveEvents()
    Unit:PlaySoundToSet(8867)
    Unit:SendChatMessage(12, 0, "Kill")
    Unit:CastSpell(40280)
    Unit:FullCastSpell(36677)
    Unit:RegisterEvent("bigbad_Phase1",1000, 0)
end
 
function bigbad_OnLeaveCombat(Unit, event)
    Unit:RemoveEvents()
    Unit:SetScale(1.3)
end
 
function bigbad_OnKilledTarget(Unit)
    Unit:CastSpell(41106)
end
 
function bigbad_Death(Unit)
    Unit:RemoveEvents()
    Unit:SetScale(1.3)
    Unit:PlaySoundToSet(8870)
    Unit:SendChatMessage(12, 0, "Thank... You...")
end
RegisterUnitEvent(88888889, 1, "bigbad_OnCombat")
RegisterUnitEvent(88888889, 2, "bigbad_OnLeaveCombat")
RegisterUnitEvent(88888889, 3, "bigbad_OnKilledTarget")
RegisterUnitEvent(88888889, 4, "bigbad_Death")
function bigbadie_OnCombat(Unit, event)
    Unit:FullCastSpellOnTarget(29516, Unit:GetMainTank())
end
function bigbadie_Death(Unit)
    RemoveEvents()
end
RegisterUnitEvent(88888888, 1, "bigbadie_OnCombat")
RegisterUnitEvent(88888888, 4, "bigbadie_Death")
