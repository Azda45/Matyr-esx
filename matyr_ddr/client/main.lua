local p = nil

RegisterNUICallback('callback', function(data, cb)
    SetNuiFocus(false, false)
    resultReceived = true
    if data.success then
        p:resolve(true)
    else
        p:resolve(false)
    end
    p = nil
    cb('ok')
end)


function hacking(cb, dif, timer)
    p = promise.new()
    SendNUIMessage({
        action = 'ddr',
        difficulty = dif,
        timer = timer,
    })
    SetNuiFocus(true, true)
    local result = Citizen.Await(p)
    cb(result)
end

exports("hacking", hacking)
