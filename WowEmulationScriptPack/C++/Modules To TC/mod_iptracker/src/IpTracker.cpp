
#include "Config.h"
#include "LoginDatabase.h"
#include "ScriptMgr.h"
#include "DatabaseEnv.h"



#define CONF_ENABLE_TRACKER "IpTracker.Enabled"
#define CONF_CLEAN_OLDER_THAN_DAYS "IpTracker.CleanOlderThanDays"
#define QUERY_UPDATE_IP "INSERT INTO `account_ip` (`account`, `ip`, `first_time`, `last_time`) VALUES (%u, '%s', NOW(), NOW()) ON DUPLICATE KEY UPDATE `last_time` = NOW()"
#define QUERY_DELETE_IP "DELETE FROM `account_ip` WHERE `last_time` < (DATE_SUB(NOW(), INTERVAL %u DAY))"

class IpTracker : public AccountScript, public WorldScript {
public:

    IpTracker() : AccountScript("IpTracker"), WorldScript("IpTracker") { }

    void OnLastIpUpdate(uint32 accountId, std::string ip)
    {
        if (!sConfigMgr->GetBoolDefault(CONF_ENABLE_TRACKER, false))
        {
            return;
        }

        LoginDatabase.AsyncQuery(QUERY_UPDATE_IP);
    }

    void OnStartup() override
    {
        const auto DAYS = sConfigMgr->GetBoolDefault(CONF_CLEAN_OLDER_THAN_DAYS, 0);

        if (!sConfigMgr->GetBoolDefault(CONF_ENABLE_TRACKER, false) || DAYS == 0)
        {
            return;
        }

        LoginDatabase.PQuery(QUERY_DELETE_IP, DAYS);
        //sLog->outString(">>> mod-ip-tracker: deleted all rows older than %u days\n", DAYS);
    }
};

void AddIpTrackerScripts() {
    new IpTracker();
}

