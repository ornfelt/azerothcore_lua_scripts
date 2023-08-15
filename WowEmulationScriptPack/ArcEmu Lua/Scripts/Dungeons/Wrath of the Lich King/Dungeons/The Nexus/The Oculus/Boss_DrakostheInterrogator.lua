--//////////////////////////////////
--//// © Holystone Productions  ////
--////     Cronic & Warfrost    ////
--////       Copy Right         ////
--////  Blizzlike Repack v 2.5  ////
--//////////////////////////////////

local Drakos = 27654
local Bombs = 43307

function DrakostheInterrogator_OnCombat(punit, event)
  punit:SendChatMessage(14, 0, "The prisoners shall not go free. The word of Malygos is law!")
   punit:RegisterEvent("DrakostheInterrogator_ThunderingStomp", 15000, 0)
   punit:RegisterEvent("DrakostheInterrogator_MagicPull", 33000, 0)
end

function DrakostheInterrogator_ThunderingStomp(punit, event)
  punit:SendChatMessage(14, 0, "I will crush you!")
   punit:FullCastSpell(50774)
end

function DrakostheInterrogator_MagicPull(punit, event)
 punit:SendChatMessage(14, 0, "It is too late to run!")
   punit:FullCastSpell(51336)
  local plr = punit:GetRandomPlayer(0)
    local x = punit:GetX()
    local y = punit:GetY()
    local z = punit:GetZ()
    local o = punit:GetO()
  plr:MoveTo(x, y, z, o, 256)
   punit:RegisterEvent("DrakostheInterrogator_SpawnAdd", 5000, 1)
end

function DrakostheInterrogator_SpawnAdd(punit, event)
    local x = punit:GetX()
    local y = punit:GetY()
    local z = punit:GetZ()
    local o = punit:GetO()
  punit:SpawnCreature(43307, x+7, y+3, z+3, o, 14, 20000)
  punit:SpawnCreature(43307, x+4, y+1, z+2, o, 14, 20000)
  punit:SpawnCreature(43307, x+5, y+5, z+1, o, 14, 20000)
  punit:SpawnCreature(43307, x+3, y+7, z+2, o, 14, 20000)
  punit:SpawnCreature(43307, x+1, y+9, z+1, o, 14, 20000)
  punit:SpawnCreature(43307, x+2, y+3, z+3, o, 14, 20000)
  punit:SpawnCreature(43307, x+9, y+2, z+1, o, 14, 20000)
end

-- Bombs --

function DrakostheInterrogator_Bombs(punit, event)
  punit:Root()
  punit:RegisterEvent("DrakostheInterrogator_Bombs_Explogen", 5000, 1)
end

function DrakostheInterrogator_Bombs_Explogen(punit, event)
  punit:CastSpell(1449)
end

RegisterUnitEvent(Drakos, 1, "DrakostheInterrogator_OnCombat")
RegisterUnitEvent(Bombs, 18, "DrakostheInterrogator_Bombs")