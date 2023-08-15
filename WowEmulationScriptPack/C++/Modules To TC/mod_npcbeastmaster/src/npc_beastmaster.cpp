/*

# BeastMaster NPC #

#### A module for AzerothCore by [StygianTheBest](https://github.com/StygianTheBest/AzerothCore-Content/tree/master/Modules)
------------------------------------------------------------------------------------------------------------------


### Description ###
------------------------------------------------------------------------------------------------------------------
WhiteFang is a Beastmaster NPC that howls! This NPC allows any player, or only Hunters, to adopt and use pets. He
also teaches the player specific Hunter skills for use with their pets. A player can adopt normal or exotic pets
depending on how you've configured the NPC. For each pet I use a model for a rare creature of the same type, so
they all look cool. He also sells a great selection of pet food for every level of pet. Hunters can access the
stables as well. This has been a lot of fun for players on my server, and pets work great and just like they do
on a Hunter in or out of dungeons.


### Features ###
------------------------------------------------------------------------------------------------------------------
- Adds a Worgen BeastMaster NPC with sounds/emotes
- Allows all classes, or Hunters only, to adopt new pets
- Teaches Normal and Exotic Pets
- Allows Exotic Beast acquisition with or without spec
- Teaches Hunter abilities to the player
- Sells pet food For all pet levels
- Pet scale is configurable


### To-Do ###
------------------------------------------------------------------------------------------------------------------
- If possible, create working stable for non-Hunter player
- Fix pet spells disappearing from pet bar on relog/dismiss (Note: they persist if added back)

### Data ###
------------------------------------------------------------------------------------------------------------------
- Type: NPC
- Script: BeastMaster
- Config: Yes
    - Enable Module Announce
    - Enable For Hunter Only
    - Enable Exotic Pet Adoption Without Spec (Teaches Beast Mastery)
    - Set Pet Scaling Factor
- SQL: Yes
    - NPC ID: 601026


### Version ###
------------------------------------------------------------------------------------------------------------------
- v2017.09.03 - Release
- v2017.09.04 - Fixed Spirit Beast persistence (teaches Beast Mastery to player)
- v2017.09.08 - Created new Pet Food item list for all pet levels
- v2017.09.11
    - Added Exotic Pet: Spirit Bear
    - Added Pet: Warp Stalker
    - Added Pet: Wind Serpent
    - Added Pet: Nether Ray
    - Added Pet: Spore Bat
    - Updated pet models to rare spawn models
- v2017.09.13 - Teaches additional hunter spells (Eagle Eye, Eyes of the Beast, Beast Lore)
- v2017.09.30 - Add pet->InitLevelupSpellsForLevel(); recommended by Alistar


### Credits ###
------------------------------------------------------------------------------------------------------------------
- [Blizzard Entertainment](http://blizzard.com)
- [TrinityCore](https://github.com/TrinityCore/TrinityCore/blob/3.3.5/THANKS)
- [SunwellCore](http://www.azerothcore.org/pages/sunwell.pl/)
- [AzerothCore](https://github.com/AzerothCore/azerothcore-wotlk/graphs/contributors)
- [AzerothCore Discord](https://discord.gg/gkt4y2x)
- [EMUDevs](https://youtube.com/user/EmuDevs)
- [AC-Web](http://ac-web.org/)
- [ModCraft.io](http://modcraft.io/)
- [OwnedCore](http://ownedcore.com/)
- [OregonCore](https://wiki.oregon-core.net/)
- [Wowhead.com](http://wowhead.com)
- [AoWoW](https://wotlk.evowow.com/)


### License ###
------------------------------------------------------------------------------------------------------------------
- This code and content is released under the [GNU AGPL v3](https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3).

*/

#include "Pet.h"
#include "ObjectMgr.h"
#include "Chat.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "Player.h"
#include "WorldSession.h"
#include "CreatureAI.h"
#include "Config.h"

class BeastMasterAnnounce : public PlayerScript
{

public:

    BeastMasterAnnounce() : PlayerScript("BeastMasterAnnounce") {}

    void OnLogin(Player* player, bool firstLogin)
    {
        if (firstLogin) {
            // Announce Module
            if (sConfigMgr->GetBoolDefault("BeastMasterNPC.Announce", true))
            {
                ChatHandler(player->GetSession()).SendSysMessage("This server is running the |cff4CFF00BeastMasterNPC |rmodule");
            }
        }
    }
};

class BeastMaster : public CreatureScript
{

public:

    BeastMaster() : CreatureScript("BeastMaster") { }
    // Passive Emotes
    struct NPC_PassiveAI : public ScriptedAI
    {
        NPC_PassiveAI(Creature* creature) : ScriptedAI(creature) { }
        void CreatePet(Player* player, Creature* m_creature, uint32 entry) {

            // Get Pet Scale from config
            const float PetScale = sConfigMgr->GetFloatDefault("BeastMaster.PetScale", 1.0);

            // If enabled for Hunters only..
            if (sConfigMgr->GetBoolDefault("BeastMaster.HunterOnly", true))
            {
                if (player->GetClass() != CLASS_HUNTER)
                {
                    me->Whisper("Silly fool, Pets are for Hunters!", LANG_UNIVERSAL, player);
                    me->HandleEmoteCommand(EMOTE_ONESHOT_LAUGH);
                    CloseGossipMenuFor(player);
                    return;
                }
            }

            if (player->GetPet()) {
                m_creature->Whisper("First you must abandon or stable your current pet!", LANG_UNIVERSAL, player, false);;
                player->PlayerTalkClass->SendCloseGossip();
                return;
            }

            Creature* creatureTarget = m_creature->SummonCreature(entry, player->GetPositionX(), player->GetPositionY() + 2, player->GetPositionZ(), player->GetOrientation(), TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5min);
            if (!creatureTarget) return;

            Pet* pet = player->CreateTamedPetFrom(creatureTarget, 0);
            if (!pet)
                return;

            // kill original creature
            creatureTarget->setDeathState(JUST_DIED);
            creatureTarget->RemoveCorpse();
            creatureTarget->SetHealth(0);                       // just for nice GM-mode view

            pet->SetPower(POWER_HAPPINESS, 1048000);

            //pet->SetUInt32Value(UNIT_FIELD_PETEXPERIENCE,0);
            //pet->SetUInt32Value(UNIT_FIELD_PETNEXTLEVELEXP, uint32((Trinity::XP::xp_to_level(70))/4));

            // prepare visual effect for levelup
            pet->SetUInt32Value(UNIT_FIELD_LEVEL, player->GetLevel() - 1);
            pet->GetMap()->AddToMap(pet->ToCreature());

            // visual effect for levelup
            pet->SetUInt32Value(UNIT_FIELD_LEVEL, player->GetLevel());


            if (!pet->InitStatsForLevel(player->GetLevel()))
                // sLog->outError("Pet Create fail: no init stats for entry %u", entry);

                pet->UpdateAllStats();

            // caster have pet now
            player->SetMinion(pet, true);

            pet->SavePetToDB(PET_SAVE_AS_CURRENT);
            pet->InitTalentForLevel();
            player->PetSpellInitialize();

            // Learn Hunter Abilities
            // Assume player has already learned the spells if they have Eagle Eye
            if (!player->HasSpell(6197))
            {
                // player->learnSpell(13481);	// Tame Beast - Not working for non-hunter classes
                player->LearnSpell(883, true);	// Call Pet
                player->LearnSpell(982, true);	// Revive Pet
                player->LearnSpell(264, true);	// Dismiss Pet
                player->LearnSpell(6991, true);	// Feed Pet
                player->LearnSpell(33976, true);	// Mend Pet	
                player->LearnSpell(1002, true);	// Eyes of the Beast
                player->LearnSpell(1462, true);	// Beast Lore
                player->LearnSpell(6197, true);	// Eagle Eye
            }

            // Farewell
            std::ostringstream messageAdopt;
            messageAdopt << "A fine choice " << player->GetName() << "! Your " << pet->GetName() << " shall know no law but that of the club and fang.";
            m_creature->Whisper(messageAdopt.str().c_str(), LANG_UNIVERSAL, player);
            CloseGossipMenuFor(player);
            m_creature->HandleEmoteCommand(EMOTE_ONESHOT_POINT);
        }

        bool OnGossipHello(Player* player)
        {
            // Howl
            me->HandleEmoteCommand(EMOTE_ONESHOT_ROAR);

            // If enabled for Hunters only..
            if (sConfigMgr->GetBoolDefault("BeastMaster.HunterOnly", true))
            {
                if (player->GetClass() != CLASS_HUNTER)
                {
                    me->Whisper("Silly fool, Pets are for Hunters!", LANG_UNIVERSAL, player);
                    me->HandleEmoteCommand(EMOTE_ONESHOT_LAUGH);
                    CloseGossipMenuFor(player);
                    return false;
                }
            }

            // MAIN MENU
            AddGossipItemFor(player, GOSSIP_ICON_BATTLE, "Browse Pets", GOSSIP_SENDER_MAIN, 51);
            AddGossipItemFor(player, GOSSIP_ICON_BATTLE, "Browse Rare Pets", GOSSIP_SENDER_MAIN, 54);

            // Allow Exotic Pets regardless of spec
            if (sConfigMgr->GetBoolDefault("BeastMaster.ExoticNoSpec", true))
            {
                AddGossipItemFor(player, GOSSIP_ICON_BATTLE, "Browse Exotic Pets", GOSSIP_SENDER_MAIN, 53);
            }
            else
            {
                if (player->CanTameExoticPets())
                {
                    AddGossipItemFor(player, GOSSIP_ICON_BATTLE, "Browse Exotic Pets", GOSSIP_SENDER_MAIN, 53);
                }
            }

            // Stables for hunters only - Doesn't seem to work for other classes
            if (player->GetClass() == CLASS_HUNTER)
            {
                AddGossipItemFor(player, GOSSIP_ICON_TAXI, "Visit Stable", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_STABLEPET);
            }

            // Pet Food Vendor
            AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Buy Pet Food", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_VENDOR);
            SendGossipMenuFor(player, 601026, me);

            // Howl/Roar
            player->PlayDirectSound(9036);
            me->HandleEmoteCommand(EMOTE_ONESHOT_ROAR);

            return true;
        }

        bool OnGossipSelect(Player* player, uint32 menuId, uint32 gossipListId)
        {
            uint32 const sender = player->PlayerTalkClass->GetGossipOptionSender(gossipListId);
            uint32 const action = player->PlayerTalkClass->GetGossipOptionAction(gossipListId);

            player->PlayerTalkClass->ClearMenus();

            switch (action)
            {

                // MAIN MENU
            case 50:
                AddGossipItemFor(player, GOSSIP_ICON_BATTLE, "Browse Pets", GOSSIP_SENDER_MAIN, 51);
                AddGossipItemFor(player, GOSSIP_ICON_BATTLE, "Browse Rare Pets", GOSSIP_SENDER_MAIN, 54);

                // Allow Exotics for all players
                if (sConfigMgr->GetBoolDefault("BeastMaster.ExoticNoSpec", true))
                {
                    AddGossipItemFor(player, GOSSIP_ICON_BATTLE, "Browse Exotic Pets", GOSSIP_SENDER_MAIN, 53);
                }
                else
                {
                    // Allow Exotics only for Hunters with Beast Mastery
                    if (player->CanTameExoticPets())
                    {
                        AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Browse Exotic Pets", GOSSIP_SENDER_MAIN, 53);
                    }
                }

                // Stables for hunters only - Doesn't seem to work for other classes
                if (player->GetClass() == CLASS_HUNTER)
                {
                    AddGossipItemFor(player, GOSSIP_ICON_TAXI, "Visit Stable", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_STABLEPET);
                }

                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Buy Pet Food", GOSSIP_SENDER_MAIN, GOSSIP_OPTION_VENDOR);
                SendGossipMenuFor(player, 100001, me);
                break;

                // PETS PAGE 1
            case 51:
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Back..", GOSSIP_SENDER_MAIN, 50);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Next..", GOSSIP_SENDER_MAIN, 52);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Bat", GOSSIP_SENDER_MAIN, 1);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Bear", GOSSIP_SENDER_MAIN, 2);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Boar", GOSSIP_SENDER_MAIN, 300);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Cat", GOSSIP_SENDER_MAIN, 4);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Carrion Bird", GOSSIP_SENDER_MAIN, 5);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Crab", GOSSIP_SENDER_MAIN, 6);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Crocolisk", GOSSIP_SENDER_MAIN, 7);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Dragonhawk", GOSSIP_SENDER_MAIN, 8);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Gorilla", GOSSIP_SENDER_MAIN, 9);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Hound", GOSSIP_SENDER_MAIN, 10);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Hyena", GOSSIP_SENDER_MAIN, 11);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Moth", GOSSIP_SENDER_MAIN, 12);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Nether Ray", GOSSIP_SENDER_MAIN, 13);
                SendGossipMenuFor(player, 100002, me);
                break;

                // PETS PAGE 2
            case 52:
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Back..", GOSSIP_SENDER_MAIN, 50);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Previous..", GOSSIP_SENDER_MAIN, 51);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Owl", GOSSIP_SENDER_MAIN, 140);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Raptor", GOSSIP_SENDER_MAIN, 15);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Ravager", GOSSIP_SENDER_MAIN, 16);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Scorpid", GOSSIP_SENDER_MAIN, 17);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Serpent", GOSSIP_SENDER_MAIN, 18);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Spider", GOSSIP_SENDER_MAIN, 19);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Spore Bat", GOSSIP_SENDER_MAIN, 20);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Tallstrider", GOSSIP_SENDER_MAIN, 21);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Turtle", GOSSIP_SENDER_MAIN, 22);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Warp Stalker", GOSSIP_SENDER_MAIN, 23);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Wasp", GOSSIP_SENDER_MAIN, 24);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Wind Serpent", GOSSIP_SENDER_MAIN, 25);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Wolf", GOSSIP_SENDER_MAIN, 26);
                SendGossipMenuFor(player, 100003, me);
                break;

                // EXOTIC BEASTS
            case 53:

                // Teach Beast Mastery or Spirit Beasts won't work properly
                if (!player->HasSpell(53270))
                {
                    player->LearnSpell(53270, true);
                    std::ostringstream messageLearn;
                    messageLearn << "I have taught you the art of Beast Mastery " << player->GetName() << ".";
                    me->Whisper(messageLearn.str().c_str(), LANG_UNIVERSAL, player);
                }

                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Back..", GOSSIP_SENDER_MAIN, 50);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Chimaera", GOSSIP_SENDER_MAIN, 27);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Core Hound", GOSSIP_SENDER_MAIN, 28);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Devilsaur", GOSSIP_SENDER_MAIN, 79);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Rhino", GOSSIP_SENDER_MAIN, 30);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Silithid", GOSSIP_SENDER_MAIN, 31);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Jormungar Worm", GOSSIP_SENDER_MAIN, 32);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Arcturis (Spirit Bear)", GOSSIP_SENDER_MAIN, 33);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Gondria (Spirit Tiger)", GOSSIP_SENDER_MAIN, 34);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Loque'nahak (Spirit Leopard)", GOSSIP_SENDER_MAIN, 35);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Skoll (Spirit Worg)", GOSSIP_SENDER_MAIN, 36);
                SendGossipMenuFor(player, 100003, me);
                break;

                // RARE PETS
            case 54:
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Back..", GOSSIP_SENDER_MAIN, 50);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Mazzranache (Tallstrider)", GOSSIP_SENDER_MAIN, 37);
                AddGossipItemFor(player, GOSSIP_ICON_MONEY_BAG, "Aotona (Bird)", GOSSIP_SENDER_MAIN, 38);
                SendGossipMenuFor(player, 100004, me);
                break;

                // STABLE
            case GOSSIP_OPTION_STABLEPET:
                player->GetSession()->SendStablePet(me->GetGUID());
                break;

                // VENDOR
            case GOSSIP_OPTION_VENDOR:
                player->GetSession()->SendListInventory(me->GetGUID());
                break;

                // BEASTS
            case 1: // Bat (Shadikith The Glider)
                CreatePet(player, me, 16180);
                break;

            case 2: // Bear (Ursollok)
                CreatePet(player, me, 12037);
                break;

            case 300: // Boar (Armored Brown)
                CreatePet(player, me, 29996);
                break;

            case 4: // Cat (Shadowclaw)
                CreatePet(player, me, 2175);
                break;

            case 5: // Carrion Bird (Zaricotl)
                CreatePet(player, me, 2931);
                break;

            case 6: // Crab (Crusty)
                CreatePet(player, me, 18241);
                break;

            case 7: // Crocolisk (Izod Green)
                CreatePet(player, me, 1417);
                break;

            case 8: // Dragonhawk (Bloodfalcon)
                CreatePet(player, me, 18155);
                break;

            case 9: // Gorilla (King Mukla)
                CreatePet(player, me, 1559);
                break;

            case 10: // Hound (Darkhound - Registers as Wolf Pre-Cata)
                CreatePet(player, me, 29452);
                break;

            case 11: // Hyena (Snort the Heckler)
                CreatePet(player, me, 5829);
                break;

            case 12: // Moth (Aspatha the Broodmother)
                CreatePet(player, me, 25498);
                break;

            case 13: // Nether Ray (Count Ungula)
                CreatePet(player, me, 18285);
                break;

            case 140:  // Owl (Olm the Wise)
                CreatePet(player, me, 14343);
                break;

            case 15: // Raptor (Lar'korwi)
                CreatePet(player, me, 9684);
                break;

            case 16: // Ravager (Rip-blade Ravager)
                CreatePet(player, me, 22123);
                break;

            case 17: // Scorpid (Krellak)
                CreatePet(player, me, 14476);
                break;

            case 18: // Serpent (Emperor Cobra)
                CreatePet(player, me, 28011);
                break;

            case 19: // Spider (Krethis the Shadowspinner)
                CreatePet(player, me, 12433);
                break;

            case 20: // Spore Bat (Sporewing)
                CreatePet(player, me, 18280);
                break;

            case 21: // TallStrider (Green/Purple)
                CreatePet(player, me, 22807);
                break;

            case 22: // Turtle (Cranky Benj)
                CreatePet(player, me, 14223);
                break;

            case 23: // WarpStalker (Gezzarak the Huntress)
                CreatePet(player, me, 23163);
                break;

            case 24: // Wasp (Blacksting)
                CreatePet(player, me, 18283);
                break;

            case 25: // Wind Serpent (Azzere the Skyblade)
                CreatePet(player, me, 5834);
                break;

            case 26: // Wolf (Ghostpaw Alpha)
                CreatePet(player, me, 3825);
                break;

            case 27: // Exotic: Chimaera (Nuramoc)
                CreatePet(player, me, 20932);
                break;

            case 28: // Exotic: Core Hound (Lava/Fire) (21108 - Fel/Fire)
                CreatePet(player, me, 11671);
                break;

            case 29: // Exotic: Devilsaur (King Krush)
                CreatePet(player, me, 32485);
                break;

            case 30: // Rhino (Wooly Rhino Matriarch Brown)
                CreatePet(player, me, 25487);
                break;

            case 31: // Exotic: Silithid (Clutchmother Zavas)
                CreatePet(player, me, 6582);
                break;

            case 32: // Exotic: Worm (Rattlebore)
                CreatePet(player, me, 26360);
                break;

            case 33: // Exotic Spirit: Bear (Arcturis)
                CreatePet(player, me, 38453);
                break;

            case 34: // Exotic Spirit: Night Saber (Gondria)
                CreatePet(player, me, 33776);
                break;

            case 35: // Exotic Spirit: Leopard (Loque'nahak)
                CreatePet(player, me, 32517);
                break;

            case 36: // Exotic Sprit: Worg (Skoll)
                CreatePet(player, me, 35189);
                break;

            case 37: // Rare: Tallstrider (Mazzranache)
                CreatePet(player, me, 3068);
                break;

            case 38: // Rare: Bird of Prey (Aotona)
                CreatePet(player, me, 32481);
                break;
            }

            return true;
        }
    };

    // CREATURE AI
    CreatureAI* GetAI(Creature* creature) const override
    {
        return new NPC_PassiveAI(creature);
    }
};

void AddBeastMasterScripts()
{
    new BeastMasterAnnounce();
    new BeastMaster();
}
