local npcid = 400018
local spellid1 = 100138
local spellid2 = 69930
local spellid3 = 52386
local yelltext = {
"Defenders, forward! We end this beast here and now!",
"We fight the Scourge to protect our homes, our families...I only hope we are not too late.",
"",
"Alleria...perfect timing as always.",
}
local waypointIndex = 0

function OnReachWp(event, creature, waypoint)
if waypointIndex >= #yelltext then
return
end
creature:CastSpell(creature, spellid1, true)
creature:CastSpell(creature, spellid2, true)
creature:CastSpell(creature, spellid3, true)
creature:SendUnitSay(yelltext[waypointIndex + 1], 0)
waypointIndex = waypointIndex + 1
end

function OnSpawn(event, creature)
waypointIndex = 0
creature:MoveWaypoint()
creature:SetReactState(0)
end

RegisterCreatureEvent(npcid, 5, OnSpawn)
RegisterCreatureEvent(npcid, 6, OnReachWp)