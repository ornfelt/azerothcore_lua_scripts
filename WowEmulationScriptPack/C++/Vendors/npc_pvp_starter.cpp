#include "ScriptPCH.h"

class multi_pvp_starter : public CreatureScript
{
	public:
		multi_pvp_starter() : CreatureScript("multi_pvp_starter")
		{
		}

		bool OnGossipHello(Player * pPlayer, Creature * pCreature)
		{
			Creature * npc_next = pPlayer->FindNearestCreature(600010, 30.0f, true);
			
			pPlayer->ADD_GOSSIP_ITEM(4, "|cff00ff00|TInterface\\ICONS\\INV_HELMET_98:24|t|r Season 7 Mainset", GOSSIP_SENDER_MAIN, 0);
			pPlayer->ADD_GOSSIP_ITEM(4, "|cff00ff00|TInterface\\icons\\INV_Misc_Desecrated_ClothBoots:24|t|r Season 7 Offset", GOSSIP_SENDER_MAIN, 1);
			pPlayer->ADD_GOSSIP_ITEM(4, "|cff00ff00|TInterface\\icons\\INV_Jewelry_Amulet_05:24|t|r Season 7 Accessories", GOSSIP_SENDER_MAIN, 2);
			pPlayer->ADD_GOSSIP_ITEM(4, "|cff00ff00|TInterface\\icons\\INV_Weapon_Shortblade_51:24|t|r Season 7 Weapons", GOSSIP_SENDER_MAIN, 3);
			pPlayer->ADD_GOSSIP_ITEM(4, "|cff00ff00|TInterface\\icons\\spell_magic_lesserinvisibilty:24|t|r Nevermind", GOSSIP_SENDER_MAIN, 4);
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
				case 0: // Sets 
					{
						Player->vendorLoader = 2500031;
						m_session->SendListCustomInventory(Creature->GetGUID(),2500031);
						Player->PlayerTalkClass->SendCloseGossip();
					}break;
				case 1: // Offset
					{

						Player->vendorLoader = 2500057;
						m_session->SendListCustomInventory(Creature->GetGUID(),2500057);
						Player->PlayerTalkClass->SendCloseGossip();
					}break;
				case 2: // Accessories
					{
						Player->vendorLoader = 2500033;
						m_session->SendListCustomInventory(Creature->GetGUID(),2500033);
						Player->PlayerTalkClass->SendCloseGossip();
					}break;
				case 3: // Weapons
					{
						Player->vendorLoader = 2500032;
						m_session->SendListCustomInventory(Creature->GetGUID(),2500032);
						Player->PlayerTalkClass->SendCloseGossip();
					}break;
				case 4: // Nevermind
					{
						Player->PlayerTalkClass->SendCloseGossip();
					}break;
			}
			return true;
		}

};

void AddSC_multi_pvp_starter()
{
	new multi_pvp_starter();
}