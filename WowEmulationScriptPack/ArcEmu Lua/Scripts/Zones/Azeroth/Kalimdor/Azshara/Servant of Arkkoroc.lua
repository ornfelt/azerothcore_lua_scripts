--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ServantofArkkoroc_OnCombat(Unit, Event)
	Unit:RegisterEvent("ServantofArkkoroc_Trample", 5000, 0)
end

function ServantofArkkoroc_Trample(pUnit, Event) 
	pUnit:CastSpell(5568) 
end

function ServantofArkkoroc_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ServantofArkkoroc_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6143, 1, "ServantofArkkoroc_OnCombat")
RegisterUnitEvent(6143, 2, "ServantofArkkoroc_OnLeaveCombat")
RegisterUnitEvent(6143, 4, "ServantofArkkoroc_OnDied")