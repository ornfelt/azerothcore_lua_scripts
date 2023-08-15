function Thor_leif_OnCombat(Unit, Event) 
Unit:SendChatMessage(14, 0, "Cheers! More stuffs for my ultimate youghurt!")
Unit:RegisterEvent("Flamed_Youghurt", 34000, 100)
Unit:RegisterEvent("Youghurt_Spit", 23000, 100)
Unit:RegisterEvent("Youghurt_Choice", 14000, 100)
Unit:RegisterEvent("Appear_Behind", 65000, 100)
Unit:RegisterEvent("Youghurt_Mixer", 29800, 10)
Unit:RegisterEvent("Youghurt_Explosion",65000, 1)
end

function Flamed_Youghurt(Unit, Event)
Unit:SendChatMessage(14, 0, "Taste my HOT MELTED youghurt!")
Unit:FullCastSpellOnTarget(36876, Unit:GetMainTank()) 
end

function Youghurt_Choice(Unit, Event)
Unit:SendChatMessage(14, 0, "You are choosed to make my next Youghurt!")
Unit:FullCastSpellOnTarget(37511, Unit:GetRandomPlayer(0)) 
end

function Youghurt_Spit(Unit, Event)
Unit:SendChatMessage(14, 0, "Taste someone, this is my Youghurt!")
Unit:FullCastSpellOnTarget(21047, Unit:GetRandomPlayer(0)) 
end

function Appear_Behind(Unit, Event)
Unit:FullCastSpellOnTarget(41176, Unit:GetRandomPlayer(0)) 
end

function Youghurt_Mixer(Unit, Event)
Unit:SendChatMessage(14, 0, "NYOOM!, My youghurt mixer is on it's way") 
Unit:FullCastSpellOnTarget(36228, Unit:GetRandomPlayer(0)) 
end

function Youghurt_Explosion(Unit, Event) 
Unit:FullCastSpellOnTarget(25679, Unit:GetRandomPlayer(0)) 
end

function Thor_leif_OnKilledTarget(Unit, Event)
Unit:RemoveEvents()
Unit:SendChatMessage(14, 0, "Yes! More Youghurt parts!")
end

function Thor_leif_OnDied(Unit, Event) 
Unit:RemoveEvents() 
Unit:SendChatMessage(14, 0, "NO! This cannot be! The world needs more youghurt!") 
end


RegisterUnitEvent(67734, 1, "Thor_leif_OnCombat")
RegisterUnitEvent(67734, 3, "Thor_leif_OnKilledTarget")
RegisterUnitEvent(67734, 4, "Thor_leif_OnDied")