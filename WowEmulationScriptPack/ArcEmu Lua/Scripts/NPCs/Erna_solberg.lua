function Erna_OnCombat(Unit, Event) 
Unit:SendChatMessage(14, 0, "Finaly! Some people to torture!")
Unit:RegisterEvent("Erna_Rip", 23000, 20)
Unit:RegisterEvent("Erna_Crush", 35000, 10)
Unit:RegisterEvent("Erna_Smash", 50000, 100)
Unit:RegisterEvent("Erna_Charge", 25790, 25)
Unit:RegisterEvent("Erna_Rage",1000,0)
end

function Erna_Rip(Unit, Event) 
Unit:FullCastSpellOnTarget(40199, Unit:GetRandomPlayer(0)) 
end

function Erna_Crush(Unit, Event) 
Unit:FullCastSpellOnTarget(33661, Unit:GetMainTank()) 
end

function Erna_Smash(Unit, Event) 
Unit:FullCastSpellOnTarget(12734, Unit:GetClosestPlayer()) 
end

function Erna_Charge(Unit, Event) 
Unit:FullCastSpellOnTarget(38907, Unit:GetRandomPlayer(0)) 
end

function Erna_Rage(Unit, Event) 
if Unit:GetHealthPct() < 26 then 
Unit:RemoveEvents(); 
Unit:CastSpell(28131)
end 
end



function Erna_OnDied(Unit, Event) 
Unit:RemoveEvents() 
Unit:SendChatMessage(14, 0, "NO, not now! I got a whole cellar to torture") 
end

function Erna_OnKilledTarget(Unit, Event)
Unit:RemoveEvents()  
Unit:SendChatMessage(14, 0, "Hmm, You died to fast...No need of torture here") 
end

RegisterUnitEvent(87766, 1, "Erna_OnCombat")
RegisterUnitEvent(87766, 3, "Erna_OnKilledTarget")
RegisterUnitEvent(87766, 4, "Erna_OnDied")