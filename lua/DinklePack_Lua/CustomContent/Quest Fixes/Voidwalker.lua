local VoidwalkerSummoner = {}

VoidwalkerSummoner.SPELL_ID = 7728
VoidwalkerSummoner.NPC_ENTRY = 5676
VoidwalkerSummoner.SUMMON_DISTANCE = 5
VoidwalkerSummoner.DESPAWN_TIMER = 60000

function VoidwalkerSummoner.SummonVoidwalker(event, player, spell, skipCheck)
    if spell:GetEntry() == VoidwalkerSummoner.SPELL_ID then
        local x, y, z, o = player:GetLocation()
        x = x + math.cos(o) * VoidwalkerSummoner.SUMMON_DISTANCE
        y = y + math.sin(o) * VoidwalkerSummoner.SUMMON_DISTANCE
        player:SpawnCreature(VoidwalkerSummoner.NPC_ENTRY, x, y, z, o, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, VoidwalkerSummoner.DESPAWN_TIMER)
    end
end

RegisterPlayerEvent(5, VoidwalkerSummoner.SummonVoidwalker)
