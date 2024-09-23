#include "RI_ProcScripts.h"
#include "Player.h"
#include "Item.h"
#include "RI_ItemStore.h"
#include "GameTime.h"
#include "Random.h"
#include "Spell.h"
#include "SpellMgr.h"
#include "ObjectExtension.cpp"
#include "Map.h"
#include "Group.h"
#include "SpellHistory.h"
#include "SpellInfo.h"
#include "ObjectMgr.h"
#include "Creature.h"
#include "SpellAuras.h"
#include "LoginStreakCounter/LoginStreakCounter.h"
#include "SpellAuraEffects.h"
#include "Transmog/Transmog.h"
#include "WorldSession.h"
#include "GridNotifiers.h"
#include "CellImpl.h"
#include "Unit.h"
#include "DPSAndHealHighScores/DPSAndHealHighScores.h"

RI_P_AutoCharge::RI_P_AutoCharge()
{
    PrevTarget.Clear();
    TickInterval = 30000;
    NextTick = GameTime::GetGameTimeMS() + TickInterval;
}

RI_P_CastOnMove::RI_P_CastOnMove(WorldObject *owner)
{
    PrevPos = owner->GetPosition();
    TickInterval = 3000;
    NextTick = GameTime::GetGameTimeMS() + TickInterval;
    PrevSpell = 0;
}

RI_P_CastOnJump::RI_P_CastOnJump()
{
    TickInterval = 1000;
    NextTick = GameTime::GetGameTimeMS() + TickInterval;
}

RI_P_CastWhileCast::RI_P_CastWhileCast()
{
    PrevTarget = NULL;
    TickInterval = 300;
    NextTick = GameTime::GetGameTimeMS() + TickInterval;
}

RI_P_DamageTakenSmoothed::RI_P_DamageTakenSmoothed()
{
    DamageSum = 0;
    LastDmgStamp = GameTime::GetGameTimeMS();
    TickInterval = 1000;
    NextTick = GameTime::GetGameTimeMS() + TickInterval;
}

RI_P_CastOnStruck::RI_P_CastOnStruck()
{
    TickInterval = 1000;
    NextTick = GameTime::GetGameTimeMS() + TickInterval;
}

void RI_PS_DamageDoneTargetHPPCT(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    uint32 VictimHealth = params->Victim->GetHealth();
    float *CreateParam = (float*)context;
    uint32 ExtraDmg = (uint32)(VictimHealth * (*CreateParam));
    if (params->TickCount > 1)
        ExtraDmg = ExtraDmg / params->TickCount; //this is tickcount
    params->FlatMods += ExtraDmg;
}

void RI_PS_DamageDoneTargetHPMissingPCT(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    uint32 VictimHealth = params->Victim->GetMaxHealth() - params->Victim->GetHealth();
    float *CreateParam = (float*)context;
    uint32 ExtraDmg = (uint32)(VictimHealth * (*CreateParam));
    if (params->TickCount > 1)
        ExtraDmg = ExtraDmg / params->TickCount; //this is tickcount
    params->FlatMods += ExtraDmg;
}

void RI_PS_HealDoneTargetHPPCT(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    uint32 VictimHealth = params->Victim->GetHealth();
    float *CreateParam = (float*)context;
    uint32 ExtraDmg = (uint32)(VictimHealth * (*CreateParam));

    if (params->TickCount > 1)
        ExtraDmg = ExtraDmg / params->TickCount; //this is tickcount

    params->FlatMods += ExtraDmg;
}

void RI_PS_HealDoneTargetHPMissingPCT(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    uint32 VictimHealth = params->Victim->GetMaxHealth() - params->Victim->GetHealth();
    float *CreateParam = (float*)context;
    uint32 ExtraDmg = (uint32)(VictimHealth * (*CreateParam));
    params->FlatMods += ExtraDmg;
}

void RI_PS_SpellMod(void *p, void *context)
{
    CP_SPELL_MOD_APPLY *params = PointerCast(CP_SPELL_MOD_APPLY, p);
    RI_P_SpellModParams *Mod = (RI_P_SpellModParams*)context;
    if (Mod->Type == SPELLMOD_DAMAGE)
    {
        uint32 Effect, Aura;
        if (params->ModType == SPELLMOD_EFFECT1)
        {
            Effect = params->SpellInf->Effects[0].Effect;
            Aura = params->SpellInf->Effects[0].ApplyAuraName;
        }
        else if (params->ModType == SPELLMOD_EFFECT2)
        {
            Effect = params->SpellInf->Effects[1].Effect;
            Aura = params->SpellInf->Effects[1].ApplyAuraName;
        }
        else if (params->ModType == SPELLMOD_EFFECT3)
        {
            Effect = params->SpellInf->Effects[2].Effect;
            Aura = params->SpellInf->Effects[2].ApplyAuraName;
        }
        else
            return;
        if (Effect != SPELL_EFFECT_SCHOOL_DAMAGE && Aura != SPELL_AURA_PERIODIC_DAMAGE)
            return; // we only mod SPELL damage effects
    }
    else if (Mod->Type != params->ModType)
        return;
    *params->ModFlat += Mod->FlatMod;
    *params->ModPCT += Mod->PctMod;
}

void RI_PS_SpellModNegative(void *p, void *context)
{
    CP_SPELL_MOD_APPLY *params = PointerCast(CP_SPELL_MOD_APPLY, p);
    RI_P_SpellModParams *Mod = (RI_P_SpellModParams*)context;
    if (Mod->Type != params->ModType)
        return;
    *params->ModFlat -= Mod->FlatMod;
    *params->ModPCT -= Mod->PctMod;
    // avoid values going into negative
    if (-(*params->ModFlat) > params->Base)
        *params->ModFlat = -params->Base;
    if (*params->ModPCT < 0.0f)
        *params->ModPCT = 0;
}

void RI_PS_DropChanceNoJunk(void *p, void *context)
{
    CP_LOOT_ROLL_CHANCE *params = PointerCast(CP_LOOT_ROLL_CHANCE, p);
    float *RollChanceMod = (float*)context;

    if (params->Item == NULL)
        return;

    if (params->Item->InventoryType == INVTYPE_NON_EQUIP)
    {
        *params->chance -= *RollChanceMod;
        if (*params->chance < 0.0f)
            *params->chance = 0.0f;
    }
    else
    {
        *params->chance += *RollChanceMod;
        if (*params->chance > 100.0f)
            *params->chance = 100.0f;
    }
}
/*
void RI_PS_WeaponDmgCalc(void *p, void *context)
{
    CP_WEAPON_DMG_CALC *params = PointerCast(CP_WEAPON_DMG_CALC, p);
    RI_WeaponDmgMod *dm = (RI_WeaponDmgMod*)context;
    int NeededType = -1;
    int MinDmg = 0;
    int MaxDmg = 0;
    if (dm->Type == RI_EXTRA_MIN_WEAPON_MAINHAND_DMG)
    {
        NeededType = WeaponAttackType::BASE_ATTACK;
        MinDmg = dm->Val;
    }
    else if (dm->Type == RI_EXTRA_MAX_WEAPON_MAINHAND_DMG)
    {
        NeededType = WeaponAttackType::BASE_ATTACK;
        MaxDmg = dm->Val;
    }
    else if (dm->Type == RI_EXTRA_MIN_WEAPON_OFFHAND_DMG)
    {
        NeededType = WeaponAttackType::OFF_ATTACK;
        MinDmg = dm->Val;
    }
    else if (dm->Type == RI_EXTRA_MAX_WEAPON_OFFHAND_DMG)
    {
        NeededType = WeaponAttackType::OFF_ATTACK;
        MaxDmg = dm->Val;
    }
    else if (dm->Type == RI_EXTRA_MIN_WEAPON_RANGED_DMG)
    {
        NeededType = WeaponAttackType::RANGED_ATTACK;
        MinDmg = dm->Val;
    }
    else if (dm->Type == RI_EXTRA_MAX_WEAPON_RANGED_DMG)
    {
        NeededType = WeaponAttackType::RANGED_ATTACK;
        MaxDmg = dm->Val;
    }

    if (params->AtkType != NeededType)
        return;

    *params->MinDmg += MinDmg;
    *params->MaxDmg += MaxDmg;
}*/

void RI_PS_HealthRegenTick(void *p, void *context)
{
    Player *Owner = (Player*)p;
    RI_PeriodicTickParams *param = (RI_PeriodicTickParams*)context;
    if (param->NextTick > GameTime::GetGameTimeMS())
        return;
    param->NextTick = GameTime::GetGameTimeMS() + param->TickInterval;
    //onyl regen for allive players
    if (Owner->IsAlive() == false)
        return;
    int32 FlatAdd = param->ModFlat;
    float PCTAdd;
    if (param->Type == RI_HEALTH_REGEN_ALWAYS_PCT)
        PCTAdd = Owner->GetMaxHealth() * param->ModPCT;
    if (param->Type == RI_HEALTH_REGEN_MISSING_PCT)
        PCTAdd = (Owner->GetMaxHealth() - Owner->GetHealth()) * param->ModPCT;
    if (param->Type == RI_HEALTH_REGEN_EXISTING_PCT)
        PCTAdd = Owner->GetHealth() * param->ModPCT;
    else
        PCTAdd = 0.0f;
    Owner->ModifyHealth(FlatAdd + (int32)PCTAdd);
}

void RI_PS_PowerRegenTick(void *p, void *context)
{
    Player *Owner = (Player*)p;
    RI_PeriodicTickParams *param = (RI_PeriodicTickParams*)context;
    if (param->NextTick > GameTime::GetGameTimeMS())
        return;
    param->NextTick = GameTime::GetGameTimeMS() + param->TickInterval;
    //onyl regen for allive players
    if (Owner->IsAlive() == false)
        return;
    int32 PCTAdd = int32(Owner->GetMaxPower(Owner->GetPowerType()) * param->ModPCT);
    Owner->ModifyPower(Owner->GetPowerType(),(int32)PCTAdd);
}

void RI_PS_TargetPowerBurn(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    RI_P_SpellModParams *BurParams = (RI_P_SpellModParams*)context;
    int32 VictimMana = params->Victim->GetPower(POWER_MANA);
    if (VictimMana == 0)
        return;
    if (VictimMana > 100000)
        VictimMana = 100000;
    int32 ExtraDmg = int32(BurParams->FlatMod + VictimMana * BurParams->PctMod);
    if (params->TickCount > 1)
        ExtraDmg = ExtraDmg / params->TickCount; //this is tickcount
    if (ExtraDmg > VictimMana)
        ExtraDmg = VictimMana;

    params->Victim->ModifyPower(POWER_MANA, -ExtraDmg);
    params->FlatMods += ExtraDmg * 10;
}

void RI_PS_CastOnDamage(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;


    RI_PeriodicTickParams *param = (RI_PeriodicTickParams*)context;
    if (param->NextTick > GameTime::GetGameTimeMS())
        return;
    param->NextTick = GameTime::GetGameTimeMS() + param->TickInterval;

    params->Attacker->CastSpell(params->Victim, param->ModFlat, TRIGGERED_FULL_MASK);
}

void RI_PS_ManaPCTShield(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;


    RI_P_SpellModParams *BurParams = (RI_P_SpellModParams*)context;
    int32 OwnerMana = params->Victim->GetPower(POWER_MANA);
    if (OwnerMana == 0)
        return;
    int32 OwnerManaReserved = params->Victim->GetMaxPower(POWER_MANA) / 2;
    int32 ManaCanConsume = OwnerMana - OwnerManaReserved;
    if (ManaCanConsume <= 0)
        return;
    if (BurParams->PctMod > 1.0f)
        BurParams->PctMod = 1.0f;
    int32 DamageCanAbsorb = (int32)(params->OriDamage * BurParams->PctMod);
    int32 ManaCouldBurn = DamageCanAbsorb;
    if (ManaCouldBurn > ManaCanConsume)
    {
        ManaCouldBurn = ManaCanConsume;
        DamageCanAbsorb = (int32)(ManaCanConsume * BurParams->PctMod);
    }

    params->Victim->ModifyPower(POWER_MANA, -ManaCouldBurn);
    params->FlatMods -= DamageCanAbsorb;
}

void RI_PS_ManaShield(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;


    RI_P_SpellModParams *BurParams = (RI_P_SpellModParams*)context;
    int32 OwnerMana = params->Victim->GetPower(POWER_MANA);
    if (OwnerMana == 0)
        return;
    int32 OwnerManaReserved = params->Victim->GetMaxPower(POWER_MANA) / 2;
    int32 ManaCanConsume = OwnerMana - OwnerManaReserved;
    if (ManaCanConsume <= 0)
        return;
    int32 DamageManaCost = (int32)(params->OriDamage / BurParams->PctMod);
    int32 DamageCanAbsorb = params->OriDamage;
    if (DamageManaCost > ManaCanConsume)
    {
        DamageManaCost = ManaCanConsume;
        DamageCanAbsorb = (int32)(ManaCanConsume * BurParams->PctMod);
    }

    params->Victim->ModifyPower(POWER_MANA, -DamageManaCost);
    params->FlatMods -= DamageCanAbsorb;
}

void RI_PS_LifeSteal(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    RI_P_SpellModParams *BurParams = (RI_P_SpellModParams*)context;
    int32 LifeGain = BurParams->FlatMod;
    if (params->TickCount > 1)
        LifeGain = LifeGain / params->TickCount; //this is tickcount
    LifeGain += int32((params->OriDamage) * BurParams->PctMod);
    if (LifeGain > (int32)(params->OriDamage))
        LifeGain = (int32)(params->OriDamage);

    params->Attacker->ModifyHealth(LifeGain);
}

void RI_PS_ManaToDamage(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;


    RI_P_SpellModParams *BurParams = (RI_P_SpellModParams*)context;
    int32 OwnerMana = params->Attacker->GetPower(POWER_MANA);
    if (OwnerMana == 0)
        return;
//    int32 ManaToBurn = int32(BurParams->FlatMod + OwnerMana * BurParams->PctMod);
    int32 ManaToBurn = BurParams->FlatMod;
    if (params->TickCount > 1)
        ManaToBurn = ManaToBurn / params->TickCount; //this is tickcount
    if (ManaToBurn > OwnerMana)
        ManaToBurn = OwnerMana;

    params->Attacker->ModifyPower(POWER_MANA, -ManaToBurn);
    params->FlatMods += ManaToBurn; // coeff should be related to mana regen. we aim to have around 50k DPS with it
}

void RI_PS_DamageToMana(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;


    RI_P_SpellModParams *BurParams = (RI_P_SpellModParams*)context;
    int32 OwnerMana = params->Victim->GetPower(POWER_MANA);
    if (OwnerMana == 0)
        return;
    int32 ManaToGain = int32(BurParams->FlatMod + params->OriDamage * BurParams->PctMod);
    if (ManaToGain > (int32)params->OriDamage)
        ManaToGain = (int32)params->OriDamage;

    params->Victim->ModifyPower(POWER_MANA, ManaToGain);
}

void RI_PS_GoldRate(void *p, void *context)
{
    CP_INT32_PARAM *params = PointerCast(CP_INT32_PARAM, p);
    float *Coeff = (float*)context;

    *params->Value += (int32)((*params->Value * (*Coeff)));
    //avoid overflows
    if (*params->Value < 0)
        *params->Value = 0;
}

void RI_PS_CastOnDeadlyBlow(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;


    //no need to trigger it
    if (params->Victim->GetHealth() > params->GetDamage())
        return;

    //do not spam trigger it
    RI_PeriodicTickParams *param = (RI_PeriodicTickParams*)context;
    if (param->NextTick > GameTime::GetGameTimeMS())
        return;
    param->NextTick = GameTime::GetGameTimeMS() + param->TickInterval;

    //cancel damage
    params->ForceDamageAbsorb();
    //cast cloak
    params->Victim->CastSpell(params->Victim, param->ModFlat, TRIGGERED_FULL_MASK);
    params->Victim->CombatStop();
    params->Victim->GetThreatManager().ClearAllThreat();
}

void RI_PS_MinMaxDamage(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;


    RI_P_MinMaxDMG *MinMaxCoef = (RI_P_MinMaxDMG*)context;

    //reduce dmg ?
    MinMaxCoef->Flipper++;
    if ((MinMaxCoef->Flipper & 2) == 0)
    {
        int32 reduction = (int32)((params->OriDamage) * (MinMaxCoef->Coef));
        params->FlatMods -= reduction;
    }
    else
    {
        uint32 increase = (uint32)((params->OriDamage) * (MinMaxCoef->Coef));
        params->FlatMods += increase;
    }
}

void RI_PS_ExplodeOnTargetDie(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;


    //no need to trigger it
    if (params->Victim->GetHealth() > params->GetDamage())
        return;

    //cast spell
    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(8349);
    Spell* spell = new Spell(params->Attacker, spellInfo, TRIGGERED_FULL_MASK);
    spell->m_targets.SetUnitTarget(params->Victim);
    spell->m_targets.SetSrc(params->Attacker->GetPosition());
    spell->m_targets.SetDst(params->Victim->GetPosition());
    spell->SetSpellValue(SPELLVALUE_BASE_POINT0, params->Victim->GetMaxHealth() * 5 / 100);
    spell->cast(true);
}

void RI_PS_LightningOnStruck(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;
    RI_P_CastOnStruck *Params = (RI_P_CastOnStruck*)context;

    uint32 DamageToBeDelt = 1 + (uint32)(params->OriDamage * Params->ReflectPCT);
    uint32 *ChainLightningStackedDamage = params->Victim->GetCreateExtension<uint32>(OE_CHAIN_LIGHTNING_PPM_DAMAGE,0);
    if (Params->NextTick > GameTime::GetGameTimeMS())
    {
        ChainLightningStackedDamage[0] += DamageToBeDelt;
        return;
    }
    Params->NextTick = GameTime::GetGameTimeMS() + Params->TickInterval;
    DamageToBeDelt += ChainLightningStackedDamage[0];
    ChainLightningStackedDamage[0] = 0;

    //cast spell chain lightning
    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(Params->SpellId);
    Spell* spell = new Spell(params->Victim, spellInfo, TRIGGERED_FULL_MASK);
    spell->m_targets.SetUnitTarget(params->Attacker);
    spell->m_targets.SetSrc(params->Attacker->GetPosition());
    spell->m_targets.SetDst(params->Attacker->GetPosition());
//    spell->SetSpellValue(SPELLVALUE_BASE_POINT0, int32(params->Attacker->GetMaxHealth() * 0.005f) + 1); //0.5% max health that jumps 3 times
    spell->SetSpellValue(SPELLVALUE_BASE_POINT0, int32(DamageToBeDelt));
    spell->cast(true);
}

void RI_PS_DamageTakenAttackerCount(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;


    //cancel part of the damage
    size_t AttackerCount = params->Victim->GetThreatManager().GetThreatListSize();
    int32 DmgReduction = *(int32*)context;
    DmgReduction = DmgReduction * (int32)AttackerCount;
    if (DmgReduction > (int32)params->OriDamage)
        params->FlatMods -= DmgReduction;
}

void RI_PS_DamageTakenDamageDone_Taken(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    RI_P_DmgTakenDone *Param = (RI_P_DmgTakenDone *)context;
    if (Param->FlatMod > 0)
    {
        if (params->OriDamage > Param->FlatMod)
            Param->DamageTakenToDone += Param->FlatMod;
        else
            Param->DamageTakenToDone += params->OriDamage;
    }
    Param->DamageTakenToDone += int32(params->OriDamage * Param->PctMod);
}

void RI_PS_DamageTakenDamageDone_Done(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    RI_P_DmgTakenDone *Param = (RI_P_DmgTakenDone *)context;
    params->FlatMods += Param->DamageTakenToDone * 10;
    Param->DamageTakenToDone = 0;
}

void RI_PS_DamageTakenRaidSize(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    if (params->Attacker->GetMap() == NULL || params->Attacker->GetMap()->GetExtension<int64>(OE_MAP_MOB_DIFFICULTY_SCALER) == NULL)
        return;
    int64 *diff = params->Attacker->GetMap()->GetExtension<int64>(OE_MAP_MOB_DIFFICULTY_SCALER);
    if (*diff <= 100)
        return;

    if (params->Attacker->GetMap()->IsDungeon() == false)
        return;
    if (params->Attacker->ToPlayer() == NULL)
        return;
    if (params->Attacker->ToPlayer()->GetGroup() == NULL)
        return;
    //    int32 PlayerCount = params->Attacker->GetMap()->GetPlayersCountExceptGMs();
    int32 PlayerCount = params->Attacker->ToPlayer()->GetGroup()->GetMembersCount();

    RI_P_SpellModParams *Param = (RI_P_SpellModParams *)context;
    params->FlatMods -= int32((params->GetDamage() * Param->PctMod + Param->FlatMod) * PlayerCount);
}

void RI_PS_DamageDoneRaidSize(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    if (params->Attacker->GetMap()->IsDungeon() == false)
        return;
    if (params->Attacker->ToPlayer() == NULL)
        return;
    if (params->Attacker->ToPlayer()->GetGroup() == NULL)
        return;
//    int32 PlayerCount = params->Attacker->GetMap()->GetPlayersCountExceptGMs();
    int32 PlayerCount = params->Attacker->ToPlayer()->GetGroup()->GetMembersCount();

    RI_P_SpellModParams *Param = (RI_P_SpellModParams *)context;
    int32 ExtraDmg = Param->FlatMod * PlayerCount;
    if (params->TickCount > 1)
        ExtraDmg = ExtraDmg / params->TickCount; //this is tickcount
    ExtraDmg += int32(params->OriDamage * Param->PctMod * PlayerCount);
    params->FlatMods += ExtraDmg;
}

void RI_PS_DamageTakenFromGold(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    Player *pVictim = params->Victim->ToPlayer();
    if (pVictim == NULL)
        return;

    int32 *Param = (int32 *)context;
    if (pVictim->GetMoney() > 1000)
    {
        pVictim->ModifyMoney(-1000);
        params->FlatMods -= *Param;
    }
}

#ifndef MIN
    #define MIN(a,b) ((a)>(b))?(b):(a)
#endif
#ifndef MAX
    #define MAX(a,b) ((a)>(b))?(a):(b)
#endif

void RI_PS_DamageTakenShareTank(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;
    Player *pVictim = params->Victim->ToPlayer();
    if (pVictim == NULL)
        return; //impossible case
    if (pVictim->GetGroup() == NULL)
        return;
    const float Radius = 15.0f;
    uint32 TankCount = 0;//get a list of nearby group tanks
    std::list<Player *> NearbyPlayers;
    for (GroupReference* itr = pVictim->GetGroup()->GetFirstMember(); itr != nullptr; itr = itr->next())
    {
        Player* Target = itr->GetSource();
        if (Target && Target->IsAlive() && Target != pVictim && pVictim->IsWithinDistInMap(Target, Radius))
        {
            if (Target->getClass() == CLASS_WARRIOR || Target->getClass() == CLASS_PALADIN || Target->getClass() == CLASS_DEATH_KNIGHT || Target->getClass() == CLASS_DRUID)
            {
                NearbyPlayers.push_back(Target);
                TankCount++;
            }
        }
    }
    if (TankCount == 0)
        return;
    int32 DamageToShareOri = params->GetDamage();
    RI_P_SpellModParams *Mod = (RI_P_SpellModParams*)context;
    int32 DamageToShare = MIN(DamageToShareOri, Mod->FlatMod) + (int32)(DamageToShareOri * Mod->PctMod);
    if (DamageToShare > (int32)params->GetDamage())
        DamageToShare = params->GetDamage();
    
    int32 DmgShare = DamageToShare / ( TankCount + 1 );
    //distribute dmg
    for (std::list<Player *>::iterator itr = NearbyPlayers.begin(); itr != NearbyPlayers.end(); itr++)
        if((int32)(*itr)->GetHealth() > DmgShare)
            (*itr)->ModifyHealth(-DmgShare);
    params->FlatMods -= DmgShare * TankCount;
}

void RI_PS_DamageTakenShareCaster(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;
    Player *pVictim = params->Victim->ToPlayer();
    if (pVictim == NULL)
        return; //impossible case
    if (pVictim->GetGroup() == NULL)
        return;
    const float Radius = 15.0f;
    uint32 TankCount = 0;//get a list of nearby group tanks
    std::list<Player *> NearbyPlayers;
    for (GroupReference* itr = pVictim->GetGroup()->GetFirstMember(); itr != nullptr; itr = itr->next())
    {
        Player* Target = itr->GetSource();
        if (Target && Target->IsAlive() && Target != pVictim && pVictim->IsWithinDistInMap(Target, Radius))
        {
            if (Target->getClass() == CLASS_PALADIN || Target->getClass() == CLASS_PRIEST || Target->getClass() == CLASS_SHAMAN || Target->getClass() == CLASS_MAGE || Target->getClass() == CLASS_WARLOCK || Target->getClass() == CLASS_DRUID)
            {
                NearbyPlayers.push_back(Target);
                TankCount++;
            }
        }
    }
    if (TankCount == 0)
        return;

    int32 DamageToShareOri = params->GetDamage();
    RI_P_SpellModParams *Mod = (RI_P_SpellModParams*)context;
    int32 DamageToShare = MIN(DamageToShareOri, Mod->FlatMod) + (int32)(DamageToShareOri * Mod->PctMod);
    if (DamageToShare > (int32)params->GetDamage())
        DamageToShare = params->GetDamage();

    int32 DmgShare = DamageToShare / (TankCount + 1);
    //distribute dmg
    for (std::list<Player *>::iterator itr = NearbyPlayers.begin(); itr != NearbyPlayers.end(); itr++)
        if ((int32)(*itr)->GetHealth() > DmgShare)
            (*itr)->ModifyHealth(-DmgShare);
    params->FlatMods -= DmgShare * TankCount;
}

void RI_PS_ReduceCooldownPrevCast(void *p, void *context)
{
    CP_SPELL_CAST *params = PointerCast(CP_SPELL_CAST, p);
    if (params->TargetCount > 1)
        return;
    int32 *pSpellId = (int32*)context;
    if (pSpellId[0] <= 0)
    {
        pSpellId[0] = params->SpellInf->Id;
        return;
    }
    if (pSpellId[0] != params->SpellInf->Id)
    {
        pSpellId[1] = pSpellId[0];
        pSpellId[0] = params->SpellInf->Id;
    }
    if(pSpellId[1]>0)
        params->p->GetSpellHistory()->ModifyCooldown(pSpellId[1], -2000);
}

void RI_PS_DamageDoneLowHP(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    if (params->Attacker->GetHealthPct() > 20)
        return;
    RI_P_SpellModParams *Param = (RI_P_SpellModParams *)context;
    int32 ExtraDmg = Param->FlatMod;
    if (params->TickCount > 1)
        ExtraDmg = ExtraDmg / params->TickCount; //this is tickcount
    params->FlatMods += int32(params->OriDamage * Param->PctMod + ExtraDmg);
}

void RI_PS_DamageEvadeLowHP(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    if (params->Victim->GetHealthPct() > 20)
        return;

    int32 *Param = (int32 *)context;
    if (rand32() <= (uint32)Param[0])
        params->ForceDamageAbsorb();
}

void RI_PS_DamageAbsorbLowHP(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    if (params->Victim->GetHealthPct() > 20)
        return;

    float *Param = (float *)context;
    params->FlatMods -= int32(params->GetDamage() * Param[0]);
}

void RI_PS_DamageTakenMaxHP(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    float *Param = (float *)context;
    float AllowedDmg = params->Victim->GetMaxHealth() * Param[0];
    if ( params->GetDamage() > AllowedDmg)
        params->FlatMods -= int32(params->GetDamage() - AllowedDmg);
}

void RI_PS_OnHealDebuffTarget(void *p, void *context)
{
    CP_SPELL_CAST *params = PointerCast(CP_SPELL_CAST, p);
    if (params->TargetCount > 1)
        return;
    if ((params->procSpellType & PROC_SPELL_TYPE_HEAL) == 0)
        return;
    int32 *pSpellId = (int32*)context;
    params->p->CastSpell(params->target, 4987, TRIGGERED_FULL_MASK); //cleanse - Cleanses a friendly target, removing $s1 poison effect, $s2 disease effect, and $s3 magic effect.
    params->p->CastSpell(params->target, 475, TRIGGERED_FULL_MASK); //remove curse - Removes $m1 Curse from a friendly target.
}

void RI_PS_StormStrikeOnHeal(void *p, void *context)
{
    CP_SPELL_CAST *params = PointerCast(CP_SPELL_CAST, p);
    if (params->TargetCount > 1)
        return;
    if ((params->procSpellType & PROC_SPELL_TYPE_HEAL) == 0)
        return;
    int32 *pSpellId = (int32*)context;
    Player *pt = params->target->ToPlayer();
    if (pt == NULL)
        return;
    if (pt->IsInCombat() == false)
        return;
    WorldObject *targettaget = (WorldObject *)pt->GetMap()->GetCreature( pt->GetTarget() );
    if(targettaget == NULL)
        targettaget = pt->GetMap()->GetPlayer(pt->GetTarget());
    if(targettaget != NULL )
        params->target->CastSpell(targettaget, 65971, TRIGGERED_FULL_MASK); //stormstrike - Instantly attack with both weapons.  In addition, Nature damage dealt to is target are increased by $17364s1%.  Lasts $17364d.
}

void RI_PS_CastOnDamageVictim(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    //do not spam trigger it
    RI_PeriodicTickParams *param = (RI_PeriodicTickParams*)context;
    if (param->NextTick > GameTime::GetGameTimeMS())
        return;
    param->NextTick = GameTime::GetGameTimeMS() + param->TickInterval;
    //cast
    params->Victim->CastSpell(params->Attacker, param->ModFlat, TRIGGERED_FULL_MASK);
}

void RI_PS_PotionCooldownOnDamageTaken(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    Player *pv = params->Victim->ToPlayer();
    if (pv == NULL)
        return; // should never happen
    uint32 PID = pv->GetLastPotionId();
    if (PID == 0)
        return;
    if (ItemTemplate const* proto = sObjectMgr->GetItemTemplate(PID))
        for (uint8 idx = 0; idx < MAX_ITEM_PROTO_SPELLS; ++idx)
            if (proto->Spells[idx].SpellId && proto->Spells[idx].SpellTrigger == ITEM_SPELLTRIGGER_ON_USE)
            {
                if (SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(proto->Spells[idx].SpellId))
                {
                    pv->GetSpellHistory()->SendCooldownEvent(spellInfo, PID);
                    pv->GetSpellHistory()->ResetCooldown(proto->Spells[idx].SpellId, true);
                    pv->SetLastPotionId(0);
                }
            }
}

void RI_PS_OverHealToDamage_Heal(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    RI_P_DmgTakenDone *param = (RI_P_DmgTakenDone*)context;
    int HealthMissing = params->Victim->GetMaxHealth() - params->Victim->GetHealth();
    int OverHealAmount = params->GetDamage() - HealthMissing;
    if (OverHealAmount < 0)
        return; //not an overheal
    OverHealAmount = (int)(OverHealAmount * param->PctMod);
    //avoid bogous values
    param->FlatMod = MAX(param->FlatMod,OverHealAmount);
    if (param->FlatMod > (int)params->Victim->GetMaxHealth())
        param->FlatMod = (int)params->Victim->GetMaxHealth();
}

void RI_PS_OverHealToDamage_Damage(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    RI_P_DmgTakenDone *param = (RI_P_DmgTakenDone*)context;
    params->FlatMods += param->FlatMod;
    param->FlatMod = 0;
}

void RI_PS_PartyMimic(void *p, void *context)
{
    CP_SPELL_CAST *params = PointerCast(CP_SPELL_CAST, p);
    if (params->TargetCount > 1)
        return;
    if (params->p->GetGroup() == NULL)
        return;
    if (params->SpellInf->IsPassive())
        return;
    if (((Spell*)params->CastedSpell)->IsTriggered())
        return;
    bool HasAuraEffect = false;
    for (int i = 0; i < MAX_SPELL_EFFECTS; i++)
    {
        if (params->SpellInf->Effects[i].TargetA.GetTarget() > 0 && params->SpellInf->Effects[i].TargetA.GetTarget() != TARGET_UNIT_CASTER)
            return;
        if (params->SpellInf->Effects[i].TargetB.GetTarget() > 0 && params->SpellInf->Effects[i].TargetB.GetTarget() != TARGET_UNIT_CASTER)
            return;
        //check if any of the effects is an aura
        if (params->SpellInf->Effects[i].Effect == SPELL_EFFECT_APPLY_AURA)
            HasAuraEffect = true;
    }
    if (HasAuraEffect == false)
        return;

    //force the nearby party members to cast the same spell
    for (GroupReference* itr = params->p->GetGroup()->GetFirstMember(); itr != nullptr; itr = itr->next())
    {
        Player* member = itr->GetSource();
        if (member && member != params->p && member->IsInMap(params->p) && member->IsWithinDist(params->p, member->GetSightRange(), false))
            member->CastSpell(member, params->SpellInf->Id, TRIGGERED_FULL_MASK);
    }
}

void RI_PS_HealthBasedHeal(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    float *param = (float*)context;
    float AddedHeal = (params->Attacker->GetHealth() * param[0]);
    if (params->TickCount > 1)
        AddedHeal = AddedHeal / params->TickCount; //this is tickcount
    params->FlatMods += (int32)AddedHeal;
}

void RI_PS_MirrorCast(void *p, void *context)
{
    CP_SPELL_CAST *params = PointerCast(CP_SPELL_CAST, p);
    if (params->SpellInf->IsPassive())
        return;
    if (((Spell*)params->CastedSpell)->IsTriggered())
        return;
    if (((Spell*)params->CastedSpell)->IsChannelActive())
        return;

    //do not spam trigger it
    RI_PeriodicTickParams *param = (RI_PeriodicTickParams*)context;
    if (param->NextTick > GameTime::GetGameTimeMS())
        return;
    param->NextTick = GameTime::GetGameTimeMS() + param->TickInterval;

    params->p->CastSpell(params->target, params->SpellInf->Id, TRIGGERED_FULL_MASK);
}

void RI_PS_HealDmg_UniqueKill(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    float *param = (float*)context;
    int64 *Kills = params->Attacker->GetExtension<int64>(OE_PLAYER_MONSTER_HUNT_UNIQUE_KILLS);
    if (Kills == NULL)
        return;
    float AddedHeal = (Kills[0] * param[0]);
    if (params->TickCount > 1)
        AddedHeal = AddedHeal / params->TickCount; //this is tickcount
    params->FlatMods += (int32)AddedHeal;
}

void RI_PS_HealDmg_UniqueItemUse(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    float *param = (float*)context;
    int64 *Items = params->Attacker->GetExtension<int64>(OE_PLAYER_CONSUME_ITEM_UNIQUE_COUNT);
    if (Items == NULL)
        return;
    float AddedHeal = (Items[0] * param[0]);
    if (params->TickCount > 1)
        AddedHeal = AddedHeal / params->TickCount; //this is tickcount
    params->FlatMods += (int32)AddedHeal;
}

void RI_PS_HealDmg_Achievements(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    float *param = (float*)context;
    int64 *Achie = params->Attacker->GetExtension<int64>(OE_PLAYER_ACHIEVEMENT_COUNT);
    if (Achie == NULL)
        return;
    float AddedHeal = (Achie[0] * param[0]);
    if (params->TickCount > 1)
        AddedHeal = AddedHeal / params->TickCount; //this is tickcount
    params->FlatMods += (int32)AddedHeal;
}

void RI_PS_HealDmg_Quests(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    Player *pAttacker = params->Attacker->ToPlayer();
    if (pAttacker == NULL)
        return;
    float *param = (float*)context;
    size_t quests = pAttacker->GetRewardedQuestCount();
    float AddedHeal = (quests * param[0]);
    if (params->TickCount > 1)
        AddedHeal = AddedHeal / params->TickCount; //this is tickcount
    params->FlatMods += (int32)AddedHeal;
}

void RI_PS_HealDmg_HonorableKills(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    float *param = (float*)context;
    Player *pAttacker = params->Attacker->ToPlayer();
    if (pAttacker == NULL)
        return;
    int32 KillCount = pAttacker->GetUInt32Value(PLAYER_FIELD_LIFETIME_HONORABLE_KILLS);
    int32 KillRating = (3500 * KillCount) / (KillCount + 1500);
    float AddedHeal = (KillRating * param[0]);
    if (params->TickCount > 1)
        AddedHeal = AddedHeal / params->TickCount; //this is tickcount
    params->FlatMods += (int32)AddedHeal;
}

void RI_PS_PetThreath(void *p, void *context)
{
    CP_CREATURE_INTERRACT *params = PointerCast(CP_CREATURE_INTERRACT, p);
    if (params->creature == NULL)
        return;

    int32 *param = (int32*)context;
    
    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(34472);
    Spell* spell = new Spell(params->creature, spellInfo, TRIGGERED_FULL_MASK);
    spell->m_targets.SetUnitTarget(params->creature->ToUnit());
    spell->SetSpellValue(SPELLVALUE_BASE_POINT0, param[0]);
    spell->cast(true);
}

void RI_PS_PetAura(void *p, void *context)
{
    CP_CREATURE_INTERRACT *params = PointerCast(CP_CREATURE_INTERRACT, p);
    if (params->creature == NULL)
        return;

    int32 *param = (int32*)context;

    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(param[0]);
    Spell* spell = new Spell(params->creature, spellInfo, TRIGGERED_FULL_MASK);
    spell->m_targets.SetUnitTarget(params->creature->ToUnit());
    spell->cast(true);

    Aura *a = params->creature->GetAura(param[0]);
    if (a != NULL && a->GetDuration() != -1)
        a->SetDuration(30 * 60 * 1000);
}

void RI_PS_HealDmg_LoginStreak(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    float *param = (float*)context;
    Player *pAttacker = params->Attacker->ToPlayer();
    if (pAttacker == NULL)
        return;
    int32 LoginCount = GetLoginStreak(pAttacker->GetGUID());
    int32 KillRating = (365 * LoginCount) / (LoginCount + 365);
    float AddedHeal = (KillRating * param[0]);
    if (params->TickCount > 1)
        AddedHeal = AddedHeal / params->TickCount; //this is tickcount
    params->FlatMods += (int32)AddedHeal;
}

void RI_PS_AutoChargeTargetSwap(void *p, void *context)
{
    Player *Owner = (Player*)p;
    //only if we are in combat
    if (Owner->IsInCombat() == false)
        return;
    RI_P_AutoCharge *param = (RI_P_AutoCharge*)context;
    //no spam abuses
    if (param->NextTick > GameTime::GetGameTimeMS())
        return;
    //only cast on new targets
    if (Owner->GetTarget() == param->PrevTarget)
        return;
    //only on far away targets
    Unit *Selection = Owner->GetSelectedUnit();
    if (Selection == NULL)
        return;
    float dist = Owner->GetDistance(Selection);
    if (dist < 10.0f || dist > 40.0f)
        return;
    //seems like we can charget the new target
    param->NextTick = GameTime::GetGameTimeMS() + param->TickInterval;
    // remember to not multi charge it
    param->PrevTarget = Owner->GetTarget();
    Owner->CastSpell(Selection, 40602, TRIGGERED_FULL_MASK);
}

void RI_PS_HealAbsorbRecharge(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    std::list<AuraEffect*> const& VictimAuras = params->Victim->GetAuraEffectsByType(AuraType::SPELL_AURA_SCHOOL_ABSORB);
    for (AuraEffect* auraEff : VictimAuras)
    {
        Aura* aura = auraEff->GetBase();
        if (!aura)
            continue;
        SpellInfo const *sp = auraEff->GetSpellInfo();
        if (auraEff->GetAmount() >= 0)
        {
            float *param = (float*)context;
            int32 AddedShield = (int32)(params->OriDamage * param[0]);
            if (auraEff->GetAmount() + AddedShield > (int32)params->Victim->GetHealth())
                AddedShield = (int32)params->Victim->GetHealth() - auraEff->GetAmount();
            if(AddedShield > 0)
                auraEff->SetAmount(auraEff->GetAmount() + AddedShield);
            break;
        }
    }
}

void RI_PS_TransmogDiscover(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;
    Player *Attacker = params->Attacker->ToPlayer();
    if (Attacker == NULL)
        return;
    //roll for a random entry
    uint32 RandomEntry = rand32() % sObjectMgr->GetItemTemplateStore().size();
    const ItemTemplate *IT = sObjectMgr->GetItemTemplate(RandomEntry);
    if (IT == NULL)
        return;
    if (IsTransmogItem(IT) == false)
        return;
    if (HasTransmog(Attacker->GetSession()->GetAccountId(), IT->ItemId) == false)
    {
        Attacker->BroadcastMessage("You discovered a new transmog : %d - %s", IT->ItemId, IT->Name1.c_str());
        AddTransmog(Attacker->GetSession()->GetAccountId(), IT->ItemId);
    }
}

void RI_PS_CastOnMove_Location(void *p, void *context)
{
    Player *Owner = (Player*)p;
    RI_P_CastOnMove *param = (RI_P_CastOnMove*)context;
    //no spam abuses
    if (param->NextTick > GameTime::GetGameTimeMS())
        return;
    // check move distance
    float dist = param->PrevPos.GetExactDist2d(Owner->GetPosition());
    if (dist < 1.0f)
        return;
    //seems like we can charget the new target
    param->PrevPos = Owner->GetPosition();
    param->NextTick = GameTime::GetGameTimeMS() + param->TickInterval;

    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(42926);
    Spell* spell = new Spell(Owner, spellInfo, TriggerCastFlags(TRIGGERED_FULL_MASK | TRIGGERED_IGNORE_CAST_TIME | TRIGGERED_IGNORE_MOVE_CHECK));
    spell->m_targets.SetSrc(Owner->GetPosition());
    spell->m_targets.SetDst(Owner->GetPosition());
    spell->SetSpellValue(SPELLVALUE_BASE_POINT0, (int32)(GetSingleTargetDPS(Owner) / 100 * 80));
    spell->cast(true);
}

void RI_PS_CastOnMove_RegisterSpell(void *p, void *context)
{
    CP_SPELL_CAST *params = PointerCast(CP_SPELL_CAST, p);
    if (params->TargetCount > 1)
        return;
    if (params->p->IsValidAttackTarget(params->target) == false)
        return;
    RI_P_CastOnMove *param = (RI_P_CastOnMove*)context;
    param->PrevSpell = params->SpellInf->Id;
}

void RI_PS_CastOnMove_CastSpell(void *p, void *context)
{
    Player *Owner = (Player*)p;
    RI_P_CastOnMove *param = (RI_P_CastOnMove*)context;
    //no spam abuses
    if (param->NextTick > GameTime::GetGameTimeMS())
        return;
    // check move distance
    float dist = param->PrevPos.GetExactDist2d(Owner->GetPosition());
    if (dist < 2.0f)
        return;
    if (param->PrevSpell == 0)
        return;
    Unit *Target = Owner->GetSelectedUnit();
    if (Target == NULL || Owner->IsValidAttackTarget(Target) == false)
        return;
    //seems like we can charget the new target
    param->PrevPos = Owner->GetPosition();
    param->NextTick = GameTime::GetGameTimeMS() + param->TickInterval;
    CastSpellExtraArgs extra;
    extra.SetTriggerFlags((TriggerCastFlags)(TRIGGERED_FULL_MASK | TRIGGERED_IGNORE_CAST_TIME | TRIGGERED_IGNORE_MOVE_CHECK));
    Owner->CastSpell(Target, param->PrevSpell, extra);
}

void RI_PS_MeleeHasteToDMG(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;
    //only care about melee dmg
    if (params->sp != NULL)
        return;
    if (params->atk != BASE_ATTACK && params->atk != OFF_ATTACK)
        return;
    Player *pAttacker = params->Attacker->ToPlayer();
    if (pAttacker == NULL)
        return;
    float Haste1 = pAttacker->m_modAttackSpeedPct[BASE_ATTACK];
    float Haste2 = pAttacker->m_modAttackSpeedPct[OFF_ATTACK];
    Haste1 = MAX(Haste1, Haste2);
    //only boost slow attacks
    if (Haste1 <= 1.0f)
        return;
    float *param = (float*)context;
    params->FlatMods += (int32)(params->OriDamage * param[0] * Haste1);
}

void RI_PS_RangedHasteToDMG(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;
    //only care about melee dmg
    if (params->sp != NULL)
        return;
    if (params->atk != RANGED_ATTACK)
        return;
    Player *pAttacker = params->Attacker->ToPlayer();
    if (pAttacker == NULL)
        return;
    float Haste1 = pAttacker->m_modAttackSpeedPct[RANGED_ATTACK];
    //only boost slow attacks
    if (Haste1 <= 1.0f)
        return;
    float *param = (float*)context;
    params->FlatMods += (int32)(params->OriDamage * param[0] * Haste1);
}

void RI_PS_SpellHasteToDMG(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;
    //only care about melee dmg
    if (params->sp == NULL)
        return;
    if (params->atk != MAX_ATTACK)
        return;
    Player *pAttacker = params->Attacker->ToPlayer();
    if (pAttacker == NULL)
        return;
    float Haste1 = pAttacker->GetFloatValue(UNIT_MOD_CAST_SPEED);
    //only boost slow attacks
    if (Haste1 <= 1.0f)
        return;
    float *param = (float*)context;
    params->FlatMods += (int32)(params->OriDamage * param[0] * Haste1);
}

void RI_PS_SpellModSpellTarget(void *p, void *context)
{
    CP_SPELL_MOD_APPLY *params = PointerCast(CP_SPELL_MOD_APPLY, p);
    RI_P_SpellModParams *Mod = (RI_P_SpellModParams*)context;
    if (Mod->Type != params->ModType)
        return;
    if (params->SpellInf->SpellFamilyName == SPELLFAMILY_DEATHKNIGHT)
    {
        if (params->SpellInf->SpellIconID == 118) //death and decay makes kill friendlies
            return;
        if (params->SpellInf->SpellIconID == 88) //death coil aplies both heal and dmg
            return;
    }
    *params->ModFlat += Mod->FlatMod;
    *params->ModPCT += Mod->PctMod;
}
/*
void RI_PS_ChangeDmgType(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    uint32 *param = (uint32*)context;
    params->OriDamage |= param[0];
}*/

void RI_PS_SlamOnJump(void *p, void *context)
{
    CP_FALL_INFO *params = (CP_FALL_INFO*)p;
    RI_P_CastOnJump *param = (RI_P_CastOnJump*)context;
    //no spam abuses
    if (param->NextTick > GameTime::GetGameTimeMS())
        return;
    param->NextTick = GameTime::GetGameTimeMS() + param->TickInterval;
    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(56402);
    Spell* spell = new Spell((WorldObject*)params->p, spellInfo, (TriggerCastFlags)(TRIGGERED_FULL_MASK | TRIGGERED_IGNORE_CAST_TIME | TRIGGERED_IGNORE_MOVE_CHECK));
    spell->m_targets.SetUnitTarget(params->p);
    spell->m_targets.SetSrc(params->p->GetPosition());
    spell->m_targets.SetDst(params->p->GetPosition());
    float FallTime = (float)params->FallTime;
    if (params->FallTime > 5000)
        FallTime = 5;
    else
        FallTime = params->FallTime / 1000.0f;
    if (FallTime < 0.2f) //200ms fall time ?
        return;
    float damage = params->p->GetMaxHealth() * 0.1f * FallTime;
    spell->SetSpellValue(SPELLVALUE_BASE_POINT0, (int32)damage);
    spell->cast(true);
}

void RI_PS_ElectrocuteWhileCast(void *p, void *context)
{
    Player *Owner = (Player*)p;
    if (Owner->GetCurrentSpell(CURRENT_GENERIC_SPELL) == NULL && Owner->GetCurrentSpell(CURRENT_CHANNELED_SPELL) == NULL)
        return;
    RI_P_CastWhileCast *param = (RI_P_CastWhileCast*)context;
    //no spam abuses
    if (param->NextTick > GameTime::GetGameTimeMS())
        return;
    //search for a target
    const float Radius = 20.0f;
    std::list<Unit*> NearbyUnits;
    Trinity::AnyUnfriendlyUnitInObjectRangeCheck u_check(Owner, Owner, Radius);
    Trinity::UnitListSearcher<Trinity::AnyUnfriendlyUnitInObjectRangeCheck> searcher(Owner, NearbyUnits, u_check);
    Cell::VisitAllObjects(Owner, searcher, Radius);

    bool CanSetNextTarget = (param->PrevTarget == NULL);
    Unit *NextTarget = NULL;
    if (NearbyUnits.empty() == true)
        return;
    for (int i = 0; i < 2; i++)
    {
        //sarch until we find out prev target in the list
        for (std::list<Unit*>::iterator itr = NearbyUnits.begin(); itr != NearbyUnits.end(); itr++)
        {
            if (Owner->IsValidAttackTarget((*itr)) == false)
                continue;
            if (CanSetNextTarget == true)
            {
                NextTarget = (*itr);
                break;
            }
            if (param->PrevTarget == (*itr))
                CanSetNextTarget = true;
        }
        CanSetNextTarget = true; // we could not find the previous target ( or it was the last target ). Pick a new target
        if (NextTarget != NULL)
            break;
    }
    param->PrevTarget = NextTarget;
    if (NextTarget == NULL)
        return;

    float HighestStat = Owner->GetStat(STAT_STRENGTH);
    if (Owner->GetStat(STAT_AGILITY) > HighestStat)
        HighestStat = Owner->GetStat(STAT_AGILITY);
    if (Owner->GetStat(STAT_INTELLECT) > HighestStat)
        HighestStat = Owner->GetStat(STAT_INTELLECT);
    if (Owner->GetStat(STAT_SPIRIT) > HighestStat)
        HighestStat = Owner->GetStat(STAT_SPIRIT);
    HighestStat = HighestStat * 75 / 100; //nerfing it a bit

    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(33665);
    Spell* spell = new Spell((WorldObject*)Owner, spellInfo, (TriggerCastFlags)(TRIGGERED_FULL_MASK | TRIGGERED_IGNORE_SET_FACING));
    spell->m_targets.SetUnitTarget(NextTarget);
    spell->SetSpellValue(SPELLVALUE_BASE_POINT0, (int32)HighestStat);
    spell->cast(true);

    param->NextTick = GameTime::GetGameTimeMS() + param->TickInterval;
}

void RI_PS_TransformLook(void *p, void *context)
{
    Player *Owner = (Player *)p;
    uint32 *MorphDisplayId = Owner->GetExtension<uint32>(OE_PLAYER_MORPH_DISPLAYID);
    float *MorphSize = Owner->GetExtension<float>(OE_PLAYER_MORPH_SIZE);
    Owner->SetObjectScale(*MorphSize);
    Owner->SetDisplayId(*MorphDisplayId);
}

void RI_PS_DistanceHealBoost(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    float *CreateParam = (float*)context;
    float Dist = params->Attacker->GetDistance(params->Victim);
    Dist = MIN(Dist, 30.f);
    float HealBonus = 1.f - Dist / 30.f; // full bonus when self heal
    HealBonus *= CreateParam[0];
    params->FlatMods += (int32)(params->OriDamage * HealBonus );
}

void RI_PS_BloodLustOnDamageTaken(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    //do not spam trigger it
    RI_PeriodicTickParams *param = (RI_PeriodicTickParams*)context;
    if (param->NextTick > GameTime::GetGameTimeMS())
        return;
    param->NextTick = GameTime::GetGameTimeMS() + param->TickInterval;

    //remove sated aura
    params->Victim->RemoveAura(57724);
    CastSpellExtraArgs extra;
    extra.SetTriggerFlags((TriggerCastFlags)(TRIGGERED_FULL_MASK | TRIGGERED_IGNORE_CAST_TIME | TRIGGERED_IGNORE_MOVE_CHECK));
    params->Victim->CastSpell(params->Victim, param->ModFlat, extra);
}

void RI_PS_MoveExpode(void *p, void *context)
{
    //do not spam trigger it
    RI_P_CastOnMove *param = (RI_P_CastOnMove*)context;
    if (param->NextTick > GameTime::GetGameTimeMS())
        return;
    param->NextTick = GameTime::GetGameTimeMS() + param->TickInterval;

    Player *Owner = (Player *)p;
    //check if moving
    bool IsMoving = false;
    if (Owner->GetPositionX() != param->PrevPos.GetPositionX())
        IsMoving = true;
    else if (Owner->GetPositionY() != param->PrevPos.GetPositionY())
        IsMoving = true;
    else if (Owner->GetPositionZ() != param->PrevPos.GetPositionZ())
        IsMoving = true;
    //update to new pos
    param->PrevPos = Owner->GetPosition();
    //no need to cast if still moving
    if (IsMoving == true)
    {
        param->PrevSpell++;
        return;
    }
    if (param->PrevSpell == 0)
        return;
    uint32 TimeMoved = param->PrevSpell * param->TickInterval;
    param->PrevSpell = 0;

    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(42921);
    Spell* spell = new Spell((WorldObject*)Owner, spellInfo, (TriggerCastFlags)(TRIGGERED_FULL_MASK | TRIGGERED_IGNORE_CAST_TIME | TRIGGERED_IGNORE_MOVE_CHECK));
//    spell->m_targets.SetUnitTarget(Owner);
    spell->m_targets.SetSrc(Owner->GetPosition());
    spell->m_targets.SetDst(Owner->GetPosition());
    float DmgRating = (float)(TimeMoved * 15000)/(TimeMoved + 15000) / 1000;
    float damage = Owner->GetMaxHealth() * 0.1f * DmgRating;
    spell->SetSpellValue(SPELLVALUE_BASE_POINT0, (int32)damage);
    spell->cast(true);
}

void RI_PS_SpellModSpellRange(void *p, void *context)
{
    CP_SPELL_MOD_APPLY *params = PointerCast(CP_SPELL_MOD_APPLY, p);
    RI_P_SpellModParams *Mod = (RI_P_SpellModParams*)context;
    if (Mod->Type != params->ModType)
        return;
    int32 *AllItems = params->p->GetCreateExtension<int32>(OE_PLAYER_SPELL_MOD_RANGE_FLAT);
    *params->ModFlat += AllItems[0];
}

void RI_PS_AuraMaxStacks(void *p, void *context)
{
    CP_AURA_CAN_STACK *params = PointerCast(CP_AURA_CAN_STACK, p);
    int32 *MaxStacks = params->p->GetExtension<int32>(OE_PLAYER_MAX_AURA_STACKS);
    int32 ApplicationCount = 0;
    Unit::AuraApplicationMap &itsAuras = params->p->GetAppliedAuras();
    SpellInfo const* const m_spellInfo = params->aur->GetSpellInfo();
    for (auto i = itsAuras.begin(); i != itsAuras.end(); ++i)
    {
        if (m_spellInfo->IsRankOf(i->second->GetBase()->GetSpellInfo()))
            ApplicationCount++;
    }
    if (ApplicationCount < MaxStacks[0])
        params->CanStack = true;
}

void RI_PS_ArmorToResistance(void *p, void *context)
{
    //do not spam trigger it
    RI_PeriodicTickParams *param = (RI_PeriodicTickParams*)context;
    if (param->NextTick > GameTime::GetGameTimeMS())
        return;
    param->NextTick = GameTime::GetGameTimeMS() + param->TickInterval;
    Player *Owner = (Player *)p;
    int32 NewVal = (int32)(Owner->GetResistance(SPELL_SCHOOL_NORMAL) * param->ModPCT);
    if (NewVal == param->ModFlat)
        return;

    Owner->HandleStatFlatModifier((UnitMods)param->Type, TOTAL_VALUE, (float)(param->ModFlat), false);

    param->ModFlat = NewVal;
    Owner->HandleStatFlatModifier((UnitMods)param->Type, TOTAL_VALUE, (float)(param->ModFlat), true);
}

void RI_PS_HealNearbyPlayer(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    float *CreateParam = (float*)context;
    float DmgModPct = 0;

    const float Radius = 10.0f;
    std::list<Unit*> NearbyUnits;
    Trinity::AnyPlayerInObjectRangeCheck u_check(params->Attacker, Radius);
    Trinity::PlayerListSearcher<Trinity::AnyPlayerInObjectRangeCheck> searcher(params->Attacker, NearbyUnits, u_check);
    Cell::VisitAllObjects(params->Attacker, searcher, Radius);
    DmgModPct = (NearbyUnits.size() - 1) * CreateParam[0];

    params->FlatMods += (int32)(params->OriDamage * DmgModPct);
}

void RI_PS_KillStreakIncrease(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;
    RI_PeriodicTickParams *Params = (RI_PeriodicTickParams*)context;
    if (Params->NextTick <= GameTime::GetGameTimeMS())
        Params->ModPCT = 1;
    else
        Params->ModPCT += 1.f;
    Params->NextTick = GameTime::GetGameTimeMS() + Params->TickInterval;
}

void RI_PS_KillStreakDmgAdd(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    RI_PeriodicTickParams *CreateParam = (RI_PeriodicTickParams*)context;
    if (CreateParam->NextTick <= GameTime::GetGameTimeMS())
        CreateParam->ModPCT = 0;

    float KillCount = CreateParam->ModPCT;
    float KillRating = (1500 * KillCount) / (KillCount + 1500);
    int32 AddedDmg = (int32)(KillRating * CreateParam->ModFlat);
    if (params->TickCount > 1)
        AddedDmg = AddedDmg / params->TickCount;

    params->FlatMods += AddedDmg;
}

void RI_PS_LowHealthHealStreak(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    RI_P_SpellModParams *CreateParam = (RI_P_SpellModParams*)context;
    if (params->Victim->GetHealthPct() > 50)
        CreateParam->PctMod = 0;
    else
        CreateParam->PctMod++;

    params->FlatMods += (int32)(CreateParam->PctMod * CreateParam->FlatMod);
}

void RI_PS_SimilarDamageTaken(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    if (params->GetDamage() <= 0)
        return;

    int32 *CreateParam = (int32*)context;
    int32 DamageWouldReceiveNow = params->GetDamage();
    CreateParam[0] += DamageWouldReceiveNow;
    int32 DamageShouldReceiveNow = CreateParam[0] / 100;
    CreateParam[0] -= DamageShouldReceiveNow;

    if (CreateParam[0] < 0)
        CreateParam[0] = 0;

    params->FlatMods -= DamageWouldReceiveNow;
    params->FlatMods += DamageShouldReceiveNow;
}

void RI_PS_DamageTakenSplitOverTime_SumDmg(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    if (params->GetDamage() <= 0 || params->GetDamage() > params->Victim->GetHealth())
        return;

    RI_P_DamageTakenSmoothed *Param = (RI_P_DamageTakenSmoothed*)context;
    Param->DamageSum += params->GetDamage();
//    Param->LastDmgStamp = GameTime::GetGameTimeMS();

    params->ForceDamageAbsorb();
}

void RI_PS_DamageTakenSplitOverTime_DealDmg(void *p, void *context)
{
    RI_P_DamageTakenSmoothed *Param = (RI_P_DamageTakenSmoothed*)context;
    if (Param->NextTick > GameTime::GetGameTimeMS())
        return;
    Param->NextTick = GameTime::GetGameTimeMS() + Param->TickInterval;

    uint64 DmgPartNow = Param->DamageSum / Param->DividePeriod;
    Param->DamageSum -= DmgPartNow;

    Player *params = (Player*)p;
    if (params->GetHealth() > DmgPartNow)
        params->ModifyHealth(-(int32)DmgPartNow);
    else
        params->SetHealth(1);
}

void RI_PS_CastOnKill(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;
    Player *Attacker = params->Attacker->ToPlayer();
    if (Attacker == NULL)
        return;
    uint32 *Param = (uint32*)context;
    CastSpellExtraArgs extra;
    extra.SetTriggerFlags((TriggerCastFlags)(TRIGGERED_FULL_MASK | TRIGGERED_IGNORE_CAST_TIME | TRIGGERED_IGNORE_MOVE_CHECK));
    params->Attacker->CastSpell(params->Attacker, Param[0], extra);
}

void RI_PS_ExtraDmgWhileBehindTarget_Flat(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;
    if (params->TickCount > 1)
        return;
    if (params->Victim->HasInArc(float(M_PI), params->Attacker) == true)
        return;

    uint32 *Param = (uint32*)context;
    params->FlatMods += Param[0];
}

void RI_PS_ExtraDmgReduceWhileInFrontTarget_Flat(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;
    if (params->Attacker->HasInArc(float(M_PI), params->Victim) == false)
        return;

    uint32 *Param = (uint32*)context;
    params->FlatMods -= Param[0];
}

void RI_PS_HealsRestoreDamageTaken_Dmg(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    RI_P_SpellModParams *Param = (RI_P_SpellModParams*)context;
    Param->FlatMod = params->GetDamage();
}

void RI_PS_HealsRestoreDamageTaken_Heal(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;
    RI_P_SpellModParams *Param = (RI_P_SpellModParams*)context;
    params->FlatMods += int32(Param->FlatMod * Param->PctMod);
    Param->FlatMod = 0; //we used up this dmg, no longer can be used to restore health
}

void RI_PS_SingleTargetToAOE(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    //no periodic spells
    if (params->TickCount > 1)
        return;

    //no aoe spells
    if (params->sp != NULL && params->sp->IsTargetingArea() == true)
        return;

    //cast a spell that should be mitigated by mobs, but should not be boosted by caster anymore
    float *ConversionRate = params->Attacker->GetExtension<float>(OE_PLAYER_AOE_DMG_COEF);
    int32 AOEDmg = (int32)(ConversionRate[0] * params->OriDamage);
    params->FlatMods -= AOEDmg;
    uint32 *SumOfProcs = params->Attacker->GetExtension<uint32>(OE_PLAYER_AOE_DMG);
    SumOfProcs[0] += AOEDmg;
/*
    //cast a spell with modded value
    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(8349);
    Spell* spell = new Spell(params->Attacker, spellInfo, TRIGGERED_FULL_MASK);
    spell->m_targets.SetUnitTarget(params->Victim);
    spell->m_targets.SetSrc(params->Attacker->GetPosition());
    spell->m_targets.SetDst(params->Victim->GetPosition());
    spell->SetSpellValue(SPELLVALUE_BASE_POINT0, AOEDmg);
    spell->cast(true);*/
}

/*
void RI_PS_XPGain(void *p, void *CreateParam)
{
    CP_CREATURE_INTERRACT *params = PointerCast(CP_CREATURE_INTERRACT, p);

    //sanity check
    if (params->player == NULL || params->creature == NULL)
        return;

    float *Param = (float*)CreateParam;

    uint32 XPToGive = params->player->GetUInt32Value(PLAYER_NEXT_LEVEL_XP) * Param[0] / 100;
    params->player->GiveXP(XPToGive, NULL, 1);
}*/

void RI_PS_CastOnHit(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    //no periodic spells
    if (params->TickCount > 1)
        return;

    //no aoe spells
    if (params->sp != NULL && params->sp->IsTargetingArea() == true)
        return;

    //cast the spell
    uint32 *Param = (uint32*)context;
    CastSpellExtraArgs extra;
    extra.SetTriggerFlags((TriggerCastFlags)(TRIGGERED_FULL_MASK | TRIGGERED_IGNORE_CAST_TIME | TRIGGERED_IGNORE_MOVE_CHECK));
    params->Attacker->CastSpell(params->Victim, Param[0], extra);

    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(Param[0]);
    Spell* spell = new Spell(params->Attacker, spellInfo, TRIGGERED_FULL_MASK);
    spell->m_targets.SetUnitTarget(params->Victim);
    spell->m_targets.SetSrc(params->Attacker->GetPosition());
    spell->m_targets.SetDst(params->Victim->GetPosition());
    spell->SetSpellValue(SPELLVALUE_BASE_POINT0, params->OriDamage * 10 / 100);
    spell->cast(true);
}

void RI_PS_DiabloCastFireBreath(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    //no periodic spells
    if (params->TickCount > 1)
        return;

    //no aoe spells
    if (params->sp != NULL && params->sp->IsTargetingArea() == true)
        return;

    RI_PeriodicTickParams *Param = (RI_PeriodicTickParams*)context;
    if (Param->NextTick > GameTime::GetGameTimeMS())
        return;
    Param->NextTick = GameTime::GetGameTimeMS() + Param->TickInterval;

    //cast the spell
    CastSpellExtraArgs extra;
    extra.SetTriggerFlags((TriggerCastFlags)(TRIGGERED_FULL_MASK | TRIGGERED_IGNORE_CAST_TIME | TRIGGERED_IGNORE_MOVE_CHECK));

    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(34359);
    Spell* spell = new Spell(params->Attacker, spellInfo, TRIGGERED_FULL_MASK);
    spell->m_targets.SetUnitTarget(params->Victim);
    spell->m_targets.SetSrc(params->Attacker->GetPosition());
    spell->m_targets.SetDst(params->Victim->GetPosition());
    spell->SetSpellValue(SPELLVALUE_BASE_POINT0, (int32)(GetSingleTargetDPS(params->Attacker->ToPlayer()) / 100 * 50));
    spell->cast(true);
}

void RI_PS_HealthToDamage(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    RI_P_SpellModParams *BurParams = (RI_P_SpellModParams*)context;
    int32 OwnerHealth = params->Attacker->GetHealth();
    int32 MinHealthToRemain = params->Attacker->GetMaxHealth() / 100 * 20;
    if (OwnerHealth == 0 || OwnerHealth < MinHealthToRemain )
        return;
    OwnerHealth -= MinHealthToRemain;
    int32 HealthToBurn = int32(BurParams->FlatMod + OwnerHealth * BurParams->PctMod);
    if (params->TickCount > 1)
        HealthToBurn = HealthToBurn / params->TickCount; //this is tickcount
    if (HealthToBurn > OwnerHealth)
        HealthToBurn = OwnerHealth;

    params->Attacker->ModifyHealth(-HealthToBurn);
    params->FlatMods += HealthToBurn; // coeff should be related to mana regen. we aim to have around 50k DPS with it
}

void RI_PS_PowerMissingToDMGPCT(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;


    float *MinMaxCoef = (float*)context;
    float ManaPCT = 1.0f - (float)params->Attacker->GetPower(params->Attacker->GetPowerType()) / (float)params->Attacker->GetMaxPower(params->Attacker->GetPowerType());

    uint32 increase = (uint32)((params->OriDamage) * MinMaxCoef[0] * ManaPCT);
    params->FlatMods += increase;
}

void RI_PS_DamageDonePCT(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;

    RI_P_SpellModParams *MinMaxCoef = (RI_P_SpellModParams*)context;

    int32 increase = (int32)(params->OriDamage * MinMaxCoef->PctMod);
    if (params->TickCount > 1)
        increase += MinMaxCoef->FlatMod / params->TickCount; //this is tickcount
    else
        increase += MinMaxCoef->FlatMod;

    params->FlatMods += increase;
}
