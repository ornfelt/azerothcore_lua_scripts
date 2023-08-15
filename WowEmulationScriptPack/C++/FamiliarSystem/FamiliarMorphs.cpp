#include "Player.h"
#include "DatabaseEnv.h"
#include "ObjectExtension.cpp"
#include "DBCStores.h"
#include "ObjectMgr.h"

namespace CompanionSystem
{

    static std::map<uint32, const char *>    DisplayNames;
    char const *GetCreatureDisplayName(uint32 DisplayId)
    {
        std::map<uint32, const char *>::iterator i = DisplayNames.find(DisplayId);
        if (i == DisplayNames.end())
        {
            //iterate through all creatures and try to find who has this display ID
            for (auto const& ctPair : sObjectMgr->GetCreatureTemplates())
                if (ctPair.second.Modelid1 == DisplayId)
                {
                    DisplayNames[DisplayId] = ctPair.second.Name.c_str();
                    return ctPair.second.Name.c_str();
                }
        }
        else
            return i->second;
        return NULL;
        /*
        const CreatureModelDataEntry *cme = sCreatureModelDataStore.LookupEntry(Id);
        if (cme == NULL)
        continue;
        //search LastSlash
        uint32 LastSlashPos = 0;
        uint32 Index = 0;
        while (cme->ModelPath[Index] != 0)
        {
        if (cme->ModelPath[Index] == '\\')
        LastSlashPos = Index + 1;
        }
        uint32 DotPos = LastSlashPos;
        Index = LastSlashPos;
        while (cme->ModelPath[Index] != 0)
        {
        if (cme->ModelPath[Index] == '.')
        DotPos = Index;
        }
        char ModelName[500];
        strcpy_s(ModelName, sizeof(ModelName), &cme->ModelPath[LastSlashPos]);
        ModelName[DotPos - LastSlashPos] = 0;
        */
    }

    void LoadPlayerCompanionMorphs(Player *Plr)
    {
        std::set<uint32> *CreatureDisplayIdSet = Plr->GetExtension<std::set<uint32>>(OE_PLAYER_COMPANION_MORPS);

        //first time init
        if (CreatureDisplayIdSet == NULL)
        {
            CreatureDisplayIdSet = Plr->GetCreateExtension<std::set<uint32>>(OE_PLAYER_COMPANION_MORPS);
            char Query[5000];
            sprintf_s(Query, sizeof(Query), "select DisplayId from character_morphs where GUID=%d and DisplayId in (select displayid from morph_sizes where FamiliarSize != 0)", (uint32)Plr->GetGUID().GetRawValue());
            QueryResult result = CharacterDatabase.Query(Query);
            if (result && result->GetRowCount() > 1)
            {
                do {
                    Field* fields = result->Fetch();
                    CreatureDisplayIdSet->insert(fields[0].GetUInt32());
                } while (result->NextRow());
            }
        }
    }

    void LoadPlayerPetMorphs(Player *Plr)
    {
        std::set<uint32> *CreatureDisplayIdSet = Plr->GetExtension<std::set<uint32>>(OE_PLAYER_PET_MORPS);

        //first time init
        if (CreatureDisplayIdSet == NULL)
        {
            CreatureDisplayIdSet = Plr->GetCreateExtension<std::set<uint32>>(OE_PLAYER_PET_MORPS);
            char Query[5000];
            sprintf_s(Query, sizeof(Query), "select DisplayId from character_morphs where GUID=%d and DisplayId in (select displayid from morph_sizes where PetSize != 0)", (uint32)Plr->GetGUID().GetRawValue());
            QueryResult result = CharacterDatabase.Query(Query);
            if (result && result->GetRowCount() > 1)
            {
                do {
                    Field* fields = result->Fetch();
                    CreatureDisplayIdSet->insert(fields[0].GetUInt32());
                } while (result->NextRow());
            }
        }
    }

    void LoadPlayerMountMorphs(Player *Plr)
    {
        std::set<uint32> *CreatureDisplayIdSet = Plr->GetExtension<std::set<uint32>>(OE_PLAYER_MOUNT_MORPS);

        //first time init
        if (CreatureDisplayIdSet == NULL)
        {
            CreatureDisplayIdSet = Plr->GetCreateExtension<std::set<uint32>>(OE_PLAYER_MOUNT_MORPS);
            char Query[5000];
            sprintf_s(Query, sizeof(Query), "select DisplayId from character_morphs where GUID=%d and DisplayId in (select displayid from morph_sizes where MountSize != 0)", (uint32)Plr->GetGUID().GetRawValue());
            QueryResult result = CharacterDatabase.Query(Query);
            if (result && result->GetRowCount() > 1)
            {
                do {
                    Field* fields = result->Fetch();
                    CreatureDisplayIdSet->insert(fields[0].GetUInt32());
                } while (result->NextRow());
            }
        }
    }

    void LoadPlayerPlayerMorphs(Player *Plr)
    {
        std::set<uint32> *CreatureDisplayIdSet = Plr->GetExtension<std::set<uint32>>(OE_PLAYER_PLAYER_MORPS);

        //first time init
        if (CreatureDisplayIdSet == NULL)
        {
            CreatureDisplayIdSet = Plr->GetCreateExtension<std::set<uint32>>(OE_PLAYER_PLAYER_MORPS);
            char Query[5000];
            sprintf_s(Query, sizeof(Query), "select DisplayId from character_morphs where GUID=%d and DisplayId in (select displayid from morph_sizes where PlayerSize != 0)", (uint32)Plr->GetGUID().GetRawValue());
            QueryResult result = CharacterDatabase.Query(Query);
            if (result && result->GetRowCount() > 1)
            {
                do {
                    Field* fields = result->Fetch();
                    CreatureDisplayIdSet->insert(fields[0].GetUInt32());
                } while (result->NextRow());
            }
        }
    }

}
