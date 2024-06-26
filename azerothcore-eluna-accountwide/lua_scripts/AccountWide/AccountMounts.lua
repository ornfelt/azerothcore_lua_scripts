-- ---------------------------------------------------------------------------------------------
-- ACCOUNTWIDE MOUNTS CONFIG
--
-- Hosted by Aldori15 on Github: https://github.com/Aldori15/azerothcore-lua-accountwide
-- Credits to Dinkledork for the original script with the 396 original wotlk mounts.
-- It has been since expanded further with the addition of the exotic import mounts.
------------------------------------------------------------------------------------------------

local ENABLE_ACCOUNTWIDE_MOUNTS = false

local ANNOUNCE_ON_LOGIN = true
local ANNOUNCEMENT = "This server is running the |cFF00B0E8AccountWide Mounts |rlua script."

local WhenPLayerLevel = 11  -- Minimum character level before mounts are learned
local StrictFactions = false  -- Disallow learning mounts from opposing faction

------------------------------------------------------------------------------------------------
-- END CONFIG
------------------------------------------------------------------------------------------------

if not ENABLE_ACCOUNTWIDE_MOUNTS then
    return
end

local FILE_NAME = string.match(debug.getinfo(1,'S').source, "[^/\\]*.lua$")

-- [spellID] = { ridingSkillRank, class, team+1, extraSkillId, extraSkillRank }
-- this list contains every single mount in wotlk (version 3.3.5.12340) (396 total) + a ton of custom imported mounts
local mount_listing = {
    [458] = {75,0,1,0,0}, -- Brown Horse
    [470] = {75,0,1,0,0}, -- Black Stallion
    [472] = {75,0,1,0,0}, -- Pinto
    [580] = {75,0,2,0,0}, -- Timber Wolf
    [3363] = {300,0,0,0,0}, -- Nether Drake
    [6648] = {75,0,1,0,0}, -- Chestnut Mare
    [6653] = {75,0,2,0,0}, -- Dire Wolf
    [6654] = {75,0,2,0,0}, -- Brown Wolf
    [6777] = {75,0,1,0,0}, -- Gray Ram
    [6898] = {75,0,1,0,0}, -- White Ram
    [6899] = {75,0,1,0,0}, -- Brown Ram
    [8394] = {75,0,1,0,0}, -- Striped Frostsaber
    [8395] = {75,0,2,0,0}, -- Emerald Raptor
    [8396] = {0,0,0,0,0}, -- Summon Ivory Tallstrider
    [10789] = {75,0,1,0,0}, -- Spotted Frostsaber
    [10793] = {75,0,1,0,0}, -- Striped Nightsaber
    [10796] = {75,0,2,0,0}, -- Turquoise Raptor
    [10799] = {75,0,2,0,0}, -- Violet Raptor
    [10800] = {0,0,0,0,0}, -- Summon Brown Tallstrider
    [10801] = {0,0,0,0,0}, -- Summon Gray Tallstrider
    [10802] = {0,0,0,0,0}, -- Summon Pink Tallstrider
    [10803] = {0,0,0,0,0}, -- Summon Purple Tallstrider
    [10804] = {0,0,0,0,0}, -- Summon Turquoise Tallstrider
    [10873] = {75,0,1,0,0}, -- Red Mechanostrider
    [10969] = {75,0,1,0,0}, -- Blue Mechanostrider
    [15779] = {150,0,1,0,0}, -- White Mechanostrider Mod B
    [15780] = {75,0,1,0,0}, -- Green Mechanostrider
    [15781] = {75,0,1,0,0}, -- Steel Mechanostrider
    [16055] = {150,0,1,0,0}, -- Black Nightsaber
    [16056] = {150,0,1,0,0}, -- Ancient Frostsaber
    [16058] = {75,0,1,0,0}, -- Primal Leopard
    [16059] = {75,0,1,0,0}, -- Tawny Sabercat
    [16060] = {75,0,1,0,0}, -- Golden Sabercat
    [16080] = {150,0,2,0,0}, -- Red Wolf
    [16081] = {150,0,2,0,0}, -- Winter Wolf
    [16082] = {150,0,1,0,0}, -- Palomino
    [16083] = {150,0,1,0,0}, -- White Stallion
    [16084] = {150,0,2,0,0}, -- Mottled Red Raptor
    [17229] = {150,0,1,0,0}, -- Winterspring Frostsaber
    [17450] = {150,0,2,0,0}, -- Ivory Raptor
    [17453] = {75,0,1,0,0}, -- Green Mechanostrider
    [17454] = {75,0,1,0,0}, -- Unpainted Mechanostrider
    [17455] = {75,0,1,0,0}, -- Purple Mechanostrider
    [17456] = {75,0,1,0,0}, -- Red and Blue Mechanostrider
    [17459] = {150,0,1,0,0}, -- Icy Blue Mechanostrider Mod A
    [17460] = {150,0,1,0,0}, -- Frost Ram
    [17461] = {150,0,1,0,0}, -- Black Ram
    [17462] = {75,0,2,0,0}, -- Red Skeletal Horse
    [17463] = {75,0,2,0,0}, -- Blue Skeletal Horse
    [17464] = {75,0,2,0,0}, -- Brown Skeletal Horse
    [17465] = {150,0,2,0,0}, -- Green Skeletal Warhorse
    [17481] = {150,0,0,0,0}, -- Rivendare's Deathcharger
    [18363] = {75,0,0,0,0}, -- Riding Kodo
    [18989] = {75,0,2,0,0}, -- Gray Kodo
    [18990] = {75,0,2,0,0}, -- Brown Kodo
    [18991] = {150,0,2,0,0}, -- Green Kodo
    [18992] = {150,0,2,0,0}, -- Teal Kodo
    [22717] = {150,0,1,0,0}, -- Black War Steed
    [22718] = {150,0,2,0,0}, -- Black War Kodo
    [22719] = {150,0,1,0,0}, -- Black Battlestrider
    [22720] = {150,0,1,0,0}, -- Black War Ram
    [22721] = {150,0,2,0,0}, -- Black War Raptor
    [22722] = {150,0,2,0,0}, -- Red Skeletal Warhorse
    [22723] = {150,0,1,0,0}, -- Black War Tiger
    [22724] = {150,0,2,0,0}, -- Black War Wolf
    [23219] = {150,0,1,0,0}, -- Swift Mistsaber
    [23220] = {150,0,1,0,0}, -- Swift Dawnsaber
    [23221] = {150,0,1,0,0}, -- Swift Frostsaber
    [23222] = {150,0,1,0,0}, -- Swift Yellow Mechanostrider
    [23223] = {150,0,1,0,0}, -- Swift White Mechanostrider
    [23225] = {150,0,1,0,0}, -- Swift Green Mechanostrider
    [23227] = {150,0,1,0,0}, -- Swift Palomino
    [23228] = {150,0,1,0,0}, -- Swift White Steed
    [23229] = {150,0,1,0,0}, -- Swift Brown Steed
    [23238] = {150,0,1,0,0}, -- Swift Brown Ram
    [23239] = {150,0,1,0,0}, -- Swift Gray Ram
    [23240] = {150,0,1,0,0}, -- Swift White Ram
    [23241] = {150,0,2,0,0}, -- Swift Blue Raptor
    [23242] = {150,0,2,0,0}, -- Swift Olive Raptor
    [23243] = {150,0,2,0,0}, -- Swift Orange Raptor
    [23246] = {150,0,2,0,0}, -- Purple Skeletal Warhorse
    [23247] = {150,0,2,0,0}, -- Great White Kodo
    [23248] = {150,0,2,0,0}, -- Great Gray Kodo
    [23249] = {150,0,2,0,0}, -- Great Brown Kodo
    [23250] = {150,0,2,0,0}, -- Swift Brown Wolf
    [23251] = {150,0,2,0,0}, -- Swift Timber Wolf
    [23252] = {150,0,2,0,0}, -- Swift Gray Wolf
    [23338] = {150,0,1,0,0}, -- Swift Stormsaber
    [23509] = {150,0,0,0,0}, -- Frostwolf Howler
    [23510] = {150,0,0,0,0}, -- Stormpike Battle Charger
    [24242] = {150,0,0,0,0}, -- Swift Razzashi Raptor
    [24252] = {150,0,0,0,0}, -- Swift Zulian Tiger
    [24576] = {150,0,0,0,0}, -- Chromatic Mount
    [25675] = {75,0,0,0,0}, -- Reindeer
    [25858] = {75,0,0,0,0}, -- Reindeer
    [25859] = {150,0,0,0,0}, -- Reindeer
    [25863] = {150,0,0,0,0}, -- Black Qiraji Battle Tank
    [25953] = {150,0,0,0,0}, -- Blue Qiraji Battle Tank
    [26054] = {150,0,0,0,0}, -- Red Qiraji Battle Tank
    [26055] = {150,0,0,0,0}, -- Yellow Qiraji Battle Tank
    [26056] = {150,0,0,0,0}, -- Green Qiraji Battle Tank
    [26655] = {150,0,0,0,0}, -- Black Qiraji Battle Tank
    [26656] = {150,0,0,0,0}, -- Black Qiraji Battle Tank
    [28828] = {0,0,0,0,0}, -- Nether Drake
    [29059] = {150,0,0,0,0}, -- Naxxramas Deathcharger
    [30174] = {0,0,0,0,0}, -- Riding Turtle
    [31700] = {0,0,0,0,0}, -- Black Qiraji Battle Tank
    [31973] = {150,0,0,0,0}, -- Kessel's Elekk
    [32235] = {225,0,1,0,0}, -- Golden Gryphon
    [32239] = {225,0,1,0,0}, -- Ebon Gryphon
    [32240] = {225,0,1,0,0}, -- Snowy Gryphon
    [32242] = {300,0,1,0,0}, -- Swift Blue Gryphon
    [32243] = {225,0,2,0,0}, -- Tawny Wind Rider
    [32244] = {225,0,2,0,0}, -- Blue Wind Rider
    [32245] = {225,0,2,0,0}, -- Green Wind Rider
    [32246] = {300,0,2,0,0}, -- Swift Red Wind Rider
    [32289] = {300,0,1,0,0}, -- Swift Red Gryphon
    [32290] = {300,0,1,0,0}, -- Swift Green Gryphon
    [32292] = {300,0,1,0,0}, -- Swift Purple Gryphon
    [32295] = {300,0,2,0,0}, -- Swift Green Wind Rider
    [32296] = {300,0,2,0,0}, -- Swift Yellow Wind Rider
    [32297] = {300,0,2,0,0}, -- Swift Purple Wind Rider
    [32345] = {0,0,0,0,0}, -- Peep the Phoenix Mount
    [32420] = {0,0,0,0,0}, -- Old Crappy McWeakSauce
    [33630] = {75,0,1,0,0}, -- Blue Mechanostrider
    [33631] = {0,0,0,0,0}, -- Video Mount
    [33660] = {150,0,2,0,0}, -- Swift Pink Hawkstrider
    [34068] = {0,0,0,0,0}, -- Summon Dodostrider
    [34406] = {75,0,1,0,0}, -- Brown Elekk
    [34407] = {150,0,1,0,0}, -- Great Elite Elekk
    [34790] = {150,0,0,0,0}, -- Dark War Talbuk
    [34795] = {75,0,2,0,0}, -- Red Hawkstrider
    [34896] = {150,0,2,0,0}, -- Cobalt War Talbuk
    [34897] = {150,0,2,0,0}, -- White War Talbuk
    [34898] = {150,0,2,0,0}, -- Silver War Talbuk
    [34899] = {150,0,2,0,0}, -- Tan War Talbuk
    [35018] = {75,0,2,0,0}, -- Purple Hawkstrider
    [35020] = {75,0,2,0,0}, -- Blue Hawkstrider
    [35022] = {75,0,2,0,0}, -- Black Hawkstrider
    [35025] = {150,0,2,0,0}, -- Swift Green Hawkstrider
    [35027] = {150,0,2,0,0}, -- Swift Purple Hawkstrider
    [35028] = {150,0,2,0,0}, -- Swift Warstrider
    [35710] = {75,0,1,0,0}, -- Gray Elekk
    [35711] = {75,0,1,0,0}, -- Purple Elekk
    [35712] = {150,0,1,0,0}, -- Great Green Elekk
    [35713] = {150,0,1,0,0}, -- Great Blue Elekk
    [35714] = {150,0,1,0,0}, -- Great Purple Elekk
    [36702] = {150,0,0,0,0}, -- Fiery Warhorse
    [37015] = {300,0,0,0,0}, -- Swift Nether Drake
    [39315] = {150,0,2,0,0}, -- Cobalt Riding Talbuk
    [39316] = {150,0,0,0,0}, -- Dark Riding Talbuk
    [39317] = {150,0,2,0,0}, -- Silver Riding Talbuk
    [39318] = {150,0,2,0,0}, -- Tan Riding Talbuk
    [39319] = {150,0,2,0,0}, -- White Riding Talbuk
    [39450] = {150,0,0,0,0}, -- Tallstrider
    [39798] = {300,0,0,0,0}, -- Green Riding Nether Ray
    [39800] = {300,0,0,0,0}, -- Red Riding Nether Ray
    [39801] = {300,0,0,0,0}, -- Purple Riding Nether Ray
    [39802] = {300,0,0,0,0}, -- Silver Riding Nether Ray
    [39803] = {300,0,0,0,0}, -- Blue Riding Nether Ray
    [39910] = {150,0,0,0,0}, -- Riding Clefthoof
    [39949] = {300,0,0,0,0}, -- Mount (Test Anim)
    [40192] = {300,0,0,0,0}, -- Ashes of Al'ar
    [40212] = {300,0,0,0,0}, -- Dragonmaw Nether Drake
    [41252] = {150,0,0,0,0}, -- Raven Lord
    [41513] = {300,0,0,0,0}, -- Onyx Netherwing Drake
    [41514] = {300,0,0,0,0}, -- Azure Netherwing Drake
    [41515] = {300,0,0,0,0}, -- Cobalt Netherwing Drake
    [41516] = {300,0,0,0,0}, -- Purple Netherwing Drake
    [41517] = {300,0,0,0,0}, -- Veridian Netherwing Drake
    [41518] = {300,0,0,0,0}, -- Violet Netherwing Drake
    [42363] = {0,0,0,0,0}, -- Dan's Steam Tank Form
    [42387] = {0,0,0,0,0}, -- Dan's Steam Tank Form (Self)
    [42776] = {75,0,0,0,0}, -- Spectral Tiger
    [42777] = {150,0,0,0,0}, -- Swift Spectral Tiger
    [42929] = {75,0,0,0,0}, -- [DNT] Test Mount
    [43688] = {150,0,0,0,0}, -- Amani War Bear
    [43810] = {300,0,0,0,0}, -- Frost Wyrm
    [43880] = {0,0,0,0,0}, -- Ramstein's Swift Work Ram
    [43883] = {0,0,0,0,0}, -- Rental Racing Ram
    [43899] = {75,0,0,0,0}, -- Brewfest Ram
    [43900] = {150,0,0,0,0}, -- Swift Brewfest Ram
    [43927] = {300,0,0,0,0}, -- Cenarion War Hippogryph
    [44317] = {300,0,0,0,0}, -- Merciless Nether Drake
    [44655] = {300,0,0,0,0}, -- Flying Reindeer
    [44744] = {300,0,0,0,0}, -- Merciless Nether Drake
    [44824] = {225,0,0,0,0}, -- Flying Reindeer
    [44825] = {300,0,0,0,0}, -- Flying Reindeer
    [44827] = {300,0,0,0,0}, -- Flying Reindeer
    [45177] = {0,0,0,0,0}, -- Copy of Riding Turtle
    [46197] = {225,0,0,0,0}, -- X-51 Nether-Rocket
    [46199] = {300,0,0,0,0}, -- X-51 Nether-Rocket X-TREME
    [46628] = {150,0,0,0,0}, -- Swift White Hawkstrider
    [46980] = {150,0,0,0,0}, -- Northrend Nerubian Mount (Test)
    [47037] = {150,0,0,0,0}, -- Swift War  Elekk
    [48023] = {75,0,0,0,0}, -- Headless Horseman's Mount
    [48024] = {75,0,0,0,0}, -- Headless Horseman's Mount
    [48025] = {75,0,0,0,0}, -- Headless Horseman's Mount
    [48027] = {150,0,1,0,0}, -- Black War Elekk
    [48954] = {150,0,0,0,0}, -- Swift Zhevra
    [49193] = {300,0,0,0,0}, -- Vengeful Nether Drake
    [49322] = {150,0,0,0,0}, -- Swift Zhevra
    [49378] = {75,0,0,0,0}, -- Brewfest Riding Kodo
    [49379] = {150,0,0,0,0}, -- Great Brewfest Kodo
    [49908] = {0,0,0,0,0}, -- Pink Elekk
    [50281] = {150,0,1,0,0}, -- Black Warp Stalker
    [50869] = {75,0,0,0,0}, -- Brewfest Kodo
    [50870] = {75,0,0,0,0}, -- Brewfest Ram
    [51412] = {150,0,0,0,0}, -- Big Battle Bear
    [51617] = {75,0,0,0,0}, -- Headless Horseman's Mount
    [51621] = {75,0,0,0,0}, -- Headless Horseman's Mount
    [51960] = {300,0,0,0,0}, -- Frost Wyrm Mount
    [54753] = {150,0,0,0,0}, -- White Polar Bear
    [55164] = {300,0,0,0,0}, -- Swift Spectral Gryphon
    [55293] = {150,0,0,0,0}, -- Amani War Bear
    [55531] = {150,0,2,0,0}, -- Mechano-hog
    [58615] = {300,0,0,0,0}, -- Brutal Nether Drake
    [58819] = {150,0,1,0,0}, -- Swift Brown Steed
    [58983] = {75,0,0,0,0}, -- Big Blizzard Bear
    [58997] = {75,0,0,0,0}, -- Big Blizzard Bear
    [58999] = {75,0,0,0,0}, -- Big Blizzard Bear
    [59567] = {300,0,0,0,0}, -- Azure Drake
    [59568] = {300,0,0,0,0}, -- Blue Drake
    [59569] = {300,0,0,0,0}, -- Bronze Drake
    [59570] = {300,0,0,0,0}, -- Red Drake
    [59571] = {300,0,0,0,0}, -- Twilight Drake
    [59572] = {150,0,0,0,0}, -- Black Polar Bear
    [59573] = {150,0,0,0,0}, -- Brown Polar Bear
    [59650] = {300,0,0,0,0}, -- Black Drake
    [59785] = {150,0,1,0,0}, -- Black War Mammoth
    [59788] = {150,0,2,0,0}, -- Black War Mammoth
    [59791] = {150,0,1,0,0}, -- Wooly Mammoth
    [59793] = {150,0,2,0,0}, -- Wooly Mammoth
    [59797] = {150,0,2,0,0}, -- Ice Mammoth
    [59799] = {150,0,1,0,0}, -- Ice Mammoth
    [59802] = {150,0,0,0,0}, -- Grand Ice Mammoth
    [59804] = {150,0,0,0,0}, -- Grand Ice Mammoth
    [59961] = {300,0,0,0,0}, -- Red Proto-Drake
    [59976] = {300,0,0,0,0}, -- Black Proto-Drake
    [59996] = {300,0,0,0,0}, -- Blue Proto-Drake
    [60002] = {300,0,0,0,0}, -- Time-Lost Proto-Drake
    [60021] = {300,0,0,0,0}, -- Plagued Proto-Drake
    [60024] = {300,0,0,0,0}, -- Violet Proto-Drake
    [60025] = {300,0,0,0,0}, -- Albino Drake
    [60114] = {150,0,1,0,0}, -- Armored Brown Bear
    [60116] = {150,0,2,0,0}, -- Armored Brown Bear
    [60118] = {150,0,1,0,0}, -- Black War Bear
    [60119] = {150,0,2,0,0}, -- Black War Bear
    [60136] = {150,0,0,0,0}, -- Grand Caravan Mammoth
    [60140] = {150,0,0,0,0}, -- Grand Caravan Mammoth
    [60424] = {150,0,1,0,0}, -- Mekgineer's Chopper
    [61229] = {300,0,1,0,0}, -- Armored Snowy Gryphon
    [61230] = {300,0,2,0,0}, -- Armored Blue Wind Rider
    [61294] = {300,0,0,0,0}, -- Green Proto-Drake
    [61425] = {150,0,1,0,0}, -- Traveler's Tundra Mammoth (Alliance)
    [61447] = {150,0,2,0,0}, -- Traveler's Tundra Mammoth (Horde)
    [61465] = {150,0,1,0,0}, -- Grand Black War Mammoth
    [61467] = {150,0,2,0,0}, -- Grand Black War Mammoth
    [61469] = {150,0,2,0,0}, -- Grand Ice Mammoth
    [61470] = {150,0,1,0,0}, -- Grand Ice Mammoth
    [61983] = {150,0,0,0,0}, -- Dan's Test Mount
    [61996] = {300,0,0,0,0}, -- Blue Dragonhawk
    [61997] = {300,0,0,0,0}, -- Red Dragonhawk
    [62048] = {300,0,0,0,0}, -- Black Dragonhawk Mount
    [63232] = {150,0,1,0,0}, -- Stormwind Steed
    [63635] = {150,0,2,0,0}, -- Darkspear Raptor
    [63636] = {150,0,1,0,0}, -- Ironforge Ram
    [63637] = {150,0,1,0,0}, -- Darnassian Nightsaber
    [63638] = {150,0,1,0,0}, -- Gnomeregan Mechanostrider
    [63639] = {150,0,1,0,0}, -- Exodar Elekk
    [63640] = {150,0,2,0,0}, -- Orgrimmar Wolf
    [63641] = {150,0,2,0,0}, -- Thunder Bluff Kodo
    [63642] = {150,0,2,0,0}, -- Silvermoon Hawkstrider
    [63643] = {150,0,2,0,0}, -- Forsaken Warhorse
    [63796] = {300,0,0,0,0}, -- Mimiron's Head
    [63844] = {300,0,0,0,0}, -- Argent Hippogryph
    [63956] = {300,0,0,0,0}, -- Ironbound Proto-Drake
    [63963] = {300,0,0,0,0}, -- Rusted Proto-Drake
    [64656] = {150,0,2,0,0}, -- Blue Skeletal Warhorse
    [64657] = {75,0,2,0,0}, -- White Kodo
    [64658] = {75,0,2,0,0}, -- Black Wolf
    [64659] = {150,0,2,0,0}, -- Venomhide Ravasaur
    [64681] = {225,0,0,0,0}, -- Loaned Gryphon
    [64731] = {75,0,0,0,0}, -- Sea Turtle
    [64761] = {225,0,0,0,0}, -- Loaned Wind Rider
    [64927] = {300,0,0,0,0}, -- Deadly Gladiator's Frost Wyrm
    [64977] = {75,0,2,0,0}, -- Black Skeletal Horse
    [64992] = {75,0,0,0,0}, -- Big Blizzard Bear [PH]
    [64993] = {75,0,0,0,0}, -- Big Blizzard Bear [PH]
    [65439] = {300,0,0,0,0}, -- Furious Gladiator's Frost Wyrm
    [65637] = {150,0,1,0,0}, -- Great Red Elekk
    [65638] = {150,0,1,0,0}, -- Swift Moonsaber
    [65639] = {150,0,2,0,0}, -- Swift Red Hawkstrider
    [65640] = {150,0,1,0,0}, -- Swift Gray Steed
    [65641] = {150,0,2,0,0}, -- Great Golden Kodo
    [65642] = {150,0,1,0,0}, -- Turbostrider
    [65643] = {150,0,1,0,0}, -- Swift Violet Ram
    [65644] = {150,0,2,0,0}, -- Swift Purple Raptor
    [65645] = {150,0,2,0,0}, -- White Skeletal Warhorse
    [65646] = {150,0,2,0,0}, -- Swift Burgundy Wolf
    [65917] = {150,0,0,0,0}, -- Magic Rooster
    [66087] = {300,0,0,0,0}, -- Silver Covenant Hippogryph
    [66088] = {300,0,0,0,0}, -- Sunreaver Dragonhawk
    [66090] = {150,0,1,0,0}, -- Quel'dorei Steed
    [66091] = {150,0,2,0,0}, -- Sunreaver Hawkstrider
    [66122] = {150,0,0,0,0}, -- Magic Rooster
    [66123] = {150,0,0,0,0}, -- Magic Rooster
    [66124] = {150,0,0,0,0}, -- Magic Rooster
    [66846] = {150,0,2,0,0}, -- Ochre Skeletal Warhorse
    [66847] = {75,0,1,0,0}, -- Striped Dawnsaber
    [67336] = {300,0,0,0,0}, -- Relentless Gladiator's Frost Wyrm
    [67466] = {150,0,0,0,0}, -- Argent Warhorse
    [68056] = {150,0,2,0,0}, -- Swift Horde Wolf
    [68057] = {150,0,1,0,0}, -- Swift Alliance Steed
    [68187] = {150,0,1,0,0}, -- Crusader's White Warhorse
    [68188] = {150,0,2,0,0}, -- Crusader's Black Warhorse
    [68768] = {0,0,1,0,0}, -- Little White Stallion
    [68769] = {0,0,2,0,0}, -- Little Ivory Raptor
    [69395] = {300,0,0,0,0}, -- Onyxian Drake
    [71342] = {150,0,0,0,0}, -- Big Love Rocket
    [71343] = {150,0,0,0,0}, -- Big Love Rocket
    [71344] = {75,0,0,0,0}, -- Big Love Rocket
    [71345] = {150,0,0,0,0}, -- Big Love Rocket
    [71346] = {150,0,0,0,0}, -- Big Love Rocket
    [71347] = {150,0,0,0,0}, -- Big Love Rocket
    [71810] = {300,0,0,0,0}, -- Wrathful Gladiator's Frost Wyrm
    [72281] = {75,0,0,0,0}, -- Invincible
    [72282] = {75,0,0,0,0}, -- Invincible
    [72283] = {75,0,0,0,0}, -- Invincible
    [72284] = {75,0,0,0,0}, -- Invincible
    [72286] = {75,0,0,0,0}, -- Invincible
    [72807] = {300,0,0,0,0}, -- Icebound Frostbrood Vanquisher
    [72808] = {300,0,0,0,0}, -- Bloodbathed Frostbrood Vanquisher
    [74854] = {225,0,0,0,0}, -- Blazing Hippogryph
    [74855] = {300,0,0,0,0}, -- Blazing Hippogryph
    [74856] = {225,0,0,0,0}, -- Blazing Hippogryph
    [74918] = {150,0,0,0,0}, -- Wooly White Rhino
    [75614] = {75,0,0,0,0}, -- Celestial Steed
    [75617] = {75,0,0,0,0}, -- Celestial Steed
    [75618] = {75,0,0,0,0}, -- Celestial Steed
    [75619] = {75,0,0,0,0}, -- Celestial Steed
    [75620] = {75,0,0,0,0}, -- Celestial Steed
    [75957] = {225,0,0,0,0}, -- X-53 Touring Rocket
    [75972] = {225,0,0,0,0}, -- X-53 Touring Rocket
    [75973] = {225,0,0,0,0}, -- X-53 Touring Rocket
    [76153] = {75,0,0,0,0}, -- Celestial Steed
    [76154] = {225,0,0,0,0}, -- X-53 Touring Rocket
    [10792] = {75,0,0,0,0}, -- Spotted Panther
    [17458] = {75,0,0,0,0}, -- Fluorescent Green Mechanostrider

    -- class mounts
    [66906] = {150,2,0,0,0}, -- Argent Charger
    [66907] = {75,2,0,0,0}, -- Argent Warhorse
    [13819] = {75,2,1,0,0}, -- Warhorse
    [23214] = {150,2,1,0,0}, -- Charger
    [34769] = {75,2,2,0,0}, -- Summon Warhorse
    [34767] = {150,2,2,0,0}, -- Summon Charger
    [48778] = {150,6,0,0,0}, -- Acherus Deathcharger
    [54726] = {225,6,0,0,0}, -- Winged Steed of the Ebon Blade
    [54727] = {300,6,0,0,0}, -- Winged Steed of the Ebon Blade
    [54729] = {225,6,0,0,0}, -- Winged Steed of the Ebon Blade
    [73313] = {150,6,0,0,0}, -- Crimson Deathcharger
    [23161] = {150,9,0,0,0}, -- Dreadsteed
    [5784] = {75,9,0,0,0}, -- Felsteed

    -- profession mounts
    [75387] = {300,0,0,197,425}, -- Tiny Mooncloth Carpet
    [75596] = {300,0,0,197,425}, -- Frosty Flying Carpet
    [61451] = {225,0,0,197,300}, -- Flying Carpet
    [61442] = {300,0,0,197,450}, -- Swift Mooncloth Carpet
    [61444] = {300,0,0,197,450}, -- Swift Shadoweave Carpet
    [61446] = {300,0,0,197,450}, -- Swift Spellfire Carpet
    [61309] = {300,0,0,197,425}, -- Magnificent Flying Carpet
    [44151] = {300,0,0,202,375}, -- Turbo-Charged Flying Machine
    [44153] = {225,0,0,202,300}, -- Flying Machine

    -- old vanilla faction mounts, used to need special skills
    -- A: Horse Riding (148), Tiger Riding (150), Ram Riding(152)
    -- H: Wolf Riding (149), Raptor Riding (533), Undead Horsemanship (554)
    -- req can probably be safely ignored
    [459] = {75,0,2,149,1}, -- Gray Wolf
    [468] = {75,0,1,148,1}, -- White Stallion
    [471] = {75,0,1,148,1}, -- Palamino
    [578] = {75,0,2,149,1}, -- Black Wolf
    [579] = {150,0,2,149,1}, -- Red Wolf
    [581] = {75,0,2,149,1}, -- Winter Wolf
    [6896] = {75,0,1,152,1}, -- Black Ram
    [6897] = {75,0,1,152,1}, -- Blue Ram
    [10788] = {75,0,1,150,1}, -- Leopard
    [10790] = {75,0,1,150,1}, -- Tiger
    [8980] = {75,0,2,554,1}, -- Skeletal Horse
    [10787] = {75,0,1,150,1}, -- Black Nightsaber
    [10795] = {75,0,2,533,1}, -- Ivory Raptor
    [10798] = {75,0,2,533,1}, -- Obsidian Raptor

    -- mounts from items with duration
    [42667] = {225,0,0,0,0}, -- Flying Broom
    [42668] = {300,0,0,0,0}, -- Swift Flying Broom
    [42680] = {75,0,0,0,0}, -- Magic Broom
    [42683] = {150,0,0,0,0}, -- Swift Magic Broom
    [42692] = {0,0,0,0,0}, -- Rickety Magic Broom
    [47977] = {300,0,0,0,0}, -- Magic Broom
    [61289] = {150,0,0,0,0}, -- Borrowed Broom

    -- Custom exotic imported mounts
    [100121] = {150,0,0,0,0}, -- Vicious War Fox
    [1700157] = {225,0,0,0,0}, -- WhimsyshireCloudMount_Angry
    [1700158] = {225,0,0,0,0}, -- WhimsyshireCloudMount_Frozen
    [1700159] = {225,0,0,0,0}, -- WhimsyshireCloudMount_Happy
    [1700160] = {225,0,0,0,0}, -- WhimsyshireCloudMount_Smiling
    [1700161] = {225,0,0,0,0}, -- WhimsyshireCloudMount_Sad
    [1700162] = {225,0,0,0,0}, -- WhimsyshireCloudMount_DBZ
    [1700000] = {150,0,0,0,0}, -- Felsaber
    [1700001] = {225,0,0,0,0}, -- Slayers Felbroken Shrieker
    [1700002] = {225,0,0,0,0}, -- Deathlords Vilebrood Vanquisher
    [1700003] = {225,0,0,0,0}, -- Reins of the Bloodbathed Frostbrood Vanquisher
    [1700004] = {225,0,0,0,0}, -- Reins of the Icebound Frostbrood Vanquisher
    [1700005] = {225,0,0,0,0}, -- Reins of the Scourgebound Vanquisher
    [1700006] = {225,0,0,0,0}, -- Trust of a Dire Wolfhawk
    [1700007] = {225,0,0,0,0}, -- Trust of a Fierce Wolfhawk
    [1700008] = {225,0,0,0,0}, -- Huntmasters Loyal Wolfhawk
    [1700009] = {225,0,0,0,0}, -- Archmages Prismatic Disc Arcane
    [1700010] = {225,0,0,0,0}, -- Archmages Prismatic Disc Fire
    [1700011] = {225,0,0,0,0}, -- Archmages Prismatic Disc Frost
    [1700012] = {150,0,0,0,0}, -- Ban-Lu, Grandmasters Companion
    [1700013] = {150,0,0,0,0}, -- Highlords Golden Charger
    [1700014] = {150,0,0,0,0}, -- Highlords Vigilant Charger
    [1700015] = {150,0,0,0,0}, -- Highlords Vengefull Charger
    [1700016] = {150,0,0,0,0}, -- Highlords Valorous Charger
    [1700017] = {225,0,0,0,0}, -- High Priests Lightsworn Seeker Discipline
    [1700018] = {225,0,0,0,0}, -- High Priests Lightsworn Seeker Holy
    [1700019] = {225,0,0,0,0}, -- High Priests Lightsworn Seeker Shadow
    [1700020] = {225,0,0,0,0}, -- Shadowblades Murderous Omen
    [1700021] = {225,0,0,0,0}, -- Mephitic Reins of Dark Portent
    [1700022] = {225,0,0,0,0}, -- Midnight Black Reins of Dark Portent
    [1700023] = {225,0,0,0,0}, -- Bloody Reins of Dark Portent
    [1700024] = {150,0,0,0,0}, -- Farseers Raging Tempest Elemental
    [1700025] = {150,0,0,0,0}, -- Farseers Raging Tempest Enhancement
    [1700026] = {150,0,0,0,0}, -- Farseers Raging Tempest Restoration
    [1700027] = {150,0,0,0,0}, -- Netherlords Chaotic Wrathsteed
    [1700028] = {150,0,0,0,0}, -- Hellblazing Reins of the Brimstone Wrathsteed
    [1700029] = {150,0,0,0,0}, -- Shadowy Reins of the Accursed Wrathsteed
    [1700030] = {225,0,0,0,0}, -- Battlelords Bloodthirsty War Wyrm Arms
    [1700031] = {225,0,0,0,0}, -- Battlelords Bloodthirsty War Wyrm Fury
    [1700032] = {225,0,0,0,0}, -- Battlelords Bloodthirsty War Wyrm Protection
    [1700033] = {150,0,0,0,0}, -- Reins of the Anduin War Charger
    [1700034] = {225,0,0,0,0}, -- Luminous Starseeker
    [1700035] = {225,0,0,0,0}, -- Honeyback Harvester
    [1700036] = {225,0,0,0,0}, -- Reins of the Dark Honeyback Harvester
    [1700037] = {225,0,0,0,0}, -- Reins of the Ruby Honeyback Harvester
    [1700038] = {150,0,0,0,0}, -- Reins of the Blue Bloodgorged Crawg
    [1700039] = {150,0,0,0,0}, -- Reins of the Dark Bloodgorged Crawg
    [1700040] = {150,0,0,0,0}, -- Reins of the Green Bloodgorged Crawg
    [1700041] = {150,0,0,0,0}, -- Reins of the Pale Bloodgorged Crawg
    [1700048] = {225,0,0,0,0}, -- Reins of the Astral Cloud Serpent
    [1700049] = {225,0,0,0,0}, -- Warforged Nightmare
    [1700050] = {225,0,0,0,0}, -- Disc of the Flying Cloud
    [1700051] = {225,0,0,0,0}, -- Disc of the Blue Flying Cloud
    [1700052] = {225,0,0,0,0}, -- Disc of the Purple Flying Cloud
    [1700053] = {225,0,0,0,0}, -- Disc of the Red Flying Cloud
    [1700054] = {150,0,0,0,0}, -- Grimhowls Face Axe
    [1700055] = {225,0,0,0,0}, -- Dark Phoenix
    [1700056] = {150,0,0,0,0}, -- Shu-Zen, the Divine Sentinel
    [1700057] = {150,0,0,0,0}, -- Dawnforge Ram
    [1700058] = {150,0,0,0,0}, -- Darkforge Ram
    [1700059] = {225,0,0,0,0}, -- Cloudwing Hippogryph
    [1700060] = {150,0,0,0,0}, -- Meat Wagon
    [1700061] = {225,0,0,0,0}, -- Sylverian Dreamer
    [1700062] = {150,0,0,0,0}, -- Vulpine Familiar
    [1700063] = {225,0,0,0,0}, -- Obsidian Worldbreaker
    [1700064] = {225,0,0,0,0}, -- Alabaster Stormtalon
    [1700065] = {225,0,0,0,0}, -- Alabaster Thunderwing
    [1700066] = {225,0,0,0,0}, -- Antoran Charhound
    [1700067] = {225,0,0,0,0}, -- Antoran Gloomhound
    [1700068] = {225,0,0,0,0}, -- Felsteel Annihilator
    [1700069] = {150,0,0,0,0}, -- Reins of the Illidari Felstalker
    [1700070] = {150,0,0,0,0}, -- Primal Felsaber
    [1700071] = {150,0,0,0,0}, -- Reins of the Llothien Prowler
    [1700072] = {225,0,0,0,0}, -- Mecha-Mogul Mk2
    [1700073] = {150,0,0,0,0}, -- Reins of the Dark Fabious Tidestallion
    [1700074] = {150,0,0,0,0}, -- Reins of the Green Fabious Tidestallion
    [1700075] = {150,0,0,0,0}, -- Reins of the Purple Fabious Tidestallion
    [1700076] = {150,0,0,0,0}, -- Reins of the Red Fabious Tidestallion
    [1700077] = {150,0,0,0,0}, -- Reins of the Pale Fabious Tidestallion
    [1700078] = {150,0,0,0,0}, -- Horn of the Vicious Black War Wolf
    [1700079] = {150,0,0,0,0}, -- Horn of the Vicious Green War Wolf
    [1700080] = {150,0,0,0,0}, -- Horn of the Vicious Orange War Wolf
    [1700081] = {150,0,0,0,0}, -- Horn of the Vicious Purple War Wolf
    [1700082] = {150,0,0,0,0}, -- Horn of the Vicious Red War Wolf
    [1700083] = {150,0,0,0,0}, -- Prestigious Midnight Courser
    [1700084] = {150,0,0,0,0}, -- Prestigious Forest Courser
    [1700085] = {150,0,0,0,0}, -- Prestigious Royal Courser
    [1700086] = {150,0,0,0,0}, -- Prestigious Azure Courser
    [1700087] = {150,0,0,0,0}, -- Prestigious Ivory Courser
    [1700088] = {150,0,0,0,0}, -- Prestigious Bronze Courser
    [1700089] = {150,0,0,0,0}, -- Prestigious Bloodforged Courser
    [1700090] = {225,0,0,0,0}, -- Xiwyllag ATV blue
    [1700091] = {225,0,0,0,0}, -- Xiwyllag ATV green
    [1700092] = {225,0,0,0,0}, -- Xiwyllag ATV
    [1700093] = {225,0,0,0,0}, -- Xiwyllag ATV red
    [1700094] = {225,0,0,0,0}, -- Reins of the Infinite Timereaver
    [1700095] = {150,0,0,0,0}, -- Ironhoof Destroyer
    [1700096] = {150,0,0,0,0}, -- Armored Irontusk
    [1700097] = {150,0,0,0,0}, -- Beastlords Warwolf
    [1700098] = {150,0,0,0,0}, -- Korkron Juggernaut Blue
    [1700099] = {150,0,0,0,0}, -- Korkron Juggernaut Gray
    [1700100] = {150,0,0,0,0}, -- Korkron Juggernaut Mint
    [1700101] = {150,0,0,0,0}, -- Korkron Juggernaut Yellow
    [1700102] = {225,0,0,0,0}, -- G.M.O.D.
    [1700103] = {150,0,0,0,0}, -- Cindermane Charger
    [1700104] = {150,0,0,0,0}, -- Blessed Felcrusher
    [1700105] = {150,0,0,0,0}, -- Avenging Felcrusher
    [1700106] = {150,0,0,0,0}, -- Lightforged Felcrusher
    [1700107] = {150,0,0,0,0}, -- Glorious Felcrusher
    [1700108] = {225,0,0,0,0}, -- Lightforged Warframe
    [1700109] = {150,0,0,0,0}, -- Mechacycle Model W Bronze
    [1700110] = {150,0,0,0,0}, -- Junkheap Drifter
    [1700111] = {150,0,0,0,0}, -- Mechacycle Model W Silver
    [1700112] = {225,0,0,0,0}, -- Smoldering Ember Wyrm
    [1700113] = {150,0,0,0,0}, -- Kaldorei Nightsaber
    [1700114] = {150,0,0,0,0}, -- Reins of the purple Kaldorei Nightsaber
    [1700115] = {150,0,0,0,0}, -- Umber Nightsaber
    [1700116] = {150,0,0,0,0}, -- Sandy Nightsaber
    [1700117] = {225,0,0,0,0}, -- Reins of the Heavenly Onyx Cloud Serpent
    [1700118] = {225,0,0,0,0}, -- Reins of the Heavenly Azure Cloud Serpent
    [1700119] = {225,0,0,0,0}, -- Yulei, Daughter of Jade
    [1700120] = {225,0,0,0,0}, -- Reins of the Heavenly Crimson Cloud Serpent
    [1700121] = {225,0,0,0,0}, -- Reins of the Heavenly Golden Cloud Serpent
    [1700122] = {225,0,0,0,0}, -- Reins of the Voldunai Dunescraper
    [1700123] = {225,0,0,0,0}, -- Dazaralor Windreaver
    [1700124] = {225,0,0,0,0}, -- Reins of the Armored Cobalt Pterrordax
    [1700125] = {225,0,0,0,0}, -- Reins of the Armored Purple Pterrordax
    [1700126] = {225,0,0,0,0}, -- Reins of the Scarlet Pterrordax
    [1700127] = {225,0,0,0,0}, -- Reins of the Armored Pale Pterrordax
    [1700128] = {150,0,0,0,0}, -- Ratstallion
    [1700130] = {150,0,0,0,0}, -- Priestess Moonsaber
    [1700131] = {225,0,0,0,0}, -- Ankoan Waveray
    [1700132] = {225,0,0,0,0}, -- Azshari Bloatray
    [1700133] = {225,0,0,0,0}, -- Silent Glider
    [1700134] = {225,0,0,0,0}, -- Unshackled Waveray
    [1700135] = {150,0,0,0,0}, -- Reins of the Bone Fossilized Raptor
    [1700136] = {150,0,0,0,0}, -- Reins of the Dark Fossilized Raptor
    [1700137] = {150,0,0,0,0}, -- Reins of the Fossilized Raptor
    [1700138] = {150,0,0,0,0}, -- Reins of the Ivory Fossilized Raptor
    [1700139] = {225,0,0,0,0}, -- The Dreadwake
    [1700140] = {150,0,0,0,0}, -- Deepcoral Snapdragon
    [1700141] = {150,0,0,0,0}, -- Royal Snapdragon
    [1700142] = {150,0,0,0,0}, -- Snapdragon Kelpstalker
    [1700143] = {225,0,0,0,0}, -- Shackled Urzul Blue
    [1700144] = {225,0,0,0,0}, -- Shackled Urzul Green
    [1700145] = {225,0,0,0,0}, -- Shackled Urzul Red
    [1700146] = {225,0,0,0,0}, -- Shackled Urzul Pale
    [1700147] = {150,0,0,0,0}, -- Bloodfang Cocoon
    [1700149] = {150,0,0,0,0}, -- Blue Marsh Hopper
    [1700150] = {150,0,0,0,0}, -- Green Marsh Hopper
    [1700151] = {150,0,0,0,0}, -- Yellow Marsh Hopper
    [1700152] = {150,0,0,0,0}, -- Reins of the Grand Expedition Yak
    [1700153] = {150,0,0,0,0}, -- Starcursed Voidstrider
    [1700154] = {150,0,0,0,0}, -- Glacial Tidestorm
    [1700155] = {150,0,0,0,0}, -- Glacial Tidestorm Purple
    [1700156] = {150,0,0,0,0}, -- Glacial Tidestorm Green
    [1700163] = {150,0,0,0,0}, -- Crusaders Direhorn
    [1700164] = {225,0,0,0,0}, -- Darkmoon Dirigible
    [1700165] = {150,0,0,0,0}, -- Champions Treadblade
    [1700166] = {150,0,0,0,0}, -- Reins of the Prestigious War Steed
    [1700167] = {150,0,0,0,0}, -- Reins of the Blue Vicious War Steed
    [1700168] = {150,0,0,0,0}, -- Reins of the Copper Vicious War Steed
    [1700169] = {150,0,0,0,0}, -- Reins of the Red Vicious War Steed
    [1700170] = {150,0,0,0,0}, -- Reins of the Silver Vicious War Steed
    [1700171] = {150,0,0,0,0}, -- Patties Cap
    [1700172] = {150,0,0,0,0}, -- Reins of the Elusive Quickhoof
    [1700173] = {150,0,0,0,0}, -- Reins of the Springfur Alpaca
    [1700174] = {150,0,0,0,0}, -- Slightly Damp Pile of Fur
    [1700175] = {150,0,0,0,0}, -- Patties Cap Yellow
    [1700176] = {225,0,0,0,0}, -- Malevolent Drone
    [1700177] = {225,0,0,0,0}, -- Royal Swarmers Reins
    [1700178] = {225,0,0,0,0}, -- Shadowbarb Drone
    [1700179] = {225,0,0,0,0}, -- Nyalotha Allseer
    [1700180] = {225,0,0,0,0}, -- Wonderwing 2.0
    [1700181] = {225,0,0,0,0}, -- Pale Serpent of NZoth
    [1700182] = {225,0,0,0,0}, -- Mail Muncher
    [1700183] = {225,0,0,0,0}, -- Wriggling Parasite
    [1700184] = {150,0,0,0,0}, -- Caravan Hyena
    [1700185] = {225,0,0,0,0}, -- Reins of the Wrathion Drake
    [1700186] = {225,0,0,0,0}, -- Ensorcelled Everwyrm
    [1700188] = {225,0,0,0,0}, -- Stormwind Skychaser
    [1700189] = {225,0,0,0,0}, -- Explorer’s Jungle Hopper
    [1700190] = {225,0,0,0,0}, -- Uncorrupted Voidwing
    [1700192] = {225,0,0,0,0}, -- Reins of the Silver Bloodgorged Hunter
    [1700193] = {225,0,0,0,0}, -- Reins of the Black Bloodgorged Hunter
    [1700194] = {225,0,0,0,0}, -- Reins of the Golden Bloodgorged Hunter
    [1700196] = {225,0,0,0,0}, -- Magic Broomstick
    [1700197] = {150,0,0,0,0}, -- Reins of the Brown Riding Camel
    [1700198] = {150,0,0,0,0}, -- Reins of the Grey Riding Camel
    [1700199] = {150,0,0,0,0}, -- Reins of the Tan Riding Camel
    [1700200] = {150,0,0,0,0}, -- Reins of the White Riding Camel
    [1700201] = {150,0,0,0,0}, -- Explorer’s Dunetrekker
    [1700202] = {150,0,0,0,0}, -- Snapback Scuttler
    [1700203] = {150,0,0,0,0}, -- Reins of the Azure Riding Crane
    [1700204] = {150,0,0,0,0}, -- Reins of the Golden Riding Crane
    [1700205] = {150,0,0,0,0}, -- Reins of the Regal Riding Crane
    [1700206] = {150,0,0,0,0}, -- Reins of the Ruby Riding Crane
    [1700207] = {150,0,0,0,0}, -- Reins of the Pale Riding Crane
    [1700208] = {150,0,0,0,0}, -- Reins of the Yellow Riding Crane
    [1700209] = {225,0,0,0,0}, -- Reins of the Phosphorescent Stone Drake
    [1700210] = {225,0,0,0,0}, -- Sandstone Drake
    [1700211] = {225,0,0,0,0}, -- Reins of the Vitreous Stone Drake
    [1700212] = {225,0,0,0,0}, -- Reins of the Volcanic Stone Drake
    [1700213] = {225,0,0,0,0}, -- Reins of the Drake of the West Wind
    [1700214] = {225,0,0,0,0}, -- Reins of the Drake of the Four Winds
    [1700215] = {225,0,0,0,0}, -- Reins of the Drake of the South Wind
    [1700216] = {225,0,0,0,0}, -- Reins of the Drake of the East Wind
    [1700217] = {150,0,0,0,0}, -- Pond Nettle Dark
    [1700218] = {150,0,0,0,0}, -- Pond Nettle Green
    [1700219] = {150,0,0,0,0}, -- Pond Nettle Red
    [1700220] = {150,0,0,0,0}, -- Fathom Dweller
    [1700221] = {225,0,0,0,0}, -- Red Felbat
    [1700222] = {225,0,0,0,0}, -- Blue Felbat
    [1700223] = {225,0,0,0,0}, -- Dark Felbat
    [1700224] = {225,0,0,0,0}, -- Onyx felbat
    [1700225] = {225,0,0,0,0}, -- Felbat Forsaken
    [1700226] = {150,0,0,0,0}, -- Brinedeep Bottom-Feeder
    [1700227] = {150,0,0,0,0}, -- Reins of the Cobalt Primordial Direhorn
    [1700228] = {150,0,0,0,0}, -- Reins of the Golden Primal Direhorn
    [1700229] = {150,0,0,0,0}, -- Reins of the Jade Primordial Direhorn
    [1700230] = {150,0,0,0,0}, -- Reins of the Amber Primordial Direhorn
    [1700231] = {150,0,0,0,0}, -- Reins of the Palehide Direhorn
    [1700232] = {150,0,0,0,0}, -- Mechagon Mechanostrider
    [1700233] = {225,0,0,0,0}, -- Squeakers, the Trickster
    [1700234] = {150,0,0,0,0}, -- Gilded Prowler
    [1700235] = {150,0,0,0,0}, -- Vicious War Spider
    [1700236] = {150,0,0,0,0}, -- Bound Shadehound
    [1700237] = {150,0,0,0,0}, -- Eternal Phalynx of Courage
    [1700238] = {150,0,0,0,0}, -- Eternal Phalynx of Humility
    [1700239] = {150,0,0,0,0}, -- Eternal Phalynx of Loyalty
    [1700240] = {150,0,0,0,0}, -- Eternal Phalynx of Purity
    [1700241] = {150,0,0,0,0}, -- Dreamlight Runestag
    [1700242] = {150,0,0,0,0}, -- Shadeleaf Runestag
    [1700243] = {150,0,0,0,0}, -- Wakeners Runestag
    [1700244] = {150,0,0,0,0}, -- Winterborn Runestag
    [1700245] = {150,0,0,0,0}, -- Enchanted Dreamlight Runestag
    [1700246] = {150,0,0,0,0}, -- Enchanted Shadeleaf Runestag
    [1700247] = {150,0,0,0,0}, -- Enchanted Wakeners Runestag
    [1700248] = {150,0,0,0,0}, -- Enchanted Winterborn Runestag
    [1700249] = {150,0,0,0,0}, -- Fiendish Hellfire Core
    [1700250] = {150,0,0,0,0}, -- Lava Infernal Core
    [1700251] = {150,0,0,0,0}, -- Biting Frostshard Core
    [1700252] = {150,0,0,0,0}, -- Living Infernal Core
    [1700253] = {150,0,0,0,0}, -- Cobalt Infernal Core
    [1700254] = {150,0,0,0,0}, -- Highmountain Elderhorn
    [1700255] = {150,0,0,0,0}, -- Highmountain Thunderhoof
    [1700256] = {150,0,0,0,0}, -- Reins of the Black Thunderhoof
    [1700257] = {150,0,0,0,0}, -- Stonehide Elderhorn
    [1700258] = {150,0,0,0,0}, -- Reins of the Grove Defiler
    [1700259] = {225,0,0,0,0}, -- Winged Guardian
    [1700261] = {150,0,0,0,0}, -- Mawsworn Soulhunter
    [1700263] = {150,0,0,0,0}, -- Crypt Gargon
    [1700264] = {150,0,0,0,0}, -- Hopecrusher Gargon
    [1700265] = {150,0,0,0,0}, -- Inquisition Gargon
    [1700266] = {150,0,0,0,0}, -- Sinfall Gargon
    [1700267] = {150,0,0,0,0}, -- Battle Gargon Vrednic
    [1700268] = {150,0,0,0,0}, -- Desires Battle Gargon
    [1700269] = {150,0,0,0,0}, -- Gravestone Battle Armor
    [1700270] = {150,0,0,0,0}, -- Silessas Battle Harness
    [1700271] = {150,0,0,0,0}, -- Umbral Scythehorn
    [1700272] = {150,0,0,0,0}, -- Legsplitter War Harness
    [1700273] = {150,0,0,0,0}, -- Legsplitter Cobalt Harness
    [1700274] = {150,0,0,0,0}, -- Darkwarren Hardshell
    [1700275] = {150,0,0,0,0}, -- Pale Acidmaw
    [1700276] = {150,0,0,0,0}, -- Spinemaw Gladechewer
    [1700277] = {225,0,0,0,0}, -- Chittering Animite
    [1700278] = {225,0,0,0,0}, -- Endmire Flyer Tether
    [1700279] = {225,0,0,0,0}, -- Chittering Pale Animite
    [1700280] = {150,0,0,0,0}, -- Flametalon of Alysrazor
    [1700281] = {150,0,0,0,0}, -- Voidtalon of the Dark Star
    [1700282] = {150,0,0,0,0}, -- Frenzied Feltalon
    [1700283] = {225,0,0,0,0}, -- Harvesters Dredwing
    [1700284] = {225,0,0,0,0}, -- Horrid Dredwing
    [1700285] = {225,0,0,0,0}, -- Rampart Screecher
    [1700286] = {225,0,0,0,0}, -- Silvertip Dredwing
    [1700288] = {150,0,0,0,0}, -- Wild Dreamrunner
    [1700289] = {150,0,0,0,0}, -- Shimmermist Void Runner
    [1700290] = {150,0,0,0,0}, -- Wild Golden Dreamrunner
    [1700291] = {150,0,0,0,0}, -- Blisterback Bloodtusk
    [1700292] = {150,0,0,0,0}, -- Gorespine
    [1700293] = {150,0,0,0,0}, -- Lurid Bloodtusk
    [1700294] = {150,0,0,0,0}, -- Lurid Void Bloodtusk
    [1700295] = {225,0,0,0,0}, -- Chewed Reins of the Callow Flayedwing
    [1700296] = {225,0,0,0,0}, -- Gruesome Flayedwing
    [1700297] = {225,0,0,0,0}, -- Marrowfangs Reins
    [1700298] = {225,0,0,0,0}, -- Reins of the Void Flayedwing
    [1700299] = {225,0,0,0,0}, -- Amber Ardenmoth
    [1700300] = {225,0,0,0,0}, -- Duskflutter Ardenmoth
    [1700301] = {225,0,0,0,0}, -- Silky Shimmermoth
    [1700302] = {225,0,0,0,0}, -- Vibrant Flutterwing
    [1700303] = {225,0,0,0,0}, -- Bonesewn Fleshroc
    [1700304] = {225,0,0,0,0}, -- Predatory Plagueroc
    [1700305] = {225,0,0,0,0}, -- Reins of the Colossal Slaughterclaw
    [1700306] = {225,0,0,0,0}, -- Reins of the Hulking Deathroc
    [1700307] = {150,0,0,0,0}, -- Reins of the cobalt Flametalon
    [1700308] = {150,0,0,0,0}, -- Reins of the pink Flametalon
    [1700309] = {225,0,0,0,0}, -- Pureblood Fire Hawk
    [1700310] = {225,0,0,0,0}, -- Corrupted Fire Hawk
    [1700311] = {225,0,0,0,0}, -- Pink Fire Hawk
    [1700312] = {225,0,0,0,0}, -- Felfire Hawk
    [1700313] = {225,0,0,0,0}, -- Cobalt Fire Hawk
    [1700314] = {225,0,0,0,0}, -- Cosmic Gladiator’s Soul Eater
    [1700315] = {225,0,0,0,0}, -- Eternal Gladiator’s Soul Eater
    [1700316] = {225,0,0,0,0}, -- Sinfull Gladiator’s Soul Eater
    [1700317] = {225,0,0,0,0}, -- Unchained Gladiator’s Soul Eater
    [1700318] = {150,0,0,0,0}, -- Warstitched Darkhound
    [1700319] = {150,0,0,0,0}, -- Sintouched Deathwalker
    [1700320] = {150,0,0,0,0}, -- Restoration Deathwalker
    [1700321] = {150,0,0,0,0}, -- Soultwisted Deathwalker
    [1700322] = {225,0,0,0,0}, -- Ascendants Aquilon
    [1700323] = {150,0,0,0,0}, -- Bruce
    [1700324] = {225,0,0,0,0}, -- Armored Blue Dragonhawk
    [1700325] = {225,0,0,0,0}, -- Enchanted Fey Dragon
    [1700326] = {150,0,0,0,0}, -- Predatory Bloodgazer
    [1700327] = {150,0,0,0,0}, -- Spirit of Echero
    [1700328] = {150,0,0,0,0}, -- Sapphire Riverbeast
    [1700329] = {150,0,0,0,0}, -- Reins of the Korkron Annihilator
    [1700330] = {225,0,0,0,0}, -- Orgrimmar Interceptor
    [1700331] = {150,0,0,0,0}, -- Coalfist Gronnling
    [1700332] = {150,0,0,0,0}, -- Reins of the Ashhide Mushan Beast
    [1700333] = {150,0,0,0,0}, -- Arcanists Manasaber
    [1700334] = {225,0,0,0,0}, -- Ashen Pandaren Phoenix
    [1700335] = {225,0,0,0,0}, -- Reins of the Stormcrow
    [1700336] = {225,0,0,0,0}, -- Reins of the Solar Stormcrow
    [1700337] = {150,0,0,0,0}, -- Arcadian War Turtle
    [1700338] = {150,0,0,0,0}, -- Vicious War Bear Alliance
    [1700339] = {150,0,0,0,0}, -- Vicious War Spider Alliance
    [1700340] = {150,0,0,0,0}, -- Vicious War Turtle Alliance
    [1700341] = {150,0,0,0,0}, -- Vicious War Bear Horde
    [1700342] = {150,0,0,0,0}, -- Vicious War Spider Horde
    [1700343] = {225,0,0,0,0}, -- Waste Marauder
    [1700344] = {150,0,0,0,0}, -- Reins of the Azure Water Strider
    [1700345] = {150,0,0,0,0}, -- Vicious War Turtle Horde
    [1700346] = {225,0,0,0,0}, -- Reins of the Dread Raven
    [1700347] = {225,0,0,0,0}, -- Tyraels Charger
    [1700348] = {150,0,0,0,0}, -- Reins of the Gilded Golden Ravasaur
    [1700349] = {150,0,0,0,0}, -- Reins of the Gilded Pale Ravasaur
    [1700350] = {150,0,0,0,0}, -- Telix the Stormhorn Beetle
    [1700351] = {225,0,0,0,0}, -- Reins of the dark Zenet Hatchling
    [1700352] = {225,0,0,0,0}, -- Reins of the blood Zenet Hatchling
    [1700353] = {225,0,0,0,0}, -- Reins of the void Zenet Hatchling
    [1700354] = {225,0,0,0,0}, -- Divine Kiss of Ohnahra
    [1700355] = {225,0,0,0,0}, -- Reins of the Liberated Slyvern
    [1700356] = {225,0,0,0,0}, -- Temperamental Skyclaw
    [1700357] = {225,0,0,0,0}, -- Reins of the Pale Liberated Slyvern
    [1700358] = {225,0,0,0,0}, -- Reins of the Golden Liberated Slyvern
    [1700359] = {150,0,0,0,0}, -- Reins of the Sapphire Vorquin
    [1700360] = {150,0,0,0,0}, -- Reins of the Bronze Vorquin
    [1700361] = {150,0,0,0,0}, -- Reins of the Obsidian Vorquin
    [1700362] = {150,0,0,0,0}, -- Reins of the Cobalt Seething Slug
    [1700363] = {150,0,0,0,0}, -- Reins of the Lava Seething Slug
    [1700364] = {150,0,0,0,0}, -- Reins of the Blood Seething Slug
    [1700365] = {150,0,0,0,0}, -- Reins of the Golden Seething Slug
    [1700366] = {150,0,0,0,0}, -- Reins of the Cobalt Magmashell
    [1700367] = {150,0,0,0,0}, -- Reins of the Lava Magmashell
    [1700368] = {150,0,0,0,0}, -- Reins of the Blood Magmashell
    [1700369] = {150,0,0,0,0}, -- Reins of the Golden Magmashell
    [1700370] = {150,0,0,0,0}, -- Reins of the Loyal Magmammoth
    [1700371] = {150,0,0,0,0}, -- Reins of the Lava Magmammoth
    [1700372] = {150,0,0,0,0}, -- Reins of the Blood Magmammoth
    [1700373] = {150,0,0,0,0}, -- Reins of the Golden Magmammoth
    [1700374] = {150,0,0,0,0}, -- Reins of the Cobalt Plainswalker Bearer
    [1700375] = {150,0,0,0,0}, -- Reins of the Dark Plainswalker Bearer
    [1700376] = {150,0,0,0,0}, -- Reins of the Pale Plainswalker Bearer
    [1700377] = {150,0,0,0,0}, -- Reins of the Plainswalker Bearer
    [1700378] = {150,0,0,0,0}, -- Reins of the Blood Plainswalker Bearer
    [1700379] = {150,0,0,0,0}, -- Reins of the Noble Bruffalon
    [1700380] = {150,0,0,0,0}, -- Reins of the Brown Bruffalon
    [1700381] = {150,0,0,0,0}, -- Reins of the Dark Bruffalon
    [1700382] = {225,0,0,0,0}, -- Tamed Dark Skitterfly
    [1700383] = {225,0,0,0,0}, -- Azure Skitterfly
    [1700384] = {225,0,0,0,0}, -- Verdant Skitterfly
    [1700385] = {225,0,0,0,0}, -- Tamed Lava Skitterfly
    [1700386] = {225,0,0,0,0}, -- Tamed Golden Skitterfly
    [1700387] = {150,0,0,0,0}, -- Reins of the Ancient Azure Salamanther
    [1700388] = {150,0,0,0,0}, -- Reins of the Ancient Salamanther
    [1700389] = {150,0,0,0,0}, -- Reins of the Ancient Lava Salamanther
    [1700390] = {150,0,0,0,0}, -- Reins of the Ancient Pink Salamanther
    [1700391] = {150,0,0,0,0}, -- Reins of the Ancient Void Salamanther
    [1700392] = {150,0,0,0,0}, -- Coal Skyskin Hornstrider
    [1700393] = {150,0,0,0,0}, -- Azure Skyskin Hornstrider
    [1700394] = {150,0,0,0,0}, -- Emerald Skyskin Hornstrider
    [1700395] = {150,0,0,0,0}, -- Blood Skyskin Hornstrider
    [1700396] = {150,0,0,0,0}, -- Pale Skyskin Hornstrider
    [1700397] = {150,0,0,0,0}, -- Lizis Dark Reins
    [1700398] = {150,0,0,0,0}, -- Lizis Azure Reins
    [1700399] = {150,0,0,0,0}, -- Lizis Brown Reins
    [1700400] = {150,0,0,0,0}, -- Lizis Green Reins
    [1700401] = {150,0,0,0,0}, -- Lizis Pale Reins
    [1700402] = {225,0,0,0,0}, -- Dark Nether-Gorged Greatwyrm
    [1700403] = {225,0,0,0,0}, -- Azure Nether-Gorged Greatwyrm
    [1700404] = {225,0,0,0,0}, -- Void Nether-Gorged Greatwyrm
    [1700405] = {225,0,0,0,0}, -- Silver Nether-Gorged Greatwyrm
    [1700406] = {225,0,0,0,0}, -- Reins of the Armored Azure Valarjar Stormwing
    [1700407] = {225,0,0,0,0}, -- Reins of the Armored Dark Valarjar Stormwing
    [1700408] = {225,0,0,0,0}, -- Reins of the Armored Green Valarjar Stormwing
    [1700409] = {225,0,0,0,0}, -- Reins of the Armored Pale Valarjar Stormwing
    [1700410] = {225,0,0,0,0}, -- Reins of the Armored Golden Valarjar Stormwing
    [1700411] = {225,0,0,0,0}, -- Felstorm Dragon
    [1700412] = {225,0,0,0,0}, -- Uncorrupted Voidwing

}
--[[
local RIDING_SPELL = {
    33388, -- Apprentince Riding (75) (60 speed)
    33391, -- Journeyman Riding (150) (100 speed)
    34090, -- Expert Riding (225) (150 speed)
    34091, -- Artisan Riding (300) (280+ speed)
}
]]
local function SyncMounts(event, player)
    local Player_LeveL = player:GetLevel()
    if (Player_LeveL < WhenPLayerLevel) then
        return
    end
    if player:HasItem(90000, 1) then  -- Hard Mode Key
        return
    end
    if player:HasItem(800048, 1) then  -- Slow and Steady Key
        return
    end
    if (ANNOUNCE_ON_LOGIN and event) then
        player:SendBroadcastMessage(ANNOUNCEMENT)
    end

    local pGUID = player:GetGUIDLow()
    local pAccountId = player:GetAccountId()
    local results = CharDBQuery("SELECT guid FROM characters WHERE account = "..pAccountId.." and guid <> "..pGUID)

    local guids = {}
    if (results) then
        repeat
            table.insert(guids, results:GetUInt32(0))
        until not results:NextRow()
    end

    if (#guids > 0) then
        local guidstr = guids[1]
        for i = 2, #guids do
            guidstr = guidstr .. ",".. guids[i]
        end

        results = CharDBQuery("SELECT DISTINCT spell FROM character_spell WHERE guid IN("..guidstr..")")
        if (results) then
            local skill = player:GetSkillValue(762)
            local class = player:GetClass()
            local team = player:GetTeam()
            repeat
                local spellId = results:GetUInt32(0)
                local mount = mount_listing[spellId]
                if (mount) then
                    if ((skill >= mount[1]) and
                    ((mount[2]==0) or (mount[2]==class)) and
                    ((not StrictFactions) or (mount[3]==0) or (mount[3]==(team+1))) and
                    ((mount[4]==0) or (mount[4]==148) or (mount[4]==149) or (mount[4]==150) or (mount[4]==152) or (mount[4]==533) or (mount[4]==554) or (player:GetSkillValue(mount[4]) >= mount[5]))) then
                        if ((spellId == 61425) and (team == 2)) then -- if StrictFactions=false, have to check and replace traveler mammoth special case, to not spawn enemy vendors
                            spellId = 61447
                        elseif ((spellId == 61447) and (team == 1)) then
                            spellId = 61425
                        end
                        if (not player:HasSpell(spellId)) then
                            player:LearnSpell(spellId)
                        end
                    end
                end
            until not results:NextRow()
        end
    end
end

local function OnSendLearnedSpell(event, packet, player)
    local spellId = packet:ReadULong() -- spellId(SMSG_LEARNED_SPELL) / oldSpellId (SMSG_SUPERCEDED_SPELL)
    
    if(spellId == 33388 or spellId == 33391 or spellId == 34090 or spellId == 34091) then
        player:RegisterEvent((function(_,_,_,p) SyncMounts(nil, p) end), 100)
    end
  end
  

RegisterPlayerEvent(3, SyncMounts)
RegisterPacketEvent(299, 7, OnSendLearnedSpell) -- PACKET_EVENT_ON_PACKET_SEND (SMSG_LEARNED_SPELL)
RegisterPacketEvent(300, 7, OnSendLearnedSpell) -- PACKET_EVENT_ON_PACKET_SEND (SMSG_SUPERCEDED_SPELL)