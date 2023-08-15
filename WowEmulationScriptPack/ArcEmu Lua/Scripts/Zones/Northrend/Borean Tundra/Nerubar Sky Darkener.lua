--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function NerubarSkyDarkener_OnCombat(Unit, Event)
Unit:RegisterEvent("NerubarSkyDarkener_VenomSpit", 8000, 0)
Unit:RegisterEvent("NerubarSkyDarkener_WebBolt", 10000, 0)
end

function NerubarSkyDarkener_VenomSpit(Unit, Event) 
Unit:FullCastSpellOnTarget(45577, Unit:GetMainTank()) 
end

function NerubarSkyDarkener_WebBolt(Unit, Event) 
Unit:FullCastSpellOnTarget(45587, Unit:GetMainTank()) 
end

function NerubarSkyDarkener_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function NerubarSkyDarkener_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function NerubarSkyDarkener_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25451, 1, "NerubarSkyDarkener_OnCombat")
RegisterUnitEvent(25451, 2, "NerubarSkyDarkener_OnLeaveCombat")
RegisterUnitEvent(25451, 3, "NerubarSkyDarkener_OnKilledTarget")
RegisterUnitEvent(25451, 4, "NerubarSkyDarkener_OnDied")