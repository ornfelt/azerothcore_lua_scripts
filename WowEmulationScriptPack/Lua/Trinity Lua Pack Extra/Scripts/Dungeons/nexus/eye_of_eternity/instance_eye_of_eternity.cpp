#include "ScriptPCH.h"
#include "eye_of_eternity.h"
#include "WorldPacket.h"
 
#define DISABLED_ENTER_MESSAGE "You cannot enter Eye of Eternity now"
#define EXIT_MAP 571
#define EXIT_X 3864
#define EXIT_Z 6987
#define EXIT_Y 152
 
 
struct instance_eye_of_eternity : public ScriptedInstance
{
    instance_eye_of_eternity(Map* pMap) : ScriptedInstance(pMap) {Initialize();}
 
    std::string strInstData;
    uint32 m_auiEncounter[MAX_ENCOUNTER];
    uint32 m_uiOutroCheck;
    uint32 m_uiMalygosPlatformData;
 
    //GameObject* m_uiMalygosPlatform;
    //GameObject* m_uiFocusingIris;
    //GameObject* m_uiExitPortal;
    uint64 m_uiMalygosPlatformGUID;
    uint64 m_uiFocusingIrisGUID;
    uint64 m_uiExitPortalGUID;
 
    uint64 m_uiMalygosGUID;
    uint64 m_uiPlayerCheckGUID;

    std::list<uint64> m_flyingPlayers;
    
    bool m_bVortex;
    
 
    void Initialize()
    {
        memset(&m_auiEncounter, 0, sizeof(m_auiEncounter));
                
        m_uiMalygosGUID = 0;
        m_uiOutroCheck = 0; 
        m_uiMalygosPlatformData = 0;
        m_uiMalygosPlatformGUID = 0;
        m_uiFocusingIrisGUID = 0;
        m_uiExitPortalGUID = 0;
        m_uiPlayerCheckGUID = 0;
        m_bVortex = false;
    }
    
    void OnCreatureCreate(Creature* pCreature)
    {
        switch(pCreature->GetEntry())
        {
            case NPC_MALYGOS:
                m_uiMalygosGUID = pCreature->GetGUID();
                break;
            default:
                break;
        }
    }
    
    void OnGameObjectCreate(GameObject *pGo, bool bAdd)
    {
        switch(pGo->GetEntry())
        {
            case 193070: m_uiMalygosPlatformGUID = pGo->GetGUID(); break;
            case 193958: //normal, hero 
            case 193960: m_uiFocusingIrisGUID = pGo->GetGUID(); break;
            case 193908: m_uiExitPortalGUID = pGo->GetGUID(); break;
            default:
                break;
        }
    }
 
    bool IsEncounterInProgress() const
    {
        for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
            if (m_auiEncounter[i] == IN_PROGRESS)
                return true;
 
        return false;
    }
 
    void SetData(uint32 uiType, uint32 uiData)
    {
        switch(uiType)
        {
            case TYPE_MALYGOS:
                if(uiData == IN_PROGRESS)
                {
                    if(GameObject* m_uiExitPortal = instance->GetGameObject(m_uiExitPortalGUID))
                        m_uiExitPortal->Delete();
                    if(GameObject* m_uiFocusingIris = instance->GetGameObject(m_uiFocusingIrisGUID))
                        m_uiFocusingIris->Delete();
                }
                m_auiEncounter[0] = uiData;
                break;
            case TYPE_OUTRO_CHECK:
                m_uiOutroCheck = uiData;
                break;
            case TYPE_DESTROY_PLATFORM:
                if(uiData == IN_PROGRESS)
                {
                    if(GameObject* m_uiMalygosPlatform = instance->GetGameObject(m_uiMalygosPlatformGUID))
                        m_uiMalygosPlatform->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_DESTROYED);
                }
                else if(uiData == NOT_STARTED)
                {
                    if(GameObject* m_uiMalygosPlatform = instance->GetGameObject(m_uiMalygosPlatformGUID))
                    {
                        m_uiMalygosPlatform->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_DESTROYED);
                        m_uiMalygosPlatform->Respawn();
                    }
                }
                m_uiMalygosPlatformData = uiData;
                break;
            case TYPE_VORTEX:
                if(uiData)
                    m_bVortex = true;
                else
                    m_bVortex = false;
                break;
            case TYPE_PLAYER_HOVER:
                if(uiData == DATA_DROP_PLAYERS)
                    dropAllPlayers();
                break;
        }
    }
 
    const char* Save()
    {
        OUT_SAVE_INST_DATA;
        std::ostringstream saveStream;
        saveStream << m_auiEncounter[0] << " " << m_uiOutroCheck;
 
        strInstData = saveStream.str();
        SaveToDB();
        OUT_SAVE_INST_DATA_COMPLETE;
        return strInstData.c_str();
    }
 
    void Load(const char* chrIn)
    {
        if (!chrIn)
        {
            OUT_LOAD_INST_DATA_FAIL;
            return;
        }
 
        OUT_LOAD_INST_DATA(chrIn);
 
        std::istringstream loadStream(chrIn);
        loadStream >> m_auiEncounter[0] >> m_uiOutroCheck;
 
        for(uint8 i = 0; i < MAX_ENCOUNTER; ++i)
        {
            if (m_auiEncounter[i] == IN_PROGRESS)
                m_auiEncounter[i] = NOT_STARTED;
        }
 
        OUT_LOAD_INST_DATA_COMPLETE;
    }
 
    uint32 GetData(uint32 uiType)
    {
        switch(uiType)
        {
            case TYPE_MALYGOS:
                return m_auiEncounter[0];
            case TYPE_OUTRO_CHECK:
                return m_uiOutroCheck;
            case TYPE_DESTROY_PLATFORM:
                return m_uiMalygosPlatformData;
            case TYPE_VORTEX:
                return m_bVortex;
            case TYPE_CHECK_PLAYER_FLYING:
                return isFlying(m_uiPlayerCheckGUID);
        }
        return 0;
    }
 
    uint64 GetData64(uint32 uiData)
    {
        switch(uiData)
        {
            case NPC_MALYGOS:
                return m_uiMalygosGUID;
            default:
                return 0;
        }
        return 0;
    }

    void SetData64(uint32 uiType, uint64 uiData)
    {
        switch(uiType)
        {
        case TYPE_PLAYER_HOVER:
            if(!isFlying(uiData))
            {
                Unit* pUnit = Unit::GetUnit(*(instance->GetCreature(m_uiMalygosGUID)), uiData);
                if(pUnit && pUnit->GetTypeId() == TYPEID_PLAYER)
                {
                    m_flyingPlayers.push_back(uiData);

                    //Using packet workaround
                    WorldPacket data(12);
                    data.SetOpcode(SMSG_MOVE_SET_CAN_FLY);
                    data.append(pUnit->GetPackGUID());
                    data << uint32(0);
                    pUnit->SendMessageToSet(&data, true);
                }
            }
            break;

        case TYPE_SET_PLAYER_TO_CHECK:
            m_uiPlayerCheckGUID = uiData;
            break;
        }
    }

    bool isFlying(uint64 GUID)
    {
        if(m_flyingPlayers.empty())
            return false;

        for(std::list<uint64>::iterator itr = m_flyingPlayers.begin(); itr != m_flyingPlayers.end(); ++itr)
        {
            if(Player* pPlayer = (Player*)Unit::GetUnit(*(instance->GetCreature(m_uiMalygosGUID)), (*itr)))
            {
                if(pPlayer->GetGUID() == GUID)
                    return true;
            }
        }
        return false;
    }

    void dropAllPlayers()
    {
        for(std::list<uint64>::iterator itr = m_flyingPlayers.begin(); itr != m_flyingPlayers.end(); ++itr)
        {
            if(Unit* pUnit = Unit::GetUnit(*(instance->GetCreature(m_uiMalygosGUID)), (*itr)))
            {
                //Using packet workaround
                WorldPacket data(12);
                data.SetOpcode(SMSG_MOVE_UNSET_CAN_FLY);
                data.append(pUnit->GetPackGUID());
                data << uint32(0);
                pUnit->SendMessageToSet(&data, true);
            }
        }
        m_flyingPlayers.clear();
    }

    void OnPlayerEnter(Player* pPlayer)
    {
        if(GetData(TYPE_MALYGOS) == DONE)
        {
            Creature *pTemp = pPlayer->SummonCreature(NPC_WYRMREST_SKYTALON, pPlayer->GetPositionX(), pPlayer->GetPositionY(), pPlayer->GetPositionZ() - 5, 0);
            if(pTemp)
            {
                pTemp->SetCreatorGUID(pPlayer->GetGUID());
                pPlayer->EnterVehicle(pTemp, 0);
            }
        }
    }
};
 
InstanceData* GetInstanceData_instance_eye_of_eternity(Map* pMap)
{
    return new instance_eye_of_eternity(pMap);
}
 
void AddSC_instance_eye_of_eternity()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "instance_eye_of_eternity";
    newscript->GetInstanceData = &GetInstanceData_instance_eye_of_eternity;
    newscript->RegisterSelf();
}