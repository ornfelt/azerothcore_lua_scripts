#include "Common.h"
#include "Map.h"
#include "HungerGamesStore.h"
#include "World.h"

void HGInitGurubashi()
{
//    return;
    //create a new store
    HungerGameStore *HG = new HungerGameStore();
    HG->SetName("Gurubashi Arena");
    HG->SetCenter(0, -13204, 272, 22, sWorld->getFloatConfig(CONFIG_HUNGER_GAMES_RADIUS));
    HG->SetKickTo(530, -1909, 5520, -12.428010f);
    HG->SetZoneAreaBind(33, 2177);  // the gurubashi arena
    HG->SetMinMaxPlayers(7, 15);    // max player count should be limited to spawn locations
    HG->SetWinCreditReward(50);
#ifdef _DEBUG
    HG->SetMinMaxPlayers(2, 15);    // max player count should be limited to spawn locations
#endif

    // add door to block players comming in / leaving mid fight
    HG->AddTempObjectSpawn(new ObjectsSpawnStore(194323, -13243.0f, 198.0f, 30.0f, 1.12f));

    //will pick a random position from this list to spawn a new chest every X period
    HG->SetChestSpawnPeriod(30); //spawn a chest every X seconds
    HG->SetMaxActiveChests(3); //number of maximum chests at a time. Limit this to something smaller than max chest spawn locations
    HG->AddChestSpawnLocation(new ObjectsSpawnStore(5, -13205.5f, 269.2f, 21.8f, 1.05f));
    HG->AddChestSpawnLocation(new ObjectsSpawnStore(5, -13168.0f, 295.0f, 22.0f, 3.56f));
    HG->AddChestSpawnLocation(new ObjectsSpawnStore(5, -13206.0f, 315.0f, 22.0f, 4.96f));
    HG->AddChestSpawnLocation(new ObjectsSpawnStore(5, -13245.0f, 288.0f, 22.0f, 5.99f));
    HG->AddChestSpawnLocation(new ObjectsSpawnStore(5, -13222.0f, 239.0f, 22.0f, 1.46f));
    HG->AddChestSpawnLocation(new ObjectsSpawnStore(5, -13168.0f, 295.0f, 22.0f, 3.56f));
    HG->AddChestSpawnLocation(new ObjectsSpawnStore(5, -13168.0f, 249.0f, 22.0f, 2.55f));

    // list of locations where players will be teleported to
    HG->AddPlayerSpawnLocation(new Position(-13208.39f, 266.14f, 22.86f, 4.05f));
    HG->AddPlayerSpawnLocation(new Position(-13185.88f, 313.41f, 22.86f, 4.12f));
    HG->AddPlayerSpawnLocation(new Position(-13237.90f, 250.24f, 22.86f, 0.50f));
    HG->AddPlayerSpawnLocation(new Position(-13172.54f, 304.15f, 22.86f, 3.63f));
    HG->AddPlayerSpawnLocation(new Position(-13206.69f, 233.23f, 22.86f, 1.30f));
    HG->AddPlayerSpawnLocation(new Position(-13215.65f, 316.85f, 22.86f, 4.57f));
    HG->AddPlayerSpawnLocation(new Position(-13219.80f, 235.41f, 22.86f, 1.18f));
    HG->AddPlayerSpawnLocation(new Position(-13164.43f, 292.45f, 22.86f, 3.39f));
    HG->AddPlayerSpawnLocation(new Position(-13232.22f, 308.55f, 22.86f, 5.15f));
    HG->AddPlayerSpawnLocation(new Position(-13185.22f, 231.96f, 22.86f, 1.89f));
    HG->AddPlayerSpawnLocation(new Position(-13200.10f, 318.06f, 22.86f, 4.43f));
    HG->AddPlayerSpawnLocation(new Position(-13249.99f, 264.95f, 22.86f, 0.13f));
    HG->AddPlayerSpawnLocation(new Position(-13163.33f, 255.08f, 22.86f, 2.64f));
    HG->AddPlayerSpawnLocation(new Position(-13244.78f, 295.07f, 22.86f, 5.51f));
    HG->AddPlayerSpawnLocation(new Position(-13171.58f, 242.01f, 22.86f, 2.17f));
    HG->AddPlayerSpawnLocation(new Position(-13160.30f, 273.83f, 22.86f, 2.96f));
    HG->AddPlayerSpawnLocation(new Position(-13249.80f, 281.76f, 22.86f, 5.91f));

    // add startup items to players. Rogue needs a dagger in order ot use spells...
    HG->AddPlayerStartItem(35);
    HG->AddPlayerStartItem(2092);
    HG->AddPlayerStartItem(2361);
    HG->AddPlayerStartItem(28979);
    HG->AddPlayerStartItem(49778);
    HG->AddPlayerStartItem(50055);

    // when player opens a lootable chest, he will receive one item depending on time interval
    HG->SetProgressiveLootPeriod(3 * 60);

    //gray items
    uint32 PossibleLootMinute3[] = { 33436,33434,33433,33435,33370,33385,33403,33419,33371,33379,33397,33415,33365,33380,33398,33412,33369,33384,33402,33417,33366,33381,33399,33413,33367,33382,33400,33414,33368,33383,33401,33416,6196,30569,33428,3990,33422,3972,33429,33431,39202,33430,33424,23321,33426,33423,33425 };
    for (uint32 i = 0; i < _countof(PossibleLootMinute3); i++)
        HG->AddPossibleItemLoot(0, PossibleLootMinute3[i]);
    //white items
    uint32 PossibleLootMinute6[] = { 3892,42094,3894,8092,6566,15313,6579,2435,42099,30781,30765,3587,42084,2424,30777,2437,42098,2425,8093,2438,42088,2426,8089,3588,42092,2427,30771,2440,42097,30784,8091,41752,30754,30749,40005,30775,41746,4680,43601,2533,43600,40004,2535,2618,30751,2532,40006,44641,15909,39995 };
    for (uint32 i = 0; i < _countof(PossibleLootMinute6); i++)
        HG->AddPossibleItemLoot(1, PossibleLootMinute6[i]);
    //green items
    uint32 PossibleLootMinute9[] = { 36063,36167,36279,36399,36057,36169,36281,36393,24687,36165,36277,36389,36051,36171,36275,36395,36056,36176,36280,36392,36052,36164,36276,36388,36058,36170,36282,36394,36054,36174,36278,36390,36583,36499,36527,36569,44703,36457,36625,36416,36597,36513,36611,36541,36555,36053,15234,36696,29380,29371,36682,25197,36723 };
    for (uint32 i = 0; i < _countof(PossibleLootMinute9); i++)
        HG->AddPossibleItemLoot(2, PossibleLootMinute9[i]);
    //blue items
    uint32 PossibleLootMinute12[] = { 44667,44732,37188,43280,37691,37139,37398,44195,31554,37165,37144,37395,44104,45211,45215,37152,37189,37374,37155,37263,37218,45220,37167,31213,37370,37724,37138,37217,44256,37230,37614,37862,37871,43407,44250,13198,44193,37162,37615,37084,43281,38618,43409,37653,44174,37222,27818,44199,11784,37631,37377,44241,36981 };
    for (uint32 i = 0; i < _countof(PossibleLootMinute12); i++)
        HG->AddPossibleItemLoot(3, PossibleLootMinute12[i]);
    //epic items
    uint32 PossibleLootMinute15[] = { 45497,32088,32085,47677,43074,34391,47706,43068,19439,23564,28484,18809,50707,50993,50991,45488,45536,45844,45134,19438,19144,30768,37361,40738,49787,40735,50984,50982,37623,37363,51516,51520,51522,51518,51533,51395,50466,51389,51391,51481,51393,46033,30762,51454,49128,37693,51398,51526,51446,51448,18848,51528,51535 };
    for (uint32 i = 0; i < _countof(PossibleLootMinute15); i++)
        HG->AddPossibleItemLoot(4, PossibleLootMinute15[i]);

    //register this Hunger game in the list of hunger game definitions
    HungerGameStores.insert(HG);
}
