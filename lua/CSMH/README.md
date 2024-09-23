
# CSMH

### What is CSMH?
CSMH is a **C**lient and **S**erver **M**essage **H**andler framework for communication between Eluna and the WoW client interface. It has been tested on Mangos and TrinityCore 3.3.5a, but it will probably work for other versions as well.

CSMH consists of two parts, the Client Message Handler and the Server Message Handler respectively.

### How does this compare to AIO?
While AIO is the most used solution of this kind, it has its drawbacks as well. While it allows you to write all your code server-side, it also limits you to the Lua API only. AIO also sends the full addon code to the client on startup and reload, which is relatively bandwidth intensive compared to communication only. Upside of AIO is its ease of distribution compared to dedicated client-side addons.

CSMH is only meant to transport data between the client and the server, and is therefore not as bandwidth intensive as AIO. You write your server-side code on the server, and you distribute your client-side code either as an addon, or in a patch. This allows you to use XML and templates, as well as the full Lua API.

Both AIO and CSMH uses smallfolk for serialization, and is compatible with each other. You can use both AIO and CSMH in the same project.

### What does CSMH do and *not* do?
CSMH intentionally does not do certain things, primarily for ease of integration and personal preferences around implementations like; Flood protection, data validation, packet filtering etc.

CSMH **does** verify the sender and recipient of a message, to prevent messages being sent and accepted on someone else's behalf.

CSMH **does not** natively check and verify what is being sent to and from the client and server. It is up to you to sanity check data being sent back and forth. A good rule of thumb is to never inherently trust data being sent to the server from the client, you need to verify data before accepting it.

CSMH also **does not** have any form of built in flood protection. This is again up to you to decide on an implementation  of your choice.

### How do I use CSMH?
I would recommend going through the examples provided in this repo to get a feel for how registering, sending and receiving data on both the client and the server works. A full API and how-to will be posted soon™.

## Installation:

### Server:
- Copy everything from the Server directory to your Eluna scripts directory. That's it!

### Client:
The CMH can be distributed either as a stand-alone addon, or through a patch. Files are provided for both solutions in the Client directory, but be aware of the differences:

#### Addon:
- Copy **CMH.Lua**, **CMH.toc** and **smallfolk.lua** to **Interface\AddOns\CMH**

#### MPQ Patch:
- Copy **CMH.Lua**, **FrameXML.toc** and **smallfolk.lua** to **Interface\FrameXML**

## API:
### Client:
`RegisterServerResponses(config table)`
- **RegisterServerResponses** takes a config table (see Both section for structure) and registers functionId's to corresponding client side functions. You then use these functionId's in SendServerResponse.

`SendClientRequest(prefix, functionId, ...)`
- **SendClientRequest** sends a Client Request to the Server, with *prefix* and *functionId* defined in your server config table. Takes any amount of string, integer, table or boolean variables and sends to the corresponding function. Nil variables are not supported. This is default Lua behavior.

### Server:
`RegisterClientRequests(config table)`
- **RegisterClientRequests** takes a config table (see Both section for structure) and registers functionId's to corresponding server side functions. You then use these functionId's in SendClientRequest.

`Player:SendServerResponse(prefix, functionId, ...)`
- **SendServerResponse** sends a Server Response to the Client, with *prefix* and *functionId* defined in your client config table. Takes any amount of string, integer, table or boolean variables and sends to the corresponding function. Nil variables are not supported. This is default Lua behavior. Requires *player* object.

### Both:
	local config = {
		Prefix = "YourAddonName",
		Functions = {
			[1] = "YourFunctionName",
			[2] = "YourOtherFunctionName",
			[n] = "..."
		}
	}
- The config table is required for any script using CSMH, both client and server side. Using the same Prefix on client and server is not required, but recommended for ease of use. You can register any amount of functions in the Functions section of the config table.

## Credits:
- [Stoneharry](https://github.com/stoneharry)
- [Terrorblade](https://github.com/Terrorblade)
- [Kaev](https://github.com/kaev)
- [Rochet / AIO](https://github.com/Rochet2)
- [Eluna](https://github.com/ElunaLuaEngine/Eluna)
- [smallfolk](https://github.com/gvx/Smallfolk)