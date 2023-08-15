local Config            = {}
Config.Database         = 'acore_eluna' -- The database used to store tables for eluna
Config.EnableGamemaster = false -- Allow GM characters to save and learn companions and mounts
Config.EnableCompanions = true -- Allow compansions to be account bound
Config.EnableMounts     = true -- Allow mounts to be account bound

AuthDBQuery('CREATE TABLE IF NOT EXISTS `'..Config.Database..'`.`account_bound_companions` (`account_id` INT(10) UNSIGNED NOT NULL, `spell_id` MEDIUMINT(8) UNSIGNED NOT NULL, `allowable_race` INT(11) NOT NULL, `comment` VARCHAR(255) NOT NULL COLLATE \'utf8mb4_general_ci\', PRIMARY KEY (`account_id`, `spell_id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;')
AuthDBQuery('CREATE TABLE IF NOT EXISTS `'..Config.Database..'`.`account_bound_mounts` (`account_id` INT(10) UNSIGNED NOT NULL, `spell_id` MEDIUMINT(8) UNSIGNED NOT NULL, `allowable_race` INT(11) UNSIGNED NOT NULL, `allowable_class` INT(11) UNSIGNED NOT NULL, `required_level` TINYINT(3) UNSIGNED NOT NULL, `required_skill` SMALLINT(3) UNSIGNED NOT NULL, `required_skill_rank` SMALLINT(3) UNSIGNED NOT NULL, `comment` VARCHAR(255) NOT NULL COLLATE \'utf8mb4_general_ci\', PRIMARY KEY (`account_id`,`spell_id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;');

local Event          = {
    OnLogin          = 3,
    OnLearnSpell     = 44,
}

local Companions = {
    { 4055, 1791, 'Mechanical Squirrel' },
    { 10673, 1791, 'Bombay Cat' },
    { 10674, 1791, 'Cornish Rex Cat' },
    { 10675, 1791, 'Black Tabby Cat' },
    { 10676, 1791, 'Orange Tabby Cat' },
    { 10677, 1791, 'Siamese Cat' },
    { 10678, 1791, 'Silver Tabby Cat' },
    { 10679, 1791, 'White Kitten' },
    { 10680, 1791, 'Cockatiel' },
    { 10681, 1791, 'Cockatoo' },
    { 10682, 1791, 'Hyacinth Macaw' },
    { 10683, 1791, 'Green Wing Macaw' },
    { 10684, 1791, 'Senegal' },
    { 10685, 1791, 'Ancona Chicken' },
    { 10686, 1791, 'Prairie Chicken' },
    { 10687, 1791, 'White Plymouth Rock' },
    { 10688, 1791, 'Cockroach' },
    { 10695, 1791, 'Dark Whelpling' },
    { 10696, 1791, 'Azure Whelpling' },
    { 10697, 1791, 'Crimson Whelpling' },
    { 10698, 1791, 'Emerald Whelpling' },
    { 10699, 1791, 'Bronze Whelpling' },
    { 10700, 1791, 'Faeling' },
    { 10701, 1791, 'Dart Frog' },
    { 10702, 1791, 'Island Frog' },
    { 10703, 1791, 'Wood Frog' },
    { 10704, 1791, 'Tree Frog' },
    { 10705, 1791, 'Eagle Owl' },
    { 10706, 1791, 'Hawk Owl' },
    { 10707, 1791, 'Great Horned Owl' },
    { 10708, 1791, 'Snowy Owl' },
    { 10709, 1791, 'Brown Prairie Dog' },
    { 10710, 1791, 'Cottontail Rabbit' },
    { 10711, 1791, 'Snowshoe Rabbit' },
    { 10712, 1791, 'Spotted Rabbit' },
    { 10713, 1791, 'Albino Snake' },
    { 10714, 1791, 'Black Kingsnake' },
    { 10715, 1791, 'Blue Racer' },
    { 10716, 1791, 'Brown Snake' },
    { 10717, 1791, 'Crimson Snake' },
    { 10718, 1791, 'Green Water Snake' },
    { 10719, 1791, 'Ribbon Snake' },
    { 10720, 1791, 'Scarlet Snake' },
    { 10721, 1791, 'Elven Wisp' },
    { 12243, 1791, 'Mechanical Chicken' },
    { 13548, 1791, 'Westfall Chicken' },
    { 15048, 1791, 'Pet Bombling' },
    { 15049, 1791, 'Lil Smoky' },
    { 15067, 1791, 'Sprite Darter Hatchling' },
    { 15648, 1791, 'Corrupted Kitten' },
    { 15999, 1791, 'Worg Pup' },
    { 16450, 1791, 'Smolderweb Hatchling' },
    { 17468, 1791, 'Pet Fish' },
    { 17469, 1791, 'Pet Stone' },
    { 17567, 1791, 'Blood Parrot' },
    { 17707, 1791, 'Panda Cub' },
    { 17708, 1791, 'Mini Diablo' },
    { 17709, 1791, 'Zergling' },
    { 19363, 1791, 'Mechanical Yeti' },
    { 19772, 1791, 'Lifelike Toad' },
    { 23428, 1791, 'Albino Snapjaw' },
    { 23429, 1791, 'Loggerhead Snapjaw' },
    { 23430, 1791, 'Olive Snapjaw' },
    { 23431, 1791, 'Leatherback Snapjaw' },
    { 23432, 1791, 'Hawksbill Snapjaw' },
    { 23530, 1791, 'Tiny Red Dragon' },
    { 23531, 1791, 'Tiny Green Dragon' },
    { 23811, 1791, 'Jubling' },
    { 24696, 1791, 'Murky' },
    { 24985, 1791, 'Baby Murloc (Blue)' },
    { 24986, 1791, 'Baby Murloc (Green)' },
    { 24987, 1791, 'Baby Murloc (Orange)' },
    { 24988, 1791, 'Lurky' },
    { 24989, 1791, 'Baby Murloc (Pink)' },
    { 24990, 1791, 'Baby Murloc (Purple)' },
    { 25018, 1791, 'Murki' },
    { 25162, 1791, 'Disgusting Oozeling' },
    { 25849, 1791, 'Baby Shark' },
    { 26010, 1791, 'Tranquil Mechanical Yeti' },
    { 26045, 1791, 'Tiny Snowman' },
    { 26067, 1791, 'Mechanical Greench' },
    { 26391, 1791, 'Tentacle Call' },
    { 26529, 1791, 'Winter Reindeer' },
    { 26533, 1791, 'Father Winters Helper' },
    { 26541, 1791, 'Winters Little Helper' },
    { 27241, 1791, 'Gurky' },
    { 27570, 1791, 'Peddlefeet' },
    { 28487, 1791, 'Terky' },
    { 28505, 1791, 'Poley' },
    { 28738, 1791, 'Speedy' },
    { 28739, 1791, 'Mr. Wiggles' },
    { 28740, 1791, 'Whiskers the Rat' },
    { 28871, 1791, 'Spirit of Summer' },
    { 30152, 1791, 'White Tiger Cub' },
    { 30156, 1791, 'Hippogryph Hatchling' },
    { 32298, 1791, 'Netherwhelp' },
    { 33050, 1791, 'Magical Crawdad' },
    { 33057, 1791, 'Mighty Mr. Pinchy' },
    { 35156, 1791, 'Mana Wyrmling' },
    { 35157, 1791, 'Spotted Rabbit' },
    { 35239, 1791, 'Brown Rabbit' },
    { 35907, 1791, 'Blue Moth' },
    { 35909, 1791, 'Red Moth' },
    { 35910, 1791, 'Yellow Moth' },
    { 35911, 1791, 'White Moth' },
    { 36027, 1791, 'Golden Dragonhawk Hatchling' },
    { 36028, 1791, 'Red Dragonhawk Hatchling' },
    { 36029, 1791, 'Silver Dragonhawk Hatchling' },
    { 36031, 1791, 'Blue Dragonhawk Hatchling' },
    { 36034, 1791, 'Firefly' },
    { 39181, 1791, 'Miniwing' },
    { 39709, 1791, 'Wolpertinger' },
    { 40319, 1791, 'Lucky' },
    { 40405, 1791, 'Lucky' },
    { 40549, 1791, 'Bananas' },
    { 40613, 1791, 'Willy' },
    { 40614, 1791, 'Egbert' },
    { 40634, 1791, 'Peanut' },
    { 40990, 1791, 'Stinker' },
    { 42609, 1791, 'Sinister Squashling' },
    { 43697, 1791, 'Toothy' },
    { 43698, 1791, 'Muckbreath' },
    { 43918, 1791, 'Mojo' },
    { 44369, 1791, 'Pint-Sized Pink Pachyderm' },
    { 45082, 1791, 'Tiny Sporebat' },
    { 45125, 1791, 'Rocket Chicken' },
    { 45127, 1791, 'Dragon Kite' },
    { 45174, 1791, 'Golden Pig' },
    { 45175, 1791, 'Silver Pig' },
    { 45890, 1791, 'Scorchling' },
    { 46425, 1791, 'Snarly' },
    { 46426, 1791, 'Chuck' },
    { 46599, 1791, 'Phoenix Hatchling' },
    { 48406, 1791, 'Spirit of Competition' },
    { 48408, 1791, 'Essence of Competition' },
    { 49964, 1791, 'Ethereal Soul-Trader' },
    { 51716, 1791, 'Nether Ray Fry' },
    { 51851, 1791, 'Vampiric Batling' },
    { 52615, 1791, 'Frosty' },
    { 53082, 1791, 'Mini Tyrael' },
    { 53316, 1791, 'Ghostly Skull' },
    { 53768, 1791, 'Haunted' },
    { 54187, 1791, 'Clockwork Rocket Bot' },
    { 55068, 1791, 'Mr. Chilly' },
    { 59250, 1791, 'Giant Sewer Rat' },
    { 61348, 1791, 'Tickbird Hatchling' },
    { 61349, 1791, 'White Tickbird Hatchling' },
    { 61350, 1791, 'Proto-Drake Whelp' },
    { 61351, 1791, 'Cobra Hatchling' },
    { 61357, 1791, 'Pengu' },
    { 61472, 1791, 'Kirin Tor Familiar' },
    { 61725, 1791, 'Spring Rabbit' },
    { 61773, 1791, 'Plump Turkey' },
    { 61855, 1791, 'Baby Blizzard Bear' },
    { 61991, 1791, 'Little Fawn' },
    { 62491, 1791, 'Teldrassil Sproutling' },
    { 62508, 1791, 'Dun Morogh Cub' },
    { 62510, 1791, 'Tirisfal Batling' },
    { 62513, 1791, 'Durotar Scorpion' },
    { 62514, 1791, 'Alarming Clockbot' },
    { 62516, 1791, 'Elwynn Lamb' },
    { 62542, 1791, 'Mulgore Hatchling' },
    { 62561, 1791, 'Strand Crawler' },
    { 62562, 1791, 'Ammen Vale Lashling' },
    { 62564, 1791, 'Enchanted Broom' },
    { 62609, 1101, 'Argent Squire' },
    { 62674, 1791, 'Mechanopeep' },
    { 62746, 690, 'Argent Gruntling' },
    { 63318, 1791, 'Murkimus the Gladiator' },
    { 63712, 1791, 'Senjin Fetish' },
    { 64351, 1791, 'XS-001 Constructor Bot' },
    { 65358, 1791, 'Calico Cat' },
    { 65381, 1791, 'Curious Oracle Hatchling' },
    { 65382, 1791, 'Curious Wolvar Pup' },
    { 65682, 1791, 'Warbot' },
    { 66030, 1791, 'Grunty' },
    { 66096, 1791, 'Shimmering Wyrmling' },
    { 66175, 1791, 'Macabre Marionette' },
    { 66520, 1791, 'Jade Tiger' },
    { 67413, 1791, 'Darting Hatchling' },
    { 67414, 1791, 'Deviate Hatchling' },
    { 67415, 1791, 'Gundrak Hatchling' },
    { 67416, 1791, 'Leaping Hatchling' },
    { 67417, 1791, 'Obsidian Hatchling' },
    { 67418, 1791, 'Ravasaur Hatchling' },
    { 67419, 1791, 'Razormaw Hatchling' },
    { 67420, 1791, 'Razzashi Hatchling' },
    { 67527, 1791, 'Onyx Panther' },
    { 68767, 1791, 'Tuskarr Kite' },
    { 68810, 1791, 'Spectral Tiger Cub' },
    { 69002, 1791, 'Onyxian Whelpling' },
    { 69452, 1791, 'Core Hound Pup' },
    { 69535, 1791, 'Gryphon Hatchling' },
    { 69536, 1791, 'Wind Rider Cub' },
    { 69539, 1791, 'Zipao Tiger' },
    { 69541, 1791, 'Pandaren Monk' },
    { 69677, 1791, 'Lil K.T.' },
    { 70613, 1791, 'Perky Pug' },
    { 71840, 1791, 'Toxic Wasteling' },
    { 74932, 1791, 'Frigid Frostling' },
    { 75134, 1791, 'Blue Clockwork Rocket Bot' },
    { 75613, 1791, 'Celestial Dragon' },
    { 75906, 1791, 'Lil XT' },
    { 75936, 1791, 'Murkimus the Gladiator' },
    { 78381, 1791, 'Mini Thor' },
}

local FactionSpecificCompanions = {
    { 62609, 'Argent Squire', 62746, 'Argent Gruntling' },
}

local Mounts = {
    { 458, 1101, 1535, 20, 762, 75, 'Brown Horse' },
    { 470, 1101, 1535, 20, 762, 75, 'Black Stallion' },
    { 472, 1101, 1535, 20, 762, 75, 'Pinto' },
    { 580, 690, 1535, 20, 762, 75, 'Timber Wolf' },
    { 6648, 1101, 1535, 20, 762, 75, 'Chestnut Mare' },
    { 6653, 690, 1535, 20, 762, 75, 'Dire Wolf' },
    { 6654, 690, 1535, 20, 762, 75, 'Brown Wolf' },
    { 6777, 1101, 1535, 20, 762, 75, 'Gray Ram' },
    { 6898, 1101, 1535, 20, 762, 75, 'White Ram' },
    { 6899, 1101, 1535, 20, 762, 75, 'Brown Ram' },
    { 8394, 1101, 1535, 20, 762, 75, 'Striped Frostsaber' },
    { 8395, 690, 1535, 20, 762, 75, 'Emerald Raptor' },
    { 10789, 1101, 1535, 20, 762, 75, 'Spotted Frostsaber' },
    { 10793, 1101, 1535, 20, 762, 75, 'Striped Nightsaber' },
    { 10796, 690, 1535, 20, 762, 75, 'Turquoise Raptor' },
    { 10799, 690, 1535, 20, 762, 75, 'Violet Raptor' },
    { 10873, 1101, 1535, 20, 762, 75, 'Red Mechanostrider' },
    { 10969, 1101, 1535, 20, 762, 75, 'Blue Mechanostrider' },
    { 15779, 1101, 1535, 40, 762, 150, 'White Mechanostrider Mod B' },
    { 16055, 1101, 1535, 40, 762, 150, 'Nightsaber' },
    { 16056, 1101, 1535, 40, 762, 150, 'Ancient Frostsaber' },
    { 16080, 690, 1535, 40, 762, 150, 'Red Wolf' },
    { 16081, 690, 1535, 40, 762, 150, 'Arctic Wolf' },
    { 16082, 1101, 1535, 40, 762, 150, 'Palomino' },
    { 16083, 1101, 1535, 40, 762, 150, 'White Stallion' },
    { 16084, 690, 1535, 40, 762, 150, 'Mottled Red Raptor' },
    { 17229, 1101, 1535, 40, 762, 75, 'Winterspring Frostsaber' },
    { 17450, 690, 1535, 40, 762, 150, 'Ivory Raptor' },
    { 17453, 1101, 1535, 20, 762, 75, 'Green Mechanostrider' },
    { 17454, 1101, 1535, 20, 762, 75, 'Unpainted Mechanostrider' },
    { 17459, 1101, 1535, 40, 762, 150, 'Icy Blue Mechanostrider Mod A' },
    { 17460, 1101, 1535, 40, 762, 150, 'Frost Ram' },
    { 17461, 1101, 1535, 40, 762, 150, 'Black Ram' },
    { 17462, 690, 1535, 20, 762, 75, 'Red Skeletal Horse' },
    { 17463, 690, 1535, 20, 762, 75, 'Blue Skeletal Horse' },
    { 17464, 690, 1535, 20, 762, 75, 'Brown Skeletal Horse' },
    { 17465, 690, 1535, 40, 762, 150, 'Green Skeletal Warhorse' },
    { 17481, 1791, 1535, 40, 762, 150, 'Rivendares Deathcharger' },
    { 18989, 690, 1535, 20, 762, 75, 'Gray Kodo' },
    { 18990, 690, 1535, 20, 762, 75, 'Brown Kodo' },
    { 18991, 690, 1535, 40, 762, 150, 'Green Kodo' },
    { 18992, 690, 1535, 40, 762, 150, 'Teal Kodo' },
    { 22717, 1101, 1535, 40, 762, 150, 'Black War Steed' },
    { 22718, 690, 1535, 40, 762, 150, 'Black War Kodo' },
    { 22719, 1101, 1535, 40, 762, 150, 'Black Battlestrider' },
    { 22720, 1101, 1535, 40, 762, 150, 'Black War Ram' },
    { 22721, 690, 1535, 40, 762, 150, 'Black War Raptor' },
    { 22722, 690, 1535, 40, 762, 150, 'Red Skeletal Warhorse' },
    { 22723, 1101, 1535, 40, 762, 150, 'Black War Tiger' },
    { 22724, 690, 1535, 40, 762, 150, 'Black War Wolf' },
    { 23219, 1101, 1535, 40, 762, 150, 'Swift Mistsaber' },
    { 23221, 1101, 1535, 40, 762, 150, 'Swift Frostsaber' },
    { 23222, 1101, 1535, 40, 762, 150, 'Swift Yellow Mechanostrider' },
    { 23223, 1101, 1535, 40, 762, 150, 'Swift White Mechanostrider' },
    { 23225, 1101, 1535, 40, 762, 150, 'Swift Green Mechanostrider' },
    { 23227, 1101, 1535, 40, 762, 150, 'Swift Palomino' },
    { 23228, 1101, 1535, 40, 762, 150, 'Swift White Steed' },
    { 23229, 1101, 1535, 40, 762, 150, 'Swift Brown Steed' },
    { 23238, 1101, 1535, 40, 762, 150, 'Swift Brown Ram' },
    { 23239, 1101, 1535, 40, 762, 150, 'Swift Gray Ram' },
    { 23240, 1101, 1535, 40, 762, 150, 'Swift White Ram' },
    { 23241, 690, 1535, 40, 762, 150, 'Swift Blue Raptor' },
    { 23242, 690, 1535, 40, 762, 150, 'Swift Olive Raptor' },
    { 23243, 690, 1535, 40, 762, 150, 'Swift Orange Raptor' },
    { 23246, 690, 1535, 40, 762, 150, 'Purple Skeletal Warhorse' },
    { 23247, 690, 1535, 40, 762, 150, 'Great White Kodo' },
    { 23248, 690, 1535, 40, 762, 150, 'Great Gray Kodo' },
    { 23249, 690, 1535, 40, 762, 150, 'Great Brown Kodo' },
    { 23250, 690, 1535, 40, 762, 150, 'Swift Brown Wolf' },
    { 23251, 690, 1535, 40, 762, 150, 'Swift Timber Wolf' },
    { 23252, 690, 1535, 40, 762, 150, 'Swift Gray Wolf' },
    { 23338, 1101, 1535, 40, 762, 150, 'Swift Stormsaber' },
    { 23509, 690, 1535, 40, 762, 150, 'Frostwolf Howler' },
    { 23510, 1101, 1535, 40, 762, 150, 'Stormpike Battle Charger' },
    { 24242, 1791, 1535, 40, 762, 150, 'Swift Razzashi Raptor' },
    { 24252, 1791, 1535, 40, 762, 150, 'Swift Zulian Tiger' },
    { 25953, 1791, 1535, 40, 762, 75, 'Blue Qiraji Battle Tank' },
    { 26054, 1791, 1535, 40, 762, 75, 'Red Qiraji Battle Tank' },
    { 26055, 1791, 1535, 40, 762, 75, 'Yellow Qiraji Battle Tank' },
    { 26056, 1791, 1535, 40, 762, 75, 'Green Qiraji Battle Tank' },
    { 26656, 1791, 1535, 40, 762, 150, 'Black Qiraji Battle Tank' },
    { 32235, 1101, 1535, 60, 762, 225, 'Golden Gryphon' },
    { 32239, 1101, 1535, 60, 762, 225, 'Ebon Gryphon' },
    { 32240, 1101, 1535, 60, 762, 225, 'Snowy Gryphon' },
    { 32242, 1101, 1535, 70, 762, 300, 'Swift Blue Gryphon' },
    { 32243, 690, 1535, 60, 762, 225, 'Tawny Wind Rider' },
    { 32244, 690, 1535, 60, 762, 225, 'Blue Wind Rider' },
    { 32245, 690, 1535, 60, 762, 225, 'Green Wind Rider' },
    { 32246, 690, 1535, 70, 762, 300, 'Swift Red Wind Rider' },
    { 32289, 1101, 1535, 70, 762, 300, 'Swift Red Gryphon' },
    { 32290, 1101, 1535, 70, 762, 300, 'Swift Green Gryphon' },
    { 32292, 1101, 1535, 70, 762, 300, 'Swift Purple Gryphon' },
    { 32295, 690, 1535, 70, 762, 300, 'Swift Green Wind Rider' },
    { 32296, 690, 1535, 70, 762, 300, 'Swift Yellow Wind Rider' },
    { 32297, 690, 1535, 70, 762, 300, 'Swift Purple Wind Rider' },
    { 33660, 690, 1535, 40, 762, 150, 'Swift Pink Hawkstrider' },
    { 34406, 1101, 1535, 20, 762, 75, 'Brown Elekk' },
    { 34790, 1791, 1535, 40, 762, 150, 'Dark War Talbuk' },
    { 34795, 690, 1535, 20, 762, 75, 'Red Hawkstrider' },
    { 34896, 1791, 1535, 40, 762, 150, 'Cobalt War Talbuk' },
    { 34897, 1791, 1535, 40, 762, 150, 'White War Talbuk' },
    { 34898, 1791, 1535, 40, 762, 150, 'Silver War Talbuk' },
    { 34899, 1791, 1535, 40, 762, 150, 'Tan War Talbuk' },
    { 35018, 690, 1535, 20, 762, 75, 'Purple Hawkstrider' },
    { 35020, 690, 1535, 20, 762, 75, 'Blue Hawkstrider' },
    { 35022, 690, 1535, 20, 762, 75, 'Black Hawkstrider' },
    { 35025, 690, 1535, 40, 762, 150, 'Swift Green Hawkstrider' },
    { 35027, 690, 1535, 40, 762, 150, 'Swift Purple Hawkstrider' },
    { 35028, 690, 1535, 40, 762, 150, 'Swift Warstrider' },
    { 35710, 1101, 1535, 20, 762, 75, 'Gray Elekk' },
    { 35711, 1101, 1535, 20, 762, 75, 'Purple Elekk' },
    { 35712, 1101, 1535, 40, 762, 150, 'Great Green Elekk' },
    { 35713, 1101, 1535, 40, 762, 150, 'Great Blue Elekk' },
    { 35714, 1101, 1535, 40, 762, 150, 'Great Purple Elekk' },
    { 36702, 1791, 1535, 40, 762, 150, 'Fiery Warhorse' },
    { 37015, 1791, 1535, 70, 762, 300, 'Swift Nether Drake' },
    { 39315, 1791, 1535, 40, 762, 150, 'Cobalt Riding Talbuk' },
    { 39316, 1791, 1535, 40, 762, 150, 'Dark Riding Talbuk' },
    { 39317, 1791, 1535, 40, 762, 150, 'Silver Riding Talbuk' },
    { 39318, 1791, 1535, 40, 762, 150, 'Tan Riding Talbuk' },
    { 39319, 1791, 1535, 40, 762, 150, 'White Riding Talbuk' },
    { 39798, 1791, 1535, 70, 762, 300, 'Green Riding Nether Ray' },
    { 39800, 1791, 1535, 70, 762, 300, 'Red Riding Nether Ray' },
    { 39801, 1791, 1535, 70, 762, 300, 'Purple Riding Nether Ray' },
    { 39802, 1791, 1535, 70, 762, 300, 'Silver Riding Nether Ray' },
    { 39803, 1791, 1535, 70, 762, 300, 'Blue Riding Nether Ray' },
    { 40192, 1791, 1535, 70, 762, 300, 'Ashes of Alar' },
    { 41252, 1791, 1535, 40, 762, 150, 'Raven Lord' },
    { 41513, 1791, 1535, 70, 762, 300, 'Onyx Netherwing Drake' },
    { 41514, 1791, 1535, 70, 762, 300, 'Azure Netherwing Drake' },
    { 41515, 1791, 1535, 70, 762, 300, 'Cobalt Netherwing Drake' },
    { 41516, 1791, 1535, 70, 762, 300, 'Purple Netherwing Drake' },
    { 41517, 1791, 1535, 70, 762, 300, 'Veridian Netherwing Drake' },
    { 41518, 1791, 1535, 70, 762, 300, 'Violet Netherwing Drake' },
    { 42776, 1791, 1535, 20, 762, 75, 'Spectral Tiger' },
    { 42777, 1791, 1535, 40, 762, 150, 'Swift Spectral Tiger' },
    { 43688, 1791, 1535, 70, 762, 150, 'Amani War Bear' },
    { 43899, 1791, 1535, 20, 762, 75, 'Brewfest Ram' },
    { 43900, 1791, 1535, 40, 762, 150, 'Swift Brewfest Ram' },
    { 43927, 1791, 1535, 70, 762, 300, 'Cenarion War Hippogryph' },
    { 44744, 1791, 1535, 70, 762, 300, 'Merciless Nether Drake' },
    { 46197, 1791, 1535, 60, 762, 225, 'X-51 Nether-Rocket' },
    { 46199, 1791, 1535, 70, 762, 300, 'X-51 Nether-Rocket X-TREME' },
    { 46628, 1791, 1535, 40, 762, 150, 'Swift White Hawkstrider' },
    { 48025, 1791, 1535, 20, 762, 75, 'Headless Horsemans Mount' },
    { 48027, 1101, 1535, 40, 762, 150, 'Black War Elekk' },
    { 49193, 1791, 1535, 70, 762, 300, 'Vengeful Nether Drake' },
    { 49322, 1791, 1535, 40, 762, 150, 'Swift Zhevra' },
    { 49379, 1791, 1535, 40, 762, 150, 'Great Brewfest Kodo' },
    { 51412, 1791, 1535, 40, 762, 150, 'Big Battle Bear' },
    { 54729, 1791, 32, 60, 762, 225, 'Winged Steed of the Ebon Blade' },
    { 54753, 1791, 1535, 40, 762, 150, 'White Polar Bear' },
    { 55531, 690, 1535, 40, 762, 150, 'Mechano-hog' },
    { 58615, 1791, 1535, 70, 762, 300, 'Brutal Nether Drake' },
    { 58983, 1791, 1535, 20, 762, 75, 'Big Blizzard Bear' },
    { 59567, 1791, 1535, 70, 762, 300, 'Azure Drake' },
    { 59568, 1791, 1535, 70, 762, 300, 'Blue Drake' },
    { 59569, 1791, 1535, 70, 762, 300, 'Bronze Drake' },
    { 59570, 1791, 1535, 70, 762, 300, 'Red Drake' },
    { 59571, 1791, 1535, 70, 762, 300, 'Twilight Drake' },
    { 59650, 1791, 1535, 70, 762, 300, 'Black Drake' },
    { 59785, 1101, 1535, 40, 762, 150, 'Black War Mammoth' },
    { 59788, 690, 1535, 40, 762, 150, 'Black War Mammoth' },
    { 59791, 1101, 1535, 40, 762, 150, 'Wooly Mammoth' },
    { 59793, 690, 1535, 40, 762, 150, 'Wooly Mammoth' },
    { 59797, 690, 1535, 40, 762, 150, 'Ice Mammoth' },
    { 59799, 1101, 1535, 40, 762, 150, 'Ice Mammoth' },
    { 59961, 1791, 1535, 70, 762, 300, 'Red Proto-Drake' },
    { 59976, 1791, 1535, 70, 762, 300, 'Black Proto-Drake' },
    { 59996, 1791, 1535, 70, 762, 300, 'Blue Proto-Drake' },
    { 60002, 1791, 1535, 70, 762, 300, 'Time-Lost Proto-Drake' },
    { 60021, 1791, 1535, 70, 762, 300, 'Plagued Proto-Drake' },
    { 60024, 1791, 1535, 70, 762, 300, 'Violet Proto-Drake' },
    { 60025, 1791, 1535, 70, 762, 300, 'Albino Drake' },
    { 60114, 1101, 1535, 40, 762, 150, 'Armored Brown Bear' },
    { 60116, 690, 1535, 40, 762, 150, 'Armored Brown Bear' },
    { 60118, 1101, 1535, 40, 762, 150, 'Black War Bear' },
    { 60119, 690, 1535, 40, 762, 150, 'Black War Bear' },
    { 60424, 1101, 1535, 40, 762, 150, 'Mekgineers Chopper' },
    { 61229, 1101, 1535, 70, 762, 300, 'Armored Snowy Gryphon' },
    { 61230, 690, 1535, 70, 762, 300, 'Armored Blue Wind Rider' },
    { 61294, 1791, 1535, 70, 762, 300, 'Green Proto-Drake' },
    { 61425, 1101, 1535, 40, 762, 150, 'Travelers Tundra Mammoth' },
    { 61447, 690, 1535, 40, 762, 150, 'Travelers Tundra Mammoth' },
    { 61465, 1101, 1535, 40, 762, 150, 'Grand Black War Mammoth' },
    { 61467, 690, 1535, 40, 762, 150, 'Grand Black War Mammoth' },
    { 61469, 690, 1535, 40, 762, 150, 'Grand Ice Mammoth' },
    { 61470, 1101, 1535, 40, 762, 150, 'Grand Ice Mammoth' },
    { 61996, 1791, 1535, 70, 762, 300, 'Blue Dragonhawk' },
    { 61997, 1791, 1535, 70, 762, 300, 'Red Dragonhawk' },
    { 63232, 1101, 1535, 40, 762, 150, 'Stormwind Steed' },
    { 63635, 690, 1535, 40, 762, 150, 'Darkspear Raptor' },
    { 63636, 1101, 1535, 40, 762, 150, 'Ironforge Ram' },
    { 63637, 1101, 1535, 40, 762, 150, 'Darnassian Nightsaber' },
    { 63638, 1101, 1535, 40, 762, 150, 'Gnomeregan Mechanostrider' },
    { 63639, 1101, 1535, 40, 762, 150, 'Exodar Elekk' },
    { 63640, 690, 1535, 40, 762, 150, 'Orgrimmar Wolf' },
    { 63641, 690, 1535, 40, 762, 150, 'Thunder Bluff Kodo' },
    { 63642, 690, 1535, 40, 762, 150, 'Silvermoon Hawkstrider' },
    { 63643, 690, 1535, 40, 762, 150, 'Forsaken Warhorse' },
    { 63796, 1791, 1535, 70, 762, 300, 'Mimirons Head' },
    { 63844, 1791, 1535, 70, 762, 300, 'Argent Hippogryph' },
    { 63956, 1791, 1535, 70, 762, 300, 'Ironbound Proto-Drake' },
    { 63963, 1791, 1535, 70, 762, 300, 'Rusted Proto-Drake' },
    { 64657, 690, 1535, 20, 762, 75, 'White Kodo' },
    { 64658, 690, 1535, 20, 762, 75, 'Black Wolf' },
    { 64659, 690, 1535, 40, 762, 75, 'Venomhide Ravasaur' },
    { 64731, 1791, 1535, 0, 762, 75, 'Sea Turtle' },
    { 64927, 1791, 1535, 70, 762, 300, 'Deadly Gladiators Frost Wyrm' },
    { 64977, 690, 1535, 20, 762, 75, 'Black Skeletal Horse' },
    { 65439, 1791, 1535, 70, 762, 300, 'Furious Gladiators Frost Wyrm' },
    { 65637, 1101, 1535, 40, 762, 150, 'Great Red Elekk' },
    { 65638, 1101, 1535, 40, 762, 150, 'Swift Moonsaber' },
    { 65639, 690, 1535, 40, 762, 150, 'Swift Red Hawkstrider' },
    { 65640, 1101, 1535, 40, 762, 150, 'Swift Gray Steed' },
    { 65641, 690, 1535, 40, 762, 150, 'Great Golden Kodo' },
    { 65642, 1101, 1535, 40, 762, 150, 'Turbostrider' },
    { 65643, 1101, 1535, 40, 762, 150, 'Swift Violet Ram' },
    { 65644, 690, 1535, 40, 762, 150, 'Swift Purple Raptor' },
    { 65645, 690, 1535, 40, 762, 150, 'White Skeletal Warhorse' },
    { 65646, 690, 1535, 40, 762, 150, 'Swift Burgundy Wolf' },
    { 65917, 1791, 1535, 40, 762, 150, 'Magic Rooster' },
    { 66087, 1791, 1535, 70, 762, 300, 'Silver Covenant Hippogryph' },
    { 66088, 1791, 1535, 70, 762, 300, 'Sunreaver Dragonhawk' },
    { 66090, 1101, 1535, 40, 762, 150, 'Queldorei Steed' },
    { 66091, 690, 1535, 40, 762, 150, 'Sunreaver Hawkstrider' },
    { 66846, 690, 1535, 40, 762, 150, 'Ochre Skeletal Warhorse' },
    { 66847, 1101, 1535, 20, 762, 75, 'Striped Dawnsaber' },
    { 66906, 1791, 2, 40, 762, 150, 'Argent Charger' },
    { 67336, 1791, 1535, 70, 762, 300, 'Relentless Gladiators Frost Wyrm' },
    { 67466, 1791, 1535, 40, 762, 150, 'Argent Warhorse' },
    { 68056, 690, 1535, 40, 762, 150, 'Swift Horde Wolf' },
    { 68057, 1101, 1535, 40, 762, 150, 'Swift Alliance Steed' },
    { 68187, 1101, 1535, 40, 762, 150, 'Crusaders White Warhorse' },
    { 68188, 690, 1535, 40, 762, 150, 'Crusaders Black Warhorse' },
    { 69395, 1791, 1535, 70, 762, 300, 'Onyxian Drake' },
    { 71342, 1791, 1535, 80, 762, 150, 'Big Love Rocket' },
    { 71810, 1791, 1535, 70, 762, 300, 'Wrathful Gladiators Frost Wyrm' },
    { 72286, 1791, 1535, 20, 762, 75, 'Invincible' },
    { 72807, 1791, 1535, 70, 762, 300, 'Icebound Frostbrood Vanquisher' },
    { 72808, 1791, 1535, 70, 762, 300, 'Bloodbathed Frostbrood Vanquisher' },
    { 73313, 1791, 1535, 20, 762, 75, 'Crimson Deathcharger' },
    { 74856, 1791, 1535, 60, 762, 225, 'Blazing Hippogryph' },
    { 74918, 1791, 1535, 40, 762, 150, 'Wooly White Rhino' },
    { 75614, 1791, 1535, 20, 762, 75, 'Celestial Steed' },
    { 75973, 1791, 1535, 60, 762, 225, 'X-53 Touring Rocket' },
}

local FactionSpecificMounts = {
    { 458, 'Brown Horse', 6654, 'Brown Wolf' },
    { 470, 'Black Stallion', 64658, 'Black Wolf' },
    { 472, 'Pinto', 580, 'Timber Wolf' },
    { 6648, 'Chestnut Mare', 6653, 'Dire Wolf' },
    { 6777, 'Gray Ram', 8395, 'Emerald Raptor' },
    { 6898, 'White Ram', 10796, 'Turquoise Raptor' },
    { 6899, 'Brown Ram', 10799, 'Violet Raptor' },
    { 8394, 'Striped Frostsaber', 64977, 'Black Skeletal Horse' },
    { 10789, 'Spotted Frostsaber', 17464, 'Brown Skeletal Horse' },
    { 10793, 'Striped Nightsaber', 17463, 'Blue Skeletal Horse' },
    { 10873, 'Red Mechanostrider', 64657, 'White Kodo' },
    { 10969, 'Blue Mechanostrider', 35020, 'Blue Hawkstrider' },
    { 15779, 'White Mechanostrider Mod B', 18992, 'Teal Kodo' },
    { 16082, 'Palomino', 16080, 'Red Wolf' },
    { 16083, 'White Stallion', 16081, 'Winter Wolf' },
    { 17229, 'Winterspring Frostsaber', 64659, 'Venomhide Ravasaur' },
    { 17453, 'Green Mechanostrider', 18989, 'Gray Kodo' },
    { 17459, 'Icy Blue Mechanostrider Mod A', 18991, 'Green Kodo' },
    { 17460, 'Frost Ram', 17450, 'Ivory Raptor' },
    { 17461, 'Black Ram', 16084, 'Mottled Red Raptor' },
    { 22717, 'Black War Steed', 22724, 'Black War Wolf' },
    { 22719, 'Black Battlestrider', 22718, 'Black War Kodo' },
    { 22720, 'Black War Ram', 22721, 'Black War Raptor' },
    { 22723, 'Black War Tiger', 22722, 'Red Skeletal Warhorse' },
    { 23219, 'Swift Mistsaber', 23246, 'Purple Skeletal Warhorse' },
    { 23221, 'Swift Frostsaber', 66846, 'Ochre Skeletal Warhorse' },
    { 23222, 'Swift Yellow Mechanostrider', 23247, 'Great White Kodo' },
    { 23223, 'Swift White Mechanostrider', 23248, 'Great Gray Kodo' },
    { 23225, 'Swift Green Mechanostrider', 23249, 'Great Brown Kodo' },
    { 23227, 'Swift Palomino', 23251, 'Swift Timber Wolf' },
    { 23228, 'Swift White Steed', 23252, 'Swift Gray Wolf' },
    { 23229, 'Swift Brown Steed', 23250, 'Swift Brown Wolf' },
    { 23238, 'Swift Brown Ram', 23243, 'Swift Orange Raptor' },
    { 23239, 'Swift Gray Ram', 23241, 'Swift Blue Raptor' },
    { 23240, 'Swift White Ram', 23242, 'Swift Olive Raptor' },
    { 23338, 'Swift Stormsaber', 17465, 'Green Skeletal Warhorse' },
    { 23510, 'Stormpike Battle Charger', 23509, 'Frostwolf Howler' },
    { 32235, 'Golden Gryphon', 32245, 'Green Wind Rider' },
    { 32239, 'Ebon Gryphon', 32243, 'Tawny Wind Rider' },
    { 32240, 'Snowy Gryphon', 32244, 'Blue Wind Rider' },
    { 32242, 'Swift Blue Gryphon', 32296, 'Swift Yellow Wind Rider' },
    { 32289, 'Swift Red Gryphon', 32246, 'Swift Red Wind Rider' },
    { 32290, 'Swift Green Gryphon', 32295, 'Swift Green Wind Rider' },
    { 32292, 'Swift Purple Gryphon', 32297, 'Swift Purple Wind Rider' },
    { 34406, 'Brown Elekk', 35022, 'Black Hawkstrider' },
    { 35710, 'Gray Elekk', 34795, 'Red Hawkstrider' },
    { 35711, 'Purple Elekk', 35018, 'Purple Hawkstrider' },
    { 35712, 'Great Green Elekk', 35027, 'Swift Purple Hawkstrider' },
    { 35713, 'Great Blue Elekk', 35025, 'Swift Green Hawkstrider' },
    { 35714, 'Great Purple Elekk', 33660, 'Swift Pink Hawkstrider' },
    { 48027, 'Black War Elekk', 35028, 'Swift Warstrider' },
    { 59785, 'Black War Mammoth', 59788, 'Black War Mammoth' },
    { 59791, 'Wooly Mammoth', 59793, 'Wooly Mammoth' },
    { 59799, 'Ice Mammoth', 59797, 'Ice Mammoth' },
    { 60114, 'Armored Brown Bear', 60116, 'Armored Brown Bear' },
    { 60118, 'Black War Bear', 60119, 'Black War Bear' },
    { 60424, 'Mekgineers Chopper', 55531, 'Mechano-hog' },
    { 61229, 'Armored Snowy Gryphon', 61230, 'Armored Blue Wind Rider' },
    { 61425, 'Travelers Tundra Mammoth', 61447, 'Travelers Tundra Mammoth' },
    { 61470, 'Grand Ice Mammoth', 61469, 'Grand Ice Mammoth' },
    { 61996, 'Blue Dragonhawk', 61997, 'Red Dragonhawk' },
    { 63232, 'Stormwind Steed', 63640, 'Orgrimmar Wolf' },
    { 63636, 'Ironforge Ram', 63635, 'Darkspear Raptor' },
    { 63637, 'Darnassian Nightsaber', 63643, 'Forsaken Warhorse' },
    { 63638, 'Gnomeregan Mechanostrider', 63641, 'Thunder Bluff Kodo' },
    { 63639, 'Exodar Elekk', 63642, 'Silvermoon Hawkstrider' },
    { 65637, 'Great Red Elekk', 65639, 'Swift Red Hawkstrider' },
    { 65638, 'Swift Moonsaber', 65645, 'White Skeletal Warhorse' },
    { 65640, 'Swift Gray Steed', 65646, 'Swift Burgundy Wolf' },
    { 65642, 'Turbostrider', 65641, 'Great Golden Kodo' },
    { 65643, 'Swift Violet Ram', 65644, 'Swift Purple Raptor' },
    { 66087, 'Silver Covenant Hippogryph', 66088, 'Sunreaver Dragonhawk' },
    { 66090, 'Queldorei Steed', 66091, 'Sunreaver Hawkstrider' },
    { 66847, 'Striped Dawnsaber', 17462, 'Red Skeletal Horse' },
    { 68057, 'Swift Alliance Steed', 68056, 'Swift Horde Wolf' },
    { 68187, 'Crusaders White Warhorse', 68188, 'Crusaders Black Warhorse' },
}

function Player:SaveBoundCompanion(spellId)
    local count = 0
    for _ in pairs(Companions) do count = count + 1 end

    for i=1, count do
        local SpellId = Companions[i][1]

        if (SpellId == spellId) then
            local AccountId = self:GetAccountId()
            local AllowableRace = Companions[i][2]
            local Comment = Companions[i][3]

            local count = 0
            for _ in pairs(FactionSpecificCompanions) do count = count + 1 end

            for i=1, count do
                local AllianceId = FactionSpecificCompanions[i][1]
                local AllianceComment = FactionSpecificCompanions[i][2]
                local HordeId = FactionSpecificCompanions[i][3]
                local HordeComment = FactionSpecificCompanions[i][4]

                if (AllianceId == spellId or HordeId == spellId) then
                    AuthDBQuery('REPLACE INTO `'..Config.Database..'`.`account_bound_companions` (`account_id`, `spell_id`, `allowable_race`, `comment`) VALUES ('..AccountId..', '..AllianceId..', 1101, \''..AllianceComment..'\'), ('..AccountId..', '..HordeId..', 690, \''..HordeComment..'\');')
                    return
                end
            end

            AuthDBQuery('REPLACE INTO `'..Config.Database..'`.`account_bound_companions` (`account_id`, `spell_id`, `allowable_race`, `comment`) VALUES ('..AccountId..', '..SpellId..', '..AllowableRace..', \''..Comment..'\');')
            return
        end
    end
end

function Player:LearnBoundCompanions()
    local AccountId = self:GetAccountId()
    local RaceMask = self:GetRaceMask()
    local BoundCompanions = AuthDBQuery('SELECT `spell_id` FROM `'..Config.Database..'`.`account_bound_companions` WHERE `account_id` = '..AccountId..' AND `allowable_race` & '..RaceMask..';')

    if (BoundCompanions ~= nil) then
        repeat
            local companionData = BoundCompanions:GetRow()
            local spellId = companionData['spell_id']

            if not (self:HasSpell(spellId)) then
                self:LearnSpell(spellId)
            end
        until not BoundCompanions:NextRow();
    end
end

function Player:SaveBoundMount(spellId)
    local count = 0
    for _ in pairs(Mounts) do count = count + 1 end

    for i=1, count do
        local SpellId = Mounts[i][1]

        if (SpellId == spellId) then
            local AccountId = self:GetAccountId()
            local AllowableRace = Mounts[i][2]
            local AllowableClass = Mounts[i][3]
            local RequiredLevel = Mounts[i][4]
            local RequiredSkill = Mounts[i][5]
            local RequiredSkillLevel = Mounts[i][6]
            local Comment = Mounts[i][7]

            local count = 0
            for _ in pairs(FactionSpecificMounts) do count = count + 1 end

            for i=1, count do
                local AllianceId = FactionSpecificMounts[i][1]
                local HordeId = FactionSpecificMounts[i][3]

                if (AllianceId == spellId or HordeId == spellId) then
                    local AllianceComment = FactionSpecificMounts[i][2]
                    local HordeComment = FactionSpecificMounts[i][4]

                    AuthDBQuery('REPLACE INTO `'..Config.Database..'`.`account_bound_mounts` (`account_id`, `spell_id`, `allowable_race`, `allowable_class`, `required_level`, `required_skill`, `required_skill_rank`, `comment`) VALUES ('..AccountId..', '..AllianceId..', 1101, '..AllowableClass..', '..RequiredLevel..', '..RequiredSkill..', '..RequiredSkillLevel..', \''..AllianceComment..'\'), ('..AccountId..', '..HordeId..', 690, '..AllowableClass..', '..RequiredLevel..', '..RequiredSkill..', '..RequiredSkillLevel..', \''..HordeComment..'\');')
                    return
                end
            end

            AuthDBQuery('REPLACE INTO `'..Config.Database..'`.`account_bound_mounts` (`account_id`, `spell_id`, `allowable_race`, `allowable_class`, `required_level`, `required_skill`, `required_skill_rank`, `comment`) VALUES ('..AccountId..', '..SpellId..', '..AllowableRace..', '..AllowableClass..', '..RequiredLevel..', '..RequiredSkill..', '..RequiredSkillLevel..', \''..Comment..'\');')
            return
        end
    end
end

function Player:LearnBoundMounts()
    local AccountId = self:GetAccountId()
    local RaceMask = self:GetRaceMask()
    local ClassMask = self:GetClassMask()
    local Level = self:GetLevel()
    local BoundMounts = AuthDBQuery('SELECT `spell_id`, `required_skill`, `required_skill_rank` FROM `'..Config.Database..'`.`account_bound_mounts` WHERE `account_id` = '..AccountId..' AND `allowable_race` & '..RaceMask..' AND `allowable_class` & '..ClassMask..' AND `required_level` <= '..Level..';')

    if (BoundMounts ~= nil) then
        repeat
            local MountData = BoundMounts:GetRow()
            local SpellId = MountData['spell_id']
            local RequiredSkill = MountData['required_skill']
            local RequiredSkillRank = MountData['required_skill_rank']

            if (self:HasSkill(RequiredSkill) and self:GetPureSkillValue(RequiredSkill) >= RequiredSkillRank) then
                if not (self:HasSpell(SpellId)) then
                    self:LearnSpell(SpellId)
                end
            end
        until not BoundMounts:NextRow();
    end
end

local function OnLearnSpell(event, player, spellId)
    if (player:GetGMRank() == 0 or Config.EnableGamemaster) then
        if (Config.EnableCompanions) then
            player:SaveBoundCompanion(spellId)
        end

        if (Config.EnableMounts) then
            player:SaveBoundMount(spellId)
        end
    end
end
RegisterPlayerEvent(Event.OnLearnSpell, OnLearnSpell)

local function OnLogin(event, player)
    if (player:GetGMRank() == 0 or Config.EnableGamemaster) then
        if (Config.EnableCompanions) then
            player:LearnBoundCompanions()
        end

        if (Config.EnableMounts) then
            player:LearnBoundMounts()
        end
    end
end
RegisterPlayerEvent(Event.OnLogin, OnLogin)
