#include "ScriptMgr.h"
#include "Channel.h"
#include "Group.h"
#include "Guild.h"
#include "Log.h"
#include "Player.h"
#include "CreatureAI.h"
#include "ScriptedGossip.h"
#include "Creature.h"
#include "Player.h"
#include "WorldSession.h"
#include "PassiveAI.h"
#include "ObjectMgr.h"
#include "SpellAuras.h"
#include "DatabaseEnv.h"
#include "DBCStores.h"
#include "ReputationMgr.h"
#include "SpellMgr.h"
#include "ObjectExtension.cpp"
#include "GameTime.h"
#include "AccountMgr.h"
#include "PersonalInstance\PersonalInstance.h"

void AddGossipItemForArcemu(Player* player, uint32 icon, std::string const& text, uint32 MenuId)
{
    player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, icon, text, GOSSIP_SENDER_MAIN, MenuId, "", 0);
}

void AddGossipItemExtended(Player* player, uint32 icon, std::string const& text, uint32 MenuId, std::string const& text2, uint32 money, bool scripted) {
    player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, icon, text, GOSSIP_SENDER_MAIN, MenuId, text2, money, scripted);
}

//forward declaration. This will only work if personal instance scripts get compiled. If not. Remove the taxi menu
void TeleportToPersonalInstanceMapWithChecks(Player *player, int MapId, bool LoadPersonalSpawns);
void SetIronmanHardcoreMode(Player *player, int type);
bool IsIronManPlayer(Player *p);
bool CheckPlayerCanTurnIronManHardcore(Player *player, int type);

class Warper : public CreatureScript
{
public:
    Warper() : CreatureScript("WarpNPC") { }

    struct WarperAI : public CreatureAI
    {
        WarperAI(Creature* creature) : CreatureAI(creature)
        {
        }
        //does nothing unless we say so
        void UpdateAI(uint32 diff) override
        {
        }
        bool GossipHello(Player* /*player*/);
        bool GossipSelect(Player* /*player*/, uint32 /*menuId*/, uint32 /*gossipListId*/);
        void send_MainPage(Player* Plr);
        void send_GuidePage(Player* Plr, uint32 textId);
        void EventTeleport(Player *Plr, uint32 mapid, float x, float y, float z)
        {
            Plr->TeleportTo(mapid, x, y, z, 0.0f);
        }
        //	void Cast_Reward_auras_on_active_player(Player* Plr);
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
//        printf("We created and AI \n");
        return new WarperAI(creature);
    }
};

#if 0
void Warper::Cast_Reward_auras_on_active_player(Player* Plr)
{
//	return;
	uint32 kill_limits[13] = { 1,100,200,300,400,500,600,700,800,900,1500,3000,6000 };
	//bonus auras : class / auras
	uint32 n_spells[12][17] = 
	{
//		{20217,58451,58452,48104,48102,48100,58449,9885,48161,26035,47430},	//no class 0
		{20217,89345,89346,89347,1126,21562,26035,0,0,0,0,0,0,0,0},	//no class 0
		{0,0,0,0,0,0,0,0,42505,0,0,0,0,0,0,0,0},	//WARRIOR
		{0,0,0,0,0,0,0,0,42505,0,0,0,0,0,0,0,0},	//PALADIN
		{0,0,0,0,0,0,0,0,42505,0,0,0,0,0,0,0,0},	//HUNTER
		{0,0,0,0,0,0,0,0,42505,0,0,0,0,0,0,0,0},	//ROGUE
		{0,0,0,0,0,0,0,0,42505,0,0,0,0,0,0,0,0},	//PRIEST
		{0,0,0,0,0,0,0,0,42505,0,0,0,0,0,0,0,0},	//SHAMAN
		{0,0,0,0,0,0,0,0,42505,0,0,0,0,0,0,0,0},	//MAGE
		{0,0,0,0,0,0,0,0,42505,0,0,0,0,0,0,0,0},	//WARLOCK
		{0,0,0,0,0,0,0,0,42505,0,0,0,0,0,0,0,0},	//no class 10
		{0,0,0,0,0,0,0,0,42505,0,0,0,0,0,0,0,0},	//druid
	};
	uint32 kill_level = 0;
	for(uint32 i=0;i<13;i++)
		if( kill_limits[i] < Plr->GetUInt32Value(PLAYER_FIELD_LIFETIME_HONORBALE_KILLS) )
			kill_level = i;
	
	uint32 clas = Plr->getClass();
	SpellCastTargets targets;
	targets.m_targetMask = TARGET_FLAG_UNIT;
	targets.m_unitTarget = Plr->GetGUID();
	
	for( uint32 i=0;i<kill_level;i++)
	{
		if( n_spells[clas][i] )
		{
			SpellEntry * ent = dbcSpell.LookupEntry(n_spells[clas][i]);
			Spell *newSpell = SpellPool.PooledNew( __FILE__, __LINE__ );
			newSpell->Init(Plr, ent, true, 0);
			newSpell->prepare(&targets);
		}
		if( n_spells[0][i] )
		{
			SpellEntry * ent = dbcSpell.LookupEntry(n_spells[0][i]);
			Spell *newSpell = SpellPool.PooledNew( __FILE__, __LINE__ );
			newSpell->Init(Plr, ent, true, 0);
			newSpell->prepare(&targets);
		}
	}
}
#endif

bool UpdateAccountRank(Player* player, Creature* const me)
{
    int8 RealmID = 1;
    if (player->GetSession()) {
        uint32 AccountId = player->GetSession()->GetAccountId();
        uint8 rank = 0;
        bool found = false;
        char Query[5000];
        sprintf_s(Query, sizeof(Query), "SELECT credits FROM account_credits WHERE AccId=%d LIMIT 1", AccountId);
        QueryResult donationsFound = CharacterDatabase.Query(Query);

        if (!donationsFound)
        {
            me->Whisper(std::string("You need 5000+ total amassed credits to claim a Membership."), LANG_UNIVERSAL, player);
            return false;
        }
        do
        {
            Field* fields = donationsFound->Fetch();
            uint32 credits = fields[0].GetInt32();
            if (credits < 5000) {
                me->Whisper(std::string("You need 5000+ total amassed credits to claim a Membership."), LANG_UNIVERSAL, player);
                return false;
            }

            if (credits >= 5000)
                rank = SEC_BRONZE;
            if (credits >= 10000)
                rank = SEC_SILVER;
            if (credits >= 25000)
                rank = SEC_GOLD;
            if (credits >= 50000)
                rank = SEC_PLATINUM;
            if (credits >= 100000)
                rank = SEC_DIAMOND;

            me->Whisper(std::string("You have " + std::to_string(credits) + " total amassed credits on your account"), LANG_UNIVERSAL, player);
            uint32 currentRank = AccountMgr::GetSecurity(player->GetSession()->GetAccountId(), RealmID);
            if (rank > 0 && currentRank < rank) {
                rbac::RBACData* rbac = player->GetSession()->GetRBACData();
                sAccountMgr->UpdateAccountAccess(rbac, AccountId, rank, RealmID);
                return true;
            }
            else
                return false;
        } while (donationsFound->NextRow());
    }
    else
        return false;
}

bool AddAura(Player* target, uint32 spellId)
{
    if (!target)
        return false;

    if (SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId))
    {
        AuraCreateInfo createInfo(spellInfo, MAX_EFFECT_MASK, target);
        createInfo.SetCaster(target);

        Aura::TryRefreshStackOrCreate(createInfo);
    }
    return true;
}

bool RemoveAura(Player* target, uint32 spellId, bool all = false)
{
    if (!target)
        return false;

    if (all) {
        target->RemoveAllAuras();
        return true;
    }
    target->RemoveAurasDueToSpell(spellId);
    return true;
}

bool CompleteQuest(Player* player, uint32 entry)
{
    Quest const* quest = sObjectMgr->GetQuestTemplate(entry);

    // Add quest items for quests that require items
    for (uint8 x = 0; x < QUEST_ITEM_OBJECTIVES_COUNT; ++x)
    {
        uint32 id = quest->RequiredItemId[x];
        uint32 count = quest->RequiredItemCount[x];
        if (!id || !count)
            continue;

        uint32 curItemCount = player->GetItemCount(id, true);

        ItemPosCountVec dest;
        uint8 msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, id, count - curItemCount);
        if (msg == EQUIP_ERR_OK)
        {
            Item* item = player->StoreNewItem(dest, id, true);
            player->SendNewItem(item, count - curItemCount, true, false);
        }
    }

    // All creature/GO slain/cast (not required, but otherwise it will display "Creature slain 0/10")
    for (uint8 i = 0; i < QUEST_OBJECTIVES_COUNT; ++i)
    {
        int32 creature = quest->RequiredNpcOrGo[i];
        uint32 creatureCount = quest->RequiredNpcOrGoCount[i];

        if (creature > 0)
        {
            if (CreatureTemplate const* creatureInfo = sObjectMgr->GetCreatureTemplate(creature))
                for (uint16 z = 0; z < creatureCount; ++z)
                    player->KilledMonster(creatureInfo, ObjectGuid::Empty);
        }
        else if (creature < 0)
            for (uint16 z = 0; z < creatureCount; ++z)
                player->KillCreditGO(creature);
    }

    // If the quest requires reputation to complete
    if (uint32 repFaction = quest->GetRepObjectiveFaction())
    {
        uint32 repValue = quest->GetRepObjectiveValue();
        uint32 curRep = player->GetReputationMgr().GetReputation(repFaction);
        if (curRep < repValue)
            if (FactionEntry const* factionEntry = sFactionStore.LookupEntry(repFaction))
                player->GetReputationMgr().SetReputation(factionEntry, repValue);
    }

    // If the quest requires a SECOND reputation to complete
    if (uint32 repFaction = quest->GetRepObjectiveFaction2())
    {
        uint32 repValue2 = quest->GetRepObjectiveValue2();
        uint32 curRep = player->GetReputationMgr().GetReputation(repFaction);
        if (curRep < repValue2)
            if (FactionEntry const* factionEntry = sFactionStore.LookupEntry(repFaction))
                player->GetReputationMgr().SetReputation(factionEntry, repValue2);
    }

    // If the quest requires money
    int32 ReqOrRewMoney = quest->GetRewOrReqMoney();
    if (ReqOrRewMoney < 0)
        player->ModifyMoney(-ReqOrRewMoney);

    player->CompleteQuest(entry);
    return true;
}

void LearnSkillProfession(Player* Plr, uint32 skillId) {
    uint32 classmask = Plr->getClassMask();
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
        if (!spellInfo || !SpellMgr::IsSpellValid(spellInfo, Plr, false))
            continue;

        Plr->LearnSpell(skillLine->spellId, false);
    }
    uint16 maxLevel = Plr->GetPureMaxSkillValue(skillId);
    Plr->SetSkill(skillId, Plr->GetSkillStep(skillId), maxLevel, maxLevel);
}

bool GiveFreeStart(Player* Plr, bool FreeStuff, bool LevelUp)
{
    CloseGossipMenuFor(Plr);

    if (LevelUp) { //Just for Normal Instant 80 players

        if (Plr->getLevel() < 80) {
            Plr->GiveLevel(80);
            Plr->InitTalentForLevel();
            Plr->SetUInt32Value(PLAYER_XP, 0);

            //fix DK talents only 25
            if (Plr->getClass() == CLASS_DEATH_KNIGHT) {
                Quest const* quest_ally = sObjectMgr->GetQuestTemplate(13188);
                Quest const* quest_horde = sObjectMgr->GetQuestTemplate(13188);
                if (Plr->GetTeam() == ALLIANCE && Plr->CanAddQuest(quest_ally, true)) {
                    Plr->AddQuestAndCheckCompletion(quest_ally, nullptr);
                    CompleteQuest(Plr, 13188);
                    Plr->RewardQuest(quest_ally, 0, Plr);
                    Plr->ResetTalents(true);
                    Plr->SendTalentsInfoData(false);
                }
                if (Plr->GetTeam() == HORDE && Plr->CanAddQuest(quest_horde, true)) {
                    Plr->AddQuestAndCheckCompletion(quest_horde, nullptr);
                    CompleteQuest(Plr, 13189);
                    Plr->RewardQuest(quest_horde, 0, Plr);
                    Plr->ResetTalents(true);
                    Plr->SendTalentsInfoData(false);
                }
            }
        }
    }

    if(FreeStuff)
    {
        for (uint32 i = INVENTORY_SLOT_BAG_START; i <= (INVENTORY_SLOT_BAG_END - 1); i++) {
            if (!Plr->GetBagByPos(i)) {
                Plr->EquipNewItem(i, 3914, true);
            }
        }

        LearnSkillProfession(Plr, SKILL_RIDING);
        Plr->SetSkill(SKILL_RIDING, 300, 300, 300);
        Plr->AddItem(49284, 1);
        Plr->AddItem(43516, 1);
        Plr->AddItem(34518, 1); // companion for the companion menu
    }

    //learn missing spells
    if (Plr->getClass() == CLASS_WARRIOR)
    {
        Plr->LearnSpell(750, false);		//Plate Proficiencies
        Plr->LearnSpell(8737, false);		//Mail Proficiencies
        Plr->LearnSpell(9077, false);		//Leather Proficiencies
        Plr->LearnSpell(9116, false);		//Shield Proficiencies
        Plr->LearnSpell(202, false);		//Two-Handed Swords Proficiencies
        Plr->LearnSpell(199, false);		//Two-Handed Maces Proficiencies
        Plr->LearnSpell(197, false);		//Two-Handed Axes Proficiencies
        Plr->LearnSpell(227, false);		//Staves Proficiencies
        Plr->LearnSpell(3018, false);		//Shoot Proficiencies
        Plr->LearnSpell(200, false);		//Polearms Proficiencies
        Plr->LearnSpell(201, false);		//One-Handed Swords Proficiencies
        Plr->LearnSpell(198, false);		//One-Handed Maces Proficiencies
        Plr->LearnSpell(196, false);		//One-Handed Axes Proficiencies
        Plr->LearnSpell(266, false);		//Guns Proficiencies
        Plr->LearnSpell(15590, false);		//Fist Weapons Proficiencies
        Plr->LearnSpell(1180, false);		//Daggers Proficiencies
        Plr->LearnSpell(5011, false);		//Crossbows Proficiencies
        Plr->LearnSpell(264, false);		//Bows Proficiencies

        if (Plr->getLevel() >= 10)
        {
            Plr->LearnSpell(71, false);		//Defensive Stance
            Plr->LearnSpell(7386, false);	//Sunder Armor
            Plr->LearnSpell(355, false);	//Taunt
            Plr->LearnSpell(12678, false);	//Stance Mastery
        }
        if (Plr->getLevel() >= 30)
        {
            Plr->LearnSpell(2458, false);	//Berserker Stance
            Plr->LearnSpell(20252, false);	//Intercept
        }
    }
    else if (Plr->getClass() == CLASS_PALADIN)
    {
        Plr->LearnSpell(750, false);		//Plate Proficiencies
        Plr->LearnSpell(8737, false);		//Mail Proficiencies
        Plr->LearnSpell(9077, false);		//Leather Proficiencies
        Plr->LearnSpell(9116, false);		//Shield Proficiencies
        Plr->LearnSpell(27762, false);		//Relic Proficiencies
        Plr->LearnSpell(202, false);		//Two-Handed Swords Proficiencies
        Plr->LearnSpell(199, false);		//Two-Handed Maces Proficiencies
        Plr->LearnSpell(197, false);		//Two-Handed Axes Proficiencies
        Plr->LearnSpell(200, false);		//Polearms Proficiencies
        Plr->LearnSpell(201, false);		//One-Handed Swords Proficiencies
        Plr->LearnSpell(198, false);		//One-Handed Maces Proficiencies
        Plr->LearnSpell(196, false);		//One-Handed Axes Proficiencies

        if (Plr->getLevel() >= 20)
        {
            Plr->LearnSpell(7328, false);	//Redemption
            Plr->LearnSpell(5502, false);	//Sense Undead
            Plr->LearnSpell(13819, false);	//Warhorse
            Plr->LearnSpell(23214, false);	//Charger
        }

        if (Plr->getLevel() >= 64 && Plr->GetTeam() == ALLIANCE)
            Plr->LearnSpell(31801, false);	//Seal of Vengeance

        if (Plr->getLevel() >= 66 && Plr->GetTeam() == HORDE)
            Plr->LearnSpell(53736, false);	//Seal of Corruption
    }
    else if (Plr->getClass() == CLASS_HUNTER)
    {
        Plr->LearnSpell(8737, false);		//Mail Proficiencies
        Plr->LearnSpell(9077, false);		//Leather Proficiencies
        Plr->LearnSpell(202, false);		//Two-Handed Swords Proficiencies
        Plr->LearnSpell(197, false);		//Two-Handed Axes Proficiencies
        Plr->LearnSpell(227, false);		//Staves Proficiencies
        Plr->LearnSpell(200, false);		//Polearms Proficiencies
        Plr->LearnSpell(201, false);		//One-Handed Swords Proficiencies
        Plr->LearnSpell(196, false);		//One-Handed Axes Proficiencies
        Plr->LearnSpell(266, false);		//Guns Proficiencies
        Plr->LearnSpell(15590, false);		//Fist Weapons Proficiencies
        Plr->LearnSpell(1180, false);		//Daggers Proficiencies
        Plr->LearnSpell(5011, false);		//Crossbows Proficiencies
        Plr->LearnSpell(264, false);		//Bows Proficiencies
        Plr->LearnSpell(674, false);		//dual weild

        if (Plr->getLevel() >= 20)
        {
            Plr->LearnSpell(1515, false);	//Tame Beast
            Plr->LearnSpell(883, false);	//Call Pet
            Plr->LearnSpell(2641, false);	//Dismiss Pet
            Plr->LearnSpell(6991, false);	//Feed Pet
            Plr->LearnSpell(982, false);	//Revive Pet
        }
    }
    else if (Plr->getClass() == CLASS_ROGUE)
    {
        Plr->LearnSpell(9077, false);		//Leather Proficiencies
        Plr->LearnSpell(3018, false);		//Shoot Proficiencies
        Plr->LearnSpell(201, false);		//One-Handed Swords Proficiencies
        Plr->LearnSpell(198, false);		//One-Handed Maces Proficiencies
        Plr->LearnSpell(196, false);		//One-Handed Axes Proficiencies
        Plr->LearnSpell(266, false);		//Guns Proficiencies
        Plr->LearnSpell(15590, false);		//Fist Weapons Proficiencies
        Plr->LearnSpell(1180, false);		//Daggers Proficiencies
        Plr->LearnSpell(5011, false);		//Crossbows Proficiencies
        Plr->LearnSpell(264, false);		//Bows Proficiencies

        if (Plr->getLevel() >= 20)
            Plr->LearnSpell(51722, false);	//dismantle
    }
    else if (Plr->getClass() == CLASS_PRIEST)
    {
        Plr->LearnSpell(5009, false);		//Wands Proficiencies
        Plr->LearnSpell(227, false);		//Staves Proficiencies
        Plr->LearnSpell(5019, false);		//Shoot Proficiencies
        Plr->LearnSpell(198, false);		//One-Handed Maces Proficiencies
        Plr->LearnSpell(1180, false);		//Daggers Proficiencies
        if (Plr->getLevel() >= 20)
        {
            Plr->LearnSpell(2944, false);	//Devouring Plague
            Plr->LearnSpell(6346, false);	//Fear Ward
        }
    }
    else if (Plr->getClass() == CLASS_DEATH_KNIGHT)
    {
        Plr->LearnSpell(48778, false);	//Acherus Deathcharger
        Plr->LearnSpell(53428, false);	//Runeforging
        Plr->LearnSpell(50977, false);	//Death Gate
        Plr->LearnSpell(52665, false);		//Relic Proficiencies
        Plr->LearnSpell(8737, false);		//Mail Proficiencies
        Plr->LearnSpell(9077, false);		//Leather Proficiencies
        Plr->LearnSpell(202, false);		//Two-Handed Swords Proficiencies
        Plr->LearnSpell(199, false);		//Two-Handed Maces Proficiencies
        Plr->LearnSpell(197, false);		//Two-Handed Axes Proficiencies
        Plr->LearnSpell(200, false);		//Polearms Proficiencies
        Plr->LearnSpell(201, false);		//One-Handed Swords Proficiencies
        Plr->LearnSpell(198, false);		//One-Handed Maces Proficiencies
        Plr->LearnSpell(196, false);		//One-Handed Axes Proficiencies
    }
    else if (Plr->getClass() == CLASS_SHAMAN)
    {
        Plr->LearnSpell(8737, false);		//Mail Proficiencies
        Plr->LearnSpell(9077, false);		//Leather Proficiencies
        Plr->LearnSpell(9116, false);		//Shield Proficiencies
        Plr->LearnSpell(27763, false);		//Relic Proficiencies
        Plr->LearnSpell(199, false);		//Two-Handed Maces Proficiencies
        Plr->LearnSpell(197, false);		//Two-Handed Axes Proficiencies
        Plr->LearnSpell(227, false);		//Staves Proficiencies
        Plr->LearnSpell(198, false);		//One-Handed Maces Proficiencies
        Plr->LearnSpell(196, false);		//One-Handed Axes Proficiencies
        Plr->LearnSpell(15590, false);		//Fist Weapons Proficiencies
        Plr->LearnSpell(1180, false);		//Daggers Proficiencies

        if (Plr->getLevel() >= 10)
            Plr->LearnSpell(3599, false);	//Searing Totem
        if (Plr->getLevel() >= 20)
            Plr->LearnSpell(5394, false);	//Healing Stream Totem
        if (Plr->getLevel() >= 4)
            Plr->LearnSpell(8071, false);	//Stoneskin Totem
    }
    else if (Plr->getClass() == CLASS_MAGE)
    {
        Plr->LearnSpell(5009, false);		//Wands Proficiencies
        Plr->LearnSpell(227, false);		//Staves Proficiencies
        Plr->LearnSpell(5019, false);		//Shoot Proficiencies
        Plr->LearnSpell(201, false);		//One-Handed Swords Proficiencies
        Plr->LearnSpell(1180, false);		//Daggers Proficiencies
        if (Plr->getLevel() >= 71)
            Plr->LearnSpell(53140, false);	//Teleport: Dalaran
        if (Plr->getLevel() >= 60)
        {
            Plr->LearnSpell(28272, false);	//Polymorph
        }
    }
    else if (Plr->getClass() == CLASS_WARLOCK)
    {
        Plr->LearnSpell(5009, false);		//Wands Proficiencies
        Plr->LearnSpell(227, false);		//Staves Proficiencies
        Plr->LearnSpell(688, false);		//Summon Imp
        Plr->LearnSpell(5019, false);		//Shoot Proficiencies
        Plr->LearnSpell(201, false);		//One-Handed Swords Proficiencies
        Plr->LearnSpell(1180, false);		//Daggers Proficiencies
        if (Plr->getLevel() >= 10)
            Plr->LearnSpell(697, false);	//Summon Voidwalker
        if (Plr->getLevel() >= 20)
        {
            Plr->LearnSpell(5784, false);	//Felsteed
            Plr->LearnSpell(712, false);	//Summon Succubus
        }
        if (Plr->getLevel() >= 30)
            Plr->LearnSpell(691, false);	//Summon Felhunter
        if (Plr->getLevel() >= 40)
            Plr->LearnSpell(23161, false);	//Dreadsteed
        if (Plr->getLevel() >= 50)
            Plr->LearnSpell(1122, false);	//Inferno
        if (Plr->getLevel() >= 60)
            Plr->LearnSpell(18540, false);	//Ritual of Doom
    }
    else if (Plr->getClass() == CLASS_DRUID)
    {
        Plr->LearnSpell(9077, false);		//Leather Proficiencies
        Plr->LearnSpell(27764, false);		//Relic Proficiencies
        Plr->LearnSpell(199, false);		//Two-Handed Maces Proficiencies
        Plr->LearnSpell(227, false);		//Staves Proficiencies
        Plr->LearnSpell(200, false);		//Polearms Proficiencies
        Plr->LearnSpell(198, false);		//One-Handed Maces Proficiencies
        Plr->LearnSpell(15590, false);		//Fist Weapons Proficiencies
        Plr->LearnSpell(1180, false);		//Daggers Proficiencies
        if (Plr->getLevel() >= 16)
            Plr->LearnSpell(1066, false);	//Aquatic Form
        if (Plr->getLevel() >= 14)
            Plr->LearnSpell(8946, false);	//Cure Poison
        if (Plr->getLevel() >= 10)
        {
            Plr->LearnSpell(5487, false);	//Bear Form
            Plr->LearnSpell(6795, false);	//Growl
            Plr->LearnSpell(6807, false);	//Maul
        }
        if (Plr->getLevel() >= 71)
            Plr->LearnSpell(40120, false);	//Swift Flight Form
        if (Plr->getLevel() >= 85)
        {
            Plr->LearnSpell(88747, false);	//Wild Mushroom
            Plr->LearnSpell(88751, false);	//Wild Mushroom: Detonate
        }
        Plr->SetSkill(SKILL_RIDING, 300, 300, 300);
    }
    if (Plr->getRace() == RACE_TROLL)
    {
        Plr->LearnSpell(26297, false);	//Berserking
        Plr->LearnSpell(20557, false);	//Beast Slaying
        Plr->LearnSpell(26290, false);	//Bow Specialization
    }
    else if (Plr->getRace() == RACE_BLOODELF)
    {
        Plr->RemoveSpell(28734, false, false);	//mana tap
        if (Plr->getClass() == CLASS_DEATH_KNIGHT)
            Plr->LearnSpell(50613, false);	//arcane torrent
        if (Plr->getClass() == CLASS_DEATH_KNIGHT)
            Plr->LearnSpell(50613, false);	//arcane torrent
    }

    Plr->UpdateWeaponsSkillsToMaxSkillsForLevel(); //max skill weapons
    return true;
}

void Warper::WarperAI::send_GuidePage(Player* Plr, uint32 textId)
{
    ClearGossipMenuFor(Plr);
    SendGossipMenuFor(Plr, textId, me->GetGUID());
}

void Warper::WarperAI::send_MainPage(Player* Plr)
{
    if (Plr)
    {
        //note that this check is not 100% sometimes after death events put players in combat and make them get stuck.
        if (Plr->IsInCombat())
        {
            CloseGossipMenuFor(Plr);
            me->Whisper(std::string("You are not allowed to use Taxi while in combat"), LANG_UNIVERSAL, Plr);
            return;
        }
    }

    uint32 playtime = Plr->GetTotalPlayedTime();
    uint32 endtime = 3600 * 2;

    ClearGossipMenuFor(Plr);

    if (Plr->getLevel() == 1 && IsIronManPlayer(Plr) == false && Plr->GetSkillValue(SKILL_RIDING) == 0)
    {
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_TRAINER, "1. NORMAL: Free S5/T7 | Instant Lvl 80 | Regent vendors", 1600);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_TABARD, "2. IRONMAN: Free S6 | Lvl 1 | NO Trade, AH, Mail, Regents", 1601);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_BATTLE, "3. HARDCORE: Free S7 | Solo Ironman > NO Group | Death = GameOver [except in PvP]", 1602);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_TRAINER, "4. NORMAL: Free S5/T7 | Regent vendors", 1603);
        SendGossipMenuFor(Plr, 25, me->GetGUID());
    }
    else
    {
        if (Plr->GetSkillValue(SKILL_RIDING) == 0)
        {
            if (IsIronManPlayer(Plr) == false)
                GiveFreeStart(Plr, true, true);
            else
                GiveFreeStart(Plr, true, false);
        }

        AddGossipItemForArcemu(Plr, GOSSIP_ICON_TRAINER, "ZombieWow Guide", 1700);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_TRAINER, "Skilling Zone", 1300);
        if (Plr->FindMap() && Plr->GetMap()->IsDungeon() == false && Plr->GetMap()->IsBattlegroundOrArena() == false)
            AddGossipItemForArcemu(Plr, GOSSIP_ICON_TAXI, "Personal Instance", 400);
        if (playtime < endtime && IsIronManPlayer(Plr) == false)
        { //free stuff expires

            std::string expires;
            int minutes;
            int hours = (endtime - playtime) / 3600;
            if (hours > 0) {
                minutes = ((endtime - playtime) - (hours * 3600)) / 60;
                expires += std::to_string(hours) + " hour(s) " + std::to_string(minutes) + " min";
            }
            else
            {
                minutes = (endtime - playtime) / 60;
                expires += std::to_string(minutes) + " minutes";
            }

            AddGossipItemForArcemu(Plr, GOSSIP_ICON_DOT, "INFO: Free * Expire in: " + expires, 0);
            AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "* Free PvP Armor (Free S5 in Mall Also)", 1000);
            AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "* Free PvE Armor", 1100);
            AddGossipItemForArcemu(Plr, GOSSIP_ICON_BATTLE, "* Free Weapon", 1200);
        }
        
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_TAXI, "Alliance Cities", 2);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_TAXI, "Horde Cities", 1);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_TRAINER, "Leveling Areas", 1400);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_TAXI, "Dungeons", 28);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_TAXI, "Instances", 29);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_TABARD, "Gurubashi Arena", 21);
        // AddGossipItemForArcemu( Plr, 8, "PvP Temple", 22);
        //	AddGossipItemForArcemu( Plr, 9, "Make This Place Your Home", 95);
        //	AddGossipItemForArcemu( Plr, 10, "Reset Talentpoints", 220);
    //    AddGossipItemForArcemu(Plr, 5, "Players Tools and Fixes", 369);
        //		Menu->AddMenuItem(5, "Advanced Bug Fixes.",0,0,"Are you sure ?",0,0,600);
        AddGossipItemForArcemu(Plr, 11, "Set Instance Dificulty", 401);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_MONEY_BAG, "Claim Rewards & Donations", 1500);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_MONEY_BAG, "Shop & Repair ", 200);

        AddGossipItemForArcemu(Plr, 11, "Remove Resurrection Sickness", 97);
        AddGossipItemForArcemu(Plr, 11, "Complete Active Broken Quests", 96);
        AddGossipItemForArcemu(Plr, 11, "Learn Missing Spells", 94);
        
        if (Plr->GetMapId() == 631)
            AddGossipItemForArcemu(Plr, 11, "ICC - High Overlord Saurfang", 98);
        SendGossipMenuFor(Plr, 9, me->GetGUID());
    }
}

bool Warper::WarperAI::GossipHello( Player* Plr )
{
//	Cast_Reward_auras_on_active_player( Plr );
//	if( AutoSend )
		send_MainPage(Plr);
    return true;
}

std::string SlotName(uint8 slot) {
    if (slot == EQUIPMENT_SLOT_HEAD)
        return "head";
    else if (slot == EQUIPMENT_SLOT_SHOULDERS)
        return "shoulder";
    else if (slot == EQUIPMENT_SLOT_CHEST)
        return "chest";
    else if (slot == EQUIPMENT_SLOT_BODY)
        return "body";
    else if (slot == EQUIPMENT_SLOT_WAIST)
        return "waist";
    else if (slot == EQUIPMENT_SLOT_LEGS)
        return "legs";
    else if (slot == EQUIPMENT_SLOT_FEET)
        return "feet";
    else if (slot == EQUIPMENT_SLOT_HANDS)
        return "hands";
    else if (slot == EQUIPMENT_SLOT_BACK)
        return "back";
    else if (slot == EQUIPMENT_SLOT_MAINHAND)
        return "main";
    else if (slot == EQUIPMENT_SLOT_OFFHAND)
        return "off";
    else if (slot == EQUIPMENT_SLOT_RANGED)
        return "ranged";
    else if (slot == EQUIPMENT_SLOT_TABARD)
        return "tabard";
    else if (slot == EQUIPMENT_SLOT_WRISTS)
        return "wrists";
    else
        return "invalid";
}

void ClaimRewardSQL(uint32 rewardid)
{
    uint32 now = (uint32)GameTime::GetGameTime();
    if (now > 0) {
        char Query[5000];
        sprintf_s(Query, sizeof(Query), "UPDATE shop_rewards SET claimed = 1, dtime=%d WHERE rowid=%d", now, rewardid);
        CharacterDatabase.Execute(Query);
    }
}

void CheckSQLQuestBroken(Player* Plr, Creature* const me) {
    bool found = false;
    char Query[5000];
    sprintf_s(Query, sizeof(Query), "SELECT questId FROM quest_broken");
    QueryResult qeustsFound = CharacterDatabase.Query(Query);

    if (!qeustsFound)
    {
        me->Whisper(std::string("No quests reported yet. Make a report on Discord or on Website."), LANG_UNIVERSAL, Plr);
        return;
    }
    do
    {
        Field* fields = qeustsFound->Fetch();
        uint32 QuestEntry = fields[0].GetInt32();
        Quest const* quest = sObjectMgr->GetQuestTemplate(QuestEntry);
        if (Plr->GetQuestStatus(QuestEntry) != QUEST_STATUS_NONE
            && Plr->GetQuestStatus(QuestEntry) != QUEST_STATUS_COMPLETE
            && Plr->GetQuestStatus(QuestEntry) != QUEST_STATUS_REWARDED
            )
        {
            CompleteQuest(Plr, QuestEntry);
            found = true;
        }
    } while (qeustsFound->NextRow());

    if(!found)
        me->Whisper(std::string("None of your Active quests were found in our bugged list. Make a report on Discord or on Website."), LANG_UNIVERSAL, Plr);
}

int CheckSQLReward(Player* Plr, Creature* const me) {

    if(UpdateAccountRank(Plr, me))
        me->Yell(std::string("Your Account Membership has been updated! Exit game then relog."), LANG_UNIVERSAL, Plr);

    bool fail = false;
    char Query[5000];
    sprintf_s(Query, sizeof(Query), "SELECT rowid, rewardtype, parameter, quantity FROM shop_rewards WHERE claimed = 0 AND guid=%d", (uint32)Plr->GetGUID().GetRawValue());
    QueryResult rewards = CharacterDatabase.Query(Query);

    if (!rewards)
    {
        me->Whisper(std::string("No rewards to claim. Visit our Web Shop on zombiewow.com"), LANG_UNIVERSAL, Plr);
        return 0;
    }
    do
    {
        Field* fields = rewards->Fetch();
        uint32 rewardid = fields[0].GetInt32();
        uint32 rewardtype = fields[1].GetInt32();
        uint32 parameter = fields[2].GetInt32();
        uint32 quantity = fields[3].GetInt32();

        if (rewardtype == 0) { //Basic add item
            if (Plr->AddItem(parameter, quantity))
            {
                ClaimRewardSQL(rewardid);
            }
            else fail = true;
        }
        else if (rewardtype == 1) { //Gold
            if (Plr->ModifyMoney(quantity, true))
            {
                ClaimRewardSQL(rewardid);
            }
            else fail = true;
        }
        else if (rewardtype == 2) { //Profesions & Recipes
            if (parameter == 1) //all
            {
                LearnSkillProfession(Plr, 171);
                LearnSkillProfession(Plr, 164);
                LearnSkillProfession(Plr, 333);
                LearnSkillProfession(Plr, 202);
                LearnSkillProfession(Plr, 182);
                LearnSkillProfession(Plr, 773);
                LearnSkillProfession(Plr, 755);
                LearnSkillProfession(Plr, 165);
                LearnSkillProfession(Plr, 186);
                LearnSkillProfession(Plr, 393);
                LearnSkillProfession(Plr, 197);
            }
            else
                LearnSkillProfession(Plr, parameter);
            ClaimRewardSQL(rewardid);
        }
        else if (rewardtype == 3) { //Reputation
            FactionEntry const* factionEntry = sFactionStore.LookupEntry(parameter);
            if (factionEntry) {
                Plr->GetReputationMgr().SetOneFactionReputation(factionEntry, 42999, false);
                Plr->GetReputationMgr().SendState(Plr->GetReputationMgr().GetState(factionEntry));
                ClaimRewardSQL(rewardid);
            }
        }
        else if (rewardtype == 4) { //Customization
            if (parameter == 1) { //Rename
                Plr->SetAtLoginFlag(AT_LOGIN_RENAME);
            }
            else if(parameter == 2) { //Look
                Plr->SetAtLoginFlag(AT_LOGIN_CUSTOMIZE);
            }
            else if (parameter == 3) { //Change Faction
                Plr->SetAtLoginFlag(AT_LOGIN_CHANGE_FACTION);
            }
            else if (parameter == 4) { //Change Race
                Plr->SetAtLoginFlag(AT_LOGIN_CHANGE_RACE);
            }

            ClaimRewardSQL(rewardid);
            Plr->BroadcastMessage("You must relog to customize your character\n");
        }
        else if (rewardtype == 5) { //Transmog
            if (SlotName((uint8)quantity) != "invalid") { //check if valid slot (quantity = slot for transmog)
                char Query[5000];
                sprintf_s(Query, sizeof(Query), "INSERT IGNORE INTO account_transmog_items(AcctId, ItemId, SlotId) VALUES(%d,%d,%d)", (uint32)Plr->GetSession()->GetAccountId(), (uint32)parameter, (uint32)quantity);
                CharacterDatabase.Execute(Query);

                ClaimRewardSQL(rewardid);
                Plr->BroadcastMessage("Use syntax .xmog %s %d \n", SlotName((uint8)quantity).c_str(), parameter);
            }
            else {
                Plr->BroadcastMessage("Error: Please contact admin regarding reward ID #%d \n", rewardid);
            }
        }
        else if (rewardtype == 6) { //Visual Aura
            AddAura(Plr, parameter);
            ClaimRewardSQL(rewardid);
        }
    } while (rewards->NextRow());

    if (!fail)
        return 1;
    else
        return 2;
}

int sentAll = 0;

bool Warper::WarperAI::GossipSelect(Player* Plr, uint32 Id, uint32 gossipListId)
{
//    printf("Selected menu %d ", gossipListId);
    //can't imagine this getting NULL 
	if( Plr ) 
	{
		//note that this check is not 100% sometimes after death events put players in combat and make them get stuck.
		if( Plr->IsInCombat() )
		{
            CloseGossipMenuFor(Plr);
            me->Whisper(std::string("You are not allowed to use Taxi while in combat"), LANG_UNIVERSAL, Plr);
			return false;
		}
	}

    uint32 const IntId = Plr->PlayerTalkClass->GetGossipOptionAction(gossipListId);
//    printf("Selected menu %d \n", IntId);


switch (IntId)
{
        //main menu
    case 99:
    case 0:
        send_MainPage(Plr);
        break; //main
    case 28:
    {
        ClearGossipMenuFor(Plr);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_TAXI, "Eastern Kingdom Dungeons", 23);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_TAXI, "Kalimdor Dungeons", 24);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_TAXI, "Outland Dungeons", 25);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_TAXI, "Northrend Dungeons", 26);
        AddGossipItemForArcemu(Plr, 0, "[Back]", 99);
        SendGossipMenuFor(Plr, 9, me);
    }break;
    case 29:
    {
        ClearGossipMenuFor(Plr);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_TAXI, "Azeroth Instances", 30);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_TAXI, "Outland Instances", 50);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_TAXI, "Northrend Instances", 300);
        AddGossipItemForArcemu(Plr, 0, "[Back]", 99);
        SendGossipMenuFor(Plr, 9, me);
    }break;
    case 1600:
        //Normal Player
        if (IsIronManPlayer(Plr) == false) {
            GiveFreeStart(Plr, true, true);
            send_GuidePage(Plr, 50);
        }
        break;
    case 1601:
        //Set Ironman
        if (CheckPlayerCanTurnIronManHardcore(Plr, 0) == true) {
            SetIronmanHardcoreMode(Plr, 0); // if you change order, extra items might be given to HC players
            GiveFreeStart(Plr, false, false);
            send_GuidePage(Plr, 51);
        }
        else
        {
            CloseGossipMenuFor(Plr);
            Plr->BroadcastMessage("You need a fresh new character to choose this mode");
        }
        break;
    case 1602:
        //Set Hardcode
        if (CheckPlayerCanTurnIronManHardcore(Plr,1) == true) {
            SetIronmanHardcoreMode(Plr, 1);
            GiveFreeStart(Plr, false, false);
            send_GuidePage(Plr, 52);
        }
        else
        {
            CloseGossipMenuFor(Plr);
            Plr->BroadcastMessage("You need a fresh new character to choose this mode");
        }
        break;
    case 1603:
        {
            if (CheckPlayerCanTurnIronManHardcore(Plr, 1) == false)
                GiveFreeStart(Plr, true, false);
            CloseGossipMenuFor(Plr);
        }break;

    case 1700:
        ClearGossipMenuFor(Plr);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_TRAINER, "Available Player Commands", 1701);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_TRAINER, "Website & Highscores", 1702);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_TRAINER, "Skilling Zone & Modes", 1703);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_TRAINER, "Personal Instance (.home)", 1704);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_TRAINER, "Other Guides", 1705);
        AddGossipItemForArcemu(Plr, 0, "[Back]", 99);
        SendGossipMenuFor(Plr, 9, me);
    break;

    case 1701: send_GuidePage(Plr, 111); break;
    case 1702: send_GuidePage(Plr, 112); break;
    case 1703: send_GuidePage(Plr, 113); break;
    case 1704: send_GuidePage(Plr, 114); break;
    case 1705: send_GuidePage(Plr, 115); break;

    case 398:
        CloseGossipMenuFor(Plr);
        TeleportToPersonalInstanceMapWithChecks(Plr, ENDURANCE_MAP, true);
        break;
    case 399:
        CloseGossipMenuFor(Plr);
        TeleportToPersonalInstanceMapWithChecks(Plr, 615, true);
        break;

    case 400:
        ClearGossipMenuFor(Plr);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_BATTLE, "Endurance", 398);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_CHAT, "My Home Map 1", 399);
        //TODO load maps and generate menu
        AddGossipItemForArcemu(Plr, 0, "[Back]", 99);
        SendGossipMenuFor(Plr, 9, me);
    break;
    case 401:
    {
        ClearGossipMenuFor(Plr);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_CHAT, "Easy mode. -90%", 452);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_CHAT, "Normal mode", 453);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_BATTLE, "Tougher +100%", 454);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_BATTLE, "Only green drops +300%", 455);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_BATTLE, "Nightmare +500%", 456);
        AddGossipItemForArcemu(Plr, 0, "[Back]", 99);
        SendGossipMenuFor(Plr, 9, me);
    }break;
    case 452:
    {
        CloseGossipMenuFor(Plr);
        *Plr->GetCreateIn64Extension(OE_MAP_MOB_DIFFICULTY_SCALER) = -90;
        Plr->BroadcastMessage("Changed instance difficulty. Only new instances will be changed. Party leader needs to have it!");
    }break;
    case 453:
    {
        CloseGossipMenuFor(Plr);
        *Plr->GetCreateIn64Extension(OE_MAP_MOB_DIFFICULTY_SCALER) = 0;
        Plr->BroadcastMessage("Changed instance difficulty. Only new instances will be changed. Party leader needs to have it!");
    }break;
    case 454:
    {
        CloseGossipMenuFor(Plr);
        *Plr->GetCreateIn64Extension(OE_MAP_MOB_DIFFICULTY_SCALER) = 100;
        Plr->BroadcastMessage("Changed instance difficulty. Only new instances will be changed. Party leader needs to have it!");
    }break;
    case 455:
    {
        CloseGossipMenuFor(Plr);
        *Plr->GetCreateIn64Extension(OE_MAP_MOB_DIFFICULTY_SCALER) = 300;
        Plr->BroadcastMessage("Changed instance difficulty. Only new instances will be changed. Party leader needs to have it!");
    }break;
    case 456:
    {
        CloseGossipMenuFor(Plr);
        *Plr->GetCreateIn64Extension(OE_MAP_MOB_DIFFICULTY_SCALER) = 500;
        Plr->BroadcastMessage("Changed instance difficulty. Only new instances will be changed. Party leader needs to have it!");
    }break;
    case 1500:
    {
        CloseGossipMenuFor(Plr);
        sentAll = CheckSQLReward(Plr, me);
        if (sentAll == 1) {
            me->Whisper(std::string("Thanks for your support, all rewards where added! Character has been saved."), LANG_UNIVERSAL, Plr);
        }
        else if (sentAll == 2) {
            me->Whisper(std::string("Some items could not be added, free up some slots in your bags."), LANG_UNIVERSAL, Plr);
        }
        Plr->SaveToDB();

    }break;
    case 1300:	EventTeleport(Plr, 530, -1909, 5520, -12.428010f);		break;//Skilling Zone
    case 1400:
        ClearGossipMenuFor(Plr);
        if (Plr->GetTeam() == HORDE)
        {
            AddGossipItemForArcemu(Plr, GOSSIP_ICON_TAXI, "Leveling Areas 10-60", 81);
        }
        else
        {
            AddGossipItemForArcemu(Plr, GOSSIP_ICON_TAXI, "Leveling Areas 10-60", 80);
        }
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_TAXI, "Outland Locations lvl 60+", 3);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_TAXI, "Northrend Locations lvl 70+", 500);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_TAXI, "Isle of Quel'Danas lvl 70+", 250);
        AddGossipItemForArcemu(Plr, 0, "[Back]", 99);
        SendGossipMenuFor(Plr, 9, me);
        break;
    
    case 1200:
        ClearGossipMenuFor(Plr);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Balanced Heartseeker (Dagger)", 1201);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Battleworn Thrash Blade (Sword)", 1202);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Bloodied Arcanite Reaper (2H Axe)", 1203);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Charmed Ancient Bone Bow (Bow)", 1204);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Grand Staff of Jordan (Staff)", 1205);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "The Blessed Hammer of Grace (Mace)", 1206);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Upgraded Dwarven Hand Cannon (Gun)", 1207);
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Woestave (Wand)", 1208);
        AddGossipItemForArcemu(Plr, 0, "[Back]", 99);
        SendGossipMenuFor(Plr, 9, me);
        break;
    case 1201:
        CloseGossipMenuFor(Plr);
        if(Plr->AddItem(42944, 1))
            me->Say(std::string("Balanced Heartseeker was added to your bags."), LANG_UNIVERSAL, Plr);
        break;
    case 1202:
        CloseGossipMenuFor(Plr);
        if (Plr->AddItem(44096, 1))
        me->Say(std::string("Battleworn Thrash Blade was added to your bags."), LANG_UNIVERSAL, Plr);
        break;
    case 1203:
        CloseGossipMenuFor(Plr);
        if (Plr->AddItem(42943, 1))
        me->Say(std::string("Bloodied Arcanite Reaper was added to your bags."), LANG_UNIVERSAL, Plr);
        break;
    case 1204:
        CloseGossipMenuFor(Plr);
        if (Plr->AddItem(42946, 1))
        me->Say(std::string("Charmed Ancient Bone Bow was added to your bags."), LANG_UNIVERSAL, Plr);
        break;
    case 1205:
        CloseGossipMenuFor(Plr);
        if (Plr->AddItem(44095, 1))
        me->Say(std::string("Grand Staff of Jordan was added to your bags."), LANG_UNIVERSAL, Plr);
        break;
    case 1206:
        CloseGossipMenuFor(Plr);
        if (Plr->AddItem(44094, 1))
        me->Say(std::string("The Blessed Hammer of Grace was added to your bags."), LANG_UNIVERSAL, Plr);
        break;
    case 1207:
        CloseGossipMenuFor(Plr);
        if (Plr->AddItem(44093, 1))
        me->Say(std::string("Upgraded Dwarven Hand Cannon was added to your bags."), LANG_UNIVERSAL, Plr);
        break;
    case 1208:
        CloseGossipMenuFor(Plr);
        if (Plr->AddItem(20082, 1))
        me->Say(std::string("Woestave was added to your bags."), LANG_UNIVERSAL, Plr);
        break;

   
    case 1000:
        ClearGossipMenuFor(Plr);
        if (Plr->getClass() == CLASS_WARRIOR) {
            AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Deadly Gladiator's Battlegear", 1001);
        }
        if (Plr->getClass() == CLASS_WARLOCK) {
            AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Deadly Gladiator's Felshroud", 1002);
        }
        if (Plr->getClass() == CLASS_SHAMAN) {
            AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Deadly Gladiator's Earthshaker", 1003);
            AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Deadly Gladiator's Thunderfist", 1004);
            AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Deadly Gladiator's Wartide", 1005);
        }
        if (Plr->getClass() == CLASS_ROGUE) {
            AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Deadly Gladiator's Vestments", 1006);
        }
        if (Plr->getClass() == CLASS_PRIEST) {
            AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Deadly Gladiator's Investiture", 1007);
            AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Deadly Gladiator's Raiment", 1008);
        }
        if (Plr->getClass() == CLASS_PALADIN) {
            AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Deadly Gladiator's Redemption", 1009);
            AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Deadly Gladiator's Vindication", 1010);
        }
        if (Plr->getClass() == CLASS_MAGE) {
            AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Deadly Gladiator's Regalia", 1011);
        }
        if (Plr->getClass() == CLASS_HUNTER) {
            AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Deadly Gladiator's Pursuit", 1012);
        }
        if (Plr->getClass() == CLASS_DRUID) {
            AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Deadly Gladiator's Refuge", 1013);
            AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Deadly Gladiator's Sanctuary", 1014);
            AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Deadly Gladiator's Wildhide", 1015);
        }
        if (Plr->getClass() == CLASS_DEATH_KNIGHT) {
            AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Deadly Gladiator's Desecration", 1016);
        }
        AddGossipItemForArcemu(Plr, 0, "[Back]", 99);
        SendGossipMenuFor(Plr, 9, me);
        break;

        case 1001: //Warrior
            CloseGossipMenuFor(Plr);
            if(Plr->AddItem(40879, 1) && Plr->AddItem(40888, 1) && Plr->AddItem(40880, 1) && //off-parts
                Plr->AddItem(40786, 1) && Plr->AddItem(40804, 1) && Plr->AddItem(40823, 1) && Plr->AddItem(40844, 1) && Plr->AddItem(40862, 1))
                me->Say(std::string("Deadly Gladiator's PvP Set was added to your bags."), LANG_UNIVERSAL, Plr);
            break;
        case 1002: //Warlock
            CloseGossipMenuFor(Plr);
            if (Plr->AddItem(41897, 1) && Plr->AddItem(41908, 1) && Plr->AddItem(41902, 1) && //off-parts
                Plr->AddItem(42010, 1) && Plr->AddItem(41992, 1) && Plr->AddItem(42016, 1) && Plr->AddItem(41997, 1) && Plr->AddItem(42004, 1))
                me->Say(std::string("Deadly Gladiator's PvP Set was added to your bags."), LANG_UNIVERSAL, Plr);
            break;
        case 1003: //Shaman
            CloseGossipMenuFor(Plr);
            if (Plr->AddItem(41069, 1) && Plr->AddItem(41064, 1) && Plr->AddItem(41229, 1) && //off-parts
                Plr->AddItem(41080, 1) && Plr->AddItem(41136, 1) && Plr->AddItem(41150, 1) && Plr->AddItem(41198, 1) && Plr->AddItem(41210, 1))
                me->Say(std::string("Deadly Gladiator's PvP Set was added to your bags."), LANG_UNIVERSAL, Plr);
            break;
        case 1004: //Shaman
            CloseGossipMenuFor(Plr);
            if (Plr->AddItem(41234, 1) && Plr->AddItem(41224, 1) && Plr->AddItem(41074, 1) && //off-parts
                Plr->AddItem(40991, 1) && Plr->AddItem(41006, 1) && Plr->AddItem(41018, 1) && Plr->AddItem(41032, 1) && Plr->AddItem(41043, 1))
                me->Say(std::string("Deadly Gladiator's PvP Set was added to your bags."), LANG_UNIVERSAL, Plr);
            break;
        case 1005: //Shaman
            CloseGossipMenuFor(Plr);
            if (Plr->AddItem(41234, 1) && Plr->AddItem(41224, 1) && Plr->AddItem(41074, 1) && //off-parts
                Plr->AddItem(40990, 1) && Plr->AddItem(41000, 1) && Plr->AddItem(41012, 1) && Plr->AddItem(41026, 1) && Plr->AddItem(41037, 1))
                me->Say(std::string("Deadly Gladiator's PvP Set was added to your bags."), LANG_UNIVERSAL, Plr);
            break;
        case 1006: //Rogue
            CloseGossipMenuFor(Plr);
            if (Plr->AddItem(41831, 1) && Plr->AddItem(41839, 1) && Plr->AddItem(41835, 1) && //off-parts
                Plr->AddItem(41766, 1) && Plr->AddItem(41671, 1) && Plr->AddItem(41654, 1) && Plr->AddItem(41682, 1) && Plr->AddItem(41649, 1))
                me->Say(std::string("Deadly Gladiator's PvP Set was added to your bags."), LANG_UNIVERSAL, Plr);
            break;
        case 1007: //Priest
            CloseGossipMenuFor(Plr);
            if (Plr->AddItem(41873, 1) && Plr->AddItem(41892, 1) && Plr->AddItem(41884, 1) && //off-parts
                Plr->AddItem(41873, 1) && Plr->AddItem(41853, 1) && Plr->AddItem(41863, 1) && Plr->AddItem(41868, 1) && Plr->AddItem(41858, 1))
                me->Say(std::string("Deadly Gladiator's PvP Set was added to your bags."), LANG_UNIVERSAL, Plr);
            break;
        case 1008://Priest
            CloseGossipMenuFor(Plr);
            if (Plr->AddItem(41873, 1) && Plr->AddItem(41892, 1) && Plr->AddItem(41902, 1) && //off-parts
                Plr->AddItem(41939, 1) && Plr->AddItem(41914, 1) && Plr->AddItem(41926, 1) && Plr->AddItem(41933, 1) && Plr->AddItem(41920, 1))
                me->Say(std::string("Deadly Gladiator's PvP Set was added to your bags."), LANG_UNIVERSAL, Plr);
            break;
        case 1009: //Paladin
            CloseGossipMenuFor(Plr);
            if (Plr->AddItem(40974, 1) && Plr->AddItem(40982, 1) && Plr->AddItem(40880, 1) && //off-parts
                Plr->AddItem(40905, 1) && Plr->AddItem(40926, 1) && Plr->AddItem(40932, 1) && Plr->AddItem(40938, 1) && Plr->AddItem(40962, 1))
                me->Say(std::string("Deadly Gladiator's PvP Set was added to your bags."), LANG_UNIVERSAL, Plr);
            break;
        case 1010: //Paladin
            CloseGossipMenuFor(Plr);
            if (Plr->AddItem(40879, 1) && Plr->AddItem(40888, 1) && Plr->AddItem(40975, 1) && //off-parts
                Plr->AddItem(40785, 1) && Plr->AddItem(40805, 1) && Plr->AddItem(40825, 1) && Plr->AddItem(40846, 1) && Plr->AddItem(40864, 1))
                me->Say(std::string("Deadly Gladiator's PvP Set was added to your bags."), LANG_UNIVERSAL, Plr);
            break;
        case 1011: //Mage
            CloseGossipMenuFor(Plr);
            if (Plr->AddItem(41897, 1) && Plr->AddItem(41908, 1) && Plr->AddItem(41902, 1) && //off-parts
                Plr->AddItem(41964, 1) && Plr->AddItem(41945, 1) && Plr->AddItem(41970, 1) && Plr->AddItem(41951, 1) && Plr->AddItem(41958, 1))
                me->Say(std::string("Deadly Gladiator's PvP Set was added to your bags."), LANG_UNIVERSAL, Plr);
            break;
        case 1012: //Hunter
            CloseGossipMenuFor(Plr);
            if (Plr->AddItem(41069, 1) && Plr->AddItem(41064, 1) && Plr->AddItem(41074, 1) && //off-parts
                Plr->AddItem(41086, 1) && Plr->AddItem(41142, 1) && Plr->AddItem(41156, 1) && Plr->AddItem(41204, 1) && Plr->AddItem(41216, 1))
                me->Say(std::string("Deadly Gladiator's PvP Set was added to your bags."), LANG_UNIVERSAL, Plr);
            break;
        case 1013: //Druid
            CloseGossipMenuFor(Plr);
            if (Plr->AddItem(41831, 1) && Plr->AddItem(41839, 1) && Plr->AddItem(41634, 1) && //off-parts
                Plr->AddItem(41286, 1) && Plr->AddItem(41320, 1) && Plr->AddItem(41297, 1) && Plr->AddItem(41309, 1) && Plr->AddItem(41274, 1))
                me->Say(std::string("Deadly Gladiator's PvP Set was added to your bags."), LANG_UNIVERSAL, Plr);
            break;
        case 1014: //Druid
            CloseGossipMenuFor(Plr);
            if (Plr->AddItem(41629, 1) && Plr->AddItem(41839, 1) && Plr->AddItem(41835, 1) && //off-parts
                Plr->AddItem(41274, 1) && Plr->AddItem(41677, 1) && Plr->AddItem(41666, 1) && Plr->AddItem(41660, 1) && Plr->AddItem(41714, 1))
                me->Say(std::string("Deadly Gladiator's PvP Set was added to your bags."), LANG_UNIVERSAL, Plr);
            break;
        case 1015: //Druid
            CloseGossipMenuFor(Plr);
            if (Plr->AddItem(41629, 1) && Plr->AddItem(41839, 1) && Plr->AddItem(41835, 1) && //off-parts
                Plr->AddItem(41714, 1) && Plr->AddItem(41326, 1) && Plr->AddItem(41303, 1) && Plr->AddItem(41315, 1) && Plr->AddItem(41280, 1))
                me->Say(std::string("Deadly Gladiator's PvP Set was added to your bags."), LANG_UNIVERSAL, Plr);
            break;
        case 1016: //DK
            CloseGossipMenuFor(Plr);
            if (Plr->AddItem(40879, 1) && Plr->AddItem(40888, 1) && Plr->AddItem(40880, 1) && //off-parts
                Plr->AddItem(40784, 1) && Plr->AddItem(40806, 1) && Plr->AddItem(40824, 1) && Plr->AddItem(40845, 1) && Plr->AddItem(40863, 1))
                me->Say(std::string("Deadly Gladiator's PvP Set was added to your bags."), LANG_UNIVERSAL, Plr);
            break;


        case 1100:
            ClearGossipMenuFor(Plr);
            if (Plr->getClass() == CLASS_WARRIOR) {
                AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Valorous Dreadnaught Battlegear", 1101);
                AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Valorous Dreadnaught Plate", 1102);
            }
            if (Plr->getClass() == CLASS_WARLOCK) {
                AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Valorous Plagueheart Garb", 1103);
            }
            if (Plr->getClass() == CLASS_SHAMAN) {
                AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Valorous Earthshatter Regalia", 1104);
                AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Valorous Earthshatter Garb", 1105);
                AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Valorous Earthshatter Battlegear", 1106);
            }
            if (Plr->getClass() == CLASS_ROGUE) {
                AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Valorous Bonescythe Battlegear", 1107);
            }
            if (Plr->getClass() == CLASS_PRIEST) {
                AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Valorous Regalia of Faith", 1108);
                AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Valorous Garb of Faith", 1109);
            }
            if (Plr->getClass() == CLASS_PALADIN) {
                AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Valorous Redemption Regalia", 1110);
                AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Valorous Redemption Battlegear", 1111);
                AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Valorous Redemption Plate", 1112);
            }
            if (Plr->getClass() == CLASS_MAGE) {
                AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Valorous Frostfire Garb", 1113);
            }
            if (Plr->getClass() == CLASS_HUNTER) {
                AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Valorous Cryptstalker Battlegear", 1114);
            }
            if (Plr->getClass() == CLASS_DRUID) {
                AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Valorous Dreamwalker Regalia", 1115);
                AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Valorous Dreamwalker Garb", 1116);
                AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Valorous Dreamwalker Battlegear", 1117);
            }
            if (Plr->getClass() == CLASS_DEATH_KNIGHT) {
                AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Valorous Scourgeborne Battlegear", 1118);
                AddGossipItemForArcemu(Plr, GOSSIP_ICON_VENDOR, "Valorous Scourgeborne Plate", 1119);
            }
            AddGossipItemForArcemu(Plr, 0, "[Back]", 99);
            SendGossipMenuFor(Plr, 9, me);
            break;

        case 1101: //Warrior
            CloseGossipMenuFor(Plr);
            if (Plr->AddItem(40332, 1) && Plr->AddItem(40241, 1) && Plr->AddItem(40745, 1) && //off-parts
                Plr->AddItem(40528, 1) && Plr->AddItem(40530, 1) && Plr->AddItem(40525, 1) && Plr->AddItem(40529, 1) && Plr->AddItem(40527, 1))
                me->Say(std::string("Valorous PvE Set was added to your bags."), LANG_UNIVERSAL, Plr);
            break;
        case 1102: //Warrior
            CloseGossipMenuFor(Plr);
            if (Plr->AddItem(39729, 1) && Plr->AddItem(39759, 1) && Plr->AddItem(40743, 1) && //off-parts
                Plr->AddItem(40546, 1) && Plr->AddItem(40548, 1) && Plr->AddItem(40544, 1) && Plr->AddItem(40547, 1) && Plr->AddItem(40545, 1))
                me->Say(std::string("Valorous PvE Set was added to your bags."), LANG_UNIVERSAL, Plr);
            break;
        case 1103: //Warlock
            CloseGossipMenuFor(Plr);
            if (Plr->AddItem(40325, 1) && Plr->AddItem(40301, 1) && Plr->AddItem(40269, 1) && //off-parts
                Plr->AddItem(40421, 1) && Plr->AddItem(40424, 1) && Plr->AddItem(40422, 1) && Plr->AddItem(40420, 1) && Plr->AddItem(40423, 1))
                me->Say(std::string("Valorous PvE Set was added to your bags."), LANG_UNIVERSAL, Plr);
            break;
        case 1104: //Shaman
            CloseGossipMenuFor(Plr);
            if (Plr->AddItem(40209, 1) && Plr->AddItem(40327, 1) && Plr->AddItem(40747, 1) && //off-parts
                Plr->AddItem(40510, 1) && Plr->AddItem(40513, 1) && Plr->AddItem(40508, 1) && Plr->AddItem(40512, 1) && Plr->AddItem(40509, 1))
                me->Say(std::string("Valorous PvE Set was added to your bags."), LANG_UNIVERSAL, Plr);
            break;
        case 1105: //Shaman
            CloseGossipMenuFor(Plr);
            if (Plr->AddItem(39702, 1) && Plr->AddItem(39762, 1) && Plr->AddItem(40746, 1) && //off-parts
                Plr->AddItem(40516, 1) && Plr->AddItem(40518, 1) && Plr->AddItem(40514, 1) && Plr->AddItem(40517, 1) && Plr->AddItem(40515, 1))
                me->Say(std::string("Valorous PvE Set was added to your bags."), LANG_UNIVERSAL, Plr);
            break;
        case 1106: //Shaman
            CloseGossipMenuFor(Plr);
            if (Plr->AddItem(40521, 1) && Plr->AddItem(40524, 1) && Plr->AddItem(40523, 1) && Plr->AddItem(40522, 1) && Plr->AddItem(40520, 1))
                me->Say(std::string("Valorous PvE Set was added to your bags."), LANG_UNIVERSAL, Plr);
            break;
        case 1107: //Rogue
            CloseGossipMenuFor(Plr);
            if (Plr->AddItem(39765, 1) && Plr->AddItem(40205, 1) && Plr->AddItem(40409, 1) && //off-parts
                Plr->AddItem(40499, 1) && Plr->AddItem(40502, 1) && Plr->AddItem(40495, 1) && Plr->AddItem(40500, 1) && Plr->AddItem(40496, 1))
                me->Say(std::string("Valorous PvE Set was added to your bags."), LANG_UNIVERSAL, Plr);
            break;
        case 1108: //Priest
            CloseGossipMenuFor(Plr);
            if (Plr->AddItem(39731, 1) && Plr->AddItem(39731, 1) && Plr->AddItem(39731, 1) && //off-parts
                Plr->AddItem(40447, 1) && Plr->AddItem(40450, 1) && Plr->AddItem(40448, 1) && Plr->AddItem(40445, 1) && Plr->AddItem(40449, 1))
                me->Say(std::string("Valorous PvE Set was added to your bags."), LANG_UNIVERSAL, Plr);
            break;
        case 1109: //Priest
            CloseGossipMenuFor(Plr);
            if (Plr->AddItem(40456, 1) && Plr->AddItem(40459, 1) && Plr->AddItem(40457, 1) && Plr->AddItem(40454, 1) && Plr->AddItem(40458, 1))
                me->Say(std::string("Valorous PvE Set was added to your bags."), LANG_UNIVERSAL, Plr);
            break;
        case 1110: //Palandin
            CloseGossipMenuFor(Plr);
            if (Plr->AddItem(40332, 1) && Plr->AddItem(40241, 1) && Plr->AddItem(40745, 1) && //off-parts
                Plr->AddItem(40571, 1) && Plr->AddItem(40573, 1) && Plr->AddItem(40569, 1) && Plr->AddItem(40572, 1) && Plr->AddItem(40570, 1))
                me->Say(std::string("Valorous PvE Set was added to your bags."), LANG_UNIVERSAL, Plr);
            break;
        case 1111://Palandin
            CloseGossipMenuFor(Plr);
            if (Plr->AddItem(39729, 1) && Plr->AddItem(39759, 1) && Plr->AddItem(40743, 1) && //off-parts
                Plr->AddItem(40576, 1) && Plr->AddItem(40578, 1) && Plr->AddItem(40574, 1) && Plr->AddItem(40577, 1) && Plr->AddItem(40575, 1))
                me->Say(std::string("Valorous PvE Set was added to your bags."), LANG_UNIVERSAL, Plr);
            break;
        case 1112://Palandin
            CloseGossipMenuFor(Plr);
            if (Plr->AddItem(40581, 1) && Plr->AddItem(40584, 1) && Plr->AddItem(40579, 1) && Plr->AddItem(40583, 1) && Plr->AddItem(40580, 1))
                me->Say(std::string("Valorous PvE Set was added to your bags."), LANG_UNIVERSAL, Plr);
            break;
        case 1113: //Mage
            CloseGossipMenuFor(Plr);
            if (Plr->AddItem(40198, 1) && Plr->AddItem(39735, 1) && Plr->AddItem(40751, 1) && //off-parts
                Plr->AddItem(40416, 1) && Plr->AddItem(40419, 1) && Plr->AddItem(40417, 1) && Plr->AddItem(40415, 1) && Plr->AddItem(40418, 1))
                me->Say(std::string("Valorous PvE Set was added to your bags."), LANG_UNIVERSAL, Plr);
            break;
        case 1114: //Hunter
            CloseGossipMenuFor(Plr);
            if (Plr->AddItem(40209, 1) && Plr->AddItem(40327, 1) && Plr->AddItem(40747, 1) && //off-parts
                Plr->AddItem(40505, 1) && Plr->AddItem(40507, 1) && Plr->AddItem(40503, 1) && Plr->AddItem(40506, 1) && Plr->AddItem(40504, 1))
                me->Say(std::string("Valorous PvE Set was added to your bags."), LANG_UNIVERSAL, Plr);
            break;
        case 1115: //Druid
            CloseGossipMenuFor(Plr);
            if (Plr->AddItem(39722, 1) && Plr->AddItem(40200, 1) && Plr->AddItem(40409, 1) && //off-parts
                Plr->AddItem(40461, 1) && Plr->AddItem(40465, 1) && Plr->AddItem(40462, 1) && Plr->AddItem(40460, 1) && Plr->AddItem(40463, 1))
                me->Say(std::string("Valorous PvE Set was added to your bags."), LANG_UNIVERSAL, Plr);
            break;
        case 1116: //Druid
            CloseGossipMenuFor(Plr);
            if (Plr->AddItem(39765, 1) && Plr->AddItem(39765, 1) && //off-parts
                Plr->AddItem(40467, 1) && Plr->AddItem(40470, 1) && Plr->AddItem(40468, 1) && Plr->AddItem(40466, 1) && Plr->AddItem(40469, 1))
                me->Say(std::string("Valorous PvE Set was added to your bags."), LANG_UNIVERSAL, Plr);
            break;
        case 1117: //Druid
            CloseGossipMenuFor(Plr);
            if (Plr->AddItem(40473, 1) && Plr->AddItem(40494, 1) && Plr->AddItem(40493, 1) && Plr->AddItem(40472, 1) && Plr->AddItem(40471, 1))
                me->Say(std::string("Valorous PvE Set was added to your bags."), LANG_UNIVERSAL, Plr);
            break;

        case 1118: //DK
            CloseGossipMenuFor(Plr);
            if (Plr->AddItem(40332, 1) && Plr->AddItem(40241, 1) && Plr->AddItem(40745, 1) && //off-parts
                Plr->AddItem(40554, 1) && Plr->AddItem(40557, 1) && Plr->AddItem(40550, 1) && Plr->AddItem(40556, 1) && Plr->AddItem(40552, 1))
                me->Say(std::string("Valorous PvE Set was added to your bags."), LANG_UNIVERSAL, Plr);
            break;
        case 1119: //DK
            CloseGossipMenuFor(Plr);
            if (Plr->AddItem(39729, 1) && Plr->AddItem(39759, 1) && Plr->AddItem(40743, 1) && //off-parts
                Plr->AddItem(40565, 1) && Plr->AddItem(40568, 1) && Plr->AddItem(40559, 1) && Plr->AddItem(40567, 1) && Plr->AddItem(40563, 1))
                me->Say(std::string("Valorous PvE Set was added to your bags."), LANG_UNIVERSAL, Plr);
            break;
        
        case 1:
			ClearGossipMenuFor(Plr);
            if (Plr->GetTeam() == HORDE)
            {   //Horde
                AddGossipItemForArcemu(Plr, 5, "Orgrimmar", 5);
                AddGossipItemForArcemu(Plr, 5, "Silvermoon", 4);
                AddGossipItemForArcemu(Plr, 5, "Thunderbluff", 6);
                AddGossipItemForArcemu(Plr, 5, "UnderCity", 7);
                AddGossipItemForArcemu(Plr, GOSSIP_ICON_TAXI, "Dalaran (Neutral)", 503);
            }
            else
            {   //Alliance
                AddGossipItemForArcemu(Plr, 5, "Orgrimmar", 225);
                AddGossipItemForArcemu(Plr, 5, "Silvermoon", 224);
                AddGossipItemForArcemu(Plr, 5, "Thunderbluff", 226);
                AddGossipItemForArcemu(Plr, 5, "UnderCity", 227);
                AddGossipItemForArcemu(Plr, GOSSIP_ICON_TAXI, "Dalaran (Neutral)", 503);
            }
			AddGossipItemForArcemu( Plr, 0, "[Back]", 99);
			SendGossipMenuFor(Plr,9,me);
			break;
		case 2:		
			ClearGossipMenuFor(Plr);
            if (Plr->GetTeam() == ALLIANCE) {
                AddGossipItemForArcemu(Plr, 5, "Stormwind", 9);
                AddGossipItemForArcemu(Plr, 5, "The Exodar", 8);
                AddGossipItemForArcemu(Plr, 5, "Ironforge", 10);
                AddGossipItemForArcemu(Plr, 5, "Darnassus", 11);
                AddGossipItemForArcemu(Plr, GOSSIP_ICON_TAXI, "Dalaran (Neutral)", 503);
            }
            else
            {
                AddGossipItemForArcemu(Plr, 5, "Stormwind", 229);
                AddGossipItemForArcemu(Plr, 5, "The Exodar", 228);
                AddGossipItemForArcemu(Plr, 5, "Ironforge", 230);
                AddGossipItemForArcemu(Plr, 5, "Darnassus", 231);
                AddGossipItemForArcemu(Plr, GOSSIP_ICON_TAXI, "Dalaran (Neutral)", 503);
            }
			AddGossipItemForArcemu( Plr, 0, "[Back]", 99);
			SendGossipMenuFor(Plr,9,me);
			break; //Alliance Cities
		case 3:     
			ClearGossipMenuFor(Plr);
			AddGossipItemForArcemu( Plr, 5, "Hellfire Peninsula (58-63)", 12);
			AddGossipItemForArcemu( Plr, 5, "Zangermarsh (60-64)", 13);
			AddGossipItemForArcemu( Plr, 5, "Nagrand (64-67)", 14);
			AddGossipItemForArcemu( Plr, 5, "Blades Edge Mountains (65-68)", 15);
			AddGossipItemForArcemu( Plr, 5, "Netherstorm (67-70)", 16);
			AddGossipItemForArcemu( Plr, 5, "Terokkar Forest (62-65)", 17);
			AddGossipItemForArcemu( Plr, 5, "Shadowmoon Valley (67-70)", 18);
			AddGossipItemForArcemu( Plr, 0, "[Back]", 1400);
			SendGossipMenuFor(Plr,9,me);
			break; //Outland Locations
		case 5:     EventTeleport( Plr, 1, 1569, -4437, 6.41f);								break;//Orgrimmar (Horde)
		case 225:   EventTeleport( Plr, 1, 1330, -4360, 29);								break;//Orgrimmar
        case 4:     EventTeleport(Plr, 530, 9487, -7279, 14.29f);		                    break;//Silvermoon (Horde)
        case 224:   EventTeleport(Plr, 530, 9400.486328f, -7278.376953f, 14.206780f);		break;//Silvermoon
		case 6:     EventTeleport( Plr, 1, -1227, 124, 131.29f);			                break;//ThunderBluff (Horde)
        case 226:   EventTeleport(Plr, 1, -1304.569946f, 205.285004f, 68.681396f);		    break;//ThunderBluff
		case 7:     EventTeleport( Plr, 0, 1584, 241, -52.1534f);			                break;//UnderCity (Horde)
        case 227:   EventTeleport(Plr, 0, 2050.203125f, 285.650604f, 56.994549f);			break;//UnderCity

        case 9:     EventTeleport( Plr, 0, -8833.76f, 623.25f, 93.691803f);			        break;//Stormwind (Ally)
		case 229:   EventTeleport( Plr, 0, -9100.480469f, 406.950745f, 92.594185f);			break;//Stormwind
        case 8:     EventTeleport(Plr, 530, -3965, -11653, -138.843994f);	                break;//Exodar (Ally)
        case 228:   EventTeleport(Plr, 530, -4072.202393f, -12014.337891f, -1.277277f);	    break;//Exodar
		case 10:    EventTeleport( Plr, 0, -4918, -940, 501.564f);		                    break;//Ironforge (Ally)
        case 230:   EventTeleport(Plr, 0, -5028.265137f, -825.976563f, 495.301575f);		break;//Ironforge
		case 11:    EventTeleport( Plr, 1, 9949, 2284, 1341.395f);		                    break;//Darnassus (Ally)
        case 231:   EventTeleport(Plr, 1, 9985.907227f, 1971.155640f, 1326.815674f);		break;//Darnassus
		case 12:    EventTeleport( Plr, 530, -248.160004f, 922.348999f, 84.379799f);		break;//Hellfire Peninsula
		case 13:    EventTeleport( Plr, 530, -225.863632f, 5405.927246f, 22.346397f);		break;//Zangermarsh
		case 14:    EventTeleport( Plr, 530, -468.232330f, 8418.666016f, 28.031298f);		break;//Nagrand
		case 15:    EventTeleport( Plr, 530, 1471.672852f, 6828.047852f, 107.759239f);		break;//Blades Edge Mountains
		case 16:    EventTeleport( Plr, 530, 3396.123779f, 4182.208008f, 137.097992f);		break;//Netherstorm
		case 17:    EventTeleport( Plr, 530, -1202.426636f, 5313.692871f, 33.774723f);		break;//Terokkar Forest
		case 18:    EventTeleport( Plr, 530, -2859.522461f, 3182.34773f, 10.008426f);		break;//Shadowmoon Valley
		case 21:    EventTeleport( Plr, 0, -13281.959961f, 122.105515f, 26.464458f);		break;// Gurubsahi Arena
		// case 22:    
            // if (Plr->GetTeam() == 0) -1837.70 5448.44 -12.427
					// EventTeleport( Plr, 1, -8512.610352, 2018.642822, 104.748581);				// PvP Temple Alliance
			// else
					// EventTeleport( Plr, 1, -8654.244141, 1964.294556, 106.390472);				// PvP Temple Horde
       		// break;
        case 23:
        {
            ClearGossipMenuFor(Plr);
            AddGossipItemForArcemu(Plr, 5, "Deadmines", 70);
            AddGossipItemForArcemu(Plr, 5, "Uldaman", 71);
            AddGossipItemForArcemu(Plr, 5, "Gnomeregan", 72);
            AddGossipItemForArcemu(Plr, 5, "Sunken Temple", 73);
            AddGossipItemForArcemu(Plr, 5, "Blackrock Depths", 74);
            AddGossipItemForArcemu(Plr, 0, "[Back]", 99);
            SendGossipMenuFor(Plr, 9, me);
        }break;
        case 24:
        {
            ClearGossipMenuFor(Plr);
            AddGossipItemForArcemu(Plr, 5, "Maraudon", 75);
            AddGossipItemForArcemu(Plr, 5, "Ragefire Chasm", 76);
            AddGossipItemForArcemu(Plr, 5, "Dire Maul", 77);
            AddGossipItemForArcemu(Plr, 5, "Ahn'Qiraj Temple", 78);
            AddGossipItemForArcemu(Plr, 5, "Razorfen Downs", 79);
            AddGossipItemForArcemu(Plr, 5, "Wailing Caverns", 110);
            AddGossipItemForArcemu(Plr, 5, "Razorfen Kraul", 111);
            AddGossipItemForArcemu(Plr, 5, "Blackfathom Deeps", 112);
            AddGossipItemForArcemu(Plr, 5, "The Escape From Durnholde", 113);
            AddGossipItemForArcemu(Plr, 0, "[Back]", 99);
            SendGossipMenuFor(Plr, 9, me);
        }break;
        case 25:
        {
            ClearGossipMenuFor(Plr);
            AddGossipItemForArcemu(Plr, 5, "The Sunwell", 114);
            AddGossipItemForArcemu(Plr, 5, "Magister's Terrace", 115);
            AddGossipItemForArcemu(Plr, 0, "[Back]", 99);
            SendGossipMenuFor(Plr, 9, me);
        }break;
        case 26:
        {
            ClearGossipMenuFor(Plr);
            AddGossipItemForArcemu(Plr, 5, "Drak'Tharon Keep", 116);
            AddGossipItemForArcemu(Plr, 5, "Gundrak", 117);
            AddGossipItemForArcemu(Plr, 5, "Ahn'kahet: The Old Kingdom", 118);
            AddGossipItemForArcemu(Plr, 0, "[Back]", 99);
            SendGossipMenuFor(Plr, 9, me);
        }break;
        case 30:
			ClearGossipMenuFor(Plr);
			AddGossipItemForArcemu( Plr, 5, "Shadowfang Keep", 31);
			AddGossipItemForArcemu( Plr, 5, "Scarlet Monastery", 32);
			AddGossipItemForArcemu( Plr, 5, "Zul'Farrak", 33);
			AddGossipItemForArcemu( Plr, 5, "Stratholme", 41);
			AddGossipItemForArcemu( Plr, 5, "Scholomance", 40);
			AddGossipItemForArcemu( Plr, 5, "Blackrock Spire", 42);
			AddGossipItemForArcemu( Plr, 5, "Onyxia's Lair", 38);
			AddGossipItemForArcemu( Plr, 5, "Molten Core", 37);
			AddGossipItemForArcemu( Plr, 5, "Zul'Gurub", 34);
			AddGossipItemForArcemu( Plr, 5, "Karazhan", 43);
			AddGossipItemForArcemu( Plr, 5, "Ahn'Qirai 20", 35);
			AddGossipItemForArcemu( Plr, 5, "Ahn'Qirai 40", 36);
			AddGossipItemForArcemu( Plr, 5, "Naxxramas", 39);
			AddGossipItemForArcemu( Plr, 5, "Caverns of Times", 44);
			AddGossipItemForArcemu( Plr, 5, "Blackwing Lair Inside", 45);
			AddGossipItemForArcemu( Plr, 5, "Zul'Aman", 100);
			AddGossipItemForArcemu( Plr, 0, "[Back]", 99);
			SendGossipMenuFor(Plr,9,me);
			break; // Azeroth Instances
		case 31:    EventTeleport( Plr, 0, -234.495087f, 1561.946411f, 76.892143f);			break;// Shadowfang Keep
		case 32:    EventTeleport( Plr, 0, 2870.442627f, -819.985229f, 160.331085f);		break;// Scarlet Monastery
		case 33:    EventTeleport( Plr, 1, -6797.278809f, -2903.917969f, 9.953360f);		break;// Zul'Farrak
		case 34:    EventTeleport( Plr, 0, -11919.073242f, -1202.459374f, 92.298744f);		break;// Zul'Gurub
		case 35:    EventTeleport( Plr, 1, -8394.730469f, 1485.658447f, 21.038563f);		break;// Ahn'Qirai 20
		case 36:    EventTeleport( Plr, 1, -8247.316406f, 1970.156860f, 129.071472f);		break;// Ahn'Qirai 40
		case 37: 
		        // EventTeleport( Plr, 0, -7515.409668, -1045.369629, 182.301208);
	            EventTeleport( Plr, 409, 1089.6f, -470.19f, -106.41f);
			break;// Molten Core
		case 38: // Onyxia
				// EventTeleport( Plr, 1, -4708.491699, -3727.672363, 54.535076);
				EventTeleport( Plr, 249, 30.0f, -64.0f, -5.0f);
			break;
		case 39: // Naxxramas
				// EventTeleport( Plr, 0, 3132.915283, -3731.012939, 138.658371);
				EventTeleport( Plr, 533, 3006.06f, -3436.72f, 293.891f);
			break;
		case 40: 	EventTeleport( Plr, 0, 1267.468628f, -2556.651367f, 94.127983f);		break;//Scholomance
		case 41: 	EventTeleport( Plr, 0, 3359.111572f, -3380.8444238f, 144.781860f);		break;//Stratholme
		case 42: 	EventTeleport( Plr, 0, -7527.129883f, -1224.997437f, 285.733002f);		break;// Black ROck Spire
		case 43: // Kharazan
			// EventTeleport( Plr, 0, -11122.913086, -2014.498779, 47.079350);
			EventTeleport( Plr, 532, -11087.3f, -1977.47f, 49.6135f);
		break;
		case 44: 	EventTeleport( Plr, 1, -8519.718750f, -4297.542480f, -208.441376f);		break;// Caverns of Times
		case 45:    EventTeleport( Plr, 469, -7664, -1101, 401);							break;// Blackwing Lair
		case 100: 	EventTeleport( Plr, 530, 6848.597168f, -7761.557129f, 124.714592f);		break;// Zul'Aman
		case 50:	
			ClearGossipMenuFor(Plr);
			AddGossipItemForArcemu( Plr, 0, "Outland Raids", 64);
			AddGossipItemForArcemu( Plr, 5, "Hellfire Ramparts", 51);
			AddGossipItemForArcemu( Plr, 5, "The Blood Furnace", 52);
			AddGossipItemForArcemu( Plr, 5, "The Shattered Halls", 53);
			AddGossipItemForArcemu( Plr, 5, "The Underbog", 54);
			AddGossipItemForArcemu( Plr, 5, "The Slave Pens", 55);
			AddGossipItemForArcemu( Plr, 5, "The Steamvault", 56);
			AddGossipItemForArcemu( Plr, 5, "Mana-Tombs", 57);
			AddGossipItemForArcemu( Plr, 5, "Auchenai Crypts", 58);
			AddGossipItemForArcemu( Plr, 5, "Sethekk Halls", 59);
			AddGossipItemForArcemu( Plr, 5, "Shadow Labyrinth", 60);
			AddGossipItemForArcemu( Plr, 5, "The Mechanar", 61);
			AddGossipItemForArcemu( Plr, 5, "The Botanica", 62);
			AddGossipItemForArcemu( Plr, 5, "The Arcatraz", 63);
			AddGossipItemForArcemu( Plr, 0, "[Back]", 99);
			SendGossipMenuFor(Plr,9,me);
			break;// Outland Instances
		case 51:	EventTeleport( Plr, 530, -360.670990f, 3071.899902f, -15.097700f);		break;// Hellfire Ramparts
		case 52: 	EventTeleport( Plr, 530, -303.506012f, 3164.820068f, 31.742500f);		break;// The Blood Furnace
		case 53: 	EventTeleport( Plr, 530, -311.083527f, 3083.291748f, -3.745923f);		break;// The Shattered Halls
		case 54: 	EventTeleport( Plr, 530, 777.088989f, 6763.450195f, -72.062561f);		break;// The Underbog
		case 55: 	EventTeleport( Plr, 530, 719.507996f, 6999.339844f, -73.074303f);		break;// The Slave Pens
		case 56: 	EventTeleport( Plr, 530, 816.590027f, 6934.669922f, -80.544601f);		break;// The Steamvault
		case 57: 	EventTeleport( Plr, 530, -3079.810059f, 4943.040039f, -101.046997f);	break;// Mana-Tombs
		case 58: 	EventTeleport( Plr, 530, -3361.959961f, 5225.770020f, -101.047997f);	break;// Auchenai Crypts
		case 59: 	EventTeleport( Plr, 530, -3362.219971f, 4660.410156f, -101.049004f);	break;// Sethekk Halls
		case 60: 	EventTeleport( Plr, 530, -3645.060059f, 4943.620117f, -101.047997f);	break;// Shadow Labyrinth
		case 61: 	EventTeleport( Plr, 530, 2862.409912f, 1546.089966f, 252.158691f);		break;// The Mechanar
		case 62: 	EventTeleport( Plr, 530, 3413.649902f, 1483.319946f, 182.837997f);		break;// The Botanica
		case 63:	EventTeleport( Plr, 530, 3311.598145f, 1332.745117f, 505.557251f);		break; // The Arcatraz
		case 64: 
			ClearGossipMenuFor(Plr);
            AddGossipItemForArcemu( Plr, 5, "Magtheridon's Lair", 65);
			AddGossipItemForArcemu( Plr, 5, "Serpentshrine Cavern", 66);
            AddGossipItemForArcemu( Plr, 5, "Gruul's Lair", 67);
			AddGossipItemForArcemu( Plr, 5, "The Eye", 68);
			AddGossipItemForArcemu( Plr, 5, "Black Temple", 69);
			AddGossipItemForArcemu( Plr, 0, "[Back]", 99);
            SendGossipMenuFor(Plr,9,me);
		break;// Outland Raids
		case 65:	EventTeleport( Plr, 530, -313.678986f, 3088.350098f, -116.501999f);		break;// Magtheridon's Lair
		case 66:	EventTeleport( Plr, 530, 830.542908f, 6865.445801f, -63.785503f);		break;// Serpentshrine Cavern
		case 67:	EventTeleport( Plr, 530, 3549.424072f, 5179.854004f, -4.430779f);		break; // Gruul's Lair
		case 68: 	EventTeleport( Plr, 530, 3087.310059f, 1373.790039f, 184.643005f);		break;// The Eye
		case 69: // Black Temple
				// EventTeleport( Plr, 530, -3609.739990, 328.252014, 37.307701 );
				EventTeleport( Plr, 564, 97.0894f, 1001.96f, -86.8798f);
			break;
        case 70: {Plr->TeleportTo(0, -11208.299805f, 1672.520020f, 24.660000f, 4.552170f); /*36 Deadmines */ }break;
        case 71: {Plr->TeleportTo(0, -6620.479980f, -3765.189941f, 266.226013f, 3.135310f); /*70 Uldaman */}break;
        case 72: {Plr->TeleportTo(0, -5163.330078f, 927.622986f, 257.187988f, 0.000000f); /*90 Gnomeregan */}break;
        case 73: {Plr->TeleportTo(0, -10175.099609f, -3995.149902f, -112.900002f, 2.959380f); /*109 Sunken Temple */}break;
        case 74: {Plr->TeleportTo(0, -7179.629883f, -923.666992f, 166.416000f, 1.840970f); /*230 Blackrock Depths */}break;
        case 75: {Plr->TeleportTo(1, -1186.979980f, 2875.949951f, 85.725800f, 1.784430f); /*349 Maraudon */}break;
        case 76: {Plr->TeleportTo(1, 1813.489990f, -4418.580078f, -18.570000f, 1.780000f); /*389 Ragefire Chasm */}break;
        case 77: {Plr->TeleportTo(1, -3520.649902f, 1077.719971f, 161.138000f, 1.500900f);/*429 Dire Maul*/}break;
        case 78: {Plr->TeleportTo(1, -8242.669922f, 1992.060059f, 129.072006f, 4.030660f); /*531 Ahn'Qiraj Temple*/}break;
        case 79: {Plr->TeleportTo(1, -4658.120117f, -2526.350098f, 81.491997f, 1.259780f); /*129 Razorfen Downs*/}break;
        case 80:     // Alliance
				ClearGossipMenuFor(Plr);
				AddGossipItemForArcemu( Plr, 5, "Westfall(Santinel Hill) 10-20", 120);
				AddGossipItemForArcemu( Plr, 5, "Redridge(Lakeshire) 15-25", 121);
				AddGossipItemForArcemu( Plr, 5, "Hillsbrad(Southshore) 20-30", 122);
				AddGossipItemForArcemu( Plr, 5, "Duskwood(Darkshire)) 18-30", 123);
				AddGossipItemForArcemu( Plr, 5, "STV(Rebel Camp) 30-45", 124);
				AddGossipItemForArcemu( Plr, 5, "Booty Bay", 125);
				AddGossipItemForArcemu( Plr, 5, "The Hinterlands(Aerie Peak) 40-50", 236);
				AddGossipItemForArcemu( Plr, 5, "Tanaris(Gadgetzan) 40-50", 126);
				AddGossipItemForArcemu( Plr, 5, "Felwood 48-55", 127);
				AddGossipItemForArcemu( Plr, 5, "Blasted Lands 45-55", 128);
				AddGossipItemForArcemu( Plr, 5, "Winterspring(Everlook) 55-60", 129);
				AddGossipItemForArcemu( Plr, 0, "[Back]", 1400);
				SendGossipMenuFor(Plr,9,me);
			break;
        case 81:     // Maps Horde
            ClearGossipMenuFor(Plr);
            AddGossipItemForArcemu(Plr, 5, "Crossroads 10-20", 130);
            AddGossipItemForArcemu(Plr, 5, "Ashenvale 18-30", 131);
            AddGossipItemForArcemu(Plr, 5, "Hillsbrad(Tarren Mill) 20-30", 132);
            AddGossipItemForArcemu(Plr, 5, "T.Needles(Darkcloud) 25-35", 133);
            AddGossipItemForArcemu(Plr, 5, "Booty Bay", 134);
            AddGossipItemForArcemu(Plr, 5, "Blasted Lands 45-57", 234);
            AddGossipItemForArcemu(Plr, 5, "Tanaris(Gadgetzan) 40-50", 135);
            AddGossipItemForArcemu(Plr, 5, "Ungoro 48-55", 136);
            AddGossipItemForArcemu(Plr, 5, "Sillithus 55-60", 137);
            AddGossipItemForArcemu(Plr, 5, "Felwood 48-55", 138);
            AddGossipItemForArcemu(Plr, 5, "Winterspring(Everlook) 55-60", 139);
            AddGossipItemForArcemu(Plr, 0, "[Back]", 1400);
            SendGossipMenuFor(Plr, 9, me);
            break;

        case 85:	EventTeleport(Plr, 0, 3760, -2578, 131);							break;
        case 86:	EventTeleport(Plr, 0, -13845, 2714, 53);							break;
        case 94:
            CloseGossipMenuFor(Plr);
            GiveFreeStart(Plr, false, false);
            break;
        case 95:
        {
            CloseGossipMenuFor(Plr);
            WorldLocation homeLoc;
            uint32 areaId = Plr->GetAreaId();
            homeLoc = Plr->GetWorldLocation();
            Plr->SetHomebind(homeLoc, areaId);

            WorldPacket data(SMSG_BINDPOINTUPDATE, 4 * 3 + 4 + 4);
            data << TaggedPosition<Position::XYZ>(homeLoc);
            data << uint32(homeLoc.GetMapId());
            data << uint32(areaId);
            Plr->SendDirectMessage(&data);

            TC_LOG_DEBUG("spells", "EffectBind: New homebind X: %f, Y: %f, Z: %f, MapId: %u, AreaId: %u",
                homeLoc.GetPositionX(), homeLoc.GetPositionY(), homeLoc.GetPositionZ(), homeLoc.GetMapId(), areaId);

            // zone update
            data.Initialize(SMSG_PLAYERBOUND, 8 + 4);
            data << uint64(Plr->GetGUID());
            data << uint32(areaId);
            Plr->SendDirectMessage(&data);
            //                Plr->GetSession()->SendInnkeeperBind(pCreature);
        }   break;// Bind Position
        case 96:
            CloseGossipMenuFor(Plr);
            CheckSQLQuestBroken(Plr, me);
            break;
        case 97: // Remove res sickness
            CloseGossipMenuFor(Plr);
            Plr->RemoveAurasDueToSpell(15007);
            me->Whisper(std::string("We have removed your Resurrection Sickness."), LANG_UNIVERSAL, Plr);
            break;
        case 98:	EventTeleport(Plr, 631, -549.212f, 2211.01f, 539.371f);	break;
        case 110: {Plr->TeleportTo(1, -740.059021f, -2214.229980f, 16.137400f, 5.680000f); /*43 Wailing Caverns*/}break;
        case 111: {Plr->TeleportTo(1, -4464.919922f, -1666.239990f, 81.892799f, 4.288270f); /*47 Razorfen Kraul*/}break;
        case 112: {Plr->TeleportTo(1, 4247.740234f, 745.879028f, -24.529900f, 4.582800f); /*48 Blackfathom Deeps*/}break;
        case 113: {Plr->TeleportTo(1, -8334.980469f, -4055.320068f, -207.737000f, 3.274310f); /*560 The Escape From Durnholde*/}break;
        case 114: {Plr->TeleportTo(530, 12560.799805f, -6774.589844f, 15.080000f, 6.250000f); /*580 The Sunwell*/}break;
        case 115: {Plr->TeleportTo(530, 12884.599609f, -7336.169922f, 65.480003f, 1.090000f); /*585 Magister's Terrace*/}break;
        case 116: {Plr->TeleportTo(571, 4774.470215f, -2028.040039f, 229.373001f, 4.645000f); /*600 Drak'Tharon Keep*/}break;
        case 117: {Plr->TeleportTo(571, 6970.020020f, -4402.089844f, 441.578003f, 3.845000f); /*604 Gundrak*/}break;
        case 118: {Plr->TeleportTo(571, 3641.840088f, 2032.939941f, 2.470000f, 1.178000f); /*619 Ahn'kahet: The Old Kingdom*/}break;

        case 120:	EventTeleport( Plr, 0, -10520.672852f, 1070.661377f, 54.476643f);	break;//westfall
		case 121:	EventTeleport( Plr, 0, -9474.256836f, -2266.271484f, 74.542351f);	break;//redrige
		case 122:	EventTeleport( Plr, 0, -691.75f, -571.38f, 25);			            break;//southshore
		case 123:	EventTeleport( Plr, 0, -10438.022461f, -1169.694702f, 27.711634f);	break;//darkshire
		case 124:	EventTeleport( Plr, 0, -11312.692383f, -197.921173f, 76.107666f);		break;//rebel
		case 125:	EventTeleport( Plr, 0, -14302, 520.451721f, 8.668963f);				break;//BootyBay
		case 236:	EventTeleport( Plr, 0, 283.66f, -2127.16f, 119.962288f);				break;//Aerie Peak
		case 126:	EventTeleport( Plr, 1, -7164.650879f, -3795.239014f, 9.125962f);		break;//Tanaris
		case 127:	EventTeleport( Plr, 1, 6220.294922f, -1957.315308f, 570.255615f);		break;//Felwood
		case 128:	EventTeleport( Plr, 0, -11017.627930f, -3320.720947f, 60.680126f);	break;//Blasted Lands
		case 129:	EventTeleport( Plr, 1, 6718.615723f, -4675.737305f, 720.833557f);		break;//Winterspring
		case 130: 	EventTeleport( Plr, 1, -442, -2632.331543f, 95.534744f);				break;// XR
		case 131:   EventTeleport( Plr, 1, 2271.131348f, -2546.675781f, 98);		break;//Ashenvale
		case 132:   EventTeleport( Plr, 0, -31.493298f, -920.824158f, 54.640732f);			break;//tarren mill
		case 133:	EventTeleport( Plr, 1, -5100.577148f, -1945.574219f, 88.742935f);		break;//darkcloud
		case 134:	EventTeleport( Plr, 0, -14302, 520.451721f, 8.668963f);				break;//BootyBay
		case 234:	EventTeleport( Plr, 0, -10859, -2940, 13.294115f);					break;//BLands
		case 135:	EventTeleport( Plr, 1, -7164.650879f, -3795.239014f, 9.125962f);		break;//Tanaris
		case 136:	EventTeleport( Plr, 1, -6158.600098f, -1093.307007f, -205.555405f);		break;//Ungoro
		case 137:	EventTeleport( Plr, 1, -6836.545898f, 757.019226f, 42.706440f);			break;//Sillithus
		case 138:	EventTeleport( Plr, 1, 5124.594238f, -338.450073f, 356.489868f);		break;//Felwood
		case 139:	EventTeleport( Plr, 1, 6718.615723f, -4675.737305f, 720.833557f);		break;//Winterspring
        case 500:	 //northrend locations
                ClearGossipMenuFor(Plr);
                AddGossipItemForArcemu( Plr, 5, "Borean Tundra (68-72)", 501);
				AddGossipItemForArcemu( Plr, 5, "Crystalsong Forest (74-76)", 502);
				AddGossipItemForArcemu( Plr, 5, "Dragonblight (71-74)", 504);
				AddGossipItemForArcemu( Plr, 5, "Grizzly Hills (73-75)", 505);
				AddGossipItemForArcemu( Plr, 5, "Howling Fjord (68-72)", 506);
				AddGossipItemForArcemu( Plr, 5, "Hrothgar's Landing (77-80)", 507);
				AddGossipItemForArcemu( Plr, 5, "Icecrown (77-80)", 508);
				AddGossipItemForArcemu( Plr, 5, "Sholazar Basin (75-78)", 509);
				AddGossipItemForArcemu( Plr, 5, "The Storm Peaks (76-80)", 510);
				AddGossipItemForArcemu( Plr, 5, "Wintergrasp (77-80)", 511);
				AddGossipItemForArcemu( Plr, 5, "Zul'Drak (74-77)", 512);
                AddGossipItemForArcemu( Plr, 0, "[Back]", 1400);
                SendGossipMenuFor(Plr,9,me);
            break;
			
	
		case 501:	EventTeleport( Plr, 571, 2874, 5431, 57);		break; //Borean Tundra
		case 502:	EventTeleport( Plr, 571, 5408, 462, 172);		break; //Crystalsong Forest
		case 503:	EventTeleport( Plr, 571, 5748, 569, 651.5f );		break; //Dalaran
		case 504:	EventTeleport( Plr, 571, 3575.07f, 856.02f, 117.44f);		break; //Dragonblight
		case 505:	EventTeleport( Plr, 571, 3622, -3419, 241);		break; //Grizzly Hills
		case 506:	
			if (Plr->GetTeam() == HORDE)
				EventTeleport( Plr, 571, 432.061f, -4558.01f, 245.784f);	//Howling Fjord 1
			else
				EventTeleport( Plr, 571, 595.124f, -5081.49f, 5.55386f);	//Howling Fjord 2
			break;	
		case 507:	EventTeleport( Plr, 571, 10314.14f, 778.87f, 74.37f);		break; //Hrothgar's Landing
		case 508:	EventTeleport( Plr, 571, 7240.71f, 2160.98f, 564.96f);		break; //Icecrown
		case 509:	EventTeleport( Plr, 571, 5464.70f, 5000.89f, -131.24f);		break; //Sholazar Basin
		case 510:	EventTeleport( Plr, 571, 6233, -1049, 414);		break; //The Storm Peaks
		case 511:	EventTeleport( Plr, 571, 4510.39f, 2765.08f, 389.45f);		break; //Wintergrasp
		case 512:	EventTeleport( Plr, 571, 5440, -1247, 249);		break; //Zul'Drak

		case 250:   EventTeleport( Plr, 530, 13007.82f, -6913.34f, 9.583396f);				break;//Quel
		case 200:	Plr->GetSession()->SendListInventory(me->GetGUID());					break;// Repair
		case 210:   EventTeleport( Plr, 1, -2717.19f, -4987.04f, 26.866404f);				break;//PvP Mall
		case 211:   EventTeleport( Plr, 1, -2677.69f, -4810.75f, 18.402950f);				break;//PvP Mall
		case 300:     // Nortrend Instances
                ClearGossipMenuFor(Plr);
                AddGossipItemForArcemu( Plr, 5, "Utgarde Instances", 301);
				AddGossipItemForArcemu( Plr, 5, "Nexus Instances", 302);
				AddGossipItemForArcemu( Plr, 5, "Ulduar Instances", 303);
				AddGossipItemForArcemu( Plr, 5, "Drak'theron Keep", 304);
				AddGossipItemForArcemu( Plr, 5, "COT: Stratholme Past", 305);
				AddGossipItemForArcemu( Plr, 5, "Azjol-Nerub Instances", 306);
//				AddGossipItemForArcemu( Plr, 5, "Northrend Battleground", 307);
				AddGossipItemForArcemu( Plr, 5, "The Violet Hold", 308);
				AddGossipItemForArcemu( Plr, 5, "The Obsidian Sanctum", 309);
				AddGossipItemForArcemu( Plr, 5, "Trial of the Champion", 310);
				AddGossipItemForArcemu( Plr, 5, "Trial of the Crusader", 313);
				AddGossipItemForArcemu( Plr, 5, "Icecrown Instances", 314);
				AddGossipItemForArcemu( Plr, 5, "Icecrown Raid", 315);
				AddGossipItemForArcemu( Plr, 5, "Vault of Archavon", 316);
				AddGossipItemForArcemu( Plr, 5, "Ruby Sanctum", 317);
                AddGossipItemForArcemu( Plr, 0, "[Back]", 99);
                SendGossipMenuFor(Plr,9,me);
            break;

		case 313:                EventTeleport( Plr, 571, 8516, 731, 558.25f);			break;//Trial of Crusader
		case 314:                EventTeleport( Plr, 571, 5628, 2035, 798.28f);			break;//Icecrown Instances
		case 315:                EventTeleport( Plr, 571, 6118.17f, 2223.15f, 515.34f);		break;//Icecrown Raid
		case 317:                EventTeleport( Plr, 571, 3597, 201, -114);				break;//Ruby Sanctum
		
		case 301:     // Utgarde Instances
                ClearGossipMenuFor(Plr);
                AddGossipItemForArcemu( Plr, 5, "Utgarde Keep", 311);
				AddGossipItemForArcemu( Plr, 5, "Utgarde Pinnacle", 312);
				AddGossipItemForArcemu( Plr, 0, "[Back]", 99);
                SendGossipMenuFor(Plr,9,me);
            break;
		case 311:                EventTeleport( Plr, 571, 1220, -4864, 41.248f);			break;//Utgarde Keep
		case 312:                EventTeleport( Plr, 571, 1252, -4854, 215.80f);			break;//Utgarde Pinnacle
		case 302:     // Nexus Instances
                ClearGossipMenuFor(Plr);
                AddGossipItemForArcemu( Plr, 5, "The Nexus", 321);
				AddGossipItemForArcemu( Plr, 5, "The Oculus", 322);
				AddGossipItemForArcemu( Plr, 5, "The Eye of eternity", 323);
				AddGossipItemForArcemu( Plr, 0, "[Back]", 99);
                SendGossipMenuFor(Plr,9,me);
            break;
		case 321:                EventTeleport( Plr, 571, 3891, 6985, 69.49f);			break;//The Nexus
		case 322:                EventTeleport( Plr, 571, 3866, 6986, 153);				break;//The Occulus
					//the eye of eternity
		case 323:				EventTeleport( Plr,  571, 3864, 6984, 107);				break; 
		case 303:     //Ulduar Instances
                ClearGossipMenuFor(Plr);
                AddGossipItemForArcemu( Plr, 5, "Halls of Stone", 331);
				AddGossipItemForArcemu( Plr, 5, "Halls of Lightning", 332);
				AddGossipItemForArcemu( Plr, 5, "Ulduar Raid", 333);
				AddGossipItemForArcemu( Plr, 0, "[Back]", 99);
                SendGossipMenuFor(Plr,9,me);
            break;
		case 331:                EventTeleport( Plr, 599, 1153, 811, 196);				break;//Halls of Stone
		case 332:                EventTeleport( Plr, 602, 1333, -237, 41);				break;//Halls of Lightning
		case 333:                EventTeleport( Plr, 571, 9276.140f, -1116.917f, 1216.117f);				break;//Uldar Raid
		case 304:     // Drak'theron Keep Instances
                ClearGossipMenuFor(Plr);
                AddGossipItemForArcemu( Plr, 5, "Hall of Departure", 341);
				AddGossipItemForArcemu( Plr, 5, "Gun'Drak", 342);
				AddGossipItemForArcemu( Plr, 0, "[Back]", 99);
                SendGossipMenuFor(Plr,9,me);
            break;
		case 341:                EventTeleport( Plr, 571, 4774, -2038, 230);				break;//Hall of Departure
		case 342:                EventTeleport( Plr, 604, 1947.18f, 682.82f, 135.433853f);	break;//Gun'Drak
		case 305:     // Caverns of Time: Stratholme Past
                ClearGossipMenuFor(Plr);
                AddGossipItemForArcemu( Plr, 5, "Outer Instance Entrance", 351);
				AddGossipItemForArcemu( Plr, 5, "Bridge to Stratholme", 352);
				AddGossipItemForArcemu( Plr, 5, "Crusaders Square", 353);
				AddGossipItemForArcemu( Plr, 5, "Festival Lane", 354);
				AddGossipItemForArcemu( Plr, 5, "Inn", 355);
				AddGossipItemForArcemu( Plr, 5, "Plaguewood Tower", 356);

				AddGossipItemForArcemu( Plr, 0, "[Back]", 99);
                SendGossipMenuFor(Plr,9,me);
            break;
		case 351:                EventTeleport( Plr, 1, -8638, -4382, -207);				break;//Outer Instance Entrance
		case 352:                EventTeleport( Plr, 595, 1967, 1287, 146);				break;//Bridge to Stratholme
		case 353:                EventTeleport( Plr, 595, 2300, 1495, 129);				break;//Crusaders Square
		case 354:                EventTeleport( Plr, 595, 2258, 1153, 139);				break;//Festival Lane
		case 355:                EventTeleport( Plr, 595, 1560, 603, 100);				break;//Inn
		case 356:                EventTeleport( Plr, 595, 1654, 1611, 117);				break;//Plaguewood Tower
		case 306:     //Azjol-Nerub Instances
                ClearGossipMenuFor(Plr);
                AddGossipItemForArcemu( Plr, 5, "Azjol-Nerub", 361);
				AddGossipItemForArcemu( Plr, 5, "Ahn'kahet: The Old Kingdom", 362);
				AddGossipItemForArcemu( Plr, 0, "[Back]", 99);
                SendGossipMenuFor(Plr,9,me);
            break;
        case 361:                EventTeleport(Plr, 571, 3739, 2163, 37.2f);				break;//Azjol-Nerub
        case 362:                EventTeleport(Plr, 571, 3647, 2045, 1.79f);				break;//Ahn'kahet: The Old Kingdom
                                                                                              //The Violet Hold
        case 308:              EventTeleport(Plr, 608, 1838, 804, 44.23f);				break;
            //The Obsidian Sanctum
        case 309:              EventTeleport(Plr, 571, 3457, 262, -112);					break;
            //Trial of the Champion
        case 310:              EventTeleport(Plr, 571, 8571, 792, 559);					break;
            //Vault of Archavon
        case 316:              EventTeleport(Plr, 571, 5441, 2840, 421);					break;






#if 0
	
/*		case 220://Reset Talentpoints
			{
				uint32 price = 10000;
				uint32 currentgold = Plr->GetGold();
				if (currentgold>=price)
				{
					int32 newgold = currentgold - price;
					Plr->SetGold(newgold);
					Plr->BroadcastMessage("Your talentpoints are reset!");
					Plr->Reset_Talents();
				}
				else 
					Plr->BroadcastMessage("You don't have enough money to afford a talent reset!");
			}
			break;
		case 556://Repair Items
			{
			uint64 price = 20000;
			uint64 currentgold = Plr->GetGold();
			if (currentgold>=price)
			{
				Player *p_caster = Plr;
				for( int i = 0; i < EQUIPMENT_SLOT_END; i++ )
				{
					Item *pItem = p_caster->GetItemInterface()->GetInventoryItem( i );
					if( pItem != NULL )
					{
						if( pItem->IsContainer() )
						{
							Container *pContainer = static_cast<Container*>( pItem );
							for( unsigned int j = 0; j < pContainer->GetProto()->ContainerSlots; ++j )
							{
								pItem = pContainer->GetItem( j );
								if( pItem != NULL )
								{
		//							int32 cost = 0;
		//							if( cost <= (int32)p_caster->GetUInt32Value( PLAYER_FIELD_COINAGE ) )
									{
		//								p_caster->ModUnsigned32Value( PLAYER_FIELD_COINAGE, -cost );
										pItem->SetDurabilityToMax();
										pItem->m_isDirty = true;
									}
								}
							}
						}
						else
						{
							if( pItem->GetProto()->MaxDurability > 0 && i < INVENTORY_SLOT_BAG_END && pItem->GetDurability() <= 0 )
							{
		//						int32 cost = 0;
		//						if( cost <= (int32)p_caster->GetUInt32Value( PLAYER_FIELD_COINAGE ) )
								{
		//							p_caster->ModUnsigned32Value( PLAYER_FIELD_COINAGE, -cost );
									pItem->SetDurabilityToMax();
									pItem->m_isDirty = true;
								}
								p_caster->ApplyItemMods( pItem, i, true );
							}
							else
							{
								int64 cost = 0;
								if( cost <= p_caster->GetGold( ) )
								{
									p_caster->ModGold( -cost );
									pItem->SetDurabilityToMax();
									pItem->m_isDirty = true;
								}
							}
						}
					}
				}
				Plr->BroadcastMessage("Your items are repaired!");
			}
			else
			{
				Plr->BroadcastMessage("You need 2 gold to repair your items!");
			}
			ClearGossipMenuFor(Plr);
			AddGossipItemForArcemu( Plr, 0, "[Back]", 369);
		    SendGossipMenuFor(Plr,3673,me);
			}
		break;*/
/*
	case 369: //players tools and fixes menu
			ClearGossipMenuFor(Plr);
			AddGossipItemForArcemu( Plr, 0, "Fix Professions", 555);
//			AddGossipItemForArcemu( Plr, 0, "Learn prof specialization", 557);
			AddGossipItemForArcemu( Plr, 0, "Repair all my Items", 556);
			AddGossipItemForArcemu( Plr, 0, "Remove shaman totems", 558);
			AddGossipItemForArcemu( Plr, 11, "Remove Resurrection Sickness", 97);
//			AddGossipItemForArcemu( Plr, 9, "Make This Place Your Home", 95);
//			AddGossipItemForArcemu( Plr, 10, "Reset Talentpoints", 220);
			AddGossipItemForArcemu( Plr, 0, "Learn class missing Spells and Proficiencies", 603);
			AddGossipItemForArcemu( Plr, 0, "Disband Arena Team 2v2", 606);
			AddGossipItemForArcemu( Plr, 0, "Disband Arena Team 3v3", 607);
			AddGossipItemForArcemu( Plr, 0, "Disband Arena Team 5v5", 608);
			AddGossipItemForArcemu( Plr, 0, "Reset Daily quests", 609);
			AddGossipItemForArcemu( Plr, 0, "Watch Wow Movies", 610);
			AddGossipItemForArcemu( Plr, 0, "[Back]", 99);
			SendGossipMenuFor(Plr,3673,me);
		break;
        */
/*	case 606:
		{
			if( Plr->m_arenaTeams[ ARENA_TEAM_TYPE_2V2 ] && Plr->m_arenaTeams[ ARENA_TEAM_TYPE_2V2 ]->m_leader == Plr->GetLowGUID() )
			{
				Plr->m_arenaTeams[ ARENA_TEAM_TYPE_2V2 ]->Destroy();
				Plr->BroadcastMessage("Your Arena team has been disbanded!");
			}
			else
				Plr->BroadcastMessage("Could not find arena team to disband!");
			Plr->CloseGossip();
		}break;
	case 607:
		{
			if( Plr->m_arenaTeams[ ARENA_TEAM_TYPE_3V3 ] && Plr->m_arenaTeams[ ARENA_TEAM_TYPE_3V3 ]->m_leader == Plr->GetLowGUID() )
			{
				Plr->m_arenaTeams[ ARENA_TEAM_TYPE_3V3 ]->Destroy();
				Plr->BroadcastMessage("Your Arena team has been disbanded!");
			}
			else
				Plr->BroadcastMessage("Could not find arena team to disband!");
			Plr->CloseGossip();
		}break;
	case 608:
		{
			if( Plr->m_arenaTeams[ ARENA_TEAM_TYPE_5V5 ] && Plr->m_arenaTeams[ ARENA_TEAM_TYPE_5V5 ]->m_leader == Plr->GetLowGUID() )
			{
				Plr->m_arenaTeams[ ARENA_TEAM_TYPE_5V5 ]->Destroy();
				Plr->BroadcastMessage("Your Arena team has been disbanded!");
			}
			else
				Plr->BroadcastMessage("Could not find arena team to disband!");
			Plr->CloseGossip();
		}break;
	case 609:	//check player quests and see which ones should be moved to the repeatable quests list
		{
			bool found_any = false;
			std::set<uint32>::iterator itr,itr2;
			for(itr = Plr->m_finishedQuests.begin(); itr != Plr->m_finishedQuests.end(); )
			{
				uint32 questid = *itr;
				itr2 = itr;
				itr++;
				Quest *q = QuestStorage.LookupEntry( questid );
				if( q )
				{
					if( q->is_repeatable == arcemu_QUEST_REPEATABLE_DAILY || q->is_repeatable == arcemu_QUEST_REPEATABLE_WEEKLY )
					{
						if( q->is_repeatable == arcemu_QUEST_REPEATABLE_DAILY )
							Plr->PushToFinishedDailies( questid );
						if( q->is_repeatable == arcemu_QUEST_REPEATABLE_DAILY )
							Plr->PushToFinishedWeeklies( questid );
						Plr->BroadcastMessage("Force finished quest : %s",q->title);
						Plr->m_finishedQuests.erase( itr2 );
						found_any = true;
					}
				}
			}
			if( found_any )
				Plr->BroadcastMessage("You should be able to finish these repeatable quest after next reset interval");
			else
				Plr->BroadcastMessage("Could not find any quests that need to forced set as repeatable");
			Plr->CloseGossip();
		}break;*/
/*
	case 610: //players tools and fixes menu
			ClearGossipMenuFor(Plr);
			AddGossipItemForArcemu( Plr, 0, "Intro", 630);
			AddGossipItemForArcemu( Plr, 0, "Burning Crusade", 631);
			AddGossipItemForArcemu( Plr, 0, "WOTLK", 632);
			AddGossipItemForArcemu( Plr, 0, "At the wrath gate", 633);
			AddGossipItemForArcemu( Plr, 0, "Fall of the Lich King", 634);
			AddGossipItemForArcemu( Plr, 0, "Cataclysm", 635);
			AddGossipItemForArcemu( Plr, 0, "Worgen outro", 636);
			AddGossipItemForArcemu( Plr, 0, "Goblin Outro", 637);
			SendGossipMenuFor(Plr,3673,me);
		break; */
/*	case 630: Plr->CloseGossip(); Plr->SendTriggerMovie(2);  break;
	case 631: Plr->CloseGossip(); Plr->SendTriggerMovie(27); break;
	case 632: Plr->CloseGossip(); Plr->SendTriggerMovie(18); break;
	case 633: Plr->CloseGossip(); Plr->SendTriggerMovie(14); break;
	case 634: Plr->CloseGossip(); Plr->SendTriggerMovie(16); break;
	case 635: Plr->CloseGossip(); Plr->SendTriggerMovie(23); break;
	case 636: Plr->CloseGossip(); Plr->SendTriggerMovie(21); break;
	case 637: Plr->CloseGossip(); Plr->SendTriggerMovie(22); break;*/
/*	case 555: //Profession Fixes menu
			ClearGossipMenuFor(Plr);
			AddGossipItemForArcemu( Plr, 8, "Fix enchanting", 596);
			AddGossipItemForArcemu( Plr, 8, "Fix tailoring", 595);
			AddGossipItemForArcemu( Plr, 8, "Fix engineering", 594);
			AddGossipItemForArcemu( Plr, 8, "Fix jewelcrafting", 593);
			AddGossipItemForArcemu( Plr, 8, "Fix alchemy", 592);
			AddGossipItemForArcemu( Plr, 8, "Fix black smith",591);
			AddGossipItemForArcemu( Plr, 8, "Fix herbalism", 590);
			AddGossipItemForArcemu( Plr, 8, "Fix leather working", 589);
			AddGossipItemForArcemu( Plr, 8, "Fix mining", 588);
			AddGossipItemForArcemu( Plr, 8, "Fix skinning", 587);
			AddGossipItemForArcemu( Plr, 8, "Fix cooking", 586);
			AddGossipItemForArcemu( Plr, 8, "Fix first aid", 585);
			AddGossipItemForArcemu( Plr, 8, "Fix fishing", 584);
			AddGossipItemForArcemu( Plr, 8, "Fix inscription", 597);
			AddGossipItemForArcemu( Plr, 8, "Fix archaeology", 598);
			AddGossipItemForArcemu( Plr, 0, "[Back]", 99);
			SendGossipMenuFor(Plr,3673,me);
		break;*/
/*
	case 600:
			ClearGossipMenuFor(Plr);
			AddGossipItemForArcemu( Plr, 0, "Reset Faction Standings to new char", 559);
			AddGossipItemForArcemu( Plr, 0, "Remove profession skills and give 2 slots back(in case dual spec bug)", 601);
//			AddGossipItemForArcemu( Plr, 0, "Reset all spells to as new char(including professions). In case missing racial or buged chars.", 602);
//            AddGossipItemForArcemu( Plr, 0, "Reset all spells to as new char(including professions). In case missing racial or buged chars.",0,0,"This will reset mounts and professions. You will not get a refund! Continue ?",0,0,602);
			AddGossipItemForArcemu( Plr, 0, "Remove all auras(even ones that are invisible).Strange bugs", 604);
			AddGossipItemForArcemu( Plr, 0, "Resend achievement rewards.(10k gold antispam prot)", 605);
			AddGossipItemForArcemu( Plr, 0, "Remove A Profession", 560);
			AddGossipItemForArcemu( Plr, 0, "[Back]", 99);
			SendGossipMenuFor(Plr,3673,me);
		break;
	case 560: //Profession Fixes menu
			ClearGossipMenuFor(Plr);
			AddGossipItemForArcemu( Plr, 8, "Remove enchanting", 561);
			AddGossipItemForArcemu( Plr, 8, "Remove tailoring", 562);
			AddGossipItemForArcemu( Plr, 8, "Remove engineering", 563);
			AddGossipItemForArcemu( Plr, 8, "Remove jewelcrafting", 564);
			AddGossipItemForArcemu( Plr, 8, "Remove alchemy", 565);
			AddGossipItemForArcemu( Plr, 8, "Remove black smith",566);
			AddGossipItemForArcemu( Plr, 8, "Remove herbalism", 567);
			AddGossipItemForArcemu( Plr, 8, "Remove leather working", 568);
			AddGossipItemForArcemu( Plr, 8, "Remove mining", 569);
			AddGossipItemForArcemu( Plr, 8, "Remove skinning", 570);
			AddGossipItemForArcemu( Plr, 8, "Remove cooking", 571);
			AddGossipItemForArcemu( Plr, 8, "Remove first aid", 572);
			AddGossipItemForArcemu( Plr, 8, "Remove fishing", 573);
			AddGossipItemForArcemu( Plr, 8, "Remove inscription", 574);
			AddGossipItemForArcemu( Plr, 8, "Remove archaeology", 575);
			AddGossipItemForArcemu( Plr, 0, "[Back]", 99);
			SendGossipMenuFor(Plr,3673,me);
		break;
*/
/*
	case 559: //Reset Faction Standing to new char
		{
			Plr->ClearReputations();
//			Plr->reputationByListId.empty();
			Plr->_InitialReputation();
//			Plr->smsg_InitialFactions();
			Plr->BroadcastMessage("Your faction standing has been reseted.Needs a relog!");
			Plr->CloseGossip();
		}break;
	case 605:
		{
			if( Plr->GetGold() < 100000000 )
			{
				Plr->BroadcastMessage("you need 10k gold to get rewards again for achievements!");
				Plr->CloseGossip();
				return;
			}
			Plr->ModGold( -100000000 );
			std::map<uint32,AchievementVal*>::iterator itr;
			for( itr = Plr->m_sub_achievement_criterias.begin(); itr != Plr->m_sub_achievement_criterias.end(); itr++ )
				if( itr->second && itr->second->completed_at_stamp != 0 )
				{
					AchievementCriteriaEntry *achic = dbcAchievementCriteriaStore.LookupEntry( itr->first );
					AchievementEntry *achi = dbcAchievementStore.LookupEntry( achic->referredAchievement );
					Plr->GiveAchievementReward( achi );
				}
			Plr->BroadcastMessage("Your achievements have been reawarded!");
			Plr->CloseGossip();
		}break;
*/
	//make sure player has 2 profession points and does not have any professions learned. Does not delete recepies
/*	case 604:
		uint32 possible_professions[] = {SKILL_INSCRIPTION,SKILL_ENCHANTING,SKILL_TAILORING,SKILL_ENGINEERING,SKILL_JEWELCRAFTING,SKILL_ALCHEMY,SKILL_BLACKSMITHING,SKILL_HERBALISM,SKILL_LEATHERWORKING,SKILL_MINING,SKILL_SKINNING};
		uint32 index_count = sizeof( possible_professions ) / sizeof( uint32 );
		break;*/
	//make sure player has 2 profession points and does not have any professions learned
/*
	case 601:
		{
			//still need to add here the profession specializations 
			uint32 possible_professions[] = {56273,9787,10660,28672,26797,2656,26801,31252,28675,59390,26798,53042,51005,17039,17040,17041,20222,20219,55534,2580,2383,28677,10658,10656,13262,52175,9788,8613,8617,8618,10768,32678,50305,2575,2576,3564,10248,29354,50310,2108,3104,3811,10662,32549,51302,2366,2368,3570,11993,28695,50300,2018,3100,3538,9785,29844,51300,2259,3101,3464,11611,28596,51304,25229,25230,28894,28895,28897,51311,4036,4037,4038,12656,30350,51306,3908,3909,3910,12180,26790,51309,7411,7412,7413,13920,28029,51313,45357,45358,45359,45360,45361,45363};
			uint32 index_count = sizeof( possible_professions ) / sizeof( uint32 );
			for(uint32 i=0;i<index_count;i++)
			{
				Plr->removeSpell( possible_professions[i], false, false, 0 );
				Plr->removeDeletedSpell( possible_professions[i] );
			}
			Plr->removeSpellByHashName( SPELL_HASH_MASTER_OF_ANATOMY );
			Plr->removeSpellByHashName( SPELL_HASH_TOUGHNESS );
			Plr->_RemoveSkillLine( SKILL_INSCRIPTION, true );
			Plr->_RemoveSkillLine( SKILL_ENCHANTING, true );
			Plr->_RemoveSkillLine( SKILL_TAILORING, true );
			Plr->_RemoveSkillLine( SKILL_ENGINEERING, true );
			Plr->_RemoveSkillLine( SKILL_JEWELCRAFTING, true );
			Plr->_RemoveSkillLine( SKILL_ALCHEMY, true );
			Plr->_RemoveSkillLine( SKILL_BLACKSMITHING, true );
			Plr->_RemoveSkillLine( SKILL_HERBALISM, true );
			Plr->_RemoveSkillLine( SKILL_LEATHERWORKING, true );
			Plr->_RemoveSkillLine( SKILL_MINING, true );
			Plr->_RemoveSkillLine( SKILL_SKINNING, true );
			Plr->SetUInt32Value(PLAYER_PROFESSION_SKILL_LINE_1,0);
			Plr->SetUInt32Value(PLAYER_PROFESSION_SKILL_LINE_1+1,0);
			send_MainPage(pObject,Plr);
		}
		break;
	//remove all spells including talents from spellbook in case some spells are bugging professions menu
	case 602:
		Plr->Reset_Talents();
		Plr->Reset_Spells();
		Plr->SetUInt32Value(PLAYER_PROFESSION_SKILL_LINE_1,0);
		Plr->SetUInt32Value(PLAYER_PROFESSION_SKILL_LINE_1+1,0);
		send_MainPage(pObject,Plr);
		break;
	//like rogue dismantle,paladin resurrect,warrior stances..
	case 603:
		//armor specializations
		if( Plr->getClass() == WARRIOR )
			Plr->LearnSpell( 86526, false );		
		else if( Plr->getClass() == PALADIN )
			Plr->LearnSpell( 86525, false );		
		else if( Plr->getClass() == DEATHKNIGHT )
			Plr->LearnSpell( 86524, false );		
		else if( Plr->getClass() == ROGUE )
			Plr->LearnSpell( 86531, false );		
		else if( Plr->getClass() == HUNTER )
			Plr->LearnSpell( 86528, false );		
		else if( Plr->getClass() == DRUID )
			Plr->LearnSpell( 86530, false );		
		else if( Plr->getClass() == SHAMAN )
			Plr->LearnSpell( 86529, false );		
		else if( Plr->getClass() == WARLOCK )
			Plr->LearnSpell( 86091, false );		
		else if( Plr->getClass() == PRIEST )
			Plr->LearnSpell( 89745, false );		
		else if( Plr->getClass() == MAGE )
			Plr->LearnSpell( 89744, false );

		if( Plr->getRace() == RACE_TROLL )
		{
			Plr->LearnSpell( 26297, false );	//Berserking
			Plr->LearnSpell( 20557, false );	//Beast Slaying
			Plr->LearnSpell( 26290, false );	//Bow Specialization
		}
		else if( Plr->getRace() == RACE_BLOODELF )
		{
			Plr->removeSpell( 28734, false, false, 0 );	//mana tap
			if( Plr->getClass() == DEATHKNIGHT )
				Plr->LearnSpell( 50613, false );	//arcane torrent
			if( Plr->getClass() == DEATHKNIGHT )
				Plr->LearnSpell( 50613, false );	//arcane torrent
		}
		send_MainPage(pObject,Plr);
		break;
	//there are some strange invisible auras that remain on chars and make them bugged
	case 604:
		for(uint32 i = 0; i < MAX_PASSIVE_AURAS1(Plr); ++i)
			if( Plr->m_auras[i] != 0 ) 
				Plr->m_auras[i]->Remove();
		break;
/*	
	//the actions are not made yet
	case 557: //learn profession specialization
			ClearGossipMenuFor(Plr);
			AddGossipItemForArcemu( Plr, 8, "Armorsmithing", 5571);
			AddGossipItemForArcemu( Plr, 8, "Weaponsmithing", 5572);
			AddGossipItemForArcemu( Plr, 8, "Master Axesmithing", 5573);
			AddGossipItemForArcemu( Plr, 8, "Master Hamersmithing", 5574);
			AddGossipItemForArcemu( Plr, 8, "Master Swordsmithing", 5575);
			AddGossipItemForArcemu( Plr, 8, "Gnomish engineering",5576);
			AddGossipItemForArcemu( Plr, 8, "Goblin engineering", 5577);
			AddGossipItemForArcemu( Plr, 8, "Dragonscale Leatherworking", 5578);
			AddGossipItemForArcemu( Plr, 8, "Elemental leatherworking", 5579);
			AddGossipItemForArcemu( Plr, 8, "Tribal Leatherworking", 5580);
			AddGossipItemForArcemu( Plr, 8, "Mooncloth tailoring", 5581);
			AddGossipItemForArcemu( Plr, 8, "Shadoweave tailoring", 5582);
			AddGossipItemForArcemu( Plr, 8, "SpellFire Tailoring", 5583);
			AddGossipItemForArcemu( Plr, 0, "[Back]", 99);
			SendGossipMenuFor(Plr,3673,me);
		break;*/
/*
	case 558: //Remove shaman totems from players since in 3.3 there are totems that replace them all
		if( Plr->GetItemInterface() )
		{
			Plr->GetItemInterface()->RemoveItemAmt(5175,1);
			Plr->GetItemInterface()->RemoveItemAmt(5176,1);
			Plr->GetItemInterface()->RemoveItemAmt(5177,1);
			Plr->GetItemInterface()->RemoveItemAmt(5178,1);
			Plr->CloseGossip();
		}
		break;
	case 598: 
		resetskilland_send_menu(pObject,Plr,SKILL_ARCHAEOLOGY,getmax_profession_archaeology(Plr));		
		break;
	case 597: 
		resetskilland_send_menu(pObject,Plr,SKILL_INSCRIPTION,getmax_profession_inscription(Plr));		
		break;
	case 596: 
		resetskilland_send_menu(pObject,Plr,SKILL_ENCHANTING,getmax_profession_enchant(Plr));		
		break;
	case 595: 
		resetskilland_send_menu(pObject,Plr,SKILL_TAILORING,getmax_profession_tailor(Plr));			
		break;
	case 594: 
		resetskilland_send_menu(pObject,Plr,SKILL_ENGINEERING,getmax_profession_engineering(Plr));		
		break;
	case 593: 
		resetskilland_send_menu(pObject,Plr,SKILL_JEWELCRAFTING,getmax_profession_jewelcrafting(Plr));		
		break;
	case 592: 
		{
			resetskilland_send_menu(pObject,Plr,SKILL_ALCHEMY,getmax_profession_alchemy(Plr));			
			uint32 currentskill = Plr->_GetSkillLineCurrent(SKILL_ALCHEMY,false);
			if( currentskill > 0 )
			{
				Plr->LearnSpell( 53042 );	//right now Mixology as perk can't be learned from trainers
				Plr->CastSpell( Plr, 53042, true );
			}
		}break;
	case 591: 
		resetskilland_send_menu(pObject,Plr,SKILL_BLACKSMITHING,getmax_profession_blacksmith(Plr));		
		break;
	case 590: 
		resetskilland_send_menu(pObject,Plr,SKILL_HERBALISM,getmax_profession_herbalism(Plr));			
		break;
	case 589: 
		resetskilland_send_menu(pObject,Plr,SKILL_LEATHERWORKING,getmax_profession_leatherwork(Plr));	
		break;
	case 588: 
		resetskilland_send_menu(pObject,Plr,SKILL_MINING,getmax_profession_mining(Plr));			
		break;
	case 587: 
		resetskilland_send_menu(pObject,Plr,SKILL_SKINNING,getmax_profession_skinning(Plr));			
		break;
	case 586: 
		resetskilland_send_menu(pObject,Plr,SKILL_COOKING,getmax_profession_cooking(Plr));			
		break;
	case 585: 
		resetskilland_send_menu(pObject,Plr,SKILL_FIRST_AID,getmax_profession_firstaid(Plr));			
		break;
	case 584: 
		resetskilland_send_menu(pObject,Plr,SKILL_FISHING,getmax_profession_fishing(Plr));			
		break;
	case 561:
			Plr->_RemoveSkillLine( SKILL_ENCHANTING, true );
			if( Plr->GetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 ) == SKILL_ENCHANTING )
				Plr->SetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1, 0 );
			if( Plr->GetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 + 1 ) == SKILL_ENCHANTING )
				Plr->SetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 + 1, 0 );
			Plr->CloseGossip();
		break;
	case 562:
			Plr->_RemoveSkillLine( SKILL_TAILORING, true );
			if( Plr->GetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 ) == SKILL_TAILORING )
				Plr->SetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1, 0 );
			if( Plr->GetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 + 1 ) == SKILL_TAILORING )
				Plr->SetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 + 1, 0 );
			Plr->CloseGossip();
		break;
	case 563:
			Plr->_RemoveSkillLine( SKILL_ENGINEERING, true );
			if( Plr->GetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 ) == SKILL_ENGINEERING )
				Plr->SetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1, 0 );
			if( Plr->GetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 + 1 ) == SKILL_ENGINEERING )
				Plr->SetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 + 1, 0 );
			Plr->CloseGossip();
		break;
	case 564:
			Plr->_RemoveSkillLine( SKILL_JEWELCRAFTING, true );
			if( Plr->GetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 ) == SKILL_JEWELCRAFTING )
				Plr->SetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1, 0 );
			if( Plr->GetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 + 1 ) == SKILL_JEWELCRAFTING )
				Plr->SetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 + 1, 0 );
			Plr->CloseGossip();
		break;
	case 565:
			Plr->_RemoveSkillLine( SKILL_ALCHEMY, true );
			if( Plr->GetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 ) == SKILL_ALCHEMY )
				Plr->SetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1, 0 );
			if( Plr->GetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 + 1 ) == SKILL_ALCHEMY )
				Plr->SetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 + 1, 0 );
			Plr->CloseGossip();
		break;
	case 566:
			Plr->_RemoveSkillLine( SKILL_BLACKSMITHING, true );
			if( Plr->GetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 ) == SKILL_BLACKSMITHING )
				Plr->SetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1, 0 );
			if( Plr->GetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 + 1 ) == SKILL_BLACKSMITHING )
				Plr->SetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 + 1, 0 );
			Plr->CloseGossip();
		break;
	case 568:
			Plr->_RemoveSkillLine( SKILL_LEATHERWORKING, true );
			if( Plr->GetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 ) == SKILL_LEATHERWORKING )
				Plr->SetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1, 0 );
			if( Plr->GetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 + 1 ) == SKILL_LEATHERWORKING )
				Plr->SetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 + 1, 0 );
			Plr->CloseGossip();
		break;
	case 569:
			Plr->_RemoveSkillLine( SKILL_MINING, true );
			if( Plr->GetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 ) == SKILL_MINING )
				Plr->SetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1, 0 );
			if( Plr->GetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 + 1 ) == SKILL_MINING )
				Plr->SetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 + 1, 0 );
			Plr->CloseGossip();
		break;
	case 570:
			Plr->_RemoveSkillLine( SKILL_SKINNING, true );
			if( Plr->GetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 ) == SKILL_SKINNING )
				Plr->SetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1, 0 );
			if( Plr->GetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 + 1 ) == SKILL_SKINNING )
				Plr->SetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 + 1, 0 );
			Plr->CloseGossip();
		break;
	case 571:
			Plr->_RemoveSkillLine( SKILL_COOKING, true );
			if( Plr->GetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 ) == SKILL_COOKING )
				Plr->SetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1, 0 );
			if( Plr->GetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 + 1 ) == SKILL_COOKING )
				Plr->SetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 + 1, 0 );
			Plr->CloseGossip();
		break;
	case 572:
			Plr->_RemoveSkillLine( SKILL_FIRST_AID, true );
			if( Plr->GetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 ) == SKILL_FIRST_AID )
				Plr->SetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1, 0 );
			if( Plr->GetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 + 1 ) == SKILL_FIRST_AID )
				Plr->SetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 + 1, 0 );
			Plr->CloseGossip();
		break;
	case 573:
			Plr->_RemoveSkillLine( SKILL_FISHING, true );
			if( Plr->GetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 ) == SKILL_FISHING )
				Plr->SetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1, 0 );
			if( Plr->GetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 + 1 ) == SKILL_FISHING )
				Plr->SetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 + 1, 0 );
			Plr->CloseGossip();
		break;
	case 574:
			Plr->_RemoveSkillLine( SKILL_INSCRIPTION, true );
			if( Plr->GetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 ) == SKILL_INSCRIPTION )
				Plr->SetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1, 0 );
			if( Plr->GetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 + 1 ) == SKILL_INSCRIPTION )
				Plr->SetUInt32Value( PLAYER_PROFESSION_SKILL_LINE_1 + 1, 0 );
			Plr->CloseGossip();
		break;
	
        */
#endif
	}
    return true;
}

#if 0
//in case we leaned next level of a profession but our skill maxed out then we advance max skill too
uint32 Warper::getmax_profession_fishing(Player* Plr)
{
	uint32 spells[]={0,7620,7731,7732,18248,33095,51294,88868};
	for(int32 i=7;i>0;i--)
		if( Plr->HasSpell( spells[ i ] ) ) 
		{
			//remove other ranks cause in 403 client freaks out from more then 2 professions
			for(int32 j=i-1;j>0;j--)
				Plr->removeSpell( spells[ j ], true, false, 0 );
			return 75*i;
		}
	return 0;
}

//in case we leaned next level of a profession but our skill maxed out then we advance max skill too
uint32 Warper::getmax_profession_firstaid(Player* Plr)
{
	uint32 spells[]={0,3273,3274,7924,10846,27028,45542,74559};
	for(int32 i=7;i>0;i--)
		if( Plr->HasSpell( spells[ i ] ) ) 
		{
			//remove other ranks cause in 403 client freaks out from more then 2 professions
			for(int32 j=i-1;j>0;j--)
				Plr->removeSpell( spells[ j ], true, false, 0 );
			return 75*i;
		}
	return 0;
}

//in case we leaned next level of a profession but our skill maxed out then we advance max skill too
uint32 Warper::getmax_profession_cooking(Player* Plr)
{
	uint32 spells[]={0,2550,3102,3413,18260,33359,51296,88053};
	for(int32 i=7;i>0;i--)
		if( Plr->HasSpell( spells[ i ] ) ) 
		{
			//remove other ranks cause in 403 client freaks out from more then 2 professions
			for(int32 j=i-1;j>0;j--)
				Plr->removeSpell( spells[ j ], true, false, 0 );
			return 75*i;
		}
	return 0;
}

//in case we leaned next level of a profession but our skill maxed out then we advance max skill too
uint32 Warper::getmax_profession_skinning(Player* Plr)
{
	uint32 spells[]={0,8613,8617,8618,10768,32678,50305,74522};
	for(int32 i=7;i>0;i--)
		if( Plr->HasSpell( spells[ i ] ) ) 
		{
			//remove other ranks cause in 403 client freaks out from more then 2 professions
			for(int32 j=i-1;j>0;j--)
				Plr->removeSpell( spells[ j ], true, false, 0 );
			return 75*i;
		}
	return 0;
}

//in case we leaned next level of a profession but our skill maxed out then we advance max skill too
uint32 Warper::getmax_profession_mining(Player* Plr)
{
	uint32 spells[]={0,2575,2576,3564,10248,29354,50310,74517};
	for(int32 i=7;i>0;i--)
		if( Plr->HasSpell( spells[ i ] ) ) 
		{
			//remove other ranks cause in 403 client freaks out from more then 2 professions
			for(int32 j=i-1;j>0;j--)
				Plr->removeSpell( spells[ j ], true, false, 0 );
			return 75*i;
		}
	return 0;
}

//in case we leaned next level of a profession but our skill maxed out then we advance max skill too
uint32 Warper::getmax_profession_leatherwork(Player* Plr)
{
	uint32 spells[]={0,2108,3104,3811,10662,32549,51302,81199};
	for(int32 i=7;i>0;i--)
		if( Plr->HasSpell( spells[ i ] ) ) 
		{
			//remove other ranks cause in 403 client freaks out from more then 2 professions
			for(int32 j=i-1;j>0;j--)
				Plr->removeSpell( spells[ j ], true, false, 0 );
			return 75*i;
		}
	return 0;
}

//in case we leaned next level of a profession but our skill maxed out then we advance max skill too
uint32 Warper::getmax_profession_herbalism(Player* Plr)
{
	uint32 spells[]={0,2366,2368,3570,11993,28695,50300,74519};
	for(int32 i=7;i>0;i--)
		if( Plr->HasSpell( spells[ i ] ) ) 
		{
			//remove other ranks cause in 403 client freaks out from more then 2 professions
			for(int32 j=i-1;j>0;j--)
				Plr->removeSpell( spells[ j ], true, false, 0 );
			return 75*i;
		}
	return 0;
}

//in case we leaned next level of a profession but our skill maxed out then we advance max skill too
uint32 Warper::getmax_profession_blacksmith(Player* Plr)
{
	uint32 spells[]={0,2018,3100,3538,9785,29844,51300,76666};
	for(int32 i=7;i>0;i--)
		if( Plr->HasSpell( spells[ i ] ) ) 
		{
			//remove other ranks cause in 403 client freaks out from more then 2 professions
			for(int32 j=i-1;j>0;j--)
				Plr->removeSpell( spells[ j ], true, false, 0 );
			return 75*i;
		}
	return 0;
}

//in case we leaned next level of a profession but our skill maxed out then we advance max skill too
uint32 Warper::getmax_profession_alchemy(Player* Plr)
{
	uint32 spells[]={0,2259,3101,3464,11611,28596,51304,80731};
	for(int32 i=7;i>0;i--)
		if( Plr->HasSpell( spells[ i ] ) ) 
		{
			//remove other ranks cause in 403 client freaks out from more then 2 professions
			for(int32 j=i-1;j>0;j--)
				Plr->removeSpell( spells[ j ], true, false, 0 );
			return 75*i;
		}
	return 0;
}

//in case we leaned next level of a profession but our skill maxed out then we advance max skill too
uint32 Warper::getmax_profession_jewelcrafting(Player* Plr)
{
	uint32 spells[]={0,25229,25230,28894,28895,28897,51311,73318};
	for(int32 i=7;i>0;i--)
		if( Plr->HasSpell( spells[ i ] ) ) 
		{
			//remove other ranks cause in 403 client freaks out from more then 2 professions
			for(int32 j=i-1;j>0;j--)
				Plr->removeSpell( spells[ j ], true, false, 0 );
			return 75*i;
		}
	return 0;
}

//in case we leaned next level of a profession but our skill maxed out then we advance max skill too
uint32 Warper::getmax_profession_engineering(Player* Plr)
{
	uint32 spells[]={0,4036,4037,4038,12656,30350,51306,82774};
	for(int32 i=7;i>0;i--)
		if( Plr->HasSpell( spells[ i ] ) ) 
		{
			//remove other ranks cause in 403 client freaks out from more then 2 professions
			for(int32 j=i-1;j>0;j--)
				Plr->removeSpell( spells[ j ], true, false, 0 );
			return 75*i;
		}
	return 0;
}

//in case we leaned next level of a profession but our skill maxed out then we advance max skill too
uint32 Warper::getmax_profession_tailor(Player* Plr)
{
	uint32 spells[]={0,3908,3909,3910,12180,26790,51309,75156};
	for(int32 i=7;i>0;i--)
		if( Plr->HasSpell( spells[ i ] ) ) 
		{
			//remove other ranks cause in 403 client freaks out from more then 2 professions
			for(int32 j=i-1;j>0;j--)
				Plr->removeSpell( spells[ j ], true, false, 0 );
			return 75*i;
		}
	return 0;
}

//in case we leaned next level of a profession but our skill maxed out then we advance max skill too
uint32 Warper::getmax_profession_enchant(Player* Plr)
{
	uint32 spells[]={0,7411,7412,7413,13920,28029,51313,74258};
	for(int32 i=7;i>0;i--)
		if( Plr->HasSpell( spells[ i ] ) ) 
		{
			//remove other ranks cause in 403 client freaks out from more then 2 professions
			for(int32 j=i-1;j>0;j--)
				Plr->removeSpell( spells[ j ], true, false, 0 );
			return 75*i;
		}
	return 0;
}

//in case we leaned next level of a profession but our skill maxed out then we advance max skill too
uint32 Warper::getmax_profession_archaeology(Player* Plr)
{
	uint32 spells[]={0,78670,88961,89718,89719,89720,89721,89722};
	for(int32 i=7;i>0;i--)
		if( Plr->HasSpell( spells[ i ] ) ) 
		{
			//remove other ranks cause in 403 client freaks out from more then 2 professions
			for(int32 j=i-1;j>0;j--)
				Plr->removeSpell( spells[ j ], true, false, 0 );
			return 75*i;
		}
	return 0;
}

//in case we leaned next level of a profession but our skill maxed out then we advance max skill too
uint32 Warper::getmax_profession_inscription(Player* Plr)
{
	uint32 spells[]={0,45357,45358,45359,45360,45361,45363,86008};
	for(int32 i=7;i>0;i--)
		if( Plr->HasSpell( spells[ i ] ) ) 
		{
			//remove other ranks cause in 403 client freaks out from more then 2 professions
			for(int32 j=i-1;j>0;j--)
				Plr->removeSpell( spells[ j ], true, false, 0 );
			return 75*i;
		}
	return 0;
}

void Warper::resetskilland_send_menu(Object * pObject, Player* Plr,uint32 skill, uint32 maxskill)
{
	GossipMenu *Menu;
	ClearGossipMenuFor(Plr);
	AddGossipItemForArcemu( Plr, 0, "[Back]", 99);
	SendGossipMenuFor(Plr,3673,me);

	if ( maxskill != 0 )
	{
		uint32 currentskill = Plr->_GetSkillLineCurrent(skill,false);
		if( currentskill > maxskill )
			currentskill = maxskill; //should not happen but let us be safe
		Plr->_RemoveSkillLine(skill);
		Plr->_AddSkillLine(skill, currentskill, maxskill);
		Creature * pCreature = (Creature *)pObject; // we already checked if he is creature in main menu
		pCreature->SendChatMessage(CHAT_MSG_MONSTER_SAY, LANG_UNIVERSAL, "Profession has been fixed" );
	}
	else
	{
		Plr->_RemoveSkillLine( skill ); //maybe he got stuck with the skill and he is missing the spell
		Plr->BroadcastMessage("You don't have this proffesion learned!");
	}
}
#endif

void AddWarpNPCScripts()
{
    new Warper();
    //REPLACE INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (123456, 0, 0, 0, 0, 0, 21666, 0, 0, 0, 'TAXI', '', '', 0, 80, 80, 0, 35, 3, 1, 1.14286, 3, 0, 0, 2000, 2000, 1, 1, 1, 768, 2048, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 'WarpNPC', 12340);
    /*
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -689.849, -551.111, 28.2474, 4.17282, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 4625.86, -3814.98, 943.89, 0.207356, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -8888.34, 168.457, -19.3832, 0.979392, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 5679.82, 2839.42, 367.834, 3.15862, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 5879.41, 2113.98, 636.041, 3.5558, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 609, 2359.69, -5660.08, 154.129, 1.82449, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 8510.04, 720.713, 558.248, 0.0314149, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 5635.21, 2036.42, 798.273, 3.5445, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -1886.38, 5476.48, -12.4268, -1.13631, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -1841.11, 5384.34, -12.4267, 2.0249, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -1816.24, 5453.72, -12.4276, -2.68497, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 649, 606.75, 139.968, 138.548, 3.33615, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 5742.4, 565.216, 651.547, 0.810531, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 6733.75, -4622.33, 450.518, 1.06657, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 426.106, -4586.89, 243.833, 0.844311, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 608.061, -5045.28, 1.14858, 3.97804, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 604, 1954.78, 686.061, 135.455, 2.39775, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 4765.23, -2032.01, 229.354, 4.89774, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 3892.76, 6975.93, 69.4883, 2.26823, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 1254.27, -4862.9, 215.716, 1.26056, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 1227.49, -4874.81, 41.2512, 3.37171, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 609, 2451.44, -5641.35, 547.522, 1.26462, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, -302.95, -2808.5, 136.292, 6.26354, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 2862.4, 6208.77, 104.242, 3.87516, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 429, 384.411, 274.887, 12.2345, 5.27394, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 595, 1892.51, 1284.53, 143.585, 2.90283, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 595, 2253.44, 1480.9, 131.413, 3.53745, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -2040.12, 6654.54, 50.3404, 2.81251, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 451, 16303.1, 16311.8, 69.4452, 2.99551, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 3727.07, 2159.46, 36.4347, 3.27479, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 601, 428.369, 797.433, 828.537, 4.01103, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 3652.39, 2042.81, 1.78781, 2.5604, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 3874.09, 6998.18, 106.319, 5.90384, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 1106.19, -4987.98, 31.8501, 0.599258, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 609, 2365.86, -5779.41, 151.367, 0.756337, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -2154.99, 6670.39, 0.697995, 5.24802, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, 2892.98, 5984.92, 2.39486, 2.13236, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 3488.35, 248.611, -120.097, 2.42631, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 8940.05, -981.138, 1039.3, 3.75028, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, 13281.1, -7146.3, 4.33135, 6.22978, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, 13009.4, -6913.29, 9.58444, 2.4685, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, 2624.34, 6629.31, 18.4606, 5.11355, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, 3538.27, 5085.16, 2.0353, 5.75166, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -462.311, 8404.91, 27.1291, 1.50796, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -3082.04, 2564.61, 62.3978, 3.1031, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -3976.98, -13912.9, 98.9903, 5.863, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -315.599, 3026.76, -15.7055, 2.05145, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, 9419.66, -7278.38, 14.203, 3.10075, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -4003.8, -11891.9, -0.75457, 4.10135, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -3608.32, 352.127, 38.3625, 5.91562, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, 3104.45, 1382.66, 184.458, 2.55883, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, 3558.97, 5186.37, -6.82469, 3.66624, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, 736.588, 6832.26, -63.5006, 1.60928, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -327.247, 3145.22, -101.622, 3.33401, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, 3379.6, 1494.62, 179.542, 5.96944, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, 2880.06, 1581.24, 248.863, 4.49562, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -3634.2, 4927.33, -101.048, 1.065, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, 3288.58, 1359.43, 502.264, 5.66036, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -3351.59, 4674.81, -101.049, 3.40072, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -3348.43, 5213.17, -101.05, 2.89341, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, 820.321, 6925.64, -79.9998, 1.79463, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, 710.41, 6995.52, -73.0749, 6.28083, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -3090.01, 4931.09, -100.879, 1.42079, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, 751.061, 6765.75, -64.5609, 0.379347, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, 3062.12, 3659.32, 143.17, 1.41136, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 543, -1414.43, 1760.9, 81.7088, 4.44272, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -700.535, 2700.5, 95.0568, 4.67155, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, 1857.65, 5532.21, 277.004, 1.0281, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, 189.244, 2640.07, 87.8543, 2.78504, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -251.478, 964.682, 84.337, 4.87889, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -3987.99, 2157.82, 104.65, 0.882784, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 532, -11096.2, -1981.01, 49.8903, 5.78524, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 534, 5070.51, -1800.27, 1322.1, 1.73039, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, 6797.4, -7875.08, 158.12, 0.962804, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -1218.99, 7166.85, 57.2654, 0.794043, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, 289.289, 5994.05, 23.0538, 3.63247, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 532, -11117.5, -1973.93, 91.4656, 2.23686, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -3988.76, -11641, -138.44, 5.45066, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -4570.06, 1073.28, 5.80329, 0.486667, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -1109.45, 5197.03, 57.1984, 2.58198, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -4069.36, -12005.7, -1.10873, 4.39116, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -5136.5, 641.809, 83.7982, 3.86534, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -197.621, 5502.32, 22.5452, 3.14945, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 8616.09, 741.943, 548.047, 2.58318, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 609, 2364.81, -5665.05, 426.007, 2.93347, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -1911.12, 5406.68, -12.4273, 0.480287, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 604, 2034.78, 805.941, 0.000118852, 3.23427, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 9331.05, -1093.02, 1245.15, 4.5341, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, 10354.4, -6362.76, 34.7751, 2.63501, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 631, 4268.2, 3072.94, 360.521, 3.16763, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 3630.24, -3409.82, 240.257, 4.08799, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, 6864.26, -7739.56, 124.633, 3.17302, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 5440.11, 2833.81, 420.43, 1.54331, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, 3366.65, -3382.04, 145.012, 3.00336, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -8132.02, -4604.36, 13.7074, 3.1196, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -236.6, 1556.86, 76.8921, 1.16867, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 2147.68, -4745.23, 50.4955, 2.63589, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 6207.5, -152.833, 79.8186, 1.065, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, 4246.66, -2774.35, 6.85885, 5.29595, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, 797.314, -434.431, 136.329, 1.51425, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 1844.7, -4527.52, 23.4119, 0.0416226, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 1930.34, -4584.09, 33.8946, 3.30898, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -1153.55, -1562.8, 211.853, 5.32185, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, 2883.35, -825.117, 160.331, 1.66819, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -7521.48, -907.223, -273.589, 1.01788, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 9980.08, 1990.11, 1328.35, 5.18568, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -6797.59, -2902.35, 9.77973, 2.83686, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -1349.45, 535.562, 141.804, 4.72412, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 1993.36, -4657.28, 27.0115, 3.9962, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -12386.9, 181.112, 2.4534, 0.184567, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -7461.7, -1056.1, 896.77, 5.09645, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 8762.19, 1413.01, 13.957, 4.04035, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 11128.3, 1580.44, 983.161, 2.25407, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -3128.52, -3046.93, 33.7964, 5.70985, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 4000.5, -1295.29, 254.222, 2.92481, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -8161.47, -4616.81, -127.435, 3.27081, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -8519.72, -4297.54, -208.441, 0.15708, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -10219.1, -3875.51, 0.591386, 3.50687, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -9061.78, 826.309, 108.418, 2.23359, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -3761.08, 1166.66, 127.436, 2.18812, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 1351.19, -4399.94, 28.8418, 2.26026, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -8177.17, -4778.15, 36.8404, 0.021205, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -7162.73, -3784.7, 8.84636, 3.49423, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -3093.11, -149.483, 45.3731, 0.25761, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -11403.8, 1968.96, 8.84114, 2.46144, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -4736.03, -6913.35, 0.000900533, 0.111086, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 6721.86, -4662.83, 720.991, 1.27234, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -11023.7, 1498.19, 43.2005, 1.62892, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -9863.39, 1274.33, 40.7401, 1.55352, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -9841.63, 1023.96, 32.6613, 0.285889, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -10130, 1059.21, 36.2834, 5.0077, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -10143, 1194, 36.3869, 3.0929, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -10295.7, 1404.58, 40.1418, 2.11744, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -10720.2, 1675.77, 43.9052, 2.70099, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -1119.97, 1555.7, 54.167, 5.72176, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -4069.21, -3248.12, 99.0959, 1.08804, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -10442.5, -3259.56, 20.1789, 5.21347, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -8839.75, -3041.3, 225.763, 4.03615, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -1035.85, 1576.54, 54.1519, 3.15811, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -7498.01, -916.191, 166.713, 0.736993, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -7616.34, -897.054, 166.988, 1.53653, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -7678.13, -1055.38, 166.982, 3.83775, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -7538, -1214.45, 285.44, 1.53623, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -8821.81, 2205.12, -10.1882, 3.84688, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -7809.46, 765.488, 131.406, 3.17315, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -10996.6, -1262.76, 51.7313, 3.76442, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 1197.35, -4319.49, 21.2962, 4.66364, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -9442.19, -2271.73, 71.1706, 5.7958, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -10854, -2925.75, 13.6985, 4.25372, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -8241.98, 1491.69, 4.51829, 0.859224, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -6268.36, -3673.51, -58.7547, 2.12955, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 1355.63, -4635.46, 54.1642, 2.47486, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -1272.54, 108.008, 128.266, 5.5237, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 7785.29, -2419.52, 488.702, 5.59972, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -2824.08, -4758.5, 4.81572, 6.27689, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 1582.55, -4448.7, 5.79852, 2.17712, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -2643.02, -4901.81, 21.7942, 2.67377, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -6763.02, 3535.11, 10.5704, 3.63764, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -5628.49, -4319.9, 401.163, 5.27362, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -6234.75, -3925.93, -58.7497, 3.31902, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -7218.12, -5406.61, 19.6311, 0.649126, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 7446.74, 799.951, -1.43931, 3.44554, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -3442.41, -1481.39, 233.038, 1.66426, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -4815.77, -980.161, 464.709, 2.4206, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -2666.46, -4808.38, 18.8248, 2.99629, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 5132.5, -352.492, 355.015, 1.77421, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -6843.88, 766.758, 42.9768, 5.52685, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -6159.17, -1074.58, -199.557, 4.52311, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -5115.92, -1963.07, 88.6745, 0.591405, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 2297.14, -2530.69, 100.635, 3.84452, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -451.985, -2620.16, 96.5615, 5.95489, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -10982.6, -3398.18, 65.3724, 2.6248, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 6198.78, -1942.26, 570.559, 5.7444, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -14298.9, 508.174, 8.96553, 2.69784, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -11328.6, -193.478, 75.4638, 4.98885, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -10561.2, -1174.99, 27.9638, 5.3195, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -843.149, -548.314, 11.0922, 1.32575, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -9245.62, -2164.36, 63.9339, 3.11253, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -10513, 1073.9, 54.5017, 3.67566, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -13255.6, 140.532, 34.4612, 2.54704, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 9951.77, 2279.71, 1341.39, 4.75009, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -4976.71, -889.6, 501.615, 2.15278, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, 2044.74, 291.655, 55.6734, 4.79014, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -1298.31, 209.806, 68.6814, 3.62226, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 10332, 830.879, 1326.26, 2.95624, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -8938.99, -138.21, 83.5747, 1.90381, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -14277.3, 321.884, 28.6365, 4.68569, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -3539.49, -4315.62, 7.07841, 5.98316, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, 299.174, -2123.38, 121.837, 3.31124, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -9108.72, 367.8, 93.9999, 2.55843, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 1684.11, -4339.33, 94.8891, 3.97098, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -11126.1, -2008.65, 47.3441, 5.59785, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -11914.3, -1207.24, 92.2889, 3.59797, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 1729.21, -4411.6, 37.4962, 0.627537, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -3939.49, -4987.4, 7.4647, 2.70569, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -3673.71, -817.174, 10.058, 5.88734, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, 2.82986, -21.994, 91.7909, 1.51081, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -1621.13, 3135.94, 45.9746, 3.44397, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -8641.1, -4369.28, -208.51, 5.47894, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -8574.64, -1145.98, 230.045, 4.95941, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -8607.57, -515.341, 8.87664, 3.2806, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 2413.27, -2939.24, 125.06, 5.05245, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, 2291.81, -5316.8, 88.3029, 2.02161, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -8608.74, -3628.53, 14.2042, 5.67921, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, 1370.92, -1460.52, 56.9692, 1.39017, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -8658.52, 2370.54, 82.5345, 5.85671, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -9877.43, -3946.73, 320.237, 6.10097, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 6107.62, -4181.6, 852.323, 3.8406, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -4258.64, -3285.98, 240.565, 5.01083, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 16235.6, 16262.5, 14.1219, 3.1196, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -10736.3, 2451.27, 7.49529, 1.70667, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -10576.1, 2173.53, 2.67944, 1.8155, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -8261.25, -111.627, 239.045, 5.80562, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -8997.52, 873.877, 29.621, 3.81311, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -6910.9, 1222.27, 171.433, 5.98078, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 5411.53, -3553.99, 1563.18, 4.32389, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -177.949, 1692.39, 78.3558, 5.0077, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 1809.81, -2890.57, 98.6348, 0.1704, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 1471, -4214.59, 58.994, 4.15082, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -1197.15, 50.6182, 250.593, 1.64774, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -1858.56, -4247.58, 2.13465, 0.791547, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -2914.97, -267.27, 59.8618, 1.98313, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -5326.27, 3905.37, 3.70419, 0.75241, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -11548.2, -2338.63, 625.7, 0.738227, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -5657.02, 3724.91, 2.30746, 3.2162, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -1164.52, -5259.29, 0.421314, 3.47146, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -12.8375, 1.60793, 81.6682, 0.00392389, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -998.182, -3824.51, 5.4409, 1.02115, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -7142.4, 4020.2, 4.16727, 1.23831, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -5628.75, 5311.96, -1260.37, 2.68682, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -9445.26, -961.257, 111.011, 0.0235567, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -7565.18, -1311.37, 245.933, 3.52799, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 1553.66, -4421.27, 18.2003, 2.22268, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -10700.6, -1303.08, 17.6904, 5.09802, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -3976.88, -2839.09, 9.90557, 3.65681, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -7922.93, -1361.96, 134.081, 1.42393, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -9041.3, -2711.86, 35.7235, 5.66036, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -6168.72, 327.953, 400.247, 0.240331, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -382.791, 1126.58, 83.6032, 4.72417, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, 2613.34, -537.074, 88.9999, 3.56728, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -7195.55, -2436.56, -217.664, 3.2217, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, 3353.03, -3223.31, 146.253, 3.7542, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, 1234.43, -2418.37, 61.4671, 0.704501, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -12546.4, -582.738, 39.8507, 4.61343, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -8392.09, 1494.58, 19.1428, 4.50504, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -7998.94, 1549.05, 3.61816, 1.58258, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -8240.68, 1959.29, 130.302, 2.44102, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, 6839.36, -7762.2, 126.016, 6.16381, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, 6725.16, -7944.59, 170.099, 0.958972, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -259.168, 923.326, 84.3798, 0.431183, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -261.604, 1023.41, 54.3254, 6.24156, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -218.647, 5409.21, 22.8706, 3.21149, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -702.373, 8885.26, 185.215, 4.90874, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, 1464.38, 6817.24, 107.501, 0.866747, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, 874.415, 7278.42, 22.7265, 1.24093, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, 3406.22, 4181.9, 137.619, 3.21149, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, 3363.06, 4149.93, 135.029, 3.42748, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -1193.21, 5306.35, 34.0521, 2.03183, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -1144.47, 5887.19, 189.742, 1.41136, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -2853.6, 3175.31, 12.4956, 2.21168, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -2641.61, 3024.03, -4.91942, 3.73143, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, 164.865, 2571.05, 79.0345, 4.18303, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -5377.62, 38.8936, 393.155, 3.46832, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -10704.7, -1299.63, 17.9428, 4.91031, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -4059.9, -3458.73, 280.489, 1.97763, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -10204.8, -1828.97, 20.5028, 4.97393, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -4893.62, -4245.7, 827.764, 1.23465, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -5326.21, -3779.71, 310.106, 3.18793, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -7547.5, -1199.69, 477.755, 5.53784, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -13314, 156.6, 17.3738, 3.44083, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, 12854.2, -6854.8, 11.6302, 3.26097, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 2868.96, 5425.21, 56.9089, 0.379347, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 5404.22, 466.988, 171.332, 5.7444, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 5887.57, 665.897, 169.508, 4.46892, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 5853.46, 763.566, 641.332, 3.46754, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 3574.83, 849.607, 116.345, 1.51189, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 3542.45, 266.178, 45.6085, 2.03025, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 3526.66, -2884.26, 204.788, 0.16886, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 58.3264, -4655.9, 283.482, 0.537998, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 10314.3, 770.614, 74.3653, 1.31162, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 8474.45, 454.66, 596.072, 3.27825, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 7234.59, 2161.48, 565.032, 5.77111, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 5464.28, 4993.02, -131.504, 1.19459, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 5542.24, 4851.47, -196.064, 3.65367, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 6234.23, -1055.66, 413.829, 1.63363, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 6423.94, -1188.44, 446.935, 2.44966, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 4511.77, 2758.26, 389.788, 1.72395, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 4319.28, 2401.97, 392.653, 0.829381, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 5439.9, -1254.79, 248.749, 1.48283, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 5560.92, -1619.5, 242.247, 2.01612, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 3623.33, 6799.39, 172.453, 1.77107, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 571, 4417.27, -1989.52, 158.312, 1.20245, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -6219.98, 333.285, 383.22, 3.23584, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -4979.28, 868.237, 274.31, 2.19911, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -614.457, -4246.31, 38.956, 3.80526, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, 1697.84, 1681.47, 134.591, 1.38637, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -34.6544, -886.954, 56.1436, 5.6307, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -11204.9, 1669.23, 24.9169, 2.89341, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -11219.9, 1707.11, 38.8648, 2.13078, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -11348.1, 56.5741, 723.884, 3.09133, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -7971.42, 781.192, -0.650773, 0.770475, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, 1701.7, 1704.16, 135.577, 4.56317, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 6225.76, -1973.13, 572.921, 1.72866, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 6499.68, -2375.89, 589.816, 4.54117, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 6236.64, -1951.08, 568.781, 3.45732, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -10838.9, -2949.14, 14.0245, 3.20285, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 6869.82, -4655.54, 700.42, 6.04521, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 4474.57, -4295.74, 908.371, 2.99315, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 4469.25, -4306.45, 904.504, 2.12136, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, -1792.18, 4923.72, -21.7612, 1.76793, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -11638.8, -63.2578, 16.2386, 2.24781, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -12010.2, 433.287, 4.29053, 5.80252, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -7545.29, -1203.66, 477.722, 0.12017, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -7514.35, -1222.71, 477.723, 3.47461, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, 105.566, -191.643, 126.887, 2.88805, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -4908.09, -4242.28, 827.763, 0.279797, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 3944.82, -2833.03, 618.748, 0.80896, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, 1429.35, 6839.26, 109.359, 0.251283, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -8820.38, 626.175, 94.3414, 3.63247, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -3751.52, 1051.01, 159.591, 1.57081, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -4618.59, -6446.35, 4.30083, 2.95232, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 3039.59, -1297.48, 311.383, 0.849808, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 8794.33, 965.861, 0.796671, 0.52229, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, 1738.61, 239.055, 62.5326, 6.2612, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -597.413, -4581.52, 9.8404, 0.285897, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -8229.74, -4492.87, -214.011, 5.91053e-39, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, 4117.48, 3067.14, 339.465, 4.71738, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 7411.48, -341.59, 5.58678, 1.63384e-34, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -13254.5, 145.262, 34.6916, 2.56748, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -5331.21, -3776.25, 310.038, 0.65232, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -8296, -4568, -222, 0, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -10372.6, -411.663, 64.0194, 4.16485, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -4074.75, -3443.14, 281.529, 5.25431, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, 10388.9, -6403.06, 161.052, 0.959293, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, -1827.66, 3043.02, 3.24248, 5.3081, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 1, 1554.01, -4424.41, 18.4773, 1.48832, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 530, 7864.27, -7911.6, 291.764, 3.18198, 1);
INSERT INTO `creature` (`id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`) VALUES (123456, 0, -12901.2, -1850.8, 117.172, 3.83274, 1);

INSERT INTO npc_text (id,text0_0) VALUES (8,"Select Game Mode, you may NOT change it after!");
INSERT INTO npc_text (id,text0_0) VALUES (9,"Hi there. Where can the TAXI port you today?");

CREATE TABLE `account_credits` (
`AccId` int(12) unsigned NOT NULL,
`credits` int(12) unsigned NOT NULL DEFAULT '0',
PRIMARY KEY (`AccId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC
*/
}
