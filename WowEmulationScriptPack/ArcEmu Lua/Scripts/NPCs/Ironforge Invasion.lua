--< Made by Utsjitimmie and Underseas from projectsilvermoon.net >--
--< Ask us if you want to use (a part of) this script in your repack >--
--< You may ofcourse use it for your server without asking >--

--< Have fun!
--< ~Utsjitimmie
--< ~Underseas

IF_started = 0
wave1_done = 0
ghoul_id = 0
RegisterUnitEvent(10002643, 18, "reg_IF_inv_control")

function IF_inv_reset(pUnit, Event)
IF_started = 0
wave1_done = 0
ghoul_id = 0
end

function wave1(pUnit, Event)
pUnit:SpawnCreature(10002644, -5093.67, -740.237, 469.57, 6.18894, 14, 3600000)
pUnit:SpawnCreature(10002644, -5091, -743.926, 470.423, 6.12062, 14, 3600000)
pUnit:SpawnCreature(10002644, -5092.5, -736.363, 469.805, 6.024, 14, 3600000)
pUnit:SpawnCreature(10002644, -5094.77, -747.439, 469.619, 6.02008, 14, 3600000)
pUnit:SpawnCreature(10002645, -5097.92, -745.42, 468.488, 6.13239, 14, 3600000)
pUnit:SpawnCreature(10002645, -5097.52, -738.074, 468.53, 6.19051, 14, 3600000)
pUnit:SpawnCreature(10002646, -5104.27, -741.552, 466.809, 0.0172758, 14, 3600000)
pUnit:SpawnCreature(10002646, -5101.92, -734.626, 467.391, 0.00627809, 14, 3600000)
end

function ghoul(pUnit, Event)
ghoul_id = ghoul_id + 1
pUnit:RegisterEvent("ghoul_wp_end", 10, 0)
if ghoul_id == 1 then
pUnit:CreateCustomWaypointMap()
pUnit:CreateWaypoint(-5076.15, -744.624, 474.911, 0, 0, 0, 571)
pUnit:CreateWaypoint(-5056.67, -756.358, 484.471, 0, 0, 0, 571)
pUnit:CreateWaypoint(-5047.06, -773.969, 492.999, 0, 0, 0, 571)
pUnit:CreateWaypoint(-5043.68, -782.428, 494.934, 0, 0, 0, 571)
pUnit:CreateWaypoint(-5022.74, -829.943, 495.32, 0, 0, 0, 571)
pUnit:CreateWaypoint(-4987, -874.548, 496.984, 0, 0, 0, 571)
elseif ghoul_id == 2 then
pUnit:CreateCustomWaypointMap()
pUnit:CreateWaypoint(-5071.72, -749.624, 477.379, 0, 0, 0, 571)
pUnit:CreateWaypoint(-5052.93, -770.293, 490.726, 0, 0, 0, 571)
pUnit:CreateWaypoint(-5048.83, -780.983, 494.531, 0, 0, 0, 571)
pUnit:CreateWaypoint(-5024.49, -832.359, 495.319, 0, 0, 0, 571)
pUnit:CreateWaypoint(-5021.85, -835.777, 496.985, 0, 0, 0, 571)
pUnit:CreateWaypoint(-4988.28, -876.438, 496.984, 0, 0, 0, 571)
elseif ghoul_id == 3 then
pUnit:CreateCustomWaypointMap()
pUnit:CreateWaypoint(-5075.51, -740.097, 474.634, 0, 0, 0, 571)
pUnit:CreateWaypoint(-5053.49, -753.613, 484.465, 0, 0, 0, 571)
pUnit:CreateWaypoint(-5041.81, -770.897, 493.331, 0, 0, 0, 571)
pUnit:CreateWaypoint(-5041.15, -781.275, 494.894, 0, 0, 0, 571)
pUnit:CreateWaypoint(-5020.77, -828.459, 495.44, 0, 0, 0, 571)
pUnit:CreateWaypoint(-4985.27, -873.521, 496.984, 0, 0, 0, 571)
elseif ghoul_id == 4 then
pUnit:CreateCustomWaypointMap()
pUnit:CreateWaypoint(-5094.42, -747.534, 469.719, 0, 0, 0, 571)
pUnit:CreateWaypoint(-5078.46, -751.119, 475.211, 0, 0, 0, 571)
pUnit:CreateWaypoint(-5065.23, -759.724, 483.026, 0, 0, 0, 571)
pUnit:CreateWaypoint(-5055.9, -779.029, 493.38, 0, 0, 0, 571)
pUnit:CreateWaypoint(-5049.11, -791.555, 495.125, 0, 0, 0, 571)
pUnit:CreateWaypoint(-5026.76, -832.747, 495.318, 0, 0, 0, 571)
pUnit:CreateWaypoint(-5023.67, -836.582, 496.984, 0, 0, 0, 571)
pUnit:CreateWaypoint(-4990.93, -876.806, 496.984, 0, 0, 0, 571)
end
end
RegisterUnitEvent(10002644, 18, "ghoul")

function ghoul_wp_end(pUnit, Event)
if pUnit:GetX() > -4991 then
pUnit:DestroyCustomWaypointMap()
end
end

function IF_inv_control(pUnit, Event)
if IF_started == 1 and wave1_done == 0 then
wave1_done = 1
pUnit:RegisterEvent("wave1",10,1)
pUnit:RegisterEvent("IF_inv_reset", 3600000, 1)
end
end

function reg_IF_inv_control(pUnit, Event)
pUnit:RegisterEvent("IF_inv_control", 10, 0)
end
