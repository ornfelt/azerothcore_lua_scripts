local parangon = require('parangon')
local parangon_gossip = {}

if (not parangon.config.gossip_menu) then
  return false
end

local SMSG_NPC_TEXT_UPDATE = 384
local MAX_GOSSIP_TEXT_OPTIONS = 8

function Player:GossipSetText(text, textID)
    local data = CreatePacket(SMSG_NPC_TEXT_UPDATE, 100);
    data:WriteULong(textID or 0x7FFFFFFF)
    for i = 1, MAX_GOSSIP_TEXT_OPTIONS do
        data:WriteFloat(0) -- Probability
        data:WriteString(text) -- Text
        data:WriteString(text) -- Text
        data:WriteULong(0) -- language
        data:WriteULong(0) -- emote
        data:WriteULong(0) -- emote
        data:WriteULong(0) -- emote
        data:WriteULong(0) -- emote
        data:WriteULong(0) -- emote
        data:WriteULong(0) -- emote
    end
    self:SendPacket(data)
end

RegisterCreatureGossipEvent(197, 1, function(event, player, object)
  local pLocale, pName, pAccId = player:GetDbcLocale(), player:GetName(), player:GetAccountId()

  local text = {
    line_1 = "     "..parangon.locale[pLocale]["paragon_of"].." "..pName.."\n\n",
    line_2 = "          "..parangon.locale[pLocale]["level"].." "..parangon.account[pAccId].level.."\n",
    line_3 = "          "..parangon.locale[pLocale]["experience"].." |CFF1a9314"..parangon.account[pAccId].exp.."|r\n",
    line_4 = "          "..parangon.locale[pLocale]["max_experience"].." |CFF187ab0"..parangon.account[pAccId].max_exp.."|r\n\n",
    line_5 = "          |CFF833c9c"..parangon.locale[pLocale]["points_available"].." "..parangon.account[pAccId].level,
  }

  for _, statid in pairs(parangon.stats) do
    player:GossipMenuAddItem(0, parangon.locale[pLocale]["parangon_stat_"..statid], 0, statid)
  end

  player:GossipSetText(text.line_1..text.line_2..text.line_3..text.line_4..text.line_5)
  player:GossipSendMenu(0x7FFFFFFF, object)
end)


RegisterCreatureGossipEvent(197, 2, function(event, player, object, sender, intid, code, menu_id)

end)
