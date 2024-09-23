function MurkyOnSpawn(event, creature)
local owner = creature:GetOwner()
if not owner then
    return
end
local playerName = owner:GetName()

    local dialogue = {
        "Mrglglglgl! Murky here, reporting for duty!",
        "Mrrrrrrrglglglgl! Murky happy to serve you, " .. playerName .. "!",
        "Mrglgl! Murloc Murky at your service! Let's conquer Azeroth together!",
        "Mrrrglglgl! Murky ready to take on any challenge with you, " .. playerName .. "!",
        "Mrglglglglgl! Reporting for duty! Let's make some waves, " .. playerName .. "!",
        "Mrrglglgl! Murky is excited to join your team, " .. playerName .. "! Let's show everyone what we're made of!",
        "Mrglglgl! Murloc warrior Murky at your command, " .. playerName .. "! Let's make our enemies quake with fear!",
        "Mrrrglglgl! Murky is eager to prove his worth to you, " .. playerName .. "! Let's take on the world together!",
        "Mrglglglgl! This Murloc is ready to make some noise with you, " .. playerName .. "! Let's show them who's boss!",
        "Mrrrglgl! Murky honored to be your loyal companion, " .. playerName .. "! Let's take on any challenge that comes our way!",
        "Greetings, adventurer! The one and only Murky has arrived to join you on your quest!",
        "Mrglgl! Murky is here to lend a fin and help you conquer the land, " .. playerName .. "!",
        "Mrrglgl! Murky is thrilled to serve such a worthy leader as yourself, " .. playerName .. "!",
        "Mrglglglgl! Murky reporting for duty! Let's make some mischief and have some fun, " .. playerName .. "!",
        "Mrrglgl! Murky is honored to be fighting by your side, " .. playerName .. "! Let's take on our foes with all we've got!",
        "Mrglglgl! Murky is eager to explore the land and see what adventures await us, " .. playerName .. "!",
        "Mrrrglglgl! Murky is always up for a challenge, " .. playerName .. "! Let's go forth and conquer!",
        "Mrglglglgl! Murky is ready to make some waves and take on the world, " .. playerName .. "! Let's do this!",
        "Mrrrglgl! Murky will be your trusty sidekick on this journey, " .. playerName .. "! Let's make some memories!",
        "Mrglglglgl! Murky is thrilled to be part of your team, " .. playerName .. "! Let's show them what we're made of and come out on top!"
    }
    creature:SendUnitSay(dialogue[math.random(#dialogue)], 0)
end

RegisterCreatureEvent(15186, 5, MurkyOnSpawn) -- register the function to be called on Murky's spawn
