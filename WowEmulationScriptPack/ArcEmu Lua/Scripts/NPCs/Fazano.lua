function Fazano_OnCombat(pUnit, event) 
pUnit:SendChatMessage(14, 0, "So... Intruders eh? Lucky you got this far!")
pUnit:RegisterEvent("Fazano_Firebolt", 3500, 20)
pUnit:RegisterEvent("Fazano_Fireblast", 0, 5)
pUnit:RegisterEvent("Fazano_Coneoffire", 5000, 2)
pUnit:RegisterEvent("Fazano_Fireaoe", 2500, 8)
pUnit:RegisterEvent("Fazano_Charge", 0, 2)
pUnit:RegisterEvent("Fazano_Transform", 1000, 0) 
end

function Fazano_Firebolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(18392, pUnit:GetMainTank(1))
end

function Fazano_Fireblast(pUnit, Event) 
pUnit:FullCastSpellOnTarget(20623, pUnit:GetRandomPlayer(1))
end
               
function Fazano_Coneoffire(pUnit, Event) 
pUnit:FullCastSpellOnTarget(36921, pUnit:GetClosestPlayer(1))
end
                
function Fazano_Fireaoe(pUnit, Event) 
pUnit:CastSpell(46551, pUnit:GetClosestPlayer(1))
end
               
function Fazano_Charge(pUnit, Event) 
pUnit:FullCastSpellOnTarget(40497, pUnit:GetRandomPlayer(1))
end

function Fazano_Transform(pUnit, event) 
if pUnit:GetHealthPct() < 20 then 
pUnit:RemoveEvents()
pUnit:FullCastSpell(37538)
pUnit:SetModel(21021)
pUnit:RegisterEvent("Fazano_Firebolt", 3500, 20)
pUnit:RegisterEvent("Fazano_Fireblast", 0, 5)
pUnit:RegisterEvent("Fazano_Coneoffire", 5000, 2)
pUnit:RegisterEvent("Fazano_Fireaoe", 2500, 8)
pUnit:RegisterEvent("Fazano_Charge", 0, 2)
end 
end

function Fazano_OnLeaveCombat(pUnit, event) 
pUnit:RemoveEvents() 
end

function Fazano_OnKilledTarget(pUnit, event) 
pUnit:SendChatMessage(14, 0, "Hehe, as i told you just pure luck....") 
end

function Fazano_OnDied(pUnit, event) 
pUnit:SendChatMessage(12, 0, "Noooooooo!")
pUnit:RemoveEvents()
pUnit:SetModel(9472)
pUnit:PlaySoundToSet(12530)
end

RegisterUnitEvent(65022, 1, "Fazano_OnCombat")
RegisterUnitEvent(65022, 2, "Fazano_OnLeaveCombat")
RegisterUnitEvent(65022, 3, "Fazano_OnKilledTarget")
RegisterUnitEvent(65022, 4, "Fazano_OnDied")