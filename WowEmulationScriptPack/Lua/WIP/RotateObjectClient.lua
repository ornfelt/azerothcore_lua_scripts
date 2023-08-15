local AIO = AIO or require("AIO")

if AIO.AddAddon() then
	return
end

local GobRotHandlers = AIO.AddHandlers("RotateGobs", {})

local GobTurnFrame = CreateFrame("Frame", "FrameTurnGob", UIParent, "UIPanelDialogTemplate")
GobTurnFrame:SetSize(300, 360)
GobTurnFrame:SetMovable(true)
GobTurnFrame:EnableMouse(true)
GobTurnFrame:SetToplevel(true)
GobTurnFrame:RegisterForDrag("LeftButton")
GobTurnFrame:SetPoint("CENTER")
GobTurnFrame:SetScript("OnDragStart", GobTurnFrame.StartMoving)
GobTurnFrame:SetScript("OnHide", GobTurnFrame.StopMovingOrSizing)
GobTurnFrame:SetScript("OnDragStop", GobTurnFrame.StopMovingOrSizing)
GobTurnFrame:SetScript("OnShow", function() PlaySound("igCharacterInfoTab") end)
GobTurnFrame:SetScript("OnHide", function() PlaySound("igCharacterInfoClose") end)
AIO.SavePosition(GobTurnFrame)
GobTurnFrame:SetClampedToScreen(true)
GobTurnFrame:Hide()
local GobTurnFrame_Text1 = GobTurnFrame:CreateFontString("GobTurnFrame_Text1")
GobTurnFrame_Text1:SetFont("Fonts\\FRIZQT__.TTF", 12)
GobTurnFrame_Text1:SetSize(190, 5)
GobTurnFrame_Text1:SetPoint("TOP", "FrameTurnGob", "TOP", 0, -13)
GobTurnFrame_Text1:SetText("APT Tool")


--guid input box
local GobTurnFrame_EditBox = CreateFrame("EditBox", "GUIDInput", GobTurnFrame, "InputBoxTemplate")
GobTurnFrame_EditBox:SetSize(75, 75)
GobTurnFrame_EditBox:SetAutoFocus(false)
GobTurnFrame_EditBox:SetPoint("TOP", "FrameTurnGob", "TOP", 0, -30)
GobTurnFrame_EditBox:SetScript("OnEnterPressed", GobTurnFrame_EditBox.ClearFocus)
GobTurnFrame_EditBox:SetScript("OnEscapePressed", GobTurnFrame_EditBox.ClearFocus)
local GobTurnFrame_EditBox_Text1 = GobTurnFrame_EditBox:CreateFontString("GobTurnFrame_EditBox_Text1")
GobTurnFrame_EditBox_Text1:SetFont("Fonts\\FRIZQT__.TTF", 12)
GobTurnFrame_EditBox_Text1:SetSize(190, 5)
GobTurnFrame_EditBox_Text1:SetPoint("CENTER", 0, 20)
GobTurnFrame_EditBox_Text1:SetText("GUID")

-- sliders lol
	local name = "XSlider"
	local slider1 = CreateFrame("Slider",name,GobTurnFrame,"OptionsSliderTemplate") --frameType, frameName, frameParent, frameTemplate   
	slider1:SetPoint("TOP", "GUIDInput", "TOP", 0, -70)
	slider1.textLow = _G[name.."Low"]
	slider1.textHigh = _G[name.."High"]
	slider1.text = _G[name.."Text"]
	slider1:SetMinMaxValues(0, 6.28)
	slider1:SetValueStep(0.01)
	slider1.minValue, slider1.maxValue = slider1:GetMinMaxValues() 
	slider1.textLow:SetText(string.format("%.2f", slider1.minValue))
	slider1.textHigh:SetText(string.format("%.2f", slider1.maxValue))
	slider1.text:SetText(name)
	slider1:SetValue(0)
	local slider1_editbox = CreateFrame("EDITBOX", "$parentValue", slider1, "InputBoxTemplate")
	slider1_editbox:SetSize(40, 20)
	slider1_editbox:SetPoint("CENTER", 115, 0)
	slider1_editbox:SetAutoFocus(false)
	
	local name = "YSlider"
	local slider2 = CreateFrame("Slider",name,GobTurnFrame,"OptionsSliderTemplate") --frameType, frameName, frameParent, frameTemplate   
	slider2:SetPoint("TOP", "GUIDInput", "TOP", 0, -120)
	slider2.textLow = _G[name.."Low"]
	slider2.textHigh = _G[name.."High"]
	slider2.text = _G[name.."Text"]
	slider2:SetMinMaxValues(0, 6.28)
	slider2:SetValueStep(0.01)
	slider2.minValue, slider2.maxValue = slider2:GetMinMaxValues() 
	slider2.textLow:SetText(string.format("%.2f", slider2.minValue))
	slider2.textHigh:SetText(string.format("%.2f", slider2.maxValue))
	slider2.text:SetText(name)
	slider2:SetValue(0)
	local slider2_editbox = CreateFrame("EDITBOX", "$parentValue", slider2, "InputBoxTemplate")
	slider2_editbox:SetSize(40, 20)
	slider2_editbox:SetPoint("CENTER", 115, 0)
	slider2_editbox:SetAutoFocus(false)
	
	local name = "ZSlider"
	local slider3 = CreateFrame("Slider",name,GobTurnFrame,"OptionsSliderTemplate") --frameType, frameName, frameParent, frameTemplate   
	slider3:SetPoint("TOP", "GUIDInput", "TOP", 0, -170)
	slider3.textLow = _G[name.."Low"]
	slider3.textHigh = _G[name.."High"]
	slider3.text = _G[name.."Text"]
	slider3:SetMinMaxValues(0, 6.28)
	slider3:SetValueStep(0.01)
	slider3.minValue, slider3.maxValue = slider3:GetMinMaxValues() 
	slider3.textLow:SetText(string.format("%.2f", slider3.minValue))
	slider3.textHigh:SetText(string.format("%.2f", slider3.maxValue))
	slider3.text:SetText(name)
	slider3:SetValue(0)
	local slider3_editbox = CreateFrame("EDITBOX", "$parentValue", slider3, "InputBoxTemplate")
	slider3_editbox:SetSize(40, 20)
	slider3_editbox:SetPoint("CENTER", 115, 0)
	slider3_editbox:SetAutoFocus(false)

	local name = "Up/Down"
	local slider4 = CreateFrame("Slider",name,GobTurnFrame,"OptionsSliderTemplate") --frameType, frameName, frameParent, frameTemplate   
	slider4:SetPoint("TOP", "GUIDInput", "TOP", 0, -220)
	slider4.textLow = _G[name.."Low"]
	slider4.textHigh = _G[name.."High"]
	slider4.text = _G[name.."Text"]
	slider4:SetMinMaxValues(-5, 5)
	slider4:SetValueStep(0.1)
	slider4.minValue, slider4.maxValue = slider4:GetMinMaxValues() 
	slider4.textLow:SetText(string.format("%.2f", slider4.minValue))
	slider4.textHigh:SetText(string.format("%.2f", slider4.maxValue))
	slider4.text:SetText(name)
	slider4:SetValue(0)
	local slider4_editbox = CreateFrame("EDITBOX", "$parentValue", slider4, "InputBoxTemplate")
	slider4_editbox:SetSize(40, 20)
	slider4_editbox:SetPoint("CENTER", 115, 0)
	slider4_editbox:SetAutoFocus(false)

	local name = "Scale"
	local slider5 = CreateFrame("Slider",name,GobTurnFrame,"OptionsSliderTemplate") --frameType, frameName, frameParent, frameTemplate   
	slider5:SetPoint("TOP", "GUIDInput", "TOP", 0, -270)
	slider5.textLow = _G[name.."Low"]
	slider5.textHigh = _G[name.."High"]
	slider5.text = _G[name.."Text"]
	slider5:SetMinMaxValues(0.1, 2.0)
	slider5:SetValueStep(0.1)
	slider5.minValue, slider5.maxValue = slider5:GetMinMaxValues() 
	slider5.textLow:SetText(string.format("%.2f", slider5.minValue))
	slider5.textHigh:SetText(string.format("%.2f", slider5.maxValue))
	slider5.text:SetText(name)
	slider5:SetValue(0)
	local slider5_editbox = CreateFrame("EDITBOX", "$parentValue", slider5, "InputBoxTemplate")
	slider5_editbox:SetSize(40, 20)
	slider5_editbox:SetPoint("CENTER", 115, 0)
	slider5_editbox:SetAutoFocus(false)
	
	
	-- set scripts for sliders
	slider1:SetScript("OnMouseUp", function(self,button)
		editbox = tonumber(GobTurnFrame_EditBox:GetText())
		val_1 = slider1:GetValue()
		val_2 = slider2:GetValue()
		val_3 = slider3:GetValue()
		val_4 = 0
		val_5 = 0
		slider1_editbox:SetText(string.format("%.2f", val_1))
		if (GobTurnFrame_EditBox:GetText() == "") then
			-- prevent spam of wrong error message
			return false
		elseif (editbox == nil) then
			print("You must input a number.")
			return false
		else
			AIO.Handle("RotateGobs", "CheckRotate", val_1, val_2, val_3, editbox, val_4, val_5)
		end
	end)
	slider2:SetScript("OnMouseUp", function(self,button)
		editbox = tonumber(GobTurnFrame_EditBox:GetText())
		val_1 = slider1:GetValue()
		val_2 = slider2:GetValue()
		val_3 = slider3:GetValue()
		val_4 = 0
		val_5 = 0
		slider2_editbox:SetText(string.format("%.2f", val_2))
		if (GobTurnFrame_EditBox:GetText() == "") then
			-- prevent spam of wrong error message
			return false
		elseif (editbox == nil) then
			print("You must input a number.")
			return false
		else
			AIO.Handle("RotateGobs", "CheckRotate", val_1, val_2, val_3, editbox, val_4, val_5)
		end
	end)
	slider3:SetScript("OnMouseUp", function(self,button)
		editbox = tonumber(GobTurnFrame_EditBox:GetText())
		val_1 = slider1:GetValue()
		val_2 = slider2:GetValue()
		val_3 = slider3:GetValue()
		val_4 = 0
		val_5 = 0
		slider3_editbox:SetText(string.format("%.2f", val_3))
		if (GobTurnFrame_EditBox:GetText() == "") then
			-- prevent spam of wrong error message
			return false
		elseif (editbox == nil) then
			print("You must input a number.")
			return false
		else
			AIO.Handle("RotateGobs", "CheckRotate", val_1, val_2, val_3, editbox, val_4, val_5)
		end
	end)
	slider4:SetScript("OnMouseUp", function(self,button)
		editbox = tonumber(GobTurnFrame_EditBox:GetText())
		val_1 = 0
		val_2 = 0
		val_3 = 0
		val_4 = slider4:GetValue()
		val_5 = 0
		slider4_editbox:SetText(string.format("%.2f", val_4))
		if (GobTurnFrame_EditBox:GetText() == "") then
			-- prevent spam of wrong error message
			return false
		elseif (editbox == nil) then
			print("You must input a number.")
			return false
		else
			AIO.Handle("RotateGobs", "CheckRotate", val_1, val_2, val_3, editbox, val_4, val_5)
		end
	end)
	slider5:SetScript("OnMouseUp", function(self,button)
		editbox = tonumber(GobTurnFrame_EditBox:GetText())
		val_1 = 0
		val_2 = 0
		val_3 = 0
		val_4 = 0
		val_5 = slider5:GetValue()
		slider5_editbox:SetText(string.format("%.2f", val_5))
		if (GobTurnFrame_EditBox:GetText() == "") then
			-- prevent spam of wrong error message
			return false
		elseif (editbox == nil) then
			print("You must input a number.")
			return false
		else
			AIO.Handle("RotateGobs", "CheckRotate", val_1, val_2, val_3, editbox, val_4, val_5)
		end
	end)	
	
	-- set scripts for all input boxes
	slider1_editbox:SetScript("OnEnterPressed", function(self)
		editbox = tonumber(GobTurnFrame_EditBox:GetText())
		val_1 = slider1:GetValue()
		val_2 = slider2:GetValue()
		val_3 = slider3:GetValue()
		val_4 = 0
		val_5 = 0
		if (tonumber(slider1_editbox:GetText()) == nil) then
			print("You must input a number in order to apply this to the sliders.")
			slider1_editbox.ClearFocus()
			return false
		elseif (tonumber(slider1_editbox:GetText()) > slider1.maxValue) or (tonumber(slider1_editbox:GetText()) < slider1.minValue) then
			print("You must input a number between " ..slider1.minValue.. " and " ..slider1.maxValue.. ".")
			slider1_editbox.ClearFocus()
			return false
		elseif (GobTurnFrame_EditBox:GetText() == "") then
			slider1:SetValue(tonumber(slider1_editbox:GetText()))
			slider1_editbox.ClearFocus()
			return false
		elseif (editbox == nil) then
			print("You must input a GUID number.")
			slider1:SetValue(tonumber(slider1_editbox:GetText()))
			slider1_editbox.ClearFocus()
			return false
		else
			slider1:SetValue(tonumber(slider1_editbox:GetText()))
			AIO.Handle("RotateGobs", "CheckRotate", val_1, val_2, val_3, editbox, val_4, val_5)
			slider1_editbox.ClearFocus()
			return false
		end
	end)
	slider1_editbox:SetScript("OnEscapePressed", slider1_editbox.ClearFocus)
	
	slider2_editbox:SetScript("OnEnterPressed", function(self)
		editbox = tonumber(GobTurnFrame_EditBox:GetText())
		val_1 = slider1:GetValue()
		val_2 = slider2:GetValue()
		val_3 = slider3:GetValue()
		val_4 = 0
		val_5 = 0
		if (tonumber(slider2_editbox:GetText()) == nil) then
			print("You must input a number in order to apply this to the sliders.")
			slider2_editbox.ClearFocus()
			return false
		elseif (tonumber(slider2_editbox:GetText()) > slider2.maxValue) or (tonumber(slider2_editbox:GetText()) < slider2.minValue) then
			print("You must input a number between " ..slider2.minValue.. " and " ..slider2.maxValue.. ".")
			slider2_editbox.ClearFocus()
			return false
		elseif (GobTurnFrame_EditBox:GetText() == "") then
			slider2:SetValue(tonumber(slider2_editbox:GetText()))
			slider2_editbox.ClearFocus()
			return false
		elseif (editbox == nil) then
			print("You must input a GUID number.")
			slider2:SetValue(tonumber(slider2_editbox:GetText()))
			slider2_editbox.ClearFocus()
			return false
		else
			slider2:SetValue(tonumber(slider2_editbox:GetText()))
			AIO.Handle("RotateGobs", "CheckRotate", val_1, val_2, val_3, editbox, val_4, val_5)
			slider2_editbox.ClearFocus()
			return false
		end
	end)
	slider2_editbox:SetScript("OnEscapePressed", slider2_editbox.ClearFocus)
	
	slider3_editbox:SetScript("OnEnterPressed", function(self)
		editbox = tonumber(GobTurnFrame_EditBox:GetText())
		val_1 = slider1:GetValue()
		val_2 = slider2:GetValue()
		val_3 = slider3:GetValue()
		val_4 = 0
		val_5 = 0
		if (tonumber(slider3_editbox:GetText()) == nil) then
			print("You must input a number in order to apply this to the sliders.")
			slider3_editbox.ClearFocus()
			return false
		elseif (tonumber(slider3_editbox:GetText()) > slider3.maxValue) or (tonumber(slider3_editbox:GetText()) < slider3.minValue) then
			print("You must input a number between " ..slider3.minValue.. " and " ..slider3.maxValue.. ".")
			slider3_editbox.ClearFocus()
			return false
		elseif (GobTurnFrame_EditBox:GetText() == "") then
			slider3:SetValue(tonumber(slider3_editbox:GetText()))
			slider3_editbox.ClearFocus()
			return false
		elseif (editbox == nil) then
			print("You must input a GUID number.")
			slider3:SetValue(tonumber(slider3_editbox:GetText()))
			slider3_editbox.ClearFocus()
			return false
		else
			slider3:SetValue(tonumber(slider3_editbox:GetText()))
			AIO.Handle("RotateGobs", "CheckRotate", val_1, val_2, val_3, editbox, val_4, val_5)
			slider3_editbox.ClearFocus()
			return false
		end
	end)
	
	slider4_editbox:SetScript("OnEscapePressed", slider4_editbox.ClearFocus)
	slider4_editbox:SetScript("OnEnterPressed", function(self)
		editbox = tonumber(GobTurnFrame_EditBox:GetText())
		val_1 = 0
		val_2 = 0
		val_3 = 0
		val_4 = slider4:GetValue()
		val_5 = 0
		if (tonumber(slider4_editbox:GetText()) == nil) then
			print("You must input a number in order to apply this to the sliders.")
			slider4_editbox.ClearFocus()
			return false
		elseif (tonumber(slider4_editbox:GetText()) > slider4.maxValue) or (tonumber(slider4_editbox:GetText()) < slider4.minValue) then
			print("You must input a number between " ..slider4.minValue.. " and " ..slider4.maxValue.. ".")
			slider4_editbox.ClearFocus()
			return false
		elseif (GobTurnFrame_EditBox:GetText() == "") then
			slider4:SetValue(tonumber(slider4_editbox:GetText()))
			slider4_editbox.ClearFocus()
			return false
		elseif (editbox == nil) then
			print("You must input a GUID number.")
			slider4:SetValue(tonumber(slider4_editbox:GetText()))
			slider4_editbox.ClearFocus()
			return false
		else
			slider4:SetValue(tonumber(slider4_editbox:GetText()))
			AIO.Handle("RotateGobs", "CheckRotate", val_1, val_2, val_3, editbox, val_4, val_5)
			slider4_editbox.ClearFocus()
			return false
		end
	end)
	
	slider5_editbox:SetScript("OnEscapePressed", slider5_editbox.ClearFocus)
	slider5_editbox:SetScript("OnEnterPressed", function(self)
		editbox = tonumber(GobTurnFrame_EditBox:GetText())
		val_1 = 0
		val_2 = 0
		val_3 = 0
		val_4 = 0
		val_5 = slider5:GetValue()
		if (tonumber(slider5_editbox:GetText()) == nil) then
			print("You must input a number in order to apply this to the sliders.")
			slider5_editbox.ClearFocus()
			return false
		elseif (tonumber(slider5_editbox:GetText()) > slider5.maxValue) or (tonumber(slider5_editbox:GetText()) < slider5.minValue) then
			print("You must input a number between " ..slider5.minValue.. " and " ..slider5.maxValue.. ".")
			slider5_editbox.ClearFocus()
			return false
		elseif (GobTurnFrame_EditBox:GetText() == "") then
			slider5:SetValue(tonumber(slider5_editbox:GetText()))
			slider5_editbox.ClearFocus()
			return false
		elseif (editbox == nil) then
			print("You must input a GUID number.")
			slider5:SetValue(tonumber(slider5_editbox:GetText()))
			slider5_editbox.ClearFocus()
			return false
		else
			slider5:SetValue(tonumber(slider5_editbox:GetText()))
			AIO.Handle("RotateGobs", "CheckRotate", val_1, val_2, val_3, editbox, val_4, val_5)
			slider5_editbox.ClearFocus()
			return false
		end
	end)	

function GobRotHandlers.CommandOutput(player, val_1, val_2, val_3, editbox, gm)
	if gm == true then
		SendChatMessage(".gob turn " ..editbox.. " "..val_1.." "..val_2.." "..val_3, "SAY")
	end
end

function GobRotHandlers.ShowMain(player)
	GobTurnFrame:Show()
end