#include "ScriptPCH.h" 
#include "ArenaTeam.h"
#include "ArenaTeamMgr.h"
#include "Player.h"
#include "Battleground.h" 

//#define sArenaTeamMgr ACE_Singleton<ArenaTeamMgr, ACE_Null_Mutex>::instance()

class MMRCommandScript : public CommandScript
{
public:
	MMRCommandScript() : CommandScript("MMRCommandScript") {}
    std::vector<ChatCommand> GetCommands() const override
    {
        static std::vector<ChatCommand> mmrCTB =
        {
            { "reset", SEC_PLAYER, true, &HandleMMRResetCommand, ""}, 
            // { NULL, 0, false, NULL, ""}
        };

        static std::vector<ChatCommand> CommandTable =
        {
            { "mmr", SEC_PLAYER, true, NULL, "", mmrCTB },
            // { NULL, 0, false, NULL, ""}
        };

        return CommandTable;
    }

    
	static bool HandleMMRResetCommand(ChatHandler* handler, const char* args)
    {
        if (!sWorld->getBoolConfig(CUSTOM_SCRIPTS_ENABLED_OR_NOT))
            return false;

        if (Player* me = handler->GetSession()->GetPlayer())
        { 
            for (uint8 slot = 0; slot <= 2; ++slot)
                if (uint32 arenaTeamId = Player::GetArenaTeamIdFromStorage(me->GetGUIDLow(), slot))
                { 
                    if (ArenaTeam *team = sArenaTeamMgr->GetArenaTeamById(arenaTeamId))
                    {
                        if (ArenaTeamMember* member = team->GetMember(me->GetGUID()))
                        {
                            int32 mod = sWorld->getIntConfig(CONFIG_ARENA_START_MATCHMAKER_RATING) - member->MatchMakerRating;
                            member->MatchMakerRating = mod;
                            member->ModifyMatchmakerRating(mod, slot);
                            team->SaveToDB();
                        } 
                    }
                }
            me->GetSession()->SendNotification("Your MMR Rating has been reset!");
        }
        return true;
	}
 
};

void AddSC_MMRCommandScript()
{
    new MMRCommandScript();
}










