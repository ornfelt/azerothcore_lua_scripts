local mageNPC = 400027
local conjuredCinnamonRolls = 22895
local arcaneIntellect = 10157

local function OnGossipHello(event, player, creature)
player:GossipMenuAddItem(9, "|TInterface\\Icons\\inv_misc_food_73cinnamonroll:50:50:-13:0|tTake some Conjured Cinnamon Rolls", 0, 1, false, "", 0)
player:GossipMenuAddItem(9, "|TInterface\\Icons\\Spell_Holy_Magicalsentry:50:50:-13:0|tCast Arcane Intellect", 0, 2, false, "", 0)
player:GossipSendMenu(1, creature)
end

local function OnGossipSelect(event, player, creature, sender, intid, code, menuid)
if intid == 1 then
player:AddItem(conjuredCinnamonRolls, 5)
player:SendBroadcastMessage("Enjoy the sweet taste of magic! Here are 5 Conjured Cinnamon Rolls.")
elseif intid == 2 then
player:CastSpell(player, arcaneIntellect, true)
player:SendBroadcastMessage("You feel your mind become more focused as Arcane Intellect takes hold.")
end
player:GossipComplete()
end

local function YellDialogue(event, creature)
-- List of unit say options
local unitSayOptions = {
"Greetings, adventurer! Would you like some refreshment?",
"Welcome traveler! Are you in need of some sustenance?",
"Let me offer you some conjured treats and a bit of intellectual enhancement.",
"You look like you could use a boost. How about some Conjured Cinnamon Rolls and Arcane Intellect?",
"Good day! I have some delectable Conjured Cinnamon Rolls and the power of Arcane Intellect for you.",
"Step right up! I have some of the finest Conjured Cinnamon Rolls and a touch of Arcane Intellect for you."
}
-- Choose a random unit say option
local randomOption = unitSayOptions[math.random(#unitSayOptions)]
creature:SendUnitSay(randomOption, 0)
end

RegisterCreatureGossipEvent(mageNPC, 1, OnGossipHello)
RegisterCreatureGossipEvent(mageNPC, 2, OnGossipSelect)

-- triggers the yell function on spawn
RegisterCreatureEvent(mageNPC, 5, function(event, creature) YellDialogue(event, creature) end)