/*

# All Mounts NPC #

#### A module for AzerothCore by [StygianTheBest](https://github.com/StygianTheBest/AzerothCore-Content/tree/master/Modules)
------------------------------------------------------------------------------------------------------------------

### Description ###
------------------------------------------------------------------------------------------------------------------
This NPC will teach the player every mount available in the game.


### To-Do ###
------------------------------------------------------------------------------------------------------------------
- Remove all mounts not compatible with 3.3.5a


### Data ###
------------------------------------------------------------------------------------------------------------------
- Type: NPC
- Script: AllMountsNPC
- Config: Yes
    - Enable Module Announce
- SQL: Yes
    - NPC ID: 601014


### Version ###
------------------------------------------------------------------------------------------------------------------
- v2017.07.11 - Release
- v2017.08.03 - Added Bengal Tiger + Tiger Riding


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
#include "Define.h"
#include "ScriptMgr.h"
#include "SharedDefines.h"
#include "Unit.h"
#include "Pet.h"
#include "Player.h"
#include "ScriptPCH.h"
#include "ScriptedGossip.h"
#include "GossipDef.h"
#include "World.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include "Chat.h"
#include "Config.h"

class AllMountsAnnounce : public PlayerScript
{

public:

    AllMountsAnnounce() : PlayerScript("AllMountsAnnounce") {}

    void OnLogin(Player* player, bool firstLogin)
    {
        if (firstLogin) {
            // Announce Module
            if (sConfigMgr->GetBoolDefault("AllMountsNPC.Announce", true))
            {
                ChatHandler(player->GetSession()).SendSysMessage("This server is running the |cff4CFF00AllMountsNPC |rmodule.");
            }
        }
    }
};

class AllMountsNPC : public CreatureScript
{

public:

    AllMountsNPC() : CreatureScript("AllMountsNPC") { }

    // Passive Emotes
    struct NPC_PassiveAI : public ScriptedAI
    {
        NPC_PassiveAI(Creature* creature) : ScriptedAI(creature) { }

        bool OnGossipHello(Player* player)
        {
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Learn All Mounts", GOSSIP_SENDER_MAIN, 1);
            SendGossipMenuFor(player, 600025, me);
            return true;
        }

        bool OnGossipSelect(Player* player, uint32 menuId, uint32 gossipListId)
        {
            uint32 const sender = player->PlayerTalkClass->GetGossipOptionSender(gossipListId);
            uint32 const action = player->PlayerTalkClass->GetGossipOptionAction(gossipListId);

            
                player->LearnSpell(10790, true);		// ReinsoftheBengalTiger
                player->LearnSpell(828, true);          // TigerRiding
                player->LearnSpell(72286, true);           // Invincible'sReins
                player->LearnSpell(20221, true);		// Furor'sFabledSteed
                player->LearnSpell(48778, true);		// AcherusDeathcharger
                player->LearnSpell(60025, true);		// AlbinoDrake
                player->LearnSpell(127180, true);		// AlbinoRidingCrane
                player->LearnSpell(98204, true);		// AmaniBattleBear
                player->LearnSpell(96503, true);		// AmaniDragonhawk
                player->LearnSpell(43688, true);		// AmaniWarBear
                player->LearnSpell(138424, true);		// AmberPrimordialDirehorn
                player->LearnSpell(123886, true);		// AmberScorpion
                player->LearnSpell(16056, true);		// AncientFrostsaber
                player->LearnSpell(171618, true);		// AncientLeatherhide
                player->LearnSpell(16081, true);		// ArcticWolf
                player->LearnSpell(66906, true);		// ArgentCharger
                player->LearnSpell(63844, true);		// ArgentHippogryph
                player->LearnSpell(66907, true);		// ArgentWarhorse
                player->LearnSpell(67466, true);		// ArgentWarhorse
                player->LearnSpell(139595, true);		// ArmoredBloodwing
                player->LearnSpell(142478, true);		// ArmoredBlueDragonhawk
                player->LearnSpell(61230, true);		// ArmoredBlueWindRider
                player->LearnSpell(60114, true);		// ArmoredBrownBear
                player->LearnSpell(60116, true);		// ArmoredBrownBear
                player->LearnSpell(171629, true);		// ArmoredFrostboar
                player->LearnSpell(171838, true);		// ArmoredFrostwolf
                player->LearnSpell(171626, true);		// ArmoredIrontusk
                player->LearnSpell(171630, true);		// ArmoredRazorback
                player->LearnSpell(96491, true);		// ArmoredRazzashiRaptor
                player->LearnSpell(142266, true);		// ArmoredRedDragonhawk
                player->LearnSpell(136400, true);		// ArmoredSkyscreamer
                player->LearnSpell(61229, true);		// ArmoredSnowyGryphon
                player->LearnSpell(132117, true);		// AshenPandarenPhoenix
                player->LearnSpell(40192, true);		// AshesofAl'ar
                player->LearnSpell(148428, true);		// AshhideMushanBeast
                player->LearnSpell(127170, true);		// AstralCloudSerpent
                player->LearnSpell(123992, true);		// AzureCloudSerpent
                player->LearnSpell(59567, true);		// AzureDrake
                player->LearnSpell(41514, true);		// AzureNetherwingDrake
                player->LearnSpell(127174, true);		// AzureRidingCrane
                player->LearnSpell(118089, true);		// AzureWaterStrider
                player->LearnSpell(51412, true);		// BigBattleBear
                player->LearnSpell(58983, true);		// BigBlizzardBear
                player->LearnSpell(71342, true);		// BigLoveRocket
                player->LearnSpell(22719, true);		// BlackBattlestrider
                player->LearnSpell(127286, true);		// BlackDragonTurtle
                player->LearnSpell(59650, true);		// BlackDrake
                player->LearnSpell(35022, true);		// BlackHawkstrider
                player->LearnSpell(16055, true);		// BlackNightsaber
                player->LearnSpell(138642, true);		// BlackPrimalRaptor
                player->LearnSpell(59976, true);		// BlackProto-Drake
                player->LearnSpell(25863, true);		// BlackQirajiBattleTank
                player->LearnSpell(26655, true);		// BlackQirajiBattleTank
                player->LearnSpell(26656, true);		// BlackQirajiBattleTank
                player->LearnSpell(17461, true);		// BlackRam
                player->LearnSpell(130138, true);		// BlackRidingGoat
                player->LearnSpell(127209, true);		// BlackRidingYak
                player->LearnSpell(64977, true);		// BlackSkeletalHorse
                player->LearnSpell(470, true);		    // BlackStallion
                player->LearnSpell(60118, true);		// BlackWarBear
                player->LearnSpell(60119, true);		// BlackWarBear
                player->LearnSpell(48027, true);		// BlackWarElekk
                player->LearnSpell(22718, true);		// BlackWarKodo
                player->LearnSpell(59785, true);		// BlackWarMammoth
                player->LearnSpell(59788, true);		// BlackWarMammoth
                player->LearnSpell(22720, true);		// BlackWarRam
                player->LearnSpell(22721, true);		// BlackWarRaptor
                player->LearnSpell(22717, true);		// BlackWarSteed
                player->LearnSpell(22723, true);		// BlackWarTiger
                player->LearnSpell(22724, true);		// BlackWarWolf
                player->LearnSpell(64658, true);		// BlackWolf
                player->LearnSpell(171627, true);		// BlacksteelBattleboar
                player->LearnSpell(107842, true);		// BlazingDrake
                player->LearnSpell(74856, true);		// BlazingHippogryph
                player->LearnSpell(127220, true);		// BlondeRidingYak
                player->LearnSpell(72808, true);		// BloodbathedFrostbroodVanquisher
                player->LearnSpell(171620, true);		// BloodhoofBull
                player->LearnSpell(127287, true);		// BlueDragonTurtle
                player->LearnSpell(61996, true);		// BlueDragonhawk
                player->LearnSpell(59568, true);		// BlueDrake
                player->LearnSpell(35020, true);		// BlueHawkstrider
                player->LearnSpell(10969, true);		// BlueMechanostrider
                player->LearnSpell(59996, true);		// BlueProto-Drake
                player->LearnSpell(25953, true);		// BlueQirajiBattleTank
                player->LearnSpell(39803, true);		// BlueRidingNetherRay
                player->LearnSpell(129934, true);		// BlueShado-PanRidingTiger
                player->LearnSpell(17463, true);		// BlueSkeletalHorse
                player->LearnSpell(64656, true);		// BlueSkeletalWarhorse
                player->LearnSpell(32244, true);		// BlueWindRider
                player->LearnSpell(138640, true);		// Bone-WhitePrimalRaptor
                player->LearnSpell(142641, true);		// Brawler'sBurlyMushanBeast
                player->LearnSpell(171832, true);		// BreezestriderStallion
                player->LearnSpell(50869, true);		// BrewfestKodo
                player->LearnSpell(43899, true);		// BrewfestRam
                player->LearnSpell(190690, true);		// BristlingHellboar
                player->LearnSpell(59569, true);		// BronzeDrake
                player->LearnSpell(127288, true);		// BrownDragonTurtle
                player->LearnSpell(34406, true);		// BrownElekk
                player->LearnSpell(458, true);		// BrownHorse
                player->LearnSpell(18990, true);		// BrownKodo
                player->LearnSpell(6899, true);		// BrownRam
                player->LearnSpell(88748, true);		// BrownRidingCamel
                player->LearnSpell(130086, true);		// BrownRidingGoat
                player->LearnSpell(127213, true);		// BrownRidingYak
                player->LearnSpell(17464, true);		// BrownSkeletalHorse
                player->LearnSpell(6654, true);		// BrownWolf
                player->LearnSpell(58615, true);		// BrutalNetherDrake
                player->LearnSpell(124550, true);		// CataclysmicGladiator'sTwilightDrake
                player->LearnSpell(75614, true);		// CelestialSteed
                player->LearnSpell(43927, true);		// CenarionWarHippogryph
                player->LearnSpell(171848, true);		// Challenger'sWarYeti
                player->LearnSpell(171846, true);		// Champion'sTreadblade
                player->LearnSpell(6648, true);		// ChestnutMare
                player->LearnSpell(171847, true);		// CindermaneCharger
                player->LearnSpell(139448, true);		// ClutchofJi-Kun
                player->LearnSpell(189364, true);		// CoalfistGronnling
                player->LearnSpell(41515, true);		// CobaltNetherwingDrake
                player->LearnSpell(138423, true);		// CobaltPrimordialDirehorn
                player->LearnSpell(39315, true);		// CobaltRidingTalbuk
                player->LearnSpell(34896, true);		// CobaltWarTalbuk
                player->LearnSpell(170347, true);		// CoreHound
                player->LearnSpell(183117, true);		// CorruptedDreadwing
                player->LearnSpell(97560, true);		// CorruptedFireHawk
                player->LearnSpell(102514, true);		// CorruptedHippogryph
                player->LearnSpell(169952, true);		// CreepingCarpet
                player->LearnSpell(127156, true);		// CrimsonCloudSerpent
                player->LearnSpell(73313, true);		// CrimsonDeathcharger
                player->LearnSpell(129552, true);		// CrimsonPandarenPhoenix
                player->LearnSpell(140250, true);		// CrimsonPrimalDirehorn
                player->LearnSpell(123160, true);		// CrimsonRidingCrane
                player->LearnSpell(127271, true);		// CrimsonWaterStrider
                player->LearnSpell(68188, true);		// Crusader'sBlackWarhorse
                player->LearnSpell(68187, true);		// Crusader'sWhiteWarhorse
                player->LearnSpell(88990, true);		// DarkPhoenix
                player->LearnSpell(39316, true);		// DarkRidingTalbuk
                player->LearnSpell(34790, true);		// DarkWarTalbuk
                player->LearnSpell(103081, true);		// DarkmoonDancingBear
                player->LearnSpell(63635, true);		// DarkspearRaptor
                player->LearnSpell(63637, true);		// DarnassianNightsaber
                player->LearnSpell(64927, true);		// DeadlyGladiator'sFrostWyrm
                player->LearnSpell(190977, true);		// DeathtuskFelboar
                player->LearnSpell(193007, true);		// Demonsaber
                player->LearnSpell(126507, true);		// Depleted-KypariumRocket
                player->LearnSpell(6653, true);		// DireWolf
                player->LearnSpell(171634, true);		// DomesticatedRazorback
                player->LearnSpell(88335, true);		// DrakeoftheEastWind
                player->LearnSpell(88742, true);		// DrakeoftheNorthWind
                player->LearnSpell(88744, true);		// DrakeoftheSouthWind
                player->LearnSpell(88741, true);		// DrakeoftheWestWind
                player->LearnSpell(155741, true);		// DreadRaven
                player->LearnSpell(148972, true);		// Dreadsteed
                player->LearnSpell(171844, true);		// DustmaneDirewolf
                player->LearnSpell(171625, true);		// DustyRockhide
                player->LearnSpell(32239, true);		// EbonGryphon
                player->LearnSpell(194464, true);		// EclipseDragonhawk
                player->LearnSpell(175700, true);		// EmeraldDrake
                player->LearnSpell(149801, true);		// EmeraldHippogryph
                player->LearnSpell(132118, true);		// EmeraldPandarenPhoenix
                player->LearnSpell(8395, true);		// EmeraldRaptor
                player->LearnSpell(142878, true);		// EnchantedFeyDragon
                player->LearnSpell(63639, true);		// ExodarElekk
                player->LearnSpell(110039, true);		// Experiment12-B
                player->LearnSpell(113120, true);		// Feldrake
                player->LearnSpell(97501, true);		// FelfireHawk
                player->LearnSpell(200175, true);		// Felsaber
                player->LearnSpell(148970, true);		// Felsteed
                player->LearnSpell(182912, true);		// FelsteelAnnihilator
                player->LearnSpell(36702, true);		// FieryWarhorse
                player->LearnSpell(101542, true);		// FlametalonofAlysrazor
                player->LearnSpell(97359, true);		// FlamewardHippogryph
                player->LearnSpell(61451, true);		// FlyingCarpet
                player->LearnSpell(44153, true);		// FlyingMachine
                player->LearnSpell(63643, true);		// ForsakenWarhorse
                player->LearnSpell(84751, true);		// FossilizedRaptor
                player->LearnSpell(17460, true);		// FrostRam
                player->LearnSpell(171632, true);		// FrostplainsBattleboar
                player->LearnSpell(23509, true);		// FrostwolfHowler
                player->LearnSpell(75596, true);		// FrostyFlyingCarpet
                player->LearnSpell(65439, true);		// FuriousGladiator'sFrostWyrm
                player->LearnSpell(171851, true);		// GarnNighthowl
                player->LearnSpell(171836, true);		// GarnSteelmaw
                player->LearnSpell(126508, true);		// GeosynchronousWorldSpinner
                player->LearnSpell(136505, true);		// GhastlyCharger
                player->LearnSpell(171635, true);		// GiantColdsnout
                player->LearnSpell(63638, true);		// GnomereganMechanostrider
                player->LearnSpell(89520, true);		// GoblinMiniHotrod
                player->LearnSpell(87090, true);		// GoblinTrike
                player->LearnSpell(87091, true);		// GoblinTurbo-Trike
                player->LearnSpell(123993, true);		// GoldenCloudSerpent
                player->LearnSpell(32235, true);		// GoldenGryphon
                player->LearnSpell(90621, true);		// GoldenKing
                player->LearnSpell(140249, true);		// GoldenPrimalDirehorn
                player->LearnSpell(127176, true);		// GoldenRidingCrane
                player->LearnSpell(127278, true);		// GoldenWaterStrider
                player->LearnSpell(171436, true);		// GorestriderGronnling
                player->LearnSpell(135416, true);		// GrandArmoredGryphon
                player->LearnSpell(135418, true);		// GrandArmoredWyvern
                player->LearnSpell(61465, true);		// GrandBlackWarMammoth
                player->LearnSpell(61467, true);		// GrandBlackWarMammoth
                player->LearnSpell(122708, true);		// GrandExpeditionYak
                player->LearnSpell(136163, true);		// GrandGryphon
                player->LearnSpell(61470, true);		// GrandIceMammoth
                player->LearnSpell(61469, true);		// GrandIceMammoth
                player->LearnSpell(136164, true);		// GrandWyvern
                player->LearnSpell(35710, true);		// GrayElekk
                player->LearnSpell(18989, true);		// GrayKodo
                player->LearnSpell(6777, true);		// GrayRam
                player->LearnSpell(127295, true);		// GreatBlackDragonTurtle
                player->LearnSpell(127302, true);		// GreatBlueDragonTurtle
                player->LearnSpell(35713, true);		// GreatBlueElekk
                player->LearnSpell(49379, true);		// GreatBrewfestKodo
                player->LearnSpell(127308, true);		// GreatBrownDragonTurtle
                player->LearnSpell(23249, true);		// GreatBrownKodo
                player->LearnSpell(65641, true);		// GreatGoldenKodo
                player->LearnSpell(23248, true);		// GreatGrayKodo
                player->LearnSpell(127293, true);		// GreatGreenDragonTurtle
                player->LearnSpell(35712, true);		// GreatGreenElekk
                player->LearnSpell(171636, true);		// GreatGreytusk
                player->LearnSpell(127310, true);		// GreatPurpleDragonTurtle
                player->LearnSpell(35714, true);		// GreatPurpleElekk
                player->LearnSpell(120822, true);		// GreatRedDragonTurtle
                player->LearnSpell(65637, true);		// GreatRedElekk
                player->LearnSpell(23247, true);		// GreatWhiteKodo
                player->LearnSpell(120395, true);		// GreenDragonTurtle
                player->LearnSpell(18991, true);		// GreenKodo
                player->LearnSpell(17453, true);		// GreenMechanostrider
                player->LearnSpell(138643, true);		// GreenPrimalRaptor
                player->LearnSpell(61294, true);		// GreenProto-Drake
                player->LearnSpell(26056, true);		// GreenQirajiBattleTank
                player->LearnSpell(39798, true);		// GreenRidingNetherRay
                player->LearnSpell(129932, true);		// GreenShado-PanRidingTiger
                player->LearnSpell(17465, true);		// GreenSkeletalWarhorse
                player->LearnSpell(32245, true);		// GreenWindRider
                player->LearnSpell(88750, true);		// GreyRidingCamel
                player->LearnSpell(127216, true);		// GreyRidingYak
                player->LearnSpell(148619, true);		// GrievousGladiator'sCloudSerpent
                player->LearnSpell(163025, true);		// GrinningReaver
                player->LearnSpell(189999, true);		// GroveWarden
                player->LearnSpell(48025, true);		// HeadlessHorseman'sMount
                player->LearnSpell(110051, true);		// HeartoftheAspects
                player->LearnSpell(142073, true);		// Hearthsteed
                player->LearnSpell(127169, true);		// HeavenlyAzureCloudSerpent
                player->LearnSpell(127161, true);		// HeavenlyCrimsonCloudSerpent
                player->LearnSpell(127164, true);		// HeavenlyGoldenCloudSerpent
                player->LearnSpell(127165, true);		// HeavenlyJadeCloudSerpent
                player->LearnSpell(127158, true);		// HeavenlyOnyxCloudSerpent
                player->LearnSpell(59799, true);		// IceMammoth
                player->LearnSpell(59797, true);		// IceMammoth
                player->LearnSpell(72807, true);		// IceboundFrostbroodVanquisher
                player->LearnSpell(17459, true);		// IcyBlueMechanostriderModA
                player->LearnSpell(189998, true);		// IllidariFelstalker
                player->LearnSpell(124659, true);		// ImperialQuilen
                player->LearnSpell(186305, true);		// InfernalDirewolf
                player->LearnSpell(201098, true);		// InfiniteTimereaver
                player->LearnSpell(153489, true);		// IronSkyreaver
                player->LearnSpell(63956, true);		// IronboundProto-Drake
                player->LearnSpell(142910, true);		// IronboundWraithcharger
                player->LearnSpell(63636, true);		// IronforgeRam
                player->LearnSpell(171621, true);		// IronhoofDestroyer
                player->LearnSpell(171839, true);		// IronsideWarwolf
                player->LearnSpell(17450, true);		// IvoryRaptor
                player->LearnSpell(113199, true);		// JadeCloudSerpent
                player->LearnSpell(133023, true);		// JadePandarenKite
                player->LearnSpell(121837, true);		// JadePanther
                player->LearnSpell(138426, true);		// JadePrimordialDirehorn
                player->LearnSpell(127274, true);		// JadeWaterStrider
                player->LearnSpell(120043, true);		// JeweledOnyxPanther
                player->LearnSpell(127178, true);		// JungleRidingCrane
                player->LearnSpell(93644, true);		// Kor'kronAnnihilator
                player->LearnSpell(148417, true);		// Kor'kronJuggernaut
                player->LearnSpell(148396, true);		// Kor'kronWarWolf
                player->LearnSpell(107845, true);		// Life-Binder'sHandmaiden
                player->LearnSpell(65917, true);		// MagicRooster
                player->LearnSpell(61309, true);		// MagnificentFlyingCarpet
                player->LearnSpell(139407, true);		// MalevolentGladiator'sCloudSerpent
                player->LearnSpell(55531, true);		// Mechano-Hog
                player->LearnSpell(60424, true);		// Mekgineer'sChopper
                player->LearnSpell(44744, true);		// MercilessNetherDrake
                player->LearnSpell(63796, true);		// Mimiron'sHead
                player->LearnSpell(191314, true);		// MinionofGrumpus
                player->LearnSpell(171825, true);		// MosshideRiverwallow
                player->LearnSpell(93623, true);		// MottledDrake
                player->LearnSpell(171622, true);		// MottledMeadowstomper
                player->LearnSpell(16084, true);		// MottledRedRaptor
                player->LearnSpell(171850, true);		// MountTemplate49
                player->LearnSpell(171827, true);		// MountTemplate50
                player->LearnSpell(171840, true);		// MountTemplate51
                player->LearnSpell(103195, true);		// MountainHorse
                player->LearnSpell(171826, true);		// MudbackRiverbeast
                player->LearnSpell(180545, true);		// MysticRunesaber
                player->LearnSpell(121820, true);		// ObsidianNightwing
                player->LearnSpell(66846, true);		// OchreSkeletalWarhorse
                player->LearnSpell(127154, true);		// OnyxCloudSerpent
                player->LearnSpell(41513, true);		// OnyxNetherwingDrake
                player->LearnSpell(69395, true);		// OnyxianDrake
                player->LearnSpell(127272, true);		// OrangeWaterStrider
                player->LearnSpell(63640, true);		// OrgrimmarWolf
                player->LearnSpell(171833, true);		// PaleThorngrazer
                player->LearnSpell(16082, true);		// Palomino
                player->LearnSpell(118737, true);		// PandarenKite
                player->LearnSpell(130985, true);		// PandarenKite
                player->LearnSpell(32345, true);		// PeepthePhoenixMount
                player->LearnSpell(88718, true);		// PhosphorescentStoneDrake
                player->LearnSpell(472, true);		// Pinto
                player->LearnSpell(60021, true);		// PlaguedProto-Drake
                player->LearnSpell(193695, true);		// PrestigiousWarSteed
                player->LearnSpell(204166, true);		// PrestigiousWarWolf
                player->LearnSpell(148620, true);		// PridefulGladiator'sCloudSerpent
                player->LearnSpell(186828, true);		// PrimalGladiator'sFelbloodGronnling
                player->LearnSpell(97493, true);		// PurebloodFireHawk
                player->LearnSpell(127289, true);		// PurpleDragonTurtle
                player->LearnSpell(35711, true);		// PurpleElekk
                player->LearnSpell(35018, true);		// PurpleHawkstrider
                player->LearnSpell(41516, true);		// PurpleNetherwingDrake
                player->LearnSpell(39801, true);		// PurpleRidingNetherRay
                player->LearnSpell(23246, true);		// PurpleSkeletalWarhorse
                player->LearnSpell(66090, true);		// Quel'doreiSteed
                player->LearnSpell(41252, true);		// RavenLord
                player->LearnSpell(127290, true);		// RedDragonTurtle
                player->LearnSpell(61997, true);		// RedDragonhawk
                player->LearnSpell(59570, true);		// RedDrake
                player->LearnSpell(130092, true);		// RedFlyingCloud
                player->LearnSpell(34795, true);		// RedHawkstrider
                player->LearnSpell(10873, true);		// RedMechanostrider
                player->LearnSpell(138641, true);		// RedPrimalRaptor
                player->LearnSpell(59961, true);		// RedProto-Drake
                player->LearnSpell(26054, true);		// RedQirajiBattleTank
                player->LearnSpell(39800, true);		// RedRidingNetherRay
                player->LearnSpell(129935, true);		// RedShado-PanRidingTiger
                player->LearnSpell(17462, true);		// RedSkeletalHorse
                player->LearnSpell(22722, true);		// RedSkeletalWarhorse
                player->LearnSpell(16080, true);		// RedWolf
                player->LearnSpell(127177, true);		// RegalRidingCrane
                player->LearnSpell(67336, true);		// RelentlessGladiator'sFrostWyrm
                player->LearnSpell(30174, true);		// RidingTurtle
                player->LearnSpell(17481, true);		// Rivendare'sDeathcharger
                player->LearnSpell(171628, true);		// RocktuskBattleboar
                player->LearnSpell(121838, true);		// RubyPanther
                player->LearnSpell(63963, true);		// RustedProto-Drake
                player->LearnSpell(101821, true);		// RuthlessGladiator'sTwilightDrake
                player->LearnSpell(93326, true);		// SandstoneDrake
                player->LearnSpell(121836, true);		// SapphirePanther
                player->LearnSpell(171824, true);		// SapphireRiverbeast
                player->LearnSpell(97581, true);		// SavageRaptor
                player->LearnSpell(64731, true);		// SeaTurtle
                player->LearnSpell(171624, true);		// ShadowhidePearltusk
                player->LearnSpell(171829, true);		// ShadowmaneCharger
                player->LearnSpell(66087, true);		// SilverCovenantHippogryph
                player->LearnSpell(39802, true);		// SilverRidingNetherRay
                player->LearnSpell(39317, true);		// SilverRidingTalbuk
                player->LearnSpell(34898, true);		// SilverWarTalbuk
                player->LearnSpell(63642, true);		// SilvermoonHawkstrider
                player->LearnSpell(134359, true);		// SkyGolem
                player->LearnSpell(138425, true);		// SlatePrimordialDirehorn
                player->LearnSpell(171843, true);		// SmokyDirewolf
                player->LearnSpell(32240, true);		// SnowyGryphon
                player->LearnSpell(191633, true);		// SoaringSkyterror
                player->LearnSpell(171828, true);		// SolarSpirehawk
                player->LearnSpell(130965, true);		// SonofGalleon
                player->LearnSpell(148392, true);		// SpawnofGalakras
                player->LearnSpell(136471, true);		// SpawnofHorridon
                player->LearnSpell(107516, true);		// SpectralGryphon
                player->LearnSpell(92231, true);		// SpectralSteed
                player->LearnSpell(42776, true);		// SpectralTiger
                player->LearnSpell(107517, true);		// SpectralWindRider
                player->LearnSpell(92232, true);		// SpectralWolf
                player->LearnSpell(196681, true);		// SpiritofEche'ro
                player->LearnSpell(10789, true);		// SpottedFrostsaber
                player->LearnSpell(147595, true);		// Stormcrow
                player->LearnSpell(23510, true);		// StormpikeBattleCharger
                player->LearnSpell(63232, true);		// StormwindSteed
                player->LearnSpell(66847, true);		// StripedDawnsaber
                player->LearnSpell(8394, true);		// StripedFrostsaber
                player->LearnSpell(10793, true);		// StripedNightsaber
                player->LearnSpell(98718, true);		// SubduedSeahorse
                player->LearnSpell(179245, true);		// SummonChauffeur
                player->LearnSpell(179244, true);		// SummonChauffeur
                player->LearnSpell(171849, true);		// SunhideGronnling
                player->LearnSpell(66088, true);		// SunreaverDragonhawk
                player->LearnSpell(66091, true);		// SunreaverHawkstrider
                player->LearnSpell(121839, true);		// SunstonePanther
                player->LearnSpell(68057, true);		// SwiftAllianceSteed
                player->LearnSpell(32242, true);		// SwiftBlueGryphon
                player->LearnSpell(23241, true);		// SwiftBlueRaptor
                player->LearnSpell(171830, true);		// SwiftBreezestrider
                player->LearnSpell(43900, true);		// SwiftBrewfestRam
                player->LearnSpell(23238, true);		// SwiftBrownRam
                player->LearnSpell(23229, true);		// SwiftBrownSteed
                player->LearnSpell(23250, true);		// SwiftBrownWolf
                player->LearnSpell(65646, true);		// SwiftBurgundyWolf
                player->LearnSpell(102346, true);		// SwiftForestStrider
                player->LearnSpell(23221, true);		// SwiftFrostsaber
                player->LearnSpell(171842, true);		// SwiftFrostwolf
                player->LearnSpell(23239, true);		// SwiftGrayRam
                player->LearnSpell(65640, true);		// SwiftGraySteed
                player->LearnSpell(23252, true);		// SwiftGrayWolf
                player->LearnSpell(32290, true);		// SwiftGreenGryphon
                player->LearnSpell(35025, true);		// SwiftGreenHawkstrider
                player->LearnSpell(23225, true);		// SwiftGreenMechanostrider
                player->LearnSpell(32295, true);		// SwiftGreenWindRider
                player->LearnSpell(68056, true);		// SwiftHordeWolf
                player->LearnSpell(102350, true);		// SwiftLovebird
                player->LearnSpell(23219, true);		// SwiftMistsaber
                player->LearnSpell(65638, true);		// SwiftMoonsaber
                player->LearnSpell(103196, true);		// SwiftMountainHorse
                player->LearnSpell(37015, true);		// SwiftNetherDrake
                player->LearnSpell(23242, true);		// SwiftOliveRaptor
                player->LearnSpell(23243, true);		// SwiftOrangeRaptor
                player->LearnSpell(23227, true);		// SwiftPalomino
                player->LearnSpell(33660, true);		// SwiftPinkHawkstrider
                player->LearnSpell(32292, true);		// SwiftPurpleGryphon
                player->LearnSpell(35027, true);		// SwiftPurpleHawkstrider
                player->LearnSpell(65644, true);		// SwiftPurpleRaptor
                player->LearnSpell(32297, true);		// SwiftPurpleWindRider
                player->LearnSpell(24242, true);		// SwiftRazzashiRaptor
                player->LearnSpell(32289, true);		// SwiftRedGryphon
                player->LearnSpell(65639, true);		// SwiftRedHawkstrider
                player->LearnSpell(32246, true);		// SwiftRedWindRider
                player->LearnSpell(101573, true);		// SwiftShorestrider
                player->LearnSpell(55164, true);		// SwiftSpectralGryphon
                player->LearnSpell(194046, true);		// SwiftSpectralRylak
                player->LearnSpell(42777, true);		// SwiftSpectralTiger
                player->LearnSpell(102349, true);		// SwiftSpringstrider
                player->LearnSpell(23338, true);		// SwiftStormsaber
                player->LearnSpell(23251, true);		// SwiftTimberWolf
                player->LearnSpell(65643, true);		// SwiftVioletRam
                player->LearnSpell(35028, true);		// SwiftWarstrider
                player->LearnSpell(46628, true);		// SwiftWhiteHawkstrider
                player->LearnSpell(23223, true);		// SwiftWhiteMechanostrider
                player->LearnSpell(23240, true);		// SwiftWhiteRam
                player->LearnSpell(23228, true);		// SwiftWhiteSteed
                player->LearnSpell(134573, true);		// SwiftWindsteed
                player->LearnSpell(23222, true);		// SwiftYellowMechanostrider
                player->LearnSpell(32296, true);		// SwiftYellowWindRider
                player->LearnSpell(49322, true);		// SwiftZhevra
                player->LearnSpell(96499, true);		// SwiftZulianPanther
                player->LearnSpell(24252, true);		// SwiftZulianTiger
                player->LearnSpell(88749, true);		// TanRidingCamel
                player->LearnSpell(39318, true);		// TanRidingTalbuk
                player->LearnSpell(34899, true);		// TanWarTalbuk
                player->LearnSpell(32243, true);		// TawnyWindRider
                player->LearnSpell(18992, true);		// TealKodo
                player->LearnSpell(63641, true);		// ThunderBluffKodo
                player->LearnSpell(129918, true);		// ThunderingAugustCloudSerpent
                player->LearnSpell(139442, true);		// ThunderingCobaltCloudSerpent
                player->LearnSpell(124408, true);		// ThunderingJadeCloudSerpent
                player->LearnSpell(148476, true);		// ThunderingOnyxCloudSerpent
                player->LearnSpell(132036, true);		// ThunderingRubyCloudSerpent
                player->LearnSpell(580, true);		// TimberWolf
                player->LearnSpell(60002, true);		// Time-LostProto-Drake
                player->LearnSpell(171617, true);		// TrainedIcehoof
                player->LearnSpell(171623, true);		// TrainedMeadowstomper
                player->LearnSpell(171638, true);		// TrainedRiverwallow
                player->LearnSpell(171637, true);		// TrainedRocktusk
                player->LearnSpell(171831, true);		// TrainedSilverpelt
                player->LearnSpell(171841, true);		// TrainedSnarler
                player->LearnSpell(61425, true);		// Traveler'sTundraMammoth
                player->LearnSpell(61447, true);		// Traveler'sTundraMammoth
                player->LearnSpell(171619, true);		// TundraIcehoof
                player->LearnSpell(44151, true);		// Turbo-ChargedFlyingMachine
                player->LearnSpell(65642, true);		// Turbostrider
                player->LearnSpell(10796, true);		// TurquoiseRaptor
                player->LearnSpell(59571, true);		// TwilightDrake
                player->LearnSpell(107844, true);		// TwilightHarbinger
                player->LearnSpell(107203, true);		// Tyrael'sCharger
                player->LearnSpell(148618, true);		// TyrannicalGladiator'sCloudSerpent
                player->LearnSpell(92155, true);		// UltramarineQirajiBattleTank
                player->LearnSpell(17454, true);		// UnpaintedMechanostrider
                player->LearnSpell(75207, true);		// Vashj'irSeahorse
                player->LearnSpell(49193, true);		// VengefulNetherDrake
                player->LearnSpell(64659, true);		// VenomhideRavasaur
                player->LearnSpell(41517, true);		// VeridianNetherwingDrake
                player->LearnSpell(101282, true);		// ViciousGladiator'sTwilightDrake
                player->LearnSpell(146622, true);		// ViciousSkeletalWarhorse
                player->LearnSpell(185052, true);		// ViciousWarKodo
                player->LearnSpell(183889, true);		// ViciousWarMechanostrider
                player->LearnSpell(171834, true);		// ViciousWarRam
                player->LearnSpell(171835, true);		// ViciousWarRaptor
                player->LearnSpell(100332, true);		// ViciousWarSteed
                player->LearnSpell(100333, true);		// ViciousWarWolf
                player->LearnSpell(146615, true);		// ViciousWarsaber
                player->LearnSpell(41518, true);		// VioletNetherwingDrake
                player->LearnSpell(132119, true);		// VioletPandarenPhoenix
                player->LearnSpell(60024, true);		// VioletProto-Drake
                player->LearnSpell(10799, true);		// VioletRaptor
                player->LearnSpell(88746, true);		// VitreousStoneDrake
                player->LearnSpell(179478, true);		// VoidtalonoftheDarkStar
                player->LearnSpell(88331, true);		// VolcanicStoneDrake
                player->LearnSpell(163024, true);		// WarforgedNightmare
                player->LearnSpell(171845, true);		// Warlord'sDeathwheel
                player->LearnSpell(189044, true);		// WarmongeringGladiator'sFelbloodGronnling
                player->LearnSpell(171837, true);		// WarsongDirefang
                player->LearnSpell(64657, true);		// WhiteKodo
                player->LearnSpell(15779, true);		// WhiteMechanostriderModB
                player->LearnSpell(54753, true);		// WhitePolarBear
                player->LearnSpell(6898, true);		// WhiteRam
                player->LearnSpell(102488, true);		// WhiteRidingCamel
                player->LearnSpell(130137, true);		// WhiteRidingGoat
                player->LearnSpell(39319, true);		// WhiteRidingTalbuk
                player->LearnSpell(123182, true);		// WhiteRidingYak
                player->LearnSpell(65645, true);		// WhiteSkeletalWarhorse
                player->LearnSpell(16083, true);		// WhiteStallion
                player->LearnSpell(34897, true);		// WhiteWarTalbuk
                player->LearnSpell(189043, true);		// WildGladiator'sFelbloodGronnling
                player->LearnSpell(171633, true);		// WildGoretusk
                player->LearnSpell(98727, true);		// WingedGuardian
                player->LearnSpell(54729, true);		// WingedSteedoftheEbonBlade
                player->LearnSpell(17229, true);		// WinterspringFrostsaber
                player->LearnSpell(171616, true);		// WitherhideCliffstomper
                player->LearnSpell(59791, true);		// WoolyMammoth
                player->LearnSpell(59793, true);		// WoolyMammoth
                player->LearnSpell(74918, true);		// WoolyWhiteRhino
                player->LearnSpell(71810, true);		// WrathfulGladiator'sFrostWyrm
                player->LearnSpell(46197, true);		// X-51Nether-Rocket
                player->LearnSpell(46199, true);		// X-51Nether-RocketX-TREME
                player->LearnSpell(75973, true);		// X-53TouringRocket
                player->LearnSpell(26055, true);		// YellowQirajiBattleTank

                // Goodbye
                CloseGossipMenuFor(player);
                return true;
        }
    };

    // CREATURE AI
    CreatureAI* GetAI(Creature* creature) const override
    {
        return new NPC_PassiveAI(creature);
    }
};

void AddAllMountsNPCScripts()
{
    new AllMountsAnnounce();
    new AllMountsNPC();
}
