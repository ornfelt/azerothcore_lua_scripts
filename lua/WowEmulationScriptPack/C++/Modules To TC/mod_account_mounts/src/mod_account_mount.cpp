#include "Config.h"
#include "Chat.h"
#include "Player.h"
#include "DatabaseEnv.h"
#include "DBCStores.h"

class AccountMounts : public PlayerScript
{
    static const bool limitrace = false; // This set to true will only learn mounts from chars on the same team, do what you want.
public:
    AccountMounts() : PlayerScript("AccountMounts") { }

    void OnLogin(Player* pPlayer, bool firstLogin)
    {
        if (sConfigMgr->GetBoolDefault("Account.Mounts.Enable", true))
        {
            if (firstLogin) {
                if (sConfigMgr->GetBoolDefault("Account.Mounts.Announce", true))
                {
                    ChatHandler(pPlayer->GetSession()).SendSysMessage("This server is running the |cff4CFF00AccountMounts |rmodule.");
                }
            }
            std::vector<uint32> Guids;
            uint32 playerGUID = pPlayer->GetGUID();
            QueryResult result1 = CharacterDatabase.PQuery("SELECT guid, race FROM characters WHERE account = %u", playerGUID);
            if (!result1)
                return;

            do
            {
                Field* fields = result1->Fetch();
    
                //uint32 guid = fields[0].GetUInt32(); //unused variable
                uint32 race = fields[1].GetUInt8();

                if ((Player::TeamForRace(race) == Player::TeamForRace(pPlayer->GetRace())) || !limitrace)
                    Guids.push_back(result1->Fetch()[0].GetUInt32());

            } while (result1->NextRow());

            std::vector<uint32> Spells;

            for (auto& i : Guids)
            {
                QueryResult result2 = CharacterDatabase.PQuery("SELECT spell FROM character_spell WHERE guid = %u", i);
                if (!result2)
                    continue;

                do
                {
                    Spells.push_back(result2->Fetch()[0].GetUInt32());
                } while (result2->NextRow());
            }

            for (auto& i : Spells)
            {
                auto sSpell = sSpellStore.LookupEntry(i);
                if (sSpell->Effect[0] == SPELL_EFFECT_APPLY_AURA && sSpell->EffectAura[0] == SPELL_AURA_MOUNTED)
					pPlayer->LearnSpell(sSpell->ID, true);
            }
        }
	}
};

void AddAccountMountsScripts()
{
    new AccountMounts;
}
