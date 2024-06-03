local API_ENDPOINT = "http://localhost:1337" -- Modify API url
local WowHeadRedeemer = {
    Entry = 210000, -- CreatureEntry
}

function extractIdentifier(url)
  local match = url:match("gear%-set/(.-)/")
  if match then return match end

  match = url:match("gear%-set/(.-)%?")
  if match then return match end

  match = url:match("gear%-set/(.+)$")
  return match
end

function WowHeadRedeemer.OnGossipHello(event, player, unit)
    player:GossipMenuAddItem(0, "I would like to get a WoWHead GearSet.", 0, 1, true, "")
    player:GossipSendMenu(8855, unit)
end

function WowHeadRedeemer.OnGossipSelect(event, player, object, sender, intid, code)
    local player_name = player:GetAccountName()
    local set_name = extractIdentifier(code)

    HttpRequest("GET", API_ENDPOINT.."/add/gear-set/wowhead/"..player_name.."/"..set_name, function(status, body, headers)
        print(status)
    end)

    player:SendAreaTriggerMessage("Congratulations! Check your email!")
    player:GossipComplete()
end

RegisterCreatureGossipEvent(WowHeadRedeemer.Entry, 1, WowHeadRedeemer.OnGossipHello)
RegisterCreatureGossipEvent(WowHeadRedeemer.Entry, 2, WowHeadRedeemer.OnGossipSelect)
