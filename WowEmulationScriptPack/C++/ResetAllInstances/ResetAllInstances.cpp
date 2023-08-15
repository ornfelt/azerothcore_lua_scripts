#include "Player.h"
#include "DBCEnums.h"
#include "DBCStructure.h"
#include "DBCStores.h"
#include "MapManager.h"
#include <set>
#include "GameEventCallbacks.h"

void ResetAllInstancesOnClientClick(void *p, void *)
{
    CP_ASK_DISABLED_FEATURE *params = PointerCast(CP_ASK_DISABLED_FEATURE,p);

    Difficulty diff;

    std::set<Difficulty> ResetAllDifficulties;
    ResetAllDifficulties.insert(REGULAR_DIFFICULTY);
    ResetAllDifficulties.insert(DUNGEON_DIFFICULTY_NORMAL);
    ResetAllDifficulties.insert(DUNGEON_DIFFICULTY_HEROIC);
    ResetAllDifficulties.insert(DUNGEON_DIFFICULTY_EPIC);
    ResetAllDifficulties.insert(RAID_DIFFICULTY_10MAN_NORMAL);
    ResetAllDifficulties.insert(RAID_DIFFICULTY_25MAN_NORMAL);
    ResetAllDifficulties.insert(RAID_DIFFICULTY_10MAN_HEROIC);
    ResetAllDifficulties.insert(RAID_DIFFICULTY_25MAN_HEROIC);
    std::set<Difficulty>::iterator i;
    for (i = ResetAllDifficulties.begin(); i != ResetAllDifficulties.end(); i++)
    {
        diff = *i;
        for (Player::BoundInstancesMap::iterator itr = params->Player->m_boundInstances[diff].begin(); itr != params->Player->m_boundInstances[diff].end();)
        {
            InstanceSave* p = itr->second.save;
            MapEntry const* entry = sMapStore.LookupEntry(itr->first);
            if (!entry )
            {
                ++itr;
                continue;
            }

            // if the map is loaded, reset it
            Map* map = sMapMgr->FindMap(p->GetMapId(), p->GetInstanceId());
            if (map && map->IsDungeon())
            {
                if (!map->ToInstanceMap()->Reset(INSTANCE_RESET_ALL))
                {
                    ++itr;
                    continue;
                }
            }

            // since this is a solo instance there should not be any players inside
            params->Player->SendResetInstanceSuccess(p->GetMapId());

            p->DeleteFromDB();
            params->Player->m_boundInstances[diff].erase(itr++);

            // the following should remove the instance save from the manager and delete it as well
            p->RemovePlayer(params->Player);
        }
    }
}

void AddResetAllInstancesScripts()
{
    RegisterCallbackFunction(CALLBACK_TYPE_RESET_ALL_INSTANCES, ResetAllInstancesOnClientClick, NULL);
}
