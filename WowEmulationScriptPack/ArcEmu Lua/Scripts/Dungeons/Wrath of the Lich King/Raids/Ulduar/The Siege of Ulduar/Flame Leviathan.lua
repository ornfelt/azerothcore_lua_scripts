function flamelev_oncombat(unit, event)
unit:sendchatmessage(14, 0, "hostile entities detected. Threat assessment protocol active. Primary target engaged. Time minus thirty seconds to re-evaluation.") 
unit:playsoundtoset(15506)
unit:registerevent("flamelev_secondmessage", 12000, 1)
unit:registerevent("flamelev_phase1", 20000, 1)
end

function flamelev_secondmessage(unit, event)
unit:playsoundtoset(15516)
unit:sendchatmessage(14, 0, "unauthorized entity attempting circuit overload. Activating anti-personnel countermeasures.")
end

function flamelev_phase1(unit, event)
unit:removeevents()
unit:castspellontarget(62374, unit:getrandomplayer(0))
unit:castspell(62374)
unit:sendchatmessage(14, 0, "pursuit objective modified. Changing course.")
unit:playsoundtoset(15508)
unit:registerevent("flamelev_missilebarrage", 21000, 0)
unit:registerevent("flamelev_vents", 73000, 0)
unit:registerevent("flamelev_psvoice", 34000, 0)
unit:registerevent("flamelev_pursued", 34000, 0)
unit:registerevent("flamelev_phase2", 5000, 0)
end

function flamelev_missilebarrage(unit, event)
unit:castspellontarget(62400, unit:getrandomplayer(0))
end

function flamelev_psvoice(unit, event)
unit:playsoundtoset(15508)
unit:sendchatmessage(14, 0, "pursuit objective modified. Changing course.")
end

function flamelev_pursued(unit, event)
unit:castspellontarget(62374, unit:getrandomplayer(0))
end

function flamelev_vents(unit, event)
unit:fullcastspell(62396)
unit:playsoundtoset(15510)
unit:sendchatmessage(14, 0, "orbital countermeasures enabled.")
end

function flamelev_phase2(unit, event)
if unit:gethealthpct() <= 80 then
unit:removeevents()
unit:fullcastspell(62680)
unit:registerevent("flamelev_voicephase2", 1000, 1)
unit:registerevent("flamelev_psvoice", 35000, 0)
unit:registerevent("flamelev_pursued", 35000, 0)
unit:registerevent("flamelev_flamejets", 43000, 0)
unit:registerevent("flamelev_firenova", 8493, 0)
unit:registerevent("flamelev_vents", 73000, 0)
unit:registerevent("flamelev_missilebarrage", 26000, 0)
unit:registerevent("flamelev_phase3", 1000, 0)
end
end

function flamelev_missilebarrage(unit, event)
unit:castspellontarget(62400, unit:getrandomplayer(0))
end

function flamelev_voicephase2(unit, event)
unit:sendchatmessage(14, 0, "system malfunction. Diverting power to support systems.")
unit:playsoundtoset(15517)
end

function flamelev_psvoice(unit, event)
unit:sendchatmessage(14, 0, "pursuit objective modified. Changing course.")
unit:playsoundtoset(15508)
end

function flamelev_pursued(unit, event)
unit:castspellontarget(62374, unit:getrandomplayer(0))
end

function flamelev_flamejets(unit, event)
unit:fullcastspell(62680)
end

function flamelev_vents(unit, event)
unit:fullcastspell(62396)
unit:playsoundtoset(15510)
unit:sendchatmessage(14, 0, "orbital countermeasures enabled.")
end

function flamelev_firenova(unit, event)
unit:fullcastspell(38728)
end

function flamelev_phase3(unit, event)
if unit:gethealthpct() <= 15 then
unit:removeevents()
unit:sendchatmessage(14, 0, "system restart required. Deactivating weapon systems.")
unit:registerevent("flamelev_systemvoice", 1000, 1)
unit:registerevent("flamelev_battering", 25517, 10)
unit:registerevent("flamelev_searingflame", 30284, 0)
unit:registerevent("flamelev_flamejets", 62000, 0)
unit:registerevent("flamelev_missilebarrage", 26000, 0)
end
end

function flamelev_missilebarrage(unit, event)
unit:castspellontarget(62400, unit:getrandomplayer(0))
end

function flamelev_systemvoice(unit, event)
unit:playsoundtoset(15519)
end

function flamelev_battering(unit, event)
unit:castspellontarget(62376, unit:getrandomplayer(0))
end

function flamelev_flamejets(unit, event)
unit:fullcastspell(62680)
end

function flamelev_searingflame(unit, event)
unit:fullcastspellontarget(62661, unit:getrandomplayer(0))
end

function flamelev_onleavecombat(unit, event)
unit:removeevents()
end

function flamelev_onkilledtarget(unit, event)
unit:playsoundtoset(15521)
unit:sendchatmessage(14, 0, "threat assessment routine modified. Current target threat level: Zero. Acquiring new target.")
end

function flamelev_ondeath(unit, event)
unit:playsoundtoset(15520)
unit:sendchatmessage(14, 0, "total systems failure. Defense protocols breached. Leviathan unit shutting down.")
unit:removeevents()
end 

RegisterUnitEvent (33113, 1, "flamelev_oncombat")
RegisterUnitEvent (33113, 2, "flamelev_onleavecombat")
RegisterUnitEvent (33113, 3, "flamelev_onkilledtarget")
RegisterUnitEvent (33113, 4, "flamelev_ondeath")