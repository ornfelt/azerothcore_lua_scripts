#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "AccountMgr.h"
#include "time.h"
#include <stdio.h>
#include <stdlib.h>
#include "GameEventMgr.h"
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

enum Spells
{
	SPELL_CORRUPTION = 65810,
	SPELL_ENRAGE = 68335,
	SPELL_CRIPPLE = 31477,
	SPELL_ARCANE_BARRAGE = 65799,
	SPELL_DOMINATE_MIND = 63713,
	SPELL_EARTH = 30129,
	SPELL_HEX = 66054,
	SPELL_PSYCHOSIS = 63795,
	SPELL_ARCANE_DEVASTION = 34799,
	SPELL_ARMY_OF_DEAD = 67761,
	SPELL_SCHATTENFALLE = 73529
	
};

enum Events
{
	EVENT_CURRUPTION = 1,
	EVENT_ENRAGE = 2,
	EVENT_CRIPPLE = 3,
	EVENT_ARCANE_BARRAGE = 4,
	EVENT_DOMINATE_MIND = 5,
	EVENT_EARTH = 6,
	EVENT_HEX = 7,
	EVENT_PSYCHOSIS = 8,
	EVENT_ARCANE_DEVASTION = 9,
	EVENT_ARMY_OF_DEAD = 10,
	EVENT_SUMMONS = 11,
	EVENT_KILL = 12,
	EVENT_SCHATTENFALLE = 13

};

enum Phases
{
	PHASE_ONE = 1,
	PHASE_TWO = 2,
	PHASE_THREE = 3
};

enum Summons
{
	NPC_TOLREOSADD = 800093
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




class tolreos : public CreatureScript
{
public:
	tolreos() : CreatureScript("tolreos") { }

	struct tolreosAI : public ScriptedAI
	{
		tolreosAI(Creature* creature) : ScriptedAI(creature), Summons(me) { }
        uint32 kills;
		void Reset() override
		{
            kills = 0;
			me->SetObjectScale(1);
			me->SetReactState(REACT_DEFENSIVE);
			_events.Reset();
			Summons.DespawnAll();
			//me->SetCurrentEquipmentId(2193);
		}

		void EnterCombat(Unit*) override
		{
			me->Yell("Ein kleiner Mensch stirbt nur zum Schein! Wollt ihr ganz alleine sein?", LANG_UNIVERSAL, nullptr);
			_events.SetPhase(PHASE_ONE);
			_events.ScheduleEvent(EVENT_CURRUPTION, 8000);
			_events.ScheduleEvent(EVENT_CRIPPLE, 10000);
			_events.ScheduleEvent(EVENT_ARCANE_BARRAGE, 8000);
			_events.ScheduleEvent(EVENT_SUMMONS, 30000);


		}

		void DamageTaken(Unit* /*attacker*/, uint32& damage) override
		{
			if (me->HealthBelowPctDamaged(75, damage) && _events.IsInPhase(PHASE_ONE))
			{
				me->Yell("Euer kleines Herz wird still fuer Stunden! So wird man Euch fuer Tod befinden.", LANG_UNIVERSAL, nullptr);
				//me->SetCurrentEquipmentId(2214);
				me->SetObjectScale(2);
				_events.SetPhase(PHASE_TWO);
				_events.ScheduleEvent(EVENT_EARTH, 10000);
				_events.ScheduleEvent(EVENT_HEX, 8000);
				_events.ScheduleEvent(EVENT_ARCANE_DEVASTION, 12000);
				_events.ScheduleEvent(EVENT_PSYCHOSIS, 10000);
				_events.ScheduleEvent(EVENT_SUMMONS, 30000);
				
				

			}

			if (me->HealthBelowPctDamaged(35, damage) && _events.IsInPhase(PHASE_TWO))
			{
				me->Yell("Werdet verschart in nassem Sand. Habt eine Spieluhr in der Hand.", LANG_UNIVERSAL, nullptr);
				_events.SetPhase(PHASE_THREE);
				_events.ScheduleEvent(EVENT_ARMY_OF_DEAD, 5000);
				_events.ScheduleEvent(EVENT_CURRUPTION, 6000);
				_events.ScheduleEvent(EVENT_ENRAGE, 25000);
				_events.ScheduleEvent(EVENT_HEX, 12000);
				_events.ScheduleEvent(EVENT_SUMMONS, 30000);
			}
		}


		void JustDied(Unit* /*pPlayer*/) override
		{
			char msg[250];
			snprintf(msg, 250, "|cffff0000[Boss System]|r Boss|cffff6060 Tolreos|r wurde getoetet! Respawn in 5h.");
			sWorld->SendGlobalText(msg, NULL);
			Summons.DespawnAll();
		}
		 
		void KilledUnit(Unit* victim) override
		{
			kills++;
			if (victim->GetTypeId() != TYPEID_PLAYER)
				return;
			char msg[250];
			snprintf(msg, 250, "|cffff0000[Boss System]|r Boss|cffff6060 Tolreos|r hat einen Spieler getoetet. Insgesamt steht der Killcounter seit dem letzten Restart bei: %u", kills);
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
				case EVENT_CURRUPTION:
					if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1)){
						DoCast(target, SPELL_CORRUPTION);
					}
					_events.ScheduleEvent(EVENT_CURRUPTION, 10000);
					break;
				case EVENT_ENRAGE:
					DoCastToAllHostilePlayers(SPELL_ENRAGE);
					break;
				case EVENT_CRIPPLE:
					Talk(SAY_RANDOM);
					DoCastToAllHostilePlayers(SPELL_CRIPPLE);
					_events.ScheduleEvent(EVENT_CRIPPLE, 25000);
					break;
				case EVENT_ARCANE_BARRAGE:
					DoCastToAllHostilePlayers(SPELL_ARCANE_BARRAGE);
					_events.ScheduleEvent(EVENT_ARCANE_BARRAGE, 5000);
					break;
				case EVENT_SUMMONS:
					Talk(SAY_HELP);
					me->SummonCreature(NPC_TOLREOSADD, me->GetPositionX() + 5, me->GetPositionY(), me->GetPositionZ() + 5, 0, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 60000);
					_events.ScheduleEvent(EVENT_SUMMONS, 45000);
					break;
				case EVENT_EARTH:
					Talk(SAY_ENRAGE);
					if (Unit* target = SelectTarget(SELECT_TARGET_TOPAGGRO, 0)){
						DoCast(target, SPELL_EARTH);
					}
					_events.ScheduleEvent(EVENT_EARTH, 10000);
					break;
				case EVENT_PSYCHOSIS:
					if (Unit* target = SelectTarget(SELECT_TARGET_BOTTOMAGGRO,0)){
						DoCast(target, SPELL_PSYCHOSIS);
					}	
					_events.ScheduleEvent(EVENT_PSYCHOSIS, 18000);
					break;
				case EVENT_HEX:
					if (Unit* target = SelectTarget(SELECT_TARGET_FARTHEST, 0)){
						DoCast(target,SPELL_HEX);
					}
					_events.ScheduleEvent(EVENT_HEX, 10000);
					break;
				case EVENT_ARCANE_DEVASTION:
					DoCastVictim(SPELL_ARCANE_DEVASTION);
					_events.ScheduleEvent(EVENT_ARCANE_DEVASTION, 12000);
					break;
				case EVENT_ARMY_OF_DEAD:
					me->Yell("Kommt mir zur Hilfe!", LANG_UNIVERSAL, nullptr);
					DoCastToAllHostilePlayers(SPELL_ARMY_OF_DEAD);
					_events.ScheduleEvent(EVENT_ARMY_OF_DEAD, 20000);
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
		return new tolreosAI(creature);
	}



};


class tolreosadd : public CreatureScript
{
public:
	tolreosadd() : CreatureScript("tolreosadd") { }

	struct tolreosaddAI : public ScriptedAI
	{
        uint32 kills = 0;
		tolreosaddAI(Creature* creature) : ScriptedAI(creature), Summons(me) { }
		
		void Reset() override
		{
            kills = 0;
			_events.Reset();
			Summons.DespawnAll();
		}

		void EnterCombat(Unit*) override
		{
			me->Yell("In 30 Sekunden seid ihr Tod Abschaum!", LANG_UNIVERSAL, nullptr);
			_events.SetPhase(PHASE_ONE);
			_events.ScheduleEvent(EVENT_SCHATTENFALLE, 30000);
			

		}

		void DamageTaken(Unit* /*attacker*/, uint32& damage) override
		{
			if (me->HealthBelowPctDamaged(100, damage) && _events.IsInPhase(PHASE_ONE))
			{
				_events.SetPhase(PHASE_TWO);
				_events.ScheduleEvent(EVENT_SCHATTENFALLE, 30000);


			}
		}


		void KilledUnit(Unit* victim) override
		{
			kills++;
			if (victim->GetTypeId() != TYPEID_PLAYER)
				return;
			char msg[250];
			snprintf(msg, 250, "|cffff0000[Boss System]|r Boss|cffff6060 Tolreos|r hat einen Spieler getoetet. Insgesamt steht der Killcounter seit dem letzten Restart bei: %u", kills);
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
				case EVENT_SCHATTENFALLE:	
					DoCast(SPELL_SCHATTENFALLE);
					_events.ScheduleEvent(EVENT_SCHATTENFALLE, 10000);
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
		return new tolreosaddAI(creature);
	}



};


void AddSC_tolreos()
{
	new tolreos();
	new tolreosadd();
}