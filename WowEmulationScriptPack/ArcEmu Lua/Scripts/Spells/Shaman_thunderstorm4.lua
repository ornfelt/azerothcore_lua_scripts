function OnCastThunderstorm1(event, plr, spellid)
if (spellid == 59159) then
plr:CastSpell(17531)
end
end

RegisterServerHook(10, "OnCastThunderstorm1")