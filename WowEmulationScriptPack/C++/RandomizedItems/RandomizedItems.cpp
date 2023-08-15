#include "DatabaseEnv.h"
#include "ChannelMgr.h"
#include "Channel.h"
#include "ScriptMgr.h"
#include "Player.h"
#include "World.h"
#include "Chat.h"
#include "GameEventCallbacks.h"
#include "ObjectExtension.cpp"
#include "worldSession.h"
#include "GameTime.h"
#include <string.h>
#include "Item.h"
#include "ScriptSettings/ScriptSettingsAPI.h"
#include "SpellMgr.h"

#include "RI_ItemStore.h"
#include "RI_PlayerStore.h"
#include "RI_AddonUpdater.h"
#include "RI_CreatureScaleScripts.h"
#include "RI_HoradricCube.h"
#include "RI_AutomatedTesting.h"

#include "AddonCommunication/AddonCommunication.h"

namespace RandomizedItems
{

    void QuerySingleStatValue(Player *PacketSender, int StatQueried)
    {
        PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
        RI_PlayerStore *ps = GetPlayerRIStore(PacketSender);
        float replp = ps->GetTotalStat(StatQueried);
        if (replp == 0.0f)
            return;
        char repl[500];
        if (RI_PickableStats[StatQueried].FixedValue != 0)
            sprintf_s(repl, sizeof(repl), "%d %02f %d", StatQueried, 1.0f, (int)replp);
        else
            sprintf_s(repl, sizeof(repl), "%d %02f %d", StatQueried, replp, 1);
        AddonComm::SendMessageToClient(PacketSender, "RIQS", repl);
    }

    void QuerySingleStatValue(Player *PacketSender, const char *msg)
    {
        int StatQueried;
        sscanf(msg, "%d", &StatQueried);
        QuerySingleStatValue(PacketSender, StatQueried);
    }

    void QueryAllStatValues(Player *PacketSender, const char *msg)
    {
        for (int StatQueried = 0; StatQueried < RI_MAX_STAT_TYPES; StatQueried++)
            QuerySingleStatValue(PacketSender, StatQueried);
    }

    void QueryBagItemStats(Player *PacketSender, const char *msg)
    {
        int TransactionID;
        int InventoryIndex;
        int BagIndex;
        int BagSlotIndex;
        int InspectInventoryIndex;
        int TradeSlotIndex;
        sscanf(msg, "%d %d %d %d %d %d", &TransactionID, &InventoryIndex, &BagIndex, &BagSlotIndex, &InspectInventoryIndex, &TradeSlotIndex);

        //printf("Extracted query params : %d %d %d %d %d\n", TransactionID, InventoryIndex, BagIndex, BagSlotIndex, InspectInventoryIndex);
        HandleQuery(PacketSender, InventoryIndex, BagIndex, BagSlotIndex, InspectInventoryIndex, TransactionID, TradeSlotIndex);
    }
}

void PlayerReviveForceReapplyStats(void *p, void *)
{
    Player *player = (Player*)p;
    GetPlayerRIStore(player)->OnPlayerRevive();
}

class TC_GAME_API RandomizedItemLoaderScript : public PlayerScript
{
public:
    RandomizedItemLoaderScript() : PlayerScript("RandomizedItemLoaderScript") {}
    void OnLogin(Player* player, bool firstLogin)
    {
        GetPlayerRIStore(player)->OnPlayerLoginFinished(player);
        player->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_REVIVE, PlayerReviveForceReapplyStats);
    }

    // Called when a player logs out.
    void OnLogout(Player* player)
    {
        GetPlayerRIStore(player)->OnPlayerLogout(player);
    }

    void OnDelete(ObjectGuid guid, uint32 accountId)
    {
        char Query[5000];
        sprintf_s(Query, sizeof(Query), "delete from character_item_randomizations where PlayerGUID=%u", guid.GetCounter());
        CharacterDatabase.Execute(Query);
        sprintf_s(Query, sizeof(Query), "delete from character_IR_params where PlayerGUID=%u", guid.GetCounter());
        CharacterDatabase.Execute(Query);
        sprintf_s(Query, sizeof(Query), "delete from character_IR_sacrifice where PlayerGUID=%u", guid.GetCounter());
        CharacterDatabase.Execute(Query);
    }
};

void AddRandomizedItemsScripts()
{
    //only load this server addon if config file said so
    if (sWorld->getIntConfig(CONFIG_RANDOMIZED_INSTANCE_ITEMS) == 0)
        return;
    //monitor when to load/save/delete item extra data 
    new RandomizedItemLoaderScript();
	//register listner that will push messages to DB
    RegisterCallbackFunction(CALLBACK_TYPE_PLAYER_ITEM_EQUIP, RI_ApplyRandomStatsOnItemChange, NULL);
    RegisterCallbackFunction(CALLBACK_TYPE_PLAYER_ITEM_STORED, RI_AnyItemReceived, NULL); //just for debugging purpuses !
    RegisterCallbackFunction(CALLBACK_TYPE_SAVE_ITEM, RI_ItemSaved, NULL); 
    RegisterCallbackFunction(CALLBACK_TYPE_DELETE_ITEM, RI_ItemDeleted, NULL); 
    RegisterCallbackFunction(CALLBACK_TYPE_SELL_ITEM, RI_ItemSold, NULL);

    AddonComm::RegisterOpcodeHandler("RIQS", RandomizedItems::QuerySingleStatValue);
    AddonComm::RegisterOpcodeHandler("RIQA", RandomizedItems::QueryAllStatValues);
    AddonComm::RegisterOpcodeHandler("RIV ", OnAddonVersionReport);
    AddonComm::RegisterOpcodeHandler("RI  ", RandomizedItems::QueryBagItemStats);
    AddonComm::RegisterOpcodeHandler("RIC ", ParseCubeMessage);

    GenerateRandomRollFormatStrings();
    RI_RegisterMapHandleScritps();

    //hack this spell to split dmg between targets
    //6295 - Fiery Enchantment
    SpellInfo *spellEntry = (SpellInfo *)sSpellMgr->GetSpellInfo(6295);
    spellEntry->AttributesCu |= SPELL_ATTR0_CU_SHARE_DAMAGE;

    LoadAutomatedTestingScript();
/*
CREATE TABLE `character_IR_params` (
`PlayerGUID` int(20) unsigned NOT NULL,
`MagicDust` int(20) unsigned NOT NULL,
`MagicFindBuffStrength` int(11) DEFAULT NULL,
`MagicFindBuffDuration` int(11) DEFAULT NULL,
`MagicPowerBuffStrength` int(11) DEFAULT NULL,
`MagicPowerBuffDuration` int(11) DEFAULT NULL,
`MagicFindNoInstanceBuffStrength` int(11) DEFAULT NULL,
`MagicFindNoInstanceBuffDuration` int(11) DEFAULT NULL,
`MagicPowerNoInstanceBuffStrength` int(11) DEFAULT NULL,
`MagicPowerNoInstanceBuffDuration` int(11) DEFAULT NULL,
`AttackStatRollChance` int(11) DEFAULT NULL,
`AttackStatRollChanceDur` int(11) DEFAULT NULL,
`DefenseStatRollChance` int(11) DEFAULT NULL,
`DefenseStatRollChanceDur` int(11) DEFAULT NULL,
`UtilStatRollChance` int(11) DEFAULT NULL,
`UtilStatRollChanceDur` int(11) DEFAULT NULL,
`StatRollChance` int(11) DEFAULT NULL,
`StatRollChanceDur` int(11) DEFAULT NULL,
INDEX `Index1` (`PlayerGUID`),
UNIQUE KEY `UniquePair` (`PlayerGUID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `character_IR_sacrifice` (
`PlayerGUID` int(20) unsigned NOT NULL,
`statType` int(20) unsigned NOT NULL,
`chance` int(11) DEFAULT NULL,
INDEX `Index1` (`PlayerGUID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `character_item_randomizations` (
`PlayerGUID` int(20) unsigned NOT NULL,
`ItemGUID` int(20) unsigned NOT NULL,
`t1` int(11) DEFAULT NULL,
`p1` float DEFAULT NULL,
`t2` int(11) DEFAULT NULL,
`p2` float DEFAULT NULL,
`t3` int(11) DEFAULT NULL,
`p3` float DEFAULT NULL,
`t4` int(11) DEFAULT NULL,
`p4` float DEFAULT NULL,
`t5` int(11) DEFAULT NULL,
`p5` float DEFAULT NULL,
`t6` int(11) DEFAULT NULL,
`p6` float DEFAULT NULL,
`t7` int(11) DEFAULT NULL,
`p7` float DEFAULT NULL,
`t8` int(11) DEFAULT NULL,
`p8` float DEFAULT NULL,
`t9` int(11) DEFAULT NULL,
`p9` float DEFAULT NULL,
`t10` int(11) DEFAULT NULL,
`p10` float DEFAULT NULL,
`t11` int(11) DEFAULT NULL,
`p11` float DEFAULT NULL,
`t12` int(11) DEFAULT NULL,
`p12` float DEFAULT NULL,
`t13` int(11) DEFAULT NULL,
`p13` float DEFAULT NULL,
`t14` int(11) DEFAULT NULL,
`p14` float DEFAULT NULL,
`t15` int(11) DEFAULT NULL,
`p15` float DEFAULT NULL,
INDEX `Index1` (`PlayerGUID`,`ItemGUID`),
UNIQUE KEY `UniquePair` (`PlayerGUID`,`ItemGUID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
ALTER TABLE character_item_randomizations ADD CONSTRAINT PK_1 PRIMARY KEY (PlayerGUID, ItemGUID);

insert into `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) values('123470','0','0','0','0','0','29524','0','0','0','Sacrifice for prayers','Bless the RNG','','0','80','80','0','35','129','1','1.14286','1','0','0','0','0','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','3','1','1','1','1','1','0','0','1','0','0','0','','0');
INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`) VALUES('123470','159','5');
insert into `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) values('123471','0','0','0','0','0','29524','0','0','0','Sacrifice for curses','Hate the RNG','','0','80','80','0','35','129','1','1.14286','1','0','0','0','0','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','3','1','1','1','1','1','0','0','1','0','0','0','','0');
INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`) VALUES('123471','159','5');

*/
}
