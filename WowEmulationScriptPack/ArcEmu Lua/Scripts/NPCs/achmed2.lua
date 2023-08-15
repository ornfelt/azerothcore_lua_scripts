function Achmed_OnCombat(Unit, Event) 
Unit:SendChatMessage(14, 0, "You no take kebab!")
Unit:RegisterEvent("Achmed_Enrage", 1000, 0)
Unit:RegisterEvent("Achmed_Chill", 28000, 0)
Unit:RegisterEvent("Achmed_Waterspite", 32000, 0)
Unit:RegisterEvent("Achmed_Blastwave", 25000, 0)
Unit:PlaySoundToSet(12491)
end

function Achmed_Chill(Unit, Event) 
Unit:FullCastSpellOnTarget(29290, Unit:GetRandomPlayer(0)) 
Unit:SendChatMessage(14, 0, "Here, taste some of my Cat kebab!")
end

function Achmed_Blastwave(Unit, Event)
Unit:CastSpell(36278)
Unit:SendChatMessage(14, 0, "Feel the power of the kebab!")
end

function Achmed_Waterspite(Unit, Event) 
Unit:FullCastSpellOnTarget(35008, Unit:GetRandomPlayer(0)) 
Unit:SendChatMessage(14, 0, "Here try some of my special made garlic dressing")
end

function Achmed_Enrage(Unit, Event) 
if Unit:GetHealthPct() < 50 then 
Unit:RemoveEvents(); 
Unit:SendChatMessage(14, 0, "You really did it now. feel the anger of the kebab!")
Unit:CastSpell(44779)
Unit:FullCastSpellOnTarget(15283, Unit:GetRandomPlayer(0))
end 
end

function Achmed_OnDied(Unit, Event) 
Unit:RemoveEvents()
Unit:SendChatMessage(12, 0, "NOO! The kebab must be..delivered..")
end

function Achmed_OnKilledTarget(Unit, Event) 
Unit:SendChatMessage(14, 0, "A kebab here, a kebab there..") 
end

RegisterUnitEvent(8999233, 1, "Achmed_OnCombat")
RegisterUnitEvent(8999233, 3, "Achmed_OnKilledTarget")
RegisterUnitEvent(8999233, 4, "Achmed_OnDied")