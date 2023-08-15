-- Noth the Plaguebringer

function Noth_OnCombat(Unit, Event)
Unit:RegisterEvent("Noth_Curse", 20000, 0)
--Unit:RegisterEvent("Noth_Blink", 2500, 0)
Unit:RegisterEvent("Noth_Summon", 30000, 0)
end

function Noth_Curse(pUnit, Event)
local plr = pUnit:GetRandomPlayer(1)
if (plr ~= nil) then
pUnit:FullCastSpellOnTarget(29213, plr) -- <- Curse. Causes another debuff after 10 sec if not Decursed. Not yet found a way to make it work (if server itself doesnt support it)
end
end

--[[function Noth_Blink(Unit, Event)
	Unit:GetX()
	Unit:GetY()
	Unit:GetZ()
	Unit:GetO()
	if NothBlink = math.random(1, 2)
	if NothBlink == 1 then
		Unit:MoveTo(X,Y,Z,O)  -- Noth isn't supposed to change location but orientation yes just befor blink so it blinks a random direction. So this is the orientation 1. Doesnt require any modif.
		Unit:CastSpell(29211)
		Unit:ClearThreatList()
	end
    if KoboldTimer == 2 then
		Unit:MoveTo(X,Y,Z,Orientation)  -- This is the orientation 2. Has to be exact 180° different. This is pretty blizzlike since u cant bug this one.
		Unit:CastSpell(29211)
		Unit:ClearThreatList()
		end
	end
end]]--

function Noth_Summon(Unit,Event)
Unit:GetX()
Unit:GetY()
Unit:GetZ()
Unit:GetFaction()
Unit:SpawnCreature(16984,X,Y,Z,Faction,2000001) -- Works? Anyways. It summons a "Plagued Warrior" every 30seconds to fight for.
end

function Noth_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function Noth_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(15954, 1, "Noth_OnCombat")
RegisterUnitEvent(15954, 2, "Noth_OnLeaveCombat")
RegisterUnitEvent(15954, 4, "Noth_OnDied")

-- Plagued Warrior

function PW_OnCombat(Unit, Event)
Unit:RegisterEvent("PW_Cleave", 6000, 0)
end

function PW_Cleave(Unit, Event)
Unit:CastSpell(15496)
end

function PW_OnDied(Unit, Event)
Unit:RemoveEvents()
end

function PW_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
Unit:Despawn(0,0)
end

RegisterUnitEvent(16984, 1, "PW_OnCombat")
RegisterUnitEvent(16984, 2, "PW_OnLeaveCombat")
RegisterUnitEvent(16984, 4, "PW_OnDied")
RegisterUnitEvent(40441, 4, "grand_OnDeath")