function killCreature(event, killer, killed)
	local qry = WorldDBQuery("SELECT * FROM custom_quest WHERE GUID = "..(killer:GetGUIDLow()))
	if(qry ~= nil)then
		local isitem = qry:GetUInt32(4)
		if(isitem == 0)then
			local entry = qry:GetUInt32(1)
			if(entry == killed:GetEntry())then
				updateQuestProgress(killer, 1)
			end
		--else
			--some loot check for the item
			--updateQuestProgress(killer, 1)
		end
	end
end
RegisterPlayerEvent(7, killCreature)



local First = {
"Greetings", --insert player
"Salutations"
}

local Second = {
"There has been a disturbance of", --insert mob name
"There are rumors of "
}
--local full = First[math.random(#First)] .. Player:GetName() .. Second[math.random(#Second)] .. req:GetName()

--box:setText(full)