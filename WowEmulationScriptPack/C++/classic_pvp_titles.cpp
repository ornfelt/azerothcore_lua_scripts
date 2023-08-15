#include "ScriptPCH.h"
 
enum Ranks
{
        RANK_1  = 50,
        RANK_2  = 100,
        RANK_3  = 500,
        RANK_4  = 1000,
        RANK_5  = 2000,
        RANK_6  = 4000,
        RANK_7  = 5000,
        RANK_8  = 6000,
        RANK_9  = 8000,
        RANK_10 = 10000,
        RANK_11 = 12500,
        RANK_12 = 15000,
        RANK_13 = 20000,
        RANK_14 = 25000,
};
 
class PVPTitles : public PlayerScript
{
public:
        PVPTitles() : PlayerScript("PVPTitles") { }
 
        void OnPVPKill(Player *Killer, Player *Killed)
        {
                if (Killer->GetGUID() == Killed->GetGUID())
                        return;
                       
                uint32 team = Killer->GetTeam();
 
                switch(Killer->GetUInt32Value(PLAYER_FIELD_LIFETIME_HONORABLE_KILLS))
                {
                        case RANK_1:
                                Killer->SetTitle(sCharTitlesStore.LookupEntry(1 + (team == ALLIANCE ? 0 : 14)));
                                break;
                        case RANK_2:
                                Killer->SetTitle(sCharTitlesStore.LookupEntry(2 + (team == ALLIANCE ? 0 : 14)));
                                break;
                        case RANK_3:
                                Killer->SetTitle(sCharTitlesStore.LookupEntry(3 + (team == ALLIANCE ? 0 : 14)));
                                break;
                        case RANK_4:
                                Killer->SetTitle(sCharTitlesStore.LookupEntry(4 + (team == ALLIANCE ? 0 : 14)));
                                break;
                        case RANK_5:
                                Killer->SetTitle(sCharTitlesStore.LookupEntry(5 + (team == ALLIANCE ? 0 : 14)));
                                break;
                        case RANK_6:
                                Killer->SetTitle(sCharTitlesStore.LookupEntry(6 + (team == ALLIANCE ? 0 : 14)));
                                break;
                        case RANK_7:
                                Killer->SetTitle(sCharTitlesStore.LookupEntry(7 + (team == ALLIANCE ? 0 : 14)));
                                break;
                        case RANK_8:
                                Killer->SetTitle(sCharTitlesStore.LookupEntry(8 + (team == ALLIANCE ? 0 : 14)));
                                break;
                        case RANK_9:
                                Killer->SetTitle(sCharTitlesStore.LookupEntry(9 + (team == ALLIANCE ? 0 : 14)));
                                break;
                        case RANK_10:
                                Killer->SetTitle(sCharTitlesStore.LookupEntry(10 + (team == ALLIANCE ? 0 : 14)));
                                break;
                        case RANK_11:
                                Killer->SetTitle(sCharTitlesStore.LookupEntry(11 + (team == ALLIANCE ? 0 : 14)));
                                break;
                        case RANK_12:
                                Killer->SetTitle(sCharTitlesStore.LookupEntry(12 + (team == ALLIANCE ? 0 : 14)));
                                break;
                        case RANK_13:
                                Killer->SetTitle(sCharTitlesStore.LookupEntry(13 + (team == ALLIANCE ? 0 : 14)));
                                break;
                        case RANK_14:
                                Killer->SetTitle(sCharTitlesStore.LookupEntry(14 + (team == ALLIANCE ? 0 : 14)));
                                break;
                }
        }
};
#ifndef __clang_analyzer__
void AddSC_PVPTitles()
{
        new PVPTitles();
}
#endif