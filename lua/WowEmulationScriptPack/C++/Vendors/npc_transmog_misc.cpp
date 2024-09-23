#include "ScriptPCH.h"

enum arenarating 
{
        arenarating		= 0,
		arenarating1	= 1500,
		arenarating2	= 1850,
		arenarating3	= 2250,
		arenarating4	= 2250
};


class multi_transmog_misc : public CreatureScript
{
	public:
		multi_transmog_misc() : CreatureScript("multi_transmog_misc")
		{
		}

		bool OnGossipHello(Player * pPlayer, Creature * pCreature)
		{
			Creature * npc_next = pPlayer->FindNearestCreature(600010, 30.0f, true);
			
			pPlayer->ADD_GOSSIP_ITEM(4, "|cff00ff00|TInterface\\icons\\ACHIEVEMENT_ARENA_2V2_1:24|t|r FREE - Season 1", GOSSIP_SENDER_MAIN, 0);
			pPlayer->ADD_GOSSIP_ITEM(4, "|cff00ff00|TInterface\\icons\\Achievement_Arena_3v3_4:24|t|r 1500 - Season 2", GOSSIP_SENDER_MAIN, 1);
			pPlayer->ADD_GOSSIP_ITEM(4, "|cff00ff00|TInterface\\icons\\Achievement_Arena_5v5_6:24|t|r 1850 - Season 3", GOSSIP_SENDER_MAIN, 2);
			pPlayer->ADD_GOSSIP_ITEM(4, "|cff00ff00|TInterface\\icons\\Achievement_Arena_5v5_7:24|t|r 2250 - Season 4", GOSSIP_SENDER_MAIN, 3);
			pPlayer->ADD_GOSSIP_ITEM(4, "|cff00ff00|TInterface\\icons\\Achievement_Level_60:24|t|r 2250 - Level 60 Rare Set", GOSSIP_SENDER_MAIN, 4);
			pPlayer->ADD_GOSSIP_ITEM(4, "|cff00ff00|TInterface\\icons\\spell_magic_lesserinvisibilty:24|t|r Nevermind", GOSSIP_SENDER_MAIN, 5);
			pPlayer->PlayerTalkClass->SendGossipMenu(9425, pCreature->GetGUID());
			return true;
		}

		bool OnGossipSelect(Player * Player, Creature * Creature, uint32 /*uiSender*/, uint32 uiAction)
		{
			if(!Player)
				return true;
			
			WorldSession * m_session = Player->GetSession();
			
			switch(uiAction)
			{
				case 0:
					if (Player->GetArenaPersonalRating(ARENA_TYPE_2v2) >= arenarating)
					{
						Player->vendorLoader = 1500080;
						m_session->SendListCustomInventory(Creature->GetGUID(),1500080);
						Player->PlayerTalkClass->SendCloseGossip();
					}else
					{
						ChatHandler(Player->GetSession()).PSendSysMessage("|cffff6060[Information]:|r You need atleast |cFFFF4500%u|rrating in personalarenateam to buy this item! Personal", arenarating);
						Player->CLOSE_GOSSIP_MENU();
                        return false;
					}break;

				case 1:
					if (Player->GetArenaPersonalRating(ARENA_TYPE_2v2) >= arenarating1)
					{
						Player->vendorLoader = 1500081;
						m_session->SendListCustomInventory(Creature->GetGUID(),1500081);
						Player->PlayerTalkClass->SendCloseGossip();
					}else
					{
						ChatHandler(Player->GetSession()).PSendSysMessage("|cffff6060[Information]:|r You need atleast |cFFFF4500%u|r 2v2 or 3v3 rating to buy this item!", arenarating1);
						Player->CLOSE_GOSSIP_MENU();
                        return false;
					}break;

				case 2:
					if (Player->GetArenaPersonalRating(ARENA_TYPE_2v2) >= arenarating2)
					{
						Player->vendorLoader = 1500082;
						m_session->SendListCustomInventory(Creature->GetGUID(),1500082);
						Player->PlayerTalkClass->SendCloseGossip();
						}else
					{
						ChatHandler(Player->GetSession()).PSendSysMessage("|cffff6060[Information]:|r You need atleast |cFFFF4500%u|r 2v2 or 3v3 rating to buy this item!", arenarating2);
						Player->CLOSE_GOSSIP_MENU();
                        return false;
					}break;
				case 3:
					if (Player->GetArenaPersonalRating(ARENA_TYPE_2v2) >= arenarating3)
					{
						Player->vendorLoader = 1500083;
						m_session->SendListCustomInventory(Creature->GetGUID(),1500083);
						Player->PlayerTalkClass->SendCloseGossip();
						}else
					{
						ChatHandler(Player->GetSession()).PSendSysMessage("|cffff6060[Information]:|r You need atleast |cFFFF4500%u|r 2v2 or 3v3 rating to buy this item!", arenarating3);
						Player->CLOSE_GOSSIP_MENU();
                        return false;
					}break;
				case 4:
					if (Player->GetArenaPersonalRating(ARENA_TYPE_2v2) >= arenarating4)
					{
						Player->vendorLoader = 1500084;
						m_session->SendListCustomInventory(Creature->GetGUID(),1500084);
						Player->PlayerTalkClass->SendCloseGossip();
						}else
					{
						ChatHandler(Player->GetSession()).PSendSysMessage("|cffff6060[Information]:|r You need atleast |cFFFF4500%u|r 2v2 or 3v3 rating to buy this item!", arenarating4);
						Player->CLOSE_GOSSIP_MENU();
                        return false;
					}break;
				case 5:
					{
						Player->PlayerTalkClass->SendCloseGossip();
					}break;
			}
			return true;
		}

};

void AddSC_multi_transmog_misc()
{
	new multi_transmog_misc();
}