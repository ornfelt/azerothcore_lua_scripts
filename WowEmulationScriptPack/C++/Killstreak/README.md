## Table of contents
* [Presentation](#presentation)
* [Features](#features)
* [Changes](#changes)
* [How to use it](#how-to-use-it)
* [Example](#example)
* [Installation](#installation)
* [Thanks](#thanks)

## Presentation
This directory contains the implementation of a killing streak system. It is not a script that you can just add to your solution to have a killing streak system implemented. It is rather something that you can use to build your own killing streak system.

## Features
* Increment the killstreak count for a given player
* Reset the killstreak count for a given player
* Get the killstreak count for a given player

## Changes
Currently, the system increments the killstreak count everytime a player kills another one. You might want to do some checks before doing that like the area where the players are or the difference of level between the two players...

If you want to do so, you have to modify the *KillstreakManager.cpp* file in the function:
```c++
void HandlePvPKill(Player* killer, Player* killed)
```

Comments in the file are there to help you.

## How to use it
To use this in order to build your own killing streak system, just create a PlayerScript and include the *"KillstreakManager.h"* file. Once it's done, you will have access to a sKillstreakMgr object in the Maelstrom namespace.

In a nutshell, you have access to the member functions of
```c++
Maelstrom::sKillstreakMgr
```
Which is a pointer.

With this object, you can increment player's killstreaks, get them and reset them.

**Functions that you can call to do this can throw exceptions so don't forget to call them in a try catch block.**

When you override the void OnPVPKill(Player* killer, Player* killed) function of PlayerScript, __you have to call Maelstrom::sKillstreakMgr->HandlePvPKill(killer, killed) as first instruction__. It won't work if you don't.

## Example
The file *script_killstreak_example.cpp* is a very basic example of killing streak system that you can build with this solution. I recommend you to read it in order to understand how to use it.

## Installation
* To download a file open it in github, click on "raw", then on the page that appears with the code, right click and then choose "save as"
* Download *KillstreakManager.h* and *KillstreakManager.cpp* and save them in _TrinityCore/src/server/game/Scripting_
* Open your TrinityCore solution, open the "game" project
* Click on "Header Files", add existing item and select your *KillstreakManager.h* file
* Click on "Source Files", add existing item and select your *KillstreakManager.cpp* file
* Download the *script_killstreak_handling.cpp* file and save it in _TrinityCore/src/server/scripts/Custom_
* Add the script to your solution as an usual script
* Don't forget to add the **void AddSC_script_killstreak_handling()** function to your ScriptLoader.cpp file

* Create your awesome killing streak system !

[Optional]: If you want to add the example script to your solution, download the *script_killstreak_example.cpp* file and add it as an usual script.

The function to add in your ScriptLoader.cpp file is void AddSC_script_killstreak_example().

# Thanks
I would like to thank Rochet2 for his constructive comments about this script. Make sure you check out [his repo](http://rochet2.github.io/), he does amazing things !
