local PacifistChallenge = {}

PacifistChallenge.ITEM_PACIFIST = 800051
PacifistChallenge.SPELL_FAILURE = 80092

function PacifistChallenge.HasItem(player, itemId)
    return player:HasItem(itemId)
end

function PacifistChallenge.IsPlayer(unit)
    return unit:IsPlayer()
end

function PacifistChallenge.OnKill(event, killer, killed)
    if PacifistChallenge.IsPlayer(killer) and PacifistChallenge.HasItem(killer, PacifistChallenge.ITEM_PACIFIST) then
        killer:CastSpell(killer, PacifistChallenge.SPELL_FAILURE, true)
        killer:RemoveItem(PacifistChallenge.ITEM_PACIFIST, 1)
        killer:PlayDirectSound(183253)
        killer:SendBroadcastMessage("|cFFFF0000You have failed the pacifist challenge mode!|r")
    end
end

RegisterPlayerEvent(6, PacifistChallenge.OnKill)
RegisterPlayerEvent(7, PacifistChallenge.OnKill)
