#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "Player.h"

enum Spells
{
	SPELL_SLIME_BOLT = 32309,
	SPELL_BEBENDE_ERDE = 6524,
	SPELL_BLISTERING_COLD = 70123,
	SPELL_BERSERK = 26662,
	SPELL_ENRAGE = 68335,
	SPELL_TOXIC_WASTE = 69024
};

enum Events
{
	EVENT_COLD = 1,
	EVENT_BEBENDE_ERDE = 2,
	EVENT_SLIME_BOLT = 3,
	EVENT_SUMMONS = 4,
	EVENT_BERSERK = 5,
	EVENT_ENRAGE = 6,
	EVENT_WASTE = 7

};

enum Phases
{
	PHASE_ONE = 1,
	PHASE_TWO = 2,
	PHASE_THREE = 3
};

enum Summons
{
	NPC_SCHMORRSCHUPPEN = 40421
};

enum Texts
{
	SAY_AGGRO = 0,
	SAY_RANDOM = 1,
	SAY_HELP = 2,
	SAY_BERSERK = 3,
	SAY_ENRAGE = 4,
	SAY_DEAD = 5
};

class boss_galadriel : public CreatureScript
{
public:
	boss_galadriel() : CreatureScript("boss_galadriel") { }

	struct boss_twoAI : public ScriptedAI
	{
		boss_twoAI(Creature* creature) : ScriptedAI(creature), Summons(me) { }

		void Reset() override
		{
			_events.Reset();
			Summons.DespawnAll();
		}

		void EnterCombat(Unit* /*who*/) override
		{
			Talk(SAY_AGGRO);
			_events.SetPhase(PHASE_ONE);
			_events.ScheduleEvent(EVENT_COLD, 1000);
			_events.ScheduleEvent(EVENT_BEBENDE_ERDE,10000);
			_events.ScheduleEvent(EVENT_WASTE, 8000);
						
		}

		void DamageTaken(Unit* /*attacker*/, uint32& damage) override
		{
			if (me->HealthBelowPctDamaged(75, damage) && _events.IsInPhase(PHASE_ONE))
			{
				_events.SetPhase(PHASE_TWO);
				_events.ScheduleEvent(EVENT_SLIME_BOLT, 10000);
				_events.ScheduleEvent(EVENT_WASTE, 20000);
			
			}

			if (me->HealthBelowPctDamaged(35, damage) && _events.IsInPhase(PHASE_TWO))
			{
				_events.SetPhase(PHASE_THREE);
				_events.ScheduleEvent(EVENT_SUMMONS, 5000);
				_events.ScheduleEvent(EVENT_BERSERK, 10000);
				_events.ScheduleEvent(EVENT_ENRAGE, 120000); //2Minuten sonst alle tot!
			}
		}

		void JustSummoned(Creature* summon) override
		{
			Summons.Summon(summon);

			switch (summon->GetEntry())
			{
			case NPC_SCHMORRSCHUPPEN:
				if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 300.0f))
					summon->AI()->AttackStart(target); // I think it means the Tank !
				break;
			}
		}

		void JustDied(Unit* ) override
		{
			char msg[250];
			snprintf(msg, 250, "|cffff0000[Boss System]|r Boss|cffff6060 Galadriel|r wurde getoetet! Der Respawn ist in 7 Tagen ab jetzt! "); 
			sWorld->SendGlobalText(msg, NULL);
			Summons.DespawnAll();
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
				case EVENT_SLIME_BOLT:
					DoCast(me, EVENT_SLIME_BOLT);
					break;
				case EVENT_BEBENDE_ERDE:
					DoCastVictim(SPELL_BEBENDE_ERDE);
					_events.ScheduleEvent(EVENT_BEBENDE_ERDE, 8000);
					break;
				case EVENT_COLD:
					Talk(SAY_RANDOM);
					DoCastVictim(SPELL_BLISTERING_COLD);
					_events.ScheduleEvent(EVENT_COLD, 30000);
					break;
				case EVENT_SUMMONS:
					Talk(SAY_HELP);
					me->SummonCreature(NPC_SCHMORRSCHUPPEN, me->GetPositionX() + 5, me->GetPositionY(), me->GetPositionZ() + 5, 0, TEMPSUMMON_CORPSE_DESPAWN, 600000);
					me->SummonCreature(NPC_SCHMORRSCHUPPEN, me->GetPositionX() + 5, me->GetPositionY(), me->GetPositionZ() + 5, 0, TEMPSUMMON_CORPSE_DESPAWN, 600000);
					me->SummonCreature(NPC_SCHMORRSCHUPPEN, me->GetPositionX() + 5, me->GetPositionY(), me->GetPositionZ() + 5, 0, TEMPSUMMON_CORPSE_DESPAWN, 600000);
					break;
				case EVENT_BERSERK:
					Talk(SAY_BERSERK);
					DoCast(me, SPELL_BERSERK);
					_events.ScheduleEvent(EVENT_BERSERK, 120000);
					break;
				case EVENT_ENRAGE:
					Talk(SAY_ENRAGE);
					DoCast(me, SPELL_ENRAGE);
					_events.ScheduleEvent(EVENT_ENRAGE, 10000);
					break;
				case EVENT_WASTE:
					DoCastToAllHostilePlayers(SPELL_TOXIC_WASTE);
					_events.ScheduleEvent(EVENT_WASTE, 15000);
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
		return new boss_twoAI(creature);
	}



};

void AddSC_boss_galadriel()
{
	new boss_galadriel();
}