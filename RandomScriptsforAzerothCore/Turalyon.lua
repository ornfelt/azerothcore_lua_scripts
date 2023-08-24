local npcid = 400018
local spellid1 = 100135
local spellid2 = 69930
local yelltext = {
  "This world is ours, and by the Holy Light we will keep it safe, now and forever.",
  "We will stand tall, and we will fight on, in the name of the Light!",
  "Let the shadows flee before the blazing light of justice!",
  "For the Alliance! For the Light!",
}
local waypointIndex = 0

function OnReachWp(event, creature, waypoint)
  if waypointIndex >= #yelltext then
    waypointIndex = 0
  end
  creature:CastSpell(creature, spellid1, true)
  creature:CastSpell(creature, spellid2, true)
  creature:SendUnitYell(yelltext[waypointIndex + 1], 0)
  waypointIndex = waypointIndex + 1
end

function OnSpawn(event, creature)
  waypointIndex = 0
  creature:MoveWaypoint()
  creature:SetReactState(0)
end

RegisterCreatureEvent(npcid, 5, OnSpawn)
RegisterCreatureEvent(npcid, 6, OnReachWp)
