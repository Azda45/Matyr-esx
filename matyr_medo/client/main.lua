liczba = 0

RegisterNetEvent("3dme:me")
AddEventHandler("3dme:me", function(text, source, icon)
    local playerId = GetPlayerFromServerId(source)
    if playerId ~= -1 or source == GetPlayerServerId(PlayerId()) then
        local isDisplaying = true
        liczba = liczba + 1
        --if icon == nil then icon = 'icons' end
        icon = 'comment-dots'
        Citizen.CreateThread(function()
            while isDisplaying do
                Citizen.Wait(0)
                local htmlString = ""
                local sourceCoords = GetEntityCoords(GetPlayerPed(playerId))
                local nearCoords = GetEntityCoords(PlayerPedId())
                local distance = Vdist2(sourceCoords, nearCoords)
                if distance < 25.0 then
                    local onScreen, xxx, yyy =
                        GetHudScreenPositionFromWorldPosition(
                            sourceCoords.x + Config.CoordsX,
                            sourceCoords.y + Config.CoordsY,
                            sourceCoords.z + Config.CoordsZ)
                    htmlString =
                        htmlString ..
                        '<span style="position: absolute; left: ' ..
                        xxx * 100 ..
                        "%;top: " .. yyy * 100 .. '%;"><div class="me-container"><div class="text-container" style="color:#ffffff;"><b></b>' .. text .. "</div></div></span>"
                end
                if lasthtmlString ~= htmlString then
                            SendNUIMessage({
                                toggle = true,
                                html = htmlString
                            })
                            lasthtmlString = htmlString
                end
            end
            if isDisplaying == false then
                SendNUIMessage({toggle = false})
            end
        end)
        Citizen.CreateThread(function()
            Citizen.Wait(Config.Duration)
            liczba = liczba -1
            isDisplaying = false
            SendNUIMessage({toggle = false})
        end)
    end
end)


RegisterNetEvent("3dme:do")
AddEventHandler("3dme:do", function(text, source, icon)
    local playerId = GetPlayerFromServerId(source)
    if playerId ~= -1 or source == GetPlayerServerId(PlayerId()) then
        local isDisplaying = true
        liczba = liczba + 1
        --if icon == nil then icon = 'icons' end
        icon = 'user'
        Citizen.CreateThread(function()
            while isDisplaying do
                Citizen.Wait(0)
                local htmlString = ""
                local sourceCoords = GetEntityCoords(GetPlayerPed(playerId))
                local nearCoords = GetEntityCoords(PlayerPedId())
                local distance = Vdist2(sourceCoords, nearCoords)
                if distance < 25.0 then
                    local onScreen, xxx, yyy =
                        GetHudScreenPositionFromWorldPosition(
                            sourceCoords.x + Config.CoordsX,
                            sourceCoords.y + Config.CoordsY,
                            sourceCoords.z + Config.CoordsZ)
                    htmlString =
                        htmlString ..
                        '<span style="position: absolute; left: ' ..
                        xxx * 100 ..
                        "%;top: " .. yyy * 100 .. '%;"><div class="do-container"><div class="text-container" style="color:#ff0000;"><b></b>' .. text .. "</div></div></span>"
                end
                if lasthtmlString ~= htmlString then

                            SendNUIMessage({
                                toggle = true,
                                html = htmlString
                            })
                            lasthtmlString = htmlString
                end
            end
            if isDisplaying == false then
                SendNUIMessage({toggle = false})
            end
        end)
        Citizen.CreateThread(function()
            Citizen.Wait(Config.Duration)
            liczba = liczba -1
            isDisplaying = false
            SendNUIMessage({toggle = false})
        end)
    end
end)