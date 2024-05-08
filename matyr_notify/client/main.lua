RegisterNetEvent("matyr_notify:DoShortHudText")
AddEventHandler("matyr_notify:DoShortHudText", function(data)
	DoShortHudText(data.type, data.text)
end)
RegisterNetEvent("matyr_notify:DoHudText")
AddEventHandler("matyr_notify:DoHudText", function(data)
	DoHudText(data.type, data.text)
end)
RegisterNetEvent("matyr_notify:DoLongHudText")
AddEventHandler("matyr_notify:DoLongHudText", function(data)
	DoLongHudText(data.type, data.text)
end)
RegisterNetEvent("matyr_notify:DoLongHudText")
AddEventHandler("matyr_notify:DoLongHudText", function(data)
	DoLongHudText(data.type, data.text)
end)
RegisterNetEvent("matyr_notify:DoCustomHudText")
AddEventHandler("matyr_notify:DoCustomHudText", function(data)
    DoCustomHudText(data.type, data.text, data.duration)
end)
function DoShortHudText(type, text)
	SendNUIMessage({
		action = 'shortnotif',
		type = type,
		text = text
	})
end

function DoHudText(type, text)
	SendNUIMessage({
		action = 'notif',
		type = type,
		text = text
	})
end

function DoLongHudText(type, text)
	SendNUIMessage({
		action = 'longnotif',
		type = type,
		text = text
	})
end


function DoCustomHudText(type, text, duration)
    SendNUIMessage({
        action = 'customnotif',
        type = type,
        text = text,
        duration = duration
    })
end
