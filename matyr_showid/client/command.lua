local notification = exports['matyr_notify']
local showIdConfig = {
    commandName = "id",
    commandDescription = "Show your ID.",
    message = 'Your id is {ID}.'
}

RegisterCommand(showIdConfig.commandName, function()
    local playerId = GetPlayerServerId(PlayerId())
    local result = showIdConfig.message:gsub("{ID}", playerId)
    Notify(result)
end)

function Notify(result)
    Wait(250)
    notification:DoHudText('inform', result)
end

Citizen.CreateThread(function()
    local command = showIdConfig.commandName
    local description = showIdConfig.commandDescription
    TriggerEvent('chat:addSuggestion', '/' .. command .. '', description)
end)