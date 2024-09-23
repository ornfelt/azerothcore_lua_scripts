# AzerothCore Eluna Extended-Holidays Script

## Overview

This script is designed to work with AzerothCore and the Eluna scripting engine. It provides server administrators the ability to enable or disable specific in-game holidays. The script is configured to run at server startup and will automatically initiate the events based on the configuration set in the script.

## How to Use

1. Place this Lua script in your `lua_scripts` directory.
2. Open the script and locate the `HolidayStatus` table.
3. Update the table to indicate which holidays should be enabled (`true`) or disabled (`false`).
4. Restart your server for the changes to take effect.

## Output

The script prints out messages to the server console indicating which holidays are enabled. This can be useful for server administrators to confirm that the script is running as expected.

## Troubleshooting

If you encounter any issues or have suggestions for improvement, please file an issue on GitHub or contribute to the project.
