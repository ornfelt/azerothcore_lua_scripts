# mod-nbem-scan-and-npcboteqmanager
Server module mod-nbem-scan and Addon NpcBotEqManager

# mod-nbem-scan

Standalone **AzerothCore/Trickerer NPCBots helper module** for **NpcBotEqManager**.

This package provides the server-side functionality required by the **NpcBotEqManager** addon. It allows players to scan, equip, and unequip gear on their currently selected NPCBot through an easy-to-use graphical interface.

The module does **not** modify any core files. All equip and unequip actions are routed through Trickerer's existing NPCBots equipment logic and ownership checks.

## Requirements

* **AzerothCore with NPCBots by Trickerer**
  https://github.com/trickerer/AzerothCore-wotlk-with-NPCBots

## Installation

### Server Module

Copy:

```text
mod-nbem-scan
```

to:

```text
azerothcore/modules/
```

Then re-run CMake and rebuild AzerothCore.

### Client Addon

Copy:

```text
NpcBotEqManager
```

to:

```text
World of Warcraft/Interface/AddOns/
```

## Usage

Select one of your NPCBots and type:

```text
/nbem
```

to open the **NpcBotEqManager** interface.

You can also open the addon by clicking the **gear icon on the minimap**.

## Features

* Graphical interface for managing NPCBot equipment.
* Scan your selected NPCBot.
* Equip and unequip items through the addon.
* Uses Trickerer's existing NPCBot equipment logic.
* Ownership checks are preserved.
* No core modifications required.

## Notes

* **No core modifications are required.**
* Compatible with **AzerothCore with Trickerer's NPCBots**.

