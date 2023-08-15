--[[
16926	PS_Krick_Aggro01
16927	PS_Krick_Slay01
16928	PS_Krick_Slay02
16929	PS_Krick_OrderStop01
16930	PS_Krick_OrderBlowup01
16931	PS_Krick_Target01
16932	PS_Krick_Target02
16933	PS_Krick_Target03
16934	PS_Krick_Event01
16935	PS_Krick_Event02
16936	PS_Krick_Event03
16937	PS_Krick_Event04
16938	PS_Krick_Attack
16939	PS_Krick_Wound
16940	PS_Krick_WoundCrit
]]--

function Ick_OnCombat (pUnit, Event)
pUnit:SendChatMessage(14, 0, "Our work must not be interrupted! Ick take care of them!")
pUnit:PlaySoundToSet(16926)
pUnit:RegisterEvent("Ick_Toxicwaste", 14000, 0)
pUnit:RegisterEvent("Ick_Explosivebarrage", 32000, 0)
pUnit:RegisterEvent("Ick_Poisionnova", 43000, 0)
pUnit:RegisterEvent("Ick_Pursuit", 25000, 0)
pUnit:RegisterEvent("Ick_Pustulant", 20000, 0)
end

function Ick_Toxicwaste (pUnit, Event)
pUnit:CastSpellOnTarget (70436, pUnit:GetRandomPlayer(0))
end

function Ick_Explosivebarrage (pUnit, Event)
pUnit:Root()
pUnit:FullCastSpellOnTarget (69012, pUnit:GetRandomPlayer(0))
pUnit:SendChatMessage (14, 0, "Enough Moving Around! Hold still while I blow them all up!")
pUnit:PlaySoundToSet(16929)
pUnit:RegisterEvent("Ick_UnRoot", 18000, 0)
end

function Ick_UnRoot (pUnit, Event)
pUnit:UnRoot()
end

function Ick_Poisonnova (pUnit, Event)
pUnit:FullCastSpellOnTarget (68989, pUnit:GetRandomPlayer(0))
pUnit:SendChatMessage (14, 0, "Quickly! Poison them all while they're still close!")
pUnit:PlaySoundToSet(16930)
end

function Ick_Pursuit (pUnit, Event)
local RandomTalk=math.random(1, 3);
	if(Pursuit == 1) then
		pUnit:SendChatMessage(14, 0, "I've changed my mind...go get that one instead!")
		pUnit:PlaySoundToSet(16932)
	elseif(Pursuit == 2) then
		pUnit:PlaySoundToSet(16933)
		pUnit:SendChatMessage(14, 0, "What are you attacking him for? The dangerous one is over there, fool!")
	elseif(Pursuit == 3) then
		pUnit:SendChatMessage (14, 0, "No, that one! That one! Get that one!")
		pUnit:PlaySoundToSet(16931)
		punit:RegisterEvent("Ick_Pursuitconfusion", 6000, 1)
	end
	pUnit:Root()
	pUnit:FullCastSpellOnTarget (68987, pUnit:GetRandomPlayer(0))
end

function Ick_Pursuitconfusion (pUnit, Event)
	pUnit:UnRoot()
	pUnit:CastSpell(69029)
	pUnit:RegisterEvent("Ick_Pustulant", 20000, 0)
end

function Ick_Pustulant (pUnit, Event)
	pUnit:FullCastSpellOnTarget (69581, pUnit:GetRandomPlayer(0))
end

function Ick_OnKillPlr (pUnit, Event)
local PlrDeath=math.random(1, 2);
	if PlrDeath == 1 then
		pUnit:SendChatMessage(14, 0, "Arms and legs are in short supply! Thanks for your contribution!")
		pUnit:PlaySoundToSet(16928)
	elseif PlrDeath == 2 then
		pUnit:SendChatMessage(14, 0, "Ooh...We could probably use these parts!")
		pUnit:PlaySoundToSet(16927)
	end
end

function Ick_OnDeath (pUnit, Event)
	pUnit:SpawnCreature(36794, 857.188, 123.257, 510.006, 3.54895, 35, 59100, 0, 0, 0, 0, 0)
	pUnit:SpawnCreature(36993, 857.188, 123.257, 510.006, 3.54895, 35, 6000000, 0, 0, 0, 0, 0)
	pUnit:SpawnCreature(36477, 857.188, 123.257, 510.006, 3.54895, 35, 43500, 0, 0, 0, 0, 0)
	pUnit:RemoveEvents()
end

function Ick_OnLeaveCombat (pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(36476, 1, "Ick_OnCombat")
RegisterUnitEvent(36476, 2, "Ick_OnLeaveCombat")
RegisterUnitEvent(36476, 3, "Ick_OnKillPlr")
RegisterUnitEvent(36476, 4, "Ick_OnDeath")