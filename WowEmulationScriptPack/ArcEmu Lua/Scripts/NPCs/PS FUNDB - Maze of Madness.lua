--Chest despawn > spawn next
function MazeM_chest1_despawn(Unit, Event, pMisc)
maze_chest_desp1 = 1
Unit:RemoveFromWorld()
end
RegisterGameObjectEvent(333332, 3, "MazeM_chest1_despawn")

--Chest despawn > spawn next
function MazeM_chest2_despawn(Unit, Event, pMisc)
maze_chest_desp2 = 1
Unit:RemoveFromWorld()
end
RegisterGameObjectEvent(333333, 3, "MazeM_chest2_despawn")

--Chest despawn > spawn next
function MazeM_chest3_despawn(Unit, Event, pMisc)
maze_chest_desp3 = 1
Unit:RemoveFromWorld()
end
RegisterGameObjectEvent(333334, 3, "MazeM_chest3_despawn")

function Maze_objects_check(Unit, Event)
if (maze_chest_desp1 == 1) then
maze_chest_desp1 = nil
local randnum = math.random(5)
if randnum == 1 then
Unit:SpawnGameObject(333332, -2420, -1145.09, 115.621, 4.48068, 36000000000)
elseif randnum == 2 then
Unit:SpawnGameObject(333332, -2442.87, -1131.97, 114.232, 3.43453, 36000000000)
elseif randnum == 3 then
Unit:SpawnGameObject(333332, -2299.49, -999.394, 123.613, 1.93381, 36000000000)
elseif randnum == 4 then
Unit:SpawnGameObject(333332, -2167.7, -1014.21, 124.563, 5.4114, 36000000000)
elseif randnum == 5 then
Unit:SpawnGameObject(333332, -2147.23, -1118.22, 120.896, 5.06583, 36000000000)
end
end

if (maze_chest_desp2 == 1) then
maze_chest_desp2 = nil
local randnum = math.random(5)
if randnum == 1 then
Unit:SpawnGameObject(333333, -2266.37, -1152.1, 112.942, 2.64327, 36000000000)
elseif randnum == 2 then
Unit:SpawnGameObject(333333, -2189.42, -1149.27, 113.182, 0.547415, 36000000000)
elseif randnum == 3 then
Unit:SpawnGameObject(333333, -2160.97, -962.88, 126.765, 4.76738, 36000000000)
elseif randnum == 4 then
Unit:SpawnGameObject(333333, -2218.16, -1040.26, 123.633, 3.38115, 36000000000)
elseif randnum == 5 then
Unit:SpawnGameObject(333333, -2259.46, -1078.46, 118.934, 2.28474, 36000000000)
end
end

if (maze_chest_desp3 == 1) then
maze_chest_desp3 = nil
local randnum = math.random(5)
if randnum == 1 then
Unit:SpawnGameObject(333334, -2180.16, -974.231, 125.645, 2.99666, 36000000000)
elseif randnum == 2 then
Unit:SpawnGameObject(333334, -2096.82, -973.916, 125.96, 3.90979, 36000000000)
elseif randnum == 3 then
Unit:SpawnGameObject(333334, -2368.68, -1182.34, 115.664, 4.91347, 36000000000)
elseif randnum == 4 then
Unit:SpawnGameObject(333334, -2324.52, -1024.06, 126.916, 5.94569, 36000000000)
elseif randnum == 5 then
Unit:SpawnGameObject(333334, -2251.98, -1031.28, 120.532, 2.07368, 36000000000)
end
end
end

function Maze_random_bot(Unit, Event)
local randnum = math.random(5)
end

function Maze_Obs_spawn(Unit, Event)
Unit:RegisterEvent("Maze_objects_check", 500, 0)
Unit:RegisterEvent("Maze_random_bot", 1000, 0)
Unit:SpawnGameObject(333332, -2420, -1145.09, 115.621, 4.48068, 36000000000)
Unit:SpawnGameObject(333333, -2266.37, -1152.1, 112.942, 2.64327, 36000000000)
Unit:SpawnGameObject(333334, -2180.16, -974.231, 125.645, 2.99666, 36000000000)
end
RegisterUnitEvent(555992, 18, "Maze_Obs_spawn")

function Teleporting_onUse3 (pUnit, Event, pMisc)
   pMisc:Teleport (169,-2334.39,-1044.45,129.599)
end
RegisterGameObjectEvent (5000002, 4, "Teleporting_onUse3")
