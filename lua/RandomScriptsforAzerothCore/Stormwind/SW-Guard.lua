--Made by Dinkledork. This script defines a table of 26 battle cries for a creature with ID 400014. When the creature spawns, it will randomly select one of the 26 dialogues and use it in a yell.

local SwHorse = {}; --ID from creature_template

local dialogues = {
"Defend our lands with all you've got!",
"Victory is ours, if we stand together!",
"We are the shield that protects our people!",
"Show no mercy to those who would harm us!",
"Justice for our fallen!",
"Stand firm, for the future of our kingdom!",
"Today, we fight for everything we hold dear!",
"Let our enemies know that we will not be broken!",
"With honor and bravery, we will triumph!",
"We will not bow down to tyranny!",
"Rise up and defend our way of life!",
"In the face of danger, we stand strong!",
"For our families, for our friends, we fight!",
"Our cause is just, our resolve unbreakable!",
"Glory awaits those who face the fray!",
"No quarter for the enemy!",
"Hold the line, for the sake of all!",
"Today, we make history with our bravery!",
"The battle is upon us!",
"We fight for the defense of our homeland!",
"Make them pay for every inch they gain!",
"For the Alliance!",
"Ready yourselves for battle!",
"Prepare yourselves for the oncoming assault!",
"Steady yourselves, men. A terrible enemy approaches!",
"Don't let the enemy make it to the castle!"
}

local function OnSpawn(event, creature) 
  local randomDialogue = dialogues[math.random(26)] -- Selects a random dialogue from the "dialogues" table
  creature:SendUnitYell(randomDialogue,0) -- Makes the creature yell the selected dialogue
end

RegisterCreatureEvent(400014, 5, OnSpawn) -- Registers the "OnSpawn" function as a spawn event for the creature with ID 400014

