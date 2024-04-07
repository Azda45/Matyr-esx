ESX = exports["es_extended"]:getSharedObject()
local key = exports["matyr_key"]
local notify = exports['matyr_notify']
local circle = exports['matyr_circle']
local color = exports['matyr_color']
local ddr = exports['matyr_ddr']
local hackingdevice = exports['matyr_hackingdevice']
local lightsout = exports['matyr_lightsout']
local lockpick = exports['matyr_lockpick']
local password = exports['matyr_password']
local thermite = exports["matyr_thermite"]
local untangle = exports['matyr_untangle']
local vault = exports['matyr_vaulthack']

-- circle
RegisterNetEvent('circle', function()
    local keyboard = key:KeyboardInput({
        header = "Circle Setting",
        rows = {
            {
                id = 1,
                txt = "Amount"
            },
            {
                id = 2,
                txt = "Time"
            }
        }
    })
    if keyboard ~= nil then
        if keyboard[1].input == nil or keyboard[2].input == nil then return end
        local success = circle:circle(keyboard[1].input, keyboard[2].input)
        if success then
            notify:DoHudText('success', 'You successfully complete CIRCLE minigame')
        else
            notify:DoHudText('error', 'You fail to complete CIRCLE minigame')
        end
    end
end)

-- color
RegisterNetEvent('color', function()
    local keyboard = key:KeyboardInput({
        header = "Color Setting",
        rows = {
            {
                id = 1,
                txt = "Amount Icon (Max 7)"
            },
            {
                id = 2,
                txt = "Time"
            },
        }
    })
    if keyboard ~= nil then
        if keyboard[1].input == nil or keyboard[2].input == nil then return end
        local success = color:color(keyboard[1].input, keyboard[2].input)
        if success then
            notify:DoHudText('success', 'You successfully complete COLOR minigame')
        else
            notify:DoHudText('error', 'You fail to complete COLOR minigame')
        end
    end
end)

-- ddr
RegisterNetEvent('ddr', function()
    local keyboard = key:KeyboardInput({
        header = "Ddr Setting",
        rows = {
            {
                id = 1,
                txt = "Level (easy,medium,hard)"
            },
            {
                id = 2,
                txt = "Time"
            }
        }
    })

    if keyboard ~= nil then
        if keyboard[1].input == nil or keyboard[2].input == nil then return end
        ddr:hacking(function(success)
            if success then
                notify:DoHudText('success', 'You successfully complete DDR minigame')
            else
                notify:DoHudText('error', 'You fail to complete DDR minigame')
            end
        end, keyboard[1].input, keyboard[2].input)
    end
end)

-- hackingdevice
RegisterNetEvent('hackingdevice', function()
    local keyboard = key:KeyboardInput({
        header = "Device Setting",
        rows = {
            {
                id = 1,
                txt = "Time"
            }
        }
    })

    if keyboard ~= nil then
        if keyboard[1].input == nil then return end
        hackingdevice:hackingdevice(function(success)
            if success then
                notify:DoHudText('success', 'You successfully complete HACKINGDEVICE minigame')
            else
                notify:DoHudText('error', 'You fail to complete HACKINGDEVICE    minigame')
            end
        end, "numeric", keyboard[1].input, 0)
    end
end)

-- lightsout
RegisterNetEvent('lightsout', function()
    local result = lightsout:lightsout(4, 20)

    if result then
        notify:DoHudText('success', 'You successfully complete LIGHTSOUT minigame')
    else
        notify:DoHudText('error', 'You fail to complete LIGHTSOUT minigame')
    end
end)

-- lockpick
RegisterNetEvent('lockpick', function()
    local success = lockpick:startLockpick()
    if success then
        notify:DoHudText('success', 'You successfully completed the LOCKPICK minigame.')
    else
        notify:DoHudText('error', 'You failed to complete the LOCKPICK minigame.')
    end
end)

-- password
RegisterNetEvent('password', function()
    local keyboard = key:KeyboardInput({
        header = "Password Setting",
        rows = {
            {
                id = 1,
                txt = "Length"
            },
            {
                id = 2,
                txt = "Time"
            },
            {
                id = 3,
                txt = "ShowTime"
            },
        }
    })
    if keyboard ~= nil then
        if keyboard[1].input == nil or keyboard[2].input == nil or keyboard[3].input == nil then return end
        local result = password:password(keyboard[1].input, keyboard[2].input,
            keyboard[3].input)

        if result then
            notify:DoHudText('success', 'You successfully complete PASSWORD minigame')
        else
            notify:DoHudText('error', 'You fail to complete PASSWORD minigame')
        end
    end
end)

-- thermite
RegisterNetEvent('thermite', function()
    local keyboard = key:KeyboardInput({
        header = "Thermite Setting",
        rows = {
            {
                id = 1,
                txt = "Correct Block (1-36 Block)"
            },
            {
                id = 2,
                txt = "Time Show"
            },
            {
                id = 3,
                txt = "Time Lose"
            }
        }
    })
    if keyboard ~= nil then
        if keyboard[1].input == nil or keyboard[2].input == nil or keyboard[3].input == nil then return end
        thermite:thermiteminigame(keyboard[1].input, 3, keyboard[2].input, keyboard[3].input,
            function()
                notify:DoHudText('success', 'You successfully complete THERMITE minigame')
            end,
            function()
                notify:DoHudText('error', 'You fail to complete THERMITE minigame')
            end)
    end
end)

-- untangle
RegisterNetEvent('untangle', function()
    local keyboard = key:KeyboardInput({
        header = "Untagle Setting",
        rows = {
            {
                id = 1,
                txt = "Dots (Min 4)"
            },
            {
                id = 2,
                txt = "Time"
            }
        }
    })

    if keyboard ~= nil then
        if keyboard[1].input == nil or keyboard[2].input == nil then return end
        untangle:untangle(function(success)
            if success then
                notify:DoHudText('success', 'You successfully complete UNTANGLE minigame')
            else
                notify:DoHudText('error', 'You fail to complete UNTANGLE minigame')
            end
        end, keyboard[1].input, keyboard[2].input)
    end
end)

-- vault
RegisterNetEvent('vault', function()
    local keyboard = key:KeyboardInput({
        header = "Vault Setting",
        rows = {
            {
                id = 1,
                txt = "Time"
            },
            {
                id = 2,
                txt = "Step"
            }
        }
    })

    if keyboard ~= nil then
        if keyboard[1].input == nil or keyboard[2].input == nil then return end
        vault:vault(keyboard[1].input, 4, keyboard[2].input, function(success)
            if success then
                notify:DoHudText('success', 'You successfully complete VAULT minigame')
            else
                notify:DoHudText('error', 'You fail to complete VAULT minigame')
            end
        end)
    end
end)
