local Config = {}
Config.Database                   = 'acore_eluna' -- The database used to store tables for eluna
Config.ReferralDuration           = 90 -- The amount of days that a referral will stay active. Set to 0 to never have referrals expire
Config.MaxAccountAge              = 7 -- The amount of days since the account was created where it can still be recruited. Accounts older than this amount of days will not be able to be recruited
Config.DaysUntilReward            = 30 -- The amount of days since the referral that is required before the accounts receive special rewards. Set to 0 to disable rewards
Config.EnableRewardSwiftZhevra    = true -- This setting gives the players the Swift Zhevra item
Config.EnableRewardTouringRocket  = true -- This setting gives the players the X-53 Touring Rocket item
Config.EnableRewardCelestialSteed = true -- This setting gives the players the Celestial Steed item

local Status = {
    Pending  = 1,
    Active   = 2,
    Expired  = 3,
}

local Event   = {
    OnDelete  = 2,
    OnLogin   = 3,
    OnUpdate  = 13,
    OnCommand = 42,
}

AuthDBQuery('CREATE TABLE IF NOT EXISTS `'..Config.Database..'`.`recruit_a_friend_accounts` (`account_id` INT(10) UNSIGNED NOT NULL, `recruiter_id` INT(10) UNSIGNED NOT NULL, `referral_date` TIMESTAMP NOT NULL DEFAULT current_timestamp(), `status` TINYINT(3) UNSIGNED NOT NULL , PRIMARY KEY (`account_id`) USING BTREE) COLLATE=\'utf8mb4_general_ci\' ENGINE=InnoDB;')
AuthDBQuery('CREATE TABLE IF NOT EXISTS `'..Config.Database..'`.`recruit_a_friend_rewarded` (`account_id` INT(10) UNSIGNED NOT NULL, `realm_id` INT(10) UNSIGNED NOT NULL, `character_guid` INT(10) UNSIGNED NOT NULL, PRIMARY KEY (`account_id`, `realm_id`, `character_guid`) USING BTREE) COLLATE=\'utf8mb4_general_ci\' ENGINE=InnoDB;')
AuthDBQuery('DELETE FROM `'..Config.Database..'`.`recruit_a_friend_accounts` WHERE `status` = '..Status.Pending..';')

local function SplitString(input)
    if (seperator == nil) then
        seperator = '%s'
    end

    local t = {}

    for str in string.gmatch(input, '([^%s]+)') do
        table.insert(t, str)
    end

    return t
end

local function RecruitCommand(event, player, command, chatHandler)
    local commands = {}
    commands = SplitString(command)

    if (commands[1] ~= 'recruit' or player:GetGMRank() > 0) then
        return
    end

    if (commands[2] == 'friend') then
        if (commands[3] == nil) then
            chatHandler:SendSysMessage('You have to specify the |cff4CFF00name|r of a character.')
            return false
        end

        local friend = GetPlayerByName(commands[3])
        if (friend ~= nil) then
            if (friend:GetGMRank() > 0) then
                chatHandler:SendSysMessage('The specified character doesn\'t exist or is currently |cffFF0000offline|r!')
                return false
            end

            if (friend == player) then
                chatHandler:SendSysMessage('You can\'t recruit |cffFF0000yourself|r!')
                return false
            end

            local IsRecruited = AuthDBQuery('SELECT `status` FROM `'..Config.Database..'`.`recruit_a_friend_accounts` WHERE `account_id` = '..friend:GetAccountId()..' LIMIT 1;')
            if (IsRecruited ~= nil) then
                local status = IsRecruited:GetUInt32(0)

                if (status == Status.Pending) then
                    chatHandler:SendSysMessage('A referral of that account is currently |cffFF0000pending|r.')
                elseif (status == Status.Active) then
                    chatHandler:SendSysMessage('A referral of that account is currently |cff4CFF00active|r.')
                elseif (status == Status.Expired) then
                    chatHandler:SendSysMessage('A referral of that account has |cffFF0000expired|r.')
                end

                return false
            end

            local WasRecruitedBy = AuthDBQuery('SELECT `recruiter_id` FROM `'..Config.Database..'`.`recruit_a_friend_accounts` WHERE `account_id` = '..player:GetAccountId()..' LIMIT 1;')
            if (WasRecruitedBy ~= nil) then
                if (WasRecruitedBy:GetUInt32(0) == friend:GetAccountId()) then
                    chatHandler:SendSysMessage('You can\'t recruit |cff4CFF00'..friend:GetName()..'|r because they referred you.')
                    return false
                end
            end

            local IsReferralValid = AuthDBQuery('SELECT * FROM `account` WHERE `id` = '..friend:GetAccountId()..' AND `joindate` > NOW() - INTERVAL '..Config.MaxAccountAge..' DAY LIMIT 1;')
            if (IsReferralValid == nil) then
                chatHandler:SendSysMessage('You can\'t recruit |cffFF0000'..friend:GetName()..'|r because their account was created more than '..Config.MaxAccountAge..' days ago.')
                return false
            end

            AuthDBQuery('INSERT INTO `'..Config.Database..'`.`recruit_a_friend_accounts` (`account_id`, `recruiter_id`, `status`) VALUES ('..friend:GetAccountId()..', '..player:GetAccountId()..', '..Status.Pending..');')

            chatHandler:SendSysMessage('You have sent a referral request to |cff4CFF00'..friend:GetName()..'|r.')
            chatHandler:SendSysMessage('The player has to |cff4CFF00accept|r, or |cff4CFF00decline|r, the pending request.')
            chatHandler:SendSysMessage('If they accept the request, you have to log out and back in for the changes to take effect.')

            friend:SendBroadcastMessage('|cff4CFF00'..player:GetName()..'|r has sent you a referral request.')
            friend:SendBroadcastMessage('Use |cff4CFF00.recruit accept|r to accept or |cffFF0000.recruit decline|r to decline the request.')
            return false
        else
            chatHandler:SendSysMessage('The specified character doesn\'t exist or is currently |cffFF0000offline|r!')
            return false
        end
    elseif (commands[2] == 'accept') then
        local IsRecruited = AuthDBQuery('SELECT `recruiter_id` FROM `'..Config.Database..'`.`recruit_a_friend_accounts` WHERE `account_id` = '..player:GetAccountId()..' AND `status` = '..Status.Pending..' LIMIT 1;')
        if (IsRecruited ~= nil) then
            AuthDBQuery('DELETE FROM `'..Config.Database..'`.`recruit_a_friend_accounts` WHERE `account_id` = '..player:GetAccountId()..';')
            AuthDBQuery('UPDATE `account` SET `recruiter` = '..IsRecruited:GetUInt32(0)..' WHERE `id` = '..player:GetAccountId()..';')
            AuthDBQuery('INSERT INTO `'..Config.Database..'`.`recruit_a_friend_accounts` (`account_id`, `recruiter_id`, `status`) VALUES ('..player:GetAccountId()..', '..IsRecruited:GetUInt32(0)..', '..Status.Active..');')
            chatHandler:SendSysMessage('You have |cff4CFF00accepted|r the referral request.')
            chatHandler:SendSysMessage('You have to log out and back in for the changes to take effect.')
            return false
        else
            chatHandler:SendSysMessage('You don\'t have a pending referral request.')
            return false
        end
    elseif (commands[2] == 'decline') then
        local IsRecruited = AuthDBQuery('SELECT `recruiter_id` FROM `'..Config.Database..'`.`recruit_a_friend_accounts` WHERE `account_id` = '..player:GetAccountId()..' AND `status` = '..Status.Pending..' LIMIT 1;')
        if (IsRecruited ~= nil) then
            AuthDBQuery('DELETE FROM `'..Config.Database..'`.`recruit_a_friend_accounts` WHERE `account_id` = '..player:GetAccountId()..';')
            chatHandler:SendSysMessage('You have |cffFF0000declined|r the referral request.')
            return false
        else
            chatHandler:SendSysMessage('You don\'t have a pending referral request.')
            return false
        end
    elseif (commands[2] == 'status') then
        local ReferralStatus = AuthDBQuery('SELECT `referral_date`, `referral_date` + INTERVAL '..Config.ReferralDuration..' DAY, `referral_date` + INTERVAL '..Config.DaysUntilReward..' DAY, `status` FROM `'..Config.Database..'`.`recruit_a_friend_accounts` WHERE `account_id` = '..player:GetAccountId()..' LIMIT 1;')
        if (ReferralStatus ~= nil) then
            local referralDate = ReferralStatus:GetString(0)
            local expirationDate = ReferralStatus:GetString(1)
            local rewardDate = ReferralStatus:GetString(2)
            local status = ReferralStatus:GetUInt32(3)
            local currentTimestamp = os.date('%Y-%m-%d %H:%m:%S')

            if (status == Status.Pending) then
                chatHandler:SendSysMessage('You have not been recruited but have a |cff4CFF00pending|r request.')
            elseif (status == Status.Active) then
                if (Config.ReferralDuration > 0) then
                    chatHandler:SendSysMessage('You were recruited at |cff4CFF00'..referralDate..'|r and it will expire at |cffFF0000'..expirationDate..'|r.')
                else
                    chatHandler:SendSysMessage('You were recruited at |cff4CFF00'..referralDate..'|r and it will |cffFF0000never|r expire.')
                end
            elseif (status == Status.Expired) then
                chatHandler:SendSysMessage('You were recruited at |cff4CFF00'..referralDate..'|r and it expired at |cffFF0000'..expirationDate..'|r.')
            end

            if (Config.DaysUntilReward > 0) then
                if (rewardDate < currentTimestamp) then
                    chatHandler:SendSysMessage('You received your rewards at |cffFF0000'..rewardDate..'|r.')
                else
                    chatHandler:SendSysMessage('You will receive your rewards at |cff4CFF00'..rewardDate..'|r.')
                end
            end

            return false
        else
            chatHandler:SendSysMessage('You have |cffFF0000not|r been referred.')
            return false
        end
    elseif (commands[2] == nil or commands[2] == 'help') then
        chatHandler:SendSysMessage('You can recruit a friend using |cff4CFF00.recruit friend <name>|r.')
        chatHandler:SendSysMessage('You can accept a pending request using |cff4CFF00.recruit accept|r.')
        chatHandler:SendSysMessage('You can decline a pending request using |cff4CFF00.recruit decline|r.')

        if (Config.ReferralDuration > 0) then
            chatHandler:SendSysMessage('The recruit a friend benefits will expire after '..Config.ReferralDuration..' days.')
        else
            chatHandler:SendSysMessage('The recruit a friend benefits will never expire.')
        end

        chatHandler:SendSysMessage('You can see the status of your referral using |cff4CFF00.recruit status|r.')

        return false
    end
end
RegisterPlayerEvent(Event.OnCommand, RecruitCommand)

function Player:SendMailToPlayer(title, text, item)
    SendMail(title, text, self:GetGUIDLow(), 0, 61, 0, 0, 0, item, 1)
end

function Player:SendRewardsToPlayer()
    if (Config.EnableRewardSwiftZhevra) then
        self:SendMailToPlayer('Swift Zhevra', 'I found this stray Zhevra walking around The Barrens, aimlessly. I figured you, if anyone, could give it a good home!', 37719)
    end

    if (Config.EnableRewardTouringRocket) then
        self:SendMailToPlayer('X-53 Touring Rocket', 'This rocket was found flying around Northrend, with what seemed like no purpose. Perhaps you could put it to good use?', 54860)
    end

    if (Config.EnableRewardCelestialSteed) then
        self:SendMailToPlayer('Celestial Steed', 'A strange steed was found roaming Northrend, phasing in and out of existence. I figured you would be interested in such a companion.', 54811)
    end
end

local function RecruitOnLogin(event, player)
    player:SendBroadcastMessage('This server supports the use of the Recruit-A-Friend feature. Use the command |cff4CFF00.recruit help|r for more information!')

    if (Config.DaysUntilReward > 0) then
        local rewarded = AuthDBQuery('SELECT * FROM `'..Config.Database..'`.`recruit_a_friend_rewarded` WHERE `account_id` = '..player:GetAccountId()..' AND `realm_id` = '..GetRealmID()..' AND `character_guid` = '..player:GetGUIDLow()..' LIMIT 1;')
        if (rewarded == nil) then
            local eligible = AuthDBQuery('SELECT * FROM `'..Config.Database..'`.`recruit_a_friend_accounts` WHERE `referral_date` < NOW() - INTERVAL '..Config.DaysUntilReward..' DAY AND (`account_id` = '..player:GetAccountId()..' OR `recruiter_id` = '..player:GetAccountId()..') AND `status` NOT LIKE '..Status.Pending..' LIMIT 1;')
            if (eligible ~= nil) then
                AuthDBQuery('INSERT INTO `'..Config.Database..'`.`recruit_a_friend_rewarded` (`account_id`, `realm_id`, `character_guid`) VALUES ('..player:GetAccountId()..', '..GetRealmID()..', '..player:GetGUIDLow()..');')
                player:SendRewardsToPlayer()
            end
        end
    end
end
RegisterPlayerEvent(Event.OnLogin, RecruitOnLogin)

local function ExpireActiveReferrals()
    AuthDBQuery('UPDATE `account` SET `recruiter` = 0 WHERE `id` IN (SELECT `account_id` FROM `'..Config.Database..'`.`recruit_a_friend_accounts` WHERE `referral_date` < NOW() - INTERVAL '..Config.ReferralDuration..' DAY AND status = '..Status.Active..');')
    AuthDBQuery('UPDATE `'..Config.Database..'`.`recruit_a_friend_accounts` SET `status` = '..Status.Expired..' WHERE `referral_date` < NOW() - INTERVAL '..Config.ReferralDuration..' DAY AND `status` = '..Status.Active..';')
end

if (Config.ReferralDuration > 0) then
    -- Check for expired referrals every 15 minutes
    local check = 15 * (60 * 1000)
    local time = 0
    local function RecruitOnUpdate(event, diff)
        time = time + diff
        if (time > check) then
            ExpireActiveReferrals()
            time = 0
        end
    end
    RegisterServerEvent(Event.OnUpdate, RecruitOnUpdate)
end

local function RecruitOnDelete(event, guid)
    AuthDBQuery('DELETE FROM `'..Config.Database..'`.`recruit_a_friend_rewarded` WHERE `realm_id`='..GetRealmID()..' AND `character_guid`='..guid..' LIMIT 1;')
end
RegisterPlayerEvent(Event.OnDelete, RecruitOnDelete)
