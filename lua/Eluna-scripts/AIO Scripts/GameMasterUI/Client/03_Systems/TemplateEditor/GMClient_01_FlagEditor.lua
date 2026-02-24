local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return -- Exit if on server
end

-- Bit operations compatibility
local bit = bit or bit32 or {}
if not bit.band then
    -- Fallback bit operations for Lua 5.1 without bit library
    bit.band = function(a, b)
        local result = 0
        local bitval = 1
        while a > 0 and b > 0 do
            if a % 2 == 1 and b % 2 == 1 then
                result = result + bitval
            end
            bitval = bitval * 2
            a = math.floor(a / 2)
            b = math.floor(b / 2)
        end
        return result
    end
    
    bit.bor = function(a, b)
        local result = 0
        local bitval = 1
        while a > 0 or b > 0 do
            if a % 2 == 1 or b % 2 == 1 then
                result = result + bitval
            end
            bitval = bitval * 2
            a = math.floor(a / 2)
            b = math.floor(b / 2)
        end
        return result
    end
end

-- Initialize FlagEditor namespace
_G.FlagEditor = _G.FlagEditor or {}
local FlagEditor = _G.FlagEditor

-- Get UIStyleLibrary functions
local CreateStyledFrame = _G.CreateStyledFrame
local CreateStyledButton = _G.CreateStyledButton  
local CreateStyledCheckbox = _G.CreateStyledCheckbox
local CreateFullyStyledDropdown = _G.CreateFullyStyledDropdown
local CreateScrollableFrame = _G.CreateScrollableFrame

-- Flag definitions for each type
FlagEditor.FLAG_DEFINITIONS = {
    npcflag = {
        title = "NPC Flags",
        flags = {
            { bit = 0, value = 1, name = "Gossip", desc = "NPC has gossip dialog" },
            { bit = 1, value = 2, name = "Quest Giver", desc = "NPC can give quests" },
            { bit = 2, value = 4, name = "UNK1", desc = "Unknown flag 1" },
            { bit = 3, value = 8, name = "UNK2", desc = "Unknown flag 2" },
            { bit = 4, value = 16, name = "Trainer", desc = "NPC can train skills/spells" },
            { bit = 5, value = 32, name = "Trainer (Class)", desc = "Class trainer" },
            { bit = 6, value = 64, name = "Trainer (Profession)", desc = "Profession trainer" },
            { bit = 7, value = 128, name = "Vendor", desc = "NPC sells items" },
            { bit = 8, value = 256, name = "Vendor (Ammo)", desc = "Sells ammunition" },
            { bit = 9, value = 512, name = "Vendor (Food)", desc = "Sells food items" },
            { bit = 10, value = 1024, name = "Vendor (Poison)", desc = "Sells poisons" },
            { bit = 11, value = 2048, name = "Vendor (Reagent)", desc = "Sells reagents" },
            { bit = 12, value = 4096, name = "Repairer", desc = "Can repair items" },
            { bit = 13, value = 8192, name = "Flight Master", desc = "Flight path vendor" },
            { bit = 14, value = 16384, name = "Spirit Healer", desc = "Resurrects dead players" },
            { bit = 15, value = 32768, name = "Spirit Guide", desc = "Spirit guide NPC" },
            { bit = 16, value = 65536, name = "Innkeeper", desc = "Can bind hearthstone" },
            { bit = 17, value = 131072, name = "Banker", desc = "Access to bank" },
            { bit = 18, value = 262144, name = "Petitioner", desc = "Guild/Arena charter" },
            { bit = 19, value = 524288, name = "Tabard Designer", desc = "Guild tabard designer" },
            { bit = 20, value = 1048576, name = "Battlemaster", desc = "Battleground queue" },
            { bit = 21, value = 2097152, name = "Auctioneer", desc = "Auction house access" },
            { bit = 22, value = 4194304, name = "Stable Master", desc = "Pet stable access" },
            { bit = 23, value = 8388608, name = "Guild Banker", desc = "Guild bank access" },
            { bit = 24, value = 16777216, name = "Spellclick", desc = "Can be clicked for spell" },
        }
    },
    unit_flags = {
        title = "Unit Flags",
        flags = {
            { bit = 0, value = 1, name = "Server Controlled", desc = "Unit controlled by server" },
            { bit = 1, value = 2, name = "Non Attackable", desc = "Cannot be attacked" },
            { bit = 2, value = 4, name = "Remove Client Control", desc = "Client has no control" },
            { bit = 3, value = 8, name = "Player Controlled", desc = "Controlled by player" },
            { bit = 4, value = 16, name = "Rename", desc = "Can be renamed" },
            { bit = 5, value = 32, name = "Preparation", desc = "Don't take reagents" },
            { bit = 6, value = 64, name = "UNK 6", desc = "Unknown flag 6" },
            { bit = 7, value = 128, name = "Not Attackable 1", desc = "Not attackable variant 1" },
            { bit = 8, value = 256, name = "Immune to PC", desc = "Immune to player attacks" },
            { bit = 9, value = 512, name = "Immune to NPC", desc = "Immune to NPC attacks" },
            { bit = 10, value = 1024, name = "Looting", desc = "Loot animation" },
            { bit = 11, value = 2048, name = "Pet in Combat", desc = "Pet is in combat" },
            { bit = 12, value = 4096, name = "PVP", desc = "PVP flagged" },
            { bit = 13, value = 8192, name = "Silenced", desc = "Cannot cast spells" },
            { bit = 14, value = 16384, name = "UNK 14", desc = "Unknown flag 14" },
            { bit = 15, value = 32768, name = "UNK 15", desc = "Unknown flag 15" },
            { bit = 16, value = 65536, name = "UNK 16", desc = "Unknown flag 16" },
            { bit = 17, value = 131072, name = "Pacified", desc = "Cannot attack" },
            { bit = 18, value = 262144, name = "Stunned", desc = "Stunned state" },
            { bit = 19, value = 524288, name = "In Combat", desc = "Unit is in combat" },
            { bit = 20, value = 1048576, name = "Taxi Flight", desc = "On taxi/flight path" },
            { bit = 21, value = 2097152, name = "Disarmed", desc = "Weapons disabled" },
            { bit = 22, value = 4194304, name = "Confused", desc = "Confused state" },
            { bit = 23, value = 8388608, name = "Fleeing", desc = "Fleeing/feared" },
            { bit = 24, value = 16777216, name = "Player Controlled", desc = "Mind controlled by player" },
            { bit = 25, value = 33554432, name = "Not Selectable", desc = "Cannot be selected" },
            { bit = 26, value = 67108864, name = "Skinnable", desc = "Can be skinned" },
            { bit = 27, value = 134217728, name = "Mount", desc = "Is a mount" },
            { bit = 28, value = 268435456, name = "UNK 28", desc = "Unknown flag 28" },
            { bit = 29, value = 536870912, name = "UNK 29", desc = "Unknown flag 29" },
            { bit = 30, value = 1073741824, name = "Sheathe", desc = "Sheathe weapons" },
        }
    },
    unit_flags2 = {
        title = "Unit Flags 2",
        flags = {
            { bit = 0, value = 1, name = "Feign Death", desc = "Creature is feigning death" },
            { bit = 1, value = 2, name = "No Model", desc = "Hide unit model" },
            { bit = 2, value = 4, name = "Ignore Reputation", desc = "Ignore reputation when calculating aggro" },
            { bit = 3, value = 8, name = "Comprehend Lang", desc = "Unit can understand all languages" },
            { bit = 4, value = 16, name = "Mirror Image", desc = "Unit is a mirror image" },
            { bit = 5, value = 32, name = "Instantly Appear Model", desc = "Model appears instantly" },
            { bit = 6, value = 64, name = "Force Movement", desc = "Force movement" },
            { bit = 7, value = 128, name = "Disarm Offhand", desc = "Offhand weapon disabled" },
            { bit = 8, value = 256, name = "Disable Pred Stats", desc = "Disable predicted stats" },
            { bit = 9, value = 512, name = "Allow Changing Talents", desc = "Can change talents" },
            { bit = 10, value = 1024, name = "Disarm Ranged", desc = "Ranged weapon disabled" },
            { bit = 11, value = 2048, name = "Regenerate Power", desc = "Regenerate power/energy" },
            { bit = 12, value = 4096, name = "Restrict Party Interaction", desc = "Restrict party interaction" },
            { bit = 13, value = 8192, name = "Prevent Spell Click", desc = "Prevent spell click interactions" },
            { bit = 14, value = 16384, name = "Interact While Hostile", desc = "Can interact even if hostile" },
            { bit = 15, value = 32768, name = "Cannot Switch Targets", desc = "Cannot switch targets" },
            { bit = 16, value = 65536, name = "Unk 16", desc = "Unknown flag 16" },
            { bit = 17, value = 131072, name = "Unk 17", desc = "Unknown flag 17" },
            { bit = 18, value = 262144, name = "Allow Enemy Interact", desc = "Enemies can interact" },
            { bit = 19, value = 524288, name = "Disable Turn", desc = "Cannot turn" },
            { bit = 20, value = 1048576, name = "Unk 20", desc = "Unknown flag 20" },
            { bit = 21, value = 2097152, name = "Play Dead", desc = "Playing dead (different from feign death)" },
            { bit = 22, value = 4194304, name = "Hide Body", desc = "Hide body/corpse" },
            { bit = 23, value = 8388608, name = "Unk 23", desc = "Unknown flag 23" },
            { bit = 24, value = 16777216, name = "Unk 24", desc = "Unknown flag 24" },
            { bit = 25, value = 33554432, name = "Unk 25", desc = "Unknown flag 25" },
            { bit = 26, value = 67108864, name = "Unk 26", desc = "Unknown flag 26" },
            { bit = 27, value = 134217728, name = "Unk 27", desc = "Unknown flag 27" },
            { bit = 28, value = 268435456, name = "Unk 28", desc = "Unknown flag 28" },
            { bit = 29, value = 536870912, name = "Unk 29", desc = "Unknown flag 29" },
            { bit = 30, value = 1073741824, name = "Unk 30", desc = "Unknown flag 30" },
            { bit = 31, value = 2147483648, name = "Unk 31", desc = "Unknown flag 31" },
        }
    },
    dynamicflags = {
        title = "Dynamic Flags",
        flags = {
            { bit = 0, value = 1, name = "Lootable", desc = "Has loot" },
            { bit = 1, value = 2, name = "Track Unit", desc = "Creature is being tracked" },
            { bit = 2, value = 4, name = "Tapped", desc = "Already tapped by another player" },
            { bit = 3, value = 8, name = "Tapped By Player", desc = "Tapped by a player" },
            { bit = 4, value = 16, name = "Special Info", desc = "Show special info" },
            { bit = 5, value = 32, name = "Dead", desc = "Unit is dead" },
            { bit = 6, value = 64, name = "Refer A Friend", desc = "Refer-a-friend linked" },
            { bit = 7, value = 128, name = "Tapped By All Threat List", desc = "Tapped by all on threat list" },
        }
    },
    type_flags = {
        title = "Type Flags",
        flags = {
            { bit = 0, value = 1, name = "Tameable", desc = "Can be tamed by hunters" },
            { bit = 1, value = 2, name = "Ghost Visible", desc = "Visible to dead players" },
            { bit = 2, value = 4, name = "Boss", desc = "Boss level mob" },
            { bit = 3, value = 8, name = "Do Not Play Wound Anim", desc = "Don't play wound animation" },
            { bit = 4, value = 16, name = "Hide Faction Tooltip", desc = "Don't show faction in tooltip" },
            { bit = 5, value = 32, name = "UNK5", desc = "Unknown flag 5" },
            { bit = 6, value = 64, name = "Spell Attackable", desc = "Can be attacked with spells" },
            { bit = 7, value = 128, name = "Dead Interact", desc = "Can interact while dead" },
            { bit = 8, value = 256, name = "Herbloot", desc = "Can be herb looted" },
            { bit = 9, value = 512, name = "Miningloot", desc = "Can be mined" },
            { bit = 10, value = 1024, name = "Don't Log Death", desc = "Death not logged" },
            { bit = 11, value = 2048, name = "Mounted Combat", desc = "Can fight while mounted" },
            { bit = 12, value = 4096, name = "Aid Players", desc = "Can help players" },
            { bit = 13, value = 8192, name = "Is Pet Bar Used", desc = "Has pet bar when charmed" },
            { bit = 14, value = 16384, name = "Mask UID", desc = "Mask unit ID" },
            { bit = 15, value = 32768, name = "Engineerloot", desc = "Can be engineering looted" },
            { bit = 16, value = 65536, name = "Exotic", desc = "Exotic pet (requires Beast Mastery)" },
            { bit = 17, value = 131072, name = "Use Default Collision Box", desc = "Use default collision" },
            { bit = 18, value = 262144, name = "Is Siege Weapon", desc = "Siege weapon" },
            { bit = 19, value = 524288, name = "Projectile Collision", desc = "Can collide with projectiles" },
            { bit = 20, value = 1048576, name = "Hide Name Plate", desc = "Hide nameplate" },
            { bit = 21, value = 2097152, name = "Do Not Play Mount Anim", desc = "Don't play mount animation" },
            { bit = 22, value = 4194304, name = "Is Link All", desc = "Linked to all difficulties" },
            { bit = 23, value = 8388608, name = "Interact Only With Creator", desc = "Only creator can interact" },
            { bit = 24, value = 16777216, name = "Force Gossip", desc = "Force gossip activation" },
        }
    },
    flags = {
        title = "GameObject Flags",
        flags = {
            { bit = 0, value = 1, name = "IN_USE", desc = "Gameobject in use - Disables interaction while being animated" },
            { bit = 1, value = 2, name = "LOCKED", desc = "Makes the Gameobject Locked. Requires a key, spell, or event to be opened" },
            { bit = 2, value = 4, name = "INTERACT_COND", desc = "Untargetable, cannot interact (requires GO_DYNFLAG_LO_ACTIVATE to enable)" },
            { bit = 3, value = 8, name = "TRANSPORT", desc = "Gameobject can transport (boat, elevator, car)" },
            { bit = 4, value = 16, name = "NOT_SELECTABLE", desc = "Not selectable (Not even in GM-mode)" },
            { bit = 5, value = 32, name = "NODESPAWN", desc = "Never despawns. Typical for gameobjects with on/off state (doors)" },
            { bit = 6, value = 64, name = "AI_OBSTACLE", desc = "Registers in AIObstacleMgr (unknown functionality)" },
            { bit = 7, value = 128, name = "FREEZE_ANIMATION", desc = "Freezes animation" },
            { bit = 9, value = 512, name = "DAMAGED", desc = "Gameobject has been siege damaged" },
            { bit = 10, value = 1024, name = "DESTROYED", desc = "Gameobject has been destroyed" },
        }
    },
    flags_extra = {
        title = "Extra Flags",
        flags = {
            { bit = 0, value = 1, name = "Instance Bind", desc = "Creature binds players to instance" },
            { bit = 1, value = 2, name = "Civilian", desc = "Creature is civilian (dishonorable kill)" },
            { bit = 2, value = 4, name = "No Parry", desc = "Cannot parry attacks" },
            { bit = 3, value = 8, name = "No Parry Hasten", desc = "No parry haste" },
            { bit = 4, value = 16, name = "No Block", desc = "Cannot block attacks" },
            { bit = 5, value = 32, name = "No Crush", desc = "Cannot do crushing blows" },
            { bit = 6, value = 64, name = "No XP at Kill", desc = "No experience from kill" },
            { bit = 7, value = 128, name = "Trigger", desc = "Trigger NPC (invisible)" },
            { bit = 8, value = 256, name = "No Taunt", desc = "Cannot be taunted" },
            { bit = 9, value = 512, name = "No Move Flags Update", desc = "Movement flags not updated" },
            { bit = 10, value = 1024, name = "Ghost Visibility", desc = "Visible as ghost" },
            { bit = 11, value = 2048, name = "Use Offhand Attack", desc = "Uses offhand attacks" },
            { bit = 12, value = 4096, name = "No Sell Vendor", desc = "Players can't sell to this vendor" },
            { bit = 13, value = 8192, name = "Ignore Pathfinding", desc = "Ignores pathfinding" },
            { bit = 14, value = 16384, name = "Immunity Knockback", desc = "Immune to knockback" },
            { bit = 15, value = 32768, name = "Ignore Combat", desc = "Ignored in combat calculations" },
            { bit = 16, value = 65536, name = "Worldevent", desc = "Active during world events only" },
            { bit = 17, value = 131072, name = "Guard", desc = "Is a guard NPC" },
            { bit = 18, value = 262144, name = "Ignore Feign Death", desc = "Ignores feign death" },
            { bit = 19, value = 524288, name = "No Crit", desc = "Cannot be critically hit" },
            { bit = 20, value = 1048576, name = "No Skill Gain", desc = "No skill gain from fighting" },
            { bit = 21, value = 2097152, name = "Taunt Diminish", desc = "Taunt immunity after 5 taunts" },
            { bit = 22, value = 4194304, name = "All Diminish", desc = "All CC subject to diminishing returns" },
            { bit = 23, value = 8388608, name = "Log Kill Credit Only", desc = "Kill credit but no loot/xp" },
            { bit = 24, value = 16777216, name = "Dual Wield Forced", desc = "Forced to dual wield" },
            { bit = 25, value = 33554432, name = "No Player Damage Req", desc = "No player damage requirement" },
            { bit = 26, value = 67108864, name = "Unused 26", desc = "Unused flag 26" },
            { bit = 27, value = 134217728, name = "Unused 27", desc = "Unused flag 27" },
            { bit = 28, value = 268435456, name = "Dungeon Boss", desc = "Dungeon boss (requires special kill)" },
            { bit = 29, value = 536870912, name = "Ignore Stat Scaling", desc = "Ignore stat scaling in dungeons" },
            { bit = 30, value = 1073741824, name = "No Avoid", desc = "Cannot dodge/parry/block" },
        }
    },
    
    -- ====================
    -- ITEM FLAGS
    -- ====================
    
    Flags = {
        title = "Item Flags",
        flags = {
            { bit = 0, value = 1, name = "No Pickup", desc = "Item cannot be picked up" },
            { bit = 1, value = 2, name = "Conjured", desc = "Item is conjured" },
            { bit = 2, value = 4, name = "Has Loot", desc = "Item has loot (can be opened)" },
            { bit = 3, value = 8, name = "Heroic Tooltip", desc = "Show heroic tooltip" },
            { bit = 4, value = 16, name = "Deprecated", desc = "Item is deprecated" },
            { bit = 5, value = 32, name = "No User Destroy", desc = "Cannot be destroyed by player" },
            { bit = 6, value = 64, name = "Player Cast", desc = "Player cast spell (not item cast)" },
            { bit = 7, value = 128, name = "No Equip Cooldown", desc = "No cooldown when equipped" },
            { bit = 8, value = 256, name = "Multi Loot Quest", desc = "Multiple quest loot" },
            { bit = 9, value = 512, name = "Is Wrapper", desc = "Item is a wrapper (gift)" },
            { bit = 10, value = 1024, name = "Uses Resources", desc = "Uses resources" },
            { bit = 11, value = 2048, name = "Multi Drop", desc = "Multiple drop" },
            { bit = 12, value = 4096, name = "Item Can Be Charged", desc = "Item can be charged" },
            { bit = 13, value = 8192, name = "No Disenchant", desc = "Cannot be disenchanted" },
            { bit = 14, value = 16384, name = "No Sell Price", desc = "No vendor sell price" },
            { bit = 15, value = 32768, name = "Not Disenchantable", desc = "Cannot be disenchanted (different from No Disenchant)" },
            { bit = 16, value = 65536, name = "Real Time Duration", desc = "Duration counts in real time" },
            { bit = 17, value = 131072, name = "No Creator", desc = "Don't show creator name" },
            { bit = 18, value = 262144, name = "Is Prospectable", desc = "Can be prospected" },
            { bit = 19, value = 524288, name = "Unique Equippable", desc = "Unique equipped" },
            { bit = 20, value = 1048576, name = "Ignore For Auras", desc = "Ignore for auras" },
            { bit = 21, value = 2097152, name = "Ignore Default Arena Restrictions", desc = "Ignore arena restrictions" },
            { bit = 22, value = 4194304, name = "No Durability Loss", desc = "No durability loss" },
            { bit = 23, value = 8388608, name = "Use When Shapeshifted", desc = "Can use when shapeshifted" },
            { bit = 24, value = 16777216, name = "Has Quest Glow", desc = "Has quest glow effect" },
            { bit = 25, value = 33554432, name = "Hide Unusable Recipe", desc = "Hide unusable recipe" },
            { bit = 26, value = 67108864, name = "Not Useable in Arena", desc = "Cannot use in arena" },
            { bit = 27, value = 134217728, name = "Is Bound to Account", desc = "Bound to account" },
            { bit = 28, value = 268435456, name = "No Reagent Cost", desc = "No reagent cost for enchanting" },
            { bit = 29, value = 536870912, name = "Is Millable", desc = "Can be milled" },
            { bit = 30, value = 1073741824, name = "Report to Guild News", desc = "Report to guild news" },
            { bit = 31, value = 2147483648, name = "No Progressive Loot", desc = "No progressive loot" },
        }
    },
    
    FlagsExtra = {
        title = "Item Extra Flags",
        flags = {
            { bit = 0, value = 1, name = "Horde Only", desc = "Usable by Horde only" },
            { bit = 1, value = 2, name = "Alliance Only", desc = "Usable by Alliance only" },
            { bit = 2, value = 4, name = "Ext Cost Requires Gold", desc = "Extended cost requires gold" },
            { bit = 3, value = 8, name = "Neutral Disenchant", desc = "Neutral faction can disenchant" },
            { bit = 4, value = 16, name = "Real Time Duration", desc = "Duration in real time" },
            { bit = 5, value = 32, name = "No Bind", desc = "No binding" },
            { bit = 6, value = 64, name = "Has Loot", desc = "Has loot table" },
            { bit = 7, value = 128, name = "Has Normal Price", desc = "Has normal vendor price" },
            { bit = 8, value = 256, name = "Bnet Account Bound", desc = "Bound to Battle.net account" },
            { bit = 9, value = 512, name = "Cannot Upgrade", desc = "Cannot be upgraded" },
            { bit = 10, value = 1024, name = "Cannot Disenchant", desc = "Cannot be disenchanted" },
            { bit = 11, value = 2048, name = "Cannot Scout", desc = "Cannot scout" },
            { bit = 12, value = 4096, name = "Cannot Roll Greed", desc = "Cannot roll greed" },
        }
    },
    
    BagFamily = {
        title = "Bag Family",
        flags = {
            { bit = 0, value = 1, name = "Arrows", desc = "Can hold arrows" },
            { bit = 1, value = 2, name = "Bullets", desc = "Can hold bullets" },
            { bit = 2, value = 4, name = "Soul Shards", desc = "Can hold soul shards" },
            { bit = 3, value = 8, name = "Leatherworking Supplies", desc = "Can hold leatherworking supplies" },
            { bit = 4, value = 16, name = "Inscription Supplies", desc = "Can hold inscription supplies" },
            { bit = 5, value = 32, name = "Herbs", desc = "Can hold herbs" },
            { bit = 6, value = 64, name = "Enchanting Supplies", desc = "Can hold enchanting supplies" },
            { bit = 7, value = 128, name = "Engineering Supplies", desc = "Can hold engineering supplies" },
            { bit = 8, value = 256, name = "Keys", desc = "Can hold keys" },
            { bit = 9, value = 512, name = "Gems", desc = "Can hold gems" },
            { bit = 10, value = 1024, name = "Mining Supplies", desc = "Can hold mining supplies" },
            { bit = 11, value = 2048, name = "Soulbound Equipment", desc = "Can hold soulbound equipment" },
            { bit = 12, value = 4096, name = "Vanity Pets", desc = "Can hold vanity pets" },
            { bit = 13, value = 8192, name = "Currency Tokens", desc = "Can hold currency tokens" },
            { bit = 14, value = 16384, name = "Quest Items", desc = "Can hold quest items" },
        }
    },
    
    AllowableClass = {
        title = "Allowable Classes",
        flags = {
            { bit = 0, value = 1, name = "Warrior", desc = "Usable by Warriors" },
            { bit = 1, value = 2, name = "Paladin", desc = "Usable by Paladins" },
            { bit = 2, value = 4, name = "Hunter", desc = "Usable by Hunters" },
            { bit = 3, value = 8, name = "Rogue", desc = "Usable by Rogues" },
            { bit = 4, value = 16, name = "Priest", desc = "Usable by Priests" },
            { bit = 5, value = 32, name = "Death Knight", desc = "Usable by Death Knights" },
            { bit = 6, value = 64, name = "Shaman", desc = "Usable by Shamans" },
            { bit = 7, value = 128, name = "Mage", desc = "Usable by Mages" },
            { bit = 8, value = 256, name = "Warlock", desc = "Usable by Warlocks" },
            { bit = 9, value = 512, name = "Druid", desc = "Usable by Druids" },
        }
    },
    
    AllowableRace = {
        title = "Allowable Races",
        flags = {
            { bit = 0, value = 1, name = "Human", desc = "Usable by Humans" },
            { bit = 1, value = 2, name = "Orc", desc = "Usable by Orcs" },
            { bit = 2, value = 4, name = "Dwarf", desc = "Usable by Dwarfs" },
            { bit = 3, value = 8, name = "Night Elf", desc = "Usable by Night Elfs" },
            { bit = 4, value = 16, name = "Undead", desc = "Usable by Undeads" },
            { bit = 5, value = 32, name = "Tauren", desc = "Usable by Taurens" },
            { bit = 6, value = 64, name = "Gnome", desc = "Usable by Gnomes" },
            { bit = 7, value = 128, name = "Troll", desc = "Usable by Trolls" },
            { bit = 8, value = 256, name = "Goblin", desc = "Usable by Goblins" },
            { bit = 9, value = 512, name = "Blood Elf", desc = "Usable by Blood Elfs" },
            { bit = 10, value = 1024, name = "Draenei", desc = "Usable by Draenei" },
        }
    },
    mechanic_immune_mask = {
        title = "Mechanic Immunities",
        flags = {
            { bit = 0, value = 1, name = "Charm", desc = "Immune to charm" },
            { bit = 1, value = 2, name = "Disoriented", desc = "Immune to disorient" },
            { bit = 2, value = 4, name = "Disarm", desc = "Immune to disarm" },
            { bit = 3, value = 8, name = "Distract", desc = "Immune to distract" },
            { bit = 4, value = 16, name = "Fear", desc = "Immune to fear" },
            { bit = 5, value = 32, name = "Grip", desc = "Immune to death grip" },
            { bit = 6, value = 64, name = "Root", desc = "Immune to root" },
            { bit = 7, value = 128, name = "Slow Attack", desc = "Immune to attack speed debuffs" },
            { bit = 8, value = 256, name = "Silence", desc = "Immune to silence" },
            { bit = 9, value = 512, name = "Sleep", desc = "Immune to sleep" },
            { bit = 10, value = 1024, name = "Snare", desc = "Immune to snare/slow" },
            { bit = 11, value = 2048, name = "Stun", desc = "Immune to stun" },
            { bit = 12, value = 4096, name = "Freeze", desc = "Immune to freeze" },
            { bit = 13, value = 8192, name = "Knockout", desc = "Immune to knockout" },
            { bit = 14, value = 16384, name = "Bleed", desc = "Immune to bleed" },
            { bit = 15, value = 32768, name = "Bandage", desc = "Immune to bandage" },
            { bit = 16, value = 65536, name = "Polymorph", desc = "Immune to polymorph" },
            { bit = 17, value = 131072, name = "Banish", desc = "Immune to banish" },
            { bit = 18, value = 262144, name = "Shield", desc = "Immune to shield" },
            { bit = 19, value = 524288, name = "Shackle", desc = "Immune to shackle" },
            { bit = 20, value = 1048576, name = "Mount", desc = "Immune to mount" },
            { bit = 21, value = 2097152, name = "Infected", desc = "Immune to infected" },
            { bit = 22, value = 4194304, name = "Turn", desc = "Immune to turn undead" },
            { bit = 23, value = 8388608, name = "Horror", desc = "Immune to horror" },
            { bit = 24, value = 16777216, name = "Invulnerability", desc = "Immune to invulnerability" },
            { bit = 25, value = 33554432, name = "Interrupt", desc = "Immune to interrupt" },
            { bit = 26, value = 67108864, name = "Daze", desc = "Immune to daze" },
            { bit = 27, value = 134217728, name = "Discovery", desc = "Immune to discovery" },
            { bit = 28, value = 268435456, name = "Immune Shield", desc = "Immune to immune shield" },
            { bit = 29, value = 536870912, name = "Sapped", desc = "Immune to sap" },
            { bit = 30, value = 1073741824, name = "Enraged", desc = "Immune to enrage removal" },
        }
    },
    spell_school_immune_mask = {
        title = "Spell School Immunities",
        flags = {
            { bit = 0, value = 1, name = "Physical", desc = "Immune to physical damage" },
            { bit = 1, value = 2, name = "Holy", desc = "Immune to holy damage" },
            { bit = 2, value = 4, name = "Fire", desc = "Immune to fire damage" },
            { bit = 3, value = 8, name = "Nature", desc = "Immune to nature damage" },
            { bit = 4, value = 16, name = "Frost", desc = "Immune to frost damage" },
            { bit = 5, value = 32, name = "Shadow", desc = "Immune to shadow damage" },
            { bit = 6, value = 64, name = "Arcane", desc = "Immune to arcane damage" },
        }
    },
    gameobject_flags = {
        title = "GameObject Flags",
        flags = {
            { bit = 0, value = 1, name = "In Use", desc = "Disables interaction while being animated" },
            { bit = 1, value = 2, name = "Locked", desc = "Requires key/spell/event to open - shows 'Locked' in tooltip" },
            { bit = 2, value = 4, name = "Interact Condition", desc = "Cannot interact - requires GO_DYNFLAG_LO_ACTIVATE for client interaction" },
            { bit = 3, value = 8, name = "Transport", desc = "GameObject can transport (boat, elevator, car)" },
            { bit = 4, value = 16, name = "Not Selectable", desc = "Not selectable (not even in GM mode)" },
            { bit = 5, value = 32, name = "No Despawn", desc = "Never despawns - typical for doors and objects with on/off state" },
            { bit = 6, value = 64, name = "AI Obstacle", desc = "Registers object in AIObstacleMgr" },
            { bit = 7, value = 128, name = "Freeze Animation", desc = "Freezes the animation" },
            { bit = 9, value = 512, name = "Damaged", desc = "GameObject has been siege damaged" },
            { bit = 10, value = 1024, name = "Destroyed", desc = "GameObject has been destroyed" },
        }
    },
    VisFlags = {
        title = "Visibility Flags",
        flags = {
            { bit = 0, value = 1, name = "Unknown 1", desc = "Unknown visibility flag" },
            { bit = 1, value = 2, name = "Creep", desc = "Creature moves in creep mode" },
            { bit = 2, value = 4, name = "Untrackable", desc = "Cannot be tracked" },
        }
    },
    PvPFlags = {
        title = "PvP Flags",
        flags = {
            { bit = 0, value = 1, name = "PvP", desc = "Creature is PvP flagged" },
            { bit = 1, value = 2, name = "Unknown", desc = "Unknown PvP flag" },
            { bit = 2, value = 4, name = "FFA PvP", desc = "Free-for-all PvP enabled" },
            { bit = 3, value = 8, name = "Sanctuary", desc = "In sanctuary (no PvP)" },
        }
    }
}

-- Preset templates for common NPC types
FlagEditor.PRESETS = {
    npcflag = {
        { name = "Vendor", value = 128, desc = "Basic vendor" },
        { name = "Repair Vendor", value = 4224, desc = "Vendor with repair" }, -- 128 + 4096
        { name = "Quest Giver", value = 2, desc = "Gives quests" },
        { name = "Trainer", value = 16, desc = "Skill/spell trainer" },
        { name = "Flight Master", value = 8192, desc = "Flight path vendor" },
        { name = "Innkeeper", value = 65536, desc = "Hearthstone binder" },
        { name = "Banker", value = 131072, desc = "Bank access" },
        { name = "Auctioneer", value = 2097152, desc = "Auction house" },
        { name = "Stable Master", value = 4194304, desc = "Pet stable" },
        { name = "Full Service Vendor", value = 4354, desc = "Vendor + Repair + Gossip" }, -- 128 + 4096 + 1 + 1
    },
    unit_flags = {
        { name = "Non-Attackable", value = 258, desc = "Cannot be attacked" }, -- 2 + 256
        { name = "Friendly NPC", value = 768, desc = "Immune to players" }, -- 256 + 512
        { name = "Not Selectable", value = 33554432, desc = "Cannot be targeted" },
        { name = "Standard NPC", value = 0, desc = "No special flags" },
        { name = "Quest NPC", value = 2, desc = "Quest related NPC" },
    },
    type_flags = {
        { name = "Beast (Tameable)", value = 1, desc = "Hunter pet" },
        { name = "Herb Node", value = 256, desc = "Herbalism node" },
        { name = "Mining Node", value = 512, desc = "Mining node" },
        { name = "Engineering Node", value = 32768, desc = "Engineering salvage" },
        { name = "Boss", value = 4, desc = "Boss mob" },
        { name = "Rare Elite", value = 4, desc = "Rare spawn elite" },
    },
    flags_extra = {
        { name = "Civilian", value = 2, desc = "Protected NPC" },
        { name = "World Boss", value = 1073741824, desc = "Raid boss" }, -- No Avoid flag
        { name = "Dungeon Boss", value = 268435456, desc = "5-man boss" },
        { name = "Guard", value = 131072, desc = "City guard" },
        { name = "Training Dummy", value = 262144, desc = "Ignores combat" },
    },
    unit_flags2 = {
        { name = "Standard", value = 0, desc = "No special flags" },
        { name = "Feign Death", value = 1, desc = "Creature feigning death" },
        { name = "Hide Model", value = 2, desc = "Model is hidden" },
        { name = "Mirror Image", value = 16, desc = "Mirror image clone" },
        { name = "Can't Turn", value = 524288, desc = "Cannot turn or rotate" },
        { name = "Regenerate Power", value = 2048, desc = "Regenerates power" },
    },
    dynamicflags = {
        { name = "None", value = 0, desc = "No dynamic flags" },
        { name = "Lootable", value = 1, desc = "Has loot to be looted" },
        { name = "Tapped", value = 4, desc = "Already tapped" },
        { name = "Dead", value = 32, desc = "Unit is dead" },
        { name = "Lootable + Dead", value = 33, desc = "Dead with loot" },
    },
    mechanic_immune_mask = {
        { name = "None", value = 0, desc = "No immunities" },
        { name = "CC Immune", value = 13019, desc = "Immune to most CC (Charm, Fear, Root, Silence, Sleep, Snare, Stun)" }, -- 1+2+8+16+64+256+512+1024+2048+8192
        { name = "Boss Standard", value = 650854399, desc = "Standard boss immunities" }, -- Common boss immunities
        { name = "Undead", value = 8388608, desc = "Immune to horror" },
        { name = "Mechanical", value = 8389120, desc = "Immune to bleed and horror" }, -- 16384 + 8388608 + 512
        { name = "Elemental", value = 16908800, desc = "Immune to bleed, poison, sleep" }, -- 16384 + 512 + 16777216
        { name = "Charm Immune", value = 1, desc = "Immune to charm effects" },
        { name = "Fear Immune", value = 16, desc = "Immune to fear effects" },
        { name = "Stun Immune", value = 2048, desc = "Immune to stun effects" },
        { name = "Root Immune", value = 64, desc = "Immune to root effects" },
        { name = "Silence Immune", value = 256, desc = "Immune to silence effects" },
        { name = "Sleep Immune", value = 512, desc = "Immune to sleep effects" },
        { name = "Snare Immune", value = 1024, desc = "Immune to snare effects" },
        { name = "Disarm Immune", value = 4, desc = "Immune to disarm effects" },
        { name = "PvP Trinket", value = 65, desc = "Removes Root and Charm" }, -- 1 + 64
        { name = "All Immunities", value = 1073741823, desc = "Immune to all mechanics" }, -- All bits except bit 31
    },
    spell_school_immune_mask = {
        { name = "None", value = 0, desc = "No school immunities" },
        { name = "All Magic", value = 126, desc = "Immune to all magic schools" }, -- 2+4+8+16+32+64
        { name = "Fire Elemental", value = 124, desc = "Immune to Fire, Frost, Nature, Arcane" }, -- 4+8+16+64+32
        { name = "Water Elemental", value = 118, desc = "Immune to Fire, Holy, Shadow, Arcane" }, -- 2+4+32+64+16
        { name = "Nature Elemental", value = 98, desc = "Immune to Fire, Frost, Shadow, Arcane" }, -- 2+32+64
        { name = "Shadow Being", value = 95, desc = "Immune to Holy, Physical, all but Shadow" }, -- 1+2+4+8+16+64
        { name = "Holy Being", value = 125, desc = "Immune to Shadow, all but Holy" }, -- 1+4+8+16+32+64
        { name = "Physical Only", value = 126, desc = "Immune to all magic damage" }, -- All magic schools
        { name = "Anti-Magic", value = 126, desc = "Magic immunity shield" }, -- All magic schools
        { name = "Fire Immune", value = 4, desc = "Immune to fire damage only" },
        { name = "Frost Immune", value = 16, desc = "Immune to frost damage only" },
        { name = "Nature Immune", value = 8, desc = "Immune to nature damage only" },
        { name = "Shadow Immune", value = 32, desc = "Immune to shadow damage only" },
        { name = "Arcane Immune", value = 64, desc = "Immune to arcane damage only" },
        { name = "Holy Immune", value = 2, desc = "Immune to holy damage only" },
        { name = "Physical Immune", value = 1, desc = "Immune to physical damage only" },
    },
    VisFlags = {
        { name = "None", value = 0, desc = "No special visibility flags" },
        { name = "Creep", value = 2, desc = "Creature moves in creep mode" },
        { name = "Untrackable", value = 4, desc = "Cannot be tracked" },
        { name = "Creep + Untrackable", value = 6, desc = "Creep mode and untrackable" },
    },
    PvPFlags = {
        { name = "None", value = 0, desc = "No PvP flags" },
        { name = "PvP Enabled", value = 1, desc = "Creature is PvP flagged" },
        { name = "FFA PvP", value = 4, desc = "Free-for-all PvP" },
        { name = "Sanctuary", value = 8, desc = "Protected by sanctuary" },
    },
    gameobject_flags = {
        { name = "None", value = 0, desc = "No flags" },
        { name = "Locked", value = 2, desc = "Locked - requires key/spell/event" },
        { name = "Not Selectable", value = 16, desc = "Cannot be selected" },
        { name = "No Despawn", value = 32, desc = "Never despawns" },
        { name = "Transport", value = 8, desc = "Transport (boat, elevator)" },
        { name = "Damaged", value = 512, desc = "Siege damaged" },
        { name = "Destroyed", value = 1024, desc = "Destroyed" },
        { name = "Locked Door", value = 34, desc = "Locked door that never despawns" }, -- 2 + 32
        { name = "Quest Object", value = 48, desc = "Quest object that cannot be selected and never despawns" }, -- 16 + 32
        { name = "Interactive", value = 0, desc = "Fully interactive object" },
        { name = "In Use", value = 1, desc = "Currently being used/animated" },
    }
}

-- Current state
FlagEditor.currentFlagType = nil
FlagEditor.currentValue = 0
FlagEditor.callback = nil
FlagEditor.isOpen = false

-- Create the flag editor dialog
function FlagEditor.CreateDialog()
    if FlagEditor.frame then
        return FlagEditor.frame
    end
    
    -- Main frame
    local frame = CreateFrame("Frame", "FlagEditorFrame", UIParent)
    frame:SetSize(500, 600)
    frame:SetPoint("CENTER", 0, 0)
    frame:SetFrameStrata("DIALOG")
    frame:SetFrameLevel(100)
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    frame:Hide()
    
    -- Apply UIStyleLibrary styling
    if _G.CreateStyledFrame then
        local styledBg = _G.CreateStyledFrame(frame, _G.UISTYLE_COLORS.DarkGrey)
        styledBg:SetAllPoints()
        styledBg:SetFrameLevel(frame:GetFrameLevel() - 1)
    else
        print("|cFFFF0000[FlagEditor] Warning: UIStyleLibrary not loaded|r")
    end
    
    -- Title bar
    local titleBar = CreateFrame("Frame", nil, frame)
    titleBar:SetHeight(32)
    titleBar:SetPoint("TOPLEFT", 8, -8)
    titleBar:SetPoint("TOPRIGHT", -8, -8)
    
    local title = titleBar:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("CENTER")
    title:SetText("Flag Editor")
    title:SetTextColor(UISTYLE_COLORS.White[1], UISTYLE_COLORS.White[2], UISTYLE_COLORS.White[3], 1)
    frame.title = title
    
    -- Close button using UIStyleLibrary (consistent with other GameMasterUI windows)
    local closeBtn = FlagEditor.CreateButton(titleBar, "X", 24, 24)
    closeBtn:SetPoint("TOPRIGHT", titleBar, "TOPRIGHT", -5, -3)
    closeBtn:SetScript("OnClick", function()
        FlagEditor.Close()
    end)
    
    -- Value display
    local valueFrame = CreateFrame("Frame", nil, frame)
    valueFrame:SetHeight(30)
    valueFrame:SetPoint("TOPLEFT", 10, -45)
    valueFrame:SetPoint("TOPRIGHT", -10, -45)
    
    local valueLabel = valueFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    valueLabel:SetPoint("LEFT", 5, 0)
    valueLabel:SetText("Current Value:")
    valueLabel:SetTextColor(UISTYLE_COLORS.White[1], UISTYLE_COLORS.White[2], UISTYLE_COLORS.White[3], 1)
    
    local valueText = valueFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    valueText:SetPoint("LEFT", valueLabel, "RIGHT", 10, 0)
    valueText:SetText("0")
    frame.valueText = valueText
    
    local hexText = valueFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal") 
    hexText:SetPoint("LEFT", valueText, "RIGHT", 10, 0)
    hexText:SetTextColor(UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3], 1)
    hexText:SetText("(0x0)")
    frame.hexText = hexText
    
    -- Preset dropdown
    local presetFrame = CreateFrame("Frame", nil, frame)
    presetFrame:SetHeight(30)
    presetFrame:SetPoint("TOPLEFT", 10, -75)
    presetFrame:SetPoint("TOPRIGHT", -10, -75)
    
    local presetLabel = presetFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    presetLabel:SetPoint("LEFT", 5, 0)
    presetLabel:SetText("Presets:")
    presetLabel:SetTextColor(UISTYLE_COLORS.White[1], UISTYLE_COLORS.White[2], UISTYLE_COLORS.White[3], 1)
    
    -- Create styled dropdown instead of UIDropDownMenuTemplate
    local presetItems = {}
    frame.presetDropdown = CreateFullyStyledDropdown(presetFrame, 200, presetItems, "Select preset...", 
        function(value, item)
            if value == -1 then
                -- Custom selected, do nothing
            else
                FlagEditor.ApplyPreset(value)
            end
        end
    )
    frame.presetDropdown:SetPoint("LEFT", presetLabel, "RIGHT", 10, 0)
    
    -- Scroll frame for checkboxes using UIStyleLibrary if available
    local content, scrollBar, updateScrollBar
    if _G.CreateScrollableFrame then
        local container
        container, content, scrollBar, updateScrollBar = _G.CreateScrollableFrame(frame, 460, 430)
        container:SetPoint("TOPLEFT", 10, -110)
        container:SetPoint("BOTTOMRIGHT", -10, 50)
        frame.updateScrollBar = updateScrollBar
    else
        -- Fallback to standard scroll frame
        local scrollFrame = CreateFrame("ScrollFrame", "FlagEditorScrollFrame", frame, "UIPanelScrollFrameTemplate")
        scrollFrame:SetPoint("TOPLEFT", 10, -110)
        scrollFrame:SetPoint("BOTTOMRIGHT", -30, 50)
        
        content = CreateFrame("Frame", nil, scrollFrame)
        content:SetSize(450, 800)
        scrollFrame:SetScrollChild(content)
    end
    frame.content = content
    
    -- Button container
    local buttonContainer = CreateFrame("Frame", nil, frame)
    buttonContainer:SetHeight(40)
    buttonContainer:SetPoint("BOTTOMLEFT", 10, 10)
    buttonContainer:SetPoint("BOTTOMRIGHT", -10, 10)
    
    -- OK button
    local okBtn = FlagEditor.CreateButton(buttonContainer, "OK", 80, 30)
    okBtn:SetPoint("RIGHT", buttonContainer, "CENTER", -10, 0)
    okBtn:SetScript("OnClick", function()
        FlagEditor.Save()
    end)
    
    -- Cancel button
    local cancelBtn = FlagEditor.CreateButton(buttonContainer, "Cancel", 80, 30)
    cancelBtn:SetPoint("LEFT", buttonContainer, "CENTER", 10, 0)
    cancelBtn:SetScript("OnClick", function()
        FlagEditor.Close()
    end)
    
    -- Clear button
    local clearBtn = FlagEditor.CreateButton(buttonContainer, "Clear All", 70, 25)
    clearBtn:SetPoint("LEFT", 10, 0)
    clearBtn:SetScript("OnClick", function()
        FlagEditor.ClearAll()
    end)
    
    -- Info button
    local infoBtn = FlagEditor.CreateButton(buttonContainer, "?", 25, 25)
    infoBtn:SetPoint("RIGHT", -10, 0)
    infoBtn:SetScript("OnClick", function()
        FlagEditor.ShowHelp()
    end)
    
    FlagEditor.frame = frame
    return frame
end

-- Create a styled button
function FlagEditor.CreateButton(parent, text, width, height)
    if _G.CreateStyledButton then
        return _G.CreateStyledButton(parent, text, width, height)
    else
        print("|cFFFF0000[FlagEditor] Warning: CreateStyledButton not available|r")
        -- Basic fallback
        local button = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
        button:SetSize(width or 100, height or 30)
        button:SetText(text)
        return button
    end
end

-- Create checkbox for a flag
function FlagEditor.CreateCheckbox(parent, flag, yOffset)
    -- Create container frame for positioning
    local container = CreateFrame("Frame", nil, parent)
    container:SetHeight(24)
    container:SetPoint("TOPLEFT", 10, yOffset)
    container:SetPoint("TOPRIGHT", -10, yOffset)
    
    -- Create styled checkbox with flag name
    local checkboxText = string.format("%s (%d)", flag.name, flag.value)
    local checkbox = CreateStyledCheckbox(container, checkboxText)
    checkbox:SetPoint("TOPLEFT", 0, 0)
    checkbox:SetPoint("TOPRIGHT", 0, 0)
    checkbox.flag = flag
    
    -- Tooltip
    checkbox:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(flag.name, UISTYLE_COLORS.White[1], UISTYLE_COLORS.White[2], UISTYLE_COLORS.White[3])
        GameTooltip:AddLine(flag.desc, UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3], true)
        GameTooltip:AddLine(string.format("Value: %d (0x%X)", flag.value, flag.value), UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3])
        GameTooltip:AddLine(string.format("Bit: %d", flag.bit), UISTYLE_COLORS.TextGrey[1], UISTYLE_COLORS.TextGrey[2], UISTYLE_COLORS.TextGrey[3])
        GameTooltip:Show()
    end)
    checkbox:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    
    -- Override the click handler to also update flag values
    local originalOnClick = checkbox:GetScript("OnClick")
    checkbox:SetScript("OnClick", function(self)
        -- Call original checkbox behavior first
        if originalOnClick then
            originalOnClick(self)
        end
        -- Then update flag editor values
        FlagEditor.UpdateValue()
    end)
    
    -- Store reference to the styled checkbox for easier access
    container.checkbox = checkbox
    return container
end

-- Populate checkboxes for current flag type
function FlagEditor.PopulateFlags()
    local content = FlagEditor.frame.content
    local flagDef = FlagEditor.FLAG_DEFINITIONS[FlagEditor.currentFlagType]
    
    if not flagDef then
        return
    end
    
    -- Clean up previous checkboxes
    if content.checkboxes then
        for _, checkboxContainer in ipairs(content.checkboxes) do
            checkboxContainer:Hide()
            checkboxContainer:ClearAllPoints()
            -- Move off-screen to prevent visual overlap
            checkboxContainer:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -5000, 5000)
        end
    end
    
    -- Clean up all child frames
    for _, child in ipairs({content:GetChildren()}) do
        if child ~= content.headerText then -- Don't remove the header text frame
            child:Hide()
            child:ClearAllPoints()
            -- Move off-screen to prevent visual overlap
            child:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -5000, 5000)
        end
    end
    
    -- Initialize tracking
    content.checkboxes = {}
    
    -- Create or reuse section header
    local header
    if content.headerText then
        -- Reuse existing header
        header = content.headerText
        header:Show()
    else
        -- Create new header only if it doesn't exist
        header = content:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        header:SetPoint("TOPLEFT", 10, -10)
        content.headerText = header
    end
    
    -- Update header text and color
    header:SetText(flagDef.title)
    header:SetTextColor(UISTYLE_COLORS.White[1], UISTYLE_COLORS.White[2], UISTYLE_COLORS.White[3], 1)
    
    -- Create checkboxes
    local yOffset = -35
    for _, flag in ipairs(flagDef.flags) do
        local checkboxContainer = FlagEditor.CreateCheckbox(content, flag, yOffset)
        
        -- Set initial state based on current value
        local isSet = bit.band(FlagEditor.currentValue, flag.value) > 0
        checkboxContainer.checkbox:SetChecked(isSet)
        
        table.insert(content.checkboxes, checkboxContainer)
        yOffset = yOffset - 30
    end
    
    -- Update scroll height
    content:SetHeight(math.abs(yOffset) + 20)
    
    -- Update scrollbar if available
    if FlagEditor.frame.updateScrollBar then
        FlagEditor.frame.updateScrollBar()
    end
    
    -- Setup preset dropdown
    FlagEditor.SetupPresetDropdown()
end

-- Setup preset dropdown
function FlagEditor.SetupPresetDropdown()
    local dropdown = FlagEditor.frame.presetDropdown
    local presets = FlagEditor.PRESETS[FlagEditor.currentFlagType]
    
    -- Build items for styled dropdown
    local items = {}
    
    -- Add "Custom" option
    table.insert(items, {
        text = "Custom",
        value = -1
    })
    
    -- Add presets if available
    if presets then
        for _, preset in ipairs(presets) do
            table.insert(items, {
                text = preset.name,
                value = preset.value
            })
        end
    end
    
    -- Update dropdown items (recreate dropdown with new items)
    local parent = dropdown:GetParent()
    local point, relativeTo, relativePoint, x, y = dropdown:GetPoint()
    dropdown:Hide()
    dropdown:SetParent(nil)
    
    -- Create new dropdown with updated items
    FlagEditor.frame.presetDropdown = CreateFullyStyledDropdown(parent, 200, items, "Select preset...", 
        function(value, item)
            if value == -1 then
                -- Custom selected, do nothing
            else
                FlagEditor.ApplyPreset(value)
            end
        end
    )
    FlagEditor.frame.presetDropdown:SetPoint(point, relativeTo, relativePoint, x, y)
end

-- Apply a preset value
function FlagEditor.ApplyPreset(value)
    FlagEditor.currentValue = value
    FlagEditor.UpdateDisplay()
    
    -- Update checkboxes
    local content = FlagEditor.frame.content
    if content.checkboxes then
        for _, checkboxContainer in ipairs(content.checkboxes) do
            local isSet = bit.band(value, checkboxContainer.checkbox.flag.value) > 0
            checkboxContainer.checkbox:SetChecked(isSet)
        end
    end
end

-- Update value from checkboxes
function FlagEditor.UpdateValue()
    local value = 0
    local content = FlagEditor.frame.content
    
    if content.checkboxes then
        for _, checkboxContainer in ipairs(content.checkboxes) do
            if checkboxContainer.checkbox:GetChecked() then
                value = bit.bor(value, checkboxContainer.checkbox.flag.value)
            end
        end
    end
    
    FlagEditor.currentValue = value
    FlagEditor.UpdateDisplay()
    
    -- Reset dropdown to custom - for styled dropdown, we need to update the text manually
    if FlagEditor.frame.presetDropdown and FlagEditor.frame.presetDropdown.text then
        FlagEditor.frame.presetDropdown.text:SetText("Custom")
        FlagEditor.frame.presetDropdown.value = -1
    end
end

-- Update value display
function FlagEditor.UpdateDisplay()
    FlagEditor.frame.valueText:SetText(tostring(FlagEditor.currentValue))
    FlagEditor.frame.hexText:SetText(string.format("(0x%X)", FlagEditor.currentValue))
end

-- Clear all checkboxes
function FlagEditor.ClearAll()
    FlagEditor.currentValue = 0
    FlagEditor.UpdateDisplay()
    
    local content = FlagEditor.frame.content
    if content.checkboxes then
        for _, checkboxContainer in ipairs(content.checkboxes) do
            checkboxContainer.checkbox:SetChecked(false)
        end
    end
    
    -- Reset dropdown to custom - for styled dropdown
    if FlagEditor.frame.presetDropdown and FlagEditor.frame.presetDropdown.text then
        FlagEditor.frame.presetDropdown.text:SetText("Custom")
        FlagEditor.frame.presetDropdown.value = -1
    end
end

-- Show help dialog
function FlagEditor.ShowHelp()
    local helpText = "Flag Editor Help\n\n" ..
        "This tool helps you set creature flags using checkboxes.\n\n" ..
        "• Check the boxes for flags you want to enable\n" ..
        "• Use presets for common configurations\n" ..
        "• The value updates automatically\n" ..
        "• Hover over flags for descriptions\n\n" ..
        "Flags are bitmasks - multiple can be combined."
    
    StaticPopup_Show("GENERIC_INFO", "Flag Editor Help", helpText)
end

-- Save and close
function FlagEditor.Save()
    if FlagEditor.callback then
        FlagEditor.callback(FlagEditor.currentValue)
    end
    FlagEditor.Close()
end

-- Open the flag editor
function FlagEditor.Open(flagType, currentValue, callback)
    FlagEditor.currentFlagType = flagType
    FlagEditor.currentValue = currentValue or 0
    FlagEditor.callback = callback
    
    -- Create dialog if needed
    if not FlagEditor.frame then
        FlagEditor.CreateDialog()
    end
    
    -- Update title
    local flagDef = FlagEditor.FLAG_DEFINITIONS[flagType]
    if flagDef then
        FlagEditor.frame.title:SetText("Flag Editor - " .. flagDef.title)
    end
    
    -- Populate flags
    FlagEditor.PopulateFlags()
    
    -- Update display
    FlagEditor.UpdateDisplay()
    
    -- Show frame
    FlagEditor.frame:Show()
    FlagEditor.isOpen = true
end

-- Close the editor
function FlagEditor.Close()
    if FlagEditor.frame then
        -- Clean up content before closing
        if FlagEditor.frame.content then
            -- Clean up checkboxes
            if FlagEditor.frame.content.checkboxes then
                for _, checkboxContainer in ipairs(FlagEditor.frame.content.checkboxes) do
                    checkboxContainer:Hide()
                    checkboxContainer:ClearAllPoints()
                    checkboxContainer:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -5000, 5000)
                end
                FlagEditor.frame.content.checkboxes = {}
            end
            
            -- Hide header text but keep it for reuse
            if FlagEditor.frame.content.headerText then
                FlagEditor.frame.content.headerText:Hide()
            end
            
            -- Clean up all child frames
            for _, child in ipairs({FlagEditor.frame.content:GetChildren()}) do
                child:Hide()
                child:ClearAllPoints()
                child:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -5000, 5000)
            end
        end
        
        FlagEditor.frame:Hide()
    end
    FlagEditor.isOpen = false
    FlagEditor.currentFlagType = nil
    FlagEditor.currentValue = 0
    FlagEditor.callback = nil
end

-- Export to global namespace
_G.FlagEditor = FlagEditor

-- print("|cFF00FF00[FlagEditor] Module loaded|r")