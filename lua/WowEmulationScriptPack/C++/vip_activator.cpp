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
class vip_activator : public CreatureScript
{
public:
    vip_activator() : CreatureScript("vip_activator") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        player->ADD_GOSSIP_ITEM(6, "Activate VIP", GOSSIP_SENDER_MAIN, 0);
		player->ADD_GOSSIP_ITEM(6, "I lost my VIP Key!", GOSSIP_SENDER_MAIN, 1);
		player->ADD_GOSSIP_ITEM(6, "I don`t have VIP spell!", GOSSIP_SENDER_MAIN, 2);
        player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player *player, Creature *creature, uint32 sender, uint32 uiAction)
    {
        if (sender == GOSSIP_SENDER_MAIN)
        {
            player->PlayerTalkClass->ClearMenus();
            rbac::RBACData* rbac = player->GetSession()->GetRBACData();
            switch (uiAction)
            {
                case 0:
                    if (player->HasItemCount(313370, 1, false))
                    {
                        player->CLOSE_GOSSIP_MENU();
                        player->DestroyItemCount(313370, 1, true, false);
						player->AddItem(438555, 1);
						player->LearnSpell(63988, false);
						player->LearnSpell(26035, false);
						player->LearnSpell(34756, false);
						sAccountMgr->UpdateAccountAccess(rbac, player->GetSession()->GetAccountId(), uint8(SEC_VIP), -1);
                        creature->Whisper("Congratulations, you now have VIP please relog!", LANG_UNIVERSAL, player);
                    }
                    else
                    {
                        player->CLOSE_GOSSIP_MENU();
                        creature->Whisper("You do not have the VIP Token.", LANG_UNIVERSAL, player);
                        return false;
                    }
                    break;
				case 1:
                    if (player->GetSession()->GetSecurity() >= 1)
                    {
                        player->CLOSE_GOSSIP_MENU();
						player->AddItem(438555, 1);
                        creature->Whisper("Now you have the VIP Key!", LANG_UNIVERSAL, player);
                    }
                    else
                    {
                        player->CLOSE_GOSSIP_MENU();
                        creature->Whisper("You are not VIP.", LANG_UNIVERSAL, player);
                        return false;
                    }
                    break;
					case 2:
                    if (player->GetSession()->GetSecurity() >= 1)
                    {
                        player->CLOSE_GOSSIP_MENU();
						player->LearnSpell(63988, false);
						player->LearnSpell(26035, false);
						player->LearnSpell(34756, false);
                        creature->Whisper("Now you have the VIP Spell!", LANG_UNIVERSAL, player);
                    }
                    else
                    {
                        player->CLOSE_GOSSIP_MENU();
                        creature->Whisper("You are not VIP.", LANG_UNIVERSAL, player);
                        return false;
                    }
                    break;
            }
        }
        return true;
    }
};
void AddSC_vip_activator()
{
    new vip_activator();
}