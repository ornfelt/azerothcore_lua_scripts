/*

# SoloCraft #

#### A module for AzerothCore by [StygianTheBest](https://github.com/StygianTheBest/AzerothCore-Content/tree/master/Modules)
------------------------------------------------------------------------------------------------------------------


### Description ###
------------------------------------------------------------------------------------------------------------------
These are my extensions to the TrinityCore WoW Server Emulator for WoW version 3.3.5a that are targetted toward
soloing (or with a very small party) the group content in WoW like dungeons and raids at the level the content was
meant for instead of having to come back and solo when you are 20 levels higher than the content.

The goal is to automatically apply stat buffs, HP regeneration, procs like dispelling target regeneration buffs,
and other things to the player based on the instance the player has entered and the size of the party they are in
to make up the non-deal party makeup.


## To-Do ###
------------------------------------------------------------------------------------------------------------------
- Verify player pets are buffed accordingly
- Dispel target regeneration
- Provide unlimited http://www.wowhead.com/item=17333/aqual-quintessence
    - Not Needed (Sadly), the need to douse the runes with Aqual Quintessence was removed in 3.0.8


## Data ###
------------------------------------------------------------------------------------------------------------------
- Type: Server/Player
- Script: Solocraft
- Config: Yes
    - Enable Module
    - Enable Module Announce
    - Set Difficulty for Instance Types
- SQL: No


### Version ###
------------------------------------------------------------------------------------------------------------------
- v2017.09.04 - Add config options for difficulty levels
- v2017.09.05 - Update strings, Add module announce


### Credits ###
------------------------------------------------------------------------------------------------------------------
- [David Macalaster](https://github.com/DavidMacalaster/Solocraft)
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

#include <map>

#include "Config.h"
#include "ScriptMgr.h"
#include "Unit.h"
#include "Player.h"
#include "Pet.h"
#include "Map.h"
#include "Group.h"
#include "InstanceScript.h"
#include "Chat.h"
#include "Log.h"

/*
 * TODO:
 * 1. Dispel target regeneration
 * 2. Provide unlimited http://www.wowhead.com/item=17333/aqual-quintessence
 */

namespace {

    class solocraft_player_instance_handler : public PlayerScript {
    public:
        solocraft_player_instance_handler() : PlayerScript("solocraft_player_instance_handler") {
            TC_LOG_INFO("scripts.solocraft.player.instance", "[Solocraft] solocraft_player_instance_handler Loaded");
        }

        void OnLogin(Player* player, bool firstLogin) override {
            if (firstLogin) {
                if (sConfigMgr->GetBoolDefault("Solocraft.Enable", true))
                {
                    ChatHandler(player->GetSession()).SendSysMessage("This server is running the |cff4CFF00SoloCraft |rmodule.");
                }
            }
        }

        void OnMapChanged(Player* player) override {
            if (sConfigMgr->GetBoolDefault("Solocraft.Enable", true)) {
                Map* map = player->GetMap();
                int difficulty = CalculateDifficulty(map, player);
                int numInGroup = GetNumInGroup(player);
                ApplyBuffs(player, map, difficulty, numInGroup);
            }
        }
    private:
        // Get difficulty values from config
        const uint32 D5 = sConfigMgr->GetIntDefault("Solocraft.Dungeon", 5);
        const uint32 D10 = sConfigMgr->GetIntDefault("Solocraft.Heroic", 10);
        const uint32 D25 = sConfigMgr->GetIntDefault("Solocraft.Raid25", 25);
        const uint32 D40 = sConfigMgr->GetIntDefault("Solocraft.Raid40", 40);

        std::map<ObjectGuid, int> _unitDifficulty;

        int CalculateDifficulty(Map* map, Player* player) {
            int difficulty = 1;
            if (map) {
                if (map->Is25ManRaid()) {
                    difficulty = 25;
                }
                else if (map->IsHeroic()) {
                    difficulty = 10;
                }
                else if (map->IsRaid()) {
                    difficulty = 40;
                }
                else if (map->IsDungeon()) {
                    difficulty = 5;
                }
            }
            return difficulty;
        }

        int GetNumInGroup(Player* player) {
            int numInGroup = 1;
            Group* group = player->GetGroup();
            if (group) {
                Group::MemberSlotList const& groupMembers = group->GetMemberSlots();
                numInGroup = groupMembers.size();
            }
            return numInGroup;
        }

        void ApplyBuffs(Player* player, Map* map, int difficulty, int numInGroup) {
            ClearBuffs(player, map);
            if (difficulty > 1) {
                //InstanceMap *instanceMap = map->ToInstanceMap();
                //InstanceScript *instanceScript = instanceMap->GetInstanceScript();

                // Announce to player
                std::ostringstream ss;
                ss << "|cffFF0000[SoloCraft] |cffFF8000" << player->GetName() << " entered %s - # of Players: %d - Difficulty Offset: %d.";
                ChatHandler(player->GetSession()).PSendSysMessage(ss.str().c_str(), map->GetMapName(), numInGroup, difficulty);

                _unitDifficulty[player->GetGUID()] = difficulty;
                for (int32 i = STAT_STRENGTH; i < MAX_STATS; ++i) {
                    player->ApplyStatPctModifier(UnitMods(UNIT_MOD_STAT_START + i), TOTAL_PCT, float(difficulty * 100));
                }
                player->SetFullHealth();
                if (player->GetPowerType() == POWER_MANA) {
                    player->SetPower(POWER_MANA, player->GetMaxPower(POWER_MANA));
                }
            }
        }

        void ClearBuffs(Player* player, Map* map) {
            std::map<ObjectGuid, int>::iterator unitDifficultyIterator = _unitDifficulty.find(player->GetGUID());
            if (unitDifficultyIterator != _unitDifficulty.end()) {
                int difficulty = unitDifficultyIterator->second;
                _unitDifficulty.erase(unitDifficultyIterator);

                // Inform the player
                std::ostringstream ss;
                ss << "|cffFF0000[SoloCraft] |cffFF8000" << player->GetName() << " exited to %s - Reverting Difficulty Offset: %d.";
                ChatHandler(player->GetSession()).PSendSysMessage(ss.str().c_str(), map->GetMapName(), difficulty);

                for (int32 i = STAT_STRENGTH; i < MAX_STATS; ++i) {
                    player->ApplyStatPctModifier(UnitMods(UNIT_MOD_STAT_START + i), TOTAL_PCT, 100.f / (1.f + float(difficulty * 100) / 100.f) - 100.f);
                }
            }
        }
    };

}


void AddSC_solocraft() {
    new solocraft_player_instance_handler();
}
