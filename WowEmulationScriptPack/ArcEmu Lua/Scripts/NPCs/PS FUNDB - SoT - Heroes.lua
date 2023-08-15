------------------------------------------------------>Defines<----------------------------------------------------------
Jaina_spw = 0
Jaina_spwn = {}
Velen_spw = 0
Velen_spwn = {}
Fandral_spw = 0
Fandral_spwn = {}
Sylvanas_spw = 0
Sylvanas_spwn = {}
Thrall_spw = 0
Thrall_spwn = {}
Rune_spw = 0
Rune_spwn = {}
------------------------------------------------------>Defines<----------------------------------------------------------
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////////////////ALLY HEROES///////////////////////////////////////////////////////////////////////--
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////./////////////////////////////////--
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--//////////////////////////////////////////////////////////////////////////// Jaina /////////////////////////////////////////////////////////////////////////////--
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function Jaina_OnCombat(Unit, Event)
Unit:SendChatMessage(12, 0, "You asked for it!")
Unit:PlaySoundToSet(5886)
Unit:RegisterEvent("a1spell1",18000,0)
Unit:RegisterEvent("a1spell2",60000,0)
Unit:RegisterEvent("a1spell3",35000,0)
Unit:RegisterEvent("a1spell4",23000,0)
end

--//////////////////////////////////////////////////////////////////////////// Spells /////////////////////////////////////////////////////////////////////////////--
function a1spell1(Unit, Event)
if Unit:GetRandomPlayer(0) ~= nil then
Unit:FullCastSpellOnTarget(38534, Unit:GetRandomPlayer(0))
end
end

function a1spell2(Unit, Event)
local x = Unit:GetX()
local y = Unit:GetY()
local z = Unit:GetZ()
local o = Unit:GetO()
Unit:SpawnCreature(21260, x+20, y, z, o, 1096, 60000)
Unit:SpawnCreature(21260, x-20, y, z, o, 1096, 60000)
end

function a1spell3(Unit, Event)
if Unit:GetRandomPlayer(0) ~= nil then
Unit:FullCastSpellOnTarget(118, Unit:GetRandomPlayer(0))
end
end

function a1spell4(Unit, Event)
Jaina_spell = math.random(3)
if (Jaina_spell == 1) then 
if Unit:GetMainTank() ~= nil then
Unit:FullCastSpellOnTarget(19712, Unit:GetMainTank())
end
end

if (Jaina_spell == 2) then
if Unit:GetRandomPlayer(0) ~= nil then
Unit:FullCastSpellOnTarget(36278, Unit:GetRandomPlayer(0))
end
end

if (Jaina_spell == 3) then
if Unit:GetRandomPlayer(1) ~= nil then
Unit:FullCastSpellOnTarget(21098, Unit:GetRandomPlayer(1))
end
end
end
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

function Jaina_OnKilledTarget(Unit, Event)
Unit:SendChatMessage(12, 0, "Don't say I haven't warned you.")
end

function Jaina_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

function Jaina_OnDied(Unit, Event)
hhero = hhero+1
Unit:SendChatMessage(12, 0, "I did...my best")
Unit:PlaySoundToSet(11010)
Unit:RemoveEvents()
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--//////////////////////////////////////////////////////////////////////////// Velen /////////////////////////////////////////////////////////////////////////////--
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function Velen_OnCombat(Unit, Event)
Unit:SendChatMessage(12, 0, "We must unite against the legion")
Unit:PlaySoundToSet(5880)
Unit:RegisterEvent("a2spell1",18000,0)
Unit:RegisterEvent("a2spell2",60000,0)
Unit:RegisterEvent("a2spell3",35000,0)
Unit:RegisterEvent("a2spell4",23000,0)
end

--//////////////////////////////////////////////////////////////////////////// Spells /////////////////////////////////////////////////////////////////////////////--
function a2spell1(Unit, Event)
if Unit:GetRandomPlayer(0) ~= nil then
Unit:FullCastSpellOnTarget(31330, Unit:GetRandomPlayer(0))
end
end

function a2spell2(Unit, Event)
local x = Unit:GetX()
local y = Unit:GetY()
local z = Unit:GetZ()
local o = Unit:GetO()
Unit:SpawnCreature(17854, x+20, y, z, o, 1640, 60000)
Unit:SpawnCreature(17854, x-20, y, z, o, 1640, 60000)
end

function a2spell3(Unit, Event)
if Unit:GetMainTank() ~= nil then
Unit:FullCastSpellOnTarget(17364, Unit:GetMainTank())
end
end

function a2spell4(Unit, Event)
Velen_spell = math.random(3)
if (Velen_spell == 1) then 
if Unit:GetMainTank() ~= nil then
Unit:FullCastSpellOnTarget(29666, Unit:GetMainTank())
end
end

if (Velen_spell == 2) then
if Unit:GetRandomPlayer(4) ~= nil then
Unit:FullCastSpellOnTarget(47071, Unit:GetRandomPlayer(4))
end
end

if (Velen_spell == 3) then
if Unit:GetRandomPlayer(1) ~= nil then
Unit:FullCastSpellOnTarget(39590, Unit:GetRandomPlayer(1))
end
end
end
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

function Velen_OnDied(Unit, Event)
hhero = hhero+1
Unit:SendChatMessage(12, 0, "I have...failed.")
Unit:RemoveEvents()
end

function Velen_OnKilledTarget(Unit, Event)
Unit:SendChatMessage(12, 0, "You have forced me to bring chaos.")
end

function Velen_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--//////////////////////////////////////////////////////////////////////////// Fandral /////////////////////////////////////////////////////////////////////////////--
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function Fandral_OnCombat(Unit, Event)
Unit:SendChatMessage(12, 0, "Nature will be with me")
Unit:RegisterEvent("aPhase1",1000,1)
Unit:RegisterEvent("aloop_this", 10, 0)
end

function aloop_this(Unit, Event)
if Unit:GetHealthPct() < 75 and aPhase1 ~= 1 then
aPhase1 = 1
Unit:RemoveEvents()
Unit:RegisterEvent("aloop_this", 10, 0)
Unit:RegisterEvent("aPhase2", 10, 1)
end
if Unit:GetHealthPct() < 50 and aPhase2 ~= 2 then
aPhase2 = 2
Unit:RemoveEvents()
Unit:RegisterEvent("aloop_this", 10, 0)
Unit:RegisterEvent("aPhase3", 10, 1)
end
if Unit:GetHealthPct() < 25 and aPhase3 ~= 3 then
aPhase3 = 3
Unit:RemoveEvents()
Unit:RegisterEvent("aloop_this", 10, 0)
Unit:RegisterEvent("aPhase4", 10, 1)
end
end

-----------------------PHASE 1--------------------------------
function aPhase1(Unit, Event)
Unit:SetModel(1542)
Unit:RegisterEvent("a3spell1",14000,0)
Unit:RegisterEvent("a3spell0",15000,0)
Unit:RegisterEvent("a3spell3",35000,0)
Unit:RegisterEvent("a3spell4",23000,0)
end

function a3spell1(Unit, Event)
if Unit:GetRandomPlayer(0) ~= nil then
Unit:FullCastSpellOnTarget(38935, Unit:GetRandomPlayer(0))
end
end

function a3spell0(Unit, Event)
if Unit:GetRandomPlayer(0) ~= nil then
Unit:FullCastSpellOnTarget(38935, Unit:GetRandomPlayer(0))
end
end

function a3spell3(Unit, Event)
if Unit:GetMainTank() ~= nil then
Unit:FullCastSpellOnTarget(27010, Unit:GetMainTank())
end
end

function a3spell4(Unit, Event)
Fandral_spell = math.random(2)
if (Fandral_spell == 1) then 
if Unit:GetMainTank() ~= nil then
Unit:FullCastSpellOnTarget(34798, Unit:GetMainTank())
end
end

if (Fandral_spell == 2) then
if Unit:GetRandomPlayer(4) ~= nil then
Unit:FullCastSpellOnTarget(39120, Unit:GetRandomPlayer(4))
end
end
end

-----------------------PHASE 2--------------------------------
function aPhase2(Unit, Event)
Unit:SetModel(15374)
Unit:RegisterEvent("a3spell1b",14000,0)
Unit:RegisterEvent("a3spell0b",15000,0)
Unit:RegisterEvent("a3spell3b",35000,0)
Unit:RegisterEvent("a3spell4b",23000,0)
Unit:RegisterEvent("a3spell5b",23500,0)
Unit:RegisterEvent("a3spell6b",23600,0)
Unit:RegisterEvent("a3spell7b",23700,0)
end


function a3spell1b(Unit, Event)
if Unit:GetRandomPlayer(0) ~= nil then
Unit:FullCastSpellOnTarget(38935, Unit:GetRandomPlayer(0))
end
end

function a3spell0b(Unit, Event)
if Unit:GetRandomPlayer(0) ~= nil then
Unit:FullCastSpellOnTarget(38935, Unit:GetRandomPlayer(0))
end
end

function a3spell3b(Unit, Event)
if Unit:GetMainTank() ~= nil then
Unit:FullCastSpellOnTarget(27010, Unit:GetMainTank())
end
end

function a3spell4b(Unit, Event)
if Unit:GetMainTank() ~= nil then
Unit:FullCastSpellOnTarget(20690, Unit:GetMainTank())
end
end

function a3spell5b(Unit, Event)
if Unit:GetRandomPlayer(7) ~= nil then
Unit:FullCastSpellOnTarget(20690, Unit:GetRandomPlayer(7))
end
end

function a3spell6b(Unit, Event)
if Unit:GetRandomPlayer(7) ~= nil then
Unit:FullCastSpellOnTarget(20690, Unit:GetRandomPlayer(7))
end
end

function a3spell7b(Unit, Event)
if Unit:GetRandomPlayer(0) ~= nil then
Unit:FullCastSpellOnTarget(20690, Unit:GetRandomPlayer(0))
end
end

-----------------------PHASE 3--------------------------------
function aPhase3(Unit, Event)
Unit:SetModel(2281)
Unit:RegisterEvent("a3spell1c",14000,0)
Unit:RegisterEvent("a3spell0c",19000,0)
Unit:RegisterEvent("a3spell3c",35000,0)
Unit:RegisterEvent("a3spell4c",23000,0)
Unit:RegisterEvent("a3spell5c",23500,0)
Unit:RegisterEvent("a3spell6c",23600,0)
end


function a3spell1c(Unit, Event)
if Unit:GetRandomPlayer(0) ~= nil then
Unit:FullCastSpellOnTarget(42398, Unit:GetRandomPlayer(0))
end
end

function a3spell0c(Unit, Event)
if Unit:GetRandomPlayer(0) ~= nil then
Unit:FullCastSpellOnTarget(42398, Unit:GetRandomPlayer(0))
end
end

function a3spell3c(Unit, Event)
if Unit:GetMainTank() ~= nil then
Unit:FullCastSpellOnTarget(42395, Unit:GetMainTank())
end
end

function a3spell4c(Unit, Event)
if Unit:GetMainTank() ~= nil then
Unit:FullCastSpellOnTarget(42389, Unit:GetMainTank())
end
end

function a3spell5c(Unit, Event)
if Unit:GetRandomPlayer(0) ~= nil then
Unit:FullCastSpellOnTarget(42389, Unit:GetRandomPlayer(0))
end
end

function a3spell6c(Unit, Event)
if Unit:GetRandomPlayer(1) ~= nil then
Unit:FullCastSpellOnTarget(42389, Unit:GetRandomPlayer(1))
end
end
-----------------------PHASE 4-----------------------------------
function aPhase4(Unit, Event)
Unit:SetModel(892)
Unit:RegisterEvent("a3spell1d",14000,0)
Unit:RegisterEvent("a3spell3d",35000,0)
Unit:RegisterEvent("a3spell4d",23000,0)
Unit:RegisterEvent("a3spell5d",23500,0)
Unit:RegisterEvent("a3spell6d",23600,0)
end


function a3spell1d(Unit, Event)
if Unit:GetMainTank() ~= nil then
Unit:FullCastSpellOnTarget(42389, Unit:GetMainTank())
end
end

function a3spell3d(Unit, Event)
if Unit:GetMainTank() ~= nil then
Unit:FullCastSpellOnTarget(43153, Unit:GetMainTank())
end
end

function a3spell4d(Unit, Event)
if Unit:GetMainTank() ~= nil then
Unit:FullCastSpellOnTarget(43243, Unit:GetMainTank())
end
end

function a3spell5d(Unit, Event)
if Unit:GetRandomPlayer(0) ~= nil then
Unit:FullCastSpellOnTarget(43243, Unit:GetRandomPlayer(0))
end
end

function a3spell6d(Unit, Event)
if Unit:GetRandomPlayer(1) ~= nil then
Unit:FullCastSpellOnTarget(43243, Unit:GetRandomPlayer(1))
end
end

------------------------Overig-------------------------------------
function Fandral_OnDied(Unit, Event)
hhero = hhero+1
Unit:SendChatMessage(12, 0, "Nature will revenge me.")
Unit:SetModel(1542)
Unit:RemoveEvents()
end

function Fandral_OnKilledTarget(Unit, Event)
Unit:SendChatMessage(12, 0, "You have forced my hand.")
end

function Fandral_OnLeaveCombat(Unit, Event)
Unit:SendChatMessage(12, 0, "You can't beat the power of nature.")
if SoT_A_Aquatic == 1 then
Unit:SetModel(2428)
else
Unit:SetModel(1542)
end
Unit:RemoveEvents()
end
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--///////////////////////////////////////////////////////////////////////////HORDE HEROES//////////////////////////////////////////////////////////////////////--
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////./////////////////////////////////--
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--//////////////////////////////////////////////////////////////////////////// Sylvanas ///////////////////////////////////////////////////////////////////////////--
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function Sylvanas_OnCombat(Unit, Event)
Unit:SendChatMessage(12, 0, "How dare you trying to attack me!!!")
Unit:PlaySoundToSet(5886)
Unit:RegisterEvent("h1spell1",18000,0)
Unit:RegisterEvent("h1spell2",60000,0)
Unit:RegisterEvent("h1spell3",35000,0)
Unit:RegisterEvent("h1spell4",23000,0)
end

--//////////////////////////////////////////////////////////////////////////// Spells /////////////////////////////////////////////////////////////////////////////--
function h1spell1(Unit, Event)
if Unit:GetRandomPlayer(0) ~= nil then
Unit:FullCastSpellOnTarget(38628, Unit:GetRandomPlayer(0))
end
end

function h1spell2(Unit, Event)
local x = Unit:GetX()
local y = Unit:GetY()
local z = Unit:GetZ()
local o = Unit:GetO()
Unit:SpawnCreature(18524, x+20, y, z, o, 118, 60000)
Unit:SpawnCreature(18524, x-20, y, z, o, 118, 60000)
end

function h1spell3(Unit, Event)
if Unit:GetRandomPlayer(7) ~= nil then
Unit:FullCastSpellOnTarget(118, Unit:GetRandomPlayer(7))
end
end

function h1spell4(Unit, Event)
Sylvanas_spell = math.random(3)
if (Sylvanas_spell == 1) then 
if Unit:GetMainTank() ~= nil then
Unit:FullCastSpellOnTarget(19712, Unit:GetMainTank())
end
end

if (Sylvanas_spell == 2) then
if Unit:GetRandomPlayer(0) ~= nil then
Unit:FullCastSpellOnTarget(36278, Unit:GetRandomPlayer(0))
end
end

if (Sylvanas_spell == 3) then
if Unit:GetRandomPlayer(1) ~= nil then
Unit:FullCastSpellOnTarget(21098, Unit:GetRandomPlayer(1))
end
end
end
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

function Sylvanas_OnDied(Unit, Event)
ahero = ahero+1
Unit:RemoveEvents()
end

function Sylvanas_OnKilledTarget(Unit, Event)
Unit:SendChatMessage(12, 0, "Don't say I haven't warned you.")
end

function Sylvanas_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--//////////////////////////////////////////////////////////////////////////// Thrall /////////////////////////////////////////////////////////////////////////////--
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function Thrall_OnCombat(Unit, Event)
Unit:SendChatMessage(12, 0, "You're time has come")
Unit:PlaySoundToSet(5880)
Unit:RegisterEvent("h2spell1",18000,0)
Unit:RegisterEvent("h2spell2",60000,0)
Unit:RegisterEvent("h2spell3",35000,0)
Unit:RegisterEvent("h2spell4",23000,0)
end

--//////////////////////////////////////////////////////////////////////////// Spells /////////////////////////////////////////////////////////////////////////////--
function h2spell1(Unit, Event)
if Unit:GetRandomPlayer(0) ~= nil then
Unit:FullCastSpellOnTarget(31330, Unit:GetRandomPlayer(0))
end
end

function h2spell2(Unit, Event)
local x = Unit:GetX()
local y = Unit:GetY()
local z = Unit:GetZ()
local o = Unit:GetO()
Unit:SpawnCreature(17854, x+20, y, z, o, 118, 60000)
Unit:SpawnCreature(17854, x-20, y, z, o, 118, 60000)
end

function h2spell3(Unit, Event)
if Unit:GetMainTank() ~= nil then
Unit:FullCastSpellOnTarget(17364, Unit:GetMainTank())
end
end

function h2spell4(Unit, Event)
Thrall_spell = math.random(3)
if (Thrall_spell == 1) then 
if Unit:GetMainTank() ~= nil then
Unit:FullCastSpellOnTarget(29666, Unit:GetMainTank())
end
end

if (Thrall_spell == 2) then
if Unit:GetRandomPlayer(4) ~= nil then
Unit:FullCastSpellOnTarget(47071, Unit:GetRandomPlayer(4))
end
end

if (Thrall_spell == 3) then
if Unit:GetRandomPlayer(1) ~= nil then
Unit:FullCastSpellOnTarget(39590, Unit:GetRandomPlayer(1))
end
end
end
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

function Thrall_OnDied(Unit, Event)
ahero = ahero+1
Unit:SendChatMessage(12, 0, "A good day...to die.")
Unit:PlaySoundToSet(10461)
Unit:RemoveEvents()
end

function Thrall_OnKilledTarget(Unit, Event)
Unit:SendChatMessage(12, 0, "You have forced my hand.")
Unit:PlaySoundToSet(10452)
end

function Thrall_OnLeaveCombat(Unit, Event)
Unit:SendChatMessage(12, 0, "I am truly in your death, strangers.")
Unit:PlaySoundToSet(10455)
Unit:RemoveEvents()
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--//////////////////////////////////////////////////////////////////////////// Hamuul ////////////////////////////////////////////////////////////////////////////--
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function Rune_OnCombat(Unit, Event)
Unit:SendChatMessage(12, 0, "Nature will be with me")
Unit:RegisterEvent("hPhase1",1000,1)
Unit:RegisterEvent("hloop_this", 10, 0)
end

function hloop_this(Unit, Event)
if Unit:GetHealthPct() < 75 and hPhase1 ~= 1 then
hPhase1 = 1
Unit:RemoveEvents()
Unit:RegisterEvent("hloop_this", 10, 0)
Unit:RegisterEvent("hPhase2", 10, 1)
end
if Unit:GetHealthPct() < 50 and hPhase2 ~= 2 then
hPhase2 = 2
Unit:RemoveEvents()
Unit:RegisterEvent("hloop_this", 10, 0)
Unit:RegisterEvent("hPhase3", 10, 1)
end
if Unit:GetHealthPct() < 25 and hPhase3 ~= 3 then
hPhase3 = 3
Unit:RemoveEvents()
Unit:RegisterEvent("hloop_this", 10, 0)
Unit:RegisterEvent("hPhase4", 10, 1)
end
end

-----------------------PHASE 1--------------------------------
function hPhase1(Unit, Event)
Unit:SetModel(4519)
Unit:RegisterEvent("h3spell1",14000,0)
Unit:RegisterEvent("h3spell0",15000,0)
Unit:RegisterEvent("h3spell3",35000,0)
Unit:RegisterEvent("h3spell4",23000,0)
end

function h3spell1(Unit, Event)
if Unit:GetRandomPlayer(0) ~= nil then
Unit:FullCastSpellOnTarget(38935, Unit:GetRandomPlayer(0))
end
end

function h3spell0(Unit, Event)
if Unit:GetRandomPlayer(0) ~= nil then
Unit:FullCastSpellOnTarget(38935, Unit:GetRandomPlayer(0))
end
end

function h3spell3(Unit, Event)
if Unit:GetMainTank() ~= nil then
Unit:FullCastSpellOnTarget(27010, Unit:GetMainTank())
end
end

function h3spell4(Unit, Event)
Rune_spell = math.random(2)
if (Rune_spell == 1) then 
if Unit:GetMainTank() ~= nil then
Unit:FullCastSpellOnTarget(34798, Unit:GetMainTank())
end
end

if (Rune_spell == 2) then
if Unit:GetRandomPlayer(4) ~= nil then
Unit:FullCastSpellOnTarget(39120, Unit:GetRandomPlayer(4))
end
end
end

-----------------------PHASE 2--------------------------------
function hPhase2(Unit, Event)
Unit:SetModel(15375)
Unit:RegisterEvent("h3spell1b",14000,0)
Unit:RegisterEvent("h3spell0b",15000,0)
Unit:RegisterEvent("h3spell3b",35000,0)
Unit:RegisterEvent("h3spell4b",23000,0)
Unit:RegisterEvent("h3spell5b",23500,0)
Unit:RegisterEvent("h3spell6b",23600,0)
Unit:RegisterEvent("h3spell7b",23700,0)
end


function h3spell1b(Unit, Event)
if Unit:GetRandomPlayer(0) ~= nil then
Unit:FullCastSpellOnTarget(38935, Unit:GetRandomPlayer(0))
end
end

function h3spell0b(Unit, Event)
if Unit:GetRandomPlayer(0) ~= nil then
Unit:FullCastSpellOnTarget(38935, Unit:GetRandomPlayer(0))
end
end

function h3spell3b(Unit, Event)
if Unit:GetMainTank() ~= nil then
Unit:FullCastSpellOnTarget(27010, Unit:GetMainTank())
end
end

function h3spell4b(Unit, Event)
if Unit:GetMainTank() ~= nil then
Unit:FullCastSpellOnTarget(20690, Unit:GetMainTank())
end
end

function h3spell5b(Unit, Event)
if Unit:GetRandomPlayer(7) ~= nil then
Unit:FullCastSpellOnTarget(20690, Unit:GetRandomPlayer(7))
end
end

function h3spell6b(Unit, Event)
if Unit:GetRandomPlayer(7) ~= nil then
Unit:FullCastSpellOnTarget(20690, Unit:GetRandomPlayer(7))
end
end

function h3spell7b(Unit, Event)
if Unit:GetRandomPlayer(0) ~= nil then
Unit:FullCastSpellOnTarget(20690, Unit:GetRandomPlayer(0))
end
end

-----------------------PHASE 3--------------------------------
function hPhase3(Unit, Event)
Unit:SetModel(2289)
Unit:RegisterEvent("h3spell1c",14000,0)
Unit:RegisterEvent("h3spell0c",19000,0)
Unit:RegisterEvent("h3spell3c",35000,0)
Unit:RegisterEvent("h3spell4c",23000,0)
Unit:RegisterEvent("h3spell5c",23500,0)
Unit:RegisterEvent("h3spell6c",23600,0)
end


function h3spell1c(Unit, Event)
if Unit:GetRandomPlayer(0) ~= nil then
Unit:FullCastSpellOnTarget(42398, Unit:GetRandomPlayer(0))
end
end

function h3spell0c(Unit, Event)
if Unit:GetRandomPlayer(0) ~= nil then
Unit:FullCastSpellOnTarget(42398, Unit:GetRandomPlayer(0))
end
end

function h3spell3c(Unit, Event)
if Unit:GetMainTank() ~= nil then
Unit:FullCastSpellOnTarget(42395, Unit:GetMainTank())
end
end

function h3spell4c(Unit, Event)
if Unit:GetMainTank() ~= nil then
Unit:FullCastSpellOnTarget(42389, Unit:GetMainTank())
end
end

function h3spell5c(Unit, Event)
if Unit:GetRandomPlayer(0) ~= nil then
Unit:FullCastSpellOnTarget(42389, Unit:GetRandomPlayer(0))
end
end

function h3spell6c(Unit, Event)
if Unit:GetRandomPlayer(1) ~= nil then
Unit:FullCastSpellOnTarget(42389, Unit:GetRandomPlayer(1))
end
end
-----------------------PHASE 4-----------------------------------
function hPhase4(Unit, Event)
Unit:SetModel(1058)
Unit:RegisterEvent("h3spell1d",14000,0)
Unit:RegisterEvent("h3spell3d",35000,0)
Unit:RegisterEvent("h3spell4d",23000,0)
Unit:RegisterEvent("h3spell5d",23500,0)
Unit:RegisterEvent("h3spell6d",23600,0)
end


function h3spell1d(Unit, Event)
if Unit:GetMainTank() ~= nil then
Unit:FullCastSpellOnTarget(42389, Unit:GetMainTank())
end
end

function h3spell3d(Unit, Event)
if Unit:GetMainTank() ~= nil then
Unit:FullCastSpellOnTarget(43153, Unit:GetMainTank())
end
end

function h3spell4d(Unit, Event)
if Unit:GetMainTank() ~= nil then
Unit:FullCastSpellOnTarget(43243, Unit:GetMainTank())
end
end

function h3spell5d(Unit, Event)
if Unit:GetRandomPlayer(0) ~= nil then
Unit:FullCastSpellOnTarget(43243, Unit:GetRandomPlayer(0))
end
end

function h3spell6d(Unit, Event)
if Unit:GetRandomPlayer(1) ~= nil then
Unit:FullCastSpellOnTarget(43243, Unit:GetRandomPlayer(1))
end
end

------------------------Overig-------------------------------------
function Rune_OnDied(Unit, Event)
ahero = ahero+1
Unit:SendChatMessage(12, 0, "Nature will revenge me.")
Unit:SetModel(4519)
Unit:RemoveEvents()
end

function Rune_OnKilledTarget(Unit, Event)
Unit:SendChatMessage(12, 0, "You have forced my hand.")
end

function Rune_OnLeaveCombat(Unit, Event)
Unit:SendChatMessage(12, 0, "You can't beat the power of nature.")
if SoT_H_Aquatic == 1 then
Unit:SetModel(2428)
else
Unit:SetModel(4519)
end
Unit:RemoveEvents()
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--//////////////////////////////////////////////////////////////////////////Despawn Functions//////////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-----------------------------------------------------------------------------------------------------Ally---------------------------------------------------------------------------------------------------
function Jaina_Despawn(Unit, Event)
if Jaina_spwn[Unit:GetGUID()] ~= SoT_initiated_times then
Unit:Despawn(0,0)
Unit:RemoveEvents()
end
end
function reg_Jaina_Despawn(Unit, Event)
Jaina_spw = Jaina_spw + 1
Jaina_spwn[Unit:GetGUID()] = Jaina_spw
Unit:RegisterEvent("Jaina_Despawn", 10, 0)
end

function Velen_Despawn(Unit, Event)
if Velen_spwn[Unit:GetGUID()] ~= SoT_initiated_times then
Unit:Despawn(0,0)
Unit:RemoveEvents()
end
end
function reg_Velen_Despawn(Unit, Event)
Velen_spw = Velen_spw + 1
Velen_spwn[Unit:GetGUID()] = Velen_spw
Unit:RegisterEvent("Velen_Despawn", 10, 0)
end

function Fandral_Despawn(Unit, Event)
if Fandral_spwn[Unit:GetGUID()] ~= SoT_initiated_times then
Unit:Despawn(0,0)
Unit:RemoveEvents()
end
end
function reg_Fandral_Despawn(Unit, Event)
Fandral_spw = Fandral_spw + 1
if SoT_A_Aquatic == 1 then
Unit:SetModel(2428)
end
Fandral_spwn[Unit:GetGUID()] = Fandral_spw
Unit:RegisterEvent("Fandral_Despawn", 10, 0)
end

-----------------------------------------------------------------------------------------------------Horde--------------------------------------------------------------------------------------------------
function Sylvanas_Despawn(Unit, Event)
if Sylvanas_spwn[Unit:GetGUID()] ~= SoT_initiated_times then
Unit:Despawn(0,0)
Unit:RemoveEvents()
end
end
function reg_Sylvanas_Despawn(Unit, Event)
Sylvanas_spw = Sylvanas_spw + 1
Sylvanas_spwn[Unit:GetGUID()] = Sylvanas_spw
Unit:RegisterEvent("Sylvanas_Despawn", 10, 0)
end

function Thrall_Despawn(Unit, Event)
if Thrall_spwn[Unit:GetGUID()] ~= SoT_initiated_times then
Unit:Despawn(0,0)
Unit:RemoveEvents()
end
end
function reg_Thrall_Despawn(Unit, Event)
Thrall_spw = Thrall_spw + 1
Thrall_spwn[Unit:GetGUID()] = Thrall_spw
Unit:RegisterEvent("Thrall_Despawn", 10, 0)
end

function Rune_Despawn(Unit, Event)
if Rune_spwn[Unit:GetGUID()] ~= SoT_initiated_times then
Unit:Despawn(0,0)
Unit:RemoveEvents()
end
end
function reg_Rune_Despawn(Unit, Event)
Rune_spw = Rune_spw + 1
if SoT_H_Aquatic == 1 then
Unit:SetModel(2428)
end
Rune_spwn[Unit:GetGUID()] = Rune_spw
Unit:RegisterEvent("Rune_Despawn", 10, 0)
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
--//////////////////////////////////////////////////////////////////////////Register Functions//////////////////////////////////////////////////////////////////////--
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
------ Ally ------
RegisterUnitEvent(555200, 1, "Jaina_OnCombat")
RegisterUnitEvent(555200, 2, "Jaina_OnLeaveCombat")
RegisterUnitEvent(555200, 3, "Jaina_OnKilledTarget")
RegisterUnitEvent(555200, 4, "Jaina_OnDied")
RegisterUnitEvent(555200, 18, "reg_Jaina_Despawn")
RegisterUnitEvent(555201, 1, "Velen_OnCombat")
RegisterUnitEvent(555201, 2, "Velen_OnLeaveCombat")
RegisterUnitEvent(555201, 3, "Velen_OnKilledTarget")
RegisterUnitEvent(555201, 4, "Velen_OnDied")
RegisterUnitEvent(555201, 18, "reg_Velen_Despawn")
RegisterUnitEvent(555202, 1, "Fandral_OnCombat")
RegisterUnitEvent(555202, 2, "Fandral_OnLeaveCombat")
RegisterUnitEvent(555202, 3, "Fandral_OnKilledTarget")
RegisterUnitEvent(555202, 4, "Fandral_OnDied")
RegisterUnitEvent(555202, 18, "reg_Fandral_Despawn")
------ Horde ------
RegisterUnitEvent(555300, 1, "Sylvanas_OnCombat")
RegisterUnitEvent(555300, 2, "Sylvanas_OnLeaveCombat")
RegisterUnitEvent(555300, 3, "Sylvanas_OnKilledTarget")
RegisterUnitEvent(555300, 4, "Sylvanas_OnDied")
RegisterUnitEvent(555300, 18, "reg_Sylvanas_Despawn")
RegisterUnitEvent(555301, 1, "Thrall_OnCombat")
RegisterUnitEvent(555301, 2, "Thrall_OnLeaveCombat")
RegisterUnitEvent(555301, 3, "Thrall_OnKilledTarget")
RegisterUnitEvent(555301, 4, "Thrall_OnDied")
RegisterUnitEvent(555301, 18, "reg_Thrall_Despawn")
RegisterUnitEvent(555302, 1, "Rune_OnCombat")
RegisterUnitEvent(555302, 2, "Rune_OnLeaveCombat")
RegisterUnitEvent(555302, 3, "Rune_OnKilledTarget")
RegisterUnitEvent(555302, 4, "Rune_OnDied")
RegisterUnitEvent(555302, 18, "reg_Rune_Despawn")
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------