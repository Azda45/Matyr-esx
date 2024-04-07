xSound = exports.xsound
activeRadios = {}
Framework = nil

Framework = 'ESX'
ESX = exports['es_extended']:getSharedObject()


RegisterNetEvent('azda_boombox:useBoombox')
AddEventHandler('azda_boombox:useBoombox', function()
    local ped = PlayerPedId()
    local hash = loadModel('prop_boombox_01')
    local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(ped, 0.0, 3.0, 0.5))
    local radio = CreateObjectNoOffset(hash, x, y, z, true, false)
    SetModelAsNoLongerNeeded(hash)
    SetCurrentPedWeapon(ped, `WEAPON_UNARMED`)
    AttachEntityToEntity(radio, ped, GetPedBoneIndex(ped, 57005), 0.32, 0, -0.05, 0.10, 270.0, 60.0, true, true, false,
        true, 1, true)
    hasBoomBox(radio)
end)

RegisterNetEvent('azda_boombox:deleteObj', function(netId)
    if DoesEntityExist(NetToObj(netId)) then
        DeleteObject(NetToObj(netId))
        if not DoesEntityExist(NetToObj(netId)) then
            TriggerServerEvent('azda_boombox:objDeleted')
        end
    end
end)

AddEventHandler('azda_boombox:pickup', function()
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    local radio = `prop_boombox_01`
    local closestRadio = GetClosestObjectOfType(pedCoords, 3.0, radio, false)
    local radioCoords = GetEntityCoords(closestRadio)
    local musicId = 'id_' .. closestRadio
    TaskTurnPedToFaceCoord(ped, radioCoords.x, radioCoords.y, radioCoords.z, 2000)
    TaskPlayAnim(ped, "pickup_object", "pickup_low", 8.0, 8.0, -1, 50, 0, false, false, false)
    Wait(1000)
    if xSound:soundExists(musicId) then
        TriggerServerEvent("azda_boombox:soundStatus", "stop", musicId, {})
    end
    FreezeEntityPosition(closestRadio, false)
    TriggerServerEvent("azda_boombox:deleteObj", ObjToNet(closestRadio))
    if activeRadios[closestRadio] then
        activeRadios[closestRadio] = nil
    end
    TriggerServerEvent('azda_boombox:syncActive', activeRadios)
    ClearPedTasks(ped)
end)

RegisterNetEvent('azda_boombox:soundStatus')
AddEventHandler('azda_boombox:soundStatus', function(type, musicId, data)
    CreateThread(function()
        if type == "position" then
            if xSound:soundExists(musicId) then
                xSound:Position(musicId, data.position)
            end
        end
        if type == "play" then
            TriggerServerEvent('azda_boombox:DiscordKnows', data.link)
            xSound:PlayUrlPos(musicId, data.link, data.volume, data.position)
            xSound:Distance(musicId, data.distance)
            xSound:setVolume(musicId, data.volume)
        end

        if type == "volume" then
            xSound:setVolume(musicId, data.volume)
        end

        if type == "stop" then
            xSound:Destroy(musicId)
        end
    end)
end)

AddEventHandler('azda_boombox:interact', function()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local radio = GetClosestObjectOfType(pedCoords, 5.0, `prop_boombox_01`, false)
    local radioCoords = GetEntityCoords(radio)
    interactBoombox(radio, radioCoords)
end)

AddEventHandler('azda_boombox:savedSongs', function(radio)
    savedSongsMenu(radio)
end)

AddEventHandler('azda_boombox:saveSong', function()
    local input = lib.inputDialog('Save Song', { 'Name', 'Youtube Link' })
    if input[1] and input[2] then
        TriggerServerEvent('azda_boombox:save', input[1], input[2])
        lib.notify({
            title = 'Success',
            description = 'Song Saved',
            type = 'success'
        })
    else
        lib.notify({
            title = 'Incorrect',
            description = 'You entered incomplete information',
            type = 'error'
        })
    end
end)

AddEventHandler('azda_boombox:selectSavedSong', function(data)
    selectSavedSong(data)
end)

AddEventHandler('azda_boombox:playSavedSong', function(data)
    local musicId = 'id_' .. data.id
    TriggerServerEvent("azda_boombox:soundStatus", "play", musicId,
        { position = activeRadios[data.id].pos, link = data.link, volume = '0.2', distance = 25 })
    activeRadios[data.id].data = { playing = true, currentId = 'id_' .. PlayerId() }
    TriggerServerEvent('azda_boombox:syncActive', activeRadios)
end)

AddEventHandler('azda_boombox:deleteSong', function(data)
    local confirmed = lib.alertDialog({
        header = 'Delete Song',
        content = 'Are you sure you wish to delete song?',
        centered = true,
        cancel = true
    })
    if confirmed == 'confirm' then
        TriggerServerEvent('azda_boombox:deleteSong', data)
        lib.notify({
            title = 'Deleted',
            description = 'Song deleted',
            type = 'success'
        })
    else
        lib.notify({
            title = 'Cancelled',
            description = 'You have cancelled your previous action',
            type = 'error'
        })
    end
end)

AddEventHandler('azda_boombox:playMenu', function(data)
    local musicId = 'id_' .. data.id
    if data.type == 'play' then
        local keyboard = lib.inputDialog('Play Music', { 'Youtube URL', 'Distance (Max 40)', 'Volume (1-100)' })
        if keyboard and keyboard[1] and tonumber(keyboard[2]) and tonumber(keyboard[2]) <= 40 and tonumber(keyboard[3]) and tonumber(keyboard[3]) <= 100 then
            TriggerServerEvent("azda_boombox:soundStatus", "play", musicId,
                { position = activeRadios[data.id].pos, link = keyboard[1], volume = keyboard[3] / 100, distance = keyboard[2] })
            activeRadios[data.id].data = { playing = true, currentId = 'id_' .. PlayerId() }
            TriggerServerEvent('azda_boombox:syncActive', activeRadios)
        end
    elseif data.type == 'stop' then
        TriggerServerEvent("azda_boombox:soundStatus", "stop", musicId, {})
        activeRadios[data.id].data = { playing = false }
        TriggerServerEvent('azda_boombox:syncActive', activeRadios)
    elseif data.type == 'volume' then
        local keyboard = lib.inputDialog('Change Volume', { 'Volume (1-100)' })
        if keyboard and tonumber(keyboard[1]) and tonumber(keyboard[1]) <= 100 then
            TriggerServerEvent("azda_boombox:soundStatus", "volume", musicId, { volume = keyboard[1] / 100 })
        end
    elseif data.type == 'distance' then
        local keyboard = lib.inputDialog('Change Distance', { 'Distance (Max 40)' })
        if keyboard and tonumber(keyboard[1]) and tonumber(keyboard[1]) <= 40 then
            TriggerServerEvent("azda_boombox:soundStatus", "distance", musicId, { distance = keyboard[1] })
        end
    end
end)

RegisterNetEvent('azda_boombox:syncActive')
AddEventHandler('azda_boombox:syncActive', function(activeBoxes)
    activeRadios = activeBoxes
end)
