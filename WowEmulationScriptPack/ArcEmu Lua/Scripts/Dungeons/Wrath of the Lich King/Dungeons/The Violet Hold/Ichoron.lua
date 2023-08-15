function Ichoron_OnCombat(Unit, Event) 
Unit:SendChatMessage(12, 0, "Water Gun, Water Blast, Ha Ha Ha. Pokemon have nothing on me.")
Unit:RegisterEvent("Ichoron_Drained", 5000, 20)
Unit:RegisterEvent("Ichoron_Frenzy1", 10000, 20)
Unit:RegisterEvent("Ichoron_ProtectiveBubble", 15000, 20)
Unit:RegisterEvent("Ichoron_Frenzy2", 20000, 20)
Unit:RegisterEvent("Ichoron_WaterBlast1", 25000, 20)
Unit:RegisterEvent("Ichoron_WaterBoltVolley1", 30000, 20)
Unit:RegisterEvent("Ichoron_WaterBlast2", 35000, 20)
Unit:RegisterEvent("Ichoron_WaterBoltVolley2", 40000, 20)
end

function Ichoron_Drained(Unit, Event) 
Unit:CastSpell(59820,	Unit:GetRandomPlayer(4)) 
end

function Ichoron_Frenzy1(Unit, Event) 
Unit:CastSpell(27897,	Unit:GetMainTank()) 
end

function Ichoron_ProtectiveBubble(Unit, Event) 
Unit:CastSpell(54306,	Unit:GetRandomPlayer(4)) 
end

function Ichoron_Frenzy2(Unit, Event) 
Unit:CastSpell(27897,	Unit:GetRandomPlayer(6)) 
end

function Ichoron_WaterBlast1(Unit, Event) 
Unit:CastSpell(54237,	Unit:GetRandomPlayer(7)) 
end

function Ichoron_WaterBoltVolley1(Unit, Event) 
Unit:CastSpell(59266,	Unit:GetRandomPlayer(4)) 
end

function Ichoron_WaterBlast2(Unit, Event) 
Unit:CastSpell(59520,	Unit:GetMainTank()) 
end

function Ichoron_WaterBoltVolley2(Unit, Event) 
Unit:CastSpell(59521,	Unit:GetRandomPlayer(7)) 
end

function Ichoron_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
Unit:SendChatMessage(12, 0, "Yeah it's better that you go back to playing pokemon!!!") 
end

function Ichoron_OnDied(Unit, Event) 
Unit:RemoveEvents() 
Unit:SendChatMessage(12, 0, "Pokemon Suck!!!!!") 
end

function Ichoron_OnKilledTarget(Unit, Event) 
Unit:SendChatMessage(12, 0, "Take that you Pokemon Lover!!!!") 
end

RegisterUnitEvent(29313, 1, "Ichoron_OnCombat")
RegisterUnitEvent(29313, 2, "Ichoron_OnLeaveCombat")
RegisterUnitEvent(29313, 3, "Ichoron_OnKilledTarget")
RegisterUnitEvent(29313, 4, "Ichoron_OnDied")