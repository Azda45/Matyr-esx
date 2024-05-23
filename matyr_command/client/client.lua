-- /OOC
RegisterCommand("ooc", function(source, args)
    TriggerServerEvent('ooc', table.concat(args, " "))
end)
TriggerEvent("chat:addSuggestion", "/ooc", "text")

-- police announcement
RegisterCommand("pol", function(source, args)
    local player = ESX.GetPlayerData()
    if player.job and player.job.name == 'police' then
        TriggerServerEvent('pol', table.concat(args, " "))
    end
end)