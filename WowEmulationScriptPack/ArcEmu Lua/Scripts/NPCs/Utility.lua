--[[ Utility.lua

********************************
*                                                            *
* The Moon++ Scripting Project        *
*                                                            *
********************************

This software is provided as free and open source by the
staff of The Moon++ Scripting Project, in accordance with 
the GPL license. This means we provide the software we have 
created freely and it has been thoroughly tested to work for 
the developers, but NO GUARANTEE is made it will work for you 
as well. Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

Staff of The Moon++ Scripting Project, November 2007
~~End of License Agreement

All credits for the files in this folder that are GameMonkey scripts
go to the GMScripts project, for all their hard work for the Ascent 
community.

-- Moon++ Project, November 2007 ]]

-- public constructor
function initialiseData (d,u,v)
local i = 1
while i <= d.slotcount do
        if d.slots[i] == null then
   break
  end
        i = i + 1
     end

if i > d.slotcount then
  d.slotcount = i
end

d.slots[i] = u

d.data[i] = v
end

function findSelf (d,u)
local i = 1
while i <= d.slotcount do
  if d.slots[i] == u then
   return i
  end
        i = i + 1
     end
return 0
end

-- public get data
function getData(d,u)
local i = findSelf(d,u)
if i ~= 0 then
  return d.data[i]
else
  return nil
end
end


-- public set data
function setData(d,u,v)
local i = findSelf(d,u)
if i ~= 0 then
  d.data[i] = v
end
end

-- public destructor
function freeData (d,u)
local i = findSelf(d,u)
if i ~= 0 then
  d.slots[i] = null
end
end