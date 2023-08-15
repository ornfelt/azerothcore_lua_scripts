--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Liadrin_GenChat(Unit)
	Unit:SendChatMessage(11, 0, "Why do you suffer the presence of this despicable Lady Liadrin? She and her followers distort the Light and make a mockery of all we stand for")
end

function Liadrin_AdalChat1(Unit)
	Unit:SendChatMessage(11, 0, "Patience, general. The Light embraces all who enter Shattrath in good faith.")
end

function Liadrin_LiaChat1(Unit)
	Unit:SendChatMessage(11, 0, "Thank you for allowing me to speak, A'dal. I know many of your allies despise me and my knights for our treatment of M'uru.")
end

function Liadrin_LiaChat2(Unit)
	Unit:SendChatMessage(11, 0, "When he was given to us by 'Prince' Kael'thas, we believed his power would help lead our people into a new age. ")
end

function Liadrin_LiaChat3(Unit)
	Unit:SendChatMessage(11, 0, "I've come to realize our path was a false one. We were betrayed by the man we called our prince. In his lust for power, he sent the felblood to attack us, and spirit M'uru away to the Sunwell")
end

function Liadrin_AdalChat2(Unit)
	Unit:SendChatMessage(11, 0, "Both our peoples suffered greatly at the hands of Kael'thas and his agents, Lady Liadrin. Your people were not the authors of their own fate, but they will die if they do not change. ")
end

function Liadrin_AdalChat3(Unit)
	Unit:SendChatMessage(11, 0, "M'uru accepted his role long ago, knowing full well what would happen to him. Will you accept your own? ")
end

function Liadrin_LiaChat4(Unit)
	Unit:SendChatMessage(11, 0, "I... I don't understand. You -- and M'uru -- knew all along that this would occur? ")
end

function Liadrin_AdalChat4(Unit)
	Unit:SendChatMessage(11, 0,"It wasn't I who fortold it, but Velen of the Draenei: ")
end

function Liadrin_AdalChat5(Unit)
	Unit:SendChatMessage(11, 0,"'Silvery moon, washed in blood,'")
end

function Liadrin_AdalChat6(Unit)
	Unit:SendChatMessage(11, 0,"'Led astray into the night, armed with the sword of broken Light.'")
end

function Liadrin_AdalChat7(Unit)
	Unit:SendChatMessage(11, 0,"'Broken, then betrayed by one, standing there bestride the sun.' ")
end

function Liadrin_AdalChat8(Unit)
	Unit:SendChatMessage(11, 0,"'At darkest hour, redemption comes, in knightly lady sworn to blood.' ")
end

function Liadrin_LiaChat5(Unit)
	Unit:SendChatMessage(11, 0, "I see it clearly now. I renounce my loyalties to House Sunstrider and its false prince. ")
end

function Liadrin_LiaChat6(Unit)
	Unit:SendChatMessage(11, 0, "I pledge the blades of my Blood Knights to the defeat of Kil'jaeden and the restoration of Silvermoon")
end

function Liadrin_LiaChat7(Unit)
	Unit:SendChatMessage(11, 0, "We will fight beside you, A'dal")
	Unit:CastSpell(45372)
end

function Liadrin_AdalChat9(Unit)
	Unit:SendChatMessage(11, 0, "The Shattered Sun Offensive will surely benefit from the addition of your knights, Lady Liadrin.")
end

function Liadrin_AdalChat10(Unit)
	Unit:SendChatMessage(11, 0, "The battle for the Sunwell is but the first step on your new path, Lady Liadrin. Shattrath is open to you and all who follow you.")
end

function Adal_1(Unit, Event)
	Unit:RegisterEvent("Liadrin_AdalChat1",1000,0)
	Unit:RegisterEvent("Liadrin_AdalChat2",8000,0)
	Unit:RegisterEvent("Liadrin_AdalChat3",10000,0)
	Unit:RegisterEvent("Liadrin_AdalChat4",14000,0)
	Unit:RegisterEvent("Liadrin_AdalChat5",16000,0)
	Unit:RegisterEvent("Liadrin_AdalChat6",19000,0)
	Unit:RegisterEvent("Liadrin_AdalChat7",22000,0)
	Unit:RegisterEvent("Liadrin_AdalChat8",25000,0)
	Unit:RegisterEvent("Liadrin_AdalChat9",33000,0)
	Unit:RegisterEvent("Liadrin_AdalChat10",36000,0)
end

function Gen_1(Unit, Event)
	Unit:RegisterEvent("Liadrin_GenChat1",500,0)
end


function Liadrin_OnReachWaypoint(Unit, Event)
	Unit:RegisterEvent("Gen_1",0,0)
	Unit:RegisterEvent("Adal_1",0,0)
	Unit:RegisterEvent("Liadrin_LiaChat1",2500,0)
	Unit:RegisterEvent("Liadrin_LiaChat2",4000,0)
	Unit:RegisterEvent("Liadrin_LiaChat3",6000,0)
	Unit:RegisterEvent("Liadrin_LiaChat4",12500,0)
	Unit:RegisterEvent("Liadrin_LiaChat5",27000,0)
	Unit:RegisterEvent("Liadrin_LiaChat6",29000,0)
	Unit:RegisterEvent("Liadrin_LiaChat7",31000,0)
end