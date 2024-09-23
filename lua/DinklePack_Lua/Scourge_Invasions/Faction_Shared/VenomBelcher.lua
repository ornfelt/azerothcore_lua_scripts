local VenomBelcherw = {}

VenomBelcherw.NPC_ID = 10417

function VenomBelcherw.VenomSpit(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 24011, true)
end

function VenomBelcherw.SlowingPoison(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 14897, true)
end

function VenomBelcherw.CastRetchingPlague(eventId, delay, calls, creature)
    local targets = creature:GetAITargets(10)
    if #targets == 0 then
        return
    end
    local target = targets[math.random(#targets)]
    creature:CastSpell(target, 30080, true)
end

function VenomBelcherw.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(VenomBelcherw.VenomSpit, 7000, 0)
    creature:RegisterEvent(VenomBelcherw.CastRetchingPlague, 13000, 0)
    creature:RegisterEvent(VenomBelcherw.SlowingPoison, 16000, 0)
end

function VenomBelcherw.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function VenomBelcherw.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(VenomBelcherw.NPC_ID, 1, VenomBelcherw.OnEnterCombat)
RegisterCreatureEvent(VenomBelcherw.NPC_ID, 2, VenomBelcherw.OnLeaveCombat)
RegisterCreatureEvent(VenomBelcherw.NPC_ID, 4, VenomBelcherw.OnDied)
