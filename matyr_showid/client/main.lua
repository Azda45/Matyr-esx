local onlinePlayers, forceDraw = {}, false

Citizen.CreateThread(function()
    TriggerServerEvent("matyr_showid:add-id")
    while true do
        Citizen.Wait(1)
        if IsControlPressed(0, 82) or forceDraw then
            for k, v in pairs(GetNeareastPlayers()) do
                local x, y, z = table.unpack(v.coords)
                Draw3DText(x, y, z + 1.1, v.playerId, 2)
            end
        end
    end
end)

RegisterNetEvent('matyr_showid:client:add-id')
AddEventHandler('matyr_showid:client:add-id', function(identifier, playerSource)
    if playerSource then
        onlinePlayers[playerSource] = identifier
    else
        onlinePlayers = identifier
    end
end)

function Draw3DText(x, y, z, text, newScale)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if onScreen then
        local dist = GetDistanceBetweenCoords(GetGameplayCamCoords(), x, y, z, 1)
        local scale = newScale * (1 / dist) * (1 / GetGameplayCamFov()) * 100
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropShadow(0, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

function GetNeareastPlayers()
    local playerPed = PlayerPedId()
    local players_clean = {}
    local playerCoords = GetEntityCoords(playerPed)
    if IsPedInAnyVehicle(playerPed, false) then
        local playersId = tostring(GetPlayerServerId(PlayerId()))
        table.insert(players_clean, { playerId = playersId, coords = playerCoords })
    else
        local players, _ = GetPlayersInArea(playerCoords, 4)
        for i = 1, #players, 1 do
            local playerServerId = GetPlayerServerId(players[i])
            local player = GetPlayerFromServerId(playerServerId)
            local ped = GetPlayerPed(player)
            if IsEntityVisible(ped) then
                if tostring(playerServerId) then
                    table.insert(players_clean, { playerId = playerServerId, coords = GetEntityCoords(ped) })
                end
            end
        end
    end

    return players_clean
end

function GetPlayersInArea(coords, area)
    local players, playersInArea = GetPlayers(), {}
    local coords = vector3(coords.x, coords.y, coords.z)
    for i = 1, #players, 1 do
        local target = GetPlayerPed(players[i])
        local targetCoords = GetEntityCoords(target)

        if #(coords - targetCoords) <= area then
            table.insert(playersInArea, players[i])
        end
    end
    return playersInArea
end

function GetPlayers()
    local players = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        if DoesEntityExist(ped) then
            table.insert(players, player)
        end
    end
    return players
end
