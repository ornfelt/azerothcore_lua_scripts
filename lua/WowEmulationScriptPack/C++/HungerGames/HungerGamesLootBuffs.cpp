#include "Creature.h"
#include "GameEventCallbacks.h"
#include "HungerGamesStore.h"

#define CREATURE_DEATH_GIVE_BUFFS_ENTRY  123463

void DealLastBreathDamageToPlayer(Creature *Attacker, Player *Victim);

//when you manage to kill a creature. You can kill steal XP loot
void HungerGamesPlayerLootAura(void *p, void *)
{
    CP_CREATURE_INTERRACT *params = PointerCast(CP_CREATURE_INTERRACT, p);

    //sanity check
    if (params->player == NULL || params->creature == NULL)
        return;

    //killer player gets XP based on creature Entry
    if (params->creature->GetEntry() != CREATURE_DEATH_GIVE_BUFFS_ENTRY)
        return;

    //no repsawning. We will spawn a new random creature
    params->creature->AddObjectToRemoveList();

    //select first available
    static const uint32 BuffsCanGive[] = { 12732,3593,20798,20217,1126,21562,26035,21614, };
    for (uint32 i = 0; i < _countof(BuffsCanGive); i++)
        if (params->player->HasAura(BuffsCanGive[i]) == false)
        {
            if (params->player->AddAura(BuffsCanGive[i], params->player) != NULL)
            {
                DealLastBreathDamageToPlayer(params->creature, params->player);
                return;
            }
        }
}
