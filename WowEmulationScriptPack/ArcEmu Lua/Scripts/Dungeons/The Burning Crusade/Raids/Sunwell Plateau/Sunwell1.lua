--Phase1

function Fel_Cleave(pUnit, Event)
	pUnit:CastSpellOnTarget(31345, pUnit:GetMainTank())
end

function Fel_Corrosion(pUnit, Event)
	pUnit:FullCastSpellOnTarget(45866, pUnit:GetMainTank())
end

function Fel_NoxiousFumes(pUnit, Event)
	pUnit:FullCastSpell(45738)
end

function Fel_GasNova(pUnit, Event)
	pUnit:FullCastSpell(45855)
end

function Fel_Berserk(pUnit, Event)
	pUnit:SendChatMessage(14, 0, "No more hesitation! Your fates are written! ")
        pUnit:PlaySoundToSet(12482)
	pUnit:FullCastSpell(46587)
end

function Fel_Encapsulate(pUnit, Event)
	pUnit:SendChatMessage(14, 0, "I am stronger than ever before!")
        pUnit:PlaySoundToSet(12479)
	pUnit:CastSpellOnTarget(45665, pUnit:GetRandomTarget(0))
end

function Fel_OnCombat(pUnit, Event)
	pUnit:SendChatMessage(14, 0, "Glory to Kil'jaeden! Death to all who oppose!")
        pUnit:PlaySoundToSet(12477)
	pUnit:RegisterEvent("Fel_Cleave",20000,0)
	pUnit:RegisterEvent("Fel_Corrosion",36000,0)
	pUnit:RegisterEvent("Fel_NoxiousFumes",27000,0)
	pUnit:RegisterEvent("Fel_GasNova",30000,0)
	pUnit:RegisterEvent("Fel_Berserk",600000,0)
	pUnit:RegisterEvent("Fel_Encapsulate",45000,0)
	pUnit:RegisterEvent("Phase2",75000,1)
end

function Fel_OnLeaveCombat(pUnit, Event)
	
end

function Fel_OnKilledTarget(pUnit, Event)
	local Choice=math.random(1,2)
	if Choice==1 then
		pUnit:SendChatMessage(14, 0, "I kill for the master!")
                pUnit:PlaySoundToSet(12480)  
	elseif Choice==2 then
		pUnit:SendChatMessage(14, 0, "The end has come!")
                pUnit:PlaySoundToSet(12481)
	end
end

function Fel_OnDied(pUnit, Event)
	pUnit:SendChatMessage(14, 0, "Kil'jaeden... will... prevail...")
        pUnit:PlaySoundToSet(12483)
	pUnit:RemoveEvents()
end


--Phase2

function Phase2(pUnit, Event)
end


function Fel_DemonicVapor(pUnit, Event)
	local x = pUnit:GetX()
	local y = pUnit:GetY()
	local z = pUnit:GetZ()
	local o = pUnit:GetO()
	pUnit:SendChatMessage(14, 0, "Choke on your final breath!")
        pUnit:PlaySoundToSet(12478)
	pUnit:CastSpell(45402)
	pUnit:SpawnCreature(30170, x-1, y, z, o, 14, o)
	pUnit:SpawnCreature(30170, x+1, y, z, o, 14, o)
	pUnit:SpawnCreature(30170, x, y-1, z, o, 14, o)
	pUnit:SpawnCreature(30170, x, y+1, z, o, 14, o)
	pUnit:SpawnCreature(30170, x-3, y, z, o, 14, o)
	pUnit:SpawnCreature(30170, x+3, y, z, o, 14, o)
end

RegisterUnitEvent(25038, 1, "Fel_OnCombat")
RegisterUnitEvent(25038, 2, "Fel_OnLeaveCombat")
RegisterUnitEvent(25038, 3, "Fel_OnKilledTarget")
RegisterUnitEvent(25038, 4, "Fel_OnDied")