local WolfRider = {}

WolfRider.NPC_ID = 400045
WolfRider.dialogues = {
    "For the Horde!",
    "Victory for the Horde!",
    "Our enemies will tremble before the might of the Horde!",
    "Lok'tar ogar!",
    "Let the winds of war carry us to glory!",
    "The Horde will claim what is rightfully ours!",
    "We will show the Lich King the power of the Horde!",
    "For the glory of the Warchief!",
    "None shall stand against the Horde!",
    "Our enemies will rue the day they crossed the Horde!",
    "With the strength of the Horde, we will triumph!",
    "Let us show the Scourge the might of the Horde!",
    "We will prove the might of the Horde!",
}

function WolfRider.OnSpawn(event, creature)
    local randomDialogue = WolfRider.dialogues[math.random(#WolfRider.dialogues)] -- Selects a random dialogue from the "dialogues" table
    creature:SendUnitYell(randomDialogue, 0) -- Makes the creature yell the selected dialogue
end

RegisterCreatureEvent(WolfRider.NPC_ID, 5, WolfRider.OnSpawn) -- Registers the "OnSpawn" function as a spawn event for the creature with ID 400045
