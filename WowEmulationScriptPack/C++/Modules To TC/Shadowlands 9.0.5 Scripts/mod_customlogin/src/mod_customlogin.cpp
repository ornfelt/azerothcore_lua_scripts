/*
# Custom Login Modifications #
#### A module for AzerothCore by [StygianTheBest](https://github.com/StygianTheBest/AzerothCore-Content/tree/master/Modules)
------------------------------------------------------------------------------------------------------------------
### Description ###
------------------------------------------------------------------------------------------------------------------
This module performs several actions on new players. It has the option to give new players BOA starting gear,
additional weapon skills, and special abilities such as custom spells. It can also set the reputation of the player
to exalted with all capital cities for their faction granting them the Ambassador title. This is typically done in
the core's config file, but it's bugged (as of 2017.08.23) in AzerothCore. It can also announce when players login
or logoff the server.
### Features ###
------------------------------------------------------------------------------------------------------------------
- Player ([ Faction ] - Name - Logon/Logoff message) notification can be announced to the world
- New characters can receive items, bags, and class-specific heirlooms
- New characters can receive additional weapon skills
- New characters can receive special abilities
- New characters can receive exalted rep with capital cities (Title: Ambassador) on first login
### Data ###
------------------------------------------------------------------------------------------------------------------
- Type: Player/Server
- Script: CustomLogin
- Config: Yes
    - Enable Module
    - Enable Module Announce
    - Enable Announce Player Login/Logoff
    - Enable Starting Gear for new players
    - Enable Additional Weapon Skills for new players
    - Enable Special Abilities for new players
    - Enable Reputation Boost for new players
- SQL: No
### Version ###
------------------------------------------------------------------------------------------------------------------
- v2017.07.26 - Release
- v2017.07.29 - Clean up code, Add rep gain, Add config options
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

#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "SharedDefines.h"
#include "World.h"

class CustomLogin : public PlayerScript
{

public:
    CustomLogin() : PlayerScript("CustomLogin") { }

    void OnLogin(Player* player, bool firstLogin) override
    {
        if (sConfigMgr->GetBoolDefault("Login.BoA", true))
        {
            if (!firstLogin) {// Run script only on first login

                uint32 shoulders = 0, chest = 0, trinkett = 0, weapon = 0, weapon2 = 0, weapon3 = 0, shield = 0, shoulders2 = 0, chest2 = 0, trinkett2 = 0, bag = 0;

                bag = 41600;
                switch (player->getClass())
                {
                case CLASS_WARRIOR:
                    //Warrior
                    shoulders = 93893;
                    chest = 93892;
                    trinkett = 122361;
                    weapon = 122389;
                    shield = 122391;
                    shoulders2 = 122355;
                    chest2 = 122381;
                    weapon2 = 42943;
                    break;
                case CLASS_PALADIN:
                    //Paladin
                    shoulders = 69890;
                    chest = 69889;
                    trinkett = 42991;
                    weapon = 69893;
                    shield = 122391;
                    shoulders2 = 42951;
                    chest2 = 48683;
                    trinkett2 = 42992;
                    weapon2 = 42948;
                    break;
                case CLASS_HUNTER:
                    //Hunter
                    shoulders = 42950;
                    chest = 48677;
                    trinkett = 42991;
                    weapon = 42943;
                    weapon2 = 42946;
                    weapon3 = 44093;
                    break;
                case CLASS_ROGUE:
                    //Rogue
                    shoulders = 42952;
                    chest = 48689;
                    trinkett = 42991;
                    weapon = 42944;
                    weapon2 = 42944;
                    break;
                case CLASS_PRIEST:
                    //Priest
                    shoulders = 42985;
                    chest = 48691;
                    trinkett = 42992;
                    weapon = 42947;
                    break;
                case CLASS_DEATH_KNIGHT:
                    //Death Knight
                    shoulders = 42949;
                    chest = 48685;
                    trinkett = 42991;
                    weapon = 42945;
                    break;
                case CLASS_SHAMAN:
                    //Shaman
                    shoulders = 122375;
                    chest = 48683;
                    trinkett = 122362;
                    weapon = 122367;
                    shield = 122392;
                    shoulders2 = 122374;
                    chest2 = 122379;
                    weapon2 = 122385;
                    break;
                case CLASS_MAGE:
                    //Mage
                    shoulders = 42985;
                    chest = 48691;
                    trinkett = 42992;
                    weapon = 42947;
                    break;
                case CLASS_WARLOCK:
                    //Warlock
                    shoulders = 42985;
                    chest = 48691;
                    trinkett = 42992;
                    weapon = 42947;
                    break;
                case CLASS_DRUID:
                    //Druid
                    shoulders = 42984;
                    chest = 48687;
                    trinkett = 42992;
                    weapon = 42948;
                    shoulders2 = 42952;
                    chest2 = 48689;
                    trinkett2 = 42991;
                    weapon2 = 48718;
                    break;
                case CLASS_MONK:
                    //Monk
                    shoulders = 42984;
                    chest = 48687;
                    trinkett = 42992;
                    weapon = 42947;
                    shoulders2 = 42952;
                    chest2 = 48689;
                    trinkett2 = 42991;
                    weapon2 = 48716;
                default:
                    return;
                }
                switch (player->getClass())
                {
                case CLASS_WARRIOR:
                    player->AddItem(shoulders, 1);
                    player->AddItem(chest, 1);
                    player->AddItem(trinkett, 2);
                    player->AddItem(weapon, 1);
                    player->AddItem(shield, 1);
                    player->AddItem(shoulders2, 1);
                    player->AddItem(chest2, 1);
                    player->AddItem(weapon2, 1);
                    player->AddItem(bag, 4);
                    break;
                case CLASS_PALADIN:
                    player->AddItem(shoulders, 1);
                    player->AddItem(chest, 1);
                    player->AddItem(trinkett, 2);
                    player->AddItem(weapon, 1);
                    player->AddItem(shield, 1);
                    player->AddItem(shoulders2, 1);
                    player->AddItem(chest2, 1);
                    player->AddItem(trinkett2, 2);
                    player->AddItem(weapon2, 1);
                    player->AddItem(bag, 4);
                    break;
                case CLASS_HUNTER:
                    player->AddItem(shoulders, 1);
                    player->AddItem(trinkett, 2);
                    player->AddItem(chest, 1);
                    player->AddItem(weapon, 1);
                    player->AddItem(weapon2, 1);
                    player->AddItem(weapon3, 1);
                    player->AddItem(bag, 4);
                    break;
                case CLASS_ROGUE:
                    player->AddItem(shoulders, 1);
                    player->AddItem(trinkett, 2);
                    player->AddItem(chest, 1);
                    player->AddItem(weapon, 1);
                    player->AddItem(weapon2, 1);
                    player->AddItem(bag, 4);
                    break;
                case CLASS_DRUID:
                    player->AddItem(shoulders, 1);
                    player->AddItem(trinkett, 2);
                    player->AddItem(chest, 1);
                    player->AddItem(weapon, 1);
                    player->AddItem(shoulders2, 1);
                    player->AddItem(chest2, 1);
                    player->AddItem(trinkett2, 2);
                    player->AddItem(weapon2, 1);
                    player->AddItem(bag, 4);
                    break;
                case CLASS_SHAMAN:
                    player->AddItem(shoulders, 1);
                    player->AddItem(chest, 1);
                    player->AddItem(trinkett, 2);
                    player->AddItem(weapon, 1);
                    player->AddItem(shield, 1);
                    player->AddItem(shoulders2, 1);
                    player->AddItem(chest2, 1);
                    player->AddItem(weapon2, 2);
                    player->AddItem(bag, 4);
                    break;
                case CLASS_MONK:
                    player->AddItem(shoulders, 1);
                    player->AddItem(trinkett, 2);
                    player->AddItem(chest, 1);
                    player->AddItem(weapon, 1);
                    player->AddItem(shoulders2, 1);
                    player->AddItem(trinkett2, 2);
                    player->AddItem(chest2, 1);
                    player->AddItem(weapon2, 1);
                    player->AddItem(bag, 4);
                    break;
                default:
                    player->AddItem(shoulders, 1);
                    player->AddItem(trinkett, 2);
                    player->AddItem(chest, 1);
                    player->AddItem(weapon, 1);
                    player->AddItem(bag, 4);
                }

                // If enabled.. learn special skills abilities
                if (sConfigMgr->GetBoolDefault("CustomLogin.SpecialAbility", true))
                {
                    // Learn Specialized Skills
                    player->LearnSpell(1784, true);	// Stealth
                    player->LearnSpell(921, true);	// Pick Pocket
                    player->LearnSpell(1804, true);	// Lockpicking
                    player->LearnSpell(2983, true);	// Sprint (3)
                    player->LearnSpell(5384, true);	// Feign Death
                    // player->learnSpell(475);	// Remove Curse

                    // Add a few teleportation runes
                    player->AddItem(17031, 5);	// Rune of Teleportation

                    // Learn Teleports
                    switch (player->GetTeamId())
                    {

                    case TEAM_ALLIANCE:

                        // Alliance Teleports
                        player->LearnSpell(3565, true);	// Darnassus
                        player->LearnSpell(32271, true);	// Exodar
                        player->LearnSpell(3562, true);	// Ironforge
                        player->LearnSpell(33690, true);	// Shattrath
                        player->LearnSpell(3561, true);	// Stormwind
                        break;

                    case TEAM_HORDE:

                        // Horde Teleports
                        player->LearnSpell(3567, true);	// Orgrimmar
                        player->LearnSpell(35715, true);	// Shattrath
                        player->LearnSpell(32272, true);	// Silvermoon
                        player->LearnSpell(3566, true);	// Thunder Bluff
                        player->LearnSpell(3563, true);	// Undercity
                        break;

                    default:
                        break;
                    }

                    // Inform the player they have new skills
                    std::ostringstream ss;
                    ss << "|cffFF0000[CustomLogin]:|cffFF8000 Your spellbook has been scribed with special abilities.";
                    ChatHandler(player->GetSession()).SendSysMessage(ss.str().c_str());
                }

                // If enabled.. set exalted factions (AzerothCore config for rep not working as of 2017-08-25)
                if (sConfigMgr->GetBoolDefault("CustomLogin.Reputation", true))
                {
                    switch (player->GetTeamId())
                    {

                        // Alliance Capital Cities
                    case TEAM_ALLIANCE:
                        player->SetReputation(47, 2500);	// IronForge
                        player->SetReputation(72, 2500);	// Stormwind 
                        player->SetReputation(69, 2500);	// Darnassus
                        player->SetReputation(389, 2500);	// Gnomeregan
                        player->SetReputation(930, 2500);	// Exodar
                        break;

                        // Horde Capital Cities
                    case TEAM_HORDE:
                        player->SetReputation(68, 2500);	// Undercity
                        player->SetReputation(76, 2500);	// Orgrimmar
                        player->SetReputation(81, 2500);	// Thunder Bluff
                        player->SetReputation(530, 2500);	// DarkSpear
                        player->SetReputation(911, 2500);	// Silvermoon
                        break;

                    default:
                        break;
                    }

                    // Inform the player they have exalted reputations
                    std::ostringstream ss;
                    ss << "|cffFF0000[CustomLogin]:|cffFF8000 Your are now Exalted with your faction's capital cities " << player->GetName() << ".";
                    ChatHandler(player->GetSession()).SendSysMessage(ss.str().c_str());
                }
            }
        }

        // If enabled..
        if (sConfigMgr->GetBoolDefault("CustomLogin.Enable", true))
        {
            if (firstLogin) {
                // Announce Module
                if (sConfigMgr->GetBoolDefault("CustomLogin.Announce", true))
                {
                    ChatHandler(player->GetSession()).SendSysMessage("This server is running the |cff4CFF00CustomLogin |rmodule.");
                }
            }

            // If enabled..
            if (sConfigMgr->GetBoolDefault("CustomLogin.PlayerAnnounce", true))
            {
                // Announce Player Login
                if (player->GetTeamId() == TEAM_ALLIANCE)
                {
                    if (firstLogin) {
                        std::ostringstream ss;
                        ss << "|cffFFFFFF[|cff2897FFAlliance|cffFFFFFF]: |cff3ADF00Please welcome |cffFFFFFF" << player->GetName() << "|cffFFFFFF to our server!|r";
                        sWorld->SendServerMessage(SERVER_MSG_STRING, ss.str().c_str());
                    }
                    else
                    {
                        std::ostringstream ss;
                        ss << "|cffFFFFFF[|cff2897FFAlliance|cffFFFFFF]: |cff3ADF00Glade to see you back |cffFFFFFF" << player->GetName() << "!|r";
                        sWorld->SendServerMessage(SERVER_MSG_STRING, ss.str().c_str());
                    }
                }
                else
                {
                    if (firstLogin) {
                        std::ostringstream ss;
                        ss << "|cffFFFFFF[|cffFF0000Horde|cffFFFFFF]: |cff3ADF00Please welcome |cffFFFFFF" << player->GetName() << "|cffFFFFFF to our server!|r";
                        sWorld->SendServerMessage(SERVER_MSG_STRING, ss.str().c_str());
                    }
                    else
                    {
                        std::ostringstream ss;
                        ss << "|cffFFFFFF[|cffFF0000Horde|cffFFFFFF]: |cff3ADF00Glade to see you back |cffFFFFFF" << player->GetName() << "!|r";
                        sWorld->SendServerMessage(SERVER_MSG_STRING, ss.str().c_str());
                    }
                }
            }
        }
    }

    void OnLogout(Player* player)
    {
        if (sConfigMgr->GetBoolDefault("CustomLogin.Enable", true))
        {
            // If enabled..
            if (sConfigMgr->GetBoolDefault("CustomLogin.PlayerAnnounce", true))
            {
                // Announce Player Login
                if (player->GetTeamId() == TEAM_ALLIANCE)
                {
                    std::ostringstream ss;
                    ss << "|cffFFFFFF[|cff2897FFAlliance|cffFFFFFF]: |cffFFFFFF" << player->GetName() << "|cffFFFFFF has left the game.";
                    sWorld->SendServerMessage(SERVER_MSG_STRING, ss.str().c_str());
                }
                else
                {
                    std::ostringstream ss;
                    ss << "|cffFFFFFF[|cffFF0000Horde|cffFFFFFF]: |cffFFFFFF" << player->GetName() << "|cffFFFFFF has left the game.";
                    sWorld->SendServerMessage(SERVER_MSG_STRING, ss.str().c_str());
                }
            }
        }
    }
};

void AddCustomLoginScripts()
{
    new CustomLogin();
}
