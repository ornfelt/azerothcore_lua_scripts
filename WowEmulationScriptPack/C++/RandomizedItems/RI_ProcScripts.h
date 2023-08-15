#pragma once

class RI_StatStore;
class WorldObject;

//scripts that will handle proc based item randomizations. Ex : extra damage on dmg
typedef void(*RI_ProcFunc)(RI_StatStore *param);

struct RI_P_SpellModParams
{
    RI_P_SpellModParams()
    {
        FlatMod = 0;
        PctMod = 0.0f;
        Type = 0;
    }
    int FlatMod;
    float PctMod;
    char Type;
};

struct RI_WeaponDmgMod
{
    int Type;
    int Val;
};

struct RI_PeriodicTickParams
{
    RI_PeriodicTickParams()
    {
        NextTick = 0;
        TickInterval = 0;
        ModFlat = 0;
        ModPCT = 0.0f;
        Type = -1;
    }
    unsigned int NextTick;
    unsigned int TickInterval;
    int ModFlat;
    float ModPCT;
    char Type;
};

struct RI_P_DmgTakenDone
{
    RI_P_DmgTakenDone()
    {
        FlatMod = 0;
        PctMod = 0.0f;
        DamageTakenToDone = 0;
    }
    int FlatMod;
    float PctMod;
    int DamageTakenToDone;
};

struct RI_P_AutoCharge
{
    RI_P_AutoCharge();
    ObjectGuid PrevTarget;
    unsigned int NextTick;
    unsigned int TickInterval;
};

struct RI_P_CastOnMove
{
    RI_P_CastOnMove(WorldObject *);
    Position PrevPos;
    unsigned int PrevSpell;
    unsigned int NextTick;
    unsigned int TickInterval;
};

struct RI_P_CastOnJump
{
    RI_P_CastOnJump();
    unsigned int NextTick;
    unsigned int TickInterval;
};

struct RI_P_CastWhileCast
{
    RI_P_CastWhileCast();
    Unit *PrevTarget;
    unsigned int NextTick;
    unsigned int TickInterval;
};

struct RI_P_DamageTakenSmoothed
{
    RI_P_DamageTakenSmoothed();
    uint64 DamageSum;
    uint32 LastDmgStamp;
    uint32 DividePeriod;
    unsigned int NextTick;
    unsigned int TickInterval;
};

struct RI_P_CastOnStruck
{
    RI_P_CastOnStruck();
    uint32 SpellId;
    float ReflectPCT;
    unsigned int NextTick;
    unsigned int TickInterval;
};

struct RI_P_MinMaxDMG
{
    float Coef;
    char Flipper;
};

void RI_PS_DamageDoneTargetHPPCT(void *p, void *context);
void RI_PS_DamageDoneTargetHPMissingPCT(void *p, void *context);
void RI_PS_HealDoneTargetHPPCT(void *p, void *context);
void RI_PS_HealDoneTargetHPMissingPCT(void *p, void *context);
void RI_PS_SpellMod(void *p, void *context);
void RI_PS_SpellModNegative(void *p, void *context);
void RI_PS_DropChanceNoJunk(void *p, void *context);
void RI_PS_HealthRegenTick(void *p, void *context);
void RI_PS_PowerRegenTick(void *p, void *context);
void RI_PS_TargetPowerBurn(void *p, void *context);
void RI_PS_CastOnDamage(void *p, void *context);
void RI_PS_ManaPCTShield(void *p, void *context);
void RI_PS_ManaShield(void *p, void *context);
void RI_PS_LifeSteal(void *p, void *context);
void RI_PS_ManaToDamage(void *p, void *context);
void RI_PS_DamageToMana(void *p, void *context);
void RI_PS_CastOnDeadlyBlow(void *p, void *context);
void RI_PS_GoldRate(void *p, void *context);
void RI_PS_MinMaxDamage(void *p, void *context);
void RI_PS_ExplodeOnTargetDie(void *p, void *context);
void RI_PS_LightningOnStruck(void *p, void *context);
void RI_PS_DamageTakenAttackerCount(void *p, void *context);
void RI_PS_DamageTakenDamageDone_Taken(void *p, void *context);
void RI_PS_DamageTakenDamageDone_Done(void *p, void *context);
void RI_PS_DamageTakenRaidSize(void *p, void *context);
void RI_PS_DamageDoneRaidSize(void *p, void *context);
void RI_PS_DamageTakenFromGold(void *p, void *context);
void RI_PS_DamageTakenShareTank(void *p, void *context);
void RI_PS_DamageTakenShareCaster(void *p, void *context);
void RI_PS_ReduceCooldownPrevCast(void *p, void *context);
void RI_PS_DamageDoneLowHP(void *p, void *context);
void RI_PS_DamageEvadeLowHP(void *p, void *context);
void RI_PS_DamageAbsorbLowHP(void *p, void *context);
void RI_PS_DamageTakenMaxHP(void *p, void *context);
void RI_PS_OnHealDebuffTarget(void *p, void *context);
void RI_PS_CastOnDamageVictim(void *p, void *context);
void RI_PS_StormStrikeOnHeal(void *p, void *context);
void RI_PS_PotionCooldownOnDamageTaken(void *p, void *context);
void RI_PS_OverHealToDamage_Heal(void *p, void *context);
void RI_PS_OverHealToDamage_Damage(void *p, void *context);
void RI_PS_PartyMimic(void *p, void *context);
void RI_PS_HealthBasedHeal(void *p, void *context);
void RI_PS_MirrorCast(void *p, void *context);
void RI_PS_HealDmg_UniqueKill(void *p, void *context);
void RI_PS_HealDmg_UniqueItemUse(void *p, void *context);
void RI_PS_HealDmg_Achievements(void *p, void *context);
void RI_PS_HealDmg_Quests(void *p, void *context);
void RI_PS_HealDmg_HonorableKills(void *p, void *context);
void RI_PS_PetThreath(void *p, void *context);
void RI_PS_PetAura(void *p, void *context);
void RI_PS_HealDmg_LoginStreak(void *p, void *context);
void RI_PS_AutoChargeTargetSwap(void *p, void *context);
void RI_PS_HealAbsorbRecharge(void *p, void *context);
void RI_PS_TransmogDiscover(void *p, void *context);
void RI_PS_CastOnMove_Location(void *p, void *context);
void RI_PS_CastOnMove_RegisterSpell(void *p, void *context);
void RI_PS_CastOnMove_CastSpell(void *p, void *context);
void RI_PS_MeleeHasteToDMG(void *p, void *context);
void RI_PS_RangedHasteToDMG(void *p, void *context);
void RI_PS_SpellHasteToDMG(void *p, void *context);
void RI_PS_SpellModSpellTarget(void *p, void *context);
//void RI_PS_ChangeDmgType(void *p, void *context);
void RI_PS_SlamOnJump(void *p, void *context);
void RI_PS_ElectrocuteWhileCast(void *p, void *context);
void RI_PS_TransformLook(void *p, void *context);
void RI_PS_DistanceHealBoost(void *p, void *context);
void RI_PS_BloodLustOnDamageTaken(void *p, void *context);
void RI_PS_MoveExpode(void *p, void *context);
void RI_PS_SpellModSpellRange(void *p, void *context);
void RI_PS_AuraMaxStacks(void *p, void *context);
void RI_PS_ArmorToResistance(void *p, void *context);
void RI_PS_HealNearbyPlayer(void *p, void *context);
void RI_PS_KillStreakIncrease(void *p, void *context);
void RI_PS_KillStreakDmgAdd(void *p, void *context);
void RI_PS_LowHealthHealStreak(void *p, void *context);
void RI_PS_SimilarDamageTaken(void *p, void *context);
void RI_PS_DamageTakenSplitOverTime_SumDmg(void *p, void *context);
void RI_PS_DamageTakenSplitOverTime_DealDmg(void *p, void *context);
void RI_PS_CastOnKill(void *p, void *context);
void RI_PS_ExtraDmgWhileBehindTarget_Flat(void *p, void *context);
void RI_PS_ExtraDmgReduceWhileInFrontTarget_Flat(void *p, void *context);
void RI_PS_HealsRestoreDamageTaken_Dmg(void *p, void *context);
void RI_PS_HealsRestoreDamageTaken_Heal(void *p, void *context);
void RI_PS_SingleTargetToAOE(void *p, void *context);
//void RI_PS_XPGain(void *p, void *context);
void RI_PS_CastOnHit(void *p, void *context);
void RI_PS_DiabloCastFireBreath(void *p, void *context);
void RI_PS_HealthToDamage(void *p, void *context);
void RI_PS_PowerMissingToDMGPCT(void *p, void *context);
void RI_PS_DamageDonePCT(void *p, void *context);
