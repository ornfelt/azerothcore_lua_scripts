#include "ScriptMgr.h"
#include "AccountMgr.h"
#include "time.h"
#include <stdio.h>
#include <stdlib.h>
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

#define LESSMONEY "Not enough money!"


class seruc : public CreatureScript
{
public: seruc() : CreatureScript("seruc"){ }



		bool OnGossipHello(Player *pPlayer, Creature* _creature)
		{
			if (sConfigMgr->GetBoolDefault("Teleport.NPC", true)) {
				pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Raid: Fallen Hero", GOSSIP_SENDER_MAIN, 0, "", 0, false);
				pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Instance", GOSSIP_SENDER_MAIN, 13, "", 0, false);
				pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Teleport to PVP Areal", GOSSIP_SENDER_MAIN, 1, "", 0, false);
				pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Teleport to Isle of Freedom ", GOSSIP_SENDER_MAIN, 2, "", 0, false);
				pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Teleport to Klee ", GOSSIP_SENDER_MAIN, 3, "", 0, false);
				pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Worldbosses", GOSSIP_SENDER_MAIN, 15, "", 0, false);
				pPlayer->PlayerTalkClass->SendGossipMenu(907, _creature->GetGUID());
				return true;
			}
			
			else {
				_creature->SetPhaseMask(2, true);
				pPlayer->PlayerTalkClass->SendGossipMenu(907, _creature->GetGUID());
				return true;	
			}
		}


		bool OnGossipSelect(Player * pPlayer, Creature * pCreature, uint32 /*uiSender*/, uint32 uiAction)
		{
			switch (uiAction)
			{
				/*RAID*/
			case 0: {
				if (pPlayer->GetSession()->GetSecurity() == 3){
					pPlayer->TeleportTo(169, -393.26f, 2972.93f, 92.85f, 5.94f);
					return true;
				}

				else {
					std::ostringstream ss;
					pPlayer->GetGUID();
					pPlayer->Whisper("Wende dich bitte an die Entwickler wenn du mehr Informationen haben moechtest.", LANG_UNIVERSAL, pPlayer, true);
					ss << "|cff54b5ff|r " << ChatHandler(pPlayer->GetSession()).GetNameLink() << "|cff54b5ff hat sich in den gesperrten Raid geportet. Der Raid ist noch geschlossen. Wenn Ihr mehr Informationen erhalten wollt, wendet Euch bitte an den zustaendigen Entwickler|r |cff54b5ff!|r";
					sWorld->SendServerMessage(SERVER_MSG_STRING, ss.str().c_str());
					return true;
				}
				
				
				return true;
			}break;

			case 15:
			{
				

				pPlayer->PlayerTalkClass->ClearMenus();
				pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Tell me more about the Worldbosses!", GOSSIP_SENDER_MAIN, 17, "", 0, false);
				pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Boss: Orrig [5-10 Players] ", GOSSIP_SENDER_MAIN, 4, "", 0, false);
				pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Boss: Exitares Shadow [7-15 Players] Not recommended!", GOSSIP_SENDER_MAIN, 5, "", 0, false);
				pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Boss: Die gequaelte Seele [5-15 Players]", GOSSIP_SENDER_MAIN, 6, "", 0, false);
				pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Boss: Kayoula [25-40 Players]", GOSSIP_SENDER_MAIN, 7, "", 0, false);
				pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Boss: Therakin [10-15 Players] Rework!", GOSSIP_SENDER_MAIN, 8, "", 0, false);
				pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Boss: Arcturus [5-10 Players] ", GOSSIP_SENDER_MAIN, 9, "", 0, false);
				pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Boss: Moon [25-40 Players]", GOSSIP_SENDER_MAIN, 10, "", 0, false);
				pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Boss: Maltyriun [5-10 Players]", GOSSIP_SENDER_MAIN, 11, "", 0, false);
				pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Boss: LORDofDOOM [7-15 Players]", GOSSIP_SENDER_MAIN, 12, "", 0, false);
				pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Boss: Eonar [8-15 Players] Rework!", GOSSIP_SENDER_MAIN, 14, "", 0, false);
				pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Boss: Tolreos [8-15 Players] Rework!", GOSSIP_SENDER_MAIN, 16, "", 0, false);

				if (pPlayer->GetSession()->GetSecurity() >= 2){
					pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,7, "Boss: Anna [Testphase]", GOSSIP_SENDER_MAIN, 17, "", 0, false);
					pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,7, "Boss: Galadriel", GOSSIP_SENDER_MAIN, 18, "", 0, false);
				}

				pPlayer->PlayerTalkClass->SendGossipMenu(907, pCreature->GetGUID());
				return true;
			}
				/*PVP*/
			case 1: {
				if (pPlayer->HasEnoughMoney(200000)){
					pPlayer->GetGUID();
					pPlayer->TeleportTo(0, -793.67f, 1565.25f, 19.88f, 3.25f);
					pPlayer->ModifyMoney(-200000);
					return true;
				}
				else {
					pPlayer->GetGUID();
					ChatHandler(pPlayer->GetSession()).PSendSysMessage(LESSMONEY, pPlayer->GetName());
					pPlayer->PlayerTalkClass->SendCloseGossip();
					return true;
				}
					
			}break;
				
				
				/*INSEL*/
				case 2: {
					if (pPlayer->HasEnoughMoney(200000)){
						pPlayer->GetGUID();
						pPlayer->TeleportTo(0, -9773.00f, 2126.72f, 15.40f, 3.88f);
						pPlayer->ModifyMoney(-200000);
						return true;
					}

					else {
						pPlayer->GetGUID();
						ChatHandler(pPlayer->GetSession()).PSendSysMessage(LESSMONEY, pPlayer->GetName());
						pPlayer->PlayerTalkClass->SendCloseGossip();
						return true;
					}
				}break;

			    
						/*YASIO*/
				case 3: {
					if (pPlayer->HasEnoughMoney(200000)){
						pPlayer->GetGUID();
						pPlayer->TeleportTo(571, 5728.79f, 608.62f, 618.59f, 5.60f);
						pPlayer->ModifyMoney(-200000);
						return true;
					}

					else {
						pPlayer->GetGUID();
						ChatHandler(pPlayer->GetSession()).PSendSysMessage(LESSMONEY, pPlayer->GetName());
						pPlayer->PlayerTalkClass->SendCloseGossip();
						return true;
					}
				}break;




						/*ORRIG*/
				case 4: {
					if (pPlayer->HasEnoughMoney(200000)){
						pPlayer->GetGUID();
						pPlayer->TeleportTo(169, -2902.55f, -1259.97f, 121.88f, 3.28f);
						pPlayer->ModifyMoney(-200000);
						return true;
					}

					else {
						pPlayer->GetGUID();
						ChatHandler(pPlayer->GetSession()).PSendSysMessage(LESSMONEY, pPlayer->GetName());
						pPlayer->PlayerTalkClass->SendCloseGossip();
						return true;
					}

				}break;




						/*EXI*/
				case 5: {
					if (pPlayer->HasEnoughMoney(200000)){
						pPlayer->GetGUID();
						pPlayer->TeleportTo(169, -480.42f, 3326.65f, 286.07f, 4.69f);
						pPlayer->ModifyMoney(-200000);
						return true;
					}

					else {
						pPlayer->GetGUID();
						ChatHandler(pPlayer->GetSession()).PSendSysMessage(LESSMONEY, pPlayer->GetName());
						pPlayer->PlayerTalkClass->SendCloseGossip();
						return true;
					}
				}break;





						/*GEQUÄLTE*/
				case 6: {
					if (pPlayer->HasEnoughMoney(200000)){
						pPlayer->GetGUID();
						pPlayer->TeleportTo(169, -250.27f, 3081.07f, 96.45f, 3.10f);
						pPlayer->ModifyMoney(-200000);
						return true;
					}

					else {
						pPlayer->GetGUID();
						ChatHandler(pPlayer->GetSession()).PSendSysMessage(LESSMONEY, pPlayer->GetName());
						pPlayer->PlayerTalkClass->SendCloseGossip();
						return true;
					}
				}break;


						/*KAYOULA*/
				case 7: {
					if (pPlayer->HasEnoughMoney(200000)){
						pPlayer->GetGUID();
						pPlayer->TeleportTo(169, -1221.52f, -2432.34f, 112.95f, 1.00f);
						pPlayer->ModifyMoney(-200000);
						return true;
					}

					else {
						pPlayer->GetGUID();
						ChatHandler(pPlayer->GetSession()).PSendSysMessage(LESSMONEY, pPlayer->GetName());
						pPlayer->PlayerTalkClass->SendCloseGossip();
						return true;
					}
				}break;



						/*Theriakin*/
				case 8: {
					if (pPlayer->HasEnoughMoney(200000)){
						pPlayer->GetGUID();
						pPlayer->TeleportTo(169, 3617.89f, 4050.67f, 92.00f, 3.50f);
						pPlayer->ModifyMoney(-200000);
						return true;
					}

					else {
						pPlayer->GetGUID();
						ChatHandler(pPlayer->GetSession()).PSendSysMessage(LESSMONEY, pPlayer->GetName());
						pPlayer->PlayerTalkClass->SendCloseGossip();
						return true;
					}
				}break;



						/*ARC*/
				case 9: {
					if (pPlayer->HasEnoughMoney(200000)){
						pPlayer->GetGUID();
						pPlayer->TeleportTo(169, -1743.87f, -854.50f, 121.70f, 2.06f);
						pPlayer->ModifyMoney(-200000);
						return true;
					}

					else {
						pPlayer->GetGUID();
						ChatHandler(pPlayer->GetSession()).PSendSysMessage(LESSMONEY, pPlayer->GetName());
						pPlayer->PlayerTalkClass->SendCloseGossip();
						return true;
					}
				}break;



						/*MOON*/
				case 10: {
					if (pPlayer->HasEnoughMoney(200000)){
						pPlayer->GetGUID();
						pPlayer->TeleportTo(169, -2872.38f, -1386.17f, 118.51f, 2.60f);
						pPlayer->ModifyMoney(-200000);
						return true;
					}

					else {
						pPlayer->GetGUID();
						ChatHandler(pPlayer->GetSession()).PSendSysMessage(LESSMONEY, pPlayer->GetName());
						pPlayer->PlayerTalkClass->SendCloseGossip();
						return true;
					}
				}break;


						 /*MALTYRIUN*/
				case 11: {
					if (pPlayer->HasEnoughMoney(200000)){
						pPlayer->GetGUID();
						pPlayer->TeleportTo(169, -4385.68f, -754.82f, 120.89f, 0.63f);
						return true;
					}

					else {
						pPlayer->GetGUID();
						ChatHandler(pPlayer->GetSession()).PSendSysMessage(LESSMONEY, pPlayer->GetName());
						pPlayer->PlayerTalkClass->SendCloseGossip();
						return true;
					}
				}break;




						 /*LORDOFDOOM*/
				case 12: {
					if (pPlayer->HasEnoughMoney(200000)){
						pPlayer->GetGUID();
						pPlayer->TeleportTo(169, -2710.73f, -2722.46f, 127.87f, 0.42f);
						pPlayer->ModifyMoney(-200000);
						return true;
					}

					else {
						pPlayer->GetGUID();
						ChatHandler(pPlayer->GetSession()).PSendSysMessage(LESSMONEY, pPlayer->GetName());
						pPlayer->PlayerTalkClass->SendCloseGossip();
						return true;
					}
				}break;

					/*INSTANZ*/
				case 13: {
					if (pPlayer->GetSession()->GetSecurity() == 3){
						pPlayer->TeleportTo(169, -393.26f, 2972.93f, 92.85f, 5.94f);
						return true;
					}
					else {
						std::ostringstream ss;
						pPlayer->GetGUID();
						ss << "|cff54b5ff|r " << ChatHandler(pPlayer->GetSession()).GetNameLink() << "|cff54b5ff hat sich in die gesperrte Instanz geportet. Diese ist noch geschlossen. Wenn ihr mehr Informationen erhalten wollt, wendet Euch bitte an den zustaendigen Entwickler|r |cff54b5ff!|r";
						sWorld->SendServerMessage(SERVER_MSG_STRING, ss.str().c_str());
						return true;
					}
					return true;
				}break;

					/*Tyranium*/
				case 14: {
					if (pPlayer->HasEnoughMoney(200000)){
					pPlayer->GetGUID();
					pPlayer->TeleportTo(169, -4367.24f, -1477.58f, 92.00f, 0.21f);
					pPlayer->ModifyMoney(-200000);
					return true;
					}

					else {
						pPlayer->GetGUID();
						ChatHandler(pPlayer->GetSession()).PSendSysMessage(LESSMONEY, pPlayer->GetName());
						pPlayer->PlayerTalkClass->SendCloseGossip();
						return true;
					}
				}break;

					/*Tolreos*/
				case 16: {
					if (pPlayer->HasEnoughMoney(200000)){
						pPlayer->GetGUID();
						pPlayer->TeleportTo(169, -3655.76f, -1052.01f, 126.75f, 3.38f);
						pPlayer->ModifyMoney(-200000);
						return true;
					}

					else {
						pPlayer->GetGUID();
						ChatHandler(pPlayer->GetSession()).PSendSysMessage(LESSMONEY, pPlayer->GetName());
						pPlayer->PlayerTalkClass->SendCloseGossip();
						return true;
					}
				}break;

				case 17: {
					pPlayer->GetGUID();
					ChatHandler(pPlayer->GetSession()).PSendSysMessage("Die MMO-Bosse sind dafuer gemacht worden, eine neue Herausforderung zu sein. Es wird Loot verteilt, der entsprechend dem Aufwand verteilt wird. Jeder Boss hat mehrere Loottables die per Zufall ausgewaehlt werden. Die Bosse sind nicht dazu da, etwaige Instanzen oder Raids zu ersetzen.", pPlayer->GetName());
					pPlayer->PlayerTalkClass->SendCloseGossip();
					return true;
				}break;

			}
			return true;
		}

};



void AddSC_seruc()
{
	new seruc();
}