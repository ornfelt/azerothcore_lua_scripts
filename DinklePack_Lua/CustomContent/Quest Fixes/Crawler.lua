local CrawlerBoi = {}

CrawlerBoi.NPC_ID = 3812
CrawlerBoi.SPELL_IDS = {
    CLAW = 16829
}

function CrawlerBoi.CastClaw(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), CrawlerBoi.SPELL_IDS.CLAW, true)
end
    
function CrawlerBoi.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(CrawlerBoi.CastClaw, 4000, 0)
end

function CrawlerBoi.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function CrawlerBoi.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

RegisterCreatureEvent(CrawlerBoi.NPC_ID, 1, CrawlerBoi.OnEnterCombat)
RegisterCreatureEvent(CrawlerBoi.NPC_ID, 2, CrawlerBoi.OnLeaveCombat)
RegisterCreatureEvent(CrawlerBoi.NPC_ID, 4, CrawlerBoi.OnDied)
