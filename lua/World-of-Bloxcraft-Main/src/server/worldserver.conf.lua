local config = {}

-- Created to handle certain global variables such as: How much money a player starts with or what level they start at

config.Test = "0"
config.DataStoreEnabled = false;
config.DBVersion = 'v2.02'
------------------------

--[[Logs
	Development logs, allows the core to log each and every opcode sent between the client and server.
	To enable, set value to 1. 0 is disabled.
]]--
config.Logs = {};

config.Logs.Opcodes = "1";



return config
