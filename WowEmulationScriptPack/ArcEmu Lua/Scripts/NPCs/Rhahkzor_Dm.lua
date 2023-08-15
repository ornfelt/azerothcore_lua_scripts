function Rhahkzor_OnCombat(Unit, Event) 
Unit:SendChatMessage(14, 0, "You have wasted to much time mortals. Now you shall fall.")
Unit:RegisterEvent("Rhahkzor_Aoe", 35000, 0)
Unit:RegisterEvent("Rhahkzor_Transformation", 1000, 0)
Unit:RegisterEvent("Rhahkzor_Cleave", 20000, 0)
Unit:RegisterEvent("Rhahkzor_Sheep", 50000, 1)
Unit:PlaySoundToSet(11652)
Unit:PlaySoundToSet(11474)
end

function Rhahkzor_Aoe(Unit, Event) 
Unit:SendChatMessage(14, 0, "I will not be touched by a rebel such as you.")
Unit:PlaySoundToSet(11479)
Unit:CastSpell(43418, Unit:GetClosestPlayer()) 
end

function Rhahkzor_Sheep(Unit, Event)
Unit:FullCastSpellOnTarget(28271, Unit:GetRandomPlayer(0))
end

function Rhahkzor_Cleave(Unit, Event) 

Unit:FullCastSpellOnTarget(38226, Unit:GetRandomPlayer(0)) 

Unit:SendChatMessage(14, 0, "This is to easy.")
Unit:PlaySoundToSet(11472)
end



function Rhahkzor_Transformation(Unit, Event) 
if Unit:GetHealthPct() < 40 then 
Unit:RemoveEvents(); 
Unit:SendChatMessage(14, 0, "You are not prepared! ")
Unit:SetModel(19135)
Unit:FullCastSpell(14204)
Unit:PlaySoundToSet(11466)
Unit:CastSpell(28131)
end 
end

function Rhankzor_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
Unit:SetModel (18718) 
end


function Rhahkzor_OnDied(Unit, Event) 
Unit:RemoveEvents() 
Unit:SendChatMessage(12, 0, "NOO! This cant be..my..brothers will.. avenge my death. ") 
Unit:SetModel (18718)
end

function Rhahkzor_OnKilledTarget(Unit, Event) 
Unit:SendChatMessage(14, 0, "Who shall be next to taste my blades?") 
Unit:PlaySoundToSet(11473)
end

RegisterUnitEvent(746435, 1, "Rhahkzor_OnCombat")
RegisterUnitEvent(746435, 2, "Rhankzor_OnLeaveCombat")
RegisterUnitEvent(746435, 3, "Rhahkzor_OnKilledTarget")
RegisterUnitEvent(746435, 4, "Rhahkzor_OnDied")