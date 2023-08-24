local npcId = 400092
local spellId = 100199
local range = 8
local killCreditNpcId = 400095

function OnSpellCast(event, player, spell)
if spell:GetEntry() == spellId then
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



