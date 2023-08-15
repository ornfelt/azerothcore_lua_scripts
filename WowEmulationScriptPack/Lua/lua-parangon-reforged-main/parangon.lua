local parangon = {

  config = require("parangon_config"),
  locale = require("parangon_locale"),

  stats = {
    7464, 7471, 7477, 7468
  }
}
parangon.account = {}

function Player:SetInformations(type, info)
  type = tonumber(type) or 0

  -- Account Informations
  if (type == 1) then
    local accId = self:GetAccountId()

    for key, data in pairs(info) do
      parangon.account[accId][key] = data
    end

  -- Character Informations
  elseif (type == 2) then
    for key, data in pairs(info) do
      self:SetData(key, data)
    end
  else
    return false
  end
end

function Player:GetAccountParangon()
  local accId = self:GetAccountId()
  if (not parangon.account[accId]) then
    parangon.account[accId] = {}

    local getAccInfo = AuthDBQuery('SELECT level, exp, max_exp FROM R1_Eluna.account_parangon WHERE id = '..accId)
    if (getAccInfo) then
      parangon.account[accId]["level"], parangon.account[accId]["exp"], parangon.account[accId]["max_exp"] = getAccInfo:GetUInt32(0), getAccInfo:GetUInt32(1), getAccInfo:GetUInt32(2)
    else
      parangon.account[accId]["level"], parangon.account[accId]["exp"], parangon.account[accId]["max_exp"] = 1, 0, parangon.config.max_exp
      AuthDBExecute("INSERT INTO R1_Eluna.account_parangon VALUES ("..accId..", 1, 0)")
    end
  end
  return parangon.account[accId]
end

function Player:GetCharacterParangon()
  local pGuid = self:GetGUIDLow()

  local getCharInfo = CharDBQuery('SELECT stat_id, stat_val FROM R1_Eluna.characters_parangon WHERE guid = '..pGuid)
  if (getCharInfo) then
    repeat
      self:SetInformations(2, {["parangon_stat_"..getCharInfo:GetUInt32(0)] = getCharInfo:GetUInt32(1)})
      self:SetParangonStat(getCharInfo:GetUInt32(0), getCharInfo:GetUInt32(1))
    until not getCharInfo:NextRow()
  else
    for _, statId in pairs(parangon.stats) do
      self:SetInformations(2, {["parangon_stat_"..statId] = 0})
      AuthDBExecute("INSERT INTO R1_Eluna.characters_parangon VALUES ("..pGuid..", "..statId..", 0)")
      print('ok')
    end
  end
end

function Player:SetAccountParangon()
  local accId = self:GetAccountId()
  if (parangon.account[accId]) then
    AuthDBExecute("UPDATE R1_Eluna.account_parangon SET level = "..parangon.account[accId].level..", exp = "..parangon.account[accId].exp..", max_exp = "..parangon.account[accId].max_exp.." WHERE id = "..accId)
  end
end

function Player:SetCharacterParangon()
  local pGuid = self:GetGUIDLow()

  for _, statId in pairs(parangon.stats) do
    local data = self:GetData("parangon_stat_"..statId)
    CharDBExecute("REPLACE INTO R1_Eluna.characters_parangon (guid, stat_id, stat_val) VALUES ("..pGuid..", "..statId..", "..data..")")
  end
end

function Player:SetParangonXP(amount)
  local oldxp = parangon.account[self:GetAccountId()].exp
  local max_exp = parangon.account[self:GetAccountId()].max_exp
  self:SetInformations(1, {exp = oldxp + amount})

  if (parangon.config.message_give_xp) then
    self:SendBroadcastMessage("Vous venez de recevoir "..amount.." points d'expérience Parangon.")
  end

  if (oldxp + amount >= max_exp) then
    self:SetParangonLevel(1)
  end
end

function Player:SetParangonLevel(amount)
  local oldlevel = parangon.account[self:GetAccountId()].level
  local newLevel = oldlevel + amount

  local oldmax_exp = parangon.account[self:GetAccountId()].max_exp
  local newmax_exp = oldmax_exp + (parangon.config.max_exp_evolution / 100 * oldmax_exp)

  local oldexp = parangon.account[self:GetAccountId()].exp
  local newexp = 0

  -- Saving the experience overflow
  if (oldexp > oldmax_exp) then
    newexp = oldexp - oldmax_exp
  end

  self:SetInformations(1, {level = newLevel})
  self:SetInformations(1, {max_exp = newmax_exp})
  self:SetInformations(1, {exp = newexp})

  if (parangon.config.message_level_up) then
    self:SendBroadcastMessage("Votre niveau de Parangon change, vous êtes désormais niveau "..newLevel)
  end
end

function Player:SetParangonStat(stat_id, stat_val, amount)
  local pGuid = self:GetGUIDLow()
  local pAura = self:HasAura(stat_id)

  if (not amount) then
    amount = 0
  end

  local data = self:GetData("parangon_stat_"..stat_id)
  local new_val = stat_val + amount

  self:SetInformations(2, {["parangon_stat_"..stat_id] = new_val})

  if (pAura) then
    self:RemoveAura(stat_id)
  end
  self:AddAura(stat_id, self):SetStackAmount(new_val)
end

function ParangonOnKill(event, player, victim)
  local pLevel = player:GetLevel()
  local vLevel = victim:GetLevel()

  if (pLevel - vLevel <= parangon.config.level_difference) or (vLevel - pLevel <= parangon.config.level_difference) then
    if (parangon.config.difference_pve_pvp) then
      local oType = victim:GetTypeId()

      if (oType == 3) then
        player:SetParangonXP(parangon.config.experience_amount.pve)
      elseif (oType == 4) then
        player:SetParangonXP(parangon.config.experience_amount.pvp)
      end
    else
      player:SetParangonXP(parangon.config.experience_amount.pve)
    end
  end
end

RegisterPlayerEvent(3, function(event, player)
  player:GetAccountParangon()
  player:GetCharacterParangon()
end)

RegisterServerEvent(33, function(event)
  for _, player in pairs(GetPlayersInWorld()) do
    player:GetAccountParangon()
    player:GetCharacterParangon()
  end
end)

RegisterPlayerEvent(4, function(event, player)
  player:SetAccountParangon()
  player:SetCharacterParangon()
end)

RegisterServerEvent(16, function(event)
  for _, player in pairs(GetPlayersInWorld()) do
    player:SetAccountParangon()
    player:SetCharacterParangon()
  end
end)

for i = 6, 7 do
  RegisterPlayerEvent(i, function(event, player, victim)
    ParangonOnKill(event, player, victim)
  end)
end


return parangon
