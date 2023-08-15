function Orclock_OnCombat(Unit, event) 
Unit:SendChatMessage(14, 0, "You will not come past me!")
Unit:RegisterEvent("Orclock_Shadowbolt", 2500, 100)
end

function Orclock_Shadowbolt(Unit, event)
Unit:StopMovement(3000) 
Unit:FullCastSpellOnTarget(19729, Unit:GetRandomPlayer(0)) 
end

function Orclock_OnDied(Unit, event) 
Unit:RemoveEvents() 
Unit:SendChatMessage(12, 0, "Im sorry my master... i failed you....") 
end

function Orclock_OnKilledTarget(Unit, event) 
Unit:SendChatMessage(14, 0, "Hehe, as i told you, you will not get past me!") 
end

RegisterUnitEvent(65011, 1, "Orclock_OnCombat")
RegisterUnitEvent(65011, 3, "Orclock_OnKilledTarget")
RegisterUnitEvent(65011, 4, "Orclock_OnDied")