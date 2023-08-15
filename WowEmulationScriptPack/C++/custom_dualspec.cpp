// Dual Talent Specialization
// Smolderforge 2015

#include "ScriptPCH.h"
#include "beastmaster.h"

bool GossipHello_custom_dualspec(Player *player, Creature *creature)
{
    if (creature->isGossipTrainer()) // check if multi trainer first
    {
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, GOSSIP_TEXT_TRAIN, GOSSIP_SENDER_MAIN, player->getClass());
        
        // morph based on class
        switch (player->getClass())
        {
            case 1: // warrior
                creature->SetDisplayId(24036);
                break;
            case 2: // paladin
                creature->SetDisplayId(24032);
                break;
            case 3: // hunter
                creature->SetDisplayId(24030);
                break;
            case 4: // rogue
                creature->SetDisplayId(23777);
                break;
            case 5: // priest
                creature->SetDisplayId(24033);
                break;
            case 7: // shaman
                creature->SetDisplayId(24034);
                break;
            case 8: // mage
                creature->SetDisplayId(24031);
                break;
            case 9: // warlock
                creature->SetDisplayId(24035);
                break;
            case 11: // druid
                creature->SetDisplayId(24029);
                break;
        }
    }
    else if (creature->isTrainer())
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, GOSSIP_TEXT_TRAIN, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1000);

    if (creature->isCanTrainingAndResetTalentsOf(player) || creature->isGossipTrainer())
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TAXI, "I wish to unlearn my talents", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1001);

    if (player->getClass() == CLASS_HUNTER)
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "Tame a pet!", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);

    uint8 specCount = player->GetSpecsCount();
    if (specCount < MAX_TALENT_SPECS)
    {
        // This fuction add's a menu item,
        // a - Icon Id
        // b - Text
        // c - Sender(this is to identify the current Menu with this item)
        // d - Action (identifys this Menu Item)
        // e - Text to be displayed in pop up box
        // f - Money value in pop up box
        player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_CHAT, "Enable Dual Talent Specialization", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 0, "Are you sure you would like to activate your second specialization? This will allow you to quickly switch between two different talent builds and action bars.", 0, false);
    }
    else
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Change my specialization", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);

    if (creature->isQuestGiver())
        player->PrepareQuestMenu(creature->GetGUID());

    player->SEND_GOSSIP_MENU(94, creature->GetGUID());
    return true;
}

bool GossipSelect_custom_dualspec(Player *player, Creature *creature, uint32 sender, uint32 action)
{
    uint32 trainerEntryId = 0;
    switch (action)
    {
        // multi trainer
        case 1: // warrior
            trainerEntryId = 4087;
            break;
        case 2: // paladin
            trainerEntryId = 5491;
            break;
        case 3: // hunter
            trainerEntryId = 5515;
            break;
        case 4: // rogue
            trainerEntryId = 4584;
            break;
        case 5: // priest
            trainerEntryId = 16658;
            break;
        case 7: // shaman
            trainerEntryId = 3032;
            break;
        case 8: // mage
            trainerEntryId = 3047;
            break;
        case 9: // warlock
            trainerEntryId = 461;
            break;
        case 11: // druid
            trainerEntryId = 9465;
            break;

        // dual spec
        case GOSSIP_ACTION_INFO_DEF + 0:
            player->SetSpecsCount(player->GetSpecsCount() + 1);
            GossipSelect_custom_dualspec(player, creature, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);
            break;
        case GOSSIP_ACTION_INFO_DEF + 1:
        {
            if (player->GetActiveSpec() == 0)
            {
                player->CLOSE_GOSSIP_MENU();
                player->GetSession()->SendNotification("You are already on that spec.");
                GossipSelect_custom_dualspec(player, creature, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);
                break;
            }
            player->ActivateSpec(0);
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 2:
        {
            if (player->GetActiveSpec() == 1)
            {
                player->CLOSE_GOSSIP_MENU();
                player->GetSession()->SendNotification("You are already on that spec.");
                GossipSelect_custom_dualspec(player, creature, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);
                break;
            }
            player->ActivateSpec(1);
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 5: // swap menus & rename
        {
            uint8 specCount = player->GetSpecsCount();
            for (uint8 i = 0; i < specCount; ++i)
            {
                std::stringstream specNameString;
                specNameString << "[Activate] ";
                if (player->GetSpecName(i) == "NULL")
                    specNameString << "Unnamed";
                else
                    specNameString << player->GetSpecName(i);
                if (i == player->GetActiveSpec())
                    specNameString << " (active)";
                else
                    specNameString << "";
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, specNameString.str(), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + (1 + i));
            }

            for (uint8 i = 0; i < specCount; ++i)
            {
                std::stringstream specNameString;
                specNameString << "[Rename] ";
                if (player->GetSpecName(i) == "NULL")
                    specNameString << "Unnamed";
                else
                    specNameString << player->GetSpecName(i);
                if (i == player->GetActiveSpec())
                    specNameString << " (active)";
                else
                    specNameString << "";
                player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_TALK, specNameString.str(), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + (10 + i), "", 0, true);
            }
            player->SEND_GOSSIP_MENU(89, creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 6: // tame pet, switch script
            player->CLOSE_GOSSIP_MENU();
            GossipSelect_beastmaster(player, creature, GOSSIP_SENDER_MAIN, 100);
            break;

        // beastmaster pet cases
        case 5000:
        case 5001:
        case 5002:
        case 5003:
        case 5004:
        case 5005:
        case 5006:
        case 5007:
        case 5008:
        case 5009:
        case 5010:
        case 5011:
        case 5012:
        case 5013:
        case 5014:
        case 5015:
            GossipSelect_beastmaster(player, creature, GOSSIP_SENDER_MAIN, action);
            break;

        case GOSSIP_ACTION_INFO_DEF+1000:
            player->SEND_TRAINERLIST(creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF+1001:
            player->CLOSE_GOSSIP_MENU();
            player->SendTalentWipeConfirm(creature->GetGUID());
            break;
        default:
            sLog->outString("ActionId: %u", action);
            break;
    }

    if (trainerEntryId)
    {
        player->m_currentTrainerEntry = trainerEntryId;
        player->GetSession()->SendTrainerList(creature->GetGUID(), trainerEntryId);
    }

    return true;
}

bool GossipSelectWithCode_custom_dualspec(Player* player, Creature* creature, uint32 sender, uint32 action, const char* sCode)
{
    std::string strCode = sCode;
    CharacterDatabase.EscapeString(strCode);

    if (action == GOSSIP_ACTION_INFO_DEF + 10)
        player->SetSpecName(0, strCode.c_str());
    else if (action == GOSSIP_ACTION_INFO_DEF + 11)
        player->SetSpecName(1, strCode.c_str());

    player->CLOSE_GOSSIP_MENU();
    GossipSelect_custom_dualspec(player, creature, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 5);
    return true;
}

void AddSC_custom_dualspec()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="custom_dualspec";
    newscript->pGossipHello = &GossipHello_custom_dualspec;
    newscript->pGossipSelect = &GossipSelect_custom_dualspec;
    newscript->pGossipSelectWithCode = &GossipSelectWithCode_custom_dualspec;
    newscript->RegisterSelf();
}
