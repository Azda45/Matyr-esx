local Failed = false
local Success = false

function lightsout(grid, maxClicks)
    if grid > 4 then
        grid = 4
    end

    SendNUIMessage({ type = "lightsout", starthack = true, grid = grid, length = maxClicks })
    SetNuiFocus(true, true)

    while not Failed and not Success do
        Wait(1000)
    end
    local result = Success
    Success = false
    Failed = false

    return result, grid
end

RegisterNUICallback('success', function(data)
    Success = true
    SetNuiFocus(false, false)
    Wait(2500)
end)

RegisterNUICallback('failed', function(data)
    Failed = true
    SetNuiFocus(false, false)
    Wait(2500)
end)