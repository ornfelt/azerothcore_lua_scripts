function Theadron_OnCombat(Unit, Event) 
Unit:SendChatMessage(14, 0, "You shall burn in the fires of hell!!!")
Unit:RegisterEvent("Theadron_pyroblast", 35000, 100)
Unit:RegisterEvent("Theadron_blast_wave", 25000, 100)
Unit:RegisterEvent("Theadron_scorch", 14000, 100)
end

function Theadron_pyroblast(pUnit, Event) 
pUnit:FullCastSpellOnTarget(33938, pUnit:GetRandomPlayer(0)) 
end

function Theadron_blast_wave(pUnit, Event) 
pUnit:FullCastSpellOnTarget(33933, pUnit:GetRandomPlayer(0)) 
end

function Theadron_scorch(pUnit, Event) 
pUnit:FullCastSpellOnTarget(27074, pUnit:GetRandomPlayer(0)) 
end

RegisterUnitEvent(200001, 1, "Theadron_OnCombat")