function OnCastThunderstorm1(event, plr, spellid)
if (spellid == 51490) then
plr:CastSpell(438)
end
end

RegisterServerHook(10, "OnCastThunderstorm1")