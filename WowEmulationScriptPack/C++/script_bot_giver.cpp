#include "ScriptMgr.h"
#include "Cell.h"
#include "CellImpl.h"
#include "GameEventMgr.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "Unit.h"
#include "GameObject.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "InstanceScript.h"
#include "CombatAI.h"
#include "PassiveAI.h"
#include "Chat.h"
#include "DBCStructure.h"
#include "DBCStores.h"
#include "ObjectMgr.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include <cstring>
#include "Group.h"

//This function is called when the player opens the gossip menubool
class script_bot_giver : public CreatureScript
{
	public:

		script_bot_giver()
            : CreatureScript("script_bot_giver")
        {
        }

bool OnGossipSelect(Player *player, Creature *creature, uint32 sender, uint32 action)
		{
			switch(sender)
			{
				case 6002: SendCreatePlayerBotMenu(player, creature, action); break;
				case 6003: SendCreatePlayerBot(player, creature, action); break;
				case 6004: SendRemovePlayerBotMenu(player, creature, action); break;
				case 6005: SendRemovePlayerBot(player, creature, action); break;
			}
			return true;
		}

bool OnGossipHello(Player *player, Creature *creature)
		{
			WorldSession *session = player->GetSession();
			uint8 count = 0;

			for(PlayerBotMap::const_iterator itr = session->GetPlayerBotsBegin(); itr != session->GetPlayerBotsEnd(); ++itr)
			{
				if(count == 0)
					player->ADD_GOSSIP_ITEM(0, "Abandon Your Player?", 6004, GOSSIP_ACTION_INFO_DEF + 100);

				++count;
			}

			if(count < player->GetMaxPlayerBot()) player->ADD_GOSSIP_ITEM(0, "Recruit a Player", 6002, GOSSIP_ACTION_INFO_DEF + 1);

			player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
			return true;
		}

void SendCreatePlayerBot(Player *player, Creature *creature, uint32 action)
		{
			std::list<std::string> *names;
			names = player->GetCharacterList();
			if(names == NULL || names->empty())
			{
				player->CLOSE_GOSSIP_MENU();
				return;
			}

			int8 x = action - GOSSIP_ACTION_INFO_DEF - 1;

			std::list<std::string>::iterator iter, next;
			for(iter = names->begin(); iter != names->end(); iter++)
			{
				if (x==0) player->CreatePlayerBot((*iter).c_str());
				else {
					if(x == 1)
					{
						player->CreatePlayerBot((*iter).c_str());
						break;
					}
					--x;
				}
			}

			player->CLOSE_GOSSIP_MENU();
		} //end SendCreatePlayerBot

void SendCreatePlayerBotMenu(Player *player, Creature *creature, uint32 action)
		{
			std::list<std::string> *names;
			names = player->GetCharacterList();
			if(names == NULL || names->empty())
			{
				player->CLOSE_GOSSIP_MENU();
				return;
			}

            player->PlayerTalkClass->ClearMenus();
			player->ADD_GOSSIP_ITEM(9, "ADD ALL" , 6003, GOSSIP_ACTION_INFO_DEF + 1);
			int8 x = 2;

			std::list<std::string>::iterator iter, next;
			for(iter = names->begin(); iter != names->end(); iter++)
			{
				//sLog->outError("character : %s", (*iter).c_str());
				player->ADD_GOSSIP_ITEM(9, (*iter).c_str() , 6003, GOSSIP_ACTION_INFO_DEF + x);
				++x;
			}
			player->SEND_GOSSIP_MENU(907, creature->GetGUID());
		} //end SendCreatePlayerBotMenu

void SendRemovePlayerBotAll(Player *player, Creature *creature) {
			for (int8 x = 2; x<=10; x++ )
			{
				SendRemovePlayerBot (player, creature, GOSSIP_ACTION_INFO_DEF + 2);
			}
		}

void SendRemovePlayerBot(Player *player, Creature *creature, uint32 action)
		{
			int8 x = action - GOSSIP_ACTION_INFO_DEF - 1;

			if (x == 0) {
				SendRemovePlayerBotAll(player, creature);
				return;
			}

			WorldSession *session = player->GetSession();
			for(PlayerBotMap::const_iterator itr = session->GetPlayerBotsBegin(); itr != session->GetPlayerBotsEnd(); ++itr)
			{
				if(x == 1 && itr->second && itr->second->GetGroup())
				{
					Player *m_bot = itr->second;
					Group *m_group = m_bot->GetGroup();

					//removing bot from group
					if(m_group->IsMember(m_bot->GetGUID()))
					{
						//deleting bot from group
						if(m_group->RemoveMember(m_bot->GetGUID(), GROUP_REMOVEMETHOD_DEFAULT) < 1) // 99 means I'm a bot
						{
							//no one left in group so deleting group
							//sObjectMgr.RemoveGroup(m_group);
						}
					}
					session->LogoutPlayerBot(m_bot->GetGUID(), true);
					break;
				}
				--x;
			}
			player->CLOSE_GOSSIP_MENU();
		} //end SendRemovePlayerBot

void SendRemovePlayerBotMenu(Player *player, Creature *creature, uint32 action)
		{
            player->PlayerTalkClass->ClearMenus();
			player->ADD_GOSSIP_ITEM(9, "REMOVE ALL", 6005, GOSSIP_ACTION_INFO_DEF + 1);

			uint8 x = 2;
			WorldSession *session = player->GetSession();
			for(PlayerBotMap::const_iterator itr = session->GetPlayerBotsBegin(); itr != session->GetPlayerBotsEnd(); ++itr)
			{
				Player *bot = itr->second;
				player->ADD_GOSSIP_ITEM(9, bot->GetName(), 6005, GOSSIP_ACTION_INFO_DEF + x);
				++x;
			}
			player->SEND_GOSSIP_MENU(907, creature->GetGUID());
		} //end SendRemovePlayerBotMenu
};

//This function is called when the player clicks an option on the gossip menu
void AddSC_script_bot_giver()
{
    new script_bot_giver();
}
