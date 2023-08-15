--//////////////////////////////////
--//// © Holystone Productions  ////
--////     Cronic & Warfrost    ////
--////       Copy Right         ////
--////  Blizzlike Repack v 2.5  ////
--//////////////////////////////////

local Sjonnir = 27978

function SjonnirTheIronshaper_OnCombat(punit, event)
  punit:RegisterEvent("Sjonnir_ChainLightning", 7000, 0)
  punit:RegisterEvent("Sjonnir_LightningRing", 5000, 0)
  punit:RegisterEvent("Sjonnir_LightningShield", 28000, 0)
  punit:RegisterEvent("Sjonnir_StaticCharge", 500, 0)
  punit:RegisterEvent("Sjonnir_Frenzy", 600000, 1)
end

function Sjonnir_ChainLightning(punit, event)
 local plr = punit:GetRandomPlayer(0)
 local plrfr = plr:GetClosestFriend()
 local plrfrr = plrfr:GetClosestFriend()
  punit:CastSpellOnTarget(50830, plr)
   plr:CastspellOnTarget(50830, plrfr)
     plrfr:CastSpellOnTarget(50830, plrfrr)
end
	
function Sjonnir_LightningRing(punit, event)
  local plr = punit:GetRandomPlayer(0)
    punit:CastSpellOnTarget(50841, plr)
	 plr:AddAura(50841, 15000)
end

function Sjonnir_LightningShield(punit, event)
  punit:CastSpell(59845)
   punit:AddAura(59845, 600000)
end

function Sjonnir_StaticCharge(punit, event)
  local plr = punit:GetClosestEnemy()
    if punit:GetDistanceYards(plr) < 3 then
	  plr:AddAura(50835, 10000)
	end
end

function Sjonnir_Frenzy(punit, event)
  punit:CastSpell(28747)
end

RegisterUnitEvent(Sjonnir, 1, "SjonnirTheIronshaper_OnCombat")