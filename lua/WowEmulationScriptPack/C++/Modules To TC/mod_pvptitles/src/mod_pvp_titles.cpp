#include "ScriptMgr.h"
#include "Configuration/Config.h"
#include "Player.h"
#include "Chat.h"
#include "Player.h"
#include "Config.h"
#include "Pet.h"
#include "SpellAuras.h"
#include "DatabaseEnv.h"
#include "Creature.h"
#include "ScriptedGossip.h"
#include "DBCStores.h"

class PVPTitles : public PlayerScript
{
public:
	PVPTitles() : PlayerScript("PVPTitles") { }

	void OnLogin(Player *player, bool firstLogin)
	{
        if (firstLogin) {
            if (sConfigMgr->GetBoolDefault("PvPTitles.Enable", true))
            {
                if (sConfigMgr->GetBoolDefault("PvPTitles.Announce", true))
                {
                    ChatHandler(player->GetSession()).SendSysMessage("This server is running the |cff4CFF00PvPTitles |rmodule.");
                }
            }
        }
	}

	void OnPVPKill(Player *Killer, Player *Killed) override
	{
		if (sConfigMgr->GetBoolDefault("PvPTitles.Enable", true))
		{
			if (Killer->GetGUID() == Killed->GetGUID())
				return;

			uint32 team = Killer->GetTeamId();
//			uint32 PlusKill = 14;

            const uint32 PVP_LIFETIME_HONORABLE_KILLS = Killer->GetUInt32Value(PLAYER_FIELD_LIFETIME_HONORABLE_KILLS);
            
            const uint32 RANK_1	= sConfigMgr->GetIntDefault("PvPTitles.Rank_1", 50);
            const uint32 RANK_2	= sConfigMgr->GetIntDefault("PvPTitles.Rank_2", 100);
            const uint32 RANK_3	= sConfigMgr->GetIntDefault("PvPTitles.Rank_3", 500);
            const uint32 RANK_4	= sConfigMgr->GetIntDefault("PvPTitles.Rank_4", 1000);
            const uint32 RANK_5	= sConfigMgr->GetIntDefault("PvPTitles.Rank_5", 2000);
            const uint32 RANK_6	= sConfigMgr->GetIntDefault("PvPTitles.Rank_6", 4000);
            const uint32 RANK_7	= sConfigMgr->GetIntDefault("PvPTitles.Rank_7", 5000);
            const uint32 RANK_8	= sConfigMgr->GetIntDefault("PvPTitles.Rank_8", 6000);
            const uint32 RANK_9	= sConfigMgr->GetIntDefault("PvPTitles.Rank_9", 8000);
            const uint32 RANK_10 = sConfigMgr->GetIntDefault("PvPTitles.Rank_10", 10000);
            const uint32 RANK_11 = sConfigMgr->GetIntDefault("PvPTitles.Rank_11", 12500);
            const uint32 RANK_12 = sConfigMgr->GetIntDefault("PvPTitles.Rank_12", 15000);
            const uint32 RANK_13 = sConfigMgr->GetIntDefault("PvPTitles.Rank_13", 20000);
            const uint32 RANK_14 = sConfigMgr->GetIntDefault("PvPTitles.Rank_14", 25000);

			if (PVP_LIFETIME_HONORABLE_KILLS == RANK_1 )
			{
				if (team == TEAM_HORDE)
				{
					Killer->SetTitle(sCharTitlesStore.LookupEntry(15));
				}
				else
				{
					Killer->SetTitle(sCharTitlesStore.LookupEntry(1));
				}
			}
			else if (PVP_LIFETIME_HONORABLE_KILLS == RANK_2 )
			{
				if (team == TEAM_HORDE)
				{
					Killer->SetTitle(sCharTitlesStore.LookupEntry(16));
				}
				else
				{
					Killer->SetTitle(sCharTitlesStore.LookupEntry(2));
				}
			}
			else if (PVP_LIFETIME_HONORABLE_KILLS == RANK_3 )
			{
				if (team == TEAM_HORDE)
				{
					Killer->SetTitle(sCharTitlesStore.LookupEntry(17));
				}
				else
				{
					Killer->SetTitle(sCharTitlesStore.LookupEntry(3));
				}
			}
			else if (PVP_LIFETIME_HONORABLE_KILLS == RANK_4 )
			{
				if (team == TEAM_HORDE)
				{
					Killer->SetTitle(sCharTitlesStore.LookupEntry(18));
				}
				else
				{
					Killer->SetTitle(sCharTitlesStore.LookupEntry(4));
				}
			}
			else if (PVP_LIFETIME_HONORABLE_KILLS == RANK_5 )
			{
				if (team == TEAM_HORDE)
				{
					Killer->SetTitle(sCharTitlesStore.LookupEntry(19));
				}
				else
				{
					Killer->SetTitle(sCharTitlesStore.LookupEntry(5));
				}
			}
			else if (PVP_LIFETIME_HONORABLE_KILLS == RANK_6 )
			{
				if (team == TEAM_HORDE)
				{
					Killer->SetTitle(sCharTitlesStore.LookupEntry(20));
				}
				else
				{
					Killer->SetTitle(sCharTitlesStore.LookupEntry(6));
				}
			}
			else if (PVP_LIFETIME_HONORABLE_KILLS == RANK_7 )
			{
				if (team == TEAM_HORDE)
				{
					Killer->SetTitle(sCharTitlesStore.LookupEntry(21));
				}
				else
				{
					Killer->SetTitle(sCharTitlesStore.LookupEntry(7));
				}
			}
			else if (PVP_LIFETIME_HONORABLE_KILLS == RANK_8 )
			{
				if (team == TEAM_HORDE)
				{
					Killer->SetTitle(sCharTitlesStore.LookupEntry(22));
				}
				else
				{
					Killer->SetTitle(sCharTitlesStore.LookupEntry(8));
				}
			}
			else if (PVP_LIFETIME_HONORABLE_KILLS == RANK_9 )
			{
				if (team == TEAM_HORDE)
				{
					Killer->SetTitle(sCharTitlesStore.LookupEntry(23));
				}
				else
				{
					Killer->SetTitle(sCharTitlesStore.LookupEntry(9));
				}
			}
			else if (PVP_LIFETIME_HONORABLE_KILLS == RANK_10 )
			{
				if (team == TEAM_HORDE)
				{
					Killer->SetTitle(sCharTitlesStore.LookupEntry(24));
				}
				else
				{
					Killer->SetTitle(sCharTitlesStore.LookupEntry(10));
				}
			}
			else if (PVP_LIFETIME_HONORABLE_KILLS == RANK_11 )
			{
				if (team == TEAM_HORDE)
				{
					Killer->SetTitle(sCharTitlesStore.LookupEntry(25));
				}
				else
				{
					Killer->SetTitle(sCharTitlesStore.LookupEntry(11));
				}
			}
			else if (PVP_LIFETIME_HONORABLE_KILLS == RANK_12 )
			{
				if (team == TEAM_HORDE)
				{
					Killer->SetTitle(sCharTitlesStore.LookupEntry(26));
				}
				else
				{
					Killer->SetTitle(sCharTitlesStore.LookupEntry(12));
				}
			}
			else if (PVP_LIFETIME_HONORABLE_KILLS == RANK_13 )
			{
				if (team == TEAM_HORDE)
				{
					Killer->SetTitle(sCharTitlesStore.LookupEntry(27));
				}
				else
				{
					Killer->SetTitle(sCharTitlesStore.LookupEntry(13));
				}
			}
			else if (PVP_LIFETIME_HONORABLE_KILLS == RANK_14 )
			{
				if (team == TEAM_HORDE)
				{
					Killer->SetTitle(sCharTitlesStore.LookupEntry(28));
				}
				else
				{
					Killer->SetTitle(sCharTitlesStore.LookupEntry(14));
				}
			}
		}
	}
};

void AddPvpTitlesScripts() 
{
	new PVPTitles();
}
