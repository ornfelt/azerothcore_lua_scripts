--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TyrandeWhisperwind_OnCombat(	Unit, Event)
	Unit:RegisterEvent("TyrandeWhisperwind_Cleave", 12000, 0)
	Unit:RegisterEvent("TyrandeWhisperwind_Moonfire", 18000, 0)
	Unit:RegisterEvent("TyrandeWhisperwind_SearingArrow", 20000, 0)
	Unit:RegisterEvent("TyrandeWhisperwind_Starfall", 25000, 0)
end

function TyrandeWhisperwind_Cleave(	Unit, Event) 
	Unit:CastSpell(20691) 
end

function TyrandeWhisperwind_Moonfire(	Unit, Event) 
	Unit:FullCastSpellOnTarget(20690, 	Unit:GetMainTank()) 
end

function TyrandeWhisperwind_SearingArrow(	Unit, Event) 
	Unit:FullCastSpellOnTarget(20688, 	Unit:GetMainTank()) 
end

function TyrandeWhisperwind_Starfall(	Unit, Event) 
	Unit:CastSpell(20687) 
end

function TyrandeWhisperwind_OnLeaveCombat(	Unit, Event) 
	Unit:RemoveEvents() 
end

function TyrandeWhisperwind_OnDied(	Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(7999, 1, "TyrandeWhisperwind_OnCombat")
RegisterUnitEvent(7999, 2, "TyrandeWhisperwind_OnLeaveCombat")
RegisterUnitEvent(7999, 4, "TyrandeWhisperwind_OnDied")