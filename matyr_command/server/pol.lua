local webhook =
'https://discord.com/api/webhooks/1184154852587208724/76XxA1gnJrYu1gvgtQs-b00EJp5fGlB_k6UDEIMzqAfKraDPQ08tgoYbHLEtQoCzE5HK'

RegisterServerEvent('pol')
AddEventHandler('pol', function(param)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local player = xPlayer.getName()
    local currentTime = os.time() + (7 * 3600) -- Adding 7 hours (in seconds) to convert to Jakarta time (UTC+7)
    local identifier = GetPlayerIdentifiers(source)[1]
    local time = os.date("%Y-%m-%d %H:%M:%S", currentTime)

    if xPlayer then
        local lines = {}
        for line in param:gmatch("[^|]+") do
            table.insert(lines, line)
        end
        for _, line in ipairs(lines) do
            local embed = {
                ["username"] = "Matyr Police Announcer",
                ["avatar"] ="http://matyr_command/asset/icon.svg" ,
                ["embeds"] = { {
                    ["author"] = {
                        ["name"] = player
                    },
                    ["title"] = "Police Announcement",
                    ["description"] = line,
                    ["color"] = 3447003,
                    ["footer"] = {
                        ["text"] = "Steam HEX: " .. identifier .. "\nTime : " .. time
                    }
                } }
            }
            TriggerClientEvent('chatMessage', -1, '^*[PoliceAnnouncement]^*' .. '^*', 'error' ,line .. '^*')
            PerformHttpRequest(webhook, function(statusCode, text, headers) end, 'POST', json.encode(embed),
                { ['Content-Type'] = 'application/json' })
        end
    end
end)
