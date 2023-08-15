--[[=========================================
   Eonar.lua
   Original Code by zdroid9770
   Version 5
========================================]]--
-- % Complete: 100%



function Boss_OnCombat(pUnit, Event)
        pUnit:SendChatMessage(14, 0, "You dare Enter my City!")
        pUnit:SetModel(20510)
        pUnit:SetScale(0.5)
        pUnit:RegisterEvent("Boss_Spell", 5000, 0)
        pUnit:RegisterEvent("Boss_Phase1", 25000, 1)
end

function Boss_Spell(pUnit, Event)
        pUnit:CastSpellOnTarget(31422, pUnit:GetMainTank())
end

function Boss_Phase1(pUnit, Event)
   if pUnit:GetHealthPct() <= 50 then
        pUnit:RemoveEvents()
        pUnit:FullCastSpellOnTarget(40504, pUnit:GetMainTank())
        pUnit:RegisterEvent("Boss_Spell1", 5000, 0)
    end
end

function Boss_Spell1(pUnit, Event)
        pUnit:CastSpellOnTarget(39049, pUnit:GetMainTank())
        pUnit:RegisterEvent("Boss_Spell2", 30000, 0)
end

function Boss_Spell2(pUnit, Event)
        pUnit:CastSpellOnTarget(21131, pUnit:GetMainTank())
        pUnit:RegisterEvent("Boss_Spell3", 10000, 0)
end

function Boss_Spell3(pUnit, Event)
        pUnit:CastSpellOnTarget(69293, pUnit:GetMainTank())
        pUnit:RegisterEvent("Boss_Spell4", 16000, 0)
end

function Boss_Spell4(pUnit, Event)
        pUnit:CastSpellOnTarget(69286, pUnit:GetMainTank())
        pUnit:RemoveEvents()
end

function Boss_OnLeaveCombat(pUnit, Event)
        pUnit:SendChatMessage(14, 0, "You are fools!")
end

function Boss_OnKilledTarget(pUnit, Event)
        pUnit:SendChatMessage(12, 0, "you are all weak...")
end

function Boss_OnDeath(pUnit, Event)
        pUnit:DeMorph()
        pUnit:SendChatMessage(14, 0, "NOO! This is Impossible! I... I will have my revenge!! YOU HEAR ME?! I WILL HAVE MY REVENGE!!")
        pUnit:RemoveEvents()
end




RegisterUnitEvent(100104, 1, "Boss_OnCombat")
RegisterUnitEvent(100104, 2, "Boss_OnLeaveCombat")
RegisterUnitEvent(100104, 3, "Boss_OnKilledTarget")
RegisterUnitEvent(100104, 4, "Boss_OnDeath")