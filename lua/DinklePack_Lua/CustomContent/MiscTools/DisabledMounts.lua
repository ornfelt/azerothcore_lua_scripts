local PlayerMountControl = {}

PlayerMountControl.SPELL_IDS = {
    SPELL1 = 41515,
    SPELL2 = 60025,
    SPELL3 = 100150,
    SPELL4 = 80029,
    SPELL5 = 80097,
    SPELL6 = 100192
}

function PlayerMountControl.OnPlayerCastMountSpell(event, player, spell)
    local map = player:GetMap()
    if map and (map:IsDungeon() or map:IsBattleground()) then
        local spellId = spell:GetEntry()
        if spellId == PlayerMountControl.SPELL_IDS.SPELL1 or 
           spellId == PlayerMountControl.SPELL_IDS.SPELL2 or 
           spellId == PlayerMountControl.SPELL_IDS.SPELL3 or 
           spellId == PlayerMountControl.SPELL_IDS.SPELL4 or 
           spellId == PlayerMountControl.SPELL_IDS.SPELL5 or 
           spellId == PlayerMountControl.SPELL_IDS.SPELL6 then
            spell:Cancel()
            player:StopSpellCast(spellId)
            player:SendBroadcastMessage("You cannot use that here.")
        end
    end
end

RegisterPlayerEvent(5, PlayerMountControl.OnPlayerCastMountSpell)
