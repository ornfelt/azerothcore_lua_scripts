--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function CounselorTalbot_OnCombat(Unit, Event)
Unit:RegisterEvent("CounselorTalbot_SoulBlast", 10000, 0)
Unit:RegisterEvent("CounselorTalbot_SoulDeflection", 12000, 0)
Unit:RegisterEvent("CounselorTalbot_VampiricBolt", 15000, 0)
end

function CounselorTalbot_SoulBlast(Unit, Event) 
Unit:FullCastSpellOnTarget(50992, Unit:GetMainTank()) 
end

function CounselorTalbot_SoulDeflection(Unit, Event) 
Unit:FullCastSpellOnTarget(51009, Unit:GetMainTank()) 
end

function CounselorTalbot_VampiricBolt(Unit, Event) 
Unit:FullCastSpellOnTarget(51016, Unit:GetMainTank()) 
end

function CounselorTalbot_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CounselorTalbot_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CounselorTalbot_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25301, 1, "CounselorTalbot_OnCombat")
RegisterUnitEvent(25301, 2, "CounselorTalbot_OnLeaveCombat")
RegisterUnitEvent(25301, 3, "CounselorTalbot_OnKilledTarget")
RegisterUnitEvent(25301, 4, "CounselorTalbot_OnDied")