#include "AccountMgr.h"
#include "ArenaTeam.h"
#include "ArenaTeamMgr.h"
#include "BattlegroundMgr.h"
#include "Battleground.h"
#include "Chat.h"
#include "Common.h"
#include "Creature.h"
#include "DBCStores.h"
#include "DisableMgr.h"
#include "Language.h"
#include "Log.h"
#include "npc_arenasolo.h"
#include "ObjectMgr.h"
#include "ObjectExtension.cpp"
#include "PassiveAI.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedGossip.h"
#include "WorldSession.h"

void AddGossipItemForArcemu(Player* player, uint32 icon, std::string const& text, uint32 MenuId);
void AddGossipItemExtended(Player* player, uint32 icon, std::string const& text, uint32 MenuId, std::string const& text2, uint32 money, bool scripted);

class ArenaSolo : public CreatureScript
{
public:
    ArenaSolo() : CreatureScript("Npc_arenasolo") { }

    struct ArenaSoloAI : public CreatureAI
    {
        ArenaSoloAI(Creature* creature) : CreatureAI(creature)
        {
        }

        void UpdateAI(uint32 diff) override
        {
        }

        void send_MainPage(Player* player);
        bool GossipHello(Player* player);
        bool GossipSelect(Player* player, uint32 Id, uint32 gossipListId);
        
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new ArenaSoloAI(creature);
    }
};

    bool JoinQueueArena(Player * player, bool isRated)
    {
        if(!player)
            return false;

        if(player->getLevel() < 80)
            return false;

        ObjectGuid guid = player->GetGUID();
        uint8 arenaslot = ArenaTeam::GetSlotByType(ARENA_TEAM_5v5);
        uint8 arenatype = ARENA_TYPE_5v5;
        uint32 arenaRating = 0;
        uint32 matchmakerRating = 0;

        // ignore if we already in BG or BG queue
        if (player->InBattleground())
            return false;

        //check existance
        Battleground* bg = sBattlegroundMgr->GetBattlegroundTemplate(BATTLEGROUND_AA);
        if (!bg)
        {
            TC_LOG_ERROR("Arena", "Battleground: template bg (all arenas) not found");
            return false;
        }

        if (DisableMgr::IsDisabledFor(DISABLE_TYPE_BATTLEGROUND, BATTLEGROUND_AA, NULL))
        {
            ChatHandler(player->GetSession()).PSendSysMessage(LANG_ARENA_DISABLED);
            return false;
        }

        BattlegroundTypeId bgTypeId = bg->GetTypeID();
        BattlegroundQueueTypeId bgQueueTypeId = BattlegroundMgr::BGQueueTypeId(bgTypeId, arenatype);
        PvPDifficultyEntry const* bracketEntry = GetBattlegroundBracketByLevel(bg->GetMapId(), player->getLevel());
        if (!bracketEntry)
            return false;

        GroupJoinBattlegroundResult err = ERR_GROUP_JOIN_BATTLEGROUND_FAIL;

        // check if already in queue
        if (player->GetBattlegroundQueueIndex(bgQueueTypeId) < PLAYER_MAX_BATTLEGROUND_QUEUES)
            //player is already in this queue
            return false;
        // check if has free queue slots
        if (!player->HasFreeBattlegroundQueueId())
            return false;

        uint32 ateamId = 0;

        if(isRated)
        {
            ateamId = player->GetArenaTeamId(arenaslot);
            ArenaTeam* at = sArenaTeamMgr->GetArenaTeamById(ateamId);
            if (!at)
            {
                player->GetSession()->SendNotInArenaTeamPacket(arenatype);
                return false;
            }

            // get the team rating for queueing
            arenaRating = at->GetRating();
            matchmakerRating = arenaRating;
            // the arenateam id must match for everyone in the group

            if (arenaRating <= 0)
                arenaRating = 1;
        }

        BattlegroundQueue &bgQueue = sBattlegroundMgr->GetBattlegroundQueue(bgQueueTypeId);
        bg->SetRated(isRated);

        GroupQueueInfo* ginfo = bgQueue.AddGroup(player, NULL, bgTypeId, bracketEntry, arenatype, isRated, false, arenaRating, matchmakerRating, ateamId);
        uint32 avgTime = bgQueue.GetAverageQueueWaitTime(ginfo, bracketEntry->GetBracketId());
        uint32 queueSlot = player->AddBattlegroundQueueId(bgQueueTypeId);

        WorldPacket data;
        // send status packet (in queue)
        sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, bg, queueSlot, STATUS_WAIT_QUEUE, avgTime, 0, arenatype, 0);
        player->GetSession()->SendPacket(&data);

        sBattlegroundMgr->ScheduleQueueUpdate(matchmakerRating, arenatype, bgQueueTypeId, bgTypeId, bracketEntry->GetBracketId());

        return true;
    }

    bool CreateArenateam(Player* player)
    {
        if(!player)
            return false;

        uint8 slot = ArenaTeam::GetSlotByType(ARENA_TEAM_5v5);
        if (slot >= MAX_ARENA_SLOT)
            return false;

        // Check if player is already in an arena team
        if (player->GetArenaTeamId(slot))
        {
            player->GetSession()->SendArenaTeamCommandResult(ERR_ARENA_TEAM_CREATE_S, player->GetName(), "", ERR_ALREADY_IN_ARENA_TEAM);
            return false;
        }


        // Teamname = playername
        // if teamname exist, we have to choose another name (playername + number)
        int i = 1;
        std::stringstream teamName;
        teamName << player->GetName();
        do
        {
            if(sArenaTeamMgr->GetArenaTeamByName(teamName.str()) != NULL) // teamname exist, so choose another name
            {
                teamName.str(std::string());
                teamName << player->GetName() << (i++);
            }
           else
                break;
        } while (i < 100); // should never happen

        // Create arena team
        ArenaTeam* arenaTeam = new ArenaTeam();

        if (!arenaTeam->Create(player->GetGUID(), ARENA_TEAM_5v5, teamName.str(), 4283124816, 45, 4294242303, 5, 4294705149))
        {
            delete arenaTeam;
            return false;
        }

       // Register arena team
        sArenaTeamMgr->AddArenaTeam(arenaTeam);
        arenaTeam->AddMember(player->GetGUID());

        ChatHandler(player->GetSession()).SendSysMessage("1v1 Arenateam successful created!");

        return true;
   }

    void ArenaSolo::ArenaSoloAI::send_MainPage(Player * player) {
        ClearGossipMenuFor(player);

        if (player->InBattlegroundQueueForBattlegroundQueueType(BATTLEGROUND_QUEUE_5v5))
            AddGossipItemExtended(player, GOSSIP_ICON_CHAT, "Leave queue 1v1 Arena", 3, "Are you sure?", 0, false);
        else
            AddGossipItemForArcemu(player, GOSSIP_ICON_CHAT, "Sign up 1v1 Arena (unrated)", 20);

        if (player->GetArenaTeamId(ArenaTeam::GetSlotByType(ARENA_TEAM_5v5)) == 0)
            AddGossipItemExtended(player, GOSSIP_ICON_CHAT, "Create new 1v1 Arenateam", 1, "Create 1v1 arenateam?", 400000, false);
        else
        {
            if (player->InBattlegroundQueueForBattlegroundQueueType(BATTLEGROUND_QUEUE_5v5) == false)
            {
                AddGossipItemForArcemu(player, GOSSIP_ICON_CHAT, "Sign up 1v1 Arena (rated)", 2);
                AddGossipItemExtended(player, GOSSIP_ICON_CHAT, "Disband arenateam", 5, "Are you sure?", 0, false);
            }

            AddGossipItemForArcemu(player, GOSSIP_ICON_CHAT, "Show statistics", 4);
        }

        SendGossipMenuFor(player, 68, me->GetGUID());
    }

    bool ArenaSolo::ArenaSoloAI::GossipHello(Player * player)
    {
        send_MainPage(player);
        return true;
    }

    bool ArenaSolo::ArenaSoloAI::GossipSelect(Player* player, uint32 Id, uint32 gossipListId)
    {
        if (player)
        {
            if (player->IsInCombat())
            {
                me->Whisper(std::string("You are not allowed to use Arenam Master while in combat"), LANG_UNIVERSAL, player);
                return false;
            }
        }

        uint32 const IntId = player->PlayerTalkClass->GetGossipOptionAction(gossipListId);

        switch (IntId)
        {
            case 0:
                send_MainPage(player);
                break; //main
            case 1: // Create new Arenateam
                {
                    if(player->getLevel() >= 80)
                    {
                        if(player->GetMoney() >= 400000 && CreateArenateam(player))
                            player->ModifyMoney(-400000);
                    }
                    else
                   {
                        ChatHandler(player->GetSession()).PSendSysMessage("You need level %u+ to create an 1v1 arenateam.", 80);
                        CloseGossipMenuFor(player);
                        return true;
                    }
                }
                break;

            case 2: // Join Queue Arena (rated)
                {
                    if(Arena1v1CheckTalents(player) && JoinQueueArena(player, true) == false)
                        ChatHandler(player->GetSession()).SendSysMessage("Something went wrong while join queue.");

                    CloseGossipMenuFor(player);
                    return true;
                }
                break;

            case 20: // Join Queue Arena (unrated)
                {
                    if(Arena1v1CheckTalents(player) && JoinQueueArena(player, false) == false)
                        ChatHandler(player->GetSession()).SendSysMessage("Something went wrong while join queue.");

                    CloseGossipMenuFor(player);
                    return true;
                }
                break;

            case 3: // Leave Queue
                {
                    WorldPacket Data;
                    Data << (uint8)0x1 << (uint8)0x0 << (uint32)BATTLEGROUND_AA << (uint16)0x0 << (uint8)0x0;
                    player->GetSession()->HandleBattleFieldPortOpcode(Data);
                    CloseGossipMenuFor(player);
                    return true;
                }
                break;

            case 4: // get statistics
                {
                    ArenaTeam* at = sArenaTeamMgr->GetArenaTeamById(player->GetArenaTeamId(ArenaTeam::GetSlotByType(ARENA_TEAM_5v5)));
                    if(at)
                    {
                        std::stringstream s;
                        s << "Rating: " << at->GetStats().Rating;
                        s << "\nRank: " << at->GetStats().Rank;
                        s << "\nSeason Games: " << at->GetStats().SeasonGames;
                        s << "\nSeason Wins: " << at->GetStats().SeasonWins;
                        s << "\nWeek Games: " << at->GetStats().WeekGames;
                        s << "\nWeek Wins: " << at->GetStats().WeekWins;

                        ChatHandler(player->GetSession()).PSendSysMessage(s.str().c_str());
                    }
                }
                break;


            case 5: // Disband arenateam
                {
                    WorldPacket Data;
                    Data << (uint32)player->GetArenaTeamId(ArenaTeam::GetSlotByType(ARENA_TEAM_5v5));
                    player->GetSession()->HandleArenaTeamLeaveOpcode(Data);
                    ChatHandler(player->GetSession()).SendSysMessage("Arenateam deleted!");
                    CloseGossipMenuFor(player);
                    return true;
                }
                break;

        }
        return true;
    }

void AddArenaSoloScripts()
{
    new ArenaSolo();
}
/*
insert into `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) values('123454','0','0','0','0','0','21665','0','0','0','1v1 Arena Master','','','0','80','80','0','35','1','1','1.14286','1','0','0','2000','2000','1','1','1','0','0','0','0','0','0','0','0','7','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','1','1','1','1','1','1','0','0','1','0','0','2','Npc_arenasolo','0');

*/
