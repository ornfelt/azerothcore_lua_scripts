local MSG_COMMAND = "#bronze commands"

function BronzeCommandsOnChat(event, player, message, type, language)
if(message == MSG_COMMAND) then
			player:SendBroadcastMessage("|cFFFF0000Bronze Rank Commands:")
			player:SendBroadcastMessage("|cFF00FFFFOnline Players: |cFFFFA500Type #online - to see how many players is online.")
			player:SendBroadcastMessage("|cFF00FFFFUnstuck Command: |cFFFFA500Type #unstuck to get unstucked. If your dead type /g #unstuck.")
			player:SendBroadcastMessage("|cFF00FFFFGet To Trainer: |cFFFFA500Type #train - to get to your class trainer.")
			player:SendBroadcastMessage("|cFF00FFFFRessurrect Your Self: |cFFFFA500Type #ressurrect - to get revived, but you need 1       |cFF00FFFF[Revive Stone]|cFFFFA500 or else it wont work.")
			player:SendBroadcastMessage("|cFF00FFFFLevel 90: |cFFFFA500 Type: #grow - Makes you level 90!")
			player:SendBroadcastMessage("|cFF00FFFFBronze Gear: |cFFFFA500 Type: #bronze - Gives you full Bronze VIP gear!")
			player:SendBroadcastMessage("|cFF00FFFFIncrease Gold: |cFFFFA500 Type: #gold - Gives you a coin you can exchange for gold!")
			player:SendBroadcastMessage("|cFF00FFFFDonor Mall: |cFFFFA500 Type: #donormall - Ports you to donor mall!")
		
						player:SendBroadcastMessage("|cFF00FFFFGM Commands:")
			player:SendBroadcastMessage("|cFF00FFFFcommands: |cFFFFA500 Type: .commands - to see all the GM commands BRONZE has unlocked!")
			player:SendBroadcastMessage("|cffFF0000[Reminder]|cffFFFF05Don't forget to support our server by |cffFF0000voting|cffFFFF05 and |cffFF0000donating|cffFFFF05 on |cffFF0000www.extremisgaming.com!")

			end
		end
	
RegisterServerHook(16, "BronzeCommandsOnChat")