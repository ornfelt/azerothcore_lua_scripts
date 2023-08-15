--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ThaneTorvaldEriksson_OnCombat(Unit, Event)
Unit:RegisterEvent("ThaneTorvaldEriksson_ArcaneShot", 7000, 0)
Unit:RegisterEvent("ThaneTorvaldEriksson_MultiShot", 10000, 0)
Unit:RegisterEvent("ThaneTorvaldEriksson_Shoot", 6000, 0)
Unit:RegisterEvent("ThaneTorvaldEriksson_TorvaldsDeterrence", 11000, 0)
Unit:RegisterEvent("ThaneTorvaldEriksson_Volley", 13000, 0)
end

function ThaneTorvaldEriksson_ArcaneShot(Unit, Event) 
Unit:FullCastSpellOnTarget(34829, Unit:GetMainTank()) 
end

function ThaneTorvaldEriksson_MultiShot(Unit, Event) 
Unit:FullCastSpellOnTarget(52813, Unit:GetMainTank()) 
end

function ThaneTorvaldEriksson_Shoot(Unit, Event) 
Unit:FullCastSpellOnTarget(50512, Unit:GetMainTank()) 
end

function ThaneTorvaldEriksson_TorvaldsDeterrence(Unit, Event) 
Unit:CastSpell(57057) 
end

function ThaneTorvaldEriksson_Volley(Unit, Event) 
Unit:CastSpell(56843) 
end

function ThaneTorvaldEriksson_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ThaneTorvaldEriksson_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ThaneTorvaldEriksson_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27377, 1, "ThaneTorvaldEriksson_OnCombat")
RegisterUnitEvent(27377, 2, "ThaneTorvaldEriksson_OnLeaveCombat")
RegisterUnitEvent(27377, 3, "ThaneTorvaldEriksson_OnKilledTarget")
RegisterUnitEvent(27377, 4, "ThaneTorvaldEriksson_OnDied")