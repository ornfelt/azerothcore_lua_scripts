local ShadowAss = {}

ShadowAss.CREATURE_ID = 2434 
ShadowAss.RANGE = 15 
ShadowAss.SPELL_ID = 1786 
ShadowAss.AURA_ID = 42347 
ShadowAss.DELAY = 3000 

function ShadowAss.CheckNearbyCreatures(event, creature)
    creature:AddAura(ShadowAss.SPELL_ID, creature)

    local creaturesNearby = creature:GetCreaturesInRange(ShadowAss.RANGE, ShadowAss.CREATURE_ID)
    if #creaturesNearby > 0 then
        creature:DespawnOrUnsummon(0)
    end
end

function ShadowAss.AddAuraOnLeaveCombat(event, creature)
    creature:AddAura(ShadowAss.SPELL_ID, creature)
end

RegisterCreatureEvent(ShadowAss.CREATURE_ID, 5, ShadowAss.CheckNearbyCreatures)
RegisterCreatureEvent(ShadowAss.CREATURE_ID, 2, ShadowAss.AddAuraOnLeaveCombat)
