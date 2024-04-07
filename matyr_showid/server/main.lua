onlinePlayers = {}

RegisterServerEvent('matyr_showid:add-id')
AddEventHandler('matyr_showid:add-id', function()
    TriggerClientEvent("matyr_showid:client:add-id", source, onlinePlayers)
    TriggerClientEvent("matyr_showid:client:add-id", -1,  tostring(source))
end)

AddEventHandler('playerDropped', function(reason)
    onlinePlayers[tostring(source)] = nil
end)