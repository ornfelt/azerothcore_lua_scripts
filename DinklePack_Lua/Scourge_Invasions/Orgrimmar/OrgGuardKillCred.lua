local HealingEvent = {}

HealingEvent.TARGET_NPC_IDS = {400059, 400060, 400061, 400014, 400041, 400040, 400039, 3296}
HealingEvent.SPELL_ID = 100183
HealingEvent.CREDIT_NPC_ID = 400039

function HealingEvent.OnSpellCast(event, player, spell)
    local target = spell:GetTarget()

    if target and spell:GetEntry() == HealingEvent.SPELL_ID then
        local isValidTarget = false

        for _, NPCID in ipairs(HealingEvent.TARGET_NPC_IDS) do
            if target:GetEntry() == NPCID then
                isValidTarget = true
                break
            end
        end

        if not isValidTarget or target:GetHealthPct() > 90 then
            player:SendBroadcastMessage("That defender is doing fine. Find one that needs more help!")
            spell:Cancel()
        else
            player:KilledMonsterCredit(HealingEvent.CREDIT_NPC_ID)
        end
    end
end

RegisterPlayerEvent(5, HealingEvent.OnSpellCast)
