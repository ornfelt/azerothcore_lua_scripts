#include "Creature.h"
#include "DBCStores.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "GameEventCallbacks.h"
#include "HungerGamesStore.h"

#define CREATURE_DEATH_GIVE_SPELLS_ENTRY  123462

void DealLastBreathDamageToPlayer(Creature *Attacker, Player *Victim);

//when you manage to kill a creature. You can kill steal XP loot
void HungerGamesPlayerLootSpell(void *p, void *)
{
    CP_CREATURE_INTERRACT *params = PointerCast(CP_CREATURE_INTERRACT, p);

    //sanity check
    if (params->player == NULL || params->creature == NULL)
        return;

    //killer player gets XP based on creature Entry
    if (params->creature->GetEntry() != CREATURE_DEATH_GIVE_SPELLS_ENTRY)
        return;

    //no repsawning. We will spawn a new random creature
    params->creature->AddObjectToRemoveList();

    // the price of killing this NPC
    DealLastBreathDamageToPlayer(params->creature, params->player);

    Player *Plr = params->player;

    if (Plr->getClass() == 1)
    {
        if (Plr->getLevel() >= 1)
        {
            Plr->LearnSpell(6673, false);
        }
        if (Plr->getLevel() >= 4)
        {
            Plr->LearnSpell(100, false);
            Plr->LearnSpell(772, false);
        }
        if (Plr->getLevel() >= 6)
        {
            Plr->LearnSpell(34428, false);
            Plr->LearnSpell(3127, false);
            Plr->LearnSpell(6343, false);
        }
        if (Plr->getLevel() >= 8)
        {
            Plr->LearnSpell(1715, false);
            Plr->LearnSpell(284, false);
        }
        if (Plr->getLevel() >= 10)
        {
            Plr->LearnSpell(2687, false);
            Plr->LearnSpell(6546, false);
        }
        if (Plr->getLevel() >= 12)
        {
            Plr->LearnSpell(5242, false);
            Plr->LearnSpell(72, false);
            Plr->LearnSpell(7384, false);
        }
        if (Plr->getLevel() >= 14)
        {
            Plr->LearnSpell(6572, false);
            Plr->LearnSpell(1160, false);
        }
        if (Plr->getLevel() >= 16)
        {
            Plr->LearnSpell(2565, false);
            Plr->LearnSpell(694, false);
            Plr->LearnSpell(285, false);
        }
        if (Plr->getLevel() >= 18)
        {
            Plr->LearnSpell(8198, false);
            Plr->LearnSpell(676, false);
        }
        if (Plr->getLevel() >= 20)
        {
            Plr->LearnSpell(674, false);
            Plr->LearnSpell(12678, false);
            Plr->LearnSpell(6547, false);
            Plr->LearnSpell(20230, false);
            Plr->LearnSpell(845, false);
        }
        if (Plr->getLevel() >= 22)
        {
            Plr->LearnSpell(6192, false);
            Plr->LearnSpell(5246, false);
        }
        if (Plr->getLevel() >= 24)
        {
            Plr->LearnSpell(1608, false);
            Plr->LearnSpell(6574, false);
            Plr->LearnSpell(6190, false);
            Plr->LearnSpell(5308, false);
        }
        if (Plr->getLevel() >= 26)
        {
            Plr->LearnSpell(6178, false);
            Plr->LearnSpell(1161, false);
        }
        if (Plr->getLevel() >= 28)
        {
            Plr->LearnSpell(8204, false);
            Plr->LearnSpell(871, false);
        }
        if (Plr->getLevel() >= 30)
        {
            Plr->LearnSpell(7369, false);
            Plr->LearnSpell(20252, false);
            Plr->LearnSpell(1464, false);
            Plr->LearnSpell(6548, false);
        }
        if (Plr->getLevel() >= 32)
        {
            Plr->LearnSpell(18499, false);
            Plr->LearnSpell(11564, false);
            Plr->LearnSpell(20658, false);
            Plr->LearnSpell(11549, false);
        }
        if (Plr->getLevel() >= 34)
        {
            Plr->LearnSpell(11554, false);
            Plr->LearnSpell(7379, false);
        }
        if (Plr->getLevel() >= 36)
        {
            Plr->LearnSpell(1680, false);
        }
        if (Plr->getLevel() >= 38)
        {
            Plr->LearnSpell(8820, false);
            Plr->LearnSpell(6552, false);
            Plr->LearnSpell(8205, false);
        }
        if (Plr->getLevel() >= 40)
        {
            Plr->LearnSpell(750, false);
            Plr->LearnSpell(20660, false);
            Plr->LearnSpell(11565, false);
            Plr->LearnSpell(11608, false);
            Plr->LearnSpell(11572, false);
            Plr->LearnSpell(23922, false);
        }
        if (Plr->getLevel() >= 42)
        {
            Plr->LearnSpell(11550, false);
        }
        if (Plr->getLevel() >= 44)
        {
            Plr->LearnSpell(11600, false);
            Plr->LearnSpell(11555, false);
        }
        if (Plr->getLevel() >= 46)
        {
            Plr->LearnSpell(11604, false);
            Plr->LearnSpell(11578, false);
        }
        if (Plr->getLevel() >= 48)
        {
            Plr->LearnSpell(11580, false);
            Plr->LearnSpell(21551, false);
            Plr->LearnSpell(20661, false);
            Plr->LearnSpell(11566, false);
            Plr->LearnSpell(23923, false);
        }
        if (Plr->getLevel() >= 50)
        {
            Plr->LearnSpell(11573, false);
            Plr->LearnSpell(1719, false);
            Plr->LearnSpell(11609, false);
        }
        if (Plr->getLevel() >= 52)
        {
            Plr->LearnSpell(11551, false);
        }
        if (Plr->getLevel() >= 54)
        {
            Plr->LearnSpell(11556, false);
            Plr->LearnSpell(23924, false);
            Plr->LearnSpell(11601, false);
            Plr->LearnSpell(11605, false);
            Plr->LearnSpell(21552, false);
        }
        if (Plr->getLevel() >= 56)
        {
            Plr->LearnSpell(11567, false);
            Plr->LearnSpell(20662, false);
        }
        if (Plr->getLevel() >= 58)
        {
            Plr->LearnSpell(11581, false);
        }
        if (Plr->getLevel() >= 60)
        {
            Plr->LearnSpell(30016, false);
            Plr->LearnSpell(23925, false);
            Plr->LearnSpell(21553, false);
            Plr->LearnSpell(11574, false);
            Plr->LearnSpell(25288, false);
            Plr->LearnSpell(25289, false);
            Plr->LearnSpell(25286, false);
            Plr->LearnSpell(20569, false);
        }
        if (Plr->getLevel() >= 61)
        {
            Plr->LearnSpell(25241, false);
        }
        if (Plr->getLevel() >= 62)
        {
            Plr->LearnSpell(25202, false);
        }
        if (Plr->getLevel() >= 63)
        {
            Plr->LearnSpell(25269, false);
        }
        if (Plr->getLevel() >= 64)
        {
            Plr->LearnSpell(23920, false);
        }
        if (Plr->getLevel() >= 65)
        {
            Plr->LearnSpell(25234, false);
        }
        if (Plr->getLevel() >= 66)
        {
            Plr->LearnSpell(25258, false);
            Plr->LearnSpell(29707, false);
            Plr->LearnSpell(25248, false);
        }
        if (Plr->getLevel() >= 67)
        {
            Plr->LearnSpell(25264, false);
        }
        if (Plr->getLevel() >= 68)
        {
            Plr->LearnSpell(25208, false);
            Plr->LearnSpell(25231, false);
            Plr->LearnSpell(469, false);
        }
        if (Plr->getLevel() >= 69)
        {
            Plr->LearnSpell(25242, false);
            Plr->LearnSpell(2048, false);
        }
        if (Plr->getLevel() >= 70)
        {
            Plr->LearnSpell(30357, false);
            Plr->LearnSpell(3411, false);
            Plr->LearnSpell(25236, false);
            Plr->LearnSpell(30324, false);
            Plr->LearnSpell(30022, false);
            Plr->LearnSpell(25203, false);
            Plr->LearnSpell(30356, false);
            Plr->LearnSpell(30330, false);
        }
        if (Plr->getLevel() >= 71)
        {
            Plr->LearnSpell(64382, false);
            Plr->LearnSpell(46845, false);
        }
        if (Plr->getLevel() >= 72)
        {
            Plr->LearnSpell(47449, false);
            Plr->LearnSpell(47519, false);
        }
        if (Plr->getLevel() >= 73)
        {
            Plr->LearnSpell(47470, false);
            Plr->LearnSpell(47501, false);
        }
        if (Plr->getLevel() >= 74)
        {
            Plr->LearnSpell(47474, false);
            Plr->LearnSpell(47439, false);
        }
        if (Plr->getLevel() >= 75)
        {
            Plr->LearnSpell(47487, false);
            Plr->LearnSpell(47485, false);
            Plr->LearnSpell(47497, false);
            Plr->LearnSpell(55694, false);
        }
        if (Plr->getLevel() >= 76)
        {
            Plr->LearnSpell(47465, false);
            Plr->LearnSpell(47450, false);
        }
        if (Plr->getLevel() >= 77)
        {
            Plr->LearnSpell(47520, false);
        }
        if (Plr->getLevel() >= 78)
        {
            Plr->LearnSpell(47502, false);
            Plr->LearnSpell(47436, false);
        }
        if (Plr->getLevel() >= 79)
        {
            Plr->LearnSpell(47437, false);
            Plr->LearnSpell(47475, false);
        }
        if (Plr->getLevel() >= 80)
        {
            Plr->LearnSpell(47498, false);
            Plr->LearnSpell(47471, false);
            Plr->LearnSpell(47440, false);
            Plr->LearnSpell(47488, false);
            Plr->LearnSpell(57755, false);
            Plr->LearnSpell(47486, false);
            Plr->LearnSpell(57823, false);
        }
    }
    if (Plr->getClass() == 2)
    {
        if (Plr->getLevel() >= 1)
        {
            Plr->LearnSpell(465, false);
        }
        if (Plr->getLevel() >= 4)
        {
            Plr->LearnSpell(20271, false);
            Plr->LearnSpell(19740, false);
        }
        if (Plr->getLevel() >= 6)
        {
            Plr->LearnSpell(498, false);
            Plr->LearnSpell(639, false);
        }
        if (Plr->getLevel() >= 8)
        {
            Plr->LearnSpell(1152, false);
            Plr->LearnSpell(853, false);
            Plr->LearnSpell(3127, false);
        }
        if (Plr->getLevel() >= 10)
        {
            Plr->LearnSpell(1022, false);
            Plr->LearnSpell(10290, false);
            Plr->LearnSpell(633, false);
        }
        if (Plr->getLevel() >= 12)
        {
            Plr->LearnSpell(19834, false);
            Plr->LearnSpell(53408, false);
        }
        if (Plr->getLevel() >= 14)
        {
            Plr->LearnSpell(19742, false);
            Plr->LearnSpell(647, false);
            Plr->LearnSpell(31789, false);
        }
        if (Plr->getLevel() >= 16)
        {
            Plr->LearnSpell(25780, false);
            Plr->LearnSpell(62124, false);
            Plr->LearnSpell(7294, false);
        }
        if (Plr->getLevel() >= 18)
        {
            Plr->LearnSpell(1044, false);
        }
        if (Plr->getLevel() >= 20)
        {
            Plr->LearnSpell(34768, false);
            Plr->LearnSpell(879, false);
            Plr->LearnSpell(5502, false);
            Plr->LearnSpell(19750, false);
            Plr->LearnSpell(13820, false);
            Plr->LearnSpell(643, false);
            Plr->LearnSpell(26573, false);
            Plr->LearnSpell(20217, false);
        }
        if (Plr->getLevel() >= 22)
        {
            Plr->LearnSpell(1026, false);
            Plr->LearnSpell(19835, false);
            Plr->LearnSpell(19746, false);
            Plr->LearnSpell(20164, false);
        }
        if (Plr->getLevel() >= 24)
        {
            Plr->LearnSpell(5599, false);
            Plr->LearnSpell(10326, false);
            Plr->LearnSpell(10322, false);
            Plr->LearnSpell(19850, false);
            Plr->LearnSpell(5588, false);
        }
        if (Plr->getLevel() >= 26)
        {
            Plr->LearnSpell(1038, false);
            Plr->LearnSpell(19939, false);
            Plr->LearnSpell(10298, false);
        }
        if (Plr->getLevel() >= 28)
        {
            Plr->LearnSpell(5614, false);
            Plr->LearnSpell(53407, false);
            Plr->LearnSpell(19876, false);
        }
        if (Plr->getLevel() >= 30)
        {
            Plr->LearnSpell(10291, false);
            Plr->LearnSpell(20165, false);
            Plr->LearnSpell(20116, false);
            Plr->LearnSpell(19752, false);
            Plr->LearnSpell(2800, false);
            Plr->LearnSpell(1042, false);
        }
        if (Plr->getLevel() >= 32)
        {
            Plr->LearnSpell(19888, false);
            Plr->LearnSpell(19836, false);
        }
        if (Plr->getLevel() >= 34)
        {
            Plr->LearnSpell(19940, false);
            Plr->LearnSpell(642, false);
            Plr->LearnSpell(19852, false);
        }
        if (Plr->getLevel() >= 36)
        {
            Plr->LearnSpell(19891, false);
            Plr->LearnSpell(10299, false);
            Plr->LearnSpell(5615, false);
            Plr->LearnSpell(10324, false);
        }
        if (Plr->getLevel() >= 38)
        {
            Plr->LearnSpell(20166, false);
            Plr->LearnSpell(3472, false);
            Plr->LearnSpell(10278, false);
        }
        if (Plr->getLevel() >= 40)
        {
            Plr->LearnSpell(750, false);
            Plr->LearnSpell(20922, false);
            Plr->LearnSpell(1032, false);
            Plr->LearnSpell(23214, false);
            Plr->LearnSpell(5589, false);
            Plr->LearnSpell(19895, false);
            Plr->LearnSpell(34767, false);
        }
        if (Plr->getLevel() >= 42)
        {
            Plr->LearnSpell(19837, false);
            Plr->LearnSpell(19941, false);
            Plr->LearnSpell(4987, false);
        }
        if (Plr->getLevel() >= 44)
        {
            Plr->LearnSpell(10312, false);
            Plr->LearnSpell(19897, false);
            Plr->LearnSpell(19853, false);
            Plr->LearnSpell(24275, false);
        }
        if (Plr->getLevel() >= 46)
        {
            Plr->LearnSpell(10328, false);
            Plr->LearnSpell(10300, false);
            Plr->LearnSpell(6940, false);
        }
        if (Plr->getLevel() >= 48)
        {
            Plr->LearnSpell(20772, false);
            Plr->LearnSpell(20929, false);
            Plr->LearnSpell(19899, false);
        }
        if (Plr->getLevel() >= 50)
        {
            Plr->LearnSpell(2812, false);
            Plr->LearnSpell(10292, false);
            Plr->LearnSpell(19942, false);
            Plr->LearnSpell(20923, false);
            Plr->LearnSpell(10310, false);
            Plr->LearnSpell(20927, false);
        }
        if (Plr->getLevel() >= 52)
        {
            Plr->LearnSpell(10313, false);
            Plr->LearnSpell(19838, false);
            Plr->LearnSpell(19896, false);
            Plr->LearnSpell(25782, false);
            Plr->LearnSpell(24274, false);
        }
        if (Plr->getLevel() >= 54)
        {
            Plr->LearnSpell(10308, false);
            Plr->LearnSpell(19854, false);
            Plr->LearnSpell(25894, false);
            Plr->LearnSpell(10329, false);
        }
        if (Plr->getLevel() >= 56)
        {
            Plr->LearnSpell(20930, false);
            Plr->LearnSpell(19898, false);
            Plr->LearnSpell(10301, false);
        }
        if (Plr->getLevel() >= 58)
        {
            Plr->LearnSpell(19943, false);
        }
        if (Plr->getLevel() >= 60)
        {
            Plr->LearnSpell(20924, false);
            Plr->LearnSpell(19900, false);
            Plr->LearnSpell(25918, false);
            Plr->LearnSpell(10314, false);
            Plr->LearnSpell(25292, false);
            Plr->LearnSpell(25290, false);
            Plr->LearnSpell(25898, false);
            Plr->LearnSpell(10318, false);
            Plr->LearnSpell(24239, false);
            Plr->LearnSpell(25899, false);
            Plr->LearnSpell(25291, false);
            Plr->LearnSpell(32699, false);
            Plr->LearnSpell(20928, false);
            Plr->LearnSpell(25916, false);
            Plr->LearnSpell(20773, false);
            Plr->LearnSpell(10293, false);
        }
        if (Plr->getLevel() >= 62)
        {
            Plr->LearnSpell(27135, false);
            Plr->LearnSpell(32223, false);
        }
        if (Plr->getLevel() >= 63)
        {
            Plr->LearnSpell(27151, false);
        }
        if (Plr->getLevel() >= 64)
        {
            Plr->LearnSpell(27174, false);
            Plr->LearnSpell(31801, false);
        }
        if (Plr->getLevel() >= 65)
        {
            Plr->LearnSpell(27142, false);
            Plr->LearnSpell(27143, false);
        }
        if (Plr->getLevel() >= 66)
        {
            Plr->LearnSpell(27137, false);
            Plr->LearnSpell(27150, false);
            Plr->LearnSpell(53736, false);
        }
        if (Plr->getLevel() >= 68)
        {
            Plr->LearnSpell(27138, false);
            Plr->LearnSpell(27180, false);
            Plr->LearnSpell(27152, false);
        }
        if (Plr->getLevel() >= 69)
        {
            Plr->LearnSpell(27139, false);
            Plr->LearnSpell(27154, false);
        }
        if (Plr->getLevel() >= 70)
        {
            Plr->LearnSpell(27149, false);
            Plr->LearnSpell(33072, false);
            Plr->LearnSpell(27153, false);
            Plr->LearnSpell(27136, false);
            Plr->LearnSpell(27179, false);
            Plr->LearnSpell(32700, false);
            Plr->LearnSpell(27141, false);
            Plr->LearnSpell(27173, false);
            Plr->LearnSpell(31884, false);
            Plr->LearnSpell(27140, false);
        }
        if (Plr->getLevel() >= 71)
        {
            Plr->LearnSpell(48937, false);
            Plr->LearnSpell(54428, false);
            Plr->LearnSpell(48935, false);
        }
        if (Plr->getLevel() >= 72)
        {
            Plr->LearnSpell(48816, false);
            Plr->LearnSpell(48949, false);
        }
        if (Plr->getLevel() >= 73)
        {
            Plr->LearnSpell(48800, false);
            Plr->LearnSpell(48933, false);
            Plr->LearnSpell(48931, false);
        }
        if (Plr->getLevel() >= 74)
        {
            Plr->LearnSpell(48805, false);
            Plr->LearnSpell(48784, false);
            Plr->LearnSpell(48941, false);
        }
        if (Plr->getLevel() >= 75)
        {
            Plr->LearnSpell(48818, false);
            Plr->LearnSpell(48824, false);
            Plr->LearnSpell(53600, false);
            Plr->LearnSpell(48781, false);
            Plr->LearnSpell(48951, false);
            Plr->LearnSpell(48826, false);
        }
        if (Plr->getLevel() >= 76)
        {
            Plr->LearnSpell(48943, false);
            Plr->LearnSpell(54043, false);
        }
        if (Plr->getLevel() >= 77)
        {
            Plr->LearnSpell(48938, false);
            Plr->LearnSpell(48945, false);
            Plr->LearnSpell(48936, false);
        }
        if (Plr->getLevel() >= 78)
        {
            Plr->LearnSpell(48817, false);
            Plr->LearnSpell(48947, false);
            Plr->LearnSpell(48788, false);
        }
        if (Plr->getLevel() >= 79)
        {
            Plr->LearnSpell(48950, false);
            Plr->LearnSpell(48934, false);
            Plr->LearnSpell(48932, false);
            Plr->LearnSpell(48785, false);
            Plr->LearnSpell(48801, false);
            Plr->LearnSpell(48942, false);
        }
        if (Plr->getLevel() >= 80)
        {
            Plr->LearnSpell(48827, false);
            Plr->LearnSpell(48825, false);
            Plr->LearnSpell(53601, false);
            Plr->LearnSpell(48806, false);
            Plr->LearnSpell(61411, false);
            Plr->LearnSpell(48782, false);
            Plr->LearnSpell(48952, false);
            Plr->LearnSpell(48819, false);
        }
    }
    if (Plr->getClass() == 3)
    {
        if (Plr->getLevel() >= 2)
        {
            Plr->LearnSpell(1494, false);
        }
        if (Plr->getLevel() >= 4)
        {
            Plr->LearnSpell(13163, false);
            Plr->LearnSpell(1978, false);
        }
        if (Plr->getLevel() >= 6)
        {
            Plr->LearnSpell(3044, false);
            Plr->LearnSpell(1130, false);
        }
        if (Plr->getLevel() >= 8)
        {
            Plr->LearnSpell(3127, false);
            Plr->LearnSpell(14260, false);
            Plr->LearnSpell(5116, false);
        }
        if (Plr->getLevel() >= 10)
        {
            Plr->LearnSpell(13165, false);
            Plr->LearnSpell(19883, false);
            Plr->LearnSpell(13549, false);
        }
        if (Plr->getLevel() >= 12)
        {
            Plr->LearnSpell(136, false);
            Plr->LearnSpell(14281, false);
            Plr->LearnSpell(2974, false);
            Plr->LearnSpell(20736, false);
        }
        if (Plr->getLevel() >= 14)
        {
            Plr->LearnSpell(6197, false);
            Plr->LearnSpell(1002, false);
            Plr->LearnSpell(1513, false);
        }
        if (Plr->getLevel() >= 16)
        {
            Plr->LearnSpell(1495, false);
            Plr->LearnSpell(13795, false);
            Plr->LearnSpell(5118, false);
            Plr->LearnSpell(14261, false);
        }
        if (Plr->getLevel() >= 18)
        {
            Plr->LearnSpell(14318, false);
            Plr->LearnSpell(19884, false);
            Plr->LearnSpell(13550, false);
            Plr->LearnSpell(2643, false);
        }
        if (Plr->getLevel() >= 20)
        {
            Plr->LearnSpell(1499, false);
            Plr->LearnSpell(674, false);
            Plr->LearnSpell(781, false);
            Plr->LearnSpell(34074, false);
            Plr->LearnSpell(3111, false);
            Plr->LearnSpell(14282, false);
        }
        if (Plr->getLevel() >= 22)
        {
            Plr->LearnSpell(14323, false);
            Plr->LearnSpell(3043, false);
        }
        if (Plr->getLevel() >= 24)
        {
            Plr->LearnSpell(19885, false);
            Plr->LearnSpell(14262, false);
            Plr->LearnSpell(1462, false);
        }
        if (Plr->getLevel() >= 26)
        {
            Plr->LearnSpell(13551, false);
            Plr->LearnSpell(19880, false);
            Plr->LearnSpell(3045, false);
            Plr->LearnSpell(14302, false);
        }
        if (Plr->getLevel() >= 28)
        {
            Plr->LearnSpell(13809, false);
            Plr->LearnSpell(14283, false);
            Plr->LearnSpell(3661, false);
            Plr->LearnSpell(20900, false);
            Plr->LearnSpell(14319, false);
        }
        if (Plr->getLevel() >= 30)
        {
            Plr->LearnSpell(14269, false);
            Plr->LearnSpell(5384, false);
            Plr->LearnSpell(14326, false);
            Plr->LearnSpell(13161, false);
            Plr->LearnSpell(14288, false);
        }
        if (Plr->getLevel() >= 32)
        {
            Plr->LearnSpell(19878, false);
            Plr->LearnSpell(14263, false);
            Plr->LearnSpell(1543, false);
        }
        if (Plr->getLevel() >= 34)
        {
            Plr->LearnSpell(13552, false);
            Plr->LearnSpell(13813, false);
        }
        if (Plr->getLevel() >= 36)
        {
            Plr->LearnSpell(3034, false);
            Plr->LearnSpell(3662, false);
            Plr->LearnSpell(14303, false);
            Plr->LearnSpell(20901, false);
            Plr->LearnSpell(14284, false);
        }
        if (Plr->getLevel() >= 38)
        {
            Plr->LearnSpell(14320, false);
        }
        if (Plr->getLevel() >= 40)
        {
            Plr->LearnSpell(14264, false);
            Plr->LearnSpell(14324, false);
            Plr->LearnSpell(14310, false);
            Plr->LearnSpell(13159, false);
            Plr->LearnSpell(8737, false);
            Plr->LearnSpell(1510, false);
            Plr->LearnSpell(19882, false);
        }
        if (Plr->getLevel() >= 42)
        {
            Plr->LearnSpell(14289, false);
            Plr->LearnSpell(20909, false);
            Plr->LearnSpell(13553, false);
        }
        if (Plr->getLevel() >= 44)
        {
            Plr->LearnSpell(14316, false);
            Plr->LearnSpell(14285, false);
            Plr->LearnSpell(14270, false);
            Plr->LearnSpell(13542, false);
            Plr->LearnSpell(20902, false);
        }
        if (Plr->getLevel() >= 46)
        {
            Plr->LearnSpell(14304, false);
            Plr->LearnSpell(14327, false);
            Plr->LearnSpell(20043, false);
        }
        if (Plr->getLevel() >= 48)
        {
            Plr->LearnSpell(14265, false);
            Plr->LearnSpell(14321, false);
        }
        if (Plr->getLevel() >= 50)
        {
            Plr->LearnSpell(56641, false);
            Plr->LearnSpell(13554, false);
            Plr->LearnSpell(24132, false);
            Plr->LearnSpell(14294, false);
            Plr->LearnSpell(19879, false);
        }
        if (Plr->getLevel() >= 52)
        {
            Plr->LearnSpell(14286, false);
            Plr->LearnSpell(13543, false);
            Plr->LearnSpell(20903, false);
        }
        if (Plr->getLevel() >= 54)
        {
            Plr->LearnSpell(14317, false);
            Plr->LearnSpell(20910, false);
            Plr->LearnSpell(14290, false);
        }
        if (Plr->getLevel() >= 56)
        {
            Plr->LearnSpell(20190, false);
            Plr->LearnSpell(14305, false);
            Plr->LearnSpell(14266, false);
        }
        if (Plr->getLevel() >= 57)
        {
            Plr->LearnSpell(63668, false);
        }
        if (Plr->getLevel() >= 58)
        {
            Plr->LearnSpell(13555, false);
            Plr->LearnSpell(14271, false);
            Plr->LearnSpell(14322, false);
            Plr->LearnSpell(14295, false);
            Plr->LearnSpell(14325, false);
        }
        if (Plr->getLevel() >= 60)
        {
            Plr->LearnSpell(25295, false);
            Plr->LearnSpell(24133, false);
            Plr->LearnSpell(25294, false);
            Plr->LearnSpell(20904, false);
            Plr->LearnSpell(14287, false);
            Plr->LearnSpell(19801, false);
            Plr->LearnSpell(19263, false);
            Plr->LearnSpell(14311, false);
            Plr->LearnSpell(13544, false);
            Plr->LearnSpell(25296, false);
        }
        if (Plr->getLevel() >= 61)
        {
            Plr->LearnSpell(27025, false);
        }
        if (Plr->getLevel() >= 62)
        {
            Plr->LearnSpell(34120, false);
        }
        if (Plr->getLevel() >= 63)
        {
            Plr->LearnSpell(63669, false);
            Plr->LearnSpell(27014, false);
        }
        if (Plr->getLevel() >= 65)
        {
            Plr->LearnSpell(27023, false);
        }
        if (Plr->getLevel() >= 66)
        {
            Plr->LearnSpell(34026, false);
            Plr->LearnSpell(27067, false);
        }
        if (Plr->getLevel() >= 67)
        {
            Plr->LearnSpell(27022, false);
            Plr->LearnSpell(27021, false);
            Plr->LearnSpell(27016, false);
        }
        if (Plr->getLevel() >= 68)
        {
            Plr->LearnSpell(27046, false);
            Plr->LearnSpell(27044, false);
            Plr->LearnSpell(27045, false);
            Plr->LearnSpell(34600, false);
        }
        if (Plr->getLevel() >= 69)
        {
            Plr->LearnSpell(63670, false);
            Plr->LearnSpell(27019, false);
        }
        if (Plr->getLevel() >= 70)
        {
            Plr->LearnSpell(36916, false);
            Plr->LearnSpell(27068, false);
            Plr->LearnSpell(34477, false);
            Plr->LearnSpell(27065, false);
            Plr->LearnSpell(60051, false);
        }
        if (Plr->getLevel() >= 71)
        {
            Plr->LearnSpell(49051, false);
            Plr->LearnSpell(48995, false);
            Plr->LearnSpell(53351, false);
            Plr->LearnSpell(49066, false);
        }
        if (Plr->getLevel() >= 72)
        {
            Plr->LearnSpell(48998, false);
            Plr->LearnSpell(49055, false);
        }
        if (Plr->getLevel() >= 73)
        {
            Plr->LearnSpell(49000, false);
            Plr->LearnSpell(49044, false);
        }
        if (Plr->getLevel() >= 74)
        {
            Plr->LearnSpell(58431, false);
            Plr->LearnSpell(61846, false);
            Plr->LearnSpell(48989, false);
            Plr->LearnSpell(49047, false);
        }
        if (Plr->getLevel() >= 75)
        {
            Plr->LearnSpell(60052, false);
            Plr->LearnSpell(63671, false);
            Plr->LearnSpell(53271, false);
            Plr->LearnSpell(61005, false);
            Plr->LearnSpell(49011, false);
            Plr->LearnSpell(49049, false);
        }
        if (Plr->getLevel() >= 76)
        {
            Plr->LearnSpell(49071, false);
            Plr->LearnSpell(53338, false);
        }
        if (Plr->getLevel() >= 77)
        {
            Plr->LearnSpell(49052, false);
            Plr->LearnSpell(49067, false);
            Plr->LearnSpell(48996, false);
        }
        if (Plr->getLevel() >= 78)
        {
            Plr->LearnSpell(48999, false);
            Plr->LearnSpell(49056, false);
        }
        if (Plr->getLevel() >= 79)
        {
            Plr->LearnSpell(49045, false);
            Plr->LearnSpell(49001, false);
        }
        if (Plr->getLevel() >= 80)
        {
            Plr->LearnSpell(49050, false);
            Plr->LearnSpell(49012, false);
            Plr->LearnSpell(63672, false);
            Plr->LearnSpell(62757, false);
            Plr->LearnSpell(61847, false);
            Plr->LearnSpell(53339, false);
            Plr->LearnSpell(58434, false);
            Plr->LearnSpell(48990, false);
            Plr->LearnSpell(60192, false);
            Plr->LearnSpell(49048, false);
            Plr->LearnSpell(60053, false);
            Plr->LearnSpell(61006, false);
        }
    }
    if (Plr->getClass() == 4)
    {
        if (Plr->getLevel() >= 1)
        {
            Plr->LearnSpell(1784, false);
        }
        if (Plr->getLevel() >= 4)
        {
            Plr->LearnSpell(921, false);
            Plr->LearnSpell(53, false);
        }
        if (Plr->getLevel() >= 6)
        {
            Plr->LearnSpell(1757, false);
            Plr->LearnSpell(1776, false);
        }
        if (Plr->getLevel() >= 8)
        {
            Plr->LearnSpell(5277, false);
            Plr->LearnSpell(6760, false);
        }
        if (Plr->getLevel() >= 10)
        {
            Plr->LearnSpell(6770, false);
            Plr->LearnSpell(674, false);
            Plr->LearnSpell(2983, false);
            Plr->LearnSpell(5171, false);
        }
        if (Plr->getLevel() >= 12)
        {
            Plr->LearnSpell(1766, false);
            Plr->LearnSpell(3127, false);
            Plr->LearnSpell(2589, false);
        }
        if (Plr->getLevel() >= 14)
        {
            Plr->LearnSpell(8647, false);
            Plr->LearnSpell(1758, false);
            Plr->LearnSpell(703, false);
        }
        if (Plr->getLevel() >= 16)
        {
            Plr->LearnSpell(6761, false);
            Plr->LearnSpell(1804, false);
            Plr->LearnSpell(1966, false);
        }
        if (Plr->getLevel() >= 18)
        {
            Plr->LearnSpell(8676, false);
        }
        if (Plr->getLevel() >= 20)
        {
            Plr->LearnSpell(2590, false);
            Plr->LearnSpell(51722, false);
            Plr->LearnSpell(1943, false);
        }
        if (Plr->getLevel() >= 22)
        {
            Plr->LearnSpell(1759, false);
            Plr->LearnSpell(1856, false);
            Plr->LearnSpell(8631, false);
            Plr->LearnSpell(1725, false);
        }
        if (Plr->getLevel() >= 24)
        {
            Plr->LearnSpell(6762, false);
            Plr->LearnSpell(2836, false);
        }
        if (Plr->getLevel() >= 26)
        {
            Plr->LearnSpell(1833, false);
            Plr->LearnSpell(8724, false);
        }
        if (Plr->getLevel() >= 28)
        {
            Plr->LearnSpell(8639, false);
            Plr->LearnSpell(2070, false);
            Plr->LearnSpell(6768, false);
            Plr->LearnSpell(2591, false);
        }
        if (Plr->getLevel() >= 30)
        {
            Plr->LearnSpell(8632, false);
            Plr->LearnSpell(1760, false);
            Plr->LearnSpell(1842, false);
            Plr->LearnSpell(408, false);
        }
        if (Plr->getLevel() >= 32)
        {
            Plr->LearnSpell(8623, false);
        }
        if (Plr->getLevel() >= 34)
        {
            Plr->LearnSpell(2094, false);
            Plr->LearnSpell(8725, false);
            Plr->LearnSpell(8696, false);
        }
        if (Plr->getLevel() >= 36)
        {
            Plr->LearnSpell(8640, false);
            Plr->LearnSpell(8721, false);
        }
        if (Plr->getLevel() >= 38)
        {
            Plr->LearnSpell(8621, false);
            Plr->LearnSpell(8633, false);
        }
        if (Plr->getLevel() >= 40)
        {
            Plr->LearnSpell(8637, false);
            Plr->LearnSpell(1860, false);
            Plr->LearnSpell(8624, false);
        }
        if (Plr->getLevel() >= 42)
        {
            Plr->LearnSpell(11267, false);
            Plr->LearnSpell(1857, false);
            Plr->LearnSpell(6774, false);
        }
        if (Plr->getLevel() >= 44)
        {
            Plr->LearnSpell(11279, false);
            Plr->LearnSpell(11273, false);
        }
        if (Plr->getLevel() >= 46)
        {
            Plr->LearnSpell(11293, false);
            Plr->LearnSpell(11289, false);
            Plr->LearnSpell(17347, false);
        }
        if (Plr->getLevel() >= 48)
        {
            Plr->LearnSpell(11299, false);
            Plr->LearnSpell(11297, false);
        }
        if (Plr->getLevel() >= 50)
        {
            Plr->LearnSpell(26669, false);
            Plr->LearnSpell(8643, false);
            Plr->LearnSpell(11268, false);
            Plr->LearnSpell(34411, false);
        }
        if (Plr->getLevel() >= 52)
        {
            Plr->LearnSpell(11303, false);
            Plr->LearnSpell(11274, false);
            Plr->LearnSpell(11280, false);
        }
        if (Plr->getLevel() >= 54)
        {
            Plr->LearnSpell(11290, false);
            Plr->LearnSpell(11294, false);
        }
        if (Plr->getLevel() >= 56)
        {
            Plr->LearnSpell(11300, false);
        }
        if (Plr->getLevel() >= 58)
        {
            Plr->LearnSpell(11269, false);
            Plr->LearnSpell(17348, false);
            Plr->LearnSpell(11305, false);
        }
        if (Plr->getLevel() >= 60)
        {
            Plr->LearnSpell(11281, false);
            Plr->LearnSpell(34412, false);
            Plr->LearnSpell(25300, false);
            Plr->LearnSpell(25302, false);
            Plr->LearnSpell(11275, false);
            Plr->LearnSpell(31016, false);
        }
        if (Plr->getLevel() >= 61)
        {
            Plr->LearnSpell(26839, false);
        }
        if (Plr->getLevel() >= 62)
        {
            Plr->LearnSpell(26889, false);
            Plr->LearnSpell(32645, false);
            Plr->LearnSpell(26861, false);
        }
        if (Plr->getLevel() >= 64)
        {
            Plr->LearnSpell(27448, false);
            Plr->LearnSpell(26679, false);
            Plr->LearnSpell(26865, false);
        }
        if (Plr->getLevel() >= 66)
        {
            Plr->LearnSpell(27441, false);
            Plr->LearnSpell(31224, false);
        }
        if (Plr->getLevel() >= 68)
        {
            Plr->LearnSpell(26867, false);
            Plr->LearnSpell(26863, false);
        }
        if (Plr->getLevel() >= 69)
        {
            Plr->LearnSpell(32684, false);
        }
        if (Plr->getLevel() >= 70)
        {
            Plr->LearnSpell(48673, false);
            Plr->LearnSpell(26862, false);
            Plr->LearnSpell(48689, false);
            Plr->LearnSpell(26884, false);
            Plr->LearnSpell(5938, false);
            Plr->LearnSpell(34413, false);
            Plr->LearnSpell(26864, false);
        }
        if (Plr->getLevel() >= 71)
        {
            Plr->LearnSpell(51724, false);
        }
        if (Plr->getLevel() >= 72)
        {
            Plr->LearnSpell(48658, false);
        }
        if (Plr->getLevel() >= 73)
        {
            Plr->LearnSpell(48667, false);
        }
        if (Plr->getLevel() >= 74)
        {
            Plr->LearnSpell(57992, false);
            Plr->LearnSpell(48656, false);
            Plr->LearnSpell(48671, false);
        }
        if (Plr->getLevel() >= 75)
        {
            Plr->LearnSpell(48675, false);
            Plr->LearnSpell(57934, false);
            Plr->LearnSpell(48663, false);
            Plr->LearnSpell(48690, false);
        }
        if (Plr->getLevel() >= 76)
        {
            Plr->LearnSpell(48637, false);
            Plr->LearnSpell(48674, false);
        }
        if (Plr->getLevel() >= 78)
        {
            Plr->LearnSpell(48659, false);
        }
        if (Plr->getLevel() >= 79)
        {
            Plr->LearnSpell(48672, false);
            Plr->LearnSpell(48668, false);
        }
        if (Plr->getLevel() >= 80)
        {
            Plr->LearnSpell(48638, false);
            Plr->LearnSpell(48660, false);
            Plr->LearnSpell(48676, false);
            Plr->LearnSpell(51723, false);
            Plr->LearnSpell(48657, false);
            Plr->LearnSpell(57993, false);
            Plr->LearnSpell(48666, false);
            Plr->LearnSpell(48691, false);
        }
    }
    if (Plr->getClass() == 5)
    {
        if (Plr->getLevel() >= 1)
        {
            Plr->LearnSpell(1243, false);
        }
        if (Plr->getLevel() >= 4)
        {
            Plr->LearnSpell(2052, false);
            Plr->LearnSpell(589, false);
        }
        if (Plr->getLevel() >= 6)
        {
            Plr->LearnSpell(591, false);
            Plr->LearnSpell(17, false);
        }
        if (Plr->getLevel() >= 8)
        {
            Plr->LearnSpell(139, false);
            Plr->LearnSpell(586, false);
        }
        if (Plr->getLevel() >= 10)
        {
            Plr->LearnSpell(594, false);
            Plr->LearnSpell(2006, false);
            Plr->LearnSpell(2053, false);
            Plr->LearnSpell(8092, false);
        }
        if (Plr->getLevel() >= 12)
        {
            Plr->LearnSpell(592, false);
            Plr->LearnSpell(1244, false);
            Plr->LearnSpell(588, false);
        }
        if (Plr->getLevel() >= 14)
        {
            Plr->LearnSpell(528, false);
            Plr->LearnSpell(598, false);
            Plr->LearnSpell(6074, false);
            Plr->LearnSpell(8122, false);
        }
        if (Plr->getLevel() >= 16)
        {
            Plr->LearnSpell(8102, false);
            Plr->LearnSpell(2054, false);
        }
        if (Plr->getLevel() >= 18)
        {
            Plr->LearnSpell(970, false);
            Plr->LearnSpell(600, false);
            Plr->LearnSpell(527, false);
        }
        if (Plr->getLevel() >= 20)
        {
            Plr->LearnSpell(7128, false);
            Plr->LearnSpell(2944, false);
            Plr->LearnSpell(15237, false);
            Plr->LearnSpell(453, false);
            Plr->LearnSpell(6075, false);
            Plr->LearnSpell(14914, false);
            Plr->LearnSpell(9484, false);
            Plr->LearnSpell(6346, false);
            Plr->LearnSpell(2061, false);
        }
        if (Plr->getLevel() >= 22)
        {
            Plr->LearnSpell(984, false);
            Plr->LearnSpell(2096, false);
            Plr->LearnSpell(8103, false);
            Plr->LearnSpell(2010, false);
            Plr->LearnSpell(2055, false);
        }
        if (Plr->getLevel() >= 24)
        {
            Plr->LearnSpell(15262, false);
            Plr->LearnSpell(8129, false);
            Plr->LearnSpell(3747, false);
            Plr->LearnSpell(1245, false);
        }
        if (Plr->getLevel() >= 26)
        {
            Plr->LearnSpell(9472, false);
            Plr->LearnSpell(992, false);
            Plr->LearnSpell(19238, false);
            Plr->LearnSpell(6076, false);
        }
        if (Plr->getLevel() >= 28)
        {
            Plr->LearnSpell(8124, false);
            Plr->LearnSpell(17311, false);
            Plr->LearnSpell(15430, false);
            Plr->LearnSpell(6063, false);
            Plr->LearnSpell(19276, false);
            Plr->LearnSpell(8104, false);
        }
        if (Plr->getLevel() >= 30)
        {
            Plr->LearnSpell(14752, false);
            Plr->LearnSpell(6065, false);
            Plr->LearnSpell(596, false);
            Plr->LearnSpell(15263, false);
            Plr->LearnSpell(1004, false);
            Plr->LearnSpell(602, false);
            Plr->LearnSpell(605, false);
            Plr->LearnSpell(976, false);
        }
        if (Plr->getLevel() >= 32)
        {
            Plr->LearnSpell(9473, false);
            Plr->LearnSpell(552, false);
            Plr->LearnSpell(6077, false);
        }
        if (Plr->getLevel() >= 34)
        {
            Plr->LearnSpell(1706, false);
            Plr->LearnSpell(6064, false);
            Plr->LearnSpell(19240, false);
            Plr->LearnSpell(2767, false);
            Plr->LearnSpell(8105, false);
            Plr->LearnSpell(10880, false);
        }
        if (Plr->getLevel() >= 36)
        {
            Plr->LearnSpell(6066, false);
            Plr->LearnSpell(15264, false);
            Plr->LearnSpell(2791, false);
            Plr->LearnSpell(19277, false);
            Plr->LearnSpell(988, false);
            Plr->LearnSpell(17312, false);
            Plr->LearnSpell(15431, false);
        }
        if (Plr->getLevel() >= 38)
        {
            Plr->LearnSpell(6078, false);
            Plr->LearnSpell(6060, false);
            Plr->LearnSpell(9474, false);
        }
        if (Plr->getLevel() >= 40)
        {
            Plr->LearnSpell(2060, false);
            Plr->LearnSpell(9485, false);
            Plr->LearnSpell(14818, false);
            Plr->LearnSpell(8106, false);
            Plr->LearnSpell(996, false);
            Plr->LearnSpell(1006, false);
        }
        if (Plr->getLevel() >= 42)
        {
            Plr->LearnSpell(10892, false);
            Plr->LearnSpell(10898, false);
            Plr->LearnSpell(10888, false);
            Plr->LearnSpell(15265, false);
            Plr->LearnSpell(10957, false);
            Plr->LearnSpell(19241, false);
        }
        if (Plr->getLevel() >= 44)
        {
            Plr->LearnSpell(10927, false);
            Plr->LearnSpell(10909, false);
            Plr->LearnSpell(27799, false);
            Plr->LearnSpell(10915, false);
            Plr->LearnSpell(17313, false);
            Plr->LearnSpell(19278, false);
        }
        if (Plr->getLevel() >= 46)
        {
            Plr->LearnSpell(10881, false);
            Plr->LearnSpell(10945, false);
            Plr->LearnSpell(10933, false);
            Plr->LearnSpell(10963, false);
        }
        if (Plr->getLevel() >= 48)
        {
            Plr->LearnSpell(21562, false);
            Plr->LearnSpell(10899, false);
            Plr->LearnSpell(10937, false);
            Plr->LearnSpell(15266, false);
        }
        if (Plr->getLevel() >= 50)
        {
            Plr->LearnSpell(10951, false);
            Plr->LearnSpell(19242, false);
            Plr->LearnSpell(10893, false);
            Plr->LearnSpell(14819, false);
            Plr->LearnSpell(27870, false);
            Plr->LearnSpell(10916, false);
            Plr->LearnSpell(10960, false);
            Plr->LearnSpell(10928, false);
        }
        if (Plr->getLevel() >= 52)
        {
            Plr->LearnSpell(27800, false);
            Plr->LearnSpell(10964, false);
            Plr->LearnSpell(10946, false);
            Plr->LearnSpell(17314, false);
            Plr->LearnSpell(19279, false);
        }
        if (Plr->getLevel() >= 54)
        {
            Plr->LearnSpell(10900, false);
            Plr->LearnSpell(10934, false);
            Plr->LearnSpell(15267, false);
        }
        if (Plr->getLevel() >= 56)
        {
            Plr->LearnSpell(10929, false);
            Plr->LearnSpell(27683, false);
            Plr->LearnSpell(10890, false);
            Plr->LearnSpell(10917, false);
            Plr->LearnSpell(34863, false);
            Plr->LearnSpell(10958, false);
        }
        if (Plr->getLevel() >= 58)
        {
            Plr->LearnSpell(19243, false);
            Plr->LearnSpell(10965, false);
            Plr->LearnSpell(10894, false);
            Plr->LearnSpell(20770, false);
            Plr->LearnSpell(10947, false);
        }
        if (Plr->getLevel() >= 60)
        {
            Plr->LearnSpell(34864, false);
            Plr->LearnSpell(25316, false);
            Plr->LearnSpell(10961, false);
            Plr->LearnSpell(19280, false);
            Plr->LearnSpell(10952, false);
            Plr->LearnSpell(15261, false);
            Plr->LearnSpell(27801, false);
            Plr->LearnSpell(10901, false);
            Plr->LearnSpell(34916, false);
            Plr->LearnSpell(10955, false);
            Plr->LearnSpell(27871, false);
            Plr->LearnSpell(21564, false);
            Plr->LearnSpell(25315, false);
            Plr->LearnSpell(27841, false);
            Plr->LearnSpell(10938, false);
            Plr->LearnSpell(18807, false);
            Plr->LearnSpell(25314, false);
            Plr->LearnSpell(27681, false);
        }
        if (Plr->getLevel() >= 61)
        {
            Plr->LearnSpell(25363, false);
            Plr->LearnSpell(25233, false);
        }
        if (Plr->getLevel() >= 62)
        {
            Plr->LearnSpell(32379, false);
        }
        if (Plr->getLevel() >= 63)
        {
            Plr->LearnSpell(25210, false);
            Plr->LearnSpell(25372, false);
        }
        if (Plr->getLevel() >= 64)
        {
            Plr->LearnSpell(32546, false);
        }
        if (Plr->getLevel() >= 65)
        {
            Plr->LearnSpell(25221, false);
            Plr->LearnSpell(25367, false);
            Plr->LearnSpell(25217, false);
            Plr->LearnSpell(34865, false);
        }
        if (Plr->getLevel() >= 66)
        {
            Plr->LearnSpell(34433, false);
            Plr->LearnSpell(25384, false);
            Plr->LearnSpell(25437, false);
        }
        if (Plr->getLevel() >= 67)
        {
            Plr->LearnSpell(25235, false);
        }
        if (Plr->getLevel() >= 68)
        {
            Plr->LearnSpell(25467, false);
            Plr->LearnSpell(25213, false);
            Plr->LearnSpell(25308, false);
            Plr->LearnSpell(33076, false);
            Plr->LearnSpell(25433, false);
            Plr->LearnSpell(25331, false);
            Plr->LearnSpell(25435, false);
            Plr->LearnSpell(25387, false);
        }
        if (Plr->getLevel() >= 69)
        {
            Plr->LearnSpell(25431, false);
            Plr->LearnSpell(25375, false);
            Plr->LearnSpell(25364, false);
        }
        if (Plr->getLevel() >= 70)
        {
            Plr->LearnSpell(25389, false);
            Plr->LearnSpell(32375, false);
            Plr->LearnSpell(25392, false);
            Plr->LearnSpell(25222, false);
            Plr->LearnSpell(28275, false);
            Plr->LearnSpell(25368, false);
            Plr->LearnSpell(25312, false);
            Plr->LearnSpell(32996, false);
            Plr->LearnSpell(34866, false);
            Plr->LearnSpell(34917, false);
            Plr->LearnSpell(39374, false);
            Plr->LearnSpell(25218, false);
            Plr->LearnSpell(53005, false);
            Plr->LearnSpell(32999, false);
        }
        if (Plr->getLevel() >= 71)
        {
            Plr->LearnSpell(48040, false);
        }
        if (Plr->getLevel() >= 72)
        {
            Plr->LearnSpell(48134, false);
            Plr->LearnSpell(48119, false);
        }
        if (Plr->getLevel() >= 73)
        {
            Plr->LearnSpell(48062, false);
            Plr->LearnSpell(48070, false);
            Plr->LearnSpell(48299, false);
            Plr->LearnSpell(48172, false);
        }
        if (Plr->getLevel() >= 74)
        {
            Plr->LearnSpell(48112, false);
            Plr->LearnSpell(48122, false);
            Plr->LearnSpell(48155, false);
            Plr->LearnSpell(48126, false);
        }
        if (Plr->getLevel() >= 75)
        {
            Plr->LearnSpell(48159, false);
            Plr->LearnSpell(48077, false);
            Plr->LearnSpell(48088, false);
            Plr->LearnSpell(48065, false);
            Plr->LearnSpell(53006, false);
            Plr->LearnSpell(48086, false);
            Plr->LearnSpell(48124, false);
            Plr->LearnSpell(48067, false);
            Plr->LearnSpell(48045, false);
            Plr->LearnSpell(48157, false);
        }
        if (Plr->getLevel() >= 76)
        {
            Plr->LearnSpell(48072, false);
            Plr->LearnSpell(48169, false);
        }
        if (Plr->getLevel() >= 77)
        {
            Plr->LearnSpell(48168, false);
            Plr->LearnSpell(48170, false);
        }
        if (Plr->getLevel() >= 78)
        {
            Plr->LearnSpell(48171, false);
            Plr->LearnSpell(48063, false);
            Plr->LearnSpell(48135, false);
            Plr->LearnSpell(48120, false);
        }
        if (Plr->getLevel() >= 79)
        {
            Plr->LearnSpell(48123, false);
            Plr->LearnSpell(48113, false);
            Plr->LearnSpell(48127, false);
            Plr->LearnSpell(48300, false);
            Plr->LearnSpell(48071, false);
        }
        if (Plr->getLevel() >= 80)
        {
            Plr->LearnSpell(48074, false);
            Plr->LearnSpell(48173, false);
            Plr->LearnSpell(48125, false);
            Plr->LearnSpell(48158, false);
            Plr->LearnSpell(48089, false);
            Plr->LearnSpell(53023, false);
            Plr->LearnSpell(53007, false);
            Plr->LearnSpell(48156, false);
            Plr->LearnSpell(64901, false);
            Plr->LearnSpell(64843, false);
            Plr->LearnSpell(48087, false);
            Plr->LearnSpell(48160, false);
            Plr->LearnSpell(48073, false);
            Plr->LearnSpell(48066, false);
            Plr->LearnSpell(48161, false);
            Plr->LearnSpell(48078, false);
            Plr->LearnSpell(48068, false);
            Plr->LearnSpell(48162, false);
        }
    }
    if (Plr->getClass() == 6)
    {
        if (Plr->getLevel() >= 55)
        {
            Plr->LearnSpell(53343, false);
            Plr->LearnSpell(53341, false);
        }
        if (Plr->getLevel() >= 56)
        {
            Plr->LearnSpell(50842, false);
            Plr->LearnSpell(46584, false);
            Plr->LearnSpell(49998, false);
        }
        if (Plr->getLevel() >= 57)
        {
            Plr->LearnSpell(47528, false);
            Plr->LearnSpell(54447, false);
            Plr->LearnSpell(53342, false);
            Plr->LearnSpell(48263, false);
        }
        if (Plr->getLevel() >= 58)
        {
            Plr->LearnSpell(48721, false);
            Plr->LearnSpell(45524, false);
        }
        if (Plr->getLevel() >= 59)
        {
            Plr->LearnSpell(47476, false);
            Plr->LearnSpell(49926, false);
            Plr->LearnSpell(55258, false);
        }
        if (Plr->getLevel() >= 60)
        {
            Plr->LearnSpell(51416, false);
            Plr->LearnSpell(53331, false);
            Plr->LearnSpell(43265, false);
            Plr->LearnSpell(51325, false);
            Plr->LearnSpell(49917, false);
        }
        if (Plr->getLevel() >= 61)
        {
            Plr->LearnSpell(49896, false);
            Plr->LearnSpell(3714, false);
            Plr->LearnSpell(49020, false);
        }
        if (Plr->getLevel() >= 62)
        {
            Plr->LearnSpell(48792, false);
            Plr->LearnSpell(49892, false);
        }
        if (Plr->getLevel() >= 63)
        {
            Plr->LearnSpell(49999, false);
            Plr->LearnSpell(54446, false);
            Plr->LearnSpell(53323, false);
        }
        if (Plr->getLevel() >= 64)
        {
            Plr->LearnSpell(49927, false);
            Plr->LearnSpell(45529, false);
            Plr->LearnSpell(55259, false);
        }
        if (Plr->getLevel() >= 65)
        {
            Plr->LearnSpell(56222, false);
            Plr->LearnSpell(57330, false);
            Plr->LearnSpell(49918, false);
            Plr->LearnSpell(51417, false);
        }
        if (Plr->getLevel() >= 66)
        {
            Plr->LearnSpell(49939, false);
            Plr->LearnSpell(48743, false);
        }
        if (Plr->getLevel() >= 67)
        {
            Plr->LearnSpell(49936, false);
            Plr->LearnSpell(49903, false);
            Plr->LearnSpell(56815, false);
            Plr->LearnSpell(55265, false);
            Plr->LearnSpell(51423, false);
        }
        if (Plr->getLevel() >= 68)
        {
            Plr->LearnSpell(48707, false);
            Plr->LearnSpell(49893, false);
        }
        if (Plr->getLevel() >= 69)
        {
            Plr->LearnSpell(55260, false);
            Plr->LearnSpell(49928, false);
        }
        if (Plr->getLevel() >= 70)
        {
            Plr->LearnSpell(53344, false);
            Plr->LearnSpell(51326, false);
            Plr->LearnSpell(49919, false);
            Plr->LearnSpell(51409, false);
            Plr->LearnSpell(48265, false);
            Plr->LearnSpell(51418, false);
            Plr->LearnSpell(45463, false);
        }
        if (Plr->getLevel() >= 72)
        {
            Plr->LearnSpell(70164, false);
            Plr->LearnSpell(62158, false);
            Plr->LearnSpell(61999, false);
            Plr->LearnSpell(49940, false);
        }
        if (Plr->getLevel() >= 73)
        {
            Plr->LearnSpell(51424, false);
            Plr->LearnSpell(49937, false);
            Plr->LearnSpell(55270, false);
            Plr->LearnSpell(49904, false);
        }
        if (Plr->getLevel() >= 74)
        {
            Plr->LearnSpell(55261, false);
            Plr->LearnSpell(49929, false);
        }
        if (Plr->getLevel() >= 75)
        {
            Plr->LearnSpell(51419, false);
            Plr->LearnSpell(51410, false);
            Plr->LearnSpell(49923, false);
            Plr->LearnSpell(47568, false);
            Plr->LearnSpell(51327, false);
            Plr->LearnSpell(57623, false);
            Plr->LearnSpell(49920, false);
        }
        if (Plr->getLevel() >= 76)
        {
            Plr->LearnSpell(49894, false);
        }
        if (Plr->getLevel() >= 78)
        {
            Plr->LearnSpell(49909, false);
            Plr->LearnSpell(49941, false);
        }
        if (Plr->getLevel() >= 79)
        {
            Plr->LearnSpell(51425, false);
            Plr->LearnSpell(55271, false);
        }
        if (Plr->getLevel() >= 80)
        {
            Plr->LearnSpell(42650, false);
            Plr->LearnSpell(55262, false);
            Plr->LearnSpell(49938, false);
            Plr->LearnSpell(51328, false);
            Plr->LearnSpell(49921, false);
            Plr->LearnSpell(49895, false);
            Plr->LearnSpell(51411, false);
            Plr->LearnSpell(49930, false);
            Plr->LearnSpell(49924, false);
            Plr->LearnSpell(55268, false);
        }
    }
    if (Plr->getClass() == 7)
    {
        if (Plr->getLevel() >= 1)
        {
            Plr->LearnSpell(8017, false);
        }
        if (Plr->getLevel() >= 4)
        {
            Plr->LearnSpell(8042, false);
        }
        if (Plr->getLevel() >= 6)
        {
            Plr->LearnSpell(332, false);
            Plr->LearnSpell(2484, false);
        }
        if (Plr->getLevel() >= 8)
        {
            Plr->LearnSpell(5730, false);
            Plr->LearnSpell(324, false);
            Plr->LearnSpell(8018, false);
            Plr->LearnSpell(8044, false);
            Plr->LearnSpell(529, false);
        }
        if (Plr->getLevel() >= 10)
        {
            Plr->LearnSpell(8075, false);
            Plr->LearnSpell(8024, false);
            Plr->LearnSpell(8050, false);
        }
        if (Plr->getLevel() >= 12)
        {
            Plr->LearnSpell(547, false);
            Plr->LearnSpell(370, false);
            Plr->LearnSpell(1535, false);
            Plr->LearnSpell(2008, false);
        }
        if (Plr->getLevel() >= 14)
        {
            Plr->LearnSpell(8045, false);
            Plr->LearnSpell(548, false);
            Plr->LearnSpell(8154, false);
        }
        if (Plr->getLevel() >= 16)
        {
            Plr->LearnSpell(8019, false);
            Plr->LearnSpell(526, false);
            Plr->LearnSpell(2645, false);
            Plr->LearnSpell(57994, false);
            Plr->LearnSpell(325, false);
        }
        if (Plr->getLevel() >= 18)
        {
            Plr->LearnSpell(6390, false);
            Plr->LearnSpell(8052, false);
            Plr->LearnSpell(913, false);
            Plr->LearnSpell(8143, false);
            Plr->LearnSpell(8027, false);
        }
        if (Plr->getLevel() >= 20)
        {
            Plr->LearnSpell(8056, false);
            Plr->LearnSpell(8033, false);
            Plr->LearnSpell(52127, false);
            Plr->LearnSpell(8004, false);
            Plr->LearnSpell(6363, false);
            Plr->LearnSpell(915, false);
        }
        if (Plr->getLevel() >= 22)
        {
            Plr->LearnSpell(131, false);
            Plr->LearnSpell(8498, false);
        }
        if (Plr->getLevel() >= 24)
        {
            Plr->LearnSpell(8155, false);
            Plr->LearnSpell(939, false);
            Plr->LearnSpell(10399, false);
            Plr->LearnSpell(8181, false);
            Plr->LearnSpell(8046, false);
            Plr->LearnSpell(8160, false);
            Plr->LearnSpell(905, false);
            Plr->LearnSpell(20609, false);
        }
        if (Plr->getLevel() >= 26)
        {
            Plr->LearnSpell(8190, false);
            Plr->LearnSpell(6196, false);
            Plr->LearnSpell(943, false);
            Plr->LearnSpell(5675, false);
            Plr->LearnSpell(8030, false);
        }
        if (Plr->getLevel() >= 28)
        {
            Plr->LearnSpell(8038, false);
            Plr->LearnSpell(52129, false);
            Plr->LearnSpell(8053, false);
            Plr->LearnSpell(8227, false);
            Plr->LearnSpell(6391, false);
            Plr->LearnSpell(8008, false);
            Plr->LearnSpell(546, false);
            Plr->LearnSpell(8184, false);
        }
        if (Plr->getLevel() >= 30)
        {
            Plr->LearnSpell(6364, false);
            Plr->LearnSpell(6375, false);
            Plr->LearnSpell(556, false);
            Plr->LearnSpell(8232, false);
            Plr->LearnSpell(20608, false);
            Plr->LearnSpell(8177, false);
            Plr->LearnSpell(10595, false);
            Plr->LearnSpell(36936, false);
            Plr->LearnSpell(51730, false);
            Plr->LearnSpell(66842, false);
        }
        if (Plr->getLevel() >= 32)
        {
            Plr->LearnSpell(8512, false);
            Plr->LearnSpell(6041, false);
            Plr->LearnSpell(8499, false);
            Plr->LearnSpell(421, false);
            Plr->LearnSpell(945, false);
            Plr->LearnSpell(8012, false);
            Plr->LearnSpell(959, false);
        }
        if (Plr->getLevel() >= 34)
        {
            Plr->LearnSpell(6495, false);
            Plr->LearnSpell(10406, false);
            Plr->LearnSpell(52131, false);
            Plr->LearnSpell(8058, false);
        }
        if (Plr->getLevel() >= 36)
        {
            Plr->LearnSpell(16339, false);
            Plr->LearnSpell(10585, false);
            Plr->LearnSpell(10412, false);
            Plr->LearnSpell(8010, false);
            Plr->LearnSpell(20610, false);
            Plr->LearnSpell(10495, false);
        }
        if (Plr->getLevel() >= 38)
        {
            Plr->LearnSpell(8161, false);
            Plr->LearnSpell(10456, false);
            Plr->LearnSpell(8249, false);
            Plr->LearnSpell(8170, false);
            Plr->LearnSpell(10391, false);
            Plr->LearnSpell(10478, false);
            Plr->LearnSpell(6392, false);
        }
        if (Plr->getLevel() >= 40)
        {
            Plr->LearnSpell(10447, false);
            Plr->LearnSpell(8005, false);
            Plr->LearnSpell(8134, false);
            Plr->LearnSpell(930, false);
            Plr->LearnSpell(51988, false);
            Plr->LearnSpell(66843, false);
            Plr->LearnSpell(1064, false);
            Plr->LearnSpell(8737, false);
            Plr->LearnSpell(6377, false);
            Plr->LearnSpell(6365, false);
            Plr->LearnSpell(8235, false);
        }
        if (Plr->getLevel() >= 41)
        {
            Plr->LearnSpell(52134, false);
        }
        if (Plr->getLevel() >= 42)
        {
            Plr->LearnSpell(10537, false);
            Plr->LearnSpell(11314, false);
        }
        if (Plr->getLevel() >= 44)
        {
            Plr->LearnSpell(10466, false);
            Plr->LearnSpell(10600, false);
            Plr->LearnSpell(10407, false);
            Plr->LearnSpell(10392, false);
        }
        if (Plr->getLevel() >= 46)
        {
            Plr->LearnSpell(10622, false);
            Plr->LearnSpell(16341, false);
            Plr->LearnSpell(10586, false);
            Plr->LearnSpell(10496, false);
            Plr->LearnSpell(10472, false);
        }
        if (Plr->getLevel() >= 48)
        {
            Plr->LearnSpell(10431, false);
            Plr->LearnSpell(10413, false);
            Plr->LearnSpell(2860, false);
            Plr->LearnSpell(10395, false);
            Plr->LearnSpell(10526, false);
            Plr->LearnSpell(16355, false);
            Plr->LearnSpell(52136, false);
            Plr->LearnSpell(10427, false);
            Plr->LearnSpell(20776, false);
        }
        if (Plr->getLevel() >= 50)
        {
            Plr->LearnSpell(15207, false);
            Plr->LearnSpell(10486, false);
            Plr->LearnSpell(51991, false);
            Plr->LearnSpell(66844, false);
            Plr->LearnSpell(10462, false);
            Plr->LearnSpell(10437, false);
        }
        if (Plr->getLevel() >= 52)
        {
            Plr->LearnSpell(10467, false);
            Plr->LearnSpell(10448, false);
            Plr->LearnSpell(11315, false);
            Plr->LearnSpell(10442, false);
        }
        if (Plr->getLevel() >= 54)
        {
            Plr->LearnSpell(10623, false);
            Plr->LearnSpell(10479, false);
            Plr->LearnSpell(10408, false);
        }
        if (Plr->getLevel() >= 55)
        {
            Plr->LearnSpell(52138, false);
        }
        if (Plr->getLevel() >= 56)
        {
            Plr->LearnSpell(10396, false);
            Plr->LearnSpell(16342, false);
            Plr->LearnSpell(10432, false);
            Plr->LearnSpell(15208, false);
            Plr->LearnSpell(10605, false);
            Plr->LearnSpell(10587, false);
            Plr->LearnSpell(10497, false);
        }
        if (Plr->getLevel() >= 58)
        {
            Plr->LearnSpell(10428, false);
            Plr->LearnSpell(10473, false);
            Plr->LearnSpell(10538, false);
            Plr->LearnSpell(16387, false);
            Plr->LearnSpell(16356, false);
        }
        if (Plr->getLevel() >= 60)
        {
            Plr->LearnSpell(10438, false);
            Plr->LearnSpell(16362, false);
            Plr->LearnSpell(10468, false);
            Plr->LearnSpell(10414, false);
            Plr->LearnSpell(10601, false);
            Plr->LearnSpell(20777, false);
            Plr->LearnSpell(32593, false);
            Plr->LearnSpell(25357, false);
            Plr->LearnSpell(51992, false);
            Plr->LearnSpell(25361, false);
            Plr->LearnSpell(57720, false);
            Plr->LearnSpell(10463, false);
            Plr->LearnSpell(29228, false);
        }
        if (Plr->getLevel() >= 61)
        {
            Plr->LearnSpell(25546, false);
            Plr->LearnSpell(25422, false);
        }
        if (Plr->getLevel() >= 62)
        {
            Plr->LearnSpell(24398, false);
            Plr->LearnSpell(25448, false);
        }
        if (Plr->getLevel() >= 63)
        {
            Plr->LearnSpell(25508, false);
            Plr->LearnSpell(25469, false);
            Plr->LearnSpell(25439, false);
            Plr->LearnSpell(25391, false);
        }
        if (Plr->getLevel() >= 64)
        {
            Plr->LearnSpell(3738, false);
            Plr->LearnSpell(25489, false);
        }
        if (Plr->getLevel() >= 65)
        {
            Plr->LearnSpell(25552, false);
            Plr->LearnSpell(25570, false);
            Plr->LearnSpell(25528, false);
        }
        if (Plr->getLevel() >= 66)
        {
            Plr->LearnSpell(25500, false);
            Plr->LearnSpell(2062, false);
            Plr->LearnSpell(25420, false);
        }
        if (Plr->getLevel() >= 67)
        {
            Plr->LearnSpell(25449, false);
            Plr->LearnSpell(25525, false);
            Plr->LearnSpell(25560, false);
            Plr->LearnSpell(25557, false);
        }
        if (Plr->getLevel() >= 68)
        {
            Plr->LearnSpell(25464, false);
            Plr->LearnSpell(25423, false);
            Plr->LearnSpell(2894, false);
            Plr->LearnSpell(25505, false);
            Plr->LearnSpell(25563, false);
        }
        if (Plr->getLevel() >= 69)
        {
            Plr->LearnSpell(33736, false);
            Plr->LearnSpell(25454, false);
            Plr->LearnSpell(25567, false);
            Plr->LearnSpell(25574, false);
            Plr->LearnSpell(25590, false);
            Plr->LearnSpell(25533, false);
        }
        if (Plr->getLevel() >= 70)
        {
            Plr->LearnSpell(57721, false);
            Plr->LearnSpell(61299, false);
            Plr->LearnSpell(25396, false);
            Plr->LearnSpell(32182, false);
            Plr->LearnSpell(32594, false);
            Plr->LearnSpell(25547, false);
            Plr->LearnSpell(25472, false);
            Plr->LearnSpell(25509, false);
            Plr->LearnSpell(59156, false);
            Plr->LearnSpell(51993, false);
            Plr->LearnSpell(25457, false);
            Plr->LearnSpell(2825, false);
            Plr->LearnSpell(25442, false);
        }
        if (Plr->getLevel() >= 71)
        {
            Plr->LearnSpell(58580, false);
            Plr->LearnSpell(58699, false);
            Plr->LearnSpell(58801, false);
            Plr->LearnSpell(58794, false);
            Plr->LearnSpell(58785, false);
            Plr->LearnSpell(58649, false);
            Plr->LearnSpell(58755, false);
            Plr->LearnSpell(58771, false);
        }
        if (Plr->getLevel() >= 72)
        {
            Plr->LearnSpell(49275, false);
        }
        if (Plr->getLevel() >= 73)
        {
            Plr->LearnSpell(49237, false);
            Plr->LearnSpell(58751, false);
            Plr->LearnSpell(58731, false);
            Plr->LearnSpell(49235, false);
        }
        if (Plr->getLevel() >= 74)
        {
            Plr->LearnSpell(55458, false);
            Plr->LearnSpell(49270, false);
            Plr->LearnSpell(49230, false);
        }
        if (Plr->getLevel() >= 75)
        {
            Plr->LearnSpell(58741, false);
            Plr->LearnSpell(57622, false);
            Plr->LearnSpell(49232, false);
            Plr->LearnSpell(59158, false);
            Plr->LearnSpell(49283, false);
            Plr->LearnSpell(58703, false);
            Plr->LearnSpell(61300, false);
            Plr->LearnSpell(58652, false);
            Plr->LearnSpell(58746, false);
            Plr->LearnSpell(49272, false);
            Plr->LearnSpell(58581, false);
            Plr->LearnSpell(51505, false);
            Plr->LearnSpell(61649, false);
            Plr->LearnSpell(58737, false);
            Plr->LearnSpell(49280, false);
        }
        if (Plr->getLevel() >= 76)
        {
            Plr->LearnSpell(58756, false);
            Plr->LearnSpell(58773, false);
            Plr->LearnSpell(57960, false);
            Plr->LearnSpell(58795, false);
            Plr->LearnSpell(58803, false);
            Plr->LearnSpell(58789, false);
        }
        if (Plr->getLevel() >= 77)
        {
            Plr->LearnSpell(49276, false);
        }
        if (Plr->getLevel() >= 78)
        {
            Plr->LearnSpell(49236, false);
            Plr->LearnSpell(58582, false);
            Plr->LearnSpell(58753, false);
            Plr->LearnSpell(58734, false);
        }
        if (Plr->getLevel() >= 79)
        {
            Plr->LearnSpell(49231, false);
            Plr->LearnSpell(49238, false);
        }
        if (Plr->getLevel() >= 80)
        {
            Plr->LearnSpell(58790, false);
            Plr->LearnSpell(49271, false);
            Plr->LearnSpell(49281, false);
            Plr->LearnSpell(49273, false);
            Plr->LearnSpell(58804, false);
            Plr->LearnSpell(49284, false);
            Plr->LearnSpell(58704, false);
            Plr->LearnSpell(61301, false);
            Plr->LearnSpell(57722, false);
            Plr->LearnSpell(49233, false);
            Plr->LearnSpell(58739, false);
            Plr->LearnSpell(55459, false);
            Plr->LearnSpell(58774, false);
            Plr->LearnSpell(51514, false);
            Plr->LearnSpell(61657, false);
            Plr->LearnSpell(49277, false);
            Plr->LearnSpell(59159, false);
            Plr->LearnSpell(58745, false);
            Plr->LearnSpell(58643, false);
            Plr->LearnSpell(58757, false);
            Plr->LearnSpell(58796, false);
            Plr->LearnSpell(58656, false);
            Plr->LearnSpell(60043, false);
            Plr->LearnSpell(51994, false);
            Plr->LearnSpell(58749, false);
        }
    }
    if (Plr->getClass() == 8)
    {
        if (Plr->getLevel() >= 1)
        {
            Plr->LearnSpell(1459, false);
        }
        if (Plr->getLevel() >= 4)
        {
            Plr->LearnSpell(116, false);
            Plr->LearnSpell(5504, false);
        }
        if (Plr->getLevel() >= 6)
        {
            Plr->LearnSpell(143, false);
            Plr->LearnSpell(587, false);
            Plr->LearnSpell(2136, false);
        }
        if (Plr->getLevel() >= 8)
        {
            Plr->LearnSpell(5143, false);
            Plr->LearnSpell(205, false);
            Plr->LearnSpell(118, false);
        }
        if (Plr->getLevel() >= 10)
        {
            Plr->LearnSpell(7300, false);
            Plr->LearnSpell(5505, false);
            Plr->LearnSpell(122, false);
        }
        if (Plr->getLevel() >= 12)
        {
            Plr->LearnSpell(145, false);
            Plr->LearnSpell(604, false);
            Plr->LearnSpell(597, false);
            Plr->LearnSpell(130, false);
        }
        if (Plr->getLevel() >= 14)
        {
            Plr->LearnSpell(2137, false);
            Plr->LearnSpell(1460, false);
            Plr->LearnSpell(1449, false);
            Plr->LearnSpell(837, false);
        }
        if (Plr->getLevel() >= 16)
        {
            Plr->LearnSpell(2120, false);
            Plr->LearnSpell(5144, false);
        }
        if (Plr->getLevel() >= 18)
        {
            Plr->LearnSpell(475, false);
            Plr->LearnSpell(3140, false);
            Plr->LearnSpell(1008, false);
        }
        if (Plr->getLevel() >= 20)
        {
            Plr->LearnSpell(10, false);
            Plr->LearnSpell(12824, false);
            Plr->LearnSpell(543, false);
            Plr->LearnSpell(7301, false);
            Plr->LearnSpell(1953, false);
            Plr->LearnSpell(12051, false);
            Plr->LearnSpell(1463, false);
            Plr->LearnSpell(5506, false);
            Plr->LearnSpell(7322, false);
        }
        if (Plr->getLevel() >= 22)
        {
            Plr->LearnSpell(990, false);
            Plr->LearnSpell(6143, false);
            Plr->LearnSpell(2138, false);
            Plr->LearnSpell(8437, false);
            Plr->LearnSpell(2948, false);
        }
        if (Plr->getLevel() >= 24)
        {
            Plr->LearnSpell(12505, false);
            Plr->LearnSpell(5145, false);
            Plr->LearnSpell(8400, false);
            Plr->LearnSpell(8450, false);
            Plr->LearnSpell(2139, false);
            Plr->LearnSpell(2121, false);
        }
        if (Plr->getLevel() >= 26)
        {
            Plr->LearnSpell(865, false);
            Plr->LearnSpell(8406, false);
            Plr->LearnSpell(120, false);
        }
        if (Plr->getLevel() >= 28)
        {
            Plr->LearnSpell(8494, false);
            Plr->LearnSpell(1461, false);
            Plr->LearnSpell(759, false);
            Plr->LearnSpell(8444, false);
            Plr->LearnSpell(6141, false);
        }
        if (Plr->getLevel() >= 30)
        {
            Plr->LearnSpell(8401, false);
            Plr->LearnSpell(7302, false);
            Plr->LearnSpell(8455, false);
            Plr->LearnSpell(8412, false);
            Plr->LearnSpell(8438, false);
            Plr->LearnSpell(6127, false);
            Plr->LearnSpell(8457, false);
            Plr->LearnSpell(12522, false);
            Plr->LearnSpell(45438, false);
        }
        if (Plr->getLevel() >= 32)
        {
            Plr->LearnSpell(8461, false);
            Plr->LearnSpell(8422, false);
            Plr->LearnSpell(8407, false);
            Plr->LearnSpell(8416, false);
            Plr->LearnSpell(6129, false);
        }
        if (Plr->getLevel() >= 34)
        {
            Plr->LearnSpell(8492, false);
            Plr->LearnSpell(6117, false);
            Plr->LearnSpell(8445, false);
        }
        if (Plr->getLevel() >= 36)
        {
            Plr->LearnSpell(8427, false);
            Plr->LearnSpell(8495, false);
            Plr->LearnSpell(13018, false);
            Plr->LearnSpell(8402, false);
            Plr->LearnSpell(12523, false);
            Plr->LearnSpell(8451, false);
        }
        if (Plr->getLevel() >= 38)
        {
            Plr->LearnSpell(8439, false);
            Plr->LearnSpell(8413, false);
            Plr->LearnSpell(3552, false);
            Plr->LearnSpell(8408, false);
        }
        if (Plr->getLevel() >= 40)
        {
            Plr->LearnSpell(12825, false);
            Plr->LearnSpell(6131, false);
            Plr->LearnSpell(8446, false);
            Plr->LearnSpell(8458, false);
            Plr->LearnSpell(8423, false);
            Plr->LearnSpell(7320, false);
            Plr->LearnSpell(8417, false);
            Plr->LearnSpell(10138, false);
        }
        if (Plr->getLevel() >= 42)
        {
            Plr->LearnSpell(12524, false);
            Plr->LearnSpell(10159, false);
            Plr->LearnSpell(10148, false);
            Plr->LearnSpell(10156, false);
            Plr->LearnSpell(10144, false);
            Plr->LearnSpell(10169, false);
            Plr->LearnSpell(8462, false);
        }
        if (Plr->getLevel() >= 44)
        {
            Plr->LearnSpell(10191, false);
            Plr->LearnSpell(10179, false);
            Plr->LearnSpell(10185, false);
            Plr->LearnSpell(13019, false);
        }
        if (Plr->getLevel() >= 46)
        {
            Plr->LearnSpell(10197, false);
            Plr->LearnSpell(10201, false);
            Plr->LearnSpell(22782, false);
            Plr->LearnSpell(13031, false);
            Plr->LearnSpell(10205, false);
        }
        if (Plr->getLevel() >= 48)
        {
            Plr->LearnSpell(10173, false);
            Plr->LearnSpell(10215, false);
            Plr->LearnSpell(10053, false);
            Plr->LearnSpell(10149, false);
            Plr->LearnSpell(10211, false);
            Plr->LearnSpell(12525, false);
        }
        if (Plr->getLevel() >= 50)
        {
            Plr->LearnSpell(10139, false);
            Plr->LearnSpell(10180, false);
            Plr->LearnSpell(10160, false);
            Plr->LearnSpell(10223, false);
            Plr->LearnSpell(10219, false);
        }
        if (Plr->getLevel() >= 52)
        {
            Plr->LearnSpell(10206, false);
            Plr->LearnSpell(13032, false);
            Plr->LearnSpell(13020, false);
            Plr->LearnSpell(10145, false);
            Plr->LearnSpell(10186, false);
            Plr->LearnSpell(10177, false);
            Plr->LearnSpell(10192, false);
        }
        if (Plr->getLevel() >= 54)
        {
            Plr->LearnSpell(10230, false);
            Plr->LearnSpell(10199, false);
            Plr->LearnSpell(10150, false);
            Plr->LearnSpell(10202, false);
            Plr->LearnSpell(10170, false);
            Plr->LearnSpell(12526, false);
        }
        if (Plr->getLevel() >= 56)
        {
            Plr->LearnSpell(33041, false);
            Plr->LearnSpell(10212, false);
            Plr->LearnSpell(10216, false);
            Plr->LearnSpell(10157, false);
            Plr->LearnSpell(10181, false);
            Plr->LearnSpell(23028, false);
        }
        if (Plr->getLevel() >= 58)
        {
            Plr->LearnSpell(10161, false);
            Plr->LearnSpell(10207, false);
            Plr->LearnSpell(22783, false);
            Plr->LearnSpell(10054, false);
            Plr->LearnSpell(13033, false);
        }
        if (Plr->getLevel() >= 60)
        {
            Plr->LearnSpell(13021, false);
            Plr->LearnSpell(25304, false);
            Plr->LearnSpell(10140, false);
            Plr->LearnSpell(10193, false);
            Plr->LearnSpell(28609, false);
            Plr->LearnSpell(18809, false);
            Plr->LearnSpell(10151, false);
            Plr->LearnSpell(10220, false);
            Plr->LearnSpell(28612, false);
            Plr->LearnSpell(10187, false);
            Plr->LearnSpell(25345, false);
            Plr->LearnSpell(10174, false);
            Plr->LearnSpell(10225, false);
            Plr->LearnSpell(12826, false);
        }
        if (Plr->getLevel() >= 61)
        {
            Plr->LearnSpell(27078, false);
        }
        if (Plr->getLevel() >= 62)
        {
            Plr->LearnSpell(25306, false);
            Plr->LearnSpell(27080, false);
            Plr->LearnSpell(30482, false);
        }
        if (Plr->getLevel() >= 63)
        {
            Plr->LearnSpell(27130, false);
            Plr->LearnSpell(27071, false);
            Plr->LearnSpell(27075, false);
        }
        if (Plr->getLevel() >= 64)
        {
            Plr->LearnSpell(30451, false);
            Plr->LearnSpell(27134, false);
            Plr->LearnSpell(33042, false);
            Plr->LearnSpell(27086, false);
        }
        if (Plr->getLevel() >= 65)
        {
            Plr->LearnSpell(27087, false);
            Plr->LearnSpell(37420, false);
            Plr->LearnSpell(27133, false);
            Plr->LearnSpell(27073, false);
        }
        if (Plr->getLevel() >= 66)
        {
            Plr->LearnSpell(30455, false);
            Plr->LearnSpell(27132, false);
            Plr->LearnSpell(27070, false);
        }
        if (Plr->getLevel() >= 67)
        {
            Plr->LearnSpell(33944, false);
            Plr->LearnSpell(27088, false);
        }
        if (Plr->getLevel() >= 68)
        {
            Plr->LearnSpell(27101, false);
            Plr->LearnSpell(66, false);
            Plr->LearnSpell(27131, false);
            Plr->LearnSpell(27085, false);
        }
        if (Plr->getLevel() >= 69)
        {
            Plr->LearnSpell(27124, false);
            Plr->LearnSpell(33946, false);
            Plr->LearnSpell(27128, false);
            Plr->LearnSpell(27072, false);
            Plr->LearnSpell(38699, false);
            Plr->LearnSpell(27125, false);
        }
        if (Plr->getLevel() >= 70)
        {
            Plr->LearnSpell(27074, false);
            Plr->LearnSpell(33405, false);
            Plr->LearnSpell(27082, false);
            Plr->LearnSpell(38697, false);
            Plr->LearnSpell(27079, false);
            Plr->LearnSpell(33938, false);
            Plr->LearnSpell(44780, false);
            Plr->LearnSpell(32796, false);
            Plr->LearnSpell(27126, false);
            Plr->LearnSpell(33717, false);
            Plr->LearnSpell(33933, false);
            Plr->LearnSpell(38692, false);
            Plr->LearnSpell(55359, false);
            Plr->LearnSpell(43987, false);
            Plr->LearnSpell(27127, false);
            Plr->LearnSpell(30449, false);
            Plr->LearnSpell(33043, false);
            Plr->LearnSpell(27090, false);
            Plr->LearnSpell(38704, false);
        }
        if (Plr->getLevel() >= 71)
        {
            Plr->LearnSpell(43023, false);
            Plr->LearnSpell(43045, false);
            Plr->LearnSpell(42894, false);
        }
        if (Plr->getLevel() >= 72)
        {
            Plr->LearnSpell(42913, false);
            Plr->LearnSpell(42930, false);
            Plr->LearnSpell(42925, false);
        }
        if (Plr->getLevel() >= 73)
        {
            Plr->LearnSpell(42890, false);
            Plr->LearnSpell(42858, false);
            Plr->LearnSpell(43019, false);
        }
        if (Plr->getLevel() >= 74)
        {
            Plr->LearnSpell(42939, false);
            Plr->LearnSpell(42832, false);
            Plr->LearnSpell(42872, false);
        }
        if (Plr->getLevel() >= 75)
        {
            Plr->LearnSpell(42944, false);
            Plr->LearnSpell(43038, false);
            Plr->LearnSpell(42917, false);
            Plr->LearnSpell(44614, false);
            Plr->LearnSpell(42949, false);
            Plr->LearnSpell(42843, false);
            Plr->LearnSpell(42955, false);
            Plr->LearnSpell(42841, false);
        }
        if (Plr->getLevel() >= 76)
        {
            Plr->LearnSpell(43015, false);
            Plr->LearnSpell(42920, false);
            Plr->LearnSpell(42896, false);
        }
        if (Plr->getLevel() >= 77)
        {
            Plr->LearnSpell(42985, false);
            Plr->LearnSpell(42891, false);
            Plr->LearnSpell(43017, false);
        }
        if (Plr->getLevel() >= 78)
        {
            Plr->LearnSpell(42833, false);
            Plr->LearnSpell(42914, false);
            Plr->LearnSpell(43010, false);
            Plr->LearnSpell(42859, false);
        }
        if (Plr->getLevel() >= 79)
        {
            Plr->LearnSpell(42926, false);
            Plr->LearnSpell(43046, false);
            Plr->LearnSpell(43024, false);
            Plr->LearnSpell(42846, false);
            Plr->LearnSpell(43012, false);
            Plr->LearnSpell(42842, false);
            Plr->LearnSpell(43008, false);
            Plr->LearnSpell(42931, false);
            Plr->LearnSpell(43020, false);
        }
        if (Plr->getLevel() >= 80)
        {
            Plr->LearnSpell(42995, false);
            Plr->LearnSpell(47610, false);
            Plr->LearnSpell(42950, false);
            Plr->LearnSpell(55360, false);
            Plr->LearnSpell(42897, false);
            Plr->LearnSpell(42940, false);
            Plr->LearnSpell(58659, false);
            Plr->LearnSpell(42921, false);
            Plr->LearnSpell(44781, false);
            Plr->LearnSpell(55342, false);
            Plr->LearnSpell(43002, false);
            Plr->LearnSpell(42945, false);
            Plr->LearnSpell(42873, false);
            Plr->LearnSpell(43039, false);
            Plr->LearnSpell(42956, false);
        }
    }
    if (Plr->getClass() == 9)
    {
        if (Plr->getLevel() >= 1)
        {
            Plr->LearnSpell(688, false);
        }
        if (Plr->getLevel() >= 3)
        {
            Plr->LearnSpell(348, false);
        }
        if (Plr->getLevel() >= 4)
        {
            Plr->LearnSpell(702, false);
            Plr->LearnSpell(172, false);
        }
        if (Plr->getLevel() >= 6)
        {
            Plr->LearnSpell(695, false);
            Plr->LearnSpell(1454, false);
        }
        if (Plr->getLevel() >= 8)
        {
            Plr->LearnSpell(5782, false);
            Plr->LearnSpell(980, false);
        }
        if (Plr->getLevel() >= 10)
        {
            Plr->LearnSpell(1120, false);
            Plr->LearnSpell(707, false);
            Plr->LearnSpell(6201, false);
            Plr->LearnSpell(696, false);
        }
        if (Plr->getLevel() >= 12)
        {
            Plr->LearnSpell(1108, false);
            Plr->LearnSpell(705, false);
            Plr->LearnSpell(755, false);
        }
        if (Plr->getLevel() >= 14)
        {
            Plr->LearnSpell(689, false);
            Plr->LearnSpell(6222, false);
        }
        if (Plr->getLevel() >= 16)
        {
            Plr->LearnSpell(1455, false);
            Plr->LearnSpell(5697, false);
        }
        if (Plr->getLevel() >= 18)
        {
            Plr->LearnSpell(693, false);
            Plr->LearnSpell(1014, false);
            Plr->LearnSpell(5676, false);
        }
        if (Plr->getLevel() >= 20)
        {
            Plr->LearnSpell(706, false);
            Plr->LearnSpell(5740, false);
            Plr->LearnSpell(3698, false);
            Plr->LearnSpell(1094, false);
            Plr->LearnSpell(1710, false);
            Plr->LearnSpell(698, false);
            Plr->LearnSpell(1088, false);
        }
        if (Plr->getLevel() >= 22)
        {
            Plr->LearnSpell(6205, false);
            Plr->LearnSpell(699, false);
            Plr->LearnSpell(126, false);
            Plr->LearnSpell(6202, false);
        }
        if (Plr->getLevel() >= 24)
        {
            Plr->LearnSpell(5138, false);
            Plr->LearnSpell(5500, false);
            Plr->LearnSpell(6223, false);
            Plr->LearnSpell(18867, false);
            Plr->LearnSpell(8288, false);
        }
        if (Plr->getLevel() >= 26)
        {
            Plr->LearnSpell(1456, false);
            Plr->LearnSpell(17919, false);
            Plr->LearnSpell(132, false);
            Plr->LearnSpell(1714, false);
        }
        if (Plr->getLevel() >= 28)
        {
            Plr->LearnSpell(1106, false);
            Plr->LearnSpell(710, false);
            Plr->LearnSpell(6366, false);
            Plr->LearnSpell(3699, false);
            Plr->LearnSpell(6217, false);
        }
        if (Plr->getLevel() >= 30)
        {
            Plr->LearnSpell(20752, false);
            Plr->LearnSpell(2941, false);
            Plr->LearnSpell(1098, false);
            Plr->LearnSpell(709, false);
            Plr->LearnSpell(1086, false);
            Plr->LearnSpell(1949, false);
        }
        if (Plr->getLevel() >= 32)
        {
            Plr->LearnSpell(7646, false);
            Plr->LearnSpell(1490, false);
            Plr->LearnSpell(6229, false);
            Plr->LearnSpell(18868, false);
            Plr->LearnSpell(6213, false);
        }
        if (Plr->getLevel() >= 34)
        {
            Plr->LearnSpell(7648, false);
            Plr->LearnSpell(5699, false);
            Plr->LearnSpell(17920, false);
            Plr->LearnSpell(6219, false);
        }
        if (Plr->getLevel() >= 36)
        {
            Plr->LearnSpell(2362, false);
            Plr->LearnSpell(7641, false);
            Plr->LearnSpell(3700, false);
            Plr->LearnSpell(11687, false);
            Plr->LearnSpell(17951, false);
        }
        if (Plr->getLevel() >= 38)
        {
            Plr->LearnSpell(11711, false);
            Plr->LearnSpell(7651, false);
            Plr->LearnSpell(8289, false);
        }
        if (Plr->getLevel() >= 40)
        {
            Plr->LearnSpell(23161, false);
            Plr->LearnSpell(18869, false);
            Plr->LearnSpell(20755, false);
            Plr->LearnSpell(11733, false);
            Plr->LearnSpell(5484, false);
            Plr->LearnSpell(11665, false);
        }
        if (Plr->getLevel() >= 42)
        {
            Plr->LearnSpell(6789, false);
            Plr->LearnSpell(11683, false);
            Plr->LearnSpell(17921, false);
            Plr->LearnSpell(11739, false);
            Plr->LearnSpell(11707, false);
        }
        if (Plr->getLevel() >= 44)
        {
            Plr->LearnSpell(11659, false);
            Plr->LearnSpell(11693, false);
            Plr->LearnSpell(11671, false);
            Plr->LearnSpell(11725, false);
        }
        if (Plr->getLevel() >= 46)
        {
            Plr->LearnSpell(11721, false);
            Plr->LearnSpell(17952, false);
            Plr->LearnSpell(11688, false);
            Plr->LearnSpell(11699, false);
            Plr->LearnSpell(11677, false);
            Plr->LearnSpell(11729, false);
        }
        if (Plr->getLevel() >= 48)
        {
            Plr->LearnSpell(6353, false);
            Plr->LearnSpell(11712, false);
            Plr->LearnSpell(18870, false);
            Plr->LearnSpell(17727, false);
            Plr->LearnSpell(18647, false);
        }
        if (Plr->getLevel() >= 50)
        {
            Plr->LearnSpell(11719, false);
            Plr->LearnSpell(18937, false);
            Plr->LearnSpell(17922, false);
            Plr->LearnSpell(11734, false);
            Plr->LearnSpell(11667, false);
            Plr->LearnSpell(17925, false);
            Plr->LearnSpell(20756, false);
        }
        if (Plr->getLevel() >= 52)
        {
            Plr->LearnSpell(11740, false);
            Plr->LearnSpell(11660, false);
            Plr->LearnSpell(11708, false);
            Plr->LearnSpell(11694, false);
            Plr->LearnSpell(11675, false);
        }
        if (Plr->getLevel() >= 54)
        {
            Plr->LearnSpell(11684, false);
            Plr->LearnSpell(11672, false);
            Plr->LearnSpell(17928, false);
            Plr->LearnSpell(11700, false);
        }
        if (Plr->getLevel() >= 56)
        {
            Plr->LearnSpell(11689, false);
            Plr->LearnSpell(18871, false);
            Plr->LearnSpell(6215, false);
            Plr->LearnSpell(17924, false);
            Plr->LearnSpell(17953, false);
        }
        if (Plr->getLevel() >= 58)
        {
            Plr->LearnSpell(11730, false);
            Plr->LearnSpell(17926, false);
            Plr->LearnSpell(17923, false);
            Plr->LearnSpell(11713, false);
            Plr->LearnSpell(11678, false);
            Plr->LearnSpell(11726, false);
        }
        if (Plr->getLevel() >= 60)
        {
            Plr->LearnSpell(603, false);
            Plr->LearnSpell(11668, false);
            Plr->LearnSpell(18938, false);
            Plr->LearnSpell(11722, false);
            Plr->LearnSpell(17728, false);
            Plr->LearnSpell(11661, false);
            Plr->LearnSpell(25309, false);
            Plr->LearnSpell(30404, false);
            Plr->LearnSpell(11735, false);
            Plr->LearnSpell(25311, false);
            Plr->LearnSpell(30413, false);
            Plr->LearnSpell(11695, false);
            Plr->LearnSpell(28610, false);
            Plr->LearnSpell(20757, false);
        }
        if (Plr->getLevel() >= 61)
        {
            Plr->LearnSpell(27224, false);
        }
        if (Plr->getLevel() >= 62)
        {
            Plr->LearnSpell(28176, false);
            Plr->LearnSpell(25307, false);
            Plr->LearnSpell(27219, false);
        }
        if (Plr->getLevel() >= 63)
        {
            Plr->LearnSpell(27263, false);
        }
        if (Plr->getLevel() >= 64)
        {
            Plr->LearnSpell(27211, false);
            Plr->LearnSpell(29722, false);
        }
        if (Plr->getLevel() >= 65)
        {
            Plr->LearnSpell(27210, false);
            Plr->LearnSpell(27216, false);
        }
        if (Plr->getLevel() >= 66)
        {
            Plr->LearnSpell(29858, false);
            Plr->LearnSpell(28172, false);
            Plr->LearnSpell(27250, false);
        }
        if (Plr->getLevel() >= 67)
        {
            Plr->LearnSpell(27259, false);
            Plr->LearnSpell(27218, false);
            Plr->LearnSpell(27217, false);
        }
        if (Plr->getLevel() >= 68)
        {
            Plr->LearnSpell(27222, false);
            Plr->LearnSpell(29893, false);
            Plr->LearnSpell(27223, false);
            Plr->LearnSpell(27213, false);
            Plr->LearnSpell(27230, false);
        }
        if (Plr->getLevel() >= 69)
        {
            Plr->LearnSpell(28189, false);
            Plr->LearnSpell(27212, false);
            Plr->LearnSpell(27209, false);
            Plr->LearnSpell(27228, false);
            Plr->LearnSpell(27220, false);
            Plr->LearnSpell(27215, false);
            Plr->LearnSpell(30909, false);
        }
        if (Plr->getLevel() >= 70)
        {
            Plr->LearnSpell(32231, false);
            Plr->LearnSpell(30910, false);
            Plr->LearnSpell(30414, false);
            Plr->LearnSpell(27265, false);
            Plr->LearnSpell(27260, false);
            Plr->LearnSpell(59170, false);
            Plr->LearnSpell(30545, false);
            Plr->LearnSpell(30459, false);
            Plr->LearnSpell(30546, false);
            Plr->LearnSpell(30405, false);
            Plr->LearnSpell(27243, false);
            Plr->LearnSpell(59161, false);
            Plr->LearnSpell(27238, false);
        }
        if (Plr->getLevel() >= 71)
        {
            Plr->LearnSpell(50511, false);
            Plr->LearnSpell(47812, false);
        }
        if (Plr->getLevel() >= 72)
        {
            Plr->LearnSpell(47819, false);
            Plr->LearnSpell(47886, false);
            Plr->LearnSpell(61191, false);
            Plr->LearnSpell(47890, false);
        }
        if (Plr->getLevel() >= 73)
        {
            Plr->LearnSpell(47859, false);
            Plr->LearnSpell(47871, false);
            Plr->LearnSpell(47863, false);
        }
        if (Plr->getLevel() >= 74)
        {
            Plr->LearnSpell(47892, false);
            Plr->LearnSpell(60219, false);
            Plr->LearnSpell(47808, false);
            Plr->LearnSpell(47814, false);
            Plr->LearnSpell(47837, false);
        }
        if (Plr->getLevel() >= 75)
        {
            Plr->LearnSpell(47841, false);
            Plr->LearnSpell(47897, false);
            Plr->LearnSpell(47826, false);
            Plr->LearnSpell(47835, false);
            Plr->LearnSpell(47810, false);
            Plr->LearnSpell(47824, false);
            Plr->LearnSpell(47846, false);
            Plr->LearnSpell(59171, false);
            Plr->LearnSpell(59163, false);
        }
        if (Plr->getLevel() >= 76)
        {
            Plr->LearnSpell(47856, false);
            Plr->LearnSpell(47884, false);
            Plr->LearnSpell(47793, false);
        }
        if (Plr->getLevel() >= 77)
        {
            Plr->LearnSpell(47855, false);
            Plr->LearnSpell(47813, false);
        }
        if (Plr->getLevel() >= 78)
        {
            Plr->LearnSpell(47865, false);
            Plr->LearnSpell(47823, false);
            Plr->LearnSpell(47857, false);
            Plr->LearnSpell(47860, false);
            Plr->LearnSpell(47888, false);
            Plr->LearnSpell(47891, false);
        }
        if (Plr->getLevel() >= 79)
        {
            Plr->LearnSpell(47864, false);
            Plr->LearnSpell(47820, false);
            Plr->LearnSpell(47893, false);
            Plr->LearnSpell(47809, false);
            Plr->LearnSpell(47878, false);
            Plr->LearnSpell(47815, false);
        }
        if (Plr->getLevel() >= 80)
        {
            Plr->LearnSpell(59164, false);
            Plr->LearnSpell(60220, false);
            Plr->LearnSpell(47827, false);
            Plr->LearnSpell(57946, false);
            Plr->LearnSpell(58887, false);
            Plr->LearnSpell(47836, false);
            Plr->LearnSpell(59092, false);
            Plr->LearnSpell(48018, false);
            Plr->LearnSpell(47867, false);
            Plr->LearnSpell(47843, false);
            Plr->LearnSpell(47825, false);
            Plr->LearnSpell(48020, false);
            Plr->LearnSpell(61290, false);
            Plr->LearnSpell(47811, false);
            Plr->LearnSpell(47847, false);
            Plr->LearnSpell(59172, false);
            Plr->LearnSpell(47889, false);
            Plr->LearnSpell(47838, false);
        }
    }
    if (Plr->getClass() == 11)
    {
        if (Plr->getLevel() >= 1)
        {
            Plr->LearnSpell(1126, false);
        }
        if (Plr->getLevel() >= 4)
        {
            Plr->LearnSpell(8921, false);
            Plr->LearnSpell(774, false);
        }
        if (Plr->getLevel() >= 6)
        {
            Plr->LearnSpell(467, false);
            Plr->LearnSpell(5177, false);
        }
        if (Plr->getLevel() >= 8)
        {
            Plr->LearnSpell(339, false);
            Plr->LearnSpell(5186, false);
        }
        if (Plr->getLevel() >= 10)
        {
            Plr->LearnSpell(99, false);
            Plr->LearnSpell(16689, false);
            Plr->LearnSpell(1058, false);
            Plr->LearnSpell(5232, false);
            Plr->LearnSpell(8924, false);
        }
        if (Plr->getLevel() >= 12)
        {
            Plr->LearnSpell(8936, false);
            Plr->LearnSpell(50769, false);
            Plr->LearnSpell(5229, false);
        }
        if (Plr->getLevel() >= 14)
        {
            Plr->LearnSpell(782, false);
            Plr->LearnSpell(5178, false);
            Plr->LearnSpell(5211, false);
            Plr->LearnSpell(5187, false);
        }
        if (Plr->getLevel() >= 16)
        {
            Plr->LearnSpell(783, false);
            Plr->LearnSpell(1430, false);
            Plr->LearnSpell(779, false);
            Plr->LearnSpell(8925, false);
            Plr->LearnSpell(1066, false);
        }
        if (Plr->getLevel() >= 18)
        {
            Plr->LearnSpell(770, false);
            Plr->LearnSpell(8938, false);
            Plr->LearnSpell(1062, false);
            Plr->LearnSpell(2637, false);
            Plr->LearnSpell(16857, false);
            Plr->LearnSpell(6808, false);
            Plr->LearnSpell(16810, false);
        }
        if (Plr->getLevel() >= 20)
        {
            Plr->LearnSpell(1079, false);
            Plr->LearnSpell(5188, false);
            Plr->LearnSpell(6756, false);
            Plr->LearnSpell(1735, false);
            Plr->LearnSpell(5215, false);
            Plr->LearnSpell(1082, false);
            Plr->LearnSpell(2912, false);
            Plr->LearnSpell(768, false);
            Plr->LearnSpell(20484, false);
        }
        if (Plr->getLevel() >= 22)
        {
            Plr->LearnSpell(5179, false);
            Plr->LearnSpell(5221, false);
            Plr->LearnSpell(8926, false);
            Plr->LearnSpell(2908, false);
            Plr->LearnSpell(2090, false);
        }
        if (Plr->getLevel() >= 24)
        {
            Plr->LearnSpell(1075, false);
            Plr->LearnSpell(1822, false);
            Plr->LearnSpell(50768, false);
            Plr->LearnSpell(780, false);
            Plr->LearnSpell(2782, false);
            Plr->LearnSpell(8939, false);
            Plr->LearnSpell(5217, false);
        }
        if (Plr->getLevel() >= 26)
        {
            Plr->LearnSpell(8949, false);
            Plr->LearnSpell(5189, false);
            Plr->LearnSpell(6809, false);
            Plr->LearnSpell(1850, false);
            Plr->LearnSpell(2893, false);
        }
        if (Plr->getLevel() >= 28)
        {
            Plr->LearnSpell(16811, false);
            Plr->LearnSpell(8927, false);
            Plr->LearnSpell(5209, false);
            Plr->LearnSpell(9492, false);
            Plr->LearnSpell(5195, false);
            Plr->LearnSpell(3029, false);
            Plr->LearnSpell(8998, false);
            Plr->LearnSpell(2091, false);
        }
        if (Plr->getLevel() >= 30)
        {
            Plr->LearnSpell(24974, false);
            Plr->LearnSpell(5234, false);
            Plr->LearnSpell(6800, false);
            Plr->LearnSpell(20739, false);
            Plr->LearnSpell(8940, false);
            Plr->LearnSpell(6798, false);
            Plr->LearnSpell(5180, false);
            Plr->LearnSpell(740, false);
        }
        if (Plr->getLevel() >= 32)
        {
            Plr->LearnSpell(5225, false);
            Plr->LearnSpell(6778, false);
            Plr->LearnSpell(22568, false);
            Plr->LearnSpell(6785, false);
            Plr->LearnSpell(9490, false);
        }
        if (Plr->getLevel() >= 34)
        {
            Plr->LearnSpell(1823, false);
            Plr->LearnSpell(8950, false);
            Plr->LearnSpell(8914, false);
            Plr->LearnSpell(769, false);
            Plr->LearnSpell(3627, false);
            Plr->LearnSpell(8972, false);
            Plr->LearnSpell(8928, false);
        }
        if (Plr->getLevel() >= 36)
        {
            Plr->LearnSpell(50767, false);
            Plr->LearnSpell(22842, false);
            Plr->LearnSpell(9493, false);
            Plr->LearnSpell(9005, false);
            Plr->LearnSpell(8941, false);
            Plr->LearnSpell(6793, false);
        }
        if (Plr->getLevel() >= 38)
        {
            Plr->LearnSpell(8992, false);
            Plr->LearnSpell(5201, false);
            Plr->LearnSpell(16812, false);
            Plr->LearnSpell(18657, false);
            Plr->LearnSpell(5196, false);
            Plr->LearnSpell(8955, false);
            Plr->LearnSpell(6780, false);
            Plr->LearnSpell(8903, false);
        }
        if (Plr->getLevel() >= 40)
        {
            Plr->LearnSpell(24975, false);
            Plr->LearnSpell(8910, false);
            Plr->LearnSpell(29166, false);
            Plr->LearnSpell(9000, false);
            Plr->LearnSpell(8929, false);
            Plr->LearnSpell(8907, false);
            Plr->LearnSpell(16914, false);
            Plr->LearnSpell(20719, false);
            Plr->LearnSpell(62600, false);
            Plr->LearnSpell(9634, false);
            Plr->LearnSpell(20742, false);
            Plr->LearnSpell(8918, false);
            Plr->LearnSpell(22827, false);
        }
        if (Plr->getLevel() >= 42)
        {
            Plr->LearnSpell(9745, false);
            Plr->LearnSpell(8951, false);
            Plr->LearnSpell(9750, false);
            Plr->LearnSpell(9747, false);
            Plr->LearnSpell(6787, false);
        }
        if (Plr->getLevel() >= 44)
        {
            Plr->LearnSpell(9756, false);
            Plr->LearnSpell(9754, false);
            Plr->LearnSpell(9752, false);
            Plr->LearnSpell(1824, false);
            Plr->LearnSpell(9758, false);
            Plr->LearnSpell(22812, false);
        }
        if (Plr->getLevel() >= 46)
        {
            Plr->LearnSpell(9829, false);
            Plr->LearnSpell(8983, false);
            Plr->LearnSpell(9833, false);
            Plr->LearnSpell(9839, false);
            Plr->LearnSpell(8905, false);
            Plr->LearnSpell(9823, false);
            Plr->LearnSpell(9821, false);
        }
        if (Plr->getLevel() >= 48)
        {
            Plr->LearnSpell(9856, false);
            Plr->LearnSpell(9845, false);
            Plr->LearnSpell(9852, false);
            Plr->LearnSpell(9849, false);
            Plr->LearnSpell(16813, false);
            Plr->LearnSpell(50766, false);
            Plr->LearnSpell(22828, false);
        }
        if (Plr->getLevel() >= 50)
        {
            Plr->LearnSpell(17401, false);
            Plr->LearnSpell(9888, false);
            Plr->LearnSpell(20747, false);
            Plr->LearnSpell(24976, false);
            Plr->LearnSpell(9884, false);
            Plr->LearnSpell(9866, false);
            Plr->LearnSpell(21849, false);
            Plr->LearnSpell(9880, false);
            Plr->LearnSpell(9862, false);
            Plr->LearnSpell(9875, false);
        }
        if (Plr->getLevel() >= 52)
        {
            Plr->LearnSpell(9834, false);
            Plr->LearnSpell(9898, false);
            Plr->LearnSpell(9840, false);
            Plr->LearnSpell(9894, false);
            Plr->LearnSpell(9892, false);
        }
        if (Plr->getLevel() >= 54)
        {
            Plr->LearnSpell(9908, false);
            Plr->LearnSpell(9910, false);
            Plr->LearnSpell(9904, false);
            Plr->LearnSpell(9912, false);
            Plr->LearnSpell(9830, false);
            Plr->LearnSpell(9901, false);
            Plr->LearnSpell(9857, false);
        }
        if (Plr->getLevel() >= 56)
        {
            Plr->LearnSpell(9827, false);
            Plr->LearnSpell(22829, false);
            Plr->LearnSpell(9889, false);
        }
        if (Plr->getLevel() >= 58)
        {
            Plr->LearnSpell(9876, false);
            Plr->LearnSpell(9853, false);
            Plr->LearnSpell(17329, false);
            Plr->LearnSpell(33982, false);
            Plr->LearnSpell(9835, false);
            Plr->LearnSpell(9867, false);
            Plr->LearnSpell(9850, false);
            Plr->LearnSpell(9881, false);
            Plr->LearnSpell(18658, false);
            Plr->LearnSpell(9841, false);
            Plr->LearnSpell(33986, false);
        }
        if (Plr->getLevel() >= 60)
        {
            Plr->LearnSpell(9846, false);
            Plr->LearnSpell(31018, false);
            Plr->LearnSpell(9885, false);
            Plr->LearnSpell(25299, false);
            Plr->LearnSpell(9896, false);
            Plr->LearnSpell(9858, false);
            Plr->LearnSpell(21850, false);
            Plr->LearnSpell(25297, false);
            Plr->LearnSpell(24977, false);
            Plr->LearnSpell(53223, false);
            Plr->LearnSpell(31709, false);
            Plr->LearnSpell(50765, false);
            Plr->LearnSpell(17402, false);
            Plr->LearnSpell(33950, false);
            Plr->LearnSpell(20748, false);
            Plr->LearnSpell(25298, false);
            Plr->LearnSpell(9863, false);
        }
        if (Plr->getLevel() >= 61)
        {
            Plr->LearnSpell(26984, false);
            Plr->LearnSpell(27001, false);
        }
        if (Plr->getLevel() >= 62)
        {
            Plr->LearnSpell(26978, false);
            Plr->LearnSpell(22570, false);
            Plr->LearnSpell(26998, false);
        }
        if (Plr->getLevel() >= 63)
        {
            Plr->LearnSpell(26981, false);
            Plr->LearnSpell(24248, false);
            Plr->LearnSpell(26987, false);
        }
        if (Plr->getLevel() >= 64)
        {
            Plr->LearnSpell(26997, false);
            Plr->LearnSpell(27003, false);
            Plr->LearnSpell(33763, false);
            Plr->LearnSpell(26992, false);
        }
        if (Plr->getLevel() >= 65)
        {
            Plr->LearnSpell(26980, false);
            Plr->LearnSpell(33357, false);
        }
        if (Plr->getLevel() >= 66)
        {
            Plr->LearnSpell(33745, false);
            Plr->LearnSpell(27006, false);
            Plr->LearnSpell(27005, false);
        }
        if (Plr->getLevel() >= 67)
        {
            Plr->LearnSpell(26996, false);
            Plr->LearnSpell(27008, false);
            Plr->LearnSpell(26986, false);
            Plr->LearnSpell(27000, false);
        }
        if (Plr->getLevel() >= 68)
        {
            Plr->LearnSpell(26989, false);
            Plr->LearnSpell(33987, false);
            Plr->LearnSpell(27009, false);
            Plr->LearnSpell(33983, false);
        }
        if (Plr->getLevel() >= 69)
        {
            Plr->LearnSpell(50764, false);
            Plr->LearnSpell(26985, false);
            Plr->LearnSpell(26982, false);
            Plr->LearnSpell(26979, false);
            Plr->LearnSpell(27004, false);
            Plr->LearnSpell(26994, false);
        }
        if (Plr->getLevel() >= 70)
        {
            Plr->LearnSpell(53199, false);
            Plr->LearnSpell(26983, false);
            Plr->LearnSpell(33786, false);
            Plr->LearnSpell(27002, false);
            Plr->LearnSpell(26991, false);
            Plr->LearnSpell(53248, false);
            Plr->LearnSpell(26995, false);
            Plr->LearnSpell(53225, false);
            Plr->LearnSpell(27012, false);
            Plr->LearnSpell(26988, false);
            Plr->LearnSpell(26990, false);
            Plr->LearnSpell(27013, false);
        }
        if (Plr->getLevel() >= 71)
        {
            Plr->LearnSpell(48559, false);
            Plr->LearnSpell(48442, false);
            Plr->LearnSpell(40120, false);
            Plr->LearnSpell(50212, false);
            Plr->LearnSpell(49799, false);
            Plr->LearnSpell(62078, false);
        }
        if (Plr->getLevel() >= 72)
        {
            Plr->LearnSpell(48561, false);
            Plr->LearnSpell(48464, false);
            Plr->LearnSpell(48573, false);
            Plr->LearnSpell(48450, false);
            Plr->LearnSpell(48576, false);
        }
        if (Plr->getLevel() >= 73)
        {
            Plr->LearnSpell(48578, false);
            Plr->LearnSpell(48569, false);
            Plr->LearnSpell(48567, false);
            Plr->LearnSpell(48479, false);
        }
        if (Plr->getLevel() >= 74)
        {
            Plr->LearnSpell(49802, false);
            Plr->LearnSpell(48459, false);
            Plr->LearnSpell(53307, false);
            Plr->LearnSpell(48377, false);
        }
        if (Plr->getLevel() >= 75)
        {
            Plr->LearnSpell(48446, false);
            Plr->LearnSpell(48563, false);
            Plr->LearnSpell(48440, false);
            Plr->LearnSpell(53249, false);
            Plr->LearnSpell(48462, false);
            Plr->LearnSpell(48571, false);
            Plr->LearnSpell(52610, false);
            Plr->LearnSpell(53200, false);
            Plr->LearnSpell(53226, false);
            Plr->LearnSpell(48565, false);
        }
        if (Plr->getLevel() >= 76)
        {
            Plr->LearnSpell(48575, false);
        }
        if (Plr->getLevel() >= 77)
        {
            Plr->LearnSpell(48443, false);
            Plr->LearnSpell(48560, false);
            Plr->LearnSpell(49803, false);
            Plr->LearnSpell(48562, false);
        }
        if (Plr->getLevel() >= 78)
        {
            Plr->LearnSpell(48574, false);
            Plr->LearnSpell(53312, false);
            Plr->LearnSpell(53308, false);
            Plr->LearnSpell(48465, false);
            Plr->LearnSpell(48577, false);
        }
        if (Plr->getLevel() >= 79)
        {
            Plr->LearnSpell(48477, false);
            Plr->LearnSpell(48461, false);
            Plr->LearnSpell(48579, false);
            Plr->LearnSpell(48378, false);
            Plr->LearnSpell(48570, false);
            Plr->LearnSpell(50213, false);
            Plr->LearnSpell(48480, false);
        }
        if (Plr->getLevel() >= 80)
        {
            Plr->LearnSpell(48470, false);
            Plr->LearnSpell(50763, false);
            Plr->LearnSpell(48463, false);
            Plr->LearnSpell(49800, false);
            Plr->LearnSpell(48572, false);
            Plr->LearnSpell(48468, false);
            Plr->LearnSpell(48566, false);
            Plr->LearnSpell(48467, false);
            Plr->LearnSpell(48441, false);
            Plr->LearnSpell(53251, false);
            Plr->LearnSpell(48564, false);
            Plr->LearnSpell(48451, false);
            Plr->LearnSpell(48568, false);
            Plr->LearnSpell(48447, false);
            Plr->LearnSpell(61384, false);
            Plr->LearnSpell(48469, false);
            Plr->LearnSpell(50464, false);
            Plr->LearnSpell(53201, false);
        }
    }
}
