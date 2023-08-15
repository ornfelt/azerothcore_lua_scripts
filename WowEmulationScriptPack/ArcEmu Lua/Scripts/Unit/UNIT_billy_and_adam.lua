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

function billy_Talk1(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "I heard that there are these huge fish that can walk on land to hunt, and eat people!")
	pUnit:RegisterEvent("billy_Talk2",41000, 1)
	end

function adam_Talk(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "My daddy says that in the ocean, there are fish so big they could swallow a whole ship.")
	pUnit:RegisterEvent("adam_Talk1",40000, 1)
	end

function billy_Talk2(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "I heard a story about this golden fish, and if you caught it you would get three wishes!")
	pUnit:RegisterEvent("billy_Talk3",41000, 1)
	end


function adam_Talk1(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "And one time, at camp, I caught a fish that was bigger than I am!!")
	pUnit:RegisterEvent("adam_Talk2",40000, 1)
	end


function billy_Talk3(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "I caught a big one last week, it had three eyes!")
	pUnit:RegisterEvent("billy_Talk4",41000, 1)
	end

function adam_Talk2(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "My daddy can catch more fish than your dady!")
	pUnit:RegisterEvent("adam_Talk4",40000, 1)
	end

function billy_Talk4(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "Look! Look! I caught something! Aww...it's just a stinky ol' boot.")
        pUnit:RegisterEvent("billy_Talk1",41000, 1)
	end

function adam_Talk4(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "Think there are any fish in here?")
        pUnit:RegisterEvent("adam_Talk",40000, 1)
	end

function billy_Died(pUnit, Event)
pUnit:RemoveEvents()
end


function adam_Died(pUnit, Event)
pUnit:RemoveEvents()
end


RegisterUnitEvent(1367, 18, "billy_Talk1")
RegisterUnitEvent(1366, 18, "adam_Talk")
RegisterUnitEvent(1367, 4, "billy_Died")
RegisterUnitEvent(1366, 4, "adam_Died")
