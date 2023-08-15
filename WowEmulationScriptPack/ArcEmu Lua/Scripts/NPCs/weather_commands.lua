--------------------------------
-- Script by: RakkorZ - ZxOxZ --
--     Requires: LuaHypArc    --
--------------------------------

WEATHER = {}

--Weather Commands.

WEATHER.Command.Normal = "#weather normal"
WEATHER.Command.Foggy = "#weather foggy"
WEATHER.Command.Rainy = "#weather rainy"
WEATHER.Command.HeavyRain = "#weather heavyrain"
WEATHER.Command.Snowy = "#weather snowy"
WEATHER.Command.SandStorm = "#weather sandstorm"

--Weather Functions.

function WEATHER.OnChat(event, player, message, type, language)
	local WeatherMessage = message:lower()
		if (WeatherMessage:find(WEATHER.Command.Normal) == 1) then
			player:SetPlayerWeather(0, 2)
			return 0
		end
		if (WeatherMessage:find(WEATHER.Command.Foggy) == 1) then
			player:SetPlayerWeather(1, 2)
			return 0
		end
		if (WeatherMessage:find(WEATHER.Command.Rainy) == 1) then
			player:SetPlayerWeather(2, 2)
			return 0
		end
		if (WeatherMessage:find(WEATHER.Command.HeavyRain) == 1) then
			player:SetPlayerWeather(4, 2)
			return 0
		end
		if (WeatherMessage:find(WEATHER.Command.Snowy) == 1) then
			player:SetPlayerWeather(8, 2)
			return 0
		end
		if (WeatherMessage:find(WEATHER.Command.SandStorm) == 1) then
			player:SetPlayerWeather(16, 2)
			return 0
		end
end

RegisterServerHook(16, "WEATHER.OnChat")