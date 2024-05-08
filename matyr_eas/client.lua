RegisterNetEvent("SendAlert")
AddEventHandler("SendAlert", function(msg, msg2, time)
    SendNUIMessage({
        type    = "alert",
        enable  = true,
        issuer  = msg,
        message = msg2,
        volume  = Config.EAS.Volume
    })
end)
