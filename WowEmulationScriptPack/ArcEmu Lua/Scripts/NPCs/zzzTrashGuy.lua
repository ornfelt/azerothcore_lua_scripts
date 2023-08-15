function Naga_OnEnterCombat(pUnit,Event)
pUnit:RegisterEvent("Naga_SpellAoe", 10000, 0)
end

function Naga_SpellAoe(pUnit,Event)
       Choice=math.random(1, 4)
                if Choice==1 then
                pUnit:FullCastSpellOnTarget(20692, pUnit:GetRandomPlayer(0))
                end 
                if Choice==2 then
                pUnit:FullCastSpellOnTarget(32364, pUnit:GetRandomPlayer(0))
                end
                if Choice==3 then
                pUnit:FullCastSpellOnTarget(11, pUnit:GetRandomPlayer(0))
                end
                if Choice==4 then
                pUnit:FullCastSpellOnTarget(29879, pUnit:GetRandomPlayer(0))
                end
end

function Naga_OnLeaveCombat(pUnit, event)
pUnit:RemoveEvents()
end

function Naga_Death(pUnit)
pUnit:RemoveEvents()
end

RegisterUnitEvent(973632, 1, "Naga_OnEnterCombat")
RegisterUnitEvent(973632, 2, "Naga_OnLeaveCombat")
RegisterUnitEvent(973632, 4, "Naga_Death")