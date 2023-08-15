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
#include "ScriptedCreature.h"
#include "Player.h"



class supportnpc : public CreatureScript
{
public:
		supportnpc() : CreatureScript("supportnpc") { }
		
	

		void erklaerung(Player* player, std::string hilfe){
        
			ChatHandler(player->GetSession()).PSendSysMessage(hilfe.c_str(), player->GetName());
			player->PlayerTalkClass->SendCloseGossip();
			std::ostringstream ss;
			ss << hilfe;
			player->GetSession()->SendAreaTriggerMessage("%s", ss.str().c_str());
			return;
        
		}
    
    
		bool OnGossipHello(Player* player, Creature* creature)
        {
			if (creature->IsQuestGiver())
				player->PrepareQuestMenu(creature->GetGUID());

			if (sConfigMgr->GetBoolDefault("Support.NPC", true)) {
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_CHAT, "Help for new Players!", GOSSIP_SENDER_MAIN, 100, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_CHAT, "Questhelper", GOSSIP_SENDER_MAIN, 101, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_CHAT, "Character Tools", GOSSIP_SENDER_MAIN, 102, "", 0, false);
				player->PlayerTalkClass->SendGossipMenu(1, creature->GetGUID());
				return true;
			}
		
			else {
				creature->SetPhaseMask(2, true);
				player->PlayerTalkClass->SendGossipMenu(1, creature->GetGUID());
				return true;
			}

		
        }
	
		bool OnGossipSelect(Player * player, Creature * creature, uint32 /*uiSender*/, uint32 uiAction)
		{
			switch (uiAction)
			{
				case 0:
				{
					
					player->GetGUID();
					ChatHandler(player->GetSession()).PSendSysMessage("Ja, es gibt eine Erstaustattung. In jedem Startgebiet steht der entsprechende NPC. Es darf und kann nur der erste Charakter ausgestattet werden.", player->GetName());
					player->PlayerTalkClass->SendCloseGossip();
					player->GetSession()->SendAreaTriggerMessage("Ja in den Startgebieten. Naehere Informationen auf der HP oder im Chatfenster.");
					return true;
                }break;

				case 1:
				{
					player->GetGUID();
					ChatHandler(player->GetSession()).PSendSysMessage("Einen GM erreicht ihr ueber das Ticketsystem. Jedoch koennt ihr auch den MMOwning Launcher benutzen, sowie eine PN an einen GM auf der Homepage schreiben.", player->GetName());
					player->PlayerTalkClass->SendCloseGossip();
					player->GetSession()->SendAreaTriggerMessage("Per Ticket, auf der Homepage, ueber den Launcher, oder ueber ein PN");
					return true;
                }break;

				case 2:
				{
					player->GetGUID();
					ChatHandler(player->GetSession()).PSendSysMessage("Das ist uns bekannt. Der Questcompleter verschickt nicht immer alle Questitems. Ist die Quest normal abschliessbar wird es hier keine Erstattung geben. Ein Zuruecktreten vom Completen kann auch nicht erfolgen. Weitere Informationen gibt es auf der Homepage.", player->GetName());
					player->PlayerTalkClass->SendCloseGossip();
					player->GetSession()->SendAreaTriggerMessage("Das ist bekannt und wird nicht erstattet. Genauere Informationen auf der Homepage.");
					return true;
                }break;

				case 3:
				{
                    erklaerung(player->GetSession()->GetPlayer(), "Melde dich Quest über den Befehl .report [quest]. Druecke Shift + Links auf die Quest um sie einzufuegen. Bei ausreichend Meldungen wird die Quest bei eingeben des Befehls automatisch abgeschlossen.");
					
                }break;

				case 4:
				{
					player->GetGUID();
					ChatHandler(player->GetSession()).PSendSysMessage("Crossfaction spielen ist auf MMOwning nicht moeglich. Wir haben uns bewusst dagegen entschieden. Da wir einen pvp-orientierten Server stellen ist Crossfaction nicht moeglich.", player->GetName());
					player->PlayerTalkClass->SendCloseGossip();
					player->GetSession()->SendAreaTriggerMessage("Crossfaction spielen ist auf MMOwning nicht moeglich. Wir haben uns bewusst dagegen entschieden.");
					return true;
                }break;

				case 5:
				{
					player->GetGUID();
					ChatHandler(player->GetSession()).PSendSysMessage("Oeffne dein Chatfenster und schreibe /join Horde bzw. /join Allianz um dem Fraktionschat beizutreten.", player->GetName());
					player->PlayerTalkClass->SendCloseGossip();
					player->GetSession()->SendAreaTriggerMessage("Oeffne dein Chatfenster und gib /join Horde bzw. /join Allianz ein.");
					return true;
                }break;

				case 6:
				{
					player->GetGUID();
					ChatHandler(player->GetSession()).PSendSysMessage("Die komplette Rampoquestreihe ist per Questcompleter abschliessbar. Bitte nutze diesen auch bevor du ein Ticket eroeffnest.", player->GetName());
					player->PlayerTalkClass->SendCloseGossip();
					player->GetSession()->SendAreaTriggerMessage("Die Rampoquestreihe ist komplett per Questcompleter abschliessbar.");
					return true;
                }break;
                    
                
                case 7:
                {
                    player->GetGUID();
                    ChatHandler(player->GetSession()).PSendSysMessage("Einen 1:1 Gildentransfer gibt es nicht. Eine Aufwertung fuer neue Gilden ab 25 Spieler mit 251er Gear ist jedoch moeglich.", player->GetName());
                    player->PlayerTalkClass->SendCloseGossip();
                    player->GetSession()->SendAreaTriggerMessage("Einen 1:1 Transfer gibt es nicht. Aber eine Aufwertung fuer Gilden. Naehere Informationen gibt es auf der Homepage.");
                    return true;
                }break;

                
                case 8:
                {
                    erklaerung(player->GetSession()->GetPlayer(),"Der Contentpatch startet ab Level 80 ueber einen Drop bei den Endbosse in allen Instanzen von Nordend oder ueber 2 Quests beim Wandervolk.");
                }break;
                    
                case 9:
                {
                    erklaerung(player->GetSession()->GetPlayer(), "Die speziellen Eventquests koennen nur bei den Eventquestgebern (-nehmern) abgegeben werden. Bitte gedulde dich daher, bis das Event wieder aktiv wird.");
				}break;
				
				case 10:
				{
					player->TeleportTo(0,-12832.98f,-1374.24f,113.46f,3.97f);
					player->SaveRecallPosition();
					player->SaveToDB();
                    return true;
				}break;
                    
                case 100:
                {
                    
                    
                    player->PlayerTalkClass->ClearMenus();
                     player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_CHAT, "Startcharacter? Does this exist?", GOSSIP_SENDER_MAIN, 0, "", 0, false);
                     player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_CHAT, "Possibility for Guild Transfer?", GOSSIP_SENDER_MAIN, 7, "", 0, false);
                     player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_CHAT, "How to contact a GM?", GOSSIP_SENDER_MAIN, 1, "", 0, false);
                     player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_CHAT, "There is a bug. How can i report this error?", GOSSIP_SENDER_MAIN, 3, "", 0, false);
                     player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_CHAT, "Crossfaction?", GOSSIP_SENDER_MAIN, 4, "", 0, false);
                     player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_CHAT, "How to write in Worldchat?", GOSSIP_SENDER_MAIN, 5, "", 0, false);

					 if (sConfigMgr->GetBoolDefault("Content.Patch", true)) {
						 player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_CHAT, "How to start the Contentpatch?", GOSSIP_SENDER_MAIN, 8, "", 0, false);
					 }
                    
                    
                    
                    player->PlayerTalkClass->SendGossipMenu(1, creature->GetGUID());
                    return true;

                }break;
                 
                //Questhilfen
                case 101:
                {
                    player->PlayerTalkClass->ClearMenus();
                     player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_CHAT, "Der Questcompleter hat mir nicht alle Items zugesendet. Was tun?", GOSSIP_SENDER_MAIN, 2, "", 0, false);
                     player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,GOSSIP_ICON_CHAT, "Die Rampoquestreihe funktioniert bei mir nicht.", GOSSIP_SENDER_MAIN, 6, "", 0, false);
                     player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,GOSSIP_ICON_CHAT, "Where can i complete Eventquests?", GOSSIP_SENDER_MAIN, 9, "", 0, false);
                    
                    player->PlayerTalkClass->SendGossipMenu(1, creature->GetGUID());
                    return true;
                }break;
                    
                // Charakterhilfen
                case 102:
                {
                    player->PlayerTalkClass->ClearMenus();
                    player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_CHAT, "Help for Character! Click me!", GOSSIP_SENDER_MAIN, 10, "", 0, false);
                    player->PlayerTalkClass->SendGossipMenu(1, creature->GetGUID());
                    return true;
                
                }break;
                    
                    
                return true;
			};
			return true;
		}


	
};


void AddSC_supportnpc()
{
	new supportnpc();
}
