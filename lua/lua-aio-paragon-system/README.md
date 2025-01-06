# ![logo](https://raw.githubusercontent.com/azerothcore/azerothcore.github.io/master/images/logo-github.png) AzerothCore

# AIO - Paragon

### Description

	I share my AIO - Paragon System.

	Paragon is a script that allows you to set up Diablo 3's Paragon system.
	This one is provided with interface, you can place your statistics.

  	You will be able to earn Paragon points all Levels, experience points can be earned via PvE & PvP.

  	To change the parameters you just have to open the script.

    License: AGPL


# Setup

- Download the AIO Addon from https://rochet2.github.io/AIO.html
- Copy the AIO_Client to your WoW_Client_folder/Interface/AddOns/
- Copy the AIO_Server to wherever your lua_scripts folder resides on your server

- Copy the lua_scripts/D3_Paragon folder to the lua_scripts folder on your server
- Copy the Interface folder into a .MPQ patch in your Client's data folder
- Next, configure the "paragon-server.lua" script by going to Line 11, then replace 'ac_eluna' with whatever database name you created.
- Start your worldserver so that the database tables get created.

Thanks to @Naruon for the tutorial ;)


## Credits

* [iThorgrim](https://github.com/DevCores/lua-aio-parangon)
* [Open-Wow](https://open-wow.eu)

AzerothCore: [repository](https://github.com/azerothcore) - [website](http://azerothcore.org/) - [discord chat community](https://discord.gg/PaqQRkd)
