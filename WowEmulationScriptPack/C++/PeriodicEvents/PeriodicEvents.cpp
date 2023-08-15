#include "Player.h"
#include "ScriptMgr.h"
#include "Map.h"
#include "Creature.h"
#include "GameEventCallbacks.h"
#include <time.h>
#include "World.h"
#include "WorldSession.h"
#include <windows.h>
#include <stdio.h>
#include "MapManager.h"
#include "RBAC.h"
#include "ItemTemplate.h"
#include "GameTime.h"

enum ServerEventTypes
{
    SE_MULTIPLIED_HEALING_EVERYWHERE                = 1,
    SE_MULTIPLIED_HEALING_INSTANCES                 = 2,
    SE_MULTIPLIED_HEALING_SPECIFIC_INSTANCE         = 3,
    SE_MULTIPLIED_DMG_EVERYWHERE                    = 4,
    SE_MULTIPLIED_DMG_INSTANCES                     = 5,
    SE_MULTIPLIED_DAMAGE_SPECIFIC_INSTANCE          = 6,
    SE_MULTIPLIED_LOOT_EVERYWHERE                   = 7,
    SE_MULTIPLIED_LOOT_INSTANCES                    = 8,
    SE_MULTIPLIED_LOOT_SPECIFIC_INSTANCE            = 9,
    SE_MULTIPLIED_GOLD_EVERYWHERE                   = 10,
    SE_MULTIPLIED_GOLD_INSTANCES                    = 11,
    SE_MULTIPLIED_GOLD_SPECIFIC_INSTANCE            = 12,
    SE_REDUCED_CREATURE_HEALTH_EVERYWHERE           = 13,
    SE_REDUCED_CREATURE_HEALTH_ANY_INSTANCE         = 14,
    SE_REDUCED_CREATURE_HEALTH_SPECIFIC_INSTANCE    = 15,
    SE_REDUCED_CREATURE_DMG_EVERYWHERE              = 16,
    SE_REDUCED_CREATURE_DMG_ANY_INSTANCE            = 17,
    SE_REDUCED_CREATURE_DMG_SPECIFIC_INSTANCE       = 18,
    SE_SPAWN_CREATURE                               = 19,
    SE_MULTIPLIED_HONOR                             = 20,
    SE_MULTIPLIED_CRAFTING                          = 21,
    SE_MULTIPLIED_GATHERING                         = 22,
    SE_MULTIPLIED_DURABILITY_LOSS                   = 23,
    SE_INCREASED_MOVEMENT_SPEED_ANYWHERE            = 24,
    SE_INCREASED_MOVEMENT_SPEED_INSTANCES           = 25,
    SE_INCREASED_MOVEMENT_SPEED_SPECIFIC_MAP        = 26,
    SE_INCREASED_ITEM_STATS_ON_LOOT_ANYWHERE        = 27,
    SE_INCREASED_ITEM_STATS_ON_LOOT_INSTANCES       = 28,
    SE_INCREASED_ITEM_STATS_ON_LOOT_SPECIFIC_MAP    = 29,
    SE_INCREASED_POWER_REGEN_ANYWHERE               = 30,
    SE_INCREASED_POWER_REGEN_INSTANCES              = 31,
    SE_INCREASED_POWER_REGEN_SPECIFIC_MAP           = 32,
    SE_INCREASED_HASTE_ANYWHERE                     = 33,
    SE_INCREASED_HASTE_INSTANCES                    = 34,
    SE_INCREASED_HASTE_SPECIFIC_MAP                 = 35,
    SE_LOOT_ONLY_ITEM_QUALITY_ANYWHERE              = 36,
    SE_LOOT_ONLY_ITEM_QUALITY_INSTANCES             = 37,
    SE_LOOT_ONLY_ITEM_QUALITY_SPECIFIC_MAP          = 38,
    SE_LOOTED_ITEMS_COUNT_ANYWHERE                  = 39,
    SE_LOOTED_ITEMS_COUNT_INSTANCES                 = 40,
    SE_LOOTED_ITEMS_COUNT_SPECIFIC_MAP              = 41,
    SE_MAX_EVENT_TYPES
};

void ServerEventHealingReceivedAnywhere(void *p, void *c);
void ServerEventHealingReceivedSpecificMap(void *p, void *c);
void ServerEventHealingReceivedInstances(void *p, void *c);
void ServerEventDmgDoneAnywhere(void *p, void *c);
void ServerEventDmgDoneSpecificMap(void *p, void *c);
void ServerEventDmgDoneInstances(void *p, void *c);
void ServerEventCreatureLootAnywhere(void *p, void *c);
void ServerEventCreatureLootInstances(void *p, void *c);
void ServerEventCreatureLootSpecificMap(void *p, void *c);
void ServerEventCreatureGoldLootAnywhere(void *p, void *c);   // same code as for loot
void ServerEventCreatureGoldLootInstances(void *p, void *c);  // same code as for loot
void ServerEventCreatureGoldLootSpecificMap(void *p, void *c);// same code as for loot
void ServerEventCreatureSpawnHealthAnywhere(void *p, void *c);
void ServerEventCreatureSpawnHealthInstances(void *p, void *c);
void ServerEventCreatureSpawnHealthSpecificMap(void *p, void *c);
void ServerEventCreatureDmgAnywhere(void *p, void *c);
void ServerEventCreatureDmgInstances(void *p, void *c);
void ServerEventCreatureDmgSpecificMap(void *p, void *c);
void ServerEventCreatureLootQualityAnywhere(void *p, void *c);
void ServerEventCreatureLootQualityInstances(void *p, void *c);
void ServerEventCreatureLootQualitySpecificMap(void *p, void *c);
void ServerEventCreatureLootGroupAnywhere(void *p, void *c);
void ServerEventCreatureLootGroupInstances(void *p, void *c);
void ServerEventCreatureLootGroupSpecificMap(void *p, void *c);


bool CheckValidClientCommand(const char *cmsg, int32 type, const char * channel);

time_t ConvertTimeOfTheWeekToTime(int32 DayOfTheWeek, uint32 Hour, uint32 Minute)
{
    //get current time, format it, overwrite with our hour and minute, get it in time format
    time_t rawtime;
    struct tm ptm;

    time(&rawtime); //get current time

    localtime_r(&rawtime, &ptm); // convert to formated time
    ptm.tm_hour = Hour;
    ptm.tm_min = Minute;
    if (DayOfTheWeek >= 0 && DayOfTheWeek < 7)
    {
        ptm.tm_mday = ptm.tm_mday - ptm.tm_wday + DayOfTheWeek;
        ptm.tm_wday = DayOfTheWeek;
    }

    return mktime(&ptm);
}

#define INVALID_VALUE_OR_UNINTITIALIZED     0xFFFF

// struct to hold 1 single event. We will have a list of events that we will monitor
class EventStore
{
public:
    ~EventStore()
    {
        if (IsEventRunning() == true)
            OnEventStopped();
    }
    //kinda like a constructor called multiple times
    void    ResetVlaues()
    {
        NameDescription[0] = 0;
        StartHour = StartMinute = EndHour = EndMinute = EventType = SpawnEntry = MapId = INVALID_VALUE_OR_UNINTITIALIZED;
        AddedValue = 0;
        StartStamp = EndStamp = 0;
        SpawnX = SpawnY = SpawnZ = SpawnO = HealingDmgHonorMultiplier = 0;
        DayOfTheWeek = 9;   //invalid day means it will not be used
        EventRunStatus = NOT_INITIALIZED_AT_ALL;
        RegisteredCallbackType = MAX_CALLBACKEVENT_TYPES;
        CallbackPointer = NULL;
    }

    //after loading an event, check if it has all the minimum required values to function
    bool EventHasValuesToFunction()
    {
        if (EventType == INVALID_VALUE_OR_UNINTITIALIZED || EventType >= SE_MAX_EVENT_TYPES )
            return false;
        if (StartHour == INVALID_VALUE_OR_UNINTITIALIZED || EndHour == INVALID_VALUE_OR_UNINTITIALIZED)
            return false;
        if (NameDescription[0] == 0)
            return false;
        if (EventType == SE_SPAWN_CREATURE && (SpawnX == 0 || SpawnY == 0))
            return false;
        return true;
    }

    //minutes until the event will expire
    int32 GetRemainingMinutes()
    {
        return (int32)((EndStamp - GameTime::GetGameTime())/60);
    }

    //debugging purpuses. Print the status of the event
    void PrintStatus()                   // for debug purpuses
    {
#ifndef _DEBUG
        return;
#endif
        UpdateStartEndStamps(); // make sure we have timestamp in daily format

        int SecondsRemain = (int)(StartStamp - GameTime::GetGameTime());
        int DaysRemain = SecondsRemain / 60 / 60 / 24;
        int HoursRemain = ( SecondsRemain / 60 / 60 ) % 24;
        int MinutesRemain = ( SecondsRemain / 60 ) % 60;
        printf("Time until the event starts : %d:%d:%d\n", DaysRemain, abs(HoursRemain), abs(MinutesRemain));

        SecondsRemain = (int)(EndStamp- GameTime::GetGameTime());
        DaysRemain = SecondsRemain / 60 / 60 / 24;
        HoursRemain = (SecondsRemain / 60 / 60) % 24;
        MinutesRemain = (SecondsRemain / 60) % 60;
        printf("Time until the event ends : %d:%d:%d\n", DaysRemain, abs(HoursRemain), abs(MinutesRemain));

        SecondsRemain = (int)(EndStamp - StartStamp);
        HoursRemain = SecondsRemain / 60 / 60;
        MinutesRemain = (SecondsRemain - HoursRemain * 60 * 60) / 60;
        printf("Time duration of the envent : %d:%d\n", HoursRemain, abs(MinutesRemain));
        printf("EventType : %d\n", EventType);
        printf("Event can be active : %d\n", EventHasValuesToFunction());
        printf("Event should be active : %d\n", EventShouldBeActive());
    }

    // no init has been done for now
    void OnEventLoaded()
    {
        EventRunStatus = ONLY_LOADED;
    }

    // toggle event handler callback register function
    void RegisterCB(CallbackEventTypes ct, EventCallbackFunctionPointer cb)
    {
        //make sure we remove old callbacks
        if (RegisteredCallbackType != MAX_CALLBACKEVENT_TYPES && CallbackPointer != NULL)
            UnRegisterCallbackFunction(RegisteredCallbackType, CallbackPointer, this);

        //memo the new callbacks
        RegisteredCallbackType = ct;
        CallbackPointer = cb;

        //register the new callbacks
        if (RegisteredCallbackType != MAX_CALLBACKEVENT_TYPES && CallbackPointer != NULL)
            RegisterCallbackFunction(RegisteredCallbackType, CallbackPointer, this);
    }

    //when event starts ( again ). Register callbacks, summon monsters ...
    void OnEventStarted()
    {
        //register callback scripts. We can only register a function + context once. Even if we run these more than once, they will register once
        if (EventType == SE_MULTIPLIED_HEALING_EVERYWHERE)
            RegisterCB(CALLBACK_TYPE_HEAL_DONE, ServerEventHealingReceivedAnywhere);
        else if (EventType == SE_MULTIPLIED_HEALING_INSTANCES)
            RegisterCB(CALLBACK_TYPE_HEAL_DONE, ServerEventHealingReceivedInstances);
        else if (EventType == SE_MULTIPLIED_HEALING_SPECIFIC_INSTANCE)
            RegisterCB(CALLBACK_TYPE_HEAL_DONE, ServerEventHealingReceivedSpecificMap);

        else if (EventType == SE_MULTIPLIED_DMG_EVERYWHERE)
            RegisterCB(CALLBACK_TYPE_DMG_DONE, ServerEventDmgDoneAnywhere);
        else if (EventType == SE_MULTIPLIED_DMG_INSTANCES)
            RegisterCB(CALLBACK_TYPE_DMG_DONE, ServerEventDmgDoneInstances);
        else if (EventType == SE_MULTIPLIED_DAMAGE_SPECIFIC_INSTANCE)
            RegisterCB(CALLBACK_TYPE_DMG_DONE, ServerEventDmgDoneSpecificMap);

        else if (EventType == SE_MULTIPLIED_LOOT_EVERYWHERE)
            RegisterCB(CALLBACK_TYPE_LOOT_ITEM_ROOL, ServerEventCreatureLootAnywhere);
        else if (EventType == SE_MULTIPLIED_LOOT_INSTANCES)
            RegisterCB(CALLBACK_TYPE_LOOT_ITEM_ROOL, ServerEventCreatureLootInstances);
        else if (EventType == SE_MULTIPLIED_LOOT_SPECIFIC_INSTANCE)
            RegisterCB(CALLBACK_TYPE_LOOT_ITEM_ROOL, ServerEventCreatureLootSpecificMap);

        else if (EventType == SE_LOOTED_ITEMS_COUNT_ANYWHERE)
            RegisterCB(CALLBACK_TYPE_LOOT_ITEM_GROUP_ROLL, ServerEventCreatureLootGroupAnywhere);
        else if (EventType == SE_LOOTED_ITEMS_COUNT_INSTANCES)
            RegisterCB(CALLBACK_TYPE_LOOT_ITEM_GROUP_ROLL, ServerEventCreatureLootGroupInstances);
        else if (EventType == SE_LOOTED_ITEMS_COUNT_SPECIFIC_MAP)
            RegisterCB(CALLBACK_TYPE_LOOT_ITEM_GROUP_ROLL, ServerEventCreatureLootGroupSpecificMap);

        else if (EventType == SE_MULTIPLIED_GOLD_EVERYWHERE)
            RegisterCB(CALLBACK_TYPE_LOOT_GOLD_GENERATED, ServerEventCreatureGoldLootAnywhere);
        else if (EventType == SE_MULTIPLIED_GOLD_INSTANCES)
            RegisterCB(CALLBACK_TYPE_LOOT_GOLD_GENERATED, ServerEventCreatureGoldLootInstances);
        else if (EventType == SE_MULTIPLIED_GOLD_SPECIFIC_INSTANCE)
            RegisterCB(CALLBACK_TYPE_LOOT_GOLD_GENERATED, ServerEventCreatureGoldLootSpecificMap);

        else if (EventType == SE_REDUCED_CREATURE_HEALTH_EVERYWHERE)
            RegisterCB(CALLBACK_TYPE_CREATURE_SPAWN, ServerEventCreatureSpawnHealthAnywhere);
        else if (EventType == SE_REDUCED_CREATURE_HEALTH_ANY_INSTANCE)
            RegisterCB(CALLBACK_TYPE_CREATURE_SPAWN, ServerEventCreatureSpawnHealthInstances);
        else if (EventType == SE_REDUCED_CREATURE_HEALTH_SPECIFIC_INSTANCE)
            RegisterCB(CALLBACK_TYPE_CREATURE_SPAWN, ServerEventCreatureSpawnHealthSpecificMap);

        else if (EventType == SE_REDUCED_CREATURE_DMG_EVERYWHERE)
            RegisterCB(CALLBACK_TYPE_DMG_DONE, ServerEventCreatureDmgAnywhere);
        else if (EventType == SE_REDUCED_CREATURE_DMG_ANY_INSTANCE)
            RegisterCB(CALLBACK_TYPE_DMG_DONE, ServerEventCreatureDmgInstances);
        else if (EventType == SE_REDUCED_CREATURE_DMG_SPECIFIC_INSTANCE)
            RegisterCB(CALLBACK_TYPE_DMG_DONE, ServerEventCreatureDmgSpecificMap);

        else if(EventType== SE_LOOT_ONLY_ITEM_QUALITY_ANYWHERE)
            RegisterCB(CALLBACK_TYPE_LOOT_ITEM_ROOL, ServerEventCreatureLootQualityAnywhere);
        else if (EventType == SE_LOOT_ONLY_ITEM_QUALITY_INSTANCES)
            RegisterCB(CALLBACK_TYPE_LOOT_ITEM_ROOL, ServerEventCreatureLootQualityInstances);
        else if (EventType == SE_LOOT_ONLY_ITEM_QUALITY_SPECIFIC_MAP)
            RegisterCB(CALLBACK_TYPE_LOOT_ITEM_ROOL, ServerEventCreatureLootQualitySpecificMap);

        //mark it as ongoing event
        EventRunStatus = RUNNING;

        // one time initialization
        if (EventType == SE_SPAWN_CREATURE)
        {
            Map *m = sMapMgr->FindMap(MapId,0);
            if (m == NULL)
                return;
            Position pos(SpawnX, SpawnY, SpawnZ, SpawnO);
            //spawn monster
            Creature* creature = new Creature();
            if (!creature->Create(m->GenerateLowGuid<HighGuid::Unit>(), m, PHASEMASK_NORMAL, SpawnEntry, pos, NULL, 0, true))
            {
                delete creature;
                return;
            }
            //try tp push it to the map
            if (!m->AddToMap(creature))
            {
                delete creature;
                return;
            }
            creature->SetHomePosition(creature->GetPosition());

            SpawnedCreatureGUID = creature->GetGUID();
        }
    }

    // when event duration expires, we ill run deinitializer
    void OnEventStopped()
    {
        //mark event stopped. Event handlers will no longer trigger even if we do not unregister them
        EventRunStatus = STOPPED;

        //make sure we remove event handlers
        RegisterCB(MAX_CALLBACKEVENT_TYPES,NULL);

        //despawn event creature
        if (EventType == SE_SPAWN_CREATURE)
        {
            Map *m = sMapMgr->FindMap(MapId, 0);
            if (m == NULL)
                return;
            Creature *c = m->GetCreature(SpawnedCreatureGUID);
            if (c)
                c->AddObjectToRemoveList();
        }
    }

    // we started this event. Unless we shut it down, it will be running
    bool IsEventRunning()
    {
        if (EventRunStatus != RUNNING)
            return false;
        return true;
    }

    //current time is larger than start stamp
    bool IsEventStarted()
    {
        time_t TimeNow = GameTime::GetGameTime();
        return (StartStamp <= TimeNow);
    }

    // current time is greater than the end stamp of this event
    bool IsEventEnded()
    {
        time_t TimeNow = GameTime::GetGameTime();
        return (TimeNow >= EndStamp);
    }

    // If event started and not yet ended
    bool EventShouldBeActive()
    {
        return ((IsEventStarted() == true) && (IsEventEnded() == false));
    }

    // every day, timestamp needs to be updated in order for the event to get started again
    void UpdateStartEndStamps()
    {
        StartStamp = ConvertTimeOfTheWeekToTime(DayOfTheWeek, StartHour, StartMinute);
        EndStamp = ConvertTimeOfTheWeekToTime(DayOfTheWeek, EndHour, EndMinute);
    }

    char    NameDescription[2000];          // something that we will announce to player when the event starts
    uint32  StartHour, StartMinute;         // time of the day
    uint32  EndHour, EndMinute;             // time of the day
    int32   DayOfTheWeek;                   // day of the week [1..7]
    uint32  EventType;                      // type of the event
    uint32  MapId;                          // lock event to this map
    float   SpawnX, SpawnY, SpawnZ, SpawnO; // where to spawn the NPC
    uint32  SpawnEntry;                     // What type of NPC to spawn
    float   HealingDmgHonorMultiplier;      // if we change some rate, By how much do we change it
    int32   AddedValue;                     // flat value used for event
    time_t  StartStamp;                     // when this event will go live
    time_t  EndStamp;                       // when we will start searching for a new event

// internal values
    enum EventRunStatusE
    {
        NOT_INITIALIZED_AT_ALL,
        ONLY_LOADED,
        RUNNING,
        STOPPED,
    };

    EventRunStatusE                 EventRunStatus;
    ObjectGuid                      SpawnedCreatureGUID;
    CallbackEventTypes              RegisteredCallbackType; // need these to be able to unload the event
    EventCallbackFunctionPointer    CallbackPointer;        // need these to be able to unload the event
};

//////////////////////////////////////////
// Store all events found in config file
class GlobalPeriodicEventStore
{
public:

    //constructor says there are no ongoing events until we update for the first time
    GlobalPeriodicEventStore()
    {
//        mutex = CreateMutex(NULL, FALSE, NULL);
    }

    // read the "config" text file to search for the next event to start
    // this function gets executed once on startup or when a GM command is used
    void ReParseEventListFile()
    {
 //       WaitForSingleObject(mutex, INFINITE); // make sure no other thread is using the lists

        //get rid of the old lists
        std::list<EventStore*> ToDelete;
        for (auto i2 = OngoingEvents.begin(); i2 != OngoingEvents.end(); i2++)
            ToDelete.push_back(*i2);
        OngoingEvents.clear();

        Sleep(1000); //guessing no other thread still uses event objects from lists

        for (auto i2 = ToDelete.begin(); i2 != ToDelete.end(); i2++)
                delete *i2;

        //open file
        FILE *f = fopen("ServerEvents.txt", "rt");
        if (f)
        {
            EventStore CurEvent;
            //read until we find an event that starts after current event
            do {
                char line[2000];
                char *ret = fgets(line, _countof(line), f);

                //skip comment lines
                if (line[0] == '#' || line[0] == '\n')
                    continue;

                //if we done defining this block of event
                if (strstr(line, "EndBlock") != NULL)
                {
                    //do other initializations also
                    CurEvent.OnEventLoaded();
CurEvent.PrintStatus();     //debug print if all went well
                    //do we have enough values for this event to function ? Add it to our list of events we will host
                    if (CurEvent.EventHasValuesToFunction() == true)
                    {
                        EventStore *t = new EventStore;
                        *t = CurEvent;
                        OngoingEvents.push_back(t);
                    }

                    CurEvent.ResetVlaues();
                    continue;
                }

                //title means we start a new event structure
                if (strstr(line, "NameAndDescription=") != NULL)
                {
                    CurEvent.ResetVlaues();
                    strcpy_s(CurEvent.NameDescription, line + strlen("NameAndDescription="));
                }
                else if (strstr(line, "StartHour=") != NULL)
                {
                    char *tline = line + strlen("StartHour=");
                    CurEvent.StartHour = atoi(tline);
                    CurEvent.StartMinute = atoi(strstr(line,":")+1);
                }
                else if (strstr(line, "EndHour=") != NULL)
                {
                    char *tline = line + strlen("EndHour=");
                    CurEvent.EndHour = atoi(tline);
                    CurEvent.EndMinute = atoi(strstr(line, ":") + 1);
                }
                else if (strstr(line, "DayOfTheWeek=") != NULL)
                {
                    char *tline = line + strlen("DayOfTheWeek=");
                    CurEvent.DayOfTheWeek = atoi(tline);
                }
                else if (strstr(line, "EventType=") != NULL)
                {
                    char *tline = line + strlen("EventType=");
                    CurEvent.EventType = atoi(tline);
                }
                else if (strstr(line, "SpawnLocationX=") != NULL)
                {
                    char *tline = line + strlen("SpawnLocationX=");
                    CurEvent.SpawnX = (float)atof(tline);
                }
                else if (strstr(line, "SpawnLocationY=") != NULL)
                {
                    char *tline = line + strlen("SpawnLocationY=");
                    CurEvent.SpawnY = (float)atof(tline);
                }
                else if (strstr(line, "SpawnLocationZ=") != NULL)
                {
                    char *tline = line + strlen("SpawnLocationZ=");
                    CurEvent.SpawnZ = (float)atof(tline);
                }
                else if (strstr(line, "SpawnLocationO=") != NULL)
                {
                    char *tline = line + strlen("SpawnLocationO=");
                    CurEvent.SpawnO = (float)atof(tline);
                }
                else if (strstr(line, "SpawnEntry=") != NULL)
                {
                    char *tline = line + strlen("SpawnEntry=");
                    CurEvent.SpawnEntry = atoi(tline);
                }
                else if (strstr(line, "ValueMultiplier=") != NULL)
                {
                    char *tline = line + strlen("ValueMultiplier=");
                    CurEvent.HealingDmgHonorMultiplier = (float)atof(tline);
                }
                else if (strstr(line, "ValueAdded=") != NULL)
                {
                    char *tline = line + strlen("ValueAdded=");
                    CurEvent.AddedValue = atoi(tline);
                }
                else if (strstr(line, "MapId=") != NULL)
                {
                    char *tline = line + strlen("MapId=");
                    CurEvent.MapId = atoi(tline);
                }
            } while (feof(f)==0);
            fclose(f);
        }

 //       ReleaseMutex(mutex);
    }

    //from time to time we will update the state of this structure. Check if event expired. Clean up. Load a new event definition....
    void PeriodicUpdateEventStoreStatus()
    {
//        WaitForSingleObject(mutex, INFINITE); // protect ourselfs from GMs reloading this list

        // if we had an active event. Deinitialize it
        for (auto i2 = OngoingEvents.begin(); i2 != OngoingEvents.end(); i2++)
        {
            //if a day passed, make sure we update timestamps to be valid
            (*i2)->UpdateStartEndStamps();

            //if event was running and ended, stop it
            if ((*i2)->IsEventRunning() == true && (*i2)->EventShouldBeActive() == false)
            {
                (*i2)->OnEventStopped();
            }

            //if event is not running, but should run, start it
            if ((*i2)->IsEventRunning() == false && (*i2)->EventShouldBeActive() == true)
            {
                //announce to online players that we are running a new event
                for (auto itr = sWorld->GetAllSessions().begin(); itr != sWorld->GetAllSessions().end(); itr++)
                {
                    if (!itr->second)
                        continue;

                    Player *plr = itr->second->GetPlayer();
                    if (!plr || itr->second->isLogingOut())
                        continue;

                    plr->BroadcastMessage("ServerEvents: %s has started. Is active for %d minutes", (*i2)->NameDescription, (*i2)->GetRemainingMinutes());
                }
                //mark event as initialized so we stop spamming players
                (*i2)->OnEventStarted();
            }
        }

//        ReleaseMutex(mutex);
    }

    //when player logs in, notify him about ongoing events
    void OnplayerLogin(Player *player)
    {
 //       WaitForSingleObject(mutex, INFINITE);

        for (auto i2 = OngoingEvents.begin(); i2 != OngoingEvents.end(); i2++)
            if ((*i2)->IsEventRunning())
                player->BroadcastMessage("ServerEvents : %s is active for %d more minutes", (*i2)->NameDescription, (*i2)->GetRemainingMinutes());

 //       ReleaseMutex(mutex);
    }
    void ShowUpcommingEvents(Player *player)
    {
        for (auto i2 = OngoingEvents.begin(); i2 != OngoingEvents.end(); i2++)
            if ((*i2)->IsEventRunning() == false && (*i2)->IsEventStarted() == false && (*i2)->IsEventEnded() == false)
            {
                time_t TimeNow = GameTime::GetGameTime();
                uint32 TimeUntilStarts = ((*i2)->StartStamp - TimeNow) / 60;
                player->BroadcastMessage("ServerEvents : %s will start in %d minutes", (*i2)->NameDescription, TimeUntilStarts);
            }
    }
private:
    std::list<EventStore*>  OngoingEvents;
//    HANDLE                  mutex;
};

//one time server based event store
GlobalPeriodicEventStore GlobalEvent;

#define DO_DEFAULT_HEAL_CHECKS CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED,p); \
    if (params->OriDamage <= 0 || params->Attacker == NULL) \
        return; \
    EventStore *Event = (EventStore *)Context; \
    if(params->Attacker->ToPlayer() == NULL) \
        return;

void ServerEventHealingReceivedAnywhere(void *p, void *Context)
{
    DO_DEFAULT_HEAL_CHECKS
    params->FlatMods += Event->AddedValue + (int32)((params->OriDamage * Event->HealingDmgHonorMultiplier));
}

void ServerEventHealingReceivedSpecificMap(void *p, void *Context)
{
    DO_DEFAULT_HEAL_CHECKS
    if (params->Attacker == NULL || params->Attacker->FindMap() == NULL || params->Attacker->GetMap()->GetId() != Event->MapId)//based on our event type, we treat
        return;
    params->FlatMods += Event->AddedValue + (int32)((params->OriDamage * Event->HealingDmgHonorMultiplier));
}

void ServerEventHealingReceivedInstances(void *p, void *Context)
{
    DO_DEFAULT_HEAL_CHECKS
    if (params->Attacker == NULL || params->Attacker->FindMap() == NULL || params->Attacker->GetMap()->IsDungeon() == false) //only valid in instances
        return;
    params->FlatMods += Event->AddedValue + (int32)((params->OriDamage * Event->HealingDmgHonorMultiplier));
}

#define DO_DEFAULT_DMG_CHECKS CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED,p); \
    if (params->OriDamage <= 0 || params->Attacker == NULL || params->Victim == NULL) \
        return; \
    EventStore *Event = (EventStore *)Context; \
    if(params->Attacker->ToPlayer() == NULL) \
        return; \
    if (params->Victim->ToPlayer() != NULL) \
        return;

void ServerEventDmgDoneAnywhere(void *p, void *Context)
{
    DO_DEFAULT_DMG_CHECKS
    params->FlatMods += Event->AddedValue + (int32)((params->OriDamage * Event->HealingDmgHonorMultiplier));
}

void ServerEventDmgDoneSpecificMap(void *p, void *Context)
{
    DO_DEFAULT_DMG_CHECKS
    if (params->Attacker == NULL || params->Attacker->FindMap() == NULL || params->Attacker->GetMap()->GetId() != Event->MapId)//based on our event type, we treat
        return;
    params->FlatMods += Event->AddedValue + (int32)((params->OriDamage * Event->HealingDmgHonorMultiplier));
}

void ServerEventDmgDoneInstances(void *p, void *Context)
{
    DO_DEFAULT_DMG_CHECKS
    if (params->Attacker == NULL || params->Attacker->FindMap() == NULL || params->Attacker->GetMap()->IsDungeon() == false) //only valid in instances
        return;
    params->FlatMods += Event->AddedValue + (int32)((params->OriDamage * Event->HealingDmgHonorMultiplier));
}

//#define CHECK_EVENT_IS_RUNNING if (((EventStore *)Context)->IsEventRunning() == false) return;    // this is no longer required since events are only registered while they are running
#define CHECK_EVENT_IS_RUNNING 

void ServerEventCreatureLootAnywhere(void *p, void *Context)
{
    CP_LOOT_ROLL_CHANCE *params = PointerCast(CP_LOOT_ROLL_CHANCE, p);
    CHECK_EVENT_IS_RUNNING
    EventStore *Event = (EventStore *)Context;
    *params->chance += Event->AddedValue + (int32)((*params->chance * Event->HealingDmgHonorMultiplier));
}

void ServerEventCreatureLootInstances(void *p, void *Context)
{
    CP_LOOT_ROLL_CHANCE *params = PointerCast(CP_LOOT_ROLL_CHANCE, p);
    CHECK_EVENT_IS_RUNNING
    EventStore *Event = (EventStore *)Context;
    if (params->LooterPlayer == NULL || params->LooterPlayer->FindMap() == NULL || params->LooterPlayer->GetMap()->IsDungeon() == false) //only valid in instances
        return;
    *params->chance += Event->AddedValue + (int32)((*params->chance * Event->HealingDmgHonorMultiplier));
}

void ServerEventCreatureLootSpecificMap(void *p, void *Context)
{
    CP_LOOT_ROLL_CHANCE *params = PointerCast(CP_LOOT_ROLL_CHANCE, p);
    CHECK_EVENT_IS_RUNNING
    EventStore *Event = (EventStore *)Context;
    if (params->LooterPlayer == NULL || params->LooterPlayer->FindMap() == NULL || params->LooterPlayer->GetMap()->GetId() != Event->MapId)//based on our event type, we treat
        return;
    *params->chance += Event->AddedValue + (int32)((*params->chance * Event->HealingDmgHonorMultiplier));
}

void ServerEventCreatureLootGroupAnywhere(void *p, void *Context)
{
    CP_INT32_PARAM *params = PointerCast(CP_INT32_PARAM, p);
    CHECK_EVENT_IS_RUNNING
    EventStore *Event = (EventStore *)Context;
    *params->Value += Event->AddedValue;
}

void ServerEventCreatureLootGroupInstances(void *p, void *Context)
{
    CP_INT32_PARAM *params = PointerCast(CP_INT32_PARAM, p);
    CHECK_EVENT_IS_RUNNING
    EventStore *Event = (EventStore *)Context;
    if (params->Player == NULL || params->Player->FindMap() == NULL || params->Player->GetMap()->IsDungeon() == false) //only valid in instances
        return;
    *params->Value += Event->AddedValue;
}

void ServerEventCreatureLootGroupSpecificMap(void *p, void *Context)
{
    CP_INT32_PARAM *params = PointerCast(CP_INT32_PARAM, p);
    CHECK_EVENT_IS_RUNNING
    EventStore *Event = (EventStore *)Context;
    if (params->Player == NULL || params->Player->FindMap() == NULL || params->Player->GetMap()->GetId() != Event->MapId)//based on our event type, we treat
        return;
    *params->Value += Event->AddedValue;
}

void ServerEventCreatureGoldLootAnywhere(void *p, void *Context)
{
    CP_INT32_PARAM *params = PointerCast(CP_INT32_PARAM, p);
    CHECK_EVENT_IS_RUNNING
    EventStore *Event = (EventStore *)Context;
    *params->Value += Event->AddedValue + (int32)((*params->Value * Event->HealingDmgHonorMultiplier));
}

void ServerEventCreatureGoldLootInstances(void *p, void *Context)
{
    CP_INT32_PARAM *params = PointerCast(CP_INT32_PARAM, p);
    CHECK_EVENT_IS_RUNNING
    EventStore *Event = (EventStore *)Context;
    if (params->Player == NULL || params->Player->FindMap() == NULL || params->Player->GetMap()->IsDungeon() == false) //only valid in instances
        return;
    *params->Value += Event->AddedValue + (int32)((*params->Value * Event->HealingDmgHonorMultiplier));
}

void ServerEventCreatureGoldLootSpecificMap(void *p, void *Context)
{
    CP_INT32_PARAM *params = PointerCast(CP_INT32_PARAM, p);
    CHECK_EVENT_IS_RUNNING
    EventStore *Event = (EventStore *)Context;
    if (params->Player == NULL || params->Player->FindMap() == NULL || params->Player->GetMap()->GetId() != Event->MapId)//based on our event type, we treat
        return;
    *params->Value += Event->AddedValue + (int32)((*params->Value * Event->HealingDmgHonorMultiplier));
}

void ServerEventCreatureSpawnHealthAnywhere(void *p, void *Context)
{
    CP_CREATURE_SPAWN *params = PointerCast(CP_CREATURE_SPAWN, p);
    if (params->Spawn->GetCreatureData() == NULL)
        return;
    EventStore *Event = (EventStore *)Context;
    CHECK_EVENT_IS_RUNNING

//    int64 MaxHealth = params->Spawn->GetCreatureData()->curhealth;
    int64 MaxHealth = params->Spawn->GetCreateHealth();
    MaxHealth += Event->AddedValue + (int32)((MaxHealth * Event->HealingDmgHonorMultiplier));
    if (MaxHealth > 0x0FFFFFFF)
        MaxHealth = 0x0FFFFFFF;

    params->Spawn->SetCreateHealth((uint32)MaxHealth);
    params->Spawn->SetMaxHealth((uint32)MaxHealth);
    params->Spawn->SetHealth((uint32)MaxHealth);
}

void ServerEventCreatureSpawnHealthInstances(void *p, void *Context)
{
    CP_CREATURE_SPAWN *params = PointerCast(CP_CREATURE_SPAWN, p);
    EventStore *Event = (EventStore *)Context;
    if (params->map == NULL || params->map->IsDungeon() == false) //only valid in instances
        return;
    ServerEventCreatureSpawnHealthAnywhere(p, Context);
}

void ServerEventCreatureSpawnHealthSpecificMap(void *p, void *Context)
{
    CP_CREATURE_SPAWN *params = PointerCast(CP_CREATURE_SPAWN, p);
    EventStore *Event = (EventStore *)Context;
    if (params->map == NULL || params->map->GetId() != Event->MapId)//based on our event type, we treat
        return;
    ServerEventCreatureSpawnHealthAnywhere(p, Context);
}

#define DO_DEFAULT_DMG_CHECKS_CREATURE CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED,p); \
    if (params->OriDamage <= 0 || params->Attacker == NULL) \
        return; \
    EventStore *Event = (EventStore *)Context; \
    if (Event->IsEventRunning() == false) \
        return; \
    if(params->Attacker->ToPlayer() != NULL) \
        return;

void ServerEventCreatureDmgAnywhere(void *p, void *Context)
{
    DO_DEFAULT_DMG_CHECKS_CREATURE
    params->FlatMods += Event->AddedValue + (int32)((params->OriDamage * Event->HealingDmgHonorMultiplier));
}

void ServerEventCreatureDmgInstances(void *p, void *Context)
{
    DO_DEFAULT_DMG_CHECKS_CREATURE
    if (params->Attacker == NULL || params->Attacker->FindMap() == NULL || params->Attacker->GetMap()->IsDungeon() == false) //only valid in instances
        return;
    params->FlatMods += Event->AddedValue + (int32)((params->OriDamage * Event->HealingDmgHonorMultiplier));
}

void ServerEventCreatureDmgSpecificMap(void *p, void *Context)
{
    DO_DEFAULT_DMG_CHECKS_CREATURE
    if (params->Attacker == NULL || params->Attacker->FindMap() == NULL || params->Attacker->GetMap()->GetId() != Event->MapId)//based on our event type, we treat
        return;
    params->FlatMods += Event->AddedValue + (int32)((params->OriDamage * Event->HealingDmgHonorMultiplier));
}

void ServerEventCreatureLootQualityAnywhere(void *p, void *Context)
{
    CP_LOOT_ROLL_CHANCE *params = PointerCast(CP_LOOT_ROLL_CHANCE, p);
    EventStore *Event = (EventStore *)Context;
    CHECK_EVENT_IS_RUNNING
    if (params->Item == NULL)
        return;
    if (params->Item->Quality != Event->AddedValue)
        *params->chance = 0;
}

void ServerEventCreatureLootQualityInstances(void *p, void *Context)
{
    CP_LOOT_ROLL_CHANCE *params = PointerCast(CP_LOOT_ROLL_CHANCE, p);
    EventStore *Event = (EventStore *)Context;
    CHECK_EVENT_IS_RUNNING
    if (params->LooterPlayer == NULL || params->LooterPlayer->FindMap() == NULL || params->LooterPlayer->GetMap()->IsDungeon() == false) //only valid in instances
        return;
    if (params->Item == NULL)
        return;
    if (params->Item->Quality != Event->AddedValue)
        *params->chance = 0;
}

void ServerEventCreatureLootQualitySpecificMap(void *p, void *Context)
{
    CP_LOOT_ROLL_CHANCE *params = PointerCast(CP_LOOT_ROLL_CHANCE, p);
    EventStore *Event = (EventStore *)Context;
    CHECK_EVENT_IS_RUNNING
    if (params->LooterPlayer == NULL || params->LooterPlayer->FindMap() == NULL || params->LooterPlayer->GetMap()->GetId() != Event->MapId)//based on our event type, we treat
        return;
    if (params->Item == NULL)
        return;
    if (params->Item->Quality != Event->AddedValue)
        *params->chance = 0;
}

//////////////////////////////////////////
// Periodically reload the events text file. Maybe this could be done with a GM command also ?
HANDLE          PeriodicEventMonitorThread = 0;
static int      StatingPeriodicEventMonitorThread = 0;
static DWORD    PeriodicEventMonitorThreadIsRunning = 0;     //can shut it down with external command
DWORD __stdcall PeriodicEventMonitorThreadFunc(LPVOID lpParam)
{
    int *ThreadIsRunning = (int*)lpParam;
    *ThreadIsRunning = 1;
#ifdef _DEBUG
    const int OneLoopSleepAmt = 1000;
#else
    const int OneLoopSleepAmt = 1 * 60 * 1000;
#endif
    while (*ThreadIsRunning == 1)
    {
        //fetch a new event. Put it live
        GlobalEvent.PeriodicUpdateEventStoreStatus();

        //wait a bit. No need to spam DB with polling
        Sleep(OneLoopSleepAmt);
    }

    // signal back that we finished running this thread
    *ThreadIsRunning = 0;

    printf("Exited Periodic Event Monitor thread. How is this even possible?\n");

    //all went as expected
    return 0;
}

// function that should only run once 
void LaunchPeriodicReloadConfigFileThread()
{
    if (StatingPeriodicEventMonitorThread == 0)
    {
        StatingPeriodicEventMonitorThread = 1;

        //load config file at least once. We can use GM command to reload the config file
        GlobalEvent.ReParseEventListFile();

        //register thread that will periodically transfer messages found in DB to ingame chat
        DWORD   ThreadId;
        PeriodicEventMonitorThread = CreateThread(
            NULL,						// default security attributes
            0,							// use default stack size  
            PeriodicEventMonitorThreadFunc,		// thread function name
            &PeriodicEventMonitorThreadIsRunning,	// argument to thread function 
            0,							// use default creation flags 
            &ThreadId);					// returns the thread identifier 

                                        //this is bad
        if (PeriodicEventMonitorThread == 0)
        {
            printf("Could not start message fetch thread");
            PeriodicEventMonitorThreadIsRunning = 0;
        }
    }
}

//////////////////////////////////////////
// Players that log in while an event is running will be notified of ongoing events
class TC_GAME_API AnnouncePlayerOngoingEvent : public PlayerScript
{
public:
    AnnouncePlayerOngoingEvent() : PlayerScript("AnnouncePlayerOngoingEvent") {}
    void OnLogin(Player* player, bool firstLogin)
    {
        LaunchPeriodicReloadConfigFileThread();     // will get executed only once

        GlobalEvent.OnplayerLogin(player);
    }
};

void PEParseClientUserCommand(Player* player, uint32 type, const char *cmsg)
{
    //        printf("got command %s\n", cmsg);
    if (CheckValidClientCommand(cmsg, type, NULL) == false)
    {
        return;
    }

    //do we want to set the difficulty ?
    if (strstr(cmsg, "#csShowServerEvents") == cmsg)
    {
        GlobalEvent.OnplayerLogin(player);
    }

    //do we want to set the difficulty ?
    if (strstr(cmsg, "#csShowUpcomingServerEvents") == cmsg || strstr(cmsg, "#csShowUpcommingServerEvents") == cmsg) //lol, typoed the name
    {
        GlobalEvent.ShowUpcommingEvents(player);
    }

    //do we want to set the difficulty ?
    if (strstr(cmsg, "#csReloadServerEvents") == cmsg)
    {
        if (!player->GetSession()->HasPermission(rbac::RBAC_PERM_COMMAND_RELOAD_ALL_LOOT))
        {
            player->BroadcastMessage("No permission to use command");
            return;
        }
        GlobalEvent.ReParseEventListFile();
    }
}

void RBAC_ReloadEventsCommand()
{
    GlobalEvent.ReParseEventListFile();
}

void RBAC_ShowEvents(Player* player, uint32 type) {
    if (type == 0)
        GlobalEvent.OnplayerLogin(player);
    else
        GlobalEvent.ShowUpcommingEvents(player);
}

void PEOnChatMessageReceived(void *p, void *)
{
    CP_CHAT_RECEIVED *params = PointerCast(CP_CHAT_RECEIVED, p);

    //check for strings that might be our commands
    PEParseClientUserCommand(params->SenderPlayer, params->MsgType, params->Msg->c_str());
}

//function that is run when the server starts up. Not all service providers are functioning at this state. Soft init only
void AddPeriodicEventsScripts()
{
    RegisterCallbackFunction(CALLBACK_TYPE_CHAT_RECEIVED, PEOnChatMessageReceived, NULL);
    new AnnouncePlayerOngoingEvent();
}
