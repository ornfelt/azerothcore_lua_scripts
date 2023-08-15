--[[
***************************
*      .-.                *
*      `-.. ..-. + +      *
*      `-''-'' '          *
*  OpenSource Scripting   *
*          Team           *
* http://sunplusplus.info *
*                         *
***************************
Created:Recon
-- ]]
function justin_Talk(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "And so the knights stood before the charging Horde and held their ground as a thousand berserk orcs came through the valley.")
        pUnit:RegisterEvent("justin_Talk1",97000, 1)
	end


function brandon_Talk1(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "Oh yeah, I heard about that.")
	pUnit:RegisterEvent("brandon_Talk2",70000, 1)
	end

function brandon_Talk2(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "Oh, c'mon thats not true.")
	pUnit:RegisterEvent("brandon_Talk3",72500, 1)
	end

function roman_Talk(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "I got worm guts on my shoes.")
	pUnit:RegisterEvent("roman_Talk1",65000, 1)
	end


function roman_Talk1(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "When he was given to us by 'Prince' Kael'thas, we believed his power would help us lead our people into a new age.")
	pUnit:RegisterEvent("roman_Talk2",65000, 1)
	end


function roman_Talk2(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "I thought I heard something.")
	pUnit:RegisterEvent("roman_Talk3",65000, 1)
	end

function brandon_Talk3(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "Really?")
	pUnit:RegisterEvent("brandon_Talk4",64000, 1)
	end

function brandon_Talk4(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "WoW.")
        pUnit:RegisterEvent("brandon_Talk5",64000, 1)
	end

function roman_Talk3(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "Something smells funny.")
        pUnit:RegisterEvent("roman_Talk4",65000, 1)
	end

function justin_Talk1(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "You know there are crocolisks in the canals. They were brought from the swamp as pets but got thrown in the canals.")
        pUnit:RegisterEvent("justin_Talk2",64000, 1)
	end

function justin_Talk2(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "Abd that's how Lothar killed thirty six orcs with his bare hands!")
        pUnit:RegisterEvent("justin_Talk3",70000, 1)
	end

function roman_Talk4(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "I think I see something.")
        pUnit:RegisterEvent("roman_Talk5",68000, 1)
	end

function roman_Talk5(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "Worm goes on the hook, hook goes in the water. Fish is in the water, our fish.")
        pUnit:RegisterEvent("roman_Talk6",70500, 1)
	end

function roman_Talk6(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "There is no spoon")
        pUnit:RegisterEvent("roman_Talk7",65000, 1)
	end

function justin_Talk3(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "And then the rabbit just bit his head off...I swear.")
        pUnit:RegisterEvent("justin_Talk4",61000, 1)
	end

function justin_Talk4(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "You know why orc eyes glow red? It's because they drink blood!")
        pUnit:RegisterEvent("justin_Talk5",64000, 1)
	end

function brandon_Talk5(pUnit,Event)
        pUnit:RegisterEvent("brandon_Talk1",66666, 1)
	end

function justin_Talk5(pUnit,Event)
        pUnit:RegisterEvent("justin_Talk",66666, 1)
	end

function roman_Talk7(pUnit,Event)
        pUnit:RegisterEvent("roman_Talk",66666, 1)
	end


function justin_Died(pUnit, Event)
pUnit:RemoveEvents()
end


function roman_Died(pUnit, Event)
pUnit:RemoveEvents()
end


function brandon_Died(pUnit, Event)
pUnit:RemoveEvents()
end


RegisterUnitEvent(1370, 18, "brandon_Talk1")
RegisterUnitEvent(1371, 18, "roman_Talk")
RegisterUnitEvent(1370, 4, "brandon_Died")
RegisterUnitEvent(1371, 4, "roman_Died")
RegisterUnitEvent(1368, 18, "justin_Talk")
RegisterUnitEvent(1368, 4, "justin_Died")
