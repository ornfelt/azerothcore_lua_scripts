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


function salastone_OnCombat(Unit, event)
    Unit:PlaySoundToSet(12413)
    Unit:StopMovement(999999999)
    Unit:SetCombatCapable(1)
    Unit:RegisterEvent("StartFight", 35000, 0)
    Unit:CastSpell(1302)
    Unit:Emote(1, 1)
    Unit:CastSpell(30035)
    Unit:SendChatMessage(12,0,"Don't look so smug. I know what your thinking, but Tempest Keep was merely a setback. Did you honestly believe I would trust the future to some blind half night elf mongrel, hahahaha, oh no no no... He was merely an instrument, a stepping stone to a much larger plan. It has all led to this, and this time, you will not interfere.")
end
function StartFight(Unit)
Unit:RemoveEvents()
Unit:CastSpell(35923)
Unit:CastSpell(52138)
Unit:CastSpell(40425)
Unit:StopMovement(1000)
Unit:SetCombatCapable(0)
Unit:RegisterEvent("HARDPART", 1000, 0)
Unit:RegisterEvent("TanknSpank", 10000, 0)
end
function TanknSpank(Unit)
 if Unit:GetHealthPct() < 98 then
                Choice=math.random(1, 4)
                if Choice==1 then
                Unit:FullCastSpellOnTarget(20692, Unit:GetRandomPlayer(0))
                end 
                if Choice==2 then
                Unit:FullCastSpellOnTarget(32364, Unit:GetRandomPlayer(0))
                end
                if Choice==3 then
                Unit:FullCastSpellOnTarget(11, Unit:GetRandomPlayer(0))
                end
                if Choice==4 then
                Unit:FullCastSpellOnTarget(29879, Unit:GetRandomPlayer(0))
                end
end
end
function HARDPART(Unit)
 if Unit:GetHealthPct() < 60 then
                Unit:RemoveEvents()
                Unit:PlaySoundToSet(12418)
                Unit:SendChatMessage(12,0,"I'll turn your world; upside down...")
                Unit:StopMovement(999999999)
                Unit:SetCombatCapable(1)
                Unit:RegisterEvent("VisualIntro", 1000, 0)
                Unit:RegisterEvent("VisualSecond", 3505, 0)
         x = Unit:GetX();
         y = Unit:GetY();
         z = Unit:GetZ();
         o = Unit:GetO();
                x = x + 2
                y = y + 2
                z = z + 1
  Unit:SpawnCreature(22997, x, y, z, o, 17, 45000);
                Unit:RegisterEvent("VisualEndBeginHard", 45000, 0)
 end
end
function VisualIntro(Unit)
Unit:CastSpell(43541)
end
function VisualSecond(Unit)
Unit:FullCastSpell(15586)
end
function VisualEndBeginHard(Unit)
Unit:RemoveEvents()
Unit:PlaySoundToSet(12420)
Unit:SendChatMessage(12,0,"Do not, get to comfortable...")
Unit:StopMovement(2500)
Unit:SetCombatCapable(0)
Unit:CastSpell(29963)
Unit:CastSpell(39102)
Unit:SetScale(1)
Unit:CastSpell(34205)
Unit:RegisterEvent("BeginRandom", 11000, 0)
Unit:RegisterEvent("TanknSpanktwo", 7000, 0)
Unit:RegisterEvent("zzzSTOP", 30000, 0)
end
function BeginRandom(Unit)
 if Unit:GetHealthPct() < 45 then
                Choice=math.random(1, 5)
                if Choice==1 then
                Unit:FullCastSpellOnTarget(48072, Unit:GetRandomPlayer(0))
                end 
                if Choice==2 then
                Unit:FullCastSpellOnTarget(36148, Unit:GetRandomPlayer(0))
                end
                if Choice==3 then
                Unit:FullCastSpellOnTarget(45332, Unit:GetRandomPlayer(0))
                end
                if Choice==4 then
                Unit:FullCastSpellOnTarget(40104, Unit:GetRandomPlayer(0))
                end
                if Choice==5 then
                Unit:FullCastSpellOnTarget(38589, Unit:GetRandomPlayer(0))
                end
end
end
function TanknSpanktwo(Unit)
                Choice=math.random(1, 4)
                if Choice==1 then
                Unit:FullCastSpellOnTarget(20692, Unit:GetRandomPlayer(0))
                end 
                if Choice==2 then
                Unit:FullCastSpellOnTarget(32364, Unit:GetRandomPlayer(0))
                end
                if Choice==3 then
                Unit:FullCastSpellOnTarget(11, Unit:GetRanomPlayer(0))
                end
                if Choice==4 then
                Unit:FullCastSpellOnTarget(29879, Unit:GetRandomPlayer(0))
                end
end
function zzzSTOP(Unit)
Unit:CastSpell(40647) -- This freezes everyone for 30 seconds so remove if you want in a area with lots of other people
Unit:StopMovement(99999999)
Unit:SetCombatCapable(1)
Unit:RegisterEvent("zzzVisual", 2000, 0)
end
function zzzVisual(Unit)
Unit:RemoveEvents()
Unit:PlaySoundToSet(12417)
Unit:SendChatMessage(14,0,"Fela'mina sha!")
Unit:CastSpell(9079)
Unit:SetScale(2)
Unit:RegisterEvent("VisualIntroTwo", 1000, 0)
Unit:RegisterEvent("VisualSecondTwo", 3505, 0)
Unit:RegisterEvent("TalkTalk", 16000, 0)
Unit:RegisterEvent("zzzFINISH", 20000, 0)
end
function VisualIntroTwo(Unit)
Unit:CastSpell(43541)
Unit:CastSpell(34602)
Unit:CastSpell(40436)
end
function TalkTalk(Unit)
Unit:PlaySoundToSet(12415)
Unit:SendChatMessage(14,0,"Vengeance Burns!")
end
function VisualSecondTwo(Unit)
Unit:FullCastSpell(15586)
end
function zzzFINISH(Unit)
Unit:SetScale(1)
Unit:RemoveEvents()
Unit:StopMovement(1200000)
Unit:SetCombatCapable(1)
Unit:RegisterEvent("zzzBlastSpam", 1000, 0)
end
function zzzBlastSpam(Unit)
Unit:FullCastSpellOnTarget(38921, Unit:GetRandomPlayer(0))
end
function salastone_OnDied(Unit)
    Unit:RemoveEvents()    
    Unit:SendChatMessage(14,0,"My demise accomplishes nothing! The master will have you! You will drown in your own blood! The world shall burn! Gahhhhh!")
    Unit:PlaySoundToSet(12421)
end
function salastone_OnKilledTarget(Unit)
Choice=math.random(1, 2)
if Choice==1 then
Unit:CastSpell(10576)
end 
if Choice==2 then
Unit:CastSpell(12323)
end
end
function salastone_OnLeaveCombat(Unit)
    Unit:RemoveEvents()
end
RegisterUnitEvent(622115,1,"salastone_OnCombat")
RegisterUnitEvent(622115,2,"salastone_OnLeaveCombat")
RegisterUnitEvent(622115,3,"salastone_OnKilledTarget")
RegisterUnitEvent(622115,4,"salastone_OnDied")