--< Made by Utsjitimmie and Underseas from projectsilvermoon.net >--
--< Ask us if you want to use (a part of) this script in your repack >--
--< You may ofcourse use it for your server without asking >--

--< Have fun!
--< ~Utsjitimmie
--< ~Underseas

--Defining Variables
incombat24 = 0
incombat25 = 0
incombat26 = 0
incombat27 = 0
incombat28 = 0
incombat30 = 0
incombat31 = 0
incombat32 = 0
incombat33 = 0
--------------------------

-----------------------------------------------------------------Mobs--------------------------------------------------------------------------------
function dark_mending(unit)
local plr = unit:GetClosestPlayer()
if (plr ~= nil) then
plr:SetHealthPct(100)
end
end

--Angry Night Elf Spectator
function snowball_throw(unit)
if (incombat24==1) then
local plr = unit:GetClosestPlayer()
if (plr ~= nil) then
unit:FullCastSpellOnTarget(25686, plr);
end	
end
end

function snowball_spam(unit, event, miscunit, misc)
	unit:RegisterEvent("snowball_throw",4000,0) --Throw a snowball every 4 seconds
	unit:RegisterEvent("dark_mending",2000,0) --Cast Dark Mending Every 2 seconds
	incombat24=1
end
RegisterUnitEvent(10002524, 1, "snowball_spam")

function steatlhy(unit)
	unit:RemoveEvents()
	unit:CastSpell(1787)
	incombat24=0
end
RegisterUnitEvent(10002524, 18, "steatlhy")
RegisterUnitEvent(10002524, 2, "steatlhy")

--Angry Orc Onlooker
function frost_slow(unit)
if (incombat25==1) then
local plr = unit:GetMainTank() 
if (plr ~= nil) then
unit:FullCastSpellOnTarget(35965, plr);
end	
end
end

function frost_spam(unit, event, miscunit, misc)
	unit:RegisterEvent("frost_slow",3000,0) --Cast Frost Arrow every 3 seconds
	unit:RegisterEvent("dark_mending",2000,0) --Cast Dark Mending Every 2 seconds
	incombat25=1
end
RegisterUnitEvent(10002525, 1, "frost_spam")

function steatlthy(unit)
	unit:RemoveEvents()
	unit:CastSpell(1787)
	incombat25=0
end
RegisterUnitEvent(10002525, 18, "steatlthy")
RegisterUnitEvent(10002525, 2, "steatlthy")

--Angry Undead Spectator
function stun_target(unit)
if (incombat26==1) then
local plr = unit:GetClosestPlayer()
if (plr ~= nil) then
unit:FullCastSpellOnTarget(20170, plr);
end	
end
end

function stun_spam(unit, event, miscunit, misc)
	unit:RegisterEvent("stun_target",4000,0) --Cast Stun every 4 seconds
	unit:RegisterEvent("dark_mending",2000,0) --Cast Dark Mending Every 2 seconds
	incombat26=1
end
RegisterUnitEvent(10002526, 1, "stun_spam")

function steatlthy1(unit)
	unit:RemoveEvents()
	unit:CastSpell(1787)
	incombat26=0
end
RegisterUnitEvent(10002526, 18, "steatlthy1")
RegisterUnitEvent(10002526, 2, "steatlthy1")

--Angry Gnome Onlooker
function fire_slow(unit)
if (incombat27==1) then
local plr = unit:GetClosestPlayer()
if (plr ~= nil) then
unit:CastSpell(31661);
end	
end
end

function fire_spam(unit, event, miscunit, misc)
	unit:RegisterEvent("fire_slow",5500,0) --Cast dragon's breath every 5.5 seconds
	unit:RegisterEvent("dark_mending",2000,0) --Cast Dark Mending Every 2 seconds
	incombat27=1
end
RegisterUnitEvent(10002527, 1, "fire_spam")

function steatlthy2(unit)
	unit:RemoveEvents()
	unit:CastSpell(1787)
	incombat27=0
end
RegisterUnitEvent(10002527, 18, "steatlthy2")
RegisterUnitEvent(10002527, 2, "steatlthy2")

--Angry Human Spectator
function blazing_sp(unit)
if (incombat28==1) then
local plr = unit:GetClosestPlayer()
if (plr ~= nil) then
unit:CastSpell(36148);
end	
end
end

function blazing_spam(unit, event, miscunit, misc)
	unit:RegisterEvent("blazing_sp",4000,0) --Cast chill nova every 4 seconds
	unit:RegisterEvent("dark_mending",2000,0) --Cast Dark Mending Every 2 seconds
	incombat28=1
end
RegisterUnitEvent(10002528, 1, "blazing_spam")

function steatlthy3(unit)
	unit:RemoveEvents()
	unit:CastSpell(1787)
	incombat28=0
end
RegisterUnitEvent(10002528, 18, "steatlthy3")
RegisterUnitEvent(10002528, 2, "steatlthy3")

--Angry Tauren Onlooker: 10002530
function entangle(unit)
if (incombat30==1) then
local plr = unit:GetMainTank() 
if (plr ~= nil) then
unit:FullCastSpellOnTarget(26989, plr);
unit:StopMovement(2000)
end	
end
end

function entangle_spam(unit, event, miscunit, misc)
	unit:RegisterEvent("entangle",2000,2)
	incombat30=1
end
RegisterUnitEvent(10002530, 1, "entangle_spam") --Cast Entangling Roots 2 times when entering combat

function steatlthy4(unit)
	unit:RemoveEvents()
	unit:CastSpell(1787)
	incombat30=0
end
RegisterUnitEvent(10002530, 18, "steatlthy4")
RegisterUnitEvent(10002530, 2, "steatlthy4")

--Angry Troll Spectator: 10002531
function polymorph(unit)
if (incombat31==1) then
local plr = unit:GetMainTank() 
if (plr ~= nil) then
unit:FullCastSpellOnTarget(12826, plr);
unit:StopMovement(2000)
end
end	
end

function polymorph_spam(unit, event, miscunit, misc)
	unit:RegisterEvent("polymorph",2000,2)
	incombat31=1
end
RegisterUnitEvent(10002531, 1, "polymorph_spam") --Cast polymorph 2 times when entering combat

function steatlthy5(unit)
	unit:RemoveEvents()
	unit:CastSpell(1787)
	incombat31=0
end
RegisterUnitEvent(10002531, 18, "steatlthy5")
RegisterUnitEvent(10002531, 2, "steatlthy5")

--Angry Draenei Spectator: 10002532
function fnova(unit)
if (incombat32==1) then
local plr = unit:GetClosestPlayer()
if (plr ~= nil) then
unit:CastSpell(27088);
end	
end
end

function fnova_spam(unit, event, miscunit, misc)
	unit:RegisterEvent("fnova",4000,0) --Cast frost nova every 4 seconds
	unit:RegisterEvent("dark_mending",2000,0) --Cast Dark Mending Every 2 seconds
	incombat32=1
end
RegisterUnitEvent(10002532, 1, "fnova_spam")

function steatlthy6(unit)
	unit:RemoveEvents()
	unit:CastSpell(1787)
	incombat32=0
end
RegisterUnitEvent(10002532, 18, "steatlthy6")
RegisterUnitEvent(10002532, 2, "steatlthy6")

--Angry Blood Elf Onlooker: 10002533
function concussiveshot(unit)
if (incombat33==1) then
local plr = unit:GetMainTank() 
if (plr ~= nil) then
unit:FullCastSpellOnTarget(5116, plr);
end	
end
end

function concussiveshot_spam(unit, event, miscunit, misc)
	unit:RegisterEvent("concussiveshot",3000,0) --Cast concussive shot every 3 seconds
	unit:RegisterEvent("dark_mending",2000,0) --Cast Dark Mending Every 2 seconds
	incombat33=1
end
RegisterUnitEvent(10002533, 1, "concussiveshot_spam")

function steatlthy7(unit)
	unit:RemoveEvents()
	unit:CastSpell(1787)
	incombat33=0
end
RegisterUnitEvent(10002533, 18, "steatlthy7")
RegisterUnitEvent(10002533, 2, "steatlthy7")
