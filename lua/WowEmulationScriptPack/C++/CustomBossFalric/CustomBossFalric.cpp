#include "ScriptMgr.h"
#include "SpellMgr.h"
#include "ScriptedCreature.h"

enum Texts
{
    SAY_AGGRO                                     = 0,
    SAY_SLAY                                      = 1,
    SAY_DEATH                                     = 2,
    SAY_IMPENDING_DESPAIR                         = 3,
    SAY_DEFILING_HORROR                           = 4,
    SAY_SHADOW_NOVA                               = 5,
    SAY_DECIMATE                                  = 6,
    SAY_ZOMBIES                                   = 7,
    SAY_PLAGUED_ZOMBIES                           = 8
};

enum Spells
{
    SPELL_QUIVERING_STRIKE                        = 72422, //attack
    SPELL_IMPENDING_DESPAIR                       = 72426, //stun
    SPELL_DEFILING_HORROR                         = 72435, //bun fear
    SPELL_HOPELESSNESS_1                          = 72395, //bun curse
    SPELL_HOPELESSNESS_2                          = 72396, //bun curse
    SPELL_HOPELESSNESS_3                          = 72397, //bun curse
    SPELL_SHADOW_NOVA                             = 36127, //boom nasol trebuie rar
    SPELL_DECIMATE                                = 71123, //15% hp down
    SPELL_AWAKEN_PLAGUED_ZOMBIES                  = 71159 //spawn Zombies
};

enum Events
{
    EVENT_NONE,
    EVENT_QUIVERING_STRIKE,
    EVENT_IMPENDING_DESPAIR,
    EVENT_DEFILING_HORROR,
    EVENT_VOID_ZONE,
    EVENT_SHADOW_NOVA,
    EVENT_SUMMON_ZOMBIES
};

uint32 const HopelessnessHelper[3] = { SPELL_HOPELESSNESS_1, SPELL_HOPELESSNESS_2, SPELL_HOPELESSNESS_3 };

#define FALRIC_BOSS_ID 123411

//Zombalau - will rename later :)
class CustomBossFalric : public CreatureScript
{
    public:
        CustomBossFalric() : CreatureScript("CustomBossFalric") { }

        struct boss_falricAI : public BossAI
        {
            boss_falricAI(Creature* creature) : BossAI(creature, FALRIC_BOSS_ID)
            {
                Initialize();
            }

            void Initialize()
            {
                _hopelessnessCount = 0;
            }

            void Reset() override
            {
                BossAI::Reset();
                Initialize();
            }

            void JustEngagedWith(Unit* /*who*/) override
            {
                Talk(SAY_AGGRO);
                events.ScheduleEvent(EVENT_QUIVERING_STRIKE, 9000);
                events.ScheduleEvent(EVENT_IMPENDING_DESPAIR, 15000);
                events.ScheduleEvent(EVENT_DEFILING_HORROR, 90000);
                events.ScheduleEvent(EVENT_SHADOW_NOVA, 120000);
                events.ScheduleEvent(EVENT_SUMMON_ZOMBIES, urand(20000, 22000));
            }

            void DoAction(int32 action) override
            {
            }

            void DamageTaken(Unit* /*attacker*/, uint32& damage) override
            {
                if ((_hopelessnessCount < 1 && me->HealthBelowPctDamaged(66, damage))
                    || (_hopelessnessCount < 2 && me->HealthBelowPctDamaged(33, damage))
                    || (_hopelessnessCount < 3 && me->HealthBelowPctDamaged(10, damage)))
                {
                    if (_hopelessnessCount)
                        me->RemoveOwnedAura(sSpellMgr->GetSpellIdForDifficulty(HopelessnessHelper[_hopelessnessCount - 1], me));
                    DoCast(me, HopelessnessHelper[_hopelessnessCount]);
                    ++_hopelessnessCount;
                }
            }

            void JustDied(Unit* /*killer*/) override
            {
                Talk(SAY_DEATH);
                events.Reset();
            }

            void KilledUnit(Unit* who) override
            {
                if (who->GetTypeId() == TYPEID_PLAYER)
                    Talk(SAY_SLAY);
            }

            void UpdateAI(uint32 diff) override
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                switch (events.ExecuteEvent())
                {
                    case EVENT_QUIVERING_STRIKE:
                        DoCastVictim(SPELL_QUIVERING_STRIKE);
                        events.ScheduleEvent(EVENT_QUIVERING_STRIKE, 9000);
                        break;
                    case EVENT_IMPENDING_DESPAIR:
                        if (Unit* target = SelectTarget(SELECT_TARGET_MAXTHREAT, 0, 45.0f, true))
                        {
                            Talk(SAY_IMPENDING_DESPAIR);
                            DoCast(target, SPELL_IMPENDING_DESPAIR);
                        }
                        events.ScheduleEvent(EVENT_IMPENDING_DESPAIR, 15000);
                        break;
                    case EVENT_DEFILING_HORROR:
                            DoCastAOE(SPELL_DEFILING_HORROR);
                            events.ScheduleEvent(EVENT_DEFILING_HORROR, 90000);
                        break;
                    case EVENT_SHADOW_NOVA:
                            DoCastVictim(SPELL_SHADOW_NOVA, true);
                            Talk(SAY_SHADOW_NOVA);
                            events.ScheduleEvent(EVENT_SHADOW_NOVA, 120000);
                        break;
                    case EVENT_SUMMON_ZOMBIES:
                        Talk(SAY_PLAGUED_ZOMBIES);
                        for (uint32 i = 0; i < 7; ++i)
                            DoCast(me, SPELL_AWAKEN_PLAGUED_ZOMBIES, false);
                        events.ScheduleEvent(EVENT_SUMMON_ZOMBIES, urand(60000, 120000));
                        break;
                    default:
                        break;
                }

                DoMeleeAttackIfReady();
            }

        private:
            uint8 _hopelessnessCount;
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return new boss_falricAI(creature);
        }
};

void AddCustomBossFalricScripts()
{
    new CustomBossFalric();
}
