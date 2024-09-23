#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "Player.h"

enum Spells
{
	SPELL_MANA_DESTRUCTION = 59374,
	SPELL_BRAIN_LINK_DAMAGE = 63803,
	SPELL_NECROTIC_AURA = 55593,
	SPELL_CRYSTAL_CHAINS = 50997,
	SPELL_NECROTIC_POISON = 28776,
	SPELL_MANGLING_SLASH = 48873,
	SPELL_PIERCING_SLASH = 48878,
	SPELL_BLOOD_MIRROR_DAMAGE = 70821,
	SPELL_ANNOYING_YIPPING = 31015,
	SPELL_SARGERAS = 28342,
	SPELL_BURN = 46218,
	SPELL_TAIL_LASH = 56910,
	SPELL_EISBLOCK = 27619
};

enum Events
{
	EVENT_MANA_DESTRUCTION = 1,
	EVENT_BRAIN_LINK_DAMAGE = 2,
	EVENT_NECROTIC_AURA = 3,
	EVENT_CRYSTAL_CHAINS = 4,
	EVENT_NECROTIC_POISON = 5,
	EVENT_MANGLING_SLASH = 6,
	EVENT_PIERCING_SLASH = 7,
	EVENT_BLOOD_MIRROR_DAMAGE = 8,
	EVENT_ANNOYING_YIPPING = 9,
	EVENT_SARGERAS = 10,
	EVENT_BURN = 11,
	EVENT_TAIL_LASH = 12,
	EVENT_SUMMONS = 13,
	EVENT_EISBLOCK = 14

};

enum Phases
{
	PHASE_ONE = 1,
	PHASE_TWO = 2,
	PHASE_THREE = 3
};

enum Summons
{
	NPC_ADD = 800094
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

uint32 kills = 0;


class eonar : public CreatureScript
{
public:
	eonar() : CreatureScript("eonar") { }

	struct eonarAI : public ScriptedAI
	{
		eonarAI(Creature* creature) : ScriptedAI(creature), Summons(me) { }
		uint32 armor = 0;
		void Reset() override
		{
			kills = 0;
			_events.Reset();
			me->SetReactState(REACT_DEFENSIVE);
			Summons.DespawnAll();
			armor = me->GetArmor();
			me->SetObjectScale(1);
			me->SetArmor(20);


		}

		void EnterCombat(Unit* /*who*/) override
		{
			_events.SetPhase(PHASE_ONE);
			_events.ScheduleEvent(EVENT_MANA_DESTRUCTION, 1000);
			_events.ScheduleEvent(EVENT_BRAIN_LINK_DAMAGE, 60000);
			_events.ScheduleEvent(EVENT_MANGLING_SLASH, 8000);
			_events.ScheduleEvent(EVENT_SARGERAS, 10000);
			_events.ScheduleEvent(EVENT_TAIL_LASH, 5000);
			_events.ScheduleEvent(EVENT_SUMMONS, 30000);

		}

		void DamageTaken(Unit* /*attacker*/, uint32& damage) override
		{
			if (me->HealthBelowPctDamaged(65, damage) && _events.IsInPhase(PHASE_ONE))
			{
				_events.SetPhase(PHASE_TWO);
				_events.ScheduleEvent(EVENT_MANA_DESTRUCTION, 10000);
				_events.ScheduleEvent(EVENT_PIERCING_SLASH, 20000);
				_events.ScheduleEvent(EVENT_BRAIN_LINK_DAMAGE, 10000);
				_events.ScheduleEvent(EVENT_BLOOD_MIRROR_DAMAGE, 10000);
				_events.ScheduleEvent(EVENT_TAIL_LASH, 5000);

			}

			if (me->HealthBelowPctDamaged(25, damage) && _events.IsInPhase(PHASE_TWO))
			{
				_events.SetPhase(PHASE_THREE);
				_events.ScheduleEvent(EVENT_CRYSTAL_CHAINS, 5000);
				_events.ScheduleEvent(EVENT_PIERCING_SLASH, 10000);
				_events.ScheduleEvent(EVENT_NECROTIC_POISON, 12000);
				_events.ScheduleEvent(EVENT_ANNOYING_YIPPING, 25000);
				_events.ScheduleEvent(EVENT_BURN, 35000);
				_events.ScheduleEvent(EVENT_TAIL_LASH, 5000);
			}
		}


		void JustDied(Unit* /*player */) override
		{

			char msg[250];
			snprintf(msg, 250, "|cffff0000[Boss System]|r Boss|cffff6060 Eonar|r wurde getoetet! Respawn in 4h 30min.");
			sWorld->SendGlobalText(msg, NULL);
			Summons.DespawnAll();
		}



		void SpellHit(Unit* caster, SpellInfo const* spell) override
		{

			if (spell->Id == 35395){
				me->Yell("Eure Kreuzfahrerstoesse werden Euch nicht retten.", LANG_UNIVERSAL, nullptr);
				me->SetInCombatWith(caster);
				me->SetDisplayId(27971);
			}


			if (spell->Id == 49921 || spell->Id == 66992){
				armor = me->GetArmor();
				me->SetName("Eonar der Alte");
				me->SetObjectScale(2);
				me->CombatStop(true);
				armor = armor + 10;
				me->SetArmor(armor);
				me->Yell("Eure Seuchen werden mich nicht aufhalten. Meine Ruestung wird immer haerter!", LANG_UNIVERSAL, nullptr);

			}



		}

		void KilledUnit(Unit* victim) override
		{

			if (victim->GetTypeId() != TYPEID_PLAYER)
				return;
			char msg[250];

			++kills;
			snprintf(msg, 250, "|cffff0000[Boss System]|r |cffff6060 Eonar|r hat einen Spieler getoetet! Was fuer eine Schmach. Insgesamt steht der Killcounter seit dem letzten Restart bei: %u", kills);
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

				case EVENT_SUMMONS:
					
					me->SummonCreature(NPC_ADD, me->GetPositionX() + 5, me->GetPositionY() + 5, me->GetPositionZ(), 0, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 60000);
					_events.ScheduleEvent(EVENT_SUMMONS, 30000);
					break;
				case EVENT_NECROTIC_AURA:
					DoCast(me->GetVictim(), SPELL_NECROTIC_AURA);
					break;
				case EVENT_BRAIN_LINK_DAMAGE:
					DoCastVictim(SPELL_BRAIN_LINK_DAMAGE);
					_events.ScheduleEvent(EVENT_BRAIN_LINK_DAMAGE, 8000);
					break;
				case EVENT_MANA_DESTRUCTION:
					
					DoCastVictim(SPELL_MANA_DESTRUCTION);
					_events.ScheduleEvent(EVENT_MANA_DESTRUCTION, 1000);
					break;
				case EVENT_CRYSTAL_CHAINS:
					DoCastVictim(SPELL_CRYSTAL_CHAINS);
					_events.ScheduleEvent(EVENT_CRYSTAL_CHAINS, 30000);
					break;
				case EVENT_NECROTIC_POISON:
					
					DoCast(me->GetVictim(), SPELL_NECROTIC_POISON);
					_events.ScheduleEvent(EVENT_NECROTIC_POISON, 120000);
					break;
				case EVENT_MANGLING_SLASH:
					Talk(SAY_ENRAGE);
					DoCast(me, SPELL_MANGLING_SLASH);
					_events.ScheduleEvent(EVENT_MANGLING_SLASH, 10000);
					break;
				case EVENT_PIERCING_SLASH:
					DoCastToAllHostilePlayers(SPELL_PIERCING_SLASH);
					_events.ScheduleEvent(EVENT_PIERCING_SLASH, 15000);
					break;
				case EVENT_BLOOD_MIRROR_DAMAGE:
					DoCast(me->GetVictim(), SPELL_BLOOD_MIRROR_DAMAGE);
					_events.ScheduleEvent(EVENT_BLOOD_MIRROR_DAMAGE, 18000);
					break;
				case EVENT_ANNOYING_YIPPING:
					DoCastToAllHostilePlayers(SPELL_ANNOYING_YIPPING);
					_events.ScheduleEvent(EVENT_ANNOYING_YIPPING, 25000);
					break;
				case EVENT_SARGERAS:
					DoCastToAllHostilePlayers(SPELL_SARGERAS);
					_events.ScheduleEvent(EVENT_SARGERAS, 5000);
					break;
				case EVENT_BURN:
					DoCastVictim(SPELL_BURN);
					_events.ScheduleEvent(EVENT_BURN, 35000);
					break;
				case EVENT_TAIL_LASH:
					DoCast(me->GetVictim(), SPELL_TAIL_LASH);
					_events.ScheduleEvent(EVENT_BURN, 5000);
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
		return new eonarAI(creature);
	}



};


class eonaradd : public CreatureScript
{
public: eonaradd() : CreatureScript("eonaradd") { }


		struct eonaraddAI : public ScriptedAI
		{
			eonaraddAI(Creature* creature) : ScriptedAI(creature), Summons(me) { }
			bool deathstate = false;
			void Reset() override
			{
				me->SetReactState(REACT_AGGRESSIVE);
				_events.Reset();
				deathstate = false;
			}

			void SpellHit(Unit* caster, SpellInfo const* spell) override
			{

				if (spell->Id == 48638){
					me->Yell("Feel the Force!", LANG_UNIVERSAL, nullptr);
					me->SelectNearestHostileUnitInAggroRange(false);
					me->SetObjectScale(3);
					me->AddAura(45438, caster);
					deathstate = true;
				}


			}

			void EnterCombat(Unit*) override
			{
				Talk(SAY_AGGRO);
				_events.SetPhase(PHASE_ONE);
				_events.ScheduleEvent(EVENT_EISBLOCK, 10000);

			}

			void DamageTaken(Unit* /*attacker*/, uint32& damage) override
			{
				if (me->HealthBelowPctDamaged(100, damage) && _events.IsInPhase(PHASE_ONE))
				{

					_events.ScheduleEvent(EVENT_EISBLOCK, 15000);
				}

				if (me->HealthBelowPct(2) && _events.IsInPhase(PHASE_ONE))
				{
					if (!deathstate){
						me->SetFullHealth();
					}

					else{
						me->DespawnOrUnsummon(1);
					}
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
					case EVENT_EISBLOCK:
						if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0)){
							DoCast(target, SPELL_EISBLOCK);
						}
						_events.ScheduleEvent(EVENT_EISBLOCK, 10000);
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
			return new eonaraddAI(creature);
		}

};


void AddSC_eonar()
{
	new eonar();
	new eonaradd();
}