-- Require libs and whatever else has payloads defined
require('lualzw')
require('Smallfolk')
require('Payloads')

-- Name of the global table storing the injected functionality
local cGTN = "wi"

local dbg = "false"

local WardenLoader = {
	order = {
		-- defines the load order of payloads
		[1] = "lualzw",
		[2] = "Smallfolk",
		[3] = "Queue",
		[4] = "LibStub",
		[5] = "LibWindow",
		[6] = "CMH",
		[7] = "StatPointUI",
		[8] = "AIO",
	},
	data = {
		-- defines data per payload
		["lualzw"] = {
			version = 1,
			compressed = 0, -- This is the compression library, so can't be compressed
			cached = 1,
			payload = lualzw.payload,
			savedVars = {},
		},
		["Smallfolk"] = {
			version = 1,
			compressed = 1,
			cached = 1,
			payload = Smallfolk.payload,
			savedVars = {}
		},
		["Queue"] = {
			version = 1,
			compressed = 1,
			cached = 1,
			payload = Payloads.Queue,
			savedVars = {}
		},
		["LibStub"] = {
			version = 1,
			compressed = 1,
			cached = 1,
			payload = Payloads.LibStub,
			savedVars = {}
		},
		["LibWindow"] = {
			version = 1,
			compressed = 1,
			cached = 1,
			payload = Payloads.LibWindow,
			savedVars = {}
		},
		["CMH"] = {
			version = 1,
			compressed = 1,
			cached = 1,
			payload = Payloads.CMH,
			savedVars = {}
		},
		["StatPointUI"] = {
			version = 1,
			compressed = 1,
			cached = 1,
			payload = Payloads.StatPointUI,
			savedVars = {}
		},
		["AIO"] = {
			version = 1,
			compressed = 1,
			cached = 1,
			payload = Payloads.AIO,
			savedVars = {"AIO_sv", "AIO_sv_Addons"}
		}, 
	}
}

function Player:SendLargePayload(addon, version, cache, comp, data)
	comp = comp or 0;
	cache = cache or 0;
	local chunk = {}
	local max_size = 900

	if(comp == 1) then
		-- payload should be compressed using lzw
		-- lzw can return nil, in that case we don't compress and set flag to 0
		local newstr = lualzw.compress(data)
		if(newstr) then
			data = newstr
		else
			comp = 0;
		end
	end

	-- Split string payload into chunks of a specified max size
	while #data > 0 do
		table.insert(chunk, data:sub(1, max_size))
		data = data:sub(max_size + 1)
	end

	-- Our max amount is 99 messages per payload.
	if #chunk > 99 then
		return;
	end

	-- generate our header
	local cstr = ""
	if(#chunk < 10) then
		cstr = "0"
	end
	cstr = cstr..tostring(#chunk)

	for i = 1, #chunk do
		local istr = ""
		if(i < 10) then
			istr = "0"
		end
		istr = istr..tostring(i)

		self:SendAddonMessage("ws", "_G['"..cGTN.."'].f.p('"..istr.."', '"..cstr.."', '"..addon.."', "..version..", "..cache..", "..comp..", [["..chunk[i].."]])", 7, self)
	end
end

local function SendPayloadInform(player)
	-- If the player has any payloads already cached, then they will be loaded immediately
	-- Otherwise, full payloads will be requested
	for _, v in ipairs(WardenLoader.order) do
		local t = WardenLoader.data[v]
		-- register all saved variables if there are any
		for _, var in pairs(t.savedVars) do
			player:SendAddonMessage("ws", "_G['"..cGTN.."'].f.r('"..var.."')", 7, player)
		end
		
		player:SendAddonMessage("ws", "_G['"..cGTN.."'].f.i('"..v.."', "..t.version..", "..t.cached..", "..t.compressed..", "..#WardenLoader.order..")", 7, player)
	end
end

local function SendAddonInjector(player)
	-- Overwrite reload function
	player:SendAddonMessage("ws", "local copy,new=_G['ReloadUI'];function new() SendAddonMessage('wc', 'reload', 'WHISPER', UnitName('player')) copy() end _G['ReloadUI'] = new", 7, player)
	player:SendAddonMessage("ws", "SlashCmdList['RELOAD'] = function() _G['ReloadUI']() end", 7, player)

	-- Generate helper functions to load larger datasets
	player:SendAddonMessage("ws", "_G['"..cGTN.."'] = { f = {}, s = {}, i = {0}, d = "..dbg.."};", 7, player)
	-- Load
	player:SendAddonMessage("ws", "_G['"..cGTN.."'].f.l = function(s, n) local t=_G['"..cGTN.."'].i; forceinsecure(); loadstring(s)(); if(t.d) then print('[WardenLoader]: '..n..' loaded!') end t[1] = t[1]+1; if(t[1] == t[2]) then SendAddonMessage('wc', 'kill', 'WHISPER', UnitName('player')) end end", 7, player) 
	-- Concatenate
	player:SendAddonMessage("ws", "_G['"..cGTN.."'].f.c = function(a) local b='' for _,d in ipairs(a) do b=b..d end; return b end", 7, player) 
	-- Execute
	player:SendAddonMessage("ws", "_G['"..cGTN.."'].f.e = function(n) local t=_G['"..cGTN.."']; local lt = t.s[n] local fn = t.f.c(lt.ca); _G[n..'payload'] = {v = lt.v, p = fn}; if(lt.co==1) then fn = lualzw.decompress(fn) end t.f.l(fn, n) t.s[n]=nil end", 7, player)
	-- Process
	player:SendAddonMessage("ws", "_G['"..cGTN.."'].f.p = function(a, b, n, v, c, co, s) local t,tc=_G['"..cGTN.."'], _G['"..cGTN.."'].s; if not tc[n] then tc[n] = {['v']=v, ['co']=co, ['c']=c, ['ca']={}} end local lt = tc[n] a=tonumber(a) b=tonumber(b) table.insert(lt.ca, a, s) if a == b and #lt.ca == b then t.f.e(n) end end", 7, player)
	-- Inform
	-- One potential issue is dependency load order and requirement, this is something I'll have to look into at some point..
	player:SendAddonMessage("ws", "_G['"..cGTN.."'].f.i = function(n, v, c, co, s) local t=_G['"..cGTN.."']; if not(t.i[2]) then t.i[2] = tonumber(s) end if(c == 1) then RegisterForSave(n..'payload'); local cc = _G[n..'payload'] if(cc) then if(cc.v == v) then local p = cc.p if(co == 1) then p = lualzw.decompress(p) end t.f.l(p, n) return; end end end SendAddonMessage('wc', 'req'..n, 'WHISPER', UnitName('player')) end", 7, player)
	-- cache registry
	player:SendAddonMessage("ws", "_G['"..cGTN.."'].f.r = function(a) RegisterForSave(a); end", 7, player) 

	-- Sends an inform to the player about the available payloads
	SendPayloadInform(player)
end

local function PushInitModule(eventid, delay, repeats, player)
	if(player:GetData("ModuleInit") == true) then
		player:RemoveEventById(eventid)
		SendAddonInjector(player)
		return;
	end

	player:SendAddonMessage("ws", "SendAddonMessage('wc', 'loaded', 'WHISPER', UnitName('player')); print('[WardenLoader]: Injection successful.')", 7, player)
end

local function AwaitInjection(event, player)
	-- It is possible that the Warden injection happened while on the character screen.
	-- If so, it will not work, so we should set the warden packet as queued "just in case"
	-- This has no impact if the warden packet has not yet been sent, so eh.
	player:QueueWardenPayload()
	player:SendBroadcastMessage("[WardenLoader]: Awaiting injection...")
	-- Register timed event to try and push data to the client.
	player:SetData("ModuleInit", false)
	player:RegisterEvent(PushInitModule, 1000, 0)
end

local function OnAddonMessageReceived(event, player, _type, header, data, target)
	if player:GetName() == target:GetName() and _type == 7 then
		if(header == "wc") then
			if(data == "reload") then
				-- flag the player for re-injection if they reloaded their ui
				AwaitInjection(_, player)
			elseif(data == "loaded") then
				-- module is loaded and ready to receive data
				player:SetData("ModuleInit", true)
			elseif(data == "kill") then
				print("received kill command")
				-- kill the initial loader, this is to prevent spoofed addon packets with access to the protected namespace
				-- the initial injector can not be used after this point, and the injected helper functions above are the ones that need to be used.
				player:SendAddonMessage("ws", "false", 7, player)

				-- if the below is printed in your chat, then the initial injector was not disabled and you have problems to debug :)
				player:SendAddonMessage("ws", "print('[WardenLoader]: This message should never show.')", 7, player)
			elseif(data:sub(1, 3) == "req") then
				local addon = data:gsub(data:sub(1, 3),'')
				local t = WardenLoader.data[addon]
				if(t) then
					player:SendLargePayload(addon, t.version, t.cached, t.compressed, t.payload)
				end
			end
		end
	end
end

RegisterPlayerEvent(42, SendAddonInjector)
RegisterServerEvent(30, OnAddonMessageReceived)
RegisterPlayerEvent(3, AwaitInjection)