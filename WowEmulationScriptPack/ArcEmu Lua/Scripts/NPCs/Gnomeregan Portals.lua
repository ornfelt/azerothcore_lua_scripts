-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright (c) zdroid9770                  --
-------------------------------------------------------------------

function Gnome_onUse (Unit, Event, pMisc)
	pMisc:Teleport (0, -4966.618652, 705.545776, 249.368668)
end

RegisterGameObjectEvent (55001, 2, 'Gnome_onUse')