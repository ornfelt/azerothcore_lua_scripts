--[[ sleep delay
*********************************
*								*
* The LUA++ Scripting Project	*
*								*
*********************************

This software is provided as free and open source by the
staff of The LUA++ Scripting Project, in accordance with 
the AGPL license. This means we provide the software we have 
created freely and it has been thoroughly tested to work for 
the developers, but NO GUARANTEE is made it will work for you 
as well. Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- LUA++ staff, March 26, 2008. ]]


-- Basic sleep function to delay execution of any script for X amount of seconds,
-- not to exceed 10 seconds. To bypass the default max of 10 seconds specify as
-- second argument the max allowed seconds. This is on optional argument.

--[[ I do not recommend using this liberally through out your scripts because it uses lots of CPU,
    which can bring your server to its knee's if you use this too much. This is your warning!!!
   
    Usage:
        sleep(#); --where # is amount in seconds with default max of 10 seconds. An error will result from using a larger number.

    Optional:
        sleep(#, ##); -- where ## is the max amount allowed to sleep, this is a bypass of the default 10 seconds. !dangerous!
       
]]
	
function sleep(sec, optional_max)
	-- error checking
	assert(type(sec) == "number", "sleep arg 1 expecting number, got "..type(sec).."->"..tostring(sec));
	-- don't even bother going any farther if a negative number or zero is specified for seconds to sleep.
	if (sec <= 0) then return; end
	
	if (optional_max) then
		assert(type(optional_max) == "number", "sleep optional arg 2 expecting number, got "..type(optional_max).."->"..tostring(optional_max));
		assert(not(sec > optional_max), "sleep seconds exceeds specified max seconds allowed.");
	else
		assert(not(sec > 10), "sleep seconds exceeds max seconds allowed.");
	end
	
	local oldtime = os.time();
	repeat until (os.time()-oldtime) == sec;
	
end