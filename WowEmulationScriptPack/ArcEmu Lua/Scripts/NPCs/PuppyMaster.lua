function PuppyMaster_p1(Unit, Event)
 if Unit:GetHealthPct() < 90 then
  Unit:RemoveEvents();
  Unit:SendChatMessage (12, 0, "Burn in hell!")
  Unit:FullCastSpell(19630)
  Unit:RegisterEvent("PuppyMaster_p2",1000, 0)
 end
end
 
function PuppyMaster_p2(Unit, Event)
 if Unit:GetHealthPct() < 80 then
  Unit:RemoveEvents();
  Unit:SendChatMessage (12, 0, "Face my fire again!")
  Unit:FullCastSpell(19630)
  Unit:RegisterEvent("PuppyMaster_p3",1000, 0)
 end
end
 
function PuppyMaster_p3(Unit, Event)
 if Unit:GetHealthPct() < 72 then
  Unit:RemoveEvents();
  Unit:SendChatMessage (12, 0, "You have yet to face my full power")
  Unit:FullCastSpell(34660)
  Unit:RegisterEvent("PuppyMaster_p4",1000, 0)
 end
end

function PuppyMaster_p4(Unit, Event)
 if Unit:GetHealthPct() < 60 then
  Unit:RemoveEvents();
  Unit:SendChatMessage (12, 0, "Nothing may harm me!")
  Unit:FullCastSpell(39666)
  Unit:RegisterEvent("PuppyMaster_p5",1000, 0)
 end
end

function PuppyMaster_p5(Unit, Event)
 if Unit:GetHealthPct() < 50 then
  Unit:RemoveEvents();
  Unit:SendChatMessage (12, 0, "Fire power!")
  Unit:FullCastSpell(38836)
  Unit:RegisterEvent("PuppyMaster_p6",1000, 0)
 end
end

function PuppyMaster_p6(Unit, Event)
 if Unit:GetHealthPct() < 35 then
  Unit:RemoveEvents();
  Unit:SendChatMessage (12, 0, "You have resisted my fire powers... but not my shadow!")
  Unit:FullCastSpell(38840)
  Unit:RegisterEvent("PuppyMaster_p7",1000, 0)
 end
end

function PuppyMaster_p7(Unit, Event)
 if Unit:GetHealthPct() < 20 then
  Unit:RemoveEvents();
  Unit:SendChatMessage (12, 0, "Shadow Nova!!")
  Unit:FullCastSpell(30852)
  Unit:RegisterEvent("PuppyMaster_p8",1000, 0)
 end
end

function PuppyMaster_p8(Unit, Event)
 if Unit:GetHealthPct() < 7 then
  Unit:RemoveEvents();
  Unit:SendChatMessage (12, 0, "I will not die!")
  Unit:FullCastSpell(17683)
  Unit:RegisterEvent("PuppyMaster_p9",1000, 0)
 end
end

function PuppyMaster_p9(Unit, Event)
 if Unit:GetHealthPct() < 90 then
  Unit:RemoveEvents();
  Unit:SendChatMessage (12, 0, "You will die slowly!")
  Unit:FullCastSpell(33129)
  Unit:RegisterEvent("PuppyMaster_p10",1000, 0)
 end
end

function PuppyMaster_p10(Unit, Event)
 if Unit:GetHealthPct() < 60 then
  Unit:RemoveEvents();
  Unit:SendChatMessage (12, 0, "Rise minions!")
  Unit:FullCastSpell(41948)
  Unit:FullCastSpell(41948)
  Unit:FullCastSpell(41948)
  Unit:RegisterEvent("PuppyMaster_p11",1000, 0)
 end
end


function PuppyMaster_p11(Unit, Event)
 if Unit:GetHealthPct() < 30 then
  Unit:RemoveEvents();
  Unit:SendChatMessage (12, 0, "Run in fear!")
  Unit:FullCastSpell(39048)
  Unit:RegisterEvent("PuppyMaster_p12",1000, 0)
 end
end


function PuppyMaster_p12(Unit, Event)
 if Unit:GetHealthPct() < 10 then
  Unit:RemoveEvents();
  Unit:SendChatMessage (12, 0, "Nooo!")
  Unit:FullCastSpell(34659)
 end
end

function PuppyMaster_start(Unit, Event)
 Unit:RegisterEvent("PuppyMaster_p1",1000, 0)
 Unit:SendChatMessage (12, 0, "Insolent fool! You dare come into my domain?")
end

RegisterUnitEvent(3927, 1, "PuppyMaster_start")