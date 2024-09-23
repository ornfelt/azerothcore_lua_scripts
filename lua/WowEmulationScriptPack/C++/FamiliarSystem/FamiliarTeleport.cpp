#include "Player.h"
#include "DatabaseEnv.h"
#include "ObjectExtension.cpp"

#include "AddonCommunication/AddonCommunication.h"

namespace CompanionSystem
{
    #define Max_Teleport_Locations 4
    class TeleportSystemStore
    {
    public:
        TeleportSystemStore()
        {
            //mark locations that are invalid
            for (uint32 i = 0; i < Max_Teleport_Locations; i++)
            {
                TeleportLocations[i].m_mapId = -1;
                LocationNames[i] = "";
            }
        }

        void Load(Player *p)
        {
            //not yet loaded
            if (TeleportLocations[0].m_mapId != -1)
                return;

            //mark locations that are invalid
            for (uint32 i = 0; i < Max_Teleport_Locations; i++)
                TeleportLocations[i].m_mapId = -2;

            char Query[5000];
            sprintf_s(Query, sizeof(Query), "select slot,MapEntry,x,y,z,o,LocName from character_TeleportMemos where GUID=%d limit 0,%d", (uint32)p->GetGUID().GetRawValue(), Max_Teleport_Locations);
            QueryResult result = CharacterDatabase.Query(Query);
            if (result && result->GetRowCount() > 1)
            {
                do {
                    Field* fields = result->Fetch();
                    uint32 Slot = fields[0].GetUInt32();
                    if (Slot >= Max_Teleport_Locations)
                        continue;
                    TeleportLocations[Slot].m_mapId = fields[1].GetUInt32();
                    TeleportLocations[Slot].m_positionX = fields[2].GetFloat();
                    TeleportLocations[Slot].m_positionY = fields[3].GetFloat();
                    TeleportLocations[Slot].m_positionZ = fields[4].GetFloat();
                    TeleportLocations[Slot].SetOrientation( fields[5].GetFloat() );
                    LocationNames[Slot] = fields[6].GetString();
                } while (result->NextRow());
            }
        }

        void Save(Player *p, uint32 Slot, WorldLocation *NewLoc, const char *name)
        {
            if (Slot >= Max_Teleport_Locations)
                return;

            TeleportLocations[Slot] = *NewLoc;
            std::string EscapedName;
            if (name == NULL)
            {
                LocationNames[Slot] = Slot;
                EscapedName = Slot;
            }
            else
            {
                LocationNames[Slot] = name;
                if (LocationNames[Slot].length() > 20)
                    LocationNames[Slot] = LocationNames[Slot].substr(0, 20);
                EscapedName = LocationNames[Slot];
                CharacterDatabase.EscapeString(EscapedName);
            }
            char Query[5000];
            sprintf_s(Query, sizeof(Query), "replace into character_TeleportMemos values(%d,%d,%d,%f,%f,%f,%f,'%s')", (uint32)p->GetGUID().GetRawValue(), Slot, NewLoc->m_mapId, NewLoc->m_positionX, NewLoc->m_positionY, NewLoc->m_positionZ, NewLoc->GetOrientation(), EscapedName.c_str());
           CharacterDatabase.Execute(Query);
        }

        void Recall(Player *p, uint32 Slot)
        {
            if (Slot >= Max_Teleport_Locations)
                return;
             Load(p);
            //loaded but invalid
            if (TeleportLocations[Slot].m_mapId < 0)
                return;
            p->TeleportTo(TeleportLocations[Slot]);
        }

        const char *GetName(Player *p, uint32 Slot)
        {
            if (Slot >= Max_Teleport_Locations)
                return NULL;
            Load(p);
            if (TeleportLocations[Slot].m_mapId < 0)
                return NULL;
            return LocationNames[Slot].c_str();
        }

        WorldLocation *GetLocation(Player *p, uint32 Slot)
        {
            if (Slot >= Max_Teleport_Locations)
                return NULL;
            Load(p);
            if (TeleportLocations[Slot].m_mapId < 0)
                return NULL;
            return &TeleportLocations[Slot];
        }
    private:
        WorldLocation   TeleportLocations[Max_Teleport_Locations];
        std::string     LocationNames[Max_Teleport_Locations];
    };

    //save current player location to a teleport slot
    void TeleportMemo(Player *p, uint32 Slot, const char *Name)
    {
        TeleportSystemStore *tss = p->GetCreateExtension<TeleportSystemStore>(OE_PLAYER_TELEPORT_STORE);
        tss->Save(p, Slot, &p->GetWorldLocation(), Name);
    }

    //teleport to a saved location
    void TeleportRecall(Player *p, uint32 Slot)
    {
        if (p->IsInCombat())
        {
            p->BroadcastMessage("Teleport : Can't be used while in combat");
            return;
        }
        TeleportSystemStore *tss = p->GetCreateExtension<TeleportSystemStore>(OE_PLAYER_TELEPORT_STORE);
        tss->Recall(p, Slot);
    }

    //teleport to a saved location
    const char *TeleportGetName(Player *p, uint32 Slot)
    {
        TeleportSystemStore *tss = p->GetCreateExtension<TeleportSystemStore>(OE_PLAYER_TELEPORT_STORE);
        return tss->GetName(p, Slot);
    }
}

void PersonalTeleportationQueryAll(Player *PacketSender, const char *msg)
{
    CompanionSystem::TeleportSystemStore *tss = PacketSender->GetCreateExtension<CompanionSystem::TeleportSystemStore>(OE_PLAYER_TELEPORT_STORE);
    char repl[5000];
    repl[0] = 0;
    size_t BytesWritten = 0;
    for (uint32 i = 0; i < Max_Teleport_Locations; i++)
    {
        const char *Name = tss->GetName(PacketSender, i);
        if (Name == NULL)
            BytesWritten += sprintf_s(repl + BytesWritten, sizeof(repl) - BytesWritten, " ");
        else
            BytesWritten += sprintf_s(repl + BytesWritten, sizeof(repl) - BytesWritten, "%s ", Name);
        WorldLocation *Loc = tss->GetLocation(PacketSender, i);
        if( Loc == NULL )
            BytesWritten += sprintf_s(repl + BytesWritten, sizeof(repl) - BytesWritten, "-1 -1 -1 -1 ");
        else
            BytesWritten += sprintf_s(repl + BytesWritten, sizeof(repl) - BytesWritten, "%d %f %f %f ", Loc->m_mapId, Loc->m_positionX, Loc->m_positionY, Loc->m_positionZ);
    }
    AddonComm::SendMessageToClient(PacketSender, "PTLN", repl);
}

void PersonalTeleportationStore(Player *PacketSender, const char *msg)
{
    //get the index and name of the location
    int StoreIndex = 0;
    char StoreName[30];
    StoreName[0] = 0; StoreName[29] = 0;
    sscanf_s(msg, "%d %s", &StoreIndex, StoreName, (unsigned int)sizeof(StoreName));
    if (StoreIndex < 0 || StoreIndex >= Max_Teleport_Locations)
        return;
    CompanionSystem::TeleportMemo(PacketSender, StoreIndex, StoreName);
    //update the client with the new values
    PersonalTeleportationQueryAll(PacketSender, msg);
}

void PersonalTeleportationRecall(Player *PacketSender, const char *msg)
{
    //get the index and name of the location
    int StoreIndex = 0;
    sscanf_s(msg, "%ds", &StoreIndex);
    if (StoreIndex < 0 || StoreIndex >= Max_Teleport_Locations)
        return;
    CompanionSystem::TeleportRecall(PacketSender, StoreIndex);
}

void SetupPersonalTeleportSystem()
{
    AddonComm::RegisterOpcodeHandler("PTLS", PersonalTeleportationQueryAll);
    AddonComm::RegisterOpcodeHandler("TLLS", PersonalTeleportationStore);
    AddonComm::RegisterOpcodeHandler("TLLR", PersonalTeleportationRecall);
}
