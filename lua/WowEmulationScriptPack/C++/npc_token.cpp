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

class npc_support : public CreatureScript
{
	public:
		npc_support() : CreatureScript("npc_support")
		{
		}

		bool OnGossipHello(Player * pPlayer, Creature * pCreature)
		{
		    pPlayer->ADD_GOSSIP_ITEM(4, "|TInterface/ICONS/INV_Misc_Coin_05:30|t Morphs", GOSSIP_SENDER_MAIN, 0);
			pPlayer->ADD_GOSSIP_ITEM(0, "Nevermind...", GOSSIP_SENDER_MAIN, 800);
			pPlayer->PlayerTalkClass->SendGossipMenu(9425, pCreature->GetGUID());
			return true;
		}

		bool OnGossipSelect(Player * pPlayer, Creature * pCreature, uint32 /*uiSender*/, uint32 uiAction)
		{
			if(!pPlayer)
				return true;
			
			switch(uiAction)
			{
			  {
                case 0:
                    pPlayer->PlayerTalkClass->ClearMenus();
                    pPlayer->ADD_GOSSIP_ITEM(8, "|TInterface/ICONS/Achievement_Arena_2v2_7:30|t Blood Elf Female ", GOSSIP_SENDER_MAIN, 4);
                    pPlayer->ADD_GOSSIP_ITEM(8, "|TInterface/ICONS/Achievement_Arena_2v2_7:30|t Blood Elf Male ", GOSSIP_SENDER_MAIN, 5);
                    pPlayer->ADD_GOSSIP_ITEM(8, "|TInterface/ICONS/Achievement_Arena_2v2_7:30|t Gnome Female ", GOSSIP_SENDER_MAIN, 6);
                    pPlayer->ADD_GOSSIP_ITEM(8, "|TInterface/ICONS/Achievement_Arena_2v2_7:30|t Gnome Male ", GOSSIP_SENDER_MAIN, 7);
                    pPlayer->ADD_GOSSIP_ITEM(8, "|TInterface/ICONS/Achievement_Arena_2v2_7:30|t Human Female ", GOSSIP_SENDER_MAIN, 8);
                    pPlayer->ADD_GOSSIP_ITEM(8, "|TInterface/ICONS/Achievement_Arena_2v2_7:30|t Human Male ", GOSSIP_SENDER_MAIN, 9);
                    pPlayer->ADD_GOSSIP_ITEM(8, "|TInterface/ICONS/Achievement_Arena_2v2_7:30|t Tauren Female ", GOSSIP_SENDER_MAIN, 10);
                    pPlayer->ADD_GOSSIP_ITEM(8, "|TInterface/ICONS/Achievement_Arena_2v2_7:30|t Tauren Male ", GOSSIP_SENDER_MAIN, 11);
                    pPlayer->ADD_GOSSIP_ITEM(8, "|TInterface/ICONS/Achievement_Arena_2v2_7:30|t Undead Pirate ", GOSSIP_SENDER_MAIN, 12);
                    pPlayer->ADD_GOSSIP_ITEM(8, "|TInterface/ICONS/Achievement_Arena_2v2_7:30|t Etherial ", GOSSIP_SENDER_MAIN, 13);
                    pPlayer->ADD_GOSSIP_ITEM(8, "|TInterface/ICONS/Achievement_Arena_2v2_7:30|t Mad Scientist ", GOSSIP_SENDER_MAIN, 14);
                    pPlayer->ADD_GOSSIP_ITEM(8, "|TInterface/ICONS/Achievement_Arena_2v2_7:30|t Tatooed Man ", GOSSIP_SENDER_MAIN, 15);
                    pPlayer->ADD_GOSSIP_ITEM(8, "|TInterface/ICONS/Achievement_Arena_2v2_7:30|t Necromancer ", GOSSIP_SENDER_MAIN, 16);
                    pPlayer->ADD_GOSSIP_ITEM(8, "|TInterface/ICONS/Achievement_Arena_2v2_7:30|t Skeletal Mage ", GOSSIP_SENDER_MAIN, 17);
                    pPlayer->ADD_GOSSIP_ITEM(8, "|TInterface/ICONS/Achievement_Arena_2v2_7:30|t Frost Troll ", GOSSIP_SENDER_MAIN, 18);
                    pPlayer->ADD_GOSSIP_ITEM(8, "|TInterface/ICONS/Achievement_Arena_2v2_7:30|t Blood Elf Demon Girl ", GOSSIP_SENDER_MAIN, 19);
                    pPlayer->ADD_GOSSIP_ITEM(8, "|TInterface/ICONS/Achievement_Arena_2v2_7:30|t Human 19 Twink ", GOSSIP_SENDER_MAIN, 20);
                    pPlayer->ADD_GOSSIP_ITEM(8, "|TInterface/ICONS/Achievement_Arena_2v2_7:30|t Undead 19 Twink ", GOSSIP_SENDER_MAIN, 21);
 
                    }
                    pPlayer->PlayerTalkClass->SendGossipMenu(9452, pCreature->GetGUID());          
                break;
                               


					case 4:
                        if (pPlayer->HasItemCount(29434, 1, true))
                        {
                            pPlayer->DestroyItemCount(29434, 1, true);
                            pPlayer->SetDisplayId(20370);
                            pPlayer->SetFloatValue(OBJECT_FIELD_SCALE_X, 1);
                            pPlayer->CLOSE_GOSSIP_MENU();
                            ChatHandler(pPlayer->GetSession()).PSendSysMessage("You have been Morphed into a Female Blood Elf.", pPlayer -> GetGUID());
                        }
                        else
                        {
                            pPlayer->CLOSE_GOSSIP_MENU();
                            ChatHandler(pPlayer->GetSession()).PSendSysMessage("You don't have the required amount of Morph Tokens.", pPlayer -> GetGUID());
                        }
                    break;
                               
                    case 5:
                        if (pPlayer->HasItemCount(29434, 1, true))
                        {
                            pPlayer->DestroyItemCount(29434, 1, true);
                            pPlayer->SetDisplayId(20369);
                            pPlayer->SetFloatValue(OBJECT_FIELD_SCALE_X, 1);
                            pPlayer->CLOSE_GOSSIP_MENU();
                            ChatHandler(pPlayer->GetSession()).PSendSysMessage("You have been Morphed into a Male Blood Elf.", pPlayer -> GetGUID());
                        }
                        else
                        {
                            pPlayer->CLOSE_GOSSIP_MENU();
                            ChatHandler(pPlayer->GetSession()).PSendSysMessage("You don't have the required amount of Morph Tokens.", pPlayer -> GetGUID());
                        }
                    break;
                               
                    case 6:
                        if (pPlayer->HasItemCount(29434, 1, true))
                        {
                            pPlayer->DestroyItemCount(29434, 1, true);
                            pPlayer->SetDisplayId(20320);
                            pPlayer->SetFloatValue(OBJECT_FIELD_SCALE_X, 1);
                            pPlayer->CLOSE_GOSSIP_MENU();
                            ChatHandler(pPlayer->GetSession()).PSendSysMessage("You have been Morphed into a Gnome Female.", pPlayer -> GetGUID());
                        }
                        else
                        {
                            pPlayer->CLOSE_GOSSIP_MENU();
                            ChatHandler(pPlayer->GetSession()).PSendSysMessage("You don't have the required amount of Morph Tokens.", pPlayer -> GetGUID());
                        }
                   break;
                               
                   case 7:
                       if (pPlayer->HasItemCount(29434, 1, true))
                       {
                           pPlayer->DestroyItemCount(29434, 1, true);
                           pPlayer->SetDisplayId(20580);
                           pPlayer->SetFloatValue(OBJECT_FIELD_SCALE_X, 1);
                           pPlayer->CLOSE_GOSSIP_MENU();
                           ChatHandler(pPlayer->GetSession()).PSendSysMessage("You have been Morphed into a Gnome Male.", pPlayer -> GetGUID());
                       }
                       else
                       {
                           pPlayer->CLOSE_GOSSIP_MENU();
                           ChatHandler(pPlayer->GetSession()).PSendSysMessage("You don't have the required amount of Morph Tokens.", pPlayer -> GetGUID());
                       }
                   break;
 
                   case 8:
                       if (pPlayer->HasItemCount(29434, 1, true))
                       { 
                           pPlayer->DestroyItemCount(29434, 1, true);
                           pPlayer->SetDisplayId(19724);
                           pPlayer->SetFloatValue(OBJECT_FIELD_SCALE_X, 1);
                           pPlayer->CLOSE_GOSSIP_MENU();
                           ChatHandler(pPlayer->GetSession()).PSendSysMessage("You have been Morphed into a Human Female.", pPlayer -> GetGUID());
                       }
                       else
                       { 
                           pPlayer->CLOSE_GOSSIP_MENU();
                           ChatHandler(pPlayer->GetSession()).PSendSysMessage("You don't have the required amount of Morph Tokens.", pPlayer -> GetGUID());
                       }
                   break;
                               
                   case 9:
                       if (pPlayer->HasItemCount(29434, 1, true))
                       {
                           pPlayer->DestroyItemCount(29434, 1, true);
                           pPlayer->SetDisplayId(19723);
                           pPlayer->SetFloatValue(OBJECT_FIELD_SCALE_X, 1);
                           pPlayer->CLOSE_GOSSIP_MENU();
                           ChatHandler(pPlayer->GetSession()).PSendSysMessage("You have been Morphed into a Human Male.", pPlayer -> GetGUID());
                       }
                       else
                       {
                           pPlayer->CLOSE_GOSSIP_MENU();
                           ChatHandler(pPlayer->GetSession()).PSendSysMessage("You don't have the required amount of Morph Tokens.", pPlayer -> GetGUID());
                       }
                   break;
                               
                   case 10:
                       if (pPlayer->HasItemCount(29434, 1, true))
                       {
                           pPlayer->DestroyItemCount(29434, 1, true);
                           pPlayer->SetDisplayId(20584);
                           pPlayer->SetFloatValue(OBJECT_FIELD_SCALE_X, 1);
                           pPlayer->CLOSE_GOSSIP_MENU();
                           ChatHandler(pPlayer->GetSession()).PSendSysMessage("You have been Morphed into a Tauren Female.", pPlayer -> GetGUID());
                       }
                       else
                       {
                           pPlayer->CLOSE_GOSSIP_MENU();
                           ChatHandler(pPlayer->GetSession()).PSendSysMessage("You don't have the required amount of Morph Tokens.", pPlayer -> GetGUID());
                       }
                   break;
                               
                   case 11:
                       if (pPlayer->HasItemCount(29434, 1, true))
                       {
                           pPlayer->DestroyItemCount(29434, 1, true);
                           pPlayer->SetDisplayId(20319);
                           pPlayer->SetFloatValue(OBJECT_FIELD_SCALE_X, 1);
                           pPlayer->CLOSE_GOSSIP_MENU();
                           ChatHandler(pPlayer->GetSession()).PSendSysMessage("You have been Morphed into a Tauren Male", pPlayer -> GetGUID());
                       }
                       else
                       {
                          pPlayer->CLOSE_GOSSIP_MENU();
                          ChatHandler(pPlayer->GetSession()).PSendSysMessage("You don't have the required amount of Morph Tokens.", pPlayer -> GetGUID());
                       }
                   break;
 
                   case 12:
                       if (pPlayer->HasItemCount(29434, 1, true))
                       {
                           pPlayer->DestroyItemCount(29434, 1, true);
                           pPlayer->SetDisplayId(25042);
                           pPlayer->SetFloatValue(OBJECT_FIELD_SCALE_X, 1);
                           pPlayer->CLOSE_GOSSIP_MENU();
                           ChatHandler(pPlayer->GetSession()).PSendSysMessage("You have been Morphed into a Undead Pirate", pPlayer -> GetGUID());
                       }
                       else
                       {
                           pPlayer->CLOSE_GOSSIP_MENU();
                           ChatHandler(pPlayer->GetSession()).PSendSysMessage("You don't have the required amount of Morph Tokens.", pPlayer -> GetGUID());
                       }
                   break;
                               
                   case 13:
                       if (pPlayer->HasItemCount(29434, 1, true))
                       {
                           pPlayer->DestroyItemCount(29434, 1, true);
                           pPlayer->SetDisplayId(24942);
                           pPlayer->SetFloatValue(OBJECT_FIELD_SCALE_X, 1);
                           pPlayer->CLOSE_GOSSIP_MENU();
                           ChatHandler(pPlayer->GetSession()).PSendSysMessage("You have been Morphed into a Etherial", pPlayer -> GetGUID());
                       }
                       else
                       {
                           pPlayer->CLOSE_GOSSIP_MENU();
                           ChatHandler(pPlayer->GetSession()).PSendSysMessage("You don't have the required amount of Morph Tokens.", pPlayer -> GetGUID());
                       }
                   break;
                               
                   case 14:
                       if (pPlayer->HasItemCount(29434, 1, true))
                       {
                           pPlayer->DestroyItemCount(29434, 1, true);
                           pPlayer->SetDisplayId(23875);
                           pPlayer->SetFloatValue(OBJECT_FIELD_SCALE_X, 1);
                           pPlayer->CLOSE_GOSSIP_MENU();
                           ChatHandler(pPlayer->GetSession()).PSendSysMessage("You have been Morphed into a Mad Scientist", pPlayer -> GetGUID());
                       }
                       else
                       {
                           pPlayer->CLOSE_GOSSIP_MENU();
                           ChatHandler(pPlayer->GetSession()).PSendSysMessage("You don't have the required amount of Morph Tokens.", pPlayer -> GetGUID());
                       }
                   break;
                               
                   case 15:
                       if (pPlayer->HasItemCount(29434, 1, true))
                       {
                           pPlayer->DestroyItemCount(29434, 1, true);
                           pPlayer->SetDisplayId(22634);
                           pPlayer->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.5);
                           pPlayer->CLOSE_GOSSIP_MENU();
                           ChatHandler(pPlayer->GetSession()).PSendSysMessage("You have been Morphed into a Tattooed Man", pPlayer -> GetGUID());
                       }
                       else
                       {
                           pPlayer->CLOSE_GOSSIP_MENU();
                           ChatHandler(pPlayer->GetSession()).PSendSysMessage("You don't have the required amount of Morph Tokens.", pPlayer -> GetGUID());
                       }
                   break;
 
                   case 16:
                       if (pPlayer->HasItemCount(29434, 1, true))
                       {
                           pPlayer->DestroyItemCount(29434, 1, true);
                           pPlayer->SetDisplayId(24793);
                           pPlayer->SetFloatValue(OBJECT_FIELD_SCALE_X, 1);
                           pPlayer->CLOSE_GOSSIP_MENU();
                           ChatHandler(pPlayer->GetSession()).PSendSysMessage("You have been Morphed into a Necromancer", pPlayer -> GetGUID());
                       }
                       else
                       {
                           pPlayer->CLOSE_GOSSIP_MENU();
                           ChatHandler(pPlayer->GetSession()).PSendSysMessage("You don't have the required amount of Morph Tokens.", pPlayer -> GetGUID());
                       }
                   break;
                               
                   case 17:
                       if (pPlayer->HasItemCount(29434, 1, true))
                       {
                           pPlayer->DestroyItemCount(29434, 1, true);
                           pPlayer->SetDisplayId(24495);
                           pPlayer->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.7f);
                           pPlayer->CLOSE_GOSSIP_MENU();
                           ChatHandler(pPlayer->GetSession()).PSendSysMessage("You have been Morphed into a Skeletal Mage", pPlayer -> GetGUID());
                       }
                       else
                       {
                           pPlayer->CLOSE_GOSSIP_MENU();
                           ChatHandler(pPlayer->GetSession()).PSendSysMessage("You don't have the required amount of Morph Tokens.", pPlayer -> GetGUID());
					   }
                   break;
                               
                   case 18:
                       if (pPlayer->HasItemCount(29434, 1, true))
                       {
                           pPlayer->DestroyItemCount(29434, 1, true);
                           pPlayer->SetDisplayId(24938);
                           pPlayer->SetFloatValue(OBJECT_FIELD_SCALE_X, 1);
                           pPlayer->CLOSE_GOSSIP_MENU();
                           ChatHandler(pPlayer->GetSession()).PSendSysMessage("You have been Morphed into a Frost Troll", pPlayer -> GetGUID());
                       }
                       else
                       {
                           pPlayer->CLOSE_GOSSIP_MENU();
                           ChatHandler(pPlayer->GetSession()).PSendSysMessage("You don't have the required amount of Morph Tokens.", pPlayer -> GetGUID());
                       }
                   break;
                               
                   case 19:
                       if (pPlayer->HasItemCount(29434, 1, true))
                       {
                           pPlayer->DestroyItemCount(29434, 1, true);
                           pPlayer->SetDisplayId(24930);
                           pPlayer->SetFloatValue(OBJECT_FIELD_SCALE_X, 1);
                           pPlayer->CLOSE_GOSSIP_MENU();
                           ChatHandler(pPlayer->GetSession()).PSendSysMessage("You have been Morphed into a BELF Demon Girl", pPlayer -> GetGUID());
                       }
                       else
                       {
                           pPlayer->CLOSE_GOSSIP_MENU();
                           ChatHandler(pPlayer->GetSession()).PSendSysMessage("You don't have the required amount of Morph Tokens.", pPlayer -> GetGUID());
                       }
                   break;
 
                   case 20:
                       if (pPlayer->HasItemCount(29434, 1, true))
                       {
                           pPlayer->DestroyItemCount(29434, 1, true);
                           pPlayer->SetDisplayId(29796);
                           pPlayer->SetFloatValue(OBJECT_FIELD_SCALE_X, 1);
                           pPlayer->CLOSE_GOSSIP_MENU();
                           ChatHandler(pPlayer->GetSession()).PSendSysMessage("You have been Morphed into a Human 19 Twink", pPlayer -> GetGUID());
                       }
                       else
                       {
                           pPlayer->CLOSE_GOSSIP_MENU();
                           ChatHandler(pPlayer->GetSession()).PSendSysMessage("You don't have the required amount of Morph Tokens.", pPlayer -> GetGUID());
                       }
                   break;
 
                   case 21:
                       if (pPlayer->HasItemCount(29434, 1, true))
                       {
                           pPlayer->DestroyItemCount(29434, 1, true);
                           pPlayer->SetDisplayId(29795);
                           pPlayer->SetFloatValue(OBJECT_FIELD_SCALE_X, 1);
                           pPlayer->CLOSE_GOSSIP_MENU();
                           ChatHandler(pPlayer->GetSession()).PSendSysMessage("You have been Morphed into a Undead 19 Twink", pPlayer -> GetGUID());
                       }
                       else
                       {
                           pPlayer->CLOSE_GOSSIP_MENU();
                           ChatHandler(pPlayer->GetSession()).PSendSysMessage("You don't have the required amount of Morph Tokens.", pPlayer -> GetGUID());
                       }
                   break;
 
 
			}
			return true;
		}

};

void AddSC_npc_supporter()
{
	new npc_support();
}