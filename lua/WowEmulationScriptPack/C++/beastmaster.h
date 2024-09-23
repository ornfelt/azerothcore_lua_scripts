enum ePets
{
    PET_BAT             = 16173,
    PET_BIRD            = 21042,
    PET_BOAR            = 26020,
    PET_CAT             = 20671,
    PET_DRAGON_HAWK     = 26024,
    PET_GORILLA         = 9622,
    PET_OWL             = 17129,
    PET_RAPTOR          = 20634,
    PET_RAVAGER         = 23326,
    PET_SCORPID         = 21864,
    PET_SERPENT         = 26032,
    PET_TURTLE          = 2408,
    PET_WARP_CHASER     = 23219,
    PET_WIND_SERPENT    = 21123,
    PET_WOLF            = 20058,
};

#define GOSSIP_TEXT_BAT             "Tame a Bat"
#define GOSSIP_TEXT_BOAR            "Tame a Boar"
#define GOSSIP_TEXT_BIRD            "Tame a Carrion Bird"
#define GOSSIP_TEXT_CAT             "Tame a Cat"
#define GOSSIP_TEXT_DRAGONHAWK      "Tame a Dragonhawk"
#define GOSSIP_TEXT_GORILLA         "Tame a Gorilla"
#define GOSSIP_TEXT_OWL             "Tame an Owl"
#define GOSSIP_TEXT_RAPTOR          "Tame a Raptor"
#define GOSSIP_TEXT_RAVAGER         "Tame a Ravager"
#define GOSSIP_TEXT_SCORPID         "Tame a Scorpid"
#define GOSSIP_TEXT_SERPENT         "Tame a Serpent"
#define GOSSIP_TEXT_TURTLE          "Tame a Turtle"
#define GOSSIP_TEXT_WARPCHASER      "Tame a Warp Chaser"
#define GOSSIP_TEXT_W_SERPENT       "Tame a Wind Serpent"
#define GOSSIP_TEXT_WOLF            "Tame a Wolf"
// 15 total

void CreatePet(Player* player, Creature* creature, uint32 entry);
bool GossipSelect_beastmaster(Player* player, Creature* creature, uint32 sender, uint32 action);
