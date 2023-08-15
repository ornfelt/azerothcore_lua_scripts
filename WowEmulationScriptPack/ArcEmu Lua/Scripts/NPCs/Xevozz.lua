function Xevozz_OnCombat(Unit, Event) 
Unit:SendChatMessage(12, 0, "gre reh azool!!! ")
Unit:RegisterEvent("Xevozz_ArcaneBarrageVolley1", 5000, 20)
Unit:RegisterEvent("Xevozz_SummonEtherealSphere1", 10000, 20)
Unit:RegisterEvent("Xevozz_ArcaneBarrageVolley2", 15000, 20)
Unit:RegisterEvent("Xevozz_SummonEtherealSphere2", 20000, 20)
Unit:RegisterEvent("Xevozz_ArcaneBuffet1", 25000, 20)
Unit:RegisterEvent("Xevozz_SummonEtherealSphere3", 30000, 20)
Unit:RegisterEvent("Xevozz_ArcaneBuffet2", 35000, 20)
Unit:RegisterEvent("Xevozz_SummonEtherealSphere4", 40000, 20)
end

function Xevozz_ArcaneBarrageVolley1(pUnit, Event) 
pUnit:CastSpell(54202, pUnit:GetRandomPlayer(4)) 
end

function Xevozz_SummonEtherealSphere1(pUnit, Event) 
pUnit:CastSpell(54138, pUnit:GetMainTank()) 
end

function Xevozz_ArcaneBarrageVolley2(pUnit, Event) 
pUnit:CastSpell(59483, pUnit:GetRandomPlayer(4)) 
end

function Xevozz_SummonEtherealSphere2(pUnit, Event) 
pUnit:CastSpell(61337, pUnit:GetRandomPlayer(6)) 
end

function Xevozz_ArcaneBuffet1(pUnit, Event) 
pUnit:CastSpell(54226, pUnit:GetRandomPlayer(7)) 
end

function Xevozz_SummonEtherealSphere3(pUnit, Event) 
pUnit:CastSpell(61338, pUnit:GetRandomPlayer(4)) 
end

function Xevozz_ArcaneBuffet2(pUnit, Event) 
pUnit:CastSpell(59485, pUnit:GetMainTank()) 
end

function Xevozz_SummonEtherealSphere4(pUnit, Event) 
pUnit:CastSpell(61339, pUnit:GetRandomPlayer(7)) 
end

function Xevozz_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
Unit:SendChatMessage(12, 0, "Hen it far gone zee!!") 
end

function Xevozz_OnDied(Unit, Event) 
Unit:RemoveEvents() 
Unit:SendChatMessage(12, 0, "bizzz vor nii gunnji.......gunnji") 
end

function Xevozz_OnKilledTarget(Unit, Event) 
Unit:SendChatMessage(12, 0, "ha ha ha fik gha athol, fik gha athol!!!") 
end

RegisterUnitEvent(29266, 1, "Xevozz_OnCombat")
RegisterUnitEvent(29266, 2, "Xevozz_OnLeaveCombat")
RegisterUnitEvent(29266, 3, "Xevozz_OnKilledTarget")
RegisterUnitEvent(29266, 4, "Xevozz_OnDied")