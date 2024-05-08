onlinePlayers = {}
ESX = exports["es_extended"]:getSharedObject()


RegisterServerEvent('tgiann-showid:add-id')
AddEventHandler('tgiann-showid:add-id', function()
    xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent("tgiann-showid:client:add-id", source, onlinePlayers)
    local topText = ''

    onlinePlayers[tostring(source)] = topText
    TriggerClientEvent("tgiann-showid:client:add-id", -1, topText, tostring(source))
end)

AddEventHandler('playerDropped', function(reason)
    onlinePlayers[tostring(source)] = nil
end)
