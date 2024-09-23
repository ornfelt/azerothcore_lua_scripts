#include "AccountMgr.h"
#include "time.h"
#include <stdio.h>
#include "Bag.h"
#include "Common.h"
#include "Config.h"
#include "DatabaseEnv.h"
#include "DBCStructure.h"
#include "Define.h"
#include "Field.h"
#include "GameEventMgr.h"
#include "Item.h"
#include "Language.h"
#include "Log.h"
#include "ObjectGuid.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "QueryResult.h"
#include "ScriptMgr.h"
#include "SharedDefines.h"
#include "Transaction.h"
#include "WorldSession.h"
#include <sstream>
#include <string>
#include <stdlib.h>
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "Custom/Logic/CustomQuestionAnswerSystem.h"

enum Phases{
	PHASE_ONE = 1
};

enum Spells
{
	SPELL_POISON_NOVA = 68989,
	SPELL_ENRAGE = 68335,
	SPELL_TOXIC_WASTE = 69024,
	SPELL_RAIN_OF_FIRE = 59971,
	SPELL_FLAME_BURST = 41131,
	SPELL_ARCANE_BOMB = 56431,
	SPELL_MOONFIRE = 48463,
	SPELL_SPALTEN = 56909,
	SPELL_SARGERAS = 28342,
	SPELL_BURN = 46218,
	SPELL_FLAME_BREATH = 56908
};


enum Events
{
	EVENT_POISON_NOVA = 1,
	EVENT_ENRAGE = 2,
	EVENT_TOXIC_WASTE = 3,
	EVENT_RAIN_OF_FIRE = 4,
	EVENT_FLAME_BURST = 5,
	EVENT_ARCANE_BOMB = 6,
	EVENT_MOONFIRE = 8,
	EVENT_SUMMONS = 9,
	EVENT_SPALTEN = 10,
	EVENT_BURN = 11,
	EVENT_BREATH = 12


};


class wandervolk : public CreatureScript
{

public:
	wandervolk() : CreatureScript("wandervolk") { }

	bool OnGossipHello(Player *player, Creature* creature)
	{
		if (creature->IsQuestGiver())
			player->PrepareQuestMenu(creature->GetGUID());


		if (sConfigMgr->GetBoolDefault("Wander.Volk", true)) {
			bool status = player->GetQuestRewardStatus(900801);
			if (status) {
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Bring me to the Home of Wandervolk!", GOSSIP_SENDER_MAIN, 0, "", 0, false);
			}

			player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Who are you?", GOSSIP_SENDER_MAIN, 1, "", 0, false);
			player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
			return true;
		}
		
		else {
			
			creature->SetPhaseMask(2, true);
			player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
			return true;
		}
	}

	bool OnGossipSelect(Player * pPlayer, Creature * /*pCreature*/, uint32 /*uiSender*/, uint32 uiAction)
	{
		switch (uiAction)
		{

		case 0: {

			pPlayer->GetGUID();
			pPlayer->TeleportTo(0, 3129.77f, -6284.07f, 140.95f, 1.53f);
			return true;
		}break;


		case 1: {
			pPlayer->GetGUID();
			ChatHandler(pPlayer->GetSession()).PSendSysMessage("Das Wandervolk ist ein sehr vorsichtiges Volk. Du kannst dich nur beweissen indem du ihre Aufgaben erfuellst.",
				pPlayer->GetName());
			pPlayer->PlayerTalkClass->SendCloseGossip();
			return true;
		}break;
		return true;
		}
	return true;
	};
};


class janarius : public CreatureScript
{

public:
	janarius() : CreatureScript("janarius") { }

	bool OnQuestReward(Player* /*player*/, Creature* creature, Quest const* quest, uint32 /*opt*/) {

		if (quest->GetQuestId() == 900835){
			creature->HandleEmoteCommand(EMOTE_ONESHOT_CRY);
			creature->Yell("Dieser Bericht ist erschreckend! Wir muessen etwas tun!", LANG_UNIVERSAL, NULL);
			creature->AddAura(72525, creature);
			return true;
		}
        return true;
	}
	
};


class leandaria : public CreatureScript
{

public:
	leandaria() : CreatureScript("leandaria") { }

	struct leandariaAI : public ScriptedAI
	{
		leandariaAI(Creature* creature) : ScriptedAI(creature) { }

		void Reset() override
		{
			
		}

		void EnterCombat(Unit* /*who*/) override
		{	
			me->Yell("Nun wird es ernst. Zeigt was Ihr koennt", LANG_UNIVERSAL, NULL);
		}

		void DamageTaken(Unit* attacker, uint32& damage) override
		{
			if (me->HealthBelowPctDamaged(5, damage))
			{
				
				const Quest* quest = sObjectMgr->GetQuestTemplate(800558);
				me->Yell("Ihr habt mich geschlagen. Es reicht", LANG_UNIVERSAL, NULL); 
				me->setFaction(35);
				Player * player = attacker->GetAffectingPlayer();
				Player * playernew = player->GetSession()->GetPlayer();
				playernew->CompleteQuest(800558);
				playernew->CanRewardQuest(quest, true);
				
			}
		}


		void UpdateAI(uint32 diff) override
		{
			if (!UpdateVictim())
				return;

			_events.Update(diff);

			while (uint32 eventId = _events.ExecuteEvent())
			{
				switch (eventId)
				{
				case EVENT_POISON_NOVA:
					DoCastAOE(SPELL_POISON_NOVA);
					_events.ScheduleEvent(EVENT_TOXIC_WASTE, 30000);
					break;
				case EVENT_TOXIC_WASTE:
					DoCastToAllHostilePlayers(SPELL_TOXIC_WASTE);
					_events.ScheduleEvent(EVENT_TOXIC_WASTE, 45000);
					break;
				case EVENT_ENRAGE:
					DoCast(SPELL_ENRAGE);
					break;
				case EVENT_RAIN_OF_FIRE:
					me->FinishSpell(CURRENT_CHANNELED_SPELL, true);
					DoCastToAllHostilePlayers(SPELL_RAIN_OF_FIRE);
					_events.ScheduleEvent(EVENT_RAIN_OF_FIRE, 10000);
					break;
				case EVENT_FLAME_BURST:
					
					DoCast(me, SPELL_FLAME_BURST);
					_events.ScheduleEvent(EVENT_FLAME_BURST, 12000);
					break;
				case EVENT_ARCANE_BOMB:
					
					DoCastToAllHostilePlayers(SPELL_ARCANE_BOMB);
					_events.ScheduleEvent(EVENT_ARCANE_BOMB, 15000);
					break;
				case EVENT_SPALTEN:
					DoCastToAllHostilePlayers(SPELL_SPALTEN);
					_events.ScheduleEvent(EVENT_SPALTEN, 30000);
					break;
				case EVENT_BURN:
					DoCastVictim(SPELL_BURN);
					_events.ScheduleEvent(EVENT_BURN, 5000);
					break;
				case EVENT_BREATH:
					if (Unit* target = SelectTarget(SELECT_TARGET_TOPAGGRO, 0)){
						DoCast(target, SPELL_FLAME_BREATH);
					}

					_events.ScheduleEvent(EVENT_BREATH, 35000);
					break;

				default:
					break;
				}
			}

			DoMeleeAttackIfReady();
		}

	private:
		EventMap _events;
	};

	CreatureAI* GetAI(Creature* creature) const 
	{
		return new leandariaAI(creature);
	}


	bool OnGossipHello(Player *player, Creature* creature)
	{
		if (creature->IsQuestGiver())
			player->PrepareQuestMenu(creature->GetGUID());
		
		if (sConfigMgr->GetBoolDefault("Wander.Volk", true)) {
			player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Hi", GOSSIP_SENDER_MAIN, 0, "", 0, false);
			bool status = player->GetQuestRewardStatus(900810);
			if (status) {
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Beam mich hoch!", GOSSIP_SENDER_MAIN, 1, "", 0, false);
			}
			player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "I challenge you!", GOSSIP_SENDER_MAIN, 2, "", 0, false);
		}

		else {
			return true;
		}
			
		


		player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
		return true;
	}

	bool OnGossipSelect(Player * pPlayer, Creature * creature, uint32 /*uiSender*/, uint32 uiAction)
	{
		switch (uiAction)
		{

		case 0: {
			pPlayer->GetGUID();
			ChatHandler(pPlayer->GetSession()).PSendSysMessage("Hallo, ich bin Leandaria. Ihr muesst erst in meiner Gunst stehen um bei mir etwas zu bekommen. Schliesst zuerst die Quest 'Elostraio' ab.",
				pPlayer->GetName());
			pPlayer->PlayerTalkClass->SendCloseGossip();
			return true;
		}break;


		case 1: {
			pPlayer->GetGUID();
			pPlayer->TeleportTo(0, 3174.49f, -6000.48f, 208.00f, 0.27f);
			return true;
		}break;
			
		case 2: {
			creature->setFaction(21);
			creature->setActive(true);
			creature->SetReactState(REACT_AGGRESSIVE);
		}break;
	
			return true;
		}
		return true;
	};


};


class raetsel : public CreatureScript
{

public:
	raetsel() : CreatureScript("raetsel") { }

	bool OnGossipHello(Player *pPlayer, Creature* _creature)
	{
		if (_creature->IsQuestGiver())
			pPlayer->PrepareQuestMenu(_creature->GetGUID());
		
		pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,7, "Das zweite Raetsel", GOSSIP_SENDER_MAIN, 0, "", 0, false);
		pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,7, "What are u doing here?", GOSSIP_SENDER_MAIN, 1, "", 0, false);
		pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,7, "Ask me a Question!", GOSSIP_SENDER_MAIN, 2, "", 0, false);
		pPlayer->PlayerTalkClass->SendGossipMenu(907, _creature->GetGUID());
		return true;
	}

	bool OnGossipSelect(Player * player, Creature * /*pCreature */, uint32 /*uiSender*/, uint32 uiAction)
	{
		switch (uiAction)
		{

		case 0: {

			player->GetGUID();
			ChatHandler(player->GetSession()).PSendSysMessage("Ein anderes Wort fuer Dunkel ist gesucht und Soldaten liefen auf gesuchten Routen. Findet ihr dazu 2 Stelzen die Koordinaten veraendern, seid ihr auf dem richtigen Weg.",
				player->GetName());
			player->PlayerTalkClass->SendCloseGossip();
			return true;
		}break;

		case 1: {

			player->GetGUID();
			ChatHandler(player->GetSession()).PSendSysMessage("Hier kann man die lukrativen Raetselquestreihen abschliessen. Werden dir keine Quests angezeigt, hast du nicht die erforderlichen Vorquests abgeschlossen.",
				player->GetName());
			player->PlayerTalkClass->SendCloseGossip();
			return true;
		}break;

		case 2: {
			CustomQuestionAnswerSystem * QuestionAnswerSystem = 0;
			QuestionAnswerSystem->getQuestionForPlayer(player->GetSession()->GetPlayer());
			return true;
		}break;

			return true;
		}
		return true;
	};

};


class indomatanpc : public CreatureScript
{
public: indomatanpc() : CreatureScript("indomatanpc"){ }


		bool OnGossipHello(Player *player, Creature* creature)
		{
			
			if (creature->IsQuestGiver())
				player->PrepareQuestMenu(creature->GetGUID());

			player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
			return true;
		}
		

		bool OnQuestReward(Player* /*player*/, Creature* creature, Quest const* quest, uint32 /*opt*/) {
			if (quest->GetQuestId() == 900808){
				creature->HandleEmoteCommand(EMOTE_ONESHOT_DANCE);
				creature->Yell("Du hast den ersten Schritt geschafft", LANG_UNIVERSAL, NULL);
				return true;
			}

			if (quest->GetQuestId() == 900809){
				creature->HandleEmoteCommand(EMOTE_ONESHOT_DANCE);
				creature->Yell("Du hast den ersten Schritt geschafft", LANG_UNIVERSAL, NULL);
				return true;
			}

			if (quest->GetQuestId() == 900829){
				creature->HandleEmoteCommand(EMOTE_ONESHOT_DANCE);
				creature->Yell("Dieser Verrat muss geraecht werden!", LANG_UNIVERSAL, NULL);
				return true;
			}

			if (quest->GetQuestId() == 900830){
				creature->HandleEmoteCommand(EMOTE_ONESHOT_DANCE);
				creature->Yell("Der erste ist tot. Schlachtet den naechsten ab!", LANG_UNIVERSAL, NULL);
				return true;
			}

			if (quest->GetQuestId() == 900831){
				creature->HandleEmoteCommand(EMOTE_ONESHOT_DANCE);
				creature->Yell("Der erste ist tot. Schlachtet den naechsten ab!", LANG_UNIVERSAL, NULL);
				return true;
			}

			if (quest->GetQuestId() == 900832){
				creature->HandleEmoteCommand(EMOTE_ONESHOT_DANCE);
				creature->Yell("Und der Zweite ist tot. Ihr seid ein wahrer Krieger!", LANG_UNIVERSAL, NULL);
				return true;
			}

			if (quest->GetQuestId() == 900834){
				creature->HandleEmoteCommand(EMOTE_ONESHOT_LAND);
				creature->Yell("Ich danke, dass ihr mich so unterstuetzt!", LANG_UNIVERSAL, NULL);
				creature->AddAura(52940,creature);
				return true;
			}

			if (quest->GetQuestId() == 900835){
				creature->HandleEmoteCommand(EMOTE_ONESHOT_DANCE);
				creature->Yell("Und der Zweite ist tot. Ihr seid ein wahrer Krieger!", LANG_UNIVERSAL, NULL);
				return true;
			}
			return true;
		}

		bool OnQuestAccept(Player* player, Creature* /*creature*/, Quest const* quest) {
			if (quest->GetQuestId() == 900835){
				player->AddItem(5917, 1);
				return true;
			}
			return true;
		}


};


class lucionnpc : public CreatureScript
{
public: lucionnpc() : CreatureScript("lucion"){ }

		struct lucionAI: public ScriptedAI{

			lucionAI(Creature* creature) : ScriptedAI(creature) {}

			void Reset() override
			{
				_events.Reset();
				me->setFaction(35);
			}

			void EnterCombat(Unit* /*who*/) override
			{
				_events.SetPhase(PHASE_ONE);

			}

			void JustDied(Unit* /*killer*/) override
			{
				me->Yell("Ihr habt mich besiegt. Aber mein Meister wird weitere schicken!", LANG_UNIVERSAL, nullptr);
			}


		private:
			EventMap _events;
		};

		CreatureAI* GetAI(Creature* creature) const override
		{
			return new lucionAI(creature);
		}

		bool OnQuestReward(Player* /*player*/, Creature* creature, Quest const* quest, uint32 /*opt*/) override {
			if (quest->GetQuestId() == 900823){
				creature->HandleEmoteCommand(EMOTE_ONESHOT_APPLAUD);
				creature->Yell("Danke fuer die Vorraete!", LANG_UNIVERSAL, NULL);
				return true;
			}

			if (quest->GetQuestId() == 900824){
				creature->HandleEmoteCommand(EMOTE_ONESHOT_APPLAUD);
				creature->Yell("Endlich liegen diese Maden im Dreck!", LANG_UNIVERSAL, NULL);
				return true;
			}

			if (quest->GetQuestId() == 900828){
				creature->HandleEmoteCommand(EMOTE_ONESHOT_ATTACK2HTIGHT);
				creature->Yell("Nun seid ihr an der Reihe Abschaum. Sterbt!", LANG_UNIVERSAL, NULL);
				creature->setFaction(21);
				return true;
			}

			return true;
		}



		bool OnQuestAccept(Player* /*player*/, Creature* creature, Quest const* quest) override {
			if (quest->GetQuestId() == 900825){
				creature->HandleEmoteCommand(EMOTE_ONESHOT_APPLAUD);
				creature->Yell("Hoert mir zu. Ich muss euch etwas wichtiges erzaehlen bevor wir hier weitermachen koennen. Groot und Kraserius von den Sammlern verdaechtigen mich, das ich ein Verraeter sei und nicht im Interesse von uns handeln wuerde. Aber ich kann Euch versichern, dem ist nicht so. Es ist eher anders, die beiden betruegen uns und das gesamte Volk. Sie nutzen uns aus und berreichern sich selbst. Glaubt mir! Ich moechte nicht das auch ihr ausgenutzt werdet.", LANG_UNIVERSAL, NULL);
			}
			return true;
		}


};

void AddSC_wandervolk()
{
	new wandervolk();
	new leandaria();
	new raetsel();
	new indomatanpc();
	new lucionnpc();
	new janarius();
}