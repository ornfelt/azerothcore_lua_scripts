local NomadChallenge = {}

NomadChallenge.FORBIDDEN_SPELLS = {
    [8690] = true, [54318] = true, [54401] = true, [3561] = true, 
    [3562] = true, [3563] = true, [3565] = true, [3566] = true, 
    [3567] = true, [3578] = true, [556] = true
}

NomadChallenge.ITEM_ID = 800085

function NomadChallenge.OnBeforeCast(event, player, spell, skipCheck)
    if player:HasItem(NomadChallenge.ITEM_ID) then
        local spell_id = spell:GetEntry()
        if NomadChallenge.FORBIDDEN_SPELLS[spell_id] then
            player:SendNotification("Trying to sneak a teleport in Nomad Challenge Mode, huh? Nice try, but the only 'teleport' here is leg power!")
            spell:Cancel()
            return false
        end
    end
end

RegisterPlayerEvent(5, NomadChallenge.OnBeforeCast)
