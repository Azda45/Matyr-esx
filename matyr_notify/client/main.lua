function notify(args)
    local data = {
        type = args.type or "inform",
        text = args.text or "message",
        duration = type(args.duration) == "number" and args.duration or 3000,
        sound = args.sound ~= nil and args.sound or false
    }

    if not (data.type == "inform" or data.type == "warn" or data.type == "error" or data.type == "success") then
        data.type = "inform"
    end
    SendNUIMessage({
        action = 'notify',
        type = data.type,
        text = data.text,
        duration = data.duration,
        playSound = data.sound
    })
    SendNUIMessage({
        action = 'toggleSound',
        state = state
    })
end

exports('notify', function(args)
    notify(args)
end)