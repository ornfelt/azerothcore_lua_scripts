#include "ScriptMgr.h"
#include "Player.h"
#include "ScriptedGossip.h"
#include "WorldSession.h"
#include "World.h"
#include "Spell.h"
#include "SpellMgr.h"
#include "Config.h"
#include "ScriptMgr.h"
#include "Chat.h"
#include "DatabaseEnv.h"
#include "Chat.h"
#include "DBCStores.h"
#include "Item.h"

class CreatureScript_Professions : public CreatureScript
{
public:
    CreatureScript_Professions() : CreatureScript("CreatureScript_Professions") {}

    // Passive Emotes
    struct NPC_PassiveAI : public ScriptedAI
    {
        NPC_PassiveAI(Creature* creature) : ScriptedAI(creature) { }

        bool OnGossipHello(Player* player)
        {
            AddGossipItemFor(player, GOSSIP_ICON_TRAINER, "Alchemy", GOSSIP_SENDER_MAIN, 0);
            AddGossipItemFor(player, GOSSIP_ICON_TRAINER, "Blacksmithing", GOSSIP_SENDER_MAIN, 1);
            AddGossipItemFor(player, GOSSIP_ICON_TRAINER, "Leatherworking", GOSSIP_SENDER_MAIN, 2);
            AddGossipItemFor(player, GOSSIP_ICON_TRAINER, "Tailoring", GOSSIP_SENDER_MAIN, 3);
            AddGossipItemFor(player, GOSSIP_ICON_TRAINER, "Engineering", GOSSIP_SENDER_MAIN, 4);
            AddGossipItemFor(player, GOSSIP_ICON_TRAINER, "Enchanting", GOSSIP_SENDER_MAIN, 5);
            AddGossipItemFor(player, GOSSIP_ICON_TRAINER, "Jewelcrafting", GOSSIP_SENDER_MAIN, 6);
            AddGossipItemFor(player, GOSSIP_ICON_TRAINER, "Inscription", GOSSIP_SENDER_MAIN, 7);
            AddGossipItemFor(player, GOSSIP_ICON_TRAINER, "Herbalism", GOSSIP_SENDER_MAIN, 8);
            AddGossipItemFor(player, GOSSIP_ICON_TRAINER, "Skinning", GOSSIP_SENDER_MAIN, 9);
            AddGossipItemFor(player, GOSSIP_ICON_TRAINER, "Mining", GOSSIP_SENDER_MAIN, 10);
            AddGossipItemFor(player, GOSSIP_ICON_TRAINER, "Cooking", GOSSIP_SENDER_MAIN, 11);
            AddGossipItemFor(player, GOSSIP_ICON_TRAINER, "First Aid", GOSSIP_SENDER_MAIN, 12);
            AddGossipItemFor(player, GOSSIP_ICON_TRAINER, "Fishing", GOSSIP_SENDER_MAIN, 13);

            SendGossipMenuFor(player, 6030, me);
            return true;
        }

        bool OnGossipSelect(Player* player, uint32 gossipListId, uint32 SKILL)
        {
            uint32 const sender = player->PlayerTalkClass->GetGossipOptionSender(gossipListId);
            uint32 const action = player->PlayerTalkClass->GetGossipOptionAction(gossipListId);

            player->PlayerTalkClass->ClearMenus();

            if (sender == GOSSIP_SENDER_MAIN)
            {
                if (player->HasSkill(SKILL))
                {
                    player->GetSession()->SendNotification("You already have this work!");
                    CloseGossipMenuFor(player);
                }
                else
                {
                   
                    LearnAllRecipesInProfession(player, (SkillType)SKILL);
                }
            }

            return true;
        }

        static void LearnAllRecipesInProfession(Player* player, SkillType skill)
        {
            if (HasFreeProfession(player, skill))
            {
                switch (skill)
                {
                case 0:
                    player->LearnSpell(2259, true);
                    player->LearnSpell(3101, true);
                    player->LearnSpell(3464, true);
                    player->LearnSpell(11611, true);
                    player->LearnSpell(28596, true);
                    player->LearnSpell(51304, true);
                    break;
                case 1:
                    player->LearnSpell(2018, true);
                    player->LearnSpell(3100, true);
                    player->LearnSpell(3538, true);
                    player->LearnSpell(9785, true);
                    player->LearnSpell(29844, true);
                    player->LearnSpell(51300, true);
                    break;
                case 2:
                    player->LearnSpell(7411, true);
                    player->LearnSpell(7412, true);
                    player->LearnSpell(7413, true);
                    player->LearnSpell(13920, true);
                    player->LearnSpell(28029, true);
                    player->LearnSpell(51313, true);
                    break;
                case 3:
                    player->LearnSpell(4036, true);
                    player->LearnSpell(4037, true);
                    player->LearnSpell(4038, true);
                    player->LearnSpell(12656, true);
                    player->LearnSpell(30350, true);
                    player->LearnSpell(51306, true);
                    break;
                case 4:
                    player->LearnSpell(45357, true);
                    player->LearnSpell(45358, true);
                    player->LearnSpell(45359, true);
                    player->LearnSpell(45360, true);
                    player->LearnSpell(45361, true);
                    player->LearnSpell(45363, true);
                    break;
                case 5:
                    player->LearnSpell(25229, true);
                    player->LearnSpell(25230, true);
                    player->LearnSpell(28894, true);
                    player->LearnSpell(28895, true);
                    player->LearnSpell(28897, true);
                    player->LearnSpell(51311, true);
                    break;
                case 6:
                    player->LearnSpell(2108, true);
                    player->LearnSpell(3104, true);
                    player->LearnSpell(3811, true);
                    player->LearnSpell(10662, true);
                    player->LearnSpell(32549, true);
                    player->LearnSpell(51302, true);
                    break;
                case 7:
                    player->LearnSpell(3908, true);
                    player->LearnSpell(3909, true);
                    player->LearnSpell(3910, true);
                    player->LearnSpell(12180, true);
                    player->LearnSpell(26790, true);
                    player->LearnSpell(51309, true);
                    break;
                case 8:
                    player->LearnSpell(51296, true);
                    break;
                case 9:
                    player->LearnSpell(45542, true);
                    break;
                case 10:
                    player->LearnSpell(65293, true);
                    break;
                case 11:
                    player->LearnSpell(2575, true);
                    player->LearnSpell(2576, true);
                    player->LearnSpell(3564, true);
                    player->LearnSpell(10248, true);
                    player->LearnSpell(29354, true);
                    player->LearnSpell(50310, true);
                    break;
                case 12:
                    player->LearnSpell(8613, true);
                    player->LearnSpell(8617, true);
                    player->LearnSpell(8618, true);
                    player->LearnSpell(10768, true);
                    player->LearnSpell(32678, true);
                    player->LearnSpell(50305, true);
                    break;
                case 13:
                    player->LearnSpell(2366, true);
                    player->LearnSpell(2368, true);
                    player->LearnSpell(3570, true);
                    player->LearnSpell(11993, true);
                    player->LearnSpell(28695, true);
                    player->LearnSpell(50300, true);
                    break;
                default:
                    break;
                }

                if (SkillLineEntry const* SkillInfo = sSkillLineStore.LookupEntry(skill))
                {
                    player->SetSkill(SkillInfo->ID, player->GetSkillStep(SkillInfo->ID), 450, 450);

                    uint32 ClassMask = player->GetClassMask();

                    for (uint32 i = 0; i < sSkillLineAbilityStore.GetNumRows(); ++i)
                    {
                        if (SkillLineAbilityEntry const* SkillLine = sSkillLineAbilityStore.LookupEntry(i))
                        {
                            if (SkillLine->ID != SkillInfo->ID)
                                continue;

                            if (SkillLine->ID)
                                continue;

                            if (SkillLine->RaceMask != 0)
                                continue;

                            if (SkillLine->ClassMask && (SkillLine->ClassMask & ClassMask) == 0)
                                continue;

                            SpellInfo const* SpellInfo2 = sSpellMgr->GetSpellInfo(SkillLine->ID);

                            if (!SpellInfo2 || !SpellMgr::IsSpellValid(SpellInfo2))
                                continue;

                            player->LearnSpell(SkillLine->ID, true);
                        }
                    }
                }
            }
        }

        static bool HasFreeProfession(Player* player, SkillType Skill)
        {
            if (Skill == SKILL_FISHING || Skill == SKILL_COOKING || Skill == SKILL_FIRST_AID)
                return true;

            uint8 SkillCount = 0;

            if (player->HasSkill(SKILL_MINING))
                SkillCount++;
            if (player->HasSkill(SKILL_SKINNING))
                SkillCount++;
            if (player->HasSkill(SKILL_HERBALISM))
                SkillCount++;

            for (uint32 i = 1; i < sSkillLineStore.GetNumRows(); ++i)
            {
                if (SkillLineEntry const* SkillInfo = sSkillLineStore.LookupEntry(i))
                {
                    if (SkillInfo->CategoryID == SKILL_CATEGORY_SECONDARY)
                        continue;

                    if ((SkillInfo->CategoryID != SKILL_CATEGORY_PROFESSION) || !SkillInfo->CanLink)
                        continue;

                    if (player->HasSkill(SkillInfo->ID))
                        SkillCount++;
                }
            }

            if (SkillCount > 0 && player->HasSkill(Skill))
                SkillCount--;

            return SkillCount < sWorld->getIntConfig(CONFIG_MAX_PRIMARY_TRADE_SKILL);
        }
    };
    // CREATURE AI
    CreatureAI* GetAI(Creature* creature) const override
    {
        return new NPC_PassiveAI(creature);
    }
};

void AddSC_Professions()
{
    new CreatureScript_Professions();
}
