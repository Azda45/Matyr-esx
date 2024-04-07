local p = nil

RegisterNUICallback("dataPost", function(data, cb)
    SetNuiFocus(false)
    p:resolve(data.data)
    p = nil
    cb("ok")
end)

RegisterNUICallback("cancel", function(data, cb)
    SetNuiFocus(false)
    p:resolve(nil)
    p = nil
    cb("ok")
end)

function KeyboardInput(data)
    Wait(150)
    if not data then return end
    if p then return end

    p = promise.new()

    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "OPEN_MENU",
        data = data
    })

    return Citizen.Await(p)
end

exports("KeyboardInput", KeyboardInput)

RegisterCommand('keytes', function(source, args, rawCommand)
    local keyboardInput = exports["matyr_key"]:KeyboardInput({
        header = "keytes",
        rows = {
            {
                id = 1,
                txt = "keytes"
            }
        }
    })
    if keyboardInput ~= nil then
        if keyboardInput[1].input == nil then return end
        local notify = exports['matyr_notify']
        notify:DoHudText('inform', 'halo ' .. keyboardInput[1].input)
    end
end, false)
