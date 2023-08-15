GIANTBEETLETHINGIE = {}

ADD = {}

ADDID = {
[1] = {930028},  -- Groundbugs (4?)
[2] = {932026}, -- Tornado - 920027 for two.
[3] = {930029}, -- Fly Bugs ( 30?)
[4] = {930030} -- Crocolisk (3?)
}

local Id = 930014

function GIANTBEETLETHINGIE.OnCombat(pUnit, event, plr) -- Plr = puller
	pUnit:RegisterEvent("GIANTBEETLETHINGIE.Phase2", 1000, 0)
	pUnit:RegisterEvent("GIANTBEETLETHINGIE.Swarm", math.random(50000, 80000), 0)
	pUnit:RegisterEvent("GIANTBEETLETHINGIE.Storm", math.random(50000, 80000), 0)
	pUnit:RegisterEvent("GIANTBEETLETHINGIE.Crocs", math.random(30000, 60000), 0)
	pUnit:RegisterEvent("GIANTBEETLETHINGIE.Bugs", math.random(30000, 60000), 0)
end

function GIANTBEETLETHINGIE.Crocs(pUnit, event)
	ADD[3] = {PerformIngameSpawn(1, 0, -11231.752930, -1496.538086, 2.521633, 1.558267, 14, 0), PerformIngameSpawn(1, 0, -11222.255859, -1497.274292, 2.130605, 1.589683, 14, 0), PerformIngameSpawn(1, 0, -11212.136719, -1497.083130, 2.130605, 1.589683, 14, 0)}
end
	
function GIANTBEETLETHINGIE.CrocsOnSpawn(pUnit, event)
	pUnit:MoveTo(-11224.845703, -1431.519653, -5.517431, 1.609318)
end
	
function GIANTBEETLETHINGIE.Storm(pUnit, event)
	ADD[2] = PerformIngameSpawn(1, 0, -11220.600586, -1402.813110, -14.401114, 1.566907, 35, 20000)
end

function GIANTBEETLETHINGIE.StormOnSpawn(pUnit, event)
	pUnit:MoveTo(-11221.834961, -1479.872192, 3.576720, 0)
	local plrs = pUnit:GetInRangePlayers()
	for _,v in pairs(plrs) do
		if(v:GetDistance(pUnit) <= 5) then
			v:CastSpell(25656)
			end
	   end
end

function GIANTBEETLETHINGIE.Swarm(pUnit, event)
	local Swarm = Alive
	pUnit:CastSpell(48142)
	pUnit:RegisterEvent("GIANTBEETLETHINGIE.EnrageCheck", 1000, 0)
	local choice = math.random(1, 3)
	if(choice == 1) then
		ADD[1] = PerformIngameSpawn(1, ADDID[1], 0, -11250.250000, -1447.817261, 2.649752, 0.065058, 14, 0)
	elseif(choice == 2) then
		ADD[1] = PerformIngameSpawn(1, ADDID[1], 0, -11189, -1446, 1, 3, 14, 0)
	elseif(choice == 3) then
		ADD[1] = PerformIngameSpawn(1, ADDID[1], 0, -11186, -1390, 0, 3, 14, 0)
		end
end

function GIANTBEETLETHINGIE.EnrageCheck(pUnit, event)
	if(Swarm == Dead) then
		pUnit:RemoveAura(48142)
		pUnit:RemoveEvents()
		end
end

function GIANTBEETLETHINGIE.SwarmAdd(pUnit, event)
	pUnit:CastSpell(35471)
end


function GIANTBEETLETHINGIE.SwarmDie(pUnit, event)
	Swarm = Dead
	pUnit:RemoveEvents()
	pUnit:Despawn(0, 5000)
end

function GIANTBEETLETHINGIE.LeaveCombat(pUnit, event)
	pUnit:RemoveEvents()
	ADD[1]:Despawn(0, 1000)
	ADD[2]:Despawn(0, 1000)
	ADD[3]:Despawn(0, 1000)
end

RegisterUnitEvent(930030, 18, "GIANTBEETLETHINGIE.CrocsOnSpawn")
RegisterUnitEvent(932026, 18, "GIANTBEETLETHINGIE.StormOnSpawn")
RegisterUnitEvent(Id, 1, "GIANTBEETLETHINGIE.OnCombat") 
RegisterUnitEvent(930028, 18, "GIANTBEETLETHINGIE.SwarmAdd")
RegisterUnitEvent(930028, 4, "GIANTBEETLETHINGIE.SwarmDie")
RegisterUnitEvent(Id, 2, "GIANTBEETLETHINGIE.LeaveCombat")

