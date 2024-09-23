mb_Hunter_CurrentlyTanking = nil

mb_config = {}
-- Which characters in the raid should be considered tanks, and as such be paid extra attention to by the healers
mb_config.tanks = {"Malowtank", "Elerien"}

-- List of character names that you trust, that your characters will accept orders, remote-executes etc. from.

mb_config.trustedCharacters = {}

table.insert(mb_config.trustedCharacters, "Odia")
table.insert(mb_config.trustedCharacters, "Maligna")
table.insert(mb_config.trustedCharacters, "Necria")
table.insert(mb_config.trustedCharacters, "Charnel")
table.insert(mb_config.trustedCharacters, "Umbria")
table.insert(mb_config.trustedCharacters, "Pestilina")
table.insert(mb_config.trustedCharacters, "Khalia")
table.insert(mb_config.trustedCharacters, "Gwethriel")
table.insert(mb_config.trustedCharacters, "Kisaana")
table.insert(mb_config.trustedCharacters, "Trudy")
table.insert(mb_config.trustedCharacters, "Arethel")
table.insert(mb_config.trustedCharacters, "Elerien")
table.insert(mb_config.trustedCharacters, "Turtlehunt")
table.insert(mb_config.trustedCharacters, "Malowtank")

-- List of waters that should be drunk
mb_config.waters = {}
table.insert(mb_config.waters, "Conjured Mana Strudel")

-- Decides whether characters should register consumables for reagent watch
mb_config.enableConsumablesWatch = true

-- List of characters to receive Focus Magic buff from mages according to the mages class order index
mb_config.focusMagicTargets = {}
mb_config.focusMagicTargets.first = "Arethel"
mb_config.focusMagicTargets.second = "Odia"

-- List of profession CD's to use automatically (in order)
mb_config.professionCooldowns = {}
mb_config.professionCooldowns["Alchemy"] = {}
table.insert(mb_config.professionCooldowns["Alchemy"], "Transmute: Eternal Life to Fire")


-- Class Order is the alphabetical order that the character is within its own class
mb_config.classOrder = {}
mb_config.classOrder.mightBlesser = 1
mb_config.classOrder.wisdomBlesser = 2
mb_config.classOrder.sancBlesser = 3
mb_config.classOrder.kingsBlesser = 4
mb_config.classOrder.retriAura = 1
mb_config.classOrder.concentrationAura = 2
mb_config.classOrder.devoAura = 3
mb_config.classOrder.frostAura = 4
mb_config.classOrder.fireAura = 5
mb_config.classOrder.crusaderAura = 6
mb_config.classOrder.shadowAura = 7


-- Blacklisted interrupt spells, spells that are not interruptible but that shows as interruptible
mb_config.blacklistedInterruptSpells = {}
mb_config.blacklistedInterruptSpells["Malygos"] = { "Arcane Breath" }
mb_config.blacklistedInterruptSpells["Sartharion"] = { "Flame Breath" }

mb_config.rangedList = {}
table.insert(mb_config.rangedList, "Balance")
table.insert(mb_config.rangedList, "Arcane")
table.insert(mb_config.rangedList, "Fire")
table.insert(mb_config.rangedList, "Destruction")
table.insert(mb_config.rangedList, "Affliction")
table.insert(mb_config.rangedList, "Elemental")
table.insert(mb_config.rangedList, "Shadow")
table.insert(mb_config.rangedList, "Holy")
table.insert(mb_config.rangedList, "Disciple")
table.insert(mb_config.rangedList, "Restoration")
table.insert(mb_config.rangedList, "Beast Mastery")
table.insert(mb_config.rangedList, "Marksmanship")
table.insert(mb_config.rangedList, "Survival")

mb_config.meleeList = {}
table.insert(mb_config.meleeList, "Assassination")
table.insert(mb_config.meleeList, "Combat")
table.insert(mb_config.meleeList, "Subtlety")
table.insert(mb_config.meleeList, "Arms")
table.insert(mb_config.meleeList, "Fury")
table.insert(mb_config.meleeList, "Blood")
table.insert(mb_config.meleeList, "Unholy")
table.insert(mb_config.meleeList, "Enhancement")
table.insert(mb_config.meleeList, "Feral Combat")
table.insert(mb_config.meleeList, "Retribution")
table.insert(mb_config.meleeList, "Protection")

-- -----------------------------------------------
-- Raid Layout
-- -----------------------------------------------
mb_config.raidLayout = {}
mb_config.raidLayout["25man"] = {}
mb_config.raidLayout["25man"][1] = {}
table.insert(mb_config.raidLayout["25man"][1], "Malowtank")
table.insert(mb_config.raidLayout["25man"][1], "Aerer")
table.insert(mb_config.raidLayout["25man"][1], "Ninki")
table.insert(mb_config.raidLayout["25man"][1], "Carin")
table.insert(mb_config.raidLayout["25man"][1], "Rewis")
mb_config.raidLayout["25man"][2] = {}
table.insert(mb_config.raidLayout["25man"][2], "Warde")
table.insert(mb_config.raidLayout["25man"][2], "Riffin")
table.insert(mb_config.raidLayout["25man"][2], "Tunbert")
table.insert(mb_config.raidLayout["25man"][2], "Abith")
table.insert(mb_config.raidLayout["25man"][2], "Elerien")
mb_config.raidLayout["25man"][3] = {}
table.insert(mb_config.raidLayout["25man"][3], "Puabi")
table.insert(mb_config.raidLayout["25man"][3], "Verne")
table.insert(mb_config.raidLayout["25man"][3], "Odia")
table.insert(mb_config.raidLayout["25man"][3], "Necria")
table.insert(mb_config.raidLayout["25man"][3], "Trudy")
mb_config.raidLayout["25man"][4] = {}
table.insert(mb_config.raidLayout["25man"][4], "Khalia")
table.insert(mb_config.raidLayout["25man"][4], "Gwethriel")
table.insert(mb_config.raidLayout["25man"][4], "Arethel")
table.insert(mb_config.raidLayout["25man"][4], "Kisaana")
table.insert(mb_config.raidLayout["25man"][4], "Ceolmar")
mb_config.raidLayout["25man"][5] = {}
table.insert(mb_config.raidLayout["25man"][5], "Maligna")
table.insert(mb_config.raidLayout["25man"][5], "Charnel")
table.insert(mb_config.raidLayout["25man"][5], "Pestilina")
table.insert(mb_config.raidLayout["25man"][5], "Umbria")
table.insert(mb_config.raidLayout["25man"][5], "Igal")

-- -----------------------------------------------
-- Stat Weights
-- -----------------------------------------------
mb_config.statWeights = {}
-- Paladin
mb_config.statWeights["Paladin"] = {}
-- Holy
mb_config.statWeights["Paladin"]["Holy"] = {}
mb_config.statWeights["Paladin"]["Holy"].agility = 0.0
mb_config.statWeights["Paladin"]["Holy"].intellect = 1.0
mb_config.statWeights["Paladin"]["Holy"].spirit = 0.0
mb_config.statWeights["Paladin"]["Holy"].strength = 0.0
mb_config.statWeights["Paladin"]["Holy"].stamina = 0.1
mb_config.statWeights["Paladin"]["Holy"].critRating = 0.46
mb_config.statWeights["Paladin"]["Holy"].resilienceRating = 0.0
mb_config.statWeights["Paladin"]["Holy"].defenseRating = 0.0
mb_config.statWeights["Paladin"]["Holy"].expertiseRating = 0.0
mb_config.statWeights["Paladin"]["Holy"].dodgeRating = 0.0
mb_config.statWeights["Paladin"]["Holy"].parryRating = 0.0
mb_config.statWeights["Paladin"]["Holy"].blockRating = 0.0
mb_config.statWeights["Paladin"]["Holy"].armorPenetrationRating = 0.0
mb_config.statWeights["Paladin"]["Holy"].hitRating = 0.0
mb_config.statWeights["Paladin"]["Holy"].hasteRating = 0.35
mb_config.statWeights["Paladin"]["Holy"].attackPower = 0.0
mb_config.statWeights["Paladin"]["Holy"].armor = 0.0
mb_config.statWeights["Paladin"]["Holy"].blockValue = 0.0
mb_config.statWeights["Paladin"]["Holy"].spellPower = 0.58
mb_config.statWeights["Paladin"]["Holy"].mp5 = 0.88
mb_config.statWeights["Paladin"]["Holy"].dps = 0.0
mb_config.statWeights["Paladin"]["Holy"].socketMeta = 100
mb_config.statWeights["Paladin"]["Holy"].socketColored = 16
-- Protection
mb_config.statWeights["Paladin"]["Protection"] = {}
mb_config.statWeights["Paladin"]["Protection"].agility = 0.6
mb_config.statWeights["Paladin"]["Protection"].intellect = 0.0
mb_config.statWeights["Paladin"]["Protection"].spirit = 0.0
mb_config.statWeights["Paladin"]["Protection"].strength = 0.16
mb_config.statWeights["Paladin"]["Protection"].stamina = 1.0
mb_config.statWeights["Paladin"]["Protection"].critRating = 0.0
mb_config.statWeights["Paladin"]["Protection"].resilienceRating = 0.0
mb_config.statWeights["Paladin"]["Protection"].defenseRating = 0.5
mb_config.statWeights["Paladin"]["Protection"].expertiseRating = 0.59
mb_config.statWeights["Paladin"]["Protection"].dodgeRating = 0.4
mb_config.statWeights["Paladin"]["Protection"].parryRating = 0.45
mb_config.statWeights["Paladin"]["Protection"].blockRating = 0.07
mb_config.statWeights["Paladin"]["Protection"].armorPenetrationRating = 0.0
mb_config.statWeights["Paladin"]["Protection"].hitRating = 0.0
mb_config.statWeights["Paladin"]["Protection"].hasteRating = 0.0
mb_config.statWeights["Paladin"]["Protection"].attackPower = 0.0
mb_config.statWeights["Paladin"]["Protection"].armor = 0.08
mb_config.statWeights["Paladin"]["Protection"].blockValue = 0.06
mb_config.statWeights["Paladin"]["Protection"].spellPower = 0.0
mb_config.statWeights["Paladin"]["Protection"].mp5 = 0.0
mb_config.statWeights["Paladin"]["Protection"].dps = 0.0
mb_config.statWeights["Paladin"]["Protection"].socketMeta = 100
mb_config.statWeights["Paladin"]["Protection"].socketColored = 16
-- Retribution
mb_config.statWeights["Paladin"]["Retribution"] = {}
mb_config.statWeights["Paladin"]["Retribution"].agility = 0.32
mb_config.statWeights["Paladin"]["Retribution"].intellect = 0.0
mb_config.statWeights["Paladin"]["Retribution"].spirit = 0.0
mb_config.statWeights["Paladin"]["Retribution"].strength = 0.8
mb_config.statWeights["Paladin"]["Retribution"].stamina = 0.01
mb_config.statWeights["Paladin"]["Retribution"].critRating = 0.4
mb_config.statWeights["Paladin"]["Retribution"].resilienceRating = 0.0
mb_config.statWeights["Paladin"]["Retribution"].defenseRating = 0.0
mb_config.statWeights["Paladin"]["Retribution"].expertiseRating = 0.33
mb_config.statWeights["Paladin"]["Retribution"].dodgeRating = 0.0
mb_config.statWeights["Paladin"]["Retribution"].parryRating = 0.0
mb_config.statWeights["Paladin"]["Retribution"].blockRating = 0.0
mb_config.statWeights["Paladin"]["Retribution"].armorPenetrationRating = 0.2
mb_config.statWeights["Paladin"]["Retribution"].hitRating = 0.5
mb_config.statWeights["Paladin"]["Retribution"].hasteRating = 0.25
mb_config.statWeights["Paladin"]["Retribution"].attackPower = 0.34
mb_config.statWeights["Paladin"]["Retribution"].armor = 0.0
mb_config.statWeights["Paladin"]["Retribution"].blockValue = 0.0
mb_config.statWeights["Paladin"]["Retribution"].spellPower = 0.09
mb_config.statWeights["Paladin"]["Retribution"].mp5 = 0.0
mb_config.statWeights["Paladin"]["Retribution"].dps = 0.0
mb_config.statWeights["Paladin"]["Retribution"].socketMeta = 100
mb_config.statWeights["Paladin"]["Retribution"].socketColored = 12.8

-- Shaman
mb_config.statWeights["Shaman"] = {}
-- Enhancement
mb_config.statWeights["Shaman"]["Enhancement"] = {}
mb_config.statWeights["Shaman"]["Enhancement"].agility = 0.55
mb_config.statWeights["Shaman"]["Enhancement"].intellect = 0.4
mb_config.statWeights["Shaman"]["Enhancement"].spirit = 0.0
mb_config.statWeights["Shaman"]["Enhancement"].strength = 0.4
mb_config.statWeights["Shaman"]["Enhancement"].stamina = 0.01
mb_config.statWeights["Shaman"]["Enhancement"].critRating = 0.4
mb_config.statWeights["Shaman"]["Enhancement"].resilienceRating = 0.0
mb_config.statWeights["Shaman"]["Enhancement"].defenseRating = 0.0
mb_config.statWeights["Shaman"]["Enhancement"].expertiseRating = 0.84
mb_config.statWeights["Shaman"]["Enhancement"].dodgeRating = 0.0
mb_config.statWeights["Shaman"]["Enhancement"].parryRating = 0.0
mb_config.statWeights["Shaman"]["Enhancement"].blockRating = 0.0
mb_config.statWeights["Shaman"]["Enhancement"].armorPenetrationRating = 0.2
mb_config.statWeights["Shaman"]["Enhancement"].hitRating = 1.0
mb_config.statWeights["Shaman"]["Enhancement"].hasteRating = 0.6
mb_config.statWeights["Shaman"]["Enhancement"].attackPower = 0.35
mb_config.statWeights["Shaman"]["Enhancement"].armor = 0.0
mb_config.statWeights["Shaman"]["Enhancement"].blockValue = 0.0
mb_config.statWeights["Shaman"]["Enhancement"].spellPower = 0.2
mb_config.statWeights["Shaman"]["Enhancement"].mp5 = 0.0
mb_config.statWeights["Shaman"]["Enhancement"].dps = 0.0
mb_config.statWeights["Shaman"]["Enhancement"].socketMeta = 100
mb_config.statWeights["Shaman"]["Enhancement"].socketColored = 16
-- Restoration
mb_config.statWeights["Shaman"]["Restoration"] = {}
mb_config.statWeights["Shaman"]["Restoration"].agility = 0.0
mb_config.statWeights["Shaman"]["Restoration"].intellect = 0.85
mb_config.statWeights["Shaman"]["Restoration"].spirit = 0.0
mb_config.statWeights["Shaman"]["Restoration"].strength = 0.0
mb_config.statWeights["Shaman"]["Restoration"].stamina = 0.01
mb_config.statWeights["Shaman"]["Restoration"].critRating = 0.62
mb_config.statWeights["Shaman"]["Restoration"].resilienceRating = 0.0
mb_config.statWeights["Shaman"]["Restoration"].defenseRating = 0.0
mb_config.statWeights["Shaman"]["Restoration"].expertiseRating = 0.0
mb_config.statWeights["Shaman"]["Restoration"].dodgeRating = 0.0
mb_config.statWeights["Shaman"]["Restoration"].parryRating = 0.0
mb_config.statWeights["Shaman"]["Restoration"].blockRating = 0.0
mb_config.statWeights["Shaman"]["Restoration"].armorPenetrationRating = 0.0
mb_config.statWeights["Shaman"]["Restoration"].hitRating = 0.0
mb_config.statWeights["Shaman"]["Restoration"].hasteRating = 0.35
mb_config.statWeights["Shaman"]["Restoration"].attackPower = 0.0
mb_config.statWeights["Shaman"]["Restoration"].armor = 0.0
mb_config.statWeights["Shaman"]["Restoration"].blockValue = 0.0
mb_config.statWeights["Shaman"]["Restoration"].spellPower = 0.75
mb_config.statWeights["Shaman"]["Restoration"].mp5 = 1.0
mb_config.statWeights["Shaman"]["Restoration"].dps = 0.0
mb_config.statWeights["Shaman"]["Restoration"].socketMeta = 100
mb_config.statWeights["Shaman"]["Restoration"].socketColored = 16

-- Warrior
mb_config.statWeights["Warrior"] = {}
-- Arms
mb_config.statWeights["Warrior"]["Arms"] = {}
mb_config.statWeights["Warrior"]["Arms"].agility = 0.4
mb_config.statWeights["Warrior"]["Arms"].intellect = 0.0
mb_config.statWeights["Warrior"]["Arms"].spirit = 0.0
mb_config.statWeights["Warrior"]["Arms"].strength = 1.0
mb_config.statWeights["Warrior"]["Arms"].stamina = 0.01
mb_config.statWeights["Warrior"]["Arms"].critRating = 0.35
mb_config.statWeights["Warrior"]["Arms"].resilienceRating = 0.0
mb_config.statWeights["Warrior"]["Arms"].defenseRating = 0.0
mb_config.statWeights["Warrior"]["Arms"].expertiseRating = 0.1
mb_config.statWeights["Warrior"]["Arms"].dodgeRating = 0.0
mb_config.statWeights["Warrior"]["Arms"].parryRating = 0.0
mb_config.statWeights["Warrior"]["Arms"].blockRating = 0.0
mb_config.statWeights["Warrior"]["Arms"].armorPenetrationRating = 0.4
mb_config.statWeights["Warrior"]["Arms"].hitRating = 0.45
mb_config.statWeights["Warrior"]["Arms"].hasteRating = 0.1
mb_config.statWeights["Warrior"]["Arms"].attackPower = 0.45
mb_config.statWeights["Warrior"]["Arms"].armor = 0.0
mb_config.statWeights["Warrior"]["Arms"].blockValue = 0.0
mb_config.statWeights["Warrior"]["Arms"].spellPower = 0.0
mb_config.statWeights["Warrior"]["Arms"].mp5 = 0.0
mb_config.statWeights["Warrior"]["Arms"].dps = 0.0
mb_config.statWeights["Warrior"]["Arms"].socketMeta = 100
mb_config.statWeights["Warrior"]["Arms"].socketColored = 16

-- Rogue
mb_config.statWeights["Rogue"] = {}
-- Combat
mb_config.statWeights["Rogue"]["Combat"] = {}
mb_config.statWeights["Rogue"]["Combat"].agility = 1.0
mb_config.statWeights["Rogue"]["Combat"].intellect = 0.0
mb_config.statWeights["Rogue"]["Combat"].spirit = 0.0
mb_config.statWeights["Rogue"]["Combat"].strength = 0.55
mb_config.statWeights["Rogue"]["Combat"].stamina = 0.01
mb_config.statWeights["Rogue"]["Combat"].critRating = 0.75
mb_config.statWeights["Rogue"]["Combat"].resilienceRating = 0.0
mb_config.statWeights["Rogue"]["Combat"].defenseRating = 0.0
mb_config.statWeights["Rogue"]["Combat"].expertiseRating = 0.82
mb_config.statWeights["Rogue"]["Combat"].dodgeRating = 0.0
mb_config.statWeights["Rogue"]["Combat"].parryRating = 0.0
mb_config.statWeights["Rogue"]["Combat"].blockRating = 0.0
mb_config.statWeights["Rogue"]["Combat"].armorPenetrationRating = 1.0
mb_config.statWeights["Rogue"]["Combat"].hitRating = 0.8
mb_config.statWeights["Rogue"]["Combat"].hasteRating = 0.73
mb_config.statWeights["Rogue"]["Combat"].attackPower = 0.5
mb_config.statWeights["Rogue"]["Combat"].armor = 0.0
mb_config.statWeights["Rogue"]["Combat"].blockValue = 0.0
mb_config.statWeights["Rogue"]["Combat"].spellPower = 0.0
mb_config.statWeights["Rogue"]["Combat"].mp5 = 0.0
mb_config.statWeights["Rogue"]["Combat"].dps = 0.0
mb_config.statWeights["Rogue"]["Combat"].socketMeta = 100
mb_config.statWeights["Rogue"]["Combat"].socketColored = 16

mb_config.statWeights["Druid"] = {}
-- Balance
mb_config.statWeights["Druid"]["Balance"] = {}
mb_config.statWeights["Druid"]["Balance"].agility = 0.0
mb_config.statWeights["Druid"]["Balance"].intellect = 0.22
mb_config.statWeights["Druid"]["Balance"].spirit = 0.22
mb_config.statWeights["Druid"]["Balance"].strength = 0.0
mb_config.statWeights["Druid"]["Balance"].stamina = 0.01
mb_config.statWeights["Druid"]["Balance"].critRating = 0.43
mb_config.statWeights["Druid"]["Balance"].resilienceRating = 0.0
mb_config.statWeights["Druid"]["Balance"].defenseRating = 0.0
mb_config.statWeights["Druid"]["Balance"].expertiseRating = 0.0
mb_config.statWeights["Druid"]["Balance"].dodgeRating = 0.0
mb_config.statWeights["Druid"]["Balance"].parryRating = 0.0
mb_config.statWeights["Druid"]["Balance"].blockRating = 0.0
mb_config.statWeights["Druid"]["Balance"].armorPenetrationRating = 0.0
mb_config.statWeights["Druid"]["Balance"].hitRating = 1.0
mb_config.statWeights["Druid"]["Balance"].hasteRating = 0.54
mb_config.statWeights["Druid"]["Balance"].attackPower = 0.0
mb_config.statWeights["Druid"]["Balance"].armor = 0.0
mb_config.statWeights["Druid"]["Balance"].blockValue = 0.0
mb_config.statWeights["Druid"]["Balance"].spellPower = 0.66
mb_config.statWeights["Druid"]["Balance"].mp5 = 0.0
mb_config.statWeights["Druid"]["Balance"].dps = 0.0
mb_config.statWeights["Druid"]["Balance"].socketMeta = 100
mb_config.statWeights["Druid"]["Balance"].socketColored = 16
-- Feral
mb_config.statWeights["Druid"]["Feral Combat"] = {}
mb_config.statWeights["Druid"]["Feral Combat"].agility = 0.70
mb_config.statWeights["Druid"]["Feral Combat"].intellect = 0.0
mb_config.statWeights["Druid"]["Feral Combat"].spirit = 0.0
mb_config.statWeights["Druid"]["Feral Combat"].strength = 0.1
mb_config.statWeights["Druid"]["Feral Combat"].stamina = 1.0
mb_config.statWeights["Druid"]["Feral Combat"].critRating = 0.03
mb_config.statWeights["Druid"]["Feral Combat"].resilienceRating = 0.0
mb_config.statWeights["Druid"]["Feral Combat"].defenseRating = 0.1
mb_config.statWeights["Druid"]["Feral Combat"].expertiseRating = 0.16
mb_config.statWeights["Druid"]["Feral Combat"].dodgeRating = 0.65
mb_config.statWeights["Druid"]["Feral Combat"].parryRating = 0.0
mb_config.statWeights["Druid"]["Feral Combat"].blockRating = 0.0
mb_config.statWeights["Druid"]["Feral Combat"].armorPenetrationRating = 0.0
mb_config.statWeights["Druid"]["Feral Combat"].hitRating = 0.08
mb_config.statWeights["Druid"]["Feral Combat"].hasteRating = 0.05
mb_config.statWeights["Druid"]["Feral Combat"].attackPower = 0.04
mb_config.statWeights["Druid"]["Feral Combat"].armor = 0.25
mb_config.statWeights["Druid"]["Feral Combat"].blockValue = 0.0
mb_config.statWeights["Druid"]["Feral Combat"].spellPower = 0.0
mb_config.statWeights["Druid"]["Feral Combat"].mp5 = 0.0
mb_config.statWeights["Druid"]["Feral Combat"].dps = 0.0
mb_config.statWeights["Druid"]["Feral Combat"].socketMeta = 100
mb_config.statWeights["Druid"]["Feral Combat"].socketColored = 16
-- Restoration
mb_config.statWeights["Druid"]["Restoration"] = {}
mb_config.statWeights["Druid"]["Restoration"].agility = 0.0
mb_config.statWeights["Druid"]["Restoration"].intellect = 0.51
mb_config.statWeights["Druid"]["Restoration"].spirit = 0.32
mb_config.statWeights["Druid"]["Restoration"].strength = 0.0
mb_config.statWeights["Druid"]["Restoration"].stamina = 0.01
mb_config.statWeights["Druid"]["Restoration"].critRating = 0.11
mb_config.statWeights["Druid"]["Restoration"].resilienceRating = 0.0
mb_config.statWeights["Druid"]["Restoration"].defenseRating = 0.0
mb_config.statWeights["Druid"]["Restoration"].expertiseRating = 0.0
mb_config.statWeights["Druid"]["Restoration"].dodgeRating = 0.0
mb_config.statWeights["Druid"]["Restoration"].parryRating = 0.0
mb_config.statWeights["Druid"]["Restoration"].blockRating = 0.0
mb_config.statWeights["Druid"]["Restoration"].armorPenetrationRating = 0.0
mb_config.statWeights["Druid"]["Restoration"].hitRating = 0.0
mb_config.statWeights["Druid"]["Restoration"].hasteRating = 0.57
mb_config.statWeights["Druid"]["Restoration"].attackPower = 0.0
mb_config.statWeights["Druid"]["Restoration"].armor = 0.0
mb_config.statWeights["Druid"]["Restoration"].blockValue = 0.0
mb_config.statWeights["Druid"]["Restoration"].spellPower = 1.0
mb_config.statWeights["Druid"]["Restoration"].mp5 = 0.73
mb_config.statWeights["Druid"]["Restoration"].dps = 0.0
mb_config.statWeights["Druid"]["Restoration"].socketMeta = 100
mb_config.statWeights["Druid"]["Restoration"].socketColored = 16

-- Mage
mb_config.statWeights["Mage"] = {}
-- Arcane
mb_config.statWeights["Mage"]["Arcane"] = {}
mb_config.statWeights["Mage"]["Arcane"].agility = 0.0
mb_config.statWeights["Mage"]["Arcane"].intellect = 0.34
mb_config.statWeights["Mage"]["Arcane"].spirit = 0.14
mb_config.statWeights["Mage"]["Arcane"].strength = 0.0
mb_config.statWeights["Mage"]["Arcane"].stamina = 0.01
mb_config.statWeights["Mage"]["Arcane"].critRating = 0.37
mb_config.statWeights["Mage"]["Arcane"].resilienceRating = 0.0
mb_config.statWeights["Mage"]["Arcane"].defenseRating = 0.0
mb_config.statWeights["Mage"]["Arcane"].expertiseRating = 0.0
mb_config.statWeights["Mage"]["Arcane"].dodgeRating = 0.0
mb_config.statWeights["Mage"]["Arcane"].parryRating = 0.0
mb_config.statWeights["Mage"]["Arcane"].blockRating = 0.0
mb_config.statWeights["Mage"]["Arcane"].armorPenetrationRating = 0.0
mb_config.statWeights["Mage"]["Arcane"].hitRating = 1.0
mb_config.statWeights["Mage"]["Arcane"].hasteRating = 0.54
mb_config.statWeights["Mage"]["Arcane"].attackPower = 0.0
mb_config.statWeights["Mage"]["Arcane"].armor = 0.0
mb_config.statWeights["Mage"]["Arcane"].blockValue = 0.0
mb_config.statWeights["Mage"]["Arcane"].spellPower = 0.49
mb_config.statWeights["Mage"]["Arcane"].mp5 = 0.0
mb_config.statWeights["Mage"]["Arcane"].dps = 0.0
mb_config.statWeights["Mage"]["Arcane"].socketMeta = 100
mb_config.statWeights["Mage"]["Arcane"].socketColored = 16

-- Priest
mb_config.statWeights["Priest"] = {}
-- Holy
mb_config.statWeights["Priest"]["Holy"] = {}
mb_config.statWeights["Priest"]["Holy"].agility = 0.0
mb_config.statWeights["Priest"]["Holy"].intellect = 0.69
mb_config.statWeights["Priest"]["Holy"].spirit = 0.52
mb_config.statWeights["Priest"]["Holy"].strength = 0.0
mb_config.statWeights["Priest"]["Holy"].stamina = 0.01
mb_config.statWeights["Priest"]["Holy"].critRating = 0.38
mb_config.statWeights["Priest"]["Holy"].resilienceRating = 0.0
mb_config.statWeights["Priest"]["Holy"].defenseRating = 0.0
mb_config.statWeights["Priest"]["Holy"].expertiseRating = 0.0
mb_config.statWeights["Priest"]["Holy"].dodgeRating = 0.0
mb_config.statWeights["Priest"]["Holy"].parryRating = 0.0
mb_config.statWeights["Priest"]["Holy"].blockRating = 0.0
mb_config.statWeights["Priest"]["Holy"].armorPenetrationRating = 0.0
mb_config.statWeights["Priest"]["Holy"].hitRating = 0.0
mb_config.statWeights["Priest"]["Holy"].hasteRating = 0.31
mb_config.statWeights["Priest"]["Holy"].attackPower = 0.0
mb_config.statWeights["Priest"]["Holy"].armor = 0.0
mb_config.statWeights["Priest"]["Holy"].blockValue = 0.0
mb_config.statWeights["Priest"]["Holy"].spellPower = 0.60
mb_config.statWeights["Priest"]["Holy"].mp5 = 1.0
mb_config.statWeights["Priest"]["Holy"].dps = 0.0
mb_config.statWeights["Priest"]["Holy"].socketMeta = 100
mb_config.statWeights["Priest"]["Holy"].socketColored = 16

-- Warlock
mb_config.statWeights["Warlock"] = {}
-- Affliction
mb_config.statWeights["Warlock"]["Affliction"] = {}
mb_config.statWeights["Warlock"]["Affliction"].agility = 0.0
mb_config.statWeights["Warlock"]["Affliction"].intellect = 0.15
mb_config.statWeights["Warlock"]["Affliction"].spirit = 0.34
mb_config.statWeights["Warlock"]["Affliction"].strength = 0.0
mb_config.statWeights["Warlock"]["Affliction"].stamina = 0.01
mb_config.statWeights["Warlock"]["Affliction"].critRating = 0.38
mb_config.statWeights["Warlock"]["Affliction"].resilienceRating = 0.0
mb_config.statWeights["Warlock"]["Affliction"].defenseRating = 0.0
mb_config.statWeights["Warlock"]["Affliction"].expertiseRating = 0.0
mb_config.statWeights["Warlock"]["Affliction"].dodgeRating = 0.0
mb_config.statWeights["Warlock"]["Affliction"].parryRating = 0.0
mb_config.statWeights["Warlock"]["Affliction"].blockRating = 0.0
mb_config.statWeights["Warlock"]["Affliction"].armorPenetrationRating = 0.0
mb_config.statWeights["Warlock"]["Affliction"].hitRating = 1.0
mb_config.statWeights["Warlock"]["Affliction"].hasteRating = 0.61
mb_config.statWeights["Warlock"]["Affliction"].attackPower = 0.0
mb_config.statWeights["Warlock"]["Affliction"].armor = 0.0
mb_config.statWeights["Warlock"]["Affliction"].blockValue = 0.0
mb_config.statWeights["Warlock"]["Affliction"].spellPower = 0.72
mb_config.statWeights["Warlock"]["Affliction"].mp5 = 0.0
mb_config.statWeights["Warlock"]["Affliction"].dps = 0.0
mb_config.statWeights["Warlock"]["Affliction"].socketMeta = 100
mb_config.statWeights["Warlock"]["Affliction"].socketColored = 16
-- Demonology
mb_config.statWeights["Warlock"]["Demonology"] = {}
mb_config.statWeights["Warlock"]["Demonology"].agility = 0.0
mb_config.statWeights["Warlock"]["Demonology"].intellect = 0.13
mb_config.statWeights["Warlock"]["Demonology"].spirit = 0.29
mb_config.statWeights["Warlock"]["Demonology"].strength = 0.0
mb_config.statWeights["Warlock"]["Demonology"].stamina = 0.01
mb_config.statWeights["Warlock"]["Demonology"].critRating = 0.31
mb_config.statWeights["Warlock"]["Demonology"].resilienceRating = 0.0
mb_config.statWeights["Warlock"]["Demonology"].defenseRating = 0.0
mb_config.statWeights["Warlock"]["Demonology"].expertiseRating = 0.0
mb_config.statWeights["Warlock"]["Demonology"].dodgeRating = 0.0
mb_config.statWeights["Warlock"]["Demonology"].parryRating = 0.0
mb_config.statWeights["Warlock"]["Demonology"].blockRating = 0.0
mb_config.statWeights["Warlock"]["Demonology"].armorPenetrationRating = 0.0
mb_config.statWeights["Warlock"]["Demonology"].hitRating = 1.0
mb_config.statWeights["Warlock"]["Demonology"].hasteRating = 0.50
mb_config.statWeights["Warlock"]["Demonology"].attackPower = 0.0
mb_config.statWeights["Warlock"]["Demonology"].armor = 0.0
mb_config.statWeights["Warlock"]["Demonology"].blockValue = 0.0
mb_config.statWeights["Warlock"]["Demonology"].spellPower = 0.8
mb_config.statWeights["Warlock"]["Demonology"].mp5 = 0.0
mb_config.statWeights["Warlock"]["Demonology"].dps = 0.0
mb_config.statWeights["Warlock"]["Demonology"].socketMeta = 100
mb_config.statWeights["Warlock"]["Demonology"].socketColored = 16





