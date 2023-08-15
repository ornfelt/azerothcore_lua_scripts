#include "ScriptMgr.h"
#include "Player.h"
#include "ScriptSettings/ScriptSettingsAPI.h"
#include "GameTime.h"

class TC_GAME_API ConsecutiveLoginCounterScript : public PlayerScript
{
public:
    ConsecutiveLoginCounterScript() : PlayerScript("ConsecutiveLoginCounterScript") {}
    void OnLogin(Player* player, bool firstLogin)
    {
        int32 IsNan;
        int32 UnixStampMinutesPrevLogin = GetScripVariableInt32(SSV_Player_LastLogin, player->GetGUID().GetCounter(), &IsNan);
        if (IsNan == 1)
            SetScripVariableInt32(SSV_Player_ConsecutiveLogins, player->GetGUID().GetCounter(), 0);
        //round it down to day
        int32 TimeSincePrevLogin = GameTime::GetGameTime() / 60 - UnixStampMinutesPrevLogin;
        //if too much time passed since prev login, reset counter
        int32 CurLoginStreak = 0;
        if (TimeSincePrevLogin > 24 * 60)
        {
            SetScripVariableInt32(SSV_Player_ConsecutiveLogins, player->GetGUID().GetCounter(), 0);
            SetScripVariableInt32(SSV_Player_ConsecutiveLoginAwarded, player->GetGUID().GetCounter(), GameTime::GetGameTime() / 60);
        }
        else
        {
            int32 UnixStampMinutesPrevLogin = GetScripVariableInt32(SSV_Player_ConsecutiveLoginAwarded, player->GetGUID().GetCounter(), &IsNan);            
            int32 TimeSincePrevAvard = GameTime::GetGameTime() / 60 - UnixStampMinutesPrevLogin;
            if (TimeSincePrevAvard > 24 * 60)
            {
                CurLoginStreak = GetScripVariableInt32(SSV_Player_ConsecutiveLogins, player->GetGUID().GetCounter(), &IsNan);
                SetScripVariableInt32(SSV_Player_ConsecutiveLogins, player->GetGUID().GetCounter(), CurLoginStreak + 1);
                SetScripVariableInt32(SSV_Player_ConsecutiveLoginAwarded, player->GetGUID().GetCounter(), GameTime::GetGameTime() / 60);
            }
        }
        player->BroadcastMessage("LoginStreakCounter: %d consecutive daily logins", CurLoginStreak);

        //mark our last login time
        SetScripVariableInt32(SSV_Player_LastLogin, player->GetGUID().GetCounter(), GameTime::GetGameTime() / 60);
    }

    void OnLogout(Player* player)
    {
        SetScripVariableInt32(SSV_Player_LastLogin, player->GetGUID().GetCounter(), GameTime::GetGameTime() / 60);
    }

    void OnDelete(ObjectGuid guid, uint32 accountId)
    {
        DelScripVariableInt32(SSV_Player_LastLogin, guid.GetCounter());
        DelScripVariableInt32(SSV_Player_ConsecutiveLogins, guid.GetCounter());
    }
};

int GetLoginStreak(ObjectGuid PlayerGuid)
{
    int32 IsNan;
    int32 CurLoginStreak = GetScripVariableInt32(SSV_Player_ConsecutiveLogins, PlayerGuid.GetCounter(), &IsNan);
    if (IsNan)
        return 0;
    return CurLoginStreak;
}

void AddLoginStreakCounterScripts()
{
    new ConsecutiveLoginCounterScript();
}
