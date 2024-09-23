#include "World.h"
#include "Player.h"
#include "Map.h"
#include "ObjectExtension.cpp"
#include "WorldSession.h"
#include "ArenaFreeForAllPVPStore.h"
#include "GameTime.h"
#include "Unit.h"
#include "SpellAuras.h"
#include "DatabaseEnv.h"
#include "MapManager.h"

#define DEBUG_ARENAFFA_INSTANCE 1
#define SPELL_ID_PROTECT_PLAYER 41367

static uint32 ArenaFFAPVPGUID = 10000;
ArenaFreeForAllPVPStore::ArenaFreeForAllPVPStore()
{
    Status = HG_WAITING_FOR_QUEUE;
#ifdef _DEBUG
    MinPlayersToQueue = 2;
#else
    MinPlayersToQueue = 10;
#endif // DEBUG
    MaxPlayersToQueue = 40;
    GUID = ArenaFFAPVPGUID++;
    WaitUntilNextQueueStarts = 2 * 60;
    ForceEndMatchAfterXSeconds = 15 * 60;
    OnWinCreditReward = 10;
    SelectedMap = 0;
    KickToMap = 530;
    KickToX = -1909;
    KickToY = 5520;
    KickToZ = -12.428010f;
    MapActive = NULL;
}

void ArenaFreeForAllPVPStore::SetKickToPosition(uint32 pKickToMap, float pKickToX, float pKickToY, float pKickToZ)
{
    KickToMap = pKickToMap;
    KickToX = pKickToX;
    KickToY = pKickToY;
    KickToZ = pKickToZ;
}

bool ArenaFreeForAllPVPStore::IsPlayerInsideEventArea(Player *p)
{
    if (p->IsBeingTeleported() == true || p->IsInWorld() == false || p->IsLoading() == true || p->GetMap() != MapActive)
        return false;
    return true;
}

void ArenaFreeForAllPVPStore::SelectDestinationMap()
{
    //iterate through all possible maps and select one where the fight will go on
    size_t Count = MapSpawnPoints.size();
    if (Count == 0)
        assert(0);
    SelectedMap = rand32() % Count;
}

void AreanaFFARemoveNegativeAuras(Player *p)
{
    for (Unit::AuraApplicationMap::iterator iter = p->GetAppliedAuras().begin(); iter != p->GetAppliedAuras().end();)
    {
        if (iter->second->IsPositive() == false)
            p->RemoveAura(iter);
        else
            ++iter;
    }
}

void ArenaFFAProtectPlayerUntilMatchStart(Player *p)
{
    //allow divine shield to be casted
    AreanaFFARemoveNegativeAuras(p);
    CastSpellExtraArgs ef;
    ef.TriggerFlags = TriggerCastFlags(TRIGGERED_FULL_MASK | TRIGGERED_IGNORE_MOVE_CHECK | TRIGGERED_IGNORE_CAST_TIME);
    p->CastSpell(p, SPELL_ID_PROTECT_PLAYER, ef);
    //allow user divine shield to be casted
    AreanaFFARemoveNegativeAuras(p);
}

void ArenaFreeForAllPVPStore::PreFightWaitForQueueFill()
{
    if (Status == HG_WAITING_FOR_QUEUE)
    {
        if (PlayersQueued.size() < MinPlayersToQueue)
            return;

        //mark it as started
        Status = HG_WAITING_FOR_QUEUE_COUNTDOWN_START;
        StartedAt = GameTime::GetGameTime();

        WorldAnnounce("PVPMassacre has enough players in queue to start. Waiting for last second subscriptions");

        QueuedPlayersAtStart = (uint32)PlayersQueued.size();
    }
}

void ArenaFreeForAllPVPStore::PreFightWaitForQueueFillCountDown()
{
    if (Status == HG_WAITING_FOR_QUEUE_COUNTDOWN_START)
    {
        //timed wait
        if (StartedAt + WaitAdditionalSubscriptionToMinimum > GameTime::GetGameTime() && PlayersQueued.size() < MaxPlayersToQueue)
            return;

        //to many players quit the queue while waiting for additional players, back to filling up to minimum
        if (PlayersQueued.size() < MinPlayersToQueue)
        {
            Status = HG_WAITING_FOR_QUEUE;
            return;
        }

        //we can start now
        StartedAt = GameTime::GetGameTime();

        //Tell Players we will start teleporting them shortly
        for (auto itr = PlayersQueued.begin(); itr != PlayersQueued.end(); itr++)
        {
            Player *p = sWorld->GetOnlinePlayer(*itr);
            if (p)
                p->BroadcastMessage("You will be teleported to PVPMassacre arena shortly");
        }

        Status = HG_STARTING;
    }
}

Map *CreateMapToTeleportTo(uint32 MapId)
{
    bool IsNew = false;

    // do we have an active instance already ? Fetch that
    uint32 InstanceIdForMap = sMapMgr->GenerateInstanceId();

    // get our personal instance ID for this map type
    if (InstanceIdForMap == 0)
    {
        if (DEBUG_ARENAFFA_INSTANCE) printf("Error. Could not obtain instance ID to use for this map\n");
        return NULL;
    }
    // Get the base map that has a list of instances
    Map *m = sMapMgr->CreateBaseMap(MapId);
    if (!m)
    {
        if (DEBUG_ARENAFFA_INSTANCE) printf("Failed to create/obtain base map");
        return NULL;
    }

    //unique maps can not have instances
    if (m->Instanceable() == false)
    {
        return m;
    }

    // check if we already have our personal map instantiated
    Map *map = ((MapInstanced*)m)->FindInstanceMap(InstanceIdForMap);
    //if not, create a new one
    if (!map)
    {
        map = ((MapInstanced*)m)->CreateInstance(InstanceIdForMap, nullptr, Difficulty::REGULAR_DIFFICULTY);
        IsNew = true;
    }
    else
    {
        if (DEBUG_ARENAFFA_INSTANCE) printf("Found existing map. Will try to enter that\n");
    }

    // make sure this map does not load default spawns on it
    if (map && IsNew == true)
    {
        map->GetCreateIn64Extension(OE_MAP_IS_CUSTOM_INSTANCE, false, InstanceIdForMap);
        map->GetCreateIn64Extension(OE_MAP_IS_CUSTOM_INSTANCE_CREATOR, false, 1);
    }

    //make sure instance has a save that we can bind to players
    InstanceSave* mapSave = sInstanceSaveMgr->GetInstanceSave(InstanceIdForMap);
    if (!mapSave)
    {
        mapSave = sInstanceSaveMgr->AddInstanceSave(MapId, InstanceIdForMap, Difficulty::REGULAR_DIFFICULTY, 0, true);
    }

    return map;
}

void QueueTeleportSpecificMap(Player *player, Map *map);
void ArenaFreeForAllPVPStore::PreFightStartTeleporting()
{
    if (Status == HG_STARTING)
    {
        //timed wait for player to realize what is happening. He will be teleported shortly
        if (StartedAt + WarnPlayerTeleportIncommingSeconds > GameTime::GetGameTime())
            return;

        //start teleporting players
        StartedAt = GameTime::GetGameTime();
        Status = HG_TELEPORTING;
        SelectDestinationMap();
        WorldLocation *pos = MapSpawnPoints.at(SelectedMap);
        for (auto itr = PlayersQueued.begin(); itr != PlayersQueued.end(); itr++)
        {
            Player *p = sWorld->GetOnlinePlayer(*itr);
            if (p)
            {
                //refill all powers
                p->SetHealth(p->GetMaxHealth());
                p->SetPower(POWER_MANA, p->GetMaxPower(POWER_MANA));
                p->SetPower(POWER_RAGE, 0);
                p->SetPower(POWER_ENERGY, p->GetMaxPower(POWER_ENERGY));
                p->RemoveArenaSpellCooldowns(true);
                p->SetPvP(true);

                //put shield on the player until last one arrives
                ArenaFFAProtectPlayerUntilMatchStart(p);

                //create a map instance we will teleport players to
                if (MapActive == NULL)
                    MapActive = CreateMapToTeleportTo(pos->GetMapId());
                //next teleport will redirect to this specific map instance
                QueueTeleportSpecificMap(p, MapActive);

                //should be ready to be teleported
                p->TeleportTo(pos->GetMapId(), pos->GetPositionX(), pos->GetPositionY(), pos->GetPositionZ(), pos->GetOrientation());
            }
        }
    }
}

void ArenaFreeForAllPVPStore::PreFightTeleportWaitFinish()
{
    if (Status == HG_TELEPORTING)
    {
        // wait one second
        if (StartedAt + 1 > GameTime::GetGameTime())
            return;

        //check all players arrived earlier than timeout
        bool                    WaitForMorePlayers = false;
        std::set<ObjectGuid>    PlayersArrived = PlayersQueued;
        for (auto itr = PlayersArrived.begin(); itr != PlayersArrived.end(); itr++)
        {
            Player *p = sWorld->GetOnlinePlayer(*itr);
            //will remove this player later
            if (p == NULL)
                continue;

            if (IsPlayerInsideEventArea(p) == false)
            {
                WaitForMorePlayers = true;
                continue;
            }

            //put shield on the player until last one arrives
            ArenaFFAProtectPlayerUntilMatchStart(p);
        }

        // did all players arrive ?
        if (WaitForMorePlayers == true && StartedAt + WaitPlayerTeleportSeconds > GameTime::GetGameTime())
            return;

        //kick players that did not make it
        for (auto itr = PlayersArrived.begin(); itr != PlayersArrived.end(); itr++)
        {
            Player *p = sWorld->GetOnlinePlayer(*itr);

            //delete players that DCed
            if (p == NULL)
            {
                RemovePlayerFromQueue(*itr);
                continue;
            }

            //delete players that failed to teleport
            if (IsPlayerInsideEventArea(p) == false)
            {
                RemovePlayerFromQueue(p, false);
                continue;
            }

            //enable PVP with FFA
            p->SetPvP(true);
            p->SetByteFlag(UNIT_FIELD_BYTES_2, UNIT_BYTES_2_OFFSET_PVP_FLAG, UNIT_BYTE2_FLAG_FFA_PVP);

            //remove all buffs and debuffs
            //p->RemoveAllAuras();
        }

        //set ongoing status
        Status = HG_ONGOING;
        TeleportedPlayersAtStart = (uint32)PlayersQueued.size();
        DeserterPlayersCount = 0;
//        NeedsOneTimeInit = true;

        StartedAt = GameTime::GetGameTime(); // reset timer again
    }
}

void ArenaFreeForAllPVPStore::PreFightSetupAndUpdates()
{
    //have enough players to start map ?
    PreFightWaitForQueueFill();
    PreFightWaitForQueueFillCountDown();
    PreFightStartTeleporting();
    PreFightTeleportWaitFinish();
}

void ArenaFreeForAllPVPStore::MidFightUpdates(Map *map)
{
    if (map != MapActive)
        return;
    if (Status == HG_ONGOING)
    {
//        if (NeedsOneTimeInit == true)
//        {
//            NeedsOneTimeInit = false;
//        }

        //maybe some players deserted the scene
        std::set<ObjectGuid>    PlayersArrived = PlayersQueued;
        for (auto itr = PlayersArrived.begin(); itr != PlayersArrived.end(); itr++)
        {
            Player *p = map->GetPlayer(*itr);
            // player DCed. We consider this cheating
            if (p == NULL)
            {
                DeserterPlayersCount++;
                RemovePlayerFromQueue(*itr);
                continue;
            }

            //player fled. Deserter
            if (IsPlayerInsideEventArea(p) == false)
            {
                DeserterPlayersCount++;
                RemovePlayerFromQueue(p, false);
                continue;
            }

            //if player died, kick him
            if (p->IsAlive() == false)
            {
                RemovePlayerFromQueue(p, true);
                continue;
            }

            //remove from groups
            if (p->GetGroup())
                p->RemoveFromGroup();

            //set PVP and FFA. Avoid the bug that allows players to toggle it out
            p->SetPvP(true);
            p->SetByteFlag(UNIT_FIELD_BYTES_2, UNIT_BYTES_2_OFFSET_PVP_FLAG, UNIT_BYTE2_FLAG_FFA_PVP);
        }

        //do we have a winner ?
        if (PlayersQueued.size() == 1)
        {
            //            Player *p = sWorld->GetOnlinePlayer(*PlayersQueued.begin());
            Player *p = map->GetPlayer(*PlayersQueued.begin());
            if (p)
            {
                //kick him out to main map
                RemovePlayerFromQueue(p, true);
                //award him if there is something to be awarded
                if (DeserterPlayersCount == TeleportedPlayersAtStart - 1)
                    p->BroadcastMessage("Sadly all other players quit. No reward has been given");
                else
                {
                    p->AddCredits(OnWinCreditReward);
                    p->BroadcastMessage("Congratulations for winning the PVPMassacre, you have been rewarded %d Credits", OnWinCreditReward);
                    p->BroadcastMessage("Please wait 10 minutes for our system to update credits in to your web account");
                    char t[500];
                    sprintf_s(t, sizeof(t), "%s has been rewarded 25 Credits for winning the last PVPMassacre match", p->GetName().c_str());
                    WorldAnnounce(t);
                    //for highscores
                    char Query[5000];
                    sprintf_s(Query, sizeof(Query), "INSERT INTO character_ArenaFFA(GUID, WinCount) VALUES(%d,1) ON DUPLICATE KEY UPDATE WinCount = WinCount + 1",(uint32)p->GetGUID().GetRawValue());
                    CharacterDatabase.Execute(Query);
                }
            }
        }
    }
}

void ArenaFreeForAllPVPStore::PostFightDeinit()
{
    // this HG ended. Start a new one
    if (Status == HG_ONGOING)
    {
        //check if players are still on the map. we need to check on global list of players because maps without any players will not get updated.
        std::set<ObjectGuid>    PlayersArrived = PlayersQueued;
        for (auto itr = PlayersArrived.begin(); itr != PlayersArrived.end(); itr++)
        {
            Player *p = sWorld->GetOnlinePlayer(*itr);
            // player DCed. We consider this cheating
            if (p == NULL)
            {
                DeserterPlayersCount++;
                RemovePlayerFromQueue(*itr);
                continue;
            }

            //player fled. Deserter
            if (IsPlayerInsideEventArea(p) == false)
            {
                DeserterPlayersCount++;
                RemovePlayerFromQueue(p, false);
            }
        }

        if (PlayersQueued.size() <= 1 || StartedAt + ForceEndMatchAfterXSeconds < GameTime::GetGameTime())
        {
            //remove all players
            auto PlayersQueued2 = PlayersQueued;
            for (auto itr = PlayersQueued2.begin(); itr != PlayersQueued2.end(); itr++)
                RemovePlayerFromQueue(*itr, true);
            //mark map in finished state
            Status = HG_WAITING_FOR_QUEUE_COUNTDOWN_END;
            EndedAt = GameTime::GetGameTime();
            //invalidate the map pointer
            MapActive = NULL;
        }
    }

    if (Status == HG_WAITING_FOR_QUEUE_COUNTDOWN_END)
    {
        if (EndedAt + WaitUntilNextQueueStarts > GameTime::GetGameTime())
            return;
        Status = HG_WAITING_FOR_QUEUE;
    }
}

uint32 ArenaFreeForAllPVPStore::GetSelectedMapId()
{
    return MapSpawnPoints.at(SelectedMap)->GetMapId();
}

void ArenaFreeForAllPVPStore::UpdateEventStatus(Map *map)
{
    //this needs to run all the time even if the instanced map is not yet made
    // no need to spam it. Enough to update it only once every now
    if( map->GetId() == 0 )
        PreFightSetupAndUpdates();

    if (GetSelectedMapId() == map->GetId())
        MidFightUpdates(map);

    //needs to shut down the instance if players left the map
    PostFightDeinit();
}

void ArenaFreeForAllPVPStore::AddMapToSpawnOn(WorldLocation loc)
{
    WorldLocation *newloc = new WorldLocation(loc);
    MapSpawnPoints.push_back(newloc);
}

std::list<ArenaFreeForAllPVPStore*> ArenaFFAPVPs;

void UpdateFFAPVPEventStatus(void *p, void *context)
{
    CP_MAP_PERIODIC_UPDATE *params = PointerCast(CP_MAP_PERIODIC_UPDATE, p);
    if (params->map == NULL)
        return;

    //instanced maps have multiple times the same ID. Let the store itself detect if map is for self
    for (auto itr = ArenaFFAPVPs.begin(); itr != ArenaFFAPVPs.end(); itr++)
        (*itr)->UpdateEventStatus(params->map);
}
