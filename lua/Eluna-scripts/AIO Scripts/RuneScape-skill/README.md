# RuneScape-Style Skill System (AIO/Eluna)

## TL;DR

This is a work-in-progress RuneScape-style skill and milestone system for TrinityCore/Azerothcore using Eluna and AIO.
It provides:

- Custom skills, XP, and milestones (with rewards you set)
- Server-side logic in Lua (Eluna)
- Dynamic client UI (AIO, BLPs required for proper display)[]
- Automatic XP gain from configured activities(e.g., Mining, Fishing. Scroll to bottom `skillServer.lua` of the files to
  see how it's handled
  in the code)

## How to Use (Current State)

1. **Database Setup**
    - Import `skillSql.sql` into your world and character databases to create the required tables. (might need to copy each block)

2. **Server Scripts**
    - Place `skillServer.lua` in your Eluna scripts folder (e.g., `lua_scripts/AIO_Server/RuneScape/SkillSystem/`).
    - Make sure AIO is installed and loaded on your server.

3. **Client Addon**
    - Place `skillClient.lua` in your AIO addon folder (e.g., `lua_scripts/AIO_Server/RuneScape/SkillSystem/`).
    - No manual client install is needed; AIO will deliver the addon to players automatically.

4. **Client Patch (Required)**
    - You must add the following BLP files to your client's Interface folder:
        - `Interface\Skill_RS\UIFrameNeutral.blp`
        - `Interface\Skill_RS\ArchaeologyParts.blp`
    - Without these files, the UI will display incorrectly or not at all.

5. **Usage**
    - In-game, use `/skills` to open the skill window.
    - Use `#addrsxp <skill> <amount>` to add XP for testing.
    - Use `#forceskillxp` to manually save pending XP updates.
    - Skills, XP, and milestones are synced between server and client.

## Features

- **XP Sources System**: Configure activities that grant skill XP automatically
- **Milestone Rewards**: Items, spells, currency rewards for reaching level milestones
- **Persistent Skills**: Character skills are saved to the database
- **Performance Optimized**: Batch saving of XP updates
- **Animated UI**: Smooth animations for level ups and XP gains
- **Settings**: Configurable UI options for players

## Notes

- This is not feature-complete. Some UI/UX and reward logic may be missing or buggy.
- Milestone rewards: Only basic types (spell, item, currency) are supported for now.
- For development, see comments in the Lua files for extension points.
- Default XP sources are configured for Mining and Fishing. See `RegisterDefaultXPSources()` function to add more.

## Requirements

- TrinityCore/Azerothcore with Eluna and AIO (https://github.com/Rochet2/AIO)
- Lua 5.4 (Eluna)
- Client-side BLP files (see Client Patch section)

<table>
  <tr>
    <td><img src="Screenshot 2025-06-01 214532.png" width="250"/></td>
    <td><img src="Screenshot 2025-06-01 214645.png" width="250"/></td>
    <td><img src="Screenshot 2025-06-01 214717.png" width="250"/></td>
  </tr>
</table>

## Credits

- Inspired by RuneScape skills
- Uses Eluna and AIO by Rochet2

---
For questions or updates, see the code comments.
