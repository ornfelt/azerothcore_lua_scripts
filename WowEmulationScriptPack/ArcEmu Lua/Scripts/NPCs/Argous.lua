--Scripted by Olabvii
--For http://www.cna-wow.com/

function argous_OnCombat(pUnit, Event)
pUnit:SendChatMessage(14, 0, "You Think You can Beat the ELEMENTS!?")
pUnit:RegisterEvent("argous_lightning", 5000, 0)
pUnit:RegisterEvent("argous_phase2", 1000, 0)
end

function argous_lightning(pUnit, Event)
pUnit:CastSpellOnTarget(9532, pUnit:GetMainTank())
end


function argous_phase2(pUnit, Event)
if pUnit:GetHealthPct() <=75 then
pUnit:RemoveEvents()
pUnit:SendChatMessage(14, 0, "Water Embrace me!") 
pUnit:SetModel(525)
pUnit:RegisterEvent("argous_waterbolt", 6000, 0)
pUnit:RegisterEvent("argous_phase3", 1000, 0)
end
end

function argous_waterbolt(pUnit, Event)
pUnit:CastSpellOnTarget(31707, pUnit:GetMainTank())
end

function argous_phase3(pUnit, Event)
if pUnit:GetHealthPct() <=55 then
pUnit:RemoveEvents()
pUnit:SendChatMessage(14, 0, "Fire Embrace me!")
pUnit:SetModel(2172)
pUnit:RegisterEvent("argous_fireblast", 5000, 0)
pUnit:RegisterEvent("argous_phase4", 1000, 0)
end
end

function argous_fireblast(pUnit, Event)
pUnit:CastSpellOnTarget(36339, pUnit:GetMainTank())
end


function argous_phase4(pUnit, Event)
if pUnit:GetHealthPct() <=25 then
pUnit:RemoveEvents()
pUnit:SetModel(453)
pUnit:SendChatMessage(14, 0, "Earth Embrace Me!")
pUnit:RegisterEvent("argous_earthshock", 8000, 0)
end
end

function argous_earthshock(pUnit, Event)
pUnit:CastSpellOnTarget(8042, pUnit:GetMainTank())
end



function argous_OnLeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function argous_OnKilledTarget(pUnit, Event)
pUnit:SendChatMessage(14, 0, "Another Life Taken!")
end

function argous_OnDeath(pUnit, Event)
pUnit:SendChatMessage(14, 0, "I CAN`T BELIVE IT...")
pUnit:RemoveEvents()
end


RegisterUnitEvent(941001, 1, "argous_OnCombat")
RegisterUnitEvent(941001, 2, "argous_OnLeaveCombat")
RegisterUnitEvent(941001, 3, "argous_OnKilledTarget")
RegisterUnitEvent(941001, 4, "argous_OnDeath")