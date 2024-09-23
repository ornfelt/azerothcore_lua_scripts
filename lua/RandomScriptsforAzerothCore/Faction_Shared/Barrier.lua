local npcId = 400092
local spellId1 = 100199
local spellId2 = 100206
local range = 8
local killCreditNpcId = 400095

function OnSpellCast(event, player, spell)
    local spellEntry = spell:GetEntry()

    if spellEntry == spellId1 or spellEntry == spellId2 then
        nearestCreature = player:GetNearestCreature(range, npcId)
        if nearestCreature == nil then
            player:SendBroadcastMessage("You need to place the barrier in a more strategic location.")
            spell:Cancel()
        else
            player:KilledMonsterCredit(killCreditNpcId)
            player:SendBroadcastMessage("You have successfully built a barrier!")
        end
    end
end

RegisterPlayerEvent(5, OnSpellCast)
