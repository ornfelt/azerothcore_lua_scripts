#include "ScriptMgr.h"
#include "AccountMgr.h"
#include "time.h"
#include <stdio.h>
#include <stdlib.h>
#include "GameEventMgr.h"
#include "AccountMgr.h"
#include "time.h"
#include <stdio.h>
#include "Bag.h"
#include "Common.h"
#include "Config.h"
#include "DatabaseEnv.h"
#include "DBCStructure.h"
#include "Define.h"
#include "Field.h"
#include "GameEventMgr.h"
#include "Item.h"
#include "Language.h"
#include "Log.h"
#include "ObjectGuid.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "QueryResult.h"
#include "ScriptMgr.h"
#include "SharedDefines.h"
#include "Transaction.h"
#include "WorldSession.h"
#include <sstream>
#include <string>
#include <stdlib.h>
#include <Custom/Logic/CustomCharacterSystem.h>

enum Events {
	HALLOWEENEVENT = 99,
	JUMPEVENT = 95,
	PORTALEVENT = 96,
	WANDERVOLK = 91,
	WINTERFEST = 90,
	FBEVENT = 98,
	CHOPPEREVENT = 97
};

class eventnpc : public CreatureScript
{
public: eventnpc() : CreatureScript("eventnpc"){ }

		struct eventnpc_AI : public ScriptedAI
		{
			eventnpc_AI(Creature* creature) : ScriptedAI(creature) { }
			CustomCharacterSystem * CharacterSystem = 0;
			uint32 ticktimer;
			uint32 actualplayer = 0;
			
			void Reset() {
				ticktimer = 10000;
			}

			

			void UpdateAI(uint32 diff)
			{
				if (ticktimer <= diff) {
					if (Player * player = me->SelectNearestPlayer(10.0f)) {
						if (actualplayer != player->GetGUID()) {
							CharacterSystem->eventNPCAI(HALLOWEENEVENT, me->ToCreature());
						}

					}
				}
				else {
					ticktimer -= diff;
				}
			}

		};

		CreatureAI * GetAI(Creature * creature) const
		{
			return new eventnpc_AI(creature);
		}

		bool OnGossipHello(Player *pPlayer, Creature* _creature)
		{
			if (sConfigMgr->GetBoolDefault("Event.NPC", true)) {
				pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Who I am?", GOSSIP_SENDER_MAIN, 0, "", 0, false);
				pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "X-Mas", GOSSIP_SENDER_MAIN, 1, "", 0, false);
				pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Halloween", GOSSIP_SENDER_MAIN, 2, "", 0, false);
				pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "The Wandervolk", GOSSIP_SENDER_MAIN, 3, "", 0, false);
				pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Jumpevent", GOSSIP_SENDER_MAIN, 4, "", 0, false);
				pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Portal", GOSSIP_SENDER_MAIN, 5, "", 0, false);
				pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "New Year Eve", GOSSIP_SENDER_MAIN, 6, "", 0, false);
				pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "The Chopper Race", GOSSIP_SENDER_MAIN, 7, "", 0, false);
				pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Worldevent", GOSSIP_SENDER_MAIN, 8, "", 0, false);

				pPlayer->PlayerTalkClass->SendGossipMenu(907, _creature->GetGUID());
				return true;
			}

			else {
				pPlayer->PlayerTalkClass->SendGossipMenu(907, _creature->GetGUID());
				return true;
			}
		}
			


		bool OnGossipSelect(Player * pPlayer, Creature * pCreature, uint32 /*uiSender*/, uint32 uiAction)
		{
			switch (uiAction)
			{
				// Weihnachtsevent
				case 1: {
					Quest const* quest;
					quest = sObjectMgr->GetQuestTemplate(900001);
					GameEventMgr::ActiveEvents const& ae = sGameEventMgr->GetActiveEventList();
					bool active = ae.find(WINTERFEST) != ae.end();
					if (active == true){
						pPlayer->GetGUID();
						ChatHandler(pPlayer->GetSession()).PSendSysMessage("Viel Spass beim Weihnachtsevent wuenscht dir Exitare und das gesammte Team. Der Eventbeginn ist in Dalaran bei Bitty Frostschleuder.",
							pPlayer->GetName());
						pPlayer->PlayerTalkClass->SendCloseGossip();
						pPlayer->TeleportTo(1, 16226.21f, 16256.77f, 13.19f, 1.65f);
						if (pPlayer->GetQuestStatus(900001) == QUEST_STATUS_NONE){
							pPlayer->AddQuest(quest,pCreature);
						}

						else{
							return true;
						}
						return true;
					}
					else{
						ChatHandler(pPlayer->GetSession()).PSendSysMessage("Es ist noch nicht Weihnachten! Bitte gedulde dich daher bis zum 16. Dezember.",
							pPlayer->GetName());
						pPlayer->PlayerTalkClass->SendCloseGossip();
					}
					return true;
				}break;
				
						
				case 0: {
					pPlayer->GetGUID();
					ChatHandler(pPlayer->GetSession()).PSendSysMessage("Dieser NPC zeigt die Events an. Mit einem Klick auf das entsprechende Event bekommst du entweder eine Erklaerung, oder wirst bei aktivem Event direkt dorthin geportet. ",
						pPlayer->GetName());
					pPlayer->PlayerTalkClass->SendCloseGossip();
					return true;
				}break;

				//Halloween
				case 2:
				{
					GameEventMgr::ActiveEvents const& ae = sGameEventMgr->GetActiveEventList();
					bool active = ae.find(HALLOWEENEVENT) != ae.end();
					if (active == true){
						pPlayer->GetGUID();
						pPlayer->TeleportTo(0, -9739.81f, 2162.37f, 9.36f, 5.72f);
						ChatHandler(pPlayer->GetSession()).PSendSysMessage("Viel Spass beim Halloweenevent wuenscht dir Exitare und das gesammte Team.",
							pPlayer->GetName());
						pPlayer->PlayerTalkClass->SendCloseGossip();
						return true;
					}
					else{
						pPlayer->GetGUID();
						ChatHandler(pPlayer->GetSession()).PSendSysMessage("Das Halloweenevent ist noch nicht aktiv. Bitte gedulde dich bis zum 21.10 des Jahres.",
							pPlayer->GetName());
						pPlayer->PlayerTalkClass->SendCloseGossip();
						return true;
					}
					return true;
				}break;


				//Wandervolk
				case 3:
				{
					GameEventMgr::ActiveEvents const& ae = sGameEventMgr->GetActiveEventList();
					bool active = ae.find(WANDERVOLK) != ae.end();
					if (active == true){
						pPlayer->GetGUID();
						ChatHandler(pPlayer->GetSession()).PSendSysMessage("Das Event ist aktuell aktiv. Bitte lies dir die Questtexte aufmerksam durch oder frage deine Mitspieler wenn du nicht weiterkommst. Wir wuenschen viel Spass.",
							pPlayer->GetName());
						pPlayer->PlayerTalkClass->SendCloseGossip();
						return true;
					}

					else{
						pPlayer->GetGUID();
						ChatHandler(pPlayer->GetSession()).PSendSysMessage("Das Wandervolk ist alle 3 Tage fuer 16 Stunden verfuegbar. Ihr koennt die Prequests, welche Euch fuer das Event qualifizieren, bei Exitare starten.",
							pPlayer->GetName());
						pPlayer->PlayerTalkClass->SendCloseGossip();
						return true;
					}
					return true;
				}break;

				//Jumpevent
				case 4:
				{
					GameEventMgr::ActiveEvents const& ae = sGameEventMgr->GetActiveEventList();
					bool active = ae.find(JUMPEVENT) != ae.end();
					if (active == true){
						pPlayer->GetGUID();
						pPlayer->TeleportTo(1, 7345.04f, -1541.83f, 161.32f, 0.39f);
						ChatHandler(pPlayer->GetSession()).PSendSysMessage("Das Event ist aktuell aktiv. Viel Spass beim Erreichen des Ziels.",
							pPlayer->GetName());
						pPlayer->PlayerTalkClass->SendCloseGossip();
						return true;
					}

					else{
						pPlayer->GetGUID();
						ChatHandler(pPlayer->GetSession()).PSendSysMessage("Das Jumpevent ist alle 2 Wochen fuer 7 Tage aktiv. Aktuell ist es nicht aktiv.",
							pPlayer->GetName());
						pPlayer->PlayerTalkClass->SendCloseGossip();
						return true;
					}
					return true;
				}break;

				//Portalevent
				case 5:
				{
					GameEventMgr::ActiveEvents const& ae = sGameEventMgr->GetActiveEventList();
					bool active = ae.find(PORTALEVENT) != ae.end();
					if (active == true){
						pPlayer->GetGUID();
						pPlayer->TeleportTo(1, 7345.04f, -1541.83f, 161.32f, 0.39f);
						ChatHandler(pPlayer->GetSession()).PSendSysMessage("Das Event ist aktuell aktiv. Viel Spass beim Erreichen des Ziels.",
							pPlayer->GetName());
						pPlayer->PlayerTalkClass->SendCloseGossip();
						return true;
					}

					else{
						pPlayer->GetGUID();
						ChatHandler(pPlayer->GetSession()).PSendSysMessage("Das Event 'Das Portal' ist alle 14 Tage fuer 7 Tage aktiv.  Aktuell ist es nicht aktiv.",
							pPlayer->GetName());
						pPlayer->PlayerTalkClass->SendCloseGossip();
						return true;
					}
					return true;
				}break;


				//Neujahrsevent
				case 6:
				{
					GameEventMgr::ActiveEvents const& ae = sGameEventMgr->GetActiveEventList();
					bool active = ae.find(75) != ae.end();
					if (active == true && pPlayer->getLevel() == 1){
                        if (pPlayer->getLevel() > 1){
                            pPlayer->GetSession()->SendNotification("Du bist nicht Level 1.");
                        }

                        pPlayer->GetGUID();
						pPlayer->TeleportTo(1, -8455.62f, -1321.31f, 8.87f, 3.29f);
						ChatHandler(pPlayer->GetSession()).PSendSysMessage("Das Event ist aktuell aktiv. Viel Spass beim Erreichen des Ziels.",
							pPlayer->GetName());
						pPlayer->PlayerTalkClass->SendCloseGossip();
						return true;
					}

					
					else{
						pPlayer->GetGUID();
						ChatHandler(pPlayer->GetSession()).PSendSysMessage("Das Event 'Neujahrsevent' ist ab 1.01. verfuegbar.  Aktuell ist es nicht aktiv.",
							pPlayer->GetName());
						pPlayer->PlayerTalkClass->SendCloseGossip();
						return true;
					}
					return true;
				}break;


				//Chopperevent
				case 7:
				{
					GameEventMgr::ActiveEvents const& ae = sGameEventMgr->GetActiveEventList();
					bool active = ae.find(CHOPPEREVENT) != ae.end();
					if (active == true && pPlayer->getLevel() == 1){
						pPlayer->GetGUID();
						pPlayer->TeleportTo(0, 2075.54f, 2392.44f, 131.25f, 3.12f);
						ChatHandler(pPlayer->GetSession()).PSendSysMessage("Das Event ist aktuell aktiv. Viel Spass beim Erreichen des Ziels.",
							pPlayer->GetName());
						pPlayer->PlayerTalkClass->SendCloseGossip();
						return true;
					}

					if (pPlayer->getLevel() > 1){
						pPlayer->GetSession()->SendNotification("Du bist nicht Level 1.");
					}

					else{
						pPlayer->GetGUID();
						ChatHandler(pPlayer->GetSession()).PSendSysMessage("Das Chopperevent wird von dem Event-Team manuell gestartet. Informiert Euch bei diesem.",
							pPlayer->GetName());
						pPlayer->PlayerTalkClass->SendCloseGossip();
						return true;
					}
					return true;
				}break;

				//Worldevent
				case 8:
				{
					GameEventMgr::ActiveEvents const& ae = sGameEventMgr->GetActiveEventList();
					bool active = ae.find(77) != ae.end();
					if (active == true){
						pPlayer->GetGUID();
						pPlayer->TeleportTo(0, -4796.05f, -1001.17f, 895.85f , 5.82f);
						ChatHandler(pPlayer->GetSession()).PSendSysMessage("Das Event ist aktuell aktiv. Viel Spass beim Erreichen des Ziels.",
							pPlayer->GetName());
						pPlayer->PlayerTalkClass->SendCloseGossip();
						return true;
					}

					
					else{
						pPlayer->GetGUID();
						ChatHandler(pPlayer->GetSession()).PSendSysMessage("Das Worldevent ist zur Zeit nicht aktiv.",
							pPlayer->GetName());
						pPlayer->PlayerTalkClass->SendCloseGossip();
						return true;
					}
					return true;

				}break;

					return true;
			}
			return true;
		}
};


void AddSC_eventnpc()
{
	new eventnpc();
}