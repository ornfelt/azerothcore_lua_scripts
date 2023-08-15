function Master_OnCombat(Unit, Event) 
Unit:SendChatMessage(12, 0, "What did I say about comeing here and disturb me??")
Unit:RegisterEvent("Master_CHainL", 6000, 0)
Unit:RegisterEvent("Master_phaxe1",1000,0)
end

function Master_CHainL(pUnit, Event) 
pUnit:FullCastSpellOnTarget(28293, pUnit:GetRandomPlayer(0)) 
end

function Earthele_Spawn(pUnit, Event) 
pUnit:SpawnCreature(909092, -782.51, 6941.05, 33.15, 2.920131, 16, 60000) 
pUnit:SpawnCreature(909092, -781.18, 6948.50, 32.86, 2.446542, 16, 60000) 
end

function WaterEle_Spawn2(pUnit, Event) 
pUnit:SpawnCreature(909093, -782.51, 6941.05, 33.15, 2.920131, 16, 60000) 
pUnit:SpawnCreature(909093, -781.18, 6948.50, 32.86, 2.446542, 16, 60000) 
end

function FireEle_Spawn3(pUnit, Event) 
pUnit:SpawnCreature(909091, -782.51, 6941.05, 33.15, 2.920131, 16, 60000) 
pUnit:SpawnCreature(909091, -781.18, 6948.50, 32.86, 2.446542, 16, 60000) 
end

function Master_Eaarthquake(pUnit, Event) 
pUnit:FullCastSpellOnTarget(33919, pUnit:GetMainTank()) 
end

function Master_CharredEarth(pUnit, Event) 
pUnit:FullCastSpellOnTarget(30129, pUnit:GetRandomPlayer(0)) 
end

function Master_Fnova(pUnit, Event) 
pUnit:FullCastSpellOnTarget(31250, pUnit:GetMainTank()) 
end

function Master_Fboltvolley(pUnit, Event) 
pUnit:FullCastSpellOnTarget(36741, pUnit:GetMainTank()) 
end

function Master_Frostarmor(pUnit, Event) 
pUnit:CastSpell(12544, pUnit:GetClosestPlayer()) 
end

function Master_FlameBrath(pUnit, Event) 
pUnit:FullCastSpellOnTarget(43140, pUnit:GetMainTank()) 
end

function Master_Soulburn(pUnit, Event) 
pUnit:FullCastSpellOnTarget(19393, pUnit:GetRandomPlayer(0)) 
end

function Master_CharredEarth2(pUnit, Event) 
pUnit:FullCastSpellOnTarget(30129, pUnit:GetRandomPlayer(0)) 
end

function Master_phaxe1(pUnit, Event) 
if pUnit:GetHealthPct() < 85 then 
pUnit:RemoveEvents(); 
pUnit:FullCastSpell(0)
pUnit:SetModel(14511)
pUnit:SendChatMessage(12, 0, "Earth! Protect me!") 
pUnit:RegisterEvent("Earthele_Spawn",1,2)
pUnit:RegisterEvent("Master_Eaarthquake", 10000, 0)
pUnit:RegisterEvent("Master_CharredEarth", 15000, 0)
pUnit:RegisterEvent("Master_Phaxe2",1000,0)
end 
end

function Master_Phaxe2(pUnit, Event) 
if pUnit:GetHealthPct() < 60 then 
pUnit:RemoveEvents(); 
pUnit:FullCastSpell(0)
pUnit:SetModel(525)
pUnit:SendChatMessage(12, 0, "Looks like you guys need to be a little bit cooler!") 
pUnit:RegisterEvent("WaterEle_Spawn2",1,2)
pUnit:RegisterEvent("Master_Fnova", 30000, 0)
pUnit:RegisterEvent("Master_Fboltvolley", 15000, 0)
pUnit:RegisterEvent("Master_Frostarmor", 1, 1)
pUnit:RegisterEvent("Master_phaxe3",1000,0)
end 
end

function Master_phaxe3(pUnit, Event) 
if pUnit:GetHealthPct() < 30 then 
pUnit:RemoveEvents(); 
pUnit:FullCastSpell(0)
pUnit:SetModel(1405)
pUnit:SendChatMessage(12, 0, "Enough with this shit! burn in hell!!")
pUnit:RegisterEvent("FireEle_Spawn3",1,2)
pUnit:RegisterEvent("Master_FlameBrath", 30000, 0)
pUnit:RegisterEvent("Master_Soulburn", 20000, 0)
pUnit:RegisterEvent("Master_CharredEarth2", 23000, 0)
end 
end

function Master_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents()
Unit:SetModel(21607) 
end

function Master_OnDied(Unit, Event) 
Unit:RemoveEvents() 
Unit:SendChatMessage(11, 0, "I failed") 
end

function Master_OnKilledTarget(Unit, Event) 
Unit:SendChatMessage(11, 0, "Haha.. The elements got YOU!") 
end

RegisterUnitEvent(909090, 1, "Master_OnCombat")
RegisterUnitEvent(909090, 2, "Master_OnLeaveCombat")
RegisterUnitEvent(909090, 3, "Master_OnKilledTarget")
RegisterUnitEvent(909090, 4, "Master_OnDied")