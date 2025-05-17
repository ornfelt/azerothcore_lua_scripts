# RuneScape-Style Skill System (AIO/Eluna)

## TL;DR

This is a work-in-progress RuneScape-style skill and milestone system for TrinityCore/Azerothcore using Eluna and AIO. It provides:
- Custom skills, XP, and milestones (with rewards)
- Server-side logic in Lua (Eluna)
- Dynamic client UI (AIO, no client-side install needed)

## How to Use (Current State)

1. **Database Setup**
   - Import `skillSql.sql` into your world and character databases to create the required tables.

2. **Server Scripts**
   - Place `skillServer.lua` in your Eluna scripts folder (e.g., `lua_scripts/AIO_Server/RuneScape/SkillSystem/`).
   - Make sure AIO is installed and loaded on your server.

3. **Client Addon**
   - Place `skillClient.lua` in your AIO addon folder (e.g., `lua_scripts/AIO_Server/RuneScape/SkillSystem/`).
   - No manual client install is needed; AIO will deliver the addon to players automatically.

4. **Usage**
   - In-game, use `/skills` to open the skill window.
   - Use `#addrsxp <skill> <amount>` to add XP for testing.
   - Skills, XP, and milestones are synced between server and client.

## Notes
- This is not feature-complete. Some UI/UX and reward logic may be missing or buggy.
- Milestone rewards: Only basic types (spell, item, currency) are supported for now.
- For development, see comments in the Lua files for extension points.

## Requirements
- TrinityCore/Azerothcore with Eluna and AIO (https://github.com/Rochet2/AIO)
- Lua 5.4 (Eluna)

## Credits
- Inspired by RuneScape skills
- Uses Eluna and AIO by Rochet2

---
For questions or updates, see the code comments or contact the author.
