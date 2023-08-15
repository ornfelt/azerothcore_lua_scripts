--[[ The Lurker Below.lua
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
-- LUA++ staff, March 26, 2008. ]]


r = 20


function OnCombat(Unit, event)
    Lurker = Unit
    Lurker:RegisterEvent("Geyser", 12000, 0)
    Lurker:RegisterEvent("Whirl", 32000, 1)
    Lurker:RegisterEvent("WaterboltCheck", 5000, 0)
    Lurker:RegisterEvent("dummyspawn", 45000, 1)
    Lurker:RegisterEvent("Phase2", 120000, 1)
    Lurker:RegisterEvent("DidthatCheck", 5000, 0)
    end
    
function OnLeaveCombat(Unit, event)
    Lurker:RemoveEvents()
    end
    
function OnKilledTarget(Unit, event)
    Lurker:RemoveEvents()
    end

function OnDied(Unit, event)
    Lurker:RemoveEvents()
end

function dummyspawn(Unit, event)
    local tank = Unit:GetMainTank()
    if (tank ~= nil) then
    local x = tank:GetX()
    local y = tank:GetY()
    z = Lurker:GetZ()
    o = Lurker:GetO()
    Lurker:SpawnCreature(18729, x, y, z-3, o, 936, 0)
    Lurker:RegisterEvent("TauntedByDummy", 90, 1)
    else
    end
    end
    
function SpoutFire(Unit, event)
    Lurker:FullCastSpell(37433)
    Lurker:RegisterEvent("SpoutFire", 2500, 1) --Why are we registering the SpoutFire function once, but then it leads right back to it again, causing it to just reregister it. Should just use 0 instead.
    end
    
function TauntedByDummy(Unit, event)
    print "TauntedByDummy initiated..."
    Lurker:SetCombatMeleeCapable(1)
    Lurker:ChangeTarget(Dummy)
    Lurker:SetCombatTargetingCapable(1)
    Targeting = 1
end

--DummyAI--
function DummySpawn(Unit, event)
    print "DummySpawn initiated..."
    Dummy = Unit
    Dummy:SetNPCFlags(4)
    Dummy:SetCombatMeleeCapable(1)
    Dummy:SetCombatTargetingCapable(1)
    Targeting2 = 1
    Dummy:RegisterEvent("Dummytest", 100 , 1)
    Dummy:RegisterEvent("DummyImmune", 100, 1)
end

function DummyImmune(Unit, event)
    Dummy:CastSpell(37588)
    Dummy:CastSpell(37905)
    end
    
function Dummytest(Unit, event)
    if Targeting == 1 then
    print "Dummy Targeted"
    end
    if Targeting2 == 1 then
    print "Lurker Targeted, Success"
    Dummy:RegisterEvent("DummyMove", 1000, 1)
    end
end

function DummyMove(Unit, event)
    Lurker:RemoveEvents()
    x = Lurker:GetX()
    y = Lurker:GetY()
    Lurker:RegisterEvent("SpoutFire",2500, 1)
    Dummy:RegisterEvent("Move", 1, 1)
    Didthat = 1
    print "Didthat = 1"
    end

function Move(Unit, event)
    Dummy:CreateCustomWaypointMap()
    a = 0
    repeat
        print (a)
        a = a+0.1291543
        Xpos = x+r*math.cos(a)
        Ypos = y+r*math.sin(a)
        Dummy:CreateWaypoint(Xpos, Ypos, z-3, o, 0, 256, 20216)
    until a >=6.457715
    Lurker:RegisterEvent("DidthatCheck", 5000, 0)
    Dummy:MoveToWaypoint(1)
    Dummy:RegisterEvent("Destroy", 25000, 1)
    end

function DidthatCheck(Unit, event)
    if Didthat == 1 then
    print "passed =]"
    Passed = 2
    end
    if Passed == 2 then
    Normal = 1
    end
    end
    
function Destroy(Unit, event)
    Dummy:DestroyCustomWaypointMap()
    Dummy:Despawn(0, 0)
    Lurker:RemoveEvents()
    Lurker:SetCombatMeleeCapable(0)
    Lurker:GetMainTank()
    Lurker:RegisterEvent("DidthatCheck", 5000, 0)
    Lurker:RegisterEvent("Geyser", 12000, 0)
    Lurker:RegisterEvent("Whirl", 32000, 1)
    Lurker:RegisterEvent("WaterboltCheck", 5000, 0)
    Lurker:RegisterEvent("dummyspawn", 45000, 1)
    if Didthat == 1 then
    Lurker:RegisterEvent("Phase2", 75000, 1)
    Didthat = 0
    end
    if Passed == 2 then
    Lurker:RegisterEvent("Phase2", 30000, 1)
    Passed = 0
    end
    if Normal == 1 then
    Lurker:RegisterEvent("Phase2", 120000, 1)
    end
    end
    
RegisterUnitEvent(18729, 6, "DummySpawn")

function Geyser(Unit, event)
    local plr = Lurker:GetRandomPlayer(0)
    if (plr ~= nil) then
    Lurker:FullCastSpellOnTarget(37478, plr)
    else
    end
end

function Whirl(Unit, event) --I fixed this as it was causing multiple whirls at nearly the same time.
    local tank = Lurker:GetMainTank()
    if (tank~= nil) then
    Lurker:CastSpellOnTarget(37363, tank)
    else
    end
end

function WaterboltCheck(Unit, event)
    tank = Lurker:GetMainTank()
    if (tank~= nil) then
    Lurker:RegisterEvent("MtInRangeCheck", 200, 1)
    else
    end
end
    
function MtInRangeCheck(Unit, event) --We are not checking if the main tank is in range but anybody inrange.
    local x = Lurker:GetX()
    local y = Lurker:GetY()
    local xpos = tank:GetX()
    local ypos = tank:GetY()
    if xpos > x + 30 and ypos > y - 50 then
    Lurker:RegisterEvent("Waterbolt", 100, 1)
    elseif
    xpos <= x + 30 and ypos <= y - 50 then
    Lurker:RemoveEvents()
    Lurker:RegisterEvent("Geyser", 15000, 0)
    Lurker:RegisterEvent("WaterboltCheck", 5000, 0)
    Lurker:RegisterEvent("SpoutStart", 45000, 0)
    Lurker:RegisterEvent("Phase2", 120000, 0)
    Lurker:RegisterEvent("Whirl", 30000, 1)
    Lurker:RegisterEvent("DidthatCheck", 5000, 0)
    end
end

function Waterbolt (Unit, event)
    local plr = Lurker:GetRandomPlayer(0)
    if (plr ~= nil) then
    Lurker:StopMovement(99999999) --???? Why would we want to stop the movement forever? Does this count as an event?
    Lurker:FullCastSpellOnTarget(37138 ,plr)
    else
    end
    Lurker:RegisterEvent("WaterboltCheck", 2000, 1)
end

function Phase2(Unit, event)
    Lurker:RemoveEvents()
    Lurker:SetCombatCapable(1)
    Lurker:SetNPCFlags(4)
    Lurker:Emote(374)
    Lurker:RegisterEvent("Submerge", 3000, 1)
    Lurker:RegisterEvent("Addspawn", 5000, 1)
    end
    
function Submerge(Unit, event)
    local x = Lurker:GetX()
    local y = Lurker:GetY()
    local z = Lurker:GetZ()
    local o = Lurker:GetO()
    Lurker:MoveTo(x, y, z - 50, o)
    Lurker:RegisterEvent("ReEmerge", 60000, 1)
    end
    
function ReEmerge(Unit, event)
    Lurker:RemoveEvents()
    local x = Lurker:GetX()
    local y = Lurker:GetY()
    local z = Lurker:GetZ()
    local o = Lurker:GetO()
    Lurker:MoveTo(x, y, z + 50, o)
    Lurker:RegisterEvent("Resume", 5000, 1)
end

function Resume(Unit, event)
    Lurker:RemoveEvents()
    Lurker:SetCombatMeleeCapable(1)
    Lurker:GetMainTank()
    Lurker:RegisterEvent("Geyser", 12000, 0)
    Lurker:RegisterEvent("Whirl", 32000, 0)
    Lurker:RegisterEvent("WaterboltCheck", 5000, 0)
    Lurker:RegisterEvent("dummyspawn", 45000, 0)
    Lurker:RegisterEvent("Phase2", 120000, 0)
    end
    
function Addspawn(Unit, event)
Lurker:SpawnCreature(21865, 58.503925, -470.745422, -19.793449, 2.003222, 1620, 0)
Lurker:SpawnCreature(21865, 65.434769, -462.348175, -19.793442, 2.036211, 1620, 0)
Lurker:SpawnCreature(21865, 14.190825, -465.010651, -19.793459, 1.046609, 1620, 0)
Lurker:SpawnCreature(21865, 5.582020, -459.623169, -19.793459, 0.863040, 1620, 0)
Lurker:SpawnCreature(21865, 68.046989, -371.959717, -19.812212, 3.936874, 1620, 0)
Lurker:SpawnCreature(21865, 78.378624, -376.773041, -19.763062, 4.109663, 1620, 0)
Lurker:SpawnCreature(21873, 52.806099, -403.037048, -18.976122, 3.775870, 1620, 0)
Lurker:SpawnCreature(21873, 53.753056, -435.293640, -18.579000, 2.291469, 1620, 0)
Lurker:SpawnCreature(21873, 21.132940, -436.494507, -19.311489, 0.958648, 1620, 0)
end

function Ambusher(Unit, event)
    Ambusher = Unit
    local RandomPlayer = Ambusher:GetRandomPlayer(0)
    if (RandomPlayer ~= nil) then
    Ambusher:RegisterEvent("MultiShot", 1000, 1)
    else
    end
    end
function MultiShot(Unit)
    if math.random() < 0.3 then
    Ambusher:FullCastSpellOnTarget(30990, Ambusher:GetRandomPlayer(2))
    Ambusher:RegisterEvent("MultiShot", 5000, 1)
    end
end

function Guardian(Unit, event)
    Guardian = Unit
    Guardian:RegisterEvent("ArcinSmash", 5000, 0)
    Guardian:RegisterEvent("Hamstring", 7000, 0)
    end

function ArcinSmash(Unit, event)
    if math.random() < 0.3 then
    Guardian:FullCastSpellOnTarget(39144, Guardian:GetMainTank())
    end
    end
function Hamstring(Unit, event)
    if math.random() < 0.3 then
    Guardian:FullCastSpellOnTarget(29667, Guardian:GetMainTank())
    end
    end

RegisterUnitEvent(21865, 1, "Ambusher")
RegisterUnitEvent(21873, 1, "Guardian")
RegisterUnitEvent(21217, 1, "OnCombat")
RegisterUnitEvent(21217, 2, "OnLeaveCombat")
RegisterUnitEvent(21217, 3, "OnKilledTarget")
RegisterUnitEvent(21217, 4, "OnDied")