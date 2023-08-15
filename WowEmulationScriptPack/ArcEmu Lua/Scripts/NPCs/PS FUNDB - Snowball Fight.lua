function Snowball_Throw(Unit, Event)
Snowball_chance = math.random(7)
if Snowball_chance == 4 then
Snowball_Target = Unit:GetRandomPlayer(0)
if Snowball_Target ~= nil then
Unit:FullCastSpellOnTarget(25686, Snowball_Target)
end
end
end

function reg_Snowball_Throw(Unit, Event)
local Throw_speed = math.random(2000)
local Throw_speed2 = 2000 + Throw_speed
Unit:RegisterEvent("Snowball_Throw", Throw_speed2, 0)
end
RegisterUnitEvent(13636, 18, "reg_Snowball_Throw")

function Teleporting_onUse6 (pUnit, Event, pMisc)
   pMisc:Teleport (0,-4599.9,-1719.46,503.476)
end
RegisterGameObjectEvent (5000005, 4, "Teleporting_onUse6")

function Teleporting_onUse7 (pUnit, Event, pMisc)
   pMisc:Teleport (0,-5046.72,-1718.23,547.551)
end
RegisterGameObjectEvent (5000006, 4, "Teleporting_onUse7")

function Teleporting_onUse8 (pUnit, Event, pMisc)
   pMisc:Teleport (0,-5129.34,-1701.82,548.914)
end
RegisterGameObjectEvent (5000007, 4, "Teleporting_onUse8")
