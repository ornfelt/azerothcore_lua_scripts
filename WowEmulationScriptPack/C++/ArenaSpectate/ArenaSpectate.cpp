#include "ScriptPCH.h"
#include "Language.h"
#include "Pet.h"
#include "World.h"
#include "BattlegroundMgr.h"
#include "ArenaTeam.h"
#include "ArenaTeamMgr.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "ArenaTeamMgr.h"
#include "Common.h"
#include "DisableMgr.h"
#include "BattlegroundMgr.h"
#include "Battleground.h"
#include "ArenaTeam.h"
#include "Language.h"
#include "Config.h"

class spectate_commandscript : public CommandScript
{
public:
    spectate_commandscript() : CommandScript("spectate_commandscript") { }

    std::vector<ChatCommand> GetCommands() const override
    {
        static std::vector<ChatCommand> pvpCommandTable =
        {
            { "setviewpoint", SEC_PLAYER, false, &HandleSetViewpointCommand, ""},
            { "restoreviewpoint", SEC_PLAYER, false, &HandleRestoreViewpointCommand, ""},
            // { NULL, 0, false, NULL, ""}
        };
        static std::vector<ChatCommand> CommandTable =
        {
            { "spectate", SEC_PLAYER, false, NULL, "", pvpCommandTable },
            // { NULL, 0, false, NULL, ""}
        };
        return CommandTable;
    }

    static bool HandleSetViewpointCommand(ChatHandler* handler, const char* /*args*/)
    {
        if (!sWorld->getBoolConfig(CUSTOM_SCRIPTS_ENABLED_OR_NOT))
            return false;

        sLog->outString("HandleSetViewpointCommand");
        Player* player = handler->GetSession()->GetPlayer();
        if (!player)
            return false;

        Player* target = handler->getSelectedPlayer();
        if (!target)
        {
            handler->PSendSysMessage("You have no player selected.");
            return false;
        }

        if (target == player)
        {
            handler->PSendSysMessage("You can't spectate yourself.");
            return false;
        }

        if (!player->IsSpectator())
        {
            handler->PSendSysMessage("You can't spectate unless you're flagged as a spectator.");
            return false;
        }

        Battleground* bg = target->GetBattleground();
        if (!bg)
        {
            handler->PSendSysMessage("Your target isn't in a battleground/arena.");
            return false;
        }

        if (bg != player->GetBattleground())
        {
            handler->PSendSysMessage("Your target isn't in the same battleground/arena as you.");
            return false;
        }

        if (!bg->isArena())
        {
            handler->PSendSysMessage("Your target isn't in an arena.");
            return false;
        }

        player->SetViewpoint(target, true);
        return true;
    }

    static bool HandleRestoreViewpointCommand(ChatHandler* handler, const char* /*args*/)
    {
        if (!sWorld->getBoolConfig(CUSTOM_SCRIPTS_ENABLED_OR_NOT))
            return false;

        Player* player = handler->GetSession()->GetPlayer();
        if (!player)
            return false;

        WorldObject* viewpoint = player->GetViewpoint();
        if (!viewpoint)
        {
            handler->PSendSysMessage("There is no viewpoint to restore.");
            return false;
        }

        Player* pViewpoint = viewpoint->ToPlayer();
        if (!pViewpoint)
        {
            handler->PSendSysMessage("Your viewpoint isn't a valid player.");
            return false;
        }

        if (pViewpoint == player)
        {
            handler->PSendSysMessage("Your viewpoint is already you.");
            return false;
        }

        if (!player->IsSpectator())
        {
            handler->PSendSysMessage("You can't restore your viewpoint unless you're flagged as a spectator.");
            return false;
        }

        Battleground* bg = pViewpoint->GetBattleground();
        if (!bg)
        {
            sLog->outString("HandleRestoreViewpointCommand:: Viewpoint: ([%u]%s) for player [%u]%s isn't in a battleground..",
                pViewpoint->GetGUIDLow(), pViewpoint->GetName().c_str(), player->GetGUIDLow(), player->GetName().c_str());
            handler->SetSentErrorMessage(false);
            return false;
        }

        if (bg != player->GetBattleground())
        {
            sLog->outString("HandleRestoreViewpointCommand:: Viewpoint: ([%u]%s) for player [%u]%s is in a different battleground.",
                pViewpoint->GetGUIDLow(), pViewpoint->GetName().c_str(), player->GetGUIDLow(), player->GetName().c_str());
            handler->SetSentErrorMessage(false);
            return false;
        }

        player->SetViewpoint(viewpoint, false);
        return true;
    }
};

enum ArenaOptions
{
    ARENA_SPECTATE_MENU_CREATE_TEAM = 2,
    ARENA_SPECTATE_MENU_QUEUE,
    ARENA_SPECTATE_MENU_2V2_MATCHES,
    ARENA_SPECTATE_MENU_3V3_MATCHES,
    ARENA_SPECTATE_MENU_5V5_MATCHES,
    ARENA_SPECTATE_MENU_SPECTATE_PLAYER,
    ARENA_SPECTATE_MENU_PAGE_NEXT,
    ARENA_SPECTATE_MENU_PAGE_PREVIOUS,
};

class npc_arenamaster : public CreatureScript
{
public:
    npc_arenamaster() : CreatureScript("npc_arenamaster") { } // to horde from alliance

    struct npc_arenamasterAI : public ScriptedAI
    {
        npc_arenamasterAI(Creature* creature) : ScriptedAI(creature) {}

        void Reset() override
        {
            if (urand(0, 1))
            {
                me->SetDisplayId(19245);
                me->SetObjectScale(1.3f);
            }
            else
            {
                me->SetDisplayId(20236);
                me->SetObjectScale(0.5f);
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new  npc_arenamasterAI(creature);
    }

    const int MAX_RESULTS_PER_PAGE = 15;

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (!sWorld->getBoolConfig(CUSTOM_SCRIPTS_ENABLED_OR_NOT))
            return false;

        page = 1;
        CreateArenasMap();

        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "|TInterface\\icons\\inv_letter_17:30|t Create An Arena Team", GOSSIP_SENDER_MAIN, ARENA_SPECTATE_MENU_CREATE_TEAM);
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "|TInterface\\icons\\ability_dualwield:30|t Queue For Arena", GOSSIP_SENDER_MAIN, ARENA_SPECTATE_MENU_QUEUE);
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "|TInterface\\icons\\Achievement_arena_2v2_2:30|t Spectate 2v2 Matches", GOSSIP_SENDER_MAIN, ARENA_SPECTATE_MENU_2V2_MATCHES);
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "|TInterface\\icons\\Achievement_arena_3v3_2:30|t Spectate 3v3 Matches", GOSSIP_SENDER_MAIN, ARENA_SPECTATE_MENU_3V3_MATCHES);
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "|TInterface\\icons\\Achievement_arena_5v5_2:30|t Spectate 5v5 Matches", GOSSIP_SENDER_MAIN, ARENA_SPECTATE_MENU_5V5_MATCHES);
        player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_CHAT, "|TInterface\\icons\\inv_misc_grouplooking:30|t Spectate a Player", GOSSIP_SENDER_MAIN, ARENA_SPECTATE_MENU_SPECTATE_PLAYER, "", 0, true);
        player->SEND_GOSSIP_MENU(1, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) override
    {
        if (!sWorld->getBoolConfig(CUSTOM_SCRIPTS_ENABLED_OR_NOT))
            return false;

        player->PlayerTalkClass->ClearMenus();

        switch (sender)
        {
        case GOSSIP_SENDER_MAIN:
        {
            switch (action)
            {
            case GOSSIP_SENDER_MAIN:
            {
                OnGossipHello(player, creature);
                break;
            }
            case ARENA_SPECTATE_MENU_CREATE_TEAM:
            {
                HandleCreateTeam(player, creature);
                break;
            }
            case ARENA_SPECTATE_MENU_QUEUE:
            {
                HandleQueue(player, creature);
                break;
            }
            case ARENA_SPECTATE_MENU_2V2_MATCHES:
            case ARENA_SPECTATE_MENU_3V3_MATCHES:
            case ARENA_SPECTATE_MENU_5V5_MATCHES:
            {
                HandleShowMatches(player, creature, sender, action);
                break;
            }
            }
            break;
        }
        case ARENA_SPECTATE_MENU_2V2_MATCHES:
        case ARENA_SPECTATE_MENU_3V3_MATCHES:
        case ARENA_SPECTATE_MENU_5V5_MATCHES:
        {
            switch (action)
            {
            case ARENA_SPECTATE_MENU_PAGE_NEXT:
            case ARENA_SPECTATE_MENU_PAGE_PREVIOUS:
            {
                HandleShowMatches(player, creature, sender, action);
                break;
            }
            default:
            {
                AddPlayerToArena(player, action);
                break;
            }
            }
            break;
        }
        }
        return true;
    }

    bool OnGossipSelectCode(Player* player, Creature* creature, uint32 sender, uint32 action, const char* code)
    {
        switch (action) { case ARENA_SPECTATE_MENU_SPECTATE_PLAYER: HandleSpectatePlayer(player, code); break; }
        return true;
    }

    void HandleCreateTeam(Player* player, Creature* creature)
    {
        player->CLOSE_GOSSIP_MENU();

        WorldPacket data(SMSG_PETITION_SHOWLIST, 81);
        data << creature->GetGUID();
        data << uint8(3);                                                               // count
        // 2v2
        data << uint32(1);                                                              // index
        data << uint32(23560);                                                          // charter entry
        data << uint32(16161);                                                          // charter display id
        data << uint32(0);                                                              // charter cost
        data << uint32(2);                                                              // unknown
        data << uint32(2);   // required signs?
        // 3v3
        data << uint32(2);                                                              // index
        data << uint32(23561);                                                          // charter entry
        data << uint32(16161);                                                          // charter display id
        data << uint32(0);                                                              // charter cost
        data << uint32(3);                                                              // unknown
        data << uint32(3);   // required signs?
        // 5v5
        data << uint32(3);                                                              // index
        data << uint32(23562);                                                          // charter entry
        data << uint32(16161);                                                          // charter display id
        data << uint32(0);                                                              // charter cost
        data << uint32(5);                                                              // unknown
        data << uint32(5);   // required signs?
        player->GetSession()->SendPacket(&data);
    }

    void HandleQueue(Player* player, Creature* creature)
    {
        player->CLOSE_GOSSIP_MENU();
        player->GetSession()->SendBattleGroundList(creature->GetGUID(), BATTLEGROUND_AA);
    }

    void HandleShowMatches(Player* player, Creature* creature, uint32 sender, uint32 action)
    {
        ChatHandler handler = ChatHandler(player->GetSession());
        CreateArenasMap();
        uint8 arenaType = 0;
        uint32 gossipAction = 0;

        switch (sender)
        {
        case GOSSIP_SENDER_MAIN: arenaType = GetArenaTypeByAction(action); gossipAction = action; break;
        default:                 arenaType = GetArenaTypeByAction(sender); gossipAction = sender; break;
        }

        uint8 roomLeft = MAX_RESULTS_PER_PAGE;

        if (arenasMap.empty())
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "No Arena Matches In Progress", GOSSIP_SENDER_MAIN, gossipAction);
        else
        {
            BattlegroundContainer::iterator itr = arenasMap.begin();

            switch (action)
            {
            case ARENA_SPECTATE_MENU_PAGE_NEXT:
                ++page;
                break;
            case ARENA_SPECTATE_MENU_PAGE_PREVIOUS:
                --page;
                break;
            default:
                break;
            }
            uint16 increment = page * roomLeft;

            if (page > 1)
            {
                for (uint16 i = 0; i < increment; ++i)
                {
                    ++itr;
                    if (itr == arenasMap.end())
                        break;
                }
            }

            for (; itr != arenasMap.end(); ++itr)
            {
                if (!roomLeft)
                    break;

                Battleground* arena = itr->second;
                if (!arena)
                    continue;

                if (!CheckBattleground(arena))
                    continue;

                if (!arena->GetBgMap())
                    continue;

                if (arena->GetArenaType() != arenaType)
                    continue;

                if (!arena->isRated())
                    continue;


                ArenaTeam* hordeTeam = sArenaTeamMgr->GetArenaTeamById(arena->GetArenaTeamIdForTeam(TEAM_HORDE));
                if (!hordeTeam)
                    continue;

                ArenaTeam* allianceTeam = sArenaTeamMgr->GetArenaTeamById(arena->GetArenaTeamIdForTeam(TEAM_ALLIANCE));
                if (!allianceTeam)
                    continue;

                //if (goldTeam->GetStats().Rating < sWorld->getIntConfig(CONFIG_ARENA_SPECTATOR_MIN_RATING) && greenTeam->GetStats().Rating < sWorld->getIntConfig(CONFIG_ARENA_SPECTATOR_MIN_RATING))
                    //continue;

                std::stringstream gossipText;
                // GoldTeamName[GoldTeamRating] vs GreenTeamName[GreenTeamRating]
                gossipText << hordeTeam->GetName() << "[" << hordeTeam->GetRating() << "] vs " << allianceTeam->GetName() << "[" << allianceTeam->GetRating() << "]";
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, gossipText.str(), gossipAction, itr->first);
                --roomLeft;
            }

            if (roomLeft == MAX_RESULTS_PER_PAGE)
            {
                std::stringstream gossipText;
                //if (sWorld->getIntConfig(CONFIG_ARENA_SPECTATOR_MIN_RATING))
                    //gossipText << "No Arena Matches Above " << sWorld->getIntConfig(CONFIG_ARENA_SPECTATOR_MIN_RATING) << " Rating In Progress";
                //else
                    gossipText << "No more matches, go to previous page...";

                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, gossipText.str(), GOSSIP_SENDER_MAIN, gossipAction);
            }

            if (itr != arenasMap.end())
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Next Page", gossipAction, ARENA_SPECTATE_MENU_PAGE_NEXT);

            if (page > 1)
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Previous Page", gossipAction, ARENA_SPECTATE_MENU_PAGE_PREVIOUS);
        }

        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TALK, "Back", GOSSIP_SENDER_MAIN, GOSSIP_SENDER_MAIN);
        player->SEND_GOSSIP_MENU(1, creature->GetGUID());
    }

    void HandleSpectatePlayer(Player* player, const char* cPlayerName)
    {
        ChatHandler handler = ChatHandler(player->GetSession());
        CreateArenasMap();
        uint32 arenaId = 0;
        uint64 tmpGuid = sObjectMgr->GetPlayerGUIDByName(cPlayerName);
        uint32 guidLow = GUID_LOPART(tmpGuid);

        player->CLOSE_GOSSIP_MENU();

        if (!guidLow)
        {
            handler.PSendSysMessage("Unable to find a player with that name.");
            return;
        }

        Player* target = ObjectAccessor::FindPlayer(guidLow);
        if (!target)
        {
            handler.PSendSysMessage("The player you're trying to spectate is offline.");
            return;
        }

        arenaId = target->GetBattlegroundId();
        if (!arenaId)
        {
            handler.PSendSysMessage("The player you're trying to spectate isn't in a arena.");
            return;
        }

        if (!arenasMap[arenaId])
        {
            handler.PSendSysMessage("The arena match of the player you're trying to spectate either hasn't started yet or doesn't exist.");
            return;
        }

        AddPlayerToArena(player, arenaId);
    }

    void AddPlayerToArena(Player* player, uint32 action)
    {
        ChatHandler handler = ChatHandler(player->GetSession());
        CreateArenasMap();
        player->CLOSE_GOSSIP_MENU();

        if (!arenasMap[action])
        {
            handler.PSendSysMessage("The arena match you're trying to spectate either hasn't started yet or doesn't exist.");
            return;
        }

        if (!CheckBattleground(arenasMap[action]))
        {
            handler.PSendSysMessage("The arena match you're trying to spectate hasn't started yet.");
            return;
        }

        if (!arenasMap[action]->GetBgMap())
        {
            handler.PSendSysMessage("The map for the arena match you're trying to spectate is being deconstructed.");
            return;
        }

        Battleground* arena = sBattlegroundMgr->GetBattleground(action);
        if (!arena)
        {
            handler.PSendSysMessage("The arena match of the player you're trying to spectate no longer exists.");
            return;
        }

        if (player->InBattlegroundQueue())
        {
            handler.PSendSysMessage("You need to leave all battleground queues.");
            return;

        }
        player->SetIsSpectator(true);
        player->SetBattlegroundId(action, arena->GetBgTypeID(), PLAYER_MAX_BATTLEGROUND_QUEUES, false, false, TEAM_NEUTRAL);
        //player->SetEntryPoint();
        arena->HandlePlayerUnderMap(player);
    }

    bool CheckBattleground(Battleground* bg)
    {
        if (bg->GetStatus() != STATUS_IN_PROGRESS)
            return false;

        if (!bg->GetPlayersCountByTeam(TEAM_ALLIANCE) || !bg->GetPlayersCountByTeam(TEAM_HORDE))
            return false;

        return true;
    }

    void CreateArenasMap()
    { 
        arenasMap.clear();
        BattlegroundContainer store = sBattlegroundMgr->GetBattlegroundList();

        for (BattlegroundContainer::const_iterator itr = store.begin(); itr != store.end(); ++itr)
            {
                if (itr->second->isArena())
                    arenasMap[itr->first] = itr->second;
            }
    }
private:
    BattlegroundContainer arenasMap;
    uint32 page;

    uint8 GetArenaTypeByAction(uint32 action)
    {
        switch (action)
        {
        case ARENA_SPECTATE_MENU_2V2_MATCHES: return ARENA_TYPE_2v2;
        case ARENA_SPECTATE_MENU_3V3_MATCHES: return ARENA_TYPE_3v3;
        case ARENA_SPECTATE_MENU_5V5_MATCHES: return ARENA_TYPE_5v5;
        default: return 0;
        }
    }
};

void AddSC_ArenaSpectator()
{
    new spectate_commandscript();
    new npc_arenamaster();
}
