local ESX = exports["es_extended"]:getSharedObject()

local item = 'black_money'
local min = 150
local max = 250

RegisterNetEvent('obtaineditem')
AddEventHandler('obtaineditem', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local count = math.random(min, max)
    xPlayer.addInventoryItem(item, count)
end)
