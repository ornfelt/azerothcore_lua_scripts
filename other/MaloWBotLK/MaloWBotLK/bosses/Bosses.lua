mb_BossModule_registeredModules = {}
mb_BossModule_unloadFunction = nil
mb_BossModule_currentLoadedModule = nil
-- autoLoadUnloadCreatureName is optional, the boss module will automatically load if the commander targets this creature
-- and will automatically unload if the commander targets this creature when it's dead
function mb_BossModule_RegisterModule(moduleName, onLoadFunc, autoLoadUnloadCreatureName)
    mb_BossModule_registeredModules[moduleName] = onLoadFunc
    if autoLoadUnloadCreatureName ~= nil then
        mb_BossModule_registeredAutoLoadUnloads[autoLoadUnloadCreatureName] = moduleName
    end
end

function mb_BossModule_LoadModule(name)
    if mb_BossModule_currentLoadedModule == name then
        return
    end
    if name == "unload" and mb_BossModule_currentLoadedModule == nil then
        return
    end
    if mb_BossModule_unloadFunction ~= nil then
        mb_BossModule_unloadFunction()
        mb_BossModule_unloadFunction = nil
    end
    mb_BossModule_currentLoadedModule = nil
    mb_GoToPosition_Reset()
    MoveForwardStart()
    mb_StopMoving()
    mb_EnableAutomaticMovement()
    mb_BossModule_PreOnUpdate = mb_BossModule_originalPreOnUpdateFunction
    if name == "unload" then
        mb_SayRaid("Boss module unloaded")
        return
    end

    if mb_BossModule_registeredModules[name] == nil then
        mb_SayRaid("No BossModule registered with the name: " .. tostring(name))
        return
    end
    mb_BossModule_currentLoadedModule = name
    mb_BossModule_registeredModules[name]()
    mb_SayRaid("Loaded " .. name .. " BossModule")
end

mb_BossModule_registeredAutoLoadUnloads = {}
mb_BossModule_lastAutoLoadUnloadCheck = 0
function mb_BossModule_AutoLoadUnload()
    if mb_BossModule_lastAutoLoadUnloadCheck + 3 > mb_time then
        return
    end
    mb_BossModule_lastAutoLoadUnloadCheck = mb_time
    if not UnitExists("target") then
        return
    end
    for creatureName, moduleName in pairs(mb_BossModule_registeredAutoLoadUnloads) do
        if UnitName("target") == creatureName then
            if mb_BossModule_currentLoadedModule ~= moduleName then
                mb_BossModule_LoadModule(moduleName)
                mb_SendMessage("remoteExecute ", "mb_BossModule_LoadModule(\"" .. moduleName .. "\")")
            elseif UnitIsDeadOrGhost("target") then
                mb_BossModule_LoadModule("unload")
                mb_SendMessage("remoteExecute ", "mb_BossModule_LoadModule(\"unload\")")
            end
            return
        end
    end
end

-- Override this in boss-modules. Return false to execute normal class-code, return true to prevent class-code
function mb_BossModule_PreOnUpdate()
    return false
end
mb_BossModule_originalPreOnUpdateFunction = mb_BossModule_PreOnUpdate