--************************************************************
--*                                                          *
--*               ******************************             *                   
--*               *                            *             *
--*               *   The FrostTeam Project    *             *     
--*               *        stoneharry          *             *
--*               ******************************             *            
--*                                                          *
--*                                                          *
--*      --FrostTeam SVN consists of the latest WotLK        *   
--*      scripts, both Lua and C++. Some will be our own,    *
--*      some will be others with credits attatched. Our     *
--*      Svn includes all scripts that you may need          *
--*      to help make your server a more fun environment.--  *
--*                                                          *
--************************************************************

function LichHand_OnCombat(pUnit, event)
    pUnit:PlaySoundToSet(11961)
    pUnit:SendChatMessage(12, 0, "It is over, your search is done, let fate choose now, the righteous one!")
    pUnit:StopMovement(999999999)
    pUnit:CastSpell(50635)
    pUnit:RegisterEvent("LichHand_spawn1",1000, 0) 
end

function LichHand_spawn1(pUnit, event)
    pUnit:RemoveEvents()
    pUnit:StopMovement(999999999)
    pUnit:SpawnGameObject(183816, 5864, 2121, 637, 6.148913, 5000)
    pUnit:SpawnCreature(130921, 5864, 2121, 637, 6.148913, 20, 120000)
    pUnit:RegisterEvent("LichHand_spawn2",1000, 0) 
end

function LichHand_spawn2(pUnit, event)
    pUnit:RemoveEvents()
    pUnit:StopMovement(999999999)
    pUnit:SpawnGameObject(183816, 5891, 2108, 637, 2.637820, 5000)
    pUnit:SpawnCreature(130921, 5891, 2108, 637, 2.637820, 20, 120000)
    pUnit:RegisterEvent("LichHand_spawn3",1000, 0) 
end

function LichHand_spawn3(pUnit, event)
    pUnit:RemoveEvents()
    pUnit:StopMovement(999999999)
    pUnit:SpawnCreature(130921, 5882, 2126, 637, 4.181123, 20, 120000)
    pUnit:SpawnGameObject(183816, 5882, 2126, 637, 4.181123, 5000)
    pUnit:CastSpell(39132)
    pUnit:RegisterEvent("LichHand_phase2",20000, 0) 
end

function LichHand_phase2(pUnit, event)
    pUnit:RemoveEvents()
    pUnit:PlaySoundToSet(11962)
    pUnit:SendChatMessage(12, 0, "Your body lies beaten, battered and broken. Let my curse be your own, fate has spoken.")
    pUnit:CastSpell(60121)
    pUnit:CastSpell(39132)
    pUnit:CastSpell(39132)
    pUnit:RegisterEvent("LichHand_spawn4",10000, 0) 
end


function LichHand_spawn4(pUnit, event)
    pUnit:RemoveEvents()
    pUnit:CastSpell(39132)
    pUnit:PlaySoundToSet(11963)
    pUnit:SendChatMessage(12, 0, "Soldiers arise, stand and fight! Bring victory at last, to this fallen knight.")
x = pUnit:GetX();
y = pUnit:GetY();
z = pUnit:GetZ();
o = pUnit:GetO();
x = x + 4
    pUnit:SpawnCreature(130921, x, y, z, o, 20, 60000);
    pUnit:SpawnGameObject(183816, x, y, z, o, 5000)
x = x - 8
    pUnit:SpawnCreature(130921, x, y, z, o, 20, 60000);
    pUnit:SpawnGameObject(183816, x, y, z, o, 5000)
x = x + 4
y = y + 8
    pUnit:SpawnCreature(130921, x, y, z, o, 20, 60000);
    pUnit:SpawnGameObject(183816, x, y, z, o, 5000)
y = y - 16
    pUnit:SpawnCreature(130921, x, y, z, o, 20, 60000);
    pUnit:SpawnGameObject(183816, x, y, z, o, 5000)
y = y + 8
    pUnit:RegisterEvent("LichHand_spawn5",10000, 0)
end

function LichHand_spawn5(pUnit, event)
    pUnit:CastSpell(39132)
    pUnit:RemoveEvents()
    pUnit:PlaySoundToSet(11965)
    pUnit:SendChatMessage(12, 0, "Ha ha ha ha ha")
x = pUnit:GetX();
y = pUnit:GetY();
z = pUnit:GetZ();
o = pUnit:GetO();
y = y - 2
    pUnit:SpawnCreature(130921, x, y, z, o, 20, 60000);
    pUnit:SpawnGameObject(183816, x, y, z, o, 15000)
y = y + 0.3
    pUnit:SpawnGameObject(183816, x, y, z, o, 15000)
x = x - 0.4
y = y - 0.3
    pUnit:SpawnGameObject(183816, x, y, z, o, 15000)
    pUnit:RegisterEvent("LichHand_spawn5cool",2000, 0)
    pUnit:RegisterEvent("LichHand_spawn5end", 14000, 0)
end

function LichHand_spawn5cool(pUnit, event)
x = pUnit:GetX();
y = pUnit:GetY();
z = pUnit:GetZ();
o = pUnit:GetO();
y = y - 2
    pUnit:SpawnCreature(130921, x, y, z, o, 20, 60000);
end

function LichHand_spawn5end(pUnit, event)
    pUnit:RemoveEvents()
    pUnit:PlaySoundToSet(11966)
    pUnit:SendChatMessage(12, 0, "Prepare yourselves, the bells have told, shelter your weak, your young and your old, each of you shall the pay the final sum, cry for mercy, the reckoning has come!")
    pUnit:RegisterEvent("LichHand_Phase6",1000, 0) 
end

function LichHand_Phase6(pUnit, event)
    pUnit:RemoveEvents()
    pUnit:CastSpell(50635)
    pUnit:RegisterEvent("LichHand_spawnII",1000, 0) 
end


function LichHand_spawnII(pUnit, event)
    pUnit:RemoveEvents()
    pUnit:SpawnGameObject(183816, 5864, 2121, 637, 6.148913, 5000)
    pUnit:SpawnCreature(130921, 5864, 2121, 637, 6.148913, 20, 120000)
    pUnit:RegisterEvent("LichHand_spawnIII",1000, 0) 
end

function LichHand_spawnIII(pUnit, event)
    pUnit:RemoveEvents()
    pUnit:SpawnGameObject(183816, 5891, 2108, 637, 2.637820, 5000)
    pUnit:SpawnCreature(130921, 5891, 2108, 637, 2.637820, 20, 120000)
    pUnit:RegisterEvent("LichHand_spawnVI",1000, 0) 
end

function LichHand_spawnVI(pUnit, event)
    pUnit:RemoveEvents()
    pUnit:SpawnCreature(130921, 5882, 2126, 637, 4.181123, 20, 120000)
    pUnit:SpawnGameObject(183816, 5882, 2126, 637, 4.181123, 5000)
    pUnit:CastSpell(39132)
    pUnit:RegisterEvent("LichHand_phaseII",20000, 0) 
end

function LichHand_phaseII(pUnit, event)
    pUnit:RemoveEvents()
    pUnit:CastSpell(60121)
    pUnit:CastSpell(39132)
    pUnit:CastSpell(39132)
    pUnit:RegisterEvent("LichHand_spawnV",10000, 0) 
end


function LichHand_spawnV(pUnit, event)
    pUnit:RemoveEvents()
    pUnit:CastSpell(39132)
x = pUnit:GetX();
y = pUnit:GetY();
z = pUnit:GetZ();
o = pUnit:GetO();
x = x + 4
    pUnit:SpawnCreature(130921, x, y, z, o, 20, 60000);
    pUnit:SpawnGameObject(183816, x, y, z, o, 5000)
x = x - 8
    pUnit:SpawnCreature(130921, x, y, z, o, 20, 60000);
    pUnit:SpawnGameObject(183816, x, y, z, o, 5000)
x = x + 4
y = y + 8
    pUnit:SpawnCreature(130921, x, y, z, o, 20, 60000);
    pUnit:SpawnGameObject(183816, x, y, z, o, 5000)
y = y - 16
    pUnit:SpawnCreature(130921, x, y, z, o, 20, 60000);
    pUnit:SpawnGameObject(183816, x, y, z, o, 5000)
y = y + 8
    pUnit:RegisterEvent("LichHand_spawnIV",10000, 0)
end


function LichHand_spawnIV(pUnit, event)
    pUnit:CastSpell(39132)
    pUnit:RemoveEvents()
    pUnit:PlaySoundToSet(11965)
    pUnit:SendChatMessage(12, 0, "Ha ha ha ha ha")
x = pUnit:GetX();
y = pUnit:GetY();
z = pUnit:GetZ();
o = pUnit:GetO();
y = y - 2
    pUnit:SpawnCreature(130921, x, y, z, o, 20, 60000);
    pUnit:SpawnGameObject(183816, x, y, z, o, 15000)
y = y + 0.3
    pUnit:SpawnGameObject(183816, x, y, z, o, 15000)
x = x - 0.4
y = y - 0.3
    pUnit:SpawnGameObject(183816, x, y, z, o, 15000)
    pUnit:RegisterEvent("LichHand_spawnIVcool",2000, 0)
    pUnit:RegisterEvent("LichHand_spawnIVend", 14000, 0)
end

function LichHand_spawnIVcool(pUnit, event)
x = pUnit:GetX();
y = pUnit:GetY();
z = pUnit:GetZ();
o = pUnit:GetO();
y = y - 2
    pUnit:SpawnCreature(130921, x, y, z, o, 20, 60000);
end

function LichHand_spawnIVend(pUnit, event)
    pUnit:RemoveEvents()
    pUnit:RegisterEvent("LichHand_spawnII",10000, 0) 
end

function LichHand_OnLeaveCombat(pUnit, event)
    pUnit:RemoveEvents()
    pUnit:SetScale(0.1)
end


function Lichmin_OnCombat(pUnit, event)
    pUnit:StopMovement(5000)
end


function Lichmin_OnLeaveCombat(pUnit, event)
    pUnit:RemoveEvents()
    pUnit:Despawn(1, 0)
    pUnit:Despawn(1, 0)
    pUnit:Despawn(1, 0)
    pUnit:Despawn(1, 0)
    pUnit:Despawn(1, 0)
    pUnit:Despawn(1, 0)
end


function Lichmin_OnKilledTarget(pUnit)
    pUnit:CastSpell(41106)
end


function Lichmin_Death(pUnit)
    pUnit:RemoveEvents()
    pUnit:Despawn(1, 0)
end

function LichHand_Death(pUnit)
    pUnit:RemoveEvents()
    pUnit:SetScale(0.1)
end


RegisterUnitEvent(130921, 1, "Lichmin_OnCombat")
RegisterUnitEvent(130921, 2, "Lichmin_OnLeaveCombat")
RegisterUnitEvent(130921, 3, "Lichmin_OnKilledTarget")
RegisterUnitEvent(130921, 4, "Lichmin_Death")
RegisterUnitEvent(131815, 1, "LichHand_OnCombat")
RegisterUnitEvent(131815, 2, "LichHand_OnLeaveCombat")
RegisterUnitEvent(131815, 3, "LichHand_OnKilledTarget")
RegisterUnitEvent(131815, 4, "LichHand_Death")