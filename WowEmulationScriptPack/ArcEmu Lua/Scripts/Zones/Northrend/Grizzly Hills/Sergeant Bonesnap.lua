--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SergeantBonesnap_OnCombat(Unit, Event)
Unit:RegisterEvent("SergeantBonesnap_DemoralizingShout", 3000, 1)
Unit:RegisterEvent("SergeantBonesnap_HeroicStrike", 5000, 0)
Unit:RegisterEvent("SergeantBonesnap_Intercept", 9000, 0)
end

function SergeantBonesnap_DemoralizingShout(Unit, Event) 
Unit:CastSpell(13730) 
end

function SergeantBonesnap_HeroicStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(25710, Unit:GetMainTank()) 
end

function SergeantBonesnap_Intercept(Unit, Event) 
Unit:FullCastSpellOnTarget(27577, Unit:GetMainTank()) 
end

function SergeantBonesnap_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SergeantBonesnap_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SergeantBonesnap_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27493, 1, "SergeantBonesnap_OnCombat")
RegisterUnitEvent(27493, 2, "SergeantBonesnap_OnLeaveCombat")
RegisterUnitEvent(27493, 3, "SergeantBonesnap_OnKilledTarget")
RegisterUnitEvent(27493, 4, "SergeantBonesnap_OnDied")