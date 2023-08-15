#include "Map.h"
#include "Player.h"
#include "Creature.h"
#include "GameTime.h"
#include "ScriptMgr.h"
#include "TemporarySummon.h"
#include "PassiveAI.h"
#include "GridNotifiers.h"
#include "SpellMgr.h"
#include "GameEventCallbacks.h"
#include "ObjectExtension.cpp"
#include "RI_CreatureScaleScripts.h"
#include "SpellAuras.h"

#ifndef MIN
    #define MIN(a,b) ((a)<(b)?(a):(b))
#endif
#ifndef MAX
    #define MAX(a,b) ((a)<(b)?(b):(a))
#endif

#define RESISTANCE_FOR_MAX_MITIGATION 700
#define RESISTANCE_MAX_DMG_MITIGATION 0.8f

enum DifficultyScriptTypes
{
    RI_DS_NOT_USED_DUMMY_VALUE,
    RI_DS_MIN_DIFF_ANYSCRIPT,

    RI_DS_FROST_NOVA_ON_STRUCK,
    RI_DS_LIGHTNING_ON_STRUCK,
    RI_DS_FIRE_RAIN_ON_STRUCK,
    RI_DS_MOSTER_MOVE_SPEED,
    RI_DS_EXPLODE,
    RI_DS_DECREASE_PLAYER_HEALTH_PERIODICALLY,
    RI_DS_TOXIC_POOL,
    RI_DS_LINKED_HEALTH,
    RI_DS_RANDOM_IMMUNITY,
    RI_DS_REANIMATE,
    RI_DS_ENGULFED_IN_FLAME,   // shroud of sorrow
    RI_DS_FALL_ASLEEP, // standing in 1 place makes you fall asleep
    RI_DS_CRIT_CHANCE,
    RI_DS_RANDOM_MECHANIC_IMMUNITY,
    RI_DS_LOOSE_GOLD_ON_DEATH,
    RI_DS_REFLECT_SPELLS,
    RI_DS_ELEMENTAL_DMG,
    RI_DS_LAVA_POOL,
    RI_DS_REDUCED_DAMAGE_TAKEN,
        RI_DS_PERIODIC_DISPEL,
        RI_DS_REFLECT_DMG,
        RI_EMPOWER_ON_HIT,
    RI_DS_FRENZIED_REGENERATION,
    RI_DS_FIRE_CHAINS,

    RI_DS_MAX_SCRIPTS,
};
int RI_DS_REQUIRED_DIFF[RI_DS_MAX_SCRIPTS];

#define PLAYER_ITEM_COUNT 11
#define MONSTER_DIIFCULTY_MULTIPLIER    (PLAYER_ITEM_COUNT / 2)  // expect half of the items get upgraded to half potential. Mobs scale in both dmg and HP !
#define MONSTER_DIIFCULTY_MULTIPLIER_HP (MONSTER_DIIFCULTY_MULTIPLIER/2)

bool CheckShouldTriggerCreatureScript(Map *m, DifficultyScriptTypes Type, Creature *c = NULL, Player *p = NULL)
{
    if (m == NULL)
        return false;
    int64 *InstanceScalePlayer = m->GetExtension<int64>(OE_MAP_MOB_DIFFICULTY_SCALER);
    if (InstanceScalePlayer == NULL)
        return false;
    if (c != NULL)
    {
        if (p != NULL)
        {
            if (p->IsFriendlyTo(c) == true)
                return false;
        }
        //toxic pool should not trigger any other scripts
        if(c->GetEntry()==15925)
            return false;
        if (c->IsCritter())
            return false;
    }
    if (*InstanceScalePlayer >= RI_DS_REQUIRED_DIFF[Type])
        return true;
    return false;
}

void RI_DS_MapUpdate(void *p, void *)
{
    CP_MAP_PERIODIC_UPDATE *params = PointerCast(CP_MAP_PERIODIC_UPDATE, p);
    if (params->map == NULL)
        return;

    //only trigger for maps that are scaled
    if (CheckShouldTriggerCreatureScript(params->map, RI_DS_DECREASE_PLAYER_HEALTH_PERIODICALLY) == true)
    {
        //check if enough time has passed to decrease player health
        int64 *NextHealthDecreaseStamp = params->map->GetCreateIn64Extension(OE_MAP_RI_DS_HEALTH_DECREASE_STORE);
        if (*NextHealthDecreaseStamp < GameTime::GetGameTimeMS())
        {
            *NextHealthDecreaseStamp = GameTime::GetGameTimeMS() + 10000;
            Map::PlayerList const& PlayerList = params->map->GetPlayers();
            for (Map::PlayerList::const_iterator itr = PlayerList.begin(); itr != PlayerList.end(); ++itr)
                itr->GetSource()->EnvironmentalDamage(DAMAGE_DROWNING, 5 * itr->GetSource()->GetHealth() / 100);
        }
    }
    if (CheckShouldTriggerCreatureScript(params->map, RI_DS_FRENZIED_REGENERATION) == true)
    {
        int64 *NextHealthDecreaseStamp = params->map->GetCreateIn64Extension(OE_MAP_RI_DS_HEALTH_INCREASE_STORE);
        if (*NextHealthDecreaseStamp < GameTime::GetGameTimeMS())
        {
            *NextHealthDecreaseStamp = GameTime::GetGameTimeMS() + 2000;
            //every 10 minutes since the instance have been spawned, mobs will regenerate 1% health
            uint64 SecondsSinceCreate = GameTime::GetGameTime() - params->map->GetCreateIn64Extension(OE_MAP_CREATE_TIME, false, GameTime::GetGameTime())[0];
            float RestorePCT = SecondsSinceCreate / 60.0f / 10.0f / 100.0f;

            Map::CreatureBySpawnIdContainer const& CreatureList = params->map->GetCreatureBySpawnIdStore();
            for (auto itr = CreatureList.begin(); itr != CreatureList.end(); ++itr)
            {
                if (itr->second == NULL || itr->second->IsAlive() == false)
                    continue;
                int32 HealthMissing = itr->second->GetMaxHealth() - itr->second->GetHealth();
                if (HealthMissing <= 0)
                    continue;
                int32 RestoreAmt = itr->second->GetMaxHealth() * RestorePCT;
                itr->second->ModifyHealth(RestoreAmt);
            }
        }
    }
}

uint32 GetMinResistance(Unit *u, SpellSchoolMask mask)
{
    if (mask == 0)
        return 0;
    uint32 resist = 0x00FFFFFF;
    for (int32 i = SPELL_SCHOOL_NORMAL; i < MAX_SPELL_SCHOOL; ++i)
        if ((mask & (1 << i)) && resist > u->GetResistance(SpellSchools(i)))
        {
            if( i == 0 )
                resist = u->GetResistance(SpellSchools(i)) / 100;
            else
                resist = u->GetResistance(SpellSchools(i));
        }

    // resist value will never be negative here
    return uint32(resist);
}

void RI_OnHitTarget(void *p, void *Context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;
    Player *PlayerAttacker = params->Attacker->ToPlayer();
    if (PlayerAttacker == NULL)
        PlayerAttacker = params->Attacker->GetCharmerOrOwnerPlayerOrPlayerItself();
    Player *PlayerTarget = params->Victim->ToPlayer();
    if (PlayerTarget == NULL)
        PlayerTarget = params->Victim->GetCharmerOrOwnerPlayerOrPlayerItself();

    //if player attacks the creature
    if (PlayerAttacker != NULL && PlayerTarget == NULL)
    {
        if (CheckShouldTriggerCreatureScript(params->Attacker->GetMap(), RI_DS_MIN_DIFF_ANYSCRIPT, params->Victim->ToCreature(), PlayerAttacker) == false)
            return;

        //check if we need to trigger any of the scripts
        if (CheckShouldTriggerCreatureScript(params->Attacker->GetMap(), RI_DS_FROST_NOVA_ON_STRUCK) == true)
        {
            int64 *NextTrigger = params->Attacker->GetCreateIn64Extension(OE_CREATURE_FROST_NOVA_COOLDOWN);
            if (*NextTrigger < GameTime::GetGameTimeMS())
            {
                *NextTrigger = GameTime::GetGameTimeMS() + 2000;
                int SpellId;
                if (params->Victim->getLevel() < 85 / 4 * 1)
                    SpellId = 122;
                else if (params->Victim->getLevel() < 85 / 4 * 2)
                    SpellId = 865;
                else if (params->Victim->getLevel() < 85 / 4 * 3)
                    SpellId = 6131;
                else
                    SpellId = 10230;
                params->Victim->CastSpell(params->Attacker, SpellId, true);
            }
        }
        //check if we need to trigger any of the scripts
        if (CheckShouldTriggerCreatureScript(params->Attacker->GetMap(), RI_DS_LIGHTNING_ON_STRUCK) == true)
        {
            int64 *NextTrigger = params->Attacker->GetCreateIn64Extension(OE_CREATURE_CHAIN_LIGHTNING_COOLDOWN);
            if (*NextTrigger < GameTime::GetGameTimeMS())
            {
                *NextTrigger = GameTime::GetGameTimeMS() + 2500;
                SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(421);
                Spell* spell = new Spell(params->Victim, spellInfo, TRIGGERED_FULL_MASK);
                spell->m_targets.SetUnitTarget(params->Attacker);
                spell->SetSpellValue(SPELLVALUE_BASE_POINT0, int32(params->Attacker->GetMaxHealth() * (0.5f / 100.0f))); // 0.5%
                spell->cast(true);
            }
        }
        //check if we need to trigger any of the scripts
        if (CheckShouldTriggerCreatureScript(params->Attacker->GetMap(), RI_DS_FIRE_RAIN_ON_STRUCK) == true)
        {
            int64 *NextTrigger = params->Attacker->GetCreateIn64Extension(OE_CREATURE_FIRE_RAIN_COOLDOWN);
            if (*NextTrigger < GameTime::GetGameTimeMS())
            {
                *NextTrigger = GameTime::GetGameTimeMS() + 3000;
                SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(5740); //5740,26573
                Spell* spell = new Spell(params->Victim, spellInfo, TRIGGERED_FULL_MASK);
                spell->m_targets.SetUnitTarget(params->Attacker);
                spell->m_targets.SetSrc(params->Victim->GetPosition());
                spell->m_targets.SetDst(params->Attacker->GetPosition());
                spell->SetSpellValue(SPELLVALUE_BASE_POINT0, int32(params->Victim->GetMaxHealth() * (1.f / 100.0f))); // 0.5%
                spell->cast(true);
            }
        }
        //check if we need to trigger any of the scripts
        if (CheckShouldTriggerCreatureScript(params->Attacker->GetMap(), RI_DS_LINKED_HEALTH) == true)
        {
            auto TargetList = params->Attacker->GetThreatManager().GetThreatenedByMeList();
            size_t TargetCount = TargetList.size();
            if (TargetCount > 1)
            {
                int DmgPart = params->GetDamage() / (int)TargetCount; // each victim will receive same amount of dmg
                int32 SharedAmount = 0;
                //other targets will receive dmg as well
                for (auto itr = TargetList.begin(); itr != TargetList.end(); itr++)
                {
                    if (itr->first == params->Victim->GetGUID())
                        continue;
                    Unit *u = params->Attacker->GetMap()->GetCreature(itr->first);
                    if (u == NULL)
                        continue;
                    if ((int)u->GetHealth() > DmgPart)
                    {
                        u->ModifyHealth(-DmgPart);
                        SharedAmount += DmgPart;
                    }
                }
                params->FlatMods -= SharedAmount; // original target will only receive 1 part of dmg
            }
        }
        if (CheckShouldTriggerCreatureScript(params->Attacker->GetMap(), RI_DS_REFLECT_SPELLS) == true && rand32() % 100 < 5)
        {
            //pick a random reflection AURA
            const static uint32 ReflectSpells[] = { 51758,51763,51764,51766,22857 };
            uint32 PickedSpellId = ReflectSpells[rand32() % _countof(ReflectSpells)];
            params->Victim->CastSpell(params->Victim, PickedSpellId, TRIGGERED_FULL_MASK);
        }
    }
}

void RI_OnDamageTaken(void *p, void *Context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;
    Player *PlayerAttacker = params->Attacker->ToPlayer();
    if (PlayerAttacker == NULL)
        PlayerAttacker = params->Attacker->GetCharmerOrOwnerPlayerOrPlayerItself();
    Player *PlayerTarget = params->Victim->ToPlayer();
    if (PlayerTarget == NULL)
        PlayerTarget = params->Victim->GetCharmerOrOwnerPlayerOrPlayerItself();

    //if player attacks the creature
    if (PlayerAttacker != NULL && PlayerTarget == NULL)
    {
        if (CheckShouldTriggerCreatureScript(params->Attacker->GetMap(), RI_DS_REDUCED_DAMAGE_TAKEN) == true)
        {
            int64 *InstanceScale = params->Attacker->GetMap()->GetExtension<int64>(OE_MAP_MOB_DIFFICULTY_SCALER);
            if (InstanceScale[0] > 0)
            {
                float OriginalDamage = (float)params->GetDamage();
                float DifficultyScaler = ((float)InstanceScale[0]) / 1000.0f * RESISTANCE_MAX_DMG_MITIGATION; // at 1000% this would mean a loss of 80% dmg
                float DmgReduction = OriginalDamage * DifficultyScaler;

                uint32 PlayerListSize = params->Attacker->GetMap()->GetPlayers().getSize();
                for (uint32 i = 1; i < PlayerListSize; i++)
                {
                    float RemainingDmg = OriginalDamage - DmgReduction;
                    DmgReduction += RemainingDmg * 0.75f; //loose 75% of damage for every extra player
                }

                params->FlatMods -= (int32)(DmgReduction);
            }
        }
    }
    if (PlayerAttacker == NULL && PlayerTarget != NULL)
    {
        //mod damage based on map setting
        int64 *InstanceScale = params->Attacker->GetMap()->GetExtension<int64>(OE_MAP_MOB_DIFFICULTY_SCALER);
        if (InstanceScale != NULL && *InstanceScale > 0)
        {
            float PCTScaler = (float)*InstanceScale;
            if (PCTScaler > 200)
            {
                PCTScaler = (PCTScaler) / 100.0f * (PCTScaler / 3.0f) / 100.0f; // 100 = 0, 200 = 0, 300 = 3, 400 = 5, 500 = 8, 600 = 12
                params->FlatMods += (uint32)(params->OriDamage * PCTScaler);
            }

            //mitigation pct based reduction
            uint32 Resistance = 0;
            if (params->sp == NULL)
                Resistance = GetMinResistance(params->Victim, params->Attacker->GetMeleeDamageSchoolMask());
            else
                Resistance = GetMinResistance(params->Victim, params->sp->GetSchoolMask());
            Resistance = MIN(RESISTANCE_FOR_MAX_MITIGATION, Resistance);
            float DmgReduction = Resistance / RESISTANCE_FOR_MAX_MITIGATION * RESISTANCE_MAX_DMG_MITIGATION; // max 80% dmg reduction for 500 resistance
            params->FlatMods -= (int32)(params->GetDamage() * (1.0f - DmgReduction));
        }
    }
}

#define TIMEOUT_PREVIOUS_CONDITION_CHECKS 30000
#define DISTANCE_MOVE_SQ 0.1f
class FallAsleepStore
{
public:
    FallAsleepStore()
    {
        NextPositionCheckStamp = 0;
        MountId = 0;
    }

    uint32      NextPositionCheckStamp;
    uint32      MountId;
    Position    pos;
};

void PeriodicCheckPlayerFallAsleep(void *p, void *)
{
    Player *player = (Player*)p;
    FallAsleepStore *ms = player->GetCreateExtension<FallAsleepStore>(OE_PLAYER_FALL_ASLEEP_STORE);
    uint32 TickNow = GameTime::GetGameTimeMS();
    //if it is a good condition, than we should start counting seconds and distances
    if (ms->NextPositionCheckStamp > TickNow)
        return;
    ms->NextPositionCheckStamp = TickNow + TIMEOUT_PREVIOUS_CONDITION_CHECKS;
    //only trigger if we are standing in 1 place
    float dist = ms->pos.GetExactDist2dSq(player->GetPosition());
    //remember position
    ms->pos = player->GetPosition();
    if (dist >= DISTANCE_MOVE_SQ)
        return;
    //self cast asleep
    player->CastSpell(player, 34801, TRIGGERED_FULL_MASK);
}

void RI_DS_OnPlayerMapChange(void *p, void *)
{
    CP_MAP_CHANGED *params = PointerCast(CP_MAP_CHANGED, p);
    if (CheckShouldTriggerCreatureScript(params->NewMap, RI_DS_FROST_NOVA_ON_STRUCK) == true)
        params->Player->BroadcastMessage("ScaledInstance : Frost Nova on struck - map mod activated");
    if (CheckShouldTriggerCreatureScript(params->NewMap, RI_DS_RANDOM_IMMUNITY) == true)
        params->Player->BroadcastMessage("ScaledInstance : Random dmg school immunity - map mod activated");
    if (CheckShouldTriggerCreatureScript(params->NewMap, RI_DS_REANIMATE) == true)
        params->Player->BroadcastMessage("ScaledInstance : Killed creatures reannimate - map mod activated");
    if (CheckShouldTriggerCreatureScript(params->NewMap, RI_DS_FALL_ASLEEP) == true)
        params->Player->BroadcastMessage("ScaledInstance : Standing makes you fall asleep - map mod activated");
    if (CheckShouldTriggerCreatureScript(params->NewMap, RI_DS_ENGULFED_IN_FLAME) == true)
        params->Player->BroadcastMessage("ScaledInstance : Mobs gain AOE aura - map mod activated");
    if (CheckShouldTriggerCreatureScript(params->NewMap, RI_DS_LIGHTNING_ON_STRUCK) == true)
        params->Player->BroadcastMessage("ScaledInstance : Lightning on struck - map mod activated");
    if (CheckShouldTriggerCreatureScript(params->NewMap, RI_DS_FIRE_RAIN_ON_STRUCK) == true)
        params->Player->BroadcastMessage("ScaledInstance : Rain of Fire on struck - map mod activated");
    if (CheckShouldTriggerCreatureScript(params->NewMap, RI_DS_EXPLODE) == true)
        params->Player->BroadcastMessage("ScaledInstance : Explode on death - map mod activated");
    if (CheckShouldTriggerCreatureScript(params->NewMap, RI_DS_MOSTER_MOVE_SPEED) == true)
        params->Player->BroadcastMessage("ScaledInstance : Extra Monster speed - map mod activated");
    if (CheckShouldTriggerCreatureScript(params->NewMap, RI_DS_DECREASE_PLAYER_HEALTH_PERIODICALLY) == true)
        params->Player->BroadcastMessage("ScaledInstance : Sudden Death - map mod activated");
    if (CheckShouldTriggerCreatureScript(params->NewMap, RI_DS_TOXIC_POOL) == true)
        params->Player->BroadcastMessage("ScaledInstance : Toxic pool - map mod activated");
    if (CheckShouldTriggerCreatureScript(params->NewMap, RI_DS_LINKED_HEALTH) == true)
        params->Player->BroadcastMessage("ScaledInstance : Linked Health - map mod activated");
    if (CheckShouldTriggerCreatureScript(params->NewMap, RI_DS_CRIT_CHANCE) == true)
        params->Player->BroadcastMessage("ScaledInstance : Mob crit chance - map mod activated");
    if (CheckShouldTriggerCreatureScript(params->NewMap, RI_DS_RANDOM_MECHANIC_IMMUNITY) == true)
        params->Player->BroadcastMessage("ScaledInstance : Random mechanic immunity - map mod activated");
    if (CheckShouldTriggerCreatureScript(params->NewMap, RI_DS_LOOSE_GOLD_ON_DEATH) == true)
        params->Player->BroadcastMessage("ScaledInstance : Death Toll - map mod activated");
    if (CheckShouldTriggerCreatureScript(params->NewMap, RI_DS_REFLECT_SPELLS) == true)
        params->Player->BroadcastMessage("ScaledInstance : Reflection - map mod activated");
    if (CheckShouldTriggerCreatureScript(params->NewMap, RI_DS_ELEMENTAL_DMG) == true)
        params->Player->BroadcastMessage("ScaledInstance : Elemental - map mod activated");
    if (CheckShouldTriggerCreatureScript(params->NewMap, RI_DS_LAVA_POOL) == true)
        params->Player->BroadcastMessage("ScaledInstance : Lava pool - map mod activated");
    if (CheckShouldTriggerCreatureScript(params->NewMap, RI_DS_FIRE_CHAINS) == true)
        params->Player->BroadcastMessage("ScaledInstance : Arcane chains - map mod activated");
    if (CheckShouldTriggerCreatureScript(params->NewMap, RI_DS_REDUCED_DAMAGE_TAKEN) == true)
        params->Player->BroadcastMessage("ScaledInstance : Tough - map mod activated");
    if (CheckShouldTriggerCreatureScript(params->NewMap, RI_DS_FRENZIED_REGENERATION) == true)
        params->Player->BroadcastMessage("ScaledInstance : Health Regen - map mod activated");

    if (CheckShouldTriggerCreatureScript(params->NewMap, RI_DS_FALL_ASLEEP) == true)
        params->Player->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_PERIODIC_TICK, PeriodicCheckPlayerFallAsleep);
    else
        params->Player->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_PERIODIC_TICK, PeriodicCheckPlayerFallAsleep);
}

bool CanUnitBeFireChainTarget(Unit *u, Player *p)
{
    if (u->GetChannelObjectGuid().Empty != false)
        return false;
    if (u->GetUInt32Value(UNIT_CHANNEL_SPELL) != 0)
        return false;
    if (u->GetExtension<uint64>(OE_CREATURE_FIRE_CHAIN_MATE) != NULL)
        return false;
    if (u->isTargetableForAttack(false) == false)
        return false;
    if (p != NULL && u->IsValidAttackTarget(p) == false)
        return false;
    return true;
}

void OnCreatureUpdateFireChain(void *pCreature, void *)
{
    Creature *Owner = (Creature *)pCreature;
    int64 *NextUpdateStamp = Owner->GetCreateIn64Extension(OE_CREATURE_FIRE_CHAIN_NEXT_UPDATE_STAMP);
    //no need to spam this
    if (*NextUpdateStamp > GameTime::GetGameTimeMS())
        return;
    *NextUpdateStamp = GameTime::GetGameTimeMS() + 2000;

    Creature *ChainedTarget = NULL;
    if (Owner->GetMap() != NULL)
    {
        ObjectGuid MateGuid(*Owner->GetExtension<uint64>(OE_CREATURE_FIRE_CHAIN_MATE));
        ChainedTarget = Owner->GetMap()->GetCreature(MateGuid);
    }
    if (ChainedTarget == NULL || Owner->IsAlive() == false || ChainedTarget->IsAlive() == false)
    {
        //remove the chain from us and our mate
        Owner->SetChannelObjectGuid(ObjectGuid());
        Owner->SetUInt32Value(UNIT_CHANNEL_SPELL, 0);
        if (ChainedTarget != NULL)
        {
            ChainedTarget->SetChannelObjectGuid(ObjectGuid());
            ChainedTarget->SetUInt32Value(UNIT_CHANNEL_SPELL, 0);
        }
        //unregister this callback. Suicide call !
        Owner->UnRegisterCallbackFunc(CALLBACK_TYPE_CREATURE_UPDATE, OnCreatureUpdateFireChain);
        return;
    }
    float Divider = (Owner->GetPositionX() - ChainedTarget->GetPositionX());
    if (Divider == 0.f)
        Divider = 0.000001f;
    float LineSloap = (Owner->GetPositionY() - ChainedTarget->GetPositionY()) / Divider;// line will be : y - Owner->GetPositionY() = LineSloap(x - Owner->GetPositionX() )
    float MinX = MIN(Owner->GetPositionX(), ChainedTarget->GetPositionX()) + 1.f;
    float MaxX = MAX(Owner->GetPositionX(), ChainedTarget->GetPositionX()) - 1.f;
    float MinY = MIN(Owner->GetPositionY(), ChainedTarget->GetPositionY()) + 1.f;
    float MaxY = MAX(Owner->GetPositionY(), ChainedTarget->GetPositionY()) - 1.f;
    //get nearby players, apply dmg
    const float Radius = 30.0f;
    Map::PlayerList const& PlayerList = Owner->GetMap()->GetPlayers();
    for (Map::PlayerList::const_iterator itr = PlayerList.begin(); itr != PlayerList.end(); ++itr)
    {
        //is this player crossing the line between the 2 mobs
        Player *p = (itr->GetSource());
        float PlayerDistanceFromLine = LineSloap * (p->GetPositionX() - Owner->GetPositionX()) - (p->GetPositionY() - Owner->GetPositionY());
        if ( abs(PlayerDistanceFromLine) > 1.5f)
            continue;
        //are we between the 2 mobs ?
        if (p->GetPositionX() < MinX || p->GetPositionX() > MaxX)
            continue;
        if (p->GetPositionY() < MinY || p->GetPositionY() > MaxY)
            continue;
        //deal the damage
        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(51021);
        Spell* spell = new Spell(Owner, spellInfo, (TriggerCastFlags)(TRIGGERED_FULL_MASK | TRIGGERED_IGNORE_CAST_TIME | TRIGGERED_IGNORE_MOVE_CHECK));
        spell->m_targets.SetUnitTarget(p);
        spell->SetSpellValue(SPELLVALUE_BASE_POINT0, p->GetMaxHealth() * 10 / 100);
        spell->cast(true);
    }
}

void RI_DS_OnMobSpawn(void *p, void *)
{
    CP_CREATURE_SPAWN *params = PointerCast(CP_CREATURE_SPAWN, p);

    if (params->Spawn == NULL || params->map == NULL)
        return;

    Player *plr = NULL;
    if( params->map->GetPlayers().begin() != params->map->GetPlayers().end())
        plr = params->map->GetPlayers().begin()->GetSource();

    if (CheckShouldTriggerCreatureScript(params->map, RI_DS_MIN_DIFF_ANYSCRIPT, params->Spawn, plr) == false)
        return;

    if (CheckShouldTriggerCreatureScript(params->Spawn->GetMap(), RI_DS_MOSTER_MOVE_SPEED, params->Spawn) == true)
    {
        params->Spawn->SetObjectScale(0.75f);
        for (UnitMoveType i = MOVE_WALK; i <= MOVE_PITCH_RATE; i = (UnitMoveType)(i + 1))
            params->Spawn->SetSpeedRate(i, 1.5f);
        params->Spawn->ApplyAttackTimePercentMod(BASE_ATTACK, -50, true);
        params->Spawn->ApplyAttackTimePercentMod(OFF_ATTACK, -50, true);
        params->Spawn->ApplyAttackTimePercentMod(RANGED_ATTACK, -50, true);
    }
    if (CheckShouldTriggerCreatureScript(params->Spawn->GetMap(), RI_DS_RANDOM_IMMUNITY, params->Spawn) == true)
    {
        int PickedImmunity = rand32() % MAX_SPELL_SCHOOL;
        static uint32 const placeholderSpellId = std::numeric_limits<uint32>::max();
        params->Spawn->ApplySpellImmune(placeholderSpellId, IMMUNITY_SCHOOL, PickedImmunity, true);
        if (PickedImmunity == SPELL_SCHOOL_FIRE)
            params->Spawn->CastSpell(params->Spawn, 34333, TRIGGERED_FULL_MASK);
        if (PickedImmunity == SPELL_SCHOOL_FROST)
            params->Spawn->CastSpell(params->Spawn, 34334, TRIGGERED_FULL_MASK);
        if (PickedImmunity == SPELL_SCHOOL_HOLY)
            params->Spawn->CastSpell(params->Spawn, 34336, TRIGGERED_FULL_MASK);
        if (PickedImmunity == SPELL_SCHOOL_NATURE)
            params->Spawn->CastSpell(params->Spawn, 34335, TRIGGERED_FULL_MASK);
        if (PickedImmunity == SPELL_SCHOOL_NORMAL)
            params->Spawn->CastSpell(params->Spawn, 34337, TRIGGERED_FULL_MASK);
        if (PickedImmunity == SPELL_SCHOOL_SHADOW)
            params->Spawn->CastSpell(params->Spawn, 34338, TRIGGERED_FULL_MASK);
        if (PickedImmunity == SPELL_SCHOOL_ARCANE)
            params->Spawn->CastSpell(params->Spawn, 34331, TRIGGERED_FULL_MASK);
    }
    if (CheckShouldTriggerCreatureScript(params->Spawn->GetMap(), RI_DS_RANDOM_MECHANIC_IMMUNITY, params->Spawn) == true)
    {
        int PickedImmunity = rand32() % MAX_MECHANIC;
        static uint32 const placeholderSpellId = std::numeric_limits<uint32>::max();
        params->Spawn->ApplySpellImmune(placeholderSpellId, IMMUNITY_MECHANIC, PickedImmunity, true);
        PickedImmunity = rand32() % MAX_MECHANIC;
        params->Spawn->ApplySpellImmune(placeholderSpellId, IMMUNITY_MECHANIC, PickedImmunity, true);
    }
    if (CheckShouldTriggerCreatureScript(params->Spawn->GetMap(), RI_DS_ENGULFED_IN_FLAME, params->Spawn) == true)
    {
        params->Spawn->CastSpell(params->Spawn, 50589, TRIGGERED_FULL_MASK);
        Aura *a = params->Spawn->GetAura(50589);
        if (a != NULL && a->GetDuration() != -1)
            a->SetDuration(10 * 60 * 60 * 1000);
    }
    if (CheckShouldTriggerCreatureScript(params->Spawn->GetMap(), RI_DS_CRIT_CHANCE, params->Spawn) == true)
    {
        params->Spawn->m_baseSpellCritChance += 50;
        params->Spawn->m_baseCritChance += 50;
    }
    if (CheckShouldTriggerCreatureScript(params->Spawn->GetMap(), RI_DS_ELEMENTAL_DMG, params->Spawn) == true)
    {
        int PickedSchool = rand32() % MAX_SPELL_SCHOOL;
        params->Spawn->SetMeleeDamageSchool(SpellSchools(PickedSchool));
    }
    if (CheckShouldTriggerCreatureScript(params->Spawn->GetMap(), RI_DS_FIRE_CHAINS, params->Spawn) == true)
    {
        // only chain max 10% of creatures
//        int64 *CreaturesSpawned = params->Spawn->GetMap()->GetCreateIn64Extension(OE_CREATURE_FIRE_CHAIN_TOTAL_CREATURES_SPAWNED);
//        int64 *CreaturesChained = params->Spawn->GetMap()->GetCreateIn64Extension(OE_CREATURE_FIRE_CHAIN_CREATURES_FIRECHAINED);
//        *CreaturesSpawned += 1;
//        if (*CreaturesSpawned * 10 / 100 > *CreaturesChained)
        {
            Player *AnyPlayer = NULL;
            if( params->Spawn->GetMap()->GetPlayers().begin() != params->Spawn->GetMap()->GetPlayers().end())
                AnyPlayer = params->Spawn->GetMap()->GetPlayers().begin()->GetSource();
            if (CanUnitBeFireChainTarget(params->Spawn, AnyPlayer) == true)
            {
                // search for a mate to chain up with
                const float Radius = 20.0f;
                std::list<Unit*> NearbyUnits;
                Trinity::AnyFriendlyUnitInObjectRangeCheck u_check(params->Spawn, params->Spawn, Radius);
                Trinity::UnitListSearcher<Trinity::AnyFriendlyUnitInObjectRangeCheck> searcher(params->Spawn, NearbyUnits, u_check);
                Cell::VisitAllObjects(params->Spawn, searcher, Radius);
                //search to have some minimum radius between the 2
                Unit *BestMatch = NULL;
                float MinDistance = 0.0f;
                for (std::list<Unit*>::iterator itr = NearbyUnits.begin(); itr != NearbyUnits.end(); itr++)
                {
                    if (CanUnitBeFireChainTarget((*itr), AnyPlayer) == false)
                        continue;
                    if (abs((*itr)->GetPositionZ() - params->Spawn->GetPositionZ()) > 5.0f)
                        continue;
                    float Dist = (*itr)->GetDistance2d(params->Spawn);
                    if (Dist < 5.f)
                        continue;
                    if (Dist > MinDistance)
                    {
                        MinDistance = Dist;
                        BestMatch = (*itr);
                    }
                }
                //we found a creature we can link each other with
                if (BestMatch != NULL)
                {
                    *params->Spawn->GetCreateExtension<uint64>(OE_CREATURE_FIRE_CHAIN_MATE) = BestMatch->GetGUID().GetRawValue();
                    *BestMatch->GetCreateExtension<uint64>(OE_CREATURE_FIRE_CHAIN_MATE) = params->Spawn->GetGUID().GetRawValue();
                    params->Spawn->SetChannelObjectGuid(BestMatch->GetGUID());
                    BestMatch->SetChannelObjectGuid(params->Spawn->GetGUID());
                    params->Spawn->SetUInt32Value(UNIT_CHANNEL_SPELL, 689);
                    BestMatch->SetUInt32Value(UNIT_CHANNEL_SPELL, 689);
//                    *CreaturesChained += 1;
                    params->Spawn->RegisterCallbackFunc(CALLBACK_TYPE_CREATURE_UPDATE, OnCreatureUpdateFireChain, NULL);
                }
            }
        }
    }

    //scale health and resistances
    int64 *InstanceScale = params->map->GetCreateIn64Extension(OE_MAP_MOB_DIFFICULTY_SCALER, true);
    if (InstanceScale != NULL)
    {
        int64 PCTScaler = *InstanceScale;
        if (PCTScaler > 0)
        {
            int64 MaxHealth = params->Spawn->GetCreateHealth();
            if(PCTScaler < 600 )
                MaxHealth += MaxHealth * PCTScaler / 100 * MONSTER_DIIFCULTY_MULTIPLIER_HP; // !!! note that we already scaled health once. 3*2*2 = 12, 4*2*2=16, 5*2*2=20
            else 
                MaxHealth += MaxHealth * PCTScaler / 100 * PCTScaler / 100; //  6*6=36, 7*7=49, 8*8=64, 9*9=81 ( 6*5=30, 7*6=42, 8*7=56, 9*8=72 )
            if (MaxHealth > 0x0FFFFFFF)
                MaxHealth = 0x0FFFFFFF;
//            params->Spawn->SetCreateHealth((uint32)MaxHealth);
            params->Spawn->SetMaxHealth((uint32)MaxHealth);
            params->Spawn->SetHealth((uint32)MaxHealth);
            for (int i = SPELL_SCHOOL_NORMAL; i < MAX_SPELL_SCHOOL; i++)
            {
                if (i == SPELL_SCHOOL_NORMAL)
                    params->Spawn->SetResistance(SpellSchools(i), (int32)PCTScaler * 10);
                else
                    params->Spawn->SetResistance(SpellSchools(i), (int32)PCTScaler);
            }
        }
    }
}

struct trigger_periodicToxicAI : public NullCreatureAI
{
    trigger_periodicToxicAI(Creature* creature) : NullCreatureAI(creature)
    {
        interval = 2000;
        timer = interval;
        DespawnTimer = 2 * 60 * 1000;
    }

    int32 timer, interval, DespawnTimer;

    void UpdateAI(uint32 diff) override
    {
        //we should never die
        me->SetHealth(me->GetMaxHealth());

        if (timer <= (int32)diff)
        {
            //get nearby players, apply toxic dmg
            const float Radius = 3.0f;
            const float HealthPCTDmg = 0.05f;
            std::list<Player*> players;
            Trinity::AnyPlayerInObjectRangeCheck checker(me, Radius);
            Trinity::PlayerListSearcher<Trinity::AnyPlayerInObjectRangeCheck> searcher(me, players, checker);
            Cell::VisitWorldObjects(me, searcher, Radius);
            for (std::list<Player*>::iterator itr = players.begin(); itr != players.end(); itr++)
            {
                //nature esistance will decrease this damage
                uint32 Res = MIN(RESISTANCE_FOR_MAX_MITIGATION,(*itr)->GetResistance(SPELL_SCHOOL_NATURE));
                float ResPct = Res / RESISTANCE_FOR_MAX_MITIGATION * RESISTANCE_MAX_DMG_MITIGATION;
                uint32 Dmg = (uint32)(ResPct * HealthPCTDmg * (*itr)->GetHealth());
                (*itr)->EnvironmentalDamage(DAMAGE_SLIME, Dmg);
            }

            timer = interval;
        }
        else
            timer -= diff;
        DespawnTimer -= diff;
        if (DespawnTimer <= 0)
            me->DespawnOrUnsummon();
    }
};

struct trigger_periodicLavaAI : public NullCreatureAI
{
    trigger_periodicLavaAI(Creature* creature) : NullCreatureAI(creature)
    {
        interval = 1000;
        timer = interval;
        DespawnTimer = 2 * 60 * 1000;
    }

    int32 timer, interval, DespawnTimer;

    void UpdateAI(uint32 diff) override
    {
        //we should never die
        me->SetHealth(me->GetMaxHealth());

        if (timer <= (int32)diff)
        {
            //get nearby players, apply toxic dmg
            const float Radius = 1.5f;
            const float HealthPCTDmg = 0.10f;
            std::list<Player*> players;
            Trinity::AnyPlayerInObjectRangeCheck checker(me, Radius);
            Trinity::PlayerListSearcher<Trinity::AnyPlayerInObjectRangeCheck> searcher(me, players, checker);
            Cell::VisitWorldObjects(me, searcher, Radius);
            for (std::list<Player*>::iterator itr = players.begin(); itr != players.end(); itr++)
            {
                //nature esistance will decrease this damage
                uint32 Res = MIN(RESISTANCE_FOR_MAX_MITIGATION, (*itr)->GetResistance(SPELL_SCHOOL_FIRE));
                float ResPct = Res / RESISTANCE_FOR_MAX_MITIGATION * RESISTANCE_MAX_DMG_MITIGATION;
                uint32 Dmg = (uint32)(ResPct * HealthPCTDmg * (*itr)->GetMaxHealth());
                (*itr)->EnvironmentalDamage(DAMAGE_LAVA, Dmg);
            }

            timer = interval;
        }
        else
            timer -= diff;
        DespawnTimer -= diff;
        if (DespawnTimer <= 0)
            me->DespawnOrUnsummon();
    }
};

struct trigger_ExpoldeAI : public NullCreatureAI
{
    trigger_ExpoldeAI(Creature* creature) : NullCreatureAI(creature)
    {
        timer = 5000;
    }

    int32 timer;
    int32 Damage;

    void UpdateAI(uint32 diff) override
    {
        //we should never die
        me->SetHealth(me->GetMaxHealth());

        if (timer <= (int32)diff)
        {
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
            me->ClearUnitState(UNIT_STATE_UNATTACKABLE);
            me->ClearUnitState(UNIT_STATE_CANNOT_AUTOATTACK);
            me->ClearUnitState(UNIT_STATE_NOT_MOVE);

            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(8349);
            Spell* spell = new Spell(me, spellInfo, TRIGGERED_FULL_MASK);
            spell->m_targets.SetUnitTarget(me);
            spell->m_targets.SetSrc(me->GetPosition());
            spell->m_targets.SetDst(me->GetPosition());
            spell->SetSpellValue(SPELLVALUE_BASE_POINT0, Damage); // 3% - this will be scaled by difficulty scaler to up to 20% at this point
            spell->cast(true);
            me->DespawnOrUnsummon();
        }
        else
            timer -= diff;
    }
};
class TC_GAME_API RI_DS_OnCreatureDie : public PlayerScript
{
public:
    RI_DS_OnCreatureDie() : PlayerScript("RI_DS_OnCreatureDie") {}
    void OnCreatureKill(Player* killer, Creature* killed)
    {
        if (killed == NULL)
            return;
        Player *PlayerTarget = killed->ToPlayer();
        if (PlayerTarget == NULL)
            PlayerTarget = killed->GetCharmerOrOwnerPlayerOrPlayerItself();
        if (PlayerTarget != NULL)
            return; //do not scale pets

        if (CheckShouldTriggerCreatureScript(killer->GetMap(), RI_DS_MIN_DIFF_ANYSCRIPT, killed, killer) == false)
            return;

        if (CheckShouldTriggerCreatureScript(killed->GetMap(), RI_DS_TOXIC_POOL) == true && (rand32() % 100 < 50))
        {
            TempSummon* summon = killed->GetMap()->SummonCreature(15925, killed->GetPosition(), nullptr, 2 * 60 * 1000);
            if (summon)
            {
                summon->SetTempSummonType(TEMPSUMMON_TIMED_DESPAWN);
                summon->SetMaxHealth(666666);
                summon->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                summon->AddUnitState(UNIT_STATE_UNATTACKABLE);
                summon->AddUnitState(UNIT_STATE_CANNOT_AUTOATTACK);
                summon->AddUnitState(UNIT_STATE_NOT_MOVE);
                summon->SetFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FEIGN_DEATH);
                summon->SetObjectScale(3.0f);
                summon->SetLevel(MAX_LEVEL);
                CreatureAI *cai = new trigger_periodicToxicAI(summon);
                summon->SetAI(cai);
            }
        }
        else  if (CheckShouldTriggerCreatureScript(killed->GetMap(), RI_DS_LAVA_POOL) == true)
        {
            TempSummon* summon = killed->GetMap()->SummonCreature(15925, killed->GetPosition(), nullptr, 2 * 60 * 1000);
            if (summon)
            {
                summon->SetTempSummonType(TEMPSUMMON_TIMED_DESPAWN);
                summon->SetMaxHealth(666666);
                summon->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                summon->AddUnitState(UNIT_STATE_UNATTACKABLE);
                summon->AddUnitState(UNIT_STATE_CANNOT_AUTOATTACK);
                summon->AddUnitState(UNIT_STATE_NOT_MOVE);
                summon->SetDisplayId(4754);
                summon->SetLevel(MAX_LEVEL);
                summon->SetFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FEIGN_DEATH);
                summon->SetObjectScale(2.0f);
                CreatureAI *cai = new trigger_periodicLavaAI(summon);
                summon->SetAI(cai);
            }
        }

        if (CheckShouldTriggerCreatureScript(killed->GetMap(), RI_DS_EXPLODE) == true)
        {
            TempSummon* summon = killed->GetMap()->SummonCreature(15925, killed->GetPosition(), nullptr, 2 * 60 * 1000);
            if (summon)
            {
                summon->SetTempSummonType(TEMPSUMMON_TIMED_DESPAWN);
                summon->SetMaxHealth(666666);
                summon->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
                summon->AddUnitState(UNIT_STATE_UNATTACKABLE);
                summon->AddUnitState(UNIT_STATE_CANNOT_AUTOATTACK);
                summon->AddUnitState(UNIT_STATE_NOT_MOVE);
                summon->SetDisplayId(6888);
                summon->SetObjectScale(1.25f);
                summon->SetLevel(MAX_LEVEL);
                trigger_ExpoldeAI *cai = new trigger_ExpoldeAI(summon);
                cai->Damage = killer->GetMaxHealth() * 10 / 100;
                summon->SetAI(cai);
            }
        }

        if (CheckShouldTriggerCreatureScript(killed->GetMap(), RI_DS_REANIMATE) == true)
        {
            if (killed->ToTempSummon() == NULL && killed->IsDungeonBoss() == false && killed->IsCritter() == false && killed->GetCharmerGUID() == ObjectGuid::Empty && killed->GetCharm() == NULL)
            {
                TempSummon* summon = killed->GetMap()->SummonCreature(killed->GetEntry(), killed->GetPosition(), nullptr, 2 * 60 * 1000);
                if (summon)
                {
                    summon->SetTempSummonType(TEMPSUMMON_TIMED_DESPAWN);
                    summon->GetThreatManager().AddThreat(killer, 1);
                    //TriggerCallbackFunctions(CALLBACK_TYPE_CREATURE_SPAWN, &CP_CREATURE_SPAWN(summon, killed->GetMap()));
                }
            }
        }
    }
};


class TC_GAME_API RI_DS_PlayerScripts : public PlayerScript
{
public:
    RI_DS_PlayerScripts() : PlayerScript("RI_DS_PlayerScripts") {}
    void OnPlayerKilledByCreature(Creature* killer, Player* killed)
    {
        if (CheckShouldTriggerCreatureScript(killed->GetMap(), RI_DS_LOOSE_GOLD_ON_DEATH) == true)
        {
            killed->ModifyMoney(killed->GetMoney() / 2);
        }
    }
};

void RI_RegisterMapHandleScritps()
{
    //list of difficulties required for scripts to trigger
    RI_DS_REQUIRED_DIFF[RI_DS_MIN_DIFF_ANYSCRIPT] = 101;
    RI_DS_REQUIRED_DIFF[RI_DS_FROST_NOVA_ON_STRUCK] = 100;
    RI_DS_REQUIRED_DIFF[RI_DS_LIGHTNING_ON_STRUCK] = 200;
    RI_DS_REQUIRED_DIFF[RI_DS_CRIT_CHANCE] = 300;
    RI_DS_REQUIRED_DIFF[RI_DS_REFLECT_SPELLS] = 350;
    RI_DS_REQUIRED_DIFF[RI_DS_FIRE_RAIN_ON_STRUCK] = 400;
    RI_DS_REQUIRED_DIFF[RI_DS_ENGULFED_IN_FLAME] = 450;
    RI_DS_REQUIRED_DIFF[RI_DS_REANIMATE] = 500;
    RI_DS_REQUIRED_DIFF[RI_DS_LOOSE_GOLD_ON_DEATH] = 550;
    RI_DS_REQUIRED_DIFF[RI_DS_ELEMENTAL_DMG] = 550;
    RI_DS_REQUIRED_DIFF[RI_DS_EXPLODE] = 600;
    RI_DS_REQUIRED_DIFF[RI_DS_FALL_ASLEEP] = 650;
    RI_DS_REQUIRED_DIFF[RI_DS_REDUCED_DAMAGE_TAKEN] = 650;
    RI_DS_REQUIRED_DIFF[RI_DS_MOSTER_MOVE_SPEED] = 700;
    RI_DS_REQUIRED_DIFF[RI_DS_DECREASE_PLAYER_HEALTH_PERIODICALLY] = 750;
    RI_DS_REQUIRED_DIFF[RI_DS_RANDOM_MECHANIC_IMMUNITY] = 850;
    RI_DS_REQUIRED_DIFF[RI_DS_RANDOM_IMMUNITY] = 850;
    RI_DS_REQUIRED_DIFF[RI_DS_TOXIC_POOL] = 900;
    RI_DS_REQUIRED_DIFF[RI_DS_LINKED_HEALTH] = 950;    
    RI_DS_REQUIRED_DIFF[RI_DS_LAVA_POOL] = 1000;
    RI_DS_REQUIRED_DIFF[RI_DS_FIRE_CHAINS] = 1000;
    RI_DS_REQUIRED_DIFF[RI_DS_FRENZIED_REGENERATION] = 1000;
    //will call sub functions to handle difficulty scripts
    RegisterCallbackFunction(CALLBACK_TYPE_DMG_DONE, RI_OnHitTarget, NULL);
    RegisterCallbackFunction(CALLBACK_TYPE_DMG_RECEIVED, RI_OnDamageTaken, NULL);
    RegisterCallbackFunction(CALLBACK_TYPE_MAP_PERIODIC_UPDATE, RI_DS_MapUpdate, NULL);
    RegisterCallbackFunction(CALLBACK_TYPE_PLAYER_MAP_CHANGE, RI_DS_OnPlayerMapChange, NULL);
    RegisterCallbackFunction(CALLBACK_TYPE_CREATURE_SPAWN, RI_DS_OnMobSpawn, NULL);
    //used by toxic pools
    new RI_DS_OnCreatureDie();
    new RI_DS_PlayerScripts();
}
