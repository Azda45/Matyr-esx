RegisterCommand('craft', function(source, args, rawCommand)
    local playerId = tonumber(source)
    if playerId then
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer then
            local diamondCount = xPlayer.getInventoryItem('diamond').count
            local ironCount = xPlayer.getInventoryItem('iron').count

            if diamondCount >= 2 and ironCount >= 2 then
                xPlayer.removeInventoryItem('diamond', 2)
                xPlayer.removeInventoryItem('iron', 2)
                xPlayer.addInventoryItem('lockpick', 1)
                TriggerClientEvent('matyr:craft-succ', playerId)
            else
                TriggerClientEvent('matyr:craft-fail', playerId)
            end
        end
    end
end, false)
