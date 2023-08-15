-- Debug naked
-- http://www.wowhead.com/spell=54844 (X-Ray Specs)
local function debug_naked(event, player, msg, lang, typ)
    if(msg == "#naked" and not player:IsDead()) then
	player:CastSpell(player, 54844, false)
        local aura = player:GetAura(54844)
        if (aura ~= nil) then
            aura:Remove()
        end
    end
end 

RegisterPlayerEvent(18, debug_naked)