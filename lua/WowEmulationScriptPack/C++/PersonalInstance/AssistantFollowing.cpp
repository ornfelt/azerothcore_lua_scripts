#include "Player.h"
#include "PersonalInstance.h"
#include "ScriptedGossip.h"
#include "ScriptMgr.h"
#include "CreatureAI.h"
#include "Creature.h"
#include "Map.h"
#include "ObjectExtension.cpp"
#include "DBCStores.h"
#include "World.h"
#include "ObjectMgr.h"
#include "GameObjectData.h"
#include "GameObject.h"
#include "GridNotifiers.h"
#include "DBCStores.h"
#include "TemporarySummon.h"

void PersonalInstanceSummonPlayer(Player *Summoner, const char *SummonedPlayerName);
void PersonalInstanceKickPlayer(Player *Kicker, const char *KickedPlayerName);
void PersonalInstanceKickAllPlayers(Player *Kicker);

#define CREATURE_ENTRY_ASISSTANT_FOLLOWING        123465  // auto spawn it once we enter our instance

void SpawnAssistantFollowing(Player *player)
{
    //sanity checks
    if (player == NULL || player->FindMap() == NULL)
        return;

    SummonPropertiesEntry const* properties = sSummonPropertiesStore.LookupEntry(307);
    if (properties == NULL)
        return;
    Position pos = player->GetRandomPoint(player->GetPosition(), 3);
    TempSummon* summon = player->GetMap()->SummonCreature(CREATURE_ENTRY_ASISSTANT_FOLLOWING, pos, properties, 0, player, 61357);
    if (!summon)
        return;

    summon->SetFaction(player->GetFaction());

    ((Minion*)summon)->SetFollowAngle(player->GetAbsoluteAngle(summon));

    summon->SelectLevel();       // some summoned creaters have different from 1 DB data for level/hp
    summon->SetUInt32Value(UNIT_NPC_FLAGS, summon->GetCreatureTemplate()->npcflag);
    summon->SetImmuneToAll(true);
    summon->AI()->EnterEvadeMode();
    summon->SetDisableGravity(true);
}

class GossipMenuId
{
public:
    GossipMenuId(int pComposedId)
    {
        ComposedId = pComposedId;
    }
    GossipMenuId(int MenuId, int ItemId)
    {
        ComposedId = (MenuId & 255) << 24;
        ComposedId |= (ItemId & 0x00FFFFFF);
    }
    int GetMenuid() { return ((ComposedId >> 24) & 255); }
    int GetItemId() { return (ComposedId & 0x00FFFFFF); }
    int Get() { return ComposedId; }
private:
    int ComposedId;
};

#define ITEMS_PAGE  16
#define MAX_PAGES   10  // maybe it's 16 ? what is client limit for gossip menu ?

class Paginator
{
public:
    Paginator(const std::set<uint32> *list)
    {
        Content = list;
    }
    size_t GetNumberOfPages()
    {
        size_t t = (Content->size() + ITEMS_PAGE - 1) / ITEMS_PAGE;
        if (t > MAX_PAGES)
            return MAX_PAGES;
        return t;
    }
    std::set<uint32>::iterator GetPageStart(uint32 PageNr)
    {
        std::set<uint32>::iterator i = Content->begin();
        for (uint32 j = 0; j < PageNr * ITEMS_PAGE && i != Content->end(); j++)
            i++;
        return i;
    }
    std::set<uint32>::iterator GetPageEnd(uint32 PageNr)
    {
        std::set<uint32>::iterator i = GetPageStart(PageNr);
        for (uint32 j = 0; j < ITEMS_PAGE && i != Content->end(); j++)
            i++;
        return i;
    }
    uint32 GetPageItem(uint32 PageNr, uint32 RowNr)
    {
        std::set<uint32>::iterator i = GetPageStart(PageNr);
        for (uint32 j = 0; j < RowNr && i != Content->end(); j++)
            i++;
        if (i != Content->end())
            return *i;
        return 0;
    }
private:
    const std::set<uint32> *Content;
};

PersonalInstanceStore *GetPIS(Player *player);
void TeleportToPersonalInstanceMapWithChecks(Player *player, int MapId, bool LoadPersonalSpawns = false);
void FlightToggle(Player *player, bool Enable);
class FollowingPersonalInstanceAssistantNPC : public CreatureScript
{
public:
    FollowingPersonalInstanceAssistantNPC() : CreatureScript("FollowingPersonalInstanceAssistantNPC") { }

    struct FollowingPersonalInstanceAssistantNPCAI : public CreatureAI
    {
        char    IsFlying;
        uint32  SpawnAgainGO;
        FollowingPersonalInstanceAssistantNPCAI(Creature* creature) : CreatureAI(creature)
        {
            IsFlying = 0;
            SpawnAgainGO = 0;
        }
        ~FollowingPersonalInstanceAssistantNPCAI()
        {
        }
        void UpdateAI(uint32 diff) override {}//does nothing unless we say so

        enum GossipMainMenuIds
        {
            MENU_NEW_MAP_LIST,
            MENU_NEW_MAP_TELEPORT_TO,

            MENU_SPAWN_GAMEOBJECT_LIST_PAGES,
            MENU_SPAWN_GAMEOBJECT_PAGE,
            MENU_SPAWN_GAMEOBJECT_ID,

            MENU_SPAWN_CREATURE_LIST_PAGES,
            MENU_SPAWN_CREATURE_PAGE,
            MENU_SPAWN_CREATURE_ID,

            MENU_SELECT_CLOSEST_OBJECT,
            MENU_DELETE_SELECTED_OBJECT,
            MENU_TOGGLE_FLIGHT,
            MENU_TELEPORT_OUT,

            MENU_PLAYER_COMMANDS,
            MENU_PLAYER_SUMMON,
            MENU_PLAYER_SUMMON_ACCEPT,
            MENU_PLAYER_KICK,
            MENU_PLAYER_KICK_ALL,

            MENU_CLOSE
        };

        //construct gossip menu to show to player
        bool GossipHello(Player* Plr)
        {
            if (Plr->GetMap()->GetExtension<int64>(OE_MAP_IS_CUSTOM_INSTANCE) == NULL || *Plr->GetMap()->GetCreateIn64Extension(OE_MAP_IS_CUSTOM_INSTANCE_CREATOR) != (int64)Plr->GetGUID().GetRawValue())
            {
                Plr->BroadcastMessage("Assistant can only be used in personal instance");
                return true;
            }

            ClearGossipMenuFor(Plr);
            Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, "Teleport to other map", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_NEW_MAP_LIST,0).Get(), "", 0);
            Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, "Spawn Gameobject", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_SPAWN_GAMEOBJECT_LIST_PAGES,0).Get(), "", 0);
            if(SpawnAgainGO != 0)
                Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, "Spawn same Gameobject", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_SPAWN_GAMEOBJECT_ID, SpawnAgainGO).Get(), "", 0);
            Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, "Spawn Creature", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_SPAWN_CREATURE_LIST_PAGES,0).Get(), "", 0);
            Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, "Select Gameobject", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_SELECT_CLOSEST_OBJECT, 0).Get(), "", 0);
            Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, "Delete selection", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_DELETE_SELECTED_OBJECT, 0).Get(), "", 0);
            Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, "Toggle flight", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_TOGGLE_FLIGHT, 0).Get(), "", 0);
            Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, "Teleport out", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_TELEPORT_OUT, 0).Get(), "", 0);
            Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, "Player commands", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_PLAYER_COMMANDS, 0).Get(), "", 0);
            //            Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, "Check forum for more info", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_CLOSE).Get(), "", 0);
            SendGossipMenuFor(Plr, 100, me->GetGUID());
            return true;
        }

        void GossipListAvailableMaps(Player* Plr, GossipMenuId &MId)
        {
            ClearGossipMenuFor(Plr);
            PersonalInstanceStore *PIS = GetPIS(Plr);
            for (auto i = PIS->GetAllowedMaps().begin(); i != PIS->GetAllowedMaps().end(); i++)
            {
                uint32 MapId = *i;
                const MapEntry *mt = sMapStore.LookupEntry(MapId);
                if (mt && mt->name[sWorld->GetDefaultDbcLocale()])
                    Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, mt->name[sWorld->GetDefaultDbcLocale()], GOSSIP_SENDER_MAIN, GossipMenuId(MENU_NEW_MAP_TELEPORT_TO, MapId).Get(), "", 0);
            }
            SendGossipMenuFor(Plr, 100, me->GetGUID());
        }

        void GossipTeleportToMap(Player* Plr, GossipMenuId &MId)
        {
            CloseGossipMenuFor(Plr);
            uint32 MapId = MId.GetItemId();
            TeleportToPersonalInstanceMapWithChecks(Plr, MapId, true);
        }

        void GossipListAvailableGOs(Player* Plr, GossipMenuId &MId)
        {
            ClearGossipMenuFor(Plr);
            PersonalInstanceStore *PIS = GetPIS(Plr);
            Paginator Pages(&PIS->GetAllowedGOs());
            uint32 PagesReqired = (uint32)Pages.GetNumberOfPages();
            for (uint32 i = 0; i < PagesReqired; i++)
            {
                char PageName[50];
                sprintf_s(PageName, sizeof(PageName), "Page %d", i);
                Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, PageName, GOSSIP_SENDER_MAIN, GossipMenuId(MENU_SPAWN_GAMEOBJECT_PAGE,i).Get(), "", 0);
            }
            SendGossipMenuFor(Plr, 100, me->GetGUID());
        }

        void GossipListPageAvailableGOs(Player* Plr, GossipMenuId &MId)
        {
            uint32 PageIndex = MId.GetItemId();

            PersonalInstanceStore *PIS = GetPIS(Plr);
            Paginator Pages(&PIS->GetAllowedGOs());
                
            std::set<uint32>::iterator ItemsEnd = Pages.GetPageEnd(PageIndex);
            ClearGossipMenuFor(Plr);
            uint32 UselessCounter = 0;
            for (std::set<uint32>::iterator ItemsStart = Pages.GetPageStart(PageIndex); ItemsStart != ItemsEnd; ItemsStart++)
            {
                uint32 GOId = *ItemsStart;
                const GameObjectTemplate *got = sObjectMgr->GetGameObjectTemplate(GOId);
                if (got)
                    Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, got->name.c_str(), GOSSIP_SENDER_MAIN, GossipMenuId(MENU_SPAWN_GAMEOBJECT_ID, GOId).Get(), "", 0);
                UselessCounter++;
            }
            SendGossipMenuFor(Plr, 100, me->GetGUID());
        }

        void GossipSpawnFromListGOs(Player* Plr, GossipMenuId &MId)
        {
            CloseGossipMenuFor(Plr);
            uint32 GOId = MId.GetItemId();
            PersonalInstanceStore *PIS = GetPIS(Plr);
            Object *ret = PIS->SpawnGameObject(Plr, GOId, &Plr->GetPosition(), false);
            // in case we wish to delete it ...
            if(ret)
                Plr->SetSelection(ret->GetGUID());
            SpawnAgainGO = GOId;
        }

        void GossipListAvailableCreatures(Player* Plr, GossipMenuId &MId)
        {
                ClearGossipMenuFor(Plr);
                PersonalInstanceStore *PIS = GetPIS(Plr);
                Paginator Pages(&PIS->GetAllowedCreatures());
                uint32 PagesReqired = (uint32)Pages.GetNumberOfPages();
                for (uint32 i = 0; i < PagesReqired; i++)
                {
                    char PageName[50];
                    sprintf_s(PageName, sizeof(PageName), "Page %d", i);
                    Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, PageName, GOSSIP_SENDER_MAIN, GossipMenuId(MENU_SPAWN_CREATURE_PAGE,i).Get(), "", 0);
                }
                SendGossipMenuFor(Plr, 100, me->GetGUID());
        }

        void GossipListPageAvailableCreatures(Player* Plr, GossipMenuId &MId)
        {
            uint32 PageIndex = MId.GetItemId();

            PersonalInstanceStore *PIS = GetPIS(Plr);
            Paginator Pages(&PIS->GetAllowedCreatures());

            std::set<uint32>::iterator ItemsEnd = Pages.GetPageEnd(PageIndex);
            ClearGossipMenuFor(Plr);
            uint32 UselessCounter = 0;
            for (std::set<uint32>::iterator ItemsStart = Pages.GetPageStart(PageIndex); ItemsStart != ItemsEnd; ItemsStart++)
            {
                uint32 GOId = *ItemsStart;
                const CreatureTemplate *got = sObjectMgr->GetCreatureTemplate(GOId);
                if (got)
                    Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, got->Name.c_str(), GOSSIP_SENDER_MAIN, GossipMenuId(MENU_SPAWN_CREATURE_ID, GOId).Get(), "", 0);
                UselessCounter++;
            }
            SendGossipMenuFor(Plr, 100, me->GetGUID());
        }

        void GossipSpawnFromListCreature(Player* Plr, GossipMenuId &MId)
        {
            CloseGossipMenuFor(Plr);
            uint32 GOId = MId.GetItemId();
            PersonalInstanceStore *PIS = GetPIS(Plr);
            PIS->SpawnCreature(Plr, GOId, &Plr->GetPosition(), false);
        }

        void GossipSelectGameObject(Player* Plr, GossipMenuId &MId)
        {
            GameObject* obj = nullptr;
            Trinity::NearestGameObjectCheck check(*Plr);
            Trinity::GameObjectLastSearcher<Trinity::NearestGameObjectCheck> searcher(Plr, obj, check);
            Cell::VisitGridObjects(Plr, searcher, SIZE_OF_GRIDS);
            if (obj == NULL)
            {
                Plr->BroadcastMessage("No nearby object to select");
                return;
            }

            //make the player select this gameobject
            Plr->SetSelection(obj->GetGUID());

            //show the player some quick info about the selected object to make sure he selected what he wanted
            GameObjectTemplate const* gameObjectInfo = obj->GetGOInfo();
            if (!gameObjectInfo)
            {
                printf("The impossible happened. Found a spawned GO without a template\n");
                return;
            }
            Plr->BroadcastMessage("Selected:%s, Entry:%d, Display:%d, Type:%d", gameObjectInfo->name.c_str(), gameObjectInfo->entry, gameObjectInfo->displayId, gameObjectInfo->type);
            CloseGossipMenuFor(Plr);
        }

        void GossipDeleteObject(Player* Plr, GossipMenuId &MId)
        {
            GameObject *obj = Plr->GetMap()->GetGameObject(Plr->GetTarget());
            if (obj == NULL)
            {
                Plr->BroadcastMessage("You need to select an object first. Maybe use : #csMyInstanceSelectGameObject ?");
                return;
            }
            //spawn the creature and add it to DB
            PersonalInstanceStore *pi = GetPIS(Plr);
            pi->DeleteGameObject(Plr, obj);
        }

        void GossipDeleteCreature(Player* Plr, GossipMenuId &MId)
        {
            Creature *obj = Plr->GetMap()->GetCreature(Plr->GetTarget());
            if (obj == NULL)
            {
                Plr->BroadcastMessage("You need to select a creature first");
                return;
            }
            //spawn the creature and add it to DB
            PersonalInstanceStore *pi = GetPIS(Plr);
            pi->DeleteCreature(Plr, obj);
        }

        //when player clicks on a gossip menu, we call the callback function
        bool GossipSelect(Player* Plr, uint32 menuId, uint32 gossipListId)
        {
            return GossipSelectCode(Plr, menuId, gossipListId, NULL);
        }

        bool GossipSelectCode(Player* Plr, uint32 menuId, uint32 gossipListId, char const* code)override
        {
            uint32 const IntId = Plr->PlayerTalkClass->GetGossipOptionAction(gossipListId);
            GossipMenuId MId(IntId);

            switch (MId.GetMenuid())
            {
            case MENU_NEW_MAP_LIST: GossipListAvailableMaps(Plr, MId); break;
            case MENU_NEW_MAP_TELEPORT_TO: GossipTeleportToMap(Plr, MId); break;
            case MENU_SPAWN_GAMEOBJECT_LIST_PAGES: GossipListAvailableGOs(Plr, MId); break;
            case MENU_SPAWN_GAMEOBJECT_PAGE: GossipListPageAvailableGOs(Plr, MId); break;
            case MENU_SPAWN_GAMEOBJECT_ID: GossipSpawnFromListGOs(Plr, MId); break;
            case MENU_SPAWN_CREATURE_LIST_PAGES: GossipListAvailableCreatures(Plr, MId); break;
            case MENU_SPAWN_CREATURE_PAGE: GossipListPageAvailableCreatures(Plr, MId); break;
            case MENU_SPAWN_CREATURE_ID: GossipSpawnFromListCreature(Plr, MId); break;
            case MENU_SELECT_CLOSEST_OBJECT: GossipSelectGameObject(Plr, MId); break;
            case MENU_DELETE_SELECTED_OBJECT:
            {
                GameObject * obj = Plr->GetMap()->GetGameObject(Plr->GetTarget());
                if (obj)
                    GossipDeleteObject(Plr, MId);
                else
                    GossipDeleteCreature(Plr, MId);
                CloseGossipMenuFor(Plr);
            }break;
            case MENU_TOGGLE_FLIGHT:
                IsFlying = 1 - IsFlying;
                FlightToggle(Plr, IsFlying);
                CloseGossipMenuFor(Plr);
                break;
            case MENU_TELEPORT_OUT:
            {
                PersonalInstanceStore *PIS = GetPIS(Plr);
                Plr->TeleportTo(PIS->GetEntrancePoint());
            }break;
            case MENU_PLAYER_COMMANDS:
            {
                ClearGossipMenuFor(Plr);
                Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, "Summon player", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_PLAYER_SUMMON, 0).Get(), "", 0, true);
                Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, "Kick player", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_PLAYER_KICK, 0).Get(), "", 0, true);
                Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, "Kick all players", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_PLAYER_KICK_ALL, 0).Get(), "", 0);
                SendGossipMenuFor(Plr, 100, me->GetGUID());
            }break;
            case MENU_PLAYER_SUMMON:
            {
                PersonalInstanceSummonPlayer(Plr, code);
                CloseGossipMenuFor(Plr);
            }break;
            case MENU_PLAYER_KICK:
            {
                PersonalInstanceKickPlayer(Plr, code);
                CloseGossipMenuFor(Plr);
            }break;
            case MENU_PLAYER_KICK_ALL:
            {
                PersonalInstanceKickAllPlayers(Plr);
                CloseGossipMenuFor(Plr);
            }break;
            default:
                CloseGossipMenuFor(Plr);
                break;
            }
            return true;
        }
    };
    CreatureAI* GetAI(Creature* creature) const override
    {
        return new FollowingPersonalInstanceAssistantNPCAI(creature);
    }
};

void InitFollowingAssistant()
{
    new FollowingPersonalInstanceAssistantNPC();
}
