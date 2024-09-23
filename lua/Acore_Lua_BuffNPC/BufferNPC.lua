local NPCID = 400117
local ANNOUNCE_MODULE = true
local BUFF_BY_LEVEL = true
local BUFF_CURE_RES = true
local BUFF_NUM_PHRASES = 19
local BUFF_NUM_WHISPERS = 14
local BUFF_MESSAGE_TIMER = 40000
local BUFF_EMOTE_SPELL = 44940
local ENABLE_BUFF_EMOTE_SPELL = false -- shoots off a firework periodically to grab attention


local phrases = {
    "It's no fluff, you'll be tough, with these buffs!",    
    "Get empowered, not devoured, in this crucial hour!",    
    "Strength and might, for the fight, buffs that'll make you feel right!",    
    "You'll be spry, don't be shy, with these buffs you'll touch the sky!",    
    "Grab a buff, no need to bluff, you'll be rough and tough enough!",
	"In this fray, don't delay, buffs to brighten up your day, %s!",
    "Come get buffed, taste my stuff, the elven females can't get enuff!",
	"With these charms, flex your arms, no more worries, no more qualms!", 
    "Be the talk, take a walk, show your prowess, let them gawk!",
	"Power up, be the champ, with these buffs you'll break the camp!",
	"Buffs are here, have no fear, you'll be strong from ear to ear!",
    "Take your fill, prove your skill, let these buffs your courage instill!",
    "No more stress, you'll impress, with these buffs you're sure to progress!",
    "Feel the surge, let it merge, with these buffs you'll surely emerge!",
    "You're no pawn, time to dawn, buffs that make you strong like brawn!",
    "Rise above, like a dove, with these buffs that fit like a glove!",
    "Buff your way, seize the day, show the world your strength's at play!",
    "Be the bane, no more pain, with these buffs your power will gain!",
    "With great cheer, have no fear, buffs are here, your path is clear!"
}


local whispers = {
	"With this boost, cut them loose, show them all your inner moose, %s!",
	"You'll shine bright, like a light, let your power take its flight, %s!",  
	"A buff for you, strong and true, in your quest, they'll see you through, %s!",  
	"These buffs I share, for those who dare, to face the world without despair, %s!",
	"Go with grace, win the race, let these buffs keep up your pace, %s!",
	"Fare thee well, give 'em hell, let your victories ring like a bell, %s!",
	"Forge ahead, show your stead, with these buffs, you'll be well-fed, %s!",
    "Stride with pride, side by side, let these buffs be your guide, %s!",
    "Off you go, steal the show, these buffs will help your power grow, %s!",
    "Now's your chance, take a stance, with these buffs, you'll enhance, %s!",
    "Buffed and ready, keep it steady, face the world with blade unsteady, %s!",
    "On your way, don't delay, let these buffs keep foes at bay, %s!",
    "Stay brave, ride the wave, with these buffs, you're sure to save, %s!",
    "Set to soar, ready for more, buffs that'll make your power roar, %s!"
	
}

local function Replace(str, from, to)
    str = string.gsub(str, from, to)
    return str
end

local function PickWhisper(Name)
    local WhisperNum = math.random(1, #whispers)
    local whisper = whispers[WhisperNum]
    local randMsg = Replace(whisper, "%%s", Name)
    return randMsg
end

local function PickPhrase()
    local PhraseNum = math.random(1, #phrases)
    local phrase = phrases[PhraseNum]
    return phrase
end

local function OnGossipSelect(event, player, creature, sender, intid)
    local PlayerName = player:GetName()
    local PlayerLevel = player:GetLevel()

    
    local vecBuffs = {48162, 43223, 48469, 48470, 48170, 43002}

    
    if BUFF_CURE_RES and player:HasAura(15007) then
        player:RemoveAura(15007)
        creature:SendUnitSay("The aura of death has been lifted from you " .. PlayerName .. ". Watch yourself out there!", 0, player)
    end

if PlayerLevel >= 1 and PlayerLevel < 10 then
    player:CastSpell(player, 21562, true) 
    player:CastSpell(player, 1126, true)  
    player:CastSpell(player, 27683, true) 
elseif PlayerLevel >= 10 and PlayerLevel < 20 then
    player:CastSpell(player, 21562, true) 
    player:CastSpell(player, 1126, true)  
    player:CastSpell(player, 27683, true) 
elseif PlayerLevel >= 20 and PlayerLevel < 30 then
    player:CastSpell(player, 21562, true) 
    player:CastSpell(player, 1126, true)  
    player:CastSpell(player, 27683, true) 
    player:CastSpell(player, 13326, true) 
elseif PlayerLevel >= 30 and PlayerLevel < 40 then
    player:CastSpell(player, 21562, true) 
    player:CastSpell(player, 25898, true) 
    player:CastSpell(player, 1126, true)  
    player:CastSpell(player, 27681, true) 
    player:CastSpell(player, 27683, true) 
    player:CastSpell(player, 13326, true) 
elseif PlayerLevel >= 40 and PlayerLevel < 50 then
    player:CastSpell(player, 21562, true) 
    player:CastSpell(player, 48469, true) 
    player:CastSpell(player, 27681, true) 
    player:CastSpell(player, 48170, true) 
    player:CastSpell(player, 13326, true) 
elseif PlayerLevel >= 50 and PlayerLevel < 60 then
    player:CastSpell(player, 48162, true) 
    player:CastSpell(player, 43223, true) 
    player:CastSpell(player, 48469, true) 
    player:CastSpell(player, 48074, true) 
    player:CastSpell(player, 48170, true) 
   player:CastSpell(player, 36880, true) 
elseif PlayerLevel >= 60 and PlayerLevel < 70 then
    player:CastSpell(player, 48162, true) 
    player:CastSpell(player, 43223, true) 
    player:CastSpell(player, 48469, true) 
    player:CastSpell(player, 48074, true) 
    player:CastSpell(player, 48170, true) 
    player:CastSpell(player, 36880, true) 
elseif PlayerLevel >= 70 and PlayerLevel < 80 then
    player:CastSpell(player, 48162, true) 
    player:CastSpell(player, 43223, true) 
    player:CastSpell(player, 48469, true) 
    player:CastSpell(player, 48074, true) 
    player:CastSpell(player, 48170, true) 
    player:CastSpell(player, 36880, true) 
else
for _, buff in ipairs(vecBuffs) do
    player:CastSpell(player, buff, true)
end
end


    creature:SendUnitSay(PickWhisper(PlayerName), 0)
    creature:PerformEmote(71) 
    player:GossipComplete()
end

local function OnGossipHello(event, player, creature)
    player:GossipMenuAddItem(0, "|TInterface\\icons\\spell_misc_emotionhappy:43:43:-33|t|cff007d45Buff me!|r", 1, 1)
    player:GossipSendMenu(1, creature)
end



local function OnTimerEmote(eventID, delay, pCall, creature) 
    creature:PerformEmote(71)  
    if ENABLE_BUFF_EMOTE_SPELL then  
        creature:CastSpell(creature, BUFF_EMOTE_SPELL, true)
    end
    creature:SendUnitSay(PickPhrase(), 0)
    creature:RegisterEvent(OnTimerEmote, BUFF_MESSAGE_TIMER, 1, creature) 
end


local function OnSpawn(event, creature)
    creature:RegisterEvent(OnTimerEmote, BUFF_MESSAGE_TIMER, 1, creature) 
    if BUFF_EMOTE_SPELL ~= 0 then
        creature:AddAura(BUFF_EMOTE_SPELL, creature)
    end
end


local function WrappedOnTimerEmote(eventID, delay, pCall)
    local anyCreature = nil
    
    for _, player in ipairs(GetPlayersInWorld()) do
        anyCreature = player:GetNearestCreature(30, NPCID)
        if anyCreature then
            break
        end
    end

    if anyCreature then
        local playersInRange = anyCreature:GetPlayersInRange(100000)
        for _, player in ipairs(playersInRange) do
            local creature = player:GetNearestCreature(100000, NPCID)
            if creature then
                OnTimerEmote(eventID, delay, pCall, creature)
            end
        end
    end
end


local eventId = CreateLuaEvent(WrappedOnTimerEmote, BUFF_MESSAGE_TIMER, 1)
if eventId then
    RegisterCreatureEvent(NPCID, 5, OnSpawn)
end

local function OnLogin(event, player)
    if ANNOUNCE_MODULE then
        player:SendBroadcastMessage("This server is running the |cff4CFF00BufferNPC |rmodule.")
    end
    local creature = player:GetNearestCreature(30, NPCID)  
    if creature then
        creature:SetEquipmentSlots(27937, 27937, 0)  -- Weapon slots. Change to whatever.
    end
end

RegisterPlayerEvent(3, OnLogin)
RegisterCreatureGossipEvent(NPCID, 1, OnGossipHello)
RegisterCreatureGossipEvent(NPCID, 2, OnGossipSelect)