#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "Player.h"

enum Spells
{
	SPELL_ALPTRAUM = 50341,
	SPELL_ENRAGE = 68335,
	SPELL_ARKANE_AUFLADUNG = 41349,
	SPELL_FEUERBALL = 388369,
	SPELL_BLITZENTLADUNG = 39028,
	SPELL_BLIZZARD = 70362,
	SPELL_BLUTGERUCH = 72769,
	SPELL_BRECHENDE_WELLE = 57652,
	SPELL_DEGENERATION = 53605,
	SPELL_DURCHDRINGENDE_KAELTE = 66013,
	SPELL_EISBLITZ = 31249,
	SPELL_ERNEUERUNG = 66177,
	SPELL_SEUCHENBOMBE = 61858,
	SPELL_SEUCHENSTROM = 69871,
	SPELL_BLISTERING_COLD = 71049,
	SPELL_TOXIC_WASTE = 69024,
	SPELL_SPALTEN = 74367,
	SPELL_ARMY_OF_DEAD = 67761

};

enum Events
{
	EVENT_ALPTRAUM = 1,
	EVENT_ENRAGE = 2,
	EVENT_ARKANE_AUFLADUNG = 3,
	EVENT_FEUERBALL = 4,
	EVENT_BLITZENTLADUNG = 5,
	EVENT_BLIZZARD = 6,
	EVENT_BLUTGERUCH = 7,
	EVENT_BRECHENDE_WELLE = 8,
	EVENT_DEGENERATION = 9,
	EVENT_DURCHDRINGENDE_KAELTE = 10,
	EVENT_EISBLITZ = 11,
	EVENT_ERNEUERUNG = 12,
	EVENT_SEUCHENBOMBE = 13,
	EVENT_TOXIC_WASTE = 14,
	EVENT_SPALTEN = 15,
	EVENT_ARMY_OF_DEAD = 16,
	EVENT_SUMMONS_HARD = 17,
	EVENT_SUMMONS = 18
};

enum Phases
{
	PHASE_ONE = 1,
	PHASE_TWO = 2,
	PHASE_THREE = 3
};

enum Summons
{
	NPC_SCHMORSCHUPPEN = 40417
};

enum Texts
{
	SAY_AGGRO = 0,
	SAY_RANDOM = 1,
	SAY_KILL = 2,
	SAY_DEAD = 3,
	SAY_BLIZZARD = 4

};

class lighthardmode : public CreatureScript
{
public:
	lighthardmode() : CreatureScript("lighthardmode") { }

	struct lighthardmodeAI : public ScriptedAI
	{
		lighthardmodeAI(Creature* creature) : ScriptedAI(creature), Summons(me)

		{

		}

		uint32 playerdie = 0;


		void Reset() override
		{
			_events.Reset();
			Summons.DespawnAll();
			playerdie = 0;
		}




		void Lootchange(uint32 playerdie){
			me->ResetLootMode();
			if (playerdie == 0){
				me->AddLootMode(LOOT_MODE_HARD_MODE_2);
			}
			else{
				me->AddLootMode(LOOT_MODE_DEFAULT);
			}
		}

		void AggroAllPlayers(Creature* temp)
		{
			Map::PlayerList const &PlList = temp->GetMap()->GetPlayers();

			if (PlList.isEmpty())
				return;

			for (Map::PlayerList::const_iterator i = PlList.begin(); i != PlList.end(); ++i)
			{
				if (Player* player = i->GetSource())
				{
					if (player->IsGameMaster())
						continue;

					if (player->IsAlive())
					{
						temp->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_PC);
						temp->SetReactState(REACT_AGGRESSIVE);
						temp->SetInCombatWith(player);
						player->SetInCombatWith(temp);
						temp->AddThreat(player, 0.0f);
					}
				}
			}
		}

		void EnterCombat(Unit* /*who*/) override
		{
			Talk(SAY_AGGRO);
			_events.SetPhase(PHASE_ONE);
			_events.ScheduleEvent(EVENT_ALPTRAUM, 8000);
			_events.ScheduleEvent(EVENT_ARKANE_AUFLADUNG, 10000);
			_events.ScheduleEvent(EVENT_FEUERBALL, 25000);
			_events.ScheduleEvent(EVENT_BLITZENTLADUNG, 12000);
			_events.ScheduleEvent(EVENT_SEUCHENBOMBE, 30000);
			_events.ScheduleEvent(EVENT_TOXIC_WASTE, 15000);
			_events.ScheduleEvent(EVENT_SPALTEN, 10000);
			_events.ScheduleEvent(EVENT_DURCHDRINGENDE_KAELTE, 18000);

		}

		void DamageTaken(Unit* /*attacker*/, uint32& damage) override
		{
			if (me->HealthBelowPctDamaged(75, damage) && _events.IsInPhase(PHASE_ONE))
			{
				_events.SetPhase(PHASE_TWO);
				_events.ScheduleEvent(EVENT_BLIZZARD, 15000);
				_events.ScheduleEvent(SPELL_BLUTGERUCH, 8000);
				_events.ScheduleEvent(EVENT_BRECHENDE_WELLE, 12000);
				_events.ScheduleEvent(EVENT_DEGENERATION, 10000);
				_events.ScheduleEvent(EVENT_EISBLITZ, 25000);
				_events.ScheduleEvent(EVENT_ERNEUERUNG, 20000);
				_events.ScheduleEvent(EVENT_SEUCHENBOMBE, 30000);
				_events.ScheduleEvent(EVENT_SUMMONS, 60000);
				_events.ScheduleEvent(EVENT_TOXIC_WASTE, 15000);
				_events.ScheduleEvent(EVENT_SPALTEN, 10000);
			}

			if (me->HealthBelowPctDamaged(35, damage) && _events.IsInPhase(PHASE_TWO))
			{
				_events.SetPhase(PHASE_THREE);
				_events.ScheduleEvent(EVENT_BLUTGERUCH, 8000);
				_events.ScheduleEvent(EVENT_DEGENERATION, 6000);
				_events.ScheduleEvent(EVENT_BLIZZARD, 12000);
				_events.ScheduleEvent(EVENT_ARKANE_AUFLADUNG, 10000);
				_events.ScheduleEvent(EVENT_ENRAGE, 120000);
				_events.ScheduleEvent(EVENT_TOXIC_WASTE, 15000);
				_events.ScheduleEvent(EVENT_SUMMONS_HARD, 60000);
				_events.ScheduleEvent(EVENT_SPALTEN, 10000);
			}
		}

		void JustSummoned(Creature* summon) override
		{
			Summons.Summon(summon);

			switch (summon->GetEntry())
			{
			case NPC_SCHMORSCHUPPEN:
				if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 300.0f))
					summon->AI()->AttackStart(target);
				break;
			}
		}

		void Questcomplete(){
            Player* pPlayer = nullptr;
			pPlayer->GetGUID();
			pPlayer->SendQuestComplete(899000);
		}

		void JustDied(Unit* pPlayer) override
		{

			
			Talk(SAY_DEAD);
			char msg[250];
			snprintf(msg, 250, "|cffff0000[Boss System]|r Boss|cffff6060 Lightshadow|r wurde getoetet! Respawn in 4h 33min. Darkshadow ist nun der rechtmaessige Prinz! %u", playerdie);
			sWorld->SendGlobalText(msg, NULL);
			Map::PlayerList const &PlList = pPlayer->GetMap()->GetPlayers();
			if (PlList.isEmpty())
				return;
			Lootchange(playerdie);
			for (Map::PlayerList::const_iterator i = PlList.begin(); i != PlList.end(); ++i)
			{
				if (Player* player = i->GetSource())
				{
					if (player->IsGameMaster())
						continue;

					if (player->IsAlive())
					{
						player->RemoveAllAuras();
						if (player->hasQuest(899000) && playerdie == 0){
							Questcomplete();
							
						}
						else {
							player->SendQuestFailed(899000,EQUIP_ERR_OK);
														
						}
					
					}
				}
			}

		}


		void KilledUnit(Unit* victim) override
		{
			Talk(SAY_KILL);
			if (victim->GetTypeId() != TYPEID_PLAYER)
				return;
			char msg[250];
			DoCast(me, SPELL_ERNEUERUNG);
			DoCast(me, SPELL_ENRAGE);
			DoCast(SPELL_SEUCHENSTROM);
			DoCast(SPELL_SEUCHENBOMBE);
			DoCast(SPELL_BLISTERING_COLD);
			DoCast(SPELL_ARMY_OF_DEAD);
			++playerdie;
			snprintf(msg, 250, "|cffff0000[Boss System]|r |cffff6060 Lightshadow|r hat einen Mitstreiter Darkshadows ermordet! Was fuer eine Schmach! Killcounter steht bei: %u", playerdie);
			sWorld->SendGlobalText(msg, NULL);
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
				case EVENT_ALPTRAUM:
					DoCastToAllHostilePlayers(SPELL_ALPTRAUM);
					_events.ScheduleEvent(EVENT_ALPTRAUM, 10000);
					break;
				case EVENT_ENRAGE:
					DoCastToAllHostilePlayers(SPELL_ENRAGE);
					break;
				case EVENT_ARKANE_AUFLADUNG:
					DoCastToAllHostilePlayers(SPELL_ARKANE_AUFLADUNG);
					_events.ScheduleEvent(EVENT_BLIZZARD, 15000);
					break;
				case EVENT_FEUERBALL:
					DoCastToAllHostilePlayers(SPELL_FEUERBALL);
					_events.ScheduleEvent(EVENT_SEUCHENBOMBE, 10000);
					break;
				case EVENT_BLITZENTLADUNG:
					DoCastToAllHostilePlayers(SPELL_BLITZENTLADUNG);
					_events.ScheduleEvent(EVENT_BLITZENTLADUNG, 12000);
					break;
				case EVENT_BLIZZARD:
					Talk(SAY_BLIZZARD);
					DoCastToAllHostilePlayers(SPELL_BLIZZARD);
					_events.ScheduleEvent(EVENT_ARKANE_AUFLADUNG, 25000);
					break;
				case EVENT_BLUTGERUCH:
					DoCastToAllHostilePlayers(SPELL_BLUTGERUCH);
					_events.ScheduleEvent(EVENT_BLUTGERUCH, 18000);
					break;
				case EVENT_BRECHENDE_WELLE:
					DoCastVictim(SPELL_BRECHENDE_WELLE);
					_events.ScheduleEvent(EVENT_BRECHENDE_WELLE, 12000);
					break;
				case EVENT_DEGENERATION:
					DoCast(SPELL_DEGENERATION);
					_events.ScheduleEvent(EVENT_DEGENERATION, 20000, 1);
					break;
				case EVENT_DURCHDRINGENDE_KAELTE:
					DoCastToAllHostilePlayers(SPELL_DURCHDRINGENDE_KAELTE);
					_events.ScheduleEvent(EVENT_DURCHDRINGENDE_KAELTE, 12000);
					break;
				case EVENT_EISBLITZ:
					DoCastToAllHostilePlayers(SPELL_EISBLITZ);
					_events.ScheduleEvent(EVENT_ERNEUERUNG, 25000);
					break;
				case EVENT_ERNEUERUNG:
					DoCast(me, SPELL_ERNEUERUNG);
					_events.ScheduleEvent(EVENT_EISBLITZ, 25000);
					break;
				case EVENT_SEUCHENBOMBE:
					DoCast(me, SPELL_SEUCHENBOMBE);
					_events.ScheduleEvent(EVENT_SEUCHENBOMBE, 25000);
					break;
				case EVENT_TOXIC_WASTE:
					DoCastToAllHostilePlayers(SPELL_TOXIC_WASTE);
					_events.ScheduleEvent(EVENT_TOXIC_WASTE, 15000);
					break;
				case EVENT_SPALTEN:
					DoCastVictim(SPELL_SPALTEN);
					_events.ScheduleEvent(EVENT_SPALTEN, 10000);
					break;
				case EVENT_ARMY_OF_DEAD:
					DoCast(SPELL_ARMY_OF_DEAD);
					break;
				case EVENT_SUMMONS_HARD:
					me->SummonCreature(NPC_SCHMORSCHUPPEN, me->GetPositionX() + 5, me->GetPositionY(), me->GetPositionZ() + 5, 0, TEMPSUMMON_CORPSE_DESPAWN, 600000);
					me->SummonCreature(NPC_SCHMORSCHUPPEN, me->GetPositionX() + 5, me->GetPositionY(), me->GetPositionZ() + 5, 0, TEMPSUMMON_CORPSE_DESPAWN, 600000);
					break;
				case EVENT_SUMMONS:
					me->SummonCreature(NPC_SCHMORSCHUPPEN, me->GetPositionX() + 5, me->GetPositionY(), me->GetPositionZ() + 5, 0, TEMPSUMMON_CORPSE_DESPAWN, 600000);
					break;

				default:
					break;
				}
			}

			DoMeleeAttackIfReady();
		}

	private:
		EventMap _events;
		SummonList Summons;
	};

	CreatureAI* GetAI(Creature* creature) const override
	{
		return new lighthardmodeAI(creature);
	}



};

void AddSC_lighthardmode()
{
	new lighthardmode();
}