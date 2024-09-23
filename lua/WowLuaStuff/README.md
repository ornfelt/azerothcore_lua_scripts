# Collection of Lua scripts for WoW
In this repo you can find some Lua scripts to dump stuff from WoW to a ```json``` string.
These script are used in my bot to extract various things from the game via its Lua Api.

## EquipmentDump.lua
Dumps all items that you have equipped as ```json```

## EquipmentSlotDump.lua
Dumps a item that you have equipped as ```json```

## EventCapture.lua
Dumps collected events as ```json```

## InventoryDump.lua
Dumps all items in your bag as ```json```

## ItemDump.lua
Dumps a specific item as ```json```

## ItemStatsDump.lua
Dumps the Primary stats of a specific item as ```json```

## SkillDump.lua
Dumps all skills as ```json```

## SpellbookDump.lua
Dumps all spells as ```json```

## Misc stuff
```c#
public enum EquipmentSlot : int
{
    INVSLOT_AMMO = 0,
    INVSLOT_HEAD = 1,
    INVSLOT_NECK = 2,
    INVSLOT_SHOULDER = 3,
    INVSLOT_SHIRT = 4,
    INVSLOT_CHEST = 5,
    INVSLOT_WAIST = 6,
    INVSLOT_LEGS = 7,
    INVSLOT_FEET = 8,
    INVSLOT_WRIST = 9,
    INVSLOT_HANDS = 10,
    INVSLOT_RING1 = 11,
    INVSLOT_RING2 = 12,
    INVSLOT_TRINKET1 = 13,
    INVSLOT_TRINKET2 = 14,
    INVSLOT_BACK = 15,
    INVSLOT_MAINHAND = 16,
    INVSLOT_OFFHAND = 17,
    INVSLOT_RANGED = 18,
    INVSLOT_TABARD = 19,
    CONTAINER_BAG_1 = 20,
    CONTAINER_BAG_2 = 21,
    CONTAINER_BAG_3 = 22,
    CONTAINER_BAG_4 = 23
}
```
