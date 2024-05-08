local context = exports['matyr_context']
RegisterCommand('minigame', function(source, args, rawCommand)
    context:context({
        {
            id = 1,
            header = "Minigame Practice",
            txt = ""
        },
        {
            id = 2,
            header = "CIRCLE",
            txt = "Circle Practice",
            params = {
                event = "circle",
            }
        },
        {
            id = 3,
            header = "COLOR",
            txt = "Color Practice",
            params = {
                event = "color",
            }
        },
        {
            id = 4,
            header = "DDR",
            txt = "Ddr Practice",
            params = {
                event = "ddr",
            }
        },
        {
            id = 5,
            header = "HACKINGDEVICE",
            txt = "Hackingdevice Practice",
            params = {
                event = "hackingdevice",
            }
        },
        {
            id = 6,
            header = "LIGHTSOUT",
            txt = "Lightsout Practice",
            params = {
                event = "lightsout",
            }
        },
        {
            id = 7,
            header = "LOCKPICK",
            txt = "Lockpick Practice",
            params = {
                event = "lockpick",
            }
        },
        {
            id = 8,
            header = "PASSWORD",
            txt = "Password Practice",
            params = {
                event = "password",
            }
        },
        {
            id = 9,
            header = "THERMITE",
            txt = "Thermite Practice",
            params = {
                event = "thermite",
            }
        },
        {
            id = 10,
            header = "UNTANGLE",
            txt = "Untagle Practice",
            params = {
                event = "untangle",
            }
        },
        {
            id = 11,
            header = "VAULT",
            txt = "Vault Practice",
            params = {
                event = "vault",
            }
        },
        {
            id = 14,
            header = "Exit",
            txt = "",
            params = {
                event = "exit",
            }
        },
    })
end)
