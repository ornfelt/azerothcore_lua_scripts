// Beastmaster NPC
// Smolderforge 2013-2015

#include "beastmaster.h"
#include "ScriptPCH.h"
#include "ScriptedGossip.h"

void CreatePet(Player* player, Creature* creature, uint32 entry)
{
    if (player->GetPet())
    {
        player->GetSession()->SendNotification("You already have a pet!");
        player->CLOSE_GOSSIP_MENU();
        return;
    }

    Creature *creatureTarget = creature->SummonCreature(entry, player->GetPositionX(), player->GetPositionY() + 2, player->GetPositionZ(), player->GetOrientation(), TEMPSUMMON_CORPSE_TIMED_DESPAWN, 500);
    if (!creatureTarget)
        return;

    Pet* pet = player->CreateTamedPetFrom(creatureTarget, 0);
    if (!pet)
        return;
 
    // kill original creature
    creatureTarget->setDeathState(JUST_DIED);
    creatureTarget->RemoveCorpse();
    creatureTarget->SetHealth(0);
 
    pet->SetPower(POWER_HAPPINESS, 1048000);
    pet->SetTP(350);

    // prepare visual effect for levelup
    pet->SetUInt32Value(UNIT_FIELD_LEVEL, player->getLevel() - 1);
    pet->GetMap()->Add(pet->ToCreature());
    // visual effect for levelup
    pet->SetUInt32Value(UNIT_FIELD_LEVEL, player->getLevel());

    if (!pet->InitStatsForLevel(player->getLevel()))
        sLog->outError("Pet Create fail: No init stats for pet with entry %u", entry);

    pet->UpdateAllStats();
    player->SetMinion(pet, true);
    pet->SavePetToDB(PET_SAVE_AS_CURRENT);
    player->PetSpellInitialize();

    // make sure player has all training spells
    player->learnSpell(27348); // bite
    player->learnSpell(28343); // charge
    player->learnSpell(27347); // claw
    player->learnSpell(27346); // cower
    player->learnSpell(23112); // dash
    player->learnSpell(23150); // dive
    player->learnSpell(35324); // fire breath
    player->learnSpell(24599); // furious howl
    player->learnSpell(35308); // gore
    player->learnSpell(25017); // lightning breath
    player->learnSpell(35391); // poison spit
    player->learnSpell(24455); // prowl
    player->learnSpell(27361); // scorpid poison
    player->learnSpell(27349); // screech
    player->learnSpell(26065); // spell shield
    player->learnSpell(27366); // thunderstomp
    player->learnSpell(35348); // warp
    player->learnSpell(27350); // arcane res
    player->learnSpell(27353); // shadow res
    player->learnSpell(27351); // fire res
    player->learnSpell(27352); // frost res
    player->learnSpell(27354); // nature res
    player->learnSpell(27362); // natural armor
    player->learnSpell(27364); // great stamina
    player->learnSpell(35700); // avoidance
    player->learnSpell(25077); // cobra reflexes

    player->CLOSE_GOSSIP_MENU();
    player->GetSession()->SendAreaTriggerMessage("Pet tamed successfully.");
}

bool GossipHello_beastmaster(Player* player, Creature* creature)
{
    if (creature->isTrainer())
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TRAINER, GOSSIP_TEXT_TRAIN, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_TRAIN);

    if (creature->isCanTrainingAndResetTalentsOf(player))
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TAXI, "I wish to unlearn my talents", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_UNLEARN);

    if (player->getClass() == CLASS_HUNTER)
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, "Tame a pet!", GOSSIP_SENDER_MAIN, 100);

    if (creature->isQuestGiver())
        player->PrepareQuestMenu(creature->GetGUID());

    player->PlayerTalkClass->SendGossipMenu(1, creature->GetGUID());

    return true;
}

bool GossipSelect_beastmaster(Player* player, Creature* creature, uint32 sender, uint32 action)
{
    switch (action)
    {
        case 100:
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_2, GOSSIP_TEXT_BAT,             GOSSIP_SENDER_MAIN, 5001);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_2, GOSSIP_TEXT_BOAR,            GOSSIP_SENDER_MAIN, 5003);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_2, GOSSIP_TEXT_BIRD,            GOSSIP_SENDER_MAIN, 5002);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_2, GOSSIP_TEXT_CAT,             GOSSIP_SENDER_MAIN, 5004);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_2, GOSSIP_TEXT_DRAGONHAWK,      GOSSIP_SENDER_MAIN, 5005);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_2, GOSSIP_TEXT_GORILLA,         GOSSIP_SENDER_MAIN, 5006);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_2, GOSSIP_TEXT_OWL,             GOSSIP_SENDER_MAIN, 5007);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_2, GOSSIP_TEXT_RAPTOR,          GOSSIP_SENDER_MAIN, 5008);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_2, GOSSIP_TEXT_RAVAGER,         GOSSIP_SENDER_MAIN, 5009);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_2, GOSSIP_TEXT_SCORPID,         GOSSIP_SENDER_MAIN, 5010);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_2, GOSSIP_TEXT_SERPENT,         GOSSIP_SENDER_MAIN, 5011);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_2, GOSSIP_TEXT_TURTLE,          GOSSIP_SENDER_MAIN, 5012);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_2, GOSSIP_TEXT_WARPCHASER,      GOSSIP_SENDER_MAIN, 5013);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_2, GOSSIP_TEXT_W_SERPENT,       GOSSIP_SENDER_MAIN, 5014);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_2, GOSSIP_TEXT_WOLF,            GOSSIP_SENDER_MAIN, 5015);

            // learn players all training spells:
            player->learnSpell(27348); // bite
            player->learnSpell(28343); // charge
            player->learnSpell(27347); // claw
            player->learnSpell(27346); // cower
            player->learnSpell(23112); // dash
            player->learnSpell(23150); // dive
            player->learnSpell(35324); // fire breath
            player->learnSpell(24599); // furious howl
            player->learnSpell(35308); // gore
            player->learnSpell(25017); // lightning breath
            player->learnSpell(35391); // poison spit
            player->learnSpell(24455); // prowl
            player->learnSpell(27361); // scorpid poison
            player->learnSpell(27349); // screech
            player->learnSpell(26065); // spell shield
            player->learnSpell(27366); // thunderstomp
            player->learnSpell(35348); // warp
            player->learnSpell(27350); // arcane res
            player->learnSpell(27353); // shadow res
            player->learnSpell(27351); // fire res
            player->learnSpell(27352); // frost res
            player->learnSpell(27354); // nature res
            player->learnSpell(27362); // natural armor
            player->learnSpell(27364); // great stamina
            player->learnSpell(35700); // avoidance
            player->learnSpell(25077); // cobra reflexes

            player->PlayerTalkClass->SendGossipMenu(70, creature->GetGUID());
            break;
        case 5001:
            CreatePet(player, creature, PET_BAT);
            player->CLOSE_GOSSIP_MENU();
            break;
        case 5002:
            CreatePet(player, creature, PET_BIRD);
            player->CLOSE_GOSSIP_MENU();
            break;
        case 5003:
            CreatePet(player, creature, PET_BOAR);
            player->CLOSE_GOSSIP_MENU();
            break;
        case 5004:
            CreatePet(player, creature, PET_CAT);
            player->CLOSE_GOSSIP_MENU();
            break;
        case 5005:
            CreatePet(player, creature, PET_DRAGON_HAWK);
            player->CLOSE_GOSSIP_MENU();
            break;
        case 5006:
            CreatePet(player, creature, PET_GORILLA);
            player->CLOSE_GOSSIP_MENU();
            break;
        case 5007:
            CreatePet(player, creature, PET_OWL);
            player->CLOSE_GOSSIP_MENU();
            break;
        case 5008:
            CreatePet(player, creature, PET_RAPTOR);
            player->CLOSE_GOSSIP_MENU();
            break;
        case 5009:
            CreatePet(player, creature, PET_RAVAGER);
            player->CLOSE_GOSSIP_MENU();
            break;
        case 5010:
            CreatePet(player, creature, PET_SCORPID);
            player->CLOSE_GOSSIP_MENU();
            break;
        case 5011:
            CreatePet(player, creature, PET_SERPENT);
            player->CLOSE_GOSSIP_MENU();
            break;
        case 5012:
            CreatePet(player, creature, PET_TURTLE);
            player->CLOSE_GOSSIP_MENU();
            break;
        case 5013:
            CreatePet(player, creature, PET_WARP_CHASER);
            player->CLOSE_GOSSIP_MENU();
            break;
        case 5014:
            CreatePet(player, creature, PET_WIND_SERPENT);
            player->CLOSE_GOSSIP_MENU();
            break;
        case 5015:
            CreatePet(player, creature, PET_WOLF);
            player->CLOSE_GOSSIP_MENU();
            break;

        case GOSSIP_ACTION_TRAIN:
            player->SEND_TRAINERLIST(creature->GetGUID());
            break;
        case GOSSIP_ACTION_UNLEARN:
            player->CLOSE_GOSSIP_MENU();
            player->SendTalentWipeConfirm(creature->GetGUID());
            break;
    }

    return true;
}

void AddSC_beastmaster()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "beastmaster";
    newscript->pGossipHello  = &GossipHello_beastmaster;
    newscript->pGossipSelect = &GossipSelect_beastmaster;
    newscript->RegisterSelf();
}