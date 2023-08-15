--//////////////////////////////////
--//// © Holystone Productions  ////
--////     Cronic & Warfrost    ////
--////       Copy Right         ////
--////  Blizzlike Repack v 2.5  ////
--//////////////////////////////////

local MaidenofGrief = 27975
local StormofGrief = 43304

function MaidenofGrief_OnCombat(punit, event)
    punit:SendChatMessage(14, 0, "You shouldn't have come...now you will die!")
   punit:RegisterEvent("MaidenofGrief_PartingSorrow", 20000, 0)
   punit:RegisterEvent("MaidenofGrief_PillarofWoe", 31000, 0)
   punit:RegisterEvent("MaidenofGrief_ShockofSorrow", 14000, 0)
   punit:RegisterEvent("MaidenofGrief_StormofGrief", 10000, 0)
end

function MaidenofGrief_PartingSorrow(punit, event)
  local target = punit:GetRandomPlayer(0)
    punit:FullCastSpellOnTarget(59723, target)
end

function MaidenofGrief_PillarofWoe(punit, event)
  local player = punit:GetRandomPlayer(0)
    punit:FullCastSpellOnTarget(50761, player)
	  local plr = punit:GetSelection()
	  plr:AddAura(50761, 10000)
end

function MaidenofGrief_ShockofSorrow(punit, event)
   local target = punit:GetAITarges()
     punit:FullCastSpell(50760)
	   target:AddAura(50760, 6000)
end

function MaidenofGrief_StormofGrief(punit, event)
  local plr = punit:GetRandomPlayer(0)
   local x = plr:GetX()
   local y = plr:GetY()
   local z = plr:GetZ()
   local o = plr:GetO()
  punit:SpawnCreature(43304, x, y, z, o, 14, 22000)
end

RegisterUnitEvent(MaidenofGrief, 1, "MaidenofGrief_OnCombat")

-- StormofGrief -- 

function StormofGrief_OnSpawn(punit, event)
   punit:SetFaction(14)
   punit:Root()
   punit:SetModel(11686)
   punit:SetScale(3)
    punit:RegisterEvent("StormofGrief_Aoe_Cast", 1000, 1)
end

function StormofGrief_Aoe_Cast(punit, event)
   local x = punit:GetX()
   local y = punit:GetY()
   local z = punit:GetZ()
  punit:CastSpellAoF(x, y, z, 50752)
end

RegisterUnitEvent(StormofGrief, 18, "StormofGrief_OnSpawn")