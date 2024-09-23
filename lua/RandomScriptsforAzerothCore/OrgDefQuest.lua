local ORG_ID = {3296, 400039, 400040, 400041, 400045, 400059, 400060, 400061, 400070, 400071}
local SPELL_ID = 100193

function OnSpellCast(event, caster, spell)
local target = spell:GetTarget()
if target and spell:GetEntry() == SPELL_ID then
local isValidTarget = false
for _, orgID in ipairs(ORG_ID) do
if target:GetEntry() == orgID then
isValidTarget = true
break
end
end
if not isValidTarget then
caster:SendBroadcastMessage("That target is not valid.")
spell:Cancel()
elseif target:HasAura(SPELL_ID) then
caster:SendBroadcastMessage("You've already used the Shadow-Drenched Cloth on that defender!")
spell:Cancel()
else
-- give kill credit to NPC ID 3296
caster:KilledMonsterCredit(3296)
end
end
end

RegisterPlayerEvent(5, OnSpellCast)