-- --------------------------------
-- PARAGON SERVER CONFIGURATION
-- --------------------------------

local AIO = AIO or require("aio")

local paragon = {
    config = {
        db_name = 'ac_eluna',

        pointsPerLevel = 1, -- number of stat points to grant per level of Paragon
        grantTalentPoints = true, -- Enable/disable talent points per level
        talentInterval = 5, -- Number of Paragon levels between talent point grants
        talentsPerLevel = 1, -- Number of talent points granted when eligible

        minPlayerLevel = 60, -- What level does the player need to be to unlock the Paragon XP system?
        expMax = 400, -- Base XP required for the first Paragon level. XP requirements scale exponentially with each further level.
        expScalingFactor = 1.2, -- Controls how quickly XP required per Paragon level increases.
        -- Higher values (e.g., 1.5) cause XP to increase more **exponentially**, making later Paragon levels harder.
        -- Lower values (e.g., 1.1) make Paragon leveling easier by reducing XP growth.

        fullXpRange = 5, -- Full XP is granted if the enemy is within this level range (±5 levels).
        halfXpRange = 10, -- Half XP is granted if the enemy is within this level range (±10 levels).
        halfXpMultiplier = 0.5, -- XP is reduced to 50% when enemy is within `halfXpRange`.
        quarterXpRange = 15, -- Quarter XP is granted if the enemy is within this level range (±15 levels).
        quarterXpMultiplier = 0.25, -- XP is reduced to 25% when enemy is within `quarterXpRange`.

        showXPGainedMessages = true, -- Set to true to show XP gained messages, false to disable it.
        showTalentNotifications = true, -- Set to true to show talent point earned messages, false to disable it.
    },

    spells = {
        [7464] = 'Strength',
        [7468] = 'Intellect',
        [7471] = 'Agility',
        [7474] = 'Spirit',
        [7477] = 'Stamina',
        [7511] = 'Defense Rating',
    },
}

local paragon_addon = AIO.AddHandlers("AIO_Paragon", {})
paragon.account = {}


function paragon_addon.sendInformations(msg, player)
    local pGuid = player:GetGUIDLow()
    local pAcc = player:GetAccountId()

    local temp = {
        stats = {},
        level = 1,
        points = 0,
    }

    for stat, _ in pairs(paragon.spells) do
        temp.stats[stat] = player:GetData('paragon_stats_'..stat) or 0
    end

    if not paragon.account[pAcc] then
        paragon.account[pAcc] = {
            level = 1,
            exp = 0,
            exp_max = paragon.config.expMax
        }
    end

    temp.level = paragon.account[pAcc].level
    temp.points = player:GetData('paragon_points')
    temp.exps = {
        exp = paragon.account[pAcc].exp,
        exp_max = paragon.account[pAcc].exp_max
    }
    temp.playerLevel = player:GetLevel()
    temp.minPlayerLevel = paragon.config.minPlayerLevel

    return msg:Add("AIO_Paragon", "setInfo", temp.stats, temp.level, temp.points, temp.exps, temp.playerLevel, temp.minPlayerLevel)
end
AIO.AddOnInit(paragon_addon.sendInformations)


function paragon.setAddonInfo(player)
    paragon_addon.sendInformations(AIO.Msg(), player):Send(player)
end


function paragon.onServerStart(event)
    CharDBExecute(string.format("CREATE DATABASE IF NOT EXISTS `%s`;", paragon.config.db_name))
    CharDBExecute(string.format("CREATE TABLE IF NOT EXISTS `%s`.`paragon_account` (`account_id` INT(11) NOT NULL, `level` INT(11) DEFAULT 1, `exp` INT(11) DEFAULT 0, PRIMARY KEY (`account_id`));", paragon.config.db_name))
    CharDBExecute(string.format("CREATE TABLE IF NOT EXISTS `%s`.`paragon_characters` (`account_id` INT(11) NOT NULL, `guid` INT(11) NOT NULL, `strength` INT(11) DEFAULT 0, `agility` INT(11) DEFAULT 0, `stamina` INT(11) DEFAULT 0, `intellect` INT(11) DEFAULT 0, `spirit` INT(11) DEFAULT 0, `defense` INT(11) DEFAULT 0, PRIMARY KEY (`account_id`, `guid`));", paragon.config.db_name))
end
RegisterServerEvent(14, paragon.onServerStart)


function paragon_addon.setStats(player)
    local pLevel = player:GetLevel()

    if pLevel >= paragon.config.minPlayerLevel then
        for spell, _ in pairs(paragon.spells) do
            player:RemoveAura(spell)
            player:AddAura(spell, player)
            player:GetAura(spell):SetStackAmount(player:GetData('paragon_stats_'..spell))
        end
    end
end


function paragon_addon.setStatsInformation(player, stat, value, flags)
    local inCombat = player:IsInCombat()
    if (not inCombat) then
        local pLevel = player:GetLevel()
        if (pLevel >= paragon.config.minPlayerLevel) then
            if flags then
                -- Left click to add points
                if ((player:GetData('paragon_points') - value) >= 0) then
                    player:SetData('paragon_stats_'..stat, (player:GetData('paragon_stats_'..stat) + value))
                    player:SetData('paragon_points', (player:GetData('paragon_points') - value))
                    player:SetData('paragon_points_spend', (player:GetData('paragon_points_spend') + value))
                else
                    player:SendNotification('You have no more points to spend.')
                    return false
                end
            else
                -- Right click to refund points
                if (player:GetData('paragon_stats_'..stat) > 0) then
                    player:SetData('paragon_stats_'..stat, (player:GetData('paragon_stats_'..stat) - value))
                    player:SetData('paragon_points', (player:GetData('paragon_points') + value))
                    player:SetData('paragon_points_spend', (player:GetData('paragon_points_spend') - value))
                else
                    player:SendNotification('You have no points to refund.')
                    return false
                end
            end
            paragon.setAddonInfo(player)
        else
            player:SendNotification('You don\'t have the level required to do that.')
        end
    else
        player:SendNotification('You can\'t do this in combat.')
    end
end


function Player:setparagonInfo(strength, agility, stamina, intellect, spirit, defense)
    self:SetData('paragon_stats_7464', strength)
    self:SetData('paragon_stats_7471', agility)
    self:SetData('paragon_stats_7477', stamina)
    self:SetData('paragon_stats_7468', intellect)
    self:SetData('paragon_stats_7474', spirit)
    self:SetData('paragon_stats_7511', defense)
end


function paragon.onLogin(event, player)
    local pAcc = player:GetAccountId()
    local getparagonCharInfo = CharDBQuery(string.format("SELECT strength, agility, stamina, intellect, spirit, defense FROM `%s`.`paragon_characters` WHERE account_id = %d", paragon.config.db_name, pAcc))

    if getparagonCharInfo then
        player:setparagonInfo(getparagonCharInfo:GetUInt32(0), getparagonCharInfo:GetUInt32(1), getparagonCharInfo:GetUInt32(2), getparagonCharInfo:GetUInt32(3), getparagonCharInfo:GetUInt32(4), getparagonCharInfo:GetUInt32(5))
        local totalPoints = getparagonCharInfo:GetUInt32(0) + getparagonCharInfo:GetUInt32(1) + getparagonCharInfo:GetUInt32(2) + getparagonCharInfo:GetUInt32(3) + getparagonCharInfo:GetUInt32(4) + getparagonCharInfo:GetUInt32(5)
        player:SetData('paragon_points', totalPoints)
    else
        local pGuid = player:GetGUIDLow()
        CharDBExecute(string.format("INSERT INTO `%s`.`paragon_characters` VALUES (%d, %d, 0, 0, 0, 0, 0, 0)", paragon.config.db_name, pAcc, pGuid))
        player:setparagonInfo(0, 0, 0, 0, 0, 0)
        player:SetData('paragon_points', 0)
    end
    player:SetData('paragon_points_spend', player:GetData('paragon_points_spend') or 0)

    if not paragon.account[pAcc] then
        paragon.account[pAcc] = {
            level = 1,
            exp = 0,
            exp_max = paragon.config.expMax
        }
    end

    local getparagonAccInfo = AuthDBQuery(string.format("SELECT level, exp FROM `%s`.`paragon_account` WHERE account_id = %d", paragon.config.db_name, pAcc))
    if getparagonAccInfo then
        paragon.account[pAcc].level = getparagonAccInfo:GetUInt32(0)
        paragon.account[pAcc].exp = getparagonAccInfo:GetUInt32(1)
        paragon.updateExpMax(pAcc)
    else
        AuthDBExecute(string.format("INSERT INTO `%s`.`paragon_account` VALUES (%d, 1, 0)", paragon.config.db_name, pAcc))
    end

    paragon_addon.setStats(player)

    if(pAcc ~= nil) then
        local level = paragon.account[pAcc].level
        local pointsEarned = (level > 1) and ((level - 1) * paragon.config.pointsPerLevel) or 0
        local pointsSpent = player:GetData('paragon_points_spend') or 0
        player:SetData('paragon_points', pointsEarned - pointsSpent)
    end
end
RegisterPlayerEvent(3, paragon.onLogin)


function paragon.getPlayers(event)
    for _, player in pairs(GetPlayersInWorld()) do
        paragon.onLogin(event, player)
    end
end
RegisterServerEvent(33, paragon.getPlayers)


function paragon.onLogout(event, player)
    local pAcc = player:GetAccountId()
    local pGuid = player:GetGUIDLow()
    local strength, agility, stamina, intellect, spirit, defense = player:GetData('paragon_stats_7464'), player:GetData('paragon_stats_7471'), player:GetData('paragon_stats_7477'), player:GetData('paragon_stats_7468'), player:GetData('paragon_stats_7474'), player:GetData('paragon_stats_7511')
    CharDBExecute(string.format("REPLACE INTO `%s`.`paragon_characters` VALUES (%d, %d, %d, %d, %d, %d, %d, %d)", paragon.config.db_name, pAcc, pGuid, strength, agility, stamina, intellect, spirit, defense))
    
    if not paragon.account[pAcc] then
        paragon.account[pAcc] = {
            level = 1,
            exp = 0,
            exp_max = paragon.config.expMax
          }
    end

    local level, exp = paragon.account[pAcc].level, paragon.account[pAcc].exp
    AuthDBExecute(string.format("REPLACE INTO `%s`.`paragon_account` VALUES (%d, %d, %d)", paragon.config.db_name, pAcc, level, exp))
end
RegisterPlayerEvent(4, paragon.onLogout)


function paragon.setPlayers(event)
    for _, player in pairs(GetPlayersInWorld()) do
        paragon.onLogout(event, player)
    end
end
RegisterServerEvent(16, paragon.setPlayers)


function paragon.onLevelUp(event, player, oldLevel)
    if player:GetLevel() == paragon.config.minPlayerLevel then
        player:SendBroadcastMessage(string.format("|CFF00A2FFCongratulations! You have reached level %d. The Paragon system has been unlocked and you can now start gaining Paragon levels.", paragon.config.minPlayerLevel))        
    end

    paragon.setAddonInfo(player)
end
RegisterPlayerEvent(13, paragon.onLevelUp)


function paragon.getRandomXP(type)
    local xpRanges = {
        elite = {5, 10},
        dungeonBoss = {90, 110},
        worldBoss = {250, 270},
        pvp = {8, 12}
    }
    return math.random(xpRanges[type][1], xpRanges[type][2])
end


function paragon.setExp(player, victim, numMembers)
    local pLevel = player:GetLevel()
    local vLevel = victim:GetLevel()
    local pAcc = player:GetAccountId()

    local levelDiff = pLevel - vLevel
    local xpGain = 0

    local creature = victim:ToCreature()
    if creature then
        local isElite = creature:IsElite()
        local isDungeonBoss = creature:IsDungeonBoss()
        local isWorldBoss = creature:IsWorldBoss()

        if isWorldBoss then
            xpGain = paragon.getRandomXP("worldBoss")
        elseif isDungeonBoss then
            xpGain = paragon.getRandomXP("dungeonBoss")
        elseif isElite then
            xpGain = paragon.getRandomXP("elite")
        else
            return -- Ignore normal creatures
        end
    else
        xpGain = paragon.getRandomXP("pvp")
    end

    if xpGain <= 0 then return end  -- Exit early if no XP

    if levelDiff > 0 then  -- Only reduce XP if the enemy is lower level
        if levelDiff > paragon.config.quarterXpRange then return end -- Enemy too weak, no XP
        if levelDiff > paragon.config.halfXpRange then xpGain = math.floor(xpGain * paragon.config.quarterXpMultiplier) end
        if levelDiff > paragon.config.fullXpRange then xpGain = math.floor(xpGain * paragon.config.halfXpMultiplier) end
    end
    
    if paragon.config.showXPGainedMessages then
        player:SendBroadcastMessage(string.format("|CFF00A2FFYou earned %d Paragon XP!|r", xpGain))
    end
    
    -- Adjust XP for group members
    local adjustedXP = math.floor(xpGain / (numMembers or 1))
    paragon.account[pAcc].exp = paragon.account[pAcc].exp + adjustedXP

    paragon.setAddonInfo(player)

    -- If the XP exceeds the max, be sure to carry over any excess XP to the next level
    if paragon.account[pAcc].exp >= paragon.account[pAcc].exp_max then
        local levelUps = math.floor(paragon.account[pAcc].exp / paragon.account[pAcc].exp_max)
        local carryOverXP = paragon.account[pAcc].exp % paragon.account[pAcc].exp_max
        player:SetparagonLevel(levelUps, carryOverXP)
    end    
end


function paragon.onKillCreatureOrPlayer(event, player, victim)
    local pLevel = player:GetLevel()
    if (pLevel >= paragon.config.minPlayerLevel) then
        local pGroup = player:GetGroup()
        if pGroup then
            local members = pGroup:GetMembers()
            local numMembers = #members
            for _, groupMember in pairs(members) do
                paragon.setExp(groupMember, victim, numMembers)
            end
        else
            paragon.setExp(player, victim, 1)
        end
    end
end
RegisterPlayerEvent(6, paragon.onKillCreatureOrPlayer)
RegisterPlayerEvent(7, paragon.onKillCreatureOrPlayer)


function Player:SetparagonLevel(level, carryOverXP)
    local pAcc = self:GetAccountId()
    if(pAcc ~= nil) then
        -- Increment the Paragon level
        paragon.account[pAcc].level = paragon.account[pAcc].level + level
        paragon.account[pAcc].exp = carryOverXP
        paragon.updateExpMax(pAcc)

        -- Update the available Paragon stat points
        local totalPoints = (paragon.account[pAcc].level > 1) and ((paragon.account[pAcc].level - 1) * paragon.config.pointsPerLevel) or 0
        local availablePoints = totalPoints - self:GetData('paragon_points_spend')
        self:SetData('paragon_points', availablePoints)

        -- Grant talent points based on config settings
        if paragon.config.grantTalentPoints and (paragon.account[pAcc].level % paragon.config.talentInterval == 0) then
            local newTalentPoints = paragon.config.talentsPerLevel * level
            self:SetFreeTalentPoints(self:GetFreeTalentPoints() + newTalentPoints)
            
            if paragon.config.showTalentNotifications then
                self:SendBroadcastMessage("|CFF00A2FFYou have earned a new talent point from Paragon!|r")
            end
        end

        paragon.setAddonInfo(self)
    end

    -- Visual/Notification effect
    self:CastSpell(self, 11540, true) -- blue firework
    self:CastSpell(self, 11541, true) -- green firework
    self:SendBroadcastMessage(string.format("|CFF00A2FFYou have just passed a level of Paragon.|r |CFF00FF00You are now level %d!|r", paragon.account[pAcc].level))    
end


function paragon.updateExpMax(pAcc)
    if paragon.account[pAcc] then
        local level = math.max(1, paragon.account[pAcc].level)
        paragon.account[pAcc].exp_max = math.floor(paragon.config.expMax * (level ^ paragon.config.expScalingFactor))
    end
end