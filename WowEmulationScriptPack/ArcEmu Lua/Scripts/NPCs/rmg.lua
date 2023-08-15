function rmg_onspawn(pUnit, event)
        local tbig = pUnit:GetClosestPlayer()
        local tx = tbig:GetX()
        local ty = tbig:GetY()
        local tz = tbig:GetZ()
        local to = tbig:GetO()
pUnit:MoveTo(tx, ty, tz, to)
pUnit:ModThreat(tbig, 100)
end

function rmg_oncombat(pUnit, event)
pUnit:RegisterEvent("rmg_thrash", 10000, 0)
end

function rmg_thrash(pUnit, event)
local chooserand = math.random(1, 10)
 if chooserand <= 4 then
pUnit:CastSpell(3391)
else
end
end

function rmg_leavecombat(pUnit, event)
pUnit:RemoveEvents()
end

function rmg_died(pUnit, event)
pUnit:RemoveEvents()
end

RegisterUnitEvent(20001, 18, "rmg_onspawn")
RegisterUnitEvent(20001, 1, "rmg_oncombat")
RegisterUnitEvent(20001, 2, "rmg_leavecombat")
RegisterUnitEvent(20001, 4, "rmg_died")