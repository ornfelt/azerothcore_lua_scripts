function Patchwerk_PoisonBoltVolley(pUnit, event)
     pUnit:FullCastSpell(32309)
end

function Patchwerk_Berserk(pUnit, event)
     pUnit:SendChatMessage(16, 0, "Patchwerk goes into a berserker rage!")
     pUnit:CastSpell(26662)
     pUnit:RegisterEvent("Patchwerk_PoisonBoltVolley", 4000, 0)
end

function Patchwerk_Enrage(pUnit, event)
     local vars=getvars(pUnit)
     if pUnit:GetHealthPct() <= 5 and vars.phase == nil then
     	pUnit:SendChatMessage(16, 0, "Patchwerk becomes enraged!")
        pUnit:CastSpell(28131)
        setvars(pUnit, {phase=1})
     end
end

function Patchwerk_HatefulStrike(pUnit, event)
     local tbl=pUnit:GetInRangePlayers()
     for k,v in pairs(tbl) do
     	if v:GetDistance(pUnit) <= 10 then
           if v:GetHealth() > v:GetHealth() then
              pUnit:FullCastSpellOnTarget(28308, v)
           end
        end
     end
end

function Patchwerk_OnEnterCombat(pUnit, event)
     setvars(pUnit, {phase=nil})
     pUnit:SendChatMessage(14, 0, "Patchwerk want to play.")
     pUnit:RegisterEvent("Patchwerk_Berserk", 420000, 1)
     pUnit:RegisterEvent("Patchwerk_Enrage", 1000, 0)
     pUnit:RegisterEvent("Patchwerk_HatefulStrike", 1200, 0)
end

RegisterUnitEvent(16028, 1, "Patchwerk_OnEnterCombat")

function Patchwerk_OnWipe(pUnit, event)
     pUnit:RemoveEvents()
end

RegisterUnitEvent(16028, 2, "Patchwerk_OnWipe")