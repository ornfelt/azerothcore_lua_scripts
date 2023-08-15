--
-- Sunblade Protector
--

function SUNBLADE_PROTECTOR_LIGHTING(Unit, event, miscunit, misc)
   Unit:FullCastSpellOnTarget(46480, Unit:GetRandomPlayer(0))
end


function SUNBLADE_PROTECTOR_OnCombat(Unit,event)
    Unit:RegisterEvent("SUNBLADE_PROTECTOR_LIGHTING",10000,0)

end

function SUNBLADE_PROTECTOR_OnLeaveCombat(Unit,Event)
    Unit:RemoveEvents()
end

function SUNBLADE_PROTECTOR_OnKilledTarget(Unit,Event)

end

function SUNBLADE_PROTECTOR_OnDied(Unit,Event)
    Unit:RemoveEvents()
   
end

--
-- Sunblade Cabalist
--

function SUNBLADE_CABALIST_IGNITE_MANA(Unit, event, miscunit, misc)
   Unit:FullCastSpellOnTarget(46543, Unit:GetRandomPlayer(4))
end

function SUNBLADE_CABALIST_SUMMON_IMP(Unit, event, miscunit, misc)
   Unit:FullCastSpellOnTarget(46544, Unit:GetRandomPlayer(0))
end

function SUNBLADE_CABALIST_SHADOWBOLT(Unit, event, miscunit, misc)
   Unit:CastSpellOnTarget(47248, Unit:GetRandomPlayer(0))
end

function SUNBLADE_CABALIST_OnCombat(Unit,event)
    Unit:RegisterEvent("SUNBLADE_CABALIST_IGNITE_MANA",10000,0)
    Unit:RegisterEvent("SUNBLADE_CABALIST_SUMMON_IMP",10000,0)
    Unit:RegisterEvent("SUNBLADE_CABALIST_SHADOWBOLT",5000,0)

end

function SUNBLADE_CABALIST_OnLeaveCombat(Unit,Event)
    Unit:RemoveEvents()
end

function SUNBLADE_CABALIST_OnKilledTarget(Unit,Event)

end

function SUNBLADE_CABALIST_OnDied(Unit,Event)
    Unit:RemoveEvents()
   
end

--
-- Sunblade Arch Mage
--

function SUNBLADE_ARCHMAGE_ARCANE_EXPLOSION(Unit, event, miscunit, misc)
   Unit:FullCastSpellOnTarget(46553, Unit:GetRandomPlayer(0))
end

function SUNBLADE_ARCHMAGE_FROSTNOVA(Unit, event, miscunit, misc)
   Unit:FullCastSpellOnTarget(46555, Unit:GetClosestPlayer())
end

function SUNBLADE_ARCHMAGE_BLINK(Unit, event, miscunit, misc)
   Unit:FullCastSpellOnTarget(46573, Unit:GetRandomPlayer(0))
end

function SUNBLADE_ARCHMAGE_OnCombat(Unit,event)
    Unit:RegisterEvent("SUNBLADE_ARCHMAGE_ARCANE_EXPLOSION",5000,0)
    Unit:RegisterEvent("SUNBLADE_ARCHMAGE_FROSTNOVA",10000,0)
    Unit:RegisterEvent("SUNBLADE_ARCHMAGE_BLINK",20000,0)

end

function SUNBLADE_ARCHMAGE_OnLeaveCombat(Unit,Event)
    Unit:RemoveEvents()
end

function SUNBLADE_ARCHMAGE_OnKilledTarget(Unit,Event)

end

function SUNBLADE_ARCHMAGE_OnDied(Unit,Event)
    Unit:RemoveEvents()
   
end


--
-- Sunblade Dawn Priest
--


function SUNBLADE_DAWNPRIEST_RENEW(Unit, event, miscunit, misc)
   Unit:FullCastSpellOnTarget(46563, Unit:GetRandomFriend(0))
end

function SUNBLADE_DAWNPRIEST_HOLYNOVA(Unit, event, miscunit, misc)
   Unit:FullCastSpellOnTarget(46564, Unit:GetRandomPlayer(1))
end

function SUNBLADE_DAWNPRIEST_HOLYFORM(Unit, event, miscunit, misc)
   Unit:FullCastSpellOnTarget(46565, Unit:GetRandomPlayer(0))
end

function SUNBLADE_DAWNPRIEST_OnCombat(Unit,event)
    Unit:RegisterEvent("SUNBLADE_DAWNPRIEST_RENEW",10000,0)
    Unit:RegisterEvent("SUNBLADE_DAWNPRIEST_HOLYNOVA",10000,0)
    Unit:RegisterEvent("SUNBLADE_DAWNPRIEST_HOLYFORM",20000,0)

end

function SUNBLADE_DAWNPRIEST_OnLeaveCombat(Unit,Event)
    Unit:RemoveEvents()
end

function SUNBLADE_DAWNPRIEST_OnKilledTarget(Unit,Event)

end

function SUNBLADE_DAWNPRIEST_OnDied(Unit,Event)
    Unit:RemoveEvents()
   
end

--
-- Sunblade Dragonhawk
--

function SUNBLADE_DRAGONHAWK_FLAMEBREATH(Unit, event, miscunit, misc)
   Unit:FullCastSpellOnTarget(47251, Unit:GetRandomPlayer(1))
end


function SUNBLADE_DRAGONHAWK_OnCombat(Unit,event)
    Unit:RegisterEvent("SUNBLADE_DRAGONHAWK_FLAMEBREATH",8000,0)

end

function SUNBLADE_DRAGONHAWK_OnLeaveCombat(Unit,Event)
    Unit:RemoveEvents()
end

function SUNBLADE_DRAGONHAWK_OnKilledTarget(Unit,Event)

end

function SUNBLADE_DRAGONHAWK_OnDied(Unit,Event)
    Unit:RemoveEvents()
   
end

--
-- Sunblade Dusk Priest
--

function SUNBLADE_DUSK_PRIEST_SHADOWORD_PAIN(Unit, event, miscunit, misc)
   Unit:FullCastSpellOnTarget(46560, Unit:GetRandomPlayer(0))
end

function SUNBLADE_DUSK_PRIEST_FEAR(Unit, event, miscunit, misc)
   Unit:FullCastSpellOnTarget(46561, Unit:GetRandomPlayer(1))
end

function SUNBLADE_DUSK_PRIEST_MIND_FLAY(Unit, event, miscunit, misc)
   Unit:FullCastSpellOnTarget(47262, Unit:GetRandomPlayer(2))
end

function SUNBLADE_DUSK_PRIEST_OnCombat(Unit,event)
    Unit:RegisterEvent("SUNBLADE_DUSK_PRIEST_SHADOWORD_PAIN",15000,0)
    Unit:RegisterEvent("SUNBLADE_DUSK_PRIEST_FEAR",15000,0)
    Unit:RegisterEvent("SUNBLADE_DUSK_PRIEST_MIND_FLAY",10000,0)

end

function SUNBLADE_DUSK_PRIEST_OnLeaveCombat(Unit,Event)
    Unit:RemoveEvents()
end

function SUNBLADE_DUSK_PRIEST_OnKilledTarget(Unit,Event)

end

function SUNBLADE_DUSK_PRIEST_OnDied(Unit,Event)
    Unit:RemoveEvents()
   
end

--
-- Sunblade Scout
--

function SUNBLADE_SCOUT_SINISTER_STRIKE(Unit, event, miscunit, misc)
   Unit:FullCastSpellOnTarget(46558, Unit:GetRandomPlayer(1))
end


function SUNBLADE_SCOUT_OnCombat(Unit,event)
    Unit:RegisterEvent("SUNBLADE_SCOUT_SINISTER_STRIKE",5000,0)

end

function SUNBLADE_SCOUT_OnLeaveCombat(Unit,Event)
    Unit:RemoveEvents()
end

function SUNBLADE_SCOUT_OnKilledTarget(Unit,Event)

end

function SUNBLADE_SCOUT_OnDied(Unit,Event)
    Unit:RemoveEvents()
   
end

--
-- SUNBLADE SLAYER
--

function SUNBLADE_SLAYER_SLAYING_SHOT(Unit, event, miscunit, misc)
   Unit:FullCastSpellOnTarget(46557, Unit:GetRandomPlayer(2))
end

function SUNBLADE_SLAYER_SHOOT(Unit, event, miscunit, misc)
   Unit:FullCastSpellOnTarget(47001, Unit:GetRandomPlayer(2))
end


function SUNBLADE_SLAYER_OnCombat(Unit,event)
    Unit:RegisterEvent("SUNBLADE_SLAYER_SLAYING_SHOT",10000,0)
    Unit:RegisterEvent("SUNBLADE_SLAYER_SHOOT",10000,0)
end

function SUNBLADE_SLAYER_OnLeaveCombat(Unit,Event)
    Unit:RemoveEvents()
end

function SUNBLADE_SLAYER_OnKilledTarget(Unit,Event)

end

function SUNBLADE_SLAYER_OnDied(Unit,Event)
    Unit:RemoveEvents()
   
end

--
-- Sunblade Vindicator
--

function SUNBLADE_VINDICATOR_MORTAL_STRIKE(Unit, event, miscunit, misc)
   Unit:FullCastSpellOnTarget(39171, Unit:GetClosestPlayer())
end

function SUNBLADE_VINDICATOR_CLEAVE(Unit, event, miscunit, misc)
   Unit:FullCastSpellOnTarget(46559, Unit:GetClosestPlayer())
end


function SUNBLADE_VINDICATOR_OnCombat(Unit,event)
    Unit:RegisterEvent("SUNBLADE_VINDICATOR_MORTAL_STRIKE",10000,0)
    Unit:RegisterEvent("SUNBLADE_VINDICATOR_CLEAVE",7000,0)
end

function SUNBLADE_VINDICATOR_OnLeaveCombat(Unit,Event)
    Unit:RemoveEvents()
end

function SUNBLADE_VINDICATOR_OnKilledTarget(Unit,Event)

end

function SUNBLADE_VINDICATOR_OnDied(Unit,Event)
    Unit:RemoveEvents()
   
end


--
-- Shadowsword Soulbinder
--


function SHADOWSWORD_SOULBINDER_CURSE_OF_EXHAUSTION(Unit, event, miscunit, misc)
   Unit:FullCastSpellOnTarget(46434, Unit:GetRandomPlayer(7))
end

function SHADOWSWORD_SOULBINDER_FLASH_OF_DARKNESS(Unit, event, miscunit, misc)
   Unit:FullCastSpellOnTarget(46442, Unit:GetClosestPlayer())
end


function SHADOWSWORD_SOULBINDER_OnCombat(Unit,event)
    Unit:RegisterEvent("SHADOWSWORD_SOULBINDER_CURSE_OF_EXHAUSTION",4000,0)
    Unit:RegisterEvent("SHADOWSWORD_SOULBINDER_FLASH_OF_DARKNESS",10000,0)
end

function SHADOWSWORD_SOULBINDER_OnLeaveCombat(Unit,Event)
    Unit:RemoveEvents()
end

function SHADOWSWORD_SOULBINDER_OnKilledTarget(Unit,Event)

end

function SHADOWSWORD_SOULBINDER_OnDied(Unit,Event)
    Unit:RemoveEvents()
   
end

--
-- Shadowsword Assassin
--


function SHADOWSWORD_ASSASSIN_ASSASSINS_MARK(Unit, event, miscunit, misc)
   Unit:CastSpellOnTarget(46459, Unit:GetRandomPlayer(0))
end

function SHADOWSWORD_ASSASSIN_SHADOWSTEP(Unit, event, miscunit, misc)
   Unit:CastSpellOnTarget(46463, Unit:GetRandomPlayer(0))
end


function SHADOWSWORD_ASSASSIN_OnCombat(Unit,event)
    Unit:RegisterEvent("SHADOWSWORD_ASSASSIN_ASSASSINS_MARK",4000,0)
    Unit:RegisterEvent("SHADOWSWORD_ASSASSIN_SHADOWSTEP",10000,0)
end

function SHADOWSWORD_ASSASSIN_OnLeaveCombat(Unit,Event)
    Unit:RemoveEvents()
end

function SHADOWSWORD_ASSASSIN_OnKilledTarget(Unit,Event)

end

function SHADOWSWORD_ASSASSIN_OnDied(Unit,Event)
    Unit:RemoveEvents()
   
end

--
-- Shadowsword Lifeshaper
--
function SHADOWSWORD_LIFESHAPER_DRAIN_LIFE(Unit, event, miscunit, misc)
   Unit:CastSpellOnTarget(46466, Unit:GetRandomPlayer(7))
end

function SHADOWSWORD_LIFESHAPER_HEALTH_FUNNEL(Unit, event, miscunit, misc)
   Unit:FullCastSpellOnTarget(46467, Unit:GetRandomFriend())
end


function SHADOWSWORD_LIFESHAPER_OnCombat(Unit,event)
    Unit:RegisterEvent("SHADOWSWORD_LIFESHAPER_DRAIN_LIFE",10000,0)
    Unit:RegisterEvent("SHADOWSWORD_LIFESHAPER_HEALTH_FUNNEL",8000,0)
end

function SHADOWSWORD_LIFESHAPER_OnLeaveCombat(Unit,Event)
    Unit:RemoveEvents()
end

function SHADOWSWORD_LIFESHAPER_OnKilledTarget(Unit,Event)

end

function SHADOWSWORD_LIFESHAPER_OnDied(Unit,Event)
    Unit:RemoveEvents()
   
end

--
-- Shadowsword Vanquisher
--


function SHADOWSWORD_VANQUISHER_CLEAVE(Unit, event, miscunit, misc)
   Unit:CastSpellOnTarget(46468, Unit:GetclosestPlayer())
end

function SHADOWSWORD_VANQUISHER_MELT_ARMOR(Unit, event, miscunit, misc)
   Unit:FullCastSpellOnTarget(46469, Unit:GetMainTank())
end


function SHADOWSWORD_VANQUISHER_OnCombat(Unit,event)
    Unit:RegisterEvent("SHADOWSWORD_VANQUISHER_CLEAVE",10000,0)
    Unit:RegisterEvent("SHADOWSWORD_VANQUISHER_MELT_ARMOR",20000,0)
end

function SHADOWSWORD_VANQUISHER_OnLeaveCombat(Unit,Event)
    Unit:RemoveEvents()
end

function SHADOWSWORD_VANQUISHER_OnKilledTarget(Unit,Event)

end

function SHADOWSWORD_VANQUISHER_OnDied(Unit,Event)
    Unit:RemoveEvents()
   
end
--
-- Shadowsword Manafiend
--

function SHADOWSWORD_MANA_FIEND_DRAIN_MANA(Unit, event, miscunit, misc)
   Unit:FullCastSpellOnTarget(46453, Unit:GetRandomPlayer(4))
end

function SHADOWSWORD_MANA_FIEND_ARCANE_EXPLOSION(Unit, event, miscunit, misc)
   Unit:CastSpellOnTarget(46457, Unit:GetClosestPlayer())
end


function SHADOWSWORD_MANA_FIEND_OnCombat(Unit,event)
    Unit:RegisterEvent("SHADOWSWORD_MANA_FIEND_DRAIN_MANA",10000,0)
    Unit:RegisterEvent("SHADOWSWORD_MANA_FIEND_ARCANE_EXPLOSION",8000,0)
end

function SHADOWSWORD_MANA_FIEND_OnLeaveCombat(Unit,Event)
    Unit:RemoveEvents()
end

function SHADOWSWORD_MANA_FIEND_OnKilledTarget(Unit,Event)

end

function SHADOWSWORD_MANA_FIEND_OnDied(Unit,Event)
    Unit:RemoveEvents()
   
end


--
-- register here this new shit
--
RegisterUnitEvent(25483,1,"SHADOWSWORD_MANA_FIEND_OnCombat")
RegisterUnitEvent(25483,2,"SHADOWSWORD_MANA_FIEND_OnLeaveCombat")
RegisterUnitEvent(25483,3,"SHADOWSWORD_MANA_FIEND_OnKilledTarget")
RegisterUnitEvent(25483,4,"SHADOWSWORD_MANA_FIEND_OnDied")

RegisterUnitEvent(25486,1,"SHADOWSWORD_VANQUISHER_OnCombat")
RegisterUnitEvent(25486,2,"SHADOWSWORD_VANQUISHER_OnLeaveCombat")
RegisterUnitEvent(25486,3,"SHADOWSWORD_VANQUISHER_OnKilledTarget")
RegisterUnitEvent(25486,4,"SHADOWSWORD_VANQUISHER_OnDied")

RegisterUnitEvent(25506,1,"SHADOWSWORD_LIFESHAPER_OnCombat")
RegisterUnitEvent(25506,2,"SHADOWSWORD_LIFESHAPER_OnLeaveCombat")
RegisterUnitEvent(25506,3,"SHADOWSWORD_LIFESHAPER_OnKilledTarget")
RegisterUnitEvent(25506,4,"SHADOWSWORD_LIFESHAPER_OnDied")

RegisterUnitEvent(25484,1,"SHADOWSWORD_ASSASSIN_OnCombat")
RegisterUnitEvent(25484,2,"SHADOWSWORD_ASSASSIN_OnLeaveCombat")
RegisterUnitEvent(25484,3,"SHADOWSWORD_ASSASSIN_OnKilledTarget")
RegisterUnitEvent(25484,4,"SHADOWSWORD_ASSASSIN_OnDied")

RegisterUnitEvent(25373,1,"SHADOWSWORD_SOULBINDER_OnCombat")
RegisterUnitEvent(25373,2,"SHADOWSWORD_SOULBINDER_OnLeaveCombat")
RegisterUnitEvent(25373,3,"SHADOWSWORD_SOULBINDER_OnKilledTarget")
RegisterUnitEvent(25373,4,"SHADOWSWORD_SOULBINDER_OnDied")

RegisterUnitEvent(25369,1,"SUNBLADE_VINDICATOR_OnCombat")
RegisterUnitEvent(25369,2,"SUNBLADE_VINDICATOR_OnLeaveCombat")
RegisterUnitEvent(25369,3,"SUNBLADE_VINDICATOR_OnKilledTarget")
RegisterUnitEvent(25369,4,"SUNBLADE_VINDICATOR_OnDied")

RegisterUnitEvent(25368,1,"SUNBLADE_SLAYER_OnCombat")
RegisterUnitEvent(25368,2,"SUNBLADE_SLAYER_OnLeaveCombat")
RegisterUnitEvent(25368,3,"SUNBLADE_SLAYER_OnKilledTarget")
RegisterUnitEvent(25368,4,"SUNBLADE_SLAYER_OnDied")

RegisterUnitEvent(25372,1,"SUNBLADE_SCOUT_OnCombat")
RegisterUnitEvent(25372,2,"SUNBLADE_SCOUT_OnLeaveCombat")
RegisterUnitEvent(25372,3,"SUNBLADE_SCOUT_OnKilledTarget")
RegisterUnitEvent(25372,4,"SUNBLADE_SCOUT_OnDied")

RegisterUnitEvent(25370,1,"SUNBLADE_DUSK_PRIEST_OnCombat")
RegisterUnitEvent(25370,2,"SUNBLADE_DUSK_PRIEST_OnLeaveCombat")
RegisterUnitEvent(25370,3,"SUNBLADE_DUSK_PRIEST_OnKilledTarget")
RegisterUnitEvent(25370,4,"SUNBLADE_DUSK_PRIEST_OnDied")

RegisterUnitEvent(25867,1,"SUNBLADE_DRAGONHAWK_OnCombat")
RegisterUnitEvent(25867,2,"SUNBLADE_DRAGONHAWK_OnLeaveCombat")
RegisterUnitEvent(25867,3,"SUNBLADE_DRAGONHAWK_OnKilledTarget")
RegisterUnitEvent(25867,4,"SUNBLADE_DRAGONHAWK_OnDied")

RegisterUnitEvent(25371,1,"SUNBLADE_DAWNPRIEST_OnCombat")
RegisterUnitEvent(25371,2,"SUNBLADE_DAWNPRIEST_OnLeaveCombat")
RegisterUnitEvent(25371,3,"SUNBLADE_DAWNPRIEST_OnKilledTarget")
RegisterUnitEvent(25371,4,"SUNBLADE_DAWNPRIEST_OnDied")

RegisterUnitEvent(25363,1,"SUNBLADE_CABALIST_OnCombat")
RegisterUnitEvent(25363,2,"SUNBLADE_CABALIST_OnLeaveCombat")
RegisterUnitEvent(25363,3,"SUNBLADE_CABALIST_OnKilledTarget")
RegisterUnitEvent(25363,4,"SUNBLADE_CABALIST_OnDied")

RegisterUnitEvent(25367,1,"SUNBLADE_ARCHMAGE_OnCombat")
RegisterUnitEvent(25367,2,"SUNBLADE_ARCHMAGE_OnLeaveCombat")
RegisterUnitEvent(25367,3,"SUNBLADE_ARCHMAGE_OnKilledTarget")
RegisterUnitEvent(25367,4,"SUNBLADE_ARCHMAGE_OnDied")

RegisterUnitEvent(25507,1,"SUNBLADE_PROTECTOR_OnCombat")
RegisterUnitEvent(25507,2,"SUNBLADE_PROTECTOR_OnLeaveCombat")
RegisterUnitEvent(25507,3,"SUNBLADE_PROTECTOR_OnKilledTarget")
RegisterUnitEvent(25507,4,"SUNBLADE_PROTECTOR_OnDied")


--
-- now we do bigger things :D here comes the first Boss Kalecgos
--


function BOSS_KALECGOS_FROST_BREATH(Unit, event, miscunit, misc)
   Unit:CastSpellOnTarget(44799, Unit:GetClosestPlayer())
end

function BOSS_KALECGOS_ARCANE_BUFFET(Unit, event, miscunit, misc)
   Unit:CastSpellOnTarget(45018, Unit:GetRandomPlayer(0))
end

function BOSS_KALECGOS_TAIL_LASH(Unit, event, miscunit, misc)
   Unit:FullCastSpellOnTarget(45122, Unit:GetClosestPlayer())
end

function BOSS_KALECGOS_OnCombat(Unit,event)
    Unit:RegisterEvent("BOSS_KALECGOS_FROST_BREATH",5000,0)
    Unit:RegisterEvent("BOSS_KALECGOS_ARCANE_BUFFET",10000,0)
    Unit:RegisterEvent("BOSS_KALECGOS_TAIL_LASH",5000,0)
end

function BOSS_KALECGOS_OnLeaveCombat(Unit,Event)
    Unit:RemoveEvents()
end

function BOSS_KALECGOS_OnKilledTarget(Unit,Event)

end

function BOSS_KALECGOS_OnDied(Unit,Event)
    Unit:RemoveEvents()
   
end

RegisterUnitEvent(24850,1,"BOSS_KALECGOS_OnCombat")
RegisterUnitEvent(24850,2,"BOSS_KALECGOS_OnLeaveCombat")
RegisterUnitEvent(24850,3,"BOSS_KALECGOS_OnKilledTarget")
RegisterUnitEvent(24850,4,"BOSS_KALECGOS_OnDied")




--
-- aaaand the next one Brutalus
--
function Enrage(pUnit, Event)
pUnit:CastSpell(26662)
end

function Stomp(pUnit, Event)
stomptarget=pUnit:GetMainTank();
pUnit:FullCastSpellOnTarget(45185, stomptarget)
stomptarget:RemoveAura(46394)
end

function Burn(pUnit, Event)
pUnit:CastSpellOnTarget(46394, pUnit:GetRandomPlayer(0))   
end

function Meteor_Slash(pUnit, Event)
pUnit:FullCastSpell(45150)
end

function Combat_Talk(pUnit, Event)
Choice=math.random(1, 3)
if Choice==1 then
pUnit:SendChatMessage(12, 0, "Bring the fight to me!")
end   
if Choice==2 then
pUnit:SendChatMessage(12, 0, "Another day, another glorious battle!")
end
if Choice==3 then
pUnit:SendChatMessage(12, 0, "I live for this!")
end   
end

function Brut_OnCombat(pUnit, Event)
pUnit:SendChatMessage(12, 0, "Ahh! More lambs to the slaughter!")
pUnit:RegisterEvent("Combat_Talk", 30000, 0)
pUnit:RegisterEvent("Meteor_Slash", 60000, 0)
pUnit:RegisterEvent("Burn", 70000, 0)
pUnit:RegisterEvent("Stomp", 45000, 0)
pUnit:RegisterEvent("Enrage", 360000, 1)
end

function Brut_OnLeaveCombat(pUnit, Event)
pUnit:RemoveEvents()   
end

function Brut_OnKilledTarget (pUnit, Event)
Choice=math.random(1, 3)
if Choice==1 then
pUnit:SendChatMessage(12, 0, "Perish, insect!")   
elseif Choice==2 then
pUnit:SendChatMessage(12, 0, "You are meat!")
elseif Choice==3 then
pUnit:SendChatMessage(12, 0, "Too easy!")   
end
end

function Brut_OnDied(pUnit, Event)
pUnit:SendChatMessage(12, 0, "Gah! Well done... Now... this gets... interesting... ")
pUnit:RemoveEvents()   
end

RegisterUnitEvent(24882, 1, "Brut_OnCombat")
RegisterUnitEvent(24882, 2, "Brut_OnLeaveCombat")
RegisterUnitEvent(24882, 3, "Brut_OnKilledTarget")
RegisterUnitEvent(24882, 4, "Brut_OnDied")