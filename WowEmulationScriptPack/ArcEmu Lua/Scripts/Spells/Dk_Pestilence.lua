--//////////////////////////////////
--//// © Holystone Productions  ////
--////     Cronic & Warfrost    ////
--////       Copy Right         ////
--////  Blizzlike Repack v 2.5  ////
--//////////////////////////////////

function Dk_Pestilence_Fixe(event, plr, spellid)
   if (spellid == 50842) then
     Target = plr:GetSelection()
	if Target ~= nil then
	  Target:AddAura(55078, 21000)
	  Target:AddAura(55095, 21000)
	 FriendTarget = Target:GetInRangeFriends()
	  if FriendTarget:GetDistanceYards(Target) < 10 then
	   FriendTarget:AddAura(55078, 21000)
	   FriendTarget:AddAura(55095, 21000)
      end
    end
  end
end

RegisterServerHook(10, "Dk_Pestilence_Fixe")