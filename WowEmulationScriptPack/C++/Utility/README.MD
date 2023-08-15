# Table of contents
* [Presentation](#presentation)
  * [Features](#features)
  * [Example of utilization](#example-of-utilization)
  * [Language](#language)
* [Installation](#installation)

# Presentation
The Utility class offers features mainly related to messages sending/displaying in the context of a project with multiple realms with different languages for each realm.
The idea was to give developers the ability to send gossip items, areatriggermessages, whispers, ... to the players in the language of the realm without
having different versions of their server code for their different realms and without using the database.

## Features
* Send a message to a player, in the realm language
* Send an areatrigger message to a player, in the realm language
* Get the name of an area, in the realm language
* Add a gossip (extended) item, in the realm language

## Example of utilization
Let's say you have two realms, one in English and the other in French.
If you want to send a message to a player or add a gossip item, here is how you can do it with our Utility class:

```c++
Player* playerToSendTheMessageTo = ...;
Maelstrom::Utility::LangTextMap messagesToDisplay = {
  { Maelstrom::Utility::ENGLISH, "Hello ! Have a nice day on Maelstrom !"          },
  { Maelstrom::Utility::FRENCH , "Salut ! Passe une bonne journée sur Maelstrom !"}
};

//Areatriggermessage
Maelstrom::Utility::SendAreaTriggerMessage(playerToSendTheMessageTo, messagesToDisplay);
//Message that displays in the bottom left of the screen (in the chat, as a system message)
//Colors are available in the Utility.h file
Maelstrom::Utility::SendMessageToPlayer(playerToSendTheMessageTo, COLOR_GREEN, messagesToDisplay);

//Let's say you want to say Hi ! and add that in a gossip item:
Maelstrom::Utility::AddGossipItem(playerToSendTheMessageTo, GOSSIP_ICON_CHAT, messagesToDisplay, GOSSIP_SENDER_MAIN, 0 /*action*/);
```

The message you can send and that you have to add to the LangTextMap is a std::string so you can have a message like this one:

```c++
Player* playerToSendTheMessageTo = ...;
Maelstrom::Utility::LangTextMap messagesToDisplay = {
  { Maelstrom::Utility::ENGLISH, "Hello, " + playerToSendTheMessageTo->getName() },
  { Maelstrom::Utility::FRENCH , "Salut, " + playerToSendTheMessageTo->getName() }
};
```

## Language
The language in which messages will be sent / displayed is the one of the server's DBC directory.

In order for this to work properly, __the DBC language of the server must the same as the one of the client !__

# Installation
 * Download Utility.h and Utility.cpp (open the file in github, click on "raw", then on the page that appears with the code, right click and "save as")
 * Save both of the files in the following directory: *TrinityCore/src/server/game/Scripting*
 * Open your Visual Studio TrinityCore solution
 * Open the "game" project
 * Right click on "Header Files" then add existing element and select Utility.h in the directory where you saved it (*TrinityCore/src/server/game/Scripting*) then add it
 * Right click on "Source Files" then add existing element and select Utility.cpp in the directory where you saved it (*TrinityCore/src/server/game/Scripting*) then add it
 * Try to build your solution to make sure everything is ok

 From now on, you can use our Utility class in every file you want, you just have to add this at the top of your file:
 ```c++
 #include "Utility.h"
 ```
 And you're good to go !

 Note that the Utility class belongs with the __Maelstrom namespace__.

 The header file is documented so please before creating an issue to ask a question, read the doc.
