////////////////////////////////////////////////////////////////////////////////
//
//  MILLENIUM-STUDIO
//  Copyright 2016 Millenium-studio SARL
//  All Rights Reserved.
//
////////////////////////////////////////////////////////////////////////////////

#include <ScriptPCH.h>
#include <ScriptMgr.h>
#include "ChannelMgr.h"

class StressTest : public PlayerScript
{
public:
    StressTest() : PlayerScript("ReportingOnFirstTimeConnexion") {}

    std::map<uint32, uint32> m_RandomEventTimer;

    void OnLogin(Player* p_Player)
    {
        if (p_Player->GetSession()->IsStressTest())
        {
            if (ChannelMgr* cMgr = channelMgr(p_Player->GetTeam()))
                if (Channel* chn = cMgr->GetJoinChannel("world", 0))
                    chn->Join(p_Player->GetGUID(), "");

            p_Player->SetCommandStatusOn(CHEAT_GOD);

            m_RandomEventTimer[p_Player->GetGUIDLow()] = 1000;
        }
    }

    void OnUpdate(Player* p_Player, uint32 p_Diff)
    {
        if (!p_Player->GetSession()->IsStressTest())
            return;

        auto l_Itr = m_RandomEventTimer.find(p_Player->GetGUIDLow());
        if (l_Itr == m_RandomEventTimer.end())
            return;

        if (l_Itr->second < p_Diff)
        {
            switch (urand(0, 10))
            {
                case 0:
                {
                    std::ostringstream l_Text;
                    l_Text << "[SAY] StressTest bot " << p_Player->GetGUIDLow();
                    p_Player->Say(l_Text.str(), Language::LANG_UNIVERSAL);
                    break;
                }
                case 1:
                {
                    std::ostringstream l_Text;
                    l_Text << "[CHANNEL] StressTest bot " << p_Player->GetGUIDLow();

                    if (ChannelMgr* l_ChannelManager = channelMgr(p_Player->GetTeam()))
                    {
                        if (Channel* l_Channel = l_ChannelManager->GetChannel("world", p_Player))
                            l_Channel->Say(p_Player->GetGUID(), l_Text.str().c_str(), Language::LANG_UNIVERSAL);
                    }
                    break;
                }
                default:
                {
                    Position l_Pos;
                    p_Player->GetRandomNearPosition(l_Pos, 150.0f);
                    p_Player->GetMotionMaster()->MovePoint(0, l_Pos, false);
                    break;
                }
            }

            l_Itr->second = 2000;
        }
        else
            l_Itr->second -= p_Diff;
    }
};

#ifndef __clang_analyzer__
void AddSC_StressTest()
{
    new StressTest();
};
#endif
