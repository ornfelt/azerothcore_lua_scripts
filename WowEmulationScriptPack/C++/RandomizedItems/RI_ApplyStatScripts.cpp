#include "RI_ApplyStatScripts.h"
#include "Player.h"
#include "ItemTemplate.h"
#include "RI_ItemStore.h"
#include "RI_AddonUpdater.h"
#include "RI_PlayerStore.h"
#include "RI_ProcScripts.h"
#include "Item.h"
#include "GameTime.h"
#include "DBCStores.h"
#include "Spell.h"
#include "SpellAuraEffects.h"
#include "SpellMgr.h"
#include "ObjectExtension.cpp"

static SpellInfo *CustomSpells[TOTAL_AURAS] = { NULL };
SpellInfo *GetSpellInfoForAura(int AuraEffect, int SetMiscValue = 0)
{
    //stop doing stupid shit
    if (AuraEffect >= TOTAL_AURAS)
        return NULL;
    //first init
    if (CustomSpells[0] == NULL)
        memset(CustomSpells, 0, sizeof(CustomSpells));
    //if not yet created, create one. Right now SpellId or Name does not matter for auras not visible client side. This is trinity server specific !
    if (CustomSpells[AuraEffect] == NULL)
    {
        SpellEntry *sp = new SpellEntry();
        sp->Effect[0] = SPELL_EFFECT_APPLY_AURA;
        sp->EffectApplyAuraName[0] = AuraEffect;
        sp->EffectImplicitTargetA[0] = TARGET_UNIT_CASTER;
        sp->EffectMiscValue[0] = SetMiscValue;
        CustomSpells[AuraEffect] = new SpellInfo(sp);
    }
    //this should never fail ( unless it fails )
    return CustomSpells[AuraEffect];
}

void RI_AS_ItemMod(bool apply, Player *p, RI_StatStore *param)
{
    PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
    RIStatTypes s = param->Type;
    ItemModType statType = RI_PickableStats[s].ItemMod;
    float val = param->Power;
    Player *pp = p;

    switch (statType)
    {
    case ITEM_MOD_MANA:
        pp->HandleStatFlatModifier(UNIT_MOD_MANA, BASE_VALUE, float(val), apply);
        break;
    case ITEM_MOD_HEALTH:                           // modify HP
        pp->HandleStatFlatModifier(UNIT_MOD_HEALTH, BASE_VALUE, float(val), apply);
        break;
    case ITEM_MOD_AGILITY:                          // modify agility
        pp->HandleStatFlatModifier(UNIT_MOD_STAT_AGILITY, BASE_VALUE, float(val), apply);
        pp->UpdateStatBuffMod(STAT_AGILITY);
        break;
    case ITEM_MOD_STRENGTH:                         //modify strength
        pp->HandleStatFlatModifier(UNIT_MOD_STAT_STRENGTH, BASE_VALUE, float(val), apply);
        pp->UpdateStatBuffMod(STAT_STRENGTH);
        break;
    case ITEM_MOD_INTELLECT:                        //modify intellect
        pp->HandleStatFlatModifier(UNIT_MOD_STAT_INTELLECT, BASE_VALUE, float(val), apply);
        pp->UpdateStatBuffMod(STAT_INTELLECT);
        break;
    case ITEM_MOD_SPIRIT:                           //modify spirit
        pp->HandleStatFlatModifier(UNIT_MOD_STAT_SPIRIT, BASE_VALUE, float(val), apply);
        pp->UpdateStatBuffMod(STAT_SPIRIT);
        break;
    case ITEM_MOD_STAMINA:                          //modify stamina
        pp->HandleStatFlatModifier(UNIT_MOD_STAT_STAMINA, BASE_VALUE, float(val), apply);
        pp->UpdateStatBuffMod(STAT_STAMINA);
        break;
    case ITEM_MOD_DEFENSE_SKILL_RATING:
        pp->ApplyRatingMod(CR_DEFENSE_SKILL, int32(val), apply);
        break;
    case ITEM_MOD_DODGE_RATING:
        pp->ApplyRatingMod(CR_DODGE, int32(val), apply);
        break;
    case ITEM_MOD_PARRY_RATING:
        pp->ApplyRatingMod(CR_PARRY, int32(val), apply);
        break;
    case ITEM_MOD_BLOCK_RATING:
        pp->ApplyRatingMod(CR_BLOCK, int32(val), apply);
        break;
    case ITEM_MOD_HIT_MELEE_RATING:
        pp->ApplyRatingMod(CR_HIT_MELEE, int32(val), apply);
        break;
    case ITEM_MOD_HIT_RANGED_RATING:
        pp->ApplyRatingMod(CR_HIT_RANGED, int32(val), apply);
        break;
    case ITEM_MOD_HIT_SPELL_RATING:
        pp->ApplyRatingMod(CR_HIT_SPELL, int32(val), apply);
        break;
    case ITEM_MOD_CRIT_MELEE_RATING:
        pp->ApplyRatingMod(CR_CRIT_MELEE, int32(val), apply);
        break;
    case ITEM_MOD_CRIT_RANGED_RATING:
        pp->ApplyRatingMod(CR_CRIT_RANGED, int32(val), apply);
        break;
    case ITEM_MOD_CRIT_SPELL_RATING:
        pp->ApplyRatingMod(CR_CRIT_SPELL, int32(val), apply);
        break;
    case ITEM_MOD_HIT_TAKEN_MELEE_RATING:
        pp->ApplyRatingMod(CR_HIT_TAKEN_MELEE, int32(val), apply);
        break;
    case ITEM_MOD_HIT_TAKEN_RANGED_RATING:
        pp->ApplyRatingMod(CR_HIT_TAKEN_RANGED, int32(val), apply);
        break;
    case ITEM_MOD_HIT_TAKEN_SPELL_RATING:
        pp->ApplyRatingMod(CR_HIT_TAKEN_SPELL, int32(val), apply);
        break;
    case ITEM_MOD_CRIT_TAKEN_MELEE_RATING:
        pp->ApplyRatingMod(CR_CRIT_TAKEN_MELEE, int32(val), apply);
        break;
    case ITEM_MOD_CRIT_TAKEN_RANGED_RATING:
        pp->ApplyRatingMod(CR_CRIT_TAKEN_RANGED, int32(val), apply);
        break;
    case ITEM_MOD_CRIT_TAKEN_SPELL_RATING:
        pp->ApplyRatingMod(CR_CRIT_TAKEN_SPELL, int32(val), apply);
        break;
    case ITEM_MOD_HASTE_MELEE_RATING:
        pp->ApplyRatingMod(CR_HASTE_MELEE, int32(val), apply);
        break;
    case ITEM_MOD_HASTE_RANGED_RATING:
        pp->ApplyRatingMod(CR_HASTE_RANGED, int32(val), apply);
        break;
    case ITEM_MOD_HASTE_SPELL_RATING:
        pp->ApplyRatingMod(CR_HASTE_SPELL, int32(val), apply);
        break;
    case ITEM_MOD_HIT_RATING:
        pp->ApplyRatingMod(CR_HIT_MELEE, int32(val), apply);
        pp->ApplyRatingMod(CR_HIT_RANGED, int32(val), apply);
        pp->ApplyRatingMod(CR_HIT_SPELL, int32(val), apply);
        break;
    case ITEM_MOD_CRIT_RATING:
        pp->ApplyRatingMod(CR_CRIT_MELEE, int32(val), apply);
        pp->ApplyRatingMod(CR_CRIT_RANGED, int32(val), apply);
        pp->ApplyRatingMod(CR_CRIT_SPELL, int32(val), apply);
        break;
    case ITEM_MOD_HIT_TAKEN_RATING:
        pp->ApplyRatingMod(CR_HIT_TAKEN_MELEE, int32(val), apply);
        pp->ApplyRatingMod(CR_HIT_TAKEN_RANGED, int32(val), apply);
        pp->ApplyRatingMod(CR_HIT_TAKEN_SPELL, int32(val), apply);
        break;
    case ITEM_MOD_CRIT_TAKEN_RATING:
        pp->ApplyRatingMod(CR_CRIT_TAKEN_MELEE, int32(val), apply);
        pp->ApplyRatingMod(CR_CRIT_TAKEN_RANGED, int32(val), apply);
        pp->ApplyRatingMod(CR_CRIT_TAKEN_SPELL, int32(val), apply);
        break;
    case ITEM_MOD_RESILIENCE_RATING:
        pp->ApplyRatingMod(CR_CRIT_TAKEN_MELEE, int32(val), apply);
        pp->ApplyRatingMod(CR_CRIT_TAKEN_RANGED, int32(val), apply);
        pp->ApplyRatingMod(CR_CRIT_TAKEN_SPELL, int32(val), apply);
        break;
    case ITEM_MOD_HASTE_RATING:
        pp->ApplyRatingMod(CR_HASTE_MELEE, int32(val), apply);
        pp->ApplyRatingMod(CR_HASTE_RANGED, int32(val), apply);
        pp->ApplyRatingMod(CR_HASTE_SPELL, int32(val), apply);
        break;
    case ITEM_MOD_EXPERTISE_RATING:
        pp->ApplyRatingMod(CR_EXPERTISE, int32(val), apply);
        break;
    case ITEM_MOD_ATTACK_POWER:
        pp->HandleStatFlatModifier(UNIT_MOD_ATTACK_POWER, TOTAL_VALUE, float(val), apply);
        pp->HandleStatFlatModifier(UNIT_MOD_ATTACK_POWER_RANGED, TOTAL_VALUE, float(val), apply);
        break;
    case ITEM_MOD_RANGED_ATTACK_POWER:
        pp->HandleStatFlatModifier(UNIT_MOD_ATTACK_POWER_RANGED, TOTAL_VALUE, float(val), apply);
        break;
    case ITEM_MOD_MANA_REGENERATION:
        pp->ApplyManaRegenBonus(int32(val), apply);
        break;
    case ITEM_MOD_ARMOR_PENETRATION_RATING:
        pp->ApplyRatingMod(CR_ARMOR_PENETRATION, int32(val), apply);
        break;
    case ITEM_MOD_SPELL_POWER:
        pp->ApplySpellPowerBonus(int32(val), apply);
        break;
    case ITEM_MOD_HEALTH_REGEN:
        pp->ApplyHealthRegenBonus(int32(val), apply);
        break;
    case ITEM_MOD_SPELL_PENETRATION:
        pp->ApplySpellPenetrationBonus(int32(val), apply);
        break;
    case ITEM_MOD_BLOCK_VALUE:
        pp->HandleBaseModFlatValue(SHIELD_BLOCK_VALUE, float(val), apply);
        break;
        // deprecated item mods
    case ITEM_MOD_SPELL_HEALING_DONE:
    case ITEM_MOD_SPELL_DAMAGE_DONE:
        break;
    }
}

void RI_AS_UnitModFlat(bool apply, Player *p, RI_StatStore *param)
{
    PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
    RIStatTypes s = param->Type;
    UnitMods statType = RI_PickableStats[s].UnitMod;
    float val = param->Power;
    Player *pp = p;

    pp->HandleStatFlatModifier(statType, TOTAL_VALUE, float(val), apply);
}

void RI_AS_MagicFind(bool Apply, Player *p, RI_StatStore *param)
{
    float val = param->Power;
    RI_PlayerStore *ri = GetPlayerRIStore(p);
    ri->ModStat(RI_STTG_MF,(int)val, Apply);
}

void RI_AS_MagicStrength(bool Apply, Player *p, RI_StatStore *param)
{
    float val = param->Power;
    RI_PlayerStore *ri = GetPlayerRIStore(p);
    ri->ModStat(RI_STTG_MFP,(int)val, Apply);
}

void RI_AS_MagicFindNoInstance(bool Apply, Player *p, RI_StatStore *param)
{
    float val = param->Power;
    RI_PlayerStore *ri = GetPlayerRIStore(p);
    ri->ModStat(RI_STTG_MF_NO_INSTANCE,(int)val, Apply);
}

void RI_AS_MagicStrengthNoInstance(bool Apply, Player *p, RI_StatStore *param)
{
    float val = param->Power;
    RI_PlayerStore *ri = GetPlayerRIStore(p);
    ri->ModStat(RI_STTG_MFP_NO_INSTANCE,(int)val, Apply);
}

void RI_AS_DamageDoneSchool(bool Apply, Player *p, RI_StatStore *param)
{
    //one time spell init
    static SpellInfo *spSchools[MAX_SPELL_SCHOOL] = { NULL };
    if (spSchools[0] == NULL)
    {
        for (int i = 0; i < MAX_SPELL_SCHOOL; i++)
        {
            SpellEntry *sp = new SpellEntry();
            sp->Effect[0] = SPELL_EFFECT_APPLY_AURA;
            sp->EffectApplyAuraName[0] = SPELL_AURA_MOD_DAMAGE_DONE;
            sp->EffectImplicitTargetA[0] = TARGET_UNIT_CASTER;
            sp->EffectMiscValue[0] = 1 << i;
            spSchools[i] = new SpellInfo(sp);
        }
    }

    //apply it visually
    int32 Val = (int32)param->Power;
    PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
    RIStatTypes s = param->Type;
    int statType = RI_PickableStats[s].SchoolMask;
    uint16 baseField = Val >= 0 ? PLAYER_FIELD_MOD_DAMAGE_DONE_POS : PLAYER_FIELD_MOD_DAMAGE_DONE_NEG;
    p->ApplyModInt32Value(baseField + statType, Val, Apply);


    //apply it so functions will use the value
    AuraEffect *aue;
    if (Apply == true)
    {
        Aura *a = NULL;
        SpellInfo const *sp = spSchools[statType];
        aue = new AuraEffect(1, 1, NULL, sp, 0);
        aue->SetAmount((int32)param->Power);
        param->ProcDataStore = aue;
    }
    else
        aue = (AuraEffect*)param->ProcDataStore;

    //apply the effect on the player
    p->_RegisterAuraEffect(aue, Apply);
    p->UpdateAllDamageDoneMods();

    //don't leak memory
    if (Apply == false)
    {
        param->ProcDataStore = NULL;
        DebugCheckDoubleDelete( aue );
    }
}

void RI_AS_DamageDoneTargetHPPCT(bool Apply, Player *p, RI_StatStore *param)
{
    //register a proc on caster for each time he does dmg
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            float *Param = new float;
            *Param = param->Power / 100.0f;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_DamageDoneTargetHPPCT, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_DamageDoneTargetHPPCT, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_DamageDoneTargetHPMissingPCT(bool Apply, Player *p, RI_StatStore *param)
{
    //register a proc on caster for each time he does dmg
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            float *Param = new float;
            *Param = param->Power / 100.0f;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_DamageDoneTargetHPMissingPCT, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_DamageDoneTargetHPMissingPCT, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_HealDoneTargetHPPCT(bool Apply, Player *p, RI_StatStore *param)
{
    //register a proc on caster for each time he does dmg
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            float *Param = new float;
            *Param = param->Power / 100.0f;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_HEAL_DONE, RI_PS_HealDoneTargetHPPCT, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_HEAL_DONE, RI_PS_HealDoneTargetHPPCT, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_HealDoneTargetHPMissingPCT(bool Apply, Player *p, RI_StatStore *param)
{
    //register a proc on caster for each time he does dmg
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            float *Param = new float;
            *Param = param->Power / 100.0f;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_HEAL_DONE, RI_PS_HealDoneTargetHPMissingPCT, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_HEAL_DONE, RI_PS_HealDoneTargetHPMissingPCT, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_SpellModFlat(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
            RI_P_SpellModParams *Param = new RI_P_SpellModParams;
            Param->FlatMod = (int32)param->Power;
            Param->Type = RI_PickableStats[param->Type].SpellMod;
            Param->PctMod = 0.0f;
            param->ProcDataStore = Param;
            if (Param->Type == SPELLMOD_DURATION)
                Param->FlatMod *= 1000;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_SPELL_MOD_APPLY, RI_PS_SpellMod, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_SPELL_MOD_APPLY, RI_PS_SpellMod, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_SpellModPCT(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
            RI_P_SpellModParams *Param = new RI_P_SpellModParams;
            Param->FlatMod = 0;
            Param->Type = RI_PickableStats[param->Type].SpellMod;
            Param->PctMod = param->Power / 100.0f;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_SPELL_MOD_APPLY, RI_PS_SpellMod, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_SPELL_MOD_APPLY, RI_PS_SpellMod, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_SpellModPCTNegative(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
            RI_P_SpellModParams *Param = new RI_P_SpellModParams;
            Param->FlatMod = 0;
            Param->Type = RI_PickableStats[param->Type].SpellMod;
            Param->PctMod = param->Power / 100.0f;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_SPELL_MOD_APPLY, RI_PS_SpellModNegative, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_SPELL_MOD_APPLY, RI_PS_SpellModNegative, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_DropChanceNoJunk(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            float *Param = new float;
            *Param = param->Power;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_LOOT_ITEM_ROOL, RI_PS_DropChanceNoJunk, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_LOOT_ITEM_ROOL, RI_PS_DropChanceNoJunk, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_HealthRegenAlways(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            RI_PeriodicTickParams *Param = new RI_PeriodicTickParams;
            if (param->Type == RI_HEALTH_REGEN_ALWAYS)
            {
                Param->ModFlat = (int32)param->Power;
                Param->ModPCT = 0.0f;
            }
            else if (param->Type == RI_HEALTH_REGEN_ALWAYS_PCT || param->Type == RI_HEALTH_REGEN_MISSING_PCT || param->Type == RI_HEALTH_REGEN_EXISTING_PCT)
            {
                Param->ModFlat = 0;
                Param->ModPCT = param->Power / 100.0f;
            }
            Param->TickInterval = 5000;
            Param->Type = param->Type;
#ifdef _DEBUG
            Param->NextTick = 0;
#else
            Param->NextTick = GameTime::GetGameTimeMS() + Param->TickInterval;
#endif
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_PERIODIC_TICK, RI_PS_HealthRegenTick, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_PERIODIC_TICK, RI_PS_HealthRegenTick, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_PowerRegenAlways(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            RI_PeriodicTickParams *Param = new RI_PeriodicTickParams;
            Param->ModFlat = 0;
            Param->ModPCT = param->Power / 100.0f;
            Param->TickInterval = 5000;
            Param->Type = param->Type;
#ifdef _DEBUG
            Param->NextTick = 0;
#else
            Param->NextTick = GameTime::GetGameTimeMS() + Param->TickInterval;
#endif
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_PERIODIC_TICK, RI_PS_PowerRegenTick, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_PERIODIC_TICK, RI_PS_PowerRegenTick, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_PowerBurn(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            RI_P_SpellModParams *Param = new RI_P_SpellModParams;
            if (param->Type == RI_POWER_BURN_TARGET)
            {
                Param->FlatMod = (int32)param->Power;
                Param->PctMod = 0.0f;
            }
            else if (param->Type == RI_POWER_BURN_TARGET_PCT)
            {
                Param->FlatMod = 0;
                Param->PctMod = param->Power / 100.0f;
            }
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_TargetPowerBurn, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_TargetPowerBurn, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_GainPassiveBuff(bool Apply, Player *p, RI_StatStore *param)
{
    PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
    uint32 SpellId = RI_PickableStats[param->Type].AdditionalParam1;
    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(SpellId);

    if (Apply == true)
    {
        //we need to load this on player login. Maybe before the player items get loaded. This is for talents and skills
        if (RI_PickableStats[param->Type].LearnAsSpell != 0 && p->HasSpell(SpellId) == false)
        {
//            p->LearnSpell(SpellId, false);
            p->AddSpell(SpellId, true, true, false, false, true);
            param->ProcDataStore = new char;
        }
        //make sure buff is casted on us even if learn spell considered to no cast it
        Aura *a = p->GetAura(SpellId);
        if (a == NULL)
            p->CastSpell(p, SpellId, TRIGGERED_FULL_MASK);
        //now we should ahve it for sure
        a = p->GetAura(SpellId);
        if (a != NULL && a->GetDuration() != -1)
            a->SetDuration(-1);

        if (RI_PickableStats[param->Type].LearnSkill && p->HasSkill(RI_PickableStats[param->Type].LearnSkill) == false)
        {
            p->SetSkill(RI_PickableStats[param->Type].LearnSkill, 16, 300, 300);
            p->UpdateWeaponsSkillsToMaxSkillsForLevel();
        }
    }
    else
    {
        if (RI_PickableStats[param->Type].LearnAsSpell != 0 && param->ProcDataStore == NULL)
            p->RemoveSpell(SpellId);
        p->RemoveAura(SpellId);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
        if (RI_PickableStats[param->Type].LearnSkill)
            p->SetSkill(RI_PickableStats[param->Type].LearnSkill, 0, 0, 0);
    }
}

void RI_AS_CastOnDamge(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
            uint32 SpellId = RI_PickableStats[param->Type].AdditionalParam1;
            RI_PeriodicTickParams *Param = new RI_PeriodicTickParams;
            Param->ModFlat = SpellId;
            Param->ModPCT = 0.0f;
            Param->TickInterval = 120000;
            Param->Type = param->Type;
#ifdef _DEBUG
            Param->NextTick = 0;
#else
            Param->NextTick = GameTime::GetGameTimeMS() + Param->TickInterval;
#endif
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_CastOnDamage, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_CastOnDamage, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_SpellAuraOnCaster(bool Apply, Player *p, RI_StatStore *param)
{
    PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
    uint32 AuraId = RI_PickableStats[param->Type].AdditionalParam1;
    SpellInfo *TheSpell = GetSpellInfoForAura(AuraId);

    AuraEffect *aue;
    if (Apply == true)
    {
        aue = new AuraEffect(1, 1, NULL, TheSpell, 0);
        aue->SetAmount((int32)param->Power);
        param->ProcDataStore = aue;
    }
    else
        aue = (AuraEffect*)param->ProcDataStore;

    //apply the effect on the player
    p->_RegisterAuraEffect(aue, Apply);

    //don't leak memory
    if (Apply == false)
    {
        param->ProcDataStore = NULL;
        DebugCheckDoubleDelete( aue );
    }
}

void RI_AS_ManaPCTShield(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            RI_P_SpellModParams *Param = new RI_P_SpellModParams;
            Param->PctMod = param->Power / 100.0f;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_ManaPCTShield, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_ManaPCTShield, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_ManaShield(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            RI_P_SpellModParams *Param = new RI_P_SpellModParams;
            Param->PctMod = param->Power;
            Param->FlatMod = 0;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_ManaShield, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_ManaShield, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_LifeSteal(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            RI_P_SpellModParams *Param = new RI_P_SpellModParams;
            if (param->Type == RI_LIFE_STEAL_FLAT)
            {
                Param->FlatMod = (int32)param->Power;
                Param->PctMod = 0.0f;
            }
            else if (param->Type == RI_LIFE_STEAL_PCT)
            {
                Param->FlatMod = 0;
                Param->PctMod = param->Power / 100.0f;
            }
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_LifeSteal, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_LifeSteal, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_ManaToDamage(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            RI_P_SpellModParams *Param = new RI_P_SpellModParams;
            if (param->Type == RI_POWER_BURN_FLAT)
            {
                Param->FlatMod = (int32)param->Power;
                Param->PctMod = 0.0f;
            }
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_ManaToDamage, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_ManaToDamage, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_DamageToMana(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            RI_P_SpellModParams *Param = new RI_P_SpellModParams;
            if (param->Type == RI_DAMAGE_RECEIVED_TO_MANA)
            {
                Param->FlatMod = (int32)param->Power;
                Param->PctMod = 0.0f;
            }
            else if (param->Type == RI_DAMAGE_RECEIVED_TO_MANA_PCT)
            {
                Param->FlatMod = 0;
                Param->PctMod = param->Power / 100.0f;
            }
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_DamageToMana, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_DamageToMana, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_GoldRate(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            float *Param = new float;
            *Param = param->Power / 100.0f;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_LOOT_GOLD_GENERATED, RI_PS_GoldRate, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_LOOT_GOLD_GENERATED, RI_PS_GoldRate, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_CastOnDeadlyBlow(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
            uint32 SpellId = RI_PickableStats[param->Type].AdditionalParam1;
            RI_PeriodicTickParams *Param = new RI_PeriodicTickParams;
            Param->ModFlat = SpellId;
            Param->ModPCT = 0.0f;
            Param->TickInterval = 5*60*1000;
            Param->Type = param->Type;
#ifdef _DEBUG
            Param->NextTick = 0;
#else
            Param->NextTick = GameTime::GetGameTimeMS() + Param->TickInterval;
#endif
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_CastOnDeadlyBlow, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_CastOnDeadlyBlow, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_MinMaxDamage(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            RI_P_MinMaxDMG *Param = new RI_P_MinMaxDMG;
            Param->Coef = param->Power / 100.0f;
            Param->Flipper = 0;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_MinMaxDamage, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_MinMaxDamage, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_CastSpeedMod(bool Apply, Player *p, RI_StatStore *param)
{
    p->ApplyCastTimePercentMod(param->Power, Apply);
}

void RI_AS_ExplodeOnTargetDie(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_ExplodeOnTargetDie, NULL);
    else
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_ExplodeOnTargetDie, NULL);
}

void RI_AS_LightningOnStruck(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
            RI_P_CastOnStruck *Param = new RI_P_CastOnStruck;
            Param->ReflectPCT = param->Power / 100.0f;
            Param->SpellId = RI_PickableStats[param->Type].AdditionalParam1;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_LightningOnStruck, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_LightningOnStruck, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_DamageTakenAttackerCount(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            int32 *Param = new int32;
            *Param = (int32)param->Power;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_DamageTakenAttackerCount, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_DamageTakenAttackerCount, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_DamageTakenToDmgDone(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            RI_P_DmgTakenDone *Param = new RI_P_DmgTakenDone;
            if (param->Type == RI_DAMAGE_TAKEN_TO_DONE_FLAT)
                Param->FlatMod = (int32)param->Power;
            else
                Param->PctMod = (int32)param->Power / 100.0f;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_DamageTakenDamageDone_Taken, param->ProcDataStore);
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_DamageTakenDamageDone_Done, param->ProcDataStore,0); // do not delete on logout, the func above will
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_DamageTakenDamageDone_Taken, param->ProcDataStore);
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_DamageTakenDamageDone_Done, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_StatPCT(bool Apply, Player *p, RI_StatStore *param)
{
    //one time spell init
    static SpellInfo *spSchools[MAX_STATS+1] = { NULL };
    if (spSchools[0] == NULL)
    {
        for (int i = 0; i < MAX_STATS + 1; i++)
        {
            SpellEntry *sp = new SpellEntry();
            sp->Effect[0] = SPELL_EFFECT_APPLY_AURA;
            sp->EffectApplyAuraName[0] = SPELL_AURA_MOD_TOTAL_STAT_PERCENTAGE;
            sp->EffectImplicitTargetA[0] = TARGET_UNIT_CASTER;
            if(i == MAX_STATS)
                sp->EffectMiscValue[0] = -1;
            else
                sp->EffectMiscValue[0] = i;
            spSchools[i] = new SpellInfo(sp);
        }
    }

    //apply it visually
    int32 Val = (int32)param->Power;
    PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
    RIStatTypes s = param->Type;
    int statType = RI_PickableStats[s].AdditionalParam1;

    //apply it so functions will use the value
    AuraEffect *aue;
    if (Apply == true)
    {
        Aura *a = NULL;
        SpellInfo const *sp;
        if(statType != -1 && statType< MAX_STATS)
            sp = spSchools[statType];
        else
            sp = spSchools[MAX_STATS];
        aue = new AuraEffect(1, 1, NULL, sp, 0);
        aue->SetAmount((int32)param->Power);
        param->ProcDataStore = aue;
    }
    else
        aue = (AuraEffect*)param->ProcDataStore;

    //apply the effect on the player
    p->_RegisterAuraEffect(aue, Apply);

    //update player interface
    for (int32 i = STAT_STRENGTH; i < MAX_STATS; ++i)
    {
        if (statType == i || statType == -1) // affect the same stats
        {
            float amount = p->GetTotalAuraMultiplier(SPELL_AURA_MOD_TOTAL_STAT_PERCENTAGE, [i](AuraEffect const* aurEff) -> bool
            {
                if (aurEff->GetMiscValue() == i || aurEff->GetMiscValue() == -1)
                    return true;
                return false;
            });

            if (p->GetPctModifierValue(UnitMods(UNIT_MOD_STAT_START + i), TOTAL_PCT) == amount)
                continue;

            p->SetStatPctModifier(UnitMods(UNIT_MOD_STAT_START + i), TOTAL_PCT, amount);
            p->UpdateStatBuffMod(Stats(i));
        }
    }

    //don't leak memory
    if (Apply == false)
    {
        param->ProcDataStore = NULL;
        DebugCheckDoubleDelete( aue );
    }
}

void RI_AS_DamageTakenRaidSize(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            RI_P_SpellModParams *Param = new RI_P_SpellModParams;
            if (param->Type == RI_DMG_TAKEN_RAID_SIZE_FLAT)
                Param->FlatMod = (int32)param->Power;
            else if (param->Type == RI_DMG_TAKEN_RAID_SIZE_PCT)
                Param->PctMod = param->Power / 100.0f;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_DamageTakenRaidSize, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_DamageTakenRaidSize, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_DamageDoneRaidSize(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            RI_P_SpellModParams *Param = new RI_P_SpellModParams;
            if (param->Type == RI_DMG_DONE_RAID_SIZE_FLAT)
                Param->FlatMod = (int32)param->Power;
            else if (param->Type == RI_DMG_DONE_RAID_SIZE_PCT)
                Param->PctMod = param->Power / 100.0f;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_DamageDoneRaidSize, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_DamageDoneRaidSize, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_DamageTakenFromGold(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            int32 *Param = new int32;
            *Param = (int32)param->Power;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_DamageTakenFromGold, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_DamageTakenFromGold, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_CastTimeMod(bool Apply, Player *p, RI_StatStore *param)
{
    if(param->Power > 1000)
        p->ApplyCastTimePercentMod(1000, Apply);
    else
        p->ApplyCastTimePercentMod(param->Power, Apply);
}

void RI_AS_TalentPoints(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply)
    {
        int64 *ExtraTalents = p->GetCreateIn64Extension(OE_PLAYER_EXTRA_TALENT_POINTS);
        *ExtraTalents += (int64)param->Power;
        p->InitTalentForLevel();
    }
    else
    {
        int64 *ExtraTalents = p->GetCreateIn64Extension(OE_PLAYER_EXTRA_TALENT_POINTS);
        *ExtraTalents -= (int64)param->Power;
        p->InitTalentForLevel();
    }
    p->SendTalentsInfoData(false);
}

void RI_AS_DamageShareTank(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            RI_P_SpellModParams *Param = new RI_P_SpellModParams;
            if (param->Type == RI_SHARED_HP_TANK_FLAT)
                Param->FlatMod = (int32)param->Power;
            else if (param->Type == RI_SHARED_HP_TANK_PCT)
                Param->PctMod = param->Power / 100.0f;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_DamageTakenShareTank, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_DamageTakenShareTank, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_DamageShareCaster(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            RI_P_SpellModParams *Param = new RI_P_SpellModParams;
            if (param->Type == RI_SHARED_HP_CASTER_FLAT)
                Param->FlatMod = (int32)param->Power;
            else if (param->Type == RI_SHARED_HP_CASTER_PCT)
                Param->PctMod = param->Power / 100.0f;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_DamageTakenShareCaster, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_DamageTakenShareCaster, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_ReduceCooldownPrevSpell(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            int32 *PrevSpellId = new int32[2];
            PrevSpellId[0] = -1;
            PrevSpellId[1] = -1;
            param->ProcDataStore = PrevSpellId;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_SPELL_POST_CAST, RI_PS_ReduceCooldownPrevCast, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_SPELL_POST_CAST, RI_PS_ReduceCooldownPrevCast, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_ExtraDmgLowHealth(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            RI_P_SpellModParams *Param = new RI_P_SpellModParams;
            if (param->Type == RI_LOW_HEALTH_EXTRA_DMG_FLAT)
                Param->FlatMod = (int32)param->Power;
            else if (param->Type == RI_LOW_HEALTH_EXTRA_DMG_PCT)
                Param->PctMod = param->Power / 100.0f;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_DamageDoneLowHP, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_DamageDoneLowHP, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_ExtraEvadeLowHealth(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            int32 *Param = new int32;
            Param[0] = (int32)param->Power;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_DamageEvadeLowHP, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_DamageEvadeLowHP, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_ExtraAbsorbLowHealth(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            float *Param = new float;
            Param[0] = param->Power / 100.0f;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_DamageAbsorbLowHP, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_DamageAbsorbLowHP, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_StatRollChance(bool Apply, Player *p, RI_StatStore *param)
{
    float val = param->Power;
    RI_PlayerStore *ri = GetPlayerRIStore(p);
    RI_Stat_Type_Groups Type = RI_STTG_MAX_TYPES;
    if (param->Type == RI_STAT_DROPCHANCE)
        Type = RI_STTG_ANY;
    else if (param->Type == RI_UTIL_STAT_DROPCHANCE)
        Type = RI_STTG_UTIL;
    else if (param->Type == RI_ATTACK_STAT_DROPCHANCE)
        Type = RI_STTG_ATTACK;
    else if (param->Type == RI_DEFENSE_STAT_DROPCHANCE)
        Type = RI_STTG_DEFENSE;
    ri->ModStat(Type, (int)val, Apply);
}

void RI_AS_DamageTakenMaxHP(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            float *Param = new float;
            Param[0] = param->Power / 100.0f;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_DamageTakenMaxHP, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_DamageTakenMaxHP, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_RemoveDebuffOnHeal(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
        p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_SPELL_POST_CAST, RI_PS_OnHealDebuffTarget);
    else
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_SPELL_POST_CAST, RI_PS_OnHealDebuffTarget);
}

void RI_AS_StormStrikeOnHeal(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
        p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_SPELL_POST_CAST, RI_PS_StormStrikeOnHeal);
    else
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_SPELL_POST_CAST, RI_PS_StormStrikeOnHeal);
}

void RI_AS_DisengageOnDmgVictim(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
            uint32 SpellId = RI_PickableStats[param->Type].AdditionalParam1;
            RI_PeriodicTickParams *Param = new RI_PeriodicTickParams;
            Param->ModFlat = SpellId;
            Param->ModPCT = 0.0f;
            Param->TickInterval = 30 * 1000;
            Param->Type = param->Type;
#ifdef _DEBUG
            Param->NextTick = 0;
#else
            Param->NextTick = GameTime::GetGameTimeMS() + Param->TickInterval;
#endif
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_CastOnDamageVictim, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_CastOnDamageVictim, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_PotionCooldownOnDamageTaken(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_PotionCooldownOnDamageTaken, param->ProcDataStore);
    else
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_PotionCooldownOnDamageTaken, param->ProcDataStore);
}

void RI_AS_OverhealsToDamage(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            RI_P_DmgTakenDone *Param = new RI_P_DmgTakenDone;
            Param->PctMod = (int32)param->Power / 100.0f;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_HEAL_DONE, RI_PS_OverHealToDamage_Heal, param->ProcDataStore);
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_OverHealToDamage_Damage, param->ProcDataStore, 0); // do not delete on logout, the func above will
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_HEAL_DONE, RI_PS_OverHealToDamage_Heal, param->ProcDataStore);
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_OverHealToDamage_Damage, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_PartyMimic(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
        p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_SPELL_POST_CAST, RI_PS_PartyMimic);
    else
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_SPELL_POST_CAST, RI_PS_PartyMimic);
}

void RI_AS_HealthBasedHeal(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            float *Param = new float;
            Param[0] = (int32)param->Power / 100.0f;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_HEAL_DONE, RI_PS_HealthBasedHeal, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_HEAL_DONE, RI_PS_HealthBasedHeal, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_MirrorCast(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        RI_PeriodicTickParams *Param = new RI_PeriodicTickParams;
        Param->TickInterval = 5 * 1000;
#ifdef _DEBUG
        Param->NextTick = 0;
#else
        Param->NextTick = GameTime::GetGameTimeMS() + Param->TickInterval;
#endif
        param->ProcDataStore = Param;
        p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_SPELL_POST_CAST, RI_PS_MirrorCast, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_SPELL_POST_CAST, RI_PS_MirrorCast, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_HealDmg_UniqueKill(bool Apply, Player *p, RI_StatStore *param)
{
    CallbackEventTypes ProcType;
    if (param->Type == RI_DAMAGE_FOR_UNIQUE_KILL)
        ProcType = CALLBACK_TYPE_DMG_DONE;
    else
        ProcType = CALLBACK_TYPE_HEAL_DONE;
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            float *Param = new float;
            Param[0] = param->Power;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(ProcType, RI_PS_HealDmg_UniqueKill, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(ProcType, RI_PS_HealDmg_UniqueKill, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_HealDmg_UniqueItemUse(bool Apply, Player *p, RI_StatStore *param)
{
    CallbackEventTypes ProcType;
    if (param->Type == RI_DAMAGE_FOR_UNIQUE_KILL)
        ProcType = CALLBACK_TYPE_DMG_DONE;
    else
        ProcType = CALLBACK_TYPE_HEAL_DONE;
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            float *Param = new float;
            Param[0] = param->Power;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(ProcType, RI_PS_HealDmg_UniqueItemUse, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(ProcType, RI_PS_HealDmg_UniqueItemUse, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_HealDmg_Achievements(bool Apply, Player *p, RI_StatStore *param)
{
    CallbackEventTypes ProcType;
    if (param->Type == RI_DAMAGE_FOR_UNIQUE_KILL)
        ProcType = CALLBACK_TYPE_DMG_DONE;
    else
        ProcType = CALLBACK_TYPE_HEAL_DONE;
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            float *Param = new float;
            Param[0] = param->Power;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(ProcType, RI_PS_HealDmg_Achievements, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(ProcType, RI_PS_HealDmg_Achievements, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_HealDmg_Quests(bool Apply, Player *p, RI_StatStore *param)
{
    CallbackEventTypes ProcType;
    if (param->Type == RI_DMG_FOR_QUESTS)
        ProcType = CALLBACK_TYPE_DMG_DONE;
    else
        ProcType = CALLBACK_TYPE_HEAL_DONE;
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            float *Param = new float;
            Param[0] = param->Power;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(ProcType, RI_PS_HealDmg_Quests, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(ProcType, RI_PS_HealDmg_Quests, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_HealDmg_HonorableKills(bool Apply, Player *p, RI_StatStore *param)
{
    CallbackEventTypes ProcType;
    if (param->Type == RI_DAMAGE_FOR_UNIQUE_KILL)
        ProcType = CALLBACK_TYPE_DMG_DONE;
    else
        ProcType = CALLBACK_TYPE_HEAL_DONE;
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            float *Param = new float;
            Param[0] = param->Power;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(ProcType, RI_PS_HealDmg_HonorableKills, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(ProcType, RI_PS_HealDmg_HonorableKills, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete( param->ProcDataStore );
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_LearnSpell(bool Apply, Player *p, RI_StatStore *param)
{
    PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
    uint32 SpellId = RI_PickableStats[param->Type].AdditionalParam1;
    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(SpellId);
    if (Apply == true)
    {
        param->ProcDataStore = NULL;
        if (RI_PickableStats[param->Type].LearnAsSpell != 0)
        {
            p->AddSpell(SpellId, true, true, false, false, true);
            param->ProcDataStore = new char;
        }
    }
    else
    {
        if (RI_PickableStats[param->Type].LearnAsSpell != 0 && param->ProcDataStore == NULL)
            p->RemoveSpell(SpellId);
        p->RemoveAura(SpellId);
        p->RemoveOwnedAura(SpellId, p->GetGUID());
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_ThreathMod(bool Apply, Player *p, RI_StatStore *param)
{
    PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
    uint32 AuraId = RI_PickableStats[param->Type].AdditionalParam1;
    SpellInfo *TheSpell = GetSpellInfoForAura(AuraId, SPELL_SCHOOL_MASK_ALL);

    AuraEffect *aue;
    if (Apply == true)
    {
        aue = new AuraEffect(1, 1, NULL, TheSpell, 0);
        aue->SetAmount((int32)param->Power);
        param->ProcDataStore = aue;
    }
    else
        aue = (AuraEffect*)param->ProcDataStore;

    //apply the effect on the player
    p->_RegisterAuraEffect(aue, Apply);

    //don't leak memory
    if (Apply == false)
    {
        param->ProcDataStore = NULL;
        DebugCheckDoubleDelete(aue);
    }

    p->GetThreatManager().UpdateMySpellSchoolModifiers();
}

void RI_AS_ThreathModPet(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            int32 *Param = new int32;
            Param[0] = (int32)param->Power;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_SUMMON_GUARDIAN, RI_PS_PetThreath, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_SUMMON_GUARDIAN, RI_PS_PetThreath, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_PetAura(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
            uint32 SpellId = RI_PickableStats[param->Type].AdditionalParam1;
            int32 *Param = new int32;
            Param[0] = SpellId;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_SUMMON_GUARDIAN, RI_PS_PetAura, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_SUMMON_GUARDIAN, RI_PS_PetAura, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_HealDmg_LoginStreak(bool Apply, Player *p, RI_StatStore *param)
{
    CallbackEventTypes ProcType;
    if (param->Type == RI_DMG_LOGIN_STREAK)
        ProcType = CALLBACK_TYPE_DMG_DONE;
    else
        ProcType = CALLBACK_TYPE_HEAL_DONE;
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            float *Param = new float;
            Param[0] = param->Power;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(ProcType, RI_PS_HealDmg_LoginStreak, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(ProcType, RI_PS_HealDmg_LoginStreak, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_AutoChargeOnTargetSwap(bool Apply, Player *p, RI_StatStore *param)
{
    if (param->ProcDataStore == NULL)
    {
        RI_P_AutoCharge *Param = new RI_P_AutoCharge;
        param->ProcDataStore = Param;
        p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_PERIODIC_TICK, RI_PS_AutoChargeTargetSwap, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_PERIODIC_TICK, RI_PS_AutoChargeTargetSwap, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_StatToSpellDmg(bool Apply, Player *p, RI_StatStore *param)
{
    //one time spell init
    static SpellInfo *spSchools[MAX_STATS] = { NULL };
    if (spSchools[0] == NULL)
    {
        for (int i = 0; i < MAX_STATS; i++)
        {
            SpellEntry *sp = new SpellEntry();
            sp->Effect[0] = SPELL_EFFECT_APPLY_AURA;
            sp->EffectApplyAuraName[0] = SPELL_AURA_MOD_SPELL_DAMAGE_OF_STAT_PERCENT;
            sp->EffectImplicitTargetA[0] = TARGET_UNIT_CASTER;
            sp->EffectMiscValue[0] = SPELL_SCHOOL_MASK_ALL;
            sp->EffectMiscValueB[0] = i;
            spSchools[i] = new SpellInfo(sp);
        }
    }

    //apply it visually
    int32 Val = (int32)param->Power;
    PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
    RIStatTypes s = param->Type;
    int statType = RI_PickableStats[s].AdditionalParam1;

    //apply it so functions will use the value
    AuraEffect *aue;
    if (Apply == true)
    {
        Aura *a = NULL;
        SpellInfo const *sp;
        sp = spSchools[statType];
        aue = new AuraEffect(1, 1, NULL, sp, 0);
        aue->SetAmount((int32)param->Power);
        param->ProcDataStore = aue;
    }
    else
        aue = (AuraEffect*)param->ProcDataStore;

    //apply the effect on the player
    p->_RegisterAuraEffect(aue, Apply);
    p->UpdateSpellDamageAndHealingBonus();

    //don't leak memory
    if (Apply == false)
    {
        param->ProcDataStore = NULL;
        DebugCheckDoubleDelete(aue);
    }
}

void RI_AS_StatToSpellHeal(bool Apply, Player *p, RI_StatStore *param)
{
    //one time spell init
    static SpellInfo *spSchools[MAX_STATS] = { NULL };
    if (spSchools[0] == NULL)
    {
        for (int i = 0; i < MAX_STATS; i++)
        {
            SpellEntry *sp = new SpellEntry();
            sp->Effect[0] = SPELL_EFFECT_APPLY_AURA;
            sp->EffectApplyAuraName[0] = SPELL_AURA_MOD_SPELL_HEALING_OF_STAT_PERCENT;
            sp->EffectImplicitTargetA[0] = TARGET_UNIT_CASTER;
            sp->EffectMiscValue[0] = i;
            sp->EffectMiscValueB[0] = i;
            spSchools[i] = new SpellInfo(sp);
        }
    }

    //apply it visually
    int32 Val = (int32)param->Power;
    PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
    RIStatTypes s = param->Type;
    int statType = RI_PickableStats[s].AdditionalParam1;

    //apply it so functions will use the value
    AuraEffect *aue;
    if (Apply == true)
    {
        Aura *a = NULL;
        SpellInfo const *sp;
        sp = spSchools[statType];
        aue = new AuraEffect(1, 1, NULL, sp, 0);
        aue->SetAmount((int32)param->Power);
        param->ProcDataStore = aue;
    }
    else
        aue = (AuraEffect*)param->ProcDataStore;

    //apply the effect on the player
    p->_RegisterAuraEffect(aue, Apply);
    p->UpdateSpellDamageAndHealingBonus();

    //don't leak memory
    if (Apply == false)
    {
        param->ProcDataStore = NULL;
        DebugCheckDoubleDelete(aue);
    }
}

void RI_AS_HealAbsorbRecharge(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            float *Param = new float;
            Param[0] = param->Power / 100.0f;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_HEAL_RECEIVED, RI_PS_HealAbsorbRecharge, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_HEAL_RECEIVED, RI_PS_HealAbsorbRecharge, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_TransmogDiscover(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        p->RegisterCallbackFunc(CALLBACK_TYPE_TARGET_KILL, RI_PS_TransmogDiscover);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_TARGET_KILL, RI_PS_TransmogDiscover);
    }
}

void RI_AS_CastOnMove_Location(bool Apply, Player *p, RI_StatStore *param)
{
    if (param->ProcDataStore == NULL)
    {
        RI_P_CastOnMove *Param = new RI_P_CastOnMove(p);
        Param->TickInterval = 1000;
        param->ProcDataStore = Param;
        p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_PERIODIC_TICK, RI_PS_CastOnMove_Location, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_PERIODIC_TICK, RI_PS_CastOnMove_Location, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_CastOnMove_FreeSpell(bool Apply, Player *p, RI_StatStore *param)
{
    if (param->ProcDataStore == NULL)
    {
        RI_P_CastOnMove *Param = new RI_P_CastOnMove(p);
        param->ProcDataStore = Param;
        p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_SPELL_POST_CAST, RI_PS_CastOnMove_RegisterSpell, param->ProcDataStore,0);
        p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_PERIODIC_TICK, RI_PS_CastOnMove_CastSpell, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_SPELL_POST_CAST, RI_PS_CastOnMove_RegisterSpell, param->ProcDataStore);
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_PERIODIC_TICK, RI_PS_CastOnMove_CastSpell, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_StatToAttackPower(bool Apply, Player *p, RI_StatStore *param)
{
    //one time spell init
    static SpellInfo *spSchools[MAX_STATS] = { NULL };
    if (spSchools[0] == NULL)
    {
        for (int i = 0; i < MAX_STATS; i++)
        {
            SpellEntry *sp = new SpellEntry();
            sp->Effect[0] = SPELL_EFFECT_APPLY_AURA;
            sp->EffectApplyAuraName[0] = SPELL_AURA_MOD_ATTACK_POWER_OF_STAT_PERCENT;
            sp->EffectImplicitTargetA[0] = TARGET_UNIT_CASTER;
            sp->EffectMiscValue[0] = i;
            sp->EffectMiscValueB[0] = i;
            spSchools[i] = new SpellInfo(sp);
        }
    }

    //apply it visually
    int32 Val = (int32)param->Power;
    PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
    RIStatTypes s = param->Type;
    int statType = RI_PickableStats[s].AdditionalParam1;

    //apply it so functions will use the value
    AuraEffect *aue;
    if (Apply == true)
    {
        Aura *a = NULL;
        SpellInfo const *sp;
        sp = spSchools[statType];
        aue = new AuraEffect(1, 1, NULL, sp, 0);
        aue->SetAmount((int32)param->Power);
        param->ProcDataStore = aue;
    }
    else
        aue = (AuraEffect*)param->ProcDataStore;

    //apply the effect on the player
    p->_RegisterAuraEffect(aue, Apply);
    p->UpdateSpellDamageAndHealingBonus();

    //don't leak memory
    if (Apply == false)
    {
        param->ProcDataStore = NULL;
        DebugCheckDoubleDelete(aue);
    }
}

void RI_AS_StatToRangedAttackPower(bool Apply, Player *p, RI_StatStore *param)
{
    //one time spell init
    static SpellInfo *spSchools[MAX_STATS] = { NULL };
    if (spSchools[0] == NULL)
    {
        for (int i = 0; i < MAX_STATS; i++)
        {
            SpellEntry *sp = new SpellEntry();
            sp->Effect[0] = SPELL_EFFECT_APPLY_AURA;
            sp->EffectApplyAuraName[0] = SPELL_AURA_MOD_RANGED_ATTACK_POWER_OF_STAT_PERCENT;
            sp->EffectImplicitTargetA[0] = TARGET_UNIT_CASTER;
            sp->EffectMiscValue[0] = i;
            sp->EffectMiscValueB[0] = i;
            spSchools[i] = new SpellInfo(sp);
        }
    }

    //apply it visually
    int32 Val = (int32)param->Power;
    PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
    RIStatTypes s = param->Type;
    int statType = RI_PickableStats[s].AdditionalParam1;

    //apply it so functions will use the value
    AuraEffect *aue;
    if (Apply == true)
    {
        Aura *a = NULL;
        SpellInfo const *sp;
        sp = spSchools[statType];
        aue = new AuraEffect(1, 1, NULL, sp, 0);
        aue->SetAmount((int32)param->Power);
        param->ProcDataStore = aue;
    }
    else
        aue = (AuraEffect*)param->ProcDataStore;

    //apply the effect on the player
    p->_RegisterAuraEffect(aue, Apply);
    p->UpdateSpellDamageAndHealingBonus();

    //don't leak memory
    if (Apply == false)
    {
        param->ProcDataStore = NULL;
        DebugCheckDoubleDelete(aue);
    }
}

void RI_AS_AllowCastWhileMove(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        int64 *t = p->GetCreateIn64Extension(OE_PLAYER_CAST_WHILE_MOVE);
        t[0]++;
    }
    else
    {
        int64 *t = p->GetCreateIn64Extension(OE_PLAYER_CAST_WHILE_MOVE);
        t[0]--;
    }
}

void RI_AS_AllowCastWhileCast(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        int64 *t = p->GetCreateIn64Extension(OE_PLAYER_CAST_WHILE_CAST);
        t[0]++;
    }
    else
    {
        int64 *t = p->GetCreateIn64Extension(OE_PLAYER_CAST_WHILE_CAST);
        t[0]--;
    }
}

void RI_AS_AllowCastNoFace(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        int64 *t = p->GetCreateIn64Extension(OE_PLAYER_CAST_WHILE_BAD_FACING);
        t[0]++;
    }
    else
    {
        int64 *t = p->GetCreateIn64Extension(OE_PLAYER_CAST_WHILE_BAD_FACING);
        t[0]--;
    }
}

void RI_AS_MeleeHasteToDMG(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            float *Param = new float;
            Param[0] = param->Power / 100.0f - 1.0f;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_MeleeHasteToDMG, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_MeleeHasteToDMG, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_RangedHasteToDMG(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            float *Param = new float;
            Param[0] = param->Power / 100.0f - 1.0f;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_RangedHasteToDMG, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_RangedHasteToDMG, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_SpellHasteToDMG(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            float *Param = new float;
            Param[0] = param->Power / 100.0f - 1.0f;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_SpellHasteToDMG, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_SpellHasteToDMG, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_SpellHasteToHeal(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            float *Param = new float;
            Param[0] = param->Power / 100.0f - 1.0f;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_HEAL_DONE, RI_PS_SpellHasteToDMG, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_HEAL_DONE, RI_PS_SpellHasteToDMG, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_SpellModFlatSpellTarget(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
            RI_P_SpellModParams *Param = new RI_P_SpellModParams;
            Param->FlatMod = (int32)param->Power;
            Param->Type = RI_PickableStats[param->Type].SpellMod;
            Param->PctMod = 0.0f;
            param->ProcDataStore = Param;
            if (Param->Type == SPELLMOD_DURATION)
                Param->FlatMod *= 1000;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_SPELL_MOD_APPLY, RI_PS_SpellModSpellTarget, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_SPELL_MOD_APPLY, RI_PS_SpellModSpellTarget, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_ChangeDmgType(bool Apply, Player *p, RI_StatStore *param)
{
    struct ChangeSchoolMaskStore
    {
        uint32 SchoolChangeCounter[MAX_SPELL_SCHOOL];
    };

    PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
    uint32 SelectedSchool = RI_PickableStats[param->Type].AdditionalParam1;
    ChangeSchoolMaskStore *ChangeSchoolsStore = p->GetExtension<ChangeSchoolMaskStore>(OE_PLAYER_CHANGE_DAMGE_SCHOOL_MASK_STORE);
    if (Apply == true)
    {
        uint32 *ChangeSchools = p->GetCreateExtension<uint32>(OE_PLAYER_CHANGE_DAMGE_SCHOOL_MASK,0);
        ChangeSchools[0] |= ( 1 << SelectedSchool);
        if (ChangeSchoolsStore == NULL)
        {
            ChangeSchoolsStore = new ChangeSchoolMaskStore;
            memset(ChangeSchoolsStore, 0, sizeof(ChangeSchoolMaskStore));
            p->SetExtension<ChangeSchoolMaskStore>(OE_PLAYER_CHANGE_DAMGE_SCHOOL_MASK_STORE, ChangeSchoolsStore);
        }
        ChangeSchoolsStore->SchoolChangeCounter[SelectedSchool]++;
    }
    else
    {
        ChangeSchoolsStore->SchoolChangeCounter[SelectedSchool]--;
        if (ChangeSchoolsStore->SchoolChangeCounter[SelectedSchool] == 0)
        {
            uint32 *ChangeSchools = p->GetCreateExtension<uint32>(OE_PLAYER_CHANGE_DAMGE_SCHOOL_MASK,0);
            ChangeSchools[0] = ChangeSchools[0] & (~(1 << SelectedSchool));
        }
    }
}

void RI_AS_SlamOnJump(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            RI_P_CastOnJump *Param = new RI_P_CastOnJump;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_FALL_LAND, RI_PS_SlamOnJump, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_FALL_LAND, RI_PS_SlamOnJump, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_ElectrocuteWhileCast(bool Apply, Player *p, RI_StatStore *param)
{
    if (param->ProcDataStore == NULL)
    {
        RI_P_CastWhileCast *Param = new RI_P_CastWhileCast();
        param->ProcDataStore = Param;
        p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_PERIODIC_TICK, RI_PS_ElectrocuteWhileCast, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_PERIODIC_TICK, RI_PS_ElectrocuteWhileCast, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_DiabloTransform(bool Apply, Player *p, RI_StatStore *param)
{
    if (param->ProcDataStore == NULL)
    {
        RI_PeriodicTickParams *Param = new RI_PeriodicTickParams();
        Param->TickInterval = 3000;
        Param->ModFlat = 34359;
        param->ProcDataStore = Param;
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_DiabloCastFireBreath, param->ProcDataStore);

        uint32 *MorphDisplayId = p->GetCreateExtension<uint32>(OE_PLAYER_MORPH_DISPLAYID);
        float *MorphSize = p->GetCreateExtension<float>(OE_PLAYER_MORPH_SIZE);
        *MorphDisplayId = 10992; // npc id 11326 
        *MorphSize = 4.0f;
        p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_PERIODIC_TICK, RI_PS_TransformLook, NULL);
    }
    else
    {
        uint32 *MorphDisplayId = p->GetCreateExtension<uint32>(OE_PLAYER_MORPH_DISPLAYID);
        *MorphDisplayId = p->GetNativeDisplayId();
        p->SetDisplayId(p->GetNativeDisplayId());
        p->SetObjectScale(1.0f);
        float *MorphSize = p->GetCreateExtension<float>(OE_PLAYER_MORPH_SIZE);
        MorphSize[0] = 1.0f;

        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_DiabloCastFireBreath, param->ProcDataStore);
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_PERIODIC_TICK, RI_PS_TransformLook, NULL);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_DistanceHealBoost(bool Apply, Player *p, RI_StatStore *param)
{
    //register a proc on caster for each time he does dmg
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            float *Param = new float;
            *Param = param->Power / 100.0f;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_HEAL_DONE, RI_PS_DistanceHealBoost, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_HEAL_DONE, RI_PS_DistanceHealBoost, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_BloodLustOnDamageTaken(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
            uint32 SpellId = RI_PickableStats[param->Type].AdditionalParam1;
            RI_PeriodicTickParams *Param = new RI_PeriodicTickParams;
            Param->ModFlat = SpellId;
            Param->ModPCT = 0.0f;
            Param->TickInterval = 5 * 60 * 1000;
            Param->Type = param->Type;
#ifdef _DEBUG
            Param->NextTick = 0;
#else
            Param->NextTick = GameTime::GetGameTimeMS() + Param->TickInterval;
#endif
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_BloodLustOnDamageTaken, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_BloodLustOnDamageTaken, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_MoveExpode(bool Apply, Player *p, RI_StatStore *param)
{
    if (param->ProcDataStore == NULL)
    {
        RI_P_CastOnMove *Param = new RI_P_CastOnMove(p);
        Param->TickInterval = 500;
        Param->NextTick = GameTime::GetGameTimeMS() + Param->TickInterval;
        Param->PrevSpell = 0; // ticks we moved before stopping
        param->ProcDataStore = Param;
        p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_PERIODIC_TICK, RI_PS_MoveExpode, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_PERIODIC_TICK, RI_PS_MoveExpode, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_SpellModFlatSpellRange(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
            RI_P_SpellModParams *Param = new RI_P_SpellModParams;
            Param->FlatMod = (int32)param->Power;
            Param->Type = RI_PickableStats[param->Type].SpellMod;
            Param->PctMod = 0.0f;
            param->ProcDataStore = Param;
            if (Param->Type == SPELLMOD_DURATION)
                Param->FlatMod *= 1000;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_SPELL_MOD_APPLY, RI_PS_SpellModSpellRange, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_SPELL_MOD_APPLY, RI_PS_SpellModSpellRange, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
    int32 *ModOtherItems = p->GetExtension<int32>(OE_PLAYER_SPELL_MOD_RANGE_FLAT);
    if (ModOtherItems == NULL)
    {
        ModOtherItems = p->GetCreateExtension<int32>(OE_PLAYER_SPELL_MOD_RANGE_FLAT);
        *ModOtherItems = 0;
    }
    int32 val = Apply ? (int32)param->Power : (int32)-param->Power;
    *ModOtherItems += val;
    for (int i = 0; i < 3 * 32; i++)
    {
        WorldPacket data(SMSG_SET_FLAT_SPELL_MODIFIER, (1 + 1 + 4));
        data << uint8(i);
        data << uint8(SPELLMOD_RANGE);
        data << int32(*ModOtherItems);
        p->SendDirectMessage(&data);
    }
}

void RI_AS_AuraMaxStacks(bool Apply, Player *p, RI_StatStore *param)
{
    int32 *MaxStacks = p->GetExtension<int32>(OE_PLAYER_MAX_AURA_STACKS);
    if (param->ProcDataStore == NULL)
    {
        if (MaxStacks == NULL)
        {
            MaxStacks = p->GetCreateExtension<int32>(OE_PLAYER_MAX_AURA_STACKS);
            MaxStacks[0] = 0;
        }
        if (param->Power > MaxStacks[0])
//            MaxStacks[0] = (int32)param->Power;
          MaxStacks[0] = 2;
        p->RegisterCallbackFunc(CALLBACK_TYPE_SAME_AURA_CAN_STACK, RI_PS_AuraMaxStacks, NULL);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_SAME_AURA_CAN_STACK, RI_PS_AuraMaxStacks, NULL);
        if (MaxStacks[0] == (int32)param->Power)
            MaxStacks[0] = 0;
    }
}

void RI_AS_ArmorToResistance(bool Apply, Player *p, RI_StatStore *param)
{
    if (param->ProcDataStore == NULL)
    {
        PossibleRandomStatRolls * RI_PickableStats = GetPickableStatStore();
        RI_PeriodicTickParams *Param = new RI_PeriodicTickParams();
        Param->TickInterval = 500;
        Param->NextTick = GameTime::GetGameTimeMS() + Param->TickInterval;
        Param->ModFlat = 0; // added value on previous tick
        Param->ModPCT = param->Power / 100.0f;
        Param->Type = RI_PickableStats[param->Type].UnitMod;
        param->ProcDataStore = Param;
        p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_PERIODIC_TICK, RI_PS_ArmorToResistance, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_PERIODIC_TICK, RI_PS_ArmorToResistance, param->ProcDataStore);
        //remove previously applied value
        RI_PeriodicTickParams *Param = (RI_PeriodicTickParams*)param->ProcDataStore;
        p->HandleStatFlatModifier((UnitMods)Param->Type, TOTAL_VALUE, (float)(Param->ModFlat), false);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_HealNearbyPlayer(bool Apply, Player *p, RI_StatStore *param)
{
    //register a proc on caster for each time he does dmg
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            float *Param = new float;
            *Param = param->Power / 100.0f;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_HEAL_DONE, RI_PS_HealNearbyPlayer, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_HEAL_DONE, RI_PS_HealNearbyPlayer, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_DmgNearbyPlayer(bool Apply, Player *p, RI_StatStore *param)
{
    //register a proc on caster for each time he does dmg
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            float *Param = new float;
            *Param = param->Power / 100.0f;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_HealNearbyPlayer, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_HealNearbyPlayer, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_DustGainPCT(bool Apply, Player *p, RI_StatStore *param)
{
    //register a proc on caster for each time he does dmg
    float *PCT = p->GetExtension<float>(OE_PLAYER_DUST_GAIN_PCT);
    if (Apply == true)
    {
        if (PCT == NULL)
        {
            PCT = p->GetCreateExtension<float>(OE_PLAYER_DUST_GAIN_PCT);
            PCT[0] = 1.0f;
        }
        PCT[0] += param->Power / 100.0f;
    }
    else
    {
        PCT[0] -= param->Power / 100.0f;
    }
}

void RI_AS_KillStreakDMG(bool Apply, Player *p, RI_StatStore *param)
{
    if (param->ProcDataStore == NULL)
    {
        RI_PeriodicTickParams *Param = new RI_PeriodicTickParams();
        Param->TickInterval = 5 * 60 * 1000; // re reset our kill streak counter at this interval
        Param->NextTick = GameTime::GetGameTimeMS() + Param->TickInterval;
        Param->ModFlat = (int)param->Power;
        Param->ModPCT = 0;  // the counter
        param->ProcDataStore = Param;
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_KillStreakDmgAdd, param->ProcDataStore, 0);
        p->RegisterCallbackFunc(CALLBACK_TYPE_TARGET_KILL, RI_PS_KillStreakIncrease, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_KillStreakDmgAdd, param->ProcDataStore);
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_TARGET_KILL, RI_PS_KillStreakIncrease, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_LowHealthHealStreak(bool Apply, Player *p, RI_StatStore *param)
{
    if (param->ProcDataStore == NULL)
    {
        RI_P_SpellModParams *Param = new RI_P_SpellModParams();
        Param->FlatMod = (int)param->Power;
        Param->PctMod = 0;  // the counter
        param->ProcDataStore = Param;
        p->RegisterCallbackFunc(CALLBACK_TYPE_HEAL_DONE, RI_PS_LowHealthHealStreak, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_HEAL_DONE, RI_PS_LowHealthHealStreak, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_SimilarDamageTaken(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            int32 *DamageSum = new int32;
            param->ProcDataStore = DamageSum;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_SimilarDamageTaken, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_SimilarDamageTaken, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_DamageTakenSplitOverTime(bool Apply, Player *p, RI_StatStore *param)
{
    if (param->ProcDataStore == NULL)
    {
        RI_P_DamageTakenSmoothed *Param = new RI_P_DamageTakenSmoothed();
        Param->DividePeriod = (uint32)param->Power / (Param->TickInterval / 1000);
        param->ProcDataStore = Param;
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_DamageTakenSplitOverTime_SumDmg, param->ProcDataStore, 0);
        p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_PERIODIC_TICK, RI_PS_DamageTakenSplitOverTime_DealDmg, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_DamageTakenSplitOverTime_SumDmg, param->ProcDataStore);
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_PERIODIC_TICK, RI_PS_DamageTakenSplitOverTime_DealDmg, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_PowerRegenFlat(bool Apply, Player *p, RI_StatStore *param)
{
    //one time spell init
    static SpellInfo *spSchools[MAX_POWERS] = { NULL };
    if (spSchools[0] == NULL)
    {
        for (int i = 0; i < MAX_POWERS; i++)
        {
            SpellEntry *sp = new SpellEntry();
            sp->Effect[0] = SPELL_EFFECT_APPLY_AURA;
            sp->EffectApplyAuraName[0] = SPELL_AURA_MOD_POWER_REGEN;
            sp->EffectImplicitTargetA[0] = TARGET_UNIT_CASTER;
            sp->EffectMiscValue[0] = i;
            spSchools[i] = new SpellInfo(sp);
        }
    }

    //apply it visually
    int32 Val = (int32)param->Power;
    PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
    RIStatTypes s = param->Type;
    int statType = RI_PickableStats[s].SpellMod;


    //apply it so functions will use the value
    AuraEffect *aue;
    if (Apply == true)
    {
        Aura *a = NULL;
        SpellInfo const *sp = spSchools[statType];
        aue = new AuraEffect(1, 1, NULL, sp, 0);
        aue->SetAmount((int32)param->Power);
        param->ProcDataStore = aue;
    }
    else
        aue = (AuraEffect*)param->ProcDataStore;

    //apply the effect on the player
    p->_RegisterAuraEffect(aue, Apply);

    if (aue->GetMiscValue() == POWER_MANA)
        p->UpdateManaRegen();

    //don't leak memory
    if (Apply == false)
    {
        param->ProcDataStore = NULL;
        DebugCheckDoubleDelete(aue);
    }
}

void RI_AS_PowerRegenPCT(bool Apply, Player *p, RI_StatStore *param)
{
    //one time spell init
    static SpellInfo *spSchools[MAX_POWERS] = { NULL };
    if (spSchools[0] == NULL)
    {
        for (int i = 0; i < MAX_POWERS; i++)
        {
            SpellEntry *sp = new SpellEntry();
            sp->Effect[0] = SPELL_EFFECT_APPLY_AURA;
            sp->EffectApplyAuraName[0] = SPELL_AURA_MOD_POWER_REGEN_PERCENT;
            sp->EffectImplicitTargetA[0] = TARGET_UNIT_CASTER;
            sp->EffectMiscValue[0] = i;
            spSchools[i] = new SpellInfo(sp);
        }
    }

    //apply it visually
    int32 Val = (int32)param->Power;
    PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
    RIStatTypes s = param->Type;
    int statType = RI_PickableStats[s].SpellMod;

    //apply it so functions will use the value
    AuraEffect *aue;
    if (Apply == true)
    {
        Aura *a = NULL;
        SpellInfo const *sp = spSchools[statType];
        aue = new AuraEffect(1, 1, NULL, sp, 0);
        aue->SetAmount((int32)param->Power);
        param->ProcDataStore = aue;
    }
    else
        aue = (AuraEffect*)param->ProcDataStore;

    //apply the effect on the player
    p->_RegisterAuraEffect(aue, Apply);

    if (aue->GetMiscValue() == POWER_MANA)
        p->UpdateManaRegen();

    //don't leak memory
    if (Apply == false)
    {
        param->ProcDataStore = NULL;
        DebugCheckDoubleDelete(aue);
    }
}

void RI_AS_PowerRegenRune(bool Apply, Player *p, RI_StatStore *param)
{
    //one time spell init
    static SpellInfo *spSchools[NUM_RUNE_TYPES] = { NULL };
    if (spSchools[0] == NULL)
    {
        for (int i = 0; i < NUM_RUNE_TYPES; i++)
        {
            SpellEntry *sp = new SpellEntry();
            sp->Effect[0] = SPELL_EFFECT_APPLY_AURA;
            sp->EffectApplyAuraName[0] = SPELL_AURA_MOD_POWER_REGEN_PERCENT;
            sp->EffectImplicitTargetA[0] = TARGET_UNIT_CASTER;
            sp->EffectMiscValue[0] = POWER_RUNE;
            sp->EffectMiscValueB[0] = i;
            spSchools[i] = new SpellInfo(sp);
        }
    }

    //apply it visually
    int32 Val = (int32)param->Power;
    PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
    RIStatTypes s = param->Type;
    int statType = RI_PickableStats[s].SpellMod;

    //apply it so functions will use the value
    AuraEffect *aue;
    if (Apply == true)
    {
        Aura *a = NULL;
        SpellInfo const *sp = spSchools[statType];
        aue = new AuraEffect(1, 1, NULL, sp, 0);
        aue->SetAmount((int32)param->Power);
        param->ProcDataStore = aue;
    }
    else
        aue = (AuraEffect*)param->ProcDataStore;

    //apply the effect on the player
    p->_RegisterAuraEffect(aue, Apply);

   p->UpdateRuneRegen(RuneType(aue->GetMiscValueB()));

    //don't leak memory
    if (Apply == false)
    {
        param->ProcDataStore = NULL;
        DebugCheckDoubleDelete(aue);
    }
}

void RI_AS_CastOnKill(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
        uint32 SpellId = RI_PickableStats[param->Type].AdditionalParam1;
        uint32 *Param = new uint32();
        Param[0] = SpellId;
        param->ProcDataStore = Param;
        p->RegisterCallbackFunc(CALLBACK_TYPE_TARGET_KILL, RI_PS_CastOnKill, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_TARGET_KILL, RI_PS_CastOnKill, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_ExtraDmgWhileBehindTarget_Flat(bool Apply, Player *p, RI_StatStore *param)
{
    //register a proc on caster for each time he does dmg
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            int32 *Param = new int32;
            Param[0] = (int32)param->Power;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_ExtraDmgWhileBehindTarget_Flat, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_ExtraDmgWhileBehindTarget_Flat, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_ExtraDmgReduceWhileInFrontTarget_Flat(bool Apply, Player *p, RI_StatStore *param)
{
    //register a proc on caster for each time he does dmg
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            int32 *Param = new int32;
            Param[0] = (int32)param->Power;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_ExtraDmgReduceWhileInFrontTarget_Flat, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_ExtraDmgReduceWhileInFrontTarget_Flat, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_HealsRestoreDamageTaken(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        RI_P_SpellModParams *Param = new RI_P_SpellModParams();
        Param->FlatMod = 0; //we will store last damage here
        Param->PctMod = param->Power; 
        param->ProcDataStore = Param;
        p->RegisterCallbackFunc(CALLBACK_TYPE_HEAL_DONE, RI_PS_HealsRestoreDamageTaken_Heal, param->ProcDataStore, 0);
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_HealsRestoreDamageTaken_Dmg, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_HEAL_DONE, RI_PS_HealsRestoreDamageTaken_Heal, param->ProcDataStore);
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_HealsRestoreDamageTaken_Dmg, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_SpellsRestoreMana(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        float *Param = new float;
        Param[0] = param->Power;
        param->ProcDataStore = Param;
        p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_SPELL_POST_CAST, NULL, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_SPELL_POST_CAST, NULL, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

/*
void RI_AS_XPGain(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        float *Param = new float;
        Param[0] = param->Power / 100.0f;
        param->ProcDataStore = Param;
        p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_KILL_CREATURE, NULL, param->ProcDataStore, 0);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_KILL_CREATURE, NULL, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}
*/

void RI_AS_SingleTargetToAOE(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        float *SummedConversion = p->GetCreateExtension<float>(OE_PLAYER_AOE_DMG_COEF);
        uint32 *SummedDmg = p->GetCreateExtension<uint32>(OE_PLAYER_AOE_DMG, 0);
        SummedConversion[0] = param->Power / 100.0f;
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_SingleTargetToAOE, NULL); // should register only once
    }
    else
    {
        float *SummedConversion = p->GetExtension<float>(OE_PLAYER_AOE_DMG_COEF);
        SummedConversion[0] -= param->Power / 100.0f;
        if(SummedConversion[0] <= 0)
            p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_SingleTargetToAOE, NULL);
    }
}

void RI_AS_CastOnHit(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
            uint32 SpellId = RI_PickableStats[param->Type].AdditionalParam1;
            uint32 *Param = new uint32;
            Param[0] = SpellId;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_CastOnHit, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_CastOnHit, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_LightningOnHit(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
            RI_P_CastOnStruck *Param = new RI_P_CastOnStruck;
            Param->ReflectPCT = param->Power / 100.0f;
            Param->SpellId = RI_PickableStats[param->Type].AdditionalParam1;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_LightningOnStruck, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, RI_PS_LightningOnStruck, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_HealthToDamage(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            RI_P_SpellModParams *Param = new RI_P_SpellModParams;
            if (param->Type == RI_HEALTH_TO_DAMAGE)
            {
                Param->FlatMod = (int32)param->Power;
                Param->PctMod = 0.0f;
            }
/*            else if (param->Type == RI_POWER_BURN_PCT)
            {
                Param->FlatMod = 0;
                Param->PctMod = param->Power / 100.0f;
            }*/
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_HealthToDamage, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_HealthToDamage, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_PowerMissingToDMGPCT(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            float *Param = new float;
            Param[0] = param->Power / 100.0f;
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_PowerMissingToDMGPCT, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_PowerMissingToDMGPCT, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}

void RI_AS_DamageDonePCT(bool Apply, Player *p, RI_StatStore *param)
{
    if (Apply == true)
    {
        if (param->ProcDataStore == NULL)
        {
            RI_P_SpellModParams *Param = new RI_P_SpellModParams;
            if (param->Type == RI_DAMAGE_DONE_FLAT)
            {
                Param->FlatMod = (int32)param->Power;
                Param->PctMod = 0.0f;
            }
            else if (param->Type == RI_DAMAGE_DONE_PCT)
            {
                Param->FlatMod = 0;
                Param->PctMod = param->Power / 100.0f;
            }
            param->ProcDataStore = Param;
        }
        p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_DamageDonePCT, param->ProcDataStore);
    }
    else
    {
        p->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, RI_PS_DamageDonePCT, param->ProcDataStore);
        if (param->ProcDataStore != NULL)
        {
            DebugCheckDoubleDelete(param->ProcDataStore);
            param->ProcDataStore = NULL;
        }
    }
}
