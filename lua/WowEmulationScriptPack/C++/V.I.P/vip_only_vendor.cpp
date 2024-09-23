#include "ScriptPCH.h"

    class VIP_NPC : public CreatureScript 
    {
            public:
            VIP_NPC() : CreatureScript("VIP_NPC") { }
     
            bool OnGossipHello(Player * me, Creature * pCreature)
            {
									   if (me->GetSession()->GetSecurity() >= 1)
                    {
										me->ADD_GOSSIP_ITEM(6, "VIP VENDOR", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_VENDOR);
                                        }
                                        else
                                        { 
										me->ADD_GOSSIP_ITEM(6, "Bye", GOSSIP_SENDER_MAIN,1);
										}
                    me->PlayerTalkClass->SendGossipMenu(9452, pCreature->GetGUID());
                    return true;
                                    }
           
            bool OnGossipSelect(Player *player, Creature * m_creature, uint32 sender, uint32 action)
    {
                player->PlayerTalkClass->ClearMenus();
                                switch (action)
                                {
                                case GOSSIP_OPTION_VENDOR:
                player->GetSession()->SendListInventory(m_creature->GetGUID());
                                break;
                                case 1:
                                m_creature->MonsterWhisper("Why are you here?  You are not a VIP! - You have been reported to a GM!", player -> GetGUID());
								player->TeleportTo(571, 6182.615234f, 5738.993652f, 1.402846f, 5.567000f); // Where you get teleported.
                                player->CLOSE_GOSSIP_MENU();
                                break;
                        }
        return true;
    }
};
 
void AddSC_VIP_NPC()
{
    new VIP_NPC();
}