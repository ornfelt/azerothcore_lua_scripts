function OnCastThunderstorm2(event, plr, spellid)
if (spellid == 59156) then
plr:CastSpell(2023)
end
end

RegisterServerHook(10, "OnCastThunderstorm2")