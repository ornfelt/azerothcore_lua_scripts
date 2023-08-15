#ifdef _DEBUG
#include <windows.h>
#include <vector>
#include <string>
#include "Player.h"
#include "GameEventCallbacks.h"
#include "ObjectExtension.cpp"
#include "GameTime.h"
#include "Item.h"
#include "RI_ItemStore.h"
#include "SpellHistory.h"
#include "Spell.h"
#include "SpellInfo.h"
#include "RI_AddonUpdater.h"
#include "SpellMgr.h"
#include "PassiveAI.h"
#include "Creature.h"
#include "DPSAndHealHighScores/DPSAndHealHighScores.h"


#define TimeExtraToSampleDPS        (0)
#define HPOfTargetUnit              (0x02FFFFFF)

std::string search_Dir = "./RiTests/";
std::vector<std::string*> TestFileNames[MAX_CLASSES];
std::list<const char*> TakenTestFileNames[MAX_CLASSES];
bool OwerwriteExistingTests = false;
int TestIndex[MAX_CLASSES];

struct AutomatedTestPlayerStore
{
    AutomatedTestPlayerStore()
    {
        TesterPlayer = NULL;
        SelectedUnit = NULL;
        AddedHealthTarget = 0;
        AddedHealthSelf = 0;
        EndStamp = 0;
        FileName = NULL;
        InitializedBuild = -1;
        ExtraBuffStack = 0;
        UsingManaBurnStat = false;
        KeepHPAt = HPOfTargetUnit;
    }
    uint32 StartStamp;
    uint32 EndStamp;
    std::string *FileName;
    bool TestPaused = false;
    Player *TesterPlayer;
    Unit *SelectedUnit;
    int64 AddedHealthTarget;
    int64 AddedHealthSelf;
    uint32 SelectedBuild; // fire mage ? Healer ?
    int32 InitializedBuild;
    uint32 ExtraBuffStack;
    uint32 KeepHPAt;
    bool    UsingManaBurnStat;
};

const char* StrTestEQ(const char *s1, const char *s2)
{
    while (*s1 == *s2)
    {
        if (*s1 == 0)
            return s2;
        s1++;
        s2++;
    }
    if (*s1 != 0 && *s1 != *s2)
        return NULL;
    return s2;
}

void ReadLine3(FILE *f, char *buff, uint32 MaxLen)
{
    *buff = 0;
    while (!feof(f))
    {
        size_t BytesRead = fread(buff, 1, 1, f);
        if (*buff == '\n')
        {
            *buff = 0;
            return;
        }
        buff++;
    }
}

void ReadLine4(FILE *f, char *buff, uint32 MaxLen)
{
    while (!feof(f))
    {
        ReadLine3(f, buff, MaxLen);
        if (buff[0] == '#' || buff[0] == '\n' || buff[0] == '\r' || buff[0] == '\t' || buff[0] == ' ')
            continue;
        else
            return;
    }
}

std::vector<float>* StrToFloats(const char *str)
{
    std::vector<float> *res = new std::vector<float>;
    int ValsInserted = 0;
    while (str[0] != 0)
    {
        char ValEnd[500];
        int i = 0;
        while (str[i] != 0 && str[i] != ' ' && i < sizeof(ValEnd))
        {
            ValEnd[i] = str[i];
            i++;
        }
        ValEnd[i] = 0;
        float val = (float)atof(ValEnd);
        res->resize(ValsInserted + 1);
        (*res)[ValsInserted++] = val;
        if (str[i] == 0)
            break;
        str += i + 1;
    }
    return res;
}

AutomatedTestPlayerStore *GetATStore(Player *p)
{
    if (p == NULL)
        return NULL;
    AutomatedTestPlayerStore *ret = p->GetExtension<AutomatedTestPlayerStore>(OE_PLAYER_AUTOMATED_TEST_STORE);
    if (ret == NULL)
    {
        ret = new AutomatedTestPlayerStore();
        ret->TesterPlayer = p;
        p->SetExtension< AutomatedTestPlayerStore>(OE_PLAYER_AUTOMATED_TEST_STORE, ret);
    }
    return ret;
}

void GenResultFileName(char *out, size_t out_size, AutomatedTestPlayerStore *at, int PClass = 0, const char *FileName = NULL)
{
    if (PClass != 0 && FileName != NULL)
    {
        sprintf_s(out, out_size, "%sres_%d_%s", search_Dir.c_str(), PClass, FileName);
    }
    else if (at == NULL || at->FileName == NULL)
        sprintf_s(out, out_size, "");
    else
        sprintf_s(out, out_size, "%sres_%d_%s", search_Dir.c_str(), at->TesterPlayer->getClass(), at->FileName->c_str());
}

int GetClassFromFileName(const char *TestFileName)
{
    const char *ClassStart = StrTestEQ("Test_", TestFileName);
    return atoi(ClassStart);
}

bool FileAlreadyExists(AutomatedTestPlayerStore *at, const char *TestFileName = NULL)
{
    char FileName[500];
    if (TestFileName != NULL)
    {
        //get the player class from the string : Test_Class
        int PClass = GetClassFromFileName(TestFileName);
        GenResultFileName(FileName, sizeof(FileName), NULL, PClass, TestFileName);
    }
    else
        GenResultFileName(FileName, sizeof(FileName), at);
    FILE *f;
    errno_t OpenRes = fopen_s(&f, FileName, "rt");
    if (f != NULL)
    {
        fclose(f);
        return true;
    }
    return false;
}

void LoadScripts(Player *plr)
{
    //load all file TestFileNames, except Status
    for (int i = 0; i < MAX_CLASSES; i++)
    {
        TestIndex[i] = 0;
        TestFileNames[i].clear();
        TakenTestFileNames[i].clear();
    }
    std::string search_path = search_Dir + "*.*";
    WIN32_FIND_DATA fd;
    HANDLE hFind = ::FindFirstFile(search_path.c_str(), &fd);
    if (hFind != INVALID_HANDLE_VALUE)
    {
        do {
            if (!(fd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) && fd.cFileName[0] == 'T')
            {
                std::string *ns = new std::string(fd.cFileName);
                int PlayerClass = GetClassFromFileName(fd.cFileName);
                TestFileNames[PlayerClass].push_back(ns);
                if(plr != NULL)
                    plr->BroadcastMessage("Loading script file : %s", fd.cFileName);
                if (OwerwriteExistingTests == false && FileAlreadyExists(NULL, fd.cFileName) == true)
                {
                    TakenTestFileNames[PlayerClass].push_back(ns->c_str());
                    TestIndex[PlayerClass]++;
                }
            }
        } while (::FindNextFile(hFind, &fd));
        ::FindClose(hFind);
    }
/*
    //load status also ( if there is a status, else reset status )
    FILE *f;
    errno_t OpenRes = fopen_s(&f, (search_Dir + std::string("Status.txt")).c_str(), "rb");
    if (f != NULL)
    {
        fread(f, 1, sizeof(DPSStatusStore), f);
        fclose(f);
        f = NULL;
    }*/
}
void UpdatePlayerHealth(Player *Owner)
{
    AutomatedTestPlayerStore *at = GetATStore(Owner);
    if (at->TesterPlayer == NULL || at->SelectedUnit == NULL)
        return;
    if (at->TesterPlayer->GetHealth() < at->KeepHPAt)
    {
        uint32 AddHealth = at->KeepHPAt - at->TesterPlayer->GetHealth();
        at->AddedHealthSelf += AddHealth;
        at->TesterPlayer->ModifyHealth(AddHealth);
    }
    if (at->SelectedUnit->GetHealth() < at->KeepHPAt)
    {
        uint32 AddHealth = at->KeepHPAt - at->SelectedUnit->GetHealth();
        at->AddedHealthTarget += AddHealth;
        at->SelectedUnit->ModifyHealth(AddHealth);
    }
    if (at->TesterPlayer->GetHealth() > at->KeepHPAt)
    {
        int32 AddHealth = at->TesterPlayer->GetHealth() - at->KeepHPAt;
        at->AddedHealthSelf -= AddHealth;
        at->TesterPlayer->ModifyHealth(-AddHealth);
    }
    if (at->SelectedUnit->GetHealth() > at->KeepHPAt)
    {
        int32 AddHealth = at->SelectedUnit->GetHealth() - at->KeepHPAt;
        at->AddedHealthTarget -= AddHealth;
        at->SelectedUnit->ModifyHealth(-AddHealth);
    }
}

void EndPreviousTest(Player *Owner)
{
    AutomatedTestPlayerStore *at = GetATStore(Owner);

    //no test script has been assigned yet
    if (at->FileName == NULL || at->FileName->length() == 0)
    {
        at->TesterPlayer->CombatStop();
        return;
    }

    //tester player should have a selection
    if (at->SelectedUnit == NULL || at->SelectedUnit == at->TesterPlayer)
    {
        at->TesterPlayer->BroadcastMessage("You need to select a unit we can mod it's health");
        return;
    }
    UpdatePlayerHealth(Owner);

    int64 DamageDone = (int64)at->AddedHealthTarget;
    int64 DamgeReceived = (int64)at->AddedHealthSelf; // if this is negative. it means we healed more than damage received
    //create file and write back results
    char FileName[500];
    GenResultFileName(FileName, sizeof(FileName), at);
    FILE *f;
    errno_t OpenRes = fopen_s(&f, FileName, "wt");
    if (f == NULL)
    {
        printf("Could not open AutomatedTest result file %s\n", FileName);
        return;
    }
    int64 TimePassed = GameTime::GetGameTimeMS() - at->StartStamp;
    int64 DPS = DamageDone / (TimePassed/1000);
    int64 HPS = DamgeReceived / (TimePassed/1000);
    fprintf_s(f, "%d\n", at->TesterPlayer->getClass());
    fprintf_s(f, "%lld\n", DamageDone);
    fprintf_s(f, "%lld\n", DamgeReceived);
    fprintf_s(f, "%u\n", (int)TimePassed);
    fprintf_s(f, "%lld\n", DPS);
    fprintf_s(f, "%lld\n", HPS);
    fclose(f);
}

void StartNextTest(Player *Owner)
{
    AutomatedTestPlayerStore *at = GetATStore(Owner);

    //have to execute the load command while there are automated script files
    int PlayerClass = at->TesterPlayer->getClass();
    if (TestFileNames[PlayerClass].empty() == true)
    {
        printf("No script files found. Nothing to start executing\n");
        at->TestPaused = true;
        return;
    }
    ResetSingleTargetDPS(at->TesterPlayer);
    //get the file name of the next script file
    if (TestIndex[PlayerClass] >= TestFileNames[PlayerClass].size())
    {
//        TestIndex[PlayerClass] = 0;
        at->TestPaused = true;
        at->TesterPlayer->BroadcastMessage("Finished processing all scripts\n");
        at->TesterPlayer->RemoveAllAurasOnDeath();
        at->SelectedUnit->RemoveAllAurasOnDeath();
        at->TesterPlayer->CombatStop();
        at->SelectedUnit->CombatStop();
        at->FileName = NULL;
        return;
    }
    //check if we have a target we can change it's HP
    if (at->TesterPlayer == NULL)
    {
        at->TesterPlayer->BroadcastMessage("Need to have a selected player that will run the tests \n");
        at->TestPaused = true;
        return;
    }
    at->SelectedUnit = at->TesterPlayer->GetSelectedUnit();
    //tester player should have a selection
    if (at->SelectedUnit == NULL || at->SelectedUnit == at->TesterPlayer || at->TesterPlayer->IsFriendlyTo(at->SelectedUnit) == true)
    {
        at->TesterPlayer->BroadcastMessage("You need to select a unit we can mod it's health");
        at->TestPaused = true;
        return;
    }
    at->TesterPlayer->SetExtension<int64>(OE_UNIT_DISABLE_DEATH_WHILE_TESTING,new int64);
    at->SelectedUnit->SetExtension<int64>(OE_UNIT_DISABLE_DEATH_WHILE_TESTING, new int64);

    at->AddedHealthTarget = 0;
    at->AddedHealthSelf = 0;

    // clear all previous stats from all items from player
    for (int i = EQUIPMENT_SLOT_START; i != EQUIPMENT_SLOT_END; i++)
    {
        Item *it = at->TesterPlayer->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (it == NULL)
            continue;
        RI_ItemStore *rii = it->GetExtension<RI_ItemStore>(OE_ITEM_EXTENDED_STATS);
        if (rii == NULL)
            continue;
        rii->ApplyEffects(at->TesterPlayer, it, false);
        rii->DeleteFromDB();
    }

    // make sure both are max level
    at->TesterPlayer->SetLevel(DEFAULT_MAX_LEVEL);
    at->SelectedUnit->SetLevel(DEFAULT_MAX_LEVEL);

    if (at->TesterPlayer->IsAlive() == false)
    {
        at->TesterPlayer->ResurrectPlayer(false, false);
        at->TesterPlayer->RemoveAurasDueToSpell(8326);
        at->TesterPlayer->RemoveAurasDueToSpell(20584);
        at->TesterPlayer->RemoveFlag(PLAYER_FLAGS, PLAYER_FLAGS_GHOST);
        at->TesterPlayer->RemoveFlag(PLAYER_FLAGS, PLAYER_FLAGS_IS_OUT_OF_BOUNDS);
    }
    if (at->SelectedUnit->IsAlive() == false)
    {
        if (at->SelectedUnit->ToPlayer() != NULL)
            at->SelectedUnit->ToPlayer()->ResurrectPlayer(false, false);
        at->SelectedUnit->RemoveAurasDueToSpell(8326);
        at->SelectedUnit->RemoveAurasDueToSpell(20584);
        at->SelectedUnit->RemoveFlag(PLAYER_FLAGS, PLAYER_FLAGS_GHOST);
        at->SelectedUnit->RemoveFlag(PLAYER_FLAGS, PLAYER_FLAGS_IS_OUT_OF_BOUNDS);
    }

    //clear all cooldowns
    PlayerSpellMap const& sp_list = at->TesterPlayer->GetSpellMap();
    for (PlayerSpellMap::const_iterator itr = sp_list.begin(); itr != sp_list.end(); ++itr)
    {
        at->TesterPlayer->GetSpellHistory()->ResetCooldown(itr->first, true);
        //double check ? Back in the days cooldown hystory bugged out sometimes
        WorldPacket data(SMSG_CLEAR_COOLDOWN, 4 + 8);
        data << uint32(itr->first);
        data << uint64(at->TesterPlayer->GetGUID());
        at->TesterPlayer->SendDirectMessage(&data);
    }

    //remove all auras. Start fresh
    at->TesterPlayer->RemoveAllAurasOnDeath();
    at->SelectedUnit->RemoveAllAurasOnDeath();

    at->InitializedBuild = -1;

    char LineBuff[5000];
    FILE *f;
    bool LastFileIsValid = 0;

    do
    {
        //seems like we can start this test
        at->FileName = TestFileNames[PlayerClass][TestIndex[PlayerClass]];
        TestIndex[PlayerClass]++; //jump to the next script after this one executes

        //check if some other client already took this file for testing
        bool FileAlreadyProcessed = false;
        for (auto itr = TakenTestFileNames[PlayerClass].begin(); itr != TakenTestFileNames[PlayerClass].end(); itr++)
            if ((*itr) == at->FileName->c_str())
            {
                FileAlreadyProcessed = true;
                break;
            }


        //check if this test was already made before server crashed
        if (OwerwriteExistingTests == false)
        {
            if (FileAlreadyProcessed == true)
            {
                //            at->TesterPlayer->BroadcastMessage("Skipping script (taken) : %s \n", at->FileName->c_str());
                continue;
            }

            if (FileAlreadyExists(at) == true)
                continue;
        }

        char FileName[500];
        sprintf_s(FileName, sizeof(FileName), "%s%s", search_Dir.c_str(), at->FileName->c_str());
        errno_t OpenRes = fopen_s(&f, FileName, "rt");
        if (f == NULL)
        {
            at->TesterPlayer->BroadcastMessage("Loading script failed : %s \n", at->FileName->c_str());
            at->TestPaused = true;
            return;
        }

        // does this script apply to our class ?
        ReadLine4(f, LineBuff, sizeof(LineBuff));
        int CanUseOnClassMask = atoi(LineBuff);
        if (((1 << (uint32)at->TesterPlayer->getClass()) & CanUseOnClassMask) == 0)
        {
//            printf("Can not use script on this class. Skipping\n");
            fclose(f);
            continue;
        }

        // can we target a creature while using this script ?
        ReadLine4(f, LineBuff, sizeof(LineBuff));
        int CanUseOnCreature = atoi(LineBuff);
        // what stats should we use ?
        if (CanUseOnCreature == 0 && at->SelectedUnit->ToPlayer() == NULL)
        {
            printf("Can not use script on creature class. Skipping\n");
            fclose(f);
            continue;
        }

        // does this script apply to taget type ?
        ReadLine4(f, LineBuff, sizeof(LineBuff));
        CanUseOnClassMask = atoi(LineBuff);
        if (((1 << (uint32)at->SelectedUnit->getClass()) & CanUseOnClassMask) == 0)
        {
            printf("Can not use script on this target class. Skipping\n");
            fclose(f);
            continue;
        }
        LastFileIsValid = 1;
        break;
    } while (TestIndex[PlayerClass] < TestFileNames[PlayerClass].size());

    if (LastFileIsValid == 0 && TestIndex[PlayerClass] >= TestFileNames[PlayerClass].size())
        return;

    TakenTestFileNames[PlayerClass].push_back(at->FileName->c_str());

    at->TesterPlayer->BroadcastMessage("Loading script settings from file : %s %d/%d\n", at->FileName->c_str(), TestIndex[PlayerClass], (int)TestFileNames[PlayerClass].size());

    at->ExtraBuffStack = 0;
    at->UsingManaBurnStat = false;

    at->KeepHPAt = HPOfTargetUnit / 2;

    //load stats that items should use
    ReadLine4(f, LineBuff, sizeof(LineBuff));
    std::vector<float> *Stats = StrToFloats(LineBuff);
    for (int i = 0; i < Stats->size();)
    {
        int ItemSlotIndex = (int)((*Stats)[i+0]);
        int StatType = (int)((*Stats)[i+1]);
        float StatValue = ((*Stats)[i + 2]);
        i += 3;
        //maybe testing items without extra stats. Base DPS
        if (StatType == 0)
            continue;
        //get the item in this slot
        Item *it = NULL;
        if (ItemSlotIndex < 0)
        {
            //find an item
            for (int i = EQUIPMENT_SLOT_START; i != EQUIPMENT_SLOT_END; i++)
            {
                it = at->TesterPlayer->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
                if (it == NULL)
                    continue;
                RI_ItemStore *rii = it->GetExtension<RI_ItemStore>(OE_ITEM_EXTENDED_STATS);
                if (rii != NULL && rii->GetStats()->size() >= 15)
                    continue;
                break;
            }
        }
        else
            it = at->TesterPlayer->GetItemByPos(INVENTORY_SLOT_BAG_0, ItemSlotIndex);
        if (it == NULL)
        {
            printf("Test script wants to use item slot %d, but player has no item there\n", ItemSlotIndex);
            continue;
        }
        if (StatType >= RIStatTypes::RI_MAX_STAT_TYPES)
        {
            printf("Test script wants to use stats type %d, but that is over the max\n", StatType);
            continue;
        }
        //special case of DPS testing
        if (StatType == RIStatTypes::RI_INCREASE_AURA_MAX_STACK)
            at->ExtraBuffStack = 1;
        else if (StatType == RIStatTypes::RI_POWER_BURN_FLAT)
            at->UsingManaBurnStat = 1;
        else if (StatType == RIStatTypes::RI_POWER_BURN_TARGET || StatType == RIStatTypes::RI_POWER_BURN_TARGET_PCT)
            at->UsingManaBurnStat = 1;
        else if (StatType == RIStatTypes::RI_LOW_HEALTH_EXTRA_DMG_FLAT || StatType == RIStatTypes::RI_LOW_HEALTH_EXTRA_DMG_PCT)
            at->KeepHPAt = HPOfTargetUnit / 100 * 15;

        RI_ItemStore *rii = it->GetExtension<RI_ItemStore>(OE_ITEM_EXTENDED_STATS);
        if (rii == NULL)
        {
            rii = new RI_ItemStore(it);
            it->SetExtension< RI_ItemStore>(OE_ITEM_EXTENDED_STATS, rii);
        }
        RI_StatStore *ss = new RI_StatStore();
        ss->Type = RIStatTypes(StatType);
        ss->Power = StatValue;
        rii->GetStats()->push_front(ss);

        PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
        if(strstr(RI_PickableStats[ss->Type].FormatStr, "%d"))
            at->TesterPlayer->BroadcastMessage( RI_PickableStats[ss->Type].FormatStr, (int)ss->Power );
        else
            at->TesterPlayer->BroadcastMessage( RI_PickableStats[ss->Type].FormatStr, ss->Power);
    }

    //apply the loaded stats
    for (int i = EQUIPMENT_SLOT_START; i != EQUIPMENT_SLOT_END; i++)
    {
        Item *it = at->TesterPlayer->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (it == NULL)
            continue;
        RI_ItemStore *rii = it->GetExtension<RI_ItemStore>(OE_ITEM_EXTENDED_STATS);
        if (rii == NULL)
            continue;
        rii->ApplyEffects(at->TesterPlayer, it, true);
    }
    //check if we should modify the default test duration. Maybe some stats take a while to trigger
    ReadLine4(f, LineBuff, sizeof(LineBuff));
    int TestDuration = atoi(LineBuff);

    //maybe a class has more than 1 build
    at->SelectedBuild = 0;
    ReadLine4(f, LineBuff, sizeof(LineBuff));
    at->SelectedBuild = atoi(LineBuff);
    
    fclose(f);

    //for DPS test - needs to be after applying stats or else it might get updated
    at->SelectedUnit->SetMaxHealth(HPOfTargetUnit);
    at->SelectedUnit->SetHealth(at->KeepHPAt);
    //for HPS test
    at->TesterPlayer->SetMaxHealth(HPOfTargetUnit);
    at->TesterPlayer->SetHealth(at->KeepHPAt);

    // maximize our mana
    at->TesterPlayer->SetMaxPower(POWER_MANA, 90000);
    at->TesterPlayer->SetPower(POWER_MANA, at->TesterPlayer->GetMaxPower(POWER_MANA));
    at->SelectedUnit->SetMaxPower(POWER_MANA, 34131); // there some extreme values also 400000, avg is 34131.5519 : select sum(curmana)/count(*) from creature where curmana > 0 and id in (select entry from creature_template where minlevel >= 80);
    at->SelectedUnit->SetPower(POWER_MANA, at->SelectedUnit->GetMaxPower(POWER_MANA));

    //repair all items
    at->TesterPlayer->DurabilityRepairAll(false, 0, false);

    //start profiling the scenario
    at->StartStamp = GameTime::GetGameTimeMS();
    at->EndStamp = GameTime::GetGameTimeMS() + TestDuration + TimeExtraToSampleDPS;
}

bool TryCastSpell(Unit *TesterPlayer, Unit *SelectedUnit, uint32 TryCastSpell)
{

    if (TesterPlayer->ToPlayer())
    {
        if (TesterPlayer->GetCurrentSpell(CurrentSpellTypes::CURRENT_GENERIC_SPELL) != NULL)
            return false;
        if (TesterPlayer->GetCurrentSpell(CurrentSpellTypes::CURRENT_CHANNELED_SPELL) != NULL)
            return false;
//        if (TesterPlayer->IsNonMeleeSpellCast(true) == true)
//            return false;
        if (TesterPlayer->ToPlayer()->HasActiveSpell(TryCastSpell) == false)
            return false;
        if (TesterPlayer->ToPlayer()->GetSpellHistory()->HasGlobalCooldown(sSpellMgr->AssertSpellInfo(TryCastSpell)))
            return false;
        if (TesterPlayer->ToPlayer()->GetSpellHistory()->HasCooldown(TryCastSpell) == true)
            return false;
    }

    //try to cast it. Crossing fingers we will not fail
    TriggerCastFlags TriggerFlags = (TriggerCastFlags)0;
    //cast it in cheat mode, no cooldowns, no cost, no nothing
//    if (SelectedUnit->HasAura(TryCastSpell) == true || TesterPlayer->HasAura(TryCastSpell) == true) //we are not smart enough to know how many times this will stack
//        TriggerFlags = ((TriggerCastFlags)(TRIGGERED_IGNORE_CAST_TIME | TRIGGERED_IGNORE_MOVE_CHECK | TRIGGERED_IGNORE_GCD | TRIGGERED_IGNORE_SPELL_AND_CATEGORY_CD | TRIGGERED_IGNORE_POWER_AND_REAGENT_COST));

//    TesterPlayer->CastSpell(SelectedUnit, 1);

    SpellCastTargets targets;
    targets.SetUnitTarget(SelectedUnit);
    targets.SetDst(SelectedUnit->GetPosition());
    targets.SetSrc(TesterPlayer->GetPosition());

    SpellInfo const* info = sSpellMgr->GetSpellInfo(TryCastSpell);
    Spell* spell = new Spell(TesterPlayer, info, TriggerFlags);
    spell->InitExplicitTargets(targets);

    uint32 CastCheck = spell->CheckCast(true);
    if (CastCheck != SPELL_FAILED_SUCCESS && CastCheck != SPELL_CAST_OK)
    {
        spell->cancel();
        delete spell;
        return false;
    }

    //we should be able to cast it
    spell->prepare(targets);

    //it failed for some reason ?
    if (spell->getState() == SPELL_STATE_FINISHED)
        return false;

    return true;
}

void EnchantItem(Player *Owner, uint32 SpellId, bool IsMainHand = true)
{
    if (Owner == NULL)
        return;
    Item *it = NULL;
    if(IsMainHand == true)
        it = Owner->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND);
    else
        it = Owner->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND);
    if (it == NULL)
        return;
    SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(SpellId);
    Spell* spell = new Spell(Owner, spellInfo, TRIGGERED_FULL_MASK);
    spell->m_targets.SetItemTarget(it);
    spell->m_targets.SetUnitTarget(Owner);
    spell->cast(true);
}

void MageDPS(Player *Owner)
{
    AutomatedTestPlayerStore *at = GetATStore(Owner);
    // first cast buffs that would boost our damage on target
    if (at->SelectedBuild == 0)
    {
        if (at->TesterPlayer->GetAuraCount(36032) < 4 + at->ExtraBuffStack) // arcane blast self amplify
        {
            if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 42897)) // Arcane Blast
                return;
        }
        if (at->TesterPlayer->GetAuraCount(44401) > 0) // missle barrage proc
        {
            if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 42846)) // Arcane Missiles
                return;
        }
        TryCastSpell(at->TesterPlayer, at->SelectedUnit, 42897); // Arcane Blast
    }
    if (at->SelectedBuild == 1)
    {
        //if hot streak than pyro
        if (at->TesterPlayer->GetAuraCount(48108) > 0 || at->TesterPlayer->GetAuraCount(48108) > 0)
        {
            if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 42891)) // Pyroblast
                return;
        }
        // if there is no improved scorch buff on target, cast scorch
        if (at->SelectedUnit->GetAuraCount(22959) < 1 + at->ExtraBuffStack)
        {
            if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 42859)) // Scorch
                return;
        }
        if (at->SelectedUnit->GetAuraCount(55362) < 1 + at->ExtraBuffStack && at->SelectedUnit->GetAuraCount(55360) < 1 + at->ExtraBuffStack) //if target has no living bomb DOT on him
        {
            if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 55360)) // Living bomb
                return;
        }
        TryCastSpell(at->TesterPlayer, at->SelectedUnit, 42833); // if no hot streak, fireball        
    }
    if (at->SelectedBuild == 2)
    {
        if (at->TesterPlayer->GetAuraCount(57761) > 0) // brain freeze
        {
            if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 47610)) // frostfire bolt
                return;
        }
        TryCastSpell(at->TesterPlayer, at->SelectedUnit, 42842); // frostbolt     
    }
}

void WarriorDPS(Player *Owner)
{
    AutomatedTestPlayerStore *at = GetATStore(Owner);
    if (at->TesterPlayer->GetAuraCount(46916) > 0) // !Slam proc
    {
        if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 47475)) // Slam
            return;
    }

    if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 23881)) // Bloodthirst ( has longer cooldown than heroic strike )
            return;

    TryCastSpell(at->TesterPlayer, at->SelectedUnit, 47450); // Heroic strike
}

void PaladinDPS(Player *Owner)
{
    AutomatedTestPlayerStore *at = GetATStore(Owner);
    static uint32 NextConsacrateCast = 0;
    if (at->SelectedBuild == 0)
    {
        if (at->TesterPlayer->GetAuraCount(21084) == 0) // Seal of Righteousness
        {
            if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 21084)) // Seal of Righteousness
                return;
        }

        //    if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 27173)) // Consecration ( has long cooldown )
        //        return;
        if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 48801)) // Exorcism ( has long cooldown )
            return;
        if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 48806)) // Hammer of Wrath ( has long cooldown )
            return;
        if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 71549)) // Crusader Strike ( has long cooldown )
            return;
        if (GameTime::GetGameTimeMS() > NextConsacrateCast)
        {
            if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 48819)) // Consecration
            {
                NextConsacrateCast = GameTime::GetGameTimeMS() + 8000;
                return;
            }
        }
            
        // if we can judge the target
        if (at->SelectedUnit->GetAuraCount(21084) == 5) // Seal of Righteousness
        {
            if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 53733)) // Judgement of Corruption
                return;
        }
    }
    if (at->SelectedBuild == 1)
    {
        if (at->TesterPlayer->GetAuraCount(31801) == 0) // Seal of Vengeance
        {
            if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 31801)) // Seal of Righteousness
                return;
        }

        if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 48801)) // Exorcism ( has long cooldown )
            return;
        if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 48806)) // Hammer of Wrath ( has long cooldown )
            return;
        if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 71549)) // Crusader Strike ( has long cooldown )
            return;
        if (GameTime::GetGameTimeMS() > NextConsacrateCast)
        {
            if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 48819)) // Consecration
            {
                NextConsacrateCast = GameTime::GetGameTimeMS() + 8000;
                return;
            }
        }
        // if we can judge the target
        if (at->SelectedUnit->GetAuraCount(31801) == 5 + at->ExtraBuffStack) // Seal of Vengeance
        {
            if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 53733)) // Judgement of Corruption
                return;
        }
    }
    //healer paladin
    if (at->SelectedBuild == 2)
    {
        if (at->TesterPlayer->GetAuraCount(58597) < 1 + at->ExtraBuffStack) // Sacred Shield
        {
            if (TryCastSpell(at->TesterPlayer, at->TesterPlayer, 53601)) // Sacred Shield
                return;
        }
        if (at->TesterPlayer->GetAuraCount(53651) == 0) // Beacon of Light
        {
            if (TryCastSpell(at->TesterPlayer, at->TesterPlayer, 53601)) // Beacon of Light
                return;
        }
        static int HealerSpell = 0;
        if (HealerSpell % 2 == 0)
        {
            if (TryCastSpell(at->TesterPlayer, at->TesterPlayer, 68009)) // Flash of Light
            {
                HealerSpell++;
                return;
            }
        }
        if (TryCastSpell(at->TesterPlayer, at->TesterPlayer, 48782)) // Holy Light
        {
            HealerSpell++;
            return;
        }
    }
}

void HunterDPS(Player *Owner)
{
    AutomatedTestPlayerStore *at = GetATStore(Owner);

    //make sure we have enough arrows to shoot
    if (at->InitializedBuild != at->SelectedBuild)
    {
        at->TesterPlayer->AddItem(52021, 1000);
        at->InitializedBuild = at->SelectedBuild;
    }

    if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 61006)) // Kill Shot - only below 20% hp
        return;

    if (at->SelectedUnit->GetAuraCount(53338) == 0) // Hunter's Mark
    {
        if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 53338)) // Hunter's Mark
            return;
    }

    if (at->SelectedUnit->GetAuraCount(49001) < 1 + +at->ExtraBuffStack) // Serpent Sting
    {
        if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 49001)) // Serpent Sting
            return;
    }

    if (at->SelectedUnit->GetAuraCount(49001) != 0) // Serpent Sting
    {
        if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 53209)) // Chimera Shot
            return;
    }

    if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 49045)) // Arcane Shot
        return;
    if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 60053)) // Explosive Shot
        return;
    if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 49052)) // Steady Shot
        return;
}

void RogueDPS(Player *Owner)
{
    AutomatedTestPlayerStore *at = GetATStore(Owner);
    //Use Instant Poison IX on your main-hand weapon and Deadly Poison IX on your offhand
    //https://wotlk.evowow.com/item=43231
    //https://wotlk.evowow.com/item=43233

    if (at->InitializedBuild != at->SelectedBuild)
    {
        EnchantItem(at->TesterPlayer, 57968, true);//Instant Poison IX
        EnchantItem(at->TesterPlayer, 57973, false);//Deadly Poison IX
        at->InitializedBuild = at->SelectedBuild;
    }

    if (at->TesterPlayer->GetComboPoints() < 5)
    {
        if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 48638)) // Sinister Strike
            return;
    }

    if (at->TesterPlayer->GetComboPoints() == 5 && at->SelectedUnit->GetAuraCount(48672) < 1 + at->ExtraBuffStack) // Rupture
    {
        if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 48672)) // Rupture
            return;
    }

    if (at->TesterPlayer->GetAuraCount(6774) < 1 + at->ExtraBuffStack && at->TesterPlayer->GetComboPoints() > 0) // Slice and Dice
    {
        if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 6774)) // Slice and Dice
            return;
    }

    if (at->TesterPlayer->GetComboPoints() == 5 && TryCastSpell(at->TesterPlayer, at->SelectedUnit, 48668)) // Eviscerate
        return;
}

void PriestDPS(Player *Owner)
{
    AutomatedTestPlayerStore *at = GetATStore(Owner);
    if (at->SelectedBuild == 0)
    {
        if (at->SelectedUnit->GetAuraCount(48160) < 1 + at->ExtraBuffStack) // Vampiric Touch
        {
            if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 48160)) // Vampiric Touch
                return;
        }

        if (at->SelectedUnit->GetAuraCount(48300) < 1 + at->ExtraBuffStack) // Devouring Plague
        {
            if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 48300)) // Devouring Plague
                return;
        }

        if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 48127)) // Mind Blast
            return;

        if (at->TesterPlayer->GetAuraCount(15258) != 0 && at->SelectedUnit->GetAuraCount(48125) < 1 + at->ExtraBuffStack) // Shadow Weaving
        {
            if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 48125)) // Shadow Word: Pain
                return;
        }

        if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 48156)) // Mind Flay
            return;
    }
    if (at->SelectedBuild == 1)
    {
        if (at->SelectedUnit->GetAuraCount(48135) < 1 + at->ExtraBuffStack) // Holy Fire
        {
            if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 48135)) // Holy Fire
                return;
        }
        if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 48123)) // smite
            return;
    }
    //healer priest
    if (at->SelectedBuild == 2)
    {
        if (at->TesterPlayer->GetAuraCount(48068) < 1 + at->ExtraBuffStack) // Renew
        {
            if (TryCastSpell(at->TesterPlayer, at->TesterPlayer, 48068)) // Renew
                return;
        }
        if (at->TesterPlayer->GetAuraCount(63734) == 3 + at->ExtraBuffStack) // Serendipity
        {
            if (TryCastSpell(at->TesterPlayer, at->TesterPlayer, 48063)) // Greater Heal
                return;
        }
        if (at->TesterPlayer->GetAuraCount(41637) == 0 && at->TesterPlayer->GetAuraCount(48111) == 0) // Prayer of Mending
        {
            if (TryCastSpell(at->TesterPlayer, at->TesterPlayer, 48113)) // Prayer of Mending
                return;
        }
        if (TryCastSpell(at->TesterPlayer, at->TesterPlayer, 48071)) // Flash Heal
            return;
    }
}

void WarlockDPS(Player *Owner)
{
    AutomatedTestPlayerStore *at = GetATStore(Owner);
    if (at->SelectedUnit->GetAuraCount(47865) < 1 + at->ExtraBuffStack) // Curse of the Elements
    {
        if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 47865)) // Curse of the Elements
            return;
    }
    if (at->SelectedUnit->GetAuraCount(47811) < 1 + at->ExtraBuffStack) // Immolate
    {
        if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 47811)) // Immolate
            return;
    }
    if (at->SelectedUnit->GetAuraCount(47813) < 1 + at->ExtraBuffStack) // Corruption
    {
        if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 47813)) // Corruption
            return;
    }
    if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 59172)) // Chaos Bolt
        return;
    if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 47838)) // Incinerate
        return;
    if (at->SelectedUnit->GetAuraCount(47811) != 0) // Immolate
    {
        if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 17962)) // Conflagrate
            return;
    }
}

void DeathKnightDPS(Player *Owner)
{
    AutomatedTestPlayerStore *at = GetATStore(Owner);
    if (at->TesterPlayer->GetAuraCount(57330) == 0) // Horn of Winter
    {
        if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 57330)) // Horn of Winter
            return;
    }
    if (at->SelectedUnit->GetAuraCount(55095) < 1 + at->ExtraBuffStack) // Frost Fever
    {
        if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 49909)) // Icy Touch
            return;
    }
    if (at->SelectedUnit->GetAuraCount(55078) < 1 + at->ExtraBuffStack) // Blood Plague
    {
        if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 49921)) // Plague Strike
            return;
    }
    if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 49020)) // Obliterate
        return;
    if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 49143)) // Frost Strike
        return;
    if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 45902)) // Blood Strike
        return;
    if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 55090)) // Scourge Strike
        return;
    if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 49895)) // Death Coil
        return;
}

void ShamanDPS(Player *Owner)
{
    AutomatedTestPlayerStore *at = GetATStore(Owner);
    if (at->SelectedBuild == 0)
    {
        if (at->InitializedBuild != at->SelectedBuild)
        {
            EnchantItem(at->TesterPlayer, 58790, true);//Flametongue Weapon
            EnchantItem(at->TesterPlayer, 58796, false);//Frostbrand Weapon
            at->InitializedBuild = at->SelectedBuild;
        }

        if (at->SelectedUnit->GetAuraCount(49233) < 1 + at->ExtraBuffStack) // Flame Shock
        {
            if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 49233)) // Flame Shock
                return;
        }
        if (at->SelectedUnit->GetAuraCount(49233) != 0) // Flame Shock
        {
            if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 60043)) // Lava Burst
                return;
        }
        if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 49238)) // Lightning Bolt
            return;
    }
    if (at->SelectedBuild == 1)
    {
        //should have enachnted weapon : Earthliving Weapon
        if (at->InitializedBuild != at->SelectedBuild)
        {
            EnchantItem(at->TesterPlayer, 51994, true);
            at->InitializedBuild = at->SelectedBuild;
        }

        if (at->TesterPlayer->GetAuraCount(49284) == 0) // Earth Shield
        {
            if (TryCastSpell(at->TesterPlayer, at->TesterPlayer, 49284)) // Water Shield
                return;
        }
        if (TryCastSpell(at->TesterPlayer, at->TesterPlayer, 10396)) // Healing Wave
            return;
    }
}

void DruidDPS(Player *Owner)
{
    AutomatedTestPlayerStore *at = GetATStore(Owner);

    if (at->SelectedBuild == 0)
    {
        if (at->TesterPlayer->GetAuraCount(768) == 0) // Cat Form
        {
            if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 768)) // Cat Form
                return;
        }

        if (at->TesterPlayer->GetAuraCount(50213) < 1 + at->ExtraBuffStack) // Tiger's Fury
        {
            if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 50213)) // Tiger's Fury
                return;
        }

        if (at->TesterPlayer->GetComboPoints() > 0 && at->TesterPlayer->GetAuraCount(52610) < 1 + at->ExtraBuffStack) // Savage Roar
        {
            if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 52610)) // Savage Roar
                return;
        }

        if (at->TesterPlayer->GetComboPoints() < 5) // Mangle (Cat)
        {
            if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 48566)) // Mangle (Cat)
                return;
        }

        if (at->TesterPlayer->GetComboPoints() > 0 && at->SelectedUnit->GetAuraCount(48574) < 1 + at->ExtraBuffStack) // Rake
        {
            if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 48574)) // Rake
                return;
        }

        if (at->TesterPlayer->GetComboPoints() == 5 && at->SelectedUnit->GetAuraCount(49800) < 1 + at->ExtraBuffStack) // Rip
        {
            if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 49800)) // Rip
                return;
        }

        if (at->TesterPlayer->GetComboPoints() == 5)
        {
            if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 48577)) // Ferocious Bite
                return;
        }

        if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 48572)) // Shred - reaquires behind target
            return;
    }
    //healer
    if (at->SelectedBuild == 1)
    {
        if (at->TesterPlayer->GetAuraCount(48443) < 1 + at->ExtraBuffStack) // Regrowth
        {
            if (TryCastSpell(at->TesterPlayer, at->TesterPlayer, 48443)) // Regrowth
                return;
        }
        if (at->TesterPlayer->GetAuraCount(48441) < 1 + at->ExtraBuffStack) // Rejuvenation
        {
            if (TryCastSpell(at->TesterPlayer, at->TesterPlayer, 48441)) // Rejuvenation
                return;
        }
        if (at->TesterPlayer->GetAuraCount(48451) < 3 + at->ExtraBuffStack) // Lifebloom
        {
            if (TryCastSpell(at->TesterPlayer, at->TesterPlayer, 48451)) // Lifebloom
                return;
        }
        if (TryCastSpell(at->TesterPlayer, at->TesterPlayer, 48378)) // Healing Touch
            return;
        if (TryCastSpell(at->TesterPlayer, at->TesterPlayer, 50464)) // Nourish
            return;
    }
    if (at->SelectedBuild == 2) // caster druid
    {
        if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 53201)) // Starfall
            return;

        if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 33831)) // Force of Nature
            return;

        if (at->SelectedUnit->GetAuraCount(48468) < 1 + at->ExtraBuffStack) // Insect Swarm
        {
            if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 48468)) // Insect Swarm
                return;
        }

        if (at->SelectedUnit->GetAuraCount(53308) < 1 + at->ExtraBuffStack) // Entangling Roots
        {
            if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 53308)) // Entangling Roots
                return;
        }

        if (at->SelectedUnit->GetAuraCount(48463) == 0) // Moonfire
        {
            if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 48463)) // Moonfire
                return;
        }

        if (at->TesterPlayer->GetAuraCount(48518) != 0) // Eclipse (Lunar)
        {
            if (TryCastSpell(at->TesterPlayer, at->TesterPlayer, 48465)) // Starfire
                return;
        }

        if (at->TesterPlayer->GetAuraCount(48517) != 0) // Eclipse (Solar)
        {
            if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 48461)) // Wrath
                return;
        }
        static int CastSwap = 0;
        if (CastSwap % 2 == 0)
        {
            if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 48461)) // Wrath
            {
                CastSwap++;
                return;
            }
        }
        else
        {
            if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 48465)) // Starfire
            {
                CastSwap++;
                return;
            }
        }
    }
    if (at->SelectedBuild == 3)
    {
        if (at->TesterPlayer->GetAuraCount(9634) == 0) // Dire Bear Form
        {
            if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 9634)) // Dire Bear Form
                return;
        }

        if (at->TesterPlayer->GetAuraCount(16857) == 0) // Faerie Fire (Feral)
        {
            if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 16857)) // Faerie Fire (Feral)
                return;
        }

        if (at->SelectedUnit->GetAuraCount(48564) == 0) // Mangle (Bear)
        {
            if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 48564)) // Mangle (Bear)
                return;
        }

        if (at->SelectedUnit->GetAuraCount(48568) < 5) // Lacerate
        {
            if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 48568)) // Lacerate
                return;
        }

        if (TryCastSpell(at->TesterPlayer, at->SelectedUnit, 48566)) // Maul
            return;
    }
}

void RI_MonitorAutomatedTest(void *p, void *context)
{
    Player *Owner = (Player*)p;
    AutomatedTestPlayerStore *at = GetATStore(Owner);
    if (at->TestPaused == true)
    {
        at->TesterPlayer->CombatStop();
        if (at->SelectedUnit != NULL)
            at->SelectedUnit->CombatStop();
        return;
    }
    if (at->EndStamp < GameTime::GetGameTimeMS())
    {
        EndPreviousTest(Owner);
        StartNextTest(Owner);
    }
    if (at->SelectedUnit == NULL)
        return;
    UpdatePlayerHealth(at->TesterPlayer);
    if (at->UsingManaBurnStat == true)
    {
        at->TesterPlayer->SetPower(POWER_MANA, at->TesterPlayer->GetMaxPower(POWER_MANA));
//        at->SelectedUnit->SetPower(POWER_MANA, at->SelectedUnit->GetMaxPower(POWER_MANA));
    }

    //in case player died and we lost selection
    if (at->SelectedUnit != NULL)
        at->TesterPlayer->SetSelection(at->SelectedUnit->GetGUID());
    //try to revive dead players
    if (at->TesterPlayer->IsAlive() == false)
    {
        at->TesterPlayer->ResurrectPlayer(false, false);
        at->TesterPlayer->RemoveAurasDueToSpell(8326);
        at->TesterPlayer->RemoveAurasDueToSpell(20584);
        at->TesterPlayer->RemoveFlag(PLAYER_FLAGS, PLAYER_FLAGS_GHOST);
        at->TesterPlayer->RemoveFlag(PLAYER_FLAGS, PLAYER_FLAGS_IS_OUT_OF_BOUNDS);
    }
    if (at->SelectedUnit->IsAlive() == false)
    {
        if (at->SelectedUnit->ToPlayer() != NULL)
            at->SelectedUnit->ToPlayer()->ResurrectPlayer(false, false);
        else
            at->SelectedUnit->setDeathState(ALIVE);
        at->SelectedUnit->RemoveAurasDueToSpell(8326);
        at->SelectedUnit->RemoveAurasDueToSpell(20584);
        at->SelectedUnit->RemoveFlag(PLAYER_FLAGS, PLAYER_FLAGS_GHOST);
        at->SelectedUnit->RemoveFlag(PLAYER_FLAGS, PLAYER_FLAGS_IS_OUT_OF_BOUNDS);
    }

    //if target is not a player, try to root him in place
    if (at->SelectedUnit->ToPlayer() == NULL && at->SelectedUnit->ToCreature() != NULL)
    {
//        static PassiveAI *pa = new PassiveAI(at->SelectedUnit->ToCreature());
//        if (at->SelectedUnit->GetAI() != pa)
//            at->SelectedUnit->ToCreature()->SetAI(pa);
        if (at->SelectedUnit->GetAuraCount(39258) == 0)
        {
            at->TesterPlayer->CastSpell(at->SelectedUnit, 39258);
            at->SelectedUnit->CastSpell(at->SelectedUnit, 39258);
        }
    }
    // anti afk macro : /run local f=CreateFrame("Frame")f:RegisterEvent("PLAYER_CAMPING")f:SetScript("OnEvent", function() local p=StaticPopup_Visible("CAMP")_G[p.."Button1"]:Click()end)

    //try to not get kicked out for afk
    if (at->TesterPlayer->isAFK())
        at->TesterPlayer->ToggleAFK();
    if (at->SelectedUnit->ToPlayer() && at->SelectedUnit->ToPlayer()->isAFK())
        at->SelectedUnit->ToPlayer()->ToggleAFK();

    //in case it doed, he will stop attacking and get kicked out for afk
    if(at->TesterPlayer->isAttackReady())
        at->TesterPlayer->Attack(at->SelectedUnit,true);
    if(at->SelectedUnit->isAttackReady())
        at->SelectedUnit->Attack(at->TesterPlayer, true);

    //if for some reason player exited PVP mode
    at->TesterPlayer->SetPvP(true);
    if(at->SelectedUnit->ToPlayer())
        at->SelectedUnit->ToPlayer()->SetPvP(true);

    if (at->TesterPlayer->getClass() == CLASS_MAGE)
        MageDPS(Owner);
    else if (at->TesterPlayer->getClass() == CLASS_WARRIOR)
        WarriorDPS(Owner);
    else if (at->TesterPlayer->getClass() == CLASS_PALADIN)
        PaladinDPS(Owner);
    else if (at->TesterPlayer->getClass() == CLASS_HUNTER)
        HunterDPS(Owner);
    else if (at->TesterPlayer->getClass() == CLASS_ROGUE)
        RogueDPS(Owner);
    else if (at->TesterPlayer->getClass() == CLASS_PRIEST)
        PriestDPS(Owner);
    else if (at->TesterPlayer->getClass() == CLASS_DEATH_KNIGHT)
        DeathKnightDPS(Owner);
    else if (at->TesterPlayer->getClass() == CLASS_SHAMAN)
        ShamanDPS(Owner);
    else if (at->TesterPlayer->getClass() == CLASS_WARLOCK)
        WarlockDPS(Owner);
    else if (at->TesterPlayer->getClass() == CLASS_DRUID)
        DruidDPS(Owner);
 /*   else
    {
        //try to autocast some spells
        static const uint32 AutoCastedSpellsIfPossible[] = {
            42650, 49930, 49938, 49895, 49924, 55268, 55262, 51411, 49909, 51425, 49921, 55271, 49941, // death knight
            48570, 48577, 48468, 62078, 53307, 48461, 49800, 48572, 53201, 48561, 48568, 48451, 49802, 48566, 48564, 48480, 48463, 48574, 48579, 48443, 48441, // druid - separate tests for cat, bear
            60053, 61006, 53339, 48996, 49001, 49052, 49012, 49045, 63672, 48999, 49050, // hunter
            42897, 42846, 42931, 42873, 42833, 42926, 42842, 42891, 42859, // mage
            31884, 48819, 48801, 48785, 48806, 48782, // paladin
            48173, 48300, 6064, 48135, 48127, 48066, 48068, 48125, 48123, // priest
            48668, 48660, 48666, 48672, 48638, // rogue should apply poisons to weapon. Should use daggers
            49271, 49231, 2894, 49233, 49236, 60043, 49238, 49281, // shaman should self cast 58804, 58790
            59172, 47813, 47864, 47811, 47838, 47815, 47809, 61290, 47825, // warlock
            47436, 64382, 47498, 47450, 47486, 47465, 57823, 47488, 47475, 47520, 47502 //warrior
        };
        if (at->TesterPlayer != NULL && at->TesterPlayer->GetCurrentSpell(CurrentSpellTypes::CURRENT_GENERIC_SPELL) == NULL && at->TesterPlayer->GetCurrentSpell(CurrentSpellTypes::CURRENT_CHANNELED_SPELL) == NULL && at->TesterPlayer->GetSelectedUnit() != NULL)
        {
            static int LastCastIndex = 0;

            int LastCastIndexLocal = LastCastIndex;
            for (int i = 0; i < _countof(AutoCastedSpellsIfPossible); i++)
            {
                uint32 VectIndex = (i + LastCastIndexLocal) % _countof(AutoCastedSpellsIfPossible);
                uint32 TryCastSpell = AutoCastedSpellsIfPossible[VectIndex];
                if (at->TesterPlayer->HasActiveSpell(TryCastSpell) == false)
                    continue;
                if (at->TesterPlayer->GetSpellHistory()->HasGlobalCooldown(sSpellMgr->AssertSpellInfo(TryCastSpell)))
                    continue;
                if (at->TesterPlayer->GetSpellHistory()->HasCooldown(TryCastSpell) == true)
                    continue;
                //            if (SecondParse == 0 && AntiSpamCooldowns[TryCastSpell] > GameTime::GetGameTimeMS())
                //                continue;

                            //try to cast it. Crossing fingers we will not fail
                TriggerCastFlags TriggerFlags;
                //cast it in cheat mode, no cooldowns, no cost, no nothing
                if (at->TesterPlayer->GetSelectedUnit()->HasAura(TryCastSpell) == true || at->TesterPlayer->HasAura(TryCastSpell) == true) //we are not smart enough to know how many times this will stack
                    TriggerFlags = ((TriggerCastFlags)(TRIGGERED_IGNORE_CAST_TIME | TRIGGERED_IGNORE_MOVE_CHECK | TRIGGERED_IGNORE_GCD | TRIGGERED_IGNORE_SPELL_AND_CATEGORY_CD | TRIGGERED_IGNORE_POWER_AND_REAGENT_COST));

                SpellCastTargets targets;
                targets.SetUnitTarget(at->SelectedUnit);
                targets.SetDst(at->SelectedUnit->GetPosition());
                targets.SetSrc(at->TesterPlayer->GetPosition());

                SpellInfo const* info = sSpellMgr->GetSpellInfo(TryCastSpell);
                Spell* spell = new Spell(at->TesterPlayer, info, TriggerFlags);
                if (spell->CheckCast(true) != SPELL_FAILED_SUCCESS)
                    continue;

                spell->prepare(targets);

                //try to not spam the same spell too much
    //            AntiSpamCooldowns[TryCastSpell] = GameTime::GetGameTimeMS() + ExpectedCooldown;
                LastCastIndex = i + 1;
                break;
            }
        }
    }*/
}


//on chat message, write it to DB
void RIOnChatMessageReceivedForTesting(void *p, void *)
{
    CP_CHAT_RECEIVED *params = PointerCast(CP_CHAT_RECEIVED, p);
    const char *msg = params->Msg->c_str();

    if (msg[0] != '@' || msg[1] != 'a' || msg[2] != 't')
        return;
    //reload the list of test we should perform
    if (StrTestEQ("@at_load", msg) != NULL)
        LoadScripts(params->SenderPlayer);
    else if (StrTestEQ("@at_jumpto", msg) != NULL)
    {
        const char *ValStart = StrTestEQ("@at_jumpto", msg) + 1;
        AutomatedTestPlayerStore *at = GetATStore(params->SenderPlayer);
        if (ValStart[0] != 0)
        {
            at->FileName = NULL;
            int PlayerClass = at->TesterPlayer->getClass();
            TestIndex[PlayerClass] = atoi(ValStart + 1);
            if (TestIndex[PlayerClass] > TestFileNames[PlayerClass].size())
            {
                printf("Could not jump to index %d, resetting to 0\n", TestIndex[PlayerClass]);
                TestIndex[PlayerClass] = 0;
            }
            printf("Will jump to next script : %d\n", TestIndex[PlayerClass]);
        }
    }
    else if (StrTestEQ("@at_pause", msg) != NULL)
    {
        AutomatedTestPlayerStore *at = GetATStore(params->SenderPlayer);
        int PlayerClass = at->TesterPlayer->getClass();
        if (at->TestPaused == false)
        {
            params->SenderPlayer->BroadcastMessage("Script execution will be paused");
            at->TestPaused = true;
        }
        else
        {
            params->SenderPlayer->BroadcastMessage("Script execution will be resumed. Last script needs a remake. Decreasing index by 1");
            at->TestPaused = false;
            if(TestIndex[PlayerClass] > 0)
                TestIndex[PlayerClass]--;
            if(at->FileName != NULL)
                TakenTestFileNames[PlayerClass].remove(at->FileName->c_str());
        }
    }
    else if (StrTestEQ("@at_stop", msg) != NULL)
    {
        AutomatedTestPlayerStore *at = GetATStore(params->SenderPlayer);
        int PlayerClass = at->TesterPlayer->getClass();
        if (TestIndex[PlayerClass] > 0)
            TestIndex[PlayerClass]--;
        at->FileName = NULL;
        params->SenderPlayer->BroadcastMessage("Stopped testing scripts");
        params->SenderPlayer->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_PERIODIC_TICK, RI_MonitorAutomatedTest, NULL);
    }
    else if (StrTestEQ("@at_start", msg) != NULL)
    {
        if (params->SenderPlayer->GetSelectedUnit() == NULL)
        {
            params->SenderPlayer->BroadcastMessage("Need to select a target unit to run tests on");
            return;
        }
        params->SenderPlayer->BroadcastMessage("Started searching for a script that this class can execute");
        AutomatedTestPlayerStore *at = GetATStore(params->SenderPlayer);
        params->SenderPlayer->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_PERIODIC_TICK, RI_MonitorAutomatedTest, NULL);
        int PlayerClass = at->TesterPlayer->getClass();
//        TestIndex[PlayerClass] = 0;
        at->EndStamp = 0;
        at->FileName = NULL;
        at->TesterPlayer = params->SenderPlayer;
    }
    else if (StrTestEQ("@at_cleardone", msg) != NULL)
    {
        params->SenderPlayer->BroadcastMessage("Cleared list of finished scripts");
        TakenTestFileNames[params->SenderPlayer->getClass()].clear();
        TestIndex[params->SenderPlayer->getClass()] = 0;
    }
    else if (StrTestEQ("@at_owerwrite", msg) != NULL)
    {
        if (OwerwriteExistingTests == false)
        {
            params->SenderPlayer->BroadcastMessage("Old results will be overwritten");
            OwerwriteExistingTests = true;
        }
        else
        {
            params->SenderPlayer->BroadcastMessage("Old results will not be overwritten");
            OwerwriteExistingTests = false;
        }
    }
    else if (StrTestEQ("@at_removeitems", msg) != NULL)
    {
        for (int i = EQUIPMENT_SLOT_START; i != EQUIPMENT_SLOT_END; i++)
            params->SenderPlayer->RemoveItem(INVENTORY_SLOT_BAG_0, i, true);
        for (int i = INVENTORY_SLOT_ITEM_START; i != INVENTORY_SLOT_ITEM_END; i++)
            params->SenderPlayer->RemoveItem(INVENTORY_SLOT_BAG_0, i, true);
    }
    else if (StrTestEQ("@at_gearup", msg) != NULL)
    {
        //remove old items
        for (int i = EQUIPMENT_SLOT_START; i != EQUIPMENT_SLOT_END; i++)
            params->SenderPlayer->RemoveItem(INVENTORY_SLOT_BAG_0, i, true);
        for (int i = INVENTORY_SLOT_ITEM_START; i != INVENTORY_SLOT_ITEM_END; i++)
            params->SenderPlayer->RemoveItem(INVENTORY_SLOT_BAG_0, i, true);

        Player *p = params->SenderPlayer;
        p->BroadcastMessage("Adding items to be used");
        int PlayerClass = p->getClass();
        if (PlayerClass == CLASS_MAGE)
        {
            p->AddItem(51280, 1);
            p->AddItem(51281, 1);
            p->AddItem(51282, 1);
            p->AddItem(51283, 1);
            p->AddItem(51284, 1);
            p->AddItem(50731, 1);
            p->AddItem(50631, 1);
            p->AddItem(54588, 1);
            p->AddItem(50348, 1);
            p->AddItem(54585, 1); // - Ring of Phased Regeneration
            p->AddItem(50614, 1); // - Loop of the Endless Labyrinth
            p->AddItem(50609, 1); // - Bone Sentinel's Amulet
            p->AddItem(54583, 1); // - Cloak of Burning Dusk
            p->AddItem(51328, 1); // - Wrathful Gladiator's Treads of Dominance
            p->AddItem(51327, 1); // - Wrathful Gladiator's Cord of Dominance
            p->AddItem(51329, 1); // - Wrathful Gladiator's Cuffs of Dominance
        }
        else if (PlayerClass == CLASS_WARRIOR)
        {
            p->AddItem(51225, 1);
            p->AddItem(51226, 1);
            p->AddItem(51227, 1);
            p->AddItem(51228, 1);
            p->AddItem(51229, 1);
            p->AddItem(49623, 2);
            p->AddItem(50706, 1);
            p->AddItem(50343, 1);
            p->AddItem(50657, 1); // - Skeleton Lord's Circle
            p->AddItem(50693, 1); // - Might of Blight
            p->AddItem(54581, 1); // - Penumbra Pendant
            p->AddItem(50677, 1); // - Winding Sheet
            p->AddItem(50659, 1); // - Polar Bear Claw Bracers
            p->AddItem(51363, 1); // - Wrathful Gladiator's Greaves of Triumph
            p->AddItem(51362, 1); // - Wrathful Gladiator's Girdle of Triumph
            p->AddItem(51364, 1); // - Wrathful Gladiator's Bracers of Triumph
            p->AddItem(51395, 1); // - Wrathful Gladiator's Recurve
        }
        else if (PlayerClass == CLASS_PALADIN)
        {
            p->AddItem(51275, 1);
            p->AddItem(51276, 1);
            p->AddItem(51277, 1);
            p->AddItem(51278, 1);
            p->AddItem(51279, 1);
            p->AddItem(49623, 1);
            p->AddItem(50706, 1);
            p->AddItem(50343, 1);
            p->AddItem(50657, 1); // - Ashen Band of Endless Vengeance
            p->AddItem(50614, 1); // - Loop of the Endless Labyrinth
            p->AddItem(54581, 1); // - Penumbra Pendant
            p->AddItem(50677, 1); // - Winding Sheet
            p->AddItem(51363, 1); // - Wrathful Gladiator's Greaves of Triumph
            p->AddItem(51362, 1); // - Wrathful Gladiator's Girdle of Triumph
            p->AddItem(51364, 1); // - Wrathful Gladiator's Bracers of Triumph
        }
        else if (PlayerClass == CLASS_HUNTER)
        {
            p->AddItem(51285, 1);
            p->AddItem(51286, 1);
            p->AddItem(51287, 1);
            p->AddItem(51288, 1);
            p->AddItem(51289, 1);
            p->AddItem(50638, 1);
            p->AddItem(50735, 1);
            p->AddItem(52021, 5000);
            p->AddItem(50355, 1);
            p->AddItem(50362, 1);
            p->AddItem(54576, 1); // - ring Signet of Twilight
            p->AddItem(50618, 1); // - Frostbrood Sapphire Ring
            p->AddItem(50633, 1); // - Sindragosa's Cruel Claw
            p->AddItem(50653, 1); // - Shadowvault Slayer's Cloak
            p->AddItem(51351, 1); // - Wrathful Gladiator's Sabatons of Triumph
            p->AddItem(51350, 1); // - Wrathful Gladiator's Waistguard of Triumph
            p->AddItem(51352, 1); // - Wrathful Gladiator's Wristguards of Triumph
        }
        else if (PlayerClass == CLASS_ROGUE)
        {
            p->AddItem(51250, 1);
            p->AddItem(51251, 1);
            p->AddItem(51252, 1);
            p->AddItem(51253, 1);
            p->AddItem(51254, 1);
            p->AddItem(50736, 2);
            p->AddItem(50706, 1);
            p->AddItem(50343, 1);
            p->AddItem(54576, 1); // - ring Signet of Twilight
            p->AddItem(50618, 1); // - Frostbrood Sapphire Ring
            p->AddItem(50633, 1); // - Sindragosa's Cruel Claw
            p->AddItem(50653, 1); // - Shadowvault Slayer's Cloak
            p->AddItem(51369, 1); // - Wrathful Gladiator's Boots of Triumph
            p->AddItem(51368, 1); // - Wrathful Gladiator's Belt of Triumph
            p->AddItem(51370, 1); // - Wrathful Gladiator's Armwraps of Triumph
            p->AddItem(51395, 1); // - Wrathful Gladiator's Recurve
        }
        else if (PlayerClass == CLASS_PRIEST)
        {
            p->AddItem(51255, 1);
            p->AddItem(51256, 1);
            p->AddItem(51257, 1);
            p->AddItem(51258, 1);
            p->AddItem(51259, 1);
            p->AddItem(50731, 1);
            p->AddItem(50631, 1);
            p->AddItem(54588, 1);
            p->AddItem(50348, 1);
            p->AddItem(54585, 1); // - Ring of Phased Regeneration
            p->AddItem(50614, 1); // - Loop of the Endless Labyrinth
            p->AddItem(50609, 1); // - Bone Sentinel's Amulet
            p->AddItem(54583, 1); // - Cloak of Burning Dusk
            p->AddItem(51328, 1); // - Wrathful Gladiator's Treads of Dominance
            p->AddItem(51327, 1); // - Wrathful Gladiator's Cord of Dominance
            p->AddItem(51329, 1); // - Wrathful Gladiator's Cuffs of Dominance
        }
        else if (PlayerClass == CLASS_DEATH_KNIGHT)
        {
            p->AddItem(51310, 1);
            p->AddItem(51311, 1);
            p->AddItem(51312, 1);
            p->AddItem(51313, 1);
            p->AddItem(51314, 1);
            p->AddItem(49623, 1);
            p->AddItem(50706, 1);
            p->AddItem(50343, 1);
            p->AddItem(50693, 1); // - Might of Blight
            p->AddItem(50657, 1); // - Skeleton Lord's Circle
            p->AddItem(54581, 1); // - Penumbra Pendant
            p->AddItem(50677, 1); // - Winding Sheet
            p->AddItem(51363, 1); // - Wrathful Gladiator's Greaves of Triumph
            p->AddItem(51362, 1); // - Wrathful Gladiator's Girdle of Triumph
            p->AddItem(51364, 1); // - Wrathful Gladiator's Bracers of Triumph
            p->AddItem(51395, 1); // - Wrathful Gladiator's Recurve
        }
        else if (PlayerClass == CLASS_SHAMAN)
        {
            p->AddItem(51235, 1);
            p->AddItem(51236, 1);
            p->AddItem(51237, 1);
            p->AddItem(51238, 1);
            p->AddItem(51239, 1);
            p->AddItem(50734, 1);
            p->AddItem(50737, 1);
            p->AddItem(54588, 1);
            p->AddItem(50348, 1);
            p->AddItem(54585, 1); // - Ring of Phased Regeneration
            p->AddItem(50614, 1); // - Loop of the Endless Labyrinth
            p->AddItem(50609, 1); // - Bone Sentinel's Amulet
            p->AddItem(54583, 1); // - Cloak of Burning Dusk
            p->AddItem(51351, 1); // - Wrathful Gladiator's Sabatons of Triumph
            p->AddItem(51350, 1); // - Wrathful Gladiator's Waistguard of Triumph
            p->AddItem(51352, 1); // - Wrathful Gladiator's Wristguards of Triumph
        }
        else if (PlayerClass == CLASS_WARLOCK)
        {
            p->AddItem(51230, 1);
            p->AddItem(51231, 1);
            p->AddItem(51232, 1);
            p->AddItem(51233, 1);
            p->AddItem(51234, 1);
            p->AddItem(50731, 1);
            p->AddItem(50631, 1);
            p->AddItem(54588, 1);
            p->AddItem(50365, 1);
            p->AddItem(54585, 1); // - Ring of Phased Regeneration
            p->AddItem(50614, 1); // - Loop of the Endless Labyrinth
            p->AddItem(50609, 1); // - Bone Sentinel's Amulet
            p->AddItem(54583, 1); // - Cloak of Burning Dusk
            p->AddItem(51328, 1); // - Wrathful Gladiator's Treads of Dominance
            p->AddItem(51327, 1); // - Wrathful Gladiator's Cord of Dominance
            p->AddItem(51329, 1); // - Wrathful Gladiator's Cuffs of Dominance
        }
        else if (PlayerClass == CLASS_DRUID)
        {
            p->AddItem(51295, 1);
            p->AddItem(51296, 1);
            p->AddItem(51297, 1);
            p->AddItem(51298, 1);
            p->AddItem(51299, 1);
            p->AddItem(50731, 1);
            p->AddItem(54588, 1);
            p->AddItem(50348, 1);
            p->AddItem(54576, 1); // - ring Signet of Twilight
            p->AddItem(50614, 1); // - Loop of the Endless Labyrinth
            p->AddItem(50609, 1); // - Bone Sentinel's Amulet
            p->AddItem(54583, 1); // - Cloak of Burning Dusk
            p->AddItem(50653, 1); // - Shadowvault Slayer's Cloak
            p->AddItem(51369, 1); // - Wrathful Gladiator's Boots of Triumph
            p->AddItem(51368, 1); // - Wrathful Gladiator's Belt of Triumph
            p->AddItem(51370, 1); // - Wrathful Gladiator's Armwraps of Triumph
        }

        //try to equip items automatically
        for (int i = INVENTORY_SLOT_ITEM_START; i != INVENTORY_SLOT_ITEM_END; i++)
        {
            Item* pSrcItem = params->SenderPlayer->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
            if (!pSrcItem)
                continue;

            uint16 dest;
            InventoryResult msg = params->SenderPlayer->CanEquipItem(NULL_SLOT, dest, pSrcItem, !pSrcItem->IsBag());
            if (msg == EQUIP_ERR_OK)
            {
                params->SenderPlayer->RemoveItem(INVENTORY_SLOT_BAG_0, i, true);
                params->SenderPlayer->EquipItem(dest, pSrcItem, true);
            }
        }
    }
}
#endif

void LoadAutomatedTestingScript()
{
#ifdef _DEBUG
    LoadScripts(NULL);
    RegisterCallbackFunction(CALLBACK_TYPE_CHAT_RECEIVED, RIOnChatMessageReceivedForTesting, NULL);
#endif
}
