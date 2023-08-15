--[[
********************************
*                                                            *
* The LUA++ Scripting Project        *
*                                                            *
********************************

--#############################################################################
--#     #     #           #       ## # #  ######    #####                        
--#    # #   # #         # #     #        #         #    #                      

--#   #   # #   #       #   #   #    # #  ###       #####                       

--#  #     #     #     #######   #     #  #         #  #                        

--# #             #   #       #    # #    ######    #   #                       
--##############################################################################
        
--        #############################################
--       #                 LUA++                     #
--      #                                           #
--     #           Scripted By Mager1794           #
--    #   http://luaplusplus.org/forum            #
--    ############################################

--####################################################
--#                Hogger Fight                      #
--#              Written by Mager1794                #
--#              No SQL Work is Needed               #
--####################################################

This software is provided as free and open source by the
staff of The LUA++ Scripting Project, in accordance with 
the AGPL license. This means we provide the software we have 
created freely and it has been thoroughly tested to work for 
the developers, but NO GUARANTEE is made it will work for you 
as well. Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- LUA++ staff, April 27, 2008. ]]

function HoggerOnCombat(Unit)
	local plr =	Unit:GetClosestPlayer()
	if (plr ~= nil) then
		Unit:CastSpellOnTarget(6268, plr) --Needed the plr as target.
		Unit:SendChatMessage(9, 0, "Hogger charges!!!");
	end
end

RegisterUnitEvent(448, 1, "HoggerOnCombat")

--Simply Makes him charge on combat
 