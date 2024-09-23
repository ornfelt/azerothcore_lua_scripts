local DiceBossID = 2326100
local timeDice = 555554
local lifeDice = 555555
local deathDice = 555556
local timer = 41
local make = false
local event1 = 0
local event2 = 0
local event3 = 0
local event4 = 0
local diceSpawns = {
{-11819.562,12005.715,88.839,1.0},
{-11833.695,11990.640,88.839,1.0},
{-11815.444,11982.158,88.839,1.0},
{-11796.832,11993.004,88.839,1.0},
{-11793.320,12006.438,88.839,1.0},
{-11806.783,12010.675,88.839,1.0},
{-11814.535,11992.551,88.839,1.0},
{-11828.813,11986.741,88.839,1.0},
{-11837.870,11994.74,88.839,1.0},
{-11813.545,11982.158,88.839,1.0},
}

local timeClick = {
"How did you go back in time?",
"What sorcery was that?"
}

local deathClick = {
"Ugh, i'll make you pay for that one!",
"You'll pay for that one...with TIME!",
"That one will cost you!"
}

local lifeClick = {
"What? Who left those laying around?",
"No, No, No! Don't heal!"
}
function diceStart(event, creature)
		creature:AddAura(39258,creature)
		--GetPlayerByGUID(playersQueue[1][1]):SummonGameObject( deathDice, diceSpawns[choice][1], diceSpawns[choice][2], diceSpawns[choice][3], diceSpawns[choice][4],10)
		event1 = creature:RegisterEvent(TimeDiceSpawn, {9000,11000}, 0)
		event2 = creature:RegisterEvent(LifeDiceSpawn, {15000,25000}, 0)
		event3 = creature:RegisterEvent(DeathDiceSpawn, {10000,12000}, 0)
		event4 = creature:RegisterEvent(counter,1000,0)
end

function TimeDiceSpawn(event, delay, repeats, creature)
	local choice = math.random(#diceSpawns)
	GetPlayerByGUID(playersQueue[1][1]):SummonGameObject( timeDice, diceSpawns[choice][1], diceSpawns[choice][2], diceSpawns[choice][3], diceSpawns[choice][4],10)
end

function LifeDiceSpawn(event, delay, repeats, creature)
	local choice = math.random(#diceSpawns)
	GetPlayerByGUID(playersQueue[1][1]):SummonGameObject( lifeDice, diceSpawns[choice][1], diceSpawns[choice][2], diceSpawns[choice][3], diceSpawns[choice][4],10)
end

function DeathDiceSpawn(event, delay, repeats, creature)
	local choice = math.random(#diceSpawns)
	GetPlayerByGUID(playersQueue[1][1]):SummonGameObject( deathDice, diceSpawns[choice][1], diceSpawns[choice][2], diceSpawns[choice][3], diceSpawns[choice][4],10)
end

function counter (event, delay, repeats, creature)
	if(make == false) then
		timer = timer-1
		creature:SendUnitYell( timer,0 )
		if(timer <= 0) then
			creature:SendUnitYell("You fail.",0)
			creature:RemoveEventById(event1)
			creature:RemoveEventById(event2)
			creature:RemoveEventById(event3)
			creature:RemoveEventById(event4)
			event4 = 0
			timer = 41
			creature:Kill(GetPlayerByGUID(playersQueue[1][1]))
		end
	else
		make = false
	end
end

function timeDiceClick(event, go, player)
	go:Despawn()
	local creaturerange = GetPlayerByGUID(playersQueue[1][1]):GetCreaturesInRange( 150, DiceBossID )
	for i in pairs(creaturerange) do
		creaturerange[i]:SendUnitYell(timeClick[math.random(#timeClick)],0)
	end
	timer = timer + 8
end

function lifeDiceClick(event, go, player)
	go:Despawn()
	local creaturerange = GetPlayerByGUID(playersQueue[1][1]):GetCreaturesInRange( 150, DiceBossID )
	for i in pairs(creaturerange) do
		creaturerange[i]:SendUnitYell(lifeClick[math.random(#lifeClick)],0)
	end
	GetPlayerByGUID(playersQueue[1][1]):CastSpell(GetPlayerByGUID(playersQueue[1][1]),25840,true)
	timer = timer - 1
end

function deathDiceClick(event, go, player)
	go:Despawn()
	local creaturerange = GetPlayerByGUID(playersQueue[1][1]):GetCreaturesInRange( 150, DiceBossID )
	for i in pairs(creaturerange) do
		local maxhp = creaturerange[i]:GetMaxHealth()
		GetPlayerByGUID(playersQueue[1][1]):DealDamage(creaturerange[i],maxhp/6)
		creaturerange[i]:SendUnitYell(deathClick[math.random(#deathClick)],0)
	end
	timer = timer - 2
end

function diceDeath (event, creature, killer)
	creature:RemoveEventById(event1)
	creature:RemoveEventById(event2)
	creature:RemoveEventById(event3)
	creature:RemoveEventById(event4)
	event4 = 0
	timer = 41
end


RegisterCreatureEvent( DiceBossID, 4, diceDeath )
RegisterCreatureEvent( DiceBossID, 22, diceStart )
RegisterGameObjectEvent( timeDice, 14, timeDiceClick )
RegisterGameObjectEvent( lifeDice, 14, lifeDiceClick )
RegisterGameObjectEvent( deathDice, 14, deathDiceClick )