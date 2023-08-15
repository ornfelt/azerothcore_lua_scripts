local FoodMessage = "#food"

function Test_OnChat(event, plr, message, type, language)
	if (message == FoodMessage) then  
		plr:AddItem(43523, 20)
	end
end


RegisterServerHook(16, "Test_OnChat")
