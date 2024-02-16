local PVPEvents = {}
PVPEvents.SPELL_ID = 80094

function PVPEvents.OnPlayerCastSpell(event, player, spell, skipCheck)
    if spell:GetEntry() ~= PVPEvents.SPELL_ID then
        return
    end

    local map = player:GetMap()
    if map:IsDungeon() or map:IsBattleground() or map:IsArena() or map:IsRaid() then
        spell:Cancel()
        player:StopSpellCast(PVPEvents.SPELL_ID)
    end
end

function PVPEvents.OnPlayerChangeMap(event, player)
    if not player:HasAura(PVPEvents.SPELL_ID) then
        return
    end

    local map = player:GetMap()
    if map:IsDungeon() or map:IsBattleground() or map:IsRaid() or map:IsArena() then
        player:RemoveAura(PVPEvents.SPELL_ID)
    end
end

RegisterPlayerEvent(28, PVPEvents.OnPlayerChangeMap)
RegisterPlayerEvent(5, PVPEvents.OnPlayerCastSpell)
