--Azuregos Cleave
function Azuregos_1(Unit,Event)
Unit:CastSpellOnTarget(19983,GetMainTank)
end
--Azuregos Frost Breath
function Azuregos_2(Unit, Event)
Unit:CastSpell(21099)
end

--Azuregos spell reflect
function Azuregos_3(Unit, Event)
Unit:CastSpell(22067)
end

--Frost nova
function Azuregos_4(Unit, Event)
Unit:CastSpell(27088)
end

--Silence
function Azuregos_5(Unit, Event)
Unit:CastSpellOnTarget(38913,Unit:GetRandomPlayer(1))
end

--Wing buffet+Aggro wipe
function Azuregos_6(Unit, Event)
Unit:CastSpellOnTarget(18500,ClearHateList)
end

--Stomp+Aggro wipe
function Azuregos_7(Unit, Event)
Unit:CastSpellOnTarget(19364,ClearHateList)
end

--Frostbolt
function Azuregos_8(Unit, Event)
  Unit:CastSpellOnTarget(38534,GetMainTank )
end

--Frost Bolt volley
function Azuregos_9(Unit, Event)
Unit:CastSpell(29923)
end

--Ice Lance
function Azuregos_10(Unit, Event)
Unit:CastSpell(46194)
end

--Arcane volley
function Azuregos_11(Unit,Event)
Unit:CastSpellOnTarget(34785)
end

--Reflective Arcane shield
function Azuregos_12(Unit,Event)
Unit:CastSpell(35159)
end

--Portal of Shadows
function Azuregos_13(Unit,Event)
Unit:CastSpell(28383)
end

--Fireball volley
function Azuregos_14(Unit,Event)
Unit:CastSpell(43240)
end

--Enrage
function Azuregos_Enrage(Unit,Event)
Unit:FullCastSpell(35595)
end

--Damage Reduction Fire
function Azuregos_fire(Unit,Event)
Unit:CastSpell(34333)
end

--DamageReduction Arcane
function Azuregos_arcane(Unit,Event)
Unit:CastSpell(34331)
end


function Azuregos_Phase1(Unit, Event)
if Unit:GetHealthPct() < 100 then
Unit:RemoveEvents()
Unit:CastSpell(34333)
Unit:CastSpell(34331)
Unit:RemoveAura(38088)
Unit:RemoveAura(38087)
Unit:RegisterEvent("Azuregos_1",7000,0)
Unit:RegisterEvent("Azuregos_2",21000,0)
Unit:RegisterEvent("Azuregos_3",51200,0)
Unit:RegisterEvent("Azuregos_4",11000,0)
Unit:RegisterEvent("Azuregos_5",55000,0)
Unit:RegisterEvent("Azuregos_6",83000,0)
Unit:RegisterEvent("Azuregos_7",153000,0)
Unit:RegisterEvent("Azuregos_8",26000,0)
Unit:RegisterEvent("Azuregos_9",26000,0)
Unit:RegisterEvent("Azuregos_10",22000,0)
Unit:RegisterEvent("Azuregos_Enrage",200000,0)
Unit:RegisterEvent("Azuregos_Phase2",1000,0)
end
end

function Azuregos_Phase2(Unit)
if Unit:GetHealthPct() < 80 then
print "Azuregos call's for a demonic powers"
Unit:RemoveEvents()
Unit:RemoveAura(34333)
Unit:RemoveAura(34331)
Unit:CastSpell(24466)
Unit:CastSpell(38088)
Unit:CastSpell(38087)
Unit:RegisterEvent("Azuregos_11",16000,0)
Unit:RegisterEvent("Azuregos_12",2000,0)
Unit:RegisterEvent("Azuregos_14",7000,0)
Unit:RegisterEvent("Azuregos_Enrage",90000,0)
Unit:RegisterEvent("Azuregos_Phase3",1000,0)
end
end

function Azuregos_Phase3(Unit, Event)
if Unit:GetHealthPct() < 70 then
Unit:RemoveEvents()
Unit:CastSpell(34333)
Unit:CastSpell(34331)
Unit:RemoveAura(38088)
Unit:RemoveAura(38087)
Unit:RegisterEvent("Azuregos_1",7000,0)
Unit:RegisterEvent("Azuregos_2",21000,0)
Unit:RegisterEvent("Azuregos_3",51200,0)
Unit:RegisterEvent("Azuregos_4",11000,0)
Unit:RegisterEvent("Azuregos_5",55000,0)
Unit:RegisterEvent("Azuregos_6",83000,0)
Unit:RegisterEvent("Azuregos_7",153000,0)
Unit:RegisterEvent("Azuregos_8",26000,0)
Unit:RegisterEvent("Azuregos_9",26000,0)
Unit:RegisterEvent("Azuregos_10",22000,0)
Unit:RegisterEvent("Azuregos_Enrage",200000,0)
Unit:RegisterEvent("Azuregos_Phase4",1000,0)
end
end

function Azuregos_Phase4(Unit)
if Unit:GetHealthPct() < 50 then
print "Azuregos call's for a demonic powers"
Unit:RemoveEvents()
Unit:RemoveAura(34333)
Unit:RemoveAura(34331)
Unit:CastSpell(24466)
Unit:CastSpell(38088)
Unit:CastSpell(38087)
Unit:RegisterEvent("Azuregos_11",16000,0)
Unit:RegisterEvent("Azuregos_12",2000,0)
Unit:RegisterEvent("Azuregos_14",7000,0)
Unit:RegisterEvent("Azuregos_Enrage",90000,0)
Unit:RegisterEvent("Azuregos_Phase5",1000,0)
end
end

function Azuregos_Phase5(Unit, Event)
if Unit:GetHealthPct() < 40 then
Unit:RemoveEvents()
Unit:RemoveAura(38088)
Unit:RemoveAura(38087)
Unit:CastSpell(34333)
Unit:CastSpell(34331)
Unit:RegisterEvent("Azuregos_1",7000,0)
Unit:RegisterEvent("Azuregos_2",21000,0)
Unit:RegisterEvent("Azuregos_3",51200,0)
Unit:RegisterEvent("Azuregos_4",11000,0)
Unit:RegisterEvent("Azuregos_5",55000,0)
Unit:RegisterEvent("Azuregos_6",83000,0)
Unit:RegisterEvent("Azuregos_7",153000,0)
Unit:RegisterEvent("Azuregos_8",26000,0)
Unit:RegisterEvent("Azuregos_9",26000,0)
Unit:RegisterEvent("Azuregos_10",22000,0)
Unit:RegisterEvent("Azuregos_Enrage",200000,0)
Unit:RegisterEvent("Azuregos_Phase6",1000,0)
end
end

function Azuregos_Phase6(Unit)
if Unit:GetHealthPct() < 15 then
print "Azuregos call's for a demonic powers"
Unit:RemoveEvents()
Unit:RemoveAura(34333)
Unit:RemoveAura(34331)
Unit:CastSpell(24466)
Unit:CastSpell(38088)
Unit:CastSpell(38087)
Unit:RegisterEvent("Azuregos_1",7000,0)
Unit:RegisterEvent("Azuregos_11",16000,0)
Unit:RegisterEvent("Azuregos_12",2000,0)
Unit:RegisterEvent("Azuregos_14",7000,0)
Unit:RegisterEvent("Azuregos_Enrage",120000,0)
end
end

function Azuregos_LeaveCombat(Unit, Event)
Unit:RemoveAura(35595)
Unit:RemoveEvents()
end

function Azuregos_Dead(Unit, Event)
Unit:RemoveAura(35595)
Unit:RemoveEvents()
end

function Azuregos_OnCombat(Unit, Event)
Unit:RegisterEvent("Azuregos_Phase1", 1000, 0)
end


RegisterUnitEvent(60000, 1, "Azuregos_OnCombat")
RegisterUnitEvent(60000, 2, "Azuregos_LeaveCombat")
RegisterUnitEvent(60000, 3, "Azuregos_Dead")