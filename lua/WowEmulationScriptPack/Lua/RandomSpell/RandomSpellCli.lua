
local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

local AioHandler = AIO.AddHandlers("RandomSpell", {})

MainFrame = CreateFrame("Frame", "MainFrame", UIParent)
local frame = MainFrame

-- FUNCTION FOR WAITING AND EXECUTING ANOTHER FUNCTION
local waitTable = {};
local waitFrame = nil;
function frame_wait(delay, func, ...)
  if(type(delay)~="number" or type(func)~="function") then
    return false;
  end
  if(waitFrame == nil) then
    waitFrame = CreateFrame("Frame","WaitFrame", UIParent);
    waitFrame:SetScript("onUpdate",function (self,elapse)
      local count = #waitTable;
      local i = 1;
      while(i<=count) do
        local waitRecord = tremove(waitTable,i);
        local d = tremove(waitRecord,1);
        local f = tremove(waitRecord,1);
        local p = tremove(waitRecord,1);
        if(d>elapse) then
          tinsert(waitTable,i,{d-elapse,f,p});
          i = i + 1;
        else
          count = count - 1;
          f(unpack(p));
        end
      end
    end);
  end
  tinsert(waitTable,{delay,func,{...}});
  return true;
end
-------------------------------------------------

function AioHandler.ShowFrame(player)
    UIFrameFadeIn(frame, 1, 0, 1)
    frame:Show()
    frame_wait(5, FadeOutFrame)
end

function FadeOutFrame(player)
    UIFrameFadeOut(frame, 0.5, 1, 0)
    frame_wait(0.5, HideFrame)
end

function HideFrame(player)
    frame:Hide()
end

function AioHandler.LoadMsg(player, roll)
    --return rolled
    CreateLink(roll)
end

-- FRAME DESIGN
-------------------------
frame:SetSize(300, 350)
frame:RegisterForDrag("LeftButton")
frame:SetPoint("TOP")
frame:SetToplevel(true)
frame:SetClampedToScreen(true)
-- Enable dragging of frame
frame:SetMovable(false)
frame:EnableMouse(false)
frame:Hide()

--AIO.SavePosition(frame)

local title = frame:CreateFontString("title")
title:SetFont("Fonts\\FRIZQT__.TTF", 13)
--title:SetSize("190,5")
title:SetPoint("CENTER", frame, "CENTER", 0, 65)
title:SetText("|cffFFC125YOU ROLLED|r")

local spellframe = CreateFrame("GameTooltip", "temptt", frame, "GameTooltipTemplate")
local spellicon = CreateFrame("Frame", "spellicon", frame)

function CreateLink(spell)
    spellframe:SetOwner(frame, "ANCHOR_NONE")
    spellframe:SetPoint("TOP", frame, "CENTER", 2, -10)
    spellframe:SetHeight(400)
    spellframe:SetWidth(300)
    
    name, rank, icon, castTime, minRange, maxRange, spellId = GetSpellInfo(spell)
    spellicon:SetSize(55,55)
    spellicon:SetPoint("CENTER", frame, "CENTER", 2, 20)
    spellicon:SetBackdrop({
        bgFile = icon
    })

    local linked = GetSpellLink(spell)
    if linked == nil then
        linked = GetSpellLink(78)
        linked = gsub(linked, "78", spell)
    end
    spellframe:SetHyperlink(linked)
    SendSystemMessage("You rolled: " .. tostring(linked));
end