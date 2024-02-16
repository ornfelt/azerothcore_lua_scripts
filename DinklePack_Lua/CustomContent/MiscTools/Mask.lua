local Masks = {}

Masks.Tables = {
    Alliance_races = {1, 3, 4, 7, 11, 12, 13, 15, 16, 19}, -- Replace with your actual Alliance race IDs
    Horde_races = {2, 5, 6, 8, 9, 10, 14, 17, 18, 20}, -- Replace with your actual Horde race IDs
    Classes = {1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 13, 14, 15},
    Demon_Hunter_Races = {14, 15} -- Replace with your actual class IDs
}

function Masks.calculateMask(ids)
    local mask = 0
    for _, id in ipairs(ids) do
        mask = mask + 2^(id - 1)
    end
    return mask
end

function Masks.Command(event, player, command)
    if command:lower() == "masks" then
        local raceMask = player:GetRaceMask()
        local classMask = player:GetClassMask()

        player:SendBroadcastMessage("Your race mask ID is: " .. tostring(raceMask))
        player:SendBroadcastMessage("Your class mask ID is: " .. tostring(classMask))

        local allianceMask = Masks.calculateMask(Masks.Tables.Alliance_races)
        local hordeMask = Masks.calculateMask(Masks.Tables.Horde_races)
        local classesMask = Masks.calculateMask(Masks.Tables.Classes)

        player:SendBroadcastMessage("The overall mask for Alliance races is: " .. tostring(allianceMask))
        player:SendBroadcastMessage("The overall mask for Horde races is: " .. tostring(hordeMask))
        player:SendBroadcastMessage("The overall mask for Alliance/Horde races is: " .. tostring(hordeMask + allianceMask))
        player:SendBroadcastMessage("The overall mask for classes is: " .. tostring(classesMask))
    elseif command:lower() == "dhmask" then
        local dhMask = Masks.calculateMask(Masks.Tables.Demon_Hunter_Races)
        player:SendBroadcastMessage("The overall mask for Demon Hunter races is: " .. tostring(dhMask))
    else
        return
    end

    return false
end

RegisterPlayerEvent(42, Masks.Command)
