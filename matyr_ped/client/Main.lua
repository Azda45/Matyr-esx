ESX = nil
ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent( 'npcvaihto' )
AddEventHandler( 'npcvaihto', function(args)
    local modelHash = tostring(args[1])

    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        ESX.Streaming.RequestModel(modelHash, function()
            SetPlayerModel(PlayerId(), modelHash)
            SetModelAsNoLongerNeeded(modelHash)

            TriggerEvent('esx:restoreLoadout')
        end)
    end)

end )

RegisterNetEvent('ks_peds:client:openMenu',
    function(peds, name)
        if peds then
            if Config.Debug then
                print('^2[ks_peds] - ^2debuggin ^1(^3ks_peds:client:openMenu^1)^2 client event ...')
            end
            local PedMenu = PedMenu(peds, ESX, name..math.random(0, 10000))
            PedMenu.OpenMenu()
            if Config.Debug then
                print('^2[ks_peds] - ^2debuggin ^1(^3ks_peds:client:openMenu^1)^2 client event peds ^1(^3'..json.encode(peds)..'^1)^2 sended to ^1(^3PedMenu^1)^2 class successfully!')
            end
        else
            ESX.ShowNotification(Config.Lang.NoPed)
        end
    end
)

RegisterCommand('pedmenu',
    function(source, arguments)
        TriggerServerEvent('ks_peds:server:openMenu')
    end
)

AddEventHandler('onClientResourceStart',
    function (resourceName)
        if GetCurrentResourceName() == resourceName then
            TriggerEvent('chat:addSuggestion', ('/addped'), 'Agregar ped a usuario', {
                {name = 'FUNC', help = 'add / remove'},
                {name = 'ID', help = 'Player ID'},
                {name = 'Ped', help = 'Ped Model'},
                {name = 'Tipo', help = 'Animal / Ped'},
                {name = 'Label', help = 'Ped Label'}
            })
        end
    end
)