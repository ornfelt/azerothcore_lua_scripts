--//////////////////////////////////
--////   Holystone Productions  ////
--////       Copy Right         ////
--////  Blizzlike Repack v 1.0  ////
--//////////////////////////////////

local NerubarBroodkeeper = 36725

function NerubarBroodkeeper_OnCombat(punit, event)
   punit:RegisterEvent("Crypt_Scarabs", 10000, 1)
end

function Crypt_Scarabs(punit, event)
   punit:FullCastSpell(70965)
   punit:RegisterEvent("Dark_Mending", 8000, 1)
end

function Dark_Mending(punit, event)
   local target = punit:GetRandomFriend()
   if (target ~= nil) then
   punit:FullCastSpellOnTarget(71020, target)
   punit:RegisterEvent("Crypt_Scarabs", 8000, 1)
 end
end

function NerubarBroodkeeper_OnLeaveCombat(punit, event)
   punit:RemoveEvents()
end

RegisterUnitEvent(NerubarBroodkeeper, 1, "NerubarBroodkeeper_OnCombat")
RegisterUnitEvent(NerubarBroodkeeper, 2, "NerubarBroodkeeper_OnLeaveCombat")