local Phase = {"#Faction", "#faction"}
local Team = {"#Team", "#team"}
local Lock = {"#lock", "#Lock#"}

function FactionChat(event, pPlayer, message, pType, pLanguage, pMisc)
	if(message == Phase[1] or message == Phase[2]) then
			local rhase = pPlayer:GetFaction()
			pPlayer:SendBroadcastMessage("|cFF00FF00[Faction System]: |cFF43BFC7You are now in faction "..rhase..".")
			return 0
			end
				if(pPlayer:GetSelection() == true) then
				local target = pPlayer:GetSelection()
				local shase = target:GetFaction()
				pPlayer:SendBroadcastMessage("|cFF00FF00[Faction System]: |cFF43BFC7The object is in faction "..shase..".")
					return 0
					end
end


		
RegisterServerHook(16, "FactionChat")

Fhase = {"#GetPhase", "#getphase", "#Getphase", "#getPhase"}

function SyndicateChat(event, pPlayer, message, pType, pLanguage, pMisc)
	if(message == Fhase[1] or message == Fhase[2] or message == Fhase[3] or message == Fhase[4]) then
			local phase = pPlayer:GetPhase()
			pPlayer:SendBroadcastMessage("|cFF00FF00[Phasing System]: |cFF43BFC7You are now in phase "..phase..".")
			return 0
			end
end

RegisterServerHook(16, "SyndicateChat")

function TeamChat(event, pPlayer, message, type, language, misc)
	if(message == Team[1] or message == Team[2]) then
		local team = pPlayer:GetTeam()
		pPlayer:SendBroadcastMessage("|cFF00FF00[Faction System]: |cFF43BFC7Your team "..team.."")
		end
end

RegisterServerHook(16, "TeamChat")

function NewPlayer(event, pPlayer)
	local world = GetPlayersInWorld()
		for _,v in pairs(world) do
			v:SendAreaTriggerMessage("Please welcome "..pPlayer:GetName().." to CNA-WoW!")
			break
			end
end



RegisterServerHook(20, "NewPlayer")