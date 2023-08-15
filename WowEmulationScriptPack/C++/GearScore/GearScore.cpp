#include "Player.h""
#include "Item.h"
#include "ItemTemplate.h"
#include "DBCStructure.h"
#include "DBCStores.h"
#include "ObjectMgr.h"
#include "DatabaseEnv.h"
#include "ScriptMgr.h"

int GetGearScore(Player *player)
{
    int sum = 0;
    for (int i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; ++i)
    {
        // don't check tabard, ranged, offhand or shirt
        const Item *it = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (it == NULL)
            continue;
        const ItemTemplate *itt = it->GetTemplate();
        if (itt)
            sum += (int)itt->GetItemLevelIncludingQuality();
    }
    return sum;
}

int GetGearGemScore(Player *player)
{
    int sum = 0;
    for (int i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; ++i)
    {
        // don't check tabard, ranged, offhand or shirt
        const Item *it = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (it == NULL)
            continue;
        EnchantmentSlot SlotsToInspect[] = { SOCK_ENCHANTMENT_SLOT, SOCK_ENCHANTMENT_SLOT_2, SOCK_ENCHANTMENT_SLOT_3, PRISMATIC_ENCHANTMENT_SLOT };
        for (int j = 0; j < _countof(SlotsToInspect); j++)
        {
            uint32 EnchantId = it->GetEnchantmentId(SlotsToInspect[j]);
            if (EnchantId == 0)
                continue;
            SpellItemEnchantmentEntry const* pEnchant = sSpellItemEnchantmentStore.LookupEntry(EnchantId);
            if (!pEnchant || pEnchant->GemID == 0)
                continue;
            ItemTemplate const* gemProto = sObjectMgr->GetItemTemplate(pEnchant->GemID);
            if (gemProto == NULL)
                continue;
            sum += gemProto->ItemLevel;
        }
    }
    return sum;
}

int GetGearRandomSuffixScore(Player *player)
{
    int sum = 0;
    for (int i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; ++i)
    {
        // don't check tabard, ranged, offhand or shirt
        const Item *it = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (it == NULL)
            continue;
        EnchantmentSlot SlotsToInspect[] = { PROP_ENCHANTMENT_SLOT_0, PROP_ENCHANTMENT_SLOT_1, PROP_ENCHANTMENT_SLOT_2, PROP_ENCHANTMENT_SLOT_3, PROP_ENCHANTMENT_SLOT_4 };
        for (int j = 0; j < _countof(SlotsToInspect); j++)
        {
            uint32 EnchantId = it->GetEnchantmentId(SlotsToInspect[j]);
            if (EnchantId == 0)
                continue;
            sum += 40;
        }
    }
    return sum;
}

int GetGlyphScore(Player *player)
{
    int sum = 0;
    for (uint8 i = 0; i < MAX_GLYPH_SLOT_INDEX; ++i)
    {
        if (player->GetGlyph(i) != 0)
            sum += 40;
    }
    return sum;
}

int GetProfessionScore(Player *player)
{
    int sum = 0;
    int SkillsToInspect[] = { SKILL_SKINNING,SKILL_FISHING,SKILL_COOKING,SKILL_FIRST_AID,SKILL_INSCRIPTION,SKILL_ENCHANTING,SKILL_TAILORING,SKILL_ENGINEERING,SKILL_JEWELCRAFTING,SKILL_ALCHEMY,SKILL_BLACKSMITHING,SKILL_HERBALISM,SKILL_LEATHERWORKING,SKILL_MINING,SKILL_JEWELCRAFTING };
    for (uint8 i = 0; i < _countof(SkillsToInspect); ++i)
    {
        uint32 CurSkillValue = player->GetSkillValue(SkillsToInspect[i]);
        float PercentDone = CurSkillValue / 80.0f * 5.0f;
        sum += int( 40 * PercentDone );
    }
    return sum;
}

int GetPlayerScore(Player *p)
{
    int SumOfScores = 0;
    // simple gearscore
    SumOfScores += GetGearScore(p);
    // count gems inside items
    SumOfScores += GetGearGemScore(p);
    // count enchantments on items
    // count random suffixes on item
    SumOfScores += GetGearRandomSuffixScore(p);
    // count inscriptions done ( glyphs )
    SumOfScores += GetGlyphScore(p);
    // skill score
    SumOfScores += GetProfessionScore(p);
    // hardcore is hard, let's add a leveling score also
    SumOfScores += 40 * p->getLevel() / DEFAULT_MAX_LEVEL; // 40 points if reached max level
    // add score based on ranked standing ? Not everyone has an arena team
    // endurance is a big challange for hardcore players
    // number of quests done
    // number of spells learned ( recepies from drops are not easy for HC )
    return SumOfScores;
}

void GearScoreOnItemChange(void *p, void *)
{
    CP_ITEM_EQUIPPED *params = PointerCast(CP_ITEM_EQUIPPED, p);
    if (params->Owner == NULL)
        return;
    int ScoreNow = GetPlayerScore(params->Owner);
    char Query[5000];
    sprintf_s(Query, sizeof(Query), "INSERT INTO character_GearScore(GUID, ItemScore) VALUES(%d,%d) ON DUPLICATE KEY UPDATE ItemScore = IF(ItemScore>%d,ItemScore,%d)",
        (uint32)params->Owner->GetGUID().GetRawValue(), (uint32)ScoreNow, (uint32)ScoreNow, (uint32)ScoreNow);
    CharacterDatabase.Execute(Query);
}

class TC_GAME_API GearScoreRegisterScript : public PlayerScript
{
public:
    GearScoreRegisterScript() : PlayerScript("GearScoreRegisterScript") {}

    void OnDelete(ObjectGuid guid, uint32 accountId)
    {
        char Query[5000];
        sprintf_s(Query, sizeof(Query), "delete from character_GearScore where GUID=%d", (uint32)guid.GetRawValue());
        CharacterDatabase.Execute(Query);
    }
};

void AddGearScoreScripts()
{
    return; //disabling this cause i have no idea if it ever got tested
/*
CREATE TABLE IF NOT EXISTS `character_GearScore` (
`GUID` int(11) NOT NULL,
`ItemScore` int(11) DEFAULT NULL,
UNIQUE KEY `relation` (`GUID`),
KEY `RowUniqueId` (`GUID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
*/
    new GearScoreRegisterScript();
    RegisterCallbackFunction(CALLBACK_TYPE_PLAYER_ITEM_EQUIP, GearScoreOnItemChange, NULL);
}
