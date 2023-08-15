--[[ EredarTwins.Lua - Author: Shorts
********************************
*                                                            *
* The LUA++ Scripting Project        *
*                                                            *
********************************

This software is provided as free and open source by the
staff of The LUA++ Scripting Project, in accordance with 
the AGPL license. This means we provide the software we have 
created freely and it has been thoroughly tested to work for 
the developers, but NO GUARANTEE is made it will work for you 
as well. Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- LUA++ staff, April 15, 2008. ]]

--Lady Sacrolash AI Script--

function Lady_OnCombat(pUnit, Event)
	setvars(pUnit, {AlyDead=0, LadyDead=0});
	pUnit:RegisterEvent("Confounding_Blow",30000,0)
	pUnit:RegisterEvent("ShadowNova",35000,0)
	pUnit:RegisterEvent("ShadowBlades",15000,0)
	pUnit:RegisterEvent("DarkTouched",25000,0)
	pUnit:RegisterEvent("LadyPhase2", 1000, 0)
	pUnit:RegisterEvent("LadyEnrage", 360000, 1)
end

function LadyPhase2(pUnit, event)
	local args = getvars(pUnit);
	if (args.AlyDead == 1) then
		pUnit:SendChatMessage(14, 0, "Alythess! Your fire burns within me!")
		pUnit:PlaySoundToSet(12488)
		pUnit:RegisterEvent("LadyConflag",20000,0)
	end
end
		
function Lady_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()	
end

function Lady_OnKilledTarget(pUnit, Event)
	pUnit:SendChatMessage(12, 0, "Shadows, engulf!")
	pUnit:PlaySoundToSet(12486)
end

function Lady_OnDied(pUnit, Event)
	local args = getvars(pUnit);
	pUnit:RemoveEvents()
	pUnit:SendChatMessage(14, 0, "I... fade.")
	args.LadyDead=1;
	setvars(pUnit, args);
end

function ShadowFury(pUnit, Event)
	pUnit:CastSpell(45270)	
end

function ConfoundingBlow(pUnit, Event)
	pUnit:CastSpellOnTarget(45256, pUnitGetRandomTarget(0))	
end

function ShadowNova(pUnit, Event)
	pUnit:SendChatMessage(12, 0, "Shadow to the aid of fire!")
	pUnit:PlaySoundToSet(12485)
	pUnit:FullCastSpell(45329)	
end

function DarkStrike(pUnit, Event)
	pUnit:CastSpellOnTarget(45271, pUnit:GetRandomTarget(0))	
end

function ShadowBlades(pUnit, Event)
	pUnit:CastSpellOnTarget(45248, pUnit:GetMainTank())
	pUnit:RegisterEvent(Dark_Strike,1000,1)
end

function DarkTouched(pUnit, Event)
	pUnit:CastSpellOnTarget(45347, pUnit:GetRandomTarget(0))	
end

function LadyConflag(pUnit, event)
	pUnit:FullCastSpellOnTarget(45342, pUnit:GetMainTank())
end

function LadyEnrage(pUnit, event)
	pUnit:CastSpell(26662) --Same as Brutallus for now
end		

RegisterUnitEvent(25165, 1, "Lady_OnCombat")
RegisterUnitEvent(25165, 2, "Lady_OnLeaveCombat")
RegisterUnitEvent(25165, 3, "Lady_OnKilledTarget")
RegisterUnitEvent(25165, 4, "Lady_OnDied")

--Grand Warlock Alythess AI Script--

function Warlock_OnCombat(pUnit, Event)
	setvars(pUnit, {AlyDead=0, LadyDead=0});
	pUnit:RegisterEvent("Flame_Touched",15000,0)
	pUnit:RegisterEvent("Pyrogenics",1000,1)
	pUnit:RegisterEvent("Flame_Sear",20000,0)
	pUnit:RegisterEvent("Conflagration",20000,0)
	pUnit:RegisterEvent("WarlockPhase2", 1000, 0)
	pUnit:RegisterEvent("AlyEnrage", 360000, 1)
end

function WarlockPhase2(pUnit, event)
	local args = getvars(pUnit);
	if (args.LadyDead == 1) then
		pUnit:SendChatMessage(14, 0, "Sacrolash!")
		pUnit:PlaySoundToSet(12492)
		pUnit:RegisterEvent("AlyShadowNova",35000,0)
	end
end

function Warlock_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()	
end

function Warlock_OnKilledTarget(pUnit, Event)
	pUnit:SendChatMessage(13, 0, "Fire, consume!")	
end

function Warlock_OnDied(pUnit, Event)
	local args = getvars(pUnit);
	pUnit:RemoveEvents()
	pUnit:PlaySoundToSet(12494)
	args.AlyDead=1;
	setvars(pUnit, args);
end

function FlameSear(pUnit, Event)
	pUnit:CastSpellOnTarget(46771, pUnit:GetRandomTarget(0))
	pUnit:CastSpellOnTarget(46771, pUnit:GetRandomTarget(0))
	pUnit:CastSpellOnTarget(46771, pUnit:GetRandomTarget(0))
end

function Conflagration(pUnit, Event)
	pUnit:PlaySoundToSet(12489)
	pUnit:SendChatMessage(13, 0, "Fire to the aid of shadow!")
	pUnit:FullCastSpellOnTarget(45342, pUnit:GetMainTank())	
end

function FlameTouched(pUnit, Event)
	pUnit:CastSpellOnTarget(45348, pUnit:GetRandomTarget(0))	
end

function Pyrogenics(pUnit, Event)
	pUnit:CastSpell(45230)	
end

function AlyShadowNova(pUnit, Event)
	pUnit:FullCastSpell(45329)	
end


function AlyEnrage(pUnit, event)
	pUnit:CastSpell(26662) -- Same as Brutallus for now
end

RegisterUnitEvent(25166, 1, "Warlock_OnCombat")
RegisterUnitEvent(25166, 2, "Warlock_OnLeaveCombat")
RegisterUnitEvent(25166, 3, "Warlock_OnKilledTarget")
RegisterUnitEvent(25166, 4, "Warlock_OnDied")
