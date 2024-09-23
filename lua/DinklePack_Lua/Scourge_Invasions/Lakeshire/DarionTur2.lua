local DamionTur = {}
DamionTur.NPC_ID = 400079
DamionTur.SOUND_ID = 183260

function DamionTur.OnSpawn(event, creature)
    creature:PlayDirectSound(DamionTur.SOUND_ID)
end

RegisterCreatureEvent(DamionTur.NPC_ID, 5, DamionTur.OnSpawn)
