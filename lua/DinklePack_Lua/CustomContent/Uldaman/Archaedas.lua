local ArchaedasEvent = {}

ArchaedasEvent.NPC_IDS = {
    ARCHAEDAS = 2748,
    EARTHEN_GUARDIAN = 7076,
    VAULT_WARDER = 10120
}
ArchaedasEvent.OBJECT_ID = 133234
ArchaedasEvent.HOSTILE_FACTION = 14

function ArchaedasEvent.SetHostileAndEnterCombat(player, entry, activateOne)
    local creatures = player:GetCreaturesInRange(100, entry)
    for _, creature in ipairs(creatures) do
        if not creature:IsInCombat() then
            creature:SetFaction(ArchaedasEvent.HOSTILE_FACTION)
            creature:SetReactState(1) 
            creature:RemoveAllAuras() -- Remove Auras with Crowd Control effect
            creature:AttackStart(player)
            if activateOne then
                break
            end
        end
    end
end

function ArchaedasEvent.ActivateNextVaultWarder(event, creature, killer)
    local creatures = creature:GetCreaturesInRange(100, ArchaedasEvent.NPC_IDS.VAULT_WARDER)
    for _, nextCreature in ipairs(creatures) do
        if not nextCreature:IsInCombat() then
            nextCreature:SetFaction(ArchaedasEvent.HOSTILE_FACTION)
            nextCreature:SetReactState(1) 
            nextCreature:RemoveAllAuras() -- Remove Auras with Crowd Control effect
            nextCreature:AttackStart(killer)
            break
        end
    end
end

function ArchaedasEvent.RoomObjectUse(event, go, player)
    if not player:IsInCombat() then
        player:SendBroadcastMessage("Archaedas, the Earthen Guardians, and the Vault Warders are waking up...")

        ArchaedasEvent.SetHostileAndEnterCombat(player, ArchaedasEvent.NPC_IDS.ARCHAEDAS, false)
        ArchaedasEvent.SetHostileAndEnterCombat(player, ArchaedasEvent.NPC_IDS.EARTHEN_GUARDIAN, false)
        ArchaedasEvent.SetHostileAndEnterCombat(player, ArchaedasEvent.NPC_IDS.VAULT_WARDER, true)
    else
        player:SendBroadcastMessage("You cannot use the object while in combat.")
    end

    return true
end

RegisterGameObjectEvent(ArchaedasEvent.OBJECT_ID, 14, ArchaedasEvent.RoomObjectUse)
RegisterCreatureEvent(ArchaedasEvent.NPC_IDS.VAULT_WARDER, 4, ArchaedasEvent.ActivateNextVaultWarder)
