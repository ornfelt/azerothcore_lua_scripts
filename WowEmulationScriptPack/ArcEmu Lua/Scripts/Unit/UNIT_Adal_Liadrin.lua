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
function general_Talk(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "Why do you suffer the presence of this despicable Lady Liadrin? She and her followers distort the Light and make a mockery of all we stand for!")
        pUnit:RegisterEvent("general_Talk1",75000, 1)
	end


function adal_Talk1(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "Patience, general. The Light embraces all who enter Shattrath in good faith.")
	pUnit:RegisterEvent("adal_Talk2",74000, 1)
	end

function adal_Talk2(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "You are welcome in Shattrath, Lady Liadrin. We have long awaited your arrival.")
	pUnit:RegisterEvent("adal_Talk3",74000, 1)
	end

function liadrin_Talk(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "Thank you for allowing me to speak, A'dal. I know many of your allies despise me and my knights for our treatment of M'uru.")
	pUnit:RegisterEvent("liadrin_Talk1",75000, 1)
	end


function liadrin_Talk1(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "When he was given to us by 'Prince' Kael'thas, we believed his power would help us lead our people into a new age.")
	pUnit:RegisterEvent("liadrin_Talk2",75000, 1)
	end


function liadrin_Talk2(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "I've come to realize our path was a false one. We were betrayted by the man we called our prince. In his lust for power, he sent the felblood to attack us, and spirit M'uru away to the Sunwell.")
	pUnit:RegisterEvent("liadrin_Talk3",75000, 1)
	end

function adal_Talk3(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "Both our peoples have suffered greatly at the hands of Kael'thas and his agents, Lady Liadrin. Your people were not the authors of their own fate, but they will die if they do not change.")
	pUnit:RegisterEvent("adal_Talk4",74000, 1)
	end

function adal_Talk4(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "M'uru accepted his role in this long ago, knowing full well what would happen to him. Will you accept your own?")
        pUnit:RegisterEvent("adal_Talk5",74000, 1)
	end

function liadrin_Talk3(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "I... I don't understand. You -- and M'uru -- knew all along that this would occur?")
        pUnit:RegisterEvent("liadrin_Talk4",75000, 1)
	end

function adal_Talk5(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "It wasn't I who foretold it, but Velen of the Draenei:")
        pUnit:RegisterEvent("adal_Talk6",74000, 1)
	end

function adal_Talk6(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "'Silvery moon, washed in blood,''Led astray into the night, armed with sword of broken Light.''Broken, then betrayed by one, standing there bestride the sun.''At darkest hour, redemption comes, in knightly lady sworn to blood.'")
        pUnit:RegisterEvent("adal_Talk7",74000, 1)
	end

function liadrin_Talk4(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "I see it clearly now. I renounce my loyalties to House Sunstrider and its false prince.")
        pUnit:RegisterEvent("liadrin_Talk5",75000, 1)
	end

function liadrin_Talk5(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "I pledge the blades of my Blood Knights to the defeat of Kil'jaeden and the restoration of Silvermoon.")
        pUnit:RegisterEvent("liadrin_Talk6",75000, 1)
	end

function liadrin_Talk6(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "We will fight beside you, A'dal.")
        pUnit:RegisterEvent("liadrin_Talk7",75000, 1)
	end

function adal_Talk7(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "The Shattered Sun Offensive will surely benefit from the addition of your knights, Lady Liadrin.")
        pUnit:RegisterEvent("adal_Talk8",74000, 1)
	end

function adal_Talk8(pUnit,Event)
	pUnit:SendChatMessage(12, 0, "The battle for the Sunwell is but the first step on your new path, Lady Liadrin. Shattrath is open to you and all who follow you.")
        pUnit:RegisterEvent("adal_Talk9",74000, 1)
	end

function general_Talk1(pUnit,Event)
        pUnit:RegisterEvent("general_Talk",75000, 1)
	end

function adal_Talk8(pUnit,Event)
        pUnit:RegisterEvent("adal_Talk1",75000, 1)
	end

function liadrin_Talk7(pUnit,Event)
        pUnit:RegisterEvent("liadrin_Talk",75000, 1)
	end


function adal_Died(pUnit, Event)
pUnit:RemoveEvents()
end


function liadrin_Died(pUnit, Event)
pUnit:RemoveEvents()
end


function general_Died(pUnit, Event)
pUnit:RemoveEvents()
end


RegisterUnitEvent(18481, 18, "adal_Talk1")
RegisterUnitEvent(25246, 18, "liadrin_Talk")
RegisterUnitEvent(18481, 4, "adal_Died")
RegisterUnitEvent(25246, 4, "liadrin_Died")
RegisterUnitEvent(25167, 18, "general_Talk")
RegisterUnitEvent(25167, 4, "general_Died")
