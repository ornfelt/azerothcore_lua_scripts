function Armycovazuz_OnCombat(pUnit, event) 
pUnit:SendChatMessage(14, 0, "What have we here!?! Insects? Your dead!")
pUnit:RegisterEvent("Armycovazuz_Wrath", 2500, 100)
pUnit:RegisterEvent("Armycovazuz_Starfire", 3500, 5)
pUnit:RegisterEvent("Armycovazuz_Arcaneexplo", 1000, 2)
pUnit:RegisterEvent("Armycovazuz_Curse", 0, 12)
pUnit:RegisterEvent("Armycovazuz_Heal", 1000, 0)
end

function Armycovazuz_Wrath(pUnit, event) 
pUnit:FullCastSpellOnTarget(20698, pUnit:GetRandomPlayer(1)) 
end

function Armycovazuz_Starfire(pUnit, event) 
pUnit:FullCastSpellOnTarget(38935, pUnit:GetMainTank(1)) 
end

function Armycovazuz_Arcaneexplo(pUnit, event) 
pUnit:CastSpell(19712, pUnit:GetClosestPlayer(1)) 
end

function Armycovazuz_Curse(pUnit, event) 
pUnit:FullCastSpellOnTarget(39647, pUnit:GetRandomPlayer(1)) 
end

function Armycovazuz_Mangle(pUnit, event) 
pUnit:FullCastSpellOnTarget(44955, pUnit:GetMainTank(1)) 
end

function Armycovazuz_Bleed(pUnit, event) 
pUnit:FullCastSpellOnTarget(33912, pUnit:GetMainTank(1))
end

function Armycovazuz_Stun(pUnit, event) 
pUnit:FullCastSpellOnTarget(36877, pUnit:GetRandomPlayer(1))
end

function Armycovazuz_Heal(pUnit, event) 
if pUnit:GetHealthPct() < 55 then 
pUnit:RemoveEvents()
pUnit:FullCastSpell(27527)
pUnit:RegisterEvent("Armycovazuz_transform", 1000, 0)
pUnit:RegisterEvent("Armycovazuz_Wrath", 1000, 20)
pUnit:RegisterEvent("Armycovazuz_Starfire", 3500, 5)
end 
end

function Armycovazuz_transform(pUnit, event) 
if pUnit:GetHealthPct() < 25 then 
pUnit:RemoveEvents()
pUnit:FullCastSpell(768)
pUnit:FullCastSpell(34971)
pUnit:SetModel(15290)
pUnit:SetScale(3)
pUnit:RegisterEvent("Armycovazuz_Mangle", 0, 20)
pUnit:RegisterEvent("Armycovazuz_Bleed", 0, 20)
pUnit:RegisterEvent("Armycovazuz_Stun", 1000, 2)
end 
end

function Armycovazuz_OnLeaveCombat(pUnit, event) 
pUnit:RemoveEvents() 
end

function Armycovazuz_OnDied(pUnit, event) 
pUnit:RemoveEvents() 
pUnit:SendChatMessage(12, 0, "huh what? i lost! NOOO!!!") 
end

function Armycovazuz_OnKilledTarget(pUnit, event) 
pUnit:SendChatMessage(12, 0, "Well well, that was a easy one....") 
end

RegisterUnitEvent(65010, 1, "Armycovazuz_OnCombat")
RegisterUnitEvent(65010, 2, "Armycovazuz_OnLeaveCombat")
RegisterUnitEvent(65010, 3, "Armycovazuz_OnKilledTarget")
RegisterUnitEvent(65010, 4, "Armycovazuz_OnDied")