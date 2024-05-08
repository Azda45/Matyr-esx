local Result = nil
local NUI_status = false

function circle(circles, seconds, callback)
    Result = nil
    NUI_status = true
    SendNUIMessage({
        action = 'circle',
        value = circles,
        time = seconds,
    })
    while NUI_status do
        Wait(5)
        SetNuiFocus(NUI_status, false)
    end
    Wait(100)
    SetNuiFocus(false, false)
    lockpickCallback = callback
    return Result
end

RegisterNUICallback('fail', function()
    ClearPedTasks(PlayerPedId())
    Result = false
    Wait(100)
    NUI_status = false
    SetNuiFocus(false, false)
    return Result
end)

RegisterNUICallback('success', function()
    Result = true
    Wait(100)
    NUI_status = false
    SetNuiFocus(false, false)
    return Result
end)