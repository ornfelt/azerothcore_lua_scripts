local lightwellNPC = 400026
local lightwellSpell = 27870
local fortitudeSpell = 10938
local divineSpiritSpell = 27841

local function OnSpawn(event, creature)
creature:CastSpell(creature, lightwellSpell, true)
end

local function OnGossipHello(event, player, creature)
player:GossipMenuAddItem(9, "|TInterface\\Icons\\Spell_Holy_SummonLightwell:50:50:-13:0|tCast Lightwell", 0, 1, false, "", 0)
player:GossipMenuAddItem(9, "|TInterface\\Icons\\Spell_Holy_WordFortitude:50:50:-13:0|tCast Power Word: Fortitude", 0, 2, false, "", 0)
player:GossipMenuAddItem(9, "|TInterface\\Icons\\Spell_Holy_DivineSpirit:50:50:-13:0|tCast Divine Spirit", 0, 3, false, "", 0)
player:GossipSendMenu(1, creature)
end

local function OnGossipSelect(event, player, creature, sender, intid, code, menuid)
if intid == 1 then
player:CastSpell(player, lightwellSpell, true)
elseif intid == 2 then
player:CastSpell(player, fortitudeSpell, true)
elseif intid == 3 then
player:CastSpell(player, divineSpiritSpell, true)
end
player:GossipComplete()
end

local function YellDialogue(event, creature)
-- List of unit say options
local unitSayOptions = {
"May the light guide your paths.",
"Blessings upon you, traveler.",
"The light is always with you. Come, let me grant you a blessing.",
"May the light guide you on your journey.",
"The power of the light is yours for the asking.",
"Let me bring the light to your path."
}
-- Choose a random unit say option
local randomOption = unitSayOptions[math.random(#unitSayOptions)]
creature:SendUnitSay(randomOption, 0)
end

RegisterCreatureEvent(lightwellNPC, 5, OnSpawn)
RegisterCreatureGossipEvent(lightwellNPC, 1, OnGossipHello)
RegisterCreatureGossipEvent(lightwellNPC, 2, OnGossipSelect)

-- triggers the yell function on spawn
RegisterCreatureEvent(lightwellNPC, 5, function(event, creature) YellDialogue(event, creature) end)