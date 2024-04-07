local Failed = false
local Success = false

function password(numbersLength, timer, showTime)
    SendNUIMessage({ type = "numbers", length = numbersLength, timer = timer, showTime = showTime })
    SetNuiFocus(true, true)

    while not Failed and not Success do
        Citizen.Wait(1000)
    end

    SetNuiFocus(false, false)

    return Success
end

RegisterNUICallback('success', function(data)
    Success = true
    SetNuiFocus(false, false)
    Wait(2500)
    Success = false
end)

RegisterNUICallback('failed', function(data)
    Failed = true
    SetNuiFocus(false, false)
    Wait(2500)
    Failed = false
end)
