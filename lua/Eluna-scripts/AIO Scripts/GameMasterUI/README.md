# GameMasterUI

In-game Game Master interface for **TrinityCore** and **AzerothCore** 3.3.5, built on top of the [AIO](https://github.com/Rochet2/AIO) framework and Eluna. The server core is auto-detected — no configuration required for standard setups.

Type `/gm` (or `/gamemaster`) in-game to open the UI.

---

## 1. Where to put it

GameMasterUI is an **AIO server addon**. AIO addons live inside Eluna's script directory under `AIO_Server/`. Eluna loads them on startup and AIO automatically pushes the client-tagged files to every connecting player.

### Final folder layout

After installation your `lua_scripts` directory must contain **both** of these as siblings:

```
lua_scripts/
└── AIO_Server/
    ├── 00_UIStyleLibrary/      ← REQUIRED (shared UI library)
    └── GameMasterUI/           ← this addon
        ├── Client/
        ├── Server/
        ├── gameMasterUtils.lua
        └── README.md
```

> The `00_` prefix on `00_UIStyleLibrary` is **load-order critical** — Eluna loads scripts alphabetically, and the library must initialize before any `GameMasterUI` client file references its templates. Do not rename or nest the folder.
>
> *Optional:* `00_LoggingSystem/` is a sibling library used by other AIO addons in this repo. **GameMasterUI does not require it** and will load fine without it.

### Step-by-step

1. **Locate your Eluna scripts directory.**
   - TrinityCore: `<server-build>/lua_scripts/`
   - AzerothCore: `<server-build>/lua_scripts/` (created by the `mod-eluna` module)
   - If `AIO_Server/` doesn't exist yet, create it.

2. **Copy two folders** from this repo (`AIO Scripts/`) into `lua_scripts/AIO_Server/`:
   - `00_UIStyleLibrary/`  — fonts, textures, frame templates (required)
   - `GameMasterUI/`       — this addon

3. **Restart the worldserver** (or run `reload eluna` from the console).

4. **In-game**, log in with a GM account (level ≥ 2) and type `/gm`.

That's it for a standard setup. Skip to [Troubleshooting](#troubleshooting) if the window doesn't appear.

---

## 2. Prerequisites

| Requirement                | Notes                                                                |
|----------------------------|----------------------------------------------------------------------|
| TrinityCore or AzerothCore | 3.3.5 branch                                                         |
| Eluna                      | Built into TrinityCore; `mod-eluna` module on AzerothCore            |
| AIO                        | https://github.com/Rochet2/AIO — install once into `lua_scripts/`    |
| MySQL/MariaDB              | World, characters, and auth databases reachable by the worldserver   |
| GM account                 | `account_access.gmlevel ≥ 2` (configurable, see below)               |

---

## 3. Configuration

For most servers, **no edits are needed**. Defaults are picked based on the core Eluna reports:

| Core         | Default databases                              |
|--------------|------------------------------------------------|
| TrinityCore  | `world`, `characters`, `auth`                  |
| AzerothCore  | `acore_world`, `acore_characters`, `acore_auth`|

If your databases use custom names, open **`Server/Core/GameMasterUI_Config.lua`** and edit the `database.names` block (≈ line 153):

```lua
names = {
    world      = "myserver_world",
    characters = "myserver_characters",
    auth       = "myserver_auth",
},
```

Other useful settings in the same file:

| Setting              | Default | What it does                                                  |
|----------------------|--------:|---------------------------------------------------------------|
| `debug`              | `false` | Verbose console logging                                       |
| `REQUIRED_GM_LEVEL`  | `2`     | Minimum gmlevel to open the UI (`0`–`3`)                      |
| `defaultPageSize`    | `100`   | Search results per page                                       |
| `removeFromWorld`    | `true`  | Hide the GM from the world while the UI is open               |
| `database.enableAsync` | `true` | Use `WorldDBQueryAsync` etc. — leave on for any sized DB      |

The bug-report button (top-right `!` icon) opens a GitHub issue. Point it at your fork by editing `githubRepo` in **`Client/00_Core/GMClient_01_Config.lua`**.

---

## 4. Usage

| Action                  | How                                            |
|-------------------------|------------------------------------------------|
| Open the UI             | `/gm` or `/gamemaster`                         |
| Close the current panel | `Esc`                                          |
| Refresh data            | `Ctrl + R`                                     |
| Context actions         | Right-click on items, NPCs, or players         |

---

## 5. Project layout

```
GameMasterUI/
├── README.md
├── gameMasterUtils.lua             — shared helpers
├── Client/                         — pushed to players by AIO
│   ├── 00_Core/                    — config, state machine, search, hotkeys
│   ├── 01_UI/                      — main frame + layout
│   ├── 02_Cards/                   — card display system (NPCs, items, spells)
│   ├── 03_Systems/                 — object editor, templates, inventory
│   └── 04_Menus/                   — context menus, item/spell selection
└── Server/                         — runs in Eluna
    ├── GameMasterUIServer.lua      — entry point
    ├── Core/
    │   ├── GameMasterUI_Config.lua          ← edit me for DB / GM level
    │   ├── GameMasterUI_Constants.lua
    │   ├── GameMasterUI_DatabaseHelper.lua
    │   ├── GameMasterUI_DatabaseErrorHelper.lua
    │   ├── GameMasterUI_Init.lua
    │   ├── GameMasterUI_SearchManagerInit.lua
    │   ├── GameMasterUI_SharedUtils.lua
    │   ├── GameMasterUI_Utils.lua
    │   ├── SearchManager.lua
    │   └── SearchStrategies/
    ├── Database/                   — per-core SQL templates
    │   ├── GameMasterUI_Database.lua
    │   ├── GameMasterUI_DatabaseItems.lua
    │   └── GameMasterUI_DatabaseSpells.lua
    ├── Data/                       — static enchant / faction lookups
    ├── Handlers/                   — AIO message handlers
    │   ├── Entity/                 — NPC, item, gameobject spawning
    │   ├── Player/                 — bans, buffs, inventory, mail, spells, quests, reputation
    │   ├── Template/               — live template editing
    │   ├── Teleport/
    │   └── GMPowers/
    └── Utils/                      — cache, fuzzy matcher, async helpers
```

---

## 6. Troubleshooting

### `/gm` does nothing, or the UI is blank

1. Confirm `00_UIStyleLibrary/` is a sibling of `GameMasterUI/` under `AIO_Server/` and still has the `00_` prefix.
2. Check the worldserver console for Eluna errors at startup.
3. Tail `Eluna.log` (next to your worldserver binary). An empty file is good.
4. In-game, run `.aio` to confirm AIO is alive.
5. If only your client looks broken, clear `<WoW>/Cache/` and `<WoW>/WDB/` and `/reload`.

### "You do not have permission"

```sql
-- check your gmlevel
SELECT * FROM auth.account_access WHERE id = <your account id>;

-- promote
UPDATE auth.account_access SET gmlevel = 2 WHERE id = <your account id>;
```

For AzerothCore replace `auth.` with `acore_auth.`.

### "Missing required tables: spell"

Some servers ship without the `spell` table populated. Re-import it from DBC using your core's standard tooling, then restart.

### Custom database names don't take effect

After editing `database.names`, restart the worldserver and watch for:
```
[GameMasterUI] Custom database: world = '<your name>'
```
If you don't see it, the file wasn't reloaded — `reload eluna` again.

### Slow queries

Make sure `database.enableAsync = true` (it is by default). For very large catalogs, add indexes:

```sql
CREATE INDEX idx_creature_name ON creature_template(name);
CREATE INDEX idx_item_name     ON item_template(name);
```

---

## 7. Reporting issues

Click the **`!`** button in the UI's top-right corner, fill the form, then copy the generated GitHub URL into your browser. By default it targets `Isidorsson/Eluna-scripts`; change `githubRepo` in `Client/00_Core/GMClient_01_Config.lua` if you maintain your own fork.

---

## Credits

- AIO framework by [Rochet2](https://github.com/Rochet2/AIO)
- Eluna Lua engine
- UI styling targets WoW 3.3.5a interface conventions
