# AIO Scripts

Most UI-based AIO scripts in this folder require the shared client-side addon folder named `00_UIStyleLibrary`.

What is 00_UIStyleLibrary?
- A small, shared library of fonts, textures, templates, and common UI helpers used by multiple AIO UIs in this repo.
- The `00_` prefix ensures it loads before dependent addons.

Where to find it in this repo
- Path: `AIO Scripts/00_UIStyleLibrary`
- Do not rename this folder. Keep the exact name `00_UIStyleLibrary` (including the `00_` prefix).

When do you need it?
- If you are using any of the AIO UI projects here (examples: GameMaster UI, Bank UI, Custom Store AIO, Talent Tree (Retail Style), RuneScape-skill UI, Slot Machine, etc.), include `00_UIStyleLibrary` or you will likely see missing fonts/textures, blank frames, or Lua errors about unknown templates.

How to add it (server-side for AIO)
- Copy the entire folder `AIO Scripts/00_UIStyleLibrary` into your server's `lua_scripts\AIO_Server\00_UIStyleLibrary` directory so it becomes `lua_scripts\AIO_Server\00_UIStyleLibrary`.
- Restart/reload the server or the AIO module so clients receive the updated UI files.
- The `00_` prefix ensures it loads before any dependent UI modules.

Troubleshooting
- Symptoms of a missing `00_UIStyleLibrary`:
  - UI appears blank or elements are invisible.
  - Errors about missing templates, textures, or fonts.
  - Dependent AIO UIs fail to open.
- Fix: Add/copy `00_UIStyleLibrary` as described above and reload the UI.

Notes
- Keep the folder name intact and do not nest it inside another folder when copying.
- If you vendor or package these UIs, ship `00_UIStyleLibrary` alongside them.
