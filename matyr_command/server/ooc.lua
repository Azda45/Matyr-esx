local webhook =
'https://discord.com/api/webhooks/1236240700945731614/QTD5XKLf7ti0NZ-TnCD0tz6TnIzrJFJ68A9ZEkL9UCriodBExNfqBUYt7DcRk6_gg-ZM'
-- /OOC
RegisterServerEvent('ooc')
AddEventHandler('ooc', function(param)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local player = xPlayer.getName()
    local currentTime = os.time() + (-3600) -- Adding 7 hours (in seconds) to convert to Jakarta time (UTC+7)
    local identifier = GetPlayerIdentifiers(source)[1]
    local time = os.date("%Y-%m-%d %H:%M:%S", currentTime)

    if xPlayer then
        local lines = {}
        for line in param:gmatch("[^|]+") do
            table.insert(lines, line)
        end
        for _, line in ipairs(lines) do
            local embed = {
                ["username"] = "OOC",
                ["embeds"] = {
                    {
                        ["color"] = 1752220,
                        ["fields"] = {
                            {
                                ["name"] = "> NAME",
                                ["value"] = "```\n" .. player .. "```\n",
                                ["inline"] = false
                            },
                            {
                                ["name"] = "> CHAT",
                                ["value"] = "```\n" .. line .. "```\n",
                                ["inline"] = false
                            },
                            {
                                ["name"] = "> IDENTIFIER",
                                ["value"] = "```\n" .. identifier .. "```\n",
                                ["inline"] = true
                            },
                            {
                                ["name"] = "> TIME GMT+7",
                                ["value"] = "```\n" .. time .. "```\n",
                                ["inline"] = true
                            },
                        }
                    }
                }
            }
            TriggerClientEvent('chatMessage', -1, '^*^5OOC^5 ' .. GetPlayerName(source) .. ' [' .. source .. ']^7^r',
                'normal', line)
            PerformHttpRequest(webhook, function(statusCode, text, headers) end, 'POST', json.encode(embed),
                { ['Content-Type'] = 'application/json' })
        end
    end
end)
