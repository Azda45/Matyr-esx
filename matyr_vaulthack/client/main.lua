local isHacking = false
local callbackFunction = nil

AddEventHandler('open:minigame', function(callback)
    callbackFunction = callback
    vaultcl()
end)

function vault(puzzleDuration, puzzleLength, puzzleAmount, callback)
    callbackFunction = callback
    vaultcl(puzzleDuration, puzzleLength, puzzleAmount)
end

RegisterNUICallback('callback', function(data, cb)
    closeHack()
    if callbackFunction then
        callbackFunction(data.success)
    else
        print("Warning: Callback function is not set.")
    end
    cb('ok')
end)

function vaultcl(puzzleDuration, puzzleLength, puzzleAmount)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "open",
        duration = puzzleDuration,
        length = puzzleLength,
        amount = puzzleAmount
    })
    isHacking = true
end

function closeHack()
    SetNuiFocus(false, false)
    isHacking = false
end

function GetHackingStatus()
    return isHacking
end
