// Race Changer NPC
// Smolderforge 2014-2016

#include "ScriptPCH.h"

#define RACE_CHANGE_TOKEN 385846

bool GossipHello_racechanger(Player *player, Creature *creature)
{
    if (player->HasItemCount(RACE_CHANGE_TOKEN, 1, false) || player->isGameMaster())
    {
        // clear flags in case player closed menu previously, and wants different settings this time
        player->SetFlaggedForRename(false);
        player->SetFlaggedForGenderSwap(false);

        // Check if player is aware and ready to proceed
        player->ADD_GOSSIP_ITEM_EXTENDED(0, "Yes, I am ready to proceed.", GOSSIP_SENDER_MAIN, 40, "Notice: Your professions will be reset and lost by undergoing a race change.", 0, false);

        player->SEND_GOSSIP_MENU(77, creature->GetGUID());
    }
    else if (player->GetTeam() == HORDE && sWorld->getConfig(CONFIG_FREE_ALLY_TRANSFER))
    {
        player->ADD_GOSSIP_ITEM_EXTENDED(0, "Yes, I am ready to proceed.", GOSSIP_SENDER_MAIN, 101, "Notice: Your professions will be reset and lost by undergoing a race change.", 0, false);

        player->SEND_GOSSIP_MENU(85, creature->GetGUID());
    }
    else
        player->SEND_GOSSIP_MENU(78, creature->GetGUID());

    return true;
}

bool GossipSelect_racechanger(Player *player, Creature *creature, uint32 sender, uint32 action)
{
    switch (action)
    {
        case 40:
            // Check if rename is desired from player first
            player->ADD_GOSSIP_ITEM(0, "No, continue with race change.", GOSSIP_SENDER_MAIN, 51);
            player->ADD_GOSSIP_ITEM(0, "Yes, flag me for rename.", GOSSIP_SENDER_MAIN, 50);

            player->SEND_GOSSIP_MENU(79, creature->GetGUID());
            // Perform rename if desired, check for gender swap
            break;
        case 50:
        case 51:
        {
            if (action == 50) // opted for rename
                player->SetFlaggedForRename(true);

            player->ADD_GOSSIP_ITEM(0, "No, continue with race change.", GOSSIP_SENDER_MAIN, 76);
            player->ADD_GOSSIP_ITEM(0, "Yes, swap my gender.", GOSSIP_SENDER_MAIN, 75);

            player->SEND_GOSSIP_MENU(80, creature->GetGUID());
        }
        break;

        // Perform gender swap if needed and question faction switch
        case 75:
        case 76:
        {
            if (action == 75) // opted for gender swap
                player->SetFlaggedForGenderSwap(true);

            player->ADD_GOSSIP_ITEM(0, "Alliance", GOSSIP_SENDER_MAIN, 100);
            player->ADD_GOSSIP_ITEM(0, "Horde",    GOSSIP_SENDER_MAIN, 200);

            player->SEND_GOSSIP_MENU(81, creature->GetGUID());
        }
        break;

        /* To reduce the amount of code by having the pop-up warning on every single
         * selection, the race value is added to 50, then modulated later to produce
         * the correct value. (see default case)
         */
        case 100:
        case 101:
        {
            switch (player->getClass())
            {
                case CLASS_WARRIOR:
                    player->ADD_GOSSIP_ITEM(0, "Human",     GOSSIP_SENDER_MAIN, 1 + 500);
                    player->ADD_GOSSIP_ITEM(0, "Dwarf",     GOSSIP_SENDER_MAIN, 3 + 500);
                    player->ADD_GOSSIP_ITEM(0, "Night Elf", GOSSIP_SENDER_MAIN, 4 + 500);
                    player->ADD_GOSSIP_ITEM(0, "Gnome",     GOSSIP_SENDER_MAIN, 7 + 500);
                    player->ADD_GOSSIP_ITEM(0, "Draenei",   GOSSIP_SENDER_MAIN, 11 + 500);
                    break;
                case CLASS_PALADIN:
                    player->ADD_GOSSIP_ITEM(0, "Human",     GOSSIP_SENDER_MAIN, 1 + 500);
                    player->ADD_GOSSIP_ITEM(0, "Dwarf",     GOSSIP_SENDER_MAIN, 3 + 500);
                    player->ADD_GOSSIP_ITEM(0, "Draenei",   GOSSIP_SENDER_MAIN, 11 + 500);
                    break;
                case CLASS_HUNTER:
                    player->ADD_GOSSIP_ITEM(0, "Dwarf",     GOSSIP_SENDER_MAIN, 3 + 500);
                    player->ADD_GOSSIP_ITEM(0, "Night Elf", GOSSIP_SENDER_MAIN, 4 + 500);
                    player->ADD_GOSSIP_ITEM(0, "Draenei",   GOSSIP_SENDER_MAIN, 11 + 500);
                    break;
                case CLASS_ROGUE:
                    player->ADD_GOSSIP_ITEM(0, "Human",     GOSSIP_SENDER_MAIN, 1 + 500);
                    player->ADD_GOSSIP_ITEM(0, "Dwarf",     GOSSIP_SENDER_MAIN, 3 + 500);
                    player->ADD_GOSSIP_ITEM(0, "Night Elf", GOSSIP_SENDER_MAIN, 4 + 500);
                    player->ADD_GOSSIP_ITEM(0, "Gnome",     GOSSIP_SENDER_MAIN, 7 + 500);
                    break;
                case CLASS_PRIEST:
                    player->ADD_GOSSIP_ITEM(0, "Human",     GOSSIP_SENDER_MAIN, 1 + 500);
                    player->ADD_GOSSIP_ITEM(0, "Dwarf",     GOSSIP_SENDER_MAIN, 3 + 500);
                    player->ADD_GOSSIP_ITEM(0, "Night Elf", GOSSIP_SENDER_MAIN, 4 + 500);
                    player->ADD_GOSSIP_ITEM(0, "Draenei",   GOSSIP_SENDER_MAIN, 11 + 500);
                    break;
                case CLASS_SHAMAN:
                    player->ADD_GOSSIP_ITEM(0, "Draenei",   GOSSIP_SENDER_MAIN, 11 + 500);
                    break;
                case CLASS_MAGE:
                    player->ADD_GOSSIP_ITEM(0, "Human",     GOSSIP_SENDER_MAIN, 1 + 500);
                    player->ADD_GOSSIP_ITEM(0, "Gnome",     GOSSIP_SENDER_MAIN, 7 + 500);
                    player->ADD_GOSSIP_ITEM(0, "Draenei",   GOSSIP_SENDER_MAIN, 11 + 500);
                    break;
                case CLASS_WARLOCK:
                    player->ADD_GOSSIP_ITEM(0, "Human",     GOSSIP_SENDER_MAIN, 1 + 500);
                    player->ADD_GOSSIP_ITEM(0, "Gnome",     GOSSIP_SENDER_MAIN, 7 + 500);
                    break;
                case CLASS_DRUID:
                    player->ADD_GOSSIP_ITEM(0, "Night Elf", GOSSIP_SENDER_MAIN, 4 + 500);
                    break;
            }
            if (action == 100) // do not display if it's a free transfer
                player->ADD_GOSSIP_ITEM(0, "« Back", GOSSIP_SENDER_MAIN, 76);

            player->SEND_GOSSIP_MENU(82, creature->GetGUID());
            break;
        }

        case 200:
        {
            switch (player->getClass())
            {
                case CLASS_WARRIOR:
                    player->ADD_GOSSIP_ITEM(0, "Orc",       GOSSIP_SENDER_MAIN, 2 + 500);
                    player->ADD_GOSSIP_ITEM(0, "Undead",    GOSSIP_SENDER_MAIN, 5 + 500);
                    player->ADD_GOSSIP_ITEM(0, "Tauren",    GOSSIP_SENDER_MAIN, 6 + 500);
                    player->ADD_GOSSIP_ITEM(0, "Troll",     GOSSIP_SENDER_MAIN, 8 + 500);
                    break;
                case CLASS_PALADIN:
                    player->ADD_GOSSIP_ITEM(0, "Blood Elf", GOSSIP_SENDER_MAIN, 10 + 500);
                    break;
                case CLASS_HUNTER:
                    player->ADD_GOSSIP_ITEM(0, "Orc",       GOSSIP_SENDER_MAIN, 2 + 500);
                    player->ADD_GOSSIP_ITEM(0, "Tauren",    GOSSIP_SENDER_MAIN, 6 + 500);
                    player->ADD_GOSSIP_ITEM(0, "Troll",     GOSSIP_SENDER_MAIN, 8 + 500);
                    player->ADD_GOSSIP_ITEM(0, "Blood Elf", GOSSIP_SENDER_MAIN, 10 + 500);
                    break;
                case CLASS_ROGUE:
                    player->ADD_GOSSIP_ITEM(0, "Orc",       GOSSIP_SENDER_MAIN, 2 + 500);
                    player->ADD_GOSSIP_ITEM(0, "Undead",    GOSSIP_SENDER_MAIN, 5 + 500);
                    player->ADD_GOSSIP_ITEM(0, "Troll",     GOSSIP_SENDER_MAIN, 8 + 500);
                    player->ADD_GOSSIP_ITEM(0, "Blood Elf", GOSSIP_SENDER_MAIN, 10 + 500);
                    break;
                case CLASS_PRIEST:
                    player->ADD_GOSSIP_ITEM(0, "Undead",    GOSSIP_SENDER_MAIN, 5 + 500);
                    player->ADD_GOSSIP_ITEM(0, "Troll",     GOSSIP_SENDER_MAIN, 8 + 500);
                    player->ADD_GOSSIP_ITEM(0, "Blood Elf", GOSSIP_SENDER_MAIN, 10 + 500);
                    break;
                case CLASS_SHAMAN:
                    player->ADD_GOSSIP_ITEM(0, "Orc",       GOSSIP_SENDER_MAIN, 2 + 500);
                    player->ADD_GOSSIP_ITEM(0, "Tauren",    GOSSIP_SENDER_MAIN, 6 + 500);
                    player->ADD_GOSSIP_ITEM(0, "Troll",     GOSSIP_SENDER_MAIN, 8 + 500);
                    break;
                case CLASS_MAGE:
                    player->ADD_GOSSIP_ITEM(0, "Undead",    GOSSIP_SENDER_MAIN, 5 + 500);
                    player->ADD_GOSSIP_ITEM(0, "Troll",     GOSSIP_SENDER_MAIN, 8 + 500);
                    player->ADD_GOSSIP_ITEM(0, "Blood Elf", GOSSIP_SENDER_MAIN, 10 + 500);
                    break;
                case CLASS_WARLOCK:
                    player->ADD_GOSSIP_ITEM(0, "Orc",       GOSSIP_SENDER_MAIN, 2 + 500);
                    player->ADD_GOSSIP_ITEM(0, "Undead",    GOSSIP_SENDER_MAIN, 5 + 500);
                    player->ADD_GOSSIP_ITEM(0, "Blood Elf", GOSSIP_SENDER_MAIN, 10 + 500);
                    break;
                case CLASS_DRUID:
                    player->ADD_GOSSIP_ITEM(0, "Tauren",    GOSSIP_SENDER_MAIN, 6 + 500);
                    break;
            }
            player->ADD_GOSSIP_ITEM(0, "« Back", GOSSIP_SENDER_MAIN, 76);

            player->SEND_GOSSIP_MENU(82, creature->GetGUID());
            break;
        }
        default:
            if (action > 11)
            {
                // Display warning, re-invoke selection with mod of 500 to change race. 500 is just arbitrary.
                player->ADD_GOSSIP_ITEM_EXTENDED(1, "[Not shown to player.]", GOSSIP_SENDER_MAIN, action % 500, "You are about to undergo a race change. Your professions will be reset. If you are changing factions, your PvP title will update upon your next kill, and reputations will be converted.", 0, false);
                player->SEND_GOSSIP_MENU(82, creature->GetGUID());
                break;
            }

            if (player->GetIsFlaggedForRename())
                player->SetAtLoginFlag(AT_LOGIN_RENAME);

            if (player->GetIsFlaggedForGenderSwap())
            {
                uint32 displayId = player->GetNativeDisplayId();
                uint32 new_displayId = displayId;
                Gender gender;
                if (player->getGender() == GENDER_FEMALE)
                {
                    new_displayId = player->getRace() == RACE_BLOODELF ? displayId+1 : displayId-1;
                    gender = GENDER_MALE;
                }
                else if (player->getGender() == GENDER_MALE)
                {
                    new_displayId = player->getRace() == RACE_BLOODELF ? displayId-1 : displayId+1;
                    gender = GENDER_FEMALE;
                }

                // Set gender
                player->SetByteValue(UNIT_FIELD_BYTES_0, 2, gender);
                player->SetByteValue(PLAYER_BYTES_3, 0, gender);

                // Change display ID
                player->SetDisplayId(new_displayId);
                player->SetNativeDisplayId(new_displayId);
            }

            player->DestroyItemCount(RACE_CHANGE_TOKEN, 1, true, false);
            std::string IP_str = player->GetSession()->GetRemoteAddress();
            sLog->outChar("Account: %d (IP: %s) Race Change on Character:[%s] (guid: %u) from Race ID %u to %u", player->GetSession()->GetAccountId(), IP_str.c_str(), player->GetName(), player->GetGUIDLow(), action, player->getRace());
            player->ChangeRace(player, action);
            break;
    }

    return true;
}

enum RaceChanger
{
    EVENT_MORPH = 1
};

int modelIds[] = {21869, 21839, 21875, 21844, 21847, 21863}; // 6 length

struct racechangerAI : public Scripted_NoMovementAI
{
    racechangerAI(Creature *c) : Scripted_NoMovementAI(c) {}

    EventMap events;

    void Reset()
    {
        events.Reset();
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IN_COMBAT);
        events.ScheduleEvent(EVENT_MORPH, 1); // initial switch
    }

    void UpdateAI(const uint32 diff)
    {
        events.Update(diff);
        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_MORPH:
                    me->SetDisplayId(modelIds[urand(0, 5)]);
                    events.ScheduleEvent(EVENT_MORPH, 30 * IN_MILLISECONDS); // repeat after 30 sec
                break;
            }
        }
    }
};

CreatureAI* GetAI_racechanger(Creature* creature)
{
    return new racechangerAI(creature);
}

void AddSC_racechanger()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name="racechanger";
    newscript->pGossipHello =  &GossipHello_racechanger;
    newscript->pGossipSelect = &GossipSelect_racechanger;
    newscript->GetAI = &GetAI_racechanger;
    newscript->RegisterSelf();
}
