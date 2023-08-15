--[[ rage_winterchill.lua
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
-- LUA++ staff, April 15, 2008. ]]
-- The following script is completely written by me. If anyone has a similar script, sorry, I promise, I didn't copy it :P
-- Frostbolt 41486 (not sure if correct, because of that I took it from Moon++)
-- Death and Decay 39658
-- Frost Nova 31250
-- Frost Armor 31256
-- Berserk 46587 (only for five minutes, but that should be enough)
function winterchill_start(Unit, Event)
   	Unit:SendChatMessage(14, 0, "The Legion's final conquest has begun! Once again the subjugation of this world is within our grasp. Let none survive!");
   	Unit:PlaySoundToSet(11022);
   	Unit:RegisterEvent("winterchill_dnd", 100, 0); -- Death and Decay
   	Unit:RegisterEvent("winterchill_fa", 100, 0); -- Frost Armor
   	Unit:RegisterEvent("winterchill_enrage", 600000, 0); -- Enrage after 10 Minutes
end

function winterchill_dnd(Unit, Event)
   	Unit:RemoveEvents();
    local speach = math.random(1, 2);
    if (speach == 1) then
       	Unit:SendChatMessage(14, 0, "Crumble and rot!");
       	Unit:PlaySoundToSet(11023);
    elseif (speach == 2) then
       	Unit:SendChatMessage(14, 0, "Ashes to ashes, dust to dust");
       	Unit:PlaySoundToSet(11055);
    end
    local oncast =	Unit:GetRandomPlayer(0);
    if (oncast ~= nil) then
    	Unit:FullCastSpellOnTarget(39658, oncast);
    end
    -- Next Cast:
    local randomtimer = math.random(30000, 60000); -- Timer, as I do not know how often Rage spams his skills, would be nice if anyone could provide me this info
    local nextcast = math.random(1, 2);
    if (nextcast == 1) then
       	Unit:RegisterEvent("winterchill_fb", randomtimer, 0); -- Frost Bolt
    elseif (nextcast == 2) then
       	Unit:RegisterEvent("winterchill_fn", randomtimer, 0); -- Frost Nova
    end
end

function winterchill_fb(Unit, Event)
   	Unit:RemoveEvents();
    local speach = math.random(1, 2);
    if (speach == 1) then
       	Unit:SendChatMessage(14, 0, "Succumb to the icy chill ... of death!");
        --	Unit:PlaySoundToSet(ID); Would be nice if someone has an ID list for me, I didn't find any
    elseif (speach == 2) then
       	Unit:SendChatMesasge(13, 0, "It will be much colder in your grave.");
        --	Unit:PlaySoundToSet(ID); Would be nice if someone has an ID list for me, I didn't find any
    end
    local oncast =	Unit:GetRandomPlayer(0);
    if (oncast ~= nil) then
    	Unit:CastSpellOnTarget(41486, oncast);
    end
    -- Next Cast:
    local randomtimer = math.random(30000, 60000); -- Timer, as I do not know how often Rage spams his skills, would be nice if anyone could provide me this info
    local nextcast = math.random(1, 2);
    if (nextcast == 1) then
       	Unit:RegisterEvent("winterchill_dnd", randomtimer, 0); -- Death and Decay
    elseif (nextcast == 2) then
       	Unit:RegisterEvent("winterchill_fn", randomtimer, 0); -- Frost Nova
    end
end

function winterchill_fn(Unit, Event)
   	Unit:RemoveEvents();
    local speach = math.random(1, 2);
    if (speach == 1) then
       	Unit:SendChatMessage(14, 0, "Succumb to the icy chill ... of death!");
        --	Unit:PlaySoundToSet(ID); Would be nice if someone has an ID list for me, I didn't find any
    elseif (speach == 2) then
       	Unit:SendChatMesasge(13, 0, "It will be much colder in your grave.");
        --	Unit:PlaySoundToSet(ID); Would be nice if someone has an ID list for me, I didn't find any
    end    
    local oncast =	Unit:GetRandomPlayer(0);
    if (oncast ~= nil) then
    	Unit:CastSpellOnTarget(31250, oncast);
    end
    -- Next Cast:
    local randomtimer = math.random(30000, 60000); -- Timer, as I do not know how often Rage spams his skills, would be nice if anyone could provide me this info
    local nextcast = math.random(1, 2);
    if (nextcast == 1) then
       	Unit:RegisterEvent("winterchill_dnd", randomtimer, 0); -- Death and Decay
    elseif (nextcast == 2) then
       	Unit:RegisterEvent("winterchill_fb", randomtimer, 0); -- Frost Bolt
    end    
end

function winterchill_fa(Unit, Event)
   	Unit:RemoveEvents();
   	Unit:CastSpellOnTarget(31256, Unit);
    local randomtimer = math.random(30000, 60000);
   	Unit:RegisterEvent("winterchill_fa", randomtimer, 0); -- Frost Armor
end
    
function winterchill_enrage(Unit, Event)
   	Unit:RemoveEvents();
   	Unit:CastSpellOnTarget(46587, Unit);
end
    

function winterchill_killplayer(Unit, Event)
   	Unit:RemoveEvents();
    local speach = math.random(1, 3);
    if (speach == 1) then
       	Unit:SendChatMessage(14, 0, "All life must perish!");
       	Unit:PlaySoundToSet(11025);
    elseif (speach == 2) then
       	Unit:SendChatMessage(14, 0, "Your world is ours now!");
       	Unit:PlaySoundToSet(11056);
    elseif (speach == 3) then
       	Unit:SendChatMessage(14, 0, "Victoy to the Legion!");
       	Unit:PlaySoundToSet(11057);
    end
end

function winterchill_death(Unit, Event)
   	Unit:SendChatMessage(14, 0, "You have won this battle, but not ... the ... war");
   	Unit:PlaySoundToSet(11026);
   	Unit:RemoveEvents();
end
    
RegisterUnitEvent(17767, 1, "winterchill_start");
RegisterUnitEvent(17767, 3, "winterchill_killplayer");
RegisterUnitEvent(17767, 4, "winterchill_death");
RegisterUnitEvent(17767, 5, "winterchill_dnd"); --What is AI_Tick?
RegisterUnitEvent(17767, 5, "winterchill_fb");
RegisterUnitEvent(17767, 5, "winterchill_fn");
RegisterUnitEvent(17767, 5, "winterchill_fa");
RegisterUnitEvent(17767, 5, "winterchill_enrage");