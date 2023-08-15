function Ambrose_OnSpawn(pUnit, event)
	pUnit:EquipWeapons(47500, 0, 0)
	pUnit:CastSpell(63396)
	pUnit:SetMaxMana(159760)
	pUnit:SetMana(159760)
	local dungeon = pUnit:GetDungeonDifficulty()
	if(dungeon == 0) then
		pUnit:SetMaxHealth(189000)
		pUnit:SetHealth(189000)
	elseif(dungeon == 1) then
		pUnit:SetMaxHealth(315000)
		pUnit:SetHealth(315000)
	end
end
			
RegisterUnitEvent(12000, 18, "Ambrose_OnSpawn")

function Marshal_OnSpawn(pUnit, event)
	pUnit:EquipWeapons(12584, 18825, 0)
	pUnit:CastSpell(62594)
	local dungeon = pUnit:GetDungeonDifficulty()
		if(dungeon == 0) then
			pUnit:SetMaxHealth(214000)
			pUnit:SetHealth(214000)
		elseif(dungeon == 1) then
			pUnit:SetMaxHealth(325000)
			pUnit:SetHealth(325000)
			end
end
			
RegisterUnitEvent(12004, 18, "Marshal_OnSpawn")

function Lana_OnSpawn(pUnit, event)
	pUnit:EquipWeapons(42244, 42244, 0)
	pUnit:CastSpell(63427)
	local dungeon = pUnit:GetDungeonDifficulty()
		if(dungeon == 0) then
			pUnit:SetMaxHealth(189000)
			pUnit:SetHealth(189000)
		elseif(dungeon == 1) then
			pUnit:SetMaxHealth(290000)
			pUnit:SetHealth(290000)
			end
end

RegisterUnitEvent(12003, 18, "Lana_OnSpawn")

function Jaelyne_OnSpawn(pUnit, event)
	pUnit:CastSpell(63406)
	local dungeon = pUnit:GetDungeonDifficulty()
		if(dungeon == 0) then
			pUnit:SetMaxHealth(189000)
			pUnit:SetHealth(189000)
		elseif(dungeon == 1) then
			pUnit:SetMaxHealth(290000)
			pUnit:SetHealth(290000)
			end
end

RegisterUnitEvent(12002, 18, "Jaelyne_OnSpawn")

function Colosus_OnSpawn(pUnit, event)
	pUnit:EquipWeapons(42354, 42566, 0)
	pUnit:CastSpell(63423)
	pUnit:SetMaxMana(159760)
	pUnit:SetMana(159760)
	local dungeon = pUnit:GetDungeonDifficulty()
		if(dungeon == 0) then
			pUnit:SetMaxHealth(189000)
			pUnit:SetHealth(189000)
		elseif(dungeon == 1) then
			pUnit:SetMaxHealth(294000)
			pUnit:SetHealth(294000)
			end
end

RegisterUnitEvent(12001, 18, "Colosus_OnSpawn")

function Eressea_OnSpawn(pUnit, event)
	pUnit:EquipWeapons(48414, 0, 0)
	pUnit:CastSpell(63403)
	pUnit:SetMaxMana(159760)
	pUnit:SetMana(159760)
	local dungeon = pUnit:GetDungeonDifficulty()
		if(dungeon == 0) then
			pUnit:SetMaxHealth(189000)
			pUnit:SetHealth(189000)
		elseif(dungeon == 1) then
			pUnit:SetMaxHealth(315000)
			pUnit:SetHealth(315000)
			end
end
			
RegisterUnitEvent(12005, 18, "Eressea_OnSpawn")

function Runok_OnSpawn(pUnit, event)
	pUnit:EquipWeapons(42354, 42566, 0)
	pUnit:CastSpell(63436)
	pUnit:SetMaxMana(159760)
	pUnit:SetMana(159760)
	local dungeon = pUnit:GetDungeonDifficulty()
		if(dungeon == 0) then
			pUnit:SetMaxHealth(189000)
			pUnit:SetHealth(189000)
		elseif(dungeon == 1) then
			pUnit:SetMaxHealth(315000)
			pUnit:SetHealth(315000)
			end
end
			
RegisterUnitEvent(12006, 18, "Runok_OnSpawn")

function Zultore_OnSpawn(pUnit, event)
	pUnit:CastSpell(63399)
	local dungeon = pUnit:GetDungeonDifficulty()
		if(dungeon == 0) then
			pUnit:SetMaxHealth(189000)
			pUnit:SetHealth(189000)
		elseif(dungeon == 1) then
			pUnit:SetMaxHealth(290000)
			pUnit:SetHealth(290000)
			end
end

RegisterUnitEvent(12007, 18, "Zultore_OnSpawn")

function Deathstalker_OnSpawn(pUnit, event)
	pUnit:EquipWeapons(42244, 42244, 0)
	pUnit:CastSpell(63430)
	local dungeon = pUnit:GetDungeonDifficulty()
		if(dungeon == 0) then
			pUnit:SetMaxHealth(189000)
			pUnit:SetHealth(189000)
		elseif(dungeon == 1) then
			pUnit:SetMaxHealth(290000)
			pUnit:SetHealth(290000)
			end
end

RegisterUnitEvent(12008, 18, "Deathstalker_OnSpawn")

function Mokra_OnSpawn(pUnit, event)
	pUnit:EquipWeapons(23464, 18826, 0)
	pUnit:CastSpell(63433)
	local dungeon = pUnit:GetDungeonDifficulty()
		if(dungeon == 0) then
			pUnit:SetMaxHealth(214000)
			pUnit:SetHealth(214000)
		elseif(dungeon == 1) then
			pUnit:SetMaxHealth(325000)
			pUnit:SetHealth(325000)
			end
end

RegisterUnitEvent(12009, 18, "Mokra_OnSpawn")