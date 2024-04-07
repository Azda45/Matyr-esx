local time = 2
local AtmModels = { 'prop_fleeca_atm', 'prop_atm_01', 'prop_atm_02', 'prop_atm_03' }

exports.ox_target:addModel(AtmModels, {
    {
        event = 'robbing-atm',
        label = 'Robb Atm',
        icon = 'fas fa-money-bill-wave',
        distance = 2,
    }
})

local notify = exports['matyr_notify']
local progbar = exports['matyr_progbar']

RegisterNetEvent('robbing-atm')
AddEventHandler('robbing-atm', function()
    exports['matyr_untangle']:untangle(function(success)
        if success then
            print("success")
            progbar:Progress {
                name = "atmrobb",
                duration = time * 1000, -- Adjust time to milliseconds
                label = "Collect Money",
                useWhileDead = false,
                canCancel = true,
                disarm = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = true,
                    disableCombat = false,
                }
            }
            Citizen.Wait(time * 1000)
            notify:DoHudText('success', 'You successfully robbed the ATM')
            TriggerServerEvent("obtaineditem")
            Citizen.Wait(500)
        else
            print("fail")
            notify:DoHudText('error', 'You Failed to rob the ATM')
        end
    end, math.random(8,12), math.random(30,35))
end)
