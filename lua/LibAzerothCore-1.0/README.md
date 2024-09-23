# LibAzerothCore-1.0

LibAzerothCore-1.0 is a library for the World of Warcraft client that integrates with the [AzerothCore](https://github.com/AzerothCore/azerothcore-wotlk/) server software.
It provides a Lua interface that allows addon code to interact with server commands in an easy fashion.

## Supported branches
| Branch  | as of commit                                                                                                  |
| ------- | ------------------------------------------------------------------------------------------------------------- |
| `3.3.5` | [`ebf5f67`](https://github.com/azerothcore/azerothcore-wotlk/commit/ebf5f6710a0de5efa3067d3b58491ef8d25b8ae8) |

## API
### LibAzerothCore::IsAzerothCore
```lua
isAzerothCore = LibStub("LibAzerothCore-1.0"):IsAzerothCore()
```
Returns `true` if the server is a supported AzerothCore build, `false` if not, and `nil` if testing is incomplete

### LibAzerothCore::RegisterLoader
```lua
LibStub("LibAzerothCore-1.0"):RegisterLoader(callback)
```
Registers the passed `callback` to be called once AzerothCore detection finishes. This method might call your loader before returning, or asynchronously at any later point. Once the loader is called, `IsAzerothCore()` is guaranteed to return either `true` or `false` (never `nil`).

### LibAzerothCore::DoCommand
```lua
LibStub("LibAzerothCore-1.0"):DoCommand(cmd, callback)
```
Invokes `cmd` on the server. Commands should be passed without leading command prefix (no `.` or `!`).
When command execution finishes, `callback` will be invoked as `callback(success, output)`. `success` is a boolean indicating whether the command's execution reported any errors, while `output` is an array of lines that the command printed.

## Example usage

```lua
-- get library object - all calls are made through this object
local LibAzeroth = LibStub("LibAzerothCore-1.0")
assert(LibAzeroth)

-- define a command callback function
local function commandCallback(success, output)
  print("Command status: ", success and "OK" or "Fail")
  if #output > 0 then
    print("Command output:")
    for _,line in ipairs(output) do
      print(line)
    end
  else
    print("Command produced no output")
  end
end
  
-- then invoke the "server motd" and "server info" commands
LibAzeroth:DoCommand("server motd", commandCallback)
LibAzeroth:DoCommand("server info", commandCallback)
```

## Credit

TrinityCore - [LibTrinityCore-1.0](https://github.com/TrinityCore/LibTrinityCore-1.0)
