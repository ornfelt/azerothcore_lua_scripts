--//////////////////////////////////
--//// © Holystone Productions  ////
--////     Cronic & Warfrost    ////
--////       Copy Right         ////
--////  Blizzlike Repack v 2.5  ////
--//////////////////////////////////

function Dk_MindFreeze_Fixe(event, plr, spellid)
   if (spellid == 47528) then
     Target = plr:GetSelection()
	   Target:InterruptSpell()
	  Target:AddAura(53550, 4000)
   end
end

RegisterServerHook(10, "Dk_MindFreeze_Fixe")