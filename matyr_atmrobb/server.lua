ESX = nil
QBCore = nil

local ESX = exports["es_extended"]:getSharedObject()
local QBCore = exports['qb-core']:GetCoreObject()

local item = 'black_money'
local min = 150
local max = 250
local framework = "esx"

RegisterNetEvent('obtaineditem')
AddEventHandler('obtaineditem', function()
    local count = math.random(min, max)
    local _source = source

    if framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(_source)
        if xPlayer then
            xPlayer.addInventoryItem(item, count)
        else
            print("ESX Player not found for source: " .. tostring(_source))
        end
    elseif framework == "qbcore" then
        local Player = QBCore.Functions.GetPlayer(_source)
        if Player then
            Player.Functions.AddItem(item, count)
        else
            print("QBCore Player not found for source: " .. tostring(_source))
        end
    else
        print("Framework not recognized")
    end
end)
