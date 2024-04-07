exports.ox_target:addSphereZone({
    coords = vec3(-1196.06, -899.8311, 13.8862),
    size = vec3(0.2, 0.2, 0.2),
    radius = 0.3,
    debug = true,
    drawSprite = true,
    options = {
        {
            event = "azda:craftmenu",
            icon = "fa-solid fa-burger",
            label = "Make Burger",
        },
        {
            event = "azda:craftmenu",
            icon = "fa-solid fa-burger",
            label = "Make Cheese Burger",
        }
    },
})

RegisterNetEvent('cook-progress')
AddEventHandler('cook-progress', function()
    lib.progressBar({
        duration = 6000,
        label = 'Crafting',
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
            move = true,
            combat = true
        },
    })
end)