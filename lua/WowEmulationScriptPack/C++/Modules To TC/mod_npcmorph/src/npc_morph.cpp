/*
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`) VALUES
('55004', '0', '0', '0', '0', '0', '18', '0', '18', '0', 'Morph Master', 'AzerothCore', '', '0', '59', '61', '0', '35', '35', '1', '1.48', '1.14286', '0.0', '0', '655.0', '663.0', '0', '158', '1.0', '1500', '1900', '1', '0', '0', '0', '0', '0', '0', '0', '0.0', '0.0', '100', '7', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '', '1', '3', '1.0', '1.0', '1.0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', 'npc_morph', '1');
*/

#include "ScriptMgr.h"
#include "ScriptedGossip.h"
#include "Player.h"

#define MSG_GOSSIP_TEXT_GETTING_STARTED	"Welcome to TrinityCore morph service!"

#define MSG_ERR_INCOMBAT "You are in combat. To use my services, Leave it.."

#define MSG_GOSSIP_TEXT_MORTH_GNOME_MALE "[Transform] Gnome, male."
#define MSG_GOSSIP_TEXT_MORTH_GNOME_FEMALE "[Transform] Gnome, female."
#define MSG_GOSSIP_TEXT_MORTH_HUMAN_MALE "[Transform] Human, male."
#define MSG_GOSSIP_TEXT_MORTH_HUMAN_FEMALE "[Transform] Human, female."
#define MSG_GOSSIP_TEXT_MORTH_BLOOD_ELF_MALE "[Transform] Blood Elf, male."
#define MSG_GOSSIP_TEXT_MORTH_BLOOD_ELF_FEMALE "[Transform] Blood Elf, female."
#define MSG_GOSSIP_TEXT_MORTH_TAUREN_MALE "[Transform] Tauren, male."
#define MSG_GOSSIP_TEXT_MORTH_TAUREN_FEMALE "[Transform] Tauren, female."

class npc_morph : public CreatureScript
{
    public: 
    npc_morph() : CreatureScript("npc_morph") { }
    // Passive Emotes
    struct NPC_PassiveAI : public ScriptedAI
    {
        NPC_PassiveAI(Creature* creature) : ScriptedAI(creature) { }

        bool OnGossipHello(Player* player, Creature* creature)
        {
            ClearGossipMenuFor(player);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, MSG_GOSSIP_TEXT_MORTH_GNOME_MALE, GOSSIP_SENDER_MAIN, 2);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, MSG_GOSSIP_TEXT_MORTH_GNOME_FEMALE, GOSSIP_SENDER_MAIN, 3);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, MSG_GOSSIP_TEXT_MORTH_HUMAN_MALE, GOSSIP_SENDER_MAIN, 4);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, MSG_GOSSIP_TEXT_MORTH_HUMAN_FEMALE, GOSSIP_SENDER_MAIN, 5);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, MSG_GOSSIP_TEXT_MORTH_BLOOD_ELF_MALE, GOSSIP_SENDER_MAIN, 6);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, MSG_GOSSIP_TEXT_MORTH_BLOOD_ELF_FEMALE, GOSSIP_SENDER_MAIN, 7);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, MSG_GOSSIP_TEXT_MORTH_TAUREN_MALE, GOSSIP_SENDER_MAIN, 8);
            AddGossipItemFor(player, GOSSIP_ICON_INTERACT_1, MSG_GOSSIP_TEXT_MORTH_TAUREN_FEMALE, GOSSIP_SENDER_MAIN, 9);
            SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, me);
            return true;
        }

        bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
        {
            if (!player->getAttackers().empty())
            {
                creature->Whisper(MSG_ERR_INCOMBAT, LANG_UNIVERSAL, player);
                ClearGossipMenuFor(player);
                return false;
            }
            switch (action)
            {
            case 2:
                player->SetDisplayId(20580);
                ClearGossipMenuFor(player);
                break;
            case 3:
                player->SetDisplayId(20320);
                ClearGossipMenuFor(player);
                break;
            case 4:
                player->SetDisplayId(15833);
                ClearGossipMenuFor(player);
                break;
            case 5:
                player->SetDisplayId(25056);
                ClearGossipMenuFor(player);
                break;
            case 6:
                player->SetDisplayId(20368);
                ClearGossipMenuFor(player);
                break;
            case 7:
                player->SetDisplayId(20370);
                ClearGossipMenuFor(player);
                break;
            case 8:
                player->SetDisplayId(20319);
                ClearGossipMenuFor(player);
                break;
            case 9:
                player->SetDisplayId(20584);
                ClearGossipMenuFor(player);
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

void AddSC_npc_morph()
{
    new npc_morph;
}
