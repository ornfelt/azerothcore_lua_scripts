#include "SharedDefines.h"
#include "ScriptMgr.h"
#include "ObjectExtension.cpp"
#include "Player.h"
#include "DatabaseEnv.h"
#include "Pet.h"
#include "ScriptSettings\ScriptSettingsAPI.h"

enum MorphType
{
    MORPH_PLAYER = 1,
    MORPH_PET,
    MORPH_COMPANION,
    MORPH_MOUNT,
};

float GetMorphSizeForPlayer(Player *p, uint32 DisplayId, MorphType type)
{
    char Query[5000];

    //check if player has access to this morph
    {
        sprintf_s(Query, sizeof(Query), "select count(*) from character_morphs where GUID=%d and DisplayId=%d", (uint32)p->GetGUID().GetRawValue(), DisplayId);
        QueryResult result = CharacterDatabase.Query(Query);
        if (!result || result->GetRowCount() != 1)
        {
            p->BroadcastMessage("You do not own this morph yet");
            return -1.0f;
        }
    }

    //get the size of this morph
    if(type== MORPH_PLAYER)
        sprintf_s(Query, sizeof(Query), "select PlayerSize from morph_sizes where DisplayId=%d", DisplayId);
    else if (type == MORPH_PET)
        sprintf_s(Query, sizeof(Query), "select PetSize from morph_sizes where DisplayId=%d", DisplayId);
    else if (type == MORPH_COMPANION)
        sprintf_s(Query, sizeof(Query), "select FamiliarSize from morph_sizes where DisplayId=%d", DisplayId);
    else if (type == MORPH_MOUNT)
        sprintf_s(Query, sizeof(Query), "select MountSize,CanFly from morph_sizes where DisplayId=%d", DisplayId);

    QueryResult result = CharacterDatabase.Query(Query);
    if (!result || result->GetRowCount() != 1)
    {
        p->BroadcastMessage("Missing display info template");
        return 0.0f;
    }

    Field* fields = result->Fetch();
    float Size = fields[0].GetFloat();

    if (p->CanFly() == true && type == MORPH_MOUNT)
    {
        uint32 CanFly = fields[1].GetUInt32();
        if (CanFly == 0)
        {
            p->BroadcastMessage("This morph can not fly");
            return 0.0f;
        }
    }

    if (Size <= 0.0f)
    {
        p->BroadcastMessage("Missing display info template");
        return 0.0f;
    }

    return Size;
}

class MorphStatusStore
{
public:
    MorphStatusStore()
    {
        PlayerSizeOriginal = 0.0f;
        PlayerDisplayOriginal = 0;
    }
    void MorpToDisplayID(Player *p, uint32 DisplayId, MorphType type)
    {
        if (type == MORPH_PLAYER)
        {
            if (DisplayId != 0)
            {
                SetScripVariableInt32(SSV_Player_Morph, (uint32)p->GetGUID().GetRawValue(), DisplayId); // so we can restore it on player login
                //save values if this is firt time use
                PlayerSizeOriginal = p->GetObjectScale();
                if (PlayerSizeOriginal >= 1.3f || PlayerSizeOriginal <= 0.7f)
                    PlayerSizeOriginal = 1.0f;
                if(PlayerDisplayOriginal == 0)
                    PlayerDisplayOriginal = p->GetNativeDisplayId();
                //check if we have info for this morph
                float NewScale = GetMorphSizeForPlayer(p, DisplayId, type);
                if (NewScale > 0.0f)
                {
                    p->SetNativeDisplayId(DisplayId);
                    p->SetDisplayId(DisplayId);
                    p->SetObjectScale(NewScale);
                }
            }
            else if (PlayerDisplayOriginal != 0)
            {                
                DelScripVariableInt32(SSV_Player_Morph, (uint32)p->GetGUID().GetRawValue()); // no more need to restore it on login
                p->SetDisplayId(PlayerDisplayOriginal);
                p->SetNativeDisplayId(PlayerDisplayOriginal);
                p->SetObjectScale(PlayerSizeOriginal);
            }
        }

        else if (type == MORPH_PET) // hunter pet
        {
            Pet *pet = p->GetPet();
            if (pet == NULL)
            {
                p->BroadcastMessage("You need to have a pet summoned to apply morph");
                return;
            }
            if (DisplayId != 0)
            {
                float NewScale = GetMorphSizeForPlayer(p, DisplayId, type);
                if (NewScale > 0.0f)
                {
                    pet->SetDisplayId(DisplayId);
                    pet->SetObjectScale(NewScale);
                }
            }
            else if (PlayerDisplayOriginal != 0)
            {
                p->BroadcastMessage("Re summon your pet to reset it's display");
            }
        }

        else if (type == MORPH_MOUNT) // hunter pet
        {
            if (p->IsMounted() == false)
            {
                p->BroadcastMessage("You need to be mounted to morph");
                return;
            }
            if (DisplayId != 0)
            {
                float NewScale = GetMorphSizeForPlayer(p, DisplayId, type);
                if (NewScale > 0.0f)
                {
                    p->SetUInt32Value(UNIT_FIELD_MOUNTDISPLAYID,DisplayId);
                    p->SetObjectScale(NewScale);
                }
            }
            else if (PlayerDisplayOriginal != 0)
            {
                p->BroadcastMessage("Re mount to reset it's display");
            }
        }

        else if (type == MORPH_COMPANION) // companion critter pet, guardian pet, MINIPET
        {
            Unit *u = p->GetSelectedUnit();
            if (u == NULL)
            {
                p->BroadcastMessage("Please select a companion first");
                return;
            }
            if(u->GetOwnerGUID() != p->GetGUID() || u->GetGUID() != p->GetCritterGUID())
            {
                p->BroadcastMessage("Please select your companion.");
                return;
            }
            if (DisplayId != 0)
            {
                float NewScale = GetMorphSizeForPlayer(p, DisplayId, type);
                if (NewScale > 0.0f)
                {
                    u->SetDisplayId(DisplayId);
                    u->SetObjectScale(NewScale);
                }
            }
            else if (PlayerDisplayOriginal != 0)
            {
                p->BroadcastMessage("Re summon to restore display");
            }
        }
    }
private:
    float           PlayerSizeOriginal;
    uint32          PlayerDisplayOriginal;
};

bool CheckValidClientCommand(const char *cmsg, int32 type, const char * channel);
int FindNextIntParam(const char *str);
class TC_GAME_API MorphAnythingRegisterScript : public PlayerScript
{
public:
    MorphAnythingRegisterScript() : PlayerScript("MorphAnythingRegisterScript") {}
    void OnLogin(Player* player, bool firstLogin)
    {
        int32 MorphId = 0;
        MorphId = GetScripVariableInt32(SSV_Player_Morph, (uint32)player->GetGUID().GetRawValue(), NULL);
        if (MorphId != 0)
            player->GetCreateExtension<MorphStatusStore>(OE_PLAYER_MORPH_STATE_STORE)->MorpToDisplayID(player, MorphId, MORPH_PLAYER);
    }
    void OnDelete(ObjectGuid guid, uint32 accountId)
    {
        char Query[5000];
        sprintf_s(Query, sizeof(Query), "delete from character_morphs where GUID=%d", (uint32)guid.GetRawValue());
        CharacterDatabase.Execute(Query);
    }
};

void MEParseClientUserCommand(Player* player, uint32 type, std::string& msg)
{
    if (CheckValidClientCommand(msg.c_str(), type, NULL) == false)
    {
        return;
    }

    if (strstr(msg.c_str(), "#csMorphSelf ") == msg.c_str())
    {
        int DisplayId = FindNextIntParam(msg.c_str());
        player->GetCreateExtension<MorphStatusStore>(OE_PLAYER_MORPH_STATE_STORE)->MorpToDisplayID(player, DisplayId, MORPH_PLAYER);
    }

    if (strstr(msg.c_str(), "#csMorphPet ") == msg.c_str())
    {
        int DisplayId = FindNextIntParam(msg.c_str());
        player->GetCreateExtension<MorphStatusStore>(OE_PLAYER_MORPH_STATE_STORE)->MorpToDisplayID(player, DisplayId, MORPH_PET);
    }

    if (strstr(msg.c_str(), "#csMorphCompanion ") == msg.c_str())
    {
        int DisplayId = FindNextIntParam(msg.c_str());
        player->GetCreateExtension<MorphStatusStore>(OE_PLAYER_MORPH_STATE_STORE)->MorpToDisplayID(player, DisplayId, MORPH_COMPANION);
    }

    if (strstr(msg.c_str(), "#csMorphMount ") == msg.c_str())
    {
        int DisplayId = FindNextIntParam(msg.c_str());
        player->GetCreateExtension<MorphStatusStore>(OE_PLAYER_MORPH_STATE_STORE)->MorpToDisplayID(player, DisplayId, MORPH_MOUNT);
    }
}

void RBAC_XMorph(Player* player, int target, int DisplayId) {
    if (target == 0) //self
        player->GetCreateExtension<MorphStatusStore>(OE_PLAYER_MORPH_STATE_STORE)->MorpToDisplayID(player, DisplayId, MORPH_PLAYER);

    if (target == 1) //pet
        player->GetCreateExtension<MorphStatusStore>(OE_PLAYER_MORPH_STATE_STORE)->MorpToDisplayID(player, DisplayId, MORPH_PET);

    if (target == 2) //companion
        player->GetCreateExtension<MorphStatusStore>(OE_PLAYER_MORPH_STATE_STORE)->MorpToDisplayID(player, DisplayId, MORPH_COMPANION);

    if (target == 3) //mount
        player->GetCreateExtension<MorphStatusStore>(OE_PLAYER_MORPH_STATE_STORE)->MorpToDisplayID(player, DisplayId, MORPH_MOUNT);
}

void RBAC_XMorph(Player* player, int target, char const* Display) {
    //printf("Display %s\n", Display);
    int DisplayId = atoi(Display);
    RBAC_XMorph(player, target, DisplayId);
}

void MAOnChatMessageReceived(void *p, void *)
{
    CP_CHAT_RECEIVED *params = PointerCast(CP_CHAT_RECEIVED, p);

    //check for strings that might be our commands
    MEParseClientUserCommand(params->SenderPlayer, params->MsgType, *params->Msg);
}

void AddMorphAnythingScripts()
{
    /*
    CREATE TABLE IF NOT EXISTS `character_morphs` (
    `GUID` int(11) NOT NULL,
    `DisplayId` int(11) DEFAULT NULL,
    UNIQUE KEY `relation` (`GUID`,`DisplayId`),
    KEY `RowUniqueId` (`GUID`,`DisplayId`) USING BTREE
    ) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

    CREATE TABLE IF NOT EXISTS `morph_sizes` (
    `DisplayId` int(11) NOT NULL,
    `PlayerSize` float DEFAULT NULL,
    `PetSize` float DEFAULT NULL,
    `FamiliarSize` float DEFAULT NULL,
    `MountSize` float DEFAULT NULL,
    `CanFly` int DEFAULT 0,
    UNIQUE KEY `relation` (`DisplayId`),
    KEY `RowUniqueId` (`DisplayId`) USING BTREE
    ) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

    #testing player morphs : pirate
    #insert into morph_sizes (DisplayId,PlayerSize) values (2347,1),(6944,1),(6945,1),(4620,1),(3494,1),(7113,1),(6948,1),(6956,1),(3833,1);

    replace into morph_sizes (DisplayId,MountSize) values (207,0.833);
    replace into morph_sizes (DisplayId,MountSize) values (247,0.833);
    replace into morph_sizes (DisplayId,MountSize) values (304,6.000);
    replace into morph_sizes (DisplayId,MountSize) values (479,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (1166,0.833);
    replace into morph_sizes (DisplayId,MountSize) values (1281,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (2188,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (2320,0.833);
    replace into morph_sizes (DisplayId,MountSize) values (2326,0.833);
    replace into morph_sizes (DisplayId,MountSize) values (2327,0.833);
    replace into morph_sizes (DisplayId,MountSize) values (2328,0.833);
    replace into morph_sizes (DisplayId,MountSize) values (2346,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (2402,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (2404,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (2405,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (2408,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (2409,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (2410,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (2736,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (2784,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (2785,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (2786,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (2787,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (4805,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (4806,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (4807,0.769);
    replace into morph_sizes (DisplayId,MountSize) values (5228,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (6076,0.769);
    replace into morph_sizes (DisplayId,MountSize) values (6080,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (6442,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (6443,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (6444,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (6447,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (6448,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (6468,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (6469,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (6471,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (6472,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (6473,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (6474,0.769);
    replace into morph_sizes (DisplayId,MountSize) values (6475,0.769);
    replace into morph_sizes (DisplayId,MountSize) values (6476,0.769);
    replace into morph_sizes (DisplayId,MountSize) values (6477,0.769);
    replace into morph_sizes (DisplayId,MountSize) values (6478,0.769);
    replace into morph_sizes (DisplayId,MountSize) values (6569,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (7709,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (8469,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (9473,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (9474,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (9475,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (9476,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (9695,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (9714,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (9991,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (10426,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (10661,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (10662,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (10664,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (10666,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (10670,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (10671,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (10672,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (10718,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (10719,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (10720,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (10721,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (11641,0.600);
    replace into morph_sizes (DisplayId,MountSize) values (12149,0.769);
    replace into morph_sizes (DisplayId,MountSize) values (12241,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (12242,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (12245,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (12246,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (14329,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (14330,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (14331,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (14332,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (14333,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (14334,0.833);
    replace into morph_sizes (DisplayId,MountSize) values (14335,0.833);
    replace into morph_sizes (DisplayId,MountSize) values (14336,0.833);
    replace into morph_sizes (DisplayId,MountSize) values (14337,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (14338,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (14339,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (14342,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (14343,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (14344,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (14346,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (14347,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (14348,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (14349,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (14372,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (14374,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (14375,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (14376,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (14377,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (14388,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (14541,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (14542,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (14544,0.571);
    replace into morph_sizes (DisplayId,MountSize) values (14546,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (14547,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (14548,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (14549,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (14550,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (14551,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (14552,0.500);
    replace into morph_sizes (DisplayId,MountSize) values (14553,0.500);
    replace into morph_sizes (DisplayId,MountSize) values (14554,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (14573,0.833);
    replace into morph_sizes (DisplayId,MountSize) values (14574,0.833);
    replace into morph_sizes (DisplayId,MountSize) values (14575,0.833);
    replace into morph_sizes (DisplayId,MountSize) values (14576,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (14577,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (14578,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (14579,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (14582,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (14583,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (14584,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (14632,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (14776,0.833);
    replace into morph_sizes (DisplayId,MountSize) values (15289,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (15290,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (15672,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (15676,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (15679,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (15680,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (15681,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (15902,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (15904,1.200);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (16314,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (16943,1.000,1);
    replace into morph_sizes (DisplayId,MountSize) values (17063,0.500);
    replace into morph_sizes (DisplayId,MountSize) values (17142,0.367);
    replace into morph_sizes (DisplayId,MountSize) values (17158,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (17549,0.500);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (17693,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (17694,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (17696,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (17697,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (17698,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (17699,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (17700,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (17701,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (17703,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (17717,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (17718,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (17719,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (17720,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (17721,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (17722,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (17759,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (17890,1.000,1);
    replace into morph_sizes (DisplayId,MountSize) values (17906,0.500);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (18164,1.000,1);
    replace into morph_sizes (DisplayId,MountSize) values (18696,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (18697,1.000);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (18724,1.000,1);
    replace into morph_sizes (DisplayId,MountSize) values (19085,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (19250,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (19296,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (19303,0.909);
    replace into morph_sizes (DisplayId,MountSize) values (19375,0.909);
    replace into morph_sizes (DisplayId,MountSize) values (19376,0.909);
    replace into morph_sizes (DisplayId,MountSize) values (19377,0.909);
    replace into morph_sizes (DisplayId,MountSize) values (19378,0.909);
    replace into morph_sizes (DisplayId,MountSize) values (19478,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (19479,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (19480,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (19482,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (19483,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (19484,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (19608,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (19869,0.500);
    replace into morph_sizes (DisplayId,MountSize) values (19870,0.500);
    replace into morph_sizes (DisplayId,MountSize) values (19871,0.500);
    replace into morph_sizes (DisplayId,MountSize) values (19872,0.500);
    replace into morph_sizes (DisplayId,MountSize) values (19873,0.500);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (20029,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (20344,1.000,1);
    replace into morph_sizes (DisplayId,MountSize) values (20359,1.000);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (20846,0.500,1);
    replace into morph_sizes (DisplayId,MountSize) values (21073,0.909);
    replace into morph_sizes (DisplayId,MountSize) values (21074,0.909);
    replace into morph_sizes (DisplayId,MountSize) values (21075,0.909);
    replace into morph_sizes (DisplayId,MountSize) values (21076,0.909);
    replace into morph_sizes (DisplayId,MountSize) values (21077,0.909);
    replace into morph_sizes (DisplayId,MountSize) values (21147,1.000);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (21152,0.667,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (21155,0.667,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (21156,0.667,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (21157,0.667,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (21158,0.667,1);
    replace into morph_sizes (DisplayId,MountSize) values (21268,0.571);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (21473,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (21486,0.667,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (21520,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (21521,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (21522,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (21523,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (21524,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (21525,1.000,1);
    replace into morph_sizes (DisplayId,MountSize) values (21635,0.571);
    replace into morph_sizes (DisplayId,MountSize) values (21939,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (21973,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (21974,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (22265,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (22350,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (22351,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (22462,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (22463,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (22464,0.741);
    replace into morph_sizes (DisplayId,MountSize) values (22465,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (22466,0.800);
    replace into morph_sizes (DisplayId,MountSize) values (22467,0.667);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (22470,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (22471,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (22472,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (22473,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (22474,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (22620,1.000,1);
    replace into morph_sizes (DisplayId,MountSize) values (22630,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (22631,1.000);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (22719,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (22720,1.000,1);
    replace into morph_sizes (DisplayId,MountSize) values (22724,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (22976,0.769);
    replace into morph_sizes (DisplayId,MountSize) values (22977,0.833);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (23056,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (23458,0.800,1);
    replace into morph_sizes (DisplayId,MountSize) values (23459,0.833);
    replace into morph_sizes (DisplayId,MountSize) values (23460,0.301);
    replace into morph_sizes (DisplayId,MountSize) values (23581,0.571);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (23647,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (23656,1.000,1);
    replace into morph_sizes (DisplayId,MountSize) values (23928,0.500);
    replace into morph_sizes (DisplayId,MountSize) values (23952,0.714);
    replace into morph_sizes (DisplayId,MountSize) values (23966,0.500);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (24324,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (24447,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (24472,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (24614,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (24665,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (24688,1.000,1);
    replace into morph_sizes (DisplayId,MountSize) values (24693,1.000);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (24710,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (24714,0.769,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (24725,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (24743,1.000,1);
    replace into morph_sizes (DisplayId,MountSize) values (24745,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (24757,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (24758,0.667);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (24784,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (24869,1.000,1);
    replace into morph_sizes (DisplayId,MountSize) values (24913,0.733);
    replace into morph_sizes (DisplayId,MountSize) values (25159,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (25278,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (25279,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (25280,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (25335,0.741);
    replace into morph_sizes (DisplayId,MountSize) values (25445,0.741);
    replace into morph_sizes (DisplayId,MountSize) values (25450,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (25451,1.000);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (25511,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (25579,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (25593,1.000,1);
    replace into morph_sizes (DisplayId,MountSize) values (25678,0.833);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (25679,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (25803,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (25831,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (25832,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (25833,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (25834,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (25835,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (25836,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (25852,1.033,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (25853,1.033,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (25854,1.033,1);
    replace into morph_sizes (DisplayId,MountSize) values (25870,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (25871,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (25958,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (26164,0.401);
    replace into morph_sizes (DisplayId,MountSize) values (26215,0.500);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (26303,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (26308,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (26363,1.000,1);
    replace into morph_sizes (DisplayId,MountSize) values (26388,0.364);
    replace into morph_sizes (DisplayId,MountSize) values (26424,0.400);
    replace into morph_sizes (DisplayId,MountSize) values (26500,0.741);
    replace into morph_sizes (DisplayId,MountSize) values (26539,0.571);
    replace into morph_sizes (DisplayId,MountSize) values (26540,0.571);
    replace into morph_sizes (DisplayId,MountSize) values (26541,0.571);
    replace into morph_sizes (DisplayId,MountSize) values (26558,0.500);
    replace into morph_sizes (DisplayId,MountSize) values (26559,0.500);
    replace into morph_sizes (DisplayId,MountSize) values (26572,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (26573,0.500);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (26578,1.000,1);
    replace into morph_sizes (DisplayId,MountSize) values (26609,0.500);
    replace into morph_sizes (DisplayId,MountSize) values (26610,0.500);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (26611,0.571,1);
    replace into morph_sizes (DisplayId,MountSize) values (26612,0.500);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (26616,1.333,1);
    replace into morph_sizes (DisplayId,MountSize) values (26624,0.500);
    replace into morph_sizes (DisplayId,MountSize) values (26625,0.533);
    replace into morph_sizes (DisplayId,MountSize) values (26681,0.571);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (26691,1.000,1);
    replace into morph_sizes (DisplayId,MountSize) values (26755,0.857);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (26881,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (26883,0.500,1);
    replace into morph_sizes (DisplayId,MountSize) values (27237,0.500);
    replace into morph_sizes (DisplayId,MountSize) values (27238,0.500);
    replace into morph_sizes (DisplayId,MountSize) values (27239,0.500);
    replace into morph_sizes (DisplayId,MountSize) values (27240,0.500);
    replace into morph_sizes (DisplayId,MountSize) values (27241,0.500);
    replace into morph_sizes (DisplayId,MountSize) values (27242,0.500);
    replace into morph_sizes (DisplayId,MountSize) values (27243,0.500);
    replace into morph_sizes (DisplayId,MountSize) values (27244,0.500);
    replace into morph_sizes (DisplayId,MountSize) values (27245,0.500);
    replace into morph_sizes (DisplayId,MountSize) values (27246,0.500);
    replace into morph_sizes (DisplayId,MountSize) values (27247,0.500);
    replace into morph_sizes (DisplayId,MountSize) values (27248,0.500);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (27480,0.500,1);
    replace into morph_sizes (DisplayId,MountSize) values (27507,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (27515,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (27517,0.500);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (27525,0.625,1);
    replace into morph_sizes (DisplayId,MountSize) values (27541,0.367);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (27561,1.000,1);
    replace into morph_sizes (DisplayId,MountSize) values (27567,0.741);
    replace into morph_sizes (DisplayId,MountSize) values (27649,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (27650,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (27659,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (27660,1.000);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (27781,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (27785,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (27796,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (27797,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (27798,1.000,1);
    replace into morph_sizes (DisplayId,MountSize) values (27818,0.741);
    replace into morph_sizes (DisplayId,MountSize) values (27819,0.741);
    replace into morph_sizes (DisplayId,MountSize) values (27820,0.741);
    replace into morph_sizes (DisplayId,MountSize) values (27821,0.741);
    replace into morph_sizes (DisplayId,MountSize) values (27902,0.800);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (27913,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (27914,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (28040,0.500,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (28041,0.500,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (28042,0.500,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (28043,0.500,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (28044,0.500,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (28045,0.500,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (28053,0.500,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (28060,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (28061,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (28063,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (28064,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (28081,0.367,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (28082,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (28083,0.367,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (28108,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (28117,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (28402,0.625,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (28417,0.625,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (28421,1.000,1);
    replace into morph_sizes (DisplayId,MountSize) values (28428,0.741);
    replace into morph_sizes (DisplayId,MountSize) values (28556,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (28571,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (28605,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (28606,0.500);
    replace into morph_sizes (DisplayId,MountSize) values (28607,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (28612,1.000);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (28652,1.000,1);
    replace into morph_sizes (DisplayId,MountSize) values (28888,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (28889,1.000);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (28890,0.500,1);
    replace into morph_sizes (DisplayId,MountSize) values (28912,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (28918,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (28919,1.000);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (28954,0.500,1);
    replace into morph_sizes (DisplayId,MountSize) values (29043,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (29102,0.909);
    replace into morph_sizes (DisplayId,MountSize) values (29130,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (29161,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (29255,0.500);
    replace into morph_sizes (DisplayId,MountSize) values (29256,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (29257,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (29258,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (29259,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (29260,0.833);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (29261,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (29262,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (29283,0.833,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (29284,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (29344,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (29361,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (29364,0.625,1);
    replace into morph_sizes (DisplayId,MountSize) values (29378,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (29379,1.000);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (29627,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (29674,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (29695,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (29696,0.625,1);
    replace into morph_sizes (DisplayId,MountSize) values (29754,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (29755,0.667);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (29794,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (29842,0.500,1);
    replace into morph_sizes (DisplayId,MountSize) values (29937,1.000);
    replace into morph_sizes (DisplayId,MountSize) values (29938,0.952);
    replace into morph_sizes (DisplayId,MountSize) values (30045,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (30046,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (30047,0.667);
    replace into morph_sizes (DisplayId,MountSize) values (30070,0.833);
    replace into morph_sizes (DisplayId,MountSize) values (30141,1.250);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (30346,0.800,1);
    replace into morph_sizes (DisplayId,MountSize) values (30518,1.250);
    replace into morph_sizes (DisplayId,MountSize) values (30695,0.800);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (30989,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (31007,0.909,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (31047,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (31154,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (31156,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (31627,1.333,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (31714,1.000,1);
    replace into morph_sizes (DisplayId,MountSize) values (31721,0.833);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (31803,1.000,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (31837,1.030,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (31958,0.909,1);
    replace into morph_sizes (DisplayId,MountSize,CanFly) values (31992,1.000,1);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (1082,0.5,0);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (2185,1,0);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (2833,0.833,0);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (6470,0.909,0);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (6544,1,0);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (10667,1,0);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (10673,1,0);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (12240,0.6,0);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (12247,0.6,0);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (14341,1,0);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (14345,1,0);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (14581,1,0);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (14777,1,0);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (15335,0.769,0);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (15667,0.714,0);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (15673,1,0);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (15674,1,0);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (15675,1,0);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (15677,1,0);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (15678,1,0);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (18722,0.5,1);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (18920,0.8,1);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (19408,0.5,1);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (21423,0.667,1);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (21444,0.667,1);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (21548,1,1);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (22844,0.769,0);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (22845,0.769,0);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (23471,0.367,0);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (23964,0.15,0);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (24009,1,1);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (24181,0.5,0);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (24456,0.833,0);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (24891,1,1);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (25686,1,0);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (26133,0.401,0);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (26709,0.333,1);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (26715,0.333,1);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (26719,0.25,1);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (26721,0.25,1);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (26722,0.25,1);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (26723,0.25,1);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (26724,0.25,1);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (27038,0.4,1);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (27040,0.4,1);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (28917,1,0);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (28931,1,0);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (28953,0.5,1);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (29113,0.769,0);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (29129,1,0);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (31155,1,1);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (31157,1,1);
replace into morph_sizes (DisplayId,MountSize,CanFly) values (31670,1,0);
    */
/*
3533 - Undead (Male)
3529 - undead (Female)
4358 - Troll (Female)
11193 - Troll (Male)
6768 - Orc (Female)
6785 - Orc (Male)
5486 - Tauren (Male)
3000 - Tauren (Female)
2222 - Night Elf (Female)
2245 - Night Elf (Male)
7000 - Gnome (Female)
7004 - Gnome (Male)
7001 - Dwarf (Male)
5737 - Dwarf (Female)
17155 - Draenei (Male)
19171 - Draenei (Female)
19161 - Goblin (Female)
19000 - Goblin (Male)
19169 - Blood Elf (Female)
21881 - Blood Elf (Male)
5735 - Human (Female)
5736 - Human (Male)



---City Bosses--
4527 - Thrall (Org)
11657 - Lady Sylvanas (UC)
4307 - Cairne Bloodhoof (TB)
17122 - Lor´themar Theron (SC)
3597 - King Magni Bronzebeard (IF)
5566 Highlord Bolvar Fordragon (SW)
7006 High Tinker Mekkatorque (Gnomer)
7274 - Tyrande Whisperwind (Darn)




===Armoured==
25019 - Armored Dwarf - Female
25020 - Armored Orc - Male
25021 - Armored Troll - Male
25022 - Armored Night Elf - Male
25023 - Armored Dwarf - Male
25024 - Armored Orc - Female
25025 - Armored Tauren - Male
25027 - Human Male Cloth Armored
25028 - Dranei Female Armored
25029 - Squeeky Gnome


===Pirates===
25032 - QueerElf Pirate(Bloodelf)
25033 - Dranei Pirate
25034 - Dwarf Pirate
25035 - Gnome Pirate
25036 - Goblin Pirate
25037 - Human Pirate
25038 - Night Elf Pirate
25039 - Orc Pirate
25040 - Tauren Pirate
25041 - Troll Pirate
25042 - Undead Pirate
25043 - Bloodelf Pirate(Female)
25044 - Dranei Pirate(Female)
25045 - Dwarf Pirate(Female)
25046 - Gnome Pirate(Female)
25047 - Goblin Pirate(Female)
25048 - Human Pirate(Female)
25049 - NightElf Pirate(Female)
25050 - Orc Pirate(Female)(Gag)
25051 - Tauren Pirate(Female)
25052 - Troll Pirate(Female)
25053 - Undead Pirate(Female)
25054 - Human Pirate(Female)


====Armor Free====
Bloodelf Female 20370
Bloodelf Male 20368
Broken Male 21105
Draenai Female 20323
Dwarf Male 20317
Gnome Female 20320
Gnome Male 20580
Goblin Female 20583
Goblin Male 20582
Human Female 19724
Human Male 19723
Nightelf Male 20318
Orc Female 20316
Tauren Female 20584
Tauren Male 20319
Troll Male 20321


===Others===
30659 - Male Skeleton1
24496 - Male Skeleton2
18162 - Male Skeleton3

31852 - Male Goblin1
28891 - Male Goblin2
19037 - Male Goblin3

===Zombie===
30646-zombie1
10977-zombie2
24707-zombie3
10979-zombie4
*/
    RegisterCallbackFunction(CALLBACK_TYPE_CHAT_RECEIVED, MAOnChatMessageReceived, NULL);
    new MorphAnythingRegisterScript();
}
