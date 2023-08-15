// ---All credit goes to Eatos on Ac-web.org!!---

      


#include "StdAfx.h"
#include "Setup.h"

// --- L80etc band members ---
#define SAMURO                  23625
#define BERGRISST               23619
#define MAIKYL                  23624
#define SIGNICIOUS              23626
#define THUNDERSKINS    23623
#define TARGETGROUND    48001
#define TARGETAIR               48000
//#define UNDEAD                        48002
#define TRIGGER                 48005
#define STAGE                   186300

/*
 * EMOTE_ONESHOT_CUSTOMSPELL01 = 402,
 * EMOTE_ONESHOT_CUSTOMSPELL02 = 403,
 * EMOTE_ONESHOT_CUSTOMSPELL03 = 404,
 * EMOTE_ONESHOT_CUSTOMSPELL04 = 405,
 * EMOTE_ONESHOT_CUSTOMSPELL05 = 406,
 * EMOTE_ONESHOT_CUSTOMSPELL06 = 407,
 */


// Spells
#define SPELLFLARE                      42505
#define SPELLFIRE                       42501
#define SPOTLIGHT                       39312
#define SPELLEARTH                      42499
#define SPELLLLIGHTNING         42510
#define SPELLLLIGHTNING2        42507
#define SPELLSTORM                      42500
#define CONSECRATION            26573
#define SINGERSLIGHT            42510


class SamAI : public CreatureAIScript
{
    public:
    ADD_CREATURE_FACTORY_FUNCTION(SamAI);
    SamAI(Creature* pCreature) : CreatureAIScript(pCreature)
    {
        _unit->GetAIInterface()->SetAllowedToEnterCombat(false);
        _unit->GetAIInterface()->m_canMove = false;
        _unit->GetAIInterface()->disable_melee = true;
        _unit->SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
        _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLFLARE), true);
        timer = 0;
        RegisterAIUpdateEvent(1000);
    }
    
	void OnCombatStart(Unit* mTarget){ RegisterAIUpdateEvent(1000); }
    void OnCombatStop(Unit *mTarget)
    {
        _unit->GetAIInterface()->setCurrentAgent(AGENT_NULL);
        _unit->GetAIInterface()->SetAIState(STATE_IDLE);
        RemoveAIUpdateEvent();
    }
    void OnDied(Unit * mKiller){ RemoveAIUpdateEvent(); }
    void OnSpawn(){_unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLFLARE), true);}
    void OnDespawn(){ RemoveAIUpdateEvent(); }
    void AIUpdate()
    {
        switch (timer)
        {
            case 1:  _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLFLARE), true); break;
            case 2:
            {			
			    _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL01);
              	_unit->SetUInt32Value(UNIT_NPC_EMOTESTATE, 402);		  
			}break;
			case 24:
            {			
			_unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL05); 
			_unit->SetUInt32Value(UNIT_NPC_EMOTESTATE, 406);
			}break;
			case 52: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL06); break;
			case 54:  _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL01); break;
            case 56: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL06);
			        _unit->CastSpell(_unit, dbcSpell.LookupEntry(SINGERSLIGHT), true); break;
            case 58: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL01);break;
			case 60: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL06); break;
			case 61: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL01);break;
			case 62: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL03);break;
			case 74: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL06);break;
			case 123: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL03); break;
            case 137: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL06); break;
            case 142: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL01); break;
            case 180: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL01); break;
            case 229: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL02); break;
            case 239: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL06); break;
            case 259: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL06); break;
            case 279: _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLFLARE), true); break;
            case 280:_unit->Despawn(1000, 0); break;
        }
            timer++;
    }
    protected:
        uint32 timer;
};

class BerAI : public CreatureAIScript
{
    public:
        ADD_CREATURE_FACTORY_FUNCTION(BerAI);
        BerAI(Creature* pCreature) : CreatureAIScript(pCreature)
        {
            _unit->GetAIInterface()->SetAllowedToEnterCombat(false);
            _unit->GetAIInterface()->m_canMove = false;
            _unit->GetAIInterface()->disable_melee = true;
            _unit->SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLFLARE), true);
            timer = 0;
            RegisterAIUpdateEvent(1000);
        }
        void OnCombatStart(Unit* mTarget){ RegisterAIUpdateEvent(1000); }
        void OnCombatStop(Unit *mTarget)
        {
        _unit->GetAIInterface()->setCurrentAgent(AGENT_NULL);
        _unit->GetAIInterface()->SetAIState(STATE_IDLE);
        RemoveAIUpdateEvent();
        }
        void OnDied(Unit * mKiller){ RemoveAIUpdateEvent(); }
        void OnSpawn(){ _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLFLARE), true); }
        void OnDespawn(){ RemoveAIUpdateEvent(); }
        void AIUpdate()
		{
            switch (timer)
			{
                case 0: _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLFLARE), true); break;
                case 10:  _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL03); break;
                case 30:  _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL04); break;
                case 34:  _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL04); break;
                case 38:  _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL03); break;
                case 104: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL01); break;
                case 123: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL01); break;
                case 140: _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPOTLIGHT), true); break;
                case 145: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL03); break;
                case 168: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL01); break;
                case 229: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL02); break;
                case 230: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL06); break;
                case 279: _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLFLARE), true); break;
                case 280: _unit->Despawn(1000,0); break;
            }
                timer++;
        }
  protected:
        uint32 timer;
};

class SigAI : public CreatureAIScript
{
  public:
        ADD_CREATURE_FACTORY_FUNCTION(SigAI);
        SigAI(Creature* pCreature) : CreatureAIScript(pCreature)
		{
                        _unit->GetAIInterface()->SetAllowedToEnterCombat(false);
                        _unit->GetAIInterface()->m_canMove = false;
                        _unit->GetAIInterface()->disable_melee = true;
                        _unit->SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                        timer = 0;
                        RegisterAIUpdateEvent(1000);
        }
        void OnCombatStart(Unit* mTarget)
		{ 
		   RegisterAIUpdateEvent(1000); 
		}
        void OnCombatStop(Unit *mTarget)
		{
            _unit->GetAIInterface()->setCurrentAgent(AGENT_NULL);
            _unit->GetAIInterface()->SetAIState(STATE_IDLE);
            RemoveAIUpdateEvent();
        }
        void OnDied(Unit * mKiller){ RemoveAIUpdateEvent(); }
        void OnSpawn(){ _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLFLARE), true); }
        void OnDespawn(){ RemoveAIUpdateEvent(); }
        void AIUpdate()
		{
            switch (timer)
			{
                case 0: _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLFLARE), true); break;
                case 5: _unit->GetMapMgr()->GetInterface()->SpawnCreature(THUNDERSKINS,2421.17f, 2826.98f, 11.5896f, 0.421754f, true,false, 0, 0); break;
				case 10:  _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL03); break;
				case 11: _unit->GetMapMgr()->GetInterface()->SpawnCreature(SAMURO,2426.97f, 2833.52f, 7.95054f, 0.884609f, true, false, 0,0);
				_unit->GetMapMgr()->GetInterface()->SpawnCreature(MAIKYL,2423.19f, 2836.1f, 7.95041f, 0.165965f,true,false, 0, 0);
			    _unit->GetMapMgr()->GetInterface()->SpawnCreature(BERGRISST,2429.28f, 2829.23f, 7.95041f, 1.17834f,true, false, 0, 0); break;
				case 30:  _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL04); break;
                case 34:  _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL04); break;
                case 38:  _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL03); break;
                case 70:  _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL01); break;
                case 85:  _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL01); break;
                case 123: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL01); break;
                case 140: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL01); break;
                case 165: _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPOTLIGHT), true); break;
                case 166: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL02); break;
                case 168: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL03); break;
                case 180: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL03); break;
                case 193: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL04); break;
                case 229: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL06); break;
                case 259: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL04); break;
                case 279: _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLFLARE), true); break;
                case 280: _unit->Despawn(1000,0); break;
            }
                timer++;
        }
        protected:
           uint32 timer;
};

class MaiAI : public CreatureAIScript
{
public:
    ADD_CREATURE_FACTORY_FUNCTION(MaiAI);
    MaiAI(Creature* pCreature) : CreatureAIScript(pCreature)
	    {
            _unit->GetAIInterface()->SetAllowedToEnterCombat(false);
            _unit->GetAIInterface()->m_canMove = false;
            _unit->GetAIInterface()->disable_melee = true;
            _unit->SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            timer = 0;
            RegisterAIUpdateEvent(1000);
        }
        void OnCombatStart(Unit* mTarget){ RegisterAIUpdateEvent(1000); }
        void OnCombatStop(Unit *mTarget)
        {
        _unit->GetAIInterface()->setCurrentAgent(AGENT_NULL);
        _unit->GetAIInterface()->SetAIState(STATE_IDLE);
        RemoveAIUpdateEvent();
        }
        void OnDied(Unit * mKiller){ RemoveAIUpdateEvent(); }
        void OnSpawn(){ _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLFLARE), true); }
        void OnDespawn(){ RemoveAIUpdateEvent(); }
        void AIUpdate()
		{
            switch (timer)
			{
                case 0: _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLFLARE), true); break;
                case 2:  _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL01); break;
                case 20:  _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL03); break;
                case 45:  _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL04); break;
                case 70:  _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL03); break;
                case 85:  _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL01); break;
                case 95:  _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL01); break;
                case 102: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL01); break;
                case 115: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL01); break;
                case 123: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL02); break;
                case 165: _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPOTLIGHT), true); break;
                case 192: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL03); break;
                case 203: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL03); break;
                case 229: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL04); break;
                case 279: _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLFLARE), true); break;
                case 280: _unit->Despawn(1000,0); break;
            }
                timer++;
        }
  protected:
        uint32 timer;
};


class ThuAI : public CreatureAIScript
{
  public:
        ADD_CREATURE_FACTORY_FUNCTION(ThuAI);
        ThuAI(Creature* pCreature) : CreatureAIScript(pCreature)
		{
            _unit->GetAIInterface()->SetAllowedToEnterCombat(false);
            _unit->GetAIInterface()->m_canMove = false;
            _unit->GetAIInterface()->disable_melee = true;
            _unit->SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            timer = 0;
            RegisterAIUpdateEvent(1000);
        }
        void OnCombatStart(Unit* mTarget){ RegisterAIUpdateEvent(1000); }
        void OnCombatStop(Unit *mTarget)
        {
        _unit->GetAIInterface()->setCurrentAgent(AGENT_NULL);
        _unit->GetAIInterface()->SetAIState(STATE_IDLE);
        RemoveAIUpdateEvent();
        }
        void OnDied(Unit * mKiller){ RemoveAIUpdateEvent(); }
        void OnSpawn(){ _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLFLARE), true); }
        void OnDespawn()
		{
            RemoveAIUpdateEvent();
            _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLFLARE), true);
        }
        void AIUpdate()
		{
            switch (timer)
			{
                case 1: _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLFLARE), true); break;
				case 2:  _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL01);break;
                case 14:  _unit->SendChatMessage(CHAT_MSG_MONSTER_SAY, LANG_UNIVERSAL, "Are you ready to rock!?!");
                case 17:  _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL03); break;
                case 42:  _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL03); break;
                case 55:  _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL04); break;
                case 56:  _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL03); break;
                case 63:  _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL03); break;
                case 64:  _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL03); break;
                case 75:  _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL04); break;
                case 76:  _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL04); break;
                case 77:  _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL04); break;
                case 88:  _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL04); break;
                case 99:  _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL04); break;
                case 110: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL04); break;
                case 137: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL02); break;
                case 140: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL04); break;
                case 142: _unit->SendChatMessage(CHAT_MSG_MONSTER_SAY, LANG_UNIVERSAL, "Power of the Horde!");
                case 313: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL04); break;
                case 194: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL04); break;
                case 200:
				{
                _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL01);
                _unit->SetUInt32Value(UNIT_NPC_EMOTESTATE, 401);
                break;
                }
                case 279: _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLFLARE), true); break;
                case 293: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL02);break;
				case 316: _unit->Emote(EMOTE_ONESHOT_CUSTOMSPELL01);break;
				case 330: _unit->Despawn(1000,0); break;
            }
                timer++;
        }
  protected:
        uint32 timer;
};



class UndeadAI : public CreatureAIScript
{
  public:
        ADD_CREATURE_FACTORY_FUNCTION(UndeadAI);
        UndeadAI(Creature* pCreature) : CreatureAIScript(pCreature){
                        _unit->GetAIInterface()->SetAllowedToEnterCombat(false);
                        _unit->GetAIInterface()->m_canMove = false;
                        _unit->GetAIInterface()->disable_melee = true;
                        _unit->SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                        timer = 0;
                        RegisterAIUpdateEvent(1000);
        }
        void OnCombatStart(Unit* mTarget){ RegisterAIUpdateEvent(1000); }
        void OnCombatStop(Unit *mTarget)
        {
        _unit->GetAIInterface()->setCurrentAgent(AGENT_NULL);
        _unit->GetAIInterface()->SetAIState(STATE_IDLE);
        RemoveAIUpdateEvent();
        }
        void OnDied(Unit * mKiller){ RemoveAIUpdateEvent(); }
        void OnSpawn(){ _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLFLARE), true); }
        void OnDespawn(){
                        RemoveAIUpdateEvent();
                        _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLFLARE), true);
        }
        void AIUpdate()
		{
            switch (timer)
			{
                case 2:  _unit->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_DANCE); break;
                case 280: _unit->Emote(EMOTE_ONESHOT_APPLAUD); break;
                case 281: _unit->Despawn(1000,0); break;
            }
            timer++;
        }
        protected:
            uint32 timer;
};


class Undead2AI : public CreatureAIScript{
  public:
        ADD_CREATURE_FACTORY_FUNCTION(Undead2AI);
        Undead2AI(Creature* pCreature) : CreatureAIScript(pCreature){
                        _unit->GetAIInterface()->SetAllowedToEnterCombat(false);
                        _unit->GetAIInterface()->m_canMove = false;
                        _unit->GetAIInterface()->disable_melee = true;
                        _unit->SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                        timer = 0;
                        RegisterAIUpdateEvent(1000);
        }
        void OnCombatStart(Unit* mTarget){ RegisterAIUpdateEvent(1000); }
        void OnCombatStop(Unit *mTarget)
        {
        _unit->GetAIInterface()->setCurrentAgent(AGENT_NULL);
        _unit->GetAIInterface()->SetAIState(STATE_IDLE);
        RemoveAIUpdateEvent();
        }
        void OnDied(Unit * mKiller){ RemoveAIUpdateEvent(); }
        void OnSpawn(){ _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLFLARE), true); }
        void OnDespawn(){
                                _unit->SendChatMessage(CHAT_MSG_MONSTER_SAY, LANG_UNIVERSAL, "THAT WAS GREAT!");
                        RemoveAIUpdateEvent();
                        _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLFLARE), true);
        }
        void AIUpdate(){
                        switch (timer){
                          case 2:  _unit->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_DANCE); break;
                                                        case 280: _unit->Emote(EMOTE_ONESHOT_CHEER); break;
                          case 281: _unit->Despawn(1000,0); break;
                        }
                        timer++;
        }
        protected:
                        uint32 timer;
};


class Undead3AI : public CreatureAIScript{
  public:
        ADD_CREATURE_FACTORY_FUNCTION(Undead3AI);
        Undead3AI(Creature* pCreature) : CreatureAIScript(pCreature){
                        _unit->GetAIInterface()->SetAllowedToEnterCombat(false);
                        _unit->GetAIInterface()->m_canMove = false;
                        _unit->GetAIInterface()->disable_melee = true;
                        _unit->SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                        timer = 0;
                        RegisterAIUpdateEvent(1000);
        }
        void OnCombatStart(Unit* mTarget){ RegisterAIUpdateEvent(1000); }
        void OnCombatStop(Unit *mTarget){
                        _unit->GetAIInterface()->setCurrentAgent(AGENT_NULL);
                        _unit->GetAIInterface()->SetAIState(STATE_IDLE);
                        RemoveAIUpdateEvent();
        }
        void OnDied(Unit * mKiller){ RemoveAIUpdateEvent(); }
        void OnSpawn(){ _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLFLARE), true); }
        void AIUpdate(){
                        switch (timer){
                          case 2:  _unit->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_DANCE); break;
                                                        case 279: _unit->Emote(EMOTE_ONESHOT_CHEER); break;
                                                        case 280: _unit->Despawn(1000,0); break;
                        }
                        timer++;
        }
        protected:
                        uint32 timer;
};


class TriggerAI : public CreatureAIScript{
  public:
        ADD_CREATURE_FACTORY_FUNCTION(TriggerAI);
        TriggerAI(Creature* pCreature) : CreatureAIScript(pCreature){
                        _unit->GetAIInterface()->SetAllowedToEnterCombat(false);
                        _unit->GetAIInterface()->m_canMove = false;
                        _unit->GetAIInterface()->disable_melee = true;
                        _unit->SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                        timer = 0;
                        RegisterAIUpdateEvent(1000);
        }
        void OnCombatStart(Unit* mTarget){ RegisterAIUpdateEvent(1000); }
        void OnCombatStop(Unit *mTarget)
        {
        _unit->GetAIInterface()->setCurrentAgent(AGENT_NULL);
        _unit->GetAIInterface()->SetAIState(STATE_IDLE);
        RemoveAIUpdateEvent();
        }
        void OnDied(Unit * mKiller){ RemoveAIUpdateEvent(); }
        void OnSpawn(){ _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLFLARE), true); }
        void OnDespawn(){
                                _unit->SendChatMessage(CHAT_MSG_MONSTER_SAY, LANG_UNIVERSAL, "THAT WAS GREAT!");
                                RemoveAIUpdateEvent();
                                _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLFLARE), true);
        }
        void AIUpdate()
		{
            switch (timer)
			{
                case 1: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 8: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 15: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 21: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 28: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 35: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 41: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 48: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 55: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 62: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 69: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 76: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 81: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 89: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 96: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 101: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 108: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 115: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 121: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 128: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 135: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 141: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 148: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 155: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 162: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 169: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 176: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 181: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 189: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 196: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 201: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 208: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 215: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 221: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 228: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 235: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 241: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 248: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 255: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 262: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 269: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 276: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                case 281: 
                        _unit->GetAIInterface()->setCurrentAgent(AGENT_NULL);
                        _unit->GetAIInterface()->SetAIState(STATE_IDLE);
                        RemoveAIUpdateEvent();
                        _unit->Despawn(1000,0); break;
            }
                timer++;
        }
    protected:
        uint32 timer;
};

class Trigger2AI : public CreatureAIScript
{
  public:
        ADD_CREATURE_FACTORY_FUNCTION(Trigger2AI);
        Trigger2AI(Creature* pCreature) : CreatureAIScript(pCreature)
		{
                        _unit->GetAIInterface()->SetAllowedToEnterCombat(false);
                        _unit->GetAIInterface()->m_canMove = false;
                        _unit->GetAIInterface()->disable_melee = true;
                        _unit->SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                        timer = 0;
                        RegisterAIUpdateEvent(1000);
        }
        void OnCombatStart(Unit* mTarget){ RegisterAIUpdateEvent(1000); }
        void OnCombatStop(Unit *mTarget)
        {
        _unit->GetAIInterface()->setCurrentAgent(AGENT_NULL);
        _unit->GetAIInterface()->SetAIState(STATE_IDLE);
        RemoveAIUpdateEvent();
        }
        void OnDied(Unit * mKiller){ RemoveAIUpdateEvent(); }
        void OnSpawn(){ _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLFLARE), true); }
        void OnDespawn()
        {
                        _unit->SendChatMessage(CHAT_MSG_MONSTER_SAY, LANG_UNIVERSAL, "THAT WAS GREAT!");
                        RemoveAIUpdateEvent();
                        _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLFLARE), true);
        }
        void AIUpdate()
        {
                switch (timer)
                {
                        case 3: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 10: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 18: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 24: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 22: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 38: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 44: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 52: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 58: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 68: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 69: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 76: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 85: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 90: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 96: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 107: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 109: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 125: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 127: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 129: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 132: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 144: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 149: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 159: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 166: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 169: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 176: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 183: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 186: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 194: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 204: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 209: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 218: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 223: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 228: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 235: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 241: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 248: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 252: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 263: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 266: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 274: _unit->CastSpell(_unit, dbcSpell.LookupEntry(CONSECRATION), true); break;
                        case 281: _unit->Despawn(1000,0); break;
                }
                timer++;
        }
protected:
        uint32 timer;
};

class Effectsground : public CreatureAIScript
{
public:
        ADD_CREATURE_FACTORY_FUNCTION(Effectsground);
        Effectsground(Creature* pCreature) : CreatureAIScript(pCreature)
        {
                _unit->GetAIInterface()->SetAllowedToEnterCombat(false);
                _unit->GetAIInterface()->m_canMove = false;
                _unit->GetAIInterface()->disable_melee = true;
                _unit->SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                timer = 0;
                RegisterAIUpdateEvent(1000);
        }
        void OnCombatStart(Unit* mTarget)
        {
                RegisterAIUpdateEvent(1000);
        }
        void OnCombatStop(Unit *mTarget)
        {
        _unit->GetAIInterface()->setCurrentAgent(AGENT_NULL);
        _unit->GetAIInterface()->SetAIState(STATE_IDLE);
        RemoveAIUpdateEvent();
        }
        void OnDied(Unit* mKiller)
        {
                RemoveAIUpdateEvent();
        }
        void OnSpawn()
        {
                _unit->SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                timer = 0;
        }
        void OnDespawn()
        {
                RemoveAIUpdateEvent();
        }
        void AIUpdate()
        {
            Unit *plr = NULL;
            plr = _unit->GetAIInterface()->GetNextTarget();

			switch (timer)
                {
                        case 2:
                        {
                            _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLLLIGHTNING), true);
                            _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLLLIGHTNING2), true);
                        }break;
                        case 6:
                        {
                            _unit->CastSpell(plr, 50934, true);
                        }break;
                        case 8:
                        {
                            _unit->CastSpell(plr, dbcSpell.LookupEntry(SPELLFIRE), true);
							_unit->CastSpellAoF(2434.129f,2835.129f,4.686350f, dbcSpell.LookupEntry(SPELLFIRE), true);
                        }break;
                        case 72:
                        {
                            _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLLLIGHTNING), true);
                            _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLLLIGHTNING2), true);
                        }break;
                        case 76:
                        {
                            _unit->CastSpell(plr, dbcSpell.LookupEntry(SPELLEARTH), true);
                        }break;
                        case 78:
                        {
                            _unit->CastSpell(plr, dbcSpell.LookupEntry(SPELLFIRE), true);
							_unit->CastSpellAoF(2434.129f,2835.129f,4.686350f, dbcSpell.LookupEntry(SPELLFIRE), true);
                        }break;
                        case 125:
                        {
                            _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLLLIGHTNING), true);
                            _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLLLIGHTNING2), true);
                        }break;
                        case 128:
                        {
                            _unit->CastSpell(plr, dbcSpell.LookupEntry(SPELLEARTH), true);
                        }break;
                        case 132:
                        {
                                _unit->CastSpell(plr, dbcSpell.LookupEntry(SPELLFIRE), true);
								_unit->CastSpellAoF(2434.129f,2835.129f,4.686350f, dbcSpell.LookupEntry(SPELLFIRE), true);
                        }break;
                        case 232:
                        {
                            _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLLLIGHTNING), true);
                            _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLLLIGHTNING2), true);
                        }break;
                        case 236:
                        {
                                _unit->CastSpell(plr, dbcSpell.LookupEntry(SPELLEARTH), true);
                        }break;
                        case 238:
                        {
                            _unit->CastSpell(plr, dbcSpell.LookupEntry(SPELLFIRE), true);
							_unit->CastSpellAoF(2434.129f,2835.129f,4.686350f, dbcSpell.LookupEntry(SPELLFIRE), true);
                        }break;
                        case 245:
                        {
                            _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLLLIGHTNING), true);
                            _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLLLIGHTNING2), true);
                        }break;
                        case 249:
                        {
                            _unit->CastSpell(plr, dbcSpell.LookupEntry(SPELLEARTH), true);
                        }break;
                        case 251:
                        {
                            _unit->CastSpell(plr, dbcSpell.LookupEntry(SPELLFIRE), true);
							_unit->CastSpellAoF(2434.129f,2835.129f,4.686350f, dbcSpell.LookupEntry(SPELLFIRE), true);
                        }break;
                        case 279:
                        {
                            _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLFLARE), true);
							_unit->CastSpellAoF(2434.129f,2835.129f,4.686350f, dbcSpell.LookupEntry(SPELLFIRE), true);
                        }break;
                        case 280:
                        {
                            _unit->Despawn(1000,0);
                        }break;
                        timer++;
                }
        }
protected:
        uint32 timer;
};

class Effectsair : public CreatureAIScript{
public:
        ADD_CREATURE_FACTORY_FUNCTION(Effectsair);
        Effectsair(Creature* pCreature) : CreatureAIScript(pCreature)
        {
                _unit->GetAIInterface()->SetAllowedToEnterCombat(false);
                _unit->GetAIInterface()->m_canMove = false;
                _unit->GetAIInterface()->disable_melee = true;
                _unit->SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                timer = 0;
                RegisterAIUpdateEvent(1000);
        }
        void OnCombatStart(Unit* mTarget){ RegisterAIUpdateEvent(1000); }
        void OnCombatStop(Unit *mTarget)
        {
        _unit->GetAIInterface()->setCurrentAgent(AGENT_NULL);
        _unit->GetAIInterface()->SetAIState(STATE_IDLE);
        RemoveAIUpdateEvent();
        }
        void OnDied(Unit * mKiller){ RemoveAIUpdateEvent(); }
        void OnSpawn(){
                        timer = 0;
                        _unit->SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
        }
        void OnDespawn()
        {
                RemoveAIUpdateEvent();
        }
        void AIUpdate()
        {
                switch(timer)
                {
                        case 1:
                        {
                                _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLSTORM), true);
                        }break;
                        case 70:
                        {
                                _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLSTORM), true);
                        }break;
                        case 123:
                        {
                                _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLSTORM), true);
                        }break;
                        case 230:
                        {
                                _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLSTORM), true);
                        }break;
                        case 243:
                        {
                                _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLSTORM), true);
                        }break;
                        case 280:
                        {
                                _unit->Despawn(1000,0);
                        }break;
                }
                timer++;
        }
protected:
        uint32 timer;
};

class EffectGreenBeam : public CreatureAIScript
{
public:
       ADD_CREATURE_FACTORY_FUNCTION(EffectGreenBeam);
        EffectGreenBeam (Creature * pCreature) : CreatureAIScript(pCreature)
        {
            _unit->GetAIInterface()->SetAllowedToEnterCombat(false);
            _unit->GetAIInterface()->m_canMove = false;
            _unit->GetAIInterface()->disable_melee = true;
            _unit->SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            timer = 0;
            RegisterAIUpdateEvent(1000);
        }
        void OnCombatStart(Unit* mTarget){ RegisterAIUpdateEvent(1000); }
        void OnCombatStop(Unit *mTarget)
        {
        _unit->GetAIInterface()->setCurrentAgent(AGENT_NULL);
        _unit->GetAIInterface()->SetAIState(STATE_IDLE);
       RemoveAIUpdateEvent();
        }
        void OnDied(Unit * mKiller){ RemoveAIUpdateEvent(); }
        void OnSpawn()
		{
            timer = 0;
            _unit->SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
        }
        void OnDespawn()
        {
                RemoveAIUpdateEvent();
        }
        void AIUpdate()
        {
            Creature* LeftBunny = _unit->GetMapMgr()->GetInterface()->GetCreatureNearestCoords( 2433.21f, 2832.98f, 4.68643,TARGETAIR);
			Creature* RightBunny = _unit->GetMapMgr()->GetInterface()->GetCreatureNearestCoords(2429.86f, 2838.1f, 4.68665f, TARGETAIR);
			switch(timer)
            {
                case 1:
                {
                    _unit->CastSpell(LeftBunny, 39979, true);
					_unit->CastSpell(RightBunny, 39979, true);
                }break;
                case 70:
                {
                    _unit->CastSpell(LeftBunny, 39979, true);
					_unit->CastSpell(RightBunny, 39979, true);
                }break;
                case 123:
                {
                    _unit->CastSpell(LeftBunny, 39979, true);
					_unit->CastSpell(RightBunny, 39979, true);
                }break;
                case 230:
                {
                    _unit->CastSpell(LeftBunny, 39979, true);
					_unit->CastSpell(RightBunny, 39979, true);
                }break;
                case 243:
                {
                    _unit->CastSpell(LeftBunny, 39979, true);
					_unit->CastSpell(RightBunny, 39979, true);
                }break;
                case 280:
                    {
                        _unit->Despawn(1000,0);
                    }break;
                }
                timer++;
        }
protected:
        uint32 timer;
};

class ConcertGuards : public CreatureAIScript
{
public:
       ADD_CREATURE_FACTORY_FUNCTION(ConcertGuards);
        ConcertGuards (Creature * pCreature) : CreatureAIScript(pCreature)
        {
            _unit->GetAIInterface()->SetAllowedToEnterCombat(false);
            _unit->GetAIInterface()->m_canMove = false;
            _unit->GetAIInterface()->disable_melee = true;
            _unit->SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            timer = 0;
            RegisterAIUpdateEvent(1000);
        }
        void OnCombatStart(Unit* mTarget){ RegisterAIUpdateEvent(1000); }
        void OnCombatStop(Unit *mTarget)
        {
        _unit->GetAIInterface()->setCurrentAgent(AGENT_NULL);
        _unit->GetAIInterface()->SetAIState(STATE_IDLE);
       RemoveAIUpdateEvent();
        }
        void OnDied(Unit * mKiller){ RemoveAIUpdateEvent(); }
        void OnSpawn()
		{
            timer = 0;
            _unit->SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
        }
        void OnDespawn()
        {
            RemoveAIUpdateEvent();
        }
        void AIUpdate()
        {
            Creature* EarthEffect = _unit->GetMapMgr()->GetInterface()->GetCreatureNearestCoords( 2437.88f, 2836.89f, 4.68622f,15781);
			switch(timer)
            {
                case 6:
                {
                    _unit->CastSpell(EarthEffect, 50934, true);
                }break;
				case 8:
                {
                    _unit->CastSpell(EarthEffect, dbcSpell.LookupEntry(SPELLFIRE), true);
                }break;
				case 30:
				{
				  _unit->SendChatMessage(CHAT_MSG_MONSTER_SAY, LANG_UNIVERSAL, "You guys rock!");
				}break;
				case 76:
                {
                    _unit->CastSpell(EarthEffect, dbcSpell.LookupEntry(SPELLEARTH), true);
                }break;
				case 78:
                {
                    _unit->CastSpell(EarthEffect, dbcSpell.LookupEntry(SPELLFIRE), true);
                }break;
				case 128:
                {
                    _unit->CastSpell(EarthEffect, dbcSpell.LookupEntry(SPELLEARTH), true);
                }break;
				case 132:
                {
                    _unit->CastSpell(EarthEffect, dbcSpell.LookupEntry(SPELLFIRE), true);
                }break;
				case 236:
                {
                    _unit->CastSpell(EarthEffect, dbcSpell.LookupEntry(SPELLEARTH), true);
                }break;
				case 238:
                {
                    _unit->CastSpell(EarthEffect, dbcSpell.LookupEntry(SPELLFIRE), true);
                }break;
				case 249:
                {
                    _unit->CastSpell(EarthEffect, dbcSpell.LookupEntry(SPELLEARTH), true);
                }break;
				case 251:
                {
                    _unit->CastSpell(EarthEffect, dbcSpell.LookupEntry(SPELLFIRE), true);
                }break;
				case 274:
				{
				  _unit->CastSpell(_unit,11544, true);
				}break;
				case 280:
                {
                    _unit->Despawn(1000,0);
                }break;
            }
                timer++;
        }
protected:
        uint32 timer;
};


class DanceFreak : public CreatureAIScript
{
public:
       ADD_CREATURE_FACTORY_FUNCTION(DanceFreak);
        DanceFreak (Creature * pCreature) : CreatureAIScript(pCreature)
        {
            _unit->GetAIInterface()->SetAllowedToEnterCombat(false);
            _unit->GetAIInterface()->m_canMove = false;
            _unit->GetAIInterface()->disable_melee = true;
            _unit->SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            timer = 0;
            RegisterAIUpdateEvent(1000);
        }
        void OnCombatStart(Unit* mTarget){ RegisterAIUpdateEvent(1000); }
        void OnCombatStop(Unit *mTarget)
        {
        _unit->GetAIInterface()->setCurrentAgent(AGENT_NULL);
        _unit->GetAIInterface()->SetAIState(STATE_IDLE);
       RemoveAIUpdateEvent();
        }
        void OnDied(Unit * mKiller){ RemoveAIUpdateEvent(); }
        void OnSpawn()
		{
            timer = 0;
            _unit->SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
        }
        void OnDespawn()
        {
            RemoveAIUpdateEvent();
        }
        void AIUpdate()
        {
            switch(timer)
            {
                case 1:
				{
				  _unit->Emote(EMOTE_ONESHOT_DANCE);
				}break;
				case 274:
				{
				  _unit->CastSpell(_unit, 30161, true);
				}break;
				case 280:
                {
                    _unit->Despawn(1000,0);
                }break;
            }
                timer++;
        }
protected:
    uint32 timer;
};

class CrowdOne : public CreatureAIScript
{
public:
       ADD_CREATURE_FACTORY_FUNCTION(CrowdOne);
        CrowdOne(Creature * pCreature) : CreatureAIScript(pCreature)
        {
            _unit->GetAIInterface()->SetAllowedToEnterCombat(false);
            _unit->GetAIInterface()->m_canMove = false;
            _unit->GetAIInterface()->disable_melee = true;
            _unit->SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            timer = 0;
            RegisterAIUpdateEvent(1000);
        }
        void OnCombatStart(Unit* mTarget){ RegisterAIUpdateEvent(1000); }
        void OnCombatStop(Unit *mTarget)
        {
        _unit->GetAIInterface()->setCurrentAgent(AGENT_NULL);
        _unit->GetAIInterface()->SetAIState(STATE_IDLE);
       RemoveAIUpdateEvent();
        }
        void OnDied(Unit * mKiller){ RemoveAIUpdateEvent(); }
        void OnSpawn()
		{
            timer = 0;
            _unit->SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
        }
        void OnDespawn()
        {
            RemoveAIUpdateEvent();
        }
        void AIUpdate()
        {
            switch(timer)
            {
                case 1:
				{
				  _unit->Emote(EMOTE_ONESHOT_DANCE);
				}break;
				case 274:
				{
				 _unit->CastSpell(_unit, 11542, true);
				}break;
				case 280:
                {
                    _unit->Despawn(1000,0);
                }break;
            }
                timer++;
        }
protected:
    uint32 timer;
};

class CrowdTwo : public CreatureAIScript
{
public:
       ADD_CREATURE_FACTORY_FUNCTION(CrowdTwo);
        CrowdTwo(Creature * pCreature) : CreatureAIScript(pCreature)
        {
            _unit->GetAIInterface()->SetAllowedToEnterCombat(false);
            _unit->GetAIInterface()->m_canMove = false;
            _unit->GetAIInterface()->disable_melee = true;
            _unit->SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            timer = 0;
            RegisterAIUpdateEvent(1000);
        }
        void OnCombatStart(Unit* mTarget){ RegisterAIUpdateEvent(1000); }
        void OnCombatStop(Unit *mTarget)
        {
        _unit->GetAIInterface()->setCurrentAgent(AGENT_NULL);
        _unit->GetAIInterface()->SetAIState(STATE_IDLE);
       RemoveAIUpdateEvent();
        }
        void OnDied(Unit * mKiller){ RemoveAIUpdateEvent(); }
        void OnSpawn()
		{
            timer = 0;
            _unit->SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
        }
        void OnDespawn()
        {
            RemoveAIUpdateEvent();
        }
        void AIUpdate()
        {
            switch(timer)
            {
                case 1:
				{
				  _unit->Emote(EMOTE_ONESHOT_DANCE);
				}break;
				case 274:
				{
				  _unit->CastSpell(_unit, 11543, true);
				}break;
				case 280:
                {
                    _unit->Despawn(1000,0);
                }break;
            }
                timer++;
        }
protected:
    uint32 timer;
};

class ShamanDude : public CreatureAIScript
{
public:
        ADD_CREATURE_FACTORY_FUNCTION(ShamanDude);
        ShamanDude(Creature * pCreature) : CreatureAIScript(pCreature)
        {
            _unit->GetAIInterface()->SetAllowedToEnterCombat(false);
            _unit->GetAIInterface()->m_canMove = false;
            _unit->GetAIInterface()->disable_melee = true;
            _unit->SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
			_unit->Emote(EMOTE_STATE_SPELL_CHANNEL_OMNI);
            timer = 0;
            RegisterAIUpdateEvent(1000);
        }
        void OnCombatStart(Unit* mTarget){ RegisterAIUpdateEvent(1000); }
        void OnCombatStop(Unit *mTarget)
        {
        _unit->GetAIInterface()->setCurrentAgent(AGENT_NULL);
        _unit->GetAIInterface()->SetAIState(STATE_IDLE);
       RemoveAIUpdateEvent();
        }
        void OnDied(Unit * mKiller){ RemoveAIUpdateEvent(); }
        void OnSpawn()
		{
            timer = 0;
            _unit->SetUInt64Value(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
			_unit->Emote(EMOTE_STATE_SPELL_CHANNEL_OMNI);
        }
        void OnDespawn()
        {
            RemoveAIUpdateEvent();
        }
        void AIUpdate()
        {
            switch(timer)
            {
                case 1:
				{
				  _unit->Emote(EMOTE_STATE_SPELL_CHANNEL_OMNI);
				  _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLLLIGHTNING), true);
                  _unit->CastSpell(_unit, dbcSpell.LookupEntry(SPELLLLIGHTNING2), true);
				  _unit->SetUInt32Value(UNIT_NPC_EMOTESTATE, 468);
				}break;
				case 3:
				{
				  _unit->PlaySoundToSet(11803);
				  _unit->Emote(EMOTE_STATE_SPELL_CHANNEL_OMNI);
				  _unit->SetUInt32Value(UNIT_NPC_EMOTESTATE, 468);
				}break;
				case 7:
				{
				  _unit->GetMapMgr()->GetInterface()->SpawnCreature(SIGNICIOUS,2423.42f, 2833.4f, 7.95041f, 0.809206f, true, false, 0,0);
				  _unit->Emote(EMOTE_STATE_SPELL_CHANNEL_OMNI);
				  _unit->SetUInt32Value(UNIT_NPC_EMOTESTATE, 468);
				  _unit->Despawn(1000,0);
				}break;
            }
                timer++;
        }
protected:
    uint32 timer;
};

class ConcertEvent : public GossipScript
{
   public:
    void GossipHello(Object* pObject, Player * plr, bool AutoSend)
    {
        GossipMenu *Menu;
		objmgr.CreateGossipMenuForPlayer(&Menu, pObject->GetGUID(), 40002, plr);
		Menu->AddItem( 0, "Start The Concert", 1 );
		Menu->AddItem( 0, "Nevermind", 2);
		Menu->SendTo(plr);
		
        if(AutoSend)
            Menu->SendTo(plr);
    }
	  
	void GossipSelectOption(Object* pObject, Player * plr, uint32 Id, uint32 IntId, const char * Code)
    {
       Creature * pCreature = (pObject->GetTypeId()==TYPEID_UNIT)?((Creature*)pObject):NULL;
       if(pCreature==NULL)
        return;
		
        switch(IntId)
	    {
            case 1:
            {
               pCreature->GetMapMgr()->GetInterface()->SpawnGameObject(STAGE,2423.39f, 2829.0f, 4.68666f, 0.772046f, true,0,0); //Stage
			   /*pCreature->GetMapMgr()->GetInterface()->SpawnCreature(SAMURO,2426.97f, 2833.52f, 7.95054f, 0.884609f, true, false, 0,0);
               pCreature->GetMapMgr()->GetInterface()->SpawnCreature(THUNDERSKINS,2421.17f, 2826.98f, 11.5896f, 0.421754f, true,false, 0, 0);
			   pCreature->GetMapMgr()->GetInterface()->SpawnCreature(MAIKYL,2423.19f, 2836.1f, 7.95041f, 0.165965f,true,false, 0, 0);
			   pCreature->GetMapMgr()->GetInterface()->SpawnCreature(SIGNICIOUS,2423.42f, 2833.4f, 7.95041f, 0.809206f, true, false, 0,0);
			   pCreature->GetMapMgr()->GetInterface()->SpawnCreature(BERGRISST,2429.28f, 2829.23f, 7.95041f, 1.17834f,true, false, 0, 0);*/

			   pCreature->GetMapMgr()->GetInterface()->SpawnCreature(TRIGGER,2431.01f, 2834.65f, 4.68643f, 0.818636f,true,false, 0, 0);
			   pCreature->GetMapMgr()->GetInterface()->SpawnCreature(TARGETAIR,2433.21f, 2832.98f, 4.68643f, 1.09038f,true,false, 0,0);
			   pCreature->GetMapMgr()->GetInterface()->SpawnCreature(TARGETAIR,2429.86f, 2838.1f, 4.68665f, 0.788363f, true, false,0,0);
			   pCreature->GetMapMgr()->GetInterface()->SpawnCreature(TARGETGROUND,1415.26f, -3186.46f, 162.664f, 5.22753f,true,false,0,0);
			   
			   pCreature->GetMapMgr()->GetInterface()->SpawnCreature(17936,2428.07f, 2833.6f, 7.95051f, 0.830115f,true,false,0,0); //Shaman Dude :D
			   pCreature->GetMapMgr()->GetInterface()->SpawnCreature(23830,2430.17f, 2835.52f, 4.68615f, 0.395815f, true, false,0,0);
			   pCreature->GetMapMgr()->GetInterface()->SpawnCreature(23721,2427.02f, 2840.26f, 4.68622f, 0.887472f, true, false,0,0);
			   pCreature->GetMapMgr()->GetInterface()->SpawnCreature(23721,2435.95f, 2831.89f, 4.68622f, 0.716255f, true, false,0,0);
			   
			   pCreature->GetMapMgr()->GetInterface()->SpawnCreature(15781, 2435.8f, 2837.16f, 4.68622f, 3.88062f, true, false, 0,0); //Crowd 1
			   pCreature->GetMapMgr()->GetInterface()->SpawnCreature(15781, 2437.88f, 2836.89f, 4.68622f, 3.85785f, true, false, 0,0); //Crowd 2
			   pCreature->GetMapMgr()->GetInterface()->SpawnCreature(15781, 2435.44f, 2834.77f, 4.68622f, 3.85785f, true, false, 0,0); //Crowd 3
			   
			   pCreature->GetMapMgr()->GetInterface()->SpawnCreature(22998, 2433.81f, 2840.19f, 4.68622f, 4.09189f, true, false, 0,0); //Crowd 4
			   pCreature->GetMapMgr()->GetInterface()->SpawnCreature(22998, 2431.15f, 2840.37f, 4.68622f, 4.09347f, true, false, 0,0); //Crowd 5
			   pCreature->GetMapMgr()->GetInterface()->SpawnCreature(22998, 2433.06f, 2843.06f, 4.68622f, 4.09347f, true, false, 0,0); //Crowd 6
			   
			   pCreature->GetMapMgr()->GetInterface()->SpawnCreature(15784, 2435.88f, 2839.38f, 4.68622f, 3.82722f, true, false, 0,0); //Crowd 7
			   pCreature->GetMapMgr()->GetInterface()->SpawnCreature(15784, 2432.73f, 2838.08f, 4.68622f, 3.87748f, true, false, 0,0); //Crowd 8
			   pCreature->GetMapMgr()->GetInterface()->SpawnCreature(15784, 2435.16f, 2841.95f, 4.68622f, 4.00079f, true, false, 0,0); //Crowd 9
			   
			   pCreature->CastSpell(pCreature,59084,true);
			   pCreature->Despawn(1000, 300500);
			   plr->Gossip_Complete();

            }break;
		    case 2:
		    {
                 plr->Gossip_Complete();
		
		    }break;

	    }
    }
    void Destroy()
    {
        delete this;
    }
};

void SetupL80etc(ScriptMgr * mgr)
{
    GossipScript * con = (GossipScript*) new ConcertEvent();
	mgr->register_gossip_script(23988, con);
	
	mgr->register_creature_script(SAMURO, &SamAI::Create);
    mgr->register_creature_script(BERGRISST, &BerAI::Create);
    mgr->register_creature_script(MAIKYL, &MaiAI::Create);
    mgr->register_creature_script(SIGNICIOUS, &SigAI::Create);
    mgr->register_creature_script(THUNDERSKINS, &ThuAI::Create);
    mgr->register_creature_script(TARGETGROUND, Effectsground::Create);
    mgr->register_creature_script(TARGETAIR, Effectsair::Create);
    mgr->register_creature_script(UNDEAD, &UndeadAI::Create);
    mgr->register_creature_script(TRIGGER, &TriggerAI::Create);
	mgr->register_creature_script(23830, &EffectGreenBeam::Create);
	mgr->register_creature_script(23721, &ConcertGuards::Create);
	mgr->register_creature_script(15784, &CrowdOne::Create);
	mgr->register_creature_script(22998, &CrowdTwo::Create);
	mgr->register_creature_script(15781, &DanceFreak::Create);
	mgr->register_creature_script(17936, &ShamanDude::Create);
}
