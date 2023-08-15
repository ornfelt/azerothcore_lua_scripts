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




class gildenvendor : public CreatureScript
{
public: gildenvendor() : CreatureScript("gildenvendor"){ }


		void gildenhausfrei(Player* player, uint32 id){
			QueryResult result;
			result = CharacterDatabase.PQuery("SELECT guildid FROM `guildhouses` WHERE `id` = %u", id);
			Field *fields = result->Fetch();
			uint32 gilde = fields[0].GetUInt32();
			if (gilde == 0){
				Gildenhausport(id, player->GetSession()->GetPlayer());
				player->GetSession()->SendNotification("Du schaust dir nun das Gildenhaus an.");
				return;
			}
			else {
				player->GetSession()->SendNotification("Das Gildenhaus ist schon belegt und kann daher nicht besichtigt werden.");
				return;
			}

		}


		void Gildenhausverkauf(Player* player){
			uint32 platzhalter = 0;
			uint32 gilde = player->GetGuildId();

			QueryResult result;
			result = CharacterDatabase.PQuery("SELECT id FROM `guildhouses` WHERE `guildid` = '%u'", gilde);

			if (result){
				Field *fields = result->Fetch();
				uint32 gildenaktuell = fields[0].GetUInt32();

				if (gilde == 0){
					player->GetSession()->SendNotification("Du bist in keiner Gilde");
					return;
				}



				QueryResult ergebnis;
				ergebnis = CharacterDatabase.PQuery("Select leaderguid from `guild` where `guildid` = '%u'", player->GetGuildId());

				Field *feld = ergebnis->Fetch();
				uint32 leaderid = feld[0].GetUInt32();

				uint32 guid = player->GetGUID();

				if (guid == leaderid){
					CharacterDatabase.PExecute("UPDATE guildhouses SET guildid = '%u' WHERE id = '%u'", platzhalter, gildenaktuell);
					player->GetSession()->SendNotification("Das Gildenhaus wurde verkauft.");
					return;
				}
			}

			else {
				player->GetSession()->SendNotification("Deine Gilde besitzt kein Gildenhaus");
			}


		}

		void Gildenhausport(uint32 gildenhausid, Player* chr){

			if (chr->IsInFlight())
			{
				
				chr->GetSession()->SendNotification("Du fliegst");
				//SetSentErrorMessage(true);
				return;
			}

			if (chr->IsInCombat())
			{
				
				chr->GetSession()->SendNotification("Du bist im Kampf");
				
				//SetSentErrorMessage(true);
				return;
			}

			

			QueryResult result;
			result = CharacterDatabase.PQuery("SELECT `x`, `y`, `z`, `map` FROM `guildhouses` WHERE `id` = %u", gildenhausid);
			if (!result)
			{
				
				chr->GetSession()->SendNotification("Keine Gildeninformationen hinterlegt.");
				return;
			}


			float x, y, z;
			uint32 map;

			Field *fields = result->Fetch();
			x = fields[0].GetFloat();
			y = fields[1].GetFloat();
			z = fields[2].GetFloat();
			map = fields[3].GetUInt32();


			chr->SaveRecallPosition();
			chr->TeleportTo(map, x, y, z, 0);
			chr->SaveToDB();
			return;

		}

		void Gildenhauszuordnung(uint32 gildenidneu, uint32 hausid, uint32 groesse, uint32 kosten, Player* player){
			
			QueryResult result;
			result = CharacterDatabase.PQuery("SELECT guildid FROM `guildhouses` WHERE `id` = %u", hausid);
			Field *fields = result->Fetch();
			uint32 gildenidalt = fields[0].GetUInt32();


			QueryResult gildenanzahl = CharacterDatabase.PQuery("SELECT count(guid) FROM guild_member WHERE guildid = %u", gildenidneu);
			Field *felder = gildenanzahl->Fetch();
			uint32 memberanzahlsql = felder[0].GetUInt32();

			
			QueryResult ergebnis;
			ergebnis = CharacterDatabase.PQuery("Select count(guildid) from `guildhouses` where `guildid` = '%u'", gildenidneu);
			uint32 gildeplayer = player->GetGuildId();

			//uint32 memberanzahllimit = groesse;

			Field *feld = ergebnis->Fetch();
			uint32 anzahl = feld[0].GetUInt32();

		
			if (gildenidalt == 0 && anzahl == 0 && gildeplayer != 0 && memberanzahlsql >= groesse){

					if (player->HasItemCount(200000, kosten)){
						player->DestroyItemCount(200000, kosten, true, false);;
						CharacterDatabase.PExecute("UPDATE guildhouses SET `guildid` = '%u' WHERE `id` = '%u'", gildenidneu, hausid);
						player->GetSession()->SendNotification("Du hast das Gildenhaus gekauft.");
						return;
					}
					else{
						player->GetSession()->SendNotification("Du hast nicht genug Gildenhaustoken um dir dieses Gildenhaus zu kaufen.");
						return;
					}
				}
				
			if (memberanzahlsql < groesse){
				player->GetSession()->SendNotification("Deine Gilde ist zu klein.");
				return;
			}

			if (gildenidalt != 0){
				player->GetSession()->SendNotification("Das Gildenhaus ist schon belegt.");
				return;
			}

			if (anzahl != 0){
				player->GetSession()->SendNotification("Deine Gilde besitzt schon ein Gildenhaus.");
				return;
			}

			else {
				player->GetSession()->SendNotification("Error.");
				return;
			}
			

		}


		bool OnGossipHello(Player *player, Creature* creature)
		{
			if (creature->IsQuestGiver())
				player->PrepareQuestMenu(creature->GetGUID());

			if (sConfigMgr->GetBoolDefault("GuildHouse.Vendor", true)) {
				uint32 test = player->GetGuildId();
				if (test != 0) {
					QueryResult result;
					result = CharacterDatabase.PQuery("Select leaderguid from `guild` where `guildid` = '%u'", player->GetGuildId());

					Field *fields = result->Fetch();
					uint32 leaderid = fields[0].GetUInt32();

					uint32 guid = player->GetGUID();

					if (guid == leaderid) {

						player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Gildenhaus kaufen", GOSSIP_SENDER_MAIN, 0, "", 0, false);
						player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Gildenhaus verkaufen", GOSSIP_SENDER_MAIN, 1, "", 0, false);
						player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Gildenhaus ansehen", GOSSIP_SENDER_MAIN, 120, "", 0, false);
						player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
						return true;

					}

					else if (guid != leaderid) {
						player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Gildenhaus ansehen", GOSSIP_SENDER_MAIN, 120, "", 0, false);
						player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
						player->GetSession()->SendNotification("Du bist nicht der Leiter deiner Gilde, daher kannst du dir nur Gildenhaeuser ansehen.");
						return true;
					}

					else {
						return true;
					}
				}


				if (test == 0) {
					//player->PlayerTalkClass->GetGossipMenu().AddMenuItem(7, "Gildenhaus ansehen", GOSSIP_SENDER_MAIN, 120);
					player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
					player->GetSession()->SendNotification("Du bist in keiner Gilde,daher kannst du dir die Haeuser nur ansehen.");
					return true;
				}
			}

			else {
				creature->SetPhaseMask(2, true);
				player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
				return true;
			}
			
			return true;


		}

		std::ostringstream ss;

		bool OnGossipSelect(Player * player, Creature * creature, uint32 /*uiSender*/, uint32 uiAction)
		{
			switch (uiAction)
			{
			case 0:
			{
				player->PlayerTalkClass->ClearMenus();
				
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,7, "Tauren village at Veiled Sea (Silithus)" , GOSSIP_SENDER_MAIN, 2, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Fishing outside an Nortshire Abbey", GOSSIP_SENDER_MAIN, 3, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Troll Village in mountains", GOSSIP_SENDER_MAIN, 4, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Dwarven village outside Ironforge", GOSSIP_SENDER_MAIN, 5, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Dwarven village (Arathi Highlands, Forbidding Sea)", GOSSIP_SENDER_MAIN, 6, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Taruen Camp (Mulgore)", GOSSIP_SENDER_MAIN, 7, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Shadowfang Keep an outside instance ", GOSSIP_SENDER_MAIN, 8, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Harbor house outside Stormwind (Elwynn Forest)", GOSSIP_SENDER_MAIN, 9, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Empty jail between canals (Stormwind)", GOSSIP_SENDER_MAIN, 10, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Old Ironforge", GOSSIP_SENDER_MAIN, 11, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Ironforge Airport", GOSSIP_SENDER_MAIN, 12, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Azshara Crater instance (Alliance entrance)", GOSSIP_SENDER_MAIN, 13, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Azshara Crater instance (Horde entrance)", GOSSIP_SENDER_MAIN,14, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Quel'Thalas Tower", GOSSIP_SENDER_MAIN, 15, "", 0, false);
				
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "2. Seite", GOSSIP_SENDER_MAIN, 78, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "3. Seite ", GOSSIP_SENDER_MAIN, 79, "", 0, false);
				
				

				player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
				return true;

			}break;

			case 78:
			{
				player->PlayerTalkClass->ClearMenus();
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Crashed gnome airplane ", GOSSIP_SENDER_MAIN, 16, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Zul'Gurub an outside instance ", GOSSIP_SENDER_MAIN, 17, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Goblin village (Tanaris, South Seas)", GOSSIP_SENDER_MAIN, 18, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Villains camp outside an Stormwind ", GOSSIP_SENDER_MAIN, 19, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Stratholm an outside instance", GOSSIP_SENDER_MAIN, 20, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Kalimdor Hyjal", GOSSIP_SENDER_MAIN, 21, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "The Ring of Valor", GOSSIP_SENDER_MAIN, 22, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Stonetalon Logging Camp", GOSSIP_SENDER_MAIN, 23, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Stonetalon Ruins", GOSSIP_SENDER_MAIN, 24, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Teldrassil Furbold camp", GOSSIP_SENDER_MAIN, 25, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Wetlands mountain camp", GOSSIP_SENDER_MAIN, 26, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Ortell's Hideout", GOSSIP_SENDER_MAIN, 27, "", 0, false);
				
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "1. Seite", GOSSIP_SENDER_MAIN, 0, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "3. Seite ", GOSSIP_SENDER_MAIN, 79, "", 0, false);

				player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
				return true;
			}break;


			case 79:
			{

				player->PlayerTalkClass->ClearMenus();
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,7, "Stranglethorn Secret Cave", GOSSIP_SENDER_MAIN, 28,"",0,false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,7, "Karazhan Smiley", GOSSIP_SENDER_MAIN, 29,"", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,7, "Well of the Forgotten", GOSSIP_SENDER_MAIN, 30,"", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,7, "Undercity Top Tier", GOSSIP_SENDER_MAIN, 31,"", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Stormwind Cut-Throat Alley", GOSSIP_SENDER_MAIN, 32,"", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Forgotten gnome camp", GOSSIP_SENDER_MAIN, 33,"", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Outland Nagrand : Tomb", GOSSIP_SENDER_MAIN, 34,"", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Outland Nagrand: Challe's Home for Little Tykes", GOSSIP_SENDER_MAIN, 35, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Outland Netherstorm: Nova's Shrine", GOSSIP_SENDER_MAIN, 36, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Wald von Elwynn", GOSSIP_SENDER_MAIN, 37, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Troll Village in mountains 2 (Darkshore)", GOSSIP_SENDER_MAIN, 38, "", 0, false);

				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,7, "1. Seite", GOSSIP_SENDER_MAIN, 0, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,7, "2. Seite ", GOSSIP_SENDER_MAIN, 78, "", 0, false);

				player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
				return true;
			}break;

			case 120:
			{
				player->PlayerTalkClass->ClearMenus();

				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,7, "Tauren village at Veiled Sea (Silithus)", GOSSIP_SENDER_MAIN, 39,"", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,7, "Fishing outside an Nortshire Abbey", GOSSIP_SENDER_MAIN, 40, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,7, "Troll Village in mountains", GOSSIP_SENDER_MAIN, 41, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,7, "Dwarven village outside Ironforge", GOSSIP_SENDER_MAIN, 42, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,7, "Dwarven village (Arathi Highlands, Forbidding Sea)", GOSSIP_SENDER_MAIN, 81, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,7, "Taruen Camp (Mulgore)", GOSSIP_SENDER_MAIN, 43, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,7, "Shadowfang Keep an outside instance ", GOSSIP_SENDER_MAIN, 44, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,7, "Harbor house outside Stormwind (Elwynn Forest)", GOSSIP_SENDER_MAIN, 45, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,7, "Empty jail between canals (Stormwind)", GOSSIP_SENDER_MAIN, 46, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,7, "Old Ironforge", GOSSIP_SENDER_MAIN, 47, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,7, "Ironforge Airport", GOSSIP_SENDER_MAIN, 48, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,7, "Azshara Crater instance (Alliance entrance)", GOSSIP_SENDER_MAIN, 49, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,7, "2. Seite", GOSSIP_SENDER_MAIN, 75, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,7, "3. Seite", GOSSIP_SENDER_MAIN, 76, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,7, "4. Seite", GOSSIP_SENDER_MAIN, 77, "", 0, false);
				


				player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
				return true;

			}break;


			case 75:
			{

				player->PlayerTalkClass->ClearMenus();
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Azshara Crater instance (Horde entrance)", GOSSIP_SENDER_MAIN, 50, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Quel'Thalas Tower", GOSSIP_SENDER_MAIN, 51, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Crashed gnome airplane ", GOSSIP_SENDER_MAIN, 52, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Zul'Gurub an outside instance ", GOSSIP_SENDER_MAIN, 53, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Goblin village (Tanaris, South Seas)", GOSSIP_SENDER_MAIN, 54, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Villains camp outside an Stormwind ", GOSSIP_SENDER_MAIN, 55, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Stratholm an outside instance", GOSSIP_SENDER_MAIN, 56, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Kalimdor Hyjal", GOSSIP_SENDER_MAIN, 57, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "The Ring of Valor", GOSSIP_SENDER_MAIN, 58, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Stonetalon Logging Camp", GOSSIP_SENDER_MAIN, 59, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Stonetalon Ruins", GOSSIP_SENDER_MAIN, 60, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Teldrassil Furbold camp", GOSSIP_SENDER_MAIN, 61, "", 0, false);

				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "1. Seite", GOSSIP_SENDER_MAIN, 120, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "3. Seite", GOSSIP_SENDER_MAIN, 76, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "4. Seite", GOSSIP_SENDER_MAIN, 77, "", 0, false);

				player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
				return true;
			}break;


			case 76:
			{
				player->PlayerTalkClass->ClearMenus();
				
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Wetlands mountain camp", GOSSIP_SENDER_MAIN, 62, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Ortell's Hideout", GOSSIP_SENDER_MAIN, 63, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Stranglethorn Secret Cave", GOSSIP_SENDER_MAIN, 64, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Karazhan Smiley", GOSSIP_SENDER_MAIN, 65, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Well of the Forgotten", GOSSIP_SENDER_MAIN, 66, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Undercity Top Tier", GOSSIP_SENDER_MAIN, 67, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Stormwind Cut-Throat Alley", GOSSIP_SENDER_MAIN, 68, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Forgotten gnome camp", GOSSIP_SENDER_MAIN, 69, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Outland Nagrand : Tomb", GOSSIP_SENDER_MAIN, 70, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Outland Nagrand: Challe's Home for Little Tykes", GOSSIP_SENDER_MAIN, 71, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Outland Netherstorm: Nova's Shrine", GOSSIP_SENDER_MAIN, 72, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Wald von Elwynn", GOSSIP_SENDER_MAIN, 73, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Troll Village in mountains 2 (Darkshore)", GOSSIP_SENDER_MAIN, 74, "", 0, false);

				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "1. Seite", GOSSIP_SENDER_MAIN, 120, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "2. Seite", GOSSIP_SENDER_MAIN, 75, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "4. Seite", GOSSIP_SENDER_MAIN, 77, "", 0, false);

				player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
				return true;
			}

			case 77:
			{

				player->PlayerTalkClass->ClearMenus();
				

				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "1. Seite", GOSSIP_SENDER_MAIN, 120, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "2. Seite", GOSSIP_SENDER_MAIN, 75, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "3. Seite", GOSSIP_SENDER_MAIN, 76, "", 0, false);

				player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
				return true;
			}break;
			


			case 39:
			{
				
				gildenhausfrei(player->GetSession()->GetPlayer() , 2);
				
			}break;

			case 40:
			{

				gildenhausfrei(player->GetSession()->GetPlayer(), 3);
				
			}break;

			case 41:
			{
				gildenhausfrei(player->GetSession()->GetPlayer(), 4);
				
				
			}break;

			case 42:
			{
				gildenhausfrei(player->GetSession()->GetPlayer(), 5);
				
			}break;

			case 43:
			{
				gildenhausfrei(player->GetSession()->GetPlayer(), 7);
			
			}break;

			case 44:
			{
				gildenhausfrei(player->GetSession()->GetPlayer(), 8);
				
			}break;

			case 45:
			{
				gildenhausfrei(player->GetSession()->GetPlayer(), 9);
				
			}break;

			case 46:
			{
				gildenhausfrei(player->GetSession()->GetPlayer(), 10);
				
			}break;

			case 47:
			{
				gildenhausfrei(player->GetSession()->GetPlayer(),11);
				
			}break;

			case 48:
			{
				gildenhausfrei(player->GetSession()->GetPlayer(),12);
				
			}break;

			case 49:
			{
				gildenhausfrei(player->GetSession()->GetPlayer(), 13);
				
			}break;

			case 50:
			{
				gildenhausfrei(player->GetSession()->GetPlayer(), 14);
				
			}break;

			case 51:
			{
				gildenhausfrei(player->GetSession()->GetPlayer(), 15);
				
			}break;

			case 52:
			{
				gildenhausfrei(player->GetSession()->GetPlayer(), 16);
				
			}break;

			case 53:
			{
				gildenhausfrei(player->GetSession()->GetPlayer(), 17);
				
			}break;

			case 54:
			{
				gildenhausfrei(player->GetSession()->GetPlayer(), 18);
				
			}break;

			case 55:
			{
				gildenhausfrei(player->GetSession()->GetPlayer(), 19);
			
			}break;

			case 56:
			{
				gildenhausfrei(player->GetSession()->GetPlayer(), 20);
				
			}break;

			case 57:
			{
				gildenhausfrei(player->GetSession()->GetPlayer(), 21);
				
			}break;

			case 58:
			{
				gildenhausfrei(player->GetSession()->GetPlayer(), 22);
			
			}break;

			case 59:
			{
				gildenhausfrei(player->GetSession()->GetPlayer(), 23);
				
			}break;

			case 60:
			{
				gildenhausfrei(player->GetSession()->GetPlayer(), 24);
				
			}break;

			case 61:
			{
				gildenhausfrei(player->GetSession()->GetPlayer(), 25);
				
			}break;

			case 62:
			{
				gildenhausfrei(player->GetSession()->GetPlayer(), 26);
				
			}break;

			case 63:
			{
				gildenhausfrei(player->GetSession()->GetPlayer(), 27);
				
			}break;

			case 64:
			{
				gildenhausfrei(player->GetSession()->GetPlayer(), 28);
				
			}break;

			case 65:
			{
				gildenhausfrei(player->GetSession()->GetPlayer(), 29);
				
			}break;

			case 66:
			{
				gildenhausfrei(player->GetSession()->GetPlayer(), 30);
				
			}break;

			case 67:
			{
				gildenhausfrei(player->GetSession()->GetPlayer(), 31);
				
			}break;

			case 68:
			{
				gildenhausfrei(player->GetSession()->GetPlayer(), 32);
				
			}break;

			case 69:
			{
				gildenhausfrei(player->GetSession()->GetPlayer(), 33);
				
			}break;

			case 70:
			{
				gildenhausfrei(player->GetSession()->GetPlayer(), 34);
				
			}break;

			case 71:
			{
				gildenhausfrei(player->GetSession()->GetPlayer(), 35);
				
			}break;

			case 72:
			{
				gildenhausfrei(player->GetSession()->GetPlayer(), 36);
				
			}break;
			
			case 73:
			{
				gildenhausfrei(player->GetSession()->GetPlayer(), 37);
				
			}break;

			case 74:
			{
				gildenhausfrei(player->GetSession()->GetPlayer(), 38);
				
			}break;

			case 80:
			{

				uint32 gildenid = player->GetGuildId();
				// 1: gildenID , 2: GildenhausID ,	3: Kosten ,   4: Playerarray
				Gildenhauszuordnung(gildenid, 6, 10, 30, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
			}break;


			case 81:
			{
				gildenhausfrei(player->GetSession()->GetPlayer(), 6);
								
			}break;



			case 1:
			{
				Gildenhausverkauf(player->GetSession()->GetPlayer());
			}break;


			//Tauren Village at Veiled Sea
			case 2:
			{
				uint32 gildenid = player->GetGuildId();
				Gildenhauszuordnung(gildenid, 2, 10 , 30,player->GetSession()->GetPlayer());	
				player->PlayerTalkClass->SendCloseGossip();
			}break;


			//Fishing outside an Nortshire Abbey
			case 3:
			{
				uint32 gildenid = player->GetGuildId();
				// 1: gildenID , 2: GildenhausID ,	3: Groesse , 4:Kosten  5: Playerarray
				Gildenhauszuordnung(gildenid, 3, 10 ,30, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
			}break;

			//Trollvillage in mountains
			case 4:
			{
				uint32 gildenid = player->GetGuildId();
				// 1: gildenID , 2: GildenhausID ,	3: Kosten ,   4: Playerarray
				Gildenhauszuordnung(gildenid, 4, 10 ,30, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
			}break;

			//Dwarven Village
			case 5:
			{
				uint32 gildenid = player->GetGuildId();
				// 1: gildenID , 2: GildenhausID ,	3: Kosten ,   4: Playerarray
				Gildenhauszuordnung(gildenid,5, 10 , 30, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
			}break;


			case 6:
			{
				uint32 gildenid = player->GetGuildId();
				// Dwarven village (Arathi Highlands, Forbidding Sea)
				Gildenhauszuordnung(gildenid, 6, 25, 40, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
			}break;

			case 7:
			{
				uint32 gildenid = player->GetGuildId();
				// Tauren camp (Mulgore, Red Rock)
				Gildenhauszuordnung(gildenid, 7, 10, 20, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
			}break;


			case 8:
			{
				uint32 gildenid = player->GetGuildId();
				// Shadowfang Keep an outside instance (Silverpine Forest)
				Gildenhauszuordnung(gildenid, 8, 10, 20, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
			}break;

			case 9:
			{
				uint32 gildenid = player->GetGuildId();
				// Harbor house outside Stormwind (Elwynn Forest) 
				Gildenhauszuordnung(gildenid, 9, 10, 20, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
			}break;

			case 10:
			{
				uint32 gildenid = player->GetGuildId();
				// Empty jail between canals (Stormwind)
				Gildenhauszuordnung(gildenid, 10, 25, 50, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();

			}break;


			case 11:
			{
				uint32 gildenid = player->GetGuildId();
				// Old Ironforge
				Gildenhauszuordnung(gildenid, 11, 25, 40, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
			}break;

			case 12:
			{
				uint32 gildenid = player->GetGuildId();
				// Ironforge Airport
				Gildenhauszuordnung(gildenid, 12, 50, 50, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
			}break;


			case 13:
			{
				uint32 gildenid = player->GetGuildId();
				// Azshara Crater instance (Alliance entrance)
				Gildenhauszuordnung(gildenid, 13, 50, 50, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
			}break;

			case 14:
			{
				uint32 gildenid = player->GetGuildId();
				// Azshara Crater instance (Horde entrance)
				Gildenhauszuordnung(gildenid, 14, 50, 50, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
			}break;

			case 15:
			{
				uint32 gildenid = player->GetGuildId();
				// QuelThalas Tower
				Gildenhauszuordnung(gildenid, 15, 25, 40, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
			}break;


			case 16:
			{
				uint32 gildenid = player->GetGuildId();
				// Crashed gnome airplane (between Dun Morogh and Searing Gorge)
				Gildenhauszuordnung(gildenid, 16, 25, 30, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
			}break;

			case 17:
			{
				uint32 gildenid = player->GetGuildId();
				// ZulGurub an outside instance (Stranglethorn Vale)
				Gildenhauszuordnung(gildenid, 17, 25, 40, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
			}break;

			case 18:
			{
				uint32 gildenid = player->GetGuildId();

				// Goblin village (Tanaris, South Seas)
				Gildenhauszuordnung(gildenid, 18, 50, 50, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
			}break;


			case 19:
			{
				uint32 gildenid = player->GetGuildId();
				// Villains camp outside an Stormwind (Elwynn Forest)
				Gildenhauszuordnung(gildenid, 19, 10, 20, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
			}break;

			case 20:
			{
				uint32 gildenid = player->GetGuildId();
				// Stratholm an outside instance
				Gildenhauszuordnung(gildenid, 20, 50, 50, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
			}break;

			case 21:
			{
				uint32 gildenid = player->GetGuildId();

				// Kalimdor Hyjal (Aka World Tree)
				Gildenhauszuordnung(gildenid, 21, 50, 50, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
			}break;


			case 22:
			{
				uint32 gildenid = player->GetGuildId();
				// The Ring of Valor (Aka. Orgrimmar Arena)
				Gildenhauszuordnung(gildenid, 22, 10, 30, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
			}break;


			case 23:
			{
				uint32 gildenid = player->GetGuildId();
				// Stonetalon Logging Camp
				Gildenhauszuordnung(gildenid, 23, 25, 40, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
			}break;

			
			case 24:
			{
				uint32 gildenid = player->GetGuildId();

				// Stonetalon Ruins
				Gildenhauszuordnung(gildenid, 24, 15, 25, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
			}break;


			case 25:
			{
				uint32 gildenid = player->GetGuildId();
				// Teldrassil Furbold camp
				Gildenhauszuordnung(gildenid, 25, 10, 20, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
			}break;


			case 26:
			{
				

				// Wetlands mountain camp -> würde ich nicht verwenden!!! (oder für eine 1-Mann Gilde *gg*)
				//Gildenhauszuordnung(gildenid, 26, 10, 20, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
			}break;

			case 27:
			{
				uint32 gildenid = player->GetGuildId();
				// Ortells Hideout
				Gildenhauszuordnung(gildenid, 27, 20, 40, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
			}break;

			case 28:
			{
				uint32 gildenid = player->GetGuildId();

				// Stranglethorn Secret Cave
				Gildenhauszuordnung(gildenid, 28, 20, 30, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
			}break;


			case 29:
			{
				
				// Karazhan Smiley -> würde ich nicht verwenden -> Man versperrt damit den mit Absicht verbauten Weg von Blizz!!!
				//Gildenhauszuordnung(gildenid, 29, 10, 30, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
				
			}break;


			case 30:
			{
				uint32 gildenid = player->GetGuildId();
				// Well of the Forgotten (Aka. Karazhan Crypt or Lower Karazhan)
				Gildenhauszuordnung(gildenid, 30, 25, 40, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
			}break;

			case 31:
			{
				
				// Undercity Top Tier -> bitte nicht verwenden, ich wüsste nicht wie man das sichern sollte + von außen sieht man rein!
				//Gildenhauszuordnung(gildenid, 31, 25, 40, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
			}break;

			case 32:
			{
				//uint32 gildenid = player->GetGuildId();
				// Stormwind Cut-Throat Alley -> direkt in SW...
				//Gildenhauszuordnung(gildenid, 32, 10, 30, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
			}break;

			case 33:
			{
				uint32 gildenid = player->GetGuildId();
				// Forgotten gnome camp
				Gildenhauszuordnung(gildenid, 33, 25, 40, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
			}break;

			case 34:
			{
				uint32 gildenid = player->GetGuildId();
				// Outland Nagrand : Tomb
				Gildenhauszuordnung(gildenid, 34, 10, 20, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
			}break;

			case 35:
			{
				
				// Outland Nagrand: Challes Home for Little Tykes -> NICHT verwenden, QUEST Gebiet!!!
				//Gildenhauszuordnung(gildenid, 35, 25, 40, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
			}break;

			case 36:
			{
				uint32 gildenid = player->GetGuildId();
				// Outland Netherstorm: Novas Shrine
				Gildenhauszuordnung(gildenid, 36, 10, 20, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
			}break;

			case 37:
			{
				uint32 gildenid = player->GetGuildId();
				// Wald von Elwynn
				Gildenhauszuordnung(gildenid, 37, 10, 20, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
			}break;

			case 38:
			{
			
				// Troll Village in mountains 2 (Darkshore) -> Ist schon oben verwendet! Troll Dorf!
				//Gildenhauszuordnung(gildenid, 38, 40, 50, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->SendCloseGossip();
			}break;

			}
            return true;
		}

};



void AddSC_gildenvendor()
{
	new gildenvendor();
}
