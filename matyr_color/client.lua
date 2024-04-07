local MinigameActive = false
local Result = nil


function color(icons, time)
    if MinigameActive then return end

    MinigameActive = true
    SetNuiFocus(true, true)
    SendNUIMessage({ res = 'BEGIN_MINIGAME', icons = icons, time = time*1000 })

    while MinigameActive do
        Citizen.Wait(100)
    end

    return Result
end

RegisterNUICallback('finished', function(data, cb)
    Result = data.result
    MinigameActive = false
    SetNuiFocus(false, false)
    cb('ok')
end)


