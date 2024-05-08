local function isAdmin(source)
    local identifiers = GetPlayerIdentifiers(source)
    for _, id in ipairs(identifiers) do
        for _, adminID in ipairs(Config.EAS.admins) do
            if string.lower(id) == string.lower(adminID) then
                return true
            end
        end
    end

    if IsPlayerAceAllowed(source, "lance.eas") then
        return true
    else
        print("NOT ALLOWED TO USE EAS")
        return false
    end
end

RegisterCommand("eas-lspd", function(source, args, rawCommand)
    if isAdmin(source) then
        CancelEvent()
        local msg = table.concat(args, " ")
        TriggerClientEvent("SendAlert", -1, "Los Santos Police Department", msg)
    end
end)

RegisterCommand("eas-lsfd", function(source, args, rawCommand)
    if isAdmin(source) then
        CancelEvent()
        local msg = table.concat(args, " ")
        TriggerClientEvent("SendAlert", -1, "Los Santos Fire Department", msg)
    end
end)

RegisterCommand("eas-gov", function(source, args, rawCommand)
    if isAdmin(source) then
        CancelEvent()
        local msg = table.concat(args, " ")
        TriggerClientEvent("SendAlert", -1, "Los Santos Government", msg)
    end
end)
