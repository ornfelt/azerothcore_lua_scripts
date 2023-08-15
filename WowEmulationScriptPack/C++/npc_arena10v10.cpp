/////////////////////////////////////////////////////////////////////////////
//        ____        __  __  __     ___                                   //
//       / __ )____ _/ /_/ /_/ /__  /   |  ________  ____  ____ ______     //
//      / __  / __ `/ __/ __/ / _ \/ /| | / ___/ _ \/ __ \/ __ `/ ___/     //
//     / /_/ / /_/ / /_/ /_/ /  __/ ___ |/ /  /  __/ / / / /_/ (__  )      //
//    /_____/\__,_/\__/\__/_/\___/_/  |_/_/   \___/_/ /_/\__,_/____/       //
//         Developed by Natureknight for BattleArenas.no-ip.org            //
//             Copyright (C) 2015 Natureknight/JessiqueBA                  //
//                      battlearenas.no-ip.org                             //
/////////////////////////////////////////////////////////////////////////////

#include "ScriptMgr.h"
#include "ArenaTeamMgr.h"
#include "Common.h"
#include "DisableMgr.h"
#include "BattlegroundMgr.h"
#include "Battleground.h"
#include "ArenaTeam.h"
#include "Language.h"
#include "npc_arena10v10.h"

class npc_10v10skirmish : public CreatureScript
{
public:
	npc_10v10skirmish() : CreatureScript("npc_10v10skirmish") { }

	bool JoinQueueArena(Player* player, Creature* me, bool isRated)
	{
		if(!player || !me)
			return false;

		if(sWorld->getIntConfig(CONFIG_ARENA_1V1_MIN_LEVEL) > player->getLevel())
			return false;

		uint64 guid = player->GetGUID();
		uint8 arenaslot = ArenaTeam::GetSlotByType(ARENA_TYPE_10v10);
		uint8 arenatype = ARENA_TYPE_10v10;
		uint32 arenaRating = 0;
		uint32 matchmakerRating = 0;

		// ignore if we already in BG or BG queue
		if (player->InBattleground())
			return false;

		//check existance
		Battleground* bg = sBattlegroundMgr->GetBattlegroundTemplate(BATTLEGROUND_AA);
		if (!bg)
		{
			sLog->outError("Battleground: template bg (all arenas) not found");
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

		BattlegroundQueue &bgQueue = sBattlegroundMgr->m_BattlegroundQueues[bgQueueTypeId];
		bg->SetRated(isRated);

		GroupQueueInfo* ginfo = bgQueue.AddGroup(player, NULL, bgTypeId, bracketEntry, arenatype, isRated, false, arenaRating, matchmakerRating, ateamId);
		uint32 avgTime = bgQueue.GetAverageQueueWaitTime(ginfo, bracketEntry->GetBracketId());
		uint32 queueSlot = player->AddBattlegroundQueueId(bgQueueTypeId);

		WorldPacket data;
		// send status packet (in queue)
		sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, bg, queueSlot, STATUS_WAIT_QUEUE, avgTime, 0, arenatype);
		player->GetSession()->SendPacket(&data);

		sBattlegroundMgr->ScheduleQueueUpdate(matchmakerRating, arenatype, bgQueueTypeId, bgTypeId, bracketEntry->GetBracketId());

		return true;
	}

	bool OnGossipHello(Player* player, Creature* me)
	{
		if(!player || !me)
			return true;

		if(sWorld->getBoolConfig(CONFIG_ARENA_1V1_ENABLE) == false)
		{
			ChatHandler(player->GetSession()).SendSysMessage("1v1 disabled!");
			return true;
		}

		if (player->InBattlegroundQueueForBattlegroundQueueType(BATTLEGROUND_QUEUE_10v10))
			player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_INTERACT_1, "Leave 10v10 Skirmish Queue", GOSSIP_SENDER_MAIN, 3, "Are you sure?", 0, false);
		else
			player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "Join 10v10 Skirmish Arena", GOSSIP_SENDER_MAIN, 20);

		player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "Script Information", GOSSIP_SENDER_MAIN, 8);
		player->SEND_GOSSIP_MENU(60014, me->GetGUID());
		return true;
	}



	bool OnGossipSelect(Player* player, Creature* me, uint32 /*uiSender*/, uint32 uiAction)
	{
		if(!player || !me)
			return true;

		player->PlayerTalkClass->ClearMenus();

		// Players in queue are unable to join 10v10 skirmish
		Battleground* bg = sBattlegroundMgr->GetBattlegroundTemplate(BATTLEGROUND_AA); // All Arenas
		BattlegroundTypeId bgTypeId = bg->GetTypeID();
		BattlegroundQueueTypeId bgQueueTypeId = BattlegroundMgr::BGQueueTypeId(bgTypeId, bg->GetArenaType());

		// Its impossible to use uiAction 3 while is in another queue than 10v10
		// so no problem to handle it this way:
		if (player->GetBattlegroundQueueIndex(bgQueueTypeId) && uiAction != 3)
		{
			player->GetSession()->SendAreaTriggerMessage("You're already in another queue. Please remove it first.");
			player->CLOSE_GOSSIP_MENU();
			return false;
		}

		switch (uiAction)
		{
		case 2: // Join Queue Arena (rated)
			{
				if(Arena1v1CheckTalents(player) && JoinQueueArena(player, me, true) == false)
					ChatHandler(player->GetSession()).SendSysMessage("Something went wrong while join queue.");

				player->CLOSE_GOSSIP_MENU();
				return true;
			}
			break;

		case 20: // Join Queue Arena (unrated)
			{
				if(JoinQueueArena(player, me, false) == false)
					ChatHandler(player->GetSession()).SendSysMessage("Something went wrong while join queue.");

				player->CLOSE_GOSSIP_MENU();
				return true;
			}
			break;

		case 3: // Leave Queue
			{
				// TODO: Write funcion to leave all arena queues
				uint8 arenaType = ARENA_TYPE_10v10;
				if (player->InBattlegroundQueueForBattlegroundQueueType(BATTLEGROUND_QUEUE_3v3_SOLO))
					arenaType = ARENA_TYPE_3v3_SOLO;

				WorldPacket Data;
				Data << arenaType << (uint8)0x0 << (uint32)BATTLEGROUND_AA << (uint16)0x0 << (uint8)0x0;
				player->GetSession()->HandleBattleFieldPortOpcode(Data);
				player->CLOSE_GOSSIP_MENU();
				return true;
			}
			break;

		case 8: // Script Info
			{
				player->GetSession()->SendAreaTriggerMessage("Developer: Natureknight");
				player->GetSession()->SendAreaTriggerMessage("Website: battlearenas.no-ip.org");
				player->CLOSE_GOSSIP_MENU();
				return true;
			}
			break;

		}

		OnGossipHello(player, me);
		return true;
	}
};


void AddSC_npc_10v10skirmish()
{
	new npc_10v10skirmish();
}