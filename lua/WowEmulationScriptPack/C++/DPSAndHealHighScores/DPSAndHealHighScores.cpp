#include "SharedDefines.h"
#include "ScriptMgr.h"
#include "GameEventCallbacks.h"
#include "ObjectExtension.cpp"
#include "Player.h"
#include "DatabaseEnv.h"
#include "Creature.h"
#include "Map.h"
#include "GameTime.h"

#define MINIMUM_TIME_TO_MEASURE_VALUE_PER_SECOND_MS     15000   // avoid 1 hit values
#define MAX_TIME_SINCE_LAST_EVENT_MS                    5000

#ifdef _DEBUG
//    #define DEBUG_DPS_SCORE 1
    #define DEBUG_DPS_SCORE 0
#else
    #define DEBUG_DPS_SCORE 0
#endif

struct ValuePerSecondStore
{
    //self zero
    ValuePerSecondStore()
    {
        SumOfValues = 0;
        LastRecordedValueStamp = 1; // avoid division by 0 errors
        EnteredMeasureModeStamp = 0;
        BestValuePerSecond = 0;
    }

    void LoadDBValue(uint32 OwnerGuid, const char *DBTableName)
    {
        //we already loaded value from DB
        if (BestValuePerSecond != 0)
            return;

        char Query[5000];
        sprintf_s(Query, sizeof(Query), "Select BestVPS from %s where guid = %d", DBTableName, OwnerGuid);
        QueryResult result = CharacterDatabase.Query(Query);
        if (result && result->GetRowCount() >= 1)
        {
            Field* fields = result->Fetch();
            BestValuePerSecond = fields[0].GetUInt32();
        }
        else
            BestValuePerSecond = 1; // avoid spamming DB with queries
        if (DEBUG_DPS_SCORE == 1)printf("Loaded DPS highscore value from DB : %lld\n", BestValuePerSecond);
    }

    void SaveDBValue(uint32 OwnerGuid, uint32 BestValuePerSecond, uint32 TimePassedSinceRecordingSeconds, const char *DBTableName)
    {
        char Query[5000];
        sprintf_s(Query, sizeof(Query), "replace into %s values ( %d, %d, %d )", DBTableName, OwnerGuid, BestValuePerSecond, TimePassedSinceRecordingSeconds);
        CharacterDatabase.Execute(Query);
    }

    //every time we hit someone or heal someone
    void OnNewValueReceived(Unit *Owner, uint32 Value, const char *DBTableName)
    {
        //changed target ? Reset the measure. Healers might change targets more than DPS players. Might have an issue here
        uint32 TimeNowMS = GameTime::GetGameTimeMS();

        //before we reset, check if this is a new record VPS
        uint32 TimePassedSinceRecordingMS = (LastRecordedValueStamp - EnteredMeasureModeStamp);
        if (TimePassedSinceRecordingMS >= MINIMUM_TIME_TO_MEASURE_VALUE_PER_SECOND_MS)
        {
            //calculate last DPS/HPS
            uint64 ValuePerSecondMeasured = (uint64)(SumOfValues / (uint64)(TimePassedSinceRecordingMS / 1000 ));
            if (DEBUG_DPS_SCORE == 1)printf("DPS highscore debug : got new DPS value of %lld\n", ValuePerSecondMeasured);

            //get current DB value if not yet loaded
            if(DBTableName != NULL)
                LoadDBValue(Owner->GetGUID().GetCounter(), DBTableName);

            //save new highscore
            if (ValuePerSecondMeasured > BestValuePerSecond)
            {
                if (DEBUG_DPS_SCORE == 1)printf("DPS highscore debug : new DPS of %lld is higher than old %lld\n", ValuePerSecondMeasured, BestValuePerSecond);

                // we got a new highscore
                BestValuePerSecond = ValuePerSecondMeasured;

                // the real save
                if (DBTableName != NULL)
                {
                    SaveDBValue(Owner->GetGUID().GetCounter(), (uint32)BestValuePerSecond, TimePassedSinceRecordingMS / 1000, DBTableName);

                    //let the player know
                    Owner->ToPlayer()->BroadcastMessage("You got a new DPS/HPS highscore %d", BestValuePerSecond);
                }
            }
        }

        //reset values
        uint32 TimePassedSincePreviousValueMS = (TimeNowMS - LastRecordedValueStamp);
        if (TimePassedSincePreviousValueMS > MAX_TIME_SINCE_LAST_EVENT_MS)
        {
            if (DEBUG_DPS_SCORE == 1)printf("DPS highscore debug : reset DPS as new fight started\n");
            SumOfValues = 0;
            EnteredMeasureModeStamp = TimeNowMS - 1; // avoid division by 0 errors, substract 1
        }

        //every time we get a new value, we just sum it up
        SumOfValues += Value;
        LastRecordedValueStamp = TimeNowMS;
        if (DEBUG_DPS_SCORE == 1)printf("DPS highscore debug : added new DPS value %d, current DPS %d\n", Value, (uint32)( SumOfValues * 1000 / (LastRecordedValueStamp - EnteredMeasureModeStamp + 1) ));
    }
    unsigned long long GetVPS() { return BestValuePerSecond; }
protected:
    uint64      SumOfValues;             // since we started counting, we got so many values
    uint32      EnteredMeasureModeStamp; // when we started summing up values
    uint32      LastRecordedValueStamp;
    uint64      BestValuePerSecond;
};

void DPSValuePerSecondHandler(void *p, void *)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    //in case this is called more than once
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Attacker->ToPlayer() == NULL)
    {
        //         printf("No dmg, attacker or victim\n");
        return;
    }
    //our addon store
    ValuePerSecondStore *vs = params->Attacker->GetCreateExtension<ValuePerSecondStore>(OE_PLAYER_DPS_STORE);
    vs->OnNewValueReceived( params->Attacker, params->OriDamage, "character_DPSHighScore");

    //no aoe spells
    if (params->sp != NULL && params->sp->IsTargetingArea() == true)
        return;

    vs = params->Attacker->GetCreateExtension<ValuePerSecondStore>(OE_PLAYER_DPS_SINGLE_TARGET_STORE);
    vs->OnNewValueReceived(params->Attacker, params->OriDamage, NULL);
}

void HPSValuePerSecondHandler(void *p, void *)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    //in case this is called more than once
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Attacker->ToPlayer() == NULL)
    {
        //         printf("No dmg, attacker or victim\n");
        return;
    }
    ValuePerSecondStore *vs = params->Attacker->GetCreateExtension<ValuePerSecondStore>(OE_PLAYER_HPS_STORE);
    vs->OnNewValueReceived( params->Attacker, params->OriDamage, "character_HPSHighScore");
}

bool CanPlayerAwardKillReward(Player *Killer, Player *Victim);

class TC_GAME_API ValuePerSecondRegisterScript : public PlayerScript
{
public:
    ValuePerSecondRegisterScript() : PlayerScript("ValuePerSecondRegisterScript") {}

    void OnLogin(Player* player, bool firstLogin)
    {
        player->RegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, DPSValuePerSecondHandler);
        player->RegisterCallbackFunc(CALLBACK_TYPE_HEAL_DONE, HPSValuePerSecondHandler);
    }

    void OnDelete(ObjectGuid guid, uint32 accountId)
    {
        char Query[5000];
        sprintf_s(Query, sizeof(Query), "delete from character_DPSHighScore where GUID=%d", (uint32)guid.GetRawValue());
        CharacterDatabase.Execute(Query);
    }
};

unsigned long long GetSingleTargetDPS(Player *Owner)
{
    ValuePerSecondStore *vs = Owner->GetCreateExtension<ValuePerSecondStore>(OE_PLAYER_DPS_SINGLE_TARGET_STORE);
    return vs->GetVPS();
}

void ResetSingleTargetDPS(Player *Owner)
{
    Owner->SetExtension<ValuePerSecondStore>(OE_PLAYER_DPS_SINGLE_TARGET_STORE, new ValuePerSecondStore(), true);
}

void AddDPSAndHealHighScoresScripts()
{
    //CREATE TABLE `character_DPSHighScore` ( `GUID` INT NULL, `BestVPS` INT NULL, `MeasureTime` INT NULL );
    //ALTER TABLE `character_DPSHighScore` ADD INDEX `GUID` (`GUID`) USING BTREE;
    //CREATE UNIQUE INDEX relation ON character_DPSHighScore (GUID);
    //CREATE TABLE `character_HPSHighScore` ( `GUID` INT NULL, `BestVPS` INT NULL, `MeasureTime` INT NULL );
    //ALTER TABLE `character_HPSHighScore` ADD INDEX `GUID` (`GUID`) USING BTREE;
    //CREATE UNIQUE INDEX relation ON character_HPSHighScore (GUID);

    new ValuePerSecondRegisterScript();
}
