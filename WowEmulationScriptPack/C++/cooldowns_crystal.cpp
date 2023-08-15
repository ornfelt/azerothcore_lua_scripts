/////////////////////////////////////////////////////////////////////////////
//        ____        __  __  __     ___                                   //
//       / __ )____ _/ /_/ /_/ /__  /   |  ________  ____  ____ ______     //
//      / __  / __ `/ __/ __/ / _ \/ /| | / ___/ _ \/ __ \/ __ `/ ___/     //
//     / /_/ / /_/ / /_/ /_/ /  __/ ___ |/ /  /  __/ / / / /_/ (__  )      //
//    /_____/\__,_/\__/\__/_/\___/_/  |_/_/   \___/_/ /_/\__,_/____/       //
//         Developed by Natureknight for BattleArenas.no-ip.org            //
//                                                                         //
/////////////////////////////////////////////////////////////////////////////

#include "ScriptPCH.h"

class CooldownsCrystal : public GameObjectScript
{
    public:

        CooldownsCrystal() : GameObjectScript("CooldownsCrystal") { }

        bool OnGossipHello(Player* player, GameObject* go)
        {
			// Dont let players use crystal when in combat
			if (player->isInCombat())
			{
				player->GetSession()->SendAreaTriggerMessage("You are in combat.");
				return false;
			}
			
			// Dont let players use crystal when they're dead. 
			if (!player->isAlive())
			{
				player->GetSession()->SendAreaTriggerMessage("You are dead.");
				return false;
			}
			
			// And dont let players to use it in arena
			if (player->InArena())
			{
				player->GetSession()->SendAreaTriggerMessage("You can't use cooldowns crystal in arena or battleground.");
				return false;
			}

			// Buffs
			player->CastSpell(player, 48102, true); // Stamina
			player->CastSpell(player, 48073, true); // Divine Spirit
			player->CastSpell(player, 48169, true); // Shadow Protection
			player->CastSpell(player, 48161, true); // PW:F
			player->CastSpell(player, 20217, true); // Blessing of Kings
			player->CastSpell(player, 42995, true); // Arcane Intellect
			player->CastSpell(player, 48469, true); // Mark of the Wild

			// Cooldowns
			player->RemoveAllSpellCooldown();
	        player->RemoveAura(10278);             // Hand of Protection
	        player->RemoveAura(498);               // Divine Protection
	        player->RemoveAura(642);               // Divine Shield
            player->RemoveAura(41425);             // Remove Hypothermia Debuff
            player->RemoveAura(25771);             // Remove Forbearance Debuff
            player->RemoveAura(57724);             // Remove Sated Debuff
            player->RemoveAura(57723);             // Remove Exhaustion Debuff
            player->RemoveAura(66233);             // Remove Ardent Defender Debuff
	        player->RemoveAura(61987);             // Avenging Wrath Marker
            player->RemoveAura(11196);             // Remove Recently Bandaged Debuff
            player->SetHealth(player->GetMaxHealth());
            player->SetPower(POWER_MANA, player->GetMaxPower(POWER_MANA));
	        player->SetPower(POWER_RAGE, 0);       // Remove Rage and Runic Power
	        player->SetPower(POWER_RUNIC_POWER, 0);
		    player->GetSession()->SendAreaTriggerMessage("Your cooldowns has been reset.");
		    return false;
        }
};

void AddSC_CooldownsCrystal()
{
    new CooldownsCrystal();
}