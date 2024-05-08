local webhook = 'https://discord.com/api/webhooks/1236240700945731614/QTD5XKLf7ti0NZ-TnCD0tz6TnIzrJFJ68A9ZEkL9UCriodBExNfqBUYt7DcRk6_gg-ZM'
-- /OOC
RegisterServerEvent('ooc')
AddEventHandler('ooc', function(param)
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
                ["username"] = "[OOC]" .. player,
                ["embeds"] = { {
                    ["author"] = {
                        ["name"] = player
                    },
                    ["title"] = "ooc",
                    ["description"] = line,
                    ["color"] = 3447003,
                    ["footer"] = {
                        ["text"] = "Steam HEX: " .. identifier .. "\nTime : " .. time
                    }
                } }
            }
            TriggerClientEvent('chatMessage', -1, '^*^5[OOC]^*^5 ' .. GetPlayerName(source), { 0, 0, 0 })
            PerformHttpRequest(webhook, function(statusCode, text, headers) end, 'POST', json.encode(embed),
                { ['Content-Type'] = 'application/json' })
        end
    end
end)
