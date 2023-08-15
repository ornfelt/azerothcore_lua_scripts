#include "SharedDefines.h"
#include "ScriptMgr.h"
#include "GameEventCallbacks.h"
#include "ObjectExtension.cpp"
#include "Player.h"
#include "ItemTemplate.h"

#include "AddonCommunication/AddonCommunication.h"

enum DropFilteringTypesEnum
{
    DROP_ONLY_ACTIVE_QUEST_ITEMS   = 1,
    DROP_ONLY_QUEST_ITEMS          = 2,
    DROP_ONLY_EMPTY                = 4,     // can be used to level skinning
    DROP_SKIP_NON_EQUIP            = 8,     // level tailoring
    DROP_SKIP_EQUIP                = 16,    // item hunting
    DROP_SKIP_GRAY                 = 32,
    DROP_SKIP_WHITE                = 64,
    DROP_SKIP_GREEN                = 128,
    DROP_SKIP_BLUE                 = 256,
    DROP_SKIP_EPIC                 = 512,
    DROP_ONLY_CRAFTING             = 1024,      // ITEM_CLASS_REAGENT ITEM_CLASS_RECIPE ITEM_CLASS_GLYPH ITEM_CLASS_TRADE_GOODS
    MAX_VALID_LOOT_FILTER_FLAGS
};

void CheckForQuestOnlyItemDrops(void *p, void *)
{
    CP_LOOT_ROLL_CHANCE *params = PointerCast(CP_LOOT_ROLL_CHANCE, p);
    if (params->LooterPlayer == NULL)
        return;
    int64 *UseDropLimitation = params->LooterPlayer->GetExtension<int64>(OE_PLAYER_QUEST_ONLY_DROPS_STORE);
    if (UseDropLimitation == NULL || *UseDropLimitation == 0)
        return;

    if (*UseDropLimitation & DROP_ONLY_EMPTY)
    {
        *params->chance = 0;
        return;
    }

    if (params->Item == NULL)
        return;

    if (*UseDropLimitation & DROP_ONLY_ACTIVE_QUEST_ITEMS)
    {
        if (params->LooterPlayer->HasQuestForItem(params->Item->ItemId) == false)
            *params->chance = 0;
        return;
    }

    if (*UseDropLimitation & DROP_ONLY_QUEST_ITEMS)
    {
        if (params->LooterPlayer->HasQuestForItem(params->Item->ItemId) == false && params->Item->StartQuest == 0 && params->Item->Class == ITEM_CLASS_QUEST)
            *params->chance = 0;
        return;
    }

    if (*UseDropLimitation & DROP_ONLY_CRAFTING)
    {
        if (params->Item->Class != ITEM_CLASS_REAGENT && params->Item->Class != ITEM_CLASS_RECIPE && params->Item->Class != ITEM_CLASS_GLYPH && params->Item->Class != ITEM_CLASS_TRADE_GOODS)
            *params->chance = 0;
        return;
    }

    if (*UseDropLimitation & DROP_SKIP_NON_EQUIP)
    {
        if (params->Item->InventoryType == InventoryType::INVTYPE_NON_EQUIP)
        {
            *params->chance = 0;
            return;
        }
    }

    if (*UseDropLimitation & DROP_SKIP_EQUIP)
    {
        if (params->Item->InventoryType != InventoryType::INVTYPE_NON_EQUIP)
        {
            *params->chance = 0;
            return;
        }
    }

    if (*UseDropLimitation & DROP_SKIP_GRAY)
    {
        if (params->Item->Quality == ItemQualities::ITEM_QUALITY_POOR)
        {
            *params->chance = 0;
            return;
        }
    }

    if (*UseDropLimitation & DROP_SKIP_WHITE)
    {
        if (params->Item->Quality == ItemQualities::ITEM_QUALITY_NORMAL)
        {
            *params->chance = 0;
            return;
        }
    }

    if (*UseDropLimitation & DROP_SKIP_GREEN)
    {
        if (params->Item->Quality == ItemQualities::ITEM_QUALITY_UNCOMMON)
        {
            *params->chance = 0;
            return;
        }
    }

    if (*UseDropLimitation & DROP_SKIP_BLUE)
    {
        if (params->Item->Quality == ItemQualities::ITEM_QUALITY_RARE)
        {
            *params->chance = 0;
            return;
        }
    }

    if (*UseDropLimitation & DROP_SKIP_EPIC)
    {
        if (params->Item->Quality == ItemQualities::ITEM_QUALITY_EPIC)
        {
            *params->chance = 0;
            return;
        }
    }
}

void ToggleLootFiltering(Player *player, int64 Flag, const char *EnableText)
{
    if (Flag < 0 || Flag >= MAX_VALID_LOOT_FILTER_FLAGS)
        return;
    int64 *UseDropLimitation = player->GetCreateIn64Extension(OE_PLAYER_QUEST_ONLY_DROPS_STORE,false,0);
    if (((*UseDropLimitation) & Flag) == 0)
    {
        *UseDropLimitation |= Flag;
        if(EnableText != NULL)
            player->BroadcastMessage(EnableText);
        else
            player->BroadcastMessage("Loot filtering option enabled");
    }
    else
    {
        *UseDropLimitation &= ~Flag;
        player->BroadcastMessage("Loot filtering option disabled");
    }
}

void RBAC_QuestLoot(Player* player, int8 type)
{
    if(type == 0)
        ToggleLootFiltering(player, DROP_ONLY_QUEST_ITEMS, "You will only receive quest related items");
    else if(type == 1)
        ToggleLootFiltering(player, DROP_ONLY_EMPTY, "You will not receive loot");
    else if (type == 2)
        ToggleLootFiltering(player, DROP_SKIP_NON_EQUIP, "You will not receive non equip loot");
    else if (type == 3)
        ToggleLootFiltering(player, DROP_SKIP_EQUIP, "You will not receive equip loot");
    else if (type == 4)
        ToggleLootFiltering(player, DROP_SKIP_GRAY,  "You will not receive gray item loot");
    else if (type == 5)
        ToggleLootFiltering(player, DROP_SKIP_WHITE, "You will not receive white item loot");
    else if (type == 6)
        ToggleLootFiltering(player, DROP_SKIP_GREEN, "You will not receive green item loot");
    else if (type == 7)
        ToggleLootFiltering(player, DROP_SKIP_BLUE, "You will not receive blue item loot");
    else if (type == 8)
        ToggleLootFiltering(player, DROP_SKIP_EPIC, "You will not receive purple item loot");
    else if (type == 9)
        ToggleLootFiltering(player, DROP_ONLY_CRAFTING, "You will only receive crafting related item loot");
}

bool CheckValidClientCommand(const char *cmsg, int32 type, const char * channel);
void QLParseClientUserCommand(Player* player, uint32 type, std::string& msg)
{
    if (CheckValidClientCommand(msg.c_str(), type, NULL) == false)
    {
        return;
    }

    if (strstr(msg.c_str(), "#csQuestOnlyLoots") == msg.c_str())
    {
        ToggleLootFiltering(player, DROP_ONLY_QUEST_ITEMS, "You will only receive quest related items");
    }
    else if(strstr(msg.c_str(), "#csEmptyOnlyLoots") == msg.c_str())
    {
        ToggleLootFiltering(player, DROP_ONLY_EMPTY, "You will not receive loot");
    }
    else if (strstr(msg.c_str(), "#csSkipNonEquipLoots") == msg.c_str())
    {
        ToggleLootFiltering(player, DROP_SKIP_NON_EQUIP, "You will not receive non equip loot");
    }
    else if (strstr(msg.c_str(), "#csSkipEquipLoots") == msg.c_str())
    {
        ToggleLootFiltering(player, DROP_SKIP_EQUIP, "You will not receive equip loot");
    }
    else if (strstr(msg.c_str(), "#csSkipGrayLoots") == msg.c_str())
    {
        ToggleLootFiltering(player, DROP_SKIP_GRAY, "You will not receive gray item loot");
    }
    else if (strstr(msg.c_str(), "#csSkipWhiteLoots") == msg.c_str())
    {
        ToggleLootFiltering(player, DROP_SKIP_WHITE, "You will not receive white item loot");
    }
    else if (strstr(msg.c_str(), "#csSkipGreenLoots") == msg.c_str())
    {
        ToggleLootFiltering(player, DROP_SKIP_GREEN, "You will not receive green item loot");
    }
    else if (strstr(msg.c_str(), "#csSkipBlueLoots") == msg.c_str())
    {
        ToggleLootFiltering(player, DROP_SKIP_BLUE, "You will not receive blue item loot");
    }
    else if (strstr(msg.c_str(), "#csSkipPurpleLoots") == msg.c_str())
    {
        ToggleLootFiltering(player, DROP_SKIP_EPIC, "You will not receive purple item loot");
    }
    else if (strstr(msg.c_str(), "#csOnlyCraftingLoots") == msg.c_str())
    {
        ToggleLootFiltering(player, DROP_ONLY_CRAFTING, "You will only receive crafting related item loot");
    }
}

void QLOnChatMessageReceived(void *p, void *)
{
    CP_CHAT_RECEIVED *params = PointerCast(CP_CHAT_RECEIVED, p);

    //check for strings that might be our commands
    QLParseClientUserCommand(params->SenderPlayer, params->MsgType, *params->Msg);
}

void QeryLootFilteringStatus(Player *PacketSender)
{
    int64 *UseDropLimitation = PacketSender->GetCreateIn64Extension(OE_PLAYER_QUEST_ONLY_DROPS_STORE, false, 0);
    char repl[500];
    sprintf_s(repl, sizeof(repl), "%d", (uint32)*UseDropLimitation);
    AddonComm::SendMessageToClient(PacketSender, "QLF ", repl);
}

void OnLootFilteringClientMessage(Player *PacketSender, const char *msg)
{
    int ActionType = -1;
    sscanf(msg, "%d", &ActionType);
    if (ActionType == 0)
        QeryLootFilteringStatus(PacketSender);
    else if (ActionType == 1)
    {
        int FilterIndex = -1;
        sscanf(msg, "%d %d", &ActionType, &FilterIndex);
        ToggleLootFiltering(PacketSender, ((int64)1<<(int64)FilterIndex), NULL);
    }
}

void AddQuestOnlyLootScripts()
{
    RegisterCallbackFunction(CALLBACK_TYPE_LOOT_ITEM_ROOL, CheckForQuestOnlyItemDrops, NULL);
    RegisterCallbackFunction(CALLBACK_TYPE_CHAT_RECEIVED, QLOnChatMessageReceived, NULL);
    AddonComm::RegisterOpcodeHandler("QLFS", OnLootFilteringClientMessage);
}
