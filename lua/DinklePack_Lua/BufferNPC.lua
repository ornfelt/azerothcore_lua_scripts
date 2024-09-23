local ENABLE_BUFF_NPC = true 
local Buffer_NPCID = 400117
local BUFF_CURE_RES = true


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

function ShuffleTable(t)
    local rand = math.random 
    local iterations = #t
    local w

    for z = iterations, 2, -1 do
        w = rand(z)
        t[z], t[w] = t[w], t[z]
    end

    return t
end

local shuffledWhispers = ShuffleTable(whispers)
local whisperIndex = 1

function PickWhisper(Name)
    local whisper = shuffledWhispers[whisperIndex]
    whisperIndex = (whisperIndex % #shuffledWhispers) + 1
    return whisper:format(Name)
end

function Buffer_OnGossipSelect(event, player, creature, sender, intid)
    local PlayerName = player:GetName()
    local PlayerLevel = player:GetLevel()

    local spellTable = {
        [1] = {1244, 1126, 19740},
        [10] = {1245, 1126, 27683},
        [20] = {2791, 1126, 27683, 13326},
        [30] = {10937, 25898, 1126, 27681, 27683, 13326},
        [40] = {10937, 48469, 27681, 48170, 13326},
        [50] = {10938, 43223, 48469, 48074, 48170, 36880},
        [60] = {10938, 43223, 48469, 48074, 48170, 36880},
        [70] = {25389, 43223, 48469, 48074, 48170, 36880},
        [80] = {48161, 43223, 48469, 48074, 48170, 36880},
    }

    for level, spells in pairs(spellTable) do
        if PlayerLevel >= level then
            for _, spell in ipairs(spells) do
                player:CastSpell(player, spell, true)
            end
        end
    end

    creature:SendUnitSay(PickWhisper(PlayerName), 0)
    creature:PerformEmote(71)
    player:GossipComplete()
end

local function Buffer_OnGossipHello(event, player, creature)
    if ENABLE_BUFF_NPC then
        player:GossipMenuAddItem(0, "|TInterface\\icons\\spell_misc_emotionhappy:43:43:-33|t|cff007d45Buff me!|r", 1, 1)
        player:GossipSendMenu(1, creature)
    else
        player:SendBroadcastMessage("You must Enable BufferNPC in lua_scripts to speak with this NPC.")
    end
end

RegisterCreatureGossipEvent(Buffer_NPCID, 1, Buffer_OnGossipHello)
RegisterCreatureGossipEvent(Buffer_NPCID, 2, Buffer_OnGossipSelect)


