local webhook =
"https://discord.com/api/webhooks/1232765690520272977/71JhSj_Wz85cWwEN8UnBvkDlv88JKbIFPFrIqzhOyPlOsH0i5-4fcuyRryLcUcm_5GiV"
local name = "Matyr Network Fivem Log"
local up ="https://cdn.discordapp.com/attachments/989506953959067760/1232562252662444152/chevron-up-circle-regular-24.png?ex=6629e88c&is=6628970c&hm=d897f856d9abb61633b1a78abeb8996a8eb9f2aadb706cd320600d0cf8079acb&"
local down = "https://cdn.discordapp.com/attachments/989506953959067760/1232562687452516393/chevron-down-circle-regular-24.png?ex=6629e8f4&is=66289774&hm=083bc30d493c88895cc5efe43cc226a04235be9fd6625c9602f8a8d82573f5d9&"
AddEventHandler('playerConnecting', function()
    local playerName = GetPlayerName(source)
    local playerIp = GetPlayerEndpoint(source)
    local playerHex = GetPlayerIdentifier(source)
    local playerPing = GetPlayerPing(source)
    local connecting = {
        {
            ["color"] = "000000",
            ["title"] = "Player Connecting",
            ["description"] = "Player Name: *" ..
                playerName ..
                "*\n\nPlayer IP: *" .. playerIp ..
                "*\n\nPlayer Steam Hex: *" .. playerHex .. "*\n Player Ping: *" .. playerPing .. "*",
            ["footer"] = {
                ["text"] = name,
                ["icon_url"] = up,
            },
        }
    }


    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST',
        json.encode({ username = name, avatar = logo, embeds = connecting }), { ['Content-Type'] = 'application/json' })
end)



AddEventHandler('playerDropped', function(reason)
    local playerName = GetPlayerName(source)
    local playerIp = GetPlayerEndpoint(source)
    local playerPing = GetPlayerPing(source)
    local playerHex = GetPlayerIdentifier(source)
    local disconnecting = {
        {
            ["color"] = "000000",
            ["title"] = "Player Disconnecting",
            ["description"] = "Player Name: *" ..
                playerName ..
                "*\n\nReason: *" ..
                reason ..
                "*\n\nPlayer IP: *" .. playerIp ..
                "*\n\nPlayer Steam Hex: *" .. playerHex .. "*\n Player Ping: *" .. playerPing .. "*",
            ["footer"] = {
                ["text"] = name,
                ["icon_url"] = down
            },
        }
    }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST',
        json.encode({ username = name, avatar = down, embeds = disconnecting }),
        { ['Content-Type'] = 'application/json' })
end)
