function Player_OnEnterWorld(event, plr)
	if plr:HasAura(69127) == true then
		plr:RemoveAura(69127)
	end
	if plr:GetMapId() == 631 then
		if (plr:HasAura(69127) == false) then
			SetDBCSpellVar(69127, "c_is_flags", 0x01000)
			plr:CastSpell(69127)
		end
	end
end
RegisterServerHook(4, "Player_OnEnterWorld")