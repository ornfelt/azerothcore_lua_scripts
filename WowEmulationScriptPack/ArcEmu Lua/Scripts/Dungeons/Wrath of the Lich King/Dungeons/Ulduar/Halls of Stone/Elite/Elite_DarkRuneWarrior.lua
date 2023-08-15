--//////////////////////////////////
--//// © Holystone Productions  ////
--////     Cronic & Warfrost    ////
--////       Copy Right         ////
--////  Blizzlike Repack v 2.5  ////
--//////////////////////////////////

local DarkRuneWarrior = 27960

function DarkRuneWarrior_OnCombat(punit, event)
   punit:RegisterEvent("DarkRuneWarrior_Cleave", 10000, 1)
end

function DarkRuneWarrior_Cleave(punit, event)
   local plr = punit:GetClosestEnemy()
     if plr:GetDistanceYards(punit) < 5 then
	   punit:CastSpellOnTarget(42724, plr)
	   punit:RegisterEvent("DarkRuneWarrior_HeroicStrike", 10000, 1)
   end
end

function DarkRuneWarrior_HeroicStrike(punit, event)
   local plr = punit:GetClosestEnemy()
     if plr:GetDistanceYards(punit) < 5 then
	   punit:CastSpellOnTarget(53395, plr)
	   punit:RegisterEvent("DarkRuneWarrior_Cleave", 10000, 1)
   end
end

RegisterUnitEvent(DarkRuneWarrior, 1, "DarkRuneWarrior_OnCombat")