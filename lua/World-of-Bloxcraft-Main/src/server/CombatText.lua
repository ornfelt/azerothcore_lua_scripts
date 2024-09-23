local CombatText = {}

makeBillboard = function(item,text,c,pn)
    local bg = Instance.new("BillboardGui", item)
    bg.Enabled = true
    bg.AlwaysOnTop = true
    bg.Size = UDim2.new(5, -0.5, 5, 0)
    local f = Instance.new("Frame", bg)
    f.BackgroundTransparency = 1
	f.Size = UDim2.new(2.5, 0, 1.50, 0)
	f.Position = f.Position + UDim2.new(0, 0, 0, -25);
    local tb = Instance.new("TextBox", f)
    tb.Size = UDim2.new(0.5, 0, 0.5, 0)
    tb.Text = text
    tb.TextStrokeTransparency = 1
    tb.TextXAlignment = "Center"
	tb.TextYAlignment = "Top"
	tb.RichText = true;
	tb.TextStrokeTransparency = 0;
    tb.BackgroundTransparency = 1
	if pn == false then
    	tb.TextColor3 = Color3.new(208,208,0)
	else
		tb.TextColor3 = Color3.new(0, 255, 0);
	end
	if c==true then
   		tb.Font="ArialBold"
    	tb.FontSize = Enum.FontSize.Size60
		for i=0,1,0.015 do wait()
			tb.TextTransparency=i
		end
		bg:Destroy()
	else
		tb.Font="Arial"
		tb.FontSize = "Size36"
		coroutine.resume(coroutine.create(function()
			for i=0,1,0.015 do wait()
				tb.TextTransparency=i
			end
		end))
		for i=0,-80,-1 do wait()
			tb.Position=UDim2.new(0,0,0,i)
		end
		bg:Destroy()
	end
end

CombatText.sendMessage = function(msg,obj,c,pn)
	makeBillboard(obj,msg,c,pn)
end

return CombatText
