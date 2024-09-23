/*
- should be able to provide an ingame menu for available
	- transmogs
		- 9 slots ?
	- player morphs
	- mount morphs
	- Companion morphs
	- pet morphs
*/

#include "Player.h"
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
#include "GameEventCallbacks.h"
#include "ScriptSettings/ScriptSettingsAPI.h"
#include "RandomizedItems/RI_PlayerStore.h"
#include "WorldSession.h"
#include "Guild.h"
#include "ParagonLevels/ParagonLevels.h"

void RBAC_XMorph(Player* player, int target, int DisplayId);
void DisableAutoMount(Player *player);
void EnableAutoMount(Player *player);
void GenerateHungerGamesMenuForPlayerWithChecks(Player *Plr, Creature *me);
void GenerateArenaFFAMenuForPlayerWithChecks(Player *Plr, Creature *me);
void TeleportToPersonalInstanceMapWithChecks(Player *player, int MapId, bool LoadPersonalSpawns);
void TogglePlayerQueueArenaFFA(Player *player, uint32 ArenaFFAGUID);
void TogglePlayerQueue(Player *player, uint32 HungerGamesGUID);

namespace CompanionSystem
{
    char const *GetCreatureDisplayName(uint32 DisplayId);
    void LoadPlayerCompanionMorphs(Player *Plr);
    void LoadPlayerPetMorphs(Player *Plr);
    void LoadPlayerMountMorphs(Player *Plr);
    void LoadPlayerPlayerMorphs(Player *Plr);
    void TeleportMemo(Player *p, uint32 Slot, const char *Name);
    void TeleportRecall(Player *p, uint32 Slot);
    const char *TeleportGetName(Player *p, uint32 Slot);
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

#define ITEMS_PAGE  14
#define MAX_PAGES   100  // maybe it's 16 ? what is client limit for gossip menu ?

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

    struct CompanionSystemGossipAI : public CreatureAI
    {
        CompanionSystemGossipAI(Creature* creature) : CreatureAI(creature) {}
        ~CompanionSystemGossipAI() {}
        void UpdateAI(uint32 diff) override {}//does nothing unless we say so

        enum GossipMainMenuIds
        {
            MENU_COMPANION_MORPHS = 1,
            MENU_COMPANION_MORPHS_LIST,
            MENU_COMPANION_MORPHS_APPLY,
            MENU_PET_MORPHS_LIST,
            MENU_PET_MORPHS_APPLY,
            MENU_PLAYER_MORPHS_LIST,
            MENU_PLAYER_MORPHS_APPLY,
            MENU_MOUNT_MORPHS_LIST,
            MENU_MOUNT_MORPHS_APPLY,
            MENU_TRANSMOGS_LIST,
            MENU_TRANSMOGS_APPLY,
            MENU_TELEPORT_LIST,
            MENU_TELEPORT_MEMO,
            MENU_TELEPORT_RECALL,
            MENU_TOGGLE_AUTOMOUNT,
            MENU_INSTANCE_SCALE,
            MENU_QUEUES_LIST,
            MENU_QUEUE_HUNGER_GAMES_LIST,
            MENU_QUEUE_PVPMASSACRE_LIST,
            MENU_TELEPORT_PERSONAL_INSTANCE,
            MENU_TELEPORT_ENDURANCE,
            MENU_MAGIC_DUST,
            MENU_MAGIC_DUST_SHOW_AURAS,
            MENU_MAGIC_DUST_BUY_4H_50PCT,
            MENU_MAGIC_DUST_BUY_4H_50PCT_POWER,
            MENU_MAGIC_DUST_BUY_4H_100PCT,
            MENU_MAGIC_DUST_BUY_4H_100PCT_POWER,
            MENU_MAGIC_DUST_BUY_4H_200PCT,
            MENU_MAGIC_DUST_BUY_4H_200PCT_POWER,
            MENU_MAGIC_DUST_BUY_4H_20PCT_DEF_CHANCE,
            MENU_MAGIC_DUST_BUY_4H_20PCT_ATK_CHANCE,
            MENU_MAGIC_DUST_BUY_4H_20PCT_UTIL_CHANCE,
            MENU_MAGIC_DUST_BUY_4H_N20PCT_DEF_CHANCE,
            MENU_MAGIC_DUST_BUY_4H_N20PCT_ATK_CHANCE,
            MENU_MAGIC_DUST_BUY_4H_N20PCT_UTIL_CHANCE,
            MENU_RI_SHOW_SACRIFICE,
            MENU_RI_RESET_SACRIFICE,
            MENU_SELL_ITEMS,
            MENU_SHOW_BANK,
            MENU_SHOW_GUILD_BANK,
            MENU_SHOW_MAIL,
            MENU_SHOW_PARAGON,
            MENU_BUY_PARAGON_STRENGTH,
            MENU_BUY_PARAGON_AGILITY,
            MENU_BUY_PARAGON_STAMINA,
            MENU_BUY_PARAGON_INTELLECT,
            MENU_BUY_PARAGON_SPIRIT,
            MENU_BUY_PARAGON_MOVE_SPEED,
            MENU_BUY_PARAGON_Haste,
            MENU_BUY_PARAGON_CritChance,
            MENU_BUY_PARAGON_CritValue,
            MENU_BUY_PARAGON_Armor,
            MENU_BUY_PARAGON_Resist,
            MENU_BUY_PARAGON_LifeRegen,
            MENU_BUY_PARAGON_AreaDmg,
            MENU_BUY_PARAGON_LifeSteal,
            MENU_BUY_PARAGON_DustGain,
        };

        //construct gossip menu to show to player
        bool GossipHello(Player* Plr) override
        {
            ClearGossipMenuFor(Plr);
            Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, "Morphs", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_COMPANION_MORPHS, 0).Get(), "", 0);
            Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, "Transmogs", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_TRANSMOGS_LIST, 0).Get(), "", 0);
            Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, "Teleport locations", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_TELEPORT_LIST, 0).Get(), "", 0);
            Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, "Queues", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_QUEUES_LIST, 0).Get(), "", 0);
            char Diffs[100];
            int Diffi = 100;
            if (Plr->GetExtension<int64>(OE_MAP_MOB_DIFFICULTY_SCALER) != NULL)
            {
                Diffi = 100 + (int)*Plr->GetCreateIn64Extension(OE_MAP_MOB_DIFFICULTY_SCALER);
                sprintf_s(Diffs, sizeof(Diffs), "Set Instance Difficulty : %d", Diffi);
            }
            else
                sprintf_s(Diffs, sizeof(Diffs), "Set Instance Difficulty : 100");
            Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, Diffs, GOSSIP_SENDER_MAIN, GossipMenuId(MENU_INSTANCE_SCALE, 0).Get(), "", 0, true);
            if(GetScripVariableInt32(SSV_Player_Automount, (uint32)Plr->GetGUID().GetRawValue(), NULL) == 0)
                Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, "Enable AutoMount", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_TOGGLE_AUTOMOUNT, 0).Get(), "", 0);
            else
                Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, "Disable AutoMount", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_TOGGLE_AUTOMOUNT, 0).Get(), "", 0);
            Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, "Magic Dust Shop", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_MAGIC_DUST, 0).Get(), "", 0);
            Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, "Sell items", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_SELL_ITEMS, 0).Get(), "", 0);
            Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, "Show bank items", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_SHOW_BANK, 0).Get(), "", 0);
            if(Plr->GetGuild() != NULL)
                Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, "Show guild bank items", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_SHOW_GUILD_BANK, 0).Get(), "", 0);
            Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, "Show mailbox", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_SHOW_MAIL, 0).Get(), "", 0);
            if (sWorld->getIntConfig(CONFIG_PARAGON_LEVELS) != 0)
            {
                uint32 Level, UnSpent;
                GetParagonLevelAndPointsUnSpent(Plr, Level, UnSpent);
                sprintf_s(Diffs, sizeof(Diffs), "Spend Paragon points %d - %d", UnSpent, Level);
                Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, Diffs, GOSSIP_SENDER_MAIN, GossipMenuId(MENU_SHOW_PARAGON, 0).Get(), "", 0);
            }
            SendGossipMenuFor(Plr, 100, me->GetGUID());
            return true;
        }

        void GenerateGenericCreatureMenu(Player* Plr, uint32 PageNumber, std::set<uint32> *CreatureDisplayIdSet, uint32 ListType, uint32 ApplyType)
        {
            ClearGossipMenuFor(Plr);
            if (CreatureDisplayIdSet == NULL)
            {
                SendGossipMenuFor(Plr, 100, me->GetGUID());
                return;
            }
            Paginator Pages(CreatureDisplayIdSet);
            std::set<uint32>::iterator ItemsEnd = Pages.GetPageEnd(PageNumber);
            for (std::set<uint32>::iterator ItemsStart = Pages.GetPageStart(PageNumber); ItemsStart != ItemsEnd; ItemsStart++)
            {
                uint32 Id = *ItemsStart;
                const char *IdName = GetCreatureDisplayName(Id);
                Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, IdName, GOSSIP_SENDER_MAIN, GossipMenuId(ApplyType, Id).Get(), "", 0);
            }
            //add "prev" and "next" pages
            if (PageNumber > 0)
                Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_CHAT, "Prev page", GOSSIP_SENDER_MAIN, GossipMenuId(ListType, PageNumber - 1).Get(), "", 0);
            if (PageNumber < Pages.GetNumberOfPages())
                Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_CHAT, "Next page", GOSSIP_SENDER_MAIN, GossipMenuId(ListType, PageNumber + 1).Get(), "", 0);
            SendGossipMenuFor(Plr, 100, me->GetGUID());
        }

        void GossipCompanions(Player* Plr, GossipMenuId &MId)
        {
            uint32 PageNumber = MId.GetItemId();
            //ensure list is never NULL ( still can be empty )
            LoadPlayerCompanionMorphs(Plr);
            //get the list of Ids the player is allowed to use
            std::set<uint32> *CreatureDisplayIdSet = Plr->GetExtension<std::set<uint32>>(OE_PLAYER_COMPANION_MORPS);
            //generate gossip menu for this list
            GenerateGenericCreatureMenu(Plr, MId.GetItemId(), CreatureDisplayIdSet, MENU_COMPANION_MORPHS_LIST, MENU_COMPANION_MORPHS_APPLY);
        }

        void GossipPets(Player* Plr, GossipMenuId &MId)
        {
            uint32 PageNumber = MId.GetItemId();
            //ensure list is never NULL ( still can be empty )
            LoadPlayerPetMorphs(Plr);
            //get the list of Ids the player is allowed to use
            std::set<uint32> *CreatureDisplayIdSet = Plr->GetExtension<std::set<uint32>>(OE_PLAYER_PET_MORPS);
            //generate gossip menu for this list
            GenerateGenericCreatureMenu(Plr, MId.GetItemId(), CreatureDisplayIdSet, MENU_PET_MORPHS_LIST, MENU_PET_MORPHS_APPLY);
        }

        void GossipMounts(Player* Plr, GossipMenuId &MId)
        {
            uint32 PageNumber = MId.GetItemId();
            //ensure list is never NULL ( still can be empty )
            LoadPlayerMountMorphs(Plr);
            //get the list of Ids the player is allowed to use
            std::set<uint32> *CreatureDisplayIdSet = Plr->GetExtension<std::set<uint32>>(OE_PLAYER_MOUNT_MORPS);
            //generate gossip menu for this list
            GenerateGenericCreatureMenu(Plr, MId.GetItemId(), CreatureDisplayIdSet, MENU_MOUNT_MORPHS_LIST, MENU_MOUNT_MORPHS_APPLY);
        }

        void GossipPlayer(Player* Plr, GossipMenuId &MId)
        {
            uint32 PageNumber = MId.GetItemId();
            //ensure list is never NULL ( still can be empty )
            LoadPlayerPlayerMorphs(Plr);
            //get the list of Ids the player is allowed to use
            std::set<uint32> *CreatureDisplayIdSet = Plr->GetExtension<std::set<uint32>>(OE_PLAYER_PLAYER_MORPS);
            //generate gossip menu for this list
            GenerateGenericCreatureMenu(Plr, MId.GetItemId(), CreatureDisplayIdSet, MENU_PLAYER_MORPHS_LIST, MENU_PLAYER_MORPHS_APPLY);
        }

        //when player clicks on a gossip menu, we call the callback function
        bool GossipSelect(Player* Plr, uint32 menuId, uint32 gossipListId) override
        {
            return GossipSelectCode(Plr, menuId, gossipListId, NULL);
        }

        bool GossipSelectCode(Player* Plr, uint32 menuId, uint32 gossipListId, char const* code)override
        {
            uint32 const IntId = Plr->PlayerTalkClass->GetGossipOptionAction(gossipListId);
            GossipMenuId MId(IntId);

            //hunger games should have menu ID starting from 1000. Really depends on Hunger games GUID
            if (MId.GetMenuid() == 0 && MId.GetItemId() >= 10000)
            {
                TogglePlayerQueueArenaFFA(Plr, MId.GetItemId());
                CloseGossipMenuFor(Plr);
                return true;
            }
            else if(MId.GetMenuid() == 0 && MId.GetItemId() >= 1000)
            {
                TogglePlayerQueue(Plr, MId.GetItemId());
                CloseGossipMenuFor(Plr);
                return true;
            }

            switch (MId.GetMenuid())
            {
            case MENU_QUEUES_LIST:
            {
                ClearGossipMenuFor(Plr);
                Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, "Hunger games", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_QUEUE_HUNGER_GAMES_LIST, 0).Get(), "", 0);
                Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, "PVPMassacre", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_QUEUE_PVPMASSACRE_LIST, 0).Get(), "", 0);
                SendGossipMenuFor(Plr, 100, me->GetGUID());
            }break;
            case MENU_QUEUE_HUNGER_GAMES_LIST:
            {
                GenerateHungerGamesMenuForPlayerWithChecks(Plr,me);
            }break;
            case MENU_QUEUE_PVPMASSACRE_LIST:
            {
                GenerateArenaFFAMenuForPlayerWithChecks(Plr, me);
            }break;
            case MENU_INSTANCE_SCALE:
            {
                int Difficulty = atoi(code);
                if (Difficulty > 10 && Difficulty < 1000)
                    *Plr->GetCreateIn64Extension(OE_MAP_MOB_DIFFICULTY_SCALER) = Difficulty - 100;
                else
                    Plr->BroadcastMessage("Instance difficulty can be between 10 and 1000");
                CloseGossipMenuFor(Plr);
            }break;
            case MENU_TOGGLE_AUTOMOUNT:
            {
                if (GetScripVariableInt32(SSV_Player_Automount, (uint32)Plr->GetGUID().GetRawValue(), NULL) == 0)
                    EnableAutoMount(Plr);
                else
                    DisableAutoMount(Plr);
                CloseGossipMenuFor(Plr);
            }break;
            case MENU_COMPANION_MORPHS:
            {
                ClearGossipMenuFor(Plr);
                Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, "Companion morphs", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_COMPANION_MORPHS_LIST, 0).Get(), "", 0);
                Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, "Player morphs", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_PLAYER_MORPHS_LIST, 0).Get(), "", 0);
                Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, "Pet morphs", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_PET_MORPHS_LIST, 0).Get(), "", 0);
                Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, "Mount morphs", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_MOUNT_MORPHS_LIST, 0).Get(), "", 0);
                SendGossipMenuFor(Plr, 100, me->GetGUID());
            }break;
            case MENU_COMPANION_MORPHS_LIST:GossipCompanions(Plr, MId); break;
            case MENU_COMPANION_MORPHS_APPLY:
            {
                RBAC_XMorph(Plr, 2, MId.GetItemId());
                CloseGossipMenuFor(Plr);
            }break;
            case MENU_PET_MORPHS_LIST:GossipPets(Plr, MId); break;
            case MENU_PET_MORPHS_APPLY:
            {
                RBAC_XMorph(Plr, 1, MId.GetItemId());
                CloseGossipMenuFor(Plr);
            }break;
            case MENU_MOUNT_MORPHS_LIST:GossipMounts(Plr, MId); break;
            case MENU_MOUNT_MORPHS_APPLY:
            {
                RBAC_XMorph(Plr, 3, MId.GetItemId());
                CloseGossipMenuFor(Plr);
            }break;
            case MENU_PLAYER_MORPHS_LIST:GossipPlayer(Plr, MId); break;
            case MENU_PLAYER_MORPHS_APPLY:
            {
                RBAC_XMorph(Plr, 0, MId.GetItemId());
                CloseGossipMenuFor(Plr);
            }break;
            case MENU_TELEPORT_LIST:
            {
#define TELPORT_CHECKS                 if (Plr->IsInCombat()) \
                {\
                    Plr->BroadcastMessage("Can't use teleport while in combat");\
                    CloseGossipMenuFor(Plr);\
                    break;\
                }\
                if (Plr->FindMap() == NULL || Plr->GetMap()->IsBattlegroundOrArena())\
                {\
                    Plr->BroadcastMessage("Can't use teleport while in battlegrounds");\
                    CloseGossipMenuFor(Plr);\
                    break;\
                }\
                if (Plr->HasStealthAura())\
                {\
                    Plr->BroadcastMessage("Can't use teleport while stealthed");\
                    CloseGossipMenuFor(Plr);\
                    break;\
                }
                if (Plr->IsFlying())\
                {\
                    Plr->BroadcastMessage("Can't use teleport while flying");\
                    CloseGossipMenuFor(Plr);\
                    break;\
                }
                if (Plr->IsFalling())\
                {\
                    Plr->BroadcastMessage("Can't use teleport while falling"); \
                    CloseGossipMenuFor(Plr); \
                    break; \
                }
                if (Plr->GetMap()->Instanceable())\
                {\
                    Plr->BroadcastMessage("Can't use teleport while in instance"); \
                    CloseGossipMenuFor(Plr); \
                    break; \
                }

                TELPORT_CHECKS
                ClearGossipMenuFor(Plr);
                for (uint32 i = 0; i < 4; i++)
                {
                    Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_CHAT, "Memo", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_TELEPORT_MEMO, i).Get(), "", 0, true);
                    const char *Name = TeleportGetName(Plr, i);
                    if (Name != NULL && Name[0] != 0)
                        Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, Name, GOSSIP_SENDER_MAIN, GossipMenuId(MENU_TELEPORT_RECALL, i).Get(), "", 0);
                }
                Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, "Personal Instance", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_TELEPORT_PERSONAL_INSTANCE,0).Get(), "", 0);
                Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, "Endurance map", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_TELEPORT_ENDURANCE, 0).Get(), "", 0);
                SendGossipMenuFor(Plr, 100, me->GetGUID());
            }break;
            case MENU_TELEPORT_MEMO:
            {
                TELPORT_CHECKS
                TeleportMemo(Plr, MId.GetItemId(), code);
                CloseGossipMenuFor(Plr);
            }break;
            case MENU_TELEPORT_RECALL:
            {
                TELPORT_CHECKS
                TeleportRecall(Plr, MId.GetItemId());
                CloseGossipMenuFor(Plr);
            }break;
            case MENU_TELEPORT_PERSONAL_INSTANCE:
            {
                CloseGossipMenuFor(Plr);
                TeleportToPersonalInstanceMapWithChecks(Plr, 615, true);
            }break;
            case MENU_TELEPORT_ENDURANCE:
            {
                CloseGossipMenuFor(Plr);
                TeleportToPersonalInstanceMapWithChecks(Plr, 565, true);
            }break;
            case MENU_MAGIC_DUST_SHOW_AURAS:
                ShowMagicDustStatus(Plr);
            case MENU_MAGIC_DUST:
            {
                ClearGossipMenuFor(Plr);
                Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_CHAT, "Magic Find Status", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_MAGIC_DUST_SHOW_AURAS, 0).Get(), "", 0);
                Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_CHAT, "Buy 50 MF/4h for 50 dust", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_MAGIC_DUST_BUY_4H_50PCT, 0).Get(), "", 0);
                Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_CHAT, "Buy 50 MFP/4h for 50 dust", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_MAGIC_DUST_BUY_4H_50PCT_POWER, 0).Get(), "", 0);
                Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_CHAT, "Buy 100 MF/4h for 1000 dust", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_MAGIC_DUST_BUY_4H_100PCT, 0).Get(), "", 0);
                Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_CHAT, "Buy 100 MFP/4h for 1000 dust", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_MAGIC_DUST_BUY_4H_100PCT_POWER, 0).Get(), "", 0);
                Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_CHAT, "Buy 200 MF/4h for 50k dust", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_MAGIC_DUST_BUY_4H_200PCT, 0).Get(), "", 0);
                Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_CHAT, "Buy 200 MFP/4h for 50k dust", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_MAGIC_DUST_BUY_4H_200PCT_POWER, 0).Get(), "", 0);
                Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_CHAT, "Buy 20% to Def Roll/4h for 5000 dust", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_MAGIC_DUST_BUY_4H_20PCT_DEF_CHANCE, 0).Get(), "", 0);
                Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_CHAT, "Buy 20% to Atk Roll/4h for 5000 dust", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_MAGIC_DUST_BUY_4H_20PCT_ATK_CHANCE, 0).Get(), "", 0);
                Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_CHAT, "Buy 20% to Util Roll/4h for 5000 dust", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_MAGIC_DUST_BUY_4H_20PCT_UTIL_CHANCE, 0).Get(), "", 0);
                Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_CHAT, "Buy -20% to Def Roll/4h for 5000 dust", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_MAGIC_DUST_BUY_4H_N20PCT_DEF_CHANCE, 0).Get(), "", 0);
                Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_CHAT, "Buy -20% to Atk Roll/4h for 5000 dust", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_MAGIC_DUST_BUY_4H_N20PCT_ATK_CHANCE, 0).Get(), "", 0);
                Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_CHAT, "Buy -20% to Util Roll/4h for 5000 dust", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_MAGIC_DUST_BUY_4H_N20PCT_UTIL_CHANCE, 0).Get(), "", 0);
                Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_CHAT, "Show sacrifice status", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_RI_SHOW_SACRIFICE, 0).Get(), "", 0);
                Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_CHAT, "Reset sacrifice status", GOSSIP_SENDER_MAIN, GossipMenuId(MENU_RI_RESET_SACRIFICE, 0).Get(), "", 0);
                SendGossipMenuFor(Plr, 100, me->GetGUID());
            }break;
            case MENU_MAGIC_DUST_BUY_4H_50PCT:
            {
                BuySRCMBuff(Plr, 50, 50, RI_STTG_MF);
                ShowMagicDustStatus(Plr);
                CloseGossipMenuFor(Plr);
            }break;
            case MENU_MAGIC_DUST_BUY_4H_50PCT_POWER:
            {
                BuySRCMBuff(Plr, 50, 50, RI_STTG_MFP);
                ShowMagicDustStatus(Plr);
                CloseGossipMenuFor(Plr);
            }break;
            case MENU_MAGIC_DUST_BUY_4H_100PCT:
            {
                BuySRCMBuff(Plr, 100, 1000, RI_STTG_MF);
                ShowMagicDustStatus(Plr);
                CloseGossipMenuFor(Plr);
            }break;
            case MENU_MAGIC_DUST_BUY_4H_100PCT_POWER:
            {
                BuySRCMBuff(Plr, 100, 1000, RI_STTG_MFP);
                ShowMagicDustStatus(Plr);
                CloseGossipMenuFor(Plr);
            }break;
            case MENU_MAGIC_DUST_BUY_4H_200PCT:
            {
                BuySRCMBuff(Plr, 200, 50*1000, RI_STTG_MF);
                ShowMagicDustStatus(Plr);
                CloseGossipMenuFor(Plr);
            }break;
            case MENU_MAGIC_DUST_BUY_4H_200PCT_POWER:
            {
                BuySRCMBuff(Plr, 200, 50*1000, RI_STTG_MFP);
                ShowMagicDustStatus(Plr);
                CloseGossipMenuFor(Plr);
            }break;
            case MENU_MAGIC_DUST_BUY_4H_20PCT_DEF_CHANCE:
            {
                BuySRCMBuff(Plr, 20, 5000, RI_STTG_DEFENSE);
                ShowMagicDustStatus(Plr);
                CloseGossipMenuFor(Plr);
            }break;
            case MENU_MAGIC_DUST_BUY_4H_20PCT_ATK_CHANCE:
            {
                BuySRCMBuff(Plr, 20, 5000, RI_STTG_ATTACK);
                ShowMagicDustStatus(Plr);
                CloseGossipMenuFor(Plr);
            }break;
            case MENU_MAGIC_DUST_BUY_4H_20PCT_UTIL_CHANCE:
            {
                BuySRCMBuff(Plr, 20, 5000, RI_STTG_UTIL);
                ShowMagicDustStatus(Plr);
                CloseGossipMenuFor(Plr);
            }break;
            case MENU_MAGIC_DUST_BUY_4H_N20PCT_DEF_CHANCE:
            {
                BuySRCMBuff(Plr, -20, 5000, RI_STTG_DEFENSE);
                ShowMagicDustStatus(Plr);
                CloseGossipMenuFor(Plr);
            }break;
            case MENU_MAGIC_DUST_BUY_4H_N20PCT_ATK_CHANCE:
            {
                BuySRCMBuff(Plr, -20, 5000, RI_STTG_ATTACK);
                ShowMagicDustStatus(Plr);
                CloseGossipMenuFor(Plr);
            }break;
            case MENU_MAGIC_DUST_BUY_4H_N20PCT_UTIL_CHANCE:
            {
                BuySRCMBuff(Plr, -20, 5000, RI_STTG_UTIL);
                ShowMagicDustStatus(Plr);
                CloseGossipMenuFor(Plr);
            }break;
            case MENU_RI_SHOW_SACRIFICE:
            {
                ShowSacrifice(Plr);
                CloseGossipMenuFor(Plr);
            }break;
            case MENU_RI_RESET_SACRIFICE:
            {
                ResetSacrifice(Plr);
                CloseGossipMenuFor(Plr);
            }break;
            case MENU_SELL_ITEMS:
            {
                WorldPacket data(SMSG_LIST_INVENTORY, 8 + 1 + 1);
                data << uint64(me->GetGUID().GetRawValue());
                data << uint8(0);                                   // count == 0, next will be error code
                data << uint8(0);                                   // "Vendor has no inventory"
                Plr->GetSession()->SendPacket(&data);
            }break;
            case MENU_SHOW_BANK:
            {
                Plr->GetSession()->SendShowBank(me->GetGUID());
            }break;
            case MENU_SHOW_GUILD_BANK:
            {
                Guild* const guild = Plr->GetGuild();
                if (guild != NULL)
                    guild->SendBankTabsInfo(Plr->GetSession(), false);
            }break;
            case MENU_SHOW_MAIL:
            {
                Plr->GetSession()->SendShowMailBox(me->GetGUID());
            }break;
            case MENU_BUY_PARAGON_STRENGTH:
            case MENU_BUY_PARAGON_AGILITY:
            case MENU_BUY_PARAGON_STAMINA:
            case MENU_BUY_PARAGON_INTELLECT:
            case MENU_BUY_PARAGON_SPIRIT:
            case MENU_BUY_PARAGON_MOVE_SPEED:
            case MENU_BUY_PARAGON_Haste:
            case MENU_BUY_PARAGON_CritChance:
            case MENU_BUY_PARAGON_CritValue:
            case MENU_BUY_PARAGON_Armor:
            case MENU_BUY_PARAGON_Resist:
            case MENU_BUY_PARAGON_LifeRegen:
            case MENU_BUY_PARAGON_AreaDmg:
            case MENU_BUY_PARAGON_LifeSteal:
            case MENU_BUY_PARAGON_DustGain:
            {
                int Index = MId.GetMenuid() - MENU_BUY_PARAGON_STRENGTH;
                ParagonBuyStat(Plr, Index);
            } // no break, refresh the menu after we bought something
            case MENU_SHOW_PARAGON:
            {
                ClearGossipMenuFor(Plr);
                uint32 PointsInvested;
                char PrintBuffer[50];
                const char *ParagonStatNames[PS_MAX_STAT_TYPES] = { "Strength","Agility","Stamina","Intellect","Spirit","Movement Speed Rating %","Haste rating","Crit Chance Rating","Crit value %","Armor","Resistances","Life regen","Area Damage","Life Steal", "Dust Gain" };
                const uint32 ParagonMenuIds[PS_MAX_STAT_TYPES] = { MENU_BUY_PARAGON_STRENGTH, MENU_BUY_PARAGON_AGILITY,MENU_BUY_PARAGON_STAMINA,MENU_BUY_PARAGON_INTELLECT,MENU_BUY_PARAGON_SPIRIT,MENU_BUY_PARAGON_MOVE_SPEED,MENU_BUY_PARAGON_Haste,MENU_BUY_PARAGON_CritChance,MENU_BUY_PARAGON_CritValue,MENU_BUY_PARAGON_Armor,MENU_BUY_PARAGON_Resist,MENU_BUY_PARAGON_LifeRegen,MENU_BUY_PARAGON_AreaDmg,MENU_BUY_PARAGON_LifeSteal,MENU_BUY_PARAGON_DustGain };
                for (uint32 i = 0; i < PS_MAX_STAT_TYPES; i++)
                {
                    GetParagonStatStatus(Plr, i, PointsInvested);
                    sprintf_s(PrintBuffer, sizeof(PrintBuffer), "Invest in %s : %d", ParagonStatNames[i], PointsInvested);
                    Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, PrintBuffer, GOSSIP_SENDER_MAIN, GossipMenuId(ParagonMenuIds[i], 0).Get(), "", 0);
                }
                SendGossipMenuFor(Plr, 100, me->GetGUID());
            }break;
            default:
                CloseGossipMenuFor(Plr);
                break;
            }
            return true;
        }
    };
};

void CompanionSystemSummonPet(void *p, void *)
{
    CP_CREATURE_INTERRACT *params = PointerCast(CP_CREATURE_INTERRACT, p);
    if (params->player == NULL || params->creature == NULL)
        return;
    if (params->player->GetCritterGUID() != params->creature->GetGUID())
        return;

    params->creature->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
    params->creature->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_VENDOR);
    params->creature->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_BANKER);
    params->creature->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_REPAIR);
    params->creature->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GUILD_BANKER);
    params->creature->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_MAILBOX);
    params->creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);

    CreatureAI *TalkingAI = new CompanionSystem::CompanionSystemGossipAI(params->creature);
    params->creature->SetAI(TalkingAI);
    TalkingAI->EnterEvadeMode();
}

void SetupPersonalTeleportSystem();

void AddFamiliarSystemScripts()
{
    /*
    CREATE TABLE `character_TeleportMemos` (
    `GUID` INT NULL,
    `slot` INT NULL,
    `MapEntry` INT NULL,
    `x` float NULL,
    `y` float NULL,
    `z` float NULL,
    `o` float NULL,
    `LocName` varchar(20) NULL,
    INDEX `Index1` (`GUID`),
    UNIQUE KEY `relation` (`GUID`,`slot`),
    KEY `RowId` (`GUID`) USING BTREE
    )ENGINE=InnoDB;
    */

    RegisterCallbackFunction(CALLBACK_TYPE_PLAYER_SUMMON_MINNION, CompanionSystemSummonPet, NULL);

    SetupPersonalTeleportSystem();
}
