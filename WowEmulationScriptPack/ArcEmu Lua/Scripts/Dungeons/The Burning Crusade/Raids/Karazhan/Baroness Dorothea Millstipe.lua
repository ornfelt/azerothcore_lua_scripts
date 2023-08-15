-- 2D's LUA

function BaronessDorotheaMillstipe_OnCombat(Unit, event)
Unit:RegisterEvent("BaronessDorotheaMillstipe_Pain",8000,0)
Unit:RegisterEvent("BaronessDorotheaMillstipe_MindFlay",15000,0)
Unit:RegisterEvent("BaronessDorotheaMillstipe_ManaBurn",20000,0)
Unit:RegisterEvent("BaronessDorotheaMillstipe_Repeat",25000,0)
end

function BaronessDorotheaMillstipe_Pain(pUnit, event)
pUnit:FullCastSpellOnTarget(34441, pUnit:GetMainTank())
end

function BaronessDorotheaMillstipe_MindFlay(pUnit, event)
local plr = pUnit:GetRandomPlayer(0)
if (plr ~= nil) then
pUnit:FullCastSpellOnTarget(37276, plr)
end
end

function BaronessDorotheaMillstipe_ManaBurn(pUnit, event)
local plr = pUnit:GetRandomPlayer(0)
if (plr ~= nil) then
pUnit:FullCastSpellOnTarget(37159, plr)
end
end

function BaronessDorotheaMillstipe_Repeat(Unit, event)
Unit:RegisterEvent("BaronessDorotheaMillstipe_Pain",8000,0)
Unit:RegisterEvent("BaronessDorotheaMillstipe_MindFlay",15000,0)
Unit:RegisterEvent("BaronessDorotheaMillstipe_ManaBurn",20000,0)
end

function BaronessDorotheaMillstipe_Pain(pUnit, event)
pUnit:FullCastSpellOnTarget(34441, pUnit:GetMainTank())
end

function BaronessDorotheaMillstipe_MindFlay(pUnit, event)
local plr = pUnit:GetRandomPlayer(0)
if (plr ~= nil) then
pUnit:FullCastSpellOnTarget(37276, plr)
end
end

function BaronessDorotheaMillstipe_ManaBurn(pUnit, event)
local plr = pUnit:GetRandomPlayer(0)
if (plr ~= nil) then
pUnit:FullCastSpellOnTarget(37159, plr)
end
end

function BaronessDorotheaMillstipe_OnDied(Unit)
Unit:RemoveEvents()
end

function BaronessDorotheaMillstipe_OnLeaveCombat(Unit)
Unit:RemoveEvents()
end

RegisterUnitEvent(19875,1,"BaronessDorotheaMillstipe_OnCombat")
RegisterUnitEvent(19875,2,"BaronessDorotheaMillstipe_Repeat")
RegisterUnitEvent(19875,3,"BaronessDorotheaMillstipe_OnLeaveCombat")
RegisterUnitEvent(19875,4,"BaronessDorotheaMillstipe_OnDied")