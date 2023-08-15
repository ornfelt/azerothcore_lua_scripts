function Sabeltooth_OnCombat(Unit, Event) 
Unit:SendChatMessage(14, 0, "Captain Sabeltooth is a dangerous guy!")
Unit:CastSpell(41447)
Unit:RegisterEvent("Sabeltooth_Fire", 30000, 5)
end

function Sabeltooth_Fire(Unit, Event) 
Unit:CastSpell(36876, Unit:GetRandomPlayer(0)) 
Unit:SendChatMessage(14, 0, "Me dragon! Boom Boom!")
end

function Sabeltooth_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
Unit:SendChatMessage(14, 0, "Captain Sabeltooth owned you?") 
end

function Sabeltooth_OnDied(Unit, Event) 
Unit:RemoveEvents() 
Unit:SendChatMessage(12, 0, "NOO! yo washed off me face painting!") 
end

function Sabeltooth_OnKilledTarget(Unit, Event) 
Unit:SendChatMessage(14, 0, "I BETTAR DAN U!!") 
Unit:FullCastSpellOnTarget(5727, Unit:GetRandomPlayer(0))
end

RegisterUnitEvent(6477, 1, "Sabeltooth_OnCombat")
RegisterUnitEvent(6477, 2, "Sabeltooth_OnLeaveCombat")
RegisterUnitEvent(6477, 3, "Sabeltooth_OnKilledTarget")
RegisterUnitEvent(6477, 4, "Sabeltooth_OnDied")