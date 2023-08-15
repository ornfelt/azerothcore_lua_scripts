#include "ScriptPCH.h"
#include "Transmogrification.h"
#include "Language.h"

enum professionmenu
{
    OPTION_TAILORING,
    OPTION_JEWELCRAFTING,
    OPTION_ENGINEERING,
    OPTION_BLACKSMITHING,
    OPTION_ALCHEMY,
    OPTION_INSCRIPTION,
    OPTION_ENCHANTING,
    OPTION_LEATHERWORKING,
    OPTION_COOKING,
    OPTION_FIRST_AID,
    OPTION_MAIN_MENU,

    SORT_TAILORING = 0,
    SORT_JEWELCRAFTING,
    SORT_ENGINEERING,
    SORT_BLACKSMITHING,
    SORT_ALCHEMY,
    SORT_INSCRIPTION,
    SORT_ENCHANTING,
    SORT_LEATHERWORKING,
    SORT_COOKING,
    SORT_FIRST_AID,

    TEXT_PROFESSION_MAIN = 50020,
    ACTION_LEARN_PROFESSION,
    ACTION_PURCHASE_MATERIALS,
};

class npc_professions : public CreatureScript
{
public:
    npc_professions() : CreatureScript("npc_professions") { } // to alliance from horde

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (!sWorld->getBoolConfig(CUSTOM_SCRIPTS_ENABLED_OR_NOT))
            return false;

        if (player->GetSession()->IsPremium() || (player->HasSkill(SKILL_TAILORING) && player->GetSkillValue(SKILL_TAILORING) >= 400)) player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Tailoring", GOSSIP_SENDER_MAIN, OPTION_TAILORING);
        if (player->GetSession()->IsPremium() || (player->HasSkill(SKILL_JEWELCRAFTING) && player->GetSkillValue(SKILL_JEWELCRAFTING) >= 400)) player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Jewelcrafting", GOSSIP_SENDER_MAIN, OPTION_JEWELCRAFTING);
        if (player->GetSession()->IsPremium() || (player->HasSkill(SKILL_ENGINEERING) && player->GetSkillValue(SKILL_ENGINEERING) >= 400)) player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Engineering", GOSSIP_SENDER_MAIN, OPTION_ENGINEERING);
        if (player->GetSession()->IsPremium() || (player->HasSkill(SKILL_BLACKSMITHING) && player->GetSkillValue(SKILL_BLACKSMITHING) >= 400)) player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Blacksmithing", GOSSIP_SENDER_MAIN, OPTION_BLACKSMITHING);
        if (player->GetSession()->IsPremium() || (player->HasSkill(SKILL_ALCHEMY) && player->GetSkillValue(SKILL_ALCHEMY) >= 400)) player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Alchemy", GOSSIP_SENDER_MAIN, OPTION_ALCHEMY);
        if (player->GetSession()->IsPremium() || (player->HasSkill(SKILL_INSCRIPTION) && player->GetSkillValue(SKILL_INSCRIPTION) >= 400)) player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Inscription", GOSSIP_SENDER_MAIN, OPTION_INSCRIPTION);
        if (player->GetSession()->IsPremium() || (player->HasSkill(SKILL_ENCHANTING) && player->GetSkillValue(SKILL_ENCHANTING) >= 400)) player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Enchanting", GOSSIP_SENDER_MAIN, OPTION_ENCHANTING);
        if (player->GetSession()->IsPremium() || (player->HasSkill(SKILL_LEATHERWORKING) && player->GetSkillValue(SKILL_LEATHERWORKING) >= 400)) player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Leatherworking", GOSSIP_SENDER_MAIN, OPTION_LEATHERWORKING);
        if (player->GetSession()->IsPremium() || (player->HasSkill(SKILL_COOKING) && player->GetSkillValue(SKILL_COOKING) >= 400)) player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Cooking", GOSSIP_SENDER_MAIN, OPTION_COOKING);
        if (player->GetSession()->IsPremium() || (player->HasSkill(SKILL_FIRST_AID) && player->GetSkillValue(SKILL_FIRST_AID) >= 400)) player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "First Aid", GOSSIP_SENDER_MAIN, OPTION_FIRST_AID);
        player->SEND_GOSSIP_MENU(TEXT_PROFESSION_MAIN, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) override
    {
        player->PlayerTalkClass->ClearMenus();
        switch (sender)
        {
            case GOSSIP_SENDER_MAIN:
                switch (action)
                {
                    case OPTION_TAILORING:
                        //if (player->HasSkill(SKILL_TAILORING))
                            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD,"|TInterface/ICONS/inv_fabric_linen_01:40:40:-18:0|tLearn the skill Tailoring", ACTION_LEARN_PROFESSION, SKILL_TAILORING);
                        //player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD,"|TInterface/ICONS/inv_fabric_linen_01:40:40:-18:0|tTailoring Materials", ACTION_PURCHASE_MATERIALS, SORT_TAILORING);
                        break;
                    case OPTION_JEWELCRAFTING:
                        //if (player->HasSkill(SKILL_JEWELCRAFTING))
                            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD,"|TInterface/ICONS/inv_jewelcrafting_nightseye_02:40:40:-18:0|tLearn the skill Jewelcrafting", ACTION_LEARN_PROFESSION, SKILL_JEWELCRAFTING);
                        //player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD,"|TInterface/ICONS/inv_jewelcrafting_nightseye_02:40:40:-18:0|tJewelcrafting Materials", ACTION_PURCHASE_MATERIALS, SORT_JEWELCRAFTING);
                        break;
                    case OPTION_ENGINEERING:
                        //if (player->HasSkill(SKILL_ENGINEERING))
                            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD,"|TInterface/ICONS/inv_misc_gear_06:40:40:-18:0|tLearn the skill Engineering", ACTION_LEARN_PROFESSION, SKILL_ENGINEERING);
                        //player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD,"|TInterface/ICONS/inv_misc_gear_06:40:40:-18:0|tEngineering Materials", ACTION_PURCHASE_MATERIALS, SORT_ENGINEERING);
                        break;
                    case OPTION_BLACKSMITHING:
                        //if (player->HasSkill(SKILL_BLACKSMITHING))
                            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD,"|TInterface/ICONS/inv_ingot_02:40:40:-18:0|tLearn the skill Blacksmithing", ACTION_LEARN_PROFESSION, SKILL_BLACKSMITHING);
                        //player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD,"|TInterface/ICONS/inv_ingot_02:40:40:-18:0|tBlacksmithing Materials", ACTION_PURCHASE_MATERIALS, SORT_BLACKSMITHING);
                        break;
                    case OPTION_ALCHEMY:
                        //if (player->HasSkill(SKILL_ALCHEMY))
                            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD,"|TInterface/ICONS/inv_misc_flower_02:40:40:-18:0|tLearn the skill Alchemy", ACTION_LEARN_PROFESSION, SKILL_ALCHEMY);
                        //player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD,"|TInterface/ICONS/inv_misc_flower_02:40:40:-18:0|tAlchemy Materials", ACTION_PURCHASE_MATERIALS, SORT_ALCHEMY);
                        break;
                    case OPTION_INSCRIPTION:
                        //if (player->HasSkill(SKILL_INSCRIPTION))
                            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD,"|TInterface/ICONS/inv_inscription_papyrus:40:40:-18:0|tLearn the skill Inscription", ACTION_LEARN_PROFESSION, SKILL_INSCRIPTION);
                        //player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD,"|TInterface/ICONS/inv_inscription_papyrus:40:40:-18:0|tInscription Materials", ACTION_PURCHASE_MATERIALS, SORT_INSCRIPTION);
                        break;
                    case OPTION_ENCHANTING:
                        //if (player->HasSkill(SKILL_ENCHANTING))
                            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD,"|TInterface/ICONS/inv_misc_dust_infinite:40:40:-18:0|tLearn the skill Enchanting", ACTION_LEARN_PROFESSION, SKILL_ENCHANTING);
                        //player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD,"|TInterface/ICONS/inv_misc_dust_infinite:40:40:-18:0|tEnchanting Materials", ACTION_PURCHASE_MATERIALS, SORT_ENCHANTING);
                        break;
                    case OPTION_LEATHERWORKING:
                        //if (player->HasSkill(SKILL_LEATHERWORKING))
                            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD,"|TInterface/ICONS/inv_misc_leatherscrap_03:40:40:-18:0|tLearn the skill Leatherworking", ACTION_LEARN_PROFESSION, SKILL_LEATHERWORKING);
                        //player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD,"|TInterface/ICONS/inv_misc_leatherscrap_03:40:40:-18:0|tLeatherworking Materials", ACTION_PURCHASE_MATERIALS, SORT_LEATHERWORKING);
                        break;
                    case OPTION_COOKING:
                        //if (player->HasSkill(SKILL_COOKING))
                            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD,"|TInterface/ICONS/inv_misc_food_16:40:40:-18:0|tLearn the skill Cooking", ACTION_LEARN_PROFESSION, SKILL_COOKING);
                        //player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD,"|TInterface/ICONS/inv_misc_food_16:40:40:-18:0|tCooking Materials", ACTION_PURCHASE_MATERIALS, SORT_COOKING);
                        break;
                    case OPTION_FIRST_AID:
                        //if(player->HasSkill(SKILL_FIRST_AID))
                            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD,"|TInterface/ICONS/inv_misc_bandage_15:40:40:-18:0|tLearn the skill First Aid", ACTION_LEARN_PROFESSION, SKILL_FIRST_AID);
                        //player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD,"|TInterface/ICONS/inv_misc_bandage_15:40:40:-18:0|tFirst Aid Materials", ACTION_PURCHASE_MATERIALS, SORT_FIRST_AID);
                        break;
                    case OPTION_MAIN_MENU:
                        OnGossipHello(player, creature);
                        player->SEND_GOSSIP_MENU(TEXT_PROFESSION_MAIN, creature->GetGUID());
                        return true;
                }
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD,"Back", GOSSIP_SENDER_MAIN, OPTION_MAIN_MENU);
                player->SEND_GOSSIP_MENU(TEXT_PROFESSION_MAIN, creature->GetGUID());
                break;
            case ACTION_LEARN_PROFESSION:
                //if (!CheckSkill(player, action))
                //{
                    //player->GetSession()->SendNotification("You already have two professions or already know this skill");
                    OnGossipHello(player, creature);
                    //break;
                //}
                HandleLearnSkillRecipesHelper(player, action);
                player->SetSkill(action, player->GetSkillStep(action), 450, 450);
                break;

        }
        return true;
    }

    bool CheckSkill(Player* player, uint16 skill)
    {
        uint8 skillCount = 0;

        if (IsSecondary(skill))
            return true;

        if (player->HasSkill(SKILL_ALCHEMY))
            skillCount++;

        if (player->HasSkill(SKILL_BLACKSMITHING))
            skillCount++;

        if (player->HasSkill(SKILL_ENCHANTING))
            skillCount++;

        if (player->HasSkill(SKILL_ENGINEERING))
            skillCount++;

        if (player->HasSkill(SKILL_HERBALISM))
            skillCount++;

        if (player->HasSkill(SKILL_INSCRIPTION))
            skillCount++;

        if (player->HasSkill(SKILL_JEWELCRAFTING))
            skillCount++;

        if (player->HasSkill(SKILL_LEATHERWORKING))
            skillCount++;

        if (player->HasSkill(SKILL_TAILORING))
            skillCount++;

        if (skillCount > 1)
            return false;

        return true;
    }

    bool IsSecondary(uint16 skill)
    {
        switch (skill)
        {
            case SKILL_COOKING:
            case SKILL_FIRST_AID:
            case SKILL_FISHING:
                return true;
            default:
                return false;
        }
    }

    void HandleLearnSkillRecipesHelper(Player* player, uint32 skillId)
    {
        uint32 classmask = player->getClassMask();

        for (uint32 j = 0; j < sSkillLineAbilityStore.GetNumRows(); ++j)
        {
            SkillLineAbilityEntry const* skillLine = sSkillLineAbilityStore.LookupEntry(j);
            if (!skillLine)
                continue;

            // wrong skill
            if (skillLine->skillId != skillId)
                continue;

            // not high rank
            if (skillLine->forward_spellid)
                continue;

            // skip racial skills
            if (skillLine->racemask != 0)
                continue;

            // skip wrong class skills
            if (skillLine->classmask && (skillLine->classmask & classmask) == 0)
                continue;

            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(skillLine->spellId);
            if (!spellInfo || !SpellMgr::IsSpellValid(spellInfo))
                continue;

            player->learnSpell(skillLine->spellId);
        }
    }
};

void AddSC_ProfessionsNPC()
{
    new npc_professions; 
}
