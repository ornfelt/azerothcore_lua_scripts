local Freya
local Elder1
local Elder2
local Elder3
 
 
 
function Freya_OnSpawn(pUnit, Event)
	Freya = pUnit
	Elder1D = 0
	Elder2D = 0
	Elder3D = 0
end

RegisterUnitEvent(99805, 18, "Freya_OnSpawn")
 
function Elder1_OnSpawn(pUnit, Event)
	Elder1 = pUnit
end
 
RegisterUnitEvent(99811, 18, "Elder1_OnSpawn")
 
function Elder2_OnSpawn(pUnit, Event)
	Elder2 = pUnit
end
 
RegisterUnitEvent(99812, 18, "Elder2_OnSpawn")
 
function Elder3_OnSpawn(pUnit, Event)
	Elder3 = pUnit
end
 
RegisterUnitEvent(99813, 18, "Elder3_OnSpawn")
 
 
 
 
function Elder1_D(pUnit, Event)
	Elder1:PlaySoundToSet(15496)
	Elder1:SendChatMessage(14, 0, "Freya... They come for.. you!")
	Elder1:RemoveEvents()
	Elder1D = 1
end
function Elder2_D(pUnit, Event)
	Elder2:PlaySoundToSet(15503)
	Elder2:SendChatMessage(14, 0, "Matron flee! They are.. ruthless..")
	Elder2:RemoveEvents()
	Elder2D = 1
end
function Elder3_D(pUnit, Event)
	Elder3:PlaySoundToSet(15487)
	Elder3:SendChatMessage(14, 0, "Matron.. One has fallen..")
	Elder3:RemoveEvents()
	Elder3D = 1
end

RegisterUnitEvent(99811, 4, "Elder1_D")
RegisterUnitEvent(99812, 4, "Elder2_D")
RegisterUnitEvent(99813, 4, "Elder3_D")
 
 
function Elder1_C(pUnit, Event)
	Elder1:PlaySoundToSet(15493)
	Elder1:SendChatMessage(14, 0, "Mortals have no place here!")
	Elder1:RegisterEvent("Elder1_Crush", 5000, 0)
	Elder1:RegisterEvent("Elder1_HealingTouch", 3000, 0)
end
function Elder1_Crush(pUnit, Event)
	Elder1:FullCastSpellOnTarget(33661,pUnit:GetMainTank())
end
function Elder1_HealingTouch(pUnit, Event)
	Elder1:CastSpellOnTarget(29339,Elder1)
end
function Elder1_L(pUnit, Event)
	Elder1:RemoveEvents()
end
function Elder1_K(pUnit, Event)
	Elder1:PlaySoundToSet(15495)
	Elder1:SendChatMessage(14, 0, "Begone!")
end

RegisterUnitEvent(99811, 1, "Elder1_C")
RegisterUnitEvent(99811, 2, "Elder1_L")
RegisterUnitEvent(99811, 3, "Elder1_K")

-----------------------------------------------

function Elder2_C(pUnit, Event)
	Elder2:PlaySoundToSet(15500)
	Elder2:SendChatMessage(14, 0, "This place will serve as your graveyard!")
	Elder2:RegisterEvent("Elder2_Cleave", 6000, 0)
	Elder2:RegisterEvent("Elder2_Moonfire", 4000, 0)
end

function Elder2_Cleave(pUnit, Event)
	Elder2:FullCastSpellOnTarget(18819,pUnit:GetMainTank())
end

function Elder2_Moonfire(pUnit, Event)
	Elder2:FullCastSpellOnTarget(20690, pUnit:GetRandomPlayer(0))
end
function Elder2_L(pUnit, Event)
	Elder2:RemoveEvents()
end
function Elder2_K(pUnit, Event)
	Elder2:PlaySoundToSet(15502)
	Elder2:SendChatMessage(14, 0, "Such a waste!")
end

RegisterUnitEvent(99812, 1, "Elder2_C")
RegisterUnitEvent(99812, 2, "Elder2_L")
RegisterUnitEvent(99812, 3, "Elder2_K")

-----------------------------------------------

function Elder3_C(pUnit, Event)
	Elder3:PlaySoundToSet(15486)
	Elder3:SendChatMessage(14, 0, "Your corpse, will nourish the soil!")
	Elder3:RegisterEvent("Elder3_Smash", 4700, 0)
	Elder3:RegisterEvent("Elder3_Roar", 12000, 0)
end
function Elder3_Smash(pUnit, Event)
	Elder3:CastSpellOnTarget(42669,pUnit:GetMainTank())
end
function Elder3_Roar(pUnit, Event)
	Elder3:FullCastSpell(40221)
end
function Elder3_L(pUnit, Event)
	Elder3:RemoveEvents()
end
function Elder3_K(pUnit, Event)
	Elder3:PlaySoundToSet(15485)
	Elder3:SendChatMessage(14, 0, "Ferterliser...")
end

function Freya_OnCombat(pUnit, Event)
end

function Freya_OnLEAVECombat(pUnit, Event)
end

function Freya_OnKILLEDCombat(pUnit, Event)
end
 

RegisterUnitEvent(99813, 1, "Elder3_C")
RegisterUnitEvent(99813, 2, "Elder3_L")
RegisterUnitEvent(99813, 3, "Elder3_K")
 
RegisterUnitEvent(99805, 1, "Freya_OnCombat")
RegisterUnitEvent(99805, 2, "Freya_OnLEAVECombat")
RegisterUnitEvent(99805, 3, "Freya_OnKILLEDCombat")
 
function Freya_OnLEAVECombat(pUnit, Event)
	Freya:RemoveEvents()
	Freya:RemoveAura(25801)
	Freya:RemoveAura(1908)
	Elder1:RemoveAura(31797)
	Elder2:RemoveAura(31797)
	Elder3:RemoveAura(31797)        
	Elder1:RemoveAura(30402)
	Elder2:RemoveAura(30402)
	Elder3:RemoveAura(30402)
end
 
function Freya_OnKILLEDCombat(pUnit, Event)
	Freya:PlaySoundToSet(15530)
	Freya:SendChatMessage(14, 0, "From your deaths springs life anew!")
end
 
function Freya_Com(pUnit, Event)
		Freya:PlaySoundToSet(15527)
		Freya:CastSpell(36480)
		Freya:SendChatMessage(14, 0, "Elders... Grant me your strength!")
		Freya:RegisterEvent("Freya_Elder1Check", 500, 1)
		Freya:RegisterEvent("Freya_Elder2Check", 1000, 1)
		Freya:RegisterEvent("Freya_Elder3Check", 1500, 1)
		Freya:RegisterEvent("Freya_OnCombat", 4000, 1)
end
	
function Freya_Elder1Check(pUnit, Event)
	if Elder1D == 0 then
		Freya:SendChatMessage(42, 0, "Freya Gains Stonebarks Blessing!")
		Freya:CastSpell(5414)
		Elder1:FullCastSpellOnTarget(46906,Freya)
		Freya:RegisterEvent("Freya_Elder1D", 26000, 0) -- Root
	else
	end
end

function Freya_Elder2Check(pUnit, Event)
	if Elder2D == 0 then
		Freya:SendChatMessage(42, 0, "Freya Gains Sunbeams Blessing!")
		Freya:CastSpell(36330)
		Elder2:FullCastSpellOnTarget(46906,Freya)
		Freya:RegisterEvent("Freya_Elder2D", 6000, 0) -- Holy Bolt
	else
	end
end
function Freya_Elder3Check(pUnit, Event)
	if Elder3D == 0 then
		Freya:SendChatMessage(42, 0, "Freya Gains Caretakers Blessing!")
		Freya:CastSpell(16510)
		Elder3:FullCastSpellOnTarget(46906,Freya)
		Freya:RegisterEvent("Freya_Elder3D", 30000, 0) -- Ground Shake
	else
	end
end
 
 
function Freya_OnCombat(pUnit, Event)
	Freya:CastSpell(1908)
	Elder1:CastSpell(31797)
	Elder2:CastSpell(31797)
	Elder3:CastSpell(31797)
	pUnit:RegisterEvent("Freya_3Elder", 1000, 1)
	Freya:RegisterEvent("Freya_Swarm", 1000, 1)
	Freya:RegisterEvent("Freya_Elements", 45000, 1)
	Freya:RegisterEvent("Freya_Elder", 90000, 1)
	Freya:RegisterEvent("Freya_Swarm2", 135000, 1)
	Freya:RegisterEvent("Freya_Elements2", 180000, 1)
	Freya:RegisterEvent("Freya_Elder2", 225000, 1)
	Freya:RegisterEvent("Freya_Phase2", 270000, 1)
end
 
 
function Freya_Elder1D(pUnit, Event)
	Freya:FullCastSpellOnTarget(20699, pUnit:GetRandomPlayer(0))
end
function Freya_Elder2D(pUnit, Event)
	Freya:CastSpell(36743)
end
function Freya_Elder3D(pUnit, Event)
	Freya:CastSpell(55142)
	Freya:CastSpell(19129)
end
 
function Freya_3Elder(pUnit, Event)
	if Elder1D == 0 and Elder2D == 0 and Elder3D == 0 then
		pUnit:CastSpell(25801)
	else
end
end
 
function Freya_Swarm(pUnit, Event)
	Freya:PlaySoundToSet(15534)
	Freya:SendChatMessage(42, 0, "Allies of Nature Have Appeared!")
	Freya:SendChatMessage(14, 0, "The Swarm of the elements shall overtake you!")
	x = Freya:GetX()
	y = Freya:GetY()
	z = Freya:GetZ()
	o = Freya:GetO()
	Freya:SpawnCreature(99806, x+8, y+8, z, o, 16, 600000)
	Freya:SpawnCreature(99806, x+9, y+9, z, o, 16, 600000)
	Freya:SpawnCreature(99806, x+10, y+10, z, o, 16, 600000)
	Freya:SpawnCreature(99806, x-8, y-8, z, o, 16, 600000)
	Freya:SpawnCreature(99806, x-9, y-9, z, o, 16, 600000)
	Freya:SpawnCreature(99806, x-10, y-10, z, o, 16, 600000)
	Freya:SpawnCreature(99806, x+11, y-11, z, o, 16, 600000)
	Freya:SpawnCreature(99806, x+12, y-12, z, o, 16, 600000)
	Freya:SpawnCreature(99806, x+10, y-15, z, o, 16, 600000)
	Freya:SpawnCreature(99806, x-12, y+9, z, o, 16, 600000)
end
 
function Freya_Swarm2(pUnit, Event)
	Freya:PlaySoundToSet(15534)
	Freya:SendChatMessage(42, 0, "Allies of Nature Have Appeared!")
	Freya:SendChatMessage(14, 0, "The Swarm of the elements shall overtake you!")
	x = Freya:GetX()
	y = Freya:GetY()
	z = Freya:GetZ()
	o = Freya:GetO()
	Freya:SpawnCreature(99806, x+8, y+8, z, o, 16, 600000)
	Freya:SpawnCreature(99806, x+9, y+9, z, o, 16, 600000)
	Freya:SpawnCreature(99806, x+10, y+10, z, o, 16, 600000)
	Freya:SpawnCreature(99806, x-8, y-8, z, o, 16, 600000)
	Freya:SpawnCreature(99806, x-9, y-9, z, o, 16, 600000)
	Freya:SpawnCreature(99806, x-10, y-10, z, o, 16, 600000)
	Freya:SpawnCreature(99806, x+11, y-11, z, o, 16, 600000)
	Freya:SpawnCreature(99806, x+12, y-12, z, o, 16, 600000)
	Freya:SpawnCreature(99806, x+10, y-15, z, o, 16, 600000)
	Freya:SpawnCreature(99806, x-12, y+9, z, o, 16, 600000)
end
 
 
function Freya_Elder(pUnit, Event)
	Freya:PlaySoundToSet(15528)
	Freya:SendChatMessage(42, 0, "Allies of Nature Have Appeared!")
	Freya:SendChatMessage(14, 0, "Eonar your servant requires aid!")
	x = Freya:GetX()
	y = Freya:GetY()
	z = Freya:GetZ()
	o = Freya:GetO()
	Freya:SpawnCreature(99807, x+15, y-15, z, o, 16, 600000)
end
 
function Freya_Elder2(pUnit, Event)
	Freya:PlaySoundToSet(15528)
	Freya:SendChatMessage(42, 0, "Allies of Nature Have Appeared!")
	Freya:SendChatMessage(14, 0, "Eonar your servant requires aid!")
	x = Freya:GetX()
	y = Freya:GetY()
	z = Freya:GetZ()
	o = Freya:GetO()
	Freya:SpawnCreature(99807, x+15, y-15, z, o, 16, 600000)
end
 
 
 
function Freya_Elements(pUnit, Event)
	Freya:PlaySoundToSet(15533)
	Freya:SendChatMessage(42, 0, "Allies of Nature Have Appeared!")
	Freya:SendChatMessage(14, 0, "Children assist me!")
	x = Freya:GetX()
	y = Freya:GetY()
	z = Freya:GetZ()
	o = Freya:GetO()
	Freya:SpawnCreature(99808, x+10, y+10, z, o, 16, 600000)
	Freya:SpawnCreature(99809, x-10, y-10, z, o, 16, 600000)
	Freya:SpawnCreature(99810, x+15, y+15, z, o, 16, 600000)
end
 
function Freya_Elements2(pUnit, Event)
	Freya:PlaySoundToSet(15533)
	Freya:SendChatMessage(42, 0, "Allies of Nature Have Appeared!")
	Freya:SendChatMessage(14, 0, "Children assist me!")
	x = Freya:GetX()
	y = Freya:GetY()
	z = Freya:GetZ()
	o = Freya:GetO()
	Freya:SpawnCreature(99808, x+10, y+10, z, o, 16, 600000)
	Freya:SpawnCreature(99809, x-10, y-10, z, o, 16, 600000)
	Freya:SpawnCreature(99810, x+15, y+15, z, o, 16, 600000)
end
 
 
 
function Freya_Phase2(pUnit, Event)
	Freya:PlaySoundToSet(15526)
	Freya:SendChatMessage(42, 0, "Enrage in 2min")
	Freya:SendChatMessage(14, 0, "The conservatory must be protected!")
	Freya:RemoveAura(1908)
	Freya:RegisterEvent("Freya_Check", 100, 0)
	Freya:RegisterEvent("Freya_Enrage", 120000, 0)
end
 
function Freya_Enrage(pUnit, Event)
	Freya:CastSpell(27680)
	Freya:PlaySoundToSet(15532)
	Freya:SendChatMessage(42, 0, "Freya Enrages!")
	Freya:SendChatMessage(14, 0, "You have strayed to far, wasted to much time!")
end
 
 
function Freya_Check(pUnit, Event)
	if Freya:GetHealthPct() <= 6 then
		Freya:RemoveEvents()
		Freya:SetHealth(130000000)
		Freya:SetFaction(35)
		Freya:SetCombatMeleeCapable(1)
		Freya:PlaySoundToSet(15531)
		Freya:SendChatMessage(12, 0, "His hold on me disapates... I, I can see clearly once more. Thank you heroes.")
		Freya:Despawn(20000,0)
		Elder1:Despawn(1000,0)
		Elder2:Despawn(1000,0)
		Elder3:Despawn(1000,0)
		Freya:RegisterEvent("Freya_ElderChestCheck", 2000, 1)
	end
end
 
 
 
function Freya_ElderChestCheck(pUnit, Event)
					Freya:SpawnGameObject(99805, 2344, -35, 424, 4.7, 240000)
				if Elder1D == 0 then
					Freya:SpawnGameObject(99811, 2360, -32, 424, 4.7, 240000)  
				if Elder2D == 0 then
					Freya:SpawnGameObject(99812, 2355, -33, 424, 4.7, 240000)
				if Elder3D == 0 then
					Freya:SpawnGameObject(99813, 2350, -34, 424, 4.7, 240000)    
				end
			end
		end
	end