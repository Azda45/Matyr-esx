ESX = nil

local Webhook = Config.Webhook
local BotUsername = "Boombox"                                                                                                               -- Name for the Bot

Framework = 'ESX'
ESX = exports['es_extended']:getSharedObject()


MySQL.ready(function()
    MySQL.Sync.execute(
        "CREATE TABLE IF NOT EXISTS `songs` (" ..
        "`identifier` varchar(64) NOT NULL, " ..
        "`label` varchar(30) NOT NULL, " ..
        "`link` longtext NOT NULL " ..
        ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4; "
    )
end)

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

RegisterServerEvent('azda_boombox:save')
AddEventHandler('azda_boombox:save', function(name, link)
    local xPlayer = ESX.GetPlayerFromId(source)
    SongConfirmed(16448250, "Save Song Log",
        "Player Name: **" ..
        xPlayer.getName() ..
        "**\n Player Identifier: **" ..
        xPlayer.getIdentifier() ..
        "**\n Song Name: **" ..
        name .. "**\n Song Link: **" .. link .. "**\n Date: " .. os.date("** Time: %H:%M Date: %d.%m.%y **") .. "",
        "Made by Andistyler")
    MySQL.Async.insert('INSERT INTO `songs` (`identifier`, `label`, `link`) VALUES (@identifier, @label, @link)',
        {
            ['@identifier'] = xPlayer.identifier,
            ['@label'] = name,
            ['@link'] = link
        })
end)

RegisterServerEvent('azda_boombox:deleteSong')
AddEventHandler('azda_boombox:deleteSong', function(data)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.execute(
    'DELETE FROM `songs` WHERE `identifier` = @identifier AND label = @label AND link = @link', {
        ["@identifier"] = xPlayer.identifier,
        ["@label"] = data.label,
        ["@link"] = data.link,
    })
end)


ESX.RegisterServerCallback('azda_boombox:getSavedSongs', function(source, cb)
    local savedSongs = {}
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT label, link FROM songs WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    }, function(result)
        if result[1] then
            for i = 1, #result do
                table.insert(savedSongs, { label = result[i].label, link = result[i].link })
            end
        end
        if savedSongs then
            cb(savedSongs)
        else
            cb(false)
        end
    end)
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
    if Webhook and Webhook ~= 'WEBHOOK_HERE' then
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
