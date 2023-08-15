-- 2D's LUA

function Dorikazor_Phase1(Unit, event)
    if Unit:GetHealthPct() < 72 then
        Unit:RemoveEvents()
        Unit:SendChatMessage(12, 0, "Feel my Pain that I get!")
        Unit:CastSpell(36841)
                Unit:RegisterEvent("Dorikazor_lightning",4000, 0)
        Unit:RegisterEvent("Dorikazor_Phase2",1000, 0)
    end
end

function Dorikazor_lightning(Unit)
    Unit:CastSpell(36841)
        Unit:SendChatMessage(12, 0, "Die! Die!")
end


function Dorikazor_Phase2(Unit, event)
    if Unit:GetHealthPct() < 62 then
        Unit:RemoveEvents()
        Unit:SendChatMessage(12, 0, "Run Away I will kill you!")
        Unit:CastSpell(41276)
        Unit:RegisterEvent("Dorikazor_Meteor",8000, 0)
        Unit:RegisterEvent("Dorikazor_Phase3",1000, 0)
    end
end

function Dorikazor_Meteor(Unit)
    Unit:CastSpell(41276)
end


function Dorikazor_Phase3(Unit, event)
    if Unit:GetHealthPct() < 52 then
        Unit:RemoveEvents()
        Unit:SendChatMessage(12, 0, "Your life is over soon!")
        Unit:SetModel(18945)
        Unit:RegisterEvent("Dorikazor_morph",0, 0)
        Unit:RegisterEvent("Dorikazor_Phase4",1000, 0)
    end
end

function Dorikazor_morph(Unit)
    Unit:SetModel(18945)
end

function Dorikazor_Phase4(Unit, event)
    if Unit:GetHealthPct() <= 26 then
        Unit:RemoveEvents()
        Unit:SetCombatCapable(1)
        Unit:SetScale(3)
        Unit:CastSpell(31984)
        Unit:SendChatMessage(12, 0, "YOU WONT KILL ME!")
        Unit:RegisterEvent("Dorikazor_Beam",7000, 0)
    end
end

function Dorikazor_Deathfinger(Unit, event)
    Unit:RemoveEvents()
    Unit:SetScale(5)
    Unit:CastSpell(31984)
    Unit:SetCombatCapable(0)
    Unit:SendChatMessage(12, 0, "Fear my Death!")
end

function Dorikazor_OnCombat(Unit, event)
    Unit:SendChatMessage(11, 0, "What do you want from me!")
    Unit:RegisterEvent("Dorikazor_Phase1",1000, 0)
    Unit:RegisterEvent("Dorikazor_lightning",6000, 0)
end

function Dorikazor_OnLeaveCombat(Unit)
    Unit:RemoveEvents()
end

function Dorikazor_OnKilledTarget(Unit)
    Unit:SendChatMessage(11, 0, "Haha, who's next?")
    Unit:CastSpell(5)
end

function Dorikazor_Death(Unit)
    Unit:SendChatMessage(12, 0, "This cannot be possible!I'm the strongest,I'm...")
    Unit:RemoveEvents()
end

RegisterUnitEvent(250252, 1, "Dorikazor_OnCombat")
RegisterUnitEvent(250252, 2, "Dorikazor_OnLeaveCombat")
RegisterUnitEvent(250252, 3, "Dorikazor_OnKilledTarget")
RegisterUnitEvent(250252, 4, "Dorikazor_Death")