--//////////////////////////////////
--//// © Holystone Productions  ////
--////     Cronic & Warfrost    ////
--////       Copy Right         ////
--////  Blizzlike Repack v 2.5  ////
--//////////////////////////////////

function BlisteringSteamrager_OnCombat(punit, event)
   punit:RegisterEvent("BlisteringSteamrager_SteamBlast", 20000, 0)
end

function BlisteringSteamrager_SteamBlast(punit, event)
   punit:CastSpell(52531)
end

RegisterUnitEvent(28583, 1, "BlisteringSteamrager_OnCombat")