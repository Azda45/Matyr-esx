RegisterNUICallback("dataPost", function(data, cb)
    SetNuiFocus(false)
    TriggerEvent(data.event, data.args, data.arg2, data.arg3)
    cb('ok')
end)

RegisterNUICallback("cancel", function()
    SetNuiFocus(false)
end)


function context(data)
    if not data then return end
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "context",
        data = data
    })
end
