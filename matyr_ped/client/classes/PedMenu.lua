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
function PedMenu(peds, core, name)

    self = {}

    self.core = core
    self.peds = peds
    self.name = name
    self.menuPeds = {}

    self.OpenMenu = function()
        
        if Config.Debug then print('^2[ks_peds] - ^2debuggin ^1(^3OpenMenu^1)^2 function in class ^1(^3PedMenu^1)^2 ...') end
        
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = "showPeds",
            peds = self.peds
        })

        if Config.Debug then print('^2[ks_peds] - ^2debuggin ^1(^3OpenMenu^1)^2 function in class ^1(^3PedMenu^1)^2 menu opened') end

    end

    self.setPed = function(ped, type)

        if type ~= 'Animal' then
            SetPedDefaultComponentVariation(PlayerPedId())
            self.core.Streaming.RequestModel(GetHashKey(ped), function()
                SetPlayerModel(PlayerId(), GetHashKey(ped))
                SetPedDefaultComponentVariation(PlayerPedId())
                SetModelAsNoLongerNeeded(GetHashKey(ped))
                SetPedComponentVariation(PlayerPedId(), 8, 0, 0, 2)
            end)
        else
            self.core.Streaming.RequestModel(GetHashKey(ped), function()
                SetPlayerModel(PlayerId(),GetHashKey(ped))
                SetPedDefaultComponentVariation(PlayerPedId())
                SetPedComponentVariation(PlayerPedId(), 8, 0, 0, 2)
                SetCanAttackFriendly(GetPlayerPed(-1), false, false)
            end)
        end

    end

    self.setDefaultPed = function()

        self.core.TriggerServerCallback('esx_skin:getPlayerSkin',
            function(skin, jobSkin)
                self.skin = skin
                self.sex = skin.sex == 0
                TriggerEvent('skinchanger:loadDefaultModel', self.sex,
                    function()
                        self.core.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                            TriggerEvent('skinchanger:loadSkin', self.skin)
                            TriggerEvent('dpc:ApplyClothing')
                        end)
                    end
                )
            end
        )

    end

    RegisterNUICallback("close", function(data)
        SetNuiFocus(false, false)
    end)
    
    RegisterNUICallback("default_ped", function(data)
        self.setDefaultPed()
        SetNuiFocus(false, false)
    end)
    
    RegisterNUICallback("setPed", function(data)
        self.setPed(data.ped, data.type)
        SetNuiFocus(false, false)
    end)

    return self

end