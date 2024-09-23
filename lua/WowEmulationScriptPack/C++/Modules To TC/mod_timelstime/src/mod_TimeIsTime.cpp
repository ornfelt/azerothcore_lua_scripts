/*
 * Azerothcore Module:     TimeIsTime
 * Author:                 Dunjeon www.guilded.gg/solofriendly
 * Contributing Author(s): lasyan3, vratam @ RegWorks
 * Version:                20210225
 * License:                GNU Affero General Public License v3.0.
 */

#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "World.h"
#include "GameTime.h"
#include "GridNotifiersImpl.h"

static bool   stimeistime_enable,
              stimeistime_announce;
static float  stimeistime_speed_rate,
              stimeistime_hour_offset;
static uint32 stimeistime_time_start;

class TimeIsTimeBeforeConfigLoad : public WorldScript {
public:

    TimeIsTimeBeforeConfigLoad() : WorldScript("TimeIsTimeBeforeConfigLoad") { }

    void OnBeforeConfigLoad(bool /*reload*/) {
        stimeistime_enable = sConfigMgr->GetBoolDefault("TimeIsTime.Enable", true);
        stimeistime_announce = sConfigMgr->GetBoolDefault("TimeIsTime.Announce", true);
        stimeistime_speed_rate = sConfigMgr->GetFloatDefault("TimeIsTime.SpeedRate", 1.0);
        stimeistime_hour_offset = sConfigMgr->GetFloatDefault("TimeIsTime.HourOffset", 0.0);
        stimeistime_time_start = sConfigMgr->GetIntDefault("TimeIsTime.TimeStart", 0);
    }
};

class TimeIsTime : public PlayerScript {
public:

    TimeIsTime() : PlayerScript("TimeIsTime") { }

    void OnLogin(Player* player, bool firstLogin) {
        if (firstLogin) {
            if (stimeistime_enable && stimeistime_announce)
                ChatHandler(player->GetSession()).SendSysMessage("This server is running the |cff4CFF00TimeIsTime |rmodule");
        }
    }
	
    void OnSendInitialPacketsBeforeAddToMap(Player* player, WorldPacket& data) {
        if (!stimeistime_enable)
            return;

        uint32 speed_time  = ((GameTime::GetGameTime() - GameTime::GetUptime()) + (GameTime::GetUptime() * stimeistime_speed_rate));
        float  hour_offset = stimeistime_hour_offset  * 3600;
        uint32 time_start  = stimeistime_time_start + hour_offset;

        data.Initialize(SMSG_LOGIN_SET_TIME_SPEED, 4 + 4 + 4);
        if (stimeistime_time_start > 0) {
            data.AppendPackedTime(time_start);
        }
        else {
            data.AppendPackedTime(speed_time);
        }
        data << float(0.01666667f) * stimeistime_speed_rate;
        data << uint32(0);

        player->GetSession()->SendPacket(&data);
    }
};

void AddTimeIsTimeScripts() {
    new TimeIsTimeBeforeConfigLoad();
    new TimeIsTime();
}
