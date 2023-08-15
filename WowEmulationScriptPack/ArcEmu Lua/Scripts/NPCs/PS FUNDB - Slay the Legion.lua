-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
-- //////////////////////////////////////////////////////////////////////// Defines ////////////////////////////////////////////////////////////////// --
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
mnghppct = 100
mngclickgreen = 0
mngclickpurple = 0
mngclickred = 0
mngclickblue = 0
Infkill = 0
MNGScore = 0
mngenter = 0
Infcounter = 0
Felcounter = 0
Pitcounter = 0
Infsecs = 3000
Felsecs = 9000
Pitsecs = 15000
CommanderTalk = 0
EnableFelguard = 0
EnablePitLord = 0
InfKilled = 0
FelKilled = 0
PitKilled = 0
MNGScoreEnd10= 0
MNGScoreEnd9 = 0
MNGScoreEnd8 = 0
MNGScoreEnd7 = 0
MNGScoreEnd6 = 0
MNGScoreEnd5 = 0
MNGScoreEnd4 = 0
MNGScoreEnd3 = 0
MNGScoreEnd2 = 0
MNGScoreEnd1 = 0
MNGTotalClicks = 0
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
-- /////////////////////////////////////////////////////////////////// GO Functions ////////////////////////////////////////////////////////////////// --
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
-- Blue = 5000187
function OnClickBlue(pUnit, Event, pMisc)
if MNGPlayer ~= nil then
if pMisc == MNGPlayer then
mngclickblue = 1
if mngenter == 2 then
MNGTotalClicks = MNGTotalClicks + 1
end
else
pMisc:Teleport(560, 3702.67, -148.213, 91.9986)
end
else
pMisc:Teleport(560, 3702.67, -148.213, 91.9986)
end
end
function blueundo(Unit, Event)
mngclickblue = 0
end
RegisterGameObjectEvent(5000187, 4, "OnClickBlue")
-- Red = 5000188
function OnClickRed(pUnit, Event, pMisc)
if MNGPlayer ~= nil then
if pMisc == MNGPlayer then
mngclickred = 1
if mngenter == 2 then
MNGTotalClicks = MNGTotalClicks + 1
end
else
pMisc:Teleport(560, 3702.67, -148.213, 91.9986)
end
else
pMisc:Teleport(560, 3702.67, -148.213, 91.9986)
end
end
function redundo(Unit, Event)
mngclickred = 0
end
RegisterGameObjectEvent(5000188, 4, "OnClickRed")
-- Purple = 5000189
function OnClickPurple(pUnit, Event, pMisc)
if MNGPlayer ~= nil then
if pMisc == MNGPlayer then
mngclickpurple = 1
if mngenter == 2 then
MNGTotalClicks = MNGTotalClicks + 1
end
else
pMisc:Teleport(560, 3702.67, -148.213, 91.9986)
end
else
pMisc:Teleport(560, 3702.67, -148.213, 91.9986)
end
end
function purpleundo(Unit, Event)
mngclickpurple = 0
end
RegisterGameObjectEvent(5000189, 4, "OnClickPurple")
-- Green = 5000190
function OnClickGreen(pUnit, Event, pMisc)
if MNGPlayer ~= nil then
if pMisc == MNGPlayer then
mngclickgreen = 1
if mngenter == 2 then
MNGTotalClicks = MNGTotalClicks + 1
end
else
pMisc:Teleport(560, 3702.67, -148.213, 91.9986)
end
else
pMisc:Teleport(560, 3702.67, -148.213, 91.9986)
end
end
function greenundo(Unit, Event)
mngclickgreen = 0
end
RegisterGameObjectEvent(5000190, 4, "OnClickGreen")
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
-- /////////////////////////////////////////////////////////////////// Use GO Effect ////////////////////////////////////////////////////////////////// --
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
function CastOnClick1(Unit, Event)
if (mngclickblue == 1) then
Unit:CastSpell(11826)
end
end
function reg_CastOnClick1(Unit, Event)
Unit:SetScale(0.5)
Unit:RegisterEvent("CastOnClick1", 10, 0)
end
RegisterUnitEvent(10002677, 18, "reg_CastOnClick1")

function CastOnClick2(Unit, Event)
if (mngclickred == 1) then
Unit:CastSpell(11826)
end
end
function reg_CastOnClick2(Unit, Event)
Unit:SetScale(0.5)
Unit:RegisterEvent("CastOnClick2", 10, 0)
end
RegisterUnitEvent(10002678, 18, "reg_CastOnClick2")

function CastOnClick3(Unit, Event)
if (mngclickpurple == 1) then
Unit:CastSpell(11826)
end
end
function reg_CastOnClick3(Unit, Event)
Unit:SetScale(0.5)
Unit:RegisterEvent("CastOnClick3", 10, 0)
end
RegisterUnitEvent(10002679, 18, "reg_CastOnClick3")

function CastOnClick4(Unit, Event)
if (mngclickgreen == 1) then
Unit:CastSpell(11826)
end
end
function reg_CastOnClick4(Unit, Event)
Unit:SetScale(0.5)
Unit:RegisterEvent("CastOnClick4", 10, 0)
end
RegisterUnitEvent(10002680, 18, "reg_CastOnClick4")
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
-- ///////////////////////////////////////////////////////// Shared Functions ///////// /////////////////////////////////////////////////////////////// --
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
function mngExplode(Unit, Event)
Unit:CastSpell(36092) -- Kael Explodes
end

function MngOnDeath(Unit, Event)
mngmsg = string.format("Your score is now: %s", MNGScore)
end
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
-- ///////////////////////////////////////////////////////// Legion Infernal = 10002671 /////////////////////////////////////////////////////////////// --
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
function InfernalOnSpawn(Unit, Event)
local y = Unit:GetY()
Unit:CreateWaypoint(3713.2117, y, 77.6216, 0, 0, 0, 7950)
Unit:SetCombatTargetingCapable(1)
Unit:SetScale(0.3)
Unit:RegisterEvent("InfernalClose", 10, 0)
end
RegisterUnitEvent(10002671, 18, "InfernalOnSpawn")

function InfernalClose(Unit, Event)
if (Unit:GetX() > 3708.4619) and (Unit:GetX() < 3712.3398) then
local x = Unit:GetX()
local y = Unit:GetY()
local z = Unit:GetZ()
if ((mngclickgreen == 1) and (Unit:GetY() > -203) and (Unit:GetY() < -201)) then
Unit:RegisterEvent("InfernalKilled", 10, 1)
InfKill = 1
end
if ((mngclickpurple == 1) and (Unit:GetY() > -207) and (Unit:GetY() < -204)) then
Unit:RegisterEvent("InfernalKilled", 10, 1)
InfKill = 2
end
if ((mngclickred == 1) and (Unit:GetY() > -210) and (Unit:GetY() < -208)) then
Unit:RegisterEvent("InfernalKilled", 10, 1)
InfKill = 3
end
if ((mngclickblue == 1) and (Unit:GetY() > -213) and (Unit:GetY() < -211)) then
Unit:RegisterEvent("InfernalKilled", 10, 1)
InfKill = 4
end
end
if(Unit:GetX() > 3712.3398) then
Unit:SetCombatTargetingCapable(0)
Unit:RegisterEvent("mngExplode", 10, 1)
end
if MNGPlayer == nil then
Unit:Despawn(0,0)
else
if MNGPlayer:IsInCombat() then
mnghppct = mnghppct - 7
Unit:Despawn(0,0)
end
end
end

function InfernalKilled(Unit, Event)
MNGScore = MNGScore + 5
InfKilled = InfKilled + 1
Unit:Kill(Unit)
Unit:SetScale(0.1)
end
RegisterUnitEvent(10002671, 4, "MngOnDeath")
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
-- ///////////////////////////////////////////////////// Legion Felguard = 10002672 /////////////////////////////////////////////////////////////////// --
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
function FelguardOnSpawn(Unit, Event)
local y = Unit:GetY()
Unit:CreateWaypoint(3713.2117, y, 77.6216, 0, 0, 0, 5048)
Unit:SetCombatTargetingCapable(1)
Unit:SetScale(2)
Unit:RegisterEvent("FelguardClose", 10, 0)
end
RegisterUnitEvent(10002672, 18, "FelguardOnSpawn")

function FelguardClose(Unit, Event)
if (Unit:GetX() > 3708.4619) and (Unit:GetX() < 3712.3398) then
local x = Unit:GetX()
local y = Unit:GetY()
local z = Unit:GetZ()
if ((mngclickgreen == 1) and (Unit:GetY() > -203) and (Unit:GetY() < -201)) then
Unit:RegisterEvent("FelguardKilled", 10, 1)
InfKill = 1
end
if ((mngclickpurple == 1) and (Unit:GetY() > -207) and (Unit:GetY() < -204)) then
Unit:RegisterEvent("FelguardKilled", 10, 1)
InfKill = 2
end
if ((mngclickred == 1) and (Unit:GetY() > -210) and (Unit:GetY() < -208)) then
Unit:RegisterEvent("FelguardKilled", 10, 1)
InfKill = 3
end
if ((mngclickblue == 1) and (Unit:GetY() > -213) and (Unit:GetY() < -211)) then
Unit:RegisterEvent("FelguardKilled", 10, 1)
InfKill = 4
end
end
if(Unit:GetX() > 3712.3398) then
Unit:SetCombatTargetingCapable(0)
Unit:RegisterEvent("mngExplode", 10, 1)
end
if MNGPlayer == nil then
Unit:Despawn(0,0)
else
if MNGPlayer:IsInCombat() then
mnghppct = mnghppct - 11
Unit:Despawn(0,0)
end
end
end

function FelguardKilled(Unit, Event)
MNGScore = MNGScore + 15
FelKilled = FelKilled + 1
Unit:Kill(Unit)
Unit:SetScale(0.1)
end
RegisterUnitEvent(10002672, 4, "MngOnDeath")
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
-- ///////////////////////////////////////////////////// Legion Pit Lord = 10002673 /////////////////////////////////////////////////////////////////// --
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
function PitLordOnSpawn(Unit, Event)
local y = Unit:GetY()
Unit:CreateWaypoint(3713.2117, y, 77.6216, 0, 0, 0, 16632)
Unit:SetCombatTargetingCapable(1)
Unit:SetScale(1)
Unit:RegisterEvent("PitLordClose", 10, 0)
end
RegisterUnitEvent(10002673, 18, "PitLordOnSpawn")

function PitLordClose(Unit, Event)
if (Unit:GetX() > 3708.4619) and (Unit:GetX() < 3712.3398) then
local x = Unit:GetX()
local y = Unit:GetY()
local z = Unit:GetZ()
if ((mngclickgreen == 1) and (Unit:GetY() > -203) and (Unit:GetY() < -201)) then
Unit:RegisterEvent("PitLordKilled", 10, 1)
InfKill = 1
end
if ((mngclickpurple == 1) and (Unit:GetY() > -207) and (Unit:GetY() < -204)) then
Unit:RegisterEvent("PitLordKilled", 10, 1)
InfKill = 2
end
if ((mngclickred == 1) and (Unit:GetY() > -210) and (Unit:GetY() < -208)) then
Unit:RegisterEvent("PitLordKilled", 10, 1)
InfKill = 3
end
if ((mngclickblue == 1) and (Unit:GetY() > -213) and (Unit:GetY() < -211)) then
Unit:RegisterEvent("PitLordKilled", 10, 1)
InfKill = 4
end
end
if(Unit:GetX() > 3712.3398) then
Unit:SetCombatTargetingCapable(0)
Unit:RegisterEvent("mngExplode", 10, 1)
end
if MNGPlayer == nil then
Unit:Despawn(0,0)
else
if MNGPlayer:IsInCombat() then
mnghppct = mnghppct - 15
Unit:Despawn(0,0)
end
end
end

function PitLordKilled(Unit, Event)
MNGScore = MNGScore + 30
PitKilled = PitKilled + 1
Unit:Kill(Unit)
Unit:SetScale(0.1)
end
RegisterUnitEvent(10002673, 4, "MngOnDeath")
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
-- ////////////////////////////////////////////////////// 10002681 = Legion Commander //////////////////////////////////////////////////////////////// --
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
function LegionCommander(Unit, Event)
if CommanderTalk == 1 then
CommanderTalk = 2
mngcmmdmsg = "Very well. Let the game begin!"
Unit:PlaySoundToSet(10338)
end
if CommanderTalk == 2 and MNGScore > 50 then
CommanderTalk = 3
mngcmmdmsg = "The Legion will conquer all!"
Unit:PlaySoundToSet(11333)
end
if CommanderTalk == 3 and MNGScore > 100 then
CommanderTalk = 4
mngcmmdmsg = "All mortals will perish!"
Unit:PlaySoundToSet(11334)
end
if CommanderTalk == 4 and MNGScore > 200 then
CommanderTalk = 5
mngcmmdmsg = "All life must be eradicated!"
Unit:PlaySoundToSet(11335)
end
if CommanderTalk == 5 and MNGScore > 400 then
CommanderTalk = 6
mngcmmdmsg = "The universe will be remade!"
Unit:PlaySoundToSet(11339)
end
if CommanderTalk == 6 and MNGScore > 550 then
CommanderTalk = 8
mngcmmdmsg = "The Legion will conquer all!"
Unit:PlaySoundToSet(11333)
end
if CommanderTalk == 8 and MNGScore > 700 then
CommanderTalk = 9
mngcmmdmsg = "All mortals will perish!"
Unit:PlaySoundToSet(11334)
end
if CommanderTalk == 9 and MNGScore > 1000 then
CommanderTalk = 10
mngcmmdmsg = "All life must be eradicated!"
Unit:PlaySoundToSet(11335)
end
if CommanderTalk == 7 then
CommanderTalk = 0
mngcmmdmsg = "Invasive lifeform no longer functional."
Unit:PlaySoundToSet(11216)
end
-----------------
if (mngcmmdmsg ~= mngcmmdmsgb) then
	Unit:SendChatMessage(14,0,mngcmmdmsg)
	mngcmmdmsgb = mngcmmdmsg
end
end

function reg_LegionCommander(Unit, Event)
Unit:RegisterEvent("LegionCommander", 10, 0)
Unit:SetCombatTargetingCapable(1)
end
RegisterUnitEvent(10002681, 18, "reg_LegionCommander")
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
-- ////////////////////////////////////////////////////// 10002676 = Minigame_helper ///////////////////////////////////////////////////////////////// --
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
function KillEffectCast(Unit, Event)
if ((InfKill == 1) and (Unit:GetY() > -203) and (Unit:GetY() < -201)) then
Unit:CastSpell(33666)
InfKill = 0
end
if ((InfKill == 2) and (Unit:GetY() > -207) and (Unit:GetY() < -204)) then
Unit:CastSpell(34234)
InfKill = 0
end
if ((InfKill == 3) and (Unit:GetY() > -210) and (Unit:GetY() < -208)) then
Unit:CastSpell(43217)
InfKill = 0
end
if ((InfKill == 4) and (Unit:GetY() > -213) and (Unit:GetY() < -211)) then
Unit:SetScale(1)
Unit:CastSpell(27087)
InfKill = 0
end
end

function KillEffect(Unit, Event)
Unit:RegisterEvent("KillEffectCast", 10, 0)
Unit:SetScale(2)
end
RegisterUnitEvent(10002676, 18, "KillEffect")
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
-- //////////////////////////////////////////////////// Minigame 1 Instructor = 10002675 ////////////////////////////////////////////////////////////// --
-- //////////////////////////////////////////////////////////////// Gossip /////////////////////////////////////////////////////////////////////////// --
function EnterMngame1(unit, event)
if mngenter ~= 2 then
	mngmsg = "The game has been started!"
	mngenter = 1
end
end

function Mngame1OnGossip(unit, event, player)
if MNGPlayer == player then
if mngenter == 0 then
	Mngame1Menu(unit, player)
end
else
player:Teleport(560, 3702.67, -148.213, 91.9986)
end
end

function Mngame1Menu(unit, player)
	unit:GossipCreateMenu(100, player, 0)
    unit:GossipMenuAddItem(4, "Lets begin!", 1, 0)
	unit:GossipMenuAddItem(4, "Bye", 2, 0)
	unit:GossipSendMenu(player)
end

function Mngame1SubMenu(unit, event, player, id, intid, code)
	if(intid == 1) then
		unit:RegisterEvent("EnterMngame1",10,1)
		player:GossipComplete()
	end
	---------
	if(intid == 2) then
		player:GossipComplete()
	end
	---------
end
RegisterUnitGossipEvent(10002675, 1, "Mngame1OnGossip")
RegisterUnitGossipEvent(10002675, 2, "Mngame1SubMenu")
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --

-- //////////////////////////////////////////////////////////////////// ON SPAWN /////////////////////////////////////////////////////////////////// --
function SpawnInfernal(unit, Event)
if mngenter == 2 then
Infcounter = Infcounter + 1
infrandom = math.random(4)
if(infrandom == 1) then
unit:SpawnCreature(10002671, 3684.87744, -202.30, 77.6216, 0, 14, 3600000)
end
if(infrandom == 2) then
unit:SpawnCreature(10002671, 3684.87744, -205.57, 77.6216, 0, 14, 3600000)
end
if(infrandom == 3) then
unit:SpawnCreature(10002671, 3684.87744, -209.07, 77.6216, 0, 14, 3600000)
end
if(infrandom == 4) then
unit:SpawnCreature(10002671, 3684.87744, -212.33, 77.6216, 0, 14, 3600000)
end
end
end

function SpawnFelguard(unit, Event)
if mngenter == 2 and EnableFelguard == 1 then
Felcounter = Felcounter + 1
infrandom = math.random(4)
if(infrandom == 1) then
unit:SpawnCreature(10002672, 3684.87744, -202.30, 77.6216, 0, 14, 3600000)
end
if(infrandom == 2) then
unit:SpawnCreature(10002672, 3684.87744, -205.57, 77.6216, 0, 14, 3600000)
end
if(infrandom == 3) then
unit:SpawnCreature(10002672, 3684.87744, -209.07, 77.6216, 0, 14, 3600000)
end
if(infrandom == 4) then
unit:SpawnCreature(10002672, 3684.87744, -212.33, 77.6216, 0, 14, 3600000)
end
end
end

function SpawnPitLord(unit, Event)
if mngenter == 2 and EnablePitLord == 1 then
Pitcounter = Pitcounter + 1
infrandom = math.random(4)
if(infrandom == 1) then
unit:SpawnCreature(10002673, 3684.87744, -202.30, 77.6216, 0, 14, 3600000)
end
if(infrandom == 2) then
unit:SpawnCreature(10002673, 3684.87744, -205.57, 77.6216, 0, 14, 3600000)
end
if(infrandom == 3) then
unit:SpawnCreature(10002673, 3684.87744, -209.07, 77.6216, 0, 14, 3600000)
end
if(infrandom == 4) then
unit:SpawnCreature(10002673, 3684.87744, -212.33, 77.6216, 0, 14, 3600000)
end
end
end

function MNGSpawnsController(unit, event)
if MNGPlayer ~= nil and mngenter == 2 then
if Infcounter == 10 then
	Infcounter = 0
	if (MNGScore > 50) and mngfifty == nil then
	mngfifty = 1
	Infsecs = Infsecs - 200
	end
	if (MNGScore > 100) and mnghundred == nil then
	mnghundred = 1
	Infsecs = Infsecs - 200
	EnableFelguard = 1
	unit:RegisterEvent("SpawnFelguard", Felsecs, 10)
	end
	if (MNGScore > 200) and mngtwohundred == nil then
	mngtwohundred = 1
	Infsecs = Infsecs - 200
	end
	if (MNGScore > 400) then
	if (Infsecs < 1000) then
	Infsecs = 1000
	else
	Infsecs = Infsecs - 200
	end
	end
	unit:RegisterEvent("SpawnInfernal", Infsecs, 10)
end
if Felcounter == 10 then
	Felcounter = 0
	if (MNGScore > 200) and mngtwohundred2 == nil then
	mngtwohundred2 = 1
	Felsecs = Felsecs - 500
	end
	if (MNGScore > 500) and mngtwohundred3 == nil then
	mngtwohundred3 = 1
	Felsecs = Felsecs - 500
	end
	if (MNGScore > 700) and mngtwohundred4 == nil then
	mngtwohundred4 = 1
	EnablePitLord = 1
	unit:RegisterEvent("SpawnPitLord", Pitsecs, 5)
	end
	if (MNGScore > 1000) then
	if (Felsecs < 3000) then
	Felsecs = 3000
	else
	Felsecs = Felsecs - 500
	end
	end
	unit:RegisterEvent("SpawnFelguard", Felsecs, 10)
end
if Pitcounter == 5 then
	Pitcounter = 0
	if MNGScore > 1200 then
	if (Pitsecs < 5000) then
	Pitsecs = 5000
	else
	Pitsecs = Pitsecs - 700
	end
	end
	unit:RegisterEvent("SpawnPitLord", Pitsecs, 5)
end
end
end

function Mngame1repeat(unit, event)
if (mngclickgreen == 1) then
unit:RegisterEvent("greenundo", 10, 1)
end
if (mngclickpurple == 1) then
unit:RegisterEvent("purpleundo", 10, 1)
end
if (mngclickred == 1) then
unit:RegisterEvent("redundo", 10, 1)
end
if (mngclickblue == 1) then
unit:RegisterEvent("blueundo", 10, 1)
end
----------------
if (mngmsg ~= mngmsgb) then
	unit:SendChatMessage(12,0,mngmsg)
	mngmsgb = mngmsg
end
----------------
if (mngenter == 1) then
	mngenter = 2
mnghppct = 100
mngclickgreen = 0
mngclickpurple = 0
mngclickred = 0
mngclickblue = 0
Infkill = 0
MNGScore = 0
Infcounter = 0
Felcounter = 0
Pitcounter = 0
Infsecs = 4000
Felsecs = 9000
Pitsecs = 20000
mngfifty = nil
mnghundred = nil
mngtwohundred = nil
mngtwohundred2 = nil
mngtwohundred3 = nil
mngtwohundred4 = nil
EnableFelguard = 0
EnablePitLord = 0
InfKilled = 0
FelKilled = 0
PitKilled = 0
MNGTotalClicks = 0
	unit:RegisterEvent("MNGSpawnsController", 10, 0)
	unit:RegisterEvent("SpawnInfernal", Infsecs, 10)
	CommanderTalk = 1
	unit:SetModel(11686)
	unit:SetNPCFlags(0)
	unit:SetCombatTargetingCapable(1)
end
-------------------
if(MNGPlayer ~= nil) then
if(mnghppct > 1) then
MNGPlayer:SetHealthPct(mnghppct)
else
unit:RegisterEvent("Mngame1End", 10, 1)
end
end
if unit:GetClosestPlayer() == nil then
MNGPlayer = nil
unit:RegisterEvent("Mngame1End", 10, 1)
else
if (MNGPlayer ~= nil) then
if (unit:GetDistance(unit:GetClosestPlayer()) > 30) or (unit:GetClosestPlayer() == nil) then
unit:RegisterEvent("Mngame1End", 10, 1)
end
end
end
-- /////////// Reset /////////// --
if MNGPlayer == nil then
mnghppct = 100
mngclickgreen = 0
mngclickpurple = 0
mngclickred = 0
mngclickblue = 0
Infkill = 0
MNGScore = 0
mngenter = 0
Infcounter = 0
Felcounter = 0
Pitcounter = 0
Infsecs = 4000
Felsecs = 9000
Pitsecs = 20000
mngfifty = nil
mnghundred = nil
mngtwohundred = nil
mngtwohundred2 = nil
mngtwohundred3 = nil
mngtwohundred4 = nil
EnableFelguard = 0
EnablePitLord = 0
InfKilled = 0
FelKilled = 0
PitKilled = 0
MNGTotalClicks = 0
MNGReward_get = nil
end
end

function Mngame1End(unit, event)
CommanderTalk = 7
unit:SetModel(21858)
unit:SetNPCFlags(1)
if MNGPlayer ~= nil then
MNGPlayer:SetHealthPct(1)
-- /////////////// Score ////////////// --
if MNGScore ~= 0 then
if (((InfKilled + FelKilled + PitKilled)/MNGTotalClicks) > 0.1) then
if MNGScoreEnd1 < MNGScore then
MNGScoreEnd10= MNGScoreEnd9; MNGPlayerEnd10= MNGPlayerEnd9;     MNGinf10= MNGinf9; MNGfel10= MNGfel9; MNGpit10= MNGpit9; MNGClicks10= MNGClicks9;
MNGScoreEnd9 = MNGScoreEnd8; MNGPlayerEnd9 = MNGPlayerEnd8;     MNGinf9 = MNGinf8; MNGfel9 = MNGfel8; MNGpit9 = MNGpit8; MNGClicks9 = MNGClicks8;
MNGScoreEnd8 = MNGScoreEnd7; MNGPlayerEnd8 = MNGPlayerEnd7;     MNGinf8 = MNGinf7; MNGfel8 = MNGfel7; MNGpit8 = MNGpit7; MNGClicks8 = MNGClicks7;
MNGScoreEnd7 = MNGScoreEnd6; MNGPlayerEnd7 = MNGPlayerEnd6;     MNGinf7 = MNGinf6; MNGfel7 = MNGfel6; MNGpit7 = MNGpit6; MNGClicks7 = MNGClicks6;
MNGScoreEnd6 = MNGScoreEnd5; MNGPlayerEnd6 = MNGPlayerEnd5;     MNGinf6 = MNGinf5; MNGfel6 = MNGfel5; MNGpit6 = MNGpit5; MNGClicks6 = MNGClicks5;
MNGScoreEnd5 = MNGScoreEnd4; MNGPlayerEnd5 = MNGPlayerEnd4;     MNGinf5 = MNGinf4; MNGfel5 = MNGfel4; MNGpit5 = MNGpit4; MNGClicks5 = MNGClicks4;
MNGScoreEnd4 = MNGScoreEnd3; MNGPlayerEnd4 = MNGPlayerEnd3;     MNGinf4 = MNGinf3; MNGfel4 = MNGfel3; MNGpit4 = MNGpit3; MNGClicks4 = MNGClicks3;
MNGScoreEnd3 = MNGScoreEnd2; MNGPlayerEnd3 = MNGPlayerEnd2;     MNGinf3 = MNGinf2; MNGfel3 = MNGfel2; MNGpit3 = MNGpit2; MNGClicks3 = MNGClicks2;
MNGScoreEnd2 = MNGScoreEnd1; MNGPlayerEnd2 = MNGPlayerEnd1;     MNGinf2 = MNGinf1; MNGfel2 = MNGfel1; MNGpit2 = MNGpit1; MNGClicks2 = MNGClicks1;
MNGScoreEnd1 = MNGScore;     MNGPlayerEnd1 = MNGPlayer:GetName(); MNGinf1 = InfKilled; MNGfel1 = FelKilled; MNGpit1 = PitKilled; MNGClicks1 = MNGTotalClicks;
else
 if MNGScoreEnd2 < MNGScore then
 MNGScoreEnd10= MNGScoreEnd9; MNGPlayerEnd10= MNGPlayerEnd9;     MNGinf10= MNGinf9; MNGfel10= MNGfel9; MNGpit10= MNGpit9; MNGClicks10= MNGClicks9;
 MNGScoreEnd9 = MNGScoreEnd8; MNGPlayerEnd9 = MNGPlayerEnd8;     MNGinf9 = MNGinf8; MNGfel9 = MNGfel8; MNGpit9 = MNGpit8; MNGClicks9 = MNGClicks8;
 MNGScoreEnd8 = MNGScoreEnd7; MNGPlayerEnd8 = MNGPlayerEnd7;     MNGinf8 = MNGinf7; MNGfel8 = MNGfel7; MNGpit8 = MNGpit7; MNGClicks8 = MNGClicks7;
 MNGScoreEnd7 = MNGScoreEnd6; MNGPlayerEnd7 = MNGPlayerEnd6;     MNGinf7 = MNGinf6; MNGfel7 = MNGfel6; MNGpit7 = MNGpit6; MNGClicks7 = MNGClicks6;
 MNGScoreEnd6 = MNGScoreEnd5; MNGPlayerEnd6 = MNGPlayerEnd5;     MNGinf6 = MNGinf5; MNGfel6 = MNGfel5; MNGpit6 = MNGpit5; MNGClicks6 = MNGClicks5;
 MNGScoreEnd5 = MNGScoreEnd4; MNGPlayerEnd5 = MNGPlayerEnd4;     MNGinf5 = MNGinf4; MNGfel5 = MNGfel4; MNGpit5 = MNGpit4; MNGClicks5 = MNGClicks4;
 MNGScoreEnd4 = MNGScoreEnd3; MNGPlayerEnd4 = MNGPlayerEnd3;     MNGinf4 = MNGinf3; MNGfel4 = MNGfel3; MNGpit4 = MNGpit3; MNGClicks4 = MNGClicks3;
 MNGScoreEnd3 = MNGScoreEnd2; MNGPlayerEnd3 = MNGPlayerEnd2;     MNGinf3 = MNGinf2; MNGfel3 = MNGfel2; MNGpit3 = MNGpit2; MNGClicks3 = MNGClicks2;
 MNGScoreEnd2 = MNGScore;       MNGPlayerEnd2 = MNGPlayer:GetName(); MNGinf2 = InfKilled; MNGfel2 = FelKilled; MNGpit2 = PitKilled; MNGClicks2 = MNGTotalClicks;
 else
  if MNGScoreEnd3 < MNGScore then
  MNGScoreEnd10= MNGScoreEnd9; MNGPlayerEnd10= MNGPlayerEnd9;     MNGinf10= MNGinf9; MNGfel10= MNGfel9; MNGpit10= MNGpit9; MNGClicks10= MNGClicks9;
  MNGScoreEnd9 = MNGScoreEnd8; MNGPlayerEnd9 = MNGPlayerEnd8;     MNGinf9 = MNGinf8; MNGfel9 = MNGfel8; MNGpit9 = MNGpit8; MNGClicks9 = MNGClicks8;
  MNGScoreEnd8 = MNGScoreEnd7; MNGPlayerEnd8 = MNGPlayerEnd7;     MNGinf8 = MNGinf7; MNGfel8 = MNGfel7; MNGpit8 = MNGpit7; MNGClicks8 = MNGClicks7;
  MNGScoreEnd7 = MNGScoreEnd6; MNGPlayerEnd7 = MNGPlayerEnd6;     MNGinf7 = MNGinf6; MNGfel7 = MNGfel6; MNGpit7 = MNGpit6; MNGClicks7 = MNGClicks6;
  MNGScoreEnd6 = MNGScoreEnd5; MNGPlayerEnd6 = MNGPlayerEnd5;     MNGinf6 = MNGinf5; MNGfel6 = MNGfel5; MNGpit6 = MNGpit5; MNGClicks6 = MNGClicks5;
  MNGScoreEnd5 = MNGScoreEnd4; MNGPlayerEnd5 = MNGPlayerEnd4;     MNGinf5 = MNGinf4; MNGfel5 = MNGfel4; MNGpit5 = MNGpit4; MNGClicks5 = MNGClicks4;
  MNGScoreEnd4 = MNGScoreEnd3; MNGPlayerEnd4 = MNGPlayerEnd3;     MNGinf4 = MNGinf3; MNGfel4 = MNGfel3; MNGpit4 = MNGpit3; MNGClicks4 = MNGClicks3;
  MNGScoreEnd3 = MNGScore;       MNGPlayerEnd3 = MNGPlayer:GetName(); MNGinf3 = InfKilled; MNGfel3 = FelKilled; MNGpit3 = PitKilled; MNGClicks3 = MNGTotalClicks;
  else
   if MNGScoreEnd4 < MNGScore then
   MNGScoreEnd10= MNGScoreEnd9; MNGPlayerEnd10= MNGPlayerEnd9;     MNGinf10= MNGinf9; MNGfel10= MNGfel9; MNGpit10= MNGpit9; MNGClicks10= MNGClicks9;
   MNGScoreEnd9 = MNGScoreEnd8; MNGPlayerEnd9 = MNGPlayerEnd8;     MNGinf9 = MNGinf8; MNGfel9 = MNGfel8; MNGpit9 = MNGpit8; MNGClicks9 = MNGClicks8;
   MNGScoreEnd8 = MNGScoreEnd7; MNGPlayerEnd8 = MNGPlayerEnd7;     MNGinf8 = MNGinf7; MNGfel8 = MNGfel7; MNGpit8 = MNGpit7; MNGClicks8 = MNGClicks7;
   MNGScoreEnd7 = MNGScoreEnd6; MNGPlayerEnd7 = MNGPlayerEnd6;     MNGinf7 = MNGinf6; MNGfel7 = MNGfel6; MNGpit7 = MNGpit6; MNGClicks7 = MNGClicks6;
   MNGScoreEnd6 = MNGScoreEnd5; MNGPlayerEnd6 = MNGPlayerEnd5;     MNGinf6 = MNGinf5; MNGfel6 = MNGfel5; MNGpit6 = MNGpit5; MNGClicks6 = MNGClicks5;
   MNGScoreEnd5 = MNGScoreEnd4; MNGPlayerEnd5 = MNGPlayerEnd4;     MNGinf5 = MNGinf4; MNGfel5 = MNGfel4; MNGpit5 = MNGpit4; MNGClicks5 = MNGClicks4;
   MNGScoreEnd4 = MNGScore;     MNGPlayerEnd4 = MNGPlayer:GetName(); MNGinf4 = InfKilled; MNGfel4 = FelKilled; MNGpit4 = PitKilled; MNGClicks4 = MNGTotalClicks;
   else
    if MNGScoreEnd5 < MNGScore then
    MNGScoreEnd10= MNGScoreEnd9; MNGPlayerEnd10= MNGPlayerEnd9;     MNGinf10= MNGinf9; MNGfel10= MNGfel9; MNGpit10= MNGpit9; MNGClicks10= MNGClicks9;
    MNGScoreEnd9 = MNGScoreEnd8; MNGPlayerEnd9 = MNGPlayerEnd8;     MNGinf9 = MNGinf8; MNGfel9 = MNGfel8; MNGpit9 = MNGpit8; MNGClicks9 = MNGClicks8;
    MNGScoreEnd8 = MNGScoreEnd7; MNGPlayerEnd8 = MNGPlayerEnd7;     MNGinf8 = MNGinf7; MNGfel8 = MNGfel7; MNGpit8 = MNGpit7; MNGClicks8 = MNGClicks7;
    MNGScoreEnd7 = MNGScoreEnd6; MNGPlayerEnd7 = MNGPlayerEnd6;     MNGinf7 = MNGinf6; MNGfel7 = MNGfel6; MNGpit7 = MNGpit6; MNGClicks7 = MNGClicks6;
    MNGScoreEnd6 = MNGScoreEnd5; MNGPlayerEnd6 = MNGPlayerEnd5;     MNGinf6 = MNGinf5; MNGfel6 = MNGfel5; MNGpit6 = MNGpit5; MNGClicks6 = MNGClicks5;
    MNGScoreEnd5 = MNGScore;       MNGPlayerEnd5 = MNGPlayer:GetName(); MNGinf5 = InfKilled; MNGfel5 = FelKilled; MNGpit5 = PitKilled; MNGClicks5 = MNGTotalClicks;
	else
     if MNGScoreEnd6 < MNGScore then
     MNGScoreEnd10= MNGScoreEnd9; MNGPlayerEnd10= MNGPlayerEnd9;     MNGinf10= MNGinf9; MNGfel10= MNGfel9; MNGpit10= MNGpit9; MNGClicks10= MNGClicks9;
     MNGScoreEnd9 = MNGScoreEnd8; MNGPlayerEnd9 = MNGPlayerEnd8;     MNGinf9 = MNGinf8; MNGfel9 = MNGfel8; MNGpit9 = MNGpit8; MNGClicks9 = MNGClicks8;
     MNGScoreEnd8 = MNGScoreEnd7; MNGPlayerEnd8 = MNGPlayerEnd7;     MNGinf8 = MNGinf7; MNGfel8 = MNGfel7; MNGpit8 = MNGpit7; MNGClicks8 = MNGClicks7;
     MNGScoreEnd7 = MNGScoreEnd6; MNGPlayerEnd7 = MNGPlayerEnd6;     MNGinf7 = MNGinf6; MNGfel7 = MNGfel6; MNGpit7 = MNGpit6; MNGClicks7 = MNGClicks6;
     MNGScoreEnd6 = MNGScore;       MNGPlayerEnd6 = MNGPlayer:GetName(); MNGinf6 = InfKilled; MNGfel6 = FelKilled; MNGpit6 = PitKilled; MNGClicks6 = MNGTotalClicks;
	 else
      if MNGScoreEnd7 < MNGScore then
      MNGScoreEnd10= MNGScoreEnd9; MNGPlayerEnd10= MNGPlayerEnd9;     MNGinf10= MNGinf9; MNGfel10= MNGfel9; MNGpit10= MNGpit9; MNGClicks10= MNGClicks9;
      MNGScoreEnd9 = MNGScoreEnd8; MNGPlayerEnd9 = MNGPlayerEnd8;     MNGinf9 = MNGinf8; MNGfel9 = MNGfel8; MNGpit9 = MNGpit8; MNGClicks9 = MNGClicks8;
      MNGScoreEnd8 = MNGScoreEnd7; MNGPlayerEnd8 = MNGPlayerEnd7;     MNGinf8 = MNGinf7; MNGfel8 = MNGfel7; MNGpit8 = MNGpit7; MNGClicks8 = MNGClicks7;
      MNGScoreEnd7 = MNGScore;       MNGPlayerEnd7 = MNGPlayer:GetName(); MNGinf7 = InfKilled; MNGfel7 = FelKilled; MNGpit7 = PitKilled; MNGClicks7 = MNGTotalClicks;
	  else
       if MNGScoreEnd8 < MNGScore then
       MNGScoreEnd10= MNGScoreEnd9; MNGPlayerEnd10= MNGPlayerEnd9;     MNGinf10= MNGinf9; MNGfel10= MNGfel9; MNGpit10= MNGpit9; MNGClicks10= MNGClicks9;
       MNGScoreEnd9 = MNGScoreEnd8; MNGPlayerEnd9 = MNGPlayerEnd8;     MNGinf9 = MNGinf8; MNGfel9 = MNGfel8; MNGpit9 = MNGpit8; MNGClicks9 = MNGClicks8;
       MNGScoreEnd8 = MNGScore;       MNGPlayerEnd8 = MNGPlayer:GetName(); MNGinf8 = InfKilled; MNGfel8 = FelKilled; MNGpit8 = PitKilled; MNGClicks8 = MNGTotalClicks;
	   else
        if MNGScoreEnd9 < MNGScore then
        MNGScoreEnd10= MNGScoreEnd9; MNGPlayerEnd10= MNGPlayerEnd9;     MNGinf10= MNGinf9; MNGfel10= MNGfel9; MNGpit10= MNGpit9; MNGClicks10= MNGClicks9;
        MNGScoreEnd9 = MNGScore;       MNGPlayerEnd9 = MNGPlayer:GetName(); MNGinf9 = InfKilled; MNGfel9 = FelKilled; MNGpit9 = PitKilled; MNGClicks9 = MNGTotalClicks;
		else
         if MNGScoreEnd10 < MNGScore then
         MNGScoreEnd10 = MNGScore;       MNGPlayerEnd10 = MNGPlayer:GetName(); MNGinf10 = InfKilled; MNGfel10 = FelKilled; MNGpit10 = PitKilled; MNGClicks10 = MNGTotalClicks;
		 end
		end
	   end
	  end
	 end
	end
   end
  end
 end
end
if MNGScoreEnd1 ~= 0 then
MNGEndScore1 = string.format("1. %s, %s, %s, %s, %s, %.2f", MNGScoreEnd1, MNGPlayerEnd1, MNGinf1, MNGfel1, MNGpit1, (MNGinf1 + MNGfel1 + MNGpit1)/MNGClicks1);
if MNGScoreEnd2 ~= 0 then
 MNGEndScore2 = string.format("2. %s, %s, %s, %s, %s, %.2f", MNGScoreEnd2, MNGPlayerEnd2, MNGinf2, MNGfel2, MNGpit2, (MNGinf2 + MNGfel2 + MNGpit2)/MNGClicks2);
if MNGScoreEnd3 ~= 0 then
  MNGEndScore3 = string.format("3. %s, %s, %s, %s, %s, %.2f", MNGScoreEnd3, MNGPlayerEnd3, MNGinf3, MNGfel3, MNGpit3, (MNGinf3 + MNGfel3 + MNGpit3)/MNGClicks3);
if MNGScoreEnd4 ~= 0 then
   MNGEndScore4 = string.format("4. %s, %s, %s, %s, %s, %.2f", MNGScoreEnd4, MNGPlayerEnd4, MNGinf4, MNGfel4, MNGpit4, (MNGinf4 + MNGfel4 + MNGpit4)/MNGClicks4);
if MNGScoreEnd5 ~= 0 then
    MNGEndScore5 = string.format("5. %s, %s, %s, %s, %s, %.2f", MNGScoreEnd5, MNGPlayerEnd5, MNGinf5, MNGfel5, MNGpit5, (MNGinf5 + MNGfel5 + MNGpit5)/MNGClicks5);
if MNGScoreEnd6 ~= 0 then
     MNGEndScore6 = string.format("6. %s, %s, %s, %s, %s, %.2f", MNGScoreEnd6, MNGPlayerEnd6, MNGinf6, MNGfel6, MNGpit6, (MNGinf6 + MNGfel6 + MNGpit6)/MNGClicks6);
if MNGScoreEnd7 ~= 0 then
      MNGEndScore7 = string.format("7. %s, %s, %s, %s, %s, %.2f", MNGScoreEnd7, MNGPlayerEnd7, MNGinf7, MNGfel7, MNGpit7, (MNGinf7 + MNGfel7 + MNGpit7)/MNGClicks7);
if MNGScoreEnd8 ~= 0 then
       MNGEndScore8 = string.format("8. %s, %s, %s, %s, %s, %.2f", MNGScoreEnd8, MNGPlayerEnd8, MNGinf8, MNGfel8, MNGpit8, (MNGinf8 + MNGfel8 + MNGpit8)/MNGClicks8);
if MNGScoreEnd9 ~= 0 then
        MNGEndScore9 = string.format("9. %s, %s, %s, %s, %s, %.2f", MNGScoreEnd9, MNGPlayerEnd9, MNGinf9, MNGfel9, MNGpit9, (MNGinf9 + MNGfel9 + MNGpit9)/MNGClicks9);
if MNGScoreEnd10 ~= 0 then
         MNGEndScore10 = string.format("10. %s, %s, %s, %s, %s, %.2f", MNGScoreEnd10, MNGPlayerEnd10, MNGinf10, MNGfel10, MNGpit10, (MNGinf10 + MNGfel10 + MNGpit10)/MNGClicks10);
end
end
end
end
end
end
end
end
end
end
mngmsg = string.format("Game Over! Total score: %s, %s, %s, %s, %s, %.2f", MNGScore, MNGPlayer:GetName(), InfKilled, FelKilled, PitKilled, (InfKilled + FelKilled + PitKilled)/MNGTotalClicks)
if MNGScoreEnd1 < MNGScore then
MNGReward_get = 1
else
 if MNGScoreEnd2 < MNGScore then
 MNGReward_get = 1
 else
  if MNGScoreEnd3 < MNGScore then
  MNGReward_get = 1
  else
   if MNGScoreEnd4 < MNGScore then
   MNGReward_get = 1
   else
    if MNGScoreEnd5 < MNGScore then
	MNGReward_get = 1
	else
     if MNGScoreEnd6 < MNGScore then
	 MNGReward_get = 1
	 else
      if MNGScoreEnd7 < MNGScore then
	  MNGReward_get = 1
	  else
       if MNGScoreEnd8 < MNGScore then
	   MNGReward_get = 1
	   else
        if MNGScoreEnd9 < MNGScore then
		MNGReward_get = 1
		else
         if MNGScoreEnd10 < MNGScore then
		 MNGReward_get = 1
		 end
		end
	   end
	  end
	 end
	end
   end
  end
 end
end
if MNGReward_get == 1 then
	if MNGScore > 600 then
		MNGPlayer:AddItem(70087,1)
	end
	if MNGScore > 1200 then
		MNGPlayer:AddItem(70087,1)
		if (((InfKilled + FelKilled + PitKilled)/MNGTotalClicks) > 0.8) then
			MNGPlayer:AddItem(70087,1)
		end
	end
	if MNGScore > 1800 then
		MNGPlayer:AddItem(70087,1)
	end
end
else
mngmsg3000 = string.format("Total score: %s, %s, %s, %s, %s, %.2f. Accuracy too low, auto-click bot protection on. Score invalid!!", MNGScore, MNGPlayer:GetName(), InfKilled, FelKilled, PitKilled, (InfKilled + FelKilled + PitKilled)/MNGTotalClicks)
unit:SendChatMessage(14, 0, mngmsg3000)
end
end
-- /////////////////////////////////// --
MNGPlayer:Teleport(560, 3702.67, -148.213, 91.9986)
MNGPlayer = nil
end
end

function Mngame1Onspawn(unit, event)
	unit:RegisterEvent("Mngame1repeat", 10, 0)
end
RegisterUnitEvent(10002675, 18, "Mngame1Onspawn")
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
-- /////////////////////////////////////////////////////// Minigame 1 Teleporter = 10002674 /////////////////////////////////////////////////////////// --
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
function MNGsafeguard(unit, event)
if mngenter ~= 2 and MNGPlayer ~= nil then
MNGPlayer:Teleport(560, 3702.67, -148.213, 91.9986)
end
end

function EnterTpMngame1(unit, event)
if MNGPlayer == nil then
MNGPlayer = mngp
mngp:Teleport(560, 3719.46, -207.216, 78.8402)
mngmsg2 = string.format("%s has been teleported to the gaming ground", mngp:GetName())
unit:RegisterEvent("MNGsafeguard", 10000, 1)
else
mngmsg2 = string.format("%s, you can't join now, wait till %s is game over.", mngp:GetName(), MNGPlayer:GetName())
end
end

function TpMngame1OnGossip(unit, event, player)
	TpMngame1Menu(unit, player)
end

function TpMngame1Menu(unit, player)
	unit:GossipCreateMenu(100, player, 0)
    unit:GossipMenuAddItem(0, "Explain how this game works please.", 52, 0)
    unit:GossipMenuAddItem(4, "Start game", 1, 0)
	unit:GossipMenuAddItem(4, "Show me the Score List", 2, 0)
	unit:GossipMenuAddItem(4, "Teleport me back please", 51, 0)
	unit:GossipSendMenu(player)
end

function TpMngame1SubMenu(unit, event, player, id, intid, code)
	if(intid == 1) then
		unit:RegisterEvent("EnterTpMngame1",10,1)
		mngp = player
		player:GossipComplete()
	end
	---------
	if(intid == 2) then
		unit:GossipCreateMenu(99, player, 0)
		if (MNGScoreEnd1 == 0) then
		unit:GossipMenuAddItem(5, "No-one has played yet today.", 4, 0)
		else
		unit:GossipMenuAddItem(5, "Rank. Score, Name, I, F, P, Accuracy", 3, 0)
		 if (MNGScoreEnd2 == 0) and MNGEndScore2 == nil then
		unit:GossipMenuAddItem(5, MNGEndScore1, 5, 0)
		else
		  if (MNGScoreEnd3 == 0) and MNGEndScore3 == nil then
		 MNGS2 = string.format("%s\n%s", MNGEndScore1, MNGEndScore2)
		 unit:GossipMenuAddItem(5, MNGS2, 5, 0)
		 else
		   if (MNGScoreEnd4 == 0) and MNGEndScore4 == nil then
		 MNGS3 = string.format("%s\n%s\n%s", MNGEndScore1, MNGEndScore2, MNGEndScore3)
		  unit:GossipMenuAddItem(5, MNGS3, 7, 0)
		  else
		    if (MNGScoreEnd5 == 0) and MNGEndScore5 == nil then
		 MNGS4 = string.format("%s\n%s\n%s\n%s", MNGEndScore1, MNGEndScore2, MNGEndScore3, MNGEndScore4)
		   unit:GossipMenuAddItem(5, MNGS4, 8, 0)
		   else
		     if (MNGScoreEnd6 == 0) and MNGEndScore6 == nil then
		 MNGS5 = string.format("%s\n%s\n%s\n%s\n%s", MNGEndScore1, MNGEndScore2, MNGEndScore3, MNGEndScore4, MNGEndScore5)
		    unit:GossipMenuAddItem(5, MNGS5, 9, 0)
			else
			  if (MNGScoreEnd7 == 0) and MNGEndScore7 == nil then
		 MNGS6 = string.format("%s\n%s\n%s\n%s\n%s\n%s", MNGEndScore1, MNGEndScore2, MNGEndScore3, MNGEndScore4, MNGEndScore5, MNGEndScore6)
		     unit:GossipMenuAddItem(5, MNGS6, 10, 0)
			 else
			   if (MNGScoreEnd8 == 0) and MNGEndScore8 == nil then
		 MNGS7 = string.format("%s\n%s\n%s\n%s\n%s\n%s\n%s", MNGEndScore1, MNGEndScore2, MNGEndScore3, MNGEndScore4, MNGEndScore5, MNGEndScore6, MNGEndScore7)
			  unit:GossipMenuAddItem(5, MNGS7, 11, 0)
			  else
			    if (MNGScoreEnd9 == 0) and MNGEndScore9 == nil then
		 MNGS8 = string.format("%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s", MNGEndScore1, MNGEndScore2, MNGEndScore3, MNGEndScore4, MNGEndScore5, MNGEndScore6, MNGEndScore7, MNGEndScore8)
			   unit:GossipMenuAddItem(5, MNGS8, 12, 0)
			   else
			     if (MNGScoreEnd10 == 0) and MNGEndScore10 == nil then
		 MNGS9 = string.format("%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s", MNGEndScore1, MNGEndScore2, MNGEndScore3, MNGEndScore4, MNGEndScore5, MNGEndScore6, MNGEndScore7, MNGEndScore8, MNGEndScore9)
			    unit:GossipMenuAddItem(5, MNGS9, 13, 0)
			     else
		 MNGS10 = string.format("%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s", MNGEndScore1, MNGEndScore2, MNGEndScore3, MNGEndScore4, MNGEndScore5, MNGEndScore6, MNGEndScore7, MNGEndScore8, MNGEndScore9, MNGEndScore10)
			  	 unit:GossipMenuAddItem(5, MNGS10, 14, 0)
				 end
			    end
			   end
			  end
			 end
		    end
		   end
		  end

		 end
		unit:GossipMenuAddItem(5, "I = Infernal, F = Felguard, P = Pit Lord\n Accuracy = Kills/Clicks", 15, 0)
		end
		unit:GossipMenuAddItem(5, "[Back]", 50, 0)
		unit:GossipSendMenu(player)
	end
	---------
	if(intid > 2) and (intid < 16) then
		player:GossipComplete()
	end
	---------
	if(intid == 50) then
		TpMngame1Menu(unit, player)
	end
	if(intid == 51) then
		player:Teleport(1,-8467.96,-4236.72,-208.443)
	end
	if(intid == 52) then
	unit:GossipCreateMenu(101, player, 0)
	unit:GossipMenuAddItem(0, "Click one of the four couldrons when an enemy enters the last square to eliminate it. If an enemy isn't eliminated in time it'll damage you.", 53, 0)
	unit:GossipMenuAddItem(0, "[Next]", 53, 0)
	unit:GossipSendMenu(player)
	end
	if(intid == 53) then
	unit:GossipCreateMenu(102, player, 0)
	unit:GossipMenuAddItem(0, "If your health is at 1 percent, you're game over and you'll get your reward.", 54, 0)
	unit:GossipMenuAddItem(0, "[Next]", 54, 0)
	unit:GossipSendMenu(player)
	end
	if(intid == 54) then
	unit:GossipCreateMenu(103, player, 0)
	unit:GossipMenuAddItem(0, "Eliminate as many enemies as you can, for every enemy you kill you get points. For every 600 points you get 50 gold, that is if you are in the top 10 with your score.", 55, 0)
	unit:GossipMenuAddItem(0, "[Next]", 55, 0)
	unit:GossipSendMenu(player)
	end
	if(intid == 55) then
	unit:GossipCreateMenu(104, player, 0)
	unit:GossipMenuAddItem(0, "If your score is higher than 1200 and your accuracy is higher than 0.8 you'll get a bonus of 50 gold.", 56, 0)
	unit:GossipMenuAddItem(0, "[Next]", 56, 0)
	unit:GossipSendMenu(player)
	end
	if(intid == 56) then
	unit:GossipCreateMenu(105, player, 0)
	unit:GossipMenuAddItem(0, "Good luck, and have fun!", 57, 0)
	unit:GossipMenuAddItem(0, "[Back to Main Menu]", 57, 0)
	unit:GossipSendMenu(player)
	end
	if(intid == 57) then
	TpMngame1Menu(unit, player)
	end
end
RegisterUnitGossipEvent(10002674, 1, "TpMngame1OnGossip")
RegisterUnitGossipEvent(10002674, 2, "TpMngame1SubMenu")

function TpMngame1repeat(unit, event)
if (mngmsg2 ~= mngmsg2b) then
	unit:SendChatMessage(12,0,mngmsg2)
	mngmsg2b = mngmsg2
end
end

function TpMngame1Onspawn(unit, event)
	unit:RegisterEvent("TpMngame1repeat", 10, 0)
end
RegisterUnitEvent(10002674, 18, "TpMngame1Onspawn")
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
function MNGPortal(pUnit, Event, pMisc)
pMisc:Teleport(560, 3702.67, -148.213, 91.9986)
end
RegisterGameObjectEvent(5000195, 4, "MNGPortal")
