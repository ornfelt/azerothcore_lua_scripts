local GobberSummon = {}

GobberSummon.GOBBER_ENTRY = 36613
GobberSummon.SUMMON_SPELL = 69046

function GobberSummon.OnSpellCast(event, player, spell)
    if spell:GetEntry() == GobberSummon.SUMMON_SPELL then
        local x, y, z, o = player:GetLocation()
        local gobber = player:SpawnCreature(GobberSummon.GOBBER_ENTRY, x, y, z, o, 3, 60000) -- 3 for TEMPSUMMON_TIMED_DESPAWN, 60000 ms (1 minute) for despawnTimer
        if gobber then
            gobber:MoveFollow(player, 1, math.pi / 2)
        end
    end
end

RegisterPlayerEvent(5, GobberSummon.OnSpellCast)
