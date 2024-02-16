local FirstLogin = {}
FirstLogin.SPELL_ID = 26

function FirstLogin.OnFirstLogin(event, player)
    player:RegisterEvent(FirstLogin.BindPlayer, 4500, 1)
end

function FirstLogin.BindPlayer(eventId, delay, calls, player)
    player:CastSpell(player, FirstLogin.SPELL_ID, true)
end

RegisterPlayerEvent(30, FirstLogin.OnFirstLogin)
