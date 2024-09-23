/**
    This plugin can be used for common player customizations
 */

#include "Config.h"
#include "Log.h"
#include "World.h"
#include "Player.h"
#include "Formulas.h"
#include "Group.h"
#include "Guild.h"
#include "BattlegroundMgr.h"
#include "Chat.h"



bool GainHonorGuardEnable = 1;
bool GainHonorGuardAnnounceModule = 1;
bool GainHonorGuardOnGuardKill = 1;
bool GainHonorGuardOnEliteKill = 1;
bool GainHonorGuardOnGuardKillAnnounce = 1;
bool GainHonorGuardOnEliteKillAnnounce = 1;
bool GainHonorRateEnable = 1;
float GainHonorRate = 1.0;

class GainHonorGuardConfig : public WorldScript
{
public:
    GainHonorGuardConfig() : WorldScript("GainHonorGuardConfig") {}

    void OnBeforeConfigLoad(bool reload)
    {
        if (!reload) {
            // Load Configuration Settings
            SetInitialWorldSettings();
        }
    }

    // Load Configuration Settings
    void SetInitialWorldSettings()
    {
		GainHonorGuardEnable = sConfigMgr->GetBoolDefault("GainHonorGuard.Enable", 1);
        GainHonorGuardAnnounceModule = sConfigMgr->GetBoolDefault("GainHonorGuard.Announce", 1);
		
		//Gain Honor Settings
		GainHonorGuardOnGuardKill = sConfigMgr->GetBoolDefault("GainHonorGuard.GainHonorOnGuardKill", 0);
        GainHonorGuardOnEliteKill = sConfigMgr->GetBoolDefault("GainHonorGuard.GainHonorOnEliteKill", 0);	

		//Announce honor gained
		GainHonorGuardOnGuardKillAnnounce = sConfigMgr->GetBoolDefault("GainHonorGuard.GainHonorOnGuardKillAnnounce", 0);
		GainHonorGuardOnEliteKillAnnounce = sConfigMgr->GetBoolDefault("GainHonorGuard.GainHonorOnEliteKillAnnounce", 0);

		//Honor Rate
		GainHonorRateEnable = sConfigMgr->GetBoolDefault("GainHonorGuard.GainHonorRateEnable", 0);
		GainHonorRate = abs(sConfigMgr->GetFloatDefault("GainHonorGuard.GainHonorRate", 1.0));
	}
};

class GainHonorGuardAnnouce : public PlayerScript
{

public:

    GainHonorGuardAnnouce() : PlayerScript("GainHonorGuard") {}

    void OnLogin(Player* player, bool firstLogin)
	{
        if (firstLogin) {
            // Announce Module
            if (GainHonorGuardEnable)
            {
                if (GainHonorGuardAnnounceModule)
                {
                    ChatHandler(player->GetSession()).SendSysMessage("This server is running the |cff4CFF00GainHonorGuard |rmodule.");
                }
            }
        }
    }
};

class GainHonorGuard : public PlayerScript
{

public:

    GainHonorGuard() : PlayerScript("GainHonorGuard") {}
	
    void OnCreatureKill(Player* player, Creature* killed)  //override
    {
		RewardHonor(player, killed);
	}
	
    void OnCreatureKilledByPet(Player* player, Creature* killed) //override
    {
		RewardHonor(player, killed);
	}

	//Reward Honor from either a Guard (creature 32768 flag) or Elite kill.  
	void RewardHonor(Player* player, Creature* killed)
	{
        if (GainHonorGuardEnable && player->IsAlive() && !player->InArena() && !player->HasAura(SPELL_AURA_PLAYER_INACTIVE))
        {			
			if (killed || !killed->HasAuraType(SPELL_AURA_NO_PVP_CREDIT))
			{				
				if ((GainHonorGuardOnGuardKill && killed->ToCreature()->IsGuard()) || (GainHonorGuardOnEliteKill && killed->ToCreature()->isElite()))
				{
				
					std::ostringstream ss;		
					int honor = -1; //Honor is added as an int
					float honor_f = (float)honor; //Convert honor to float for calculations 
					player->UpdateHonorFields();
					
					int groupsize = GetNumInGroup(player); //Determine if it was a gang beatdown
					
					//Determine level that is gray
					uint8 k_level = player->GetLevel();
					uint8 k_grey = Trinity::XP::GetGrayLevel(k_level);
					uint8 v_level = killed->GetLevel();
					
					
					// If guard or elite is grey to the player then no honor rewarded
					if (v_level > k_grey)
					{
						honor_f = ceil(Trinity::Honor::hk_honor_at_level_f(k_level) * (v_level - k_grey) / (k_level - k_grey));

						// count the number of playerkills in one day
						player->ApplyModUInt32Value(PLAYER_FIELD_KILLS, 1, true);
						// and those in a lifetime
						player->ApplyModUInt32Value(PLAYER_FIELD_LIFETIME_HONORABLE_KILLS, 1, true);
						player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_EARN_HONORABLE_KILL);
						player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_HK_CLASS, killed->GetClass());
						player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_HK_RACE, killed->GetRace());
						player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_HONORABLE_KILL_AT_AREA, player->GetAreaId());
						player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_HONORABLE_KILL, 1, 0, killed);
						
						
						if (killed != nullptr)
						{
							//A Gang beatdown of an enemy rewards less honor 
							if (groupsize > 1)
								honor_f /= groupsize;

							// apply honor multiplier from aura (not stacking-get highest)
							AddPct(honor_f, player->GetMaxPositiveAuraModifier(SPELL_AURA_MOD_HONOR_GAIN_PCT));
						}

						//Custom Gain Honor Rate 
						if (GainHonorRateEnable)
						{
							honor_f *= GainHonorRate;
						}
						else
						{
							honor_f *= sWorld->getRate(RATE_HONOR);
						}
						
						//sLog->outError("%u: gained honor with a rate: %0.2f", player->GetGUID(), sWorld->getRate(RATE_HONOR));

						// Convert Honor Back to an int to add to player
						honor = int32(honor_f);
						
						//Not sure if this works.  
						WorldPacket data(SMSG_PVP_CREDIT, 4 + 8 + 4);
						data << honor;


						// add honor points to player
						player->ModifyHonorPoints(honor);

						player->ApplyModUInt32Value(PLAYER_FIELD_TODAY_CONTRIBUTION, honor, true);
						
						//announce to player if honor was gained
						if (GainHonorGuardOnGuardKill && killed->ToCreature()->IsGuard() && GainHonorGuardOnGuardKillAnnounce)
						{
							ss << "You have been awarded |cff4CFF00%i |rHonor.";
							ChatHandler(player->GetSession()).PSendSysMessage(ss.str().c_str(), honor);
						}
						else if (GainHonorGuardOnEliteKill && killed->ToCreature()->isElite() && GainHonorGuardOnEliteKillAnnounce)
						{
							ss << "You have been awarded |cffFF8000%i |rHonor.";
							ChatHandler(player->GetSession()).PSendSysMessage(ss.str().c_str(), honor);	
						}						
					}
				}
			}
		}
    }	

    // Get the player's group size
    int GetNumInGroup(Player* player) 
	{
        int numInGroup = 1;
        Group *group = player->GetGroup();
        if (group) {
            Group::MemberSlotList const& groupMembers = group->GetMemberSlots();
            numInGroup = groupMembers.size();
		}
        return numInGroup;
    }
	
};


void AddGainHonorGuardScripts() {
	new GainHonorGuardConfig();
	new GainHonorGuardAnnouce();
    new GainHonorGuard();
}

