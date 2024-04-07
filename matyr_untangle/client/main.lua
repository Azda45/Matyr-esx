local p = nil

RegisterNUICallback('callback', function(data, cb)
    SetNuiFocus(false, false)
    if p then
        if data.success then
            p:resolve(true)
        else
            p:resolve(false)
        end
        p = nil -- Moved after resolving the promise
    else
        print("Error: Promise 'p' is nil.")
    end
    cb('ok')
end)

function untangle(cb, dots, time)
    p = promise.new()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'open',
        dots = dots,
        time = time
    })
    local result = Citizen.Await(p)
    cb(result)
end
