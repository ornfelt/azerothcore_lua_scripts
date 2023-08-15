function On_Player_Create(event, player)
    player:LearnSpell(90001)
end

RegisterPlayerEvent(30, On_Player_Create) 