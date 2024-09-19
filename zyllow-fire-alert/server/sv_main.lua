RegisterCommand('ShowShoot', function(source, args, rawCommand)
    notificationActive = not notificationActive
    if not notificationActive then
        lastShotCoords = nil
        canTeleport = false
    end
end, false)

RegisterServerEvent('fire:weaponFired')
AddEventHandler('fire:weaponFired', function(coords)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        print("Tir reçu du joueur:", xPlayer.getName(), "en position:", coords)

        local players = ESX.GetExtendedPlayers()
        for _, player in ipairs(players) do
            if player.getGroup() == 'admin' then
                TriggerClientEvent('fire_alert:notifyAdmin', player.source, coords)
            end
        end
    end
end)
