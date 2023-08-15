--//////////////////////////////////
--//// © Holystone Productions  ////
--////     Cronic & Warfrost    ////
--////       Copy Right         ////
--////  Blizzlike Repack v 2.5  ////
--//////////////////////////////////

local General = 28586
local Stormforged = 29240

function General_OnCombat(punit, event)
   punit:RegisterEvent("General_SpawnAdd", 400, 1)
   punit:RegisterEvent("General_BattleStance", 500, 1)
end

function General_BattleStance(punit, event)
  punit:RemoveEvents()
   punit:AddAura(41106, 0)
    punit:RegisterEvent("General_Cleave", 5000, 0)
	punit:RegisterEvent("General_BerserkerStance", 20000, 1)
end

function General_Cleave(punit, event)
   local target = punit:GetClosestEnemy()
    punit:CastSpellOnTarget(15284, target)
end

function General_BerserkerStance(punit, event)
  punit:RemoveEvents()
   punit:RemoveAura(41106)
    punit:AddAura(41107, 0)
	 punit:RegisterEvent("General_MortalStrike", 4000, 0)
	 punit:RegisterEvent("General_Whirlwind", 8000, 1)
	 punit:RegisterEvent("General_DefensiveStance", 20000, 1)
end

function General_MortalStrike(punit, event)
  local target = punit:GetClosestEnemy()
    punit:CastSpellOnTarget(16856, target)
end

function General_Whirlwind(punit, event)
  punit:FullCastSpell(52027)
  punit:Root()
  punit:RegisterEvent("General_UnRoot", 8000, 1)
end

function General_UnRoot(punit, event)
  punit:UnRoot()
end

function General_DefensiveStance(punit, event)
 punit:RemoveEvents()
  punit:RemoveAura(41107)
   punit:AddAura(41105, 0)
    punit:RegisterEvent("General_Intercept", 4000, 0)
	punit:RegisterEvent("General_KnockAway", 7000, 0)
	punit:RegisterEvent("General_SpellReflection", 10000, 0)
	punit:RegisterEvent("General_BattleStance", 20000, 1)
end

function General_Intercept(punit, event)
  local plr = punit:GetRandomPlayer(0)
    punit:CastSpellOnTarget(58769, plr)
     plr:AddAura(58747, 3000)
end

function General_KnockAway(punit, event)
   local plr = punit:GetClosestEnemy()
	   punit:CastSpellOnTarget(52029, plr)
  end

function General_SpellReflection(punit, event)
  punit:CastSpell(36096)
    punit:AddAura(36096, 8000)
end

function General_SpawnAdd(punit, event)
  local plr = punit:GetRandomPlayer(0)
    local x = plr:GetX()
	local y = plr:GetY()
	local z = plr:GetZ()
	local o = plr:GetO()
   punit:SpawnCreature(29240, x+4, y, z, o, 14, 360000)
   punit:SpawnCreature(29240, x, y+4, z, o, 14, 360000)
end

function StormforgedLieutenant_OnCombat(punit, event)
   punit:RegisterEvent("Stormforged_ArcWeld", 10000, 0)
   punit:RegisterEvent("Stormforged_RenewSteel", 7000, 0)
end

function Stormforged_ArcWeld(punit, event)
  local target = punit:GetRandomPlayer(0)
   punit:CastSpellOnTarget(59085, target)
    target:AddAura(59086, 10000)
   --target:Root()
   --punit:RegisterEvent("Target_UnRoot", 10000, 1)
end

function Target_UnRoot(punit, event)
   local target = punit:GetAITargets()
	target:Unroot()
end
	   

function Stormforged_RenewSteel(punit, event)
  local friend = punit:GetClosestFriend()
   if friend == 28586 then
    punit:CastSpellOnTarget(52774, friend)
  end
end

function General_OnLeaveCombat(punit, event)
  punit:RemoveEvents()
end

RegisterUnitEvent(General, 1, "General_OnCombat")
RegisterUnitEvent(General, 2, "General_OnLeaveCombat")
RegisterUnitEvent(Stormforged, 1, "StormforgedLieutenant_OnCombat")