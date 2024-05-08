ESX = nil

local Webhook = Config.Webhook
local BotUsername = "Boombox"                                                                                                               -- Name for the Bot

Framework = 'ESX'
ESX = exports['es_extended']:getSharedObject()


ESX.RegisterUsableItem(Config.BoomboxItem, function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('azda_boombox:useBoombox', source)
    xPlayer.removeInventoryItem(Config.BoomboxItem, 1)
end)


RegisterServerEvent('azda_boombox:deleteObj', function(netId)
    TriggerClientEvent('azda_boombox:deleteObj', -1, netId)
end)

RegisterServerEvent('azda_boombox:objDeleted', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem(Config.BoomboxItem, 1)
end)


RegisterNetEvent("azda_boombox:soundStatus")
AddEventHandler("azda_boombox:soundStatus", function(type, musicId, data)
    TriggerClientEvent("azda_boombox:soundStatus", -1, type, musicId, data)
end)

RegisterNetEvent("azda_boombox:syncActive")
AddEventHandler("azda_boombox:syncActive", function(activeRadios)
    TriggerClientEvent("azda_boombox:syncActive", -1, activeRadios)
end)

RegisterNetEvent("azda_boombox:DiscordKnows")
AddEventHandler("azda_boombox:DiscordKnows", function(link)
    local xPlayer = ESX.GetPlayerFromId(source)
    SongConfirmed(16448250, "Play Song Log",
        "Player Name: **" ..
        xPlayer.getName() ..
        "**\n Player Identifier: **" ..
        xPlayer.getIdentifier() ..
        "**\n Song Link: **" .. link .. "**\n Date: " .. os.date("** Time: %H:%M Date: %d.%m.%y **") .. "")
end)

SongConfirmed = function(color, name, message, footer)
    if Webhook and Webhook ~= Webhook then
        local SongConfirmed = {
            {
                ["color"] = color,
                ["title"] = "**" .. name .. "**",
                ["description"] = message,
                ["footer"] = {
                    ["text"] = footer,
                },
            }
        }

        PerformHttpRequest(Webhook, function(err, text, headers) end, 'POST',
            json.encode({ username = BotUsername, embeds = SongConfirmed }), { ['Content-Type'] = 'application/json' })
    end
end
