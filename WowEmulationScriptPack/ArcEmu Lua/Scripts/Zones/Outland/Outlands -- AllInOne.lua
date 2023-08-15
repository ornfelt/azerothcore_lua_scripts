--[[ Outlands -- AllInOne.lua

This script was written and is protected
by the GPL v2. This script was released
by The BLUA Scripting Project.
Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- Blua, December 01, 2008. ]]
--[[ Only update this script IF you have finished a peice of Outlands ]]--

function Abjurist_OnEnterCombat(pUnit, Event)
    pUnit:RegisterEvent("Abjurist_Armor", 10000, 0)
    pUnit:RegisterEvent("Abjurist_Missiles", 1000,0)
end
    
function Abjurist_Armor(pUnit, Event)
    pUnit:CastSpell(12544)
end

function Abjurist_Missiles(pUnit, Event)
    pUnit:FullCastSpellOnTarget(34447,pUnit:GetClosestPlayer())
end

function Abjurist_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Abjurist_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (19546, 1, "Abjurist_OnEnterCombat")
RegisterUnitEvent (19546, 2, "Abjurist_OnLeaveCombat")
RegisterUnitEvent (19546, 4, "Abjurist_OnDied")

function Ambassador_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Ambassador_Fireball", 3000, 0)
end

function Ambassador_Fireball(pUnit,Event)
    pUnit:FullCastSpellOnTarget(9053,pUnit:GetClosestPlayer())
end

function Ambassador_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Ambassador_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20163, 1, "Ambassador_OnEnterCombat")
RegisterUnitEvent (20163, 2, "Ambassador_OnLeaveCombat")
RegisterUnitEvent (20163, 4, "Ambassador_OnDied")

function Honor_OnEnterCombat(pUnit, Event)
    pUnit:RegisterEvent("Honor_Cleave",1000,0)
end

function Honor_Cleave(pUnit, Event)
    pUnit:FullCastSpellOnTarget(15284,pUnit:GetClosestPlayer())
end

function Honor_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Honor_OnDied(pUnit,Event)
    pUnit:RemoveEvents()
end

RegisterUnitEvent (20199, 1, "Honor_OnEnterCombat")
RegisterUnitEvent (20199, 2, "Honor_OnLeaveCombat")
RegisterUnitEvent (20199, 4, "Honor_OnDied")

function Anchorite_OnEnterCombat(pUnit, Event)
    pUnit:RegisterEvent("Anchorite_Heal", 3500, 0)
    pUnit:RegisterEvent("Anchorite_Fire", 5000, 0)
    pUnit:RegisterEvent("Anchorite_Smite", 2500, 0)
end

function Anchorite_Heal(pUnit, Event)
    pUnit:CastSpell(35096)
end

function Anchorite_Fire(pUnit, Event)
    pUnit:FullCastSpellOnTarget(17141, pUnit:GetClosestPlayer())
end

function Anchorite_Smite(pUnit, Event)
    pUnit:FullCastSpellOnTarget(9734, pUnit:GetClosestPlayer())
end

function Anchorite_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Anchorite_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (19467, 1, "Anchorite_OnEnterCombat")
RegisterUnitEvent (19467, 2, "Anchorite_OnLeaveCombat")
RegisterUnitEvent (19467, 4, "Anchorite_OnDied")

function Angered_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Angered_Bolt", 1000, 0)
    pUnit:RegisterEvent("Angered_Blast", 6000, 0)
end

function Angered_Bolt(pUnit,Event)
    pUnit:FullCastSpellOnTarget(39337, pUnit:GetClosestPlayer())
end

function Angered_Blast(pUnit,Event)
    pUnit:FullCastSpellOnTarget(38205, pUnit:GetClosestPlayer())
end

function Angered_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Angered_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (17870, 1, "Angered_OnEnterCombat")
RegisterUnitEvent (17870, 2, "Angered_OnLeaveCombat")
RegisterUnitEvent (17870, 4, "Angered_OnDied")

function Ardonis_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Ardonis_Shadows",10000,0)
    pUnit:RegisterEvent("Ardonis_Desecration",1000,0)
end

function Ardonis_Shadows(pUnit,Event)
    pUnit:CastSpell(36472)
end

function Ardonis_Desecration(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36473, pUnit:GetClosestPlayer())
end

function Ardonis_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Ardonis_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (19830, 1, "Ardonis_OnEnterCombat")
RegisterUnitEvent (19830, 2, "Ardonis_OnLeaveCombat")
RegisterUnitEvent (19830, 4, "Ardonis_OnDied")

function Arconus_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Arconus_Shadows",10000,0)
    pUnit:RegisterEvent("Arconus_Desecration",1000,0)
end

function Arconus_Shadows(pUnit,Event)
    pUnit:CastSpell(36472)
end

function Arconus_Desecration(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36473, pUnit:GetClosestPlayer())
end

function Arconus_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Arconus_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20554, 1, "Arconus_OnEnterCombat")
RegisterUnitEvent (20554, 2, "Arconus_OnLeaveCombat")
RegisterUnitEvent (20554, 4, "Arconus_OnDied")

function Ark_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Ark_Explosion",1500,0)
end

function Ark_Explosion(pUnit,Event)
    pUnit:FullCastSpellOnTarget(11975, pUnit:GetClosestPlayer())
end

function Ark_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Ark_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (19494, 1, "Ark_OnEnterCombat")
RegisterUnitEvent (19494, 2, "Ark_OnLeaveCombat")
RegisterUnitEvent (19494, 4, "Ark_OnDied")

function Seeker_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Seeker_Burn",3000,0)
    pUnit:RegisterEvent("Seeker_Lock",1000,0)
end

function Seeker_Burn(pUnit,Event)
    pUnit:FullCastSpellOnTarget(11981, pUnit:GetClosestPlayer())
end

function Seeker_Lock(pUnit,Event)
    pUnit:FullCastSpellOnTarget(30849, pUnit:GetClosestPlayer())
end

function Ark_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Ark_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (19852, 1, "Seeker_OnEnterCombat")
RegisterUnitEvent (19852, 2, "Seeker_OnLeaveCombat")
RegisterUnitEvent (19852, 4, "Seeker_OnDied")

function Avatar_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Avatar_Rain",1000,0)
    pUnit:RegisterEvent("Avatar_Bolt",3000,0)
end

function Avatar_Rain(pUnit,Event)
    pUnit:FullCastSpellOnTarget(34017, pUnit:GetClosestPlayer())
end

function Avatar_Bolt(pUnit,Event)
    pUnit:FullCastSpellOnTarget(12471, pUnit:GetClosestPlayer())
end

function Avatar_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Avatar_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (21925, 1, "Avatar_OnEnterCombat")
RegisterUnitEvent (21925, 2, "Avatar_OnLeaveCombat")
RegisterUnitEvent (21925, 4, "Avatar_OnDied")

function Azure_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Azure_Screech", 1000,0)
end

function Azure_Screech(pUnit,Event)
    pUnit:FullCastSpellOnTarget(31273, pUnit:GetClosestPlayer())
end

function Azure_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Azure_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (21005, 1, "Azure_OnEnterCombat")
RegisterUnitEvent (21005, 2, "Azure_OnLeaveCombat")
RegisterUnitEvent (21005, 4, "Azure_OnDied")

function Crocolisk_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Crocolisk_Rip",1000,0)
end

function Crocolisk_Rip(pUnit,Event)
    pUnit:FullCastSpellOnTarget(3604, pUnit:GetClosestPlayer())
end

function Crocolisk_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Crocolisk_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20773, 1, "Crocolisk_OnEnterCombat")
RegisterUnitEvent (20773, 2, "Crocolisk_OnLeaveCombat")
RegisterUnitEvent (20773, 4, "Crocolisk_OnDied")

function Mage_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Mage_Blast", 6000,0)
    pUnit:RegisterEvent("Mage_Flames",2500,0)
end

function Mage_Rip(pUnit,Event)
    pUnit:FullCastSpellOnTarget(17273, pUnit:GetClosestPlayer())
end

function Mage_Flames(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36104, pUnit:GetClosestPlayer())
end
    
function Mage_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Mage_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (19543, 1, "Mage_OnEnterCombat")
RegisterUnitEvent (19543, 2, "Mage_OnLeaveCombat")
RegisterUnitEvent (19543, 4, "Mage_OnDied")

function Bot_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Bot_Suicide",4000,1)
end

function Bot_Suicide(pUnit,Event)
	pUnit:FullCastSpellOnTarget(7,pUnit:GetClosestPlayer())
	pUnit:CastSpell(7)
end

function Bot_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Bot_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (19692, 1, "Bot_OnEnterCombat")
RegisterUnitEvent (19692, 2, "Bot_OnLeaveCombat")
RegisterUnitEvent (19692, 4, "Bot_OnDied")

function Captain_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Captain_Summon",1000,1)
    pUnit:RegisterEvent("Captain_Whirl",1000,0)
    pUnit:RegisterEvent("Captain_Wind",2000,0)
end

function Captain_Summon(pUnit,Event)
    pUnit:CastSpell(35882)
end

function Captain_Whirl(pUnit,Event)
    pUnit:FullCastSpellOnTarget(15576,pUnit:GetClosestPlayer())
end

function Capatain_Wind(pUnit,Event)
    pUnit:FullCastSpellOnTarget(17207,pUnit:GetClosestPlayer())
end

function Capatain_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Capatain_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (19635, 1, "Capatain_OnEnterCombat")
RegisterUnitEvent (19635, 2, "Capatain_OnLeaveCombat")
RegisterUnitEvent (19635, 4, "Capatain_OnDied")

function Captain_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Captain_Cleave",1000,0)
end

function Captain_Cleave(pUnit,Event)
    pUnit:FullCastSpellOnTarget(15576,pUnit:GetClosestPlayer())
end

function Capatain_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Capatain_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20985, 1, "Capatain_OnEnterCombat")
RegisterUnitEvent (20985, 2, "Capatain_OnLeaveCombat")
RegisterUnitEvent (20985, 4, "Capatain_OnDied")

function Captain_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Captain_Cleave",1000,0)
    pUnit:RegisterEvent("Captain_Toughen",1000,0)
end

function Captain_Cleave(pUnit,Event)
    pUnit:FullCastSpellOnTarget(15576,pUnit:GetClosestPlayer())
end

function Captain_Thougen(pUnit,Event)
    pUnit:CastSpell(33962)
end

function Capatain_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Capatain_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20727, 1, "Capatain_OnEnterCombat")
RegisterUnitEvent (20727, 2, "Capatain_OnLeaveCombat")
RegisterUnitEvent (20727, 4, "Capatain_OnDied")

function Captured_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Captured_Glaive",1000,0)
    pUnit:RegisterEvent("Captured_Hamstring",10000,0)
end

function Captured_Glaive(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36500,pUnit:GetClosestPlayer())
end

function Captured_Hamstring(pUnit,Event)
    pUnit:FullCastSpellOnTarget(31553,pUnit:GetClosestPlayer())
end

function Captured_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Captured_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20763, 1, "Captured_OnEnterCombat")
RegisterUnitEvent (20763, 2, "Captured_OnLeaveCombat")
RegisterUnitEvent (20763, 4, "Captured_OnDied")

function Chief_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Chief_Glaive",1000,0)
end

function Chief_Glaive(pUnit,Event)
    pUnit:FullCastSpellOnTarget(38204,pUnit:GetClosestPlayer())
end

function Chief_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Chief_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (18697, 1, "Chief_OnEnterCombat")
RegisterUnitEvent (18697, 2, "Chief_OnLeaveCombat")
RegisterUnitEvent (18697, 4, "Chief_OnDied")

function Frost_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Frost_Nova",8000,0)
    pUnit:RegisterEvent("Frost_Bolt",3000,0)
    pUnit:RegisterEvent("Frost_Barrier",30000,0)
end

function Frost_Nova(pUnit,Event)
    pUnit:FullCastSpellOnTarget(11831,pUnit:GetClosestPlayer())
end

function Frost_Bolt(pUnit,Event)
    pUnit:FullCastSpellOnTarget(9672,pUnit:GetClosestPlayer())
end

function Frost_Barrier(pUnit,Event)
    pUnit:CastSpell(33245)
end

function Frost_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Frost_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (19545, 1, "Frost_OnEnterCombat")
RegisterUnitEvent (19545, 2, "Frost_OnLeaveCombat")
RegisterUnitEvent (19545, 4, "Frost_OnDied")

function Commander_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Commander_Cleave",1000,0)
    pUnit:RegisterEvent("Commander_Spellbreaker",1000,0)
end

function Commander_Cleave(pUnit,Event)
    pUnit:FullCastSpellOnTarget(35473,pUnit:GetClosestPlayer())
end

function Commander_Spellbreaker(pUnit,Event)
    pUnit:FullCastSpellOnTarget(35871,pUnit:GetClosestPlayer())
end

function Commander_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Commander_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (19831, 1, "Commander_OnEnterCombat")
RegisterUnitEvent (19831, 2, "Commander_OnLeaveCombat")
RegisterUnitEvent (19831, 4, "Commander_OnDied")

function Conjurer_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Conjurer_Bolt",3000,0)
    pUnit:RegisterEvent("Conjurer_Sword",30000,0)
end

function Conjurer_Bolt(pUnit,Event)
    pUnit:FullCastSpellOnTarget(9532,pUnit:GetClosestPlayer())
end

function Conjurer_Sword(pUnit,Event)
    pUnit:CastSpell(36110)
end

function Conjurer_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Conjurer_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (19544, 1, "Conjurer_OnEnterCombat")
RegisterUnitEvent (19544, 2, "Conjurer_OnLeaveCombat")
RegisterUnitEvent (19544, 4, "Conjurer_OnDied")

function Basilisk_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Basilisk_Gaze",45000,0)
    pUnit:RegisterEvent("Basilisk_Charge",1000,0)
end

function Basilisk_Gaze(pUnit,Event)
    pUnit:FullCastSpellOnTarget(35313, pUnit:GetClosestPlayer())
end

function Basilisk_Charge(pUnit,Event)
    pUnit:FullCastSpellOnTarget(35385, pUnit:GetClosestPlayer())
end

function Basilisk_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Basilisk_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20607, 1, "Basilisk_OnEnterCombat")
RegisterUnitEvent (20607, 2, "Basilisk_OnLeaveCombat")
RegisterUnitEvent (20607, 4, "Basilisk_OnDied")

function Culuthas_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Culuthas_Felfire",3000,0)
end

function Culuthas_Felfire(pUnit,Event)
    pUnit:FullCastSpellOnTarget(37089, pUnit:GetClosestPlayer())
end

function Culuthas_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Culuthas_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20138, 1, "Culuthas_OnEnterCombat")
RegisterUnitEvent (20138, 2, "Culuthas_OnLeaveCombat")
RegisterUnitEvent (20138, 4, "Culuthas_OnDied")

function Forgelord_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Forgelord_Nova",2000,0)
    pUnit:RegisterEvent("Forgelord_Enrage",120000,0)
end

function Forgelord_Nova(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36255, pUnit:GetClosestPlayer())
end

function Forgelord_Enrage(pUnit,Event)
    pUnit:CastSpell(8599)
end

function Forgelord_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Forgelord_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (16943, 1, "Forgelord_OnEnterCombat")
RegisterUnitEvent (16943, 2, "Forgelord_OnLeaveCombat")
RegisterUnitEvent (16943, 4, "Forgelord_OnDied")

function Flames_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Flames_Dance",1000,0)
    pUnit:RegisterEvent("Flames_Seduction",180000,0)
    pUnit:RegisterEvent("Flames_Summon",1000,(1))
end

function Flames_Dance(pUnit,Event)
    pUnit:CastSpell(45427)
end

function Flames_Seduction(pUnit,Event)
    pUnit:FullCastSpellOnTarget(47057, pUnit:GetClosestPlayer())
end

function Flames_Summon(pUnit,Event)
    pUnit:CastSpell(45423)
end

function Flames_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Flames_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (25305, 1, "Flames_OnEnterCombat")
RegisterUnitEvent (25305, 2, "Flames_OnLeaveCombat")
RegisterUnitEvent (25305, 4, "Flames_OnDied")

function Daughter_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Daughter_Nova",2000,0)
end

function Daughter_Nova(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36225, pUnit:GetClosestPlayer())
end

function Daughter_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Daughter_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (18860, 1, "Daughter_OnEnterCombat")
RegisterUnitEvent (18860, 2, "Daughter_OnLeaveCombat")
RegisterUnitEvent (18860, 4, "Daughter_OnDied")

function Dimensius_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Dimensius_Trick",1000,(1))
    pUnit:RegisterEvent("Dimensius_Spiral",3000,0)
    pUnit:RegisterEvent("Dimensius_Vault",1000,0)
end

function Dimensius_Trick(pUnit,Event)
    pUnit:CastSpell(37425)
end

function Dimensius_Spiral(pUnit,Event)
    pUnit:FullCastSpellOnTarget(37500,pUnit:GetClosestPlayer())
end

function Dimensius_Vault(pUnit,Event)
    pUnit:FullCastSpellOnTarget(37412,pUnit:GetClosestPlayer())
end

function Dimensius_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Dimensius_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (19554, 1, "Dimensius_OnEnterCombat")
RegisterUnitEvent (19554, 2, "Dimensius_OnLeaveCombat")
RegisterUnitEvent (19554, 4, "Dimensius_OnDied")

function Exarch_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Exarch_Fortitude",2000,0)
    pUnit:RegisterEvent("Exarch_Devotion",1000,0)
end

function Exarch_Fortitude(pUnit,Event)
    pUnit:CastSpellOnTarget(36004,pUnit:GetRandomFriend())
end

function Exarch_Devotion(pUnit,Event)
    pUnit:CastSpell(8258)
end

function Exarch_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Exarch_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (21058, 1, "Exarch_OnEnterCombat")
RegisterUnitEvent (21058, 2, "Exarch_OnLeaveCombat")
RegisterUnitEvent (21058, 4, "Exarch_OnDied")

function Protector_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Protector_Strike",1000,0)
    pUnit:RegisterEvent("Protector_Smite",2500,0)
end

function Protector_Strike(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36647,pUnit:GetClosestPlayer())
end

function Protector_Smite(pUnit,Event)
    pUnit:FullCastSpellOnTarget(9734,pUnit:GetClosestPlayer())
end

function Protector_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Protector_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (18873, 1, "Protector_OnEnterCombat")
RegisterUnitEvent (18873, 2, "Protector_OnLeaveCombat")
RegisterUnitEvent (18873, 4, "Protector_OnDied")

function Vindicator_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Vindicator_Revenge",1000,0)
    pUnit:RegisterEvent("Vindicator_Vindication",1000,0)
end

function Vindicator_Revenge(pUnit,Event)
    pUnit:CastSpellOnTarget(36647,GetInRangeFriends())
end

function Vindicator_Vindication(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36002,pUnit:GetClosestPlayer())
end

function Vindicator_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Vindicator_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (18872, 1, "Vindicator_OnEnterCombat")
RegisterUnitEvent (18872, 2, "Vindicator_OnLeaveCombat")
RegisterUnitEvent (18872, 4, "Vindicator_OnDied")

function Doomclaw_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Doomclaw_Swipe",1000,0)
    pUnit:RegisterEvent("Doomclaw_Claw",1100,0)
    pUnit:RegisterEvent("Doomclaw_Slime",1000,0)
end

function Doomclaw_Swipe(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36205,pUnit:GetClosestPlayer())
end

function Doomclaw_Claw(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36996,pUnit:GetClosestPlayer())
end

function Doomclaw_Slime(pUnit,Event)
    pUnit:FullCastSpellOnTarget(34261,pUnit:GetClosestPlayer())
end

function Doomclaw_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Doomclaw_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (19738, 1, "Doomclaw_OnEnterCombat")
RegisterUnitEvent (19738, 2, "Doomclaw_OnLeaveCombat")
RegisterUnitEvent (19738, 4, "Doomclaw_OnDied")

function Boom_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Boom_Dynamite",1000,0)
end

function Boom_Dynamite(pUnit,Event)
    pUnit:FullCastSpellOnTarget(35276,pUnit:GetClosestPlayer())
end

function Boom_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Boom_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20284, 1, "Boom_OnEnterCombat")
RegisterUnitEvent (20284, 2, "Boom_OnLeaveCombat")
RegisterUnitEvent (20284, 4, "Boom_OnDied")

function Inquisitor_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Inquisitor_Weakness",1000,0)
    pUnit:RegisterEvent("Inquisitor_Flamestrike",3000,0)
end

function Inquisitor_Weakness(pUnit,Event)
    pUnit:FullCastSpellOnTarget(11980,pUnit:GetClosestPlayer())
end

function Inquisitor_Flamestrike(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36040,pUnit:GetClosestPlayer())
end

function Inquisitor_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Inquisitor_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (19493, 1, "Inquisitor_OnEnterCombat")
RegisterUnitEvent (19493, 2, "Inquisitor_OnEnterCombat")
RegisterUnitEvent (19493, 4, "Inquisitor_OnEnterCombat")

function Archon_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Archon_Flux",1000,0)
    pUnit:RegisterEvent("Archon_Intangible",1000,0)
    pUnit:RegisterEvent("Archon_Overspark",1000,0)
    pUnit:RegisterEvent("Archon_Shadow",1000,0)
end

function Archon_Flux(pUnit,Event)
    pUnit:FullCastSpellOnTarget(35924,pUnit:GetClosestPlayer())
end

function Archon_Intangible(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36513,pUnit:GetClosestPlayer())
end

function Archon_Overspark(pUnit,Event)
    pUnit:FullCastSpellOnTarget(35579,pUnit:GetClosestPlayer())
end

function Archon_Shadow(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36515,pUnit:GetClosestPlayer())
end

function Archon_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Archon_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20458, 1, "Archon_OnEnterCombat")
RegisterUnitEvent (20458, 2, "Archon_OnEnterCombat")
RegisterUnitEvent (20458, 4, "Archon_OnEnterCombat")

function Assassin_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Assassin_Kick",1000,0)
    pUnit:RegisterEvent("Assassin_Warp",1000,0)
end

function Assassin_Kick(pUnit,Event)
    pUnit:FullCastSpellOnTarget(34802,pUnit:GetClosestPlayer())
end

function Assassin_Warp(pUnit,Event)
    pUnit:FullCastSpellOnTarget(32920,pUnit:GetClosestPlayer())
end

function Assassin_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Assassin_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20452, 1, "Assassin_OnEnterCombat")
RegisterUnitEvent (20452, 2, "Assassin_OnEnterCombat")
RegisterUnitEvent (20452, 4, "Assassin_OnEnterCombat")

function Avenger_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Avenger_Shout",1000,0)
    pUnit:RegisterEvent("Avenger_Charge",1000,0)
    pUnit:RegisterEvent("Avenger_Weapons",1000,0)
end

function Avenger_Charge(pUnit,Event)
    pUnit:FullCastSpellOnTarget(32064,pUnit:GetClosestPlayer())
end

function Avenger_Intangible(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36509,pUnit:GetClosestPlayer())
end

function Avenger_Weapons(pUnit,Event)
    pUnit:FullCastSpellOnTarget(39489,pUnit:GetClosestPlayer())
end

function Avenger_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Avenger_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (22821, 1, "Avenger_OnEnterCombat")
RegisterUnitEvent (22821, 2, "Avenger_OnEnterCombat")
RegisterUnitEvent (22821, 4, "Avenger_OnEnterCombat")

function Gladiator_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Gladiator_Cleave",1000,0)
    pUnit:RegisterEvent("Gladiator_Hamstring",1000,0)
    pUnit:RegisterEvent("Gladiator_Strike",1000,0)
end

function Gladiator_Cleave(pUnit,Event)
    pUnit:FullCastSpellOnTarget(15284,pUnit:GetClosestPlayer())
end

function Gladiator_Hamstring(pUnit,Event)
    pUnit:FullCastSpellOnTarget(9080,pUnit:GetClosestPlayer())
end

function Gladiator_Strike(pUnit,Event)
    pUnit:FullCastSpellOnTarget(16856,pUnit:GetClosestPlayer())
end

function Gladiator_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Gladiator_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20854, 1, "Gladiator_OnEnterCombat")
RegisterUnitEvent (20854, 2, "Gladiator_OnEnterCombat")
RegisterUnitEvent (20854, 4, "Gladiator_OnEnterCombat")

function Jailor_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Jailor_Presence",1000,0)
end

function Jailor_Presence(pUnit,Event)
    pUnit:CastSpell(36513)
end

function Jailor_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Jailor_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (23008, 1, "Jailor_OnEnterCombat")
RegisterUnitEvent (23008, 2, "Jailor_OnEnterCombat")
RegisterUnitEvent (23008, 4, "Jailor_OnEnterCombat")

function Stalker_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Stalker_Shadowsurge",1000,0)
    pUnit:RegisterEvent("Stalker_Shadowtouched",1000,0)
end

function Stalker_Shadowsurge(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36517,pUnit:GetClosestPlayer())
end

function Stalker_Shadowtouched(pUnit,Event)
    pUnit:CastSpell(36515)
end

function Stalker_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Stalker_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20474, 1, "Stalker_OnEnterCombat")
RegisterUnitEvent (20474, 2, "Stalker_OnEnterCombat")
RegisterUnitEvent (20474, 4, "Stalker_OnEnterCombat")

function Nullifier_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Nullifier_Presence",1000,0)
end

function Nullifier_Presence(pUnit,Event)
    pUnit:CastSpell(36513)
end

function Nullifier_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Nullifier_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (22822, 1, "Nullifier_OnEnterCombat")
RegisterUnitEvent (22822, 2, "Nullifier_OnEnterCombat")
RegisterUnitEvent (22822, 4, "Nullifier_OnEnterCombat")

function Overlord_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Overlord_Shout",1000,0)
    pUnit:RegisterEvent("Overlord_Charge",1000,0)
    pUnit:RegisterEvent("Overlord_Weapons",1000,0)
    pUnit:RegisterEvent("Overlord_Shadowtouched",1000,0)
end

function Overlord_Charge(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36509,pUnit:GetMainTank())
end

function Overlord_Shout(pUnit,Event)
    pUnit:CastSpell(32064)
end

function Overlord_Weapons(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36510,pUnit:GetClosestPlayer())
end

function Overlord_Shadowtouched(pUnit,Event)
    pUnit:CastSpell(36515)
end

function Overlord_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Overlord_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20459, 1, "Overlord_OnEnterCombat")
RegisterUnitEvent (20459, 2, "Overlord_OnLeaveCombat")
RegisterUnitEvent (20459, 4, "Overlord_OnDied")

function Relay_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Relay_Shadowform",1000,0)
end

function Relay_Shadowform(pUnit,Event)
    pUnit:CastSpell(16592)
end

function Relay_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Relay_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20619, 1, "Relay_OnEnterCombat")
RegisterUnitEvent (20619, 2, "Relay_OnLeaveCombat")
RegisterUnitEvent (20619, 4, "Relay_OnDied")

function Researcher_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Researcher_Energy",1000,0)
    pUnit:RegisterEvent("Researcher_Surge",1000,0)
    pUnit:RegisterEvent("Researcher_Bolt",3000,0)
end

function Researcher_Energy(pUnit,Event)
    pUnit:CastSpell(16592)
end

function Researcher_Surge(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36508,pUnit:GetClosestPlayer())
end

function Researcher_Bolt(pUnit,Event)
    pUnit:FullCastSpellOnTarget(9532,pUnit:GetClosestPlayer())
end

function Researcher_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Researcher_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20456, 1, "Researcher_OnEnterCombat")
RegisterUnitEvent (20456, 2, "Researcher_OnLeaveCombat")
RegisterUnitEvent (20456, 4, "Researcher_OnDied")

function Shocktrooper_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Shocktrooper_Glaive",1000,0)
    pUnit:RegisterEvent("Shocktrooper_Hamstring",1000,0)
end

function Shocktrooper_Glaive(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36500,pUnit:GetClosestPlayer())
end

function Shocktrooper_Hamstring(pUnit,Event)
    pUnit:FullCastSpellOnTarget(31553,pUnit:GetClosestPlayer())
end

function Shocktrooper_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Shocktrooper_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20453, 1, "Shocktrooper_OnEnterCombat")
RegisterUnitEvent (20453, 2, "Shocktrooper_OnLeaveCombat")
RegisterUnitEvent (20453, 4, "Shocktrooper_OnDied")

function Orelis_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Orelis_Shout",1000,0)
    pUnit:RegisterEvent("Orelis_Strike",1000,0)
    pUnit:RegisterEvent("Orelis_Rend",1000,0)
end

function Orelis_Shout(pUnit,Event)
    pUnit:FullCastSpellOnTarget(13730,pUnit:GetClosestPlayer())
end

function Orelis_Strike(pUnit,Event)
    pUnit:FullCastSpellOnTarget(29426,pUnit:GetClosestPlayer())
end

function Orelis_Rend(pUnit,Event)
    pUnit:FullCastSpellOnTarget(16509,pUnit:GetClosestPlayer())
end

function Orelis_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Orelis_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (19466, 1, "Orelis_OnEnterCombat")
RegisterUnitEvent (19466, 2, "Orelis_OnLeaveCombat")
RegisterUnitEvent (19466, 4, "Orelis_OnDied")

function Eye_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Eye_Bursts",1000,0)
end

function Eye_Bursts(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36414,pUnit:GetClosestPlayer())
end

function Eye_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Eye_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20394, 1, "Eye_OnEnterCombat")
RegisterUnitEvent (20394, 2, "Eye_OnLeaveCombat")
RegisterUnitEvent (20394, 4, "Eye_OnDied")

function Lasher_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Lasher_Enrage",1000,0)
    pUnit:RegisterEvent("Lasher_Roots",1500,0)
    pUnit:RegisterEvent("Lasher_Growth",500,0)
end

function Lasher_Enrage(pUnit,Event)
    pUnit:CastSpell(3019)
end

function Lasher_Roots(pUnit,Event)
    pUnit:FullCastSpellOnTarget(12747,pUnit:GetClosestPlayer())
end

function Lasher_Growth(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36604,pUnit:GetClosestPlayer())
end

function Lasher_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Lasher_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20774, 1, "Lasher_OnEnterCombat")
RegisterUnitEvent (20774, 2, "Lasher_OnLeaveCombat")
RegisterUnitEvent (20774, 4, "Lasher_OnDied")

function Imp_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Imp_Bolt",2000,0)
end

function Imp_Bolt(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36227,pUnit:GetClosestPlayer())
end

function Imp_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Imp_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (21135, 1, "Imp_OnEnterCombat")
RegisterUnitEvent (21135, 2, "Imp_OnLeaveCombat")
RegisterUnitEvent (21135, 4, "Imp_OnDied")

function Doomguard_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Doomguard_Strike",1000,0)
    pUnit:RegisterEvent("Doomguard_Stomp",1000,0)
end

function Doomguard_Strike(pUnit,Event)
    pUnit:FullCastSpellOnTarget(32736,pUnit:GetClosestPlayer())
end

function Doomguard_Stomp(pUnit,Event)
    pUnit:FullCastSpellOnTarget(35238,pUnit:GetClosestPlayer())
end

function Doomguard_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Doomguard_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (19853, 1, "Doomguard_OnEnterCombat")
RegisterUnitEvent (19853, 2, "Doomguard_OnLeaveCombat")
RegisterUnitEvent (19853, 4, "Doomguard_OnDied")

function Wraith_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Wraith_Bolt",1000,0)
    pUnit:RegisterEvent("Wraith_Blast",6000,0)
end

function Wraith_Bolt(pUnit,Event)
    pUnit:FullCastSpellOnTarget(39337,pUnit:GetClosestPlayer())
end

function Wraith_Blast(pUnit,Event)
    pUnit:FullCastSpellOnTarget(38205,pUnit:GetClosestPlayer())
end

function Wraith_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Wraith_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (22408, 1, "Wraith_OnEnterCombat")
RegisterUnitEvent (22408, 2, "Wraith_OnLeaveCombat")
RegisterUnitEvent (22408, 4, "Wraith_OnDied")

function Engineer_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Engineer_Dynamite",1000,0)
end

function Engineer_Dynamite(pUnit,Event)
    pUnit:FullCastSpellOnTarget(7978,pUnit:GetClosestPlayer())
end

function Engineer_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Engineer_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (16948, 1, "Engineer_OnEnterCombat")
RegisterUnitEvent (16948, 2, "Engineer_OnLeaveCombat")
RegisterUnitEvent (16948, 4, "Engineer_OnDied")

function Mekgineer_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Mekgineer_Drain",1000,0)
    pUnit:RegisterEvent("Mekgineer_Steal",1000,0)
end

function Mekgineer_Drain(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36825,pUnit:GetClosestPlayer())
end

function Mekgineer_Steal(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36208,pUnit:GetClosestPlayer())
end

function Mekgineer_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Mekgineer_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (16949, 1, "Mekgineer_OnEnterCombat")
RegisterUnitEvent (16949, 2, "Mekgineer_OnLeaveCombat")
RegisterUnitEvent (16949, 4, "Mekgineer_OnDied")

function Tinker_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Tinker_Bomb",2000,0)
    pUnit:RegisterEvent("Tinker_Steal",1000,0)
end

function Tinker_Bomb(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36846,pUnit:GetClosestPlayer())
end

function Tinker_Steal(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36208,pUnit:GetClosestPlayer())
end

function Tinker_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Tinker_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20285, 1, "Tinker_OnEnterCombat")
RegisterUnitEvent (20285, 2, "Tinker_OnLeaveCombat")
RegisterUnitEvent (20285, 4, "Tinker_OnDied")

function Hatecryer_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Hatecryer_Curse",1000,0)
    pUnit:RegisterEvent("Hatecryer_Rain",1000,0)
end

function Hatecryer_Curse(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36541,pUnit:GetClosestPlayer())
end

function Hatecryer_Rain(pUnit,Event)
    pUnit:FullCastSpellOnTarget(34017,pUnit:GetClosestPlayer())
end

function Hatecryer_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Hatecryer_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20930, 1, "Hatecryer_OnEnterCombat")
RegisterUnitEvent (20930, 2, "Hatecryer_OnLeaveCombat")
RegisterUnitEvent (20930, 4, "Hatecryer_OnDied")

function Hound_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Hound_Breath",2500,0)
    pUnit:RegisterEvent("Hound_Stomp",1000,0)
end

function Hound_Breath(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36406,pUnit:GetClosestPlayer())
end

function Hound_Stomp(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36405,pUnit:GetClosestPlayer())
end

function Hound_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Hound_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20141, 1, "Hound_OnEnterCombat")
RegisterUnitEvent (20141, 2, "Hound_OnLeaveCombat")
RegisterUnitEvent (20141, 4, "Hound_OnDied")

function Forgelord_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Forgelord_Hammer",1000,0)
    pUnit:RegisterEvent("Forgelord_Slam",1900,0)
    pUnit:RegisterEvent("Forgelord_Toughen",1000,0)
end

function Forgelord_Hammer(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36251,pUnit:GetClosestPlayer())
end

function Forgelord_Slam(pUnit,Event)
    pUnit:FullCastSpellOnTarget(37179,pUnit:GetClosestPlayer())
end

function Forgelord_Toughen(pUnit,Event)
    pUnit:CastSpell(33962)
end

function Forgelord_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Forgelord_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20928, 1, "Forgelord_OnEnterCombat")
RegisterUnitEvent (20928, 2, "Forgelord_OnLeaveCombat")
RegisterUnitEvent (20928, 4, "Forgelord_OnDied")

function Kaylaan_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Kaylaan_Ressurection",4000,0)
end

function Kaylaan_Ressurection(pUnit,Event)
    pUnit:CastSpell(35746)
end

function Kaylaan_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Kaylaan_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20780, 1, "Kaylaan_OnEnterCombat")
RegisterUnitEvent (20780, 2, "Kaylaan_OnLeaveCombat")
RegisterUnitEvent (20780, 4, "Kaylaan_OnDied")

function Apprentice_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Apprentice_Hammer",1500,0)
end

function Apprentice_Hammer(pUnit,Event)
    pUnit:FullCastSpellOnTarget(37554,pUnit:GetClosestPlayer())
end

function Apprentice_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Apprentice_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20409, 1, "Apprentice_OnEnterCombat")
RegisterUnitEvent (20409, 2, "Apprentice_OnLeaveCombat")
RegisterUnitEvent (20409, 4, "Apprentice_OnDied")

function Ghost_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Ghost_Soulbind",2000,0)
end

function Ghost_Soulbind(pUnit,Event)
    pUnit:CastSpell(36153)
end

function Ghost_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Ghost_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20409, 1, "Ghost_OnEnterCombat")
RegisterUnitEvent (20409, 2, "Ghost_OnLeaveCombat")
RegisterUnitEvent (20409, 4, "Ghost_OnDied")

function Spectre_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Spectre_Curse",1000,0)
    Unit:RegisterEvent("Spectre_Bolt",3000,0)
end

function Spectre_Curse(pUnit,Event)
    pUnit:FullCastSpellOnTarget(11980,pUnit:GetClosestPlayer())
end

function Spectre_Bolt(pUnit,Event)
    pUnit:FullCastSpellOnTarget(9613,pUnit:GetClosestPlayer())
end

function Spectre_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Spectre_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20496, 1, "Spectre_OnEnterCombat")
RegisterUnitEvent (20496, 2, "Spectre_OnLeaveCombat")
RegisterUnitEvent (20496, 4, "Spectre_OnDied")

function Destroyer_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Destroyer_Knock",1000,0)
    pUnit:RegisterEvent("Destroyer_Strike",1000,0)
end

function Destroyer_Knock(pUnit,Event)
    pUnit:FullCastSpellOnTarget(11428,pUnit:GetClosestPlayer())
end

function Destroyer_Strike(pUnit,Event)
    pUnit:FullCastSpellOnTarget(13737,pUnit:GetClosestPlayer())
end

function Destroyer_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Destroyer_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20403, 1, "Destroyer_OnEnterCombat")
RegisterUnitEvent (20403, 2, "Destroyer_OnLeaveCombat")
RegisterUnitEvent (20403, 4, "Destroyer_OnDied")

function Cannon_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Cannon_Blast",3000,0)
end

function Cannon_Blast(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36238,pUnit:GetClosestPlayer())
end

function Cannon_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Cannon_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (21233, 1, "Cannon_OnEnterCombat")
RegisterUnitEvent (21233, 2, "Cannon_OnLeaveCombat")
RegisterUnitEvent (21233, 4, "Cannon_OnDied")

function Shocktrooper_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Shocktrooper_Rand",1000,0)
end

function Shocktrooper_Rand(pUnit,Event)
    pUnit:FullCastSpellOnTarget(35144,pUnit:GetClosestPlayer())
end

function Shocktrooper_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Shocktrooper_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20402, 1, "Shocktrooper_OnEnterCombat")
RegisterUnitEvent (20402, 2, "Shocktrooper_OnLeaveCombat")
RegisterUnitEvent (20402, 4, "Shocktrooper_OnDied")

function Mageslayer_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Mageslayer_Reflection",8000,0)
end

function Mageslayer_Reflection(pUnit,Event)
    pUnit:CastSpell(36096)
end

function Mageslayer_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Mageslayer_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (18866, 1, "Mageslayer_OnEnterCombat")
RegisterUnitEvent (18866, 2, "Mageslayer_OnLeaveCombat")
RegisterUnitEvent (18866, 4, "Mageslayer_OnDied")

function Beast_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Beast_Burn",1000,0)
end

function Beast_Burn(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36484,pUnit:GetClosestPlayer())
end

function Beast_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Beast_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (21267, 1, "Beast_OnEnterCombat")
RegisterUnitEvent (21267, 2, "Beast_OnLeaveCombat")
RegisterUnitEvent (21267, 4, "Beast_OnDied")

function Seeker_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Seeker_Burn",3000,0)
    pUnit:RegisterEvent("Seeker_Slow",2000,0)
end

function Seeker_Burn(pUnit,Event)
    pUnit:FullCastSpellOnTarget(11981,pUnit:GetClosestPlayer())
end

function Seeker_Slow(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36843,pUnit:GetClosestPlayer())
end

function Seeker_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Seeker_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (18867, 1, "Seeker_OnEnterCombat")
RegisterUnitEvent (18867, 2, "Seeker_OnLeaveCombat")
RegisterUnitEvent (18867, 4, "Seeker_OnDied")

function Snapper_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Snapper_DeMaterialize",1000,0)
    pUnit:RegisterEvent("Snapper_Burn",1000,0)
end

function Snapper_DeMaterialize(pUnit,Event)
    pUnit:CastSpell(34814)
end

function Snapper_Burn(pUnit,Event)
    pUnit:FullCastSpellOnTarget(37176,pUnit:GetMainTank())
end

function Snapper_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Snapper_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (18883, 1, "Snapper_OnEnterCombat")
RegisterUnitEvent (18883, 2, "Snapper_OnLeaveCombat")
RegisterUnitEvent (18883, 4, "Snapper_OnDied")

function Wraith_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Wraith_Mana",2000,0)
end

function Wraith_Mana(pUnit,Event)
    pUnit:FullCastSpellOnTarget(29054,pUnit:GetClosestPlayer())
end

function Wraith_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Wraith_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (18864, 1, "Wraith_OnEnterCombat")
RegisterUnitEvent (18864, 2, "Wraith_OnLeaveCombat")
RegisterUnitEvent (18864, 4, "Wraith_OnDied")

function Markaru_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Markaru_Spit",2500,0)
end

function Markaru_Spit(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36627,pUnit:GetClosestPlayer())
end

function Markaru_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Markaru_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20775, 1, "Markaru_OnEnterCombat")
RegisterUnitEvent (20775, 2, "Markaru_OnLeaveCombat")
RegisterUnitEvent (20775, 4, "Markaru_OnDied")

function Master_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Master_Arrow",1000,0)
    pUnit:RegisterEvent("Master_Clip",1000,0)
    pUnit:RegisterEvent("Master_Shoot",1000,0)
end

function Master_Arrow(pUnit,Event)
    pUnit:FullCastSpellOnTarget(35964,pUnit:GetClosestPlayer())
end

function Master_Clip(pUnit,Event)
    pUnit:FullCastSpellOnTarget(35963,pUnit:GetClosestPlayer())
end

function Master_Shoot(pUnit,Event)
    pUnit:FullCastSpellOnTarget(6660,pUnit:GetClosestPlayer())
end

function Master_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Master_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (19705, 1, "Master_OnEnterCombat")
RegisterUnitEvent (19705, 2, "Master_OnLeaveCombat")
RegisterUnitEvent (19705, 4, "Master_OnDied")

function Doomsmith_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Doomsmith_Doomsaw",1300,0)
end

function Doomsmith_Doomsaw(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36200,pUnit:GetClosestPlayer())
end

function Doomsmith_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Doomsmith_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (16944, 1, "Doomsmith_OnEnterCombat")
RegisterUnitEvent (16944, 2, "Doomsmith_OnLeaveCombat")
RegisterUnitEvent (16944, 4, "Doomsmith_OnDied")

function WarpMaster_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("WarpMaster_Spray",2000,0)
end

function WarpMaster_Spray(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36486,pUnit:GetClosestPlayer())
end

function WarpMaster_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function WarpMaster_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20326, 1, "WarpMaster_OnEnterCombat")
RegisterUnitEvent (20326, 2, "WarpMaster_OnLeaveCombat")
RegisterUnitEvent (20326, 4, "WarpMaster_OnDied")

function Lasher_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Lasher_Growth",1500,0)
end

function Lasher_Growth(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36604,pUnit:GetClosestPlayer())
end

function Lasher_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Lasher_OnDied(Unit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20983, 1, "Lasher_OnEnterCombat")
RegisterUnitEvent (20983, 2, "Lasher_OnLeaveCombat")
RegisterUnitEvent (20983, 4, "Lasher_OnDied")

function Dragon_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Dragon_Presence",1000,0)
    pUnit:RegisterEvent("Dragon_Netherbreath",2500,0)
end

function Dragon_Presence(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36513,pUnit:GetClosestPlayer())
end

function Dragon_Netherbreath(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36631,pUnit:GetClosestPlayer())
end

function Dragon_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Dragon_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20332, 1, "Dragon_OnEnterCombat")
RegisterUnitEvent (20332, 2, "Dragon_OnLeaveCombat")
RegisterUnitEvent (20332, 4, "Dragon_OnDied")

function Drake_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Drake_Presence",1000,0)
end

function Drake_Presence(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36513,pUnit:GetClosestPlayer())
end

function Drake_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Drake_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (18877, 1, "Drake_OnEnterCombat")
RegisterUnitEvent (18877, 2, "Drake_OnLeaveCombat")
RegisterUnitEvent (18877, 4, "Drake_OnDied")

function Ray_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Ray_Drain",1000,0)
    pUnit:RegisterEvent("Ray_Shock",1000,0)
    pUnit:RegisterEvent("Ray_Sting",1000,0)
end

function Ray_Drain(pUnit,Event)
    pUnit:FullCastSpellOnTarget(17008,pUnit:GetClosestPlayer())
end

function Ray_Shock(pUnit,Event)
    pUnit:FullCastSpellOnTarget(35334,pUnit:GetClosestPlayer())
end

function Ray_Sting(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36659,pUnit:GetClosestPlayer())
end

function Ray_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Ray_OnDied(Unit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (18880, 1, "Ray_OnEnterCombat")
RegisterUnitEvent (18880, 2, "Ray_OnLeaveCombat")
RegisterUnitEvent (18880, 4, "Ray_OnDied")

function Grindgarr_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Grindgarr_Flames",5000,0)
    pUnit:RegisterEvent("Grindgarr_Stomp",4000,0)
end

function Grindgarr_Flames(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36487,pUnit:GetClosestPlayer())
end   
   
function Grindgarr_Stomp(pUnit,Event)
    pUnit:FullCastSpellOnTarget(35238,pUnit:GetClosestPlayer())
end
    
function Grindgarr_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Grindgarr_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20803, 1, "Grindgarr_OnEnterCombat")
RegisterUnitEvent (20803, 2, "Grindgarr_OnLeaveCombat")
RegisterUnitEvent (20803, 4, "Grindgarr_OnDied")

function Athanel_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Athanel_Cleave",4000,0)
end

function Athanel_Cleave(pUnit,Event)
    pUnit:FullCastSpellOnTarget(15496,pUnit:GetMainTank())
end   
    
function Athanel_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Athanel_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20435, 1, "Athanel_OnEnterCombat")
RegisterUnitEvent (20435, 2, "Athanel_OnLeaveCombat")
RegisterUnitEvent (20435, 4, "Athanel_OnDied")

function Azarad_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Azarad_Rage",12000,0)
end

function Azarad_Rage(pUnit,Event)
    pUnit:CastSpell(35491)
end   
    
function Azarad_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Azarad_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20685, 1, "Azarad_OnEnterCombat")
RegisterUnitEvent (20685, 2, "Azarad_OnLeaveCombat")
RegisterUnitEvent (20685, 4, "Azarad_OnDied")

function Seylanna_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Seylanna_Crystal",2000,0)
    pUnit:RegisterEvent("Seylanna_Beam",4000,0)
end

function Seylanna_Crystal(pUnit,Event)
    pUnit:CastSpell(36179)
end   
   
function Seylanna_Beam(pUnit,Event)
    pUnit:FullCastSpellOnTarget(35919,pUnit:GetClosestPlayer())
end
    
function Seylanna_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Seylanna_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20397, 1, "Seylanna_OnEnterCombat")
RegisterUnitEvent (20397, 2, "Seylanna_OnLeaveCombat")
RegisterUnitEvent (20397, 4, "Seylanna_OnDied")

function Theredis_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Theredis_Disarm",8000,0)
    pUnit:RegisterEvent("Theredis_Breaker",9000,0)
end

function Theredis_Crystal(pUnit,Event)
    pUnit:FullCastSpellOnTarget(6713,pUnit:GetMainTank())
end   
   
function Theredis_Breaker(pUnit,Event)
    pUnit:FullCastSpellOnTarget(35871,pUnit:GetMainTank())
end
    
function Theredis_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Theredis_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20416, 1, "Theredis_OnEnterCombat")
RegisterUnitEvent (20416, 2, "Theredis_OnLeaveCombat")
RegisterUnitEvent (20416, 4, "Theredis_OnDied")

function Beast_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Beast_Rend",15000,0)
    pUnit:RegisterEvent("Beast_Parasite_Spell",6000,0)
    pUnit:RegisterEvent("Beast_Parasite_Spawn",36000,0)
end

function Beast_Rend(pUnit,Event)
    pUnit:FullCastSpellOnTarget(13443,pUnit:GetMainTank())
end

function Beast_Parasite_Spell(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36469,pUnit:GetRandomPlayer(0))
end

function Beast_Parasite_Spawn(pUnit,Event)
    local x = pUnit:GetX()
	local y = pUnit:GetY()
	local z = pUnit:GetZ()
	local o = pUnit:GetO()
    pUnit:CastSpell(36468)
    pUnit:SpawnCreature(21265, x-1, y, z, o, 14, o)
end

function Beast_OnLeaveCombat(pUnit,Event)
    pUnit:RemoveEvents()
end

function Beast_OnDied(pUnit,Event)
    pUnit:RemoveEvents()
end

RegisterUnitEvent(20335,1,"Beast_OnEnterCombat")
RegisterUnitEvent(20335,2,"Beast_OnLeaveCombat")
RegisterUnitEvent(20335,4,"Beast_OnDied")

function Pentatharon_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Pentatharon_Swarm",4000,0)
end

function Pentatharon_Swarm(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36039,pUnit:ClosestPlayer())
end   
    
function Pentatharon_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Pentatharon_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20215, 1, "Pentatharon_OnEnterCombat")
RegisterUnitEvent (20215, 2, "Pentatharon_OnLeaveCombat")
RegisterUnitEvent (20215, 4, "Pentatharon_OnDied")

function Hunter_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Hunter_DeMaterialize",8000,0)
    pUnit:RegisterEvent("Hunter_ManaBurn",3000,0)
end

function Hunter_DeMaterialize(pUnit,Event)
    pUnit:CastSpell(34814)
    pUnit:RegisterEvent("Hunter_Materialize",3000,0)
end   
   
function Hunter_ManaBurn(pUnit,Event)
    pUnit:FullCastSpellOnTarget(13321,pUnit:GetClosestPlayer())
end

function Hunter_Materialize(pUnit,Event)
    pUnit:CastSpell(34804)
end
    
function Hunter_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Hunter_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (18879, 1, "Hunter_OnEnterCombat")
RegisterUnitEvent (18879, 2, "Hunter_OnLeaveCombat")
RegisterUnitEvent (18879, 4, "Hunter_OnDied")

local cry_delay = 78000
local announces = {}
local announcei = 1 
local choice = 1

RegisterUnitEvent(19776, 6, "ExperimentalPilot1_Setup")
announces[1] = "All my bags are packed, I'm ready to go."

function ExperimentalPilot1_Tick(pUnit, Event)
   choice = math.random(1, announcei)
   pUnit:SendChatMessage(12, 0, announces[choice])
end

function ExperimentalPilot1_Setup(pUnit, Event)
   pUnit:RegisterEvent("ExperimentalPilot1_Tick", cry_delay, 0)
end


local cry_delay = 86000
local announces = {}
local announcei = 1 
local choice = 1

RegisterUnitEvent(19737, 6, "ExperimentalCrew1_Setup")
announces[1] = "The ship's not ready yet. We still need to calibrate the fuse length to make sure that it doesn't burn out and leave you up there alone."

function ExperimentalCrew1_Tick(pUnit, Event)
   choice = math.random(1, announcei)
   pUnit:SendChatMessage(12, 0, announces[choice])
end

function ExperimentalCrew1_Setup(pUnit, Event)
   pUnit:RegisterEvent("ExperimentalCrew1_Tick", cry_delay, 0)
end


local cry_delay = 94000
local announces = {}
local announcei = 1 
local choice = 1

RegisterUnitEvent(19776, 6, "ExperimentalPilot2_Setup")
announces[1] = "You need to do what? All this science, I don't understand ... Look, this is just my job, five days a week."

function ExperimentalPilot2_Tick(pUnit, Event)
   choice = math.random(1, announcei)
   pUnit:SendChatMessage(12, 0, announces[choice])
end

function ExperimentalPilot2_Setup(pUnit, Event)
   pUnit:RegisterEvent("ExperimentalPilot2_Tick", cry_delay, 0)
end


local cry_delay = 102000
local announces = {}
local announcei = 1 
local choice = 1

RegisterUnitEvent(19737, 6, "ExperimentalCrew2_Setup")
announces[1] = "Essentially, it's going to be a long, long time till we are ready to launch. Maybe you should just head back home to your family."

function ExperimentalCrew2_Tick(pUnit, Event)
   choice = math.random(1, announcei)
   pUnit:SendChatMessage(12, 0, announces[choice])
end

function ExperimentalCrew2_Setup(pUnit, Event)
   pUnit:RegisterEvent("ExperimentalCrew2_Tick", cry_delay, 0)
end

local cry_delay = 110000
local announces = {}
local announcei = 1 
local choice = 1

RegisterUnitEvent(19776, 6, "ExperimentalPilot3_Setup")
announces[1] = "I can't. I'm not the man they think I am at home. Besides, I didn't bring them out here."

function ExperimentalPilot3_Tick(pUnit, Event)
   choice = math.random(1, announcei)
   pUnit:SendChatMessage(12, 0, announces[choice])
end

function ExperimentalPilot3_Setup(pUnit, Event)
   pUnit:RegisterEvent("ExperimentalPilot3_Tick", cry_delay, 0)
end


local cry_delay = 190000
local announces = {}
local announcei = 1 
local choice = 1

RegisterUnitEvent(19737, 6, "ExperimentalCrew3_Setup")
announces[1] = "Why not? A family can give you strength."

function ExperimentalCrew3_Tick(pUnit, Event)
   choice = math.random(1, announcei)
   pUnit:SendChatMessage(12, 0, announces[choice])
end

function ExperimentalCrew3_Setup(pUnit, Event)
   pUnit:RegisterEvent("ExperimentalCrew3_Tick", cry_delay, 0)
end


local cry_delay = 270000
local announces = {}
local announcei = 1 
local choice = 1

RegisterUnitEvent(19776, 6, "ExperimentalPilot4_Setup")
announces[1] = "This isn't the kind of place to raise your kids. It's cold, and there'd be no one to raise them."

function ExperimentalPilot4_Tick(pUnit, Event)
   choice = math.random(1, announcei)
   pUnit:SendChatMessage(12, 0, announces[choice])
end

function ExperimentalPilot4_Setup(pUnit, Event)
   pUnit:RegisterEvent("ExperimentalPilot4_Tick", cry_delay, 0)
end


local cry_delay = 350000
local announces = {}
local announcei = 1 
local choice = 1

RegisterUnitEvent(19737, 6, "ExperimentalCrew4_Setup")
announces[1] = "Couldn't you raise them?"

function ExperimentalCrew4_Tick(pUnit, Event)
   choice = math.random(1, announcei)
   pUnit:SendChatMessage(12, 0, announces[choice])
end

function ExperimentalCrew4_Setup(pUnit, Event)
   pUnit:RegisterEvent("ExperimentalCrew4_Tick", cry_delay, 0)
end


local cry_delay = 430000
local announces = {}
local announcei = 1 
local choice = 1

RegisterUnitEvent(19776, 6, "ExperimentalPilot5_Setup")
announces[1] = "Oh, no, no, no... I'm a rocket man."

function ExperimentalPilot5_Tick(pUnit, Event)
   choice = math.random(1, announcei)
   pUnit:SendChatMessage(12, 0, announces[choice])
end

function ExperimentalPilot5_Setup(pUnit, Event)
   pUnit:RegisterEvent("ExperimentalPilot5_Tick", cry_delay, 0)
end

function Porfus_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Porfus_Hamstring",5000,0)
end

function Porfus_Hamstring(pUnit,Event)
    pUnit:FullCastSpellOnTarget(31553,pUnit:GetMainTank())
end   
    
function Porfus_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Porfus_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20783, 1, "Porfus_OnEnterCombat")
RegisterUnitEvent (20783, 2, "Porfus_OnLeaveCombat")
RegisterUnitEvent (20783, 4, "Porfus_OnDied")

function Avenger_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Avenger_Claive",4000,0)
end

function Avenger_Claive(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36500,pUnit:GetMainTank())
end   
    
function Avenger_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Avenger_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (21805, 1, "Avenger_OnEnterCombat")
RegisterUnitEvent (21805, 2, "Avenger_OnLeaveCombat")
RegisterUnitEvent (21805, 4, "Avenger_OnDied")

function Defender_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Defender_Claive",4000,0)
    pUnit:RegisterEvent("Defender_Hamstring",5000,0)
end

function Defender_Claive(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36500,pUnit:GetMainTank())
end   
    
function Defender_Hamstring(pUnit,Event)
    pUnit:FullCastSpellOnTarget(31553,pUnit:GetMainTank())
end 
    
function Defender_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Defender_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20984, 1, "Defender_OnEnterCombat")
RegisterUnitEvent (20984, 2, "Defender_OnLeaveCombat")
RegisterUnitEvent (20984, 4, "Defender_OnDied")

function Regenerator_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Regenerator_Bolt",2500,0)
end

function Regenerator_Bolt(pUnit,Event)
    pUnit:FullCastSpellOnTarget(34232,pUnit:ClosestPlayer())
end   
    
function Regenerator_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Regenerator_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (21783, 1, "Regenerator_OnEnterCombat")
RegisterUnitEvent (21783, 2, "Regenerator_OnLeaveCombat")
RegisterUnitEvent (21783, 4, "Regenerator_OnDied")

function Rhonsus_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Rhonsus_Smithery",4000,0)
end

function Rhonsus_Smithery(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36103,pUnit:ClosestPlayer())
end   
    
function Rhonsus_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Rhonsus_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20410, 1, "Rhonsus_OnEnterCombat")
RegisterUnitEvent (20410, 2, "Rhonsus_OnLeaveCombat")
RegisterUnitEvent (20410, 4, "Rhonsus_OnDied")

function Lynx_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Lynx_Dash",5000,0)
    pUnit:RegisterEvent("Lynx_Rip",6000,0)
    pUnit:RegisterEvent("Lynx_Swipe",5000,0)
end

function Lynx_Dash(pUnit,Event)
    pUnit:CastSpell(36589)
end   
   
function Lynx_Rip(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36590,pUnit:GetMainTank())
end

function Lynx_Swipe(pUnit,Event)
    pUnit:FullCastSpellOnTarget(31279,pUnit:GetMainTank())
end
    
function Lynx_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Lynx_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20671, 1, "Lynx_OnEnterCombat")
RegisterUnitEvent (20671, 2, "Lynx_OnLeaveCombat")
RegisterUnitEvent (20671, 4, "Lynx_OnDied")

function Raptor_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Raptor_Enrage",20000,0)
end

function Raptor_Enrage(pUnit,Event)
    pUnit:CastSpell(8599)
end   
    
function Raptor_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Raptor_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20634, 1, "Raptor_OnEnterCombat")
RegisterUnitEvent (20634, 2, "Raptor_OnLeaveCombat")
RegisterUnitEvent (20634, 4, "Raptor_OnDied")

function Sludge_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Sludge_Split",2500,0)
end

function Sludge_Split(pUnit,Event)
    pUnit:CastSpell(36465)
    local x = pUnit:GetX()
	local y = pUnit:GetY()
	local z = pUnit:GetZ()
	local o = pUnit:GetO()
    pUnit:SpawnCreature(21264, x-1, y, z, o, 14, o)
end   
    
function Sludge_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Sludge_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20501, 1, "Sludge_OnEnterCombat")
RegisterUnitEvent (20501, 2, "Sludge_OnLeaveCombat")
RegisterUnitEvent (20501, 4, "Sludge_OnDied")

function Defender_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Defender_Block",1000,(1))
    pUnit:RegisterEvent("Defender_Strike",5000,0)
end

function Defender_Block(pUnit,Event)
    pUnit:CastSpell(12169)
end   

function Defender_Strike(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36093,pUnit:GetMainTank())
end

function Defender_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Defender_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20934, 1, "Defender_OnEnterCombat")
RegisterUnitEvent (20934, 2, "Defender_OnLeaveCombat")
RegisterUnitEvent (20934, 4, "Defender_OnDied")

function Spirit_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Spirit_Nova",10000,0)
    pUnit:RegisterEvent("Spirit_Bolt",4000,0)
end

function Spirit_Nova(pUnit,Event)
    pUnit:CastSpell(11831)
end   

function Spirit_Bolt(pUnit,Event)
    pUnit:FullCastSpellOnTarget(20822,pUnit:GetMainTank())
end

function Spirit_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Spirit_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (19881, 1, "Spirit_OnEnterCombat")
RegisterUnitEvent (19881, 2, "Spirit_OnLeaveCombat")
RegisterUnitEvent (19881, 4, "Spirit_OnDied")

function Flayer_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Flayer_Skin",5000,0)
end

function Flayer_Skin(pUnit,Event)
    pUnit:CastSpell(36576)
end   

function Flayer_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Flayer_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20210, 1, "Flayer_OnEnterCombat")
RegisterUnitEvent (20210, 2, "Flayer_OnLeaveCombat")
RegisterUnitEvent (20210, 4, "Flayer_OnDied")

function Moth_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Moth_Dust",10000,0)
    pUnit:RegisterEvent("Moth_Buffet",2000,0)
end

function Moth_Dust(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36592,pUnit:GetMainTank())
end   

function Moth_Buffet(pUnit,Event)
    pUnit:FullCastSpellOnTarget(32914,pUnit:GetMainTank())
end

function Moth_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Moth_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20611, 1, "Moth_OnEnterCombat")
RegisterUnitEvent (20611, 2, "Moth_OnLeaveCombat")
RegisterUnitEvent (20611, 4, "Moth_OnDied")

function Stallion_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Stallion_Kick",5000,0)
end

function Stallion_Kick(pUnit,Event)
    pUnit:FullCastSpellOnTarget(11978,pUnit:GetMainTank())
end   

function Stallion_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Stallion_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20495, 1, "Stallion_OnEnterCombat")
RegisterUnitEvent (20495, 2, "Stallion_OnLeaveCombat")
RegisterUnitEvent (20495, 4, "Stallion_OnDied")

function Dimensius_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Dimensius_Feed",5000,0)
end

function Dimensius_Feed(pUnit,Event)
    pUnit:FullCastSpellOnTarget(37450,pUnit:GetMainTank())
end   

function Dimensius_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Dimensius_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (21780, 1, "Dimensius_OnEnterCombat")
RegisterUnitEvent (21780, 2, "Dimensius_OnLeaveCombat")
RegisterUnitEvent (21780, 4, "Dimensius_OnDied")

function Maryana_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Maryana_Blast",5000,0)
    pUnit:RegisterEvent("Maryana_Fire",7000,0)
    pUnit:RegisterEvent("Maryana_Intellect",1000,(1))
end

function Maryana_Blast(pUnit,Event)
    pUnit:CastSpell(37450)
end   

function Maryana_Fire(pUnit,Event)
    pUnit:CastSpell(15091)
end

function Maryana_Intellect(pUnit,Event)
    pUnit:CastSpell(35917)
end

function Maryana_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Maryana_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (19593, 1, "Maryana_OnEnterCombat")
RegisterUnitEvent (19593, 2, "Maryana_OnLeaveCombat")
RegisterUnitEvent (19593, 4, "Maryana_OnDied")

function Marathelle_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Marathelle_Tempest",4500,0)
    pUnit:RegisterEvent("Marathelle_Ring",20000,0)
end

function Marathelle_Tempest(pUnit,Event)
    pUnit:FullCastSpellOnTarget(35843,pUnit:GetClosestPlayer())
end   

function Marathelle_Ring(pUnit,Event)
    pUnit:FullCastSpellOnTarget(35831,pUnit:GetRandomPlayer(0))
end

function Marathelle_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Marathelle_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (19926, 1, "Marathelle_OnEnterCombat")
RegisterUnitEvent (19926, 2, "Marathelle_OnLeaveCombat")
RegisterUnitEvent (19926, 4, "Marathelle_OnDied")

function Summoner_Kanthin_OnCombat(pUnit, Event)
pUnit:RegisterEvent("Summoner_Kanthin_Fireball", 4000, 0)
pUnit:RegisterEvent("Summoner_Kanthin_Nova", 10000, 0)
pUnit:RegisterEvent("Summoner_Kanthin_Pyroblast", 7000, 0)
end

function Summoner_Kanthin_OnLeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function Summoner_Kanthin_OnKillTarget(pUnit, Event)
pUnit:RemoveEvents()
end

function Summoner_Kanthin_OnDeath(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(19657, 1, "Summoner_Kanthin_OnCombat")
RegisterUnitEvent(19657, 2, "Summoner_Kanthin_OnLeaveCombat")
RegisterUnitEvent(19657, 3, "Summoner_Kanthin_OnKillTarget")
RegisterUnitEvent(19657, 4, "Summoner_Kanthin_OnDeath")

function Summoner_Kanthin_Fireball(pUnit, Event)
pUnit:FullCastSpellOnTarget(19816,pUnit:GetClosestPlayer())
end

function Summoner_Kanthin_Nova(pUnit, Event)
pUnit:FullCastSpellOnTarget(19657,pUnit:GetMainTank())
end

function Summoner_Kanthin_Pyroblast(pUnit, Event)
pUnit:FullCastSpellOnTarget(17273,pUnit:GetClosestPlayer())
end

function Sundered_Rumbler_OnCombat(pUnit, Event)
pUnit:RegisterEvent("Sundered_Rumbler_Summon_Sundered_Shard", 8000, 0)
end

function Sundered_Rumbler_OnLeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function Sundered_Rumbler_OnKillTarget(pUnit, Event)
pUnit:RemoveEvents()
end

function Sundered_Rumbler_OnDeath(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(18881, 1, "Sundered_Rumbler_OnCombat")
RegisterUnitEvent(18881, 2, "Sundered_Rumbler_OnLeaveCombat")
RegisterUnitEvent(18881, 3, "Sundered_Rumbler_OnKillTarget")
RegisterUnitEvent(18881, 4, "Sundered_Rumbler_OnDeath")

function Sundered_Rumbler_Summon_Sundered_Shard(pUnit, Event)
pUnit:CastSpell(35310)
local X = pUnit:GetX()
local Y = pUnit:GetY()
local Z = pUnit:GetZ()
local O = pUnit:GetO()
pUnit:SpawnCreature(20498, X, Y, Z, O, 35, 0)
end


function Sundered_Thunderer_OnCombat(pUnit, Event)
pUnit:RegisterEvent("Sundered_Thunderer_Summon_Sundered_Shard", 8000, 0)
pUnit:RegisterEvent("Sundered_Thunderer_Thunder_Clap", 6000, 0)
end

function Sundered_Thunderer_OnLeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function Sundered_Thunderer_OnKillTarget(pUnit, Event)
pUnit:RemoveEvents()
end

function Sundered_Thunderer_OnDeath(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(18882, 1, "Sundered_Thunderer_OnCombat")
RegisterUnitEvent(18882, 2, "Sundered_Thunderer_OnLeaveCombat")
RegisterUnitEvent(18882, 3, "Sundered_Thunderer_OnKillTarget")
RegisterUnitEvent(18882, 4, "Sundered_Thunderer_OnDeath")

function Sundered_Thunderer_Thunder_Clap(pUnit, Event)
pUnit:FullCastSpellOnTarget(6000,pUnit:GetMainTank())
end

function Sundered_Thunderer_Summon_Sundered_Shard(pUnit, Event)
pUnit:CastSpell(35007)
local X = pUnit:GetX()
local Y = pUnit:GetY()
local Z = pUnit:GetZ()
local O = pUnit:GetO()
pUnit:SpawnCreature(20498, X, Y, Z, O, 35, 0)
end

function Sunfury_Arcanist_OnCombat(pUnit, Event)
pUnit:RegisterEvent("Sunfury_Arcanist_Arcane_Missiles", 6000, 0)
pUnit:RegisterEvent("Sunfury_Arcanist_Bloodcrystal_Surge", 10000, 0)
end

function Sunfury_Arcanist_OnLeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function Sunfury_Arcanist_OnKillTarget(pUnit, Event)
pUnit:RemoveEvents()
end

function Sunfury_Arcanist_OnDeath(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(20134, 1, "Sunfury_Arcanist_OnCombat")
RegisterUnitEvent(20134, 2, "Sunfury_Arcanist_OnLeaveCombat")
RegisterUnitEvent(20134, 3, "Sunfury_Arcanist_OnKillTarget")
RegisterUnitEvent(20134, 4, "Sunfury_Arcanist_OnDeath")

function Sunfury_Arcanist_Arcane_Missiles(pUnit, Event)
pUnit:FullCastSpellOnTarget(34447,pUnit:GetMainTank())
end

function Sunfury_Arcanist_Bloodcrystal_Surge(pUnit, Event)
pUnit:CastSpell(35778)
end

function Sunfury_Arch_Mage_OnCombat(pUnit, Event)
pUnit:RegisterEvent("Sunfury_Arch_Mage_Nova", 10000, 0)
pUnit:RegisterEvent("Sunfury_Arch_Mage_Fiery_Intellect", 1000, (1))
pUnit:RegisterEvent("Sunfury_Arch_Mage_Fireball", 4000, 0)
end

function Sunfury_Arch_Mage_OnLeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function Sunfury_Arch_Mage_OnKillTarget(pUnit, Event)
pUnit:RemoveEvents()
end

function Sunfury_Arch_Mage_OnDeath(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(20135, 1, "Sunfury_Arch_Mage_OnCombat")
RegisterUnitEvent(20135, 2, "Sunfury_Arch_Mage_OnLeaveCombat")
RegisterUnitEvent(20135, 3, "Sunfury_Arch_Mage_OnKillTarget")
RegisterUnitEvent(20135, 4, "Sunfury_Arch_Mage_OnDeath")

function Sunfury_Arch_Mage_Nova(pUnit, Event)
pUnit:CastSpell(11831)
end

function Sunfury_Arch_Mage_Fiery_Intellect(pUnit, Event)
pUnit:CastSpell(35917)
end

function Sunfury_Arch_Mage_Fireball(pUnit, Event)
pUnit:FullCastSpellOnTarget(20823,pUnit:GetMainTank())
end

function Sunfury_Archer_OnCombat(Unit, Event)
Unit:RegisterEvent("Sunfury_Archer_Net", 8000, 0)
Unit:RegisterEvent("Sunfury_Archer_Immolation_Arrow", 6000, 0)
Unit:RegisterEvent("Sunfury_Archer_Shoot", 6000, 0)
end

function Sunfury_Archer_Immolation_Arrow(pUnit, Event) 
pUnit:FullCastSpellOnTarget(37847, pUnit:GetMainTank()) 
end

function Sunfury_Archer_Net(pUnit, Event) 
pUnit:FullCastSpellOnTarget(12024, pUnit:GetMainTank()) 
end

function Sunfury_Archer_Shoot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(6660, pUnit:GetMainTank()) 
end

function Sunfury_Archer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Sunfury_Archer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Sunfury_Archer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(19707, 1, "Sunfury_Archer_OnCombat")
RegisterUnitEvent(19707, 2, "Sunfury_Archer_OnLeaveCombat")
RegisterUnitEvent(19707, 3, "Sunfury_Archer_OnKilledTarget")
RegisterUnitEvent(19707, 4, "Sunfury_Archer_OnDied")

function Astromancer_OnCombat(Unit, Event)
Unit:RegisterEvent("Astromancer_Focus", 6000, 0)
Unit:RegisterEvent("Astromancer_Intellect", 1000, 1)
Unit:RegisterEvent("Astromancer_Scorch", 4000, 0)
end

function Astromancer_Focus(pUnit, Event) 
pUnit:CastSpell(35914) 
end

function Astromancer_Intellect(pUnit, Event) 
pUnit:CastSpell(35917) 
end

function Astromancer_Scorch(pUnit, Event) 
pUnit:FullCastSpellOnTarget(38391, pUnit:GetMainTank()) 
end

function Astromancer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Astromancer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Astromancer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(19643, 1, "Astromancer_OnCombat")
RegisterUnitEvent(19643, 2, "Astromancer_OnLeaveCombat")
RegisterUnitEvent(19643, 3, "Astromancer_OnKilledTarget")
RegisterUnitEvent(19643, 4, "Astromancer_OnDied")

function Knight_OnCombat(Unit, Event)
end

function Knight_Heal(pUnit, Event) 
pUnit:CastSpell(36476) 
end

function Knight_Enrage(pUnit, Event) 
pUnit:CastSpell(8599) 
end

function Knight_Breaker(pUnit, Event) 
pUnit:FullCastSpellOnTarget(35871, pUnit:GetMainTank()) 
end

function Knight_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Knight_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Knight_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(21089, 1, "Knight_OnCombat")
RegisterUnitEvent(21089, 2, "Knight_OnLeaveCombat")
RegisterUnitEvent(21089, 3, "Knight_OnKilledTarget")
RegisterUnitEvent(21089, 4, "Knight_OnDied")

function Bloodwarder_OnCombat(Unit, Event)
Unit:RegisterEvent("Bloodwarder_Enrage", 25000, 1)
Unit:RegisterEvent("Bloodwarder_Mark", 10000, 0)
end

function Bloodwarder_Enrage(pUnit, Event) 
pUnit:CastSpell(8599) 
end

function Bloodwarder_Mark(pUnit, Event) 
pUnit:FullCastSpellOnTarget(35877, pUnit:GetMainTank()) 
end

function Bloodwarder_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Bloodwarder_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Bloodwarder_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(18853, 1, "Bloodwarder_OnCombat")
RegisterUnitEvent(18853, 2, "Bloodwarder_OnLeaveCombat")
RegisterUnitEvent(18853, 3, "Bloodwarder_OnKilledTarget")
RegisterUnitEvent(18853, 4, "Bloodwarder_OnDied")

function Sunfury_Bowman_OnCombat(Unit, Event)
Unit:RegisterEvent("Sunfury_Bowman_Net", 8000, 0)
Unit:RegisterEvent("Sunfury_Bowman_Immolation_Arrow", 6000, 0)
Unit:RegisterEvent("Sunfury_Bowman_Shoot", 6000, 0)
end

function Sunfury_Bowman_Immolation_Arrow(pUnit, Event) 
pUnit:FullCastSpellOnTarget(37847, pUnit:GetMainTank()) 
end

function Sunfury_Bowman_Net(pUnit, Event) 
pUnit:FullCastSpellOnTarget(12024, pUnit:GetMainTank()) 
end

function Sunfury_Bowman_Shoot(pUnit, Event) 
pUnit:FullCastSpellOnTarget(6660, pUnit:GetMainTank()) 
end

function Sunfury_Bowman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Sunfury_Bowman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Sunfury_Bowman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(20207, 1, "Sunfury_Bowman_OnCombat")
RegisterUnitEvent(20207, 2, "Sunfury_Bowman_OnLeaveCombat")
RegisterUnitEvent(20207, 3, "Sunfury_Bowman_OnKilledTarget")
RegisterUnitEvent(20207, 4, "Sunfury_Bowman_OnDied")

function Captain_OnCombat(Unit, Event)
Unit:RegisterEvent("Captain_Shout", 1000, 3)
Unit:RegisterEvent("Captain_Enrage", 25000, 1)
Unit:RegisterEvent("Captain_Breaker", 10000, 0)
Unit:RegisterEvent("Captain_Breaker", 10000, 0)
end

function Captain_Shout(pUnit, Event) 
pUnit:CastSpellOnTarget(32064, pUnit:GetRandomFriend(0)) 
end

function Captain_Enrage(pUnit, Event) 
pUnit:CastSpell(8599) 
end

function Captain_Breaker(pUnit, Event) 
pUnit:CastSpell(35871) 
end

function Captain_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Captain_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Captain_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(19453, 1, "Captain_OnCombat")
RegisterUnitEvent(19453, 2, "Captain_OnLeaveCombat")
RegisterUnitEvent(19453, 3, "Captain_OnKilledTarget")
RegisterUnitEvent(19453, 4, "Captain_OnDied")

function Centurion_OnCombat(Unit, Event)
Unit:RegisterEvent("Centurion_Enrage", 25000, 1)
Unit:RegisterEvent("Centurion_Breaker", 10000, 0)
end

function Centurion_Enrage(pUnit, Event) 
pUnit:CastSpell(8599) 
end

function Centurion_Breaker(pUnit, Event) 
pUnit:CastSpell(35871) 
end

function Centurion_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Centurion_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Centurion_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(20140, 1, "Centurion_OnCombat")
RegisterUnitEvent(20140, 2, "Centurion_OnLeaveCombat")
RegisterUnitEvent(20140, 3, "Centurion_OnKilledTarget")
RegisterUnitEvent(20140, 4, "Centurion_OnDied")

function Conjurer_OnCombat(Unit, Event)
Unit:RegisterEvent("Conjurer_Surge", 10000, 0)
Unit:RegisterEvent("Conjurer_Flamestrike", 8000, 0)
Unit:RegisterEvent("Conjurer_Frostbolt", 6000, 0)
end

function Conjurer_Surge(pUnit, Event) 
pUnit:CastSpell(35778) 
end

function Conjurer_Flamestrike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(11829, pUnit:GetMainTank()) 
end

function Conjurer_Frostbolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(9672, pUnit:GetMainTank()) 
end

function Conjurer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Conjurer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Conjurer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(20139, 1, "Conjurer_OnCombat")
RegisterUnitEvent(20139, 2, "Conjurer_OnLeaveCombat")
RegisterUnitEvent(20139, 3, "Conjurer_OnKilledTarget")
RegisterUnitEvent(20139, 4, "Conjurer_OnDied")

function Flamekeeper_OnCombat(Unit, Event)
Unit:RegisterEvent("Flamekeeper_Enrage", 25000, 0)
Unit:RegisterEvent("Flamekeeper_Flame", 10000, 0)
Unit:RegisterEvent("Flamekeeper_Torch", 5000, 0)
end

function Flamekeeper_Enrage(pUnit, Event) 
pUnit:CastSpell(8599) 
end

function Flamekeeper_Flame(pUnit, Event) 
pUnit:FullCastSpellOnTarget(33731, pUnit:GetMainTank()) 
end

function Flamekeeper_Torch(pUnit, Event) 
pUnit:FullCastSpellOnTarget(35857, pUnit:GetMainTank()) 
end

function Flamekeeper_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Flamekeeper_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Flamekeeper_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(20221, 1, "Flamekeeper_OnCombat")
RegisterUnitEvent(20221, 2, "Flamekeeper_OnLeaveCombat")
RegisterUnitEvent(20221, 3, "Flamekeeper_OnKilledTarget")
RegisterUnitEvent(20221, 4, "Flamekeeper_OnDied")

function Geologist_OnCombat(Unit, Event)
Unit:RegisterEvent("Geologist_Armor", 10000, 0)
Unit:RegisterEvent("Geologist_Rock", 6000, 0)
end

function Geologist_Armor(pUnit, Event) 
pUnit:FullCastSpellOnTarget(35918, pUnit:GetMainTank()) 
end

function Geologist_Rock(pUnit, Event) 
pUnit:FullCastSpellOnTarget(36645, pUnit:GetMainTank()) 
end

function Geologist_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Geologist_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Geologist_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(19779, 1, "Geologist_OnCombat")
RegisterUnitEvent(19779, 2, "Geologist_OnLeaveCombat")
RegisterUnitEvent(19779, 3, "Geologist_OnKilledTarget")
RegisterUnitEvent(19779, 4, "Geologist_OnDied")

function Guardsman_OnCombat(Unit, Event)
Unit:RegisterEvent("Guardsman_Enrage", 25000, 0)
Unit:RegisterEvent("Guardsman_Mark", 10000, 0)
end

function Guardsman_Enrage(pUnit, Event) 
pUnit:CastSpell(8599) 
end

function Guardsman_Mark(pUnit, Event) 
pUnit:FullCastSpellOnTarget(35877, pUnit:GetMainTank()) 
end

function Guardsman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Guardsman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Guardsman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(18850, 1, "Guardsman_OnCombat")
RegisterUnitEvent(18850, 2, "Guardsman_OnLeaveCombat")
RegisterUnitEvent(18850, 3, "Guardsman_OnKilledTarget")
RegisterUnitEvent(18850, 4, "Guardsman_OnDied")

function Magister_OnCombat(Unit, Event)
Unit:RegisterEvent("Magister_Fireball", 6000, 0)
Unit:RegisterEvent("Magister_Surge", 10000, 0)
end

function Magister_Fireball(pUnit, Event) 
pUnit:FullCastSpellOnTarget(9053, pUnit:GetMainTank()) 
end

function Magister_Surge(pUnit, Event) 
pUnit:CastSpell(35778) 
end

function Magister_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Magister_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Magister_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(18855, 1, "Magister_OnCombat")
RegisterUnitEvent(18855, 2, "Magister_OnLeaveCombat")
RegisterUnitEvent(18855, 3, "Magister_OnKilledTarget")
RegisterUnitEvent(18855, 4, "Magister_OnDied")

function Nethermancer_OnCombat(Unit, Event)
Unit:RegisterEvent("Nethermancer_Surge", 10000, 0)
Unit:RegisterEvent("Nethermancer_Bolt", 5000, 0)
Unit:RegisterEvent("Nethermance_Summon",20000,0)
end

function Nethermancer_Surge(pUnit, Event) 
pUnit:CastSpell(35778) 
end

function Nethermance_Summon(pUnit,Event)
    local x = pUnit:GetX()
	local y = pUnit:GetY()
	local z = pUnit:GetZ()
	local o = pUnit:GetO()
    pUnit:CastSpell(36477)
    pUnit:SpawnCreature(21267, x-1, y, z, o, 14, o)
end

function Nethermancer_Bolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(9613, pUnit:GetMainTank()) 
end

function Nethermancer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Nethermancer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Nethermancer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(20248, 1, "Nethermancer_OnCombat")
RegisterUnitEvent(20248, 2, "Nethermancer_OnLeaveCombat")
RegisterUnitEvent(20248, 3, "Nethermancer_OnKilledTarget")
RegisterUnitEvent(20248, 4, "Nethermancer_OnDied")

function Researcher_OnCombat(Unit, Event)
Unit:RegisterEvent("Researcher_Armor", 6000, 0)
end

function Researcher_Armor(pUnit, Event) 
pUnit:FullCastSpellOnTarget(35918, pUnit:GetMainTank()) 
end

function Researcher_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Researcher_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Researcher_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(20136, 1, "Researcher_OnCombat")
RegisterUnitEvent(20136, 2, "Researcher_OnLeaveCombat")
RegisterUnitEvent(20136, 3, "Researcher_OnKilledTarget")
RegisterUnitEvent(20136, 4, "Researcher_OnDied")

function Engineer_OnCombat(Unit, Event)
Unit:RegisterEvent("Engineer_Beam", 6000, 0)
end

function Engineer_Beam(pUnit, Event) 
pUnit:FullCastSpellOnTarget(35919, pUnit:GetMainTank()) 
end

function Engineer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Engineer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Engineer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(18852, 1, "Engineer_OnCombat")
RegisterUnitEvent(18852, 2, "Engineer_OnLeaveCombat")
RegisterUnitEvent(18852, 3, "Engineer_OnKilledTarget")
RegisterUnitEvent(18852, 4, "Engineer_OnDied")

function Master_OnCombat(Unit, Event)
Unit:RegisterEvent("Master_Beam", 6000, 0)
end

function Master_Beam(pUnit, Event) 
pUnit:FullCastSpellOnTarget(35919, pUnit:GetMainTank()) 
end

function Master_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Master_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Master_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(18857, 1, "Master_OnCombat")
RegisterUnitEvent(18857, 2, "Master_OnLeaveCombat")
RegisterUnitEvent(18857, 3, "Master_OnKilledTarget")
RegisterUnitEvent(18857, 4, "Master_OnDied")

function Shredder_OnCombat(Unit, Event)
Unit:RegisterEvent("Shredder_Blast", 6000, 0)
Unit:RegisterEvent("Shredder_Shield", 1000, 1)
end

function Shredder_Blast(pUnit, Event) 
pUnit:FullCastSpellOnTarget(36594, pUnit:GetMainTank()) 
end

function Shredder_Shield(pUnit, Event) 
pUnit:CastSpell(19514) 
end

function Shredder_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Shredder_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Shredder_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(20673, 1, "Shredder_OnCombat")
RegisterUnitEvent(20673, 2, "Shredder_OnLeaveCombat")
RegisterUnitEvent(20673, 3, "Shredder_OnKilledTarget")
RegisterUnitEvent(20673, 4, "Shredder_OnDied")

function Doe_OnCombat(Unit, Event)
Unit:RegisterEvent("Doe_Gore", 5000, 0)
end

function Doe_Gore(pUnit, Event) 
pUnit:FullCastSpellOnTarget(32019, pUnit:GetMainTank()) 
end

function Doe_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Doe_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Doe_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(20610, 1, "Doe_OnCombat")
RegisterUnitEvent(20610, 2, "Doe_OnLeaveCombat")
RegisterUnitEvent(20610, 3, "Doe_OnKilledTarget")
RegisterUnitEvent(20610, 4, "Doe_OnDied")

function Sire_OnCombat(Unit, Event)
Unit:RegisterEvent("Sire_Stomp", 6000, 0)
end

function Sire_Stomp(pUnit, Event) 
pUnit:FullCastSpellOnTarget(32023, pUnit:GetMainTank()) 
end

function Sire_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Sire_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Sire_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(20777, 1, "Sire_OnCombat")
RegisterUnitEvent(20777, 2, "Sire_OnLeaveCombat")
RegisterUnitEvent(20777, 3, "Sire_OnKilledTarget")
RegisterUnitEvent(20777, 4, "Sire_OnDied")

function Protector_OnCombat(Unit, Event)
Unit:RegisterEvent("Protector_Cleave", 7000, 0)
Unit:RegisterEvent("Protector_Flames", 5000, 0)
end

function Protector_Cleave(pUnit, Event) 
pUnit:FullCastSpellOnTarget(15496, pUnit:GetMainTank()) 
end

function Protector_Flames(pUnit, Event) 
pUnit:FullCastSpellOnTarget(37488, pUnit:GetMainTank()) 
end

function Protector_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Protector_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Protector_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(21923, 1, "Protector_OnCombat")
RegisterUnitEvent(21923, 2, "Protector_OnLeaveCombat")
RegisterUnitEvent(21923, 3, "Protector_OnKilledTarget")
RegisterUnitEvent(21923, 4, "Protector_OnDied")

function Citizen_OnCombat(Unit, Event)
Unit:RegisterEvent("Citizen_Curse", 1000, 1)
Unit:RegisterEvent("Citizen_Bolt", 6000, 0)
Unit:RegisterEvent("Citizen_Immune", 6000, 0)
end

function Citizen_Curse(pUnit, Event) 
pUnit:FullCastSpellOnTarget(11980, pUnit:GetMainTank()) 
end

function Citizen_Bolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(9613, pUnit:GetMainTank()) 
end

function Citizen_Immune(pUnit, Event) 
pUnit:FullCastSpellOnTarget(36153, pUnit:GetMainTank()) 
end

function Citizen_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Citizen_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Citizen_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(21065, 1, "Citizen_OnCombat")
RegisterUnitEvent(21065, 2, "Citizen_OnLeaveCombat")
RegisterUnitEvent(21065, 3, "Citizen_OnKilledTarget")
RegisterUnitEvent(21065, 4, "Citizen_OnDied")

function Soul_OnCombat(Unit, Event)
Unit:RegisterEvent("Soul_Immune", 6000, 0)
end

function Soul_Immune(pUnit, Event) 
pUnit:FullCastSpellOnTarget(36153, pUnit:GetMainTank()) 
end

function Soul_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Soul_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Soul_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(20512, 1, "Soul_OnCombat")
RegisterUnitEvent(20512, 2, "Soul_OnLeaveCombat")
RegisterUnitEvent(20512, 3, "Soul_OnKilledTarget")
RegisterUnitEvent(20512, 4, "Soul_OnDied")

function Tyrantus_OnCombat(Unit, Event)
Unit:RegisterEvent("Tyrantus_Wood", 7000, 0)
Unit:RegisterEvent("Tyrantus_Fear", 6000, 0)
end

function Tyrantus_Wood(pUnit, Event) 
pUnit:FullCastSpellOnTarget(35321, pUnit:GetMainTank()) 
end

function Tyrantus_Fear(pUnit, Event) 
pUnit:FullCastSpellOnTarget(36629, pUnit:GetClosestPlayer()) 
end

function Tyrantus_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Tyrantus_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Tyrantus_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(20931, 1, "Tyrantus_OnCombat")
RegisterUnitEvent(20931, 2, "Tyrantus_OnLeaveCombat")
RegisterUnitEvent(20931, 3, "Tyrantus_OnKilledTarget")
RegisterUnitEvent(20931, 4, "Tyrantus_OnDied")

function Voidwraith_OnCombat(Unit, Event)
Unit:RegisterEvent("Voidwraith_Spawn", 6000, 0)
Unit:RegisterEvent("Voidwraith_Summon", 15000,0)
end

function Voidwraith_Spawn(pUnit, Event) 
pUnit:CastSpell(34302) 
end

function Voidwraith_Summon(pUnit,Event)
    local x = pUnit:GetX()
	local y = pUnit:GetY()
	local z = pUnit:GetZ()
	local o = pUnit:GetO()
    pUnit:CastSpell(36463)
    pUnit:SpawnCreature(17471, x-1, y, z, o, 14, o)
end

function Voidwraith_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Voidwraith_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Voidwraith_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(18869, 1, "Voidwraith_OnCombat")
RegisterUnitEvent(18869, 2, "Voidwraith_OnLeaveCombat")
RegisterUnitEvent(18869, 3, "Voidwraith_OnKilledTarget")
RegisterUnitEvent(18869, 4, "Voidwraith_OnDied")

function Veronia_OnCombat(Unit, Event)
Unit:RegisterEvent("Veronia_Fight", 8000, 0)
end

function Veronia_Fight(pUnit, Event) 
pUnit:CastSpell(34905) 
end

function Veronia_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Veronia_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Veronia_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(20162, 1, "Veronia_OnCombat")
RegisterUnitEvent(20162, 2, "Veronia_OnLeaveCombat")
RegisterUnitEvent(20162, 3, "Veronia_OnKilledTarget")
RegisterUnitEvent(20162, 4, "Veronia_OnDied")

function Conduit_OnCombat(Unit, Event)
Unit:RegisterEvent("Conduit_Dummy", 9000, 0)
end

function Conduit_Dummy(pUnit, Event) 
pUnit:FullCastSpellOnTarget(36780, pUnit:GetMainTank()) 
end

function Conduit_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Conduit_OnDied(Unit, Event) 
Unit:RemoveEvents()
end



RegisterUnitEvent(20899, 1, "Conduit_OnCombat")
RegisterUnitEvent(20899, 2, "Conduit_OnLeaveCombat")
RegisterUnitEvent(20899, 3, "Conduit_OnKilledTarget")
RegisterUnitEvent(20899, 4, "Conduit_OnDied")

function Waste_OnCombat(Unit, Event)
Unit:RegisterEvent("Waste_Toxic", 3000, 0)
end

function Waste_Toxic(pUnit, Event) 
pUnit:FullCastSpellOnTarget(36519, pUnit:GetMainTank()) 
end

function Waste_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Waste_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Waste_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(20778, 1, "Waste_OnCombat")
RegisterUnitEvent(20778, 2, "Waste_OnLeaveCombat")
RegisterUnitEvent(20778, 3, "Waste_OnKilledTarget")
RegisterUnitEvent(20778, 4, "Waste_OnDied")

function Voidshrieker_OnCombat(Unit, Event)
Unit:RegisterEvent("Voidshrieker_Spawn", 8000, 0)
Unit:RegisterEvent("Voidshrieker_Bolt", 6000, 0)
end

function Voidshrieker_Spawn(pUnit, Event) 
pUnit:CastSpell(34302) 
end

function Voidshrieker_Bolt(pUnit, Event) 
pUnit:FullCastSpellOnTarget(34344, pUnit:GetMainTank()) 
end

function Voidshrieker_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Voidshrieker_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Voidshrieker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(18870, 1, "Voidshrieker_OnCombat")
RegisterUnitEvent(18870, 2, "Voidshrieker_OnLeaveCombat")
RegisterUnitEvent(18870, 3, "Voidshrieker_OnKilledTarget")
RegisterUnitEvent(18870, 4, "Voidshrieker_OnDied")

function Aberration_OnCombat(Unit, Event)
Unit:RegisterEvent("Aberration_Shield", 1000, 1)
Unit:RegisterEvent("Aberration_Storm", 20000, 0)
end

function Aberration_Shield(pUnit, Event) 
pUnit:CastSpell(36640) 
end

function Aberration_Storm(pUnit, Event) 
    local x = pUnit:GetX()
	local y = pUnit:GetY()
	local z = pUnit:GetZ()
	local o = pUnit:GetO()
    pUnit:CastSpell(36577)
    pUnit:SpawnCreature(21322, x-1, y, z, o, 14, o)
end

function Aberration_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Aberration_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Aberration_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(18865, 1, "Aberration_OnCombat")
RegisterUnitEvent(18865, 2, "Aberration_OnLeaveCombat")
RegisterUnitEvent(18865, 3, "Aberration_OnKilledTarget")
RegisterUnitEvent(18865, 4, "Aberration_OnDied")

function Chaser_OnCombat(Unit, Event)
Unit:RegisterEvent("Chaser_Invisible", 15000, 0)
Unit:RegisterEvent("Chaser_Bite", 4000, 0)
Unit:RegisterEvent("Chaser_Warp", 7000, 0)
Unit:RegisterEvent("Chaser_WarpCharge", 5000, 0)
end

function Chaser_Invisible(pUnit, Event) 
pUnit:CastSpell(32943) 
end

function Chaser_Bite(pUnit, Event) 
pUnit:FullCastSpellOnTarget(32739, pUnit:GetMainTank()) 
end

function Chaser_Warp(pUnit, Event) 
pUnit:CastSpell(32920) 
end

function Chaser_WarpCharge(pUnit, Event) 
pUnit:FullCastSpellOnTarget(37417, pUnit:GetMainTank()) 
end

function Chaser_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Chaser_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Chaser_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(18884, 1, "Chaser_OnCombat")
RegisterUnitEvent(18884, 2, "Chaser_OnLeaveCombat")
RegisterUnitEvent(18884, 3, "Chaser_OnKilledTarget")
RegisterUnitEvent(18884, 4, "Chaser_OnDied")

function Icoshock_OnCombat(Unit, Event)
Unit:RegisterEvent("Icoshock_Surge", 7000, 0)
Unit:RegisterEvent("Icoshock_Drain", 1000, 1)
end

function Icoshock_Surge(pUnit, Event) 
pUnit:FullCastSpellOnTarget(36517, pUnit:GetMainTank()) 
end

function Icoshock_Drain(pUnit, Event) 
pUnit:CastSpell(36515) 
end

function Icoshock_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Icoshock_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Icoshock_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(20770, 1, "Icoshock_OnCombat")
RegisterUnitEvent(20770, 2, "Icoshock_OnLeaveCombat")
RegisterUnitEvent(20770, 3, "Icoshock_OnKilledTarget")
RegisterUnitEvent(20770, 4, "Icoshock_OnDied")

function Monstrosity_OnCombat(Unit, Event)
Unit:RegisterEvent("Monstrosity_Arcane", 6000, 0)
Unit:RegisterEvent("Monstrosity_Storm", 20000, 0)
end

function Monstrosity_Arcane(pUnit, Event) 
pUnit:FullCastSpellOnTarget(13901, pUnit:GetMainTank()) 
end

function Monstrosity_Storm(pUnit, Event) 
    local x = pUnit:GetX()
	local y = pUnit:GetY()
	local z = pUnit:GetZ()
	local o = pUnit:GetO()
    pUnit:CastSpell(36577)
    pUnit:SpawnCreature(21322, x-1, y, z, o, 14, o)
end

function Monstrosity_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Monstrosity_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Monstrosity_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(20516, 1, "Monstrosity_OnCombat")
RegisterUnitEvent(20516, 2, "Monstrosity_OnLeaveCombat")
RegisterUnitEvent(20516, 3, "Monstrosity_OnKilledTarget")
RegisterUnitEvent(20516, 4, "Monstrosity_OnDied")

function Engineer_OnCombat(Unit, Event)
Unit:RegisterEvent("Engineer_Swipe", 6000, 0)
end

function Engineer_Swipe(pUnit, Event) 
pUnit:FullCastSpellOnTarget(35147, pUnit:GetMainTank()) 
end

function Engineer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Engineer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Engineer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(20404, 1, "Engineer_OnCombat")
RegisterUnitEvent(20404, 2, "Engineer_OnLeaveCombat")
RegisterUnitEvent(20404, 3, "Engineer_OnKilledTarget")
RegisterUnitEvent(20404, 4, "Engineer_OnDied")

function Nesaad_OnCombat(Unit, Event)
Unit:RegisterEvent("Nesaad_Flux", 7000, 0)
end

function Nesaad_Flux(pUnit, Event) 
pUnit:CastSpell(35924) 
end

function Nesaad_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Nesaad_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Nesaad_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(19641, 1, "Nesaad_OnCombat")
RegisterUnitEvent(19641, 2, "Nesaad_OnLeaveCombat")
RegisterUnitEvent(19641, 3, "Nesaad_OnKilledTarget")
RegisterUnitEvent(19641, 4, "Nesaad_OnDied")

function Corpse_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Corpse_Rend",15000,0)
    pUnit:RegisterEvent("Corpse_Parasite_Spell",6000,0)
    pUnit:RegisterEvent("Corpse_Parasite_Spawn",36000,0)
end

function Corpse_Rend(pUnit,Event)
    pUnit:FullCastSpellOnTarget(13443,pUnit:GetMainTank())
end

function Corpse_Parasite_Spell(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36469,pUnit:GetRandomPlayer(0))
end

function Corpse_Parasite_Spawn(pUnit,Event)
    local x = pUnit:GetX()
	local y = pUnit:GetY()
	local z = pUnit:GetZ()
	local o = pUnit:GetO()
    pUnit:CastSpell(36468)
    pUnit:SpawnCreature(21265, x-1, y, z, o, 14, o)
end

function Corpse_OnLeaveCombat(pUnit,Event)
    pUnit:RemoveEvents()
end

function Corpse_OnKilledTarget(pUnit,Event)
    pUnit:RemoveEvents()
end

function Corpse_OnDied(pUnit,Event)
    pUnit:RemoveEvents()
end

RegisterUnitEvent(20561,1,"Corpse_OnEnterCombat")
RegisterUnitEvent(20561,2,"Corpse_OnLeaveCombat")
RegisterUnitEvent(20561,3,"Corpes_OnKilledTarget")
RegisterUnitEvent(20561,4,"Corpse_OnDied")

function Lord_OnCombat(Unit, Event)
Unit:RegisterEvent("Lord_Cleave", 6000, 0)
end

function Lord_Cleave(pUnit, Event) 
pUnit:FullCastSpellOnTarget(15496, pUnit:GetMainTank()) 
end

function Lord_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Lord_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Lord_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(20929, 1, "Lord_OnCombat")
RegisterUnitEvent(20929, 2, "Lord_OnLeaveCombat")
RegisterUnitEvent(20929, 3, "Lord_OnKilledTarget")
RegisterUnitEvent(20929, 4, "Lord_OnDied")

function Priestess_OnCombat(Unit, Event)
Unit:RegisterEvent("Priestess_Rain", 9000, 0)
end

function Priestess_Rain(pUnit, Event) 
pUnit:CastSpell(34017) 
end

function Priestess_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Priestess_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Priestess_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(18859, 1, "Priestess_OnCombat")
RegisterUnitEvent(18859, 2, "Priestess_OnLeaveCombat")
RegisterUnitEvent(18859, 3, "Priestess_OnKilledTarget")
RegisterUnitEvent(18859, 4, "Priestess_OnDied")

function Laztarash_OnCombat(Unit, Event)
Unit:RegisterEvent("Laztarash_Hamstring", 8000, 0)
end

function Laztarash_Hamstring(pUnit, Event) 
pUnit:FullCastSpellOnTarget(31553, pUnit:GetMainTank()) 
end

function Laztarash_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Laztarash_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Laztarash_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(20789, 1, "Laztarash_OnCombat")
RegisterUnitEvent(20789, 2, "Laztarash_OnLeaveCombat")
RegisterUnitEvent(20789, 3, "Laztarash_OnKilledTarget")
RegisterUnitEvent(20789, 4, "Laztarash_OnDied")

function Raider_OnCombat(Unit, Event)
Unit:RegisterEvent("Raider_Energy", 8000, 0)
end

function Raider_Energy(pUnit, Event) 
pUnit:CastSpell(35922) 
end

function Raider_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Raider_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Raider_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(18875, 1, "Raider_OnCombat")
RegisterUnitEvent(18875, 2, "Raider_OnLeaveCombat")
RegisterUnitEvent(18875, 3, "Raider_OnKilledTarget")
RegisterUnitEvent(18875, 4, "Raider_OnDied")

function Stalker_OnCombat(Unit, Event)
Unit:RegisterEvent("Stalker_Backstab", 6000, 0)
Unit:RegisterEvent("Stalker_Warp", 8000, 0)
end

function Stalker_Backstab(pUnit, Event) 
pUnit:FullCastSpellOnTarget(7159, pUnit:GetMainTank()) 
end

function Stalker_Warp(pUnit, Event) 
pUnit:CastSpell(32920) 
end

function Stalker_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Stalker_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Stalker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(19642, 1, "Stalker_OnCombat")
RegisterUnitEvent(19642, 2, "Stalker_OnLeaveCombat")
RegisterUnitEvent(19642, 3, "Stalker_OnKilledTarget")
RegisterUnitEvent(19642, 4, "Stalker_OnDied")

function Apex_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Apex_Thunderclap",1000,0)
end

function Apex_Thunderclap(pUnit,Event)
    pUnit:FullCastSpellOnTraget(8078, pUnit:GetClosestPlayer())
end

function Apex_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Apex_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (19940, 1, "Apex_OnEnterCombat")
RegisterUnitEvent (19940, 2, "Apex_OnLeaveCombat")
RegisterUnitEvent (19940, 4, "Apex_OnDied")

function Annihilator_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Annihilator_Explosion",1500,0)
    pUnit:RegisterEvent("Annihilator_Suppression",3000,0)
end

function Annihilator_Explosion(pUnit,Event)
    pUnit:FullCastSpellOnTarget(33860, pUnit:GetClosestPlayer())
end

function Annihilator_Suppression(pUnit,Event)
    pUnit:FullCastSpellOnTarget(35892, pUnit:GetClosestPlayer())
end

function Annihilator_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Annihilator_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (18856, 1, "Annihilator_OnEnterCombat")
RegisterUnitEvent (18856, 2, "Annihilator_OnLeaveCombat")
RegisterUnitEvent (18856, 4, "Annihilator_OnDied")

function Bruiser_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Bruiser_Net",1000,0)
end

function Bruiser_Net(pUnit,Event)
    pUnit:FullCastSpellOnTarget(12024, pUnit:GetClosestPlayer())
end

function Bruiser_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Bruiser_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20484, 1, "Bruiser_OnEnterCombat")
RegisterUnitEvent (20484, 2, "Bruiser_OnLeaveCombat")
RegisterUnitEvent (20484, 4, "Bruiser_OnDied")

function Machine_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Machine_Rocket",2000,0)
end

function Machine_Rocket(pUnit,Event)
    pUnit:FullCastSpellOnTarget(38083, pUnit:GetClosestPlayer())
end

function Machine_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Machine_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (21976, 1, "Machine_OnEnterCombat")
RegisterUnitEvent (21976, 2, "Machine_OnLeaveCombat")
RegisterUnitEvent (21976, 4, "Machine_OnDied")

function Bruiser_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Bruiser_Net",1000,0)
end

function Bruiser_Net(pUnit,Event)
    pUnit:FullCastSpellOnTarget(12024, pUnit:GetClosestPlayer())
end

function Bruiser_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Bruiser_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20485, 1, "Bruiser_OnEnterCombat")
RegisterUnitEvent (20485, 2, "Bruiser_OnLeaveCombat")
RegisterUnitEvent (20485, 4, "Bruiser_OnDied")

function Bruiser_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Bruiser_Net",1000,0)
end

function Bruiser_Net(pUnit,Event)
    pUnit:FullCastSpellOnTarget(12024,pUnit:GetClosestPlayer())
end

function Bruiser_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Bruiser_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (22494,1,"Bruiser_OnEnterCombat")
RegisterUnitEvent (22494,2,"Bruiser_OnLeaveCombat")
RegisterUnitEvent (22494,4,"Bruiser_OnDied")

function Cragskaar_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Cragskaar_Knock",45000,0)
end

function Cragskaar_Knock(pUnit,Event)
    pUnit:FullCastSpellOnTarget(32959, pUnit:GetClosestPlayer())
end

function Cragskaar_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Cragskaar_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20202, 1, "Cragskaar_OnEnterCombat")
RegisterUnitEvent (20202, 2, "Cragskaar_OnLeaveCombat")
RegisterUnitEvent (20202, 4, "Cragskaar_OnDied")

function Punisher_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Punisher_Explosion",1500,0)
    pUnit:RegisterEvent("Punisher_Suppression",3000,0)
end

function Punisher_Explosion(pUnit,Event)
    pUnit:FullCastSpellOnTarget(33860,pUnit:GetClosestPlayer())
end

function Punisher_Suppression(pUnit,Event)
    pUnit:FullCastSpellOnTarget(35892,pUnit:GetClosestPlayer())
end

function Punisher_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Punisher_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (18698, 1, "Punisher_OnEnterCombat")
RegisterUnitEvent (18698, 2, "Punisher_OnLeaveCombat")
RegisterUnitEvent (18698, 4, "Punisher_OnDied")

function Morug_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Morug_Blade",1500,0)
    pUnit:RegisterEvent("Morug_Spray",1000,0)
end

function Morug_Blade(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36228,pUnit:GetClosestPlayer())
end

function Morug_Spray(pUnit,Event)
    pUnit:FullCastSpellOnTarget(34261,pUnit:GetClosestPlayer())
end

function Morug_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Morug_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20800, 1, "Morug_OnEnterCombat")
RegisterUnitEvent (20800, 2, "Morug_OnLeaveCombat")
RegisterUnitEvent (20800, 4, "Morug_OnDied")

function Kaylannl_OnEnterCombat(pUnit,Event)
    if pUnit:GetHealthPct() == 99 then
    pUnit:RegisterEvent("Kaylannl_Phase1",1000,0)
end
end
    
function Kaylannl_Phase1(pUnit,Event)
    pUnit:RegisterEvent("Kaylaanl_Ressurection",15000,0)
    pUnit:RegisterEvent("Kaylaanl_Shield",18000,0)
    pUnit:RegisterEvent("Kaylannl_Light",5000,0)
    pUnit:RegisterEvent("Kaylannl_Power",6000,0)
    pUnit:RegisterEvent("Kaylannl_Consecration",6000,0)
    pUnit:RegisterEvent("Kaylannl_Shield2",25000,0)
    pUnit:RegisterEvent("Kaylannl_Heal",7000,0)
    pUnit:RegisterEvent("Kaylannl_Slam",7000,0)
    pUnit:RegisterEvent("Kaylannl_Wrath",25000,0)
    pUnit:RegisterEvent("Kaylannl_Despawn",1000,0)
end

function Kaylannl_Ressurection(pUnit,Event)
    pUnit:FullCastSpellOnTarget(35599,pUnit:GetRandomFriend(0))
end

function Kaylannl_Shield(pUnit,Event)
    pUnit:FullCastSpellOnTarget(37554,pUnit:GetRandomPlayer(0))
end

function Kaylannl_Light(pUnit,Event)
    pUnit:FullCastSpellOnTarget(37552,pUnit:GetMainTank())
end

function Kaylannl_Power(pUnit,Event)
    local plr = pUnit:GetRandomPlayer(0)
		if plr ~= nil then
			pUnit:ChannelSpell(plr:GetGUID(),35597)
    end
end

function Kaylannl_Consecration(pUnit,Event)
    pUnit:CastSpell(37553)
end

function Kaylannl_Shield2(pUnit,Event)
    pUnit:CastSpell(13874)
end

function Kaylannl_Heal(pUnit,Event)
    pUnit:CastSpellOnTarget(37569,pUnit:GetRandomFriend(0))
end

function Kaylannl_Slam(pUnit,Event)
    pUnit:FullCastSpellOnTarget(37572,pUnit:GetMainTank())
end

function Kaylannl_Wrath(pUnit,Event)
    pUnit:FullCastSpellOnTarget(35614,pUnit:GetRandomPlayer(0))
end

function Kaylannl_Despawn(pUnit,Event)
    if pUnit:GetHealthPct() == 25 then
    pUnit:Despawn(5000)
    local x = pUnit:GetX()
	local y = pUnit:GetY()
	local z = pUnit:GetZ()
	local o = pUnit:GetO()
    pUnit:SpawnCreature(20132, x-1, y, z, o, 14, o)
end
end

function Kaylannl_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Kaylannl_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20794, 1, "Kaylannl_OnEnterCombat")
RegisterUnitEvent (20794, 2, "Kaylannl_OnLeaveCombat")
RegisterUnitEvent (20794, 4, "Kaylannl_OnDied")

function Naberius_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Naberius_Nova",1000,0)
    pUnit:RegisterEvent("Naberius_Bolt",3000,0)
end

function Naberius_Nova(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36148,pUnit:GetClosestPlayer())
end

function Naberius_Bolt(pUnit,Event)
    pUnit:FullCastSpellOnTarget(15497,pUnit:GetClosestPlayer())
end

function Naberius_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Naberius_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20483, 1, "Naberius_OnEnterCombat")
RegisterUnitEvent (20483, 2, "Naberius_OnLeaveCombat")
RegisterUnitEvent (20483, 4, "Naberius_OnDied")

function Negatron_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Negatron_Charge",1000,(1))
    pUnit:RegisterEvent("Negatron_Demolish",1000,0)
    pUnit:RegisterEvent("Negatron_Quake",1000,0)
    pUnit:RegisterEvent("Negatron_Enrage",1000,0)
end

function Negatron_Charge(pUnit,Event)
    pUnit:FullCastSpellOnTarget(35570,pUnit:GetClosestPlayer())
end

function Negatron_Demolish(pUnit,Event)
    pUnit:FullCastSpellOnTarget(34625,pUnit:GetClosestPlayer())
end

function Negatron_Quake(pUnit,Event)
    pUnit:FullCastSpellOnTarget(35565,pUnit:GetClosestPlayer())
end

function Negatron_Enrage(pUnit,Event)
    pUnit:CastSpell(34624)
end

function Negatron_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Negatron_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (19851, 1, "Negatron_OnEnterCombat")
RegisterUnitEvent (19851, 2, "Negatron_OnLeaveCombat")
RegisterUnitEvent (19851, 4, "Negatron_OnDied")

function Guard_OnCombat(pUnit, Event)
pUnit:RegisterEvent("Guard_Cleave", 5000, 0)
pUnit:RegisterEvent("Guard_Hamstring", 6000, 0)
pUnit:RegisterEvent("Guard_Mortal_Strike", 7000, 0)
end

function Guard_OnLeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
end

function Guard_OnKillTarget(pUnit, Event)
pUnit:RemoveEvents()
end

function Guard_OnDeath(pUnit, Event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(19529, 1, "Guard_OnCombat")
RegisterUnitEvent(19529, 2, "Guard_OnLeaveCombat")
RegisterUnitEvent(19529, 3, "Guard_OnKillTarget")
RegisterUnitEvent(19529, 4, "Guard_OnDeath")

function Guard_Cleave(pUnit, Event)
pUnit:FullCastSpellOnTarget(15284, GetMainTank())
end

function Guard_Hamstring(pUnit, Event)
pUnit:FullCastSpellOnTarget(9080, GetMainTank())
end

function Guard_Mortal_Strike(pUnit, Event)
pUnit:FullCastSpellOnTarget(16856, GetMainTank())
end

function Agent_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Agent_Shoot",1000,0)
end

function Agent_Shoot(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36246,pUnit:GetClosestPlayer())
end

function Agent_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Agent_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (19541, 1, "Agent_OnEnterCombat")
RegisterUnitEvent (19541, 2, "Agent_OnLeaveCombat")
RegisterUnitEvent (19541, 4, "Agent_OnDied")

function King_OnEnterCombat(pUnit,Event)
    if Unit:GetHealthPct() == 99 then
    pUnit:RegisterEvent("King_Phase1",1000,0)
end
end

function King_Phase1(pUnit,Event)
    pUnit:RegisterEvent("King_Damagebuff",1000,(1))
    pUnit:RegisterEvent("King_Gravity",2500,0)
    pUnit:RegisterEvent("King_Statis",12000,0)
    pUnit:RegisterEvent("King_Phase2",1000,0)
end

function King_Dambagebuff(pUnit,Event)
    pUnit:CastSpell(37075)
end   
   
function King_Gravity(pUnit,Event)
    pUnit:CastSpell(36533)
end

function King_Statis(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36527,pUnit:GetRandomPlayer(0))
    pUnit:FullCastSpellOnTarget(36527,pUnit:GetRandomPlayer(0))
end

function King_Phase2(pUnit,Event)
    if pUnit:GetHealthPct() == 50 then
    pUnit:RegisterEvent("King_Damagebuff",1000,(1))
    pUnit:RegisterEvent("King_Gravity",2500,0)
    pUnit:RegisterEvent("King_Statis",6000,0)
    pUnit:RegisterEvent("King_Mirror1",1000,(1))
    pUnit:RegisterEvent("King_Mirror2",1000,(1))
end
end
    

function King_Mirror1(pUnit,Event)
    local x = pUnit:GetX()
	local y = pUnit:GetY()
	local z = pUnit:GetZ()
	local o = pUnit:GetO()
    pUnit:CastSpell(36847)
    pUnit:SpawnCreature(21425, x-1, y, z, o, 14, o)
end

function King_Mirror2(pUnit,Event)
    local x = pUnit:GetX()
	local y = pUnit:GetY()
	local z = pUnit:GetZ()
	local o = pUnit:GetO()
    pUnit:CastSpell(36848)
    pUnit:SpawnCreature(21425, x-1, y, z, o, 14, o)
end
    
function King_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function King_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20454, 1, "King_OnEnterCombat")
RegisterUnitEvent (20454, 2, "King_OnLeaveCombat")
RegisterUnitEvent (20454, 4, "King_OnDied")

function Silroth_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Silroth_Flames1",10000,0)
    pUnit:RegisterEvent("Silroth_Flames2",2000,0)
end

function Silroth_Flames1(pUnit,Event)
    pUnit:CastSpell(36253)
end   

function Silroth_Flames2(pUnit,Event)
    pUnit:FullCastSpellOnTarget(36252,pUnit:GetMainTank())
end

function Silroth_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Silroth_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20801, 1, "Silroth_OnEnterCombat")
RegisterUnitEvent (20801, 2, "Silroth_OnLeaveCombat")
RegisterUnitEvent (20801, 4, "Silroth_OnDied")

function Socrethar_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Socrethar_Shield",10000,0)
    pUnit:RegisterEvent("Socrethar_Backslash",5000,0)
    pUnit:RegisterEvent("Socrethar_Cleave",6000,0)
    pUnit:RegisterEvent("Socrethar_Barrage",10000,0)
    pUnit:RegisterEvent("Socrethar_Protection",1000,(1))
    pUnit:RegisterEvent("Socrethar_Bolt",3000,0)
end

function Socrethar_Shield(pUnit,Event)
    pUnit:CastSpell(37538)
end

function Socrethar_Backslash(pUnit,Event)
    pUnit:FullCastSpellOnTarget(37537,pUnit:GetRandomPlayer(0))
end

function Socrethar_Cleave(pUnit,Event)
    pUnit:FullCastSpellOnTarget(15496,pUnit:GetMainTank())
end

function Socrethar_Barrage(pUnit,Event)
    pUnit:CastSpell(37541)
    local plr = pUnit:GetRandomPlayer()
    if plr ~= nil then
    pUnit:ChannelSpell(plr:GetGUID(),37540)
end
end

function Socrethar_Protection(pUnit,Event)
    pUnit:CastSpell(37539)
end

function Socrethar_Bolt(pUnit,Event)
    pUnit:FullCastSpellOnTarget(28448,pUnit:GetRandomPlayer(0))
end

function Socrethar_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Socrethar_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20132, 1, "Socrethar_OnEnterCombat")
RegisterUnitEvent (20132, 2, "Socrethar_OnLeaveCombat")
RegisterUnitEvent (20132, 4, "Socrethar_OnDied")

function Nuramoc_OnEnterCombat(pUnit,Event)
    pUnit:RegisterEvent("Nuramoc_Lightning",2000,0)
    pUnit:RegisterEvent("Nuramoc_Bolt",4000,0)
    pUnit:RegisterEvent("Nuramoc_Shield",5000,0)
end

function Nuramoc_Lightning(pUnit,Event)
    pUnit:FullCastSpellOnTarget(15797,pUnit:GetClosestPlayer())
end   
   
function Nuramoc_Bolt(pUnit,Event)
    pUnit:FullCastSpellOnTarget(21971,pUnit:GetClosestPlayer())
end

function Nuramoc_Shield(pUnit,Event)
    pUnit:CastSpell(38905)
end
    
function Nuramoc_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Nuramoc_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (20932, 1, "Nuramoc_OnEnterCombat")
RegisterUnitEvent (20932, 2, "Nuramoc_OnLeaveCombat")
RegisterUnitEvent (20932, 4, "Nuramoc_OnDied")

function Adal_OnCombat(Unit, Event)
Unit:RegisterEvent("Adal_Ultimate", 1000, 1)
end

function Adal_Ultimate(pUnit, Event) 
pUnit:CastSpell(35076) 
end

function Adal_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Adal_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Adal_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(18481, 1, "Adal_OnCombat")
RegisterUnitEvent(18481, 2, "Adal_OnLeaveCombat")
RegisterUnitEvent(18481, 3, "Adal_OnKilledTarget")
RegisterUnitEvent(18481, 4, "Adal_OnDied")

function Lightwarden_OnCombat(Unit, Event)
Unit:RegisterEvent("Lightwarden_Strike", 6000, 0)
Unit:RegisterEvent("Lightwarden_Hammer", 1000, 0)
Unit:RegisterEvent("Lightwarden_Heal", 7000, 0)
end

function Lightwarden_Strike(pUnit, Event) 
pUnit:FullCastSpellOnTarget(14518, pUnit:GetMainTank()) 
end

function Lightwarden_Hammer(pUnit, Event) 
pUnit:FullCastSpellOnTarget(13005, pUnit:GetMainTank()) 
end

function Lightwarden_Heal(pUnit, Event) 
pUnit:CastSpell(13952) 
end

function Lightwarden_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Lightwarden_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Lightwarden_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(18537, 1, "Lightwarden_OnCombat")
RegisterUnitEvent(18537, 2, "Lightwarden_OnLeaveCombat")
RegisterUnitEvent(18537, 3, "Lightwarden_OnKilledTarget")
RegisterUnitEvent(18537, 4, "Lightwarden_OnDied")

function Vindicator_OnCombat(Unit, Event)
Unit:RegisterEvent("Vindicator_Banish", 7000, 0)
end

function Vindicator_Banish(pUnit, Event) 
pUnit:FullCastSpellOnTarget(36642, pUnit:GetMainTank()) 
end

function Vindicator_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Vindicator_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Vindicator_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(18549, 1, "Vindicator_OnCombat")
RegisterUnitEvent(18549, 2, "Vindicator_OnLeaveCombat")
RegisterUnitEvent(18549, 3, "Vindicator_OnKilledTarget")
RegisterUnitEvent(18549, 4, "Vindicator_OnDied")

function Terokk_OnCombat(Unit, Event)
Unit:RegisterEvent("Terokk_Charge", 1000, 1)
Unit:RegisterEvent("Terokk_Burst", 6000, 0)
end

function Terokk_Charge(pUnit, Event) 
pUnit:FullCastSpellOnTarget(24193, pUnit:GetMainTank()) 
end

function Terokk_Burst(pUnit, Event) 
pUnit:FullCastSpellOnTarget(39068, pUnit:GetMainTank()) 
end

function Terokk_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Terokk_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Terokk_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(22375, 1, "Terokk_OnCombat")
RegisterUnitEvent(22375, 2, "Terokk_OnLeaveCombat")
RegisterUnitEvent(22375, 3, "Terokk_OnKilledTarget")
RegisterUnitEvent(22375, 4, "Terokk_OnDied")

function Bodyguard_OnCombat(Unit, Event)
Unit:RegisterEvent("Bodyguard_Demoralize", 10000, 0)
Unit:RegisterEvent("Bodyguard_Rend", 6000, 0)
end

function Bodyguard_Demoralize(pUnit, Event) 
pUnit:FullCastSpellOnTarget(13730, pUnit:GetClosestPlayer()) 
end

function Bodyguard_Rend(pUnit, Event) 
pUnit:FullCastSpellOnTarget(11977, pUnit:GetMainTank()) 
end

function Bodyguard_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Bodyguard_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Bodyguard_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(18483, 1, "Bodyguard_OnCombat")
RegisterUnitEvent(18483, 2, "Bodyguard_OnLeaveCombat")
RegisterUnitEvent(18483, 3, "Bodyguard_OnKilledTarget")
RegisterUnitEvent(18483, 4, "Bodyguard_OnDied")

function Petrifier_OnCombat(Unit, Event)
Unit:RegisterEvent("Petrifier_Glare", 10000, 0)
end

function Petrifier_Glare(pUnit, Event) 
pUnit:FullCastSpellOnTarget(32905, pUnit:GetMainTank()) 
end

function Petrifier_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Petrifier_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Petrifier_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(21854, 1, "Petrifier_OnCombat")
RegisterUnitEvent(21854, 2, "Petrifier_OnLeaveCombat")
RegisterUnitEvent(21854, 3, "Petrifier_OnKilledTarget")
RegisterUnitEvent(21854, 4, "Petrifier_OnDied")

function MTerokk_OnCombat(Unit, Event)
Unit:RegisterEvent("MTerokk_Dmg", 7000, 0)
end

function MTerokk_Dmg(pUnit, Event) 
pUnit:FullCastSpellOnTarget(38021, pUnit:GetMainTank()) 
end

function MTerokk_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function MTerokk_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function MTerokk_OnKilledTarget(Unit, Event) 
Unit:RemoveEvents()
end

RegisterUnitEvent(22376, 1, "MTerokk_OnCombat")
RegisterUnitEvent(22376, 2, "MTerokk_OnLeaveCombat")
RegisterUnitEvent(22376, 3, "MTerokk_OnKilledTarget")
RegisterUnitEvent(22376, 4, "MTerokk_OnDied")

function Drunk_OnCombat(Unit, Event)
Unit:RegisterEvent("Drunk_Knock", 8000, 0)
end

function Drunk_Knock(pUnit, Event) 
pUnit:FullCastSpellOnTarget(10966, pUnit:GetMainTank()) 
end

function Drunk_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Drunk_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Drunk_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(18585, 1, "Drunk_OnCombat")
RegisterUnitEvent(18585, 2, "Drunk_OnLeaveCombat")
RegisterUnitEvent(18585, 3, "Drunk_OnKilledTarget")
RegisterUnitEvent(18585, 4, "Drunk_OnDied")

function Salsalabim_OnCombat(Unit, Event)
Unit:RegisterEvent("Salsalabim_Pull", 6000, 0)
end

function Salsalabim_Pull(pUnit, Event) 
pUnit:FullCastSpellOnTarget(31705, pUnit:GetMainTank()) 
end

function Salsalabim_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Salsalabim_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Salsalabim_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(18584, 1, "Salsalabim_OnCombat")
RegisterUnitEvent(18584, 2, "Salsalabim_OnLeaveCombat")
RegisterUnitEvent(18584, 3, "Salsalabim_OnKilledTarget")
RegisterUnitEvent(18584, 4, "Salsalabim_OnDied")

function Guardian_OnCombat(Unit, Event)
Unit:RegisterEvent("Guardian_Banish", 10000, 0)
end

function Guardian_Banish(pUnit, Event) 
pUnit:FullCastSpellOnTarget(36671, pUnit:GetMainTank()) 
end

function Guardian_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Guardian_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Guardian_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(18568, 1, "Guardian_OnCombat")
RegisterUnitEvent(18568, 2, "Guardian_OnLeaveCombat")
RegisterUnitEvent(18568, 3, "Guardian_OnKilledTarget")
RegisterUnitEvent(18568, 4, "Guardian_OnDied")

function Peacekeeper_OnCombat(Unit, Event)
Unit:RegisterEvent("Peacekeeper_Block", 5000, 0)
end

function Peacekeeper_Block(pUnit, Event) 
pUnit:CastSpell(12169) 
end

function Peacekeeper_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Peacekeeper_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Peacekeeper_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(19687, 1, "Peacekeeper_OnCombat")
RegisterUnitEvent(19687, 2, "Peacekeeper_OnLeaveCombat")
RegisterUnitEvent(19687, 3, "Peacekeeper_OnKilledTarget")
RegisterUnitEvent(19687, 4, "Peacekeeper_OnDied")

function Kaan_OnCombat(Unit, Event)
Unit:RegisterEvent("Kaan_Banish", 7000, 0)
end

function Kaan_Banish(pUnit, Event) 
pUnit:FullCastSpellOnTarget(36642, pUnit:GetMainTank()) 
end

function Kaan_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Kaan_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Kaan_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(23271, 1, "Kaan_OnCombat")
RegisterUnitEvent(23271, 2, "Kaan_OnLeaveCombat")
RegisterUnitEvent(23271, 3, "Kaan_OnKilledTarget")
RegisterUnitEvent(23271, 4, "Kaan_OnDied")

function AcientShadowmoonSpirit_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("AcientShadowmoonSpirit_Haste", 40000, 0)
	pUnit:RegisterEvent("AcientShadowmoonSpirit_DeathAndDecay", 30000, 0)
	pUnit:RegisterEvent("AcientShadowmoonSpirit_TouchOfDarkness", 15000, 1)
	pUnit:RegisterEvent("AcientShadowmoonSpirit_UnholyArmor", 3000, 0)
end

function AcientShadowmoonSpirit_Haste(pUnit,Event)
	pUnit:CastSpell(37728)
end

function AcientShadowmoonSpirit_DeathAndDecay(pUnit,Event)
	pUnit:FullCastSpellOnTarget(37788,pUnit:GetClosestPlayer())
end

function AcientShadowmoonSpirit_TouchOfDarkness(pUnit,Event)
	pUnit:FullCastSpellOnTarget(37727,pUnit:GetClosestPlayer())
end

function AcientShadowmoonSpirit_UnholyArmor(pUnit,Event)
	pUnit:CastSpell(37729)
end

function AcientShadowmoonSpirit_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function AcientShadowmoonSpirit_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (21797, 1, "AcientShadowmoonSpirit_OnEnterCombat")
RegisterUnitEvent (21797, 2, "AcientShadowmoonSpirit_OnLeaveCombat")
RegisterUnitEvent (21797, 4, "AcientShadowmoonSpirit_OnDied")

function Akama_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("Akama_Lightning", 1540, 0)
end

function Akama_Lightning(pUnit,Event)
	pUnit:FullCastSpellOnTarget(39945,pUnit:GetClosestPlayer())
end

function Akama_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Akama_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (21700, 1, "Akama_OnEnterCombat")
RegisterUnitEvent (21700, 2, "Akama_OnLeaveCombat")
RegisterUnitEvent (21700, 4, "Akama_OnDied")

function Alandien_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("Alandien_ShadowFury", 3000, 0)
	pUnit:RegisterEvent("Alandien_ManaBurn", 3000, 0)
end

function Alandien_ShadowFury(pUnit,Event)
	pUnit:FullCastSpellOnTarget(39082,pUnit:GetClosestPlayer())
end

function Alandien_ManaBurn(pUnit,Event)
	pUnit:FullCastSpellOnTarget(39262,pUnit:GetClosestPlayer())
end

function Alandien_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Alandien_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (21171, 1, "Alandien_OnEnterCombat")
RegisterUnitEvent (21171, 2, "Alandien_OnLeaveCombat")
RegisterUnitEvent (21171, 4, "Alandien_OnDied")

function AltarDefender_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("AltarDefender_Shoot", 11000, 0)
end

function AltarDefender_Shoot(pUnit,Event)
	pUnit:FullCastSpellOnTarget(41440,pUnit:GetClosestPlayer())
end

function AltarDefender_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function AltarDefender_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (23453, 1, "Alandien_OnEnterCombat")
RegisterUnitEvent (23453, 2, "Alandien_OnLeaveCombat")
RegisterUnitEvent (23453, 4, "Alandien_OnDiedCombat")

function AltarOfShatar_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("AltarOfShatar_Net", 20000, 0)
end

function AltarofShatar_Net(pUnit,Event)
	pUnit:FullCastSpellOnTarget(12024,pUnit:GetClosestPlayer())
end

function AltarofShatar_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function AltarofShatar_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (21986, 1, "Alandien_OnEnterCombat")
RegisterUnitEvent (21986, 2, "Alandien_OnLeaveCombat")
RegisterUnitEvent (21986, 4, "Alandien_OnDied")

function Jerrikar_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("Jerrikar_DarkStrike", 4000, 0)
	pUnit:RegisterEvent("Jerrikar_DiplomaticImmunity", 40000, 0)
	pUnit:RegisterEvent("Jerrikar_Silence", 30000, 0)
end

function Jerrikar_Silence(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38913,GetClosestPlayer())
end

function Jerrikar_DarkStrike(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38926,GetClosestPlayer())
end

function Jerrikar_DiplomaticImmunity(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38916,GetClosestPlayer())
end

function Jerrikar_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Jerrikar_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (18695, 1, "Alandien_OnEnterCombat")
RegisterUnitEvent (18695, 2, "Alandien_OnLeaveCombat")
RegisterUnitEvent (18695, 4, "Alandien_OnDied")

function AnchoriteCaalen_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("AnchoriteCaalen_HolySmite", 1540, 0)
	pUnit:RegisterEvent("AnchoriteCaalen_HolySmite", 5000, 0)
end

function AnchoriteCaalen_HolySmite(pUnit,Event)
	pUnit:FullCastSpellOnTarget(36176,pUnit:GetClosestPlayer())
end

function AnchoriteCaalen_GreaterHeal(pUnit,Event)
	pUnit:FullCastSpellOnTarget(35096,pUnit:GetRandomFriend())
end

function AnchoriteCaalen_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function AnchoriteCaalen_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (22862, 1, "Alandien_OnEnterCombat")
RegisterUnitEvent (22862, 2, "Alandien_OnLeaveCombat")
RegisterUnitEvent (22862, 4, "Alandien_OnDied")

function ArcanoScorp_OnEnterCombat(pUnit,Event)
	pUnit:CastSpell(37917) 
	pUnit:CastSpell(37851)
	pUnit:RegisterEvent("ArcanoScorp_DisMantle", 3000, 0)
	pUnit:RegisterEvent("ArcanoScorp_Pince", 6600, 0)
end

function ArcanoScorp_Dismantle(pUnit,Event)
	pUnit:FullCastSpellOnTarget(37919,pUnit:GetClosestPlayer())
end

function ArcanoScorp_Pince(pUnit,Event)
	pUnit:FullCastSpellOnTarget(37918,pUnit:GetClosestPlayer())
end

RegisterUnitEvent (21909, 1, "ArcanoScorp_OnEnterCombat")
RegisterUnitEvent (21909, 2, "ArcanoScorp_OnLeaveCombat")
RegisterUnitEvent (21909, 4, "ArcanoScorp_OnDied")

function Arvoar_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("Arvoar_BellowingRoar", 30000, 0)
	pUnit:RegisterEvent("Arvoar_Rend", 20000, 0)
	pUnit:RegisterEvent("Arvoar_RockShell", 33000, 0)
end

function Arvoar_BellowingRoar(pUnit,Event)
	pUnit:FullCastSpellOnTarget(40636,pUnit:GetClosestPlayer())
end

function Arvoar_Rend(pUnit,Event)
	pUnit:FullCastSpellOnTarget(13443,pUnit:GetClosestPlayer())
end

function Arvoar_RockShell(pUnit,Event)
	pUnit:CastSpell(33810)
end

function Arvoar_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Arvoar_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (23267, 1, "Arvoar_OnEnterCombat")
RegisterUnitEvent (23267, 2, "Arvoar_OnLeaveCombat")
RegisterUnitEvent (23267, 4, "Arvoar_OnDied")

function Asghar_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("Asghar_Cleave", 3300, 0)
	pUnit:RegisterEvent("Asghar_DarkMending", 15000, 0)
end

function Asghar_Cleave(pUnit,Event)
	pUnit:FullCastSpellOnTarget(15496,pUnit:GetClosestPlayer())
end

function Asghar_DarkMending(pUnit,Event)
	pUnit:CastSpell(16588)
end

function Asghar_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Asghar_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (22025, 1, "Asgarhar_OnEnterCombat")
RegisterUnitEvent (22025, 2, "Asgarhar_OnLeaveCombat")
RegisterUnitEvent (22025, 4, "Asgarhar_OnDied")

function AshtongueShaman_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("AshtongueShaman_Bloodlust", 60000, 0)
	pUnit:RegisterEvent("AshtongueShaman_LightningShield", 60000, 0)
end

function AshtongueShaman_Bloodlust(pUnit,Event)
	pUnit:CastSpell(37067)
end

function AshtongueShaman_LightningShield(pUnit,Event)
	pUnit:CastSpell(12550)
end

function AshtongueShaman_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function AshtongueShaman_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (21453, 1, "AshtongueShaman_OnEnterCombat")
RegisterUnitEvent (21453, 2, "AshtongueShaman_OnLeaveCombat")
RegisterUnitEvent (21453, 4, "AshtongueShaman_OnDied")

function AshtongueWorker_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("AshtongueWorker_PierceArmor", 45000, 0)
end

function AshtongueWorker_PierceArmor(pUnit,Event)
	pUnit:FullCastSpellOnTarget(6016,pUnit:GetClosestPlayer())
end

function AshtongueWorker_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function AshtongueWorker_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (21455, 1, "AshtongueWorker_OnEnterCombat")
RegisterUnitEvent (21455, 2, "AshtongueWorker_OnLeaveCombat")
RegisterUnitEvent (21455, 4, "AshtongueWorker_OnDied")

function Azaloth_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("Azaloth_RainOfFire", 30000, 0)
	pUnit:RegisterEvent("Azaloth_Cleave", 60000, 0)
	pUnit:RegisterEvent("Azaloth_Cripple", 20000, 0)
	pUnit:RegisterEvent("Azaloth_WarStomp", 13000, 0)
end

function Azaloth_RainOfFire(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38741,pUnit:GetClosestPlayer())
end

function Azaloth_Cleave(pUnit,Event)
	pUnit:FullCastSpellOnTarget(40504,pUnit:GetClosestPlayer())
end


function Azaloth_Cripple(pUnit,Event)
	pUnit:FullCastSpellOnTarget(11443,pUnit:GetClosestPlayer())
end


function Azaloth_WarStomp(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38750,pUnit:GetClosestPlayer())
end

function Azaloth_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Azaloth_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21506, 1, "Azaloth_OnEnterCombat")
RegisterUnitEvent(21506, 2, "Azaloth_OnLeaveCombat")
RegisterUnitEvent(21506, 4, "Azaloth_OnDied")

function Barash_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("Barash_RockShell", 11000, 0)
	pUnit:RegisterEvent("Barash_BellowingRoar", 40000, 0)
	pUnit:RegisterEvent("Barash_Rend", 5000, 0)
end

function Barash_RockShell(pUnit,Event)
	pUnit:FullCastSpellOnTarget(33810,pUnit:GetClosestPlayer())
end

function Barash_BellowingRoar(pUnit,Event)
	pUnit:FullCastSpellOnTarget(40636,pUnit:GetClosestPlayer())
end

function Barash_Rend(pUnit,Event)
	pUnit:FullCastSpellOnTarget(13443,pUnit:GetClosestPlayer())
end

function Barash_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Barash_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(23269, 1, "Barash_OnEnterCombat")
RegisterUnitEvent(23269, 2, "Barash_OnLeaveCombat")
RegisterUnitEvent(23269, 4, "Barash_OnDied")

function BatRiderGuard_OnEnterCombat(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38066,pUnit:GetClosestPlayer())
	pUnit:RegisterEvent("BatRiderGuard_Spell", 25000, 0)
end

function BatRiderGuard_Spell(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38066,pUnit:GetClosestPlayer())
end

function BatRiderGuard_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function BatRiderGuard_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(15242, 1, "BatRiderGuard_OnEnterCombat")
RegisterUnitEvent(15242, 2, "BatRiderGuard_OnLeaveCombat")
RegisterUnitEvent(15242, 4, "BatRiderGuard_OnDied")

function BBOD_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("BBOD_Spell", 60000, 0)
end

function BBOD_Spell(pUnit,Event)
	pUnit:FullCastSpellOnTarget(7279,pUnit:GetClosestPlayer())
end

function BBOD_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function BBOD_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent (23286, 1, "BBOD_OnEnterCombat")
RegisterUnitEvent (23286, 2, "BBOD_OnLeaveCombat")
RegisterUnitEvent (23286, 4, "BBOD_OnDied")

function BlackCat_OnEnterCombat(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "Meow!")
end

function BlackCat_OnDeath(pUnit,Event)
	pUnit:FullCastSpellOnTarget(39477,pUnit:GetClosestPlayer())
end

RegisterUnitEvent(22816, 1, "BlackCat_OnEnterCombat")
RegisterUnitEvent(22816, 4, "BlackCat_OnDeath")

function BWM_OnEnterCombat(pUnit,Event)
	pUnit:RegisterUnitEvent("BWM_SnapKick", 10000, 0)
end

function BWM_SnapKick(pUnit,Event)
	pUnit:FullCastSpellOnTarget(39477,pUnit:GetClosestPlayer())
end

function BWM_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function BWM_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21245, 1, "BWM_OnEnterCombat")
RegisterUnitEvent(21245, 2, "BWM_OnLeaveCombat")
RegisterUnitEvent(21245, 4, "BWM_OnDied")

function BWMessenger_OnEnterCombat(pUnit,Event)
	pUnit:FullCastSpellOnTarget(35570,pUnit:GetClosestPlayer())
end

RegisterUnitEvent(21244, 1, "BWMessenger_OnEnterCombat")

function Borak_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("Borak_SliceAndDice", 15000, 0)
	pUnit:RegisterEvent("Borak_Eviscerate", 5000, 0)
end

function Borak_SliceAndDice(pUnit,Event)
	pUnit:FullCastSpellOnTarget(30470,pUnit:GetClosestPlayer())
end

function Borak_Eviscerate(pUnit,Event)
	pUnit:FullCastSpellOnTarget(27611,pUnit:GetClosestPlayer())
end

function Borak_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Borak_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21293, 1, "Borak_OnEnterCombat")
RegisterUnitEvent(21293, 2, "Borak_OnLeaveCombat")
RegisterUnitEvent(21293, 4, "Borak_OnDied")

function Bron_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("Bron_ThrowHammer", 15000, 0)
end

function Bron_ThrowHammer(pUnit,Event)
	pUnit:FullCastSpellOnTarget(33822,pUnit:GetClosestPlayer())
end

function Bron_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Bron_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(19395, 1, "Bron_OnEnterCombat")
RegisterUnitEvent(19395, 2, "Bron_OnLeaveCombat")
RegisterUnitEvent(19395, 4, "Bron_OnDied")

function WaterSpirit_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("WaterSpirit_Waterbolt", 4300, 0)
end

function Waterspirit_WaterBolt(pUnit,Event)
	pUnit:FullCastSpellOnTarget(31707,pUnit:GetClosestPlayer())
end

function WaterSpirit_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function WaterSpirit_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21029, 1, "WaterSpirit_OnEnterCombat")
RegisterUnitEvent(21029, 2, "WaterSpirit_OnLeaveCombat")
RegisterUnitEvent(21029, 4, "WaterSpirit_OnDied")

function ChainOfShadows_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("ChainOfShadows_Spell", 5500, 0)
end

function ChainOfShadows_Spell(pUnit,Event)
	pUnit:FullCastSPellOnTarget(37784,pUnit:GetClosestPlayer())
end

function ChainOfShadows_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function ChainOfShadows_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21876, 1, "ChainOfShadows_OnEnterCombat")
RegisterUnitEvent(21876, 2, "ChainOfShadows_OnLeaveCombat")
RegisterUnitEvent(21876, 4, "ChainOfShadows_OnDied")

function ChancellorBloodleaf_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("ChancellorBloodleaf_Spell1", 4000, 0)
	pUnit:RegisterEvent("ChancellorBloodleaf_Spell2", 10000, 0)
end

function ChancellorBloodleaf_Spell1(pUnit,Event)
	pUnit:FullCastSpellOnTarget(34517,pUnit:GetClosestPlayer())
end

function ChancellorBloodleaf_Spell2(pUnit,Event)
	pUnit:FullCastSpellOnTarget(15791,pUnit:GetClosestPlayer())
end

RegisterUnitEvent(22012, 1, "ChancellorBloodleaf_OnEnterCombat")
RegisterUnitEvent(22012, 2, "ChancellorBloodleaf_OnLeaveCombat")
RegisterUnitEvent(22012, 4, "ChancellorBloodleaf_OnDied")

function Cobra_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("Cobra_Spell", 11000, 0)
end

function Cobra_Spell(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38030,pUnit:GetClosestPlayer())
end

function Cobra_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Cobra_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end
RegisterUnitEvent(19784, 1, "Cobra_OnEnterCombat")
RegisterUnitEvent(19784, 2, "Cobra_OnLeaveCombat")
RegisterUnitEvent(19784, 4, "Cobra_OnDied")

function CDefender_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("CDefender_Spell1", 7000, 0)
	pUnit:RegisterEvent("CDefender_Spell2", 16000, 0)
end

function CDefender_Spell1(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38233,pUnit:GetClosestPlayer())
end

function CDefender_Spell2(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38031,pUnit:GetClosestPlayer())
end

function CDefender_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function CDefender_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(19762, 1, "CDefender_OnEnterCombat")
RegisterUnitEvent(19762, 2, "CDefender_OnLeaveCombat")
RegisterUnitEvent(19762, 4, "CDefender_OnDied")

function CMuckwatcher_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("CMuckwatcher_BattleShout", 40000, 0)
end

function CMuckwatcher_BattleShout(pUnit,Event)
	pUnit:CastSpell(38232)
end

function CMuckwatcher_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function CMuckwatcher_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(19788, 1, "CMuckwatcher_OnEnterCombat")
RegisterUnitEvent(19788, 2, "CMuckwatcher_OnLeaveCombat")
RegisterUnitEvent(19788, 4, "CMuckwatcher_OnDied")

function CMyrmidon_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("CMyrmidon_Spell", 120000, 0)
end

function CMyrmidon_Spell(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38027,pUnit:GetClosestPlayer())
end

function CMyrmidon_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function CMyrmidon_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end


RegisterUnitEvent(19765, 1, "CMyrmidon_OnEnterCombat")
RegisterUnitEvent(19765, 2, "CMyrmidon_OnLeaveCombat")
RegisterUnitEvent(19765, 4, "CMyrmidon_OnDied")

function CSiren_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("CSiren_Spell1", 20000, 0)
	pUnit:RegisterEvent("CSiren_Spell2", 6000, 0)
end

function CSiren_Spell1(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38026,pUnit:GetClosestPlayer())
end

function CSiren_Spell2(pUnit,Event)
	pUnit:FullCastSpellOnTarget(32011,pUnit:GetClosestPlayer())
end

function CSiren_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function CSiren_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(19768,1,"CSiren_OnEnterCombat")
RegisterUnitEvent(19768,2,"CSiren_OnLeaveCombat")
RegisterUnitEvent(19768,4,"CSiren_OnDied")

function CSorceress_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("CSiren_Spell1", 20000, 0)
	pUnit:RegisterEvent("CSiren_Spell2", 6000, 0)
end

function CSorceress_Spell1(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38026,pUnit:GetClosestPlayer())
end

function CSorceress_Spell2(pUnit,Event)
	pUnit:FullCastSpellOnTarget(32011,pUnit:GetClosestPlayer())
end

function CSorceress_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function CSorceress_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(19767,1,"CSorceress_OnEnterCombat")
RegisterUnitEvent(19767,2,"CSorceress_OnLeaveCombat")
RegisterUnitEvent(19767,4,"CSorceress_OnDied")

function Collidus_OnEnterCombat(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38932,pUnit:GetClosestPlayer())
	pUnit:FullCastSpellOnTarget(36414,pUnit:GetClosestPlayer())
	pUnit:RegisterEvent("Collidus_FocusedBursts", 40000, 0)
	pUnit:RegisterEvent("Collidus_Scream", 40000, 0)
end

function Collidus_FocusedBursts(pUnit,Event)
	pUnit:FullCastSpellOnTarget(36414,pUnit:GetClosestPlayer())
end

function Collidus_Scream(pUnit,Event)
	pUnit:FullCastSpellOnTarget(34322,pUnit:GetClosestPlayer())
end

function Collidus_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Collidus_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(18694, 1, "Collidus_OnEnterCombat")
RegisterUnitEvent(18694, 2, "Collidus_OnLeaveCombat")
RegisterUnitEvent(18694, 4, "Collidus_OnDied")

function Arcus_OnEnterCombat(pUnit,Event)
	pUnit:FullCastSpellOnTarget(41440,pUnit:GetClosestPlayer())
	pUnit:RegisterEvent("Arcus_Spell1", 10000, 0)
	pUnit:RegisterEvent("Arcus_Spell2", 30000, 0)
end

function Arcus_Spell1(pUnit,Event)
	pUnit:FullCastSpellOnTarget(41448,pUnit:GetClosestPlayer())
end

function Arcus_Spell1(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38370,pUnit:GetClosestPlayer())
end

function Arcus_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Arcus_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(23452, 1, "Arcus_OnEnterCombat")
RegisterUnitEvent(23452, 2, "Arcus_OnLeaveCombat")
RegisterUnitEvent(23452, 4, "Arcus_OnDied")

function Hobb_OnEnterCombat(pUnit,Event)
	pUnit:FullCastSpellOnTarget(41440,pUnit:GetClosestPlayer())
	pUnit:RegisterEvent("Hobb_Spell1", 10000, 0)
	pUnit:RegisterEvent("Hobb_Spell2", 30000, 0)
end

function Hobb_Spell1(pUnit,Event)
	pUnit:FullCastSpellOnTarget(41448,pUnit:GetClosestPlayer())
end

function Hobb_Spell1(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38370,pUnit:GetClosestPlayer())
end

function Hobb_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Hobb_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(23434, 1, "Hobb_OnEnterCombat")
RegisterUnitEvent(23434, 2, "Hobb_OnLeaveCombat")
RegisterUnitEvent(23434, 4, "Hobb_OnDied")

function Corok_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("Corok_Spell1", 11000, 0)
	pUnit:RegisterEvent("Corok_Spell2", 26000, 0)
end

function Corok_Spell1(pUnit,Event)
	pUnit:FullCastSpellOnTarget(12612,pUnit:GetClosestPlayer())
end

function Corok_Spell2(pUnit,Event)
	pUnit:FullCastSpellOnTarget(15550,pUnit:GetClosestPlayer())
end

function Corok_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Corok_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(22011, 1, "Corok_OnEnterCombat")
RegisterUnitEvent(22011, 2, "Corok_OnLeaveCombat")
RegisterUnitEvent(22011, 4, "Corok_OnDied")

function CAE_OnEnterCombat(pUnit,Event)
	pUnit:CastSpell(35194)
	pUnit:RegisterEvent("CAE_LBolt", 5000, 0)
end

function CAE_LBolt(pUnit,Event)
	pUnit:FullCastSpellOnTarget(9532,pUnit:GetClosestPlayer())
end


function CAE_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end


function CAE_OnDiedCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21707, 1, "CAE_OnEnterCombat")
RegisterUnitEvent(21707, 2, "CAE_OnLeaveCombat")
RegisterUnitEvent(21707, 4, "CAE_OnDied")

function CFE_OnEnterCombat(pUnit,Event)
	pUnit:CastSpell(35194)
	pUnit:RegisterEvent("CFE_Fball", 5000, 0)
end

function CFE_Fball(pUnit,Event)
	pUnit:FullCastSpellOnTarget(9053,pUnit:GetClosestPlayer())
end

function CFE_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function CFE_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21706, 1, "CFE_OnEnterCombat")
RegisterUnitEvent(21706, 2, "CFE_OnLeaveCombat")
RegisterUnitEvent(21706, 4, "CFE_OnDied")

function CWE_OnEnterCombat(pUnit,Event)
	pUnit:CastSpell(35194)
	pUnit:RegisterEvent("CWE_FBolt", 5000, 0)
end

function CWE_Fbolt(pUnit,Event)
	pUnit:FullCastSpellOnTarget(9672,pUnit:GetClosestPlayer())
end

function CWE_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function CWE_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21428, 1, "CWE_OnEnterCombat")
RegisterUnitEvent(21428, 2, "CWE_OnLeaveCombat")
RegisterUnitEvent(21428, 4, "CWE_OnDied")

function CMForeman_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("CMForeman_Enrage", 5000, 0)
end

function CMForeman_Enrage(pUnit,Event)
	pUnit:CastSpell(40743)
end

function CMForeman_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function CMForeman_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(23305, 1, "CMForeman_OnEnterCombat")
RegisterUnitEvent(23305, 2, "CMForeman_OnLeaveCombat")
RegisterUnitEvent(23305, 4, "CMForeman_OnDied")

function CMMiner_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("CMMiner_Enrage", 5000, 0)
end

function CMMiner_Enrage(pUnit,Event)
	pUnit:CastSpell(40743)
end

function CMMiner_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function CMMiner_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(23324, 1, "CMMiner_OnEnterCombat")
RegisterUnitEvent(23324, 2, "CMMiner_OnLeaveCombat")
RegisterUnitEvent(23324, 4, "CMMiner_OnDied")

function CShardling_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("CShardling_Enrage", 5000, 0)
end

function CShardling_Enrage(pUnit,Event)
	pUnit:CastSpell(40743)
end

function CShardling_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function CShardling_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21936, 1, "CMMiner_OnEnterCombat")
RegisterUnitEvent(21936, 2, "CMMiner_OnLeaveCombat")
RegisterUnitEvent(21936, 4, "CMMiner_OnDied")

function Cyrukh_OnEnterCombat(pUnit,Event)
	pUnit:GetMainTank()
	pUnit:GetAddTank()
	pUnit:RegisterEvent("Cyrukh_Final", 0001, 0)
	pUnit:RegisterEvent("Cyrukh_Trample", 10000, 0)
	pUnit:RegisterEvent("Cyrukh_KnockAway", 22000, 0)
end

function Cyrukh_Final(pUnit,Event)
 if pUnit:GetHealthPct() == 10 then
	pUnit:RegisterEvent("Cyrukh_FinalSpell",  20000, 0)
end
end

function Cyrukh_FinalSpell(pUnit,Event)
	pUnit:FullCastSpellOnTarget(39429,pUnit:GetMainTank())
end

function Cyrukh_Trample(pUnit,Event)
	pUnit:FullCastSpellOnTarget(39425,pUnit:GetMainTank())
end

function Cyrukh_KnockAway(pUnit,Event)
	pUnit:FullCastSpellOnTarget(18945,pUnit:GetMainTank())
end

function Cyrukh_Death(pUnit,Event)
	pUnit:RemoveEvents()
end

function Cyrukh_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21181, 1, "Cyrukh_OnEnterCombat")
RegisterUnitEvent(21181, 4, "Cyrukh_Death")
RegisterUnitEvent(21181, 2, "Cyrukh_OnLeaveCombat")

function DCHarbinger_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("DCHarbinger_Spell", 13000, 0)
	pUnit:RegisterEvent("DCHarbinger_Heal", 25000, 0)
end

function DCHarbinger_Spell(pUnit,Event)
	pUnit:FullCastSpelOnTarget(15496,pUnit:GetClosestPlayer())
end

function DCHarbinger_Heal(pUnit,Event)
	pUnit:FullCastSpelOnTarget(16588,pUnit:GetRandomFriend())
end

function DCHarbinger_Died(pUnit,Event)
	pUnit:RemoveEvents()
end

function DCHarbinger_LeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21384, 1, "DCHarbinger_OnEnterCombat")
RegisterUnitEvent(21384, 4, "DCHarbinger_Died")
RegisterUnitEvent(21384, 2, "DCHarbinger_LeaveCombat")

function DCHawkeye_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("DCHawkeye_Spell", 32000, 0)
end

function DCHawkeye_Spell(pUnit,Event)
	pUnit:FullCastSpellOnTarget(37974,pUnit:GetClosestPlayer())
end

function DCHawkeye_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function DCHawkeye_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21386, 1, "DCHawkeye_OnEnterCombat")
RegisterUnitEvent(21386, 2, "DCHawkeye_OnLeaveCombat")
RegisterUnitEvent(21386, 4, "DCHawkeye_OnDied")

function DCRavenguard_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("DCRavenguard_Enrage", 120000, 0)
	pUnit:RegisterEvent("DCRavenguard_Howl", 27000, 0)
end

function DCRavenguard_Enrage(pUnit,Event)
	pUnit:FullCastSpellOnTarget(8599,pUnit:GetClosestPlayer())
end

function DCRavenguard_Howl(pUnit,Event)
	pUnit:FullCastSpellOnTarget(23600,pUnit:GetClosestPlayer())
end

function DCRavenguard_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

function DCRavenguard_LeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(19827, 1, "DCRavenguard_OnEnterCombat")
RegisterUnitEvent(19827, 2, "DCRavenguard_LeaveCombat")
RegisterUnitEvent(19827, 4, "DCRavenguard_OnDied")

function DCScorncrow_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("DCScorncrow_FrostBolt", 12000, 0)
end

function DCScorncrow_Frostbolt(pUnit,Event)
	pUnit:FullCastSpellOnTarget(9672,pUnit:GetClosestPlayer())
end


function DCScorncrow_LeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function DCScorncrow_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21385, 1, "DCScorncrow_OnEnterCombat")
RegisterUnitEvent(21385, 2, "DCScorncrow_LeaveCombat")
RegisterUnitEvent(21385, 4, "DCScorncrow_OnDied")

function DCShadowmancer_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("DCShadowmancer_ShadowBolt", 13000, 0)
	pUnit:RegisterEvent("DCShadowmancer_DarkMending", 25000, 0)
end

function DCShadowmancer_ShadowBolt(pUnit,Event)
	pUnit:FullCastSpelOnTarget(9613,pUnit:GetClosestPlayer())
end

function DCShadowmancer_DarkMending(pUnit,Event)
	pUnit:FullCastSpelOnTarget(16588,pUnit:GetRandomFriend())
end

function DCShadowmancer_Died(pUnit,Event)
	pUnit:RemoveEvents()
end

function DCShadowmancer_LeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21384, 1, "DCShadowmancer_OnEnterCombat")
RegisterUnitEvent(21384, 4, "DCShadowmancer_Died")
RegisterUnitEvent(21384, 2, "DCShadowmancer_LeaveCombat")

function DCTalonite_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("DCTalonite_ColdTouch", 18000, 0)
	pUnit:RegisterEvent("DCTalonite_TalonOfJustice", 15000, 0)
end

function DCTalonite_ColdTouch(pUnit,Event)
	pUnit:FullCastSpellOnTarget(39230,pUnit:GetClosestPlayer())
end


function DCTalonite_TalonOfJustice(pUnit,Event)
	pUnit:FullCastSpellOnTarget(39229,pUnit:GetClosestPlayer())
end

function DCTalonite_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

function DCTalonite_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(19825, 1, "DCTalonite_OnEnterCombat")
RegisterUnitEvent(19825, 4, "DCTalonite_OnDied")
RegisterUnitEvent(19825, 2, "DCTalonite_OnLeaveCombat")

function DGuardian_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("DGuardian_Strike", 9000, 0)
	pUnit:RegisterEvent("DGuardian_Bash", 20000, 0)
end

function DGuardian_Strike(pUnit,Event)
	pUnit:FullCastSpellOnTarget(37998,pUnit:GetClosestPlayer())
end

function DGuardian_Bash(pUnit,Event)
	pUnit:FullCastSpellOnTarget(11972,pUnit:GetClosestPlayer())
end

function DGuardian_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

function DGuardian_LeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(20878, 1, "DGuardian_OnEnterCombat")
RegisterUnitEvent(20878, 1, "DGuardian_OnDied")
RegisterUnitEvent(20878, 1, "DGuardian_LeaveCombat")

function Dimp_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("Dimp_Firebolt", 6000, 0)
end

function Dimp_Firebolt(pUnit,Event)
	pUnit:FullCastSpellOnTarget(36227,pUnit:GetClosestPlayer())
end

function Dimp_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

function Dimp_LeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(20887, 1, "Dimp_OnEnterCombat")
RegisterUnitEvent(20887, 2, "Dimp_LeaveCombat")
RegisterUnitEvent(20887, 4, "Dimp_OnDied")

function DInfernal_Yell(pUnit, Event)
	pUnit:RemoveEvents()
	pUnit:CastSpell(36658)
end

function DInfernal_Start(pUnit, Event)
	pUnit:RegisterEvent("DInfernal_Yell", 1000, 0)
end

RegisterUnitEvent(21316, 6, "DInfernal_Start")

function Dmine_OnEnterCombat(pUnit,Event)
	pUnit:GetMainTank()
	pUnit:CastSpell(5)
end

function Dmine_LeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Dmine_OnDied(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38108,pUnit:GetMainTank())
end

RegisterUnitEvent(22315, 2, "Dmine_OnEnterCombat")
RegisterUnitEvent(22315, 2, "Dmine_LeaveCombat")
RegisterUnitEvent(22315, 4, "Dmine_OnDied")

function DSmith_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("DSmith_ChaosNova", 6000, 0)
	pUnit:RegisterEvent("DSmith_DrillArmor", 6000, 0)
end

function DSmith_ChaosNova(pUnit,Event)
	pUnit:FullCastSpellOnTarget(36225,pUnit:GetClosestPlayer())
end

function DSmith_DrillArmor(pUnit,Event)
	pUnit:FullCastSpellOnTarget(37580,pUnit:GetClosestPlayer())
end

function DSmith_LeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function DSmith_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(19756, 1, "DSmith_OnEnterCombat")
RegisterUnitEvent(19756, 2, "DSmith_LeaveCombat")
RegisterUnitEvent(19756, 4, "DSmith_OnDied")

function DSummoner_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("DSummoner_ShadowBolt", 10000, 0)
	pUnit:RegisterEvent("DSummoner_ShadowBolt", 16000, 0)
end

function DSummoner_ShadowBolt(pUnit,Event)
	pUnit:FullCastSpellOnTarget(9613,pUnit:GetClosestPlayer())
end

function DSummoner_FelImmolate(pUnit,Event)
	pUnit:FullCastSpellOnTarget(37628,pUnit:GetClosestPlayer())
end

function DSummoner_OnDeath(pUnit,Event)
	pUnit:RemoveEvents()
end

function DSummoner_LeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(20872, 1, "DSummoner_OnEnterCombat")
RegisterUnitEvent(20872, 2, "DSummoner_LeaveCombat")
RegisterUnitEvent(20872, 4, "DSummoner_OnDeath")

function DTinkerer_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("DTinkerer_Spell", 23000, 0)
end

function DTinkerer_Spell(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38753,pUnit:GetClosestPlayer())
end

function DTinkerer_LeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function DTinkerer_OnDeath(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:CastSpell(38107)
end

RegisterUnitEvent(19754, 1, "DTinkerer_OnEnterCombat")
RegisterUnitEvent(19754, 2, "DTinkerer_LeaveCombat")
RegisterUnitEvent(19754, 4, "DTinkerer_OnDeath")


function DHInitiate_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("DHInitiate_SpellBreaker", 18000, 0)
end

function DHInitiate_SpellBreaker(pUnit,Event)
	pUnit:FullCastSpellOnTarget(35871,pUnit:GetClosestPlayer())
end

function DHInitiate_LeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function DHInitiate_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21180, 1, "DHInitiate_OnEnterCombat")
RegisterUnitEvent(21180, 2, "DHInitiate_LeaveCombat")
RegisterUnitEvent(21180, 4, "DHInitiate_OnDied")

function DHSupplicant_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("DHSupplicant_Spell", 40000, 0)
end

function DHSupplicant_Spell(pUnit,Event)
	pUnit:CastSpell(37683)
end

function DHSupplicant_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

function DHSupplicant_LeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21179, 1, "DHSupplicant_OnEnterCombat")
RegisterUnitEvent(21179, 2, "DHSupplicant_LeaveCombat")
RegisterUnitEvent(21179, 4, "DHSupplicant_OnDied")

function DDPeon_Spell(pUnit, Event)
	pUnit:RemoveEvents()
	pUnit:CastSpell(40732)
	pUnit:RegisterEvent("DDPeon_Spell2", 10000, 0)
end

function DDPeon_Spell2(pUnit, Event)
	pUnit:RemoveEvents()
	pUnit:CastSpell(40735)
	pUnit:RegisterEvent("DDPeon_Spell3", 20000, 0)
end

function DDPeon_Spell3(pUnit, Event)
	pUnit:RemoveEvents()
	pUnit:CastSpell(40714)
	pUnit:RegisterEvent("DDPeon_Spell1", 30000, 0)
end

function DDPeon_Start(pUnit, Event)
	pUnit:RegisterEvent("DDPeon_Spell", 1000, 0)
end

RegisterUnitEvent(21316, 6, "DDPeon_Start")

function DFelboar_OnEnterCombat(pUnit,Event)
	pUnit:CastSpell(36462)
	pUnit:FullCastSpellOnTarget(22120,pUnit:GetClosestPlayer())
end

function DFelboar_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

function DFelboar_LeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21195, 1, "DFelboar_OnEnterCombat")
RegisterUnitEvent(21195, 2, "DFelboar_LeaveCombat")
RegisterUnitEvent(21195, 4, "DFelboar_OnDied")

function DAscendant_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("DAscendant_Cleave", 40000, 0)
	pUnit:RegisterEvent("DAscendant_MortalStrike", 15000, 0)
	pUnit:RegisterEvent("DAscendant_Uppercut", 23000, 0)
end

function DAscendant_Cleave(pUnit,Event)
	pUnit:FullCastSpellOnTarget(15496,pUnit:GetClosestPlayer())
end

function DAscendant_MortalStrike(pUnit,Event)
	pUnit:FullCastSpellOnTarget(17547,pUnit:GetClosestPlayer())
end

function DAscendant_Uppercut(pUnit,Event)
	pUnit:FullCastSpellOnTarget(10966,pUnit:GetClosestPlayer())
end

function DAscendant_LeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function DAscendant_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(22253, 1, "DAscendant_OnEnterCombat")
RegisterUnitEvent(22253, 2, "DAscendant_LeaveCombat")
RegisterUnitEvent(22253, 4, "DAscendant_OnDied")

function DDrakeRider_OnEnterCombat(pUnit,Event)
	pUnit:FullCastSpellOnTarget(6660,pUnit:GetClosestPlayer())
end

function DDrakeRider_LeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function DDrakeRider_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21719, 1, "DDrakeRider_OnEnterCombat")
RegisterUnitEvent(21719, 2, "DDrakeRider_LeaveCombat")
RegisterUnitEvent(21719, 4, "DDrakeRider_OnDied")

function DElite_OnEnterCombat(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38858,pUnit:GetClosestPlayer())
	pUnit:RegisterEvent("DElite_Spell1", 36000, 0)
	pUnit:RegisterEvent("DElite_Spell2", 50000, 0)
end

function DElite_Spell1(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38861,pUnit:GetClosestPlayer())
end

function DElite_Spell2(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38859,pUnit:GetClosestPlayer())
end

function DElite_LeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function DElite_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(22331, 1, "DElite_OnEnterCombat")
RegisterUnitEvent(22331, 2, "DElite_LeaveCombat")
RegisterUnitEvent(22331, 4, "DElite_OnDied")

function DNetherDrake_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("DNetherDrake_ArcaneBlast", 11000, 0)
end

function DNetherDrake_ArcaneBlast(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38344,pUnit:GetClosestPlayer())
end

function DNetherDrake_LeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function DNetherDrake_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(22000, 1, "DNetherDrake_OnEnterCombat")
RegisterUnitEvent(22000, 2, "DNetherDrake_LeaveCombat")
RegisterUnitEvent(22000, 4, "DNetherDrake_OnDied")

function DNPeon_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("DNPeon_Spell", 46000, 0)
end

function DNPeon_Spell(pUnit,Event)
	pUnit:FullCastSpellOnTarget(15572,pUnit:GetClosestPlayer())
end

function DNPeon_LeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function DNPeon_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(22252, 1, "DNPeon_OnEnterCombat")
RegisterUnitEvent(22252, 2, "DNPeon_LeaveCombat")
RegisterUnitEvent(22252, 4, "DNPeon_OnDied")

local cry_delay = 100000
local announces = {}
local announcei = 3
local choice = 1

RegisterUnitEvent(22252, 6, "DragonmawPeon_Random_Setup")
announces[1] = "It put the mutton in the stomach!"
announces[2] = "WHY IT PUT DA BOOTERANG ON DA SKIN?! WHY?!"
announces[3] = "You is bad orc... baaad... or... argh!"

function DragonmawPeon_Random_Tick(pUnit, Event)
   choice = math.random(1, announcei)
   pUnit:SendChatMessage(12, 0, announces[choice])
end

function DragonmawPeon_Random_Setup(pUnit, Event)
   pUnit:RegisterEvent("DragonmawPeon_Random_Tick", cry_delay, 0)
end

function DShaman_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("DShaman_LShield", 20000, 0)
	pUnit:RegisterEvent("DShaman_Bloodlust", 33000, 0)
end

function DShaman_LShield(pUnit,Event)
	pUnit:CastSpell(12550)
end

function DShaman_Bloodlust(pUnit,Event)
	pUnit:CastSpell(6742)
end

function DShaman_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

function DShaman_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21720, 1, "DShaman_OnEnterCombat")
RegisterUnitEvent(21720, 2, "DShaman_OnLeaveCombat")
RegisterUnitEvent(21720, 4, "DShaman_OnDied")

function DSkybreaker_OnEnterCombat(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38858,pUnit:GetClosestPlayer())
	pUnit:RegisterEvent("DSkybreaker_Spell1", 24000, 0)
	pUnit:RegisterEvent("DSkybreaker_Spell2", 11000, 0)
end

function DSkybreaker_Spell1(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38861,pUnit:GetClosestPlayer())
end

function DSkybreaker_Spell2(pUnit,Event)
	pUnit:FullCastSpellOnTarget(41448,pUnit:GetClosestPlayer())
end

function DSkybreaker_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function DSkybreaker_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(22274, 1, "DSkybreaker_OnEnterCombat")
RegisterUnitEvent(22274, 2, "DSkybreaker_OnLeaveCombat")
RegisterUnitEvent(22274, 4, "DSkybreaker_OnDied")

function DSubjugator_OnEnterCombat(pUnit,Event)
	pUnit:FullCastSpellOnTarget(9613,pUnit:GetClosestPlayer())
	pUnit:RegisterEvent("DSubjugator_Shadowbolt", 9000, 0)
end

function DSubjugator_Shadowbolt(pUnit,Event)
	pUnit:FullCastSpellOnTarget(9613,pUnit:GetClosestPlayer())
end

function DSubjugator_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end
function DSubjugator_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21718, 1, "DSubjugator_OnEnterCombat")
RegisterUnitEvent(21718, 2, "DSubjugator_OnLeaveCombat")
RegisterUnitEvent(21718, 4, "DSubjugator_OnDied")

function DTransporter_OnEnterCombat(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38858,pUnit:GetClosestPlayer())
	pUnit:RegisterEvent("DTransporter_Spell1Shoot", 33000, 0)
	pUnit:RegisterEvent("DTransporter_Spell2Shoot", 20000, 0)
end

function DTransporter_Spell1Shoot(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38861,pUnit:GetClosestPlayer())
end

function DTransporter_Spell2Shoot(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38859,pUnit:GetClosestPlayer())
end

function DTransporter_OnDeath(pUnit,Event)
	pUnit:RemoveEvents()
end

function DTransporter_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(23188, 1, "DTransporter_OnEnterCombat")
RegisterUnitEvent(23188, 2, "DTransporter_OnLeaveCombat")
RegisterUnitEvent(23188, 4, "DTransporter_OnDeath")

function DWrangler_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("DWrangler_Net", 20000, 0)
	pUnit:RegisterEvent("DWrangler_Enrage", 1000, 0)
end

function DWrangler_Net(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38338,pUnit:GetClosestPlayer())
end

function DWrangler_Enrage(pUnit,Event)
 if pUnit:GetHealthPct() == 94 then
	pUnit:CastSpell(8599)
end
end

function DWrangler_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function DWrangler_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21717, 1, "DWrangler_OnEnterCombat")
RegisterUnitEvent(21717, 2, "DWrangler_OnLeaveCombat")
RegisterUnitEvent(21717, 4, "DWrangler_OnDied")

function Dreadwarden_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("Dreadwarden_Spell1", 34000, 0)
	pUnit:RegisterEvent("Dreadwarden_Spell2", 21000, 0)
end

function Dreadwarden_Spell1(pUnit,Event)
	pUnit:FullCastSpellOnTarget(11443,pUnit:GetClosestPlayer())
end

function Dreadwarden_Spell2(pUnit,Event)
	pUnit:FullCastSpellOnTarget(32736,pUnit:GetClosestPlayer())
end

function Dreadwarden_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Dreadwarden_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(19744, 1, "Dreadwarden_OnEnterCombat")
RegisterUnitEvent(19744, 2, "Dreadwarden_OnLeaveCombat")
RegisterUnitEvent(19744, 4, "Dreadwarden_OnDied")

function EArchmage_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("EArchmage_Spell1", 14000, 0)
	pUnit:RegisterEvent("EArchmage_Spell2", 21000, 0)
	pUnit:RegisterEvent("EArchmage_Spell3", 10000, 0)
end

function EArchmage_Spell1(pUnit,Event)
	pUnit:FullCastSpellOnTarget(37986,pUnit:GetClosestPlayer())
end

function EArchmage_Spell2(pUnit,Event)
	pUnit:FullCastSpellOnTarget(11829,pUnit:GetClosestPlayer())
end

function EArchmage_Spell3(pUnit,Event)
	pUnit:FullCastSpellOnTarget(13878,pUnit:GetClosestPlayer())
end

function EArchmage_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function EArchmage_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(19796, 1, "EArchmage_OnEnterCombat")
RegisterUnitEvent(19796, 2, "EArchmage_OnLeaveCombat")
RegisterUnitEvent(19796, 4, "EArchmage_OnDied")

function EBloodwarder_OnEnterCombat(pUnit,Event)
	pUnit:CastSpell(38311)
	pUnit:RegisterEvent("EBloodwarder_BloodLeech", 9000, 0)
end

function EBloodwarder_BloodLeech(pUnit,Event)
	pUnit:FullCastSpellOnTarget(37838,pUnit:GetClosestPlayer())
end

function EBloodwarder_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function EBloodwarder_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(19806, 1, "EBloodwarder_OnEnterCombat")
RegisterUnitEvent(19806, 2, "EBloodwarder_OnLeaveCombat")
RegisterUnitEvent(19806, 4, "EBloodwarder_OnDied")

function ECavalier_OnEnterCombat(pUnit,Event)
	pUnit:CastSpell(38311)
	pUnit:RegisterEvent("ECavalier_SpellBreaker", 20000, 0)
	pUnit:RegisterEvent("ECavalier_BattleShout", 60000, 0)
end

function ECavalier_SpellBreaker(pUnit,Event)
	pUnit:CastSpell(35871)
end

function ECavalier_BattleShout(pUnit,Event)
	pUnit:CastSpell(30931)
end

function ECavalier_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function ECavalier_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(22018, 1, "ECavalier_OnEnterCombat")
RegisterUnitEvent(22018, 2, "ECavalier_OnLeaveCombat")
RegisterUnitEvent(22018, 4, "ECavalier_OnDied")

function ECenturion_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("ECenturion_SpellBreaker", 18000, 0)
	pUnit:RegisterEvent("ECenturion_Bloodheal", 1000, 0)
end


function ECenturion_SpellBreaker(pUnit,Event)
	pUnit:FullCastSpellOnTarget(35871,pUnit:GetClosestPlayer())
end

function ECenturion_Bloodheal(pUnit,Event)
 if pUnit:GetHealthPct() == 2 then
	pUnit:CastSpell(36476)
end
end

function ECenturion_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function ECenturion_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(19792, 1, "ECenturion_OnEnterCombat")
RegisterUnitEvent(19792, 2, "ECenturion_OnLeaveCombat")
RegisterUnitEvent(19792, 4, "ECenturion_OnDied")

function EDragonhawk_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("EDragonhawk_Firebreath", 18000, 0)
end

function EDragonhawk_Firebreath(pUnit,Event)
	pUnit:FullCastSpellOnTarget(37985,pUnit:GetClosestPlayer())
end

function EDragonhawk_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function EDragonhawk_OnDeath(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(20502, 1, "EDragonhawk_OnEnterCombat")
RegisterUnitEvent(20502, 2, "EDragonhawk_OnLeaveCombat")
RegisterUnitEvent(20502, 4, "EDragonhawk_OnDeath")

function ESoldier_OnEnterCombat(pUnit,Event)
 if pUnit:GetHealthPct() == 3 then
	pUnit:CastSpell(36476)
end
end

function ESoldier_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function ESoldier_OnDeath(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(22016, 1, "ESoldier_OnEnterCombat")
RegisterUnitEvent(22016, 2, "ESoldier_OnLeaveCombat")
RegisterUnitEvent(22016, 4, "ESoldier_OnDeath")

function ESpellbinder_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("ESpellbinder_SummonArcane", 11000, (1))
	pUnit:RegisterEvent("ESpellbinder_ArcaneMissle", 16000, 0)
end

function ESpellbinder_SummonArcane(pUnit,Event)
	pUnit:CastSpell(38171)
end

function ESpellbinder_ArcaneMissle(pUnit,Event)
	pUnit:FullCastSpellOnTarget(34447,pUnit:GetClosestPlayer())
end

function ESpellbinder_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function ESpellbinder_OnDeath(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(22017, 1, "ESpellbinder_OnEnterCombat")
RegisterUnitEvent(22017, 2, "ESpellbinder_OnLeaveCombat")
RegisterUnitEvent(22017, 4, "ESpellbinder_OnDeath")

function EDemolisher_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("EDemolisher_Stomp", 19000, 0)
end

function EDemolisher_Stomp(pUnit,Event)
	pUnit:CastSpell(38045)
end

function EDemolisher_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function EDemolisher_OnDeath(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21802, 1, "EDemolisher_OnEnterCombat")
RegisterUnitEvent(21802, 2, "EDemolisher_OnLeaveCombat")
RegisterUnitEvent(21802, 4, "EDemolisher_OnDeath")

function AirSpirit_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("AirSpirit_Spell1", 11000, 0)
	pUnit:RegisterEvent("AirSpirit_Spell2", 25000, 0)
end

function AirSpirit_Spell1(pUnit,Event)
	pUnit:FullCastSpellOnTarget(12058,pUnit:GetClosestPlayer())
end

function AirSpirit_Spell2(punit,Event)
	pUnit:FullCastSpellOnTarget(32717,pUnit:GetClosestPlayer())
end

function AirSpirit_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function AirSpirit_OnDeath(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21060, 1, "AirSpirit_OnEnterCombat")
RegisterUnitEvent(21060, 2, "AirSpirit_OnLeaveCombat")
RegisterUnitEvent(21060, 4, "AirSpirit_OnDeath")

function EarthSpirit_OnEnterCombat(pUnit,Event)
	pUnit:CastSpell(38365)
	pUnit:RegisterEvent("EarthSpirit_Boulder", 8500, 0)
end

function EarthSpirit_Boulder(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38498,pUnit:GetClosestPlayer())
end

function EarthSpirit_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function EarthSpirit_OnDeath(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21050, 1, "EarthSpirit_OnEnterCombat")
RegisterUnitEvent(21050, 2, "EarthSpirit_OnLeaveCombat")
RegisterUnitEvent(21050, 4, "EarthSpirit_OnDeath")

function FireSpirit_OnEnterCombat(pUnit,Event)
	pUnit:CastSpell(36006)
	pUnit:RegisterEvent("FireSpirit_Enrage", 1000, 0)
	pUnit:RegisterEvent("FireSpirit_FelFireball", 3000, 0)
end

function FireSpirit_Enrage(pUnit,Event)
 if pUnit:GetHealthPct() == 97 then
	pUnit:CastSpell(8599)
end
end

function FireSpirit_FelFireball(pUnit,Event)
	pUnit:FullCastSpellOnTarget(36247,pUnit:GetClosestPlayer())
end

function FireSpirit_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function FireSpirit_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21061, 1, "FireSpirit_OnEnterCombat")
RegisterUnitEvent(21061, 2, "FireSpirit_OnLeaveCombat")
RegisterUnitEvent(21061, 4, "FireSpirit_OnDied")

function WaterSoul_OnEnterCombat(pUnit,Event)
	pUnit:CastSpell(35923)
end	

RegisterUnitEvent(21109, 1, "WaterSoul_OnEnterCombat")

function WaterSpirit_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("WaterSpirit_Stormbolt", 12000, 0)
end

function WaterSpirit_Stormbolt(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38032,pUnit:GetClosestPlayer())
end

function WaterSpirit_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function WaterSpirit_OnDeath(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21059, 1, "WaterSpirit_OnEnterCombat")
RegisterUnitEvent(21059, 1, "WaterSpirit_OnLeaveCombat")
RegisterUnitEvent(21059, 1, "WaterSpirit_OnDeath")

function ENDrake_OnEnterCombat(pUnit,Event)
	pUnit:CastSpell(38775)
	pUnit:RegisterEvent("ENDrake_Spell", 13000, 0)
end

function ENDrake_Spell(pUnit,Event)
	pUnit:FullCastSpellOnTarget(36513,pUnit:GetClosestPlayer())
end

function ENDrake_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function ENDrake_OnDeath(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21722, 1, "ENDrake_OnEnterCombat")
RegisterUnitEvent(21722, 2, "ENDrake_OnLeaveCombat")
RegisterUnitEvent(21722, 4, "ENDrake_OnDeath")

function ENWhelp_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("ENWhelp_Spell", 4000, 0)
end

function ENWhelp_Spell(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38340,pUnit:GetClosestPlayer())
end

function ENWhelp_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function ENWhelp_OnDeath(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21721, 1, "ENWhelp_OnEnterCombat")
RegisterUnitEvent(21721, 1, "ENWhelp_OnLeaveCombat")
RegisterUnitEvent(21721, 1, "ENWhelp_OnDeath")

function Eykenen_OnEnterCombat(pUnit,Event)
	pUnit:CastSpell(32734)
	pUnit:RegisterEvent("Eykenen_EarthShield", 43000, 0)
	pUnit:RegisterEvent("Eykenen_EarthShock", 10000, 0)
end

function Eykenen_EarthShield(pUnit,Event)
	pUnit:CastSpell(32734)
end

function Eykenen_EarthShock(pUnit,Event)
	pUnit:FullCastSpellOnTarget(13281,pUnit:GetClosestPlayer())
end

function Eykenen_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Eykenen_OnDeath(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21709, 1, "Eykenen_OnEnterCombat")
RegisterUnitEvent(21709, 1, "Eykenen_OnLeaveCombat")
RegisterUnitEvent(21709, 1, "Eykenen_OnDeath")

function FRSentinel_OnEnterCombat(pUnit,Event)
	pUnit:CastSpell(38022)
	pUnit:RegisterEvent("FRSentinel_Boom", 000, 0)
	pUnit:RegisterEvent("FRSentinel_WorldBreaker", 16000, 0)
end

function FRSentinel_Boom(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38052,pUnit:GetClosestPlayer())
end

function FRSentinel_WorldBreaker(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38052,pUnit:GetClosestPlayer())
end

function FRSentinel_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function FRSentinel_OnDeath(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21949, 1, "FRSentinel_OnEnterCombat")
RegisterUnitEvent(21949, 1, "FRSentinel_OnLeaveCombat")
RegisterUnitEvent(21949, 1, "FRSentinel_OnDeath")

function FelBoar_OnEnterCombat(pUnit,Event)
	pUnit:FullCastSpellOnTarget(35570,pUnit:GetClosestPlayer())
end

RegisterUnitEvent(21878, 1, "FelBoar_OnEnterCombat")

function FDiemetradon_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("FDiemetradon_Spell", 40000, 0)
end

function FDiemetradon_Spell(pUnit,Event)
	pUnit:FullCastSpellOnTarget(37941,pUnit:GetClosestPlayer())
end

function FDiemetradon_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function FDiemetradon_OnDeath(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21408, 1, "FDiemetradon_OnEnterCombat")
RegisterUnitEvent(21408, 2, "FDiemetradon_OnLeaveCombat")
RegisterUnitEvent(21408, 4, "FDiemetradon_OnDeath")

function Felspine_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("Felspine_FelFlames", 11000, 0)
	pUnit:RegisterEvent("Felspine_FlamingWound", 46000, 0)
end

function Felspine_FelFlames(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38356,pUnit:GetClosestPlayer())
end

function Felspine_FlamingWound(pUnit,Event)
	pUnit:FullCastSpellOnTarget(37941,pUnit:GetClosestPlayer())
end

function Felspine_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Felspine_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end


RegisterUnitEvent(21897, 1, "Felspine_OnEnterCombat")
RegisterUnitEvent(21897, 2, "Felspine_OnLeaveCombat")
RegisterUnitEvent(21897, 4, "Felspine_OnDied")

function GFDiemetradon_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("GFDiemetradon_FelFireball", 11000, 0)
	pUnit:RegisterEvent("GFDiemetradon_FlamingWound", 51000, 0)
end

function GFDiemetradon_FelFireball(pUnit,Event)
	pUnit:FullCastSpellOnTarget(37945,pUnit:GetClosestPlayer())
end

function GFDiemetradon_FlamingWound(pUnit,Event)
	pUnit:FullCastSpellOnTarget(37941,pUnit:GetClosestPlayer())
end

function GFDiemetradon_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function GFDiemetradon_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21462, 1, "GFDiemetradon_OnEnterCombat")
RegisterUnitEvent(21462, 2, "GFDiemetradon_OnLeaveCombat")
RegisterUnitEvent(21462, 4, "GFDiemetradon_OnDied")

function Gromtor_OnEnterCombat(pUnit,Event)
	pUnit:FullCastSpellOnTarget(26281,pUnit:GetClosestPlayer())
	pUnit:RegisterEvent("Gromtor_SunderArmor", 120000, 0)
	pUnit:RegisterEvent("Gromtor_ShieldWall", 22000, 0)
	pUnit:RegisterEvent("Gromtor_ShieldBlock", 40000, 0)
	pUnit:RegisterEvent("Gromtor_HeroicStrike", 4000, 0)
	pUnit:RegisterEvent("Gromtor_BattleShout", 240000, 0)
end

function Gromtor_SunderArmor(pUnit,Event)
	pUnit:FullCastSpellOnTarget(16145,pUnit:GetClosestPlayer())
end

function Gromtor_ShieldWall(pUnit,Event)
	pUnit:FullCastSpellOnTarget(15062,pUnit:GetClosestPlayer())
end

function Gromtor_ShieldBlock(pUnit,Event)
	pUnit:FullCastSpellOnTarget(12169,pUnit:GetClosestPlayer())
end

function Gromtor_HeroicStrike(pUnit,Event)
	pUnit:FullCastSpellOnTarget(29426,pUnit:GetClosestPlayer())
end

function Gromtor_BattleShout(pUnit,Event)
	pUnit:FullCastSpellOnTarget(31403,pUnit:GetClosestPlayer())
end

function Gromtor_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Gromtor_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21291, 1, "Gromtor_OnEnterCombat")
RegisterUnitEvent(21291, 2, "Gromtor_OnLeaveCombat")
RegisterUnitEvent(21291, 4, "Gromtor_OnDied")

function GRGuard_OnEnterCombat(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38182,pUnit:GetClosestPlayer())
end

RegisterUnitEvent(15241, 1, "GRGuard_OnEnterCombat")

function Guldan_Channel(pUnit, Event)
	pUnit:RemoveEvents()
	pUnit:CastSpell(35996)
end

function Guldan_Start(pUnit, Event)
	pUnit:RegisterEvent("Guldan_Channel", 1000, 0)
end

RegisterUnitEvent(17008, 6, "Guldan_Start")

function Haalum_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("Haalum_Chain", 15000, 0)
	pUnit:RegisterEvent("Haalum_LBolt", 9000, 0)
end

function Haalum_Chain(pUnit,Event)
	pUnit:FullCastSpellOnTarget(12058,pUnit:GetClosestPlayer())
end

function Haalum_LBolt(pUnit,Event)
	pUnit:FullCastSpellOnTarget(9532,pUnit:GetClosestPlayer())
end

function Haalum_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Haalum_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21711, 1, "Haalum_OnEnterCombat")
RegisterUnitEvent(21711, 2, "Haalum_OnLeaveCombat")
RegisterUnitEvent(21711, 4, "Haalum_OnDied")

function IAgonizer_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("IAgonizer_Firebolt", 6000, 0)
end

function IAgonizer_Firebolt(pUnit,Event)
	pUnit:FullCastSpellOnTarget(36227,pUnit:GetClosestPlayer())
end

function IAgonizer_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function IAgonizer_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(19801, 1, "IAgonizer_OnEnterCombat")
RegisterUnitEvent(19801, 2, "IAgonizer_OnLeaveCombat")
RegisterUnitEvent(19801, 4, "IAgonizer_OnDied")

function IDreadbringer_OnEnterCombat(pUnit,Event)
 if pUnit:GetHealthPct() == 91 then
	pUnit:FullCastSpellOnTarget(38167,pUnit:GetClosestPlayer())
end
end

RegisterUnitEvent(19799, 1, "IDreadbringer_OnEnterCombat")

function IDreadlord_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("IDreadlord_PsychicScream", 23000, 0)
	pUnit:RegisterEvent("IDreadlord_MindBlast", 7000, 0)
	pUnit:RegisterEvent("IDreadlord_Sleep", 50000, 0)
end

function IDreadlord_PsychicScream(pUnit,Event)
	pUnit:FullCastSpellOnTarget(13704,pUnit:GetClosestPlayer())
end

function IDreadlord_MindBlast(pUnit,Event)
	pUnit:FullCastSpellOnTarget(17287,pUnit:GetClosestPlayer())
end

function IDreadlord_Sleep(pUnit,Event)
	pUnit:FullCastSpellOnTarget(12098,pUnit:GetClosestPlayer())
end

function IDreadlord_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function IDreadlord_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21166, 1, "IDreadlord_OnEnterCombat")
RegisterUnitEvent(21166, 2, "IDreadlord_OnLeaveCombat")
RegisterUnitEvent(21166, 4, "IDreadlord_OnDied")

function IHighlord_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("IHighlord_Curseofflames", 240000, 0)
	pUnit:RegisterEvent("IHighlord_Flamestrike", 10000, 0)
	pUnit:RegisterEvent("IHighlord_Spell", 0001, 0)
end

function IHighlord_Curseofflames(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38010,pUnit:GetClosestPlayer())
end

function IHighlord_Spell(pUnit,Event)
 if pUnit:GetHealthPct() == 92 then 
	pUnit:FullCastSpellOnTarget(38010,pUnit:GetClosestPlayer())
end
end

function IHighlord_Flamestrike(pUnit,Event)
	pUnit:FullCastSpellOnTarget(16102,pUnit:GetClosestPlayer())
end

function IHighlord_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function IHighlord_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(19797, 1, "IHighlord_OnEnterCombat")
RegisterUnitEvent(19797, 2, "IHighlord_OnLeaveCombat")
RegisterUnitEvent(19797, 4, "IHighlord_OnDied")

function IJailor_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("IJailor_FelShackles", 24000, 0)
end

function IJailor_FelShackles(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38051,pUnit:GetClosestPlayer())
end

function IJailor_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function IJailor_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21520, 1, "IJailor_OnEnterCombat")
RegisterUnitEvent(21520, 2, "IJailor_OnLeaveCombat")
RegisterUnitEvent(21520, 4, "IJailor_OnDied")

function IMBreaker_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("IMBreaker_Spell1", 34000, 0)
	pUnit:RegisterEvent("IMBreaker_Spell2", 10000, 0)
	pUnit:RegisterEvent("IMBreaker_Spell3", 41000, 0)

end

function IMBreaker_Spell1(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38985,pUnit:GetClosestPlayer())
end

function IMBreaker_Spell2(pUnit,Event)
	pUnit:FullCastSpellOnTarget(17194,pUnit:GetClosestPlayer())
end

function IMBreaker_Spell3(pUnit,Event)
	pUnit:FullCastSpellOnTarget(22884,pUnit:GetClosestPlayer())
end

function IMBreaker_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function IMBreaker_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(22074, 1, "IMBreaker_OnEnterCombat")
RegisterUnitEvent(22074, 2, "IMBreaker_OnLeaveCombat")
RegisterUnitEvent(22074, 4, "IMBreaker_OnDied")

function IOverseer_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("IOverseer_MortalStrike", 20000, 0)
	pUnit:RegisterEvent("IOverseer_Rend", 50000, 0)
end

function IOverseer_MortalStrike(pUnit,Event)
	pUnit:FullCastSpellOnTarget(32736,pUnit:GetClosestPlayer())
end

function IOverseer_Rend(pUnit,Event)
	pUnit:FullCastSpellOnTarget(11977,pUnit:GetClosestPlayer())
end

function IOverseer_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function IOverseer_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21808, 1, "IOverseer_OnEnterCombat")
RegisterUnitEvent(21808, 2, "IOverseer_OnLeaveCombat")
RegisterUnitEvent(21808, 4, "IOverseer_OnDied")

function IPainlasher_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("IPainlasher_LashOfPain", 4000, 0)
end

function IPainlasher_LashOfPain(pUnit,Event)
	pUnit:FullCastSpellOnTarget(15968,pUnit:GetClosestPlayer())
end

function IPainlasher_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function IPainlasher_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(19800, 1, "IPainlasher_OnEnterCombat")
RegisterUnitEvent(19800, 2, "IPainlasher_OnLeaveCombat")
RegisterUnitEvent(19800, 4, "IPainlasher_OnDied")

function IRavager_OnEnterCombat(pUnit,Event)
	pUnit:FullCastSpellOnTarget(33645,pUnit:GetClosestPlayer())
	pUnit:RegisterEvent("IRavager_Cleave", 22000, 0)
	pUnit:RegisterEvent("IRavager_Cutdown", 9000, 0)
	pUnit:RegisterEvent("IRavager_Shout", 60000, 0)
end

function IRavager_Cleave(pUnit,Event)
	pUnit:FullCastSpellOnTarget(15496,pUnit:GetClosestPlayer())
end

function IRavager_Cutdown(pUnit,Event)
	pUnit:FullCastSpellOnTarget(32009,pUnit:GetClosestPlayer())
end

function IRavager_Shout(pUnit,Event)
	pUnit:CastSpell(16244)
end

function IRavager_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function IRavager_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(22857, 1, "IRavager_OnEnterCombat")
RegisterUnitEvent(22857, 2, "IRavager_OnLeaveCombat")
RegisterUnitEvent(22857, 4, "IRavager_OnDied")

function ISatyr_OnEnterCombat(pUnit,Event)
 if pUnit:GetHealthPct() == 97 then
	pUnit:FullCastSpellOnTarget(38048,pUnit:GetClosestPlayer())
end
end

RegisterUnitEvent(21656, 1, "ISatyr_OnEnterCombat")

function IShadowlord_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("IShadowlord_Sleep", 000, 0)
	pUnit:RegisterEvent("IShadowlord_CarrionSwarm", 000, 0)
	pUnit:RegisterEvent("IShadowlord_Inferno", 000, 0)
end

function IShadowlord_Sleep(pUnit,Event)
	pUnit:FullCastSpellOnTarget(12098,pUnit:GetClosestPlayer())
end

function IShadowlord_CarrionSwarm(pUnit,Event)
	pUnit:FullCastSpellOnTarget(39942,pUnit:GetClosestPlayer())
end

function IShadowlord_Inferno(pUnit,Event)
 if pUnit:GetHealthPct() == 64 then
	pUnit:FullCastSpellOnTarget(39942,pUnit:GetClosestPlayer())
end
end

function IShadowlord_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function IShadowlord_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(22988, 1, "IShadowlord_OnEnterCombat")
RegisterUnitEvent(22988, 2, "IShadowlord_OnLeaveCombat")
RegisterUnitEvent(22988, 4, "IShadowlord_OnDied")

function IShadowstalker_OnEnterCombat(pUnit,Event)
	pUnit:FullCastSpellOnTarget(7159,pUnit:GetClosestPlayer())
	pUnit:RegisterEvent("IShadowstalker_Backstab", 8000, 0)
end

function IShadowstalker_Backstab(pUnit,Event)
	pUnit:FullCastSpellOnTarget(7159,pUnit:GetClosestPlayer())
end

function IShadowstalker_Stealth(pUnit,Event)
	pUnit:CastSpell(5916)
end

function IShadowstalker_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function IShadowstalker_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21337, 1, "IShadowstalker_OnEnterCombat")
RegisterUnitEvent(21337, 6, "IShadowstalker_Stealth")
RegisterUnitEvent(21337, 2, "IShadowstalker_OnLeaveCombat")
RegisterUnitEvent(21337, 4, "IShadowstalker_OnDied")

function IShocktrooper_OnEnterCombat(pUnit,Event)
	pUnit:FullCastSpellOnTarget(22120,pUnit:GetClosestPlayer())
	pUnit:RegisterEvent("IShocktrooper_Cleave", 31000, 0)
end

function IShocktrooper_Cleave(pUnit,Event)
	pUnit:FullCastSpellOnTarget(15496,pUnit:GetClosestPlayer())
end

function IShocktrooper_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function IShocktrooper_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(19802, 1, "IShocktrooper_OnEnterCombat")
RegisterUnitEvent(19802, 2, "IShocktrooper_OnLeaveCombat")
RegisterUnitEvent(19802, 4, "IShocktrooper_OnDied")

function ISlayer_OnEnterCombat(pUnit,Event)
	pUnit:FullCastSpellOnTarget(35570,pUnit:GetClosestPlayer())
end

RegisterUnitEvent(21639, 1, "ISlayer_OnEnterCombat")

function ISoldier_OnEnterCombat(pUnit,Event)
 if pUnit:GetHealthPct() == 92 then
	pUnit:FullCastSpellOnTarget(35871,pUnit:GetClosestPlayer())
end
end

RegisterUnitEvent(22075, 1, "ISoldier_OnEnterCombat")

function IWatcher_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("IWatcher_MStrike", 35000, 0)
end

function IWatcher_MStrike(pUnit,Event)
	pUnit:FullCastSpellOnTarget(32736,pUnit:GetClosestPlayer())
end

function IWatcher_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function IWatcher_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(22093, 1, "IWatcher_OnEnterCombat")
RegisterUnitEvent(22093, 2, "IWatcher_OnLeaveCombat")
RegisterUnitEvent(22093, 4, "IWatcher_OnDied")

function ISoul_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("ISoul_Totem", 11000, 0)
end

function ISoul_Totem(pUnit,Event)
	pUnit:CastSpell(11969)
end

function ISoul_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function ISoul_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(19757, 1, "ISoul_OnEnterCombat")
RegisterUnitEvent(19757, 2, "ISoul_OnLeaveCombat")
RegisterUnitEvent(19757, 4, "ISoul_OnDied")

function Karsius_OnEnterCombat(pUnit,Event)
	pUnit:FullCastSpellOnTarget(37789,pUnit:GetClosestPlayer())
end

function Karsius_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Karsius_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21877, 1, "Karsius_OnEnterCombat")
RegisterUnitEvent(21877, 2, "Karsius_OnLeaveCombat")
RegisterUnitEvent(21877, 4, "Karsius_OnDied")

function KotCistern_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("KotCistern_Waterbolt", 4000, 0)
end

function KotCistern_Waterbolt(pUnit,Event)
	pUnit:FullCastSpellOnTarget(32011,pUnit:GetClosestPlayer())
end

function KotCistern_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function KotCistern_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(20795, 1, "KotCistern_OnEnterCombat")
RegisterUnitEvent(20795, 2, "KotCistern_OnLeaveCombat")
RegisterUnitEvent(20795, 4, "KotCistern_OnDied")

function KDefender_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("KDefender_Cleave", 11000, 0)
end

function KDefender_Cleave(pUnit,Event)
	pUnit:FullCastSpellOnTarget(15496,pUnit:GetMainTank())
end

function KDefender_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function KDefender_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(19362, 1, "KDefender_OnEnterCombat")
RegisterUnitEvent(19362, 2, "KDefender_OnLeaveCombat")
RegisterUnitEvent(19362, 4, "KDefender_OnDied")

function KRider_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("KRider_SnapKick", 6000, 0)
	pUnit:RegisterEvent("KRider_MortalStrike", 13000, 0)
end

function KRider_SnapKick(pUnit,Event)
	pUnit:FullCastSpellOnTarget(15618,pUnit:GetClosestPlayer())
end

function KRider_MortalStrike(pUnit,Event)
	pUnit:FullCastSpellOnTarget(19643,pUnit:GetClosestPlayer())
end

function KRider_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function KRider_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(19364, 1, "KRider_OnEnterCombat")
RegisterUnitEvent(19364, 2, "KRider_OnLeaveCombat")
RegisterUnitEvent(19364, 4, "KRider_OnDied")

function LadyShavRar_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("LadyShavRar_ArcaneBolt", 8500, 0)
	pUnit:RegisterEvent("LadyShavRar_Freeze", 43000, 0)
end

function LadyShavRar_ArcaneBolt(pUnit,Event)
	pUnit:FullCastSpellOnTarget(13901,pUnit:GetClosestPlayer())
end

function LadyShavRar_Freeze(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38035,pUnit:GetClosestPlayer())
end

function LadyShavRar_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function LadyShavRar_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(20684, 1, "LadyShavRar_OnEnterCombat")
RegisterUnitEvent(20684, 2, "LadyShavRar_OnLeaveCombat")
RegisterUnitEvent(20684, 4, "LadyShavRar_OnDied")

function Lakaan_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("Lakaan_WaterBolt", 4000, 0)
end

function Lakaan_WaterBolt(pUnit,Event)
	pUnit:FullCastSpellOnTarget(32011,pUnit:GetClosestPlayer())
end

function Lakaan_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Lakaan_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21416, 1, "Lakaan_OnEnterCombat")
RegisterUnitEvent(21416, 2, "Lakaan_OnLeaveCombat")
RegisterUnitEvent(21416, 4, "Lakaan_OnDied")

function LFCannon_OnEnterCombat(pUnit,Event)
 if pUnit:GetHealthPct() == 70 then
	pUnit:FullCastSpellOnTarget(36238,pUnit:GetClosestPlayer())
end
end

RegisterUnitEvent(21233, 1, "LFCannon_OnEnterCombat")

function LERider_OnEnterCombat(pUnit,Event)
	pUnit:CastSpell(39782)
	pUnit:CastSpellOnTarget(31888,pUnit:GetClosestPlayer())
end

RegisterUnitEvent(22966, 1, "LERider_OnEnterCombat")

function LVindicator_OnEnterCombat(pUnit,Event)
	pUnit:FullCastSpellOnTarget(13005,pUnit:GetClosestPlayer())
	pUnit:RegisterEvent("LVindicator_Exorcism", 11000, 0)
	pUnit:RegisterEvent("LVindicator_HolyLight", 16000, 0)
end

function LVindicator_Exorcism(pUnit,Event)
	pUnit:FullCastSpellOnTarget(33632,pUnit:GetClosestPlayer())
end

function LVindicator_HolyLight(pUnit,Event)
	pUnit:FullCastSpellOnTarget(13952,pUnit:GetRandomFriend(0))
end

function LVindicator_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function LVindicator_OnDied(pUnit,Event)
	pUnit:FullCastSpellOnTarget(13903,pUnit:GetRandomFriend(0))
end

RegisterUnitEvent(22861, 1, "LVindicator_OnEnterCombat")
RegisterUnitEvent(22861, 2, "LVindicator_OnLeaveCombat")
RegisterUnitEvent(22861, 4, "LVindicator_OnDied")

function Lothros_OnEnterCombat(pUnit,Event)
	pUnit:RegisterUnitEvent("Lothros_Spell", 60000, 0)
end

function Lothros_Spell(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38167,pUnit:GetClosestPlayer())
end

function Lothros_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Lothros_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21928, 1, "Lothros_OnEnterCombat")
RegisterUnitEvent(21928, 2, "Lothros_OnLeaveCombat")
RegisterUnitEvent(21928, 4, "Lothros_OnDied")

function Makazradon_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("Makazradon_Cripple", 45000, 0)
	pUnit:RegisterEvent("Makazradon_FelCleave", 19000, 0)
	pUnit:RegisterEvent("Makazradon_RainOfFire", 18000, 0)
end

function Makazradon_Cripple(pUnit,Event)
	pUnit:FullCastSpellOnTarget(11443,pUnit:GetClosestPlayer())
end

function Makazradon_FelCleave(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38742,pUnit:GetClosestPlayer())
end

function Makazradon_RainOfFire(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38741,pUnit:GetClosestPlayer())
end

function Makazradon_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Makazradon_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21501, 1, "Makazradon_OnEnterCombat")
RegisterUnitEvent(21501, 2, "Makazradon_OnLeaveCombat")
RegisterUnitEvent(21501, 4, "Makazradon_OnDied")

function MatureNetherwingDrake_OnEnterCombat(pUnit,Event)
	pUnit:CastSpell(38502)
	pUnit:RegisterEvent("MatureNetherwingDrake_IntangiblePresence", 16000, 0)
	pUnit:RegisterEvent("MatureNetherwingDrake_Netherbreath", 5000, 0)
end

function MatureNetherwingDrake_IntangiblePresence(pUnit,Event)
	pUnit:FullCastSpellOnTarget(36513,pUnit:GetClosestPlayer())
end

function MatureNetherwingDrake_Netherbreath(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38467,pUnit:GetClosestPlayer())
end

function MatureNetherwingDrake_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function MatureNetherwingDrake_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21648, 1, "MatureNetherwingDrake_OnEnterCombat")
RegisterUnitEvent(21648, 2, "MatureNetherwingDrake_OnLeaveCombat")
RegisterUnitEvent(21648, 4, "MatureNetherwingDrake_OnDied")

function MoArgWeaponsmith_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("MoArgWeaponsmith_ChemicalFlames", 13000, 0)
	pUnit:RegisterEvent("MoArgWeaponsmith_DrillArmor", 18000, 0)
end

function MoArgWeaponsmith_ChemicalFlames(pUnit,Event)
	pUnit:FullCastSpellOnTarget(36253,pUnit:GetClosestPlayer())
end

function MoArgWeaponsmith_DrillArmor(pUnit,Event)
	pUnit:FullCastSpellOnTarget(37580,pUnit:GetClosestPlayer())
end

function MoArgWeaponsmith_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function MoArgWeaponsmith_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(19755, 1, "MoArgWeaponsmith_OnEnterCombat")
RegisterUnitEvent(19755, 2, "MoArgWeaponsmith_OnLeaveCombat")
RegisterUnitEvent(19755, 4, "MoArgWeaponsmith_OnDied")

function Mordenai_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("Mordenai_Shoot", 2000, 0)
	pUnit:RegisterEvent("Mordenai_Start", 2000, 0)
end

function Mordenai_Shoot(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38372,pUnit:GetClosestPlayer())
end

function Mordenai_Start(pUnit,Eevnt)
 if pUnit:GetHealthPct() == 98 then
	pUnit:RemoveEvents()
	pUnit:RegisterEvent("Mordenai_AimedShot", 16000, 0)
	pUnit:RegisterEvent("Mordenai_ArcaneShot", 6000, 0)
end
end

function Mordenai_AimedShot(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38370,pUnit:GetClosestPlayer())
end

function Mordenai_ArcaneShot(pUnit,Event)
	pUnit:FullCastSpellOnTarget(36623,pUnit:GetClosestPlayer())
end

function Mordenai_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Mordenai_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(22113, 1, "Mordenai_OnEnterCombat")
RegisterUnitEvent(22113, 2, "Mordenai_OnLeaveCombat")
RegisterUnitEvent(22113, 4, "Mordenai_OnDied")

function Morgroron_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("Morgroron_MortalCleave", 12000, 0)
	pUnit:RegisterEvent("Morgroron_RainOfFire", 18000, 0)
	pUnit:RegisterEvent("Morgroron_WarStomp", 7000, 0)
end

function Morgroron_MortalCleave(pUnit,Event)
	pUnit:FullCastSpellOnTarget(22859,pUnit:GetClosestPlayer())
end

function Morgroron_RainOfFire(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38741,pUnit:GetClosestPlayer())
end

function Morgroron_WarStomp(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38750,pUnit:GetClosestPlayer())
end

function Morgroron_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Morgroron_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21500, 1, "Morgroron_OnEnterCombat")
RegisterUnitEvent(21500, 2, "Morgroron_OnLeaveCombat")
RegisterUnitEvent(21500, 4, "Morgroron_OnDied")

function MutantHorror_OnEnterCombat(pUnit,Event)
	pUnit:CastSpell(8599)
	pUnit:RegisterEvent("MutantHorror_MutatedBlood", 45000, 0)
end

function MutantHorror_MutatedBlood(pUnit,Event)
	pUnit:FullCastSpellOnTarget(37950,pUnit:GetClosestPlayer())
end

function MutantHorror_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function MutantHorror_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21305, 1, "MutantHorror_OnEnterCombat")
RegisterUnitEvent(21305, 2, "MutantHorror_OnLeaveCombat")
RegisterUnitEvent(21305, 4, "MutantHorror_OnDied")

function Netharel_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("Netharel_DebilitatingStrike", 15000, 0)
	pUnit:RegisterEvent("Netharel_Evasion", 30000, 0)
	pUnit:RegisterEvent("Netharel_ManaBurn", 7000, 0)
	pUnit:RegisterEvent("Netharel_Metamorphosis", 1000, 1)
end

function Netharel_DebilitatingStrike(pUnit,Event)
	pUnit:FullCastSpellOnTarget(39135,pUnit:GetClosestPlayer())
end

function Netharel_Evasion(pUnit,Event)
	pUnit:FullCastSpellOnTarget(37683,pUnit:GetClosestPlayer())
end

function Netharel_ManaBurn(pUnit,Event)
	pUnit:FullCastSpellOnTarget(39262,pUnit:GetClosestPlayer())
end

function Netharel_Metamorphosis(pUnit,Event)
 if pUnit:GetHealthPct() == 10 then
	pUnit:CastSpell(36298)
end
end

function Netharel_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Netharel_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21164, 1, "Netharel_OnEnterCombat")
RegisterUnitEvent(21164, 2, "Netharel_OnLeaveCombat")
RegisterUnitEvent(21164, 4, "Netharel_OnDied")

function NethermineBurster_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("NethermineBurster_Poison", 2000, 0)
end

function NethermineBurster_Poison(pUnit,Event)
	pUnit:FullCastSpellOnTarget(31747,pUnit:GetClosestPlayer())
end

function NethermineBurster_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end


function NethermineBurster_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(23285, 1, "NethermineBurster_OnEnterCombat")
RegisterUnitEvent(23285, 2, "NethermineBurster_OnLeaveCombat")
RegisterUnitEvent(23285, 4, "NethermineBurster_OnDied")

function NethermineFlayer_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("NethermineFlayer_Rend", 30000, 0)
	pUnit:RegisterEvent("NethermineFlayer_ShredArmor", 31000, 0)
end

function NethermineFlayer_Rend(pUnit,Event)
	pUnit:FullCastSpellOnTarget(13443,pUnit:GetClosestPlayer())
end

function NethermineFlayer_ShredArmor(pUnit,Event)
	pUnit:FullCastSpellOnTarget(40770,pUnit:GetClosestPlayer())
end

function NethermineFlayer_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function NethermineFlayer_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(23169, 1, "NethermineFlayer_OnEnterCombat")
RegisterUnitEvent(23169, 2, "NethermineFlayer_OnLeaveCombat")
RegisterUnitEvent(23169, 4, "NethermineFlayer_OnDied")

function NethermineRavager_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("NethermineRavager_Rend", 15000, 0)
	pUnit:RegisterEvent("NethermineRavager_RockShell", 18000, 0)
end

function NethermineRavager_Rend(pUnit,Event)
	pUnit:FullCastSpellOnTarget(13443,pUnit:GetClosestPlayer())
end

function NethermineRavager_RockShell(pUnit,Event)
	pUnit:FullCastSpellOnTarget(33810,pUnit:GetClosestPlayer())
end

function NethermineRavager_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function NethermineRavager_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(23326, 1, "NethermineRavager_OnEnterCombat")
RegisterUnitEvent(23326, 2, "NethermineRavager_OnLeaveCombat")
RegisterUnitEvent(23326, 4, "NethermineRavager_OnDied")

function Netherskate_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("Netherskate_DrainMana", 1000, 0)
	pUnit:RegisterEvent("Netherskate_TailSting", 32000, 0)
end

function Netherskate_DrainMana(pUnit,Event)
 if pUnit:GetManaPct() == 92 then
	pUnit:FullCastSpellOnTarget(17008,pUnit:GetRandomPlayer(4))
end
end

function Netherskate_TailSting(pUnit,Event)
	pUnit:FullCastSpellOnTarget(36659,pUnit:GetClosestPlayer())
end

function Netherskate_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Netherskate_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21901, 1, "Netherskate_OnEnterCombat")
RegisterUnitEvent(21901, 2, "Netherskate_OnLeaveCombat")
RegisterUnitEvent(21901, 4, "Netherskate_OnDied")

function NetherwingRay_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("NetherwingRay_DrainMana", 1000, 0)
	pUnit:RegisterEvent("NetherwingRay_TailSting", 32000, 0)
end

function NetherwingRay_DrainMana(pUnit,Event)
 if pUnit:GetManaPct() == 92 then
	pUnit:FullCastSpellOnTarget(17008,pUnit:GetRandomPlayer(4))
end
end

function NetherwingRay_TailSting(pUnit,Event)
	pUnit:FullCastSpellOnTarget(36659,pUnit:GetClosestPlayer())
end

function NetherwingRay_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function NetherwingRay_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(23501, 1, "NetherwingRay_OnEnterCombat")
RegisterUnitEvent(23501, 2, "NetherwingRay_OnLeaveCombsat")
RegisterUnitEvent(23501, 4, "NetherwingRay_OnDied")

function OrkaosTheInsane_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("OrkaosTheInsane_Cleave", 14000, 0)
	pUnit:RegisterEvent("OrkaosTheInsane_MortalStrike", 16000, 0)
	pUnit:RegisterEvent("OrkaosTheInsane_Uppercut", 8000, 0)
end

function OrkaosTheInsane_Cleave(pUnit,Event)
	pUnit:FullCastSpellOnTarget(15496,pUnit:GetClosestPlayer())
end

function OrkaosTheInsane_MortalStrike(pUnit,Event)
	pUnit:FullCastSpellOnTarget(17547,pUnit:GetClosestPlayer())
end

function OrkaosTheInsane_Uppercut(pUnit,Event)
	pUnit:FullCastSpellOnTarget(10966,pUnit:GetClosestPlayer())
end

function OrkaosTheInsane_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function OrkaosTheInsane_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(23168, 1, "OrkaosTheInsane_OnEnterCombat")
RegisterUnitEvent(23168, 2, "OrkaosTheInsane_OnLeaveCombsat")
RegisterUnitEvent(23168, 4, "OrkaosTheInsane_OnDied")

function OronokTornheart_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("OronokTornheart_ChainLightning", 1200, 0)
	pUnit:RegisterEvent("OronokTornheart_FrostShock", 16000, 0)
	pUnit:RegisterEvent("OronokTornheart_HealingWave", 5000, 0)
end

function OronokTornheart_ChainLightning(pUnit,Event)
	pUnit:FullCastSpellOnTarget(16006,pUnit:GetClosestPlayer())
end

function OronokTornheart_FrostShock(pUnit,Event)
	pUnit:FullCastSpellOnTarget(12548,pUnit:GetClosestPlayer())
end

function OronokTornheart_HealingWave(pUnit,Event)
	pUnit:FullCastSpellOnTarget(12491,pUnit:GetRandomFriend())
end

function OronokTornheart_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function OronokTornheart_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21183, 1, "OronokTornheart_OnEnterCombat")
RegisterUnitEvent(21183, 2, "OronokTornheart_OnLeaveCombsat")
RegisterUnitEvent(21183, 4, "OronokTornheart_OnDied")

function OronuTheElder_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("OronuTheElder_GroundingTotem", 45000, 0)
	pUnit:RegisterEvent("OronuTheElder_HealingWave", 11000, 0)
	pUnit:RegisterEvent("OronuTheElder_LightningShield", 30000, 0)
end

function OronuTheElder_GroundingTotem(pUnit,Event)
	pUnit:CastSpell(34079)
end

function OronuTheElder_HealingWave(pUnit,Event)
	pUnit:FullCastSpellOnTarget(11986,pUnit:GetRandomFriend())
end

function OronuTheElder_LightningShield(pUnit,Event)
	pUnit:CastSpell(12550)
end

function OronuTheElder_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function OronuTheElder_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21663, 1, "OronuTheElder_OnEnterCombat")
RegisterUnitEvent(21663, 2, "OronuTheElder_OnLeaveCombsat")
RegisterUnitEvent(21663, 4, "OronuTheElder_OnDied")

function OvermineFlayer_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("OvermineFlayer_Rend", 30000, 0)
	pUnit:RegisterEvent("OvermineFlayer_RockShell", 18000, 0)
end

function OvermineFlayer_Rend(pUnit,Event)
	pUnit:FullCastSpellOnTarget(13443,pUnit:GetClosestPlayer())
end

function OvermineFlayer_RockShell(pUnit,Event)
	pUnit:CastSpell(33810)
end

function OronuTheElder_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function OronuTheElder_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(23264, 1, "OvermineFlayer_OnEnterCombat")
RegisterUnitEvent(23264, 2, "OvermineFlayer_OnLeaveCombsat")
RegisterUnitEvent(23264, 4, "OvermineFlayer_OnDied")

function OverseerRipsaw_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("OverseerRipsaw_GushingWound", 25000, 0)
	pUnit:RegisterEvent("OverseerRipsaw_SawBlade", 2500, 0)
end

function OverseerRipsaw_GushingWound(pUnit,Event)
	pUnit:FullCastSpellOnTarget(35321,pUnit:GetClosestPlayer())
end

function OverseerRipsaw_SawBlade(pUnit,Event)
	pUnit:FullCastSpellOnTarget(32735,pUnit:GetClosestPlayer())
end

function OverseerRipsaw_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function OverseerRipsaw_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21499, 1, "OverseerRipsaw_OnEnterCombat")
RegisterUnitEvent(21499, 2, "OverseerRipsaw_OnLeaveCombsat")
RegisterUnitEvent(21499, 4, "OverseerRipsaw_OnDied")

function PainmistressGabrissa_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("PainmistressGabrissa_CurseOfPain", 120000, 0)
end

function PainmistressGabrissa_CurseOfPain(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38048,pUnit:GetClosestPlayer())
 if pUnit:GetHealthPct() == 50 then 
	pUnit:RemoveEvents()
end
end

function PainmistressGabrissa_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function PainmistressGabrissa_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21309, 1, "PainmistressGabrissa_OnEnterCombat")
RegisterUnitEvent(21309, 2, "PainmistressGabrissa_OnLeaveCombsat")
RegisterUnitEvent(21309, 4, "PainmistressGabrissa_OnDied")

function ProphetessCavrylin_OnEnterCombat(pUnit,Event)
	pUnit:FullCastSpellOnTarget(36656,pUnit:GetClosestPlayer())
	pUnit:CastSpell(37997)
	pUnit:RegisterEvent("ProphetessCavrylin_MeltFlesh", 15000, 0)
end

function ProphetessCavrylin_MeltFlesh(pUnit,Event)
	pUnit:FullCastSpellOnTarget(37629,pUnit:GetClosestPlayer())
end

function ProphetessCavrylin_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function ProphetessCavrylin_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(20683, 1, "ProphetessCavrylin_OnEnterCombat")
RegisterUnitEvent(20683, 2, "ProphetessCavrylin_OnLeaveCombsat")
RegisterUnitEvent(20683, 4, "ProphetessCavrylin_OnDied")

function RavenousFlayerMatriarch_OnEnterCombat(pUnit,Event)
	pUnit:CastSpell(36464)
	pUnit:RegisterEvent("RavenousFlayerMatriarch_GushingWound", 25000, 0)
end

function RavenousFlayerMatriarch_GushingWound(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38363,pUnit:GetClosestPlayer())
end

function RavenousFlayerMatriarch_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function RavenousFlayerMatriarch_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21205, 1, "RavenousFlayerMatriarch_OnEnterCombat")
RegisterUnitEvent(21205, 2, "RavenousFlayerMatriarch_OnLeaveCombsat")
RegisterUnitEvent(21205, 4, "RavenousFlayerMatriarch_OnDied")

function RemnantofCorruption_OnSpawn(pUnit,Event)
	pUnit:CastSpell(39169)
end

RegisterUnitEvent(22439, 6, "RemnantofCorruption_OnSpawn")

function RemnantofGreed_OnSpawn(pUnit,Event)
	pUnit:CastSpell(39168)
end

RegisterUnitEvent(22438, 6, "RemnantofGreed_OnSpawn")

function RemnantofHate_OnSpawn(pUnit,Event)
	pUnit:CastSpell(38696)
end

RegisterUnitEvent(22094, 6, "RemnantofHate_OnSpawn")

function RemnantofMalice_OnSpawn(pUnit,Event)
	pUnit:CastSpell(38695)
end

RegisterUnitEvent(22437, 6, "RemnantofMalice_OnSpawn")

function RocknailFlayer_OnEnterCombat(pUnit,Event)
	pUnit:RegisterUnitEvent("RocknailFlayer_FlayedFlesh", 30000, 0)
end

function RocknailFlayer_FlayedFlesh(pUnit,Event)
	pUnit:FullCastSpellOnTarget(37937,pUnit:GetClosestPlayer())
end

function RocknailFlayer_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function RocknailFlayer_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21477, 1, "RocknailFlayer_OnEnterCombat")
RegisterUnitEvent(21477, 2, "RocknailFlayer_OnLeaveCombat")
RegisterUnitEvent(21477, 4, "RocknailFlayer_OnDied")

function RocknailRipper_OnEnterCombat(pUnit,Event)
	pUnit:RegisterUnitEvent("RocknailRipper_Rip", 11000, 0)
end

function RocknailRipper_Rip(pUnit,Event)
	pUnit:FullCastSpellOnTarget(37937,pUnit:GetClosestPlayer())
end

function RocknailRipper_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function RocknailRipper_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21478, 1, "RocknailRipper_OnEnterCombat")
RegisterUnitEvent(21478, 2, "RocknailRipper_OnLeaveCombat")
RegisterUnitEvent(21478, 4, "RocknailRipper_OnDied")

function RuulTheDarkener_OnEnterCombat(pUnit,Event)
	pUnit:RegisterUnitEvent("RuulTheDarkener_Cleave", 15000, 0)
	pUnit:RegisterUnitEvent("RuulTheDarkener_Spellbreaker", 18000, 0)
	local Choice=math.random(1,2)
	if Choice==1 then
		pUnit:SendChatMessage(14, 0, "Your world is at an end.")
	elseif Choice==2 then
		pUnit:SendChatMessage(14, 0, "The skies will darken and all will go quiet. Only then will you know the sweet serenity of death.")
end
end

function RuulTheDarkener_Cleave(pUnit,Event)
	pUnit:FullCastSpellOnTarget(15284,pUnit:GetClosestPlayer())
end

function RuulTheDarkener_Spellbreaker(pUnit,Event)
	pUnit:FullCastSpellOnTarget(35871,pUnit:GetClosestPlayer())
end

function RuulTheDarkener_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function RuulTheDarkener_OnDied(pUnit,Event)
	pUnit:SpawnCreature(22106)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21315, 1, "RuulTheDarkener_OnEnterCombat")
RegisterUnitEvent(21315, 2, "RuulTheDarkener_OnLeaveCombat")
RegisterUnitEvent(21315, 4, "RuulTheDarkener_OnDied")

function RuulsNetherdrake_OnEnterCombat(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38344,pUnit:GetClosestPlayer())
	pUnit:FullCastSpellOnTarget(36513,pUnit:GetClosestPlayer())
	pUnit:RegisterEvent("RuulsNetherdrake_ArcaneBlast", 000, 0)
end

function RuulsNetherdrake_ArcaneBlast(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38344,pUnit:GetClosestPlayer())
end

function RuulsNetherdrake_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

function RuulsNetherdrake_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(22106, 1, "RuulsNetherdrake_OnEnterCombat")
RegisterUnitEvent(22106, 2, "RuulsNetherdrake_OnLeaveCombat")
RegisterUnitEvent(22106, 4, "RuulsNetherdrake_OnDied")

function SanctumDefender_OnEnterCombat(pUnit,Event)
	pUnit:FullCastSpellOnTarget(41440,pUnit:GetClosestPlayer())
end

RegisterUnitEvent(23435, 1, "SanctumDefender_OnEnterCombat")

function ScorchshellPincer_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("ScorchshellPincer_BurningPoison", 000, 0)
end

function ScorchshellPincer_BurningPoison(pUnit,Event)
	pUnit:FullCastSpellOnTarget(15284,pUnit:GetClosestPlayer())
end

function ScorchshellPincer_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function ScorchshellPincer_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21864, 1, "ScorchshellPincer_OnEnterCombat")
RegisterUnitEvent(21864, 2, "ScorchshellPincer_OnLeaveCombat")
RegisterUnitEvent(21864, 4, "ScorchshellPincer_OnDied")

function ScornedSpiritofAir_OnSpawn(pUnit,Event)
	pUnit:CastSpell(36206)
end

RegisterUnitEvent(21132, 6, "ScornedSpiritofAir_OnSpawn")

function ScornedSpiritofEarth_OnSpawn(pUnit,Event)
	pUnit:CastSpell(36206)
end

RegisterUnitEvent(21129, 6, "ScornedSpiritofEarth_OnSpawn")

function ScornedSpiritofFire_OnSpawn(pUnit,Event)
	pUnit:CastSpell(36206)
end

RegisterUnitEvent(21130, 6, "ScornedSpiritofFire_OnSpawn")

function ScornedSpiritofWater_OnSpawn(pUnit,Event)
	pUnit:CastSpell(36206)
end

RegisterUnitEvent(21131, 6, "ScornedSpiritofWater_OnSpawn")

function ScryerCavalier_OnEnterCombat(pUnit,Event)
	pUnit:CastSpell(30931)
	pUnit:registerEvent("ScryerCavalier_Spellbreaker", 24000, 0)
end

function ScryerCavalier_Spellbreaker(pUnit,Event)
	pUnit:FullCastSpellOnTarget(35871,pUnit:GetClosestPlayer())
end

function ScryerCavalier_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function ScryerCavalier_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(22967, 1, "ScryerCavalier_OnEnterCombat")
RegisterUnitEvent(22967, 2, "ScryerCavalier_OnLeaveCombat")
RegisterUnitEvent(22967, 4, "ScryerCavalier_OnDied")

function ScryerGuardian_OnEnterCombat(pUnit,Event)
	pUnit:registerEvent("ScryerGuardian_Fireball", 7000, 0)
	pUnit:registerEvent("ScryerGuardian_Scorch", 5000, 0)
	pUnit:registerEvent("ScryerGuardian_Slow", 40000, 0)
end

function ScryerGuardian_Fireball(pUnit,Event)
	pUnit:FullCastSpellOnTarget(15228,pUnit:GetClosestPlayer())
end

function ScryerGuardian_Scorch(pUnit,Event)
	pUnit:FullCastSpellOnTarget(17195,pUnit:GetClosestPlayer())
end

function ScryerGuardian_Slow(pUnit,Event)
	pUnit:FullCastSpellOnTarget(11436,pUnit:GetClosestPlayer())
end

function ScryerGuardian_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function ScryerGuardian_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(19504, 1, "ScryerGuardian_OnEnterCombat")
RegisterUnitEvent(19504, 2, "ScryerGuardian_OnLeaveCombat")
RegisterUnitEvent(19504, 4, "ScryerGuardian_OnDied")

function SeasonedMagister_OnEnterCombat(pUnit,Event)
	pUnit:registerEvent("SeasonedMagister_Fireball", 3000, 0)
end

function SeasonedMagister_Fireball(pUnit,Event)
	pUnit:FullCastSpellOnTarget(15228,pUnit:GetClosestPlayer())
end

function SeasonedMagister_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function SeasonedMagister_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(22863, 1, "SeasonedMagister_OnEnterCombat")
RegisterUnitEvent(22863, 2, "SeasonedMagister_OnLeaveCombat")
RegisterUnitEvent(22863, 4, "SeasonedMagister_OnDied")

function ShadowCouncilWarlock_OnEnterCombat(pUnit,Event)
	pUnit:SetCombatMeleeCapable(1)
	pUnit:registerEvent("ShadowCouncilWarlock_DrainLife", 24000, 0)
	pUnit:registerEvent("ShadowCouncilWarlock_ShadowBolt", 2500, 0)
end

function ShadowCouncilWarlock_DrainLife(pUnit,Event)
	pUnit:FullCastSpellOnTarget(37992,pUnit:GetClosestPlayer())
end

function ShadowCouncilWarlock_ShadowBolt(pUnit,Event)
	pUnit:FullCastSpellOnTarget(9613,pUnit:GetClosestPlayer())
end

function ShadowCouncilWarlock_OnLeaveCombat(pUnit,Event)
	pUnit:SetCombatMeleeCapable(0)
	pUnit:RemoveEvents()
end

function ShadowCouncilWarlock_OnDied(pUnit,Event)
	pUnit:SetCombatMeleeCapable(0)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21302, 1, "ShadowCouncilWarlock_OnEnterCombat")
RegisterUnitEvent(21302, 2, "ShadowCouncilWarlock_OnLeaveCombat")
RegisterUnitEvent(21302, 4, "ShadowCouncilWarlock_OnDied")

function ShadowhoofAssassin_OnEnterCombat(pUnit,Event)
	pUnit:registerEvent("ShadowhoofAssassin_DebilitatingStrike", 15000, 0)
	pUnit:registerEvent("ShadowhoofAssassin_SinisterStrike", 6000, 0)
end

function ShadowhoofAssassin_DebilitatingStrike(pUnit,Event)
	pUnit:FullCastSpellOnTarget(37577,pUnit:GetClosestPlayer())
end

function ShadowhoofAssassin_SinisterStrike(pUnit,Event)
	pUnit:FullCastSpellOnTarget(14873,pUnit:GetClosestPlayer())
end

function ShadowhoofAssassin_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function ShadowhoofAssassin_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(22858, 1, "ShadowhoofAssassin_OnEnterCombat")
RegisterUnitEvent(22858, 2, "ShadowhoofAssassin_OnLeaveCombat")
RegisterUnitEvent(22858, 4, "ShadowhoofAssassin_OnDied")

function ShadowhoofSummoner_OnEnterCombat(pUnit,Event)
	pUnit:SetCombatMeleeCapable(1)
	pUnit:registerEvent("ShadowhoofSummoner_CurseOfTongues", 30000, 0)
	pUnit:registerEvent("ShadowhoofSummoner_ShadowBolt", 3000, 0)
end

function ShadowhoofSummoner_CurseOfTongues(pUnit,Event)
	pUnit:FullCastSpellOnTarget(13338,pUnit:GetClosestPlayer())
end

function ShadowhoofSummoner_ShadowBolt(pUnit,Event)
	pUnit:FullCastSpellOnTarget(9613,pUnit:GetClosestPlayer())
end

function ShadowhoofSummoner_OnLeaveCombat(pUnit,Event)
	pUnit:SetCombatMeleeCapable(0)
	pUnit:RemoveEvents()
end

function ShadowhoofSummoner_OnDied(pUnit,Event)
	pUnit:SetCombatMeleeCapable(0)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(22859, 1, "ShadowhoofSummoner_OnEnterCombat")
RegisterUnitEvent(22859, 2, "ShadowhoofSummoner_OnLeaveCombat")
RegisterUnitEvent(22859, 4, "ShadowhoofSummoner_OnDied")

function ShadowlordDeathwail_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("ShadowlordDeathwail_DeathCoil", 18000, 0)
	pUnit:RegisterEvent("ShadowlordDeathwail_Fear", 24000, 0)
	pUnit:RegisterEvent("ShadowlordDeathwail_FelFireball", 11000, 0)
	pUnit:RegisterEvent("ShadowlordDeathwail_ShadowBolt", 5000, 0)
	pUnit:RegisterEvent("ShadowlordDeathwail_ShadowBoltVolley", 7000, 0)
end

function ShadowlordDeathwail_DeathCoil(pUnit,Event)
	pUnit:FullCastSpellOnTarget(32709,pUnit:GetClosestPlayer())
end

function ShadowlordDeathwail_Fear(pUnit,Event)
	pUnit:FullCastSpellOnTarget(27641,pUnit:GetClosestPlayer())
end

function ShadowlordDeathwail_FelFireball(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38312,pUnit:GetClosestPlayer())
end

function ShadowlordDeathwail_ShadowBolt(pUnit,Event)
	pUnit:FullCastSpellOnTarget(12471,pUnit:GetClosestPlayer())
end

function ShadowlordDeathwail_ShadowBoltVolley(pUnit,Event)
	pUnit:FullCastSpellOnTarget(15245,pUnit:GetClosestPlayer())
end

function ShadowlordDeathwail_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function ShadowlordDeathwail_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(22006, 1, "ShadowlordDeathwail_OnEnterCombat")
RegisterUnitEvent(22006, 2, "ShadowlordDeathwail_OnLeaveCombat")
RegisterUnitEvent(22006, 4, "ShadowlordDeathwail_OnDied")

function ShadowmoonChosen_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("ShadowmoonChosen_Uppercut", 5000, 0)
	pUnit:RegisterEvent("ShadowmoonChosen_Whirlwind", 11000, 0)
end

function ShadowmoonChosen_Uppercut(pUnit,Event)
	pUnit:FullCastSpellOnTarget(10966,pUnit:GetClosestPlayer())
end

function ShadowmoonChosen_Whirlwind(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38619,pUnit:GetClosestPlayer())
	pUnit:FullCastSpellOnTarget(38618,pUnit:GetClosestPlayer())
end

function ShadowmoonChosen_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function ShadowmoonChosen_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(22084, 1, "ShadowmoonChosen_OnEnterCombat")
RegisterUnitEvent(22084, 2, "ShadowmoonChosen_OnLeaveCombat")
RegisterUnitEvent(22084, 4, "ShadowmoonChosen_OnDied")

function ShadowmoonDarkweaver_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("ShadowmoonDarkweaver_Immolate", 4000, 0)
	pUnit:RegisterEvent("ShadowmoonDarkweaver_NetherInfusion", 35000, 3)
	pUnit:RegisterEvent("ShadowmoonDarkweaver_ShadowBolt", 2500, 0)
	pUnit:RegisterEvent("ShadowmoonDarkweaver_Shadowfury", 9000, 0)
end

function ShadowmoonDarkweaver_Immolate(pUnit,Event)
	pUnit:FullCastSpellOnTarget(11962,pUnit:GetClosestPlayer())
end

function ShadowmoonDarkweaver_NetherInfusion(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38446,pUnit:GetClosestPlayer())
end

function ShadowmoonDarkweaver_ShadowBolt(pUnit,Event)
	pUnit:FullCastSpellOnTarget(9613,pUnit:GetClosestPlayer())
end

function ShadowmoonDarkweaver_Shadowfury(pUnit,Event)
	pUnit:FullCastSpellOnTarget(35373,pUnit:GetClosestPlayer())
end

function ShadowmoonDarkweaver_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function ShadowmoonDarkweaver_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

function ShadowmoonDarkweaver_OnSpawn(pUnit,Event)
	pUnit:CastSpell(38442)
end

RegisterUnitEvent(22081, 1, "ShadowmoonDarkweaver_OnEnterCombat")
RegisterUnitEvent(22081, 2, "ShadowmoonDarkweaver_OnLeaveCombat")
RegisterUnitEvent(22081, 4, "ShadowmoonDarkweaver_OnDied")
RegisterUnitEvent(22081, 6, "ShadowmoonDarkweaver_OnSpawn")

function ShadowmoonRetainer_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("ShadowmoonRetainer_Shoot", 4000, 0)
end

function ShadowmoonRetainer_Shoot(pUnit,Event)
	pUnit:FullCastSpellOnTarget(15547,pUnit:GetRandomPlayer(3))
end

function ShadowmoonRetainer_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function ShadowmoonRetainer_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(22102, 1, "ShadowmoonRetainer_OnEnterCombat")
RegisterUnitEvent(22102, 2, "ShadowmoonRetainer_OnLeaveCombat")
RegisterUnitEvent(22102, 4, "ShadowmoonRetainer_OnDied")

function ShadowmoonSlayer_OnEnterCombat(pUnit,Event)
	pUnit:FullCastSpellOnTarget(3019,pUnit:GetClosestPlayer())
	pUnit:RegisterEvent("ShadowmoonSlayer_DebilitatingStrike", 20000, 0)
end

function ShadowmoonSlayer_DebilitatingStrike(pUnit,Event)
	pUnit:FullCastSpellOnTarget(37577,pUnit:GetClosestPlayer())
end

function ShadowmoonSlayer_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function ShadowmoonSlayer_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(22082, 1, "ShadowmoonSlayer_OnEnterCombat")
RegisterUnitEvent(22082, 2, "ShadowmoonSlayer_OnLeaveCombat")
RegisterUnitEvent(22082, 4, "ShadowmoonSlayer_OnDied")

function ShadowswornDrakonid_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("ShadowswornDrakonid_Cleave", 11000, 0)
	pUnit:RegisterEvent("ShadowswornDrakonid_MortalStrike", 15000, 0)
	pUnit:RegisterEvent("ShadowswornDrakonid_SunderArmor", 30000, 0)
end

function ShadowswornDrakonid_Cleave(pUnit,Event)
	pUnit:FullCastSpellOnTarget(15496,pUnit:GetClosestPlayer())
end

function ShadowswornDrakonid_MortalStrike(pUnit,Event)
	pUnit:FullCastSpellOnTarget(17547,pUnit:GetClosestPlayer())
end

function ShadowswornDrakonid_SunderArmor(pUnit,Event)
	pUnit:FullCastSpellOnTarget(16145,pUnit:GetClosestPlayer())
end

function ShadowswornDrakonid_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function ShadowswornDrakonid_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(22072, 1, "ShadowswornDrakonid_OnEnterCombat")
RegisterUnitEvent(22072, 2, "ShadowswornDrakonid_OnLeaveCombat")
RegisterUnitEvent(22072, 4, "ShadowswornDrakonid_OnDied")

function ShadowwingOwl_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("ShadowwingOwl_EagleClaw", 30000, 0)
end

function ShadowwingOwl_EagleClaw(pUnit,Event)
	pUnit:FullCastSpellOnTarget(15496,pUnit:GetClosestPlayer())
end

function ShadowwingOwl_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function ShadowwingOwl_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(22265, 1, "ShadowwingOwl_OnEnterCombat")
RegisterUnitEvent(22265, 2, "ShadowwingOwl_OnLeaveCombat")
RegisterUnitEvent(22265, 4, "ShadowwingOwl_OnDied")

function SkethylOwl_OnEnterCombat(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38254,pUnit:GetClosestPlayer())
	pUnit:RegisterEvent("SkethylOwl_TerrifyingScreech", 14000, 0)
end

function SkethylOwl_TerrifyingScreech(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38021,pUnit:GetClosestPlayer())
end

function SkethylOwl_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function SkethylOwl_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21450, 1, "SkethylOwl_OnEnterCombat")
RegisterUnitEvent(21450, 2, "SkethylOwl_OnLeaveCombat")
RegisterUnitEvent(21450, 4, "SkethylOwl_OnDied")

function SmithGorlunk_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("SmithGorlunk_Rend", 15000, 0)
	pUnit:RegisterEvent("SmithGorlunk_SunderArmor", 12000, 0)
end

function SmithGorlunk_Rend(pUnit,Event)
	pUnit:FullCastSpellOnTarget(13445,pUnit:GetClosestPlayer())
end

function SmithGorlunk_SunderArmor(pUnit,Event)
	pUnit:FullCastSpellOnTarget(13444,pUnit:GetClosestPlayer())
end

function SmithGorlunk_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function SmithGorlunk_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(22037, 1, "SmithGorlunk_OnEnterCombat")
RegisterUnitEvent(22037, 2, "SmithGorlunk_OnLeaveCombat")
RegisterUnitEvent(22037, 4, "SmithGorlunk_OnDied")

function SonOfCorok_OnEnterCombat(pUnit,Event)
	pUnit:FullCastSpellOnTarget(12612,pUnit:GetClosestPlayer())
	pUnit:RegisterEvent("SonOfCorok_Stomp", 15000, 0)
end

function SonOfCorok_Stomp(pUnit,Event)
	pUnit:FullCastSpellOnTarget(12612,pUnit:GetClosestPlayer())
end

function SonOfCorok_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function SonOfCorok_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(19824, 1, "SonOfCorok_OnEnterCombat")
RegisterUnitEvent(19824, 2, "SonOfCorok_OnLeaveCombat")
RegisterUnitEvent(19824, 4, "SonOfCorok_OnDied")

function SpawnOfUvuros_OnEnterCombat(pUnit,Event)
	pUnit:FullCastSpellOnTarget(36405,pUnit:GetClosestPlayer())
	pUnit:RegisterEvent("SpawnOfUvuros_Bite", 4000, 0)
	pUnit:RegisterEvent("SpawnOfUvuros_DoubleBreath", 15000, 0)
	pUnit:RegisterEvent("SpawnOfUvuros_Growl", 1000, 1)
	pUnit:RegisterEvent("SpawnOfUvuros_LavaBreath", 15000, 0)
	pUnit:RegisterEvent("SpawnOfUvuros_Stomp", 9000, 0)
end

function SpawnOfUvuros_Bite(pUnit,Event)
	pUnit:FullCastSpellOnTarget(27050,pUnit:GetClosestPlayer())
end

function SpawnOfUvuros_DoubleBreath(pUnit,Event)
	pUnit:FullCastSpellOnTarget(36406,pUnit:GetClosestPlayer())
end

function SpawnOfUvuros_Growl(pUnit,Event)
	pUnit:FullCastSpellOnTarget(14921,pUnit:GetClosestPlayer())
end

function SpawnOfUvuros_LavaBreath(pUnit,Event)
	pUnit:FullCastSpellOnTarget(58610,pUnit:GetClosestPlayer())
end

function SpawnOfUvuros_Stomp(pUnit,Event)
	pUnit:FullCastSpellOnTarget(36405,pUnit:GetClosestPlayer())
end

function SpawnOfUvuros_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function SpawnOfUvuros_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21108, 1, "SpawnOfUvuros_OnEnterCombat")
RegisterUnitEvent(21108, 2, "SpawnOfUvuros_OnLeaveCombat")
RegisterUnitEvent(21108, 4, "SpawnOfUvuros_OnDied")

function SpellboundTerrorguard_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("SpellboundTerrorguard_FelFlames", 8000, 0)
	pUnit:RegisterEvent("SpellboundTerrorguard_Hamstring", 20000, 3)
end

function SpellboundTerrorguard_FelFlames(pUnit,Event)
	pUnit:FullCastSpellOnTarget(37488,pUnit:GetClosestPlayer())
end

function SpellboundTerrorguard_Hamstring(pUnit,Event)
	pUnit:FullCastSpellOnTarget(31553,pUnit:GetClosestPlayer())
end

function SpellboundTerrorguard_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function SpellboundTerrorguard_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21908, 1, "SpellboundTerrorguard_OnEnterCombat")
RegisterUnitEvent(21908, 2, "SpellboundTerrorguard_OnLeaveCombat")
RegisterUnitEvent(21908, 4, "SpellboundTerrorguard_OnDied")

function SummonerSkartax_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("SummonerSkartax_Incinerate", 5000, 0)
	pUnit:RegisterEvent("SummonerSkartax_ShadowBolt", 9000, 0)
end

function SummonerSkartax_Incinerate(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38401,pUnit:GetClosestPlayer())
end

function SummonerSkartax_ShadowBolt(pUnit,Event)
	pUnit:FullCastSpellOnTarget(12471,pUnit:GetClosestPlayer())
end

function SummonerSkartax_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function SummonerSkartax_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21207, 1, "SummonerSkartax_OnEnterCombat")
RegisterUnitEvent(21207, 2, "SummonerSkartax_OnLeaveCombat")
RegisterUnitEvent(21207, 4, "SummonerSkartax_OnDied")

function SunfuryBloodLord_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("SunfuryBloodLord_DebilitatingStrike", 15000, 0)
	pUnit:RegisterEvent("SunfuryBloodLord_TorrentOfFlames", 5000, 0)
end

function SunfuryBloodLord_DebilitatingStrike(pUnit,Event)
	pUnit:FullCastSpellOnTarget(37577,pUnit:GetClosestPlayer())
end

function SunfuryBloodLord_TorrentOfFlames(pUnit,Event)
	pUnit:FullCastSpellOnTarget(36104,pUnit:GetClosestPlayer())
end

function SunfuryBloodLord_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function SunfuryBloodLord_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21743, 1, "SunfuryBloodLord_OnEnterCombat")
RegisterUnitEvent(21743, 2, "SunfuryBloodLord_OnLeaveCombat")
RegisterUnitEvent(21743, 4, "SunfuryBloodLord_OnDied")

function SunfuryEradicator_OnEnterCombat(pUnit,Event)
	pUnit:CastSpell(38008)
	pUnit:RegisterEvent("SunfuryEradicator_FlashHeal", 15000, 0)
end

function SunfuryEradicator_FlashHeal(pUnit,Event)
	pUnit:FullCastSpellOnTarget(17137,pUnit:GetRandomFriend())
end

function SunfuryEradicator_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function SunfuryEradicator_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21742, 1, "SunfuryEradicator_OnEnterCombat")
RegisterUnitEvent(21742, 2, "SunfuryEradicator_OnLeaveCombat")
RegisterUnitEvent(21742, 4, "SunfuryEradicator_OnDied")

function SunfurySummoner_OnEnterCombat(pUnit,Event)
	pUnit:CastSpell(13901)
	pUnit:RegisterEvent("SunfurySummoner_ArcaneBolt", 5000, 0)
	pUnit:RegisterEvent("SunfurySummoner_Blink", 1000, 1)
end

function SunfurySummoner_ArcaneBolt(pUnit,Event)
	pUnit:FullCastSpellOnTarget(13901,pUnit:GetRandomFriend())
end

function SunfurySummoner_Blink(pUnit,Event)
 if pUnit:GetHealthPct() == 4 then
	pUnit:CastSpell(36994)
end
end

function SunfurySummoner_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function SunfurySummoner_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21505, 1, "SunfurySummoner_OnEnterCombat")
RegisterUnitEvent(21505, 2, "SunfurySummoner_OnLeaveCombat")
RegisterUnitEvent(21505, 4, "SunfurySummoner_OnDied")

function SunfuryWarlock_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("SunfuryWarlock_Incinerate", 3000, 0)
	pUnit:RegisterEvent("SunfuryWarlock_ShadowBolt", 9000, 0)
end

function SunfuryWarlock_Incinerate(pUnit,Event)
	pUnit:FullCastSpellOnTarget(32707,pUnit:GetClosestPlayer())
end

function SunfuryWarlock_ShadowBolt(pUnit,Event)
	pUnit:FullCastSpellOnTarget(9613,pUnit:GetClosestPlayer())
end

function SunfuryWarlock_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function SunfuryWarlock_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21503, 1, "SunfuryWarlock_OnEnterCombat")
RegisterUnitEvent(21503, 2, "SunfuryWarlock_OnLeaveCombat")
RegisterUnitEvent(21503, 4, "SunfuryWarlock_OnDied")

function Terrormaster_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("Terrormaster_Cleave", 9000, 0)
	pUnit:RegisterEvent("Terrormaster_Fear", 24000, 0)
end

function Terrormaster_Cleave(pUnit,Event)
	pUnit:FullCastSpellOnTarget(15496,pUnit:GetClosestPlayer())
end

function Terrormaster_Fear(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38154,pUnit:GetClosestPlayer())
end

function Terrormaster_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Terrormaster_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21314, 1, "Terrormaster_OnEnterCombat")
RegisterUnitEvent(21314, 2, "Terrormaster_OnLeaveCombat")
RegisterUnitEvent(21314, 4, "Terrormaster_OnDied")

function Theras_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("Terrormaster_ManaBurn", 20000, 0)
	pUnit:RegisterEvent("Terrormaster_Metamorphosis", 1000, 1)
	pUnit:RegisterEvent("Terrormaster_Spellbreaker", 12000, 0)
end

function Theras_ManaBurn(pUnit,Event)
	pUnit:FullCastSpellOnTarget(39262,pUnit:GetClosestPlayer())
end

function Theras_Metamorphosis(pUnit,Event)
 if pUnit:GetHealthPct() == 49 then
	pUnit:CastSpell(36298)
end
end

function Theras_Spellbreaker(pUnit,Event)
	pUnit:FullCastSpellOnTarget(35871,pUnit:GetClosestPlayer())
end

function Theras_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Theras_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21168, 1, "Theras_OnEnterCombat")
RegisterUnitEvent(21168, 2, "Theras_OnLeaveCombat")
RegisterUnitEvent(21168, 4, "Theras_OnDied")

function TorlothTheMagnificent_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("TorlothTheMagnificent_Cleave", 10000, 0)
	pUnit:RegisterEvent("TorlothTheMagnificent_Shadowfury", 9000, 0)
	pUnit:RegisterEvent("TorlothTheMagnificent_SpellReflection", 12000, 0)
end

function TorlothTheMagnificent_Cleave(pUnit,Event)
	pUnit:FullCastSpellOnTarget(15284,pUnit:GetClosestPlayer())
end

function TorlothTheMagnificent_Shadowfury(pUnit,Event)
	pUnit:FullCastSpellOnTarget(39082,pUnit:GetClosestPlayer())
end

function TorlothTheMagnificent_SpellReflection(pUnit,Event)
	pUnit:CastSpell(33961)
end

function TorlothTheMagnificent_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function TorlothTheMagnificent_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(22076, 1, "TorlothTheMagnificent_OnEnterCombat")
RegisterUnitEvent(22076, 2, "TorlothTheMagnificent_OnLeaveCombat")
RegisterUnitEvent(22076, 4, "TorlothTheMagnificent_OnDied")

function Umberhowl_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("Umberhowl_ChillingHowl", 30000, 0)
	pUnit:RegisterEvent("Umberhowl_Snarl", 7000, 0)
end

function Umberhowl_ChillingHowl(pUnit,Event)
	pUnit:FullCastSpellOnTarget(32918,pUnit:GetClosestPlayer())
end

function Umberhowl_Snarl(pUnit,Event)
	pUnit:FullCastSpellOnTarget(32919,pUnit:GetClosestPlayer())
end

function Umberhowl_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Umberhowl_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21255, 1, "Umberhowl_OnEnterCombat")
RegisterUnitEvent(21255, 2, "Umberhowl_OnLeaveCombat")
RegisterUnitEvent(21255, 4, "Umberhowl_OnDied")

function Uvuros_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("Uvuros_Bite", 4000, 0)
	pUnit:RegisterEvent("Uvuros_DoubleBreath", 8000, 0)
	pUnit:RegisterEvent("Uvuros_Growl", 20000, 0)
	pUnit:RegisterEvent("Uvuros_LavaBreath", 10000, 0)
	pUnit:RegisterEvent("Uvuros_TerrifyingRoar", 27000, 0)
end

function Uvuros_Bite(pUnit,Event)
	pUnit:FullCastSpellOnTarget(27050,pUnit:GetClosestPlayer())
end

function Uvuros_DoubleBreath(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38361,pUnit:GetClosestPlayer())
end

function Uvuros_Growl(pUnit,Event)
	pUnit:FullCastSpellOnTarget(27047,pUnit:GetClosestPlayer())
end

function Uvuros_LavaBreath(pUnit,Event)
	pUnit:FullCastSpellOnTarget(58610,pUnit:GetClosestPlayer())
end

function Uvuros_TerrifyingRoar(pUnit,Event)
	pUnit:FullCastSpellOnTarget(37939,pUnit:GetClosestPlayer())
end

function Uvuros_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Uvuros_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21102, 1, "Uvuros_OnEnterCombat")
RegisterUnitEvent(21102, 2, "Uvuros_OnLeaveCombat")
RegisterUnitEvent(21102, 4, "Uvuros_OnDied")

function Uylaru_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("Uylaru_CorruptedSearingTotem", 20000, 0)
	pUnit:RegisterEvent("Uylaru_FlameShock", 16000, 0)
end

function Uylaru_CorruptedSearingTotem(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38581,pUnit:GetClosestPlayer())
end

function Uylaru_FlameShock(pUnit,Event)
	pUnit:FullCastSpellOnTarget(15039,pUnit:GetClosestPlayer())
end

function Uylaru_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Uylaru_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21710, 1, "Uylaru_OnEnterCombat")
RegisterUnitEvent(21710, 2, "Uylaru_OnLeaveCombat")
RegisterUnitEvent(21710, 4, "Uylaru_OnDied")

function ValzareqTheConqueror_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("Uylaru_Shoot", 2000, 3)
end

function ValzareqTheConqueror_Shoot(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38094,pUnit:GetClosestPlayer())
end

function ValzareqTheConqueror_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function ValzareqTheConqueror_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21979, 1, "ValzareqTheConqueror_OnEnterCombat")
RegisterUnitEvent(21979, 2, "ValzareqTheConqueror_OnLeaveCombat")
RegisterUnitEvent(21979, 4, "ValzareqTheConqueror_OnDied")

function Varedis_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("Varedis_CurseOfFlames", 120000, 0)
	pUnit:RegisterEvent("Varedis_Evasion", 24000, 0)
	pUnit:RegisterEvent("Varedis_ManaBurn", 9000, 0)
end

function Varedis_CurseOfFlames(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38010,pUnit:GetClosestPlayer())
end

function Varedis_Evasion(pUnit,Event)
	pUnit:CastSpell(37683)
end

function Varedis_ManaBurn(pUnit,Event)
	pUnit:FullCastSpellOnTarget(39262,pUnit:GetClosestPlayer())
end

function Varedis_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Varedis_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21178, 1, "Varedis_OnEnterCombat")
RegisterUnitEvent(21178, 2, "Varedis_OnLeaveCombat")
RegisterUnitEvent(21178, 4, "Varedis_OnDied")

function VhelKur_OnSpawn(pUnit,Event)
	pUnit:CastSpell(36553)
end

RegisterUnitEvent(21801, 6, "VhelKur_OnSpawn")

function VilewingChimaera_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("VilewingChimaera_FroststormBreath", 5000, 0)
	pUnit:RegisterEvent("VilewingChimaera_VenomSpit", 15000, 0)
end

function VilewingChimaera_FroststormBreath(pUnit,Event)
	pUnit:FullCastSpellOnTarget(55491,pUnit:GetClosestPlayer())
end

function VilewingChimaera_VenomSpit(pUnit,Event)
	pUnit:FullCastSpellOnTarget(16552,pUnit:GetClosestPlayer())
end

function VilewingChimaera_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function VilewingChimaera_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21879, 1, "VilewingChimaera_OnEnterCombat")
RegisterUnitEvent(21879, 2, "VilewingChimaera_OnLeaveCombat")
RegisterUnitEvent(21879, 4, "VilewingChimaera_OnDied")

function WarbringerRazuun_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("WarbringerRazuun_FelFireball", 3800, 0)
	pUnit:RegisterEvent("WarbringerRazuun_MindWarp", 45000, 1)
end

function WarbringerRazuun_FelFireball(pUnit,Event)
	pUnit:FullCastSpellOnTarget(35913,pUnit:GetClosestPlayer())
end

function WarbringerRazuun_MindWarp(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38047,pUnit:GetClosestPlayer())
end

function WarbringerRazuun_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function WarbringerRazuun_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21287, 1, "WarbringerRazuun_OnEnterCombat")
RegisterUnitEvent(21287, 2, "WarbringerRazuun_OnLeaveCombat")
RegisterUnitEvent(21287, 4, "WarbringerRazuun_OnDied")

function WildhammerScout_OnEnterCombat(pUnit,Event)
	pUnit:FullCastSpellOnTarget(33808,pUnit:GetClosestPlayer())
	pUnit:RegisterEvent("WildhammerScout_ThrowHammer", 6000, 0)
end

function WildhammerScout_ThrowHammer(pUnit,Event)
	pUnit:FullCastSpellOnTarget(33805,pUnit:GetClosestPlayer())
	pUnit:FullCastSpellOnTarget(33806,pUnit:GetClosestPlayer())
end

function WildhammerScout_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function WildhammerScout_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(19384, 1, "WildhammerScout_OnEnterCombat")
RegisterUnitEvent(19384, 2, "WildhammerScout_OnLeaveCombat")
RegisterUnitEvent(19384, 4, "WildhammerScout_OnDied")

function Wrathstalker_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("Wrathstalker_Cleave", 11000, 0)
end

function Wrathstalker_Cleave(pUnit,Event)
	pUnit:FullCastSpellOnTarget(33805,pUnit:GetClosestPlayer())
end

function Wrathstalker_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Wrathstalker_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21249, 1, "Wrathstalker_OnEnterCombat")
RegisterUnitEvent(21249, 2, "Wrathstalker_OnLeaveCombat")
RegisterUnitEvent(21249, 4, "Wrathstalker_OnDied")

function Xiri_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("Xiri_BlindingLight", 24000, 0)
end

function Xiri_OnSpawn(pUnit,Event)
	pUnit:RegisterEvent("Xiri_LightOfTheNaaru1", 20000, 0)
	pUnit:RegisterEvent("Xiri_LightOfTheNaaru2", 20000, 0)
	pUnit:RegisterEvent("Xiri_LightOfTheNaaru3", 20000, 0)
end

function Xiri_BlindingLight(pUnit,Event)
	pUnit:FullCastSpellOnTarget(33805)
end

function Xiri_LightOfTheNaaru1(pUnit,Event)
	pUnit:CastSpell(39828)
end

function Xiri_LightOfTheNaaru2(pUnit,Event)
	pUnit:CastSpell(39831)
end

function Xiri_LightOfTheNaaru3(pUnit,Event)
	pUnit:CastSpell(39832)
end

function Xiri_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(18528, 1, "Xiri_OnEnterCombat")
RegisterUnitEvent(18528, 1, "Xiri_OnLeaveCombat")
RegisterUnitEvent(18528, 4, "Xiri_OnDied")
RegisterUnitEvent(18528, 6, "Xiri_OnSpawn")

function Zandras_OnEnterCombat(pUnit,Event)
	pUnit:RegisterEvent("Zandras_FelShackles", 11000, 0)
end

function Zandras_FelShackles(pUnit,Event)
	pUnit:FullCastSpellOnTarget(38051,pUnit:GetClosestPlayer())
end

function Zandras_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function Zandras_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(21249, 1, "Zandras_OnEnterCombat")
RegisterUnitEvent(21249, 2, "Zandras_OnLeaveCombat")
RegisterUnitEvent(21249, 4, "Zandras_OnDied")

function ZuluhedTheWhacked_OnEnterCombat(pUnit,Event)
	pUnit:CastSpell(38853)
	pUnit:RegisterEvent("ZuluhedTheWhacked_DemonPortal", 35000, 0)
end

function ZuluhedTheWhacked_DemonPortal(pUnit,Event)
	pUnit:CastSpell(38876)
end

function ZuluhedTheWhacked_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
end

function ZuluhedTheWhacked_OnDied(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(11980, 1, "ZuluhedTheWhacked_OnEnterCombat")
RegisterUnitEvent(11980, 2, "ZuluhedTheWhacked_OnLeaveCombat")
RegisterUnitEvent(11980, 4, "ZuluhedTheWhacked_OnDied")