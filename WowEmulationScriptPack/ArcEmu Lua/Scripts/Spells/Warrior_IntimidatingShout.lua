--//////////////////////////////////
--//// © Holystone Productions  ////
--////     Cronic & Warfrost    ////
--////       Copy Right         ////
--////  Blizzlike Repack v 2.5  ////
--//////////////////////////////////

function IntimidatingShout_Spell_Fixe(event, plr, spellid)
   if (spellid == 65930) then
     Enemy = plr:GetClosestEnemy()
	  if plr:GetDistanceYards(Enemy) < 15 then
	 Enemy:AddAura(5782, 8000)
	end
  end
end

RegisterServerHook(10, "IntimidatingShout_Spell_Fixe")