local TUR_ID = {400038, 400037}
local SPELL_ID = 100181

function OnSpellCast(event, caster, spell)
local target = spell:GetTarget()
if target and spell:GetEntry() == SPELL_ID then
local isValidTarget = false
for _, TURID in ipairs(TUR_ID) do
if target:GetEntry() == TURID then
isValidTarget = true
break
end
end
if not isValidTarget then
caster:SendBroadcastMessage("Invalid target.")
spell:Cancel()
else
-- 33% chance for the respawn to fizzle
local chance = math.random(1, 3)
if chance == 1 then
caster:SendBroadcastMessage("Attempt to recharge the turret has fizzled.")
else
-- give kill credit
caster:KilledMonsterCredit(400037)
-- respawn the creature
target:Respawn()
end
end
end
end

RegisterPlayerEvent(5, OnSpellCast)