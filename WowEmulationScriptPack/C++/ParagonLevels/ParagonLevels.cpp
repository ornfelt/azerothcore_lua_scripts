#include "DatabaseEnv.h"
#include "ChannelMgr.h"
#include "Channel.h"
#include "ScriptMgr.h"
#include "Player.h"
#include "World.h"
#include "Chat.h"
#include "GameEventCallbacks.h"
#include "ObjectExtension.cpp"
#include "worldSession.h"
#include "GameTime.h"
#include <string.h>
#include "ScriptSettings/ScriptSettingsAPI.h"
#include "ObjectMgr.h"
#include "ParagonLevels.h"
#include "SpellAuraEffects.h"

#include "AddonCommunication/AddonCommunication.h"

#define ParagonPointsPerLevel   1

SpellInfo *GetSpellInfoForAura(int AuraEffect, int SetMiscValue = 0);
void PL_HandleDmgMods(void *p, void *context);

class PlayerParagonStore
{
public:
    PlayerParagonStore(Player *pOwner)
    {
        ParagonLevel = 0;
        MoveSpeedAura = NULL;
        CritDmgSpell = NULL;
        CritDmgRanged = NULL;
        CritDmgMelee = NULL;
        AreaDamagePCT = 0.0f;
        LifeSteal = 0;
        memset(StatModsPointsSpent, 0, sizeof(StatModsPointsSpent));
        Owner = pOwner;
        LoadFromDB();
        ApplyStats(true);
    }
    ~PlayerParagonStore()
    {
        if (MoveSpeedAura != NULL)
        {
            delete MoveSpeedAura;
            MoveSpeedAura = NULL;
        }
    }
    //used when we display info about player
    uint32 GetLevel() { return ParagonLevel; }
    //when player reaches enough XP to levelup, he gets rewarded with a paragon level
    void OnLevelUp()
    {
        ParagonLevel++;
        SaveToAcctDB();
    }
    //should we show the spend menu ?
    int32 GetFreePointCount()
    {
        int32 MaxPoints = ParagonLevel * ParagonPointsPerLevel;
        int32 PointsSpent = 0;
        for (uint32 i = 0; i < PS_MAX_STAT_TYPES; i++)
            PointsSpent += StatModsPointsSpent[i];
        int32 Ret = MaxPoints - PointsSpent;
        if (Ret <= 0)
            return 0;
        return Ret;
    }
    //probably used from the companion menu
    void BuyStat(ParagonStatTypes sType)
    {
        if (sType >= PS_MAX_STAT_TYPES || sType < 0)
            return;
        if (GetFreePointCount() <= 0)
            return;
        ApplyStat(false, sType);
        StatModsPointsSpent[sType]++;
        SaveToPlrDB();
        ApplyStat(true, sType);
    }
    uint32 GetStatPoints(ParagonStatTypes sType)
    {
        if (sType == PS_ParagonLevel)
            return ParagonLevel;
        if (sType == PS_ParagonFreePoints)
            return GetFreePointCount();
        if (sType >= PS_MAX_STAT_TYPES)
            return 0;
        return StatModsPointsSpent[sType];
    }
    float GetAreaDmgMod() { return AreaDamagePCT; }
    int GetLifeSteal() { return LifeSteal; }
private:
    void LoadFromDB()
    {
        if (Owner == NULL || Owner->GetSession() == NULL)
            return;
        char Query[5000];
        //load paragon level
        sprintf_s(Query, sizeof(Query), "SELECT Level from Account_Paragon_Status where AcctId = %u", Owner->GetSession()->GetAccountId());
        QueryResult result = CharacterDatabase.Query(Query);
        if (result)
        {
            Field* fields = result->Fetch();
            ParagonLevel = fields[0].GetUInt32();
        }
        //load the stats we invested in
        sprintf_s(Query, sizeof(Query), "SELECT * from Player_Paragon_Status where PlayerGuid = %u", Owner->GetGUID().GetCounter());
        result = CharacterDatabase.Query(Query);
        if (result)
        {
            Field* fields = result->Fetch();
            for(int i=0;i<PS_MAX_STAT_TYPES;i++)
                StatModsPointsSpent[i] = fields[1+i].GetUInt32();
        }
        //this is an unbugger. There was a bug where you could spend more points than you had
        uint32 PointsSpent = 0;
        for (int i = 0; i < PS_MAX_STAT_TYPES; i++)
            PointsSpent += StatModsPointsSpent[i];
        if (PointsSpent > ParagonLevel * ParagonPointsPerLevel)
        {
            //if there was a bug where you could spend more than you had, reset spent points
            for (int i = 0; i < PS_MAX_STAT_TYPES; i++)
                StatModsPointsSpent[i] = 0;
        }
    }
    float CalcStatValueFromPoints(ParagonStatTypes sType, uint32 Points)
    {
        switch (sType)
        {
            case PS_Agility:
            case PS_Srength:                      
            case PS_Intellect:                    
            case PS_Spirit:                       
            case PS_Stamina:                      
                return Points * 5.0f;
            case PS_Armor:
                return Points * 50.0f;
            case PS_AllResist:
                return Points * 5.0f;
            case PS_Haste:
                return (float)Points;
            case PS_LifeRegen:
                return Points * 100.0f;
            case PS_CritChance:
                return (float)Points;
            case PS_MovementSpeed:
                return (25 * Points / 20.0f) / (Points / 20.0f + 25.0f);
            case PS_CritValue:
                return (50.0f * Points) / (Points + 50.0f);
            case PS_AreaDamage:
                return (50.0f * Points) / (Points + 50.0f);
            case PS_LifeStealFlat:
                return 86.0f * Points;
            case PS_DustGain:
                return (float)Points;
            default:
                return (float)Points;
        }

        return (float)Points;
    }

    void ApplyStats(bool Apply)
    {
        for (int i = 0; i < PS_MAX_STAT_TYPES; i++)
            ApplyStat(Apply, i);
    }

    void ApplyStat(bool Apply, int i)
    {
        /*
            ,
            PS_LifeStealFlat
            PS_DustGain
        */
        float val = CalcStatValueFromPoints(ParagonStatTypes(i), StatModsPointsSpent[i]);
        switch (i)
        {
        case PS_Agility:                          // modify agility
            Owner->HandleStatFlatModifier(UNIT_MOD_STAT_AGILITY, BASE_VALUE, float(val), Apply);
            Owner->UpdateStatBuffMod(STAT_AGILITY);
            break;
        case PS_Srength:                         //modify strength
            Owner->HandleStatFlatModifier(UNIT_MOD_STAT_STRENGTH, BASE_VALUE, float(val), Apply);
            Owner->UpdateStatBuffMod(STAT_STRENGTH);
            break;
        case PS_Intellect:                        //modify intellect
            Owner->HandleStatFlatModifier(UNIT_MOD_STAT_INTELLECT, BASE_VALUE, float(val), Apply);
            Owner->UpdateStatBuffMod(STAT_INTELLECT);
            break;
        case PS_Spirit:                           //modify spirit
            Owner->HandleStatFlatModifier(UNIT_MOD_STAT_SPIRIT, BASE_VALUE, float(val), Apply);
            Owner->UpdateStatBuffMod(STAT_SPIRIT);
            break;
        case PS_Stamina:                          //modify stamina
            Owner->HandleStatFlatModifier(UNIT_MOD_STAT_STAMINA, BASE_VALUE, float(val), Apply);
            Owner->UpdateStatBuffMod(STAT_STAMINA);
            break;
        case PS_Armor:                       
            Owner->HandleStatFlatModifier(UNIT_MOD_ARMOR, TOTAL_VALUE, float(val), Apply);
            break;
        case PS_AllResist:                   
            Owner->HandleStatFlatModifier(UNIT_MOD_RESISTANCE_HOLY, TOTAL_VALUE, float(val), Apply);
            Owner->HandleStatFlatModifier(UNIT_MOD_RESISTANCE_FIRE, TOTAL_VALUE, float(val), Apply);
            Owner->HandleStatFlatModifier(UNIT_MOD_RESISTANCE_NATURE, TOTAL_VALUE, float(val), Apply);
            Owner->HandleStatFlatModifier(UNIT_MOD_RESISTANCE_FROST, TOTAL_VALUE, float(val), Apply);
            Owner->HandleStatFlatModifier(UNIT_MOD_RESISTANCE_SHADOW, TOTAL_VALUE, float(val), Apply);
            Owner->HandleStatFlatModifier(UNIT_MOD_RESISTANCE_ARCANE, TOTAL_VALUE, float(val), Apply);
            break;
        case PS_Haste:
            Owner->ApplyRatingMod(CR_HASTE_SPELL, int32(val), Apply);
            Owner->ApplyRatingMod(CR_HASTE_MELEE, int32(val), Apply);
            Owner->ApplyRatingMod(CR_HASTE_RANGED, int32(val), Apply);
            break;
        case PS_LifeRegen:
            Owner->ApplyHealthRegenBonus(int32(val), Apply);
            break;
        case PS_CritChance:
            Owner->ApplyRatingMod(CR_CRIT_MELEE, int32(val), Apply);
            Owner->ApplyRatingMod(CR_CRIT_RANGED, int32(val), Apply);
            Owner->ApplyRatingMod(CR_CRIT_SPELL, int32(val), Apply);
            break;
        case PS_MovementSpeed:
            if (Apply == true)
            {
                if (MoveSpeedAura == NULL)
                {
                    SpellInfo *TheSpell = GetSpellInfoForAura(SPELL_AURA_MOD_INCREASE_SPEED);
                    MoveSpeedAura = new AuraEffect(1, 1, NULL, TheSpell, 0);
                }
                MoveSpeedAura->SetAmount((int32)val);
            }
            //apply the effect on the player
            Owner->_RegisterAuraEffect(MoveSpeedAura, Apply);
            break;
        case PS_CritValue:
            if (Apply == true)
            {
                if (CritDmgSpell == NULL)
                {
                    SpellInfo *TheSpell = GetSpellInfoForAura(SPELL_AURA_MOD_CRIT_DAMAGE_BONUS);
                    CritDmgSpell = new AuraEffect(1, 1, NULL, TheSpell, 0);
                    TheSpell = GetSpellInfoForAura(SPELL_AURA_MOD_ATTACKER_RANGED_CRIT_DAMAGE);
                    CritDmgRanged = new AuraEffect(1, 1, NULL, TheSpell, 0);
                    TheSpell = GetSpellInfoForAura(SPELL_AURA_MOD_ATTACKER_MELEE_CRIT_DAMAGE);
                    CritDmgMelee = new AuraEffect(1, 1, NULL, TheSpell, 0);
                }
                CritDmgSpell->SetAmount((int32)val);
                CritDmgRanged->SetAmount((int32)val);
                CritDmgMelee->SetAmount((int32)val);
            }
            //apply the effect on the player
            Owner->_RegisterAuraEffect(CritDmgSpell, Apply);
            Owner->_RegisterAuraEffect(CritDmgRanged, Apply);
            Owner->_RegisterAuraEffect(CritDmgMelee, Apply);
            break;
        case PS_AreaDamage:
            if (Apply)
                AreaDamagePCT += val / 100.0f;
            else
                AreaDamagePCT -= val / 100.0f;
            if(AreaDamagePCT != 0)
                Owner->RegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, PL_HandleDmgMods, NULL, 0); // will only register once            
            break;
        case PS_LifeStealFlat:
            if (Apply)
                LifeSteal += (int32)val;
            else
                LifeSteal -= (int32)val;
            if (LifeSteal != 0)
                Owner->RegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, PL_HandleDmgMods, NULL, 0); // will only register once
            break;
        case PS_DustGain:
            float *PCT = Owner->GetExtension<float>(OE_PLAYER_DUST_GAIN_PCT);
                if (Apply == true)
                {
                    if (PCT == NULL)
                    {
                        PCT = Owner->GetCreateExtension<float>(OE_PLAYER_DUST_GAIN_PCT);
                        PCT[0] = 1.0f;
                    }
                    PCT[0] += val / 100.0f;
                }
                else
                {
                    PCT[0] -= val / 100.0f;
                }
            break;
        }
    }
    void SaveToAcctDB()
    {
        char Query[5000];
        sprintf_s(Query, sizeof(Query), "Replace into Account_Paragon_Status values(%u, %u)", Owner->GetSession()->GetAccountId(), ParagonLevel);
        CharacterDatabase.Execute(Query);
    }
    void SaveToPlrDB()
    {
        char Query[5000];
        uint32 BytesWritten = 0;
        BytesWritten += sprintf_s(Query + BytesWritten, sizeof(Query) - BytesWritten, "Replace into Player_Paragon_Status values(%u", Owner->GetGUID().GetCounter());
        for (int i = 0; i < PS_MAX_STAT_TYPES; i++)
            BytesWritten += sprintf_s(Query + BytesWritten, sizeof(Query) - BytesWritten, ",%u", StatModsPointsSpent[i]);
        BytesWritten += sprintf_s(Query + BytesWritten, sizeof(Query) - BytesWritten, ")");
        CharacterDatabase.Execute(Query);
    }
    Player *Owner;
    uint32 ParagonLevel;
    uint32 StatModsPointsSpent[PS_MAX_STAT_TYPES];
    AuraEffect *MoveSpeedAura;
    AuraEffect *CritDmgSpell,*CritDmgRanged,*CritDmgMelee;
    float AreaDamagePCT;
    int LifeSteal;
};
/*
Mainstat: +5 per point, no hard cap.
Vitality: +5 per point, no hard cap.
Movement Speed, +0.5% per point, maxing out at +25% with 50 points.

Attack Speed: +.2% per point, for a maximum of +10% at 50 points.
Cooldown Reduction: +2% per point, for a maximum of +10% reduction at 50 points.
Critical Hit Chance, +.10% per point, for a maximum of 5% at 50 points.
Critical Hit Damage, +1% per point, for a maximum of 50% at 50 points.

Life. Increases +.50% Life per point, to a maximum value of +25% Life.
Armor. Increases +.50% Armor per point, to a maximum value of +25% Armor.
All Resistance: +5 per point, with a maximum of 250.
Life Regeneration, +165.1 per point, for a maximum of +8252 life per second.

Area Damage: +1% per point, max of +50%.
Resource Cost Reduction: 0.2% per point, maximum of 10% cost reduction.
Life on Hit: 82.5 per point, maxing out at 4125.
Originally set to 16.5 per point, with a 50 point cap of 825. This stat was boosted considerably during Patch 2.1 on the PTR, as part of the general healing and combat engine changes.[3]
Gold Find: +1% per point for a maximum of +50%.
Gold Find boosted by gear or Paragon Points switched from additive to multiplicative in Patch 1.0.6, granting much higher Gold Find on higher difficulty levels and making points here worth the expense for many gold-poor players.
*/

PlayerParagonStore *GetPlayerParagonStore(Player *p)
{
    PlayerParagonStore *rip = p->GetExtension<PlayerParagonStore>(OE_PLAYER_PARAGON_STORE);
    if (rip == NULL)
    {
        rip = new PlayerParagonStore(p);
        p->SetExtension<PlayerParagonStore>(OE_PLAYER_PARAGON_STORE, rip);
    }
    return rip;
}

void PL_HandleDmgMods(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL)
        return;
    PlayerParagonStore *rip = NULL;
    if (params->Attacker->GetHealth() < params->Attacker->GetMaxHealth())
    {
        rip = params->Attacker->GetExtension<PlayerParagonStore>(OE_PLAYER_PARAGON_STORE);
        params->Attacker->ModifyHealth(rip->GetLifeSteal());
    }
    if (params->sp != NULL && params->sp->IsTargetingArea() == true)
    {
        if (rip == NULL)
            rip = params->Attacker->GetExtension<PlayerParagonStore>(OE_PLAYER_PARAGON_STORE);
        params->FlatMods += (int32)(rip->GetAreaDmgMod() * params->OriDamage);
    }
}

uint32 GetParagonLevelXPRequired(uint32 ParagonLevel)
{
    float XpRequired = (float)sObjectMgr->GetXPForLevel(sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL)-1);
    for (uint32 i = 0; i < ParagonLevel; i++)
        XpRequired *= 1.15f;
    if(XpRequired < 0x7FFFFFFF)
        return uint32(XpRequired);
    return 0x7FFFFFFF;
}

class TC_GAME_API ParagonLevelPlayerScript : public PlayerScript
{
public:
    ParagonLevelPlayerScript() : PlayerScript("ParagonLevelPlayerScript") {}
    void OnLogin(Player* player, bool firstLogin)
    {
        if (player->getLevel() < sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
            return;

        //maybe this player joined the paragon system recently. How else would he not trigger the levelup ?
        if (player->GetUInt32Value(PLAYER_XP) == player->GetUInt32Value(PLAYER_NEXT_LEVEL_XP))
            player->SetUInt32Value(PLAYER_XP, 0);

        //load aparagon status
        PlayerParagonStore *ps = GetPlayerParagonStore(player);

        //set next Level XP required
        uint32 ParagonLevel = ps->GetLevel();
        player->SetUInt32Value(PLAYER_NEXT_LEVEL_XP, (uint32)GetParagonLevelXPRequired(ParagonLevel));
    }

    void OnGiveXP(Player* player, uint32& amount, Unit* victim)
    {
        if (player->getLevel() < sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
            return;

        //sanity checks
        if (player->GetUInt32Value(PLAYER_NEXT_LEVEL_XP) == 0)
        {
            PlayerParagonStore *ps = GetPlayerParagonStore(player);
            uint32 ParagonLevel = ps->GetLevel();
            player->SetUInt32Value(PLAYER_NEXT_LEVEL_XP, (uint32)GetParagonLevelXPRequired(ParagonLevel));
        }

        player->SendLogXPGain(amount, victim, 0, false, 1.0f);
        if (player->GetUInt32Value(PLAYER_XP) + amount >= player->GetUInt32Value(PLAYER_NEXT_LEVEL_XP))
        {
            //gain paragon level
            PlayerParagonStore *ps = GetPlayerParagonStore(player);
            ps->OnLevelUp();
            //reset XP status
            player->SetUInt32Value(PLAYER_XP, 0);
        }
        else
            player->SetUInt32Value(PLAYER_XP, player->GetUInt32Value(PLAYER_XP) + amount);
    }

    void OnDelete(ObjectGuid guid, uint32 accountId)
    {
        char Query[5000];
        sprintf_s(Query, sizeof(Query), "delete from Player_Paragon_Status where PlayerGUID=%u", guid.GetCounter());
        CharacterDatabase.Execute(Query);
    }
};

void GetParagonLevelAndPointsUnSpent(Player *p, uint32 &Level, uint32 &UnSpent)
{
    PlayerParagonStore *ps = GetPlayerParagonStore(p);
    Level = ps->GetLevel();
    UnSpent = ps->GetFreePointCount();
}

void GetParagonStatStatus(Player *p, uint32 Stat, uint32 &Points)
{
    PlayerParagonStore *ps = GetPlayerParagonStore(p);
    Points = ps->GetStatPoints(ParagonStatTypes(Stat));
}

void ParagonBuyStat(Player *p, uint32 Stat)
{
    PlayerParagonStore *ps = GetPlayerParagonStore(p);
    ps->BuyStat(ParagonStatTypes(Stat));
}

void ParagonQuerySingleStat(Player *PacketSender, ParagonStatTypes StatType)
{
    PlayerParagonStore *ps = GetPlayerParagonStore(PacketSender);
    uint32 Points = ps->GetStatPoints(ParagonStatTypes(StatType));
    if (Points <= 0)
        return;
    char repl[500];
    sprintf_s(repl, sizeof(repl), "%d %d", StatType, Points);
    AddonComm::SendMessageToClient(PacketSender, "PASS", repl);
}

void ParagonQuerySingleStat(Player *PacketSender, const char *msg)
{
    int StatQueried;
    sscanf(msg, "%d", &StatQueried);
    ParagonQuerySingleStat(PacketSender, ParagonStatTypes(StatQueried));
}

void ParagonQueryAllStats(Player *PacketSender, const char *msg)
{
    PlayerParagonStore *ps = GetPlayerParagonStore(PacketSender);
    char repl[500];
    sprintf_s(repl, sizeof(repl), "%d %d", PS_ParagonLevel, ps->GetLevel());
    AddonComm::SendMessageToClient(PacketSender, "PASS", repl);
    sprintf_s(repl, sizeof(repl), "%d %d", PS_ParagonFreePoints, ps->GetFreePointCount());
    AddonComm::SendMessageToClient(PacketSender, "PASS", repl);

    for (int Stat = 0; Stat < PS_MAX_STAT_TYPES; Stat++)
        ParagonQuerySingleStat(PacketSender, ParagonStatTypes(Stat));
}

void ParagonBuySingleStat(Player *PacketSender, const char *msg)
{
    int StatQueried;
    int ValueCount = sscanf(msg, "%d", &StatQueried);
    if (ValueCount == 0)
        return;
    ParagonBuyStat(PacketSender, StatQueried);
    ParagonQuerySingleStat(PacketSender, PS_ParagonFreePoints);
    ParagonQuerySingleStat(PacketSender, ParagonStatTypes(StatQueried));
}

void AddParagonLevelsScripts()
{
    //only load this server addon if config file said so
    if (sWorld->getIntConfig(CONFIG_PARAGON_LEVELS) == 0)
        return;

    //monitor when to load/save/delete item extra data 
    new ParagonLevelPlayerScript();

    AddonComm::RegisterOpcodeHandler("PAAS", ParagonQueryAllStats);
    AddonComm::RegisterOpcodeHandler("PASS", ParagonQuerySingleStat);
    AddonComm::RegisterOpcodeHandler("PABS", ParagonBuySingleStat);
}

/*
CREATE TABLE `Account_Paragon_Status` (
`AcctId` int(20) unsigned NOT NULL,
`Level` int(20) unsigned NOT NULL,
INDEX `Index1` (`AcctId`),
UNIQUE KEY `UniquePair` (`AcctId`),
PRIMARY KEY (AcctId)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Player_Paragon_Status` (
`PlayerGUID` int(20) unsigned NOT NULL,
`s1` int(11) DEFAULT NULL,
`s2` int(11) DEFAULT NULL,
`s3` int(11) DEFAULT NULL,
`s4` int(11) DEFAULT NULL,
`s5` int(11) DEFAULT NULL,
`s6` int(11) DEFAULT NULL,
`s7` int(11) DEFAULT NULL,
`s8` int(11) DEFAULT NULL,
`s9` int(11) DEFAULT NULL,
`s10` int(11) DEFAULT NULL,
`s11` int(11) DEFAULT NULL,
`s12` int(11) DEFAULT NULL,
`s13` int(11) DEFAULT NULL,
`s14` int(11) DEFAULT NULL,
`s15` int(11) DEFAULT NULL,
INDEX `Index1` (`PlayerGUID`),
UNIQUE KEY `UniquePair` (`PlayerGUID`),
PRIMARY KEY (PlayerGUID)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
*/
