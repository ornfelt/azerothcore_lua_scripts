function OnCastThunderstorm3(event, plr, spellid)
if (spellid == 59158) then
plr:CastSpell(11903)
end
end

RegisterServerHook(10, "OnCastThunderstorm3")