/* Skip Death Knight Module
   Original Module From Single Player Project Consolidated Skip Module
   Rewritten for TC 434 By Single Player Project Developer MDic
   Original Concept from conanhun513
*/

#include "AccountMgr.h"
#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Common.h"
#include "Chat.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "SharedDefines.h"
#include "World.h"
#include "WorldSession.h"

class SPP_skip_deathknight_announce : public PlayerScript
{
public:
    SPP_skip_deathknight_announce() : PlayerScript("SPP_skip_deathknight_announce") { }

    void OnLogin(Player* Player, bool /*firstLogin*/) override
    {
        if (sConfigMgr->GetBoolDefault("Skip.Deathknight.Starter.Announce.enable", true))
        {
            ChatHandler(Player->GetSession()).SendSysMessage("This server is running the |cff4CFF00SPP Skip Deathknight Starter |rmodule.");
        }
    }
};

class SPP_skip_deathknight : public PlayerScript
{
public:
    SPP_skip_deathknight() : PlayerScript("SPP_skip_deathknight") { }

    void OnLogin(Player* player, bool firstLogin) override
    {
        int DKL = sConfigMgr->GetFloatDefault("Skip.Deathknight.Start.Level", 58);

        if (sConfigMgr->GetBoolDefault("Skip.Deathknight.Starter.Enable", true))
        {
            if (player->GetAreaId() == 4342)
            {
                if (!firstLogin)
                    return;
                player->SetLevel(DKL);
                player->LearnSpell(53428, false);//runeforging
                player->LearnSpell(53441, false);//runeforging
                player->LearnSpell(53344, false);//runeforging
                player->LearnSpell(62158, false);//runeforging
                player->LearnSpell(33391, false);//journeyman riding
                player->LearnSpell(54586, false);//runeforging credit
                player->LearnSpell(48778, false);//acherus deathcharger
                player->LearnSkillRewardedSpells(776, 375);//Runeforging
                player->LearnSkillRewardedSpells(960, 375);//Runeforging
                player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 38661, true);//Greathelm of the Scourge Champion
                player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 38666, true);//Plated Saronite Bracers
                player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 38668, true);//The Plaguebringer's Girdle
                player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 38667, true);//Bloodbane's Gauntlets of Command
                player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 38665, true);//Saronite War Plate
                player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 38669, true);//Engraved Saronite Legplates
                player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 38663, true);// Blood-Soaked Saronite Plated Spaulders
                player->EquipNewItem(EQUIPMENT_SLOT_FEET, 38670, true);//Greaves of the Slaughter
                player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 38675, true);//Signet of the Dark Brotherhood
                player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 38674, true);//Soul Harvester's Charm
                player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 38671, true);//Valanar's Signet Ring
                player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 38672, true);// Keleseth's Signet Ring
                player->AddItem(39320, true);//Sky Darkener's Shroud of Blood
                player->AddItem(38664, true);//Sky Darkener's Shroud of the Unholy
                player->AddItem(39322, true);//Shroud of the North Wind
                player->AddItem(38632, true);//Greatsword of the Ebon Blade
                player->AddItem(6948, true);//Hearthstone
                player->AddItem(38707, true);//Runed Soulblade
                player->AddItem(40483, true);//Insignia of the Scourge

                if (player->GetQuestStatus(12657) == QUEST_STATUS_NONE)//The Might Of The Scourge
                {
                    player->AddQuest(sObjectMgr->GetQuestTemplate(12657), nullptr);
                    player->RewardQuest(sObjectMgr->GetQuestTemplate(12657), false, player);
                }
                if (player->GetQuestStatus(12801) == QUEST_STATUS_NONE)//The Light of Dawn
                {
                    player->AddQuest(sObjectMgr->GetQuestTemplate(12801), nullptr);
                    player->RewardQuest(sObjectMgr->GetQuestTemplate(12801), false, player);
                }
                if (player->GetTeam() == ALLIANCE && player->GetQuestStatus(13188) == QUEST_STATUS_NONE)//Where Kings Walk
                    player->AddQuest(sObjectMgr->GetQuestTemplate(13188), nullptr);
                else if (player->GetTeam() == HORDE && player->GetQuestStatus(13189) == QUEST_STATUS_NONE)//Saurfang's Blessing
                    player->AddQuest(sObjectMgr->GetQuestTemplate(13189), nullptr);
                if (player->GetTeam() == ALLIANCE)
                    player->TeleportTo(0, -8833.37f, 628.62f, 94.00f, 1.06f);//Stormwind
                else
                    player->TeleportTo(1, 1569.59f, -4397.63f, 16.06f, 0.54f);//Orgrimmar
                ObjectAccessor::SaveAllPlayers();//Save
            }
        }

        if (sConfigMgr->GetBoolDefault("GM.Skip.Deathknight.Starter.Enable", true))
        {
            if (player->GetSession()->GetSecurity() >= SEC_MODERATOR && player->GetAreaId() == 4342)
            {
                if (!firstLogin)
                    return;
                player->SetLevel(DKL);
                player->LearnSpell(53428, false);//runeforging
                player->LearnSpell(53441, false);//runeforging
                player->LearnSpell(53344, false);//runeforging
                player->LearnSpell(62158, false);//runeforging
                player->LearnSpell(33391, false);//journeyman riding
                player->LearnSpell(54586, false);//runeforging credit
                player->LearnSpell(48778, false);//acherus deathcharger
                player->LearnSkillRewardedSpells(776, 375);//Runeforging
                player->LearnSkillRewardedSpells(960, 375);//Runeforging
                player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 38661, true);//Greathelm of the Scourge Champion
                player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 38666, true);//Plated Saronite Bracers
                player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 38668, true);//The Plaguebringer's Girdle
                player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 38667, true);//Bloodbane's Gauntlets of Command
                player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 38665, true);//Saronite War Plate
                player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 38669, true);//Engraved Saronite Legplates
                player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 38663, true);// Blood-Soaked Saronite Plated Spaulders
                player->EquipNewItem(EQUIPMENT_SLOT_FEET, 38670, true);//Greaves of the Slaughter
                player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 38675, true);//Signet of the Dark Brotherhood
                player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 38674, true);//Soul Harvester's Charm
                player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 38671, true);//Valanar's Signet Ring
                player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 38672, true);// Keleseth's Signet Ring
                player->AddItem(39320, true);//Sky Darkener's Shroud of Blood
                player->AddItem(38664, true);//Sky Darkener's Shroud of the Unholy
                player->AddItem(39322, true);//Shroud of the North Wind
                player->AddItem(38632, true);//Greatsword of the Ebon Blade
                player->AddItem(6948, true);//Hearthstone
                player->AddItem(38707, true);//Runed Soulblade
                player->AddItem(40483, true);//Insignia of the Scourge

                if (player->GetQuestStatus(12657) == QUEST_STATUS_NONE)//The Might Of The Scourge
                {
                    player->AddQuest(sObjectMgr->GetQuestTemplate(12657), nullptr);
                    player->RewardQuest(sObjectMgr->GetQuestTemplate(12657), false, player);
                }
                if (player->GetQuestStatus(12801) == QUEST_STATUS_NONE)//The Light of Dawn
                {
                    player->AddQuest(sObjectMgr->GetQuestTemplate(12801), nullptr);
                    player->RewardQuest(sObjectMgr->GetQuestTemplate(12801), false, player);
                }
                if (player->GetTeam() == ALLIANCE && player->GetQuestStatus(13188) == QUEST_STATUS_NONE)//Where Kings Walk
                    player->AddQuest(sObjectMgr->GetQuestTemplate(13188), nullptr);
                else if (player->GetTeam() == HORDE && player->GetQuestStatus(13189) == QUEST_STATUS_NONE)//Saurfang's Blessing
                    player->AddQuest(sObjectMgr->GetQuestTemplate(13189), nullptr);
                if (player->GetTeam() == ALLIANCE)
                    player->TeleportTo(0, -8833.37f, 628.62f, 94.00f, 1.06f);//Stormwind
                else
                    player->TeleportTo(1, 1569.59f, -4397.63f, 16.06f, 0.54f);//Orgrimmar
                ObjectAccessor::SaveAllPlayers();//Save
            }
        }
    }
};

class spp_skip_worgen : public PlayerScript
{
public:
    spp_skip_worgen() : PlayerScript("spp_skip_worgen") { }

    void OnLogin(Player* Player, bool firstLogin) override
    {
        int WGL = sConfigMgr->GetFloatDefault("Skip.Worgen.Start.Level", 18);

        if (sConfigMgr->GetBoolDefault("Skip.Worgen.Starter.Enable", true))
        {
            if (Player->GetMapId() == 654)
            {
                if (!firstLogin)
                    return;
                Player->LearnSpell(72792, false); // Learn Racials
                Player->LearnSpell(72857, false); // Learn Two Forms
                Player->LearnSpell(95759, false); // Learn Darkflight
                Player->TeleportTo(1, 8181.060059f, 999.103027f, 7.253240f, 6.174160f);
                Player->SetLevel(WGL);
                ObjectAccessor::SaveAllPlayers();
            }
        }

        if (sConfigMgr->GetBoolDefault("GM.Skip.Worgen.Starter.Enable", true))
        {
            if (Player->GetSession()->GetSecurity() >= SEC_MODERATOR && Player->GetMapId() == 654)
            {
                if (!firstLogin)
                    return;
                Player->LearnSpell(72792, false); // Learn Racials
                Player->LearnSpell(72857, false); // Learn Two Forms
                Player->LearnSpell(95759, false); // Learn Darkflight
                Player->TeleportTo(1, 8181.060059f, 999.103027f, 7.253240f, 6.174160f);
                Player->SetLevel(WGL);
                ObjectAccessor::SaveAllPlayers();
            }
        }
    }
};

class SPP_skip_worgen_announce : public PlayerScript
{
public:
    SPP_skip_worgen_announce() : PlayerScript("SPP_skip_worgen_announce") { }

    void OnLogin(Player* Player, bool /*firstLogin*/) override
    {
        if (sConfigMgr->GetBoolDefault("Skip.Worgen.Starter.Announce.enable", true))
        {
            ChatHandler(Player->GetSession()).SendSysMessage("This server is running the |cff4CFF00SPP Skip Worgen Starter |rmodule.");
        }
    }
};


class spp_skip_goblin : public PlayerScript
{
public:
    spp_skip_goblin() : PlayerScript("spp_skip_goblin") { }

    void OnLogin(Player* Player, bool firstLogin) override
    {
        int GBL = sConfigMgr->GetFloatDefault("Skip.Goblin.Start.Level", 16);

        if (sConfigMgr->GetBoolDefault("Skip.Goblin.Starter.Enable", true))
        {
            if (Player->GetMapId() == 648)
            {
                if (!firstLogin)
                    return;
                Player->LearnSpell(69046, false); // Pack Hobgoblin
                Player->SetLevel(GBL);
                Player->TeleportTo(1, 1569.59f, -4397.63f, 16.06f, 0.54f);
                if (Player->GetTeam() == ALLIANCE && Player->GetQuestStatus(25267) == QUEST_STATUS_NONE)//Message for Saurfang
                    Player->AddQuest(sObjectMgr->GetQuestTemplate(25267), nullptr);
                ObjectAccessor::SaveAllPlayers();
            }
        }

        if (sConfigMgr->GetBoolDefault("GM.Skip.Goblin.Starter.Enable", true))
        {
            if (Player->GetSession()->GetSecurity() >= SEC_MODERATOR && Player->GetMapId() == 648)
            {
                if (!firstLogin)
                    return;
                Player->LearnSpell(69046, false); // Pack Hobgoblin
                Player->SetLevel(GBL);
                Player->TeleportTo(1, 1569.59f, -4397.63f, 16.06f, 0.54f);
                if (Player->GetTeam() == ALLIANCE && Player->GetQuestStatus(25267) == QUEST_STATUS_NONE)//Message for Saurfang
                    Player->AddQuest(sObjectMgr->GetQuestTemplate(25267), nullptr);
                ObjectAccessor::SaveAllPlayers();
            }
        }
    }
};

class SPP_skip_goblin_announce : public PlayerScript
{
public:
    SPP_skip_goblin_announce() : PlayerScript("SPP_skip_goblin_announce") { }

    void OnLogin(Player* Player, bool /*firstLogin*/) override
    {
        if (sConfigMgr->GetBoolDefault("Skip.Goblin.Starter.Announce.enable", true))
        {
            ChatHandler(Player->GetSession()).SendSysMessage("This server is running the |cff4CFF00SPP Skip Goblin Starter |rmodule.");
        }
    }
};

void AddSC_skip_StarterArea()
{
    new SPP_skip_deathknight_announce;
    new SPP_skip_deathknight;
    new spp_skip_goblin;
    new SPP_skip_goblin_announce;
    new SPP_skip_worgen_announce;
    new spp_skip_worgen;
}
