#include "ScriptPCH.h"

bool GossipHello_npc_spirit_of_competition(Player* player, Creature* creature)
{
    if (creature->isQuestGiver())
        player->PrepareQuestMenu(creature->GetGUID());

    player->PlayerTalkClass->SendGossipMenu(1, creature->GetGUID());
    return true;
}

void AddSC_npc_spirit_of_competition()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "npc_spirit_of_competition";
    newscript->pGossipHello = &GossipHello_npc_spirit_of_competition;
    newscript->RegisterSelf();
}
