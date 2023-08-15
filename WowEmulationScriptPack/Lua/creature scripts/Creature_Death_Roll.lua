local currentRoll = 200000
local deathrollBossID = 2326000
local made = false
local Strings = {
"HA! Look at those rolls!",
"Can't best the KING!",
"Give up now!",
"UNBEATABLE!",
"Puny rolls. Could be better.",
}

function deathrollSpawn (event, creature)
	if(made == false) then
	creature:SendUnitYell("YOU? YOU think you can out Deathroll ME? THE KING?",0)
		creature:RegisterEvent(CreatureRoll, 5000, 1)
		made = true
	end
end

function playerWin(event, delay, repeats, creature)
	GetPlayerByGUID(playersQueue[1][1]):Kill(creature)
	made = false
	currentRoll = 200000
end

function bossWin(event, delay, repeats, creature)
	creature:Kill(GetPlayerByGUID(playersQueue[1][1]))
	made = false
	currentRoll = 200000
end
function CreatureRoll(event, delay, repeats, creature)
	currentRoll = math.random(currentRoll)
	creature:SendUnitEmote("Trullax rolls a "..currentRoll)
	if(currentRoll == 1) then
		creature:SendUnitYell("Oh...Oh no...",0)
		creature:RegisterEvent(playerWin, 5000, 1)
	else
		creature:SendUnitYell(Strings[math.random(#Strings)],0)
		creature:RegisterEvent(PlayerRoll, 5000, 1)
	end
end



function PlayerRoll(event, delay, repeats, creature)
	currentRoll = math.random(currentRoll)
	GetPlayerByGUID(playersQueue[1][1]):TextEmote("rolls a "..currentRoll)
	if(currentRoll == 1) then
		creature:SendUnitYell("AHAHAHAHAHA! NOW YOU PAY UP!",0)
		creature:RegisterEvent(bossWin, 5000, 1)
	else
		creature:RegisterEvent(CreatureRoll, 5000, 1)
	end
end
RegisterCreatureEvent( deathrollBossID, 5, deathrollSpawn )