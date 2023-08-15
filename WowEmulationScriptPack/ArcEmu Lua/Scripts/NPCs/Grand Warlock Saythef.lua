function Saythef_OnCombat(Unit, Event) 
Unit:SendChatMessage(13, 0, "FEEL THE WRATH OF THE SHADOW!")
Unit:RegisterEvent("Shadow_Blast", 10000, 100)
Unit:RegisterEvent("Shadow_Volley", 10000, 10)
Unit:RegisterEvent("Shadow_Burst", 100000, 5)
Unit:RegisterEvent("Shadow_Flame", 1000, 5)
Unit:RegisterEvent("Shadow_Missile", 10000, 5)
Unit:RegisterEvent("Shadow_Blast",1000,0)
end

function Shadow_Blast(Unit, Event) 
Unit:FullCastSpellOnTarget(38085, Unit:GetMainTank()) 
end

function Shadow_Volley(Unit, Event) 
Unit:FullCastSpellOnTarget(40428, Unit:GetMainTank()) 
end

function Shadow_Burst(Unit, Event) 
Unit:FullCastSpellOnTarget(34436, Unit:GetMainTank()) 
end

function Shadow_Flame(Unit, Event) 
Unit:FullCastSpellOnTarget(22539, Unit:GetClosestPlayer()) 
end

function Shadow_Missile(Unit, Event) 
Unit:FullCastSpellOnTarget(32677, Unit:GetRandomPlayer(7)) 
end

function Shadow_Blast(Unit, Event) 
Unit:FullCastSpellOnTarget(45332, Unit:GetMainTank()) 
end

function Shadow_Blast(Unit, Event) 
if Unit:GetHealthPct() < 29 then 
Unit:RemoveEvents(); 
Unit:RegisterEvent("Shadow_Blast", 10000, 1)
end 
end

function Saythef_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
Unit:SendChatMessage(13, 0, "Goodbye, and goodluck to nexttime, hahaha!") 
end

function Saythef_OnDied(Unit, Event) 
Unit:RemoveEvents() 
Unit:SendChatMessage(13, 0, "NO THIS CANNOT BE NOO!") 
end

function Saythef_OnKilledTarget(Unit, Event) 
Unit:SendChatMessage(13, 0, "May the shadows corrupt you.") 
end

RegisterUnitEvent(876662, 1, "Saythef_OnCombat")
RegisterUnitEvent(876662, 2, "Saythef_OnLeaveCombat")
RegisterUnitEvent(876662, 3, "Saythef_OnKilledTarget")
RegisterUnitEvent(876662, 4, "Saythef_OnDied")