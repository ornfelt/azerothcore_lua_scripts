-- ------------------------------------------------------------------------------------------------
-- -- PARAGON SERVER CONFIGURATION
-- ------------------------------------------------------------------------------------------------

local AIO = AIO or require("aio")

local paragon = {
    config = {
        db_name = 'ac_eluna',

        pointsPerLevel = 1, -- number of stat points to grant per level of Paragon
        talentsPerLevel = 1, -- number of talent points to grant per level of Paragon

        minPlayerLevel = 60, -- What level does the player need to be to unlock the Paragon XP system?

        expMax = 500, -- XP required to reach the next level of Paragon (multiplied with each Paragon level)

        -- eliteXP = 10, -- XP granted from killing eligible Elites
        -- dungeonBossXP = 100, -- XP granted from killing eligible Dungeon Bosses
        -- worldBossXP = 250, -- XP granted from killing eligible World Bosses
        -- pvpKillXP = 10, -- XP granted from eligible PvP kills

        eliteXP = nil, -- Randomized in the setExp function (between 5 and 10)
        dungeonBossXP = nil, -- Randomized in the setExp function (between 90 and 110)
        worldBossXP = nil, -- Randomized in the setExp function (between 250 and 270)
        pvpKillXP = nil, -- Randomized in the setExp function (between 8 and 12)

        levelDiff = 5, -- Level difference (+ or -) from the player that the creature must be to be considered "eligible"
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
        points = 1,
    }

    for stat, _ in pairs(paragon.spells) do
        temp.stats[stat] = player:GetData('paragon_stats_'..stat)
    end

    if not paragon.account[pAcc] then
        paragon.account[pAcc] = {
            level = 1,
            exp = 0,
            exp_max = paragon.config.expMax
        }
    end

    temp.level = paragon.account[player:GetAccountId()].level
    temp.points = player:GetData('paragon_points')
    temp.exps = {
        exp = paragon.account[player:GetAccountId()].exp,
        exp_max = paragon.account[player:GetAccountId()].exp_max
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
    CharDBExecute('CREATE DATABASE IF NOT EXISTS `'..paragon.config.db_name..'`;')
    CharDBExecute('CREATE TABLE IF NOT EXISTS `'..paragon.config.db_name..'`.`paragon_account` (`account_id` INT(11) NOT NULL, `level` INT(11) DEFAULT 1, `exp` INT(11) DEFAULT 0, PRIMARY KEY (`account_id`) );');
    CharDBExecute('CREATE TABLE IF NOT EXISTS `'..paragon.config.db_name..'`.`paragon_characters` (`account_id` INT(11) NOT NULL, `guid` INT(11) NOT NULL, `strength` INT(11) DEFAULT 0, `agility` INT(11) DEFAULT 0, `stamina` INT(11) DEFAULT 0, `intellect` INT(11) DEFAULT 0, `spirit` INT(11) DEFAULT 0, `defense` INT(11) DEFAULT 0, PRIMARY KEY (`account_id`, `guid`));');
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
    local pCombat = player:IsInCombat()
    if (not pCombat) then
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
    local getparagonCharInfo = CharDBQuery('SELECT strength, agility, stamina, intellect, spirit, defense FROM `'..paragon.config.db_name..'`.`paragon_characters` WHERE account_id = '..pAcc)
    if getparagonCharInfo then
        player:setparagonInfo(getparagonCharInfo:GetUInt32(0), getparagonCharInfo:GetUInt32(1), getparagonCharInfo:GetUInt32(2), getparagonCharInfo:GetUInt32(3), getparagonCharInfo:GetUInt32(4), getparagonCharInfo:GetUInt32(5))
        local totalPoints = getparagonCharInfo:GetUInt32(0) + getparagonCharInfo:GetUInt32(1) + getparagonCharInfo:GetUInt32(2) + getparagonCharInfo:GetUInt32(3) + getparagonCharInfo:GetUInt32(4) + getparagonCharInfo:GetUInt32(5)
        player:SetData('paragon_points', totalPoints)
    else
        local pGuid = player:GetGUIDLow()
        CharDBExecute('INSERT INTO `'..paragon.config.db_name..'`.`paragon_characters` VALUES ('..pAcc..', '..pGuid..', 0, 0, 0, 0, 0, 0)')
        player:setparagonInfo(0, 0, 0, 0, 0, 0)
        player:SetData('paragon_points', 0)
    end
    -- player:SetData('paragon_points_spend', 0)
    player:SetData('paragon_points_spend', player:GetData('paragon_points_spend') or 0)

    if not paragon.account[pAcc] then
        paragon.account[pAcc] = {
            level = 1,
            exp = 0,
            exp_max = paragon.config.expMax
        }
    end

    local getparagonAccInfo = AuthDBQuery('SELECT level, exp FROM `'..paragon.config.db_name..'`.`paragon_account` WHERE account_id = '..pAcc)
    if getparagonAccInfo then
        paragon.account[pAcc].level = getparagonAccInfo:GetUInt32(0)
        paragon.account[pAcc].exp = getparagonAccInfo:GetUInt32(1)
        paragon.account[pAcc].exp_max = paragon.config.expMax * paragon.account[pAcc].level
    else
        AuthDBExecute('INSERT INTO `'..paragon.config.db_name..'`.`paragon_account` VALUES ('..pAcc..', 1, 0)')
    end

    paragon_addon.setStats(player)

    if(pAcc ~= nil) then
        local pointsEarned = paragon.account[pAcc].level * paragon.config.pointsPerLevel
        local pointsSpent = player:GetData('paragon_points_spend') or 0
        -- local pointsSpent = player:GetData('paragon_points') or 0
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
    CharDBExecute('REPLACE INTO `'..paragon.config.db_name..'`.`paragon_characters` VALUES ('..pAcc..', '..pGuid..', '..strength..', '..agility..', '..stamina..', '..intellect..', '..spirit..', '..defense..')')

    if not paragon.account[pAcc] then
        paragon.account[pAcc] = {
            level = 1,
            exp = 0,
            exp_max = paragon.config.expMax
          }
    end

    local level, exp = paragon.account[pAcc].level, paragon.account[pAcc].exp
    AuthDBExecute('REPLACE INTO `'..paragon.config.db_name..'`.`paragon_account` VALUES ('..pAcc..', '..level..', '..exp..')')
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
        player:SendBroadcastMessage('|CFF00A2FFCongratulations! You have reached level '..paragon.config.minPlayerLevel..'. The Paragon system has been unlocked and you can now started gaining Paragon levels.')
    end

    paragon.setAddonInfo(player)
end
RegisterPlayerEvent(13, paragon.onLevelUp)


function paragon.setExp(player, victim)
    local pLevel = player:GetLevel()
    local vLevel = victim:GetLevel()
    local pAcc = player:GetAccountId()

    if (vLevel - pLevel <= paragon.config.levelDiff) and (vLevel - pLevel >= 0) or (pLevel - vLevel <= paragon.config.levelDiff) and (pLevel - vLevel >= 0) then
        local creature = victim:ToCreature()
        if creature then
            local isElite = creature:IsElite()
            local isDungeonBoss = creature:IsDungeonBoss()
            local isWorldBoss = creature:IsWorldBoss()

            if isWorldBoss then
                -- Set worldBossXP to a random value between 250 and 270 each time a world boss is killed
                paragon.config.worldBossXP = math.random(250, 270)
                paragon.account[pAcc].exp = paragon.account[pAcc].exp + paragon.config.worldBossXP
                player:SendBroadcastMessage('|CFF00A2FFYour world boss kill gives you '..paragon.config.worldBossXP..' paragon experience points.')
            elseif isDungeonBoss then
                -- Set dungeonBossXP to a random value between 90 and 110 each time a dungeon boss is killed
                paragon.config.dungeonBossXP = math.random(90, 110)
                paragon.account[pAcc].exp = paragon.account[pAcc].exp + paragon.config.dungeonBossXP
                player:SendBroadcastMessage('|CFF00A2FFYour dungeon boss kill gives you '..paragon.config.dungeonBossXP..' paragon experience points.')
            elseif isElite then
                -- Set eliteXP to a random value between 5 and 10 each time an elite is killed
                paragon.config.eliteXP = math.random(5, 10)
                paragon.account[pAcc].exp = paragon.account[pAcc].exp + paragon.config.eliteXP
                player:SendBroadcastMessage('|CFF00A2FFYour elite kill gives you '..paragon.config.eliteXP..' paragon experience points.')
            else
                -- Optionally handle normal creatures or ignore them
                return
            end
        else
            -- Set pvpKillXP to a random value between 8 and 12 with each pvp kill
            paragon.config.pvpKillXP = math.random(8, 12)
            paragon.account[pAcc].exp = paragon.account[pAcc].exp + paragon.config.pvpKillXP
            player:SendBroadcastMessage('|CFF00A2FFYour PvP kill gives you '..paragon.config.pvpKillXP..' paragon experience points.')
        end

        paragon.setAddonInfo(player)
    end

    if paragon.account[pAcc].exp >= paragon.account[pAcc].exp_max then
        -- If the XP exceeds the max, be sure to carry over any excess/surplus XP to the next level
        local carryOverXP = paragon.account[pAcc].exp - paragon.account[pAcc].exp_max

        player:SetparagonLevel(1, carryOverXP)
    end
end


function paragon.onKillCreatureOrPlayer(event, player, victim)
    local pLevel = player:GetLevel()
    if (pLevel >= paragon.config.minPlayerLevel) then
        local pGroup = player:GetGroup()
        if pGroup then
            for _, groupMember in pairs(pGroup:GetMembers()) do
                paragon.setExp(groupMember, victim)
            end
        else
            paragon.setExp(player, victim)
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
        paragon.account[pAcc].exp_max = paragon.config.expMax * paragon.account[pAcc].level
        
        -- Update the available paragon points
        local totalPoints = paragon.account[pAcc].level * paragon.config.pointsPerLevel
        local availablePoints = totalPoints - self:GetData('paragon_points_spend')
        self:SetData('paragon_points', availablePoints)
        
        -- Grant talent points based on the configuration
        local newTalentPoints = paragon.config.talentsPerLevel * level
        self:SetFreeTalentPoints(self:GetFreeTalentPoints() + newTalentPoints)
        
        paragon.setAddonInfo(self)
    end

    -- Optional: Visual/Notification effect
    self:CastSpell(self, 11540, true) -- blue firework
    self:CastSpell(self, 11541, true) -- green firework
    self:SendNotification('|CFF00A2FFYou have just passed a level of Paragon.\nCongratulations, you are now level ' .. paragon.account[pAcc].level .. '!')
    self:SendNotification('|CFF00A2FFYou have earned a new talent point from Paragon.')
end