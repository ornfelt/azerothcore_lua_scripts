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

function skelemag_1(pUnit, Event)
 if pUnit:GetHealthPct() < 90 then
  pUnit:RemoveEvents();
  pUnit:RegisterEvent("skelemag_2",1000, 0)
  pUnit:FullCastSpell(33933)
  pUnit:FullCastSpell(33933)
  pUnit:FullCastSpell(33933)
 end
end

function skelemag_2(pUnit, Event)
 if pUnit:GetHealthPct() < 80 then
  pUnit:RemoveEvents();
  pUnit:RegisterEvent("skelemag_3",1000, 0)
  pUnit:FullCastSpell(33933)
  pUnit:FullCastSpell(33933)
  pUnit:FullCastSpell(33933)
 end
end

function skelemag_3(pUnit, Event)
 if pUnit:GetHealthPct() < 70 then
  pUnit:RemoveEvents();
  pUnit:RegisterEvent("skelemag_4",1000, 0)
  pUnit:FullCastSpell(33933)
  pUnit:FullCastSpell(33933)
  pUnit:FullCastSpell(33933)
 end
end

function skelemag_4(pUnit, Event)
 if pUnit:GetHealthPct() < 60 then
  pUnit:RemoveEvents();
  pUnit:RegisterEvent("skelemag_5",1000, 0)
  pUnit:FullCastSpell(33933)
  pUnit:FullCastSpell(33933)
  pUnit:FullCastSpell(33933)
 end
end

function skelemag_5(pUnit, Event)
 if pUnit:GetHealthPct() < 50 then
  pUnit:RemoveEvents();
  pUnit:RegisterEvent("skelemag_6",1000, 0)
  pUnit:FullCastSpell(33933)
  pUnit:FullCastSpell(33933)
  pUnit:FullCastSpell(33933)
 end
end

function skelemag_6(pUnit, Event)
 if pUnit:GetHealthPct() < 40 then
  pUnit:RemoveEvents();
  pUnit:RegisterEvent("skelemag_7",1000, 0)
  pUnit:FullCastSpell(33933)
  pUnit:FullCastSpell(33933)
  pUnit:FullCastSpell(33933)
 end
end

function skelemag_7(pUnit, Event)
 if pUnit:GetHealthPct() < 30 then
  pUnit:RemoveEvents();
  pUnit:RegisterEvent("skelemag_8",1000, 0)
  pUnit:FullCastSpell(33933)
  pUnit:FullCastSpell(33933)
  pUnit:FullCastSpell(33933)
 end
end

function skelemag_8(pUnit, Event)
 if pUnit:GetHealthPct() < 20 then
  pUnit:RemoveEvents();
  pUnit:RegisterEvent("skelemag_9",1000, 0)
  pUnit:FullCastSpell(33933)
  pUnit:FullCastSpell(33933)
  pUnit:FullCastSpell(33933)
 end
end

function skelemag_9(pUnit, Event)
 if pUnit:GetHealthPct() < 10 then
  pUnit:RemoveEvents();
  pUnit:FullCastSpell(33933)
  pUnit:FullCastSpell(33933)
  pUnit:FullCastSpell(33933)
 end
end
 
function skelemag_start(pUnit, Event)
 pUnit:RegisterEvent("skelemag_1",1000, 0)
 pUnit:SendChatMessage (11, 0, "$N, you are futile!")
 pUnit:FullCastSpell(30533)
 end
RegisterUnitEvent(321212, 1, "skelemag_start")