local notify= exports['matyr_notify']
local context = exports['matyr_context']
loadModel = function(model)
    while not HasModelLoaded(model) do
        Wait(0)
        RequestModel(model)
    end
    return model
end

loadDict = function(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(0)
        RequestAnimDict(dict)
    end
    return dict
end
hasBoomBox = function(radio)
    local equipRadio = true
    CreateThread(function()
        notify:DoHudText('inform', 'Press E to drop boombox')
        while equipRadio do
            Wait(0)
            if IsControlJustReleased(0, 38) then
                equipRadio = false
                DetachEntity(radio)
                PlaceObjectOnGroundProperly(radio)
                FreezeEntityPosition(radio, true)
                boomboxPlaced(radio)
            end
        end
    end)
end


boomboxPlaced = function(obj)
    local coords = GetEntityCoords(obj)
    local heading = GetEntityHeading(obj)
    local targetPlaced = false
    CreateThread(function()
        while true do
            if DoesEntityExist(obj) and not targetPlaced then
                exports.qtarget:AddBoxZone("boomboxzone", coords, 1, 1, {
                    name = "boomboxzone",
                    heading = heading,
                    debugPoly = false,
                    minZ = coords.z - 0.9,
                    maxZ = coords.z + 0.9
                }, {
                    options = {
                        {
                            event = 'azda_boombox:interact',
                            icon = 'fas fa-hand-paper',
                            label = 'Interact',
                        },
                        {
                            event = 'azda_boombox:pickup',
                            icon = 'fas fa-volume-up',
                            label = 'Pick Up'
                        }

                    },
                    job = 'all',
                    distance = 2
                })
                targetPlaced = true
            elseif not DoesEntityExist(obj) then
                exports.qtarget:RemoveZone('boomboxzone')
                targetPlaced = false
                break
            end
            Wait(1000)
        end
    end)
end

interactBoombox = function(radio, radioCoords)
    if not activeRadios[radio] then
        activeRadios[radio] = {
            pos = radioCoords,
            data = {
                playing = false
            }
        }
    else
        activeRadios[radio].pos = radioCoords
    end
    TriggerServerEvent('azda_boombox:syncActive', activeRadios)
    if not activeRadios[radio].data.playing then
        context:context {
            {
                id = 1,
                header = "Boombox",
                txt = ""
            },
            {
                id = 2,
                header = "Play Music",
                txt = "Play Music On Speaker",
                params = {
                    event = 'azda_boombox:playMenu',
                    args = { type = 'play', id = radio }
                },
            },
        }
    else
        context:context {
            {
                id = 1,
                header = "Boombox",
                txt = ""
            },
            {
                id = 2,
                header = 'Change Music',
                txt = 'Change music on speaker',
                params = {
                    event = 'azda_boombox:playMenu',
                    args = { type = 'play', id = radio }
                }

            },
            {
                id = 3,
                header = 'Stop Music',
                txt = 'Stop music on speaker',
                params = {
                    event = 'azda_boombox:playMenu',
                    args = { type = 'stop', id = radio }
                }
            },
            {
                id = 4,
                header = 'Adjust Volume',
                txt = 'Change volume on speaker',
                params = {
                    event = 'azda_boombox:playMenu',
                    args = { type = 'volume', id = radio }
                }

            }
        }
    end
end