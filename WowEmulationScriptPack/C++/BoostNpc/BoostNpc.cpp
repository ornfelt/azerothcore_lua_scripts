/* 
-- IN AUTH
CREATE TABLE IF NOT EXISTS `account_free_character` (
  `id` bigint(20) DEFAULT NULL,
  `character` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (190007, 0, 0, 0, 0, 0, 29348, 0, 0, 0, 'Token Giver', 'i80 boost', 'Speak', 0, 80, 80, 2, 35, 3, 1, 1.14286, 1, 0, 0, 2000, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 7, 138936390, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 'npc_tokengiver_i80', 12340);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (190008, 0, 0, 0, 0, 0, 29348, 0, 0, 0, 'PVE Boost', 'changeme', 'Speak', 0, 80, 80, 2, 35, 3, 1, 1.14286, 1, 0, 0, 2000, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 7, 138936390, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 'npc_free_pve_character', 12340);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (190009, 0, 0, 0, 0, 0, 29348, 0, 0, 0, 'PVP Boost', 'changeme', 'Speak', 0, 80, 80, 2, 35, 3, 1, 1.14286, 1, 0, 0, 2000, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 7, 138936390, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 'npc_free_pvp_character', 12340);

*/
#include "ScriptPCH.h"
#include "ScriptMgr.h"
#include "Channel.h"
#include "Guild.h"
#include "Group.h"

class npc_free_pvp_character : public CreatureScript
{
public:
    npc_free_pvp_character() : CreatureScript("npc_free_pvp_character") { }

    void PremahniPredmetiteNa(Player* player)
    {
        player->DestroyItemCount(111111, 1, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HEAD, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_SHOULDERS, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_CHEST, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_LEGS, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HANDS, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_RANGED, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_NECK, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_TABARD, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WRISTS, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FINGER1, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WAIST, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FEET, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_BACK, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FINGER2, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_TRINKET1, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_TRINKET2, true);

    }

    void DobaviMagiiNaGeroq(Player* player)
    {
        switch (player->getClass())
        {
        case CLASS_WARRIOR:
            player->learnSpell(264);
            player->learnSpell(5011);
            player->learnSpell(15590);
            player->learnSpell(266);
            player->learnSpell(200);
            player->learnSpell(227);
            player->learnSpell(199);
            player->UpdateSkillsToMaxSkillsForLevel();
            player->learnSpell(7384);
            player->learnSpell(47436);
            player->learnSpell(47450);
            player->learnSpell(11578);
            player->learnSpell(47465);
            player->learnSpell(47502);
            player->learnSpell(34428);
            player->learnSpell(1715);
            player->learnSpell(2687);
            player->learnSpell(71);
            player->learnSpell(7386);
            player->learnSpell(355);
            player->learnSpell(72);
            player->learnSpell(47437);
            player->learnSpell(57823);
            player->learnSpell(694);
            player->learnSpell(2565);
            player->learnSpell(676);
            player->learnSpell(47520);
            player->learnSpell(20230);
            player->learnSpell(12678);
            player->learnSpell(47471);
            player->learnSpell(1161);
            player->learnSpell(871);
            player->learnSpell(2458);
            player->learnSpell(20252);
            player->learnSpell(47475);
            player->learnSpell(18499);
            player->learnSpell(1680);
            player->learnSpell(6552);
            player->learnSpell(47488);
            player->learnSpell(1719);
            player->learnSpell(23920);
            player->learnSpell(47440);
            player->learnSpell(3411);
            player->learnSpell(64382);
            player->learnSpell(55694);
            player->learnSpell(57755);
            player->learnSpell(42459);
            player->learnSpell(750);
            player->learnSpell(5246);
            player->learnSpell(3127);
            player->learnSpell(34093);
            player->learnSpell(33392);
            break;

        case CLASS_PALADIN:
            player->learnSpell(196);
            player->learnSpell(200);
            player->learnSpell(197);
            player->learnSpell(199);
            player->UpdateSkillsToMaxSkillsForLevel();
            player->learnSpell(3127);
            player->learnSpell(19746);
            player->learnSpell(19752);
            player->learnSpell(750);
            player->learnSpell(48942);
            player->learnSpell(48782);
            player->learnSpell(48932);
            player->learnSpell(20271);
            player->learnSpell(498);
            player->learnSpell(10308);
            player->learnSpell(1152);
            player->learnSpell(10278);
            player->learnSpell(48788);
            player->learnSpell(53408);
            player->learnSpell(48950);
            player->learnSpell(48936);
            player->learnSpell(31789);
            player->learnSpell(62124);
            player->learnSpell(54043);
            player->learnSpell(25780);
            player->learnSpell(1044);
            player->learnSpell(20217);
            player->learnSpell(48819);
            player->learnSpell(48801);
            player->learnSpell(48785);
            player->learnSpell(5502);
            player->learnSpell(20164);
            player->learnSpell(10326);
            player->learnSpell(1038);
            player->learnSpell(53407);
            player->learnSpell(48943);
            player->learnSpell(20165);
            player->learnSpell(48945);
            player->learnSpell(642);
            player->learnSpell(48947);
            player->learnSpell(20166);
            player->learnSpell(4987);
            player->learnSpell(48806);
            player->learnSpell(6940);
            player->learnSpell(48817);
            player->learnSpell(48934);
            player->learnSpell(48938);
            player->learnSpell(25898);
            player->learnSpell(32223);
            player->learnSpell(31884);
            player->learnSpell(54428);
            player->learnSpell(61411);
            player->learnSpell(53601);
            player->learnSpell(33388);
            player->learnSpell(33391);
            player->learnSpell(34093);
            player->learnSpell(33392);
            if (player->HasSpell(20925))
                player->learnSpell(48952);
            if (player->HasSpell(31935))
                player->learnSpell(48827);
            if (player->HasSpell(20911))
                player->learnSpell(25899);
            if (player->HasSpell(20473))
                player->learnSpell(48825);
            if (player->GetTeamId() == ALLIANCE)
            {
                player->learnSpell(31801);
                player->learnSpell(13819);
                player->learnSpell(23214);
            }
            if (player->GetTeamId() == HORDE)
            {
                player->learnSpell(53736);
                player->learnSpell(34769);
                player->learnSpell(34767);
            }
            break;

        case CLASS_HUNTER:
            player->learnSpell(5011);
            player->learnSpell(15590);
            player->learnSpell(266);
            player->learnSpell(200);
            player->learnSpell(227);
            player->learnSpell(2567);
            player->learnSpell(202);
            player->UpdateSkillsToMaxSkillsForLevel();
            player->learnSpell(3043);
            player->learnSpell(3127);
            player->learnSpell(3045);
            player->learnSpell(3034);
            player->learnSpell(8737);
            player->learnSpell(1494);
            player->learnSpell(13163);
            player->learnSpell(48996);
            player->learnSpell(49001);
            player->learnSpell(49045);
            player->learnSpell(53338);
            player->learnSpell(5116);
            player->learnSpell(27044);
            player->learnSpell(883);
            player->learnSpell(2641);
            player->learnSpell(6991);
            player->learnSpell(982);
            player->learnSpell(1515);
            player->learnSpell(19883);
            player->learnSpell(20736);
            player->learnSpell(48990);
            player->learnSpell(2974);
            player->learnSpell(6197);
            player->learnSpell(1002);
            player->learnSpell(14327);
            player->learnSpell(5118);
            player->learnSpell(49056);
            player->learnSpell(53339);
            player->learnSpell(49048);
            player->learnSpell(19884);
            player->learnSpell(34074);
            player->learnSpell(781);
            player->learnSpell(14311);
            player->learnSpell(1462);
            player->learnSpell(19885);
            player->learnSpell(19880);
            player->learnSpell(13809);
            player->learnSpell(13161);
            player->learnSpell(5384);
            player->learnSpell(1543);
            player->learnSpell(19878);
            player->learnSpell(49067);
            player->learnSpell(3034);
            player->learnSpell(13159);
            player->learnSpell(19882);
            player->learnSpell(58434);
            player->learnSpell(49071);
            player->learnSpell(49052);
            player->learnSpell(19879);
            player->learnSpell(19263);
            player->learnSpell(19801);
            player->learnSpell(34026);
            player->learnSpell(34600);
            player->learnSpell(34477);
            player->learnSpell(61006);
            player->learnSpell(61847);
            player->learnSpell(53271);
            player->learnSpell(60192);
            player->learnSpell(62757);
            player->learnSpell(34093);
            player->learnSpell(33392);
            break;

        case CLASS_MAGE:
            player->learnSpell(1180);
            player->learnSpell(201);
            player->UpdateSkillsToMaxSkillsForLevel();
            player->learnSpell(42921);
            player->learnSpell(42842);
            player->learnSpell(42995);
            player->learnSpell(42833);
            player->learnSpell(27090);
            player->learnSpell(33717);
            player->learnSpell(42873);
            player->learnSpell(42846);
            player->learnSpell(12826);
            player->learnSpell(28271);
            player->learnSpell(61780);
            player->learnSpell(61721);
            player->learnSpell(28272);
            player->learnSpell(42917);
            player->learnSpell(43015);
            player->learnSpell(130);
            player->learnSpell(42926);
            player->learnSpell(43017);
            player->learnSpell(475);
            player->learnSpell(1953);
            player->learnSpell(42940);
            player->learnSpell(12051);
            player->learnSpell(43010);
            player->learnSpell(43020);
            player->learnSpell(43012);
            player->learnSpell(42859);
            player->learnSpell(2139);
            player->learnSpell(42931);
            player->learnSpell(42985);
            player->learnSpell(43008);
            player->learnSpell(45438);
            player->learnSpell(43024);
            player->learnSpell(43002);
            player->learnSpell(43046);
            player->learnSpell(42897);
            player->learnSpell(42914);
            player->learnSpell(66);
            player->learnSpell(58659);
            player->learnSpell(30449);
            player->learnSpell(42956);
            player->learnSpell(47610);
            player->learnSpell(61316);
            player->learnSpell(61024);
            player->learnSpell(55342);
            player->learnSpell(53142);
            player->learnSpell(7301);
            player->learnSpell(34093);
            player->learnSpell(33392);
            if (player->GetTeamId() == ALLIANCE)
            {
                player->learnSpell(32271); // Teleport: Exodar.
                player->learnSpell(49359); // Teleport: Theramore.
                player->learnSpell(3565); // Teleport: Darnassus.
                player->learnSpell(33690); // Teleport: Shattrath.
                player->learnSpell(3562); // Teleport: Ironforge.
                player->learnSpell(3561); // Teleport: Stormwind.
                player->learnSpell(53140); // Teleport: Dalaran.
                player->learnSpell(53142); // Portal: Dalaran.
                player->learnSpell(10059); // Portal: Stormwind.
                player->learnSpell(11419); // Portal: Darnassus.
                player->learnSpell(32266); // Portal: Exodar.
                player->learnSpell(11416); // Portal: Ironforge.
                player->learnSpell(33691); // Portal: Shattrath.
                player->learnSpell(49360); // Portal: Theramore.
            }
            if (player->GetTeamId() == HORDE)
            {
                player->learnSpell(3567); // Teleport: Orgrimmar.
                player->learnSpell(35715); // Teleport: Shattrath.
                player->learnSpell(3566); // Teleport: Thunder Bluff.
                player->learnSpell(49358); // Teleport: Stonard.
                player->learnSpell(32272); // Teleport: Silvermoon.
                player->learnSpell(3563); // Teleport: Undercity.
                player->learnSpell(53140); // Teleport: Dalaran.
                player->learnSpell(53142); // Portal: Dalaran.
                player->learnSpell(11417); // Portal: Orgrimmar.
                player->learnSpell(35717); // Portal: Shattrath.
                player->learnSpell(32267); // Portal: Silvermoon.
                player->learnSpell(49361); // Portal: Stonard.
                player->learnSpell(11420); // Portal: Thunder Bluff.
                player->learnSpell(11418); // Portal: Undercity.
            }
            break;

        case CLASS_WARLOCK:
            player->learnSpell(201);
            player->UpdateSkillsToMaxSkillsForLevel();
            player->learnSpell(696);
            player->learnSpell(47811);
            player->learnSpell(47809);
            player->learnSpell(688);
            player->learnSpell(47813);
            player->learnSpell(50511);
            player->learnSpell(57946);
            player->learnSpell(47864);
            player->learnSpell(6215);
            player->learnSpell(47878);
            player->learnSpell(47855);
            player->learnSpell(697);
            player->learnSpell(47856);
            player->learnSpell(47857);
            player->learnSpell(5697);
            player->learnSpell(47884);
            player->learnSpell(47815);
            player->learnSpell(47889);
            player->learnSpell(47820);
            player->learnSpell(698);
            player->learnSpell(712);
            player->learnSpell(126);
            player->learnSpell(5138);
            player->learnSpell(5500);
            player->learnSpell(11719);
            player->learnSpell(132);
            player->learnSpell(60220);
            player->learnSpell(18647);
            player->learnSpell(61191);
            player->learnSpell(47823);
            player->learnSpell(691);
            player->learnSpell(47865);
            player->learnSpell(47891);
            player->learnSpell(47888);
            player->learnSpell(17928);
            player->learnSpell(47860);
            player->learnSpell(47825);
            player->learnSpell(1122);
            player->learnSpell(47867);
            player->learnSpell(18540);
            player->learnSpell(47893);
            player->learnSpell(47838);
            player->learnSpell(29858);
            player->learnSpell(58887);
            player->learnSpell(47836);
            player->learnSpell(61290);
            player->learnSpell(48018);
            player->learnSpell(48020);
            player->learnSpell(33388);
            player->learnSpell(33391);
            player->learnSpell(23161);
            player->learnSpell(34093);
            player->learnSpell(33392);
            break;

        case CLASS_ROGUE:
            player->learnSpell(196);
            player->learnSpell(264);
            player->learnSpell(5011);
            player->learnSpell(15590);
            player->learnSpell(266);
            player->learnSpell(198);
            player->learnSpell(201);
            player->UpdateSkillsToMaxSkillsForLevel();
            player->learnSpell(3127);
            player->learnSpell(42459);
            player->learnSpell(48668);
            player->learnSpell(48638);
            player->learnSpell(1784);
            player->learnSpell(48657);
            player->learnSpell(921);
            player->learnSpell(1776);
            player->learnSpell(26669);
            player->learnSpell(51724);
            player->learnSpell(6774);
            player->learnSpell(11305);
            player->learnSpell(1766);
            player->learnSpell(48676);
            player->learnSpell(48659);
            player->learnSpell(1804);
            player->learnSpell(8647);
            player->learnSpell(48691);
            player->learnSpell(51722);
            player->learnSpell(48672);
            player->learnSpell(1725);
            player->learnSpell(26889);
            player->learnSpell(2836);
            player->learnSpell(1833);
            player->learnSpell(1842);
            player->learnSpell(8643);
            player->learnSpell(2094);
            player->learnSpell(1860);
            player->learnSpell(57993);
            player->learnSpell(48674);
            player->learnSpell(31224);
            player->learnSpell(5938);
            player->learnSpell(57934);
            player->learnSpell(51723);
            player->learnSpell(34093);
            player->learnSpell(33392);
            break;

        case CLASS_PRIEST:
            player->learnSpell(1180);
            player->UpdateSkillsToMaxSkillsForLevel();
            player->learnSpell(528);
            player->learnSpell(2053);
            player->learnSpell(48161);
            player->learnSpell(48123);
            player->learnSpell(48125);
            player->learnSpell(48066);
            player->learnSpell(586);
            player->learnSpell(48068);
            player->learnSpell(48127);
            player->learnSpell(48171);
            player->learnSpell(48168);
            player->learnSpell(10890);
            player->learnSpell(6064);
            player->learnSpell(988);
            player->learnSpell(48300);
            player->learnSpell(6346);
            player->learnSpell(48071);
            player->learnSpell(48135);
            player->learnSpell(48078);
            player->learnSpell(453);
            player->learnSpell(10955);
            player->learnSpell(10909);
            player->learnSpell(8129);
            player->learnSpell(48073);
            player->learnSpell(605);
            player->learnSpell(48072);
            player->learnSpell(48169);
            player->learnSpell(552);
            player->learnSpell(1706);
            player->learnSpell(48063);
            player->learnSpell(48162);
            player->learnSpell(48170);
            player->learnSpell(48074);
            player->learnSpell(48158);
            player->learnSpell(48120);
            player->learnSpell(34433);
            player->learnSpell(48113);
            player->learnSpell(32375);
            player->learnSpell(64843);
            player->learnSpell(64901);
            player->learnSpell(53023);
            player->learnSpell(34093);
            player->learnSpell(33392);
            player->PlayerTalkClass->SendCloseGossip();
            break;

        case CLASS_DEATH_KNIGHT:
            player->learnSpell(198);
            player->learnSpell(199);
            player->UpdateSkillsToMaxSkillsForLevel();
            player->learnSpell(3127);
            player->learnSpell(50842);
            player->learnSpell(49941);
            player->learnSpell(49930);
            player->learnSpell(47476);
            player->learnSpell(45529);
            player->learnSpell(3714);
            player->learnSpell(56222);
            player->learnSpell(48743);
            player->learnSpell(48263);
            player->learnSpell(49909);
            player->learnSpell(47528);
            player->learnSpell(45524);
            player->learnSpell(48792);
            player->learnSpell(57623);
            player->learnSpell(56815);
            player->learnSpell(47568);
            player->learnSpell(49895);
            player->learnSpell(50977);
            player->learnSpell(49576);
            player->learnSpell(49921);
            player->learnSpell(46584);
            player->learnSpell(49938);
            player->learnSpell(48707);
            player->learnSpell(48265);
            player->learnSpell(61999);
            player->learnSpell(42650);
            player->learnSpell(53428);
            player->learnSpell(53331);
            player->learnSpell(54447);
            player->learnSpell(53342);
            player->learnSpell(54446);
            player->learnSpell(53323);
            player->learnSpell(53344);
            player->learnSpell(70164);
            player->learnSpell(62158);
            player->learnSpell(33391);
            player->learnSpell(48778);
            player->learnSpell(51425);
            player->learnSpell(49924);
            player->learnSpell(34093);
            player->learnSpell(33392);
            player->PlayerTalkClass->SendCloseGossip();
            break;

        case CLASS_SHAMAN:
            player->learnSpell(196);
            player->learnSpell(1180);
            player->learnSpell(15590);
            player->learnSpell(197);
            player->learnSpell(199);
            player->UpdateSkillsToMaxSkillsForLevel();
            player->learnSpell(2062);
            player->learnSpell(8737);
            player->learnSpell(49273);
            player->learnSpell(49238);
            player->learnSpell(10399);
            player->learnSpell(49231);
            player->learnSpell(58753);
            player->learnSpell(2484);
            player->learnSpell(49281);
            player->learnSpell(58582);
            player->learnSpell(49233);
            player->learnSpell(58790);
            player->learnSpell(58704);
            player->learnSpell(58643);
            player->learnSpell(49277);
            player->learnSpell(61657);
            player->learnSpell(8012);
            player->learnSpell(526);
            player->learnSpell(2645);
            player->learnSpell(57994);
            player->learnSpell(8143);
            player->learnSpell(49236);
            player->learnSpell(58796);
            player->learnSpell(58757);
            player->learnSpell(49276);
            player->learnSpell(57960);
            player->learnSpell(131);
            player->learnSpell(58745);
            player->learnSpell(6196);
            player->learnSpell(58734);
            player->learnSpell(58774);
            player->learnSpell(58739);
            player->learnSpell(58656);
            player->learnSpell(546);
            player->learnSpell(556);
            player->learnSpell(66842);
            player->learnSpell(51994);
            player->learnSpell(8177);
            player->learnSpell(58749);
            player->learnSpell(20608);
            player->learnSpell(36936);
            player->learnSpell(36936);
            player->learnSpell(58804);
            player->learnSpell(49271);
            player->learnSpell(8512);
            player->learnSpell(6495);
            player->learnSpell(8170);
            player->learnSpell(66843);
            player->learnSpell(55459);
            player->learnSpell(66844);
            player->learnSpell(3738);
            player->learnSpell(2894);
            player->learnSpell(60043);
            player->learnSpell(51514);
            player->learnSpell(34093);
            player->learnSpell(33392);
            if (player->GetTeamId() == ALLIANCE)
                player->learnSpell(32182);
            if (player->GetTeamId() == HORDE)
                player->learnSpell(2825);
            break;

        case CLASS_DRUID:
            player->learnSpell(1180);
            player->learnSpell(15590);
            player->learnSpell(200);
            player->learnSpell(199);
            player->UpdateSkillsToMaxSkillsForLevel();
            player->learnSpell(48378);
            player->learnSpell(48469);
            player->learnSpell(48461);
            player->learnSpell(48463);
            player->learnSpell(48441);
            player->learnSpell(53307);
            player->learnSpell(53308);
            player->learnSpell(5487);
            player->learnSpell(48560);
            player->learnSpell(6795);
            player->learnSpell(48480);
            player->learnSpell(53312);
            player->learnSpell(18960);
            player->learnSpell(5229);
            player->learnSpell(48443);
            player->learnSpell(50763);
            player->learnSpell(8983);
            player->learnSpell(8946);
            player->learnSpell(1066);
            player->learnSpell(48562);
            player->learnSpell(783);
            player->learnSpell(770);
            player->learnSpell(16857);
            player->learnSpell(18658);
            player->learnSpell(768);
            player->learnSpell(1082);
            player->learnSpell(16979);
            player->learnSpell(49376);
            player->learnSpell(5215);
            player->learnSpell(48477);
            player->learnSpell(49800);
            player->learnSpell(48465);
            player->learnSpell(48572);
            player->learnSpell(26995);
            player->learnSpell(48574);
            player->learnSpell(2782);
            player->learnSpell(50213);
            player->learnSpell(2893);
            player->learnSpell(33357);
            player->learnSpell(5209);
            player->learnSpell(48575);
            player->learnSpell(48447);
            player->learnSpell(48577);
            player->learnSpell(48579);
            player->learnSpell(5225);
            player->learnSpell(22842);
            player->learnSpell(49803);
            player->learnSpell(9634);
            player->learnSpell(20719);
            player->learnSpell(48467);
            player->learnSpell(29166);
            player->learnSpell(62600);
            player->learnSpell(22812);
            player->learnSpell(48470);
            player->learnSpell(48564);
            player->learnSpell(48566);
            player->learnSpell(33943);
            player->learnSpell(49802);
            player->learnSpell(48451);
            player->learnSpell(48568);
            player->learnSpell(33786);
            player->learnSpell(40120);
            player->learnSpell(62078);
            player->learnSpell(52610);
            player->learnSpell(50464);
            player->learnSpell(48570);
            player->learnSpell(34093);
            player->learnSpell(33392);
            break;

        default:
            // TC_LOG_INFO("server.worldserver", "ERROR #DEFAULT [1]");
            break;
        }
    }

    void DobaviBokluciNaGeroq(Player* player)
    {
        player->SetLevel(80);
        player->ModifyMoney(player->GetMoney() + 2000000); // dobavi 200g
        player->AddItem(41599, 4); // 4 torbi (frostweave)
        player->AddItem(21215, 20); // 20x graccu hrana
        player->learnSpell(34091); // master riding
        player->learnSpell(54197); // cold weather
    }

    bool OnGossipHello(Player *player, Creature *_creature)
    {
        if (!sWorld->getBoolConfig(CUSTOM_SCRIPTS_ENABLED_OR_NOT))
            return false;

        if (player->IsInCombat()) // chceck if player is in combat
        {
            player->GetSession()->SendNotification("Leave combat first!");
            // TC_LOG_INFO("server.worldserver", "combat");
            player->PlayerTalkClass->SendCloseGossip();
            return false;
        }
        // TC_LOG_INFO("server.worldserver", "#1");

        if (player->getLevel() > 1) // check if his level is higher than 1
        {
            // TC_LOG_INFO("server.worldserver", "level 1");
            player->GetSession()->SendNotification("You must be level 1 in order to use this NPC!");
            player->PlayerTalkClass->SendCloseGossip();
            return false;
        }
        // TC_LOG_INFO("server.worldserver", "#2");

        if (!player->HasItemCount(111111, 1, true))
        {
            // TC_LOG_INFO("server.worldserver", "no TOKEN");
            return false;
        }
        // TC_LOG_INFO("server.worldserver", "#3");
        switch (player->getClass())
        {
            case CLASS_DEATH_KNIGHT:
                player->ADD_GOSSIP_ITEM(3, "[|cffFF0000PvP|r][DPS] Furious Gladiator + Offset", GOSSIP_SENDER_MAIN, 3);
                break;
            case CLASS_DRUID:
                player->ADD_GOSSIP_ITEM(3, "[|cffFF0000PvP|r][DPS/Balance] Furious Gladiator + Offset", GOSSIP_SENDER_MAIN, 5);
                player->ADD_GOSSIP_ITEM(3, "[|cffFF0000PvP|r][DPS/Feral] Furious Gladiator + Offset", GOSSIP_SENDER_MAIN, 6);
                player->ADD_GOSSIP_ITEM(3, "[|cffFF0000PvP|r][Healer] Furious Gladiator + Offset", GOSSIP_SENDER_MAIN, 7);
                break;
            case CLASS_PALADIN:
                player->ADD_GOSSIP_ITEM(3, "[|cffFF0000PvP|r][DPS] Furious Gladiator + Offset", GOSSIP_SENDER_MAIN, 9);
                player->ADD_GOSSIP_ITEM(3, "[|cffFF0000PvP|r][Healer] Furious Gladiator + Offset", GOSSIP_SENDER_MAIN, 10);
                break;
            case CLASS_PRIEST:
                player->ADD_GOSSIP_ITEM(3, "[|cffFF0000PvP|r][DPS] Furious Gladiator + Offset", GOSSIP_SENDER_MAIN, 11);
                player->ADD_GOSSIP_ITEM(3, "[|cffFF0000PvP|r][Healer] Furious Gladiator + Offset", GOSSIP_SENDER_MAIN, 12);
                break;
            case CLASS_HUNTER:
                player->ADD_GOSSIP_ITEM(3, "[|cffFF0000PvP|r][DPS] Furious Gladiator + Offset", GOSSIP_SENDER_MAIN, 13);
                break;
            case CLASS_ROGUE:
                player->ADD_GOSSIP_ITEM(3, "[|cffFF0000PvP|r][DPS] Furious Gladiator + Offset", GOSSIP_SENDER_MAIN, 14);
                break;
            case CLASS_MAGE:
                player->ADD_GOSSIP_ITEM(3, "[|cffFF0000PvP|r][DPS] Furious Gladiator + Offset", GOSSIP_SENDER_MAIN, 15);
                break;
            case CLASS_SHAMAN:
                player->ADD_GOSSIP_ITEM(3, "[|cffFF0000PvP|r][DPS/Ele] Furious Gladiator + Offset", GOSSIP_SENDER_MAIN, 16);
                player->ADD_GOSSIP_ITEM(3, "[|cffFF0000PvP|r][DPS/Enh] Furious Gladiator + Offset", GOSSIP_SENDER_MAIN, 17);
                player->ADD_GOSSIP_ITEM(3, "[|cffFF0000PvP|r][Healer] Furious Gladiator + Offset", GOSSIP_SENDER_MAIN, 18);
                break;
            case CLASS_WARRIOR:
                player->ADD_GOSSIP_ITEM(3, "[|cffFF0000PvP|r][DPS] Furious Gladiator + Offset", GOSSIP_SENDER_MAIN, 20);
                break;
            case CLASS_WARLOCK:
                player->ADD_GOSSIP_ITEM(3, "[|cffFF0000PvP|r][DPS] Furious Gladiator + Offset", GOSSIP_SENDER_MAIN, 21);
                break;

            default:
                break;
        }
        // TC_LOG_INFO("server.worldserver", "#4");
        player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, _creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player *player, Creature *_creature, uint32 sender, uint32 uiAction)
    {
        PremahniPredmetiteNa(player);

        bool eligible = true;

        if (sender == GOSSIP_SENDER_MAIN)
        {
            player->PlayerTalkClass->ClearMenus();
            switch (uiAction)
            {
            case 3: // DK @ DPS
                    player->EquipNewItem(SLOT_CHEST, 40787, true);
                    player->EquipNewItem(SLOT_LEGS, 40848, true);
                    player->EquipNewItem(SLOT_HEAD, 40827, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 40868, true);
                    player->EquipNewItem(SLOT_HANDS, 40809, true);

                    player->EquipNewItem(SLOT_MAIN_HAND, 42333, true);
                    player->EquipNewItem(SLOT_RANGED, 42621, true);

                    player->EquipNewItem(SLOT_NECK, 42034, true);
                    player->EquipNewItem(SLOT_WRISTS, 40889, true);
                    player->EquipNewItem(SLOT_WAIST, 40881, true);
                    player->EquipNewItem(SLOT_FEET, 40882, true);
                    player->EquipNewItem(SLOT_BACK, 42074, true);

                    player->EquipNewItem(SLOT_FINGER1, 42117, true);
                    player->EquipNewItem(SLOT_FINGER2, 42119, true);

                    player->EquipNewItem(SLOT_TRINKET1, 42136, true);
                    if (player->GetTeamId() == HORDE)
                        player->EquipNewItem(SLOT_TRINKET2, 42122, true); // horde insignia
                    else
                        player->EquipNewItem(SLOT_TRINKET2, 42123, true); // alliance insignia

                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;
            case 5: // DRUID @ DPS @ BALANCE
                    player->EquipNewItem(SLOT_CHEST, 41316, true);
                    player->EquipNewItem(SLOT_LEGS, 41304, true);
                    player->EquipNewItem(SLOT_HEAD, 41327, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 41281, true);
                    player->EquipNewItem(SLOT_HANDS, 41293, true);

                    player->EquipNewItem(SLOT_MAIN_HAND, 45955, true);
                    player->EquipNewItem(SLOT_RANGED, 42584, true);

                    player->EquipNewItem(SLOT_NECK, 42043, true);
                    //player->EquipNewItem(SLOT_TABARD, 0000000, true);
                    player->EquipNewItem(SLOT_WRISTS, 41641, true);
                    player->EquipNewItem(SLOT_WAIST, 41631, true);
                    player->EquipNewItem(SLOT_FEET, 41636, true);
                    player->EquipNewItem(SLOT_BACK, 42076, true);

                    player->EquipNewItem(SLOT_FINGER1, 42118, true);
                    player->EquipNewItem(SLOT_FINGER2, 42116, true);
                    player->EquipNewItem(SLOT_TRINKET1, 42133, true);
                    if (player->GetTeamId() == HORDE)
                        player->EquipNewItem(SLOT_TRINKET2, 42122, true); // horde insignia
                    else
                        player->EquipNewItem(SLOT_TRINKET2, 42123, true); // alliance insignia
                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;
            case 6: // DRUID @ DPS @ FERAL
                    player->EquipNewItem(SLOT_CHEST, 41661, true);
                    player->EquipNewItem(SLOT_LEGS, 41667, true);
                    player->EquipNewItem(SLOT_HEAD, 41678, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 41715, true);
                    player->EquipNewItem(SLOT_HANDS, 41773, true);

                    player->EquipNewItem(SLOT_MAIN_HAND, 42328, true);
                    player->EquipNewItem(SLOT_RANGED, 42589, true);

                    player->EquipNewItem(SLOT_NECK, 42034, true);
                    player->EquipNewItem(SLOT_WRISTS, 41840, true);
                    player->EquipNewItem(SLOT_WAIST, 41832, true);
                    player->EquipNewItem(SLOT_FEET, 41836, true);
                    player->EquipNewItem(SLOT_BACK, 42074, true);

                    player->EquipNewItem(SLOT_FINGER1, 42117, true);
                    player->EquipNewItem(SLOT_FINGER2, 42119, true);

                    player->EquipNewItem(SLOT_TRINKET1, 42136, true);
                    if (player->GetTeamId() == HORDE)
                        player->EquipNewItem(SLOT_TRINKET2, 42122, true); // horde insignia
                    else
                        player->EquipNewItem(SLOT_TRINKET2, 42123, true); // alliance insignia
                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;
            case 7: // DRUID @ RESTORATION
                    player->EquipNewItem(SLOT_CHEST, 41316, true);
                    player->EquipNewItem(SLOT_LEGS, 41298, true);
                    player->EquipNewItem(SLOT_HEAD, 41321, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 41275, true);
                    player->EquipNewItem(SLOT_HANDS, 41287, true);

                    player->EquipNewItem(SLOT_MAIN_HAND, 42385, true);
                    player->EquipNewItem(SLOT_RANGED, 42579, true);

                    player->EquipNewItem(SLOT_NECK, 42043, true);
                    //player->EquipNewItem(SLOT_TABARD, 0000000, true);
                    player->EquipNewItem(SLOT_WRISTS, 41641, true);
                    player->EquipNewItem(SLOT_WAIST, 41631, true);
                    player->EquipNewItem(SLOT_FEET, 41636, true);
                    player->EquipNewItem(SLOT_BACK, 42076, true);

                    player->EquipNewItem(SLOT_FINGER1, 42118, true);
                    player->EquipNewItem(SLOT_FINGER2, 42116, true);
                    player->EquipNewItem(SLOT_TRINKET1, 42133, true);
                    if (player->GetTeamId() == HORDE)
                        player->EquipNewItem(SLOT_TRINKET2, 42122, true); // horde insignia
                    else
                        player->EquipNewItem(SLOT_TRINKET2, 42123, true); // alliance insignia
                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;
            case 9: // paladin @ dps
                    player->EquipNewItem(SLOT_CHEST, 40788, true);
                    player->EquipNewItem(SLOT_LEGS, 40849, true);
                    player->EquipNewItem(SLOT_HEAD, 40828, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 40869, true);
                    player->EquipNewItem(SLOT_HANDS, 40808, true);

                    player->EquipNewItem(SLOT_MAIN_HAND, 45949, true);
                    player->EquipNewItem(SLOT_RANGED, 42853, true);

                    player->EquipNewItem(SLOT_NECK, 42034, true);
                    player->EquipNewItem(SLOT_WRISTS, 40889, true);
                    player->EquipNewItem(SLOT_WAIST, 40881, true);
                    player->EquipNewItem(SLOT_FEET, 40882, true);
                    player->EquipNewItem(SLOT_BACK, 42074, true);

                    player->EquipNewItem(SLOT_FINGER1, 42117, true);
                    player->EquipNewItem(SLOT_FINGER2, 42119, true);

                    player->EquipNewItem(SLOT_TRINKET1, 42136, true);
                    if (player->GetTeamId() == HORDE)
                        player->EquipNewItem(SLOT_TRINKET2, 42122, true); // horde insignia
                    else
                        player->EquipNewItem(SLOT_TRINKET2, 42123, true); // alliance insignia
                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;
            case 10: // paladin @ healer
                    player->EquipNewItem(SLOT_CHEST, 40907, true);
                    player->EquipNewItem(SLOT_LEGS, 40939, true);
                    player->EquipNewItem(SLOT_HEAD, 40933, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 40963, true);
                    player->EquipNewItem(SLOT_HANDS, 40927, true);

                    player->EquipNewItem(SLOT_MAIN_HAND, 45971, true);
                    player->EquipNewItem(SLOT_OFF_HAND, 42565, true);
                    player->EquipNewItem(SLOT_RANGED, 42616, true);

                    player->EquipNewItem(SLOT_NECK, 42043, true);
                    //player->EquipNewItem(SLOT_TABARD, 0000000, true);
                    player->EquipNewItem(SLOT_WRISTS, 40984, true);
                    player->EquipNewItem(SLOT_WAIST, 40978, true);
                    player->EquipNewItem(SLOT_FEET, 40977, true);
                    player->EquipNewItem(SLOT_BACK, 42076, true);

                    player->EquipNewItem(SLOT_FINGER1, 42116, true);
                    player->EquipNewItem(SLOT_FINGER2, 48999, true);
                    player->EquipNewItem(SLOT_TRINKET1, 42137, true);
                    if (player->GetTeamId() == HORDE)
                        player->EquipNewItem(SLOT_TRINKET2, 42122, true); // horde insignia
                    else
                        player->EquipNewItem(SLOT_TRINKET2, 42123, true); // alliance insignia
                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;
            case 11: // priest @ dps
                    player->EquipNewItem(SLOT_CHEST, 41921, true);
                    player->EquipNewItem(SLOT_LEGS, 41927, true);
                    player->EquipNewItem(SLOT_HEAD, 41915, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 41934, true);
                    player->EquipNewItem(SLOT_HANDS, 41940, true);

                    player->EquipNewItem(SLOT_MAIN_HAND, 45955, true);
                    player->EquipNewItem(SLOT_RANGED, 42503, true);

                    player->EquipNewItem(SLOT_NECK, 42043, true);
                    //player->EquipNewItem(SLOT_TABARD, 0000000, true);
                    player->EquipNewItem(SLOT_WRISTS, 49181, true);
                    player->EquipNewItem(SLOT_WAIST, 41899, true);
                    player->EquipNewItem(SLOT_FEET, 41904, true);
                    player->EquipNewItem(SLOT_BACK, 42076, true);

                    player->EquipNewItem(SLOT_FINGER1, 42118, true);
                    player->EquipNewItem(SLOT_FINGER2, 42116, true);
                    player->EquipNewItem(SLOT_TRINKET1, 42133, true);
                    if (player->GetTeamId() == HORDE)
                        player->EquipNewItem(SLOT_TRINKET2, 42122, true); // horde insignia
                    else
                        player->EquipNewItem(SLOT_TRINKET2, 42123, true); // alliance insignia
                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;
            case 12: // priest @ heal
                    player->EquipNewItem(SLOT_CHEST, 41859, true);
                    player->EquipNewItem(SLOT_LEGS, 41864, true);
                    player->EquipNewItem(SLOT_HEAD, 41854, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 41869, true);
                    player->EquipNewItem(SLOT_HANDS, 41874, true);
                    player->EquipNewItem(SLOT_MAIN_HAND, 42385, true);
                    player->EquipNewItem(SLOT_RANGED, 42514, true);
                    player->EquipNewItem(SLOT_NECK, 42039, true);
                    player->EquipNewItem(SLOT_WRISTS, 41893, true);
                    player->EquipNewItem(SLOT_WAIST, 41881, true);
                    player->EquipNewItem(SLOT_FEET, 41885, true);
                    player->EquipNewItem(SLOT_BACK, 42073, true);
                    player->EquipNewItem(SLOT_FINGER1, 48999, true);
                    player->EquipNewItem(SLOT_FINGER2, 42116, true);
                    player->EquipNewItem(SLOT_TRINKET1, 42137, true);
                    if (player->GetTeamId() == HORDE)
                        player->EquipNewItem(SLOT_TRINKET2, 42122, true); // horde insignia
                    else
                        player->EquipNewItem(SLOT_TRINKET2, 42123, true); // alliance insignia
                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;
            case 13: // hunter @ dps
                    player->EquipNewItem(SLOT_CHEST, 41087, true);
                    player->EquipNewItem(SLOT_LEGS, 41205, true);
                    player->EquipNewItem(SLOT_HEAD, 41157, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 41217, true);
                    player->EquipNewItem(SLOT_HANDS, 41143, true);

                    player->EquipNewItem(SLOT_MAIN_HAND, 42328, true);
                    player->EquipNewItem(SLOT_RANGED, 42491, true);

                    player->EquipNewItem(SLOT_NECK, 42034, true);
                    player->EquipNewItem(SLOT_WRISTS, 41225, true);
                    player->EquipNewItem(SLOT_WAIST, 41235, true);
                    player->EquipNewItem(SLOT_FEET, 41230, true);
                    player->EquipNewItem(SLOT_BACK, 42074, true);

                    player->EquipNewItem(SLOT_FINGER1, 42117, true);
                    player->EquipNewItem(SLOT_FINGER2, 42119, true);

                    player->EquipNewItem(SLOT_TRINKET1, 42136, true);
                    if (player->GetTeamId() == HORDE)
                        player->EquipNewItem(SLOT_TRINKET2, 42122, true); // horde insignia
                    else
                        player->EquipNewItem(SLOT_TRINKET2, 42123, true); // alliance insignia
                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;
            case 14: // rogue @ dps
                    player->EquipNewItem(SLOT_CHEST, 41650, true);
                    player->EquipNewItem(SLOT_LEGS, 41655, true);
                    player->EquipNewItem(SLOT_HEAD, 41672, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 41683, true);
                    player->EquipNewItem(SLOT_HANDS, 41767, true);

                    player->EquipNewItem(SLOT_MAIN_HAND, 42243, true);
                    player->EquipNewItem(SLOT_OFF_HAND, 42243, true);
                    player->EquipNewItem(SLOT_RANGED, 42451, true);

                    player->EquipNewItem(SLOT_NECK, 42034, true);
                    player->EquipNewItem(SLOT_WRISTS, 41840, true);
                    player->EquipNewItem(SLOT_WAIST, 41832, true);
                    player->EquipNewItem(SLOT_FEET, 41836, true);
                    player->EquipNewItem(SLOT_BACK, 42074, true);

                    player->EquipNewItem(SLOT_FINGER1, 42117, true);
                    player->EquipNewItem(SLOT_FINGER2, 42119, true);

                    player->EquipNewItem(SLOT_TRINKET1, 42136, true);
                    if (player->GetTeamId() == HORDE)
                        player->EquipNewItem(SLOT_TRINKET2, 42122, true); // horde insignia
                    else
                        player->EquipNewItem(SLOT_TRINKET2, 42123, true); // alliance insignia
                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;
            case 15: // mage @ dps
                    player->EquipNewItem(SLOT_CHEST, 41953, true);
                    player->EquipNewItem(SLOT_LEGS, 41959, true);
                    player->EquipNewItem(SLOT_HEAD, 41946, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 41965, true);
                    player->EquipNewItem(SLOT_HANDS, 41971, true);

                    player->EquipNewItem(SLOT_MAIN_HAND, 45955, true);
                    player->EquipNewItem(SLOT_RANGED, 42503, true);

                    player->EquipNewItem(SLOT_NECK, 42043, true);
                    //player->EquipNewItem(SLOT_TABARD, 0000000, true);
                    player->EquipNewItem(SLOT_WRISTS, 49181, true);
                    player->EquipNewItem(SLOT_WAIST, 41899, true);
                    player->EquipNewItem(SLOT_FEET, 41904, true);
                    player->EquipNewItem(SLOT_BACK, 42076, true);

                    player->EquipNewItem(SLOT_FINGER1, 42118, true);
                    player->EquipNewItem(SLOT_FINGER2, 42116, true);
                    player->EquipNewItem(SLOT_TRINKET1, 42133, true);
                    if (player->GetTeamId() == HORDE)
                        player->EquipNewItem(SLOT_TRINKET2, 42122, true); // horde insignia
                    else
                        player->EquipNewItem(SLOT_TRINKET2, 42123, true); // alliance insignia
                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;
            case 16: // sham @ dps @ ele
                    player->EquipNewItem(SLOT_CHEST, 40993, true);
                    player->EquipNewItem(SLOT_LEGS, 41033, true);
                    player->EquipNewItem(SLOT_HEAD, 41019, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 41044, true);
                    player->EquipNewItem(SLOT_HANDS, 41007, true);

                    player->EquipNewItem(SLOT_MAIN_HAND, 42364, true);
                    player->EquipNewItem(SLOT_RANGED, 42603, true);

                    player->EquipNewItem(SLOT_NECK, 42043, true);
                    //player->EquipNewItem(SLOT_TABARD, 0000000, true);
                    player->EquipNewItem(SLOT_WRISTS, 41065, true);
                    player->EquipNewItem(SLOT_WAIST, 41070, true);
                    player->EquipNewItem(SLOT_FEET, 41075, true);
                    player->EquipNewItem(SLOT_BACK, 42076, true);

                    player->EquipNewItem(SLOT_FINGER1, 42118, true);
                    player->EquipNewItem(SLOT_FINGER2, 42116, true);
                    player->EquipNewItem(SLOT_TRINKET1, 42133, true);
                    if (player->GetTeamId() == HORDE)
                        player->EquipNewItem(SLOT_TRINKET2, 42122, true); // horde insignia
                    else
                        player->EquipNewItem(SLOT_TRINKET2, 42123, true); // alliance insignia
                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;
            case 17: //  sham @ dps @ enh
                    player->EquipNewItem(SLOT_CHEST, 41081, true);
                    player->EquipNewItem(SLOT_LEGS, 41199, true);
                    player->EquipNewItem(SLOT_HEAD, 41151, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 41211, true);
                    player->EquipNewItem(SLOT_HANDS, 41137, true);

                    player->EquipNewItem(SLOT_MAIN_HAND, 42318, true);
                    player->EquipNewItem(SLOT_RANGED, 42608, true);

                    player->EquipNewItem(SLOT_NECK, 42034, true);
                    player->EquipNewItem(SLOT_WRISTS, 41225, true);
                    player->EquipNewItem(SLOT_WAIST, 41235, true);
                    player->EquipNewItem(SLOT_FEET, 41230, true);
                    player->EquipNewItem(SLOT_BACK, 42074, true);

                    player->EquipNewItem(SLOT_FINGER1, 42117, true);
                    player->EquipNewItem(SLOT_FINGER2, 42119, true);

                    player->EquipNewItem(SLOT_TRINKET1, 42136, true);
                    if (player->GetTeamId() == HORDE)
                        player->EquipNewItem(SLOT_TRINKET2, 42122, true); // horde insignia
                    else
                        player->EquipNewItem(SLOT_TRINKET2, 42123, true); // alliance insignia
                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;
            case 18: // sham @ resto
                    player->EquipNewItem(SLOT_CHEST, 40992, true);
                    player->EquipNewItem(SLOT_LEGS, 41027, true);
                    player->EquipNewItem(SLOT_HEAD, 41013, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 41038, true);
                    player->EquipNewItem(SLOT_HANDS, 41001, true);

                    player->EquipNewItem(SLOT_MAIN_HAND, 45971, true);

                    player->EquipNewItem(SLOT_RANGED, 42598, true);

                    player->EquipNewItem(SLOT_NECK, 42040, true);
                    player->EquipNewItem(SLOT_WRISTS, 41060, true);
                    player->EquipNewItem(SLOT_WAIST, 41051, true);
                    player->EquipNewItem(SLOT_FEET, 41055, true);
                    player->EquipNewItem(SLOT_BACK, 42076, true);

                    player->EquipNewItem(SLOT_FINGER1, 42116, true);
                    player->EquipNewItem(SLOT_FINGER2, 48999, true);
                    player->EquipNewItem(SLOT_TRINKET1, 42137, true);
                    if (player->GetTeamId() == HORDE)
                        player->EquipNewItem(SLOT_TRINKET2, 42122, true); // horde insignia
                    else
                        player->EquipNewItem(SLOT_TRINKET2, 42123, true); // alliance insignia
                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;
            case 20: // warrior @ dps
                    player->EquipNewItem(SLOT_CHEST, 40789, true);
                    player->EquipNewItem(SLOT_LEGS, 40847, true);
                    player->EquipNewItem(SLOT_HEAD, 40826, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 40866, true);
                    player->EquipNewItem(SLOT_HANDS, 40807, true);

                    player->EquipNewItem(SLOT_MAIN_HAND, 45950, true);
                    player->AddItem(45950, 1); // ako iska fury spec, dobavi +1 sword
                    player->EquipNewItem(SLOT_RANGED, 45937, true);

                    player->EquipNewItem(SLOT_NECK, 42034, true);
                    player->EquipNewItem(SLOT_WRISTS, 40889, true);
                    player->EquipNewItem(SLOT_WAIST, 40881, true);
                    player->EquipNewItem(SLOT_FEET, 40882, true);
                    player->EquipNewItem(SLOT_BACK, 42074, true);

                    player->EquipNewItem(SLOT_FINGER1, 42117, true);
                    player->EquipNewItem(SLOT_FINGER2, 42119, true);

                    player->EquipNewItem(SLOT_TRINKET1, 42136, true);
                    if (player->GetTeamId() == HORDE)
                        player->EquipNewItem(SLOT_TRINKET2, 42122, true); // horde insignia
                    else
                        player->EquipNewItem(SLOT_TRINKET2, 42123, true); // alliance insignia
                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;
            case 21: // warlock @ dps
                    player->EquipNewItem(SLOT_CHEST, 41998, true);
                    player->EquipNewItem(SLOT_LEGS, 42005, true);
                    player->EquipNewItem(SLOT_HEAD, 41993, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 42011, true);
                    player->EquipNewItem(SLOT_HANDS, 42017, true);

                    player->EquipNewItem(SLOT_MAIN_HAND, 45955, true);
                    player->EquipNewItem(SLOT_RANGED, 42503, true);

                    player->EquipNewItem(SLOT_NECK, 42043, true);
                    //player->EquipNewItem(SLOT_TABARD, 0000000, true);
                    player->EquipNewItem(SLOT_WRISTS, 49181, true);
                    player->EquipNewItem(SLOT_WAIST, 41899, true);
                    player->EquipNewItem(SLOT_FEET, 41904, true);
                    player->EquipNewItem(SLOT_BACK, 42076, true);

                    player->EquipNewItem(SLOT_FINGER1, 42118, true);
                    player->EquipNewItem(SLOT_FINGER2, 42116, true);
                    player->EquipNewItem(SLOT_TRINKET1, 42133, true);
                    if (player->GetTeamId() == HORDE)
                        player->EquipNewItem(SLOT_TRINKET2, 42122, true); // horde insignia
                    else
                        player->EquipNewItem(SLOT_TRINKET2, 42123, true); // alliance insignia
                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;

            default:
                    // TC_LOG_INFO("server.worldserver", "ERROR (#default)");
                    break;
            }
        }
        return true;
    }
};

class npc_free_pve_character : public CreatureScript
{
public:
    npc_free_pve_character() : CreatureScript("npc_free_pve_character") { }

    void PremahniPredmetiteNa(Player* player)
    {
        player->DestroyItemCount(111111, 1, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HEAD, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_SHOULDERS, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_CHEST, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_LEGS, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HANDS, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_RANGED, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_NECK, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_TABARD, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WRISTS, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FINGER1, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WAIST, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FEET, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_BACK, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FINGER2, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_TRINKET1, true);
        player->DestroyItem(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_TRINKET2, true);

    }

    void DobaviMagiiNaGeroq(Player* player)
    {
        switch (player->getClass())
        {
        case CLASS_WARRIOR:
            player->learnSpell(264);
            player->learnSpell(5011);
            player->learnSpell(15590);
            player->learnSpell(266);
            player->learnSpell(200);
            player->learnSpell(227);
            player->learnSpell(199);
            player->UpdateSkillsToMaxSkillsForLevel();
            player->learnSpell(7384);
            player->learnSpell(47436);
            player->learnSpell(47450);
            player->learnSpell(11578);
            player->learnSpell(47465);
            player->learnSpell(47502);
            player->learnSpell(34428);
            player->learnSpell(1715);
            player->learnSpell(2687);
            player->learnSpell(71);
            player->learnSpell(7386);
            player->learnSpell(355);
            player->learnSpell(72);
            player->learnSpell(47437);
            player->learnSpell(57823);
            player->learnSpell(694);
            player->learnSpell(2565);
            player->learnSpell(676);
            player->learnSpell(47520);
            player->learnSpell(20230);
            player->learnSpell(12678);
            player->learnSpell(47471);
            player->learnSpell(1161);
            player->learnSpell(871);
            player->learnSpell(2458);
            player->learnSpell(20252);
            player->learnSpell(47475);
            player->learnSpell(18499);
            player->learnSpell(1680);
            player->learnSpell(6552);
            player->learnSpell(47488);
            player->learnSpell(1719);
            player->learnSpell(23920);
            player->learnSpell(47440);
            player->learnSpell(3411);
            player->learnSpell(64382);
            player->learnSpell(55694);
            player->learnSpell(57755);
            player->learnSpell(42459);
            player->learnSpell(750);
            player->learnSpell(5246);
            player->learnSpell(3127);
            player->learnSpell(34093);
            player->learnSpell(33392);
            break;

        case CLASS_PALADIN:
            player->learnSpell(196);
            player->learnSpell(200);
            player->learnSpell(197);
            player->learnSpell(199);
            player->UpdateSkillsToMaxSkillsForLevel();
            player->learnSpell(3127);
            player->learnSpell(19746);
            player->learnSpell(19752);
            player->learnSpell(750);
            player->learnSpell(48942);
            player->learnSpell(48782);
            player->learnSpell(48932);
            player->learnSpell(20271);
            player->learnSpell(498);
            player->learnSpell(10308);
            player->learnSpell(1152);
            player->learnSpell(10278);
            player->learnSpell(48788);
            player->learnSpell(53408);
            player->learnSpell(48950);
            player->learnSpell(48936);
            player->learnSpell(31789);
            player->learnSpell(62124);
            player->learnSpell(54043);
            player->learnSpell(25780);
            player->learnSpell(1044);
            player->learnSpell(20217);
            player->learnSpell(48819);
            player->learnSpell(48801);
            player->learnSpell(48785);
            player->learnSpell(5502);
            player->learnSpell(20164);
            player->learnSpell(10326);
            player->learnSpell(1038);
            player->learnSpell(53407);
            player->learnSpell(48943);
            player->learnSpell(20165);
            player->learnSpell(48945);
            player->learnSpell(642);
            player->learnSpell(48947);
            player->learnSpell(20166);
            player->learnSpell(4987);
            player->learnSpell(48806);
            player->learnSpell(6940);
            player->learnSpell(48817);
            player->learnSpell(48934);
            player->learnSpell(48938);
            player->learnSpell(25898);
            player->learnSpell(32223);
            player->learnSpell(31884);
            player->learnSpell(54428);
            player->learnSpell(61411);
            player->learnSpell(53601);
            player->learnSpell(33388);
            player->learnSpell(33391);
            player->learnSpell(34093);
            player->learnSpell(33392);
            if (player->HasSpell(20925))
                player->learnSpell(48952);
            if (player->HasSpell(31935))
                player->learnSpell(48827);
            if (player->HasSpell(20911))
                player->learnSpell(25899);
            if (player->HasSpell(20473))
                player->learnSpell(48825);
            if (player->GetTeamId() == ALLIANCE)
            {
                player->learnSpell(31801);
                player->learnSpell(13819);
                player->learnSpell(23214);
            }
            if (player->GetTeamId() == HORDE)
            {
                player->learnSpell(53736);
                player->learnSpell(34769);
                player->learnSpell(34767);
            }
            break;

        case CLASS_HUNTER:
            player->learnSpell(5011);
            player->learnSpell(15590);
            player->learnSpell(266);
            player->learnSpell(200);
            player->learnSpell(227);
            player->learnSpell(2567);
            player->learnSpell(202);
            player->UpdateSkillsToMaxSkillsForLevel();
            player->learnSpell(3043);
            player->learnSpell(3127);
            player->learnSpell(3045);
            player->learnSpell(3034);
            player->learnSpell(8737);
            player->learnSpell(1494);
            player->learnSpell(13163);
            player->learnSpell(48996);
            player->learnSpell(49001);
            player->learnSpell(49045);
            player->learnSpell(53338);
            player->learnSpell(5116);
            player->learnSpell(27044);
            player->learnSpell(883);
            player->learnSpell(2641);
            player->learnSpell(6991);
            player->learnSpell(982);
            player->learnSpell(1515);
            player->learnSpell(19883);
            player->learnSpell(20736);
            player->learnSpell(48990);
            player->learnSpell(2974);
            player->learnSpell(6197);
            player->learnSpell(1002);
            player->learnSpell(14327);
            player->learnSpell(5118);
            player->learnSpell(49056);
            player->learnSpell(53339);
            player->learnSpell(49048);
            player->learnSpell(19884);
            player->learnSpell(34074);
            player->learnSpell(781);
            player->learnSpell(14311);
            player->learnSpell(1462);
            player->learnSpell(19885);
            player->learnSpell(19880);
            player->learnSpell(13809);
            player->learnSpell(13161);
            player->learnSpell(5384);
            player->learnSpell(1543);
            player->learnSpell(19878);
            player->learnSpell(49067);
            player->learnSpell(3034);
            player->learnSpell(13159);
            player->learnSpell(19882);
            player->learnSpell(58434);
            player->learnSpell(49071);
            player->learnSpell(49052);
            player->learnSpell(19879);
            player->learnSpell(19263);
            player->learnSpell(19801);
            player->learnSpell(34026);
            player->learnSpell(34600);
            player->learnSpell(34477);
            player->learnSpell(61006);
            player->learnSpell(61847);
            player->learnSpell(53271);
            player->learnSpell(60192);
            player->learnSpell(62757);
            player->learnSpell(34093);
            player->learnSpell(33392);
            break;

        case CLASS_MAGE:
            player->learnSpell(1180);
            player->learnSpell(201);
            player->UpdateSkillsToMaxSkillsForLevel();
            player->learnSpell(42921);
            player->learnSpell(42842);
            player->learnSpell(42995);
            player->learnSpell(42833);
            player->learnSpell(27090);
            player->learnSpell(33717);
            player->learnSpell(42873);
            player->learnSpell(42846);
            player->learnSpell(12826);
            player->learnSpell(28271);
            player->learnSpell(61780);
            player->learnSpell(61721);
            player->learnSpell(28272);
            player->learnSpell(42917);
            player->learnSpell(43015);
            player->learnSpell(130);
            player->learnSpell(42926);
            player->learnSpell(43017);
            player->learnSpell(475);
            player->learnSpell(1953);
            player->learnSpell(42940);
            player->learnSpell(12051);
            player->learnSpell(43010);
            player->learnSpell(43020);
            player->learnSpell(43012);
            player->learnSpell(42859);
            player->learnSpell(2139);
            player->learnSpell(42931);
            player->learnSpell(42985);
            player->learnSpell(43008);
            player->learnSpell(45438);
            player->learnSpell(43024);
            player->learnSpell(43002);
            player->learnSpell(43046);
            player->learnSpell(42897);
            player->learnSpell(42914);
            player->learnSpell(66);
            player->learnSpell(58659);
            player->learnSpell(30449);
            player->learnSpell(42956);
            player->learnSpell(47610);
            player->learnSpell(61316);
            player->learnSpell(61024);
            player->learnSpell(55342);
            player->learnSpell(53142);
            player->learnSpell(7301);
            player->learnSpell(34093);
            player->learnSpell(33392);
            if (player->GetTeamId() == ALLIANCE)
            {
                player->learnSpell(32271); // Teleport: Exodar.
                player->learnSpell(49359); // Teleport: Theramore.
                player->learnSpell(3565); // Teleport: Darnassus.
                player->learnSpell(33690); // Teleport: Shattrath.
                player->learnSpell(3562); // Teleport: Ironforge.
                player->learnSpell(3561); // Teleport: Stormwind.
                player->learnSpell(53140); // Teleport: Dalaran.
                player->learnSpell(53142); // Portal: Dalaran.
                player->learnSpell(10059); // Portal: Stormwind.
                player->learnSpell(11419); // Portal: Darnassus.
                player->learnSpell(32266); // Portal: Exodar.
                player->learnSpell(11416); // Portal: Ironforge.
                player->learnSpell(33691); // Portal: Shattrath.
                player->learnSpell(49360); // Portal: Theramore.
            }
            if (player->GetTeamId() == HORDE)
            {
                player->learnSpell(3567); // Teleport: Orgrimmar.
                player->learnSpell(35715); // Teleport: Shattrath.
                player->learnSpell(3566); // Teleport: Thunder Bluff.
                player->learnSpell(49358); // Teleport: Stonard.
                player->learnSpell(32272); // Teleport: Silvermoon.
                player->learnSpell(3563); // Teleport: Undercity.
                player->learnSpell(53140); // Teleport: Dalaran.
                player->learnSpell(53142); // Portal: Dalaran.
                player->learnSpell(11417); // Portal: Orgrimmar.
                player->learnSpell(35717); // Portal: Shattrath.
                player->learnSpell(32267); // Portal: Silvermoon.
                player->learnSpell(49361); // Portal: Stonard.
                player->learnSpell(11420); // Portal: Thunder Bluff.
                player->learnSpell(11418); // Portal: Undercity.
            }
            break;

        case CLASS_WARLOCK:
            player->learnSpell(201);
            player->UpdateSkillsToMaxSkillsForLevel();
            player->learnSpell(696);
            player->learnSpell(47811);
            player->learnSpell(47809);
            player->learnSpell(688);
            player->learnSpell(47813);
            player->learnSpell(50511);
            player->learnSpell(57946);
            player->learnSpell(47864);
            player->learnSpell(6215);
            player->learnSpell(47878);
            player->learnSpell(47855);
            player->learnSpell(697);
            player->learnSpell(47856);
            player->learnSpell(47857);
            player->learnSpell(5697);
            player->learnSpell(47884);
            player->learnSpell(47815);
            player->learnSpell(47889);
            player->learnSpell(47820);
            player->learnSpell(698);
            player->learnSpell(712);
            player->learnSpell(126);
            player->learnSpell(5138);
            player->learnSpell(5500);
            player->learnSpell(11719);
            player->learnSpell(132);
            player->learnSpell(60220);
            player->learnSpell(18647);
            player->learnSpell(61191);
            player->learnSpell(47823);
            player->learnSpell(691);
            player->learnSpell(47865);
            player->learnSpell(47891);
            player->learnSpell(47888);
            player->learnSpell(17928);
            player->learnSpell(47860);
            player->learnSpell(47825);
            player->learnSpell(1122);
            player->learnSpell(47867);
            player->learnSpell(18540);
            player->learnSpell(47893);
            player->learnSpell(47838);
            player->learnSpell(29858);
            player->learnSpell(58887);
            player->learnSpell(47836);
            player->learnSpell(61290);
            player->learnSpell(48018);
            player->learnSpell(48020);
            player->learnSpell(33388);
            player->learnSpell(33391);
            player->learnSpell(23161);
            player->learnSpell(34093);
            player->learnSpell(33392);
            break;

        case CLASS_ROGUE:
            player->learnSpell(196);
            player->learnSpell(264);
            player->learnSpell(5011);
            player->learnSpell(15590);
            player->learnSpell(266);
            player->learnSpell(198);
            player->learnSpell(201);
            player->UpdateSkillsToMaxSkillsForLevel();
            player->learnSpell(3127);
            player->learnSpell(42459);
            player->learnSpell(48668);
            player->learnSpell(48638);
            player->learnSpell(1784);
            player->learnSpell(48657);
            player->learnSpell(921);
            player->learnSpell(1776);
            player->learnSpell(26669);
            player->learnSpell(51724);
            player->learnSpell(6774);
            player->learnSpell(11305);
            player->learnSpell(1766);
            player->learnSpell(48676);
            player->learnSpell(48659);
            player->learnSpell(1804);
            player->learnSpell(8647);
            player->learnSpell(48691);
            player->learnSpell(51722);
            player->learnSpell(48672);
            player->learnSpell(1725);
            player->learnSpell(26889);
            player->learnSpell(2836);
            player->learnSpell(1833);
            player->learnSpell(1842);
            player->learnSpell(8643);
            player->learnSpell(2094);
            player->learnSpell(1860);
            player->learnSpell(57993);
            player->learnSpell(48674);
            player->learnSpell(31224);
            player->learnSpell(5938);
            player->learnSpell(57934);
            player->learnSpell(51723);
            player->learnSpell(34093);
            player->learnSpell(33392);
            break;

        case CLASS_PRIEST:
            player->learnSpell(1180);
            player->UpdateSkillsToMaxSkillsForLevel();
            player->learnSpell(528);
            player->learnSpell(2053);
            player->learnSpell(48161);
            player->learnSpell(48123);
            player->learnSpell(48125);
            player->learnSpell(48066);
            player->learnSpell(586);
            player->learnSpell(48068);
            player->learnSpell(48127);
            player->learnSpell(48171);
            player->learnSpell(48168);
            player->learnSpell(10890);
            player->learnSpell(6064);
            player->learnSpell(988);
            player->learnSpell(48300);
            player->learnSpell(6346);
            player->learnSpell(48071);
            player->learnSpell(48135);
            player->learnSpell(48078);
            player->learnSpell(453);
            player->learnSpell(10955);
            player->learnSpell(10909);
            player->learnSpell(8129);
            player->learnSpell(48073);
            player->learnSpell(605);
            player->learnSpell(48072);
            player->learnSpell(48169);
            player->learnSpell(552);
            player->learnSpell(1706);
            player->learnSpell(48063);
            player->learnSpell(48162);
            player->learnSpell(48170);
            player->learnSpell(48074);
            player->learnSpell(48158);
            player->learnSpell(48120);
            player->learnSpell(34433);
            player->learnSpell(48113);
            player->learnSpell(32375);
            player->learnSpell(64843);
            player->learnSpell(64901);
            player->learnSpell(53023);
            player->learnSpell(34093);
            player->learnSpell(33392);
            player->PlayerTalkClass->SendCloseGossip();
            break;

        case CLASS_DEATH_KNIGHT:
            player->learnSpell(198);
            player->learnSpell(199);
            player->UpdateSkillsToMaxSkillsForLevel();
            player->learnSpell(3127);
            player->learnSpell(50842);
            player->learnSpell(49941);
            player->learnSpell(49930);
            player->learnSpell(47476);
            player->learnSpell(45529);
            player->learnSpell(3714);
            player->learnSpell(56222);
            player->learnSpell(48743);
            player->learnSpell(48263);
            player->learnSpell(49909);
            player->learnSpell(47528);
            player->learnSpell(45524);
            player->learnSpell(48792);
            player->learnSpell(57623);
            player->learnSpell(56815);
            player->learnSpell(47568);
            player->learnSpell(49895);
            player->learnSpell(50977);
            player->learnSpell(49576);
            player->learnSpell(49921);
            player->learnSpell(46584);
            player->learnSpell(49938);
            player->learnSpell(48707);
            player->learnSpell(48265);
            player->learnSpell(61999);
            player->learnSpell(42650);
            player->learnSpell(53428);
            player->learnSpell(53331);
            player->learnSpell(54447);
            player->learnSpell(53342);
            player->learnSpell(54446);
            player->learnSpell(53323);
            player->learnSpell(53344);
            player->learnSpell(70164);
            player->learnSpell(62158);
            player->learnSpell(33391);
            player->learnSpell(48778);
            player->learnSpell(51425);
            player->learnSpell(49924);
            player->learnSpell(34093);
            player->learnSpell(33392);
            player->PlayerTalkClass->SendCloseGossip();
            break;

        case CLASS_SHAMAN:
            player->learnSpell(196);
            player->learnSpell(1180);
            player->learnSpell(15590);
            player->learnSpell(197);
            player->learnSpell(199);
            player->UpdateSkillsToMaxSkillsForLevel();
            player->learnSpell(2062);
            player->learnSpell(8737);
            player->learnSpell(49273);
            player->learnSpell(49238);
            player->learnSpell(10399);
            player->learnSpell(49231);
            player->learnSpell(58753);
            player->learnSpell(2484);
            player->learnSpell(49281);
            player->learnSpell(58582);
            player->learnSpell(49233);
            player->learnSpell(58790);
            player->learnSpell(58704);
            player->learnSpell(58643);
            player->learnSpell(49277);
            player->learnSpell(61657);
            player->learnSpell(8012);
            player->learnSpell(526);
            player->learnSpell(2645);
            player->learnSpell(57994);
            player->learnSpell(8143);
            player->learnSpell(49236);
            player->learnSpell(58796);
            player->learnSpell(58757);
            player->learnSpell(49276);
            player->learnSpell(57960);
            player->learnSpell(131);
            player->learnSpell(58745);
            player->learnSpell(6196);
            player->learnSpell(58734);
            player->learnSpell(58774);
            player->learnSpell(58739);
            player->learnSpell(58656);
            player->learnSpell(546);
            player->learnSpell(556);
            player->learnSpell(66842);
            player->learnSpell(51994);
            player->learnSpell(8177);
            player->learnSpell(58749);
            player->learnSpell(20608);
            player->learnSpell(36936);
            player->learnSpell(36936);
            player->learnSpell(58804);
            player->learnSpell(49271);
            player->learnSpell(8512);
            player->learnSpell(6495);
            player->learnSpell(8170);
            player->learnSpell(66843);
            player->learnSpell(55459);
            player->learnSpell(66844);
            player->learnSpell(3738);
            player->learnSpell(2894);
            player->learnSpell(60043);
            player->learnSpell(51514);
            player->learnSpell(34093);
            player->learnSpell(33392);
            if (player->GetTeamId() == ALLIANCE)
                player->learnSpell(32182);
            if (player->GetTeamId() == HORDE)
                player->learnSpell(2825);
            break;

        case CLASS_DRUID:
            player->learnSpell(1180);
            player->learnSpell(15590);
            player->learnSpell(200);
            player->learnSpell(199);
            player->UpdateSkillsToMaxSkillsForLevel();
            player->learnSpell(48378);
            player->learnSpell(48469);
            player->learnSpell(48461);
            player->learnSpell(48463);
            player->learnSpell(48441);
            player->learnSpell(53307);
            player->learnSpell(53308);
            player->learnSpell(5487);
            player->learnSpell(48560);
            player->learnSpell(6795);
            player->learnSpell(48480);
            player->learnSpell(53312);
            player->learnSpell(18960);
            player->learnSpell(5229);
            player->learnSpell(48443);
            player->learnSpell(50763);
            player->learnSpell(8983);
            player->learnSpell(8946);
            player->learnSpell(1066);
            player->learnSpell(48562);
            player->learnSpell(783);
            player->learnSpell(770);
            player->learnSpell(16857);
            player->learnSpell(18658);
            player->learnSpell(768);
            player->learnSpell(1082);
            player->learnSpell(16979);
            player->learnSpell(49376);
            player->learnSpell(5215);
            player->learnSpell(48477);
            player->learnSpell(49800);
            player->learnSpell(48465);
            player->learnSpell(48572);
            player->learnSpell(26995);
            player->learnSpell(48574);
            player->learnSpell(2782);
            player->learnSpell(50213);
            player->learnSpell(2893);
            player->learnSpell(33357);
            player->learnSpell(5209);
            player->learnSpell(48575);
            player->learnSpell(48447);
            player->learnSpell(48577);
            player->learnSpell(48579);
            player->learnSpell(5225);
            player->learnSpell(22842);
            player->learnSpell(49803);
            player->learnSpell(9634);
            player->learnSpell(20719);
            player->learnSpell(48467);
            player->learnSpell(29166);
            player->learnSpell(62600);
            player->learnSpell(22812);
            player->learnSpell(48470);
            player->learnSpell(48564);
            player->learnSpell(48566);
            player->learnSpell(33943);
            player->learnSpell(49802);
            player->learnSpell(48451);
            player->learnSpell(48568);
            player->learnSpell(33786);
            player->learnSpell(40120);
            player->learnSpell(62078);
            player->learnSpell(52610);
            player->learnSpell(50464);
            player->learnSpell(48570);
            player->learnSpell(34093);
            player->learnSpell(33392);
            break;

        default:
            // TC_LOG_INFO("server.worldserver", "ERROR #DEFAULT [1]");
            break;
        }
    }

    void DobaviBokluciNaGeroq(Player* player)
    {
        player->SetLevel(80);
        player->ModifyMoney(player->GetMoney() + 2000000); // dobavi 200g
        player->AddItem(41599, 4); // 4 torbi (frostweave)
        player->AddItem(21215, 20); // 20x graccu hrana
        player->learnSpell(34091); // master riding
        player->learnSpell(54197); // cold weather
    }

    bool OnGossipHello(Player *player, Creature *_creature)
    {
        if (!sWorld->getBoolConfig(CUSTOM_SCRIPTS_ENABLED_OR_NOT))
            return false;

        if (player->IsInCombat()) // chceck if player is in combat
        {
            player->GetSession()->SendNotification("Leave combat first!");
            // TC_LOG_INFO("server.worldserver", "combat");
            player->PlayerTalkClass->SendCloseGossip();
            return false;
        }

        if (player->getLevel() > 1) // check if his level is higher than 1
        {
            // TC_LOG_INFO("server.worldserver", "level 1");
            player->GetSession()->SendNotification("You must be level 1 in order to use this NPC!");
            player->PlayerTalkClass->SendCloseGossip();
            return false;
        }

        if (!player->HasItemCount(111111, 1, true))
        {
            // TC_LOG_INFO("server.worldserver", "no TOKEN");
            return false;
        }


        switch (player->getClass())
        {
            case CLASS_DEATH_KNIGHT:
                player->ADD_GOSSIP_ITEM(3, "[|cff0000FFPvE|r][TANK] Tier8 + ToC Offset", GOSSIP_SENDER_MAIN, 2);
                player->ADD_GOSSIP_ITEM(3, "[|cff0000FFPvE|r][DPS] Tier8 + ToC Offset", GOSSIP_SENDER_MAIN, 3);
                break;
            case CLASS_DRUID:
                player->ADD_GOSSIP_ITEM(3, "[|cff0000FFPvE|r][TANK] Tier8 + ToC Offset", GOSSIP_SENDER_MAIN, 4);
                player->ADD_GOSSIP_ITEM(3, "[|cff0000FFPvE|r][DPS/FERAL] Tier8 + ToC Offset", GOSSIP_SENDER_MAIN, 5);
                player->ADD_GOSSIP_ITEM(3, "[|cff0000FFPvE|r][DPS/BALANCE] Tier8 + ToC Offset", GOSSIP_SENDER_MAIN, 6);
                player->ADD_GOSSIP_ITEM(3, "[|cff0000FFPvE|r][HEAL] Tier8 + ToC Offset", GOSSIP_SENDER_MAIN, 7);
                break;
            case CLASS_PALADIN:
                player->ADD_GOSSIP_ITEM(3, "[|cff0000FFPvE|r][TANK] Tier8 + ToC Offset", GOSSIP_SENDER_MAIN, 8);
                player->ADD_GOSSIP_ITEM(3, "[|cff0000FFPvE|r][DPS] Tier8 + ToC Offset", GOSSIP_SENDER_MAIN, 9);
                player->ADD_GOSSIP_ITEM(3, "[|cff0000FFPvE|r][HEAL] Tier8 + ToC Offset", GOSSIP_SENDER_MAIN, 10);
                break;
            case CLASS_PRIEST:
                player->ADD_GOSSIP_ITEM(3, "[|cff0000FFPvE|r][DPS] Tier8 + ToC Offset", GOSSIP_SENDER_MAIN, 11);
                player->ADD_GOSSIP_ITEM(3, "[|cff0000FFPvE|r][HEAL] Tier8 + ToC Offset", GOSSIP_SENDER_MAIN, 12);
                break;
            case CLASS_HUNTER:
                player->ADD_GOSSIP_ITEM(3, "[|cff0000FFPvE|r][DPS] Tier8 + ToC Offset", GOSSIP_SENDER_MAIN, 13);
                break;
            case CLASS_ROGUE:
                player->ADD_GOSSIP_ITEM(3, "[|cff0000FFPvE|r][DPS] Tier8 + ToC Offset", GOSSIP_SENDER_MAIN, 14);
                break;
            case CLASS_MAGE:
                player->ADD_GOSSIP_ITEM(3, "[|cff0000FFPvE|r][DPS] Tier8 + ToC Offset", GOSSIP_SENDER_MAIN, 15);
                break;
            case CLASS_SHAMAN:
                player->ADD_GOSSIP_ITEM(3, "[|cff0000FFPvE|r][DPS/Elemental] Tier8 + ToC Offset", GOSSIP_SENDER_MAIN, 16);
                player->ADD_GOSSIP_ITEM(3, "[|cff0000FFPvE|r][DPS/Enhancemnet] Tier8 + ToC Offset", GOSSIP_SENDER_MAIN, 17);
                player->ADD_GOSSIP_ITEM(3, "[|cff0000FFPvE|r][HEAL] Tier8 + ToC Offset", GOSSIP_SENDER_MAIN, 18);
                break;
            case CLASS_WARRIOR:
                player->ADD_GOSSIP_ITEM(3, "[|cff0000FFPvE|r][TANK] Tier8 + ToC Offset", GOSSIP_SENDER_MAIN, 19);
                player->ADD_GOSSIP_ITEM(3, "[|cff0000FFPvE|r][DPS] Tier8 + ToC Offset", GOSSIP_SENDER_MAIN, 20);
                break;
            case CLASS_WARLOCK:
                player->ADD_GOSSIP_ITEM(3, "[|cff0000FFPvE|r][DPS] Tier8 + ToC Offset", GOSSIP_SENDER_MAIN, 21);
                break;

            default:
                break;
        }
        player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, _creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player *player, Creature *_creature, uint32 sender, uint32 uiAction)
    {
        PremahniPredmetiteNa(player);

        bool eligible;
        QueryResult rezultat = LoginDatabase.PQuery("select free from account where id = %u;", player->GetSession()->GetAccountId());
        if (rezultat)
        {
            Field *field = rezultat->Fetch();
            uint8 value = field[0].GetUInt8();
            
            if (value == 1)
                eligible = true;
            else
                eligible = false;
        }
        else
        {
            eligible = false;
        }

        if (sender == GOSSIP_SENDER_MAIN)
        {
            player->PlayerTalkClass->ClearMenus();
            switch (uiAction)
            {
            case 2: // DK @ tank
                    player->EquipNewItem(SLOT_CHEST, 46118, true);
                    player->EquipNewItem(SLOT_LEGS, 46121, true);
                    player->EquipNewItem(SLOT_HEAD, 46120, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 46122, true);
                    player->EquipNewItem(SLOT_HANDS, 46119, true);
                    player->EquipNewItem(SLOT_MAIN_HAND, 39417, true);
                    player->EquipNewItem(SLOT_RANGED, 47673, true);
                    player->EquipNewItem(SLOT_NECK, 45819, true);
                    //player->EquipNewItem(SLOT_TABARD, 0000000, true);
                    player->EquipNewItem(SLOT_WRISTS, 45663, true);
                    player->EquipNewItem(SLOT_FINGER1, 40718, true);
                    player->EquipNewItem(SLOT_WAIST, 39759, true);
                    player->EquipNewItem(SLOT_FEET, 50207, true);
                    player->EquipNewItem(SLOT_BACK, 45318, true);
                    player->EquipNewItem(SLOT_FINGER2, 47731, true);
                    player->EquipNewItem(SLOT_TRINKET1, 50356, true);
                    player->EquipNewItem(SLOT_TRINKET2, 47735, true);

                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;
            case 3: // DK @ DPS
                    player->EquipNewItem(SLOT_CHEST, 46111, true);
                    player->EquipNewItem(SLOT_LEGS, 46116, true);
                    player->EquipNewItem(SLOT_HEAD, 46115, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 46117, true);
                    player->EquipNewItem(SLOT_HANDS, 46113, true);
                    player->EquipNewItem(SLOT_MAIN_HAND, 45868, true);
                    player->EquipNewItem(SLOT_RANGED, 47673, true);
                    player->EquipNewItem(SLOT_NECK, 45819, true);
                    //player->EquipNewItem(SLOT_TABARD, 0000000, true);
                    player->EquipNewItem(SLOT_WRISTS, 45663, true);
                    player->EquipNewItem(SLOT_FINGER1, 47729, true);
                    player->EquipNewItem(SLOT_WAIST, 45241, true);
                    player->EquipNewItem(SLOT_FEET, 40742, true);
                    player->EquipNewItem(SLOT_BACK, 45318, true);
                    player->EquipNewItem(SLOT_FINGER2, 47730, true);
                    player->EquipNewItem(SLOT_TRINKET1, 47734, true);
                    player->EquipNewItem(SLOT_TRINKET2, 48722, true);

                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;
            case 4: // druid ? tank
                    player->EquipNewItem(SLOT_CHEST, 46159, true);
                    player->EquipNewItem(SLOT_LEGS, 46160, true);
                    player->EquipNewItem(SLOT_HEAD, 46161, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 46157, true);
                    player->EquipNewItem(SLOT_HANDS, 46158, true);
                    player->EquipNewItem(SLOT_MAIN_HAND, 50040, true);
                    player->EquipNewItem(SLOT_RANGED, 50456, true);
                    player->EquipNewItem(SLOT_NECK, 50228, true);
                    //player->EquipNewItem(SLOT_TABARD, 0000000, true);
                    player->EquipNewItem(SLOT_WRISTS, 45611, true);
                    player->EquipNewItem(SLOT_FINGER1, 47730, true);
                    player->EquipNewItem(SLOT_WAIST, 45829, true);
                    player->EquipNewItem(SLOT_FEET,50308, true);
                    player->EquipNewItem(SLOT_BACK, 40403, true);
                    player->EquipNewItem(SLOT_FINGER2, 45303, true);
                    player->EquipNewItem(SLOT_TRINKET1, 50352, true);
                    player->EquipNewItem(SLOT_TRINKET2, 47735, true);

                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;
            case 6: // DRUID @ DPS @ feral
                    player->EquipNewItem(SLOT_CHEST, 46194, true);
                    player->EquipNewItem(SLOT_LEGS, 46192, true);
                    player->EquipNewItem(SLOT_HEAD, 46191, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 46196, true);
                    player->EquipNewItem(SLOT_HANDS, 46189, true);
                    player->EquipNewItem(SLOT_MAIN_HAND, 50273, true);
                    player->EquipNewItem(SLOT_RANGED, 47670, true);
                    player->EquipNewItem(SLOT_NECK, 50211, true);
                    //player->EquipNewItem(SLOT_TABARD, 0000000, true);
                    player->EquipNewItem(SLOT_WRISTS, 46009, true);
                    player->EquipNewItem(SLOT_WAIST, 45556, true);
                    player->EquipNewItem(SLOT_FEET, 47504, true);
                    player->EquipNewItem(SLOT_BACK, 45493, true);
                    player->EquipNewItem(SLOT_FINGER1, 45157, true);
                    player->EquipNewItem(SLOT_FINGER2, 45503, true);
                    player->EquipNewItem(SLOT_TRINKET1, 45263, true);
                    player->EquipNewItem(SLOT_TRINKET2, 45609, true);
                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;
            case 5: // DRUID @ DPS @ BALANCE
                    player->EquipNewItem(SLOT_CHEST, 46159, true);
                    player->EquipNewItem(SLOT_LEGS, 46160, true);
                    player->EquipNewItem(SLOT_HEAD, 46161, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 46157, true);
                    player->EquipNewItem(SLOT_HANDS, 46158, true);
                    player->EquipNewItem(SLOT_MAIN_HAND, 50040, true);
                    player->EquipNewItem(SLOT_RANGED, 50456, true);
                    player->EquipNewItem(SLOT_NECK, 50228, true);
                    //player->EquipNewItem(SLOT_TABARD, 0000000, true);
                    player->EquipNewItem(SLOT_WRISTS, 45611, true);
                    player->EquipNewItem(SLOT_FINGER1, 47327, true);
                    player->EquipNewItem(SLOT_WAIST, 45829, true);
                    player->EquipNewItem(SLOT_FEET,50308, true);
                    player->EquipNewItem(SLOT_BACK, 40403, true);
                    player->EquipNewItem(SLOT_FINGER2, 48957, true);
                    player->EquipNewItem(SLOT_TRINKET1, 50259, true);
                    player->EquipNewItem(SLOT_TRINKET2, 45518, true);
                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;
            case 7: // DRUID @ RESTORATION
                    player->EquipNewItem(SLOT_CHEST, 46186, true);
                    player->EquipNewItem(SLOT_LEGS, 46185, true);
                    player->EquipNewItem(SLOT_HEAD, 46184, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 46187, true);
                    player->EquipNewItem(SLOT_HANDS, 46183, true);
                    player->EquipNewItem(SLOT_MAIN_HAND, 49790, true);
                    player->EquipNewItem(SLOT_RANGED, 50454, true);
                    player->EquipNewItem(SLOT_NECK, 40378, true);
                    //player->EquipNewItem(SLOT_TABARD, 0000000, true);
                    player->EquipNewItem(SLOT_WRISTS, 45149, true);
                    player->EquipNewItem(SLOT_FINGER1, 47732, true);
                    player->EquipNewItem(SLOT_WAIST, 45185, true);
                    player->EquipNewItem(SLOT_FEET, 45378, true);
                    player->EquipNewItem(SLOT_BACK, 45493, true);
                    player->EquipNewItem(SLOT_FINGER2, 40719, true);
                    player->EquipNewItem(SLOT_TRINKET1, 48724, true);
                    player->EquipNewItem(SLOT_TRINKET2, 50358, true);
                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;
            case 8: // pala tank
                    player->EquipNewItem(SLOT_CHEST, 46173, true);
                    player->EquipNewItem(SLOT_LEGS, 46176, true);
                    player->EquipNewItem(SLOT_HEAD, 46175, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 46177, true);
                    player->EquipNewItem(SLOT_HANDS, 46174, true);
                    player->EquipNewItem(SLOT_MAIN_HAND, 49783, true);
                    player->EquipNewItem(SLOT_RANGED, 45145, true);
                    player->EquipNewItem(SLOT_OFF_HAND, 40400, true);
                    player->EquipNewItem(SLOT_NECK, 46022, true);
                    //player->EquipNewItem(SLOT_TABARD, 0000000, true);
                    player->EquipNewItem(SLOT_WRISTS, 45111, true);
                    player->EquipNewItem(SLOT_FINGER1, 50447, true);
                    player->EquipNewItem(SLOT_WAIST, 45139, true);
                    player->EquipNewItem(SLOT_FEET, 50207, true);
                    player->EquipNewItem(SLOT_BACK, 54801, true);
                    player->EquipNewItem(SLOT_FINGER2, 47731, true);
                    player->EquipNewItem(SLOT_TRINKET1, 50235, true);
                    player->EquipNewItem(SLOT_TRINKET2, 45158, true);
                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;
            case 9: // paladin @ dps
                    player->EquipNewItem(SLOT_CHEST, 46154, true);
                    player->EquipNewItem(SLOT_LEGS, 46153, true);
                    player->EquipNewItem(SLOT_HEAD, 46156, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 46152, true);
                    player->EquipNewItem(SLOT_HANDS, 46155, true);
                    player->EquipNewItem(SLOT_MAIN_HAND, 49498, true);
                    player->EquipNewItem(SLOT_RANGED, 45510, true);
                    //player->EquipNewItem(SLOT_OFF_HAND, 0000000, true);
                    player->EquipNewItem(SLOT_NECK, 46022, true);
                    //player->EquipNewItem(SLOT_TABARD, 0000000, true);
                    player->EquipNewItem(SLOT_WRISTS, 45663, true);
                    player->EquipNewItem(SLOT_FINGER1, 47729, true);
                    player->EquipNewItem(SLOT_WAIST, 45241, true);
                    player->EquipNewItem(SLOT_FEET, 45330, true);
                    player->EquipNewItem(SLOT_BACK, 45318, true);
                    player->EquipNewItem(SLOT_FINGER2, 45540, true);
                    player->EquipNewItem(SLOT_TRINKET1, 47734, true);
                    player->EquipNewItem(SLOT_TRINKET2, 46038, true);
                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;
            case 10: // paladin @ healer
                    player->EquipNewItem(SLOT_CHEST, 46178, true);
                    player->EquipNewItem(SLOT_LEGS, 46181, true);
                    player->EquipNewItem(SLOT_HEAD, 46180, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 46182, true);
                    player->EquipNewItem(SLOT_HANDS, 46179, true);
                    player->EquipNewItem(SLOT_MAIN_HAND, 46035, true);
                    player->EquipNewItem(SLOT_RANGED, 47662, true);
                    player->EquipNewItem(SLOT_OFF_HAND, 45682, true);
                    player->EquipNewItem(SLOT_NECK, 50211, true);
                    //player->EquipNewItem(SLOT_TABARD, 0000000, true);
                    player->EquipNewItem(SLOT_WRISTS, 49797, true);
                    player->EquipNewItem(SLOT_FINGER1, 49967, true);
                    player->EquipNewItem(SLOT_WAIST, 45505, true);
                    player->EquipNewItem(SLOT_FEET, 49905, true);
                    player->EquipNewItem(SLOT_BACK, 45486, true);
                    player->EquipNewItem(SLOT_FINGER2, 47733, true);
                    player->EquipNewItem(SLOT_TRINKET1, 44255, true);
                    player->EquipNewItem(SLOT_TRINKET2, 40258, true);
                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;
            case 11: // priest @ dps
                    player->EquipNewItem(SLOT_CHEST, 46168, true);
                    player->EquipNewItem(SLOT_LEGS, 46170, true);
                    player->EquipNewItem(SLOT_HEAD, 46172, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 46165, true);
                    player->EquipNewItem(SLOT_HANDS, 46163, true);
                    player->EquipNewItem(SLOT_MAIN_HAND, 50273, true);
                    player->EquipNewItem(SLOT_RANGED, 45511, true);
                    player->EquipNewItem(SLOT_NECK, 50211, true);
                   // player->EquipNewItem(SLOT_TABARD, 0000000, true);
                    player->EquipNewItem(SLOT_WRISTS, 45275, true);
                    player->EquipNewItem(SLOT_FINGER1, 48957, true);
                    player->EquipNewItem(SLOT_WAIST, 40301, true);
                    player->EquipNewItem(SLOT_FEET, 50286, true);
                    player->EquipNewItem(SLOT_BACK, 45242, true);
                    player->EquipNewItem(SLOT_FINGER2, 45451, true);
                    player->EquipNewItem(SLOT_TRINKET1, 45518, true);
                    player->EquipNewItem(SLOT_TRINKET2, 47213, true);
                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;
            case 12: // priest @ heal
                    player->EquipNewItem(SLOT_CHEST, 46193, true);
                    player->EquipNewItem(SLOT_LEGS, 46195, true);
                    player->EquipNewItem(SLOT_HEAD, 46197, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 46190, true);
                    player->EquipNewItem(SLOT_HANDS, 46188, true);
                    player->EquipNewItem(SLOT_MAIN_HAND, 45457, true);
                    player->EquipNewItem(SLOT_RANGED, 45170, true);
                    player->EquipNewItem(SLOT_NECK, 45822, true);
                    //player->EquipNewItem(SLOT_TABARD, 0000000, true);
                    player->EquipNewItem(SLOT_WRISTS, 50785, true);
                    player->EquipNewItem(SLOT_FINGER1, 45113, true);
                    player->EquipNewItem(SLOT_WAIST, 50773, true);
                    player->EquipNewItem(SLOT_FEET, 46050, true);
                    player->EquipNewItem(SLOT_BACK, 45493, true);
                    player->EquipNewItem(SLOT_FINGER2, 48955, true);
                    player->EquipNewItem(SLOT_TRINKET1, 40258, true);
                    player->EquipNewItem(SLOT_TRINKET2, 50260, true);
                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;
            case 13: // hunter @ dps
                    player->EquipNewItem(SLOT_CHEST, 46141, true);
                    player->EquipNewItem(SLOT_LEGS, 46144, true);
                    player->EquipNewItem(SLOT_HEAD, 46143, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 46145, true);
                    player->EquipNewItem(SLOT_HANDS, 46142, true);
                    player->EquipNewItem(SLOT_MAIN_HAND, 49496, true);
                    player->EquipNewItem(SLOT_RANGED, 45327, true);
                    player->EquipNewItem(SLOT_NECK, 50228, true);
                    //player->EquipNewItem(SLOT_TABARD, 0000000, true);
                    player->EquipNewItem(SLOT_WRISTS, 45611, true);
                    player->EquipNewItem(SLOT_FINGER1, 47730, true);
                    player->EquipNewItem(SLOT_WAIST, 45829, true);
                    player->EquipNewItem(SLOT_FEET, 50308, true);
                    player->EquipNewItem(SLOT_BACK, 45461, true);
                    player->EquipNewItem(SLOT_FINGER2, 50271, true);
                    player->EquipNewItem(SLOT_TRINKET1, 40371, true);
                    player->EquipNewItem(SLOT_TRINKET2, 44253, true);
                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;
            case 14: // rogue @ dps
                    player->EquipNewItem(SLOT_CHEST, 46123, true);
                    player->EquipNewItem(SLOT_LEGS, 46126, true);
                    player->EquipNewItem(SLOT_HEAD, 46125, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 46127, true);
                    player->EquipNewItem(SLOT_HANDS, 46124, true);
                    player->EquipNewItem(SLOT_MAIN_HAND, 45484, true);
                    player->EquipNewItem(SLOT_RANGED, 43612, true);
                    player->EquipNewItem(SLOT_OFF_HAND, 45607, true);
                    player->EquipNewItem(SLOT_NECK, 50228, true);
                    //player->EquipNewItem(SLOT_TABARD, 0000000, true);
                    player->EquipNewItem(SLOT_WRISTS, 45611, true);
                    player->EquipNewItem(SLOT_FINGER1, 47730, true);
                    player->EquipNewItem(SLOT_WAIST, 45829, true);
                    player->EquipNewItem(SLOT_FEET, 50308, true);
                    player->EquipNewItem(SLOT_BACK, 45461, true);
                    player->EquipNewItem(SLOT_FINGER2, 45608, true);
                    player->EquipNewItem(SLOT_TRINKET1, 40371, true);
                    player->EquipNewItem(SLOT_TRINKET2, 44253, true);
                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;
            case 15: // mage @ dps
                    player->EquipNewItem(SLOT_CHEST, 46130, true);
                    player->EquipNewItem(SLOT_LEGS, 46133, true);
                    player->EquipNewItem(SLOT_HEAD, 46129, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 46134, true);
                    player->EquipNewItem(SLOT_HANDS, 46132, true);
                    player->EquipNewItem(SLOT_MAIN_HAND, 50273, true);
                    player->EquipNewItem(SLOT_RANGED, 45511, true);
                    player->EquipNewItem(SLOT_NECK, 50211, true);
                    //player->EquipNewItem(SLOT_TABARD, 0000000, true);
                    player->EquipNewItem(SLOT_WRISTS, 45275, true);
                    player->EquipNewItem(SLOT_FINGER1, 48957, true);
                    player->EquipNewItem(SLOT_WAIST, 40301, true);
                    player->EquipNewItem(SLOT_FEET, 50286, true);
                    player->EquipNewItem(SLOT_BACK, 45242, true);
                    player->EquipNewItem(SLOT_FINGER2, 45451, true);
                    player->EquipNewItem(SLOT_TRINKET1, 45518, true);
                    player->EquipNewItem(SLOT_TRINKET2, 47213, true);
                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;
            case 16: // sham @ dps @ ele
                    player->EquipNewItem(SLOT_CHEST, 46206, true);
                    player->EquipNewItem(SLOT_LEGS, 46210, true);
                    player->EquipNewItem(SLOT_HEAD, 46209, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 46211, true);
                    player->EquipNewItem(SLOT_HANDS, 46207, true);
                    player->EquipNewItem(SLOT_MAIN_HAND, 46035, true);
                    player->EquipNewItem(SLOT_RANGED, 45511, true);
                    player->EquipNewItem(SLOT_OFF_HAND, 45470, true);
                    player->EquipNewItem(SLOT_NECK, 50211, true);
                    //player->EquipNewItem(SLOT_TABARD, 0000000, true);
                    player->EquipNewItem(SLOT_WRISTS, 45187, true);
                    player->EquipNewItem(SLOT_FINGER1, 51381, true);
                    player->EquipNewItem(SLOT_WAIST, 45554, true);
                    player->EquipNewItem(SLOT_FEET, 45615, true);
                    player->EquipNewItem(SLOT_BACK, 44005, true);
                    player->EquipNewItem(SLOT_FINGER2, 45451, true);
                    player->EquipNewItem(SLOT_TRINKET1, 45518, true);
                    player->EquipNewItem(SLOT_TRINKET2, 45148, true);
                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;
            case 17: //  sham @ dps @ enh
                    player->EquipNewItem(SLOT_CHEST, 46205, true);
                    player->EquipNewItem(SLOT_LEGS, 46208, true);
                    player->EquipNewItem(SLOT_HEAD, 46212, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 46203, true);
                    player->EquipNewItem(SLOT_HANDS, 46200, true);
                    player->EquipNewItem(SLOT_MAIN_HAND, 46031, true);
                    player->EquipNewItem(SLOT_RANGED, 47667, true);
                    player->EquipNewItem(SLOT_OFF_HAND, 46031, true);
                    player->EquipNewItem(SLOT_NECK, 50228, true);
                    //player->EquipNewItem(SLOT_TABARD, 0000000, true);
                    player->EquipNewItem(SLOT_WRISTS, 50209, true);
                    player->EquipNewItem(SLOT_FINGER1, 47282, true);
                    player->EquipNewItem(SLOT_WAIST, 45827, true);
                    player->EquipNewItem(SLOT_FEET, 45244, true);
                    player->EquipNewItem(SLOT_BACK, 45461, true);
                    player->EquipNewItem(SLOT_FINGER2, 48954, true);
                    player->EquipNewItem(SLOT_TRINKET1, 44253, true);
                    player->EquipNewItem(SLOT_TRINKET2, 40371, true);
                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;
            case 18: // sham @ resto
                    player->EquipNewItem(SLOT_CHEST, 46198, true);
                    player->EquipNewItem(SLOT_LEGS, 46202, true);
                    player->EquipNewItem(SLOT_HEAD, 46201, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 46204, true);
                    player->EquipNewItem(SLOT_HANDS, 46199, true);
                    player->EquipNewItem(SLOT_MAIN_HAND, 46035, true);
                    player->EquipNewItem(SLOT_RANGED, 47665, true);
                    player->EquipNewItem(SLOT_OFF_HAND, 45682, true);
                    player->EquipNewItem(SLOT_NECK, 50211, true);
                    //player->EquipNewItem(SLOT_TABARD, 0000000, true);
                    player->EquipNewItem(SLOT_WRISTS, 50774, true);
                    player->EquipNewItem(SLOT_FINGER1, 49967, true);
                    player->EquipNewItem(SLOT_WAIST, 50992, true);
                    player->EquipNewItem(SLOT_FEET, 51006, true);
                    player->EquipNewItem(SLOT_BACK, 50468, true);
                    player->EquipNewItem(SLOT_FINGER2, 47733, true);
                    player->EquipNewItem(SLOT_TRINKET1, 50358, true);
                    player->EquipNewItem(SLOT_TRINKET2, 40258, true);
                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;
            case 19: // warrior @ tank
                    player->EquipNewItem(SLOT_CHEST, 46162, true);
                    player->EquipNewItem(SLOT_LEGS, 46169, true);
                    player->EquipNewItem(SLOT_HEAD, 46166, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 46167, true);
                    player->EquipNewItem(SLOT_HANDS, 46164, true);
                    
                    player->EquipNewItem(SLOT_MAIN_HAND, 45110, true);
                    player->EquipNewItem(SLOT_RANGED, 45137, true);
                    player->EquipNewItem(SLOT_OFF_HAND, 45877, true);
                    
                    player->EquipNewItem(SLOT_NECK, 45262, true);
                    player->EquipNewItem(SLOT_WRISTS, 45111, true);
                    player->EquipNewItem(SLOT_FINGER1, 47731, true);
                    player->EquipNewItem(SLOT_WAIST, 45139, true);
                    player->EquipNewItem(SLOT_FEET, 45166, true);
                    player->EquipNewItem(SLOT_BACK, 54801, true);
                    player->EquipNewItem(SLOT_FINGER2, 45471, true);
                    player->EquipNewItem(SLOT_TRINKET1, 45313, true);
                    player->EquipNewItem(SLOT_TRINKET2, 50235, true);
                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;
            case 20: // warrior @ dps
                    player->EquipNewItem(SLOT_CHEST, 46146, true);
                    player->EquipNewItem(SLOT_LEGS, 46150, true);
                    player->EquipNewItem(SLOT_HEAD, 46151, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 46149, true);
                    player->EquipNewItem(SLOT_HANDS, 46148, true);
                    player->EquipNewItem(SLOT_MAIN_HAND, 50267, true);
                    player->EquipNewItem(SLOT_RANGED, 45296, true);
                    player->EquipNewItem(SLOT_OFF_HAND, 50267, true);
                    player->EquipNewItem(SLOT_NECK, 45285, true);
                    //player->EquipNewItem(SLOT_TABARD, 0000000, true);
                    player->EquipNewItem(SLOT_WRISTS, 45264, true);
                    player->EquipNewItem(SLOT_FINGER1, 45540, true);
                    player->EquipNewItem(SLOT_WAIST, 46041, true);
                    player->EquipNewItem(SLOT_FEET, 40591, true);
                    player->EquipNewItem(SLOT_BACK, 45138, true);
                    player->EquipNewItem(SLOT_FINGER2, 45250, true);
                    player->EquipNewItem(SLOT_TRINKET1, 45931, true);
                    player->EquipNewItem(SLOT_TRINKET2, 45609, true);
                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;
            case 21: // warlock @ dps
                    player->EquipNewItem(SLOT_CHEST, 46137, true);
                    player->EquipNewItem(SLOT_LEGS, 46139, true);
                    player->EquipNewItem(SLOT_HEAD, 46140, true);
                    player->EquipNewItem(SLOT_SHOULDERS, 46136, true);
                    player->EquipNewItem(SLOT_HANDS, 46135, true);
                    player->EquipNewItem(SLOT_MAIN_HAND, 50273, true);
                    player->EquipNewItem(SLOT_RANGED, 45511, true);
                    player->EquipNewItem(SLOT_NECK, 50211, true);
                    //player->EquipNewItem(SLOT_TABARD, 0000000, true);
                    player->EquipNewItem(SLOT_WRISTS, 45275, true);
                    player->EquipNewItem(SLOT_FINGER1, 48957, true);
                    player->EquipNewItem(SLOT_WAIST, 40301, true);
                    player->EquipNewItem(SLOT_FEET, 50286, true);
                    player->EquipNewItem(SLOT_BACK, 45242, true);
                    player->EquipNewItem(SLOT_FINGER2, 45451, true);
                    player->EquipNewItem(SLOT_TRINKET1, 45518, true);
                    player->EquipNewItem(SLOT_TRINKET2, 47213, true);
                    DobaviBokluciNaGeroq(player);
                    DobaviMagiiNaGeroq(player);
                    // LoginDatabase.PQuery("update account set free = 0 where id = %u;", player->GetSession()->GetAccountId());
                    // TC_LOG_INFO("server.worldserver", "UPDATED SUCCESSFULLY");
                    player->GetSession()->KickPlayer();
                    player->PlayerTalkClass->SendCloseGossip();
                break;

            default:
                    // TC_LOG_INFO("server.worldserver", "ERROR (#default)");
                    break;
            }
        }
    return true;
    }
};

class npc_tokengiver_i80 : public CreatureScript  
{
public:
    npc_tokengiver_i80() : CreatureScript("npc_tokengiver_i80") {}

    bool OnGossipHello(Player* player, Creature* me)
    {
        if (!sWorld->getBoolConfig(CUSTOM_SCRIPTS_ENABLED_OR_NOT))
            return false;

        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "By clicking this option you agree that you will recieve your token WHICH IS NOT REFUNDABLE and the purchase you do trough it is NON REFUNDABLE EITHER.", GOSSIP_SENDER_MAIN, 1);
        player->SEND_GOSSIP_MENU(68, me->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* me, uint32 /*uiSender*/, uint32 uiAction)
    {
        player->PlayerTalkClass->ClearMenus();

        switch (uiAction)
        {
        case 1: // Join Queue
            {
                
                QueryResult rezultat = LoginDatabase.PQuery("select `id` from `account_free_character` where `id` = %u", player->GetSession()->GetAccountId());
                if (!rezultat)
                {
                        LoginDatabase.PQuery("INSERT INTO account_free_character (`id`, `character`) VALUES ('%u', '%s')", player->GetSession()->GetAccountId(), player->GetName().c_str());
                        player->AddItem(111111, 1);
                }
                else
                    player->GetSession()->SendNotification("You have already used your free premade character!");
                
                player->CLOSE_GOSSIP_MENU();
                return true;
            }
            break;
        }

        OnGossipHello(player, me);
        return true;
    }
};

void AddSC_Instant80_characters()
{
    new npc_free_pvp_character();
    new npc_free_pve_character();
    new npc_tokengiver_i80();
}