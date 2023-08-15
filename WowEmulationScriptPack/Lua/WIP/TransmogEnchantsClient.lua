local AIO = AIO or require("AIO")

if AIO.AddAddon() then
	return
end

local TransmogEnchantHandler = AIO.AddHandlers("TMogEnchant", {})

-- confirm mainhand or offhand enchant
function POPUP_MHOH(scroll_entry)
	StaticPopupDialogs["CONFIRM_H"] = {
	  text = "Would you like to enchant the weapon in your mainhand or your offhand?",
	  button1 = "Mainhand",
	  button2 = "Offhand",
	  OnAccept = function()
		scroll_entry = scroll_entry
		hand = "mainhand"
		AIO.Handle("TMogEnchant", "EnchantApply", hand, scroll_entry)
	  end,
	  OnCancel = function()
		scroll_entry = scroll_entry
		hand = "offhand"
		AIO.Handle("TMogEnchant", "EnchantApply", hand, scroll_entry)
	  end,
	  timeout = 0,
	  whileDead = false,
	  hideOnEscape = true,
	  preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
	}
	StaticPopup_Show("CONFIRM_H")
end

function TransmogEnchantHandler.ShowPopUp(player, scroll_entry)
	POPUP_MHOH(scroll_entry)
end