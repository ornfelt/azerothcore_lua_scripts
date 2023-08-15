--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function CaptainEmmyMalin_OnCombat(Unit, Event)
Unit:RegisterEvent("CaptainEmmyMalin_FrostNova", 10000, 0)
Unit:RegisterEvent("CaptainEmmyMalin_Frostbolt", 8000, 0)
Unit:RegisterEvent("CaptainEmmyMalin_IceLance", 3000, 0)
end

function CaptainEmmyMalin_FrostNova(Unit, Event) 
Unit:CastSpell(11831) 
end

function CaptainEmmyMalin_Frostbolt(Unit, Event) 
Unit:FullCastSpellOnTarget(20792, Unit:GetMainTank()) 
end

function CaptainEmmyMalin_IceLance(Unit, Event) 
Unit:FullCastSpellOnTarget(49906, Unit:GetMainTank()) 
end

function CaptainEmmyMalin_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CaptainEmmyMalin_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CaptainEmmyMalin_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26762, 1, "CaptainEmmyMalin_OnCombat")
RegisterUnitEvent(26762, 2, "CaptainEmmyMalin_OnLeaveCombat")
RegisterUnitEvent(26762, 3, "CaptainEmmyMalin_OnKilledTarget")
RegisterUnitEvent(26762, 4, "CaptainEmmyMalin_OnDied")