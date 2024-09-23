BarrierBuilderModule = {}

BarrierBuilderModule.npcId = 400092
BarrierBuilderModule.spellId1 = 100199
BarrierBuilderModule.spellId2 = 100206
BarrierBuilderModule.range = 8
BarrierBuilderModule.killCreditNpcId = 400095

function BarrierBuilderModule.OnSpellCast(event, player, spell)
    local spellEntry = spell:GetEntry()

    if spellEntry == BarrierBuilderModule.spellId1 or spellEntry == BarrierBuilderModule.spellId2 then
        nearestCreature = player:GetNearestCreature(BarrierBuilderModule.range, BarrierBuilderModule.npcId)
        if nearestCreature == nil then
            player:SendBroadcastMessage("You need to place the barrier in a more strategic location.")
            spell:Cancel()
        else
            player:KilledMonsterCredit(BarrierBuilderModule.killCreditNpcId)
            player:SendBroadcastMessage("You have successfully built a barrier!")
        end
    end
end

RegisterPlayerEvent(5, BarrierBuilderModule.OnSpellCast)
