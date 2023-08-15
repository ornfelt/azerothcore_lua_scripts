function Kaino_OnCombat(pUnit, event) 
pUnit:SendChatMessage(12, 0, "hmm, lucky you got this far. well... this is where your luck ends!")
pUnit:PlaySoundToSet(12535)
pUnit:RegisterEvent("Kaino_Rend", 1000, 0)
end

function Kaino_Stun(pUnit, event) 
pUnit:FullCastSpellOnTarget(15283, pUnit:GetRandomPlayer(1)) 
end

function Kaino_Burningwind(pUnit, event) 
pUnit:FullCastSpellOnTarget(17293, pUnit:GetRandomPlayer(1)) 
end

function Kaino_Rend(pUnit, event) 
if pUnit:GetHealthPct() < 98 then 
pUnit:RemoveEvents()
pUnit:FullCastSpell(31256)
pUnit:FullCastSpellOnTarget(18200, pUnit:GetMainTank(1))
pUnit:RegisterEvent("Kaino_Mortalstrike", 1000, 0)
pUnit:RegisterEvent("Kaino_Stun", 0, 1)
pUnit:RegisterEvent("Kaino_Burningwind", 2000, 5)
end 
end

function Kaino_Mortalstrike(pUnit, event) 
if pUnit:GetHealthPct() < 70 then 
pUnit:RemoveEvents() 
pUnit:FullCastSpellOnTarget(15708, pUnit:GetMainTank(1))
pUnit:RegisterEvent("Kaino_Gogue", 1000, 0)
pUnit:RegisterEvent("Kaino_Burningwind", 2000, 5)
pUnit:RegisterEvent("Kaino_Stun", 0, 1)
end 
end

function Kaino_Gogue(pUnit, event) 
if pUnit:GetHealthPct() < 50 then 
pUnit:RemoveEvents()
pUnit:FullCastSpell(24021)
pUnit:SetScale(2)
pUnit:RegisterEvent("Kaino_Burningwind", 2000, 5)
pUnit:RegisterEvent("Kaino_Stun", 0, 1)
end 
end

function Kaino_OnDied(pUnit, event) 
pUnit:RemoveEvents() 
pUnit:SendChatMessage(14, 0, "NOO!!! THIS CAN'T BE!!!!") 
end

function Kaino_OnKilledTarget(pUnit, event) 
pUnit:SendChatMessage(14, 0, "Well well, told you didnt i? YOU CAN'T BEAT ME!") 
end

RegisterUnitEvent(65023, 1, "Kaino_OnCombat")
RegisterUnitEvent(65023, 3, "Kaino_OnKilledTarget")
RegisterUnitEvent(65023, 4, "Kaino_OnDied")