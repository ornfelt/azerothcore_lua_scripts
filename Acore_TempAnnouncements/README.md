## lua-temp-announcements
Lua script for Azerothcore with ElunaLUA for repeated announcements from a console/GM command.

#### Find me on patreon: https://www.patreon.com/Honeys

## Requirements:
Compile your [Azerothcore](https://github.com/azerothcore/azerothcore-wotlk) with [Eluna Lua](https://www.azerothcore.org/catalogue-details.html?id=131435473).
Requires at least commit b824e9d18683ecfa498279de8ed1e49c1bfd887d of the Eluna Engine submodule hence commit 81548013dc0748c1aeb15179fed6b7fe861b64bc from [mod-eluna-lua](https://github.com/azerothcore/mod-eluna-lua-engine).
The ElunaLua module itself usually doesn't require much setup/config. Just specify the subfolder where to put your lua_scripts in its .conf file.

If the directory was not changed in the ElunaLua config, add the .lua script to your `../lua_scripts/` directory as a subfolder of the worldserver.

## Admin Usage:
Adjust the config flags in the .lua.

## GM Usage:
Use `.tannounce $min $amount $text` to do repeated server wide announcements.

`$min` is the time between each repetition in minutes.
`$amount` is the amount of broadcasts. 0 means until server restart or reload eluna.
`$text` Is the exact text to broacast. No quotes required. Forbidden chars: `[]';`

`.tannounce list` shows all active temporary announcements

`.tannounce delete $id` deletes the temporary announcement

## As an example:
`.tannounce 15 0 Hello players, we love you!`

will post a server wide announcement every 15min until the server restarts or eluna is reloaded.

`.tannounce 30 24 Hello players, check this out!`

will post a server wide announcement every 30min 24 times total. The counter will go on when the server restarts. The delay restarts at 30min for the first announcement after the restart/reload.
