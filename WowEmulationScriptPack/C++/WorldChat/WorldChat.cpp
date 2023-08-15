#include "Chat.h"
#include "Common.h"
#include "Player.h"
#include "RBAC.h"
#include "ScriptMgr.h"
#include "World.h"
#include "worldSession.h"

/* Colors */
#define MSG_COLOR_IRONMAN           "|cffD63931" //LIGHTRED
#define MSG_COLOR_HARDCORE          "|cffFF0000" //RED
#define MSG_COLOR_BRONZE            "|cffFF8000"
#define MSG_COLOR_SILVER            "|cff999999"
#define MSG_COLOR_GOLD              "|cffFFBF40"
#define MSG_COLOR_PLATINUM          "|cff8080BF"
#define MSG_COLOR_DIAMOND           "|cff00BFFF"
#define MSG_COLOR_DEVELOPER         "|cffFFA500" //ORANGE
#define MSG_COLOR_HELPER            "|cffbbbbbb" //SUBWHITE
#define MSG_COLOR_ASSISTANT         "|cffADD8E6" //LIGHTBLUE
#define MSG_COLOR_MODERATOR         "|cff008000" //GREEN
#define MSG_COLOR_GAMEMASTER        "|cff4169E1" //ROYALBLUE
#define MSG_COLOR_HEAD_GAMEMASTER   "|cff4169E1" //ROYALBLUE
#define MSG_COLOR_ADMINISTRATOR     "|cffFFFF00" //YELLOW
#define MSG_COLOR_OWNER             "|cffDA70D6" //PURPLE
#define MSG_COLOR_WHITE             "|cffFFFFFF"

/* Ranks */
#define PLAYER          "[Player]"
#define IRONMAN         "[IronMan]"
#define HARDCORE        "[HardCore]"
#define BRONZE          "[Bronze]"
#define SILVER          "[Silver]"
#define GOLD            "[Gold]"
#define PLATINUM        "[Platinum]"
#define DIAMOND         "[Diamond]"
#define DEVELOPER       "[Developer]"
#define HELPER          "[Helper]"
#define ASSISTANT       "[Assistant]"
#define MODERATOR       "[Mod]"
#define GAMEMASTER      "[GM]"
#define HEADGM          "[Head GM]"
#define ADMINISTRATOR   "[Admin]"
#define OWNER           "[Owner]"

bool IsIronmanPlr(Player *p);
bool IsHardcorePlr(Player *p);
bool IsIronManPlayer(Player *p);
class World_Chat : public CommandScript
{
    public:
        World_Chat() : CommandScript("World_Chat") { }

            static void SendWorldMessage(const char * rank, const char * color, char message[1024], Player * player, const char * msg) {
                snprintf(message, 1024, "[World]%s%s|r[%s%s|r]: %s%s|r", color, rank, MSG_COLOR_WHITE, player->GetName().c_str(), MSG_COLOR_WHITE, msg);
                sWorld->SendGlobalText(message, NULL);
            }

            static bool HandleWorldChatCommand(ChatHandler * pChat, const char * msg)
            {
            if (!*msg)
                return false;
            
                Player * player = pChat->GetSession()->GetPlayer();
                uint32 securityLevel = player->GetSession()->GetSecurity();
                char message[1024];

                if (IsIronManPlayer(player))
                {
                    const char * setColor = "";

                    if (securityLevel == SEC_BRONZE) setColor = MSG_COLOR_BRONZE;
                    else if (securityLevel == SEC_SILVER) setColor = MSG_COLOR_SILVER;
                    else if (securityLevel == SEC_GOLD) setColor = MSG_COLOR_GOLD;
                    else if (securityLevel == SEC_PLATINUM) setColor = MSG_COLOR_PLATINUM;
                    else if (securityLevel == SEC_DIAMOND) setColor = MSG_COLOR_DIAMOND;

                    if (IsHardcorePlr(player)) {
                        if (setColor == "") setColor = MSG_COLOR_HARDCORE;
                        SendWorldMessage(HARDCORE, setColor, message, player, msg);
                        return true;
                    }

                    if (IsIronmanPlr(player)) {
                        if (setColor == "") setColor = MSG_COLOR_IRONMAN;
                        SendWorldMessage(IRONMAN, setColor, message, player, msg);
                        return true;
                    }
                }
                switch (securityLevel)
                {
                    case SEC_PLAYER:        SendWorldMessage(PLAYER, MSG_COLOR_WHITE, message, player, msg);                break;
                    case SEC_BRONZE:        SendWorldMessage(BRONZE, MSG_COLOR_BRONZE, message, player, msg);               break;
                    case SEC_SILVER:        SendWorldMessage(SILVER, MSG_COLOR_SILVER, message, player, msg);               break;
                    case SEC_GOLD:          SendWorldMessage(GOLD, MSG_COLOR_GOLD, message, player, msg);                   break;
                    case SEC_PLATINUM:      SendWorldMessage(PLATINUM, MSG_COLOR_PLATINUM, message, player, msg);           break;
                    case SEC_DIAMOND:       SendWorldMessage(DIAMOND, MSG_COLOR_DIAMOND, message, player, msg);             break;
                    case SEC_DEVELOPER:     SendWorldMessage(DEVELOPER, MSG_COLOR_DEVELOPER, message, player, msg);         break;
                    case SEC_HELPER:        SendWorldMessage(HELPER, MSG_COLOR_HELPER, message, player, msg);               break;
                    case SEC_ASSISTANT:     SendWorldMessage(ASSISTANT, MSG_COLOR_ASSISTANT, message, player, msg);         break;
                    case SEC_MODERATOR:     SendWorldMessage(MODERATOR, MSG_COLOR_MODERATOR, message, player, msg);         break;
                    case SEC_GAMEMASTER:    SendWorldMessage(GAMEMASTER, MSG_COLOR_GAMEMASTER, message, player, msg);       break;
                    case SEC_HEAD_GM:       SendWorldMessage(HEADGM, MSG_COLOR_HEAD_GAMEMASTER, message, player, msg);      break;
                    case SEC_ADMINISTRATOR: SendWorldMessage(ADMINISTRATOR, MSG_COLOR_ADMINISTRATOR, message, player, msg); break;
                    case SEC_OWNER:         SendWorldMessage(OWNER, MSG_COLOR_OWNER, message, player, msg);                 break;
                }
                return true;
            }
            std::vector<ChatCommand> GetCommands() const
            {
                static std::vector<ChatCommand> HandleWorldChatCommandTable =
                {
                    { "world", rbac::RBAC_PERM_COMMAND_WORLD_CHAT, true, &HandleWorldChatCommand, "" },
                };
                return HandleWorldChatCommandTable;
            }
        };

void AddWorldChatScripts()
{
    new World_Chat;
}
