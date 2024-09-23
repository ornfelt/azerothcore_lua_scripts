#include "Creature.h"
#include "GameEventCallbacks.h"
#include "HungerGamesStore.h"
#include "Random.h"
#include "ObjectMgr.h"
#include "GameTime.h"
#include <map>

#define CREATURE_DEATH_GIVE_XP_ENTRY    123461
#define CREATURE_DEATH_GIVE_XP_AMOUNT   100
#define MAGICAL_HEALTH_WE_SHOULD_RESET  1000000

void DealLastBreathDamageToPlayer(Creature *Attacker, Player *Victim)
{
    //the price of this kill is loosing half of your hp
/*    CalcDamageInfo damageInfo;
    Attacker->CalculateMeleeDamage(Victim, &damageInfo, BASE_ATTACK);
    damageInfo.CleanDamage = Victim->GetHealth() / 2;
    Attacker->SendAttackStateUpdate(&damageInfo);
    Attacker->DealMeleeDamage(&damageInfo, true);
    */
    Victim->SetHealth(Victim->GetHealth() / 2);
}

//when you manage to kill a creature. You can kill steal XP loot
void HungerGamesPlayerLootXp(void *p, void *)
{
    CP_CREATURE_INTERRACT *params = PointerCast(CP_CREATURE_INTERRACT, p);

    //sanity check
    if (params->player == NULL || params->creature == NULL)
        return;

    //killer player gets XP based on creature Entry
    if (params->creature->GetEntry() == CREATURE_DEATH_GIVE_XP_ENTRY)
    {
        uint32 XPToGive = params->player->GetUInt32Value(PLAYER_NEXT_LEVEL_XP) * CREATURE_DEATH_GIVE_XP_AMOUNT / 100;
        params->player->GiveXP(XPToGive, NULL, 1);

        //no repsawning. We will spawn a new random creature
        params->creature->AddObjectToRemoveList();

        DealLastBreathDamageToPlayer(params->creature, params->player);
    }

}

void HungerGamesPlayerAttackCreature(void *p, void *)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    //sanity checks
    if (params->Attacker == NULL || params->Victim == NULL)
        return;

    //only target creature is XP / spell / buff...
    if (params->Attacker->GetCharmerOrOwnerGUID() != ObjectGuid::Empty)
        return;

    //protection to get 1 hit on first hit
    if(params->Victim->GetMaxHealth() == MAGICAL_HEALTH_WE_SHOULD_RESET)
        params->Victim->ToCreature()->UpdateLevelDependantStats();

    // nothing to do here
    if (params->Victim->getLevel() == params->Attacker->getLevel())
        return;

    // same level of attacker to do damage
    params->Victim->SetLevel(params->Attacker->getLevel());
    params->Victim->ToCreature()->UpdateLevelDependantStats();
    // peanut damage : 5 * level
//    params->Victim->SetBaseWeaponDamage(BASE_ATTACK, MINDAMAGE, 5 * params->Victim->getLevel());
//    params->Victim->SetBaseWeaponDamage(BASE_ATTACK, MAXDAMAGE, 7 * params->Victim->getLevel());
}

float HungerGameStore::GetTimeRemainPCT()
{
    time_t TimeSpent = GameTime::GetGameTime() - StartedAt;
    float TimeRemainingPCT = 1 - (float)TimeSpent / (float)ForceEndMatchAfterXSeconds;
    return TimeRemainingPCT;
}

bool HungerGameStore::SpawnNewCreature(Map *map)
{
    if (PossibleCreatureLocations.empty())
        return false;
    //are we allowed to spawn more chests ? Maybe we are full
    //clean up our chest list. Ditch already looted chests
    uint32 ActiveCount = 0;
    for (auto itr = PossibleCreatureLocations.begin(); itr != PossibleCreatureLocations.end(); itr++)
    {
        Creature *c = map->GetCreature((*itr)->SpawnGuid);
        if (c == NULL)
        {
            (*itr)->SpawnGuid = ObjectGuid::Empty;
            continue;
        }
        ActiveCount++;
    }

    //we got enough chests on the map. Nothing more to do
    if (ActiveCount >= MaxAllowedCreaturesActiveOnMap)
        return false;

    //pick a location that is not yet taken
    ObjectsSpawnStore *tspawn = NULL;
    uint32 MaxLocations = (uint32)PossibleCreatureLocations.size();
    float TimeRemainingPCT = GetTimeRemainPCT();
    for (int i = MaxLocations; i >= 0; i--)
    {
        uint32 CheckLoc = (NextCreatureSpawnLocation + i) % MaxLocations;
        tspawn = PossibleCreatureLocations.at(CheckLoc);
        if (tspawn->SpawnGuid != ObjectGuid::Empty && map->GetCreature(tspawn->SpawnGuid) != NULL)
            continue;
        //check if we are allowed to spawn at this distance
        if (SpawnsReducedToMid == true)
        {
            float DistanceAllowed = EventRadius * TimeRemainingPCT;
            if (tspawn->pos.GetExactDist2dSq(Position(EventCenterX, EventCenterY)) > DistanceAllowed * DistanceAllowed)
                continue;// this spawn is too far from center. Deny spawning it
        }
        NextCreatureSpawnLocation = CheckLoc;
        break;
    }

    //we can't spawn more creatures
    if (tspawn == NULL)
    {
        return false;
    }

    //random entry to avoid spawning the same creature at the same location. Kill them if you want a new spawn
    uint32 MinEntry = RandomlySpawnedCreatureEntries.at( rand32() % RandomlySpawnedCreatureEntries.size());
    tspawn->SpawnGuid = SpawnCreature(map, MinEntry, &tspawn->pos);
    if (tspawn->SpawnGuid == ObjectGuid::Empty)
        return false;

    return true;
}

void  HungerGameStore::SpawnCreaturesInitial(Map *map)
{
    uint32 SpawnsMade = 0;

    uint32 MaxPossibleEntries = (uint32)RandomlySpawnedCreatureEntries.size();
    std::vector<uint32> Entries;
    for (auto i = RandomlySpawnedCreatureEntries.begin(); i != RandomlySpawnedCreatureEntries.end(); i++)
        Entries.push_back(*i);

    for (auto i = PossibleCreatureLocations.begin(); i != PossibleCreatureLocations.end() && SpawnsMade < MaxAllowedCreaturesActiveOnMap; i++)
    {
        ObjectsSpawnStore *tspawn = *i;
        uint32 MinEntry = Entries.at( SpawnsMade % MaxPossibleEntries );
        tspawn->SpawnGuid = SpawnCreature(map, MinEntry, &tspawn->pos);
        SpawnsMade++;
    }
}

ObjectGuid HungerGameStore::SpawnCreature(Map *map, uint32 Entry, Position *pos)
{
    //spawn a check at the location
    CreatureTemplate const* objectInfo = sObjectMgr->GetCreatureTemplate(Entry);
    if (objectInfo == NULL)
    {
        printf("Holy moly, creature template missing from DB");
        return ObjectGuid::Empty;
    }
    Creature* creature = new Creature();
    if (!creature->Create(map->GenerateLowGuid<HighGuid::Unit>(), map, PHASEMASK_NORMAL, Entry, *pos, NULL, 0, true))
    {
        delete creature;
        return ObjectGuid::Empty;
    }

    //try tp push it to the map
    if (!map->AddToMap(creature))
    {
        delete creature;
        return ObjectGuid::Empty;
    }
    creature->SetHomePosition(creature->GetPosition());

    //mark him a temporary spawn. No respawn
    creature->SetOwnerGUID(ObjectGuid((uint64)1));

    //make him strong. We will change HP on first hit
    creature->SetMaxHealth(MAGICAL_HEALTH_WE_SHOULD_RESET);
    creature->SetHealth(MAGICAL_HEALTH_WE_SHOULD_RESET);

    //avoid boredom
    static const uint32 Emotes[] = { EMOTE_STATE_DANCE, EMOTE_STATE_SLEEP, EMOTE_STATE_SIT, EMOTE_STATE_KNEEL, EMOTE_STATE_WORK, EMOTE_STATE_WORK_MINING, EMOTE_STATE_APPLAUD, EMOTE_STATE_LAUGH, EMOTE_STATE_CANNIBALIZE, EMOTE_STATE_DANCESPECIAL, EMOTE_STATE_EAT, EMOTE_STATE_LOOT, EMOTE_STATE_STRANGULATE,EMOTE_STATE_STUN,EMOTE_STATE_STEALTH_STAND };
    uint32 SelectedEmote = Emotes[rand32() % _countof(Emotes)];
    creature->SetUInt32Value(UNIT_NPC_EMOTESTATE, SelectedEmote);

    //need to despawn these after the HG ends
    return creature->GetGUID();
}

void HungerGameStore::CheckSpawnRandomCreatures(Map *map)
{
    if (GetStatus() != HG_ONGOING)
    {
        RemoveAllSpawnedMobs(map);
        return;
    }

    //there are no random creatures for this hunger games map
    if (RandomlySpawnedCreatureEntries.empty())
    {
        return;
    }

    time_t TimePassed = GameTime::GetGameTime() - LastCreatureSpawnedAt;
    if (TimePassed < CreatureSpawnPeriod)
        return;

    // do not spam this function
    LastCreatureSpawnedAt = GameTime::GetGameTime();

    SpawnNewCreature(map);
}

void HungerGameStore::RemoveAllSpawnedMobs(Map *map)
{
    for (auto itr = PossibleCreatureLocations.begin(); itr != PossibleCreatureLocations.end(); itr++)
        if((*itr)->SpawnGuid.IsEmpty() == false)
        {
            Creature *c = map->GetCreature((*itr)->SpawnGuid);
            if (c == NULL)
            {
                (*itr)->SpawnGuid = ObjectGuid::Empty;
                continue;
            }
            c->AddObjectToRemoveList();
        }
}
