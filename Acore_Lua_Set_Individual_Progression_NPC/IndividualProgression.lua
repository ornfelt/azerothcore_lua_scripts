IndividualProgression = {}

local SELECT_SQL = "SELECT data FROM character_settings WHERE guid = %d AND source = 'mod-individual-progression'"
local UPSERT_SQL = "INSERT INTO character_settings (guid, source, data) VALUES (%d, 'mod-individual-progression', '%u') ON DUPLICATE KEY UPDATE data = VALUES(data)"
local DELETE_SQL = "DELETE FROM character_settings WHERE guid = %d AND source = 'mod-individual-progression'"

IndividualProgression.RestrictBeyondVanilla = false -- Set to false to allow progression beyond Vanilla
IndividualProgression.RestrictBeyondTBC = false     -- Set to false to allow progression beyond TBC


IndividualProgression.npcId = 50000
IndividualProgression.PlayerChangedTierKey = 1001
IndividualProgression.mainMenu = "|TInterface\\icons\\inv_helmet_74:45:45:-40|t|cff00008bSet Individual Progression |r"
IndividualProgression.options = {
  "|TInterface\\icons\\achievement_boss_ragnaros:45:45:-40|t|cff8b0000Tier 1 - Molten Core (Level 60)|r",
  "|TInterface\\icons\\achievement_boss_onyxia:45:45:-40|t|cff8b0000Tier 2 - Onyxia (Level 60)|r",
  "|TInterface\\icons\\achievement_boss_nefarion:45:45:-40|t|cff8b0000Tier 3 - Blackwing Lair (Level 60)|r",
  "|TInterface\\icons\\achievement_zone_silithus_01:45:45:-40|t|cff8b0000Tier 4 - Pre-AQ (Level 60)|r",
  "|TInterface\\icons\\achievement_boss_cthun:45:45:-40|t|cff8b0000Tier 5 - Anh'qiraj (Level 60)|r",
  "|TInterface\\icons\\achievement_boss_kelthuzad_01:45:45:-40|t|cff8b0000Tier 6 - Naxxramas (Level 60)|r",
  "|TInterface\\icons\\achievement_boss_princemalchezaar_02:45:45:-40|t|cff006400Tier 7 - Karazhan, Gruul's Lair, Magtheridon's Lair (Level 70)|r",
  "|TInterface\\icons\\achievement_character_bloodelf_male:45:45:-40|t|cff006400Tier 8 - Serpentshrine Cavern, Tempest Keep (Level 70)|r",
  "|TInterface\\icons\\achievement_boss_illidan:45:45:-40|t|cff006400Tier 9 - Hyjal Summit and Black Temple (Level 70)|r",
  "|TInterface\\icons\\achievement_boss_zuljin:45:45:-40|t|cff006400Tier 10 - Zul'Aman (Level 70)|r",
  "|TInterface\\icons\\achievement_boss_kiljaedan:45:45:-40|t|cff006400Tier 11 - Sunwell Plateau (Level 70)|r",
  "|TInterface\\icons\\achievement_boss_kelthuzad_01:45:45:-40|t|cff00008bTier 12 - Naxxramas WotLK, Eye of Eternity, Obsidian Sanctum (Level 80)|r",
  "|TInterface\\icons\\achievement_boss_algalon_01:45:45:-40|t|cff00008bTier 13 - Ulduar (Level 80)|r",
  "|TInterface\\icons\\achievement_reputation_argentcrusader:45:45:-40|t|cff00008bTier 14 - Trial of the Crusader|r",
  "|TInterface\\icons\\achievement_boss_lichking:45:45:-40|t|cff00008bTier 15 - Icecrown Citadel (Level 80)|r",
  "|TInterface\\icons\\spell_shadow_twilight:45:45:-40|t|cff00008bTier 16 - Ruby Sanctum (Level 80)"
}

IndividualProgression.optionsWithoutIcon = {
  "Tier 1 - Molten Core (Level 60)",
  "Tier 2 - Onyxia (Level 60)",
  "Tier 3 - Blackwing Lair (Level 60)",
  "Tier 4 - Pre-AQ (Level 60)",
  "Tier 5 - Anh'qiraj (Level 60)",
  "Tier 6 - Naxxramas (Level 60)",
  "Tier 7 - Karazhan, Gruul's Lair, Magtheridon's Lair (Level 70)",
  "Tier 8 - Serpentshrine Cavern, Tempest Keep (Level 70)",
  "Tier 9 - Hyjal Summit and Black Temple (Level 70)",
  "Tier 10 - Zul'Aman (Level 70)",
  "Tier 11 - Sunwell Plateau (Level 70)",
  "Tier 12 - Naxxramas WotLK, Eye of Eternity, Obsidian Sanctum (Level 80)",
  "Tier 13 - Ulduar (Level 80)",
  "Tier 14 - Trial of the Crusader",
  "Tier 15 - Icecrown Citadel (Level 80)",
  "Tier 16 - Ruby Sanctum (Level 80)"
}

function IndividualProgression.getTextWithoutIcon(option)
  local textStart = option:find("|r") + 2
  return option:sub(textStart)
end

function IndividualProgression.OnGossipHello(event, player, object)
  player:GossipMenuAddItem(0, IndividualProgression.mainMenu, 0, 1)
  player:GossipMenuAddItem(0, "|TInterface\\icons\\inv_scroll_03:45:45:-40|t |cff00008bWhat is Individual Progression?|r", 0, 200)
  player:GossipSendMenu(1, object)
  object:SetEquipmentSlots(32262, 33755, 0)
  object:SendUnitSay("Speaking with me will allow you to artificially set what stage of the game you'd like to be in, thereby bypassing any normal progression.", 0)

  local guid = player:GetGUIDLow()
  local query = CharDBQuery(string.format(SELECT_SQL, guid))
  
  if query then
    local playerProgressionTier = query:GetString(0)
    if playerProgressionTier then  -- Check if the value is not nil
      playerProgressionTier = tonumber(playerProgressionTier)
      object:SendUnitWhisper("Your current progression level is: " .. IndividualProgression.optionsWithoutIcon[playerProgressionTier + 1], 0, player)
    end
  else
    CharDBExecute(string.format(INSERT_SQL, guid, 0))
    object:SendUnitWhisper("You have not set any individual progression. Contact a GM for help.", 0, player)
  end
end

function IndividualProgression.ShowIndividualProgressionExplanation(player, object)
  player:GossipMenuAddItem(0, "Individual Progression is meant to simulate 'progress through expansions and expansion tiers' for individual players. Players must complete each tier in order to access content for the next tier. \n\nEach tier is designed to simulate experience of being within that tier and expansion, within reason of the WotLK client. This means Vanilla content is like Vanilla WoW, TBC is like TBC, and so on. \n\nThe goal of this feature is to focus on journey of the player. All catch-up mechanisms have been removed. \n\nThere is no need for 'fresh' servers because each new character is a fresh server. Note that this feature either requires many players working together on a server for each tier, or adjustments for smaller raid sizes to allow individual groups to progress (or more bots). Please see the auto-balance module and NPC Bot Settings in world.conf for some adjustments that improve this process on a less populated servers.", 0, 201)
  player:GossipMenuAddItem(0, "|TInterface\\icons\\achievement_guildperk_massresurrection:45:45:-40|t Back", 0, 100)
  player:GossipSendMenu(1, object)
end

IndividualProgression.PlayerTierKey = 1000

function BroadcastTimer(eventId, delay, repeats, playerGUID, secondsLeft)
  local player = GetPlayerByGUID(playerGUID)
  if player then
    if secondsLeft > 0 then
      player:SendBroadcastMessage("You will be kicked in " .. secondsLeft .. " seconds.")
    else
      player:SendBroadcastMessage("We'll see you again soon!")
    end
  end
end

function KickPlayerDelayed(eventId, delay, repeats, playerGUID)
  local player = GetPlayerByGUID(playerGUID)
  if player then
    player:KickPlayer()
  end
end

function IndividualProgression.OnGossipSelect(event, player, object, sender, intid, code)
  if intid == 1 then
    for i, option in ipairs(IndividualProgression.options) do
      player:GossipMenuAddItem(0, option, 0, i + 1)
    end
    player:GossipMenuAddItem(0, "|TInterface\\icons\\achievement_guildperk_massresurrection:45:45:-40|t Back", 0, 100)
    player:GossipSendMenu(1, object)
  elseif intid == 100 then
    player:GossipMenuAddItem(0, IndividualProgression.mainMenu, 0, 1)
    player:GossipMenuAddItem(0, "|TInterface\\icons\\inv_scroll_03:45:45:-40|t What's Individual Progression?", 0, 200) 
    player:GossipSendMenu(1, object)
  elseif intid == 200 then
    IndividualProgression.ShowIndividualProgressionExplanation(player, object) 
  else
    local tier = intid - 2
    if tier >= 0 then
      -- Check if trying to progress beyond allowed content and if it's restricted
      local isGM = player:IsGM() -- Check if the player is a Game Master
      if not isGM then
        if IndividualProgression.RestrictBeyondVanilla and tier > 5 then
          player:SendBroadcastMessage("You cannot progress beyond Vanilla content as per server configuration.")
          player:GossipComplete()
          return
        elseif IndividualProgression.RestrictBeyondTBC and tier > 10 then
          player:SendBroadcastMessage("You cannot progress beyond TBC content as per server configuration.")
          player:GossipComplete()
          return
        end
      end
      
      player:SetUInt32Value(IndividualProgression.PlayerTierKey, tier)
      player:SetUInt32Value(IndividualProgression.PlayerChangedTierKey, 1)  
      player:GossipComplete()
      player:SendBroadcastMessage("Your individual progression will be set to " .. IndividualProgression.optionsWithoutIcon[intid - 1] .. " upon logout.")
      
      local playerGUID = player:GetGUID()
      
      for i = 5, 0, -1 do
        CreateLuaEvent(function(eventId, delay, repeats) BroadcastTimer(eventId, delay, repeats, playerGUID, i) end, (5 - i) * 1000, 1)
      end
      player:SendBroadcastMessage("You will be kicked from the server in 5 seconds to apply changes.")
      CreateLuaEvent(function(eventId, delay, repeats) KickPlayerDelayed(eventId, delay, repeats, playerGUID) end, 6000, 1)
    end
  end
end

function IndividualProgression.DelayedDatabaseUpdate(eventId, delay, repeats, playerData)
  if playerData.tier >= 0 and playerData.tierChanged == 1 then
    CharDBExecute(string.format(UPSERT_SQL, playerData.guid, playerData.tier))
  end
end

function IndividualProgression.Individual_OnPlayerLogout(event, player)
    local tier = player:GetUInt32Value(IndividualProgression.PlayerTierKey)
    local tierChanged = player:GetUInt32Value(IndividualProgression.PlayerChangedTierKey)
    local guid = player:GetGUIDLow()
    local playerData = {
        tier = tier,
        tierChanged = tierChanged,
        guid = guid
    }
    CreateLuaEvent(function(eventId, delay, repeats) IndividualProgression.DelayedDatabaseUpdate(eventId, delay, repeats, playerData) end, 700, 1)
end

RegisterCreatureGossipEvent(IndividualProgression.npcId, 1, IndividualProgression.OnGossipHello)
RegisterCreatureGossipEvent(IndividualProgression.npcId, 2, IndividualProgression.OnGossipSelect)
RegisterPlayerEvent(4, IndividualProgression.Individual_OnPlayerLogout)
